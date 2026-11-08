#include <functional>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers_tests.h"
#include "map_helpers.h"
#include "mission.h"
#include "monster.h"
#include "mongroup.h"
#include "mtype.h"
#include "mp_client_conn.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "overmap.h"
#include "overmap_test_helpers.h"
#include "overmapbuffer.h"
#include "rng.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const itype_id itype_test_rock( "test_rock" );

static const mission_type_id mission_TEST_MISSION_FIND_ITEM( "TEST_MISSION_FIND_ITEM" );
static const mission_type_id mission_TEST_MISSION_GENERIC_REWARD( "TEST_MISSION_GENERIC_REWARD" );
static const mission_type_id mission_TEST_MISSION_GOAL_CONDITION1( "TEST_MISSION_GOAL_CONDITION1" );
static const mission_type_id mission_TEST_MISSION_GOAL_CONDITION2( "TEST_MISSION_GOAL_CONDITION2" );

static const morale_type morale_feeling_good( "morale_feeling_good" );

static const npc_template_id npc_template_test_talker( "test_talker" );

TEST_CASE( "mission_generic_reward_claim_persists_across_copy_and_save",
           "[mission][serialization]" )
{
    mission::clear_all();
    mission *original = mission::reserve_new(
                            mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    REQUIRE( original != nullptr );
    CHECK_FALSE( original->generic_reward_claimed() );

    original->commit_generic_reward_claim();
    CHECK( original->generic_reward_claimed() );
    const mission copied = *original;
    CHECK( copied.generic_reward_claimed() );

    std::ostringstream serialized;
    JsonOut json( serialized );
    original->serialize( json );
    JsonObject saved = json_loader::from_string( serialized.str() );
    mission loaded;
    loaded.deserialize( saved );
    CHECK( loaded.generic_reward_claimed() );

    JsonObject legacy = json_loader::from_string(
                            R"({
  "type_id": "TEST_MISSION_GENERIC_REWARD",
  "target": [ 0, 0, 0 ]
})" );
    loaded.deserialize( legacy );
    CHECK_FALSE( loaded.generic_reward_claimed() );
    mission::clear_all();
}

