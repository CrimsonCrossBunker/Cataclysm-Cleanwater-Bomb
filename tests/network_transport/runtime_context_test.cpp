#include "mp_client_conn.h"
#include "mp_player_identity.h"
#include "mp_protocol.h"
#include "mp_queue.h"
#include "mp_renet_transport.h"
#include "mp_server.h"

#include <chrono>
#include <filesystem>
#include <map>
#include <stdexcept>
#include <string>
#include <thread>

using namespace cata_mp;
using namespace std::chrono_literals;

namespace
{
void require( bool condition, const char *message )
{
    if( !condition ) {
        throw std::runtime_error( message );
    }
}

template<typename Predicate>
void await( Predicate predicate, const char *message )
{
    const auto deadline = std::chrono::steady_clock::now() + 3s;
    while( !predicate() ) {
        require( std::chrono::steady_clock::now() < deadline, message );
        std::this_thread::sleep_for( 5ms );
    }
}

size_t thread_count()
{
#if defined(__linux__)
    return static_cast<size_t>( std::distance( std::filesystem::directory_iterator( "/proc/self/task" ),
            std::filesystem::directory_iterator() ) );
#else
    return 0; // Socket/state isolation is portable; OS thread evidence is Linux-only.
#endif
}

mp_event next_event( host_session &host )
{
    mp_event event;
    await( [&]() {
        return host.events().pop( event );
    }, "expected session-local event" );
    return event;
}

void receive_exact( client_connection &client, const std::string &expected )
{
    std::string message;
    await( [&]() {
        if( !client.recv_pop( message ) ) {
            return false;
        }
        if( message == expected ) {
            return true;
        }
        std::map<std::string, std::string> fields;
        require( read_handshake( message, fields ), "valid queued message" );
        require( fields["type"] == "welcome" || fields["type"] == "player_joined",
                 "another session's gameplay message reached this client" );
        return false;
    }, "expected owner-specific payload" );
}
} // namespace

void exercise_queue_limits()
{
    const auto admission = peer_admission::create( 51 );
    event_queue queue( 4, 4096 );
    require( queue.push( { mp_event::type::connect, "owner", "", admission } ), "join admitted" );
    require( !queue.push( { mp_event::type::connect, "owner", "", admission } ),
             "duplicate admission cannot reserve twice" );
    mp_event event;
    require( queue.pop( event ) && event.evt_type == mp_event::type::connect, "join first" );
    require( queue.current_usage().reserved_disconnects == 1,
             "disconnect reservation outlives join pop" );
    require( !queue.wait_for_event( 1ms ), "reservation is not a queued event" );
    for( const char *data : {
             "first", "second", "third"
         } ) {
        require( queue.push( { mp_event::type::action, "owner", data, admission } ), "action admitted" );
    }
    require( !queue.push( { mp_event::type::action, "owner", "overflow", admission } ),
             "bounded event count rejects overflow" );
    const auto full = queue.current_usage();
    require( full.queued == 3 && full.reserved_disconnects == 1 && full.bytes <= 4096,
             "reservation is included in queue accounting" );
    admission.retire();
    require( queue.push( { mp_event::type::disconnect, "owner", "", admission } ),
             "full queue accepts its reserved disconnect after retirement" );
    require( queue.current_usage().bytes == full.bytes, "reservation transfer needs no extra budget" );
    for( const char *data : {
             "first", "second", "third"
         } ) {
        require( queue.pop( event ) && event.data == data, "accepted action FIFO preserved" );
    }
    require( queue.pop( event ) && event.evt_type == mp_event::type::disconnect &&
             event.admission.matches( admission ), "disconnect follows accepted actions" );
    require( queue.empty() && queue.current_usage().bytes == 0, "pop releases charged storage" );

    event_queue no_reserve( 1, 4096 );
    require( !no_reserve.push( { mp_event::type::connect, "owner", "", peer_admission::create( 52 ) } ),
             "join cannot consume the disconnect reservation" );
    event_queue bytes( 8, 2048 );
    require( bytes.push( { mp_event::type::action, "", std::string( 900, 'x' ), {} } ),
             "first byte-limited event" );
    require( !bytes.push( { mp_event::type::action, "", std::string( 900, 'y' ), {} } ),
             "byte overflow rejected" );
    require( bytes.pop( event ) && bytes.current_usage().bytes == 0, "byte budget reclaimed" );
    std::string retained( 4096, 'x' );
    retained.resize( 1 );
    require( !bytes.push( { mp_event::type::action, "", std::move( retained ), {} } ),
             "string capacity is counted, not just its short current length" );
    require( queue.push( { mp_event::type::connect, "new owner", "", peer_admission::create( 53 ) } ),
             "new admission after draining" );
    queue.clear();
    const auto cleared = queue.current_usage();
    require( cleared.queued == 0 && cleared.reserved_disconnects == 0 && cleared.bytes == 0,
             "session clear releases queued and reserved storage" );
}

