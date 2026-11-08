#define ASIO_STANDALONE
#include "mp_client_conn.h"

#include <asio.hpp>
#include <atomic>
#include <chrono>
#include <deque>
#include <map>
#include <thread>

#include "mp_protocol.h"
#include "mp_renet_transport.h"

namespace cata_mp
{
void mp_log( const std::string &msg ); // NOLINT(cata-static-declarations)
void mp_set_client_host_world_name( const std::string &name ); // NOLINT(cata-static-declarations)
void mp_set_client_host_player_name( const std::string &name ); // NOLINT(cata-static-declarations)
void mp_store_pending_welcome( const std::string &msg ); // NOLINT(cata-static-declarations)

namespace
{
std::atomic<bool> client_mode{ false };
bool active = false;
bool joined = false;
bool disconnected_reported = false;
std::string pending_join;
std::string connect_error;
std::deque<std::string> incoming;

void close_client()
{
    if( active ) {
        renet_transport_stop();
    }
    active = false;
    joined = false;
    disconnected_reported = false;
    incoming.clear();
    pending_join.clear();
}

std::string resolve_server( const std::string &host, uint16_t port )
{
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
                       const std::string &password, const std::string &version )
{
    return "{\"type\":" + wire_quote( type ) + ",\"transport\":\"ccb-renet-1\",\"name\":" +
           wire_quote( name ) + ",\"password\":" + wire_quote( password ) +
           ",\"version\":" + wire_quote( version ) + "}";
}
}

bool is_client_mode()
{
    return client_mode;
}

void set_client_mode( bool enabled )
{
    if( !enabled ) {
        close_client();
    }
    client_mode = enabled;
}

bool client_recv_pop( std::string &out )
{
    if( !incoming.empty() ) {
        out = std::move( incoming.front() );
        incoming.pop_front();
        return true;
    }
    if( !active ) {
        return false;
    }
    for( const renet_packet &packet : renet_transport_drain( 1 ) ) {
        if( decode_game_packet( packet.payload, out ) ) {
            return true;
        }
    }
    if( !renet_transport_get_status().connected && !disconnected_reported ) {
        disconnected_reported = true;
        out = "{\"type\":\"state\",\"connected\":false}";
        return true;
    }
    return false;
}

bool client_connect( const std::string &host, uint16_t port, const std::string &name,
                     const std::string &password, const std::string &version )
{
    close_client();
    connect_error.clear();
    if( !renet_transport_available() ) {
        connect_error = renet_transport_last_error();
        return false;
    }
    const std::string address = resolve_server( host, port );
    if( address.empty() ) {
        return false;
    }
    if( !renet_transport_start_client( address, 0 ) ) {
        connect_error = renet_transport_last_error();
        return false;
    }
    active = true;
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
    const std::string probe = handshake( "version_probe", name, password, version );
    if( probe.size() > 16384 ||
        !renet_transport_send( 0, renet_channel::reliable_ordered, probe ) ) {
        connect_error = "Could not send multiplayer handshake";
        close_client();
        return false;
    }
    while( std::chrono::steady_clock::now() < deadline ) {
        for( const renet_packet &packet : renet_transport_drain( 32 ) ) {
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
            if( fields["type"] == "welcome" && fields["transport"] == "ccb-renet-1" ) {
                mp_set_client_host_world_name( fields["world"] );
                mp_set_client_host_player_name( fields["host_name"] );
                mp_store_pending_welcome( message );
                pending_join = handshake( "join", name, password, version );
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

std::string client_connect_error()
{
    return connect_error;
}

void client_send_join()
{
    if( !active || joined || pending_join.empty() ) {
        return;
    }
    joined = renet_transport_send( 0, renet_channel::reliable_ordered, pending_join );
    if( joined ) {
        pending_join.clear();
    }
}

bool client_join_is_sent()
{
    return joined;
}

void client_send( const std::string &json )
{
    if( active ) {
        const std::string packet = encode_game_packet( json );
        if( packet.empty() || !renet_transport_send( 0, renet_channel_for_payload( json ), packet ) ) {
            mp_log( "[ccb-mp] could not queue gameplay message; closing connection" );
            renet_transport_stop();
        }
    }
}
} // namespace cata_mp
