#include <array>
#include <sstream>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "event.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "kill_statistics.h"
#include "kill_tracker.h"
#include "map.h"
#include "map_helpers.h"
#include "mission.h"
#include "mp_client_conn.h"
#include "npc.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

static const mtype_id mon_zombie( "mon_zombie" );
static const mission_type_id test_mission( "TEST_MISSION_GENERIC_REWARD" );

TEST_CASE( "kill_credit_separates_remote_players_from_native_followers", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    npc &follower = spawn_npc( point_bub_ms( 28, 25 ), "test_talker" );
    clear_character( remote, true );
    remote.setpos( get_map(), tripoint_bub_ms( 25, 25, 0 ) );
    clear_character( follower, true );
    follower.setpos( get_map(), tripoint_bub_ms( 28, 25, 0 ) );
    const restore_on_out_of_scope restore_followers( host.follower_ids );
    const bool previous_client = cata_mp::is_client_mode();
    cata_mp::set_client_mode( false );
    const on_out_of_scope cleanup( [&]() {
        cata_mp::set_client_mode( previous_client );
        host.get_kill_statistics().clear();
        clear_npcs();
    } );
    remote.set_value( "mp_proxy", "1" );
    g->add_npc_follower( remote.getID() );
    g->add_npc_follower( follower.getID() );
    host.get_kill_statistics().clear();
    const int host_xp = host.kill_xp;
    const int remote_xp = remote.kill_xp;
    const int follower_xp = follower.kill_xp;
    kill_tracker collector;
    for( Character *killer : std::array<Character *, 3> { &host, &remote, &follower } ) {
        collector.notify( cata::event::make<event_type::character_kills_monster>(
                              killer->getID(), mon_zombie, 17 ) );
    }
    CHECK( host.get_kill_statistics().kill_count( mon_zombie ) == 2 );
    CHECK( remote.get_kill_statistics().kill_count( mon_zombie ) == 1 );
    CHECK( follower.get_kill_statistics().kill_count( mon_zombie ) == 1 );
    CHECK( g->get_kill_tracker().monster_kill_count() == 2 );
    CHECK( host.kill_xp == host_xp + 17 );
    CHECK( remote.kill_xp == remote_xp + 17 );
    CHECK( follower.kill_xp == follower_xp + 17 );
    collector.notify( cata::event::make<event_type::character_kills_character>(
                          remote.getID(), character_id( 700019 ), std::string( "Victim" ),
                          std::string( "test_talker" ) ) );
    CHECK( remote.get_kill_statistics().npc_kill_count() == 1 );
    CHECK( host.get_kill_statistics().npc_kill_count() == 0 );
    CHECK( remote.kill_xp == remote_xp + 27 );
    cata_mp::set_client_mode( true );
    collector.notify( cata::event::make<event_type::character_kills_monster>(
                          host.getID(), mon_zombie, 17 ) );
    CHECK( host.get_kill_statistics().monster_kill_count() == 2 );
    CHECK( host.kill_xp == host_xp + 17 );
}

TEST_CASE( "kill_mission_thresholds_and_progress_use_the_assigned_character",
           "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( remote, true );
    remote.setpos( get_map(), tripoint_bub_ms( 25, 25, 0 ) );
    remote.set_value( "mp_proxy", "1" );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        host.get_kill_statistics().clear();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( test_mission.obj() );
    const restore_on_out_of_scope restore_goal( definition.goal );
    const restore_on_out_of_scope restore_count( definition.monster_kill_goal );
    const restore_on_out_of_scope restore_type( definition.monster_type );
    const restore_on_out_of_scope restore_species( definition.monster_species );
    definition.goal = GENERATE( MGOAL_KILL_MONSTER_TYPE, MGOAL_KILL_MONSTER_SPEC );
    definition.monster_kill_goal = 2;
    definition.monster_type = mon_zombie;
    definition.monster_species = species_id( "ZOMBIE" );
    host.get_kill_statistics().reset( { { mon_zombie, 7 } }, {} );
    remote.get_kill_statistics().reset( { { mon_zombie, 1 } }, {} );
    mission *host_task = mission::reserve_new( definition.id, character_id() );
    mission *remote_task = mission::reserve_new( definition.id, character_id() );
    host_task->assign( host );
    remote_task->assign( remote );
    kill_tracker collector;
    for( int i = 0; i < 2; ++i ) {
        collector.notify( cata::event::make<event_type::character_kills_monster>(
                              remote.getID(), mon_zombie, 0 ) );
    }
    CHECK( remote_task->is_complete( character_id(), remote ) );
    CHECK_FALSE( host_task->is_complete( character_id(), host ) );
    CHECK_FALSE( remote_task->is_complete( character_id(), host ) );
    CHECK( host.get_kill_statistics().kill_count( mon_zombie ) == 7 );
}

TEST_CASE( "kill_history_load_replaces_records_without_replaying_rewards", "[save][multiplayer]" )
{
    clear_avatar();
    clear_map();
    npc &owner = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( owner, true );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    owner.get_kill_statistics().reset( { { mon_zombie, 4 } }, { "One", "Two" } );
    owner.kill_xp = 45;
    std::ostringstream saved;
    JsonOut out( saved );
    owner.serialize( out );
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    CHECK( restored.get_kill_statistics().kill_count( mon_zombie ) == 4 );
    CHECK( restored.get_kill_statistics().npc_kill_count() == 2 );
    CHECK( restored.kill_xp == 45 );
    const auto rng_before = rng_get_engine();
    std::ostringstream portable;
    JsonOut portable_out( portable );
    owner.store_player_state( portable_out );
    restored.load_player_state( json_loader::from_string( portable.str() ).get_object() );
    CHECK( rng_get_engine() == rng_before );
    CHECK( restored.get_kill_statistics().kill_count( mon_zombie ) == 4 );
    CHECK( restored.kill_xp == 45 );
    kill_statistics old_save;
    const JsonObject legacy = json_loader::from_string(
                                  R"({ "kills": { "mon_zombie": 9 }, "npc_kills": [ "Legacy" ] })" ).get_object();
    old_save.deserialize( legacy );
    old_save.deserialize( legacy );
    CHECK( old_save.kill_count( mon_zombie ) == 9 );
    CHECK( old_save.npc_kill_count() == 1 );
    const auto revision = old_save.revision();
    CHECK_THROWS_AS( old_save.deserialize( json_loader::from_string(
            R"({ "kills": { "mon_zombie": 100 }, "npc_kills": 3 })" ).get_object() ), JsonError );
    CHECK( old_save.kill_count( mon_zombie ) == 9 );
    CHECK( old_save.revision() == revision );
}