TEST_CASE( "mission_goal_condition_test", "[mission]" )
{
    avatar &u = get_avatar();
    clear_character( u, true );
    u.reset_all_missions();
    mission::clear_all();
    clear_npcs();

    GIVEN( "no_npc" ) {
        WHEN( "mission_origin_start" ) {
            mission *m = mission::reserve_new( mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
            if( m->get_assigned_player_id() == u.getID() ) {
                // Due to some bizarre optimization, test binaries compiled with
                // RELEASE=1 and LTO=1 result in u.getID() == character_id( -1 ).
                // So set the mission's initial player_id to something else.
                m->set_assigned_player_id( character_id( -2 ) );
            }
            m->assign( u );
            WHEN( "condition_not_met" ) {
                REQUIRE( !u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_not_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                }
            }
            WHEN( "condition_met" ) {
                item rock( itype_test_rock );
                u.wield( rock );
                REQUIRE( u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == false );
                    CHECK( u.get_completed_missions().front()->mission_id() == mission_TEST_MISSION_GOAL_CONDITION1 );
                    CHECK( u.has_morale( morale_feeling_good ) == 10 );
                }
            }
        }
        WHEN( "mission_no_origin" ) {
            mission *m = mission::reserve_new( mission_TEST_MISSION_GOAL_CONDITION2, character_id() );
            if( m->get_assigned_player_id() == u.getID() ) {
                m->set_assigned_player_id( character_id( -2 ) );
            }
            m->assign( u );
            WHEN( "condition_not_met" ) {
                REQUIRE( !u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_not_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                }
            }
            WHEN( "condition_met" ) {
                item rock( itype_test_rock );
                u.wield( rock );
                REQUIRE( u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_not_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                }
            }
        }
    }

    GIVEN( "with_npc" ) {
        const character_id guy_id = get_map().place_npc( point_bub_ms( 25, 25 ), npc_template_test_talker );
        g->load_npcs();
        WHEN( "mission_origin_start" ) {
            mission *m = mission::reserve_new( mission_TEST_MISSION_GOAL_CONDITION1, guy_id );
            if( m->get_assigned_player_id() == u.getID() ) {
                m->set_assigned_player_id( character_id( -2 ) );
            }
            m->assign( u );
            WHEN( "condition_not_met" ) {
                REQUIRE( !u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_not_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( !u.get_active_mission()->is_complete( guy_id ) );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                }
            }
            WHEN( "condition_met" ) {
                item rock( itype_test_rock );
                u.wield( rock );
                REQUIRE( u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_active_mission()->is_complete( guy_id ) );
                    u.get_active_mission()->wrap_up();
                    CHECK( u.get_completed_missions().empty() == false );
                    CHECK( u.get_completed_missions().front()->mission_id() == mission_TEST_MISSION_GOAL_CONDITION1 );
                    CHECK( u.has_morale( morale_feeling_good ) == 10 );
                }
            }
        }
        WHEN( "mission_no_origin" ) {
            mission *m = mission::reserve_new( mission_TEST_MISSION_GOAL_CONDITION2, guy_id );
            if( m->get_assigned_player_id() == u.getID() ) {
                m->set_assigned_player_id( character_id( -2 ) );
            }
            m->assign( u );
            WHEN( "condition_not_met" ) {
                REQUIRE( !u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_not_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( !u.get_active_mission()->is_complete( guy_id ) );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                }
            }
            WHEN( "condition_met" ) {
                item rock( itype_test_rock );
                u.wield( rock );
                REQUIRE( u.has_item_with( []( const item & it ) {
                    return it.typeId() == itype_test_rock;
                } ) );
                THEN( "mission_complete" ) {
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_completed_missions().empty() == true );
                    u.get_active_mission()->process();
                    CHECK( u.get_completed_missions().empty() == true );
                    CHECK( u.has_morale( morale_feeling_good ) == 0 );
                    CHECK( u.get_active_mission()->is_complete( guy_id ) );
                    u.get_active_mission()->wrap_up();
                    CHECK( u.get_completed_missions().empty() == false );
                    CHECK( u.get_completed_missions().front()->mission_id() == mission_TEST_MISSION_GOAL_CONDITION2 );
                    CHECK( u.has_morale( morale_feeling_good ) == 10 );
                }
            }
        }
    }
}

namespace
{

mission *assign_test_find_item_mission( avatar &dude )
{
    mission *m = mission::reserve_new( mission_TEST_MISSION_FIND_ITEM, character_id() );
    if( m->get_assigned_player_id() == dude.getID() ) {
        m->set_assigned_player_id( character_id( -2 ) );
    }
    m->assign( dude );
    return m;
}

} // namespace

TEST_CASE( "automatic_find_item_mission_batch_processing", "[mission]" )
{
    avatar &dude = get_avatar();
    map &here = get_map();
    clear_character( dude, true );
    dude.reset_all_missions();
    mission::clear_all();
    clear_map();

    SECTION( "missing item does not complete the mission" ) {
        const mission *m = assign_test_find_item_mission( dude );
        mission::process_all();
        CHECK( m->in_progress() );
    }

    SECTION( "item in character inventory completes the mission" ) {
        const mission *m = assign_test_find_item_mission( dude );
        item rock( itype_test_rock );
        dude.wield( rock );
        mission::process_all();
        CHECK_FALSE( m->in_progress() );
    }

    SECTION( "nearby item completes the mission" ) {
        const mission *m = assign_test_find_item_mission( dude );
        here.add_item( dude.pos_bub() + tripoint_rel_ms::east, item( itype_test_rock ) );
        mission::process_all();
        CHECK_FALSE( m->in_progress() );
    }

    SECTION( "one item cannot complete two missions" ) {
        const mission *first = assign_test_find_item_mission( dude );
        const mission *second = assign_test_find_item_mission( dude );
        item rock( itype_test_rock );
        dude.wield( rock );
        mission::process_all();
        CHECK( first->in_progress() != second->in_progress() );
    }
}

TEST_CASE( "automatic_find_item_mission_batch_performance", "[.][performance][mission]" )
{
    avatar &dude = get_avatar();
    clear_character( dude, true );
    dude.reset_all_missions();
    mission::clear_all();
    clear_map();

    for( int i = 0; i < 100; ++i ) {
        assign_test_find_item_mission( dude );
    }

    BENCHMARK( "missing find-item mission" ) {
        mission::process_all();
    };

    SUCCEED();
}

