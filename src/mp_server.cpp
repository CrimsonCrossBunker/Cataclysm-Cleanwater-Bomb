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
void mp_log( const std::string &msg ); // NOLINT(cata-static-declarations)
unsigned int mp_host_world_seed(); // NOLINT(cata-static-declarations)
std::string mp_get_host_world_name(); // NOLINT(cata-static-declarations)
std::string mp_get_host_player_name(); // NOLINT(cata-static-declarations)
std::string mp_host_omt_welcome_field(); // NOLINT(cata-static-declarations)

namespace
{
using clock = std::chrono::steady_clock;
// Lift only after the engine's per-player simulation state is migrated.
constexpr size_t max_game_peers = 1;
std::shared_ptr<server> active_server;
std::atomic<bool> server_thread_running{ false };
}

struct server::impl {
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
    size_t outgoing_bytes = 0;
};

server::server( uint16_t port, std::string password, std::string version )
    : port_( port ), password_( std::move( password ) ), version_( std::move( version ) ),
      impl_( std::make_unique<impl>() )
{
    if( !renet_transport_start_host( "0.0.0.0:" + std::to_string( port ) ) ) {
        throw std::runtime_error( renet_transport_last_error() );
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
        mp_log( "[ccb-mp] host outgoing queue exhausted; ending session" );
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
        get_mp_queue().push( { mp_event::type::disconnect, peer.name, "", id } );
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
    const auto send = [id]( const std::string & reply ) {
        return renet_transport_send( id, renet_channel::reliable_ordered, encode_game_packet( reply ) );
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
            get_mp_queue().push( { mp_event::type::action, peer.name, msg, id } );
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
        if( fields["transport"] != "ccb-renet-1" ) {
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
        send( "{\"type\":\"welcome\",\"transport\":\"ccb-renet-1\",\"player_id\":" +
              wire_quote( type == "join" ? name : "probe" ) +
              ",\"peer_id\":" + std::to_string( id ) +
              ",\"world\":" + wire_quote( mp_get_host_world_name() ) +
              ",\"host_name\":" + wire_quote( mp_get_host_player_name() ) +
              ",\"current_turn\":0,\"seed\":" + std::to_string( mp_host_world_seed() ) +
              mp_host_omt_welcome_field() + "}" );
        if( type == "join" ) {
            peer.name = name;
            peer.authenticated = true;
            get_mp_queue().push( { mp_event::type::connect, name, "", id } );
            post_broadcast( "{\"type\":\"player_joined\",\"name\":" + wire_quote( name ) + "}" );
            mp_log( "[ccb-mp] peer joined: " + std::to_string( id ) );
        }
    } else if( type == "quit" ) {
        send( "{\"type\":\"goodbye\"}" );
        peer.closing = clock::now() + std::chrono::milliseconds( 100 );
    } else if( peer.authenticated ) {
        get_mp_queue().push( { mp_event::type::action, peer.name, msg, id } );
    } else {
        reject( "Join required before gameplay messages" );
    }
}

void server::run()
{
    mp_log( "[ccb-mp] Renet UDP host listening on " + std::to_string( port_ ) );
    try {
        while( !impl_->stopping ) {
            const auto connected = renet_transport_connected_peers();
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
                    renet_transport_disconnect_peer( entry.first );
                    removed.push_back( entry.first );
                }
            }
            for( uint64_t id : removed ) {
                on_disconnected( id );
            }
            for( const renet_packet &packet : renet_transport_drain( 128 ) ) {
                std::string msg;
                if( decode_game_packet( packet.payload, msg ) ) {
                    on_message( packet.peer_id, msg );
                }
            }
            std::deque<std::pair<uint64_t, std::string>> outgoing;
            {
                std::lock_guard<std::mutex> lock( impl_->mutex );
                outgoing.swap( impl_->outgoing );
                impl_->outgoing_bytes = 0;
            }
            for( const auto &message : outgoing ) {
                const std::string packet = encode_game_packet( message.second );
                if( packet.empty() ) {
                    mp_log( "[ccb-mp] invalid or oversized outgoing packet; ending session" );
                    stop();
                    break;
                }
                for( const auto &entry : impl_->peers ) {
                    if( entry.second.authenticated && entry.second.closing == clock::time_point::max() &&
                        ( message.first == 0 || message.first == entry.first ) ) {
                        if( !renet_transport_send( entry.first, renet_channel_for_payload( message.second ), packet ) ) {
                            mp_log( "[ccb-mp] failed to queue reliable gameplay packet; ending session" );
                            stop();
                        }
                    }
                }
            }
            std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
        }
    } catch( ... ) {
        renet_transport_stop();
        throw;
    }
    renet_transport_stop();
}

std::shared_ptr<server> get_active_server()
{
    return std::atomic_load( &active_server );
}

bool is_server_thread_running()
{
    return server_thread_running.load();
}

void run_server( uint16_t port, const std::string &password, const std::string &version )
{
    bool expected = false;
    if( !server_thread_running.compare_exchange_strong( expected, true ) ) {
        return;
    }
    try {
        auto instance = std::make_shared<server>( port, password, version );
        std::atomic_store( &active_server, instance );
        instance->run();
    } catch( const std::exception &error ) {
        mp_log( std::string( "[ccb-mp] SERVER-ERROR: " ) + error.what() );
    }
    std::atomic_store( &active_server, std::shared_ptr<server>() );
    server_thread_running = false;
}
} // namespace cata_mp