void exercise_inbound_overload( uint16_t port )
{
    const server_welcome info{ "budget world", "host", 11, {}, world_id( std::string( 32, '5' ) ) };
    const player_credentials player{ player_id( std::string( 32, 'a' ) ), std::string( 64, 'b' ) };
    host_session host( 4, 1024 * 1024 );
    require( host.start( port, "", "abc", info ), "bounded host starts" );
    client_connection client;
    client.set_enabled( true );
    require( client.connect( "127.0.0.1", port, "budget player", "", "abc" ), "bounded host probe" );
    client.send_join( player );
    const auto joined = next_event( host );
    require( joined.evt_type == mp_event::type::connect, "bounded host joins" );
    for( int i = 0; i < 4; ++i ) {
        client.send( "{\"type\":\"action\",\"action\":\"wait\",\"sequence\":" + std::to_string( i ) + "}" );
    }
    receive_exact( client,
                   R"({"type":"error","message":"Host incoming action queue is full; this message was not accepted. Reconnect to resynchronize."})" );
    await( [&]() {
        const auto usage = host.events().current_usage();
        return usage.queued == 4 && usage.reserved_disconnects == 0;
    }, "disconnect reaches a saturated queue without draining its actions" );
    for( int i = 0; i < 3; ++i ) {
        require( next_event( host ).data ==
                 "{\"type\":\"action\",\"action\":\"wait\",\"sequence\":" + std::to_string( i ) + "}",
                 "overload preserves each previously admitted action in order" );
    }
    const auto disconnected = next_event( host );
    require( disconnected.evt_type == mp_event::type::disconnect &&
             disconnected.admission.matches( joined.admission ), "ordered reserved disconnect" );
    require( host.running() && host.events().empty(), "overload ends only the offending admission" );
    client.reset();
    host.stop();

    host_session cannot_join( 1, 4096 );
    require( cannot_join.start( port, "", "abc", info ), "undersized host starts" );
    require( client.connect( "127.0.0.1", port, "budget player", "", "abc" ), "undersized host probe" );
    client.send_join( player );
    receive_exact( client,
                   R"({"type":"error","message":"Host incoming queue cannot admit another connection; try again after it drains."})" );
    require( cannot_join.events().empty() &&
             cannot_join.events().current_usage().reserved_disconnects == 0,
             "rejected join creates neither actor event nor reservation" );
    client.reset();
    cannot_join.stop();
}