TEST_CASE( "npc_characters_keep_independent_mission_ledgers", "[mission][multiplayer]" )
{
    clear_avatar();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
    } );
    npc remote;
    remote.setID( character_id( 700010 ) );
    mission *host_task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    mission *remote_task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    host_task->set_assigned_player_id( host.getID() );
    remote_task->set_assigned_player_id( remote.getID() );
    host.on_mission_assignment( *host_task );
    remote.on_mission_assignment( *remote_task );

    // Duplicate or other-player notifications cannot add or remove entries.
    remote.on_mission_assignment( *remote_task );
    host.on_mission_assignment( *remote_task );
    host.on_mission_finished( *remote_task );
    CHECK( host.get_active_missions() == std::vector<mission *> { host_task } );
    CHECK( remote.get_active_missions() == std::vector<mission *> { remote_task } );
    CHECK( host.get_completed_missions().empty() );
    CHECK( host.get_active_mission() == host_task );
    CHECK( remote.get_active_mission() == remote_task );
    CHECK( remote.has_mission_id( mission_TEST_MISSION_GENERIC_REWARD ) );

    remote.reset_all_missions();
    CHECK( remote.get_active_missions().empty() );
    CHECK( remote.get_active_mission() == nullptr );
    CHECK( host.get_active_mission() == host_task );
}

TEST_CASE( "remote_character_missions_round_trip_without_replaying_effects",
           "[mission][save][multiplayer]" )
{
    clear_avatar();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
    } );
    npc remote;
    remote.setID( character_id( 700010 ) );
    mission *task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    task->set_assigned_player_id( remote.getID() );
    remote.on_mission_assignment( *task );
    std::ostringstream saved;
    JsonOut out( saved );
    remote.serialize( out );

    npc restored;
    const auto rng_before = rng_get_engine();
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    CHECK( restored.getID() == remote.getID() );
    CHECK( restored.get_active_missions() == std::vector<mission *> { task } );
    CHECK( restored.get_active_mission() == task );
    CHECK( restored.get_completed_missions().empty() );
    CHECK( rng_get_engine() == rng_before );
    CHECK( host.get_active_missions().empty() );

    // Reusing a native object for a different save must clear its old ledger.
    remote.reset_all_missions();
    std::ostringstream empty_save;
    JsonOut empty_out( empty_save );
    remote.serialize( empty_out );
    restored.deserialize( json_loader::from_string( empty_save.str() ).get_object() );
    CHECK( restored.get_active_missions().empty() );
    CHECK( restored.get_active_mission() == nullptr );
}

TEST_CASE( "saved_character_reconciles_a_failed_mission_once", "[mission][save][multiplayer]" )
{
    clear_avatar();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
    } );
    avatar owner;
    clear_character( owner, true );
    owner.setID( character_id( 700010 ), true );
    mission *task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    task->assign( owner );
    npc stored_owner;
    stored_owner.setID( owner.getID() );
    stored_owner.on_mission_assignment( *task );
    std::ostringstream saved;
    JsonOut out( saved );
    stored_owner.serialize( out );
    task->fail( owner );
    REQUIRE( task->has_failed() );
    REQUIRE( host.get_failed_missions().empty() );

    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    restored.on_mission_finished( *task );
    CHECK( restored.get_active_missions().empty() );
    CHECK( restored.get_active_mission() == nullptr );
    CHECK( restored.get_failed_missions() == std::vector<mission *> { task } );
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    CHECK( restored.get_failed_missions() == std::vector<mission *> { task } );
    CHECK( host.get_failed_missions().empty() );
}

TEST_CASE( "portable_character_import_cannot_replace_world_mission_ownership",
           "[mission][multiplayer]" )
{
    clear_avatar();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
    } );
    npc remote;
    clear_character( remote, true );
    remote.setID( character_id( 700010 ) );
    mission *host_task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    mission *remote_task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    host_task->set_assigned_player_id( host.getID() );
    remote_task->set_assigned_player_id( remote.getID() );
    host.on_mission_assignment( *host_task );
    remote.on_mission_assignment( *remote_task );
    std::ostringstream imported;
    JsonOut out( imported );
    host.store_player_state( out );
    remote.load_player_state( json_loader::from_string( imported.str() ).get_object() );
    CHECK( remote.getID() != host.getID() );
    CHECK( remote.get_active_missions() == std::vector<mission *> { remote_task } );
    CHECK( remote.get_active_mission() == remote_task );
    CHECK( host.get_active_missions() == std::vector<mission *> { host_task } );
}

