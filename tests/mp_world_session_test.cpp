#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "map_helpers.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "rng.h"
#include "avatar.h"
#include "cata_utility.h"
#include "filesystem.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "player_helpers.h"
#include <filesystem>

TEST_CASE( "mp_cleanup_never_claims_npcs_by_name_or_unverified_cleanup_ids",
           "[multiplayer][world_session][player_identity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    const auto cleanup_path = PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json";
    REQUIRE_FALSE( file_exist( cleanup_path ) );
    const on_out_of_scope cleanup( [&]() {
        clear_npcs();
        remove_file( cleanup_path );
        session.reset();
    } );
    npc &same_name = spawn_npc( { 60, 60 }, "test_talker" );
    same_name.name = get_avatar().name;
    const auto same_id = same_name.getID();
    npc &default_name = spawn_npc( { 61, 60 }, "test_talker" );
    default_name.name = "player2";
    const auto default_id = default_name.getID();
    npc &proxy = spawn_npc( { 62, 60 }, "test_talker" );
    proxy.name = same_name.name;
    proxy.set_value( "mp_proxy", std::string( "1" ) );
    const auto proxy_id = proxy.getID();
    write_to_file( cleanup_path, [&]( std::ostream & out ) {
        // Old metadata is not sufficient evidence: IDs may have been reused.
        out << "{\"ids\":[" << same_id.get_value() << "],\"names\":[\"player2\"]}";
    } );
    session.stale_proxy_cleanup_done = false;
    cata_mp::mp_cleanup_stale_npcs_after_load();
    CHECK( g->critter_by_id<npc>( same_id ) != nullptr );
    CHECK( g->critter_by_id<npc>( default_id ) != nullptr );
    CHECK( g->critter_by_id<npc>( proxy_id ) == nullptr );
    CHECK_FALSE( overmap_buffer.find_npc( proxy_id ) );
    CHECK( session.stale_proxy_cleanup_done );
}

TEST_CASE( "mp_native_dispatch_rejoins_the_same_persistent_actor",
           "[multiplayer][world_session][player_identity][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const cata_mp::player_credentials profile{ cata_mp::player_id( std::string( 32, '3' ) ),
            std::string( 64, 'c' ) };
    const auto record = PATH_INFO::world_base_save_path() / ( "mp_actor_" + profile.id.str() +
        ".json" );
    const auto backup = record + ".test-backup";
    REQUIRE_FALSE( file_exist( record ) );
    REQUIRE_FALSE( file_exist( backup ) );
    const on_out_of_scope cleanup( [&]() {
        clear_npcs();
        session.reset();
        std::filesystem::remove_all( record.get_unrelative_path() );
        remove_file( backup );
        remove_file( PATH_INFO::world_base_save_path() / "mp_npc_cleanup.json" );
        cata_mp::get_mp_queue().clear();
    } );
    const auto connect = [&]( uint64_t peer, const cata_mp::player_credentials & identity ) {
        cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect, "connection nickname", "", peer, identity } );
        cata_mp::process_mp_events();
    };
    connect( 101, profile );
    REQUIRE( session.remote_connected );
    const auto original_id = session.remote_actor_id;
    REQUIRE( original_id.is_valid() );
    npc *actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
    actor->name = "Rosalee Blanco";
    actor->set_value( "identity_regression", std::string( "retained" ) );
    std::filesystem::rename( record.get_unrelative_path(), backup.get_unrelative_path() );
    std::filesystem::create_directory( record.get_unrelative_path() );
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", 101 } );
    cata_mp::process_mp_events();
    CHECK( session.remote_detach_pending );
    CHECK( session.remote_peer_id == 0 );
    CHECK( g->critter_by_id<npc>( original_id ) == actor );
    CHECK( cata_mp::is_remote_player( original_id ) );
    cata_mp::wait_for_client_action(); // Must not wait for the disconnected peer.
    std::filesystem::remove( record.get_unrelative_path() );
    std::filesystem::rename( backup.get_unrelative_path(), record.get_unrelative_path() );
    REQUIRE( cata_mp::mp_save_remote_player() );
    CHECK_FALSE( session.remote_detach_pending );
    REQUIRE_FALSE( session.remote_connected );
    session.reset(); // Includes a fresh world-store index, not merely a socket reconnect.
    connect( 202, profile );
    REQUIRE( session.remote_connected );
    CHECK( session.remote_actor_id == original_id );
    actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
    CHECK( actor->name == "Rosalee Blanco" );
    CHECK( actor->get_value( "identity_regression" ).str() == "retained" );
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", 101 } );
    cata_mp::process_mp_events();
    CHECK( session.remote_connected );
    CHECK( session.remote_peer_id == 202 );
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", 202 } );
    cata_mp::process_mp_events();
    auto impostor = profile;
    impostor.resume_secret = std::string( 64, 'd' );
    connect( 303, impostor );
    CHECK_FALSE( session.remote_connected );
    connect( 404, profile );
    REQUIRE( session.remote_connected );
    CHECK( session.remote_actor_id == original_id );
}

