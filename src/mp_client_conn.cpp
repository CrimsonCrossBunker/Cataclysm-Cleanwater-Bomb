// Networking only — no CDDA game headers allowed here (asio conflicts with PCH).
// Follow the same pattern as mp_server.cpp.
#define ASIO_STANDALONE

#include "mp_client_conn.h"

#include <asio.hpp> // IWYU pragma: keep
#include <asio/associated_cancellation_slot.hpp>
#include <asio/async_result.hpp>
#include <asio/buffer.hpp>
#include <asio/completion_condition.hpp>
#include <asio/connect.hpp>
#include <asio/detail/bind_handler.hpp>
#include <asio/detail/handler_invoke_helpers.hpp>
#include <asio/detail/impl/epoll_reactor.hpp>
#include <asio/detail/impl/reactive_socket_service_base.ipp>
#include <asio/detail/impl/resolver_service_base.ipp>
#include <asio/detail/impl/scheduler.ipp>
#include <asio/detail/impl/service_registry.hpp>
#include <asio/error_code.hpp>
#include <asio/execution/context_as.hpp>
#include <asio/execution/prefer_only.hpp>
#include <asio/impl/any_io_executor.ipp>
#include <asio/impl/connect.hpp>
#include <asio/impl/handler_alloc_hook.ipp>
#include <asio/impl/io_context.hpp>
#include <asio/impl/io_context.ipp>
#include <asio/impl/read_until.hpp>
#include <asio/impl/write.hpp>
#include <asio/io_context.hpp>
#include <asio/ip/basic_resolver_iterator.hpp>
#include <asio/ip/tcp.hpp>
#include <asio/post.hpp>
#include <asio/steady_timer.hpp>
#include <asio/streambuf.hpp>
#include <stddef.h>
#include <zstd/zstd.h>
#include <chrono>
#include <iostream>
#include <memory>
#include <mutex>
#include <new>
#include <queue>
#include <string>
#include <thread>
#include <utility>

#include "catacharset.h"   // base64_decode — only pulls std headers, asio-safe

using asio::ip::tcp;

namespace cata_mp
{

// ---------------------------------------------------------------------------
// Client mode flag
// ---------------------------------------------------------------------------

// Defined in mp_gamestate.cpp. Forward-declared (mp_client_conn.cpp doesn't
// include the gamestate header) so we can trace connection lifecycle here.
void mp_log( const std::string &msg );
void mp_set_client_host_world_name( const std::string &name );
void mp_set_client_host_player_name( const std::string &name );
void mp_store_pending_welcome( const std::string &msg );

static bool client_mode_ = false;

bool is_client_mode()
{
    return client_mode_;
}

void set_client_mode( bool enabled )
{
    client_mode_ = enabled;
    // Trace client_mode flips: a stale "true" left over from a failed prior
    // join makes mp_menu_join_session() skip the IP prompt entirely.
    mp_log( "[cdda-mp] set_client_mode -> " + std::string( enabled ? "true" : "false" ) );
}

// ---------------------------------------------------------------------------
// Thread-safe queue for incoming state strings (io thread → game thread)
// ---------------------------------------------------------------------------

class string_queue
{
    public:
        void push( std::string s ) {
            std::scoped_lock lk( mtx_ );
            q_.push( std::move( s ) );
        }
        bool pop( std::string &out ) {
            std::scoped_lock lk( mtx_ );
            if( q_.empty() ) {
                return false;
            }
            out = std::move( q_.front() );
            q_.pop();
            return true;
        }
    private:
        std::queue<std::string> q_;
        std::mutex mtx_;
};

static string_queue g_recv_queue;

// Reverse of the host's mp_compress_frame (mp_server.cpp): a line of the form
// {"z":"<base64 zstd>"} is a compressed state broadcast — base64-decode then
// zstd-decompress back to the original JSON line.  Any other line is returned
// unchanged (grants/acks/control messages stay plaintext).  Both ends are the
// same build (version handshake), so the format is guaranteed to match.
static std::string mp_decompress_frame( std::string line )
{
    static const std::string prefix = R"({"z":")";
    if( line.size() <= prefix.size() + 2 ||
        line.compare( 0, prefix.size(), prefix ) != 0 ||
        line.compare( line.size() - 2, 2, "\"}" ) != 0 ) {
        return line;
    }
    const std::string b64 = line.substr( prefix.size(),
                                         line.size() - prefix.size() - 2 );
    const std::string comp = base64_decode( b64 );
    const unsigned long long orig =
        ZSTD_getFrameContentSize( comp.data(), comp.size() );
    if( orig == ZSTD_CONTENTSIZE_UNKNOWN || orig == ZSTD_CONTENTSIZE_ERROR ) {
        mp_log( "[cdda-mp] decompress: bad zstd frame; dropping" );
        return std::string();
    }
    std::string out;
    out.resize( static_cast<size_t>( orig ) );
    const size_t n = ZSTD_decompress( &out[0], out.size(), comp.data(), comp.size() );
    if( ZSTD_isError( n ) ) {
        mp_log( std::string( "[cdda-mp] decompress error: " ) + ZSTD_getErrorName( n ) );
        return std::string();
    }
    out.resize( n );
    return out;
}

