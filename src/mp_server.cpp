#include "mp_server.h"
#include "mp_log.h"

#include <exception>
#include <algorithm>
#include <atomic>
#include <chrono>
#include <deque>
#include <map>
#include <mutex>
#include <stdexcept>
#include <thread>
#include <utility>
#include <vector>

#include "mp_protocol.h"
#include "mp_queue.h"
#include "mp_renet_transport.h"
#include "mp_admission.h"
#include "mp_player_identity.h"
#include "player_identity.h"
#include "world_identity.h"

namespace cata_mp
{
namespace
{
using clock = std::chrono::steady_clock;
// Lift only after the engine's per-player simulation state is migrated.
constexpr size_t max_game_peers = 3;

} // namespace

struct server::impl {
    renet_context transport;
    std::shared_ptr<event_queue> events;
    server_welcome welcome;
    explicit impl( std::shared_ptr<event_queue> queue, server_welcome metadata ) :
        events( std::move( queue ) ), welcome( std::move( metadata ) ) {}

    struct peer {
        std::string name;
        peer_admission admission;
        bool probed = false;
        clock::time_point created = clock::now();
        clock::time_point closing = clock::time_point::max();
    };
    std::map<uint64_t, peer> peers;
    std::atomic<bool> stopping{ false };
    std::mutex mutex;
    struct delivery {
        std::vector<peer_admission> recipients;
        std::string message;
        bool close = false;
    };
    std::map<uint64_t, peer_admission> published;
    std::deque<delivery> outgoing;
    size_t outgoing_bytes = 0;

