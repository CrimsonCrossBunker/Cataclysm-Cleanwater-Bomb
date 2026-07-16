// Standalone Asio — no Boost dependency
#define ASIO_STANDALONE

#include "mp_server.h"

#include <asio.hpp> // IWYU pragma: keep
#include <asio/associated_cancellation_slot.hpp>
#include <asio/async_result.hpp>
#include <asio/buffer.hpp>
#include <asio/detail/bind_handler.hpp>
#include <asio/detail/handler_cont_helpers.hpp>
#include <asio/detail/handler_invoke_helpers.hpp>
#include <asio/detail/impl/reactive_socket_service_base.ipp>
#include <asio/detail/impl/scheduler.ipp>
#include <asio/detail/impl/service_registry.hpp>
#include <asio/execution/context_as.hpp>
#include <asio/execution/prefer_only.hpp>
#include <asio/impl/any_io_executor.ipp>
#include <asio/impl/execution_context.hpp>
#include <asio/impl/handler_alloc_hook.ipp>
#include <asio/impl/io_context.hpp>
#include <asio/impl/io_context.ipp>
#include <asio/impl/read_until.hpp>
#include <asio/impl/write.hpp>
#include <asio/io_context.hpp>
#include <asio/ip/detail/impl/endpoint.ipp>
#include <asio/ip/tcp.hpp>
#include <asio/post.hpp>
#include <asio/streambuf.hpp>
#include <zstd/zstd.h>
#include <algorithm>
#include <atomic>
#include <cstddef>
#include <deque>
#include <functional>
#include <initializer_list>
#include <iostream>
#include <new>
#include <string_view>
#include <system_error>

#include "catacharset.h"   // base64_encode — only pulls std headers, asio-safe
#include "mp_queue.h"

#include <utility>

using asio::ip::tcp;

namespace cata_mp
{

// Forward-declared (not #included) on purpose: pulling mp_gamestate.h into this
// TU drags in CDDA's enum_traits.h, whose generic operator++ collides with
// asio's std::atomic<long> increment in scheduler.hpp. We only need these two.
void mp_log( const std::string &msg ); // NOLINT(cata-static-declarations)
unsigned int mp_host_world_seed(); // NOLINT(cata-static-declarations)
std::string mp_get_host_world_name(); // NOLINT(cata-static-declarations)
std::string mp_get_host_player_name(); // NOLINT(cata-static-declarations)
std::string mp_host_omt_welcome_field(); // NOLINT(cata-static-declarations)

// Escape a string for embedding in a JSON double-quoted value (host names can
// contain quotes/backslashes). Minimal — covers the chars that break parsing.
static std::string mp_json_escape( const std::string_view s )
{
    std::string out;
    out.reserve( s.size() + 2 );
    for( const char c : s ) {
        if( c == '"' || c == '\\' ) {
            out += '\\';
        }
        out += c;
    }
    return out;
}

// Normalize a build-version string to its commit identity for the join
// handshake. getVersionString() is the git commit hash, but the Makefile
// appends build noise that differs between separately-built binaries of the
// SAME commit: "-dirty.<HHMMSS>" (a dirty tree, stamped with the build time)
// and "+SDL3" (rendering backend). The MP wire protocol is fixed by the
// commit, not by build time or render backend, so the handshake must compare
// only the commit token — otherwise no two machines' builds ever match.
static std::string mp_version_commit_id( const std::string &v )
{
    std::string s = v;
    const std::string::size_type d = s.find( "-dirty" );
    if( d != std::string::npos ) {
        s.erase( d );
    }
    const std::string::size_type p = s.find( '+' );
    if( p != std::string::npos ) {
        s.erase( p );
    }
    return s;
}

// Host→client wire compression.  The per-turn state broadcast (monster/map
// snapshot) is large, repetitive JSON; zstd shrinks it ~5-10×.  We keep the
// newline-delimited framing by wrapping the compressed bytes in a tiny JSON
// envelope {"z":"<base64 zstd>"} — base64 contains no JSON-special or newline
// chars, so it rides the existing reader AND the write-queue coalescing
// unchanged.  The client (mp_client_conn.cpp mp_decompress_frame) recognizes the
// {"z": prefix and reverses this.  Messages below the threshold (grants, acks)
// stay plain — the envelope overhead isn't worth it and tiny payloads don't
// compress.  The version handshake guarantees both ends run this same build, so
// there is no cross-version compatibility risk.
static constexpr size_t MP_COMPRESS_THRESHOLD = 512;

static std::string mp_compress_frame( const std::string &msg )
{
    if( msg.size() < MP_COMPRESS_THRESHOLD ) {
        return msg;
    }
    // Compress the payload without its trailing newline; the envelope adds its own.
    size_t body_len = msg.size();
    if( body_len > 0 && msg.back() == '\n' ) {
        --body_len;
    }
    const size_t bound = ZSTD_compressBound( body_len );
    std::string comp;
    comp.resize( bound );
    const size_t n = ZSTD_compress( &comp[0], bound, msg.data(), body_len, 3 );
    if( ZSTD_isError( n ) || n >= body_len ) {
        // Compression failed or didn't help — send the original plaintext.
        return msg;
    }
    return R"({"z":")" + base64_encode( std::string_view( comp.data(), n ) ) + "\"}\n";
}

