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
#include "calendar.h"
#include "cata_utility.h"
#include "filesystem.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "path_info.h"
#include "player_helpers.h"
#include <filesystem>
#include <map>

namespace
{
cata_mp::player_id test_player()
{
    return cata_mp::player_id( std::string( 32, '7' ) );
}

npc &bind_test_player( cata_mp::world_session &session )
{
    npc &actor = spawn_npc( { 60, 60 }, "test_talker" );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    actor.set_value( "mp_player_id", test_player().str() );
    session.remote_actor.bind_player( actor, test_player(), g->npc_lifetimes() );
    return actor;
}

void bind_test_view( cata_mp::world_session &session )
{
    npc &actor = spawn_npc( { 61, 60 }, "test_talker" );
    actor.set_value( "mp_proxy", std::string( "1" ) );
    session.client_host_actor.bind_view( actor, g->npc_lifetimes() );
}
} // namespace

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
    std::map<uint64_t, cata_mp::peer_admission> admissions;
    const auto connect = [&]( uint64_t peer, const cata_mp::player_credentials & identity ) {
        admissions[peer] = cata_mp::peer_admission::create( peer );
        cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect, "connection nickname", "", admissions[peer], identity } );
        cata_mp::process_mp_events();
    };
    connect( 101, profile );
    REQUIRE( session.remote_connected );
    const auto original_id = session.remote_actor.id();
    REQUIRE( original_id.is_valid() );
    npc *actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
    const auto before_unload = g->npc_lifetimes().acquire( *actor );
    actor->on_unload();
    g->remove_npc( actor->getID() );
    CHECK_FALSE( before_unload.resolve( g->npc_lifetimes() ) );
    CHECK_FALSE( session.remote_actor.resolve_loaded( actor, g->npc_lifetimes() ) );
    CHECK( session.remote_actor.retained( g->npc_lifetimes() ) == actor );
    REQUIRE( cata_mp::mp_save_remote_player() );
    g->load_npcs();
    CHECK( session.remote_actor.resolve_loaded( actor, g->npc_lifetimes() ) == actor );
    CHECK_FALSE( before_unload.resolve( g->npc_lifetimes() ) );
    actor->name = "before final sync";
    actor->set_value( "identity_regression", std::string( "retained" ) );
    std::filesystem::rename( record.get_unrelative_path(), backup.get_unrelative_path() );
    std::filesystem::create_directory( record.get_unrelative_path() );
    // The worker accepted this final action before observing disconnect. Its
    // retirement must not reorder the owner stream or lose the saved update.
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                    R"({"action":"worn_sync","char_stats":{"name":"Rosalee Blanco"}})",
                                    admissions.at( 101 ) } );
    admissions.at( 101 ).retire();
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 101 ) } );
    cata_mp::process_mp_events();
    CHECK( session.remote_detach_pending );
    CHECK( session.remote_admission.peer_id() == 0 );
    CHECK( g->critter_by_id<npc>( original_id ) == actor );
    CHECK( actor->name == "Rosalee Blanco" );
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
    CHECK( session.remote_actor.id() == original_id );
    actor = g->critter_by_id<npc>( original_id );
    REQUIRE( actor );
    CHECK( actor->name == "Rosalee Blanco" );
    CHECK( actor->get_value( "identity_regression" ).str() == "retained" );
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 101 ) } );
    cata_mp::process_mp_events();
    CHECK( session.remote_connected );
    CHECK( session.remote_admission.peer_id() == 202 );
    admissions.at( 202 ).retire();
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "nickname", "", admissions.at( 202 ) } );
    cata_mp::process_mp_events();
    CHECK_FALSE( session.remote_connected );
    CHECK_FALSE( session.remote_detach_pending );
    auto impostor = profile;
    impostor.resume_secret = std::string( 64, 'd' );
    connect( 303, impostor );
    CHECK_FALSE( session.remote_connected );
    session.replication.next_net_id = 77;
    session.replication.host.host_veh_cargo_baseline[tripoint_abs_ms( 1, 2, 0 )] = "old cargo";
    session.replication.host.last_vehicle_step_payload = "old stationary vehicles";
    session.host_turn.grant_seq = 88;
    session.host_turn.pending_wake_client = true;
    session.host_turn.action_msgs_pending.push_back( "former peer's action" );
    connect( 404, profile );
    REQUIRE( session.remote_connected );
    CHECK( session.remote_actor.id() == original_id );
    CHECK( session.replication.next_net_id == 77 );
    CHECK( session.host_turn.grant_seq == 88 );
    CHECK( session.replication.host.host_veh_cargo_baseline.empty() );
    CHECK( session.replication.host.last_vehicle_step_payload.empty() );
    CHECK_FALSE( session.host_turn.pending_wake_client );
    CHECK( session.host_turn.action_msgs_pending.empty() );
}