TEST_CASE( "mp_restored_actor_ids_cannot_be_reallocated", "[multiplayer][player_identity]" )
{
    const character_id allocated = g->assign_npc_id();
    const character_id restored( allocated.get_value() + 100 );
    g->observe_npc_id( restored );
    CHECK( g->assign_npc_id() == character_id( restored.get_value() + 1 ) );
    g->observe_npc_id( allocated );
    CHECK( g->assign_npc_id() == character_id( restored.get_value() + 2 ) );
    CHECK_THROWS( g->observe_npc_id( character_id() ) );
}

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

TEST_CASE( "mp_client_mode_and_teardown_belong_to_the_owning_world",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    const on_out_of_scope cleanup( []() {
        cata_mp::mp_on_world_exit();
    } );
    cata_mp::world_session other_world;
    cata_mp::set_client_mode( true );
    CHECK( g->multiplayer_session().client.enabled() );
    CHECK_FALSE( other_world.client.enabled() );
    other_world.reset();
    CHECK( cata_mp::is_client_mode() );

    other_world.client.set_enabled( true );
    g->multiplayer_session().reset();
    CHECK_FALSE( cata_mp::is_client_mode() );
    CHECK( other_world.client.enabled() );
    // Enabling client UI without a successful probe is not pending admission.
    other_world.prepare_for_world_load();
    CHECK_FALSE( other_world.client.enabled() );
}

TEST_CASE( "mp_host_metadata_and_events_belong_to_the_owning_world",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &current = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        current.reset();
    } );
    cata_mp::world_session other;
    cata_mp::mp_set_host_world_name( "current world" );
    cata_mp::mp_set_host_player_name( "current host" );
    cata_mp::mp_capture_host_omt( tripoint_abs_omt( 1, 2, 3 ) );
    current.host_info.seed = 11;
    other.host_info = { "other world", "other host", 22, std::array<int, 3>{ 4, 5, 6 } };
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::action, "", "current", 1} );
    CHECK( other.hosting.events().empty() );
    other.hosting.events().push( {cata_mp::mp_event::type::action, "", "other", 2} );

    other.reset();
    CHECK( other.hosting.events().empty() );
    CHECK( other.host_info.world_name.empty() );
    CHECK_FALSE( other.host_info.host_omt );
    CHECK( cata_mp::mp_get_host_world_name() == "current world" );
    CHECK( cata_mp::mp_get_host_player_name() == "current host" );
    CHECK( cata_mp::mp_host_world_seed() == 11 );
    CHECK( cata_mp::mp_host_omt() == tripoint_abs_omt( 1, 2, 3 ) );
    cata_mp::mp_event event;
    REQUIRE( cata_mp::get_mp_queue().pop( event ) );
    CHECK( event.data == "current" );
    CHECK( cata_mp::get_mp_queue().empty() );

    other.hosting.events().push( {cata_mp::mp_event::type::action, "", "survivor", 2} );
    current.hosting.events().push( {cata_mp::mp_event::type::action, "", "retired", 1} );
    current.reset();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( cata_mp::mp_get_host_world_name().empty() );
    CHECK( cata_mp::mp_get_host_player_name().empty() );
    CHECK( cata_mp::mp_host_world_seed() == 0 );
    CHECK_FALSE( cata_mp::mp_host_omt_valid() );
    REQUIRE( other.hosting.events().pop( event ) );
    CHECK( event.data == "survivor" );
}
