#define ASIO_STANDALONE
#include "mp_client_conn.h"

#include <asio.hpp>
#include <atomic>
#include <chrono>
#include <deque>
#include <map>
#include <stdexcept>
#include <thread>

#include "mp_protocol.h"
#include "mp_player_identity.h"
#include "mp_renet_transport.h"
#include "mp_server.h"

namespace cata_mp
{
void mp_log( const std::string &msg ); // NOLINT(cata-static-declarations)
void mp_set_client_host_world_name( const std::string &name ); // NOLINT(cata-static-declarations)
void mp_set_client_host_player_name( const std::string &name ); // NOLINT(cata-static-declarations)
void mp_store_pending_welcome( const std::string &msg ); // NOLINT(cata-static-declarations)

struct client_connection::impl {
    renet_context transport;
    bool active = false;
    bool joined = false;
    bool disconnected_reported = false;
    std::string pending_join;
    std::string connect_error;
    std::string identity_scope;
    std::string welcome_message;
    std::deque<std::string> incoming;

    void close_client() {
        transport.reset();
        active = false;
        joined = false;
        disconnected_reported = false;
        incoming.clear();
        pending_join.clear();
        identity_scope.clear();
        welcome_message.clear();
    }

    std::string resolve_server( const std::string &host, uint16_t port ) {
        // Retain hostname support. The actual connection is UDP and is bounded by
        // the handshake deadline; no unrelated TCP probe may gate it.
        asio::io_context io;
        asio::ip::udp::resolver resolver( io );
        asio::error_code error;
        const auto endpoints = resolver.resolve( asio::ip::udp::v4(), host, std::to_string( port ), error );
        if( error || endpoints.empty() ) {
            connect_error = "Could not resolve server address: " + error.message();
            return {};
        }
        return endpoints.begin()->endpoint().address().to_string() + ":" + std::to_string( port );
    }

    std::string handshake( const std::string &type, const std::string &name,
                           const std::string &password, const std::string &version ) {
        return "{\"type\":" + wire_quote( type ) + ",\"transport\":\"ccb-renet-2\",\"name\":" +
               wire_quote( name ) + ",\"password\":" + wire_quote( password ) +
               ",\"version\":" + wire_quote( version ) + "}";
    }
    bool client_recv_pop( std::string &out ) {
        if( !incoming.empty() ) {
            out = std::move( incoming.front() );
            incoming.pop_front();
            return true;
        }
        if( !active ) {
            return false;
        }
        for( const renet_packet &packet : transport.drain( 1 ) ) {
            if( decode_game_packet( packet.payload, out ) ) {
                return true;
            }
        }
        if( !transport.status().connected && !disconnected_reported ) {
            disconnected_reported = true;
            out = "{\"type\":\"state\",\"connected\":false}";
            return true;
        }
        return false;
    }

    bool client_connect( const std::string &host, uint16_t port, const std::string &name,
                         const std::string &password, const std::string &version ) {
        close_client();
        connect_error.clear();
        if( !transport.available() ) {
            connect_error = transport.last_error();
            close_client();
            return false;
        }
        const std::string address = resolve_server( host, port );
        if( address.empty() ) {
            close_client();
            return false;
        }
        if( !transport.start_client( address, 0 ) ) {
            connect_error = transport.last_error();
            close_client();
            return false;
        }
        active = true;
        const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
        const std::string probe = handshake( "version_probe", name, password, version );
        if( probe.size() > 16384 ||
            !transport.send( 0, renet_channel::reliable_ordered, probe ) ) {
            connect_error = "Could not send multiplayer handshake";
            close_client();
            return false;
        }
        while( std::chrono::steady_clock::now() < deadline ) {
            for( const renet_packet &packet : transport.drain( 32 ) ) {
                std::string message;
                std::map<std::string, std::string> fields;
                if( !decode_game_packet( packet.payload, message ) || !read_handshake( message, fields ) ) {
                    continue;
                }
                if( fields["type"] == "error" ) {
                    connect_error = fields["message"];
                    close_client();
                    return false;
                }
                if( fields["type"] == "welcome" && fields["transport"] == "ccb-renet-2" ) {
                    world_id world;
                    try {
                        world = world_id( fields["world_id"] );
                    } catch( const std::invalid_argument & ) {
                        connect_error = "Host supplied no valid persistent world identity";
                        close_client();
                        return false;
                    }
                    welcome_message = message;
                    pending_join = handshake( "join", name, password, version );
                    pending_join.pop_back();
                    pending_join += ",\"world_id\":" + wire_quote( world.str() ) + "}";
                    identity_scope = address;
                    incoming.push_back( message );
                    mp_log( "[ccb-mp] Renet host accepted connection to " + address );
                    return true;
                }
            }
            std::this_thread::sleep_for( std::chrono::milliseconds( 10 ) );
        }
        connect_error = "Timed out waiting for UDP host response (5 seconds). Check address and UDP port.";
        close_client();
        return false;
    }