TEST_CASE( "mp_dispatch_never_controls_an_unloaded_or_replaced_actor",
           "[multiplayer][world_session][actor_binding][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        cata_mp::get_mp_queue().clear();
    } );
    npc &actor = bind_test_player( session );
    const auto retained = g->shared_from( actor );
    REQUIRE( retained );
    session.remote_connected = true;
    session.remote_admission = cata_mp::peer_admission::create( 701 );
    const auto rename = [&]() {
        cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "nickname",
                                        R"({"action":"worn_sync","char_stats":{"name":"accepted owner"}})", session.remote_admission } );
        cata_mp::process_mp_events();
    };
    rename();
    REQUIRE( actor.name == "accepted owner" );
    actor.name = "unchanged";

    SECTION( "ordinary unload rejects actions and native reload restores the same role" ) {
        const auto before = g->npc_lifetimes().acquire( actor );
        session.host_turn.proxy_was_alive = true;
        session.host_turn.granted_this_turn = true;
        actor.on_unload();
        g->remove_npc( actor.getID() );
        cata_mp::grant_client_turn();
        CHECK( session.remote_connected );
        CHECK( session.host_turn.proxy_was_alive );
        CHECK_FALSE( session.host_turn.granted_this_turn );
        rename();
        CHECK( actor.name == "unchanged" );
        CHECK_FALSE( before.resolve( g->npc_lifetimes() ) );
        g->load_npcs();
        rename();
        CHECK( actor.name == "accepted owner" );
        CHECK_FALSE( before.resolve( g->npc_lifetimes() ) );
    }
    SECTION( "removal from the active tracker is sufficient to reject control" ) {
        // remove_npc does not invoke on_unload: an active lifetime alone is
        // insufficient without exact membership in the current native tracker.
        g->remove_npc( actor.getID() );
        rename();
        CHECK( actor.name == "unchanged" );
        g->load_npcs();
        rename();
        CHECK( actor.name == "accepted owner" );
    }
    SECTION( "copied ID and tags cannot transfer control to a replacement" ) {
        g->remove_npc( actor.getID() );
        auto replacement = make_shared_fast<npc>();
        replacement->normalize();
        replacement->setID( actor.getID() );
        replacement->spawn_at_precise( actor.pos_abs() );
        replacement->set_value( "mp_proxy", std::string( "1" ) );
        replacement->set_value( "mp_player_id", test_player().str() );
        replacement->name = "replacement";
        overmap_buffer.insert_npc( replacement );
        g->load_npcs();
        REQUIRE( g->critter_by_id<npc>( actor.getID() ) == replacement.get() );
        rename();
        CHECK( replacement->name == "replacement" );
        CHECK( actor.name == "unchanged" );
        CHECK_FALSE( cata_mp::is_remote_player( replacement->getID() ) );
    }
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
    npc first_actor;
    first_actor.normalize();
    first_actor.setID( character_id( 12 ), true );
    first_actor.set_value( "mp_proxy", std::string( "1" ) );
    first_actor.set_value( "mp_player_id", test_player().str() );
    npc second_actor;
    second_actor.normalize();
    second_actor.setID( character_id( 12 ), true );
    second_actor.set_value( "mp_proxy", std::string( "1" ) );
    second_actor.set_value( "mp_player_id", test_player().str() );
    npc_lifetime_registry first_world;
    npc_lifetime_registry second_world;
    first.remote_actor.bind_player( first_actor, test_player(), first_world );
    first.remote_connected = true;
    first.remote_admission = cata_mp::peer_admission::create( 101 );
    second.remote_actor.bind_player( second_actor, test_player(), second_world );
    second.remote_connected = true;
    second.remote_admission = cata_mp::peer_admission::create( 101 );

    const auto first_admission = first.remote_admission;
    CHECK( first.accepts_remote_event( first_admission ) );
    CHECK_FALSE( first.accepts_remote_event( second.remote_admission ) );
    CHECK_FALSE( first.accepts_remote_event( cata_mp::peer_admission::create( 0 ) ) );
    CHECK_FALSE( first.accepts_remote_event( cata_mp::peer_admission::create( 202 ) ) );
    CHECK_FALSE( second.accepts_remote_event( cata_mp::peer_admission::create( 101 ) ) );
    first.reset();
    CHECK_FALSE( first.accepts_remote_event( first_admission ) );
    CHECK( second.accepts_remote_event( second.remote_admission ) );
    CHECK( second.remote_actor.id() == character_id( 12 ) );
}