    // Caller holds mutex. Retire capabilities before discarding queued work.
    void end() {
        stopping = true;
        for( const auto &entry : published ) {
            entry.second.retire();
        }
        published.clear();
        outgoing.clear();
        outgoing_bytes = 0;
    }
};

server::server( uint16_t port, std::string password, std::string version,
                std::shared_ptr<event_queue> events, server_welcome welcome )
    : port_( port ), password_( std::move( password ) ), version_( std::move( version ) ),
      impl_( std::make_unique<impl>( std::move( events ), std::move( welcome ) ) )
{
    if( !impl_->transport.start_host( "0.0.0.0:" + std::to_string( port ) ) ) {
        throw std::runtime_error( impl_->transport.last_error() );
    }
}

server::~server() = default;

void server::stop()
{
    std::scoped_lock lock( impl_->mutex );
    impl_->end();
}

void server::post( const peer_admission *admission, const std::string &msg, bool close )
{
    std::scoped_lock lock( impl_->mutex );
    if( impl_->stopping ) {
        return;
    }
    std::vector<peer_admission> recipients;
    if( admission ) {
        const auto found = impl_->published.find( admission->peer_id() );
        if( !admission->active() || found == impl_->published.end() ||
            !found->second.matches( *admission ) ) {
            return;
        }
        recipients.push_back( *admission );
    } else {
        for( const auto &entry : impl_->published ) {
            if( entry.second.active() ) {
                recipients.push_back( entry.second );
            }
        }
    }
    if( msg.size() > 8 * 1024 * 1024 ) {
        mp_log_host( "[ccb-mp] oversized outgoing packet; ending session" );
        impl_->end();
        return;
    }
    if( recipients.empty() ) {
        return;
    }
    const size_t bytes = msg.size() + sizeof( impl::delivery ) +
                         recipients.size() * sizeof( peer_admission );
    if( bytes > 64 * 1024 * 1024 - impl_->outgoing_bytes ) {
        mp_log_host( "[ccb-mp] host outgoing queue exhausted; ending session" );
        impl_->end();
        return;
    }
    impl_->outgoing.push_back( { std::move( recipients ), msg, close } );
    impl_->outgoing_bytes += bytes;
}

void server::post_send( const peer_admission &admission, const std::string &msg )
{
    post( &admission, msg, false );
}

void server::broadcast( const std::string &msg )
{
    post_broadcast( msg );
}

void server::post_reject( const peer_admission &admission, const std::string &reason )
{
    post( &admission, R"({"type":"error","message":)" + wire_quote( reason ) + "}", true );
}

void server::post_broadcast( const std::string &msg )
{
    post( nullptr, msg, false );
}

void server::on_disconnected( uint64_t id )
{
    const auto found = impl_->peers.find( id );
    if( found == impl_->peers.end() ) {
        return;
    }
    const impl::peer peer = found->second;
    impl_->peers.erase( found );
    if( peer.admission.peer_id() != 0 ) {
        peer.admission.retire();
        {
            std::scoped_lock lock( impl_->mutex );
            impl_->published.erase( id );
        }
        if( !impl_->events->push( { mp_event::type::disconnect, peer.name, "", peer.admission } ) ) {
            throw std::runtime_error( "Missing reserved multiplayer disconnect event" );
        }
        post_broadcast( R"({"type":"player_left","name":)" + wire_quote( peer.name ) + "}" );
    }
}

void server::on_message( uint64_t id, const std::string &msg )
{
    auto found = impl_->peers.find( id );
    if( found == impl_->peers.end() || found->second.closing != clock::time_point::max() ) {
        return;
    }
    impl::peer &peer = found->second;
    const auto send = [this, id]( const std::string & reply ) {
        return impl_->transport.send( id, renet_channel::reliable_ordered, encode_game_packet( reply ) );
    };
    const auto reject = [&]( const std::string & reason ) {
        send( R"({"type":"error","message":)" + wire_quote( reason ) + "}" );
        // Allow the reliable error to leave before netcode tears down the peer.
        peer.closing = clock::now() + std::chrono::seconds( 1 );
    };
    const auto enqueue_action = [&]() {
        if( !impl_->events->push( { mp_event::type::action, peer.name, msg, peer.admission } ) ) {
            reject( "Host incoming action queue is full; this message was not accepted.  Reconnect to resynchronize." );
        }
    };
    std::map<std::string, std::string> fields;
    if( !read_handshake( msg, fields ) ) {
        if( peer.admission.active() ) {
            // Large gameplay packets are parsed by the game thread.
            enqueue_action();
        } else {
            reject( "Invalid handshake" );
        }
        return;
    }
    const std::string &type = fields["type"];
    if( type == "version_probe" || type == "join" ) {
        if( peer.admission.active() ) {
            // A duplicate join must not spawn a second proxy or rename a peer.
            return;
        }
        if( fields["transport"] != "ccb-renet-2" ) {
            reject( "Incompatible multiplayer transport" );
            return;
        }
        if( !version_.empty() && version_commit_id( fields["version"] ) != version_commit_id( version_ ) ) {
            reject( "Version mismatch.  Host: " + version_ + " Client: " + fields["version"] );
            return;
        }
        if( fields["password"] != password_ ) {
            reject( "Wrong password" );
            return;
        }
        const size_t joined = std::count_if( impl_->peers.begin(), impl_->peers.end(),
        []( const auto & entry ) {
            return entry.second.admission.active();
        } );
        if( joined >= max_game_peers ) {
            reject( "Server is full (four players including the host)" );
            return;
        }
        peer.probed = true;
        const std::string name = fields["name"].empty() ? "player" : fields["name"];
        if( name.size() > 256 ) {
            reject( "Player name is too long" );
            return;
        }
        player_credentials credentials;
        if( type == "join" ) {
            try {
                credentials = { player_id( fields["player_id"] ), fields["resume_secret"] };
                if( !credentials.valid() ) {
                    throw std::invalid_argument( "Missing resume capability" );
                }
            } catch( const std::invalid_argument & ) {
                reject( "Persistent player identity required; update the client" );
                return;
            }
        }
        server_welcome welcome;
        {
            std::scoped_lock lock( impl_->mutex );
            welcome = impl_->welcome;
        }
        if( !welcome.world.valid() ) {
            reject( "Host world identity is unavailable" );
            return;
        }
        // The owner may have changed worlds after a probe. Do not admit that
        // old probe's join into a different namespace or player store.
        if( type == "join" && fields["world_id"] != welcome.world.str() ) {
            reject( "Host world changed; reconnect before joining" );
            return;
        }
        const std::string position = welcome.host_omt ?
                                     ",\"host_omt\":[" + std::to_string( ( *welcome.host_omt )[0] ) + "," +
                                     std::to_string( ( *welcome.host_omt )[1] ) + "," +
                                     std::to_string( ( *welcome.host_omt )[2] ) + "]" : "";
        const std::string welcome_packet =
            R"({"type":"welcome","transport":"ccb-renet-2","player_id":)" +
            wire_quote( type == "join" ? credentials.id.str() : "probe" ) +
            ",\"peer_id\":" + std::to_string( id ) +
            ",\"world\":" + wire_quote( welcome.world_name ) +
            ",\"world_id\":" + wire_quote( welcome.world.str() ) +
            ",\"host_name\":" + wire_quote( welcome.player_name ) +
            R"(,"current_turn":0,"seed":)" + std::to_string( welcome.seed ) + position +
            ( welcome.north_america_world ? ",\"north_america_world\":true" : "" ) + "}";
        if( type == "join" ) {
            peer.name = name;
            peer.admission = peer_admission::create( id );
            {
                std::scoped_lock lock( impl_->mutex );
                if( impl_->stopping ) {
                    peer.admission.retire();
                    return;
                }
                if( !impl_->events->push( { mp_event::type::connect, name, "", peer.admission, credentials } ) ) {
                    peer.admission.retire();
                    peer.admission = {};
                    reject( "Host incoming queue cannot admit another connection; try again after it drains." );
                    return;
                }
                impl_->published[id] = peer.admission;
            }
            post_broadcast( R"({"type":"player_joined","name":)" + wire_quote( name ) + "}" );
            mp_log_host( "[ccb-mp] peer joined: " + std::to_string( id ) );
        }
        send( welcome_packet );
    } else if( type == "quit" ) {
        send( R"({"type":"goodbye"})" );
        peer.closing = clock::now() + std::chrono::milliseconds( 100 );
    } else if( peer.admission.active() ) {
        enqueue_action();
    } else {
        reject( "Join required before gameplay messages" );
    }
}

void server::run()
{
    mp_log_host( "[ccb-mp] Renet UDP host listening on " + std::to_string( port_ ) );
    try {
        while( !impl_->stopping ) {
            // Bound transient packet copies while retaining the worker
            // quantum; idle loops still check disconnects and outgoing work.
            for( size_t packet_index = 0; packet_index < 128; ++packet_index ) {
                // Observe membership after draining: a join that arrives between
                // two runtime calls must not be discarded as an unknown route.
                const auto packets = impl_->transport.drain( 1 );
                const auto connected = impl_->transport.connected_peers();
                for( uint64_t id : connected ) {
                    impl_->peers.try_emplace( id );
                }
                std::vector<uint64_t> removed;
                for( const auto &entry : impl_->peers ) {
                    const cata_mp::server::impl::peer &peer = entry.second;
                    if( std::find( connected.begin(), connected.end(), entry.first ) == connected.end() ) {
                        removed.push_back( entry.first );
                    } else if( clock::now() >= peer.closing ||
                               ( !peer.probed && clock::now() - peer.created > std::chrono::seconds( 10 ) ) ) {
                        impl_->transport.disconnect_peer( entry.first );
                        removed.push_back( entry.first );
                    }
                }
                for( uint64_t id : removed ) {
                    on_disconnected( id );
                }
                for( const renet_packet &packet : packets ) {
                    std::string msg;
                    if( decode_game_packet( packet.payload, msg ) ) {
                        on_message( packet.peer_id, msg );
                    }
                }
                if( packets.empty() ) {
                    break;
                }
            }
            std::deque<impl::delivery> outgoing;
            {
                std::scoped_lock lock( impl_->mutex );
                outgoing.swap( impl_->outgoing );
                impl_->outgoing_bytes = 0;
            }
            for( const cata_mp::server::impl::delivery &message : outgoing ) {
                const std::string packet = encode_game_packet( message.message );
                if( packet.empty() ) {
                    mp_log_host( "[ccb-mp] invalid or oversized outgoing packet; ending session" );
                    stop();
                    break;
                }
                for( const peer_admission &admission : message.recipients ) {
                    const auto found = impl_->peers.find( admission.peer_id() );
                    if( found == impl_->peers.end() || !admission.active() ||
                        !found->second.admission.matches( admission ) ||
                        found->second.closing != clock::time_point::max() ) {
                        continue;
                    }
                    if( !impl_->transport.send( admission.peer_id(),
                                                renet_channel_for_payload( message.message ), packet ) ) {
                        mp_log_host( "[ccb-mp] failed to queue reliable gameplay packet; ending session" );
                        stop();
                    }
                    if( message.close ) {
                        found->second.closing = clock::now() + std::chrono::seconds( 1 );
                    }
                }
            }
            std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
        }
    } catch( ... ) {
        stop();
        impl_->transport.reset();
        throw;
    }
    stop();
    impl_->transport.reset();
}

bool server::running() const
{
    return !impl_->stopping;
}

void server::update_welcome( server_welcome welcome )
{
    std::scoped_lock lock( impl_->mutex );
    if( !impl_->stopping ) {
        impl_->welcome = std::move( welcome );
    }
}

host_session::host_session( size_t event_limit, size_t byte_limit ) :
    events_( std::make_shared<event_queue>( event_limit, byte_limit ) )
{
}

host_session::~host_session()
{
    stop();
}

bool host_session::running() const
{
    return instance_ && instance_->running();
}

std::shared_ptr<server> host_session::active_server() const
{
    return running() ? instance_ : nullptr;
}

event_queue &host_session::events()
{
    if( !events_ ) {
        events_ = std::make_shared<event_queue>();
    }
    return *events_;
}

void host_session::update_welcome( server_welcome welcome )
{
    if( instance_ ) {
        instance_->update_welcome( std::move( welcome ) );
    }
}

void host_session::stop()
{
    if( instance_ ) {
        instance_->stop();
    }
    if( worker_.joinable() ) {
        worker_.join();
    }
    instance_.reset();
    if( events_ ) {
        events_->clear();
    }
}

bool host_session::start( uint16_t port, const std::string &password,
                          const std::string &version, server_welcome welcome )
{
    stop();
    error_.clear();
    try {
        events();
        instance_ = std::make_shared<server>( port, password, version, events_, std::move( welcome ) );
        worker_ = std::thread( [instance = instance_]() {
            try {
                instance->run();
            } catch( const std::exception &error ) {
                mp_log_host( std::string( "[ccb-mp] SERVER-ERROR: " ) + error.what() );
            } catch( ... ) {
                mp_log_host( "[ccb-mp] SERVER-ERROR: unknown worker failure" );
            }
        } );
        return true;
    } catch( const std::exception &error ) {
        error_ = error.what();
        stop();
        return false;
    }
}
} // namespace cata_mp