// ---------------------------------------------------------------------------
// client_session — owns one TCP connection
// ---------------------------------------------------------------------------

struct client_session : public std::enable_shared_from_this<client_session> {
        tcp::socket socket;
        asio::streambuf read_buf;
        std::string name;
        bool authenticated = false;

        std::function<void( std::shared_ptr<client_session>, const std::string & )> on_message;
        std::function<void( std::shared_ptr<client_session> )> on_disconnect;

        // Outgoing write queue — only one async_write may be in flight at a time.
        // All send() / do_write() calls happen on the single Asio thread so no mutex needed.
        std::deque<std::string> write_queue_;
        bool writing_ = false;

        explicit client_session( tcp::socket sock )
            : socket( std::move( sock ) ) {}

        void start() {
            // Disable Nagle — see client_connect(). The host's grant packets are
            // tiny and must not be batched on a high-latency link or the lockstep
            // turn cycle wedges (works on LAN, hangs over the internet).
            std::error_code nd_ec;
            nd_ec = socket.set_option( tcp::no_delay( true ), nd_ec );
            send( "{\"type\":\"hello\",\"protocol\":\"cdda-mp\",\"version\":\"0.1\"}\n" );
            do_read();
        }

        void send( const std::string &msg ) {
            write_queue_.push_back( mp_compress_frame( msg ) );
            if( !writing_ ) {
                do_write();
            }
        }

        void do_write() {
            if( write_queue_.empty() ) {
                writing_ = false;
                return;
            }
            writing_ = true;
            auto self = shared_from_this();
            // Coalesce EVERY queued message into one buffer so N messages enqueued in
            // a single turn become one write() / one batch of back-to-back segments,
            // instead of N separate writes (with Nagle off, N tiny packets — the
            // small-packet storm).  Each queued message already ends in '\n', so the
            // client's newline-framed reader still splits them apart correctly, and an
            // older non-coalescing client is unaffected (wire-compatible).  Messages
            // posted during this async_write land back in write_queue_ and coalesce on
            // the next pass.
            auto buf = std::make_shared<std::string>();
            for( const std::string &m : write_queue_ ) {
                buf->append( m );
            }
            write_queue_.clear();
            asio::async_write( socket, asio::buffer( *buf ),
            [self, buf]( std::error_code ec, std::size_t ) {
                if( ec ) {
                    self->disconnect();
                    return;
                }
                self->do_write();
            } );
        }

        void disconnect() {
            std::error_code ec;
            ec = socket.close( ec );
            if( on_disconnect ) {
                on_disconnect( shared_from_this() );
            }
        }