TEST_CASE( "mp_world_reset_clears_bindings_before_character_ids_are_reused",
           "[multiplayer][world_session]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope restore_session( [&session]() {
        session.reset();
        // reset_game_state clears the faction manager, while production setup
        // also discards the old overmaps. Do not reload test NPCs retaining
        // pointers to factions from that closed world in the next test.
        clear_overmaps();
    } );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    clear_map_without_vision();
    const auto actor_id = bind_test_player( session ).getID();
    session.remote_connected = true;
    session.remote_admission = cata_mp::peer_admission::create( 101 );
    bind_test_view( session );
    session.client_host_spawned = true;
    session.stale_proxy_cleanup_done = true;

    session.client_apply_watchdog.begin( "world reset" );
    REQUIRE( session.client_apply_watchdog.running() );
    REQUIRE( cata_mp::is_remote_player( actor_id ) );
    g->reset_game_state();
    CHECK_FALSE( session.client_apply_watchdog.running() );
    CHECK_FALSE( cata_mp::is_remote_player( actor_id ) );
    CHECK_FALSE( session.remote_connected );
    CHECK_FALSE( session.remote_actor.id().is_valid() );
    CHECK( session.remote_admission.peer_id() == 0 );
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
    clear_map_without_vision();
    const auto actor_id = bind_test_player( session ).getID();
    session.remote_connected = true;
    session.remote_admission = cata_mp::peer_admission::create( 202 );
    const auto previous = cata_mp::peer_admission::create( 202 );
    previous.retire();
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, "player", "", previous } );
    npc *actor = g->critter_by_id<npc>( actor_id );
    REQUIRE( actor );
    actor->name = "current owner";
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                    R"({"action":"worn_sync","char_stats":{"name":"foreign live admission"}})",
                                    cata_mp::peer_admission::create( 202 ) } );
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                    R"({"action":"worn_sync","char_stats":{"name":"stale action"}})", previous } );
    // Same display name, different transport peer. Exercise the real dispatch
    // path, not just the predicate: the disconnect must never reach despawn.
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 101 )} );
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 0 )} );
    cata_mp::process_mp_events();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( session.remote_connected );
    CHECK( session.remote_admission.peer_id() == 202 );
    CHECK( actor->name == "current owner" );
    CHECK( cata_mp::is_remote_player( actor_id ) );

    cata_mp::mp_on_world_exit();
    CHECK_FALSE( session.remote_connected );
    CHECK_FALSE( session.accepts_remote_event( cata_mp::peer_admission::create( 202 ) ) );
    CHECK_FALSE( session.remote_actor.id().is_valid() );
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
    clear_map_without_vision();
    bind_test_view( session );
    session.client_host_spawned = true;
    session.stale_proxy_cleanup_done = true;
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::disconnect, "player", "", cata_mp::peer_admission::create( 101 )} );
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
    CHECK_FALSE( session.client_host_actor.id().is_valid() );
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
    cata_mp::get_mp_queue().push( {cata_mp::mp_event::type::action, "", "current", cata_mp::peer_admission::create( 1 )} );
    CHECK( other.hosting.events().empty() );
    other.hosting.events().push( {cata_mp::mp_event::type::action, "", "other", cata_mp::peer_admission::create( 2 )} );

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

    other.hosting.events().push( {cata_mp::mp_event::type::action, "", "survivor", cata_mp::peer_admission::create( 2 )} );
    current.hosting.events().push( {cata_mp::mp_event::type::action, "", "retired", cata_mp::peer_admission::create( 1 )} );
    current.reset();
    CHECK( cata_mp::get_mp_queue().empty() );
    CHECK( cata_mp::mp_get_host_world_name().empty() );
    CHECK( cata_mp::mp_get_host_player_name().empty() );
    CHECK( cata_mp::mp_host_world_seed() == 0 );
    CHECK_FALSE( cata_mp::mp_host_omt_valid() );
    REQUIRE( other.hosting.events().pop( event ) );
    CHECK( event.data == "survivor" );
}