    void client_send_join( const player_credentials &player ) {
        if( !active || joined || pending_join.empty() ) {
            return;
        }
        if( !player.valid() ) {
            connect_error = "Persistent player identity is required";
            return;
        }
        const std::string join = pending_join.substr( 0, pending_join.size() - 1 ) +
                                 ",\"player_id\":" + wire_quote( player.id.str() ) +
                                 ",\"resume_secret\":" + wire_quote( player.resume_secret ) + "}";
        joined = transport.send( 0, renet_channel::reliable_ordered, join );
        if( joined ) {
            pending_join.clear();
        }
    }

    void client_send( const std::string &json ) {
        if( active ) {
            const std::string packet = encode_game_packet( json );
            if( packet.empty() || !transport.send( 0, renet_channel_for_payload( json ), packet ) ) {
                mp_log( "[ccb-mp] could not queue gameplay message; closing connection" );
                transport.reset();
            }
        }
    }
};

client_connection::client_connection() = default;
client_connection::~client_connection()
{
    reset();
}

bool client_connection::enabled() const
{
    return enabled_;
}

void client_connection::set_enabled( bool value )
{
    if( !value ) {
        reset();
    } else {
        enabled_ = true;
    }
}

void client_connection::close_transport()
{
    if( impl_ ) {
        impl_->close_client();
    }
}

void client_connection::reset()
{
    close_transport();
    enabled_ = false;
    impl_.reset();
}

bool client_connection::pending_admission() const
{
    return enabled() && impl_ && impl_->active && !impl_->joined &&
           !impl_->pending_join.empty();
}

bool client_connection::transport_running() const
{
    return impl_ && impl_->transport.status().running;
}

bool client_connection::connected() const
{
    return impl_ && impl_->transport.status().connected;
}

void client_connection::prepare_for_world_load()
{
    // A menu probe has no references to the old world. A joined connection
    // does; it cannot survive replacing that world's actors or map.
    if( !pending_admission() ) {
        reset();
    }
}

bool client_connection::connect( const std::string &host, uint16_t port,
                                 const std::string &name, const std::string &password,
                                 const std::string &version )
{
    if( !impl_ ) {
        impl_ = std::make_unique<impl>();
    }
    return impl_->client_connect( host, port, name, password, version );
}

std::string client_connection::error() const
{
    return impl_ ? impl_->connect_error : std::string();
}

std::string client_connection::identity_scope() const
{
    return impl_ ? impl_->identity_scope : std::string();
}

std::string client_connection::welcome() const
{
    return impl_ ? impl_->welcome_message : std::string();
}

void client_connection::send_join( const player_credentials &player )
{
    if( impl_ ) {
        impl_->client_send_join( player );
    }
}

bool client_connection::join_is_sent() const
{
    return impl_ && impl_->joined;
}

void client_connection::send( const std::string &json )
{
    if( impl_ ) {
        impl_->client_send( json );
    }
}

bool client_connection::recv_pop( std::string &out )
{
    return impl_ && impl_->client_recv_pop( out );
}

bool is_client_mode()
{
    const auto *client = current_client_connection();
    return client && client->enabled();
}

void set_client_mode( bool enabled )
{
    if( auto *client = current_client_connection() ) {
        client->set_enabled( enabled );
    }
}

bool client_connect( const std::string &host, uint16_t port, const std::string &name,
                     const std::string &password, const std::string &version )
{
    auto *client = current_client_connection();
    if( !client || get_active_server() || !client->connect( host, port, name, password, version ) ) {
        return false;
    }
    // Metadata is published only by the current owner adapter. A reusable
    // connection component cannot modify another world's pending welcome.
    const std::string welcome = client->welcome();
    std::map<std::string, std::string> fields;
    read_handshake( welcome, fields );
    mp_set_client_host_world_name( fields["world"] );
    mp_set_client_host_player_name( fields["host_name"] );
    mp_store_pending_welcome( welcome );
    return true;
}

std::string client_connect_error()
{
    const auto *client = current_client_connection();
    if( get_active_server() ) {
        return "Stop hosting before joining another world";
    }
    return client ? client->error() : "No active application session";
}

std::string client_identity_scope()
{
    const auto *client = current_client_connection();
    return client ? client->identity_scope() : std::string();
}

void client_send_join( const player_credentials &player )
{
    if( auto *client = current_client_connection() ) {
        client->send_join( player );
    }
}

bool client_join_is_sent()
{
    const auto *client = current_client_connection();
    return client && client->join_is_sent();
}

void client_send( const std::string &json )
{
    if( auto *client = current_client_connection() ) {
        client->send( json );
    }
}

bool client_recv_pop( std::string &out )
{
    auto *client = current_client_connection();
    return client && client->recv_pop( out );
}
} // namespace cata_mp