    private:
        void do_read() {
            auto self = shared_from_this();
            asio::async_read_until( socket, read_buf, '\n',
            [self]( std::error_code ec, std::size_t ) {
                if( ec ) {
                    self->disconnect();
                    return;
                }
                std::istream stream( &self->read_buf );
                std::string line;
                std::getline( stream, line );
                if( !line.empty() && self->on_message ) {
                    self->on_message( self, line );
                }
                self->do_read();
            } );
        }
};

// ---------------------------------------------------------------------------
// server::impl — holds the Asio io_context and acceptor
// ---------------------------------------------------------------------------

struct server::impl {
    asio::io_context io_ctx;
    tcp::acceptor acceptor;

    explicit impl( uint16_t port )
        : acceptor( io_ctx, tcp::endpoint( tcp::v4(), port ) ) {}
};

// ---------------------------------------------------------------------------
// server
// ---------------------------------------------------------------------------

server::server( uint16_t port, std::string password, std::string version )
    : port_( port )
    , password_( std::move( password ) )
    , version_( std::move( version ) )
    , impl_( std::make_unique<impl>( port ) ) {}

server::~server() = default;

void server::run()
{
    std::cout << "[cdda-mp] Server listening on port " << port_ << std::endl;
    do_accept();
    impl_->io_ctx.run();
}

void server::stop()
{
    impl_->io_ctx.stop();
}

void server::broadcast( const std::string &msg )
{
    std::scoped_lock lock( clients_mutex_ );
    for( auto &c : clients_ ) {
        c->send( msg );
    }
}

void server::post_broadcast( const std::string &msg )
{
    asio::post( impl_->io_ctx, [this, msg]() {
        broadcast( msg );
    } );
}

void server::do_accept()
{
    impl_->acceptor.async_accept(
    [this]( std::error_code ec, tcp::socket socket ) {
        if( !ec ) {
            auto session = std::make_shared<client_session>( std::move( socket ) );

            session->on_message = [this]( const auto & sess, const auto & msg ) {
                on_message( sess, msg );
            };
            session->on_disconnect = [this]( const auto & sess ) {
                on_client_disconnected( sess );
            };

            on_client_connected( session );
            session->start();
        }
        do_accept();
    } );
}

void server::on_client_connected( const std::shared_ptr<client_session> &session )
{
    {
        std::scoped_lock lock( clients_mutex_ );
        clients_.push_back( session );
    }
    std::cout << "[cdda-mp] Client connected.  Total: " << clients_.size() << std::endl;

    if( clients_.size() > 2 ) {
        session->send( "{\"type\":\"error\",\"message\":\"Server is full (max 2 players)\"}\n" );
        session->disconnect();
    }
}

void server::on_client_disconnected( const std::shared_ptr<client_session> &session )
{
    {
        std::scoped_lock lock( clients_mutex_ );
        clients_.erase(
            std::remove( clients_.begin(), clients_.end(), session ),
            clients_.end()
        );
    }
    std::string name = session->name.empty() ? "unknown" : session->name;
    std::cout << "[cdda-mp] Client '" << name << "' disconnected.  Total: " <<
              clients_.size() << std::endl;

    if( session->authenticated ) {
        broadcast( R"({"type":"player_left","name":")" + name + "\"}\n" );
        get_mp_queue().push( { cata_mp::mp_event::type::disconnect, name, "" } );
    }
}

// Extract a string value from a simple JSON message, tolerating optional spaces
// around the colon (handles both "key":"val" and "key": "val").
static std::string json_get_str( const std::string_view json, const std::string &key )
{
    for( const std::string &sep : {
             std::string( "\":\"" ), std::string( "\": \"" )
         } ) {
        std::string needle = "\"";
        needle += key;
        needle += sep;
        std::string_view::size_type pos = json.find( needle );
        if( pos != std::string::npos ) {
            pos += needle.size();
            const std::string_view::size_type end = json.find( '"', pos );
            if( end != std::string::npos ) {
                return std::string( json.substr( pos, end - pos ) );
            }
        }
    }
    return "";
}