TEST_CASE( "mission_goal_and_completion_effects_use_the_assigned_character",
           "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission *task = mission::reserve_new( mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    task->assign( remote );
    REQUIRE( task->get_assigned_player_id() == remote.getID() );
    remote.i_add( item( itype_test_rock ) );
    CHECK( task->is_complete( character_id(), remote ) );
    CHECK_FALSE( task->is_complete( character_id(), host ) );

    // An explicit wrong owner must not consume inputs or finish either ledger.
    task->wrap_up( host );
    task->fail( host );
    REQUIRE( task->in_progress() );
    REQUIRE( remote.get_active_mission() == task );
    CHECK( host.get_completed_missions().empty() );
    task->wrap_up( remote );
    CHECK( task->has_succeeded() );
    CHECK( remote.get_completed_missions() == std::vector<mission *> { task } );
    CHECK( remote.has_morale( morale_feeling_good ) == 10 );
    CHECK( host.has_morale( morale_feeling_good ) == 0 );
    task->wrap_up( remote );
    task->fail( remote );
    CHECK( task->has_succeeded() );
    CHECK( remote.get_completed_missions().size() == 1 );
    CHECK( remote.get_failed_missions().empty() );
    CHECK( remote.has_morale( morale_feeling_good ) == 10 );
}

TEST_CASE( "offline_mission_failure_runs_the_saved_owner_phase_once_after_return",
           "[mission][save][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_failure( definition.fail );
    const restore_on_out_of_scope restore_rewards( definition.likely_rewards );
    const JsonObject phase = json_loader::from_string( R"({
        "effect": { "u_add_morale": "morale_feeling_good", "bonus": -10, "max_bonus": -50,
                    "duration": "60 minutes", "decay_start": "60 minutes" }
    })" ).get_object();
    REQUIRE( definition.parse_funcs( phase, "test", definition.fail ) );
    mission *task = mission::reserve_new( definition.id, character_id() );
    task->assign( remote );
    const int id = task->get_id();
    const npc_lifetime retained = g->npc_lifetimes().track_active( remote );
    REQUIRE( retained.resolve( g->npc_lifetimes() ) == &remote );
    g->npc_lifetimes().retire( remote );
    task->fail();
    REQUIRE( task->has_failed() );
    CHECK( remote.has_morale( morale_feeling_good ) == 0 );
    CHECK( host.has_morale( morale_feeling_good ) == 0 );
    std::ostringstream saved;
    JsonOut out( saved );
    task->serialize( out );
    const JsonObject pending = json_loader::from_string( saved.str() ).get_object();
    pending.allow_omitted_members();
    CHECK( pending.get_bool( "failure_effects_pending" ) );
    mission restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    mission::add_existing( restored );
    task = mission::find( id );
    REQUIRE( task != nullptr );
    // Merely holding the unloaded native object must not authorize its effects.
    mission::process_all();
    CHECK( remote.has_morale( morale_feeling_good ) == 0 );
    g->npc_lifetimes().activate( remote );
    mission::process_all();
    CHECK( remote.has_morale( morale_feeling_good ) == -10 );
    CHECK( host.has_morale( morale_feeling_good ) == 0 );
    CHECK( remote.get_failed_missions() == std::vector<mission *> { task } );
    CHECK( host.get_failed_missions().empty() );
    mission::process_all();
    task->fail( remote );
    CHECK( remote.has_morale( morale_feeling_good ) == -10 );
    CHECK( remote.get_failed_missions().size() == 1 );
    std::ostringstream completed;
    JsonOut completed_out( completed );
    task->serialize( completed_out );
    const JsonObject done = json_loader::from_string( completed.str() ).get_object();
    done.allow_omitted_members();
    CHECK_FALSE( done.get_bool( "failure_effects_pending" ) );
}