// ---------------------------------------------------------------------------
// Connection impl
// ---------------------------------------------------------------------------

struct client_impl {
    asio::io_context io_ctx;
    tcp::socket sock{ io_ctx };
    asio::streambuf read_buf;
    std::thread io_thread;

    ~client_impl() {
        io_ctx.stop();
        if( io_thread.joinable() ) {
            io_thread.join();
        }
    }

    void start_read() {
        asio::async_read_until( sock, read_buf, '\n',
        [this]( const asio::error_code & ec, size_t /*n*/ ) {
            if( ec ) {
                std::cerr << "[cdda-mp] Server disconnected: " << ec.message() << std::endl;
                mp_log( "[cdda-mp] DISCONNECT: server closed connection (" + ec.message() +
                        "). If this fired during join, the host rejected the handshake "
                        "(version mismatch / wrong password) or is on a different build — "
                        "check the host's cdda-mp-server.log for a PROBE/JOIN REJECTED line." );
                // Synthetic disconnect message — game thread will clean up the host NPC.
                g_recv_queue.push( R"({"type":"state","connected":false})" );
                return;
            }
            std::istream is( &read_buf );
            std::string line;
            std::getline( is, line );
            if( !line.empty() ) {
                std::string msg = mp_decompress_frame( std::move( line ) );
                if( !msg.empty() ) {
                    g_recv_queue.push( std::move( msg ) );
                }
            }
            start_read();
        } );
    }
};

static std::unique_ptr<client_impl> g_client;

// Join message / welcome storage.
static std::string g_pending_join;
static bool g_join_sent = false;
static std::string g_connect_error;

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

bool tcp_probe( const std::string &host, uint16_t port, int timeout_ms )
{
    try {
        asio::io_context io;
        tcp::resolver resolver( io );
        asio::error_code resolve_ec;
        auto endpoints = resolver.resolve( host, std::to_string( port ), resolve_ec );
        if( resolve_ec ) {
            return false;
        }
        tcp::socket sock( io );
        bool connected = false;
        bool finished = false;
        asio::async_connect( sock, endpoints,
        [&]( const asio::error_code & ec, const tcp::endpoint & ) {
            finished = true;
            connected = !ec;
        } );
        asio::steady_timer deadline( io );
        deadline.expires_after( std::chrono::milliseconds( timeout_ms ) );
        deadline.async_wait( [&]( const asio::error_code & ) {
            if( !finished ) {
                // Cancels the pending async_connect, which then fires its
                // completion handler with operation_aborted.
                asio::error_code ignore;
                sock.close( ignore );
            }
        } );
        io.run();
        return connected;
    } catch( const std::exception & ) {
        return false;
    }
}