void server::on_message( const std::shared_ptr<client_session> &session, const std::string &msg )
{
    std::cout << "[cdda-mp] recv: " << msg << std::endl;

    const std::string type = json_get_str( msg, "type" );

    // Lightweight pre-join probe: validate version + password immediately
    // without spawning the proxy NPC or queuing a connect event.  Lets the
    // client surface a version mismatch before the character creation UI.
    if( type == "version_probe" ) {
        const std::string probe_ver = json_get_str( msg, "version" );
        mp_log( "[cdda-mp] PROBE recv: client_ver='" +
                ( probe_ver.empty() ? std::string( "(none)" ) : probe_ver ) +
                "' host_ver='" + version_ + "' -> client_commit=" +
                mp_version_commit_id( probe_ver ) + " host_commit=" +
                mp_version_commit_id( version_ ) );
        if( !version_.empty() ) {
            const std::string client_ver = json_get_str( msg, "version" );
            if( mp_version_commit_id( client_ver ) != mp_version_commit_id( version_ ) ) {
                const std::string errmsg = "Version mismatch.  Host: " + version_ +
                                           " Client: " + ( client_ver.empty() ? "(unknown)" : client_ver );
                session->send( R"({"type":"error","message":")" + errmsg + "\"}\n" );
                mp_log( "[cdda-mp] PROBE REJECTED — version mismatch. " + errmsg +
                        " (host and client are on different builds; both must run the same release)" );
                session->disconnect();
                return;
            }
        }
        if( !password_.empty() ) {
            const std::string provided = json_get_str( msg, "password" );
            if( provided != password_ ) {
                session->send( "{\"type\":\"error\",\"message\":\"Wrong password\"}\n" );
                mp_log( "[cdda-mp] PROBE REJECTED — wrong password" );
                session->disconnect();
                return;
            }
        }
        // Probe accepted — send world name + seed + host OMT so the client can
        // display "Joining <world>" AND adopt the seed + spawn location before
        // character creation runs (client start_game() needs both before it
        // builds the host-area overmap; the post-JOIN welcome arrives too late —
        // it lands on the first do_turn, after start_game has already generated
        // the overmap with its own rng_bits() seed → ocean-spawn / "different
        // overmap" co-op join regression, 2026-06-21).
        mp_log( "[cdda-mp] PROBE accepted — version OK; sending welcome (world='" +
                mp_get_host_world_name() + "')" );
        session->send( "{\"type\":\"welcome\",\"player_id\":\"probe\""
                       ",\"world\":\"" + mp_get_host_world_name() + "\""
                       ",\"host_name\":\"" + mp_json_escape( mp_get_host_player_name() ) + "\""
                       ",\"current_turn\":0,\"seed\":" +
                       std::to_string( mp_host_world_seed() ) +
                       mp_host_omt_welcome_field() + "}\n" );
        return;
    }

    if( type == "join" ) {
        // Extract name
        std::string name = json_get_str( msg, "name" );
        if( name.empty() ) {
            name = "player";
        }

        // Check version compatibility — reject mismatched binaries. Compare
        // commit identity only (mp_version_commit_id), so two builds of the
        // same commit connect even if one tree was dirty / built at a
        // different time / uses a different render backend.
        if( !version_.empty() ) {
            const std::string client_ver = json_get_str( msg, "version" );
            if( mp_version_commit_id( client_ver ) != mp_version_commit_id( version_ ) ) {
                const std::string errmsg = "Version mismatch.  Host: " + version_ +
                                           " Client: " + ( client_ver.empty() ? "(unknown)" : client_ver );
                session->send( R"({"type":"error","message":")" + errmsg + "\"}\n" );
                mp_log( "[cdda-mp] JOIN REJECTED — version mismatch. " + errmsg +
                        " client_commit=" + mp_version_commit_id( client_ver ) +
                        " host_commit=" + mp_version_commit_id( version_ ) );
                session->disconnect();
                return;
            }
        }

        // Check password
        if( !password_.empty() ) {
            const std::string provided = json_get_str( msg, "password" );
            if( provided != password_ ) {
                session->send( "{\"type\":\"error\",\"message\":\"Wrong password\"}\n" );
                mp_log( "[cdda-mp] JOIN REJECTED — wrong password (name='" + name + "')" );
                session->disconnect();
                return;
            }
        }

        session->name = name;
        session->authenticated = true;

        // Include the host's worldgen seed so the client adopts it before
        // generating the host-area overmap — otherwise it renders its own
        // randomly-seeded terrain outside the tile-synced bubble.
        const std::string wname = mp_get_host_world_name();
        session->send( R"({"type":"welcome","player_id":")" + name +
                       R"(","world":")" + wname +
                       R"(","host_name":")" + mp_json_escape( mp_get_host_player_name() ) +
                       R"(","current_turn":0,"seed":)" +
                       std::to_string( mp_host_world_seed() ) +
                       mp_host_omt_welcome_field() + "}\n" );
        mp_log( "[cdda-mp] SEED: welcome sent host seed " +
                std::to_string( mp_host_world_seed() ) + " to '" + name + "'" );

        broadcast( R"({"type":"player_joined","name":")" + name + "\"}\n" );
        mp_log( "[cdda-mp] JOIN accepted — player '" + name + "' authenticated and connected" );

        // Notify game loop to spawn this player's character
        get_mp_queue().push( { cata_mp::mp_event::type::connect, name, "" } );

    } else if( type == "quit" ) {
        session->send( "{\"type\":\"goodbye\"}\n" );
        session->disconnect();

    } else if( session->authenticated ) {
        // Route action to game loop
        get_mp_queue().push( { cata_mp::mp_event::type::action, session->name, msg } );

    } else {
        // Unauthenticated session sent something that isn't version_probe / join /
        // quit. Almost always a protocol/version skew (e.g. a client on a build
        // that predates the version_probe handshake). Log it instead of silently
        // dropping the message, then close so the client doesn't hang.
        mp_log( "[cdda-mp] HANDSHAKE: unexpected pre-auth message type='" +
                ( type.empty() ? std::string( "(none)" ) : type ) +
                "' — likely a different/old client build.  Closing." );
        session->disconnect();
    }
}