TEST_CASE( "mp_world_state_does_not_cross_owner_or_reload_boundaries",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &current = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        current.reset();
    } );
    current.reset();
    cata_mp::world_session other;
    const tripoint_abs_ms location( 4, 5, 0 );
    cata_mp::set_host_mode( true );
    current.replication.host.tile_baseline[location].ter = "t_wall";
    other.replication.host.tile_baseline[location].ter = "t_floor";
    current.replication.client.phantom_strikes["zombie@4,5,0"] = 2;
    current.replication.client.pending_omsync.emplace_back();
    current.client_turn.client_waiting_for_ack = true;
    current.client_turn.client_last_grant_seq = 41;
    current.peer.partner_activity = "ACT_CRAFT";
    current.peer.partner_activity_moves_total = 20000;
    current.peer.partner_activity_pct = 75;
    CHECK( cata_mp::partner_activity_accepts_help() );
    CHECK( cata_mp::partner_activity_pct() == 75 );
    CHECK_FALSE( other.host_mode );
    other.reset();
    CHECK( cata_mp::is_host_mode() );
    CHECK( current.replication.host.tile_baseline.at( location ).ter == "t_wall" );
    CHECK( current.replication.client.phantom_strikes.at( "zombie@4,5,0" ) == 2 );

    other.replication.host.tile_baseline[location].ter = "t_door_c";
    other.host_turn.grant_seq = 99;
    current.prepare_for_world_load();
    CHECK( cata_mp::is_host_mode() ); // Launch intent survives setup.
    CHECK( current.replication.host.tile_baseline.empty() );
    CHECK( current.replication.client.phantom_strikes.empty() );
    CHECK( current.replication.client.pending_omsync.empty() );
    CHECK_FALSE( current.client_turn.client_waiting_for_ack );
    CHECK( current.client_turn.client_last_grant_seq == 0 );
    CHECK( cata_mp::partner_activity_moves_total() == 0 );
    CHECK( cata_mp::partner_activity_pct() == 0 );
    CHECK( other.replication.host.tile_baseline.at( location ).ter == "t_door_c" );
    CHECK( other.host_turn.grant_seq == 99 );
    current.reset();
    CHECK_FALSE( cata_mp::is_host_mode() );
}

TEST_CASE( "mp_failed_admission_metadata_cannot_leak_into_another_world",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    auto &current = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        current.reset();
    } );
    cata_mp::set_client_mode( true );
    cata_mp::mp_store_pending_welcome(
        R"({"type":"welcome","world":"old world","host_name":"old host","seed":42,"host_omt":[3,4,0]})" );
    REQUIRE( cata_mp::mp_client_spawn_omt() == tripoint_abs_omt( 3, 4, 0 ) );
    // UI intent and a welcome string are insufficient: only a successful live
    // unjoined probe may retain its spawn metadata across production setup.
    REQUIRE_FALSE( current.client.pending_admission() );
    current.prepare_for_world_load();
    CHECK_FALSE( cata_mp::is_client_mode() );
    CHECK( cata_mp::mp_client_host_world_name().empty() );
    CHECK( cata_mp::mp_client_host_player_name().empty() );
    CHECK( cata_mp::mp_client_spawn_omt() == tripoint_abs_omt::invalid );
    CHECK( current.admission.pending_welcome.empty() );
}

TEST_CASE( "mp_client_body_updates_restart_in_a_new_world_at_the_same_time",
           "[multiplayer][world_session][lifecycle][regression]" )
{
    REQUIRE_FALSE( cata_mp::is_session_active() );
    const restore_on_out_of_scope restore_time( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    auto &session = g->multiplayer_session();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_avatar();
    } );
    clear_map_without_vision();
    const auto start_world = [&]() {
        session.reset();
        calendar::turn = calendar::turn_zero + 11_hours;
        clear_avatar();
        cata_mp::set_client_mode( true );
        avatar &player = get_avatar();
        player.set_stamina( player.get_stamina_max() / 2 );
        calendar::turn += 1_turns;
        return player.get_stamina();
    };
    const int first_initial = start_world();
    cata_mp::mp_do_turn_update_body( get_avatar() );
    const int first_updated = get_avatar().get_stamina();
    REQUIRE( first_updated > first_initial );
    cata_mp::mp_do_turn_update_body( get_avatar() );
    CHECK( get_avatar().get_stamina() == first_updated );

    const int second_initial = start_world();
    cata_mp::mp_do_turn_update_body( get_avatar() );
    CHECK( get_avatar().get_stamina() > second_initial );
}