bool client_connect( const std::string &host, uint16_t port,
                     const std::string &name, const std::string &password,
                     const std::string &version )
{
    g_client = std::make_unique<client_impl>();

    asio::error_code ec;
    tcp::resolver resolver( g_client->io_ctx );
    auto endpoints = resolver.resolve( host, std::to_string( port ), ec );
    if( ec ) {
        std::cerr << "[cdda-mp] Could not resolve '" << host << "': " << ec.message() << std::endl;
        g_client.reset();
        return false;
    }

    asio::connect( g_client->sock, endpoints, ec );
    if( ec ) {
        std::cerr << "[cdda-mp] Could not connect to " << host << ":" << port
                  << " — " << ec.message() << std::endl;
        g_client.reset();
        return false;
    }

    // Disable Nagle's algorithm. The lockstep grant/wait/ack messages are tiny;
    // Nagle batching plus the peer's delayed-ACK add hundreds of ms per
    // round-trip on a high-latency link, wedging the turn cycle. Invisible on
    // LAN, essential for internet play.
    {
        asio::error_code nd_ec;
        g_client->sock.set_option( tcp::no_delay( true ), nd_ec );
        mp_log( "[cdda-mp] client TCP_NODELAY ec=" + nd_ec.message() );
    }

    g_client->start_read();
    g_client->io_thread = std::thread( []() {
        g_client->io_ctx.run();
    } );

    // Send a lightweight version_probe — validates version + password without
    // spawning the proxy NPC on the host.  The real join (which triggers proxy
    // spawn) is deferred until client_send_join() fires after char creation.
    std::string join_msg = R"({"type":"version_probe")";
    if( !password.empty() ) {
        join_msg += R"(,"password":")" + password + "\"";
    }
    if( !version.empty() ) {
        join_msg += R"(,"version":")" + version + "\"";
    }
    join_msg += "}\n";

    mp_log( "[cdda-mp] HANDSHAKE: sent version_probe to " + host + ":" +
            std::to_string( port ) + " (our version='" +
            ( version.empty() ? std::string( "(none)" ) : version ) + "'" +
            ( password.empty() ? "" : ", password set" ) + ")" );
    asio::error_code wec;
    asio::write( g_client->sock, asio::buffer( join_msg ), wec );
    if( wec ) {
        std::cerr << "[cdda-mp] Failed to send join: " << wec.message() << std::endl;
        mp_log( "[cdda-mp] HANDSHAKE: failed to send version_probe — " + wec.message() );
        g_client.reset();
        return false;
    }

    // Wait up to 5 s for welcome or error.
    const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
    while( std::chrono::steady_clock::now() < deadline ) {
        std::string msg;
        if( g_recv_queue.pop( msg ) ) {
            if( msg.find( R"("type":"error")" ) != std::string::npos ) {
                // Extract human-readable error for the caller.
                g_connect_error = "Server rejected connection.";
                const auto mpos = msg.find( R"("message":")" );
                if( mpos != std::string::npos ) {
                    const size_t start = mpos + 11;
                    const size_t end = msg.find( '"', start );
                    if( end != std::string::npos ) {
                        g_connect_error = msg.substr( start, end - start );
                    }
                }
                mp_log( "[cdda-mp] HANDSHAKE REJECTED by host: " + g_connect_error +
                        " (raw=" + msg + ")" );
                g_join_sent = false;
                g_client.reset();
                return false;
            }
            if( msg.find( R"("type":"welcome")" ) != std::string::npos ) {
                // Probe accepted — version + password OK.  Extract the world
                // name immediately so the join dialog can show "Joining <World>"
                // before the game loop gets to process the welcome packet.
                const auto wpos = msg.find( R"("world":")" );
                if( wpos != std::string::npos ) {
                    const size_t ws = wpos + 9;
                    const size_t we = msg.find( '"', ws );
                    if( we != std::string::npos ) {
                        const std::string wn = msg.substr( ws, we - ws );
                        if( !wn.empty() && wn != "default" ) {
                            mp_set_client_host_world_name( wn );
                        }
                    }
                }
                // Host's character name — so the join dialog can show whose game
                // it is ("Joining <World> — <Host>'s game") before char select.
                const auto hpos = msg.find( R"("host_name":")" );
                if( hpos != std::string::npos ) {
                    const size_t hs = hpos + 12;
                    const size_t he = msg.find( '"', hs );
                    if( he != std::string::npos ) {
                        const std::string hn = msg.substr( hs, he - hs );
                        if( !hn.empty() ) {
                            mp_set_client_host_player_name( hn );
                        }
                    }
                }
                // Stash + pre-parse the welcome NOW (connect time, before char
                // creation) so start_game() can adopt the host seed + spawn-omt
                // before it builds the host-area overmap. The game-loop replay
                // below still fires on the first do_turn (idempotent).
                mp_store_pending_welcome( msg );
                // Store the welcome so the game-loop handler can adopt the seed.
                g_pending_join = R"({"type":"join","name":")" + name + "\"";
                if( !password.empty() ) {
                    g_pending_join += R"(,"password":")" + password + "\"";
                }
                if( !version.empty() ) {
                    g_pending_join += R"(,"version":")" + version + "\"";
                }
                g_pending_join += "}\n";
                g_join_sent = false;
                // Replay the probe welcome so seed/world-name adoption fires
                // from the normal incoming-packet path on first do_turn.
                g_recv_queue.push( msg );
                std::cout << "[cdda-mp] Connected to " << host << ":" << port
                          << " as '" << name << "' — version accepted." << std::endl;
                mp_log( "[cdda-mp] HANDSHAKE: host accepted our version — connected to " +
                        host + ":" + std::to_string( port ) + " as '" + name + "'" );
                return true;
            }
            // Any other packet (e.g. hello) — keep waiting.
        }
        std::this_thread::sleep_for( std::chrono::milliseconds( 50 ) );
    }

    g_connect_error = "Timed out waiting for server response.";
    std::cerr << "[cdda-mp] Timed out waiting for welcome from server." << std::endl;
    mp_log( "[cdda-mp] HANDSHAKE: TIMED OUT after 5s waiting for host welcome/error. "
            "The host accepted the TCP connection but never answered the version_probe — "
            "host may be on an older build (no probe support) or not yet loaded into a world." );
    g_client.reset();
    return false;
}

std::string client_connect_error()
{
    return g_connect_error;
}

void client_send_join()
{
    if( g_join_sent || !g_client || g_pending_join.empty() ) {
        return;
    }
    asio::error_code ec;
    asio::write( g_client->sock, asio::buffer( g_pending_join ), ec );
    if( ec ) {
        std::cerr << "[cdda-mp] Failed to send join: " << ec.message() << std::endl;
        return;
    }
    g_join_sent = true;
    std::cout << "[cdda-mp] Join sent — now in-game." << std::endl;
}

bool client_join_is_sent()
{
    return g_join_sent;
}

bool client_recv_pop( std::string &out )
{
    return g_recv_queue.pop( out );
}

void client_send( const std::string &json )
{
    if( !g_client ) {
        return;
    }
    const std::string msg = json + "\n";
    asio::post( g_client->io_ctx, [msg]() {
        if( !g_client ) {
            return;
        }
        asio::error_code ec;
        asio::write( g_client->sock, asio::buffer( msg ), ec );
        if( ec ) {
            std::cerr << "[cdda-mp] Send error: " << ec.message() << std::endl;
        }
    } );
}

} // namespace cata_mp
