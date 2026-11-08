#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "map_helpers.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "rng.h"

TEST_CASE( "mp_proxy_bindings_belong_to_one_world", "[multiplayer][world_session]" )
{
    cata_mp::world_session first;
    cata_mp::world_session second;
    first.remote_actor_id = character_id( 12 );
    first.remote_connected = true;
    first.remote_peer_id = 101;
    second.remote_actor_id = character_id( 12 );
    second.remote_connected = true;
    second.remote_peer_id = 202;

    CHECK( first.accepts_remote_event( 101 ) );
    CHECK_FALSE( first.accepts_remote_event( 0 ) );
    CHECK_FALSE( first.accepts_remote_event( 202 ) );
    CHECK_FALSE( second.accepts_remote_event( 101 ) );
    first.reset();
    CHECK_FALSE( first.accepts_remote_event( 101 ) );
    CHECK( second.accepts_remote_event( 202 ) );
    CHECK( second.remote_actor_id == character_id( 12 ) );
}

TEST_CASE( "mp_world_reset_clears_bindings_before_character_ids_are_reused",
           "[multiplayer][world_session]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope restore_session( [&session]() {
        session.reset();
    } );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    session.remote_actor_id = character_id( 1 );
    session.remote_connected = true;
    session.remote_peer_id = 101;
    session.client_host_actor_id = character_id( 2 );
    session.client_host_spawned = true;
    session.stale_proxy_cleanup_done = true;

    session.client_apply_watchdog.begin( "world reset" );
    REQUIRE( session.client_apply_watchdog.running() );
    REQUIRE( cata_mp::is_remote_player( character_id( 1 ) ) );
    g->reset_game_state();
    CHECK_FALSE( session.client_apply_watchdog.running() );
    CHECK_FALSE( cata_mp::is_remote_player( character_id( 1 ) ) );
    CHECK_FALSE( session.remote_connected );
    CHECK_FALSE( session.remote_actor_id.is_valid() );
    CHECK( session.remote_peer_id == 0 );
    CHECK_FALSE( session.client_host_spawned );
    CHECK_FALSE( cata_mp::get_host_npc_character_id().is_valid() );
    CHECK_FALSE( session.stale_proxy_cleanup_done );
    CHECK( g->assign_npc_id() == character_id( 1 ) );
}

TEST_CASE( "mp_late_disconnect_cannot_remove_another_peers_actor",
           "[multiplayer][world_session][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    REQUIRE( cata_mp::get_mp_queue().empty() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope restore_session( [&session]() {
        session.reset();
    } );
    session.remote_actor_id = character_id( 123 );
    session.remote_connected = true;
    session.remote_peer_id = 202;
    // Same display name, different transport peer. Exercise the real dispatch
    // path, not just the predicate: the disconnect must never reach despawn.
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", 101} );
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", 0} );
    cata_mp::process_mp_events();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( session.remote_connected );
    CHECK( session.remote_peer_id == 202 );
    CHECK( cata_mp::is_remote_player( character_id( 123 ) ) );

    cata_mp::mp_on_world_exit();
    CHECK_FALSE( session.remote_connected );
    CHECK_FALSE( session.accepts_remote_event( 202 ) );
    CHECK_FALSE( session.remote_actor_id.is_valid() );
}

TEST_CASE( "mp_return_to_menu_closes_modes_bindings_and_pending_events",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    REQUIRE( cata_mp::get_mp_queue().empty() );
    auto &session = g->multiplayer_session();
    const restore_on_out_of_scope restore_quit( g->uquit );
    const on_out_of_scope cleanup( []() {
        cata_mp::mp_on_world_exit();
        cata_mp::mp_event event;
        while( cata_mp::get_mp_queue().pop( event ) ) {}
        // cleanup_at_end releases MAPBUFFER. Recreate the test map before the
        // native harness saves its test world or another case uses its tiles.
        clear_overmaps();
    } );
    cata_mp::set_client_mode( true );
    session.client_host_actor_id = character_id( 123 );
    session.client_host_spawned = true;
    session.stale_proxy_cleanup_done = true;
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", 101} );
    cata_mp::mp_set_host_world_name( "world being closed" );
    cata_mp::mp_set_host_player_name( "old host" );
    g->uquit = QUIT_SAVED;
    session.client_apply_watchdog.begin( "world exit" );
    REQUIRE( session.client_apply_watchdog.running() );

    // Exercise the actual gameplay -> main menu boundary, not the unconnected
    // exit helper directly. No socket is needed to expose the leaked mode.
    REQUIRE( turn_handler::cleanup_at_end() );
    CHECK_FALSE( session.client_apply_watchdog.running() );
    CHECK_FALSE( cata_mp::is_session_active() );
    CHECK_FALSE( session.client_host_spawned );
    CHECK_FALSE( session.client_host_actor_id.is_valid() );
    CHECK_FALSE( session.stale_proxy_cleanup_done );
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( cata_mp::mp_get_host_world_name().empty() );
    CHECK( cata_mp::mp_get_host_player_name().empty() );
}

TEST_CASE( "mp_deferred_host_intent_survives_setup_but_not_world_exit",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const on_out_of_scope cleanup( []() {
        cata_mp::mp_on_world_exit();
    } );
    REQUIRE( cata_mp::mp_request_host_session( 0, "", "test" ) );
    g->reset_game_state();
    CHECK( cata_mp::is_host_mode() );
    CHECK_FALSE( cata_mp::is_hosting() );
    CHECK_FALSE( cata_mp::mp_menu_coop_status_text().empty() );

    cata_mp::mp_on_world_exit();
    cata_mp::process_mp_events();
    CHECK_FALSE( cata_mp::is_session_active() );
    CHECK_FALSE( cata_mp::is_hosting() );
    CHECK( cata_mp::mp_menu_coop_status_text().empty() );
}