TEST_CASE( "host_item_filter_does_not_hide_remote_mission_inputs", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    host.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission *host_task = assign_test_find_item_mission( host );
    mission *remote_task = mission::reserve_new( mission_TEST_MISSION_FIND_ITEM, character_id() );
    remote_task->assign( remote );
    remote.i_add( item( itype_test_rock ) );
    mission::process_all();
    CHECK( remote_task->has_succeeded() );
    CHECK( host_task->in_progress() );
    CHECK( remote.get_completed_missions() == std::vector<mission *> { remote_task } );
    CHECK( host.get_completed_missions().empty() );
}

TEST_CASE( "reentrant_mission_start_does_not_revive_or_reuse_a_finished_task",
           "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_start( definition.start );
    bool remove = false;
    SECTION( "completion_inside_start_stays_complete" ) {}
    SECTION( "removal_inside_start_does_not_dereference_the_removed_instance" ) {
        remove = true;
    }
    int starts = 0;
    definition.start = [&]( mission * task, Character & who ) {
        ++starts;
        CHECK( who.getID() == remote.getID() );
        if( remove ) {
            who.remove_active_mission( *task );
        } else {
            task->wrap_up( who );
        }
    };
    mission *task = mission::reserve_new( definition.id, character_id() );
    const int id = task->get_id();
    task->assign( remote );
    CHECK( starts == 1 );
    CHECK( remote.get_active_missions().empty() );
    if( remove ) {
        CHECK( mission::find( id, true ) == nullptr );
    } else {
        REQUIRE( mission::find( id ) == task );
        CHECK( task->has_succeeded() );
        CHECK( remote.has_morale( morale_feeling_good ) == 10 );
    }
    CHECK( host.has_morale( morale_feeling_good ) == 0 );
}

TEST_CASE( "mission_target_origin_comes_from_the_dialogue_character", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    REQUIRE( host.pos_abs_omt() != remote.pos_abs_omt() );
    dialogue conversation( get_talker_for( remote ), nullptr );
    const mission_target_params target;
    CHECK( mission_util::get_om_terrain_pos( target, conversation ) == remote.pos_abs_omt() );
    dialogue missing_owner;
    CHECK( mission_util::get_om_terrain_pos( target, missing_owner ).is_invalid() );
}

