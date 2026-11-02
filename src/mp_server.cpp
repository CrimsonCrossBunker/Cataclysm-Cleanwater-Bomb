#include "mp_server.h"

#include <algorithm>
#include <atomic>
#include <chrono>
#include <deque>
#include <map>
#include <mutex>
#include <stdexcept>
#include <thread>
#include <utility>

#include "mp_protocol.h"
#include "mp_queue.h"
#include "mp_renet_transport.h"

namespace cata_mp
{
void mp_log_host( const std::string &msg ); // NOLINT(cata-static-declarations)

namespace
{
using clock = std::chrono::steady_clock;
// Lift only after the engine's per-player simulation state is migrated.
constexpr size_t max_game_peers = 1;

}

struct server::impl {
    renet_context transport;
    std::shared_ptr<event_queue> events;
    server_welcome welcome;
    explicit impl( std::shared_ptr<event_queue> queue, server_welcome metadata ) :
        events( std::move( queue ) ), welcome( std::move( metadata ) ) {}

    struct peer {
        std::string name;
        bool authenticated = false;
        bool probed = false;
        clock::time_point created = clock::now();
        clock::time_point closing = clock::time_point::max();
    };
    std::map<uint64_t, peer> peers;
    std::atomic<bool> stopping{ false };
    std::mutex mutex;
    std::deque<std::pair<uint64_t, std::string>> outgoing;
    std::vector<uint64_t> rejected;
    size_t outgoing_bytes = 0;
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
    impl_->stopping = true;
}

void server::post_send( uint64_t peer_id, const std::string &msg )
{
    std::lock_guard<std::mutex> lock( impl_->mutex );
    if( impl_->stopping ) {
        return;
    }
    if( impl_->outgoing_bytes + msg.size() > 64 * 1024 * 1024 ) {
        // Reliable gameplay messages must never be silently dropped.
        mp_log_host( "[ccb-mp] host outgoing queue exhausted; ending session" );
        impl_->stopping = true;
        return;
    }
    impl_->outgoing.emplace_back( peer_id, msg );
    impl_->outgoing_bytes += msg.size();
}

void server::broadcast( const std::string &msg )
{
    post_broadcast( msg );
}

void server::post_reject( uint64_t peer_id, const std::string &reason )
{
    if( peer_id == 0 ) {
        return;
    }
    post_send( peer_id, "{\"type\":\"error\",\"message\":" + wire_quote( reason ) + "}" );
    std::lock_guard<std::mutex> lock( impl_->mutex );
    if( !impl_->stopping ) {
        impl_->rejected.push_back( peer_id );
    }
}

void server::post_broadcast( const std::string &msg )
{
    post_send( 0, msg );
}

void server::on_disconnected( uint64_t id )
{
    const auto found = impl_->peers.find( id );
    if( found == impl_->peers.end() ) {
        return;
    }
    const impl::peer peer = found->second;
    impl_->peers.erase( found );
    if( peer.authenticated ) {
        impl_->events->push( { mp_event::type::disconnect, peer.name, "", id } );
        post_broadcast( "{\"type\":\"player_left\",\"name\":" + wire_quote( peer.name ) + "}" );
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
        send( "{\"type\":\"error\",\"message\":" + wire_quote( reason ) + "}" );
        // Allow the reliable error to leave before netcode tears down the peer.
        peer.closing = clock::now() + std::chrono::seconds( 1 );
    };
    std::map<std::string, std::string> fields;
    if( !read_handshake( msg, fields ) ) {
        if( peer.authenticated ) {
            // Large gameplay packets are parsed by the game thread.
            impl_->events->push( { mp_event::type::action, peer.name, msg, id } );
        } else {
            reject( "Invalid handshake" );
        }
        return;
    }
    const std::string &type = fields["type"];
    if( type == "version_probe" || type == "join" ) {
        if( peer.authenticated ) {
            // A duplicate join must not spawn a second proxy or rename a peer.
            return;
        }
        if( fields["transport"] != "ccb-renet-2" ) {
            reject( "Incompatible multiplayer transport" );
            return;
        }
        if( !version_.empty() && version_commit_id( fields["version"] ) != version_commit_id( version_ ) ) {
            reject( "Version mismatch. Host: " + version_ + " Client: " + fields["version"] );
            return;
        }
        if( fields["password"] != password_ ) {
            reject( "Wrong password" );
            return;
        }
        const size_t joined = std::count_if( impl_->peers.begin(), impl_->peers.end(),
        []( const auto & entry ) {
            return entry.second.authenticated;
        } );
        if( joined >= max_game_peers ) {
            reject( "Server is full (current engine supports one remote player)" );
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
            std::lock_guard<std::mutex> lock( impl_->mutex );
            welcome = impl_->welcome;
        }
        const std::string position = welcome.host_omt ?
                                     ",\"host_omt\":[" + std::to_string( ( *welcome.host_omt )[0] ) + "," +
                                     std::to_string( ( *welcome.host_omt )[1] ) + "," +
                                     std::to_string( ( *welcome.host_omt )[2] ) + "]" : "";
        send( "{\"type\":\"welcome\",\"transport\":\"ccb-renet-2\",\"player_id\":" +
              wire_quote( type == "join" ? credentials.id.str() : "probe" ) +
              ",\"peer_id\":" + std::to_string( id ) +
              ",\"world\":" + wire_quote( welcome.world_name ) +
              ",\"host_name\":" + wire_quote( welcome.player_name ) +
              ",\"current_turn\":0,\"seed\":" + std::to_string( welcome.seed ) +
              position + "}" );
        if( type == "join" ) {
            peer.name = name;
            peer.authenticated = true;
            impl_->events->push( { mp_event::type::connect, name, "", id, credentials } );
            post_broadcast( "{\"type\":\"player_joined\",\"name\":" + wire_quote( name ) + "}" );
            mp_log_host( "[ccb-mp] peer joined: " + std::to_string( id ) );
        }
    } else if( type == "quit" ) {
        send( "{\"type\":\"goodbye\"}" );
        peer.closing = clock::now() + std::chrono::milliseconds( 100 );
    } else if( peer.authenticated ) {
        impl_->events->push( { mp_event::type::action, peer.name, msg, id } );
    } else {
        reject( "Join required before gameplay messages" );
    }
}

void server::run()
{
    mp_log_host( "[ccb-mp] Renet UDP host listening on " + std::to_string( port_ ) );
    try {
        while( !impl_->stopping ) {
            const auto connected = impl_->transport.connected_peers();
            for( uint64_t id : connected ) {
                impl_->peers.try_emplace( id );
            }
            std::vector<uint64_t> removed;
            for( const auto &entry : impl_->peers ) {
                const auto &peer = entry.second;
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
            for( const renet_packet &packet : impl_->transport.drain( 128 ) ) {
                std::string msg;
                if( decode_game_packet( packet.payload, msg ) ) {
                    on_message( packet.peer_id, msg );
                }
            }
            std::deque<std::pair<uint64_t, std::string>> outgoing;
            std::vector<uint64_t> rejected;
            {
                std::lock_guard<std::mutex> lock( impl_->mutex );
                outgoing.swap( impl_->outgoing );
                rejected.swap( impl_->rejected );
                impl_->outgoing_bytes = 0;
            }
            for( const auto &message : outgoing ) {
                const std::string packet = encode_game_packet( message.second );
                if( packet.empty() ) {
                    mp_log_host( "[ccb-mp] invalid or oversized outgoing packet; ending session" );
                    stop();
                    break;
                }
                for( const auto &entry : impl_->peers ) {
                    if( entry.second.authenticated && entry.second.closing == clock::time_point::max() &&
                        ( message.first == 0 || message.first == entry.first ) ) {
                        if( !impl_->transport.send( entry.first, renet_channel_for_payload( message.second ), packet ) ) {
                            mp_log_host( "[ccb-mp] failed to queue reliable gameplay packet; ending session" );
                            stop();
                        }
                    }
                }
            }
            for( const uint64_t id : rejected ) {
                const auto found = impl_->peers.find( id );
                if( found != impl_->peers.end() ) {
                    found->second.closing = clock::now() + std::chrono::seconds( 1 );
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
    std::lock_guard<std::mutex> lock( impl_->mutex );
    if( !impl_->stopping ) {
        impl_->welcome = std::move( welcome );
    }
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