void exercise_context_ownership( uint16_t first_port, uint16_t second_port )
{
    // Equal entity/coordinate keys in two Rust worlds must have independent
    // dirty baselines. Reset joins the worker and discards only its own state.
    renet_context first_state;
    renet_context second_state;
    const auto submit = []( renet_context & context ) {
        return context.tile_submit( 1, 2, 0, "t_floor", "", "", "", "", "" );
    };
    require( submit( first_state ).any(), "first context has a new tile" );
    require( second_state.tile_count() == 0, "second context has no copied tile" );
    require( submit( second_state ).any(), "second context has its own dirty baseline" );
    require( !submit( first_state ).any(), "first context baseline remains stable" );
    const auto threads_before_reset = thread_count();
    first_state.reset();
    if( threads_before_reset != 0 ) {
        await( [&]() {
            return thread_count() + 1 <= threads_before_reset;
        },
        "runtime reset joins its Rust worker" );
    }
    require( second_state.tile_count() == 1 && !submit( second_state ).any(),
             "reset did not invalidate the other replication world" );
    require( first_state.tile_count() == 0, "reset context recreates empty state" );
    first_state.reset();
    second_state.reset();

    host_session first_host;
    host_session second_host;
    const server_welcome first_info{ "first world", "first host", 11, std::array<int, 3>{ 1, 2, 3 }, world_id( std::string( 32, '1' ) ) };
    server_welcome second_info{ "second world", "second host", 22, std::array<int, 3>{ 4, 5, 6 }, world_id( std::string( 32, '2' ) ) };
    require( first_host.start( first_port, "first password", "abc", first_info ), "first host start" );
    require( second_host.start( second_port, "second password", "abc", second_info ),
             "second host start" );
    client_connection first_client;
    client_connection second_client;
    first_client.set_enabled( true );
    second_client.set_enabled( true );
    require( first_client.connect( "127.0.0.1", first_port, "same name", "first password", "abc" ),
             "first independent client connects" );
    require( second_client.connect( "127.0.0.1", second_port, "same name", "second password", "abc" ),
             "second independent client connects" );
    std::map<std::string, std::string> fields;
    require( read_handshake( first_client.welcome(), fields ) && fields["world"] == "first world" &&
             fields["host_name"] == "first host", "first welcome belongs to its host" );
    require( read_handshake( second_client.welcome(), fields ) && fields["world"] == "second world" &&
             fields["host_name"] == "second host", "second welcome belongs to its host" );
    const player_credentials first_player{ player_id( std::string( 32, 'a' ) ), std::string( 64, 'b' ) };
    const player_credentials second_player{ player_id( std::string( 32, 'c' ) ), std::string( 64, 'd' ) };
    first_client.send_join( first_player );
    const auto first_join = next_event( first_host );
    require( first_join.evt_type == mp_event::type::connect && first_join.player.id == first_player.id,
             "first connection event owns its profile" );
    require( second_host.events().empty(), "first join is absent from the other queue" );
    second_client.send_join( second_player );
    const auto second_join = next_event( second_host );
    require( second_join.evt_type == mp_event::type::connect &&
             second_join.player.id == second_player.id,
             "second connection event owns its profile" );
    require( first_host.events().empty(), "second join is absent from the first queue" );

    const std::string first_action = "{\"type\":\"action\",\"action\":\"first\"}";
    const std::string second_action = "{\"type\":\"action\",\"action\":\"second\"}";
    first_client.send( first_action );
    second_client.send( second_action );
    require( next_event( first_host ).data == first_action,
             "first action delivered only to first world" );
    require( next_event( second_host ).data == second_action,
             "second action delivered only to second world" );
    auto retained = first_host.active_server();
    require( first_join.admission.peer_id() == second_join.admission.peer_id(),
             "independent servers reuse numeric routes" );
    retained->post_send( second_join.admission, "{\"type\":\"state\",\"owner\":\"foreign\"}" );
    retained->post_reject( second_join.admission, "foreign rejection" );
    retained->post_send( first_join.admission, "{\"type\":\"state\",\"owner\":\"first\"}" );
    second_host.active_server()->post_send( second_join.admission,
                                            "{\"type\":\"state\",\"owner\":\"second\"}" );
    receive_exact( first_client, "{\"type\":\"state\",\"owner\":\"first\"}" );
    receive_exact( second_client, "{\"type\":\"state\",\"owner\":\"second\"}" );

    first_client.reset();
    const auto first_disconnect = next_event( first_host );
    require( first_disconnect.evt_type == mp_event::type::disconnect &&
             first_disconnect.admission.matches( first_join.admission ) && !first_join.admission.active(),
             "disconnect retires the exact admission" );
    const auto threads_before_stop = thread_count();
    first_host.stop();
    require( !first_host.active_server() && !retained->running(), "retained server lease is retired" );
    if( threads_before_stop != 0 ) {
        await( [&]() {
            return thread_count() + 2 <= threads_before_stop;
        },
        "host stop joins native and Rust workers even with retained lease" );
    }
    retained->post_broadcast( "{\"type\":\"state\",\"owner\":\"stale\"}" );
    retained.reset();
    require( second_host.running() && second_client.connected(), "other world stays connected" );
    second_client.send( second_action );
    require( next_event( second_host ).data == second_action, "other world continues processing" );
    second_host.active_server()->post_send( second_join.admission,
                                            "{\"type\":\"state\",\"owner\":\"still second\"}" );
    receive_exact( second_client, "{\"type\":\"state\",\"owner\":\"still second\"}" );

    second_client.reset();
    require( next_event( second_host ).evt_type == mp_event::type::disconnect, "second disconnect" );
    // Late probes get one updated metadata snapshot, not process-global fields.
    second_info.world_name = "second moved";
    second_host.update_welcome( second_info );
    require( second_client.connect( "127.0.0.1", second_port, "same name", "second password", "abc" ),
             "same owner reconnects after clearing its runtime" );
    require( read_handshake( second_client.welcome(), fields ) && fields["world"] == "second moved",
             "updated welcome published by the correct owner" );
    require( fields["world_id"] == second_info.world.str(), "renaming preserves authority identity" );
    // Even with the same display name and UDP endpoint, a new world cannot
    // accept a join constructed from the previous world's probe.
    second_info.world = world_id( std::string( 32, '3' ) );
    second_host.update_welcome( second_info );
    second_client.send_join( second_player );
    receive_exact( second_client,
                   R"({"type":"error","message":"Host world changed; reconnect before joining"})" );
    require( second_host.events().empty(), "stale-world join produced no owner event" );
    second_client.reset();
    require( second_client.connect( "127.0.0.1", second_port, "same name", "second password", "abc" ),
             "new probe sees the replacement world" );
    require( read_handshake( second_client.welcome(), fields ) &&
             fields["world_id"] == second_info.world.str(),
             "replacement world has its own identity" );
    second_client.send_join( second_player );
    require( next_event( second_host ).evt_type == mp_event::type::connect,
             "fresh-world join positive control" );
    second_client.reset();
    second_host.stop();
}