TEST_CASE( "character_death_releases_only_its_own_active_missions", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    clear_character( remote, true );
    const bool original_client = cata_mp::is_client_mode();
    cata_mp::set_client_mode( false );
    const on_out_of_scope cleanup( [&]() {
        cata_mp::set_client_mode( original_client );
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission *host_task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    mission *remote_task = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    host_task->assign( host );
    remote_task->assign( remote );
    const bool remote_dies = GENERATE( false, true );
    Character &dying = remote_dies ? static_cast<Character &>( remote ) : host;
    mission *finished = mission::reserve_new( mission_TEST_MISSION_GENERIC_REWARD, character_id() );
    finished->assign( dying );
    finished->wrap_up( dying );
    REQUIRE( finished->has_succeeded() );
    const bool replica = GENERATE( false, true );
    cata_mp::set_client_mode( replica );
    mission::on_creature_death( dying );
    CHECK( host_task->is_assigned() == ( replica || remote_dies ) );
    CHECK( remote_task->is_assigned() == ( replica || !remote_dies ) );
    CHECK( finished->get_assigned_player_id() == dying.getID() );
    CHECK( finished->has_succeeded() );
    CHECK( host_task->in_progress() );
    CHECK( remote_task->in_progress() );
}

TEST_CASE( "npc_death_callbacks_cannot_fail_replacement_missions", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &giver = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_failure( definition.fail );
    const restore_on_out_of_scope restore_goal( definition.goal );
    definition.goal = MGOAL_RECRUIT_NPC;
    std::vector<mission> replacements;
    for( int i = 0; i < 2; ++i ) {
        mission *task = mission::reserve_new( definition.id, giver.getID() );
        task->set_target_npc_id( giver.getID() );
        task->assign( host );
        replacements.push_back( *task );
    }
    int failures = 0;
    definition.fail = [&]( mission *, Character & who ) {
        CHECK( &who == &host );
        ++failures;
        who.reset_all_missions();
        mission::clear_all();
        // Same IDs and potentially reused addresses are different incarnations.
        for( const mission &replacement : replacements ) {
            mission::add_existing( replacement );
        }
        clear_npcs();
    };
    giver.die( &get_map(), nullptr );
    CHECK( failures == 1 );
    for( const mission &replacement : replacements ) {
        const mission *current = mission::find( replacement.get_id() );
        REQUIRE( current );
        CHECK( current->identity_generation() != replacement.identity_generation() );
        CHECK( current->in_progress() );
    }
}

TEST_CASE( "monster_mission_death_snapshot_survives_callback_removal", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        mission::clear_all();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_failure( definition.fail );
    const restore_on_out_of_scope restore_goal( definition.goal );
    definition.goal = MGOAL_FIND_MONSTER;
    std::unique_ptr<monster> target = std::make_unique<monster>( mtype_id( "mon_zombie" ) );
    std::vector<mission> replacements;
    for( int i = 0; i < 2; ++i ) {
        mission *task = mission::reserve_new( definition.id, character_id() );
        task->assign( host );
        target->mission_ids.insert( task->get_id() );
        replacements.push_back( *task );
    }
    const bool destroy_target = GENERATE( false, true );
    int failures = 0;
    definition.fail = [&]( mission *, Character & who ) {
        ++failures;
        REQUIRE( target );
        CHECK( target->mission_ids.size() == 2 );
        target->mission_ids.clear();
        who.reset_all_missions();
        mission::clear_all();
        for( const mission &replacement : replacements ) {
            mission::add_existing( replacement );
        }
        if( destroy_target ) {
            target.reset();
        }
    };
    mission::on_creature_death( *target );
    CHECK( failures == 1 );
    for( const mission &replacement : replacements ) {
        const mission *current = mission::find( replacement.get_id() );
        REQUIRE( current );
        CHECK( current->identity_generation() != replacement.identity_generation() );
        CHECK( current->in_progress() );
    }
}

TEST_CASE( "nemesis_hordes_persist_and_follow_their_own_quest_owner",
           "[mission][multiplayer][save]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_goal( definition.goal );
    definition.goal = MGOAL_KILL_NEMESIS;
    mission *host_task = mission::reserve_new( definition.id, character_id() );
    mission *remote_task = mission::reserve_new( definition.id, character_id() );
    host_task->assign( host );
    remote_task->assign( remote );
    auto region = std::make_unique<overmap>( point_abs_om::zero );
    overmap_test_helper::place_nemesis( *region, tripoint_abs_omt( 5, 5, 0 ), host_task->get_id() );
    overmap_test_helper::place_nemesis( *region, tripoint_abs_omt( 15, 15, 0 ), remote_task->get_id() );
    overmap_test_helper::place_nemesis( *region, tripoint_abs_omt( 25, 25, 0 ) );
    const tripoint_abs_sm host_position( 40, 40, 0 );
    const tripoint_abs_sm remote_position( 60, 60, 0 );
    overmap_test_helper::signal_nemesis( *region, host_position, host.getID() );
    overmap_test_helper::signal_nemesis( *region, remote_position, remote.getID() );
    REQUIRE( overmap_test_helper::groups( *region ).size() == 3 );
    for( const auto &entry : overmap_test_helper::groups( *region ) ) {
        const mongroup &group = entry.second;
        const bool is_remote = group.nemesis_mission_id == remote_task->get_id();
        CHECK( group.nemesis_target == ( is_remote ? remote_position.xy() : host_position.xy() ) );
        CHECK( group.nemesis_targets( remote.getID() ) == is_remote );
        CHECK( group.nemesis_targets( host.getID() ) == !is_remote );
        std::ostringstream saved;
        JsonOut out( saved );
        group.serialize( out );
        mongroup loaded;
        loaded.deserialize( json_loader::from_string( saved.str() ).get_object() );
        CHECK( loaded.nemesis_mission_id == group.nemesis_mission_id );
        CHECK( loaded.nemesis_targets( remote.getID() ) == is_remote );
        loaded.deserialize( json_loader::from_string(
                                R"({ "type": "GROUP_NEMESIS", "horde_behaviour": "nemesis" })" ).get_object() );
        CHECK( loaded.nemesis_mission_id == -1 );
        CHECK( loaded.nemesis_targets( host.getID() ) );
        CHECK_FALSE( loaded.nemesis_targets( remote.getID() ) );
    }

    // Guarantee each native movement decision succeeds, so this detects the
    // former first-group-only loop without a probabilistic retry test.
    mtype &walker = const_cast<mtype &>( mtype_id( "mon_zombie" ).obj() );
    const restore_on_out_of_scope restore_speed( walker.speed );
    walker.speed = 201;
    for( auto &entry : overmap_test_helper::groups( *region ) ) {
        mongroup &group = entry.second;
        group.monsters.emplace_back( walker.id );
        region->ter_set( project_to<coords::omt>( group.rel_pos() ), oter_str_id( "road_ns" ).id() );
    }
    overmap_test_helper::move_nemesis( *region );
    for( const auto &entry : overmap_test_helper::groups( *region ) ) {
        const mongroup &group = entry.second;
        if( group.nemesis_mission_id == host_task->get_id() ) {
            CHECK( group.abs_pos == tripoint_abs_sm( 11, 11, 0 ) );
        } else if( group.nemesis_mission_id == remote_task->get_id() ) {
            CHECK( group.abs_pos == tripoint_abs_sm( 31, 31, 0 ) );
        }
        CHECK( entry.first == group.rel_pos() );
    }
    CHECK( overmap_test_helper::remove_nemesis( *region, remote.getID() ) );
    REQUIRE( overmap_test_helper::groups( *region ).size() == 2 );
    for( const auto &entry : overmap_test_helper::groups( *region ) ) {
        CHECK_FALSE( entry.second.nemesis_targets( remote.getID() ) );
        CHECK( entry.second.nemesis_targets( host.getID() ) );
    }
    host_task->set_assigned_player_id( character_id() );
    overmap_test_helper::move_nemesis( *region );
    REQUIRE( overmap_test_helper::groups( *region ).size() == 1 );
    CHECK( overmap_test_helper::groups( *region ).begin()->second.nemesis_mission_id == -1 );
}

TEST_CASE( "nemesis_materialization_and_death_keep_the_assigned_player", "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    const on_out_of_scope cleanup( [&]() {
        overmap_buffer.remove_nemesis( remote.getID() );
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
        clear_map();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_goal( definition.goal );
    const restore_on_out_of_scope restore_kill_goal( definition.monster_kill_goal );
    definition.goal = MGOAL_KILL_NEMESIS;
    const bool recurring_offline = GENERATE( false, true );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_hours;
    definition.monster_kill_goal = recurring_offline ? 2 : 1;
    mission *host_task = mission::reserve_new( definition.id, character_id() );
    mission *remote_task = mission::reserve_new( definition.id, character_id() );
    host_task->assign( host );
    remote_task->assign( remote );
    const int remote_id = remote_task->get_id();
    mongroup group( mongroup_id( "GROUP_NEMESIS" ), tripoint_abs_sm::zero, 0 );
    group.horde = true;
    group.behaviour = mongroup::horde_behaviour::nemesis;
    group.nemesis_mission_id = remote_id;
    group.monsters.emplace_back( mtype_id( "mon_zombie_nemesis" ) );
    map_meddler::spawn_monsters_submap_group( get_map(), tripoint_rel_sm( 2, 2, 0 ), group, true );
    monster *spawned = nullptr;
    for( monster &candidate : g->all_monsters() ) {
        if( candidate.is_nemesis() && candidate.mission_ids.count( remote_id ) != 0 ) {
            REQUIRE( spawned == nullptr );
            spawned = &candidate;
        }
    }
    REQUIRE( spawned );
    monster dead = spawned->copy_for_persistence();
    const tripoint_abs_sm stored_at = project_to<coords::sm>( spawned->pos_abs_omt() );
    overmap_buffer.despawn_monster( *spawned );
    g->remove_zombie( *spawned );
    bool found_stored = false;
    for( const mongroup *stored : overmap_buffer.groups_at( stored_at ) ) {
        if( stored->nemesis_mission_id == remote_id ) {
            found_stored = true;
            CHECK( stored->nemesis_targets( remote.getID() ) );
            CHECK_FALSE( stored->nemesis_targets( host.getID() ) );
        }
    }
    REQUIRE( found_stored );
    overmap_buffer.remove_nemesis( remote.getID() );
    const npc_lifetime retained = g->npc_lifetimes().track_active( remote );
    REQUIRE( retained.resolve( g->npc_lifetimes() ) == &remote );
    if( recurring_offline ) {
        g->npc_lifetimes().retire( remote );
    }
    mission::on_creature_death( dead );
    CHECK_FALSE( host_task->is_complete( character_id(), host ) );
    if( recurring_offline ) {
        std::ostringstream saved;
        JsonOut out( saved );
        remote_task->serialize( out );
        const JsonObject object = json_loader::from_string( saved.str() ).get_object();
        CHECK( object.get_bool( "nemesis_respawn_pending" ) );
        mission restored;
        restored.deserialize( object );
        mission::add_existing( restored );
        remote_task = mission::find( remote_id );
        REQUIRE( remote_task );
        mission::process_all(); // The offline owner cannot spawn a host's pursuer.
        CHECK( remote_task->in_progress() );
        remote_task->set_deadline( calendar::turn - 1_turns );
        remote_task->process();
        CHECK( remote_task->has_failed() );
        std::ostringstream terminal;
        JsonOut terminal_out( terminal );
        remote_task->serialize( terminal_out );
        CHECK_FALSE( json_loader::from_string( terminal.str() ).get_object().get_bool(
                         "nemesis_respawn_pending" ) );
    } else {
        CHECK( remote_task->is_complete( character_id(), remote ) );
        // Only unbound old monsters use the legacy local mission association.
        monster legacy( mtype_id( "mon_zombie_nemesis" ) );
        mission::on_creature_death( legacy );
        CHECK( host_task->is_complete( character_id(), host ) );
    }
    remote_task->set_assigned_player_id( character_id() );
    overmap_buffer.despawn_monster( dead );
    for( const mongroup *stored : overmap_buffer.groups_at( stored_at ) ) {
        CHECK( stored->nemesis_mission_id != remote_id );
    }
    group.monsters.emplace_back( mtype_id( "mon_zombie_nemesis" ) );
    map_meddler::spawn_monsters_submap_group( get_map(), tripoint_rel_sm( 2, 2, 0 ), group, true );
    for( const monster &candidate : g->all_monsters() ) {
        CHECK( candidate.mission_ids.count( remote_id ) == 0 );
    }
}

TEST_CASE( "dead_mission_giver_still_runs_the_surviving_owners_failure_phase",
           "[mission][multiplayer]" )
{
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    host.reset_all_missions();
    mission::clear_all();
    npc &remote = spawn_npc( point_bub_ms( 25, 25 ), "test_talker" );
    npc &giver = spawn_npc( point_bub_ms( 28, 25 ), "test_talker" );
    clear_character( remote, true );
    const on_out_of_scope cleanup( [&]() {
        host.reset_all_missions();
        remote.reset_all_missions();
        mission::clear_all();
        clear_npcs();
    } );
    mission_type &definition = const_cast<mission_type &>( mission_TEST_MISSION_GENERIC_REWARD.obj() );
    const restore_on_out_of_scope restore_failure( definition.fail );
    const restore_on_out_of_scope restore_rewards( definition.likely_rewards );
    const JsonObject phase = json_loader::from_string( R"({
        "effect": { "u_add_morale": "morale_feeling_good", "bonus": -10, "max_bonus": -50,
                    "duration": "60 minutes", "decay_start": "60 minutes" }
    })" ).get_object();
    REQUIRE( definition.parse_funcs( phase, "test", definition.fail ) );
    mission *task = mission::reserve_new( definition.id, giver.getID() );
    task->assign( remote );
    giver.set_all_parts_hp_cur( 0 );
    giver.die( &get_map(), nullptr );
    REQUIRE( giver.is_dead() );
    CHECK( task->has_failed() );
    CHECK( remote.has_morale( morale_feeling_good ) == -10 );
    CHECK( host.has_morale( morale_feeling_good ) == 0 );
    CHECK( remote.get_failed_missions() == std::vector<mission *> { task } );
    task->process();
    CHECK( remote.has_morale( morale_feeling_good ) == -10 );
}