// ---------------------------------------------------------------------------
// Entry point called from main()
// ---------------------------------------------------------------------------

static server *active_server_ = nullptr;
static std::atomic<bool> server_thread_running_{ false };

server *get_active_server()
{
    return active_server_;
}

bool is_server_thread_running()
{
    return server_thread_running_.load();
}

void run_server( uint16_t port, const std::string &password, const std::string &version )
{
    server_thread_running_.store( true );
    try {
        // The server ctor binds the listen socket and THROWS if the port is
        // still held (e.g. a prior session's socket not yet released). Surface
        // it via mp_log — std::cerr alone is invisible in the in-game log and
        // hid this failure: a thrown ctor leaves active_server_ null, so
        // is_hosting() stays false and the whole host turn body is skipped.
        server srv( port, password, version );
        active_server_ = &srv;
        srv.run();
    } catch( const std::exception &e ) {
        mp_log( std::string( "[cdda-mp] SERVER-ERROR: " ) + e.what() );
        std::cerr << "[cdda-mp] Server error: " << e.what() << std::endl;
        // Never call exit() from a background thread — it runs SDL atexit handlers
        // on the wrong thread, which crashes on macOS (EXC_BREAKPOINT in Cocoa).
    }
    active_server_ = nullptr;
    // Cleared last: the server object above has now destructed and released the
    // listen socket, so a waiter on this flag knows the port is free.
    server_thread_running_.store( false );
}

} // namespace cata_mp
