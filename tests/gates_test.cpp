#include <limits>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "avatar_action.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "gates.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "mp_gamestate.h"
#include "mp_queue.h"
#include "mp_world_session.h"
#include "npc.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "sounds.h"
#include "type_id.h"
#include "vehicle.h"
#include "vpart_position.h"

static const ter_str_id ter_t_door_c( "t_door_c" );
static const ter_str_id ter_t_door_locked( "t_door_locked" );
static const ter_str_id ter_t_door_o( "t_door_o" );
static const ter_str_id ter_t_window_no_curtains( "t_window_no_curtains" );
static const ter_str_id ter_t_window_no_curtains_open( "t_window_no_curtains_open" );

TEST_CASE( "doors_should_be_able_to_open_and_close", "[gates]" )
{
    map &here = get_map();
    clear_map_without_vision();

    tripoint_bub_ms pos = get_avatar().pos_bub() + point::east;

    WHEN( "the door is unlocked" ) {
        // create closed door on tile next to player
        REQUIRE( here.ter_set( pos, ter_t_door_c ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_c->id );

        THEN( "the door should be able to open and close" ) {
            CHECK( here.open_door( get_avatar(), pos, true, false ) );
            CHECK( here.ter( pos ).obj().id == ter_t_door_o->id );

            CHECK( here.close_door( pos, true, false ) );
            CHECK( here.ter( pos ).obj().id == ter_t_door_c->id );
        }
    }
    WHEN( "the door is locked" ) {
        // create locked door on tile next to player
        REQUIRE( here.ter_set( pos, ter_t_door_locked ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_locked->id );

        THEN( "the door should not be able to open" ) {
            CHECK_FALSE( here.close_door( pos, true, false ) );
            CHECK( here.ter( pos ).obj().id == ter_t_door_locked->id );
        }
    }
}

TEST_CASE( "windows_should_be_able_to_open_and_close", "[gates]" )
{
    map &here = get_map();
    clear_map_without_vision();

    tripoint_bub_ms pos = get_avatar().pos_bub() + point::east;

    // create closed window on tile next to player
    REQUIRE( here.ter_set( pos, ter_t_window_no_curtains ) );
    REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains->id );

    WHEN( "the window is opened from the inside" ) {
        THEN( "the window should be able to open" ) {
            CHECK( here.open_door( get_avatar(), pos, true, false ) );
            CHECK( here.ter( pos ).obj().id == ter_t_window_no_curtains_open->id );
        }
    }
    WHEN( "the window is opened from the outside" ) {
        THEN( "the window should not be able to open" ) {
            CHECK_FALSE( here.close_door( pos, false, false ) );
            CHECK( here.ter( pos ).obj().id == ter_t_window_no_curtains->id );
        }
    }
}

// Note that it is not intended for all doors and windows to make swish sound,
// some doors and windows might make other types of sounds in the future
// TODO: update test case when door and window sounds become defined in JSON.
TEST_CASE( "doors_and_windows_should_make_whoosh_sound", "[gates]" )
{
    map &here = get_map();
    clear_map_without_vision();
    clear_avatar();
    sounds::reset_sounds();

    tripoint_bub_ms pos = get_avatar().pos_bub() + point::east;

    WHEN( "the door is opened" ) {
        REQUIRE( here.ter_set( pos, ter_t_door_c ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_c->id );

        // make sure there is no sounds before action
        REQUIRE( sounds::get_monster_sounds().first.empty() );

        REQUIRE( here.open_door( get_avatar(), pos, true, false ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_o->id );

        THEN( "the door should make a swish sound" ) {
            CHECK_FALSE( sounds::get_monster_sounds().first.empty() );
        }
    }
    WHEN( "the door is closed" ) {
        REQUIRE( here.ter_set( pos, ter_t_door_o ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_o->id );

        // make sure there is no sounds before action
        REQUIRE( sounds::get_monster_sounds().first.empty() );

        REQUIRE( here.close_door( pos, true, false ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_c->id );

        THEN( "the door should make a swish sound" ) {
            CHECK_FALSE( sounds::get_monster_sounds().first.empty() );
        }
    }
    WHEN( "the window is opened" ) {
        REQUIRE( here.ter_set( pos, ter_t_window_no_curtains ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains->id );

        // make sure there is no sounds before action
        REQUIRE( sounds::get_monster_sounds().first.empty() );

        REQUIRE( here.open_door( get_avatar(), pos, true, false ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains_open->id );

        THEN( "the window should make a swish sound" ) {
            CHECK_FALSE( sounds::get_monster_sounds().first.empty() );
        }
    }
    WHEN( "the window is closed" ) {
        REQUIRE( here.ter_set( pos, ter_t_window_no_curtains_open ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains_open->id );

        // make sure there is no sounds before action
        REQUIRE( sounds::get_monster_sounds().first.empty() );

        REQUIRE( here.close_door( pos, true, false ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains->id );

        THEN( "the window should make a swish sound" ) {
            CHECK_FALSE( sounds::get_monster_sounds().first.empty() );
        }
    }
}

TEST_CASE( "character_should_lose_moves_when_opening_or_closing_doors_or_windows", "[gates]" )
{
    avatar &they = get_avatar();
    map &here = get_map();

    clear_avatar();
    clear_map_without_vision();

    tripoint_bub_ms pos = get_avatar().pos_bub() + point::east;

    // the movement cost for opening and closing gates
    // remember to update this if changing value in code
    const int open_move_cost = 100;

    // set move value to 0 so we know how many
    // move points were spent opening and closing gates
    they.set_moves( 0 );

    WHEN( "avatar opens door" ) {
        REQUIRE( here.ter_set( pos, ter_t_door_c ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_c->id );

        REQUIRE( avatar_action::move( they, here, tripoint_rel_ms::east ) );

        THEN( "avatar should spend move points" ) {
            CHECK( they.get_moves() == -open_move_cost );
        }
    }
    WHEN( "avatar fails to open locked door" ) {
        REQUIRE( here.ter_set( pos, ter_t_door_locked ) );
        REQUIRE( here.ter( pos ).obj().id == ter_t_door_locked->id );

        REQUIRE_FALSE( avatar_action::move( they, here, tripoint_rel_ms::east ) );

        THEN( "avatar should not spend move points" ) {
            CHECK( they.get_moves() == 0 );
        }
    }
    GIVEN( "that avatar is outdoors" ) {
        REQUIRE( here.is_outside( pos ) );

        WHEN( "avatar fails to open window" ) {
            REQUIRE( here.ter_set( pos, ter_t_window_no_curtains ) );
            REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains->id );

            REQUIRE_FALSE( avatar_action::move( they, here, tripoint_rel_ms::east ) );

            THEN( "avatar should spend move points" ) {
                CHECK( they.get_moves() == 0 );
            }
        }
    }
    GIVEN( "that avatar is indoors" ) {
        ter_id ter_flat_roof = ter_id( "t_flat_roof" );
        ter_id ter_concrete_floor = ter_id( "t_thconc_floor" );
        ter_id ter_concrete_wall = ter_id( "t_concrete_wall" );

        // enclose the player in single tile room surrounded with
        // concrete floor and roof to test opening windows from indoors
        const std::vector<tripoint_bub_ms> room_walls{
            pos + point::south_east,
            pos + point::south,
            pos + point::south_west,
            pos + point::west,
            pos + point::north_west,
            pos + point::north,
            pos + point::north_east
        };
        for( tripoint_bub_ms point : room_walls ) {
            REQUIRE( here.ter_set( point, ter_concrete_wall ) );
        }
        REQUIRE( here.ter_set( pos, ter_concrete_floor ) );
        REQUIRE( here.ter_set( pos + tripoint::above, ter_flat_roof ) );

        // mark map cache as dirty and rebuild it so that map starts
        // recognizing that tile player is standing on is indoors
        here.set_outside_cache_dirty( pos.z() );
        here.build_outside_cache( pos.z() );
        REQUIRE_FALSE( here.is_outside( pos ) );

        WHEN( "avatar opens window" ) {
            REQUIRE( here.ter_set( pos, ter_t_window_no_curtains ) );
            REQUIRE( here.ter( pos ).obj().id == ter_t_window_no_curtains->id );

            REQUIRE( avatar_action::move( they, here, tripoint_rel_ms::east ) );

            THEN( "avatar should spend move points" ) {
                CHECK( they.get_moves() == -open_move_cost );
            }
        }
    }
}

TEST_CASE( "synchronous_door_close_uses_the_actual_actor", "[gates][network]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    standard_npc remote;
    remote.setpos( here, you.pos_bub() );
    remote.set_moves( 1000 );
    you.set_moves( 2000 );
    const activity_id waiting( "ACT_WAIT" );
    remote.activity = player_activity( waiting, 500 );
    const tripoint_bub_ms target = you.pos_bub() + point::east;

    SECTION( "close completes without replacing a remote activity" ) {
        here.ter_set( target, ter_t_door_o );
        REQUIRE( close_tile_activity_actor::close_immediately( remote, target ) );
        CHECK( here.ter( target ) == ter_t_door_c );
        CHECK( remote.get_moves() == 910 );
    }
    SECTION( "an invalid target costs no moves" ) {
        here.ter_set( target, ter_t_door_c );
        CHECK_FALSE( close_tile_activity_actor::close_immediately( remote, target ) );
        CHECK( remote.get_moves() == 1000 );
    }
    CHECK( you.get_moves() == 2000 );
    CHECK( remote.activity.id() == waiting );
    CHECK( remote.activity.moves_left == 500 );
}

TEST_CASE( "shared_open_uses_actual_actor_and_charges_only_success",
           "[gates][open][network]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    standard_npc remote;
    remote.setpos( here, tripoint_bub_ms( 65, 60, 0 ) );
    Character &actor = GENERATE( false, true ) ? static_cast<Character &>( remote ) : you;
    const tripoint_bub_ms target = actor.pos_bub( here ) + point::east;
    you.set_moves( 2000 );
    remote.set_moves( 1000 );
    const int moves = actor.get_moves();
    const activity_id waiting( "ACT_WAIT" );
    actor.activity = player_activity( waiting, 500 );
    sounds::reset_sounds();

    SECTION( "a closed door opens once" ) {
        here.ter_set( target, ter_t_door_c );
        REQUIRE( doors::open_immediately( here, actor, target ) );
        CHECK( here.ter( target ) == ter_t_door_o );
        CHECK( actor.get_moves() == moves - 100 );
        CHECK( sounds::get_monster_sounds().first.size() == 1 );
        CHECK_FALSE( doors::open_immediately( here, actor, target ) );
        CHECK( actor.get_moves() == moves - 100 );
        CHECK( sounds::get_monster_sounds().first.size() == 1 );
    }
    SECTION( "locked door rejection is free" ) {
        here.ter_set( target, ter_t_door_locked );
        CHECK_FALSE( doors::open_immediately( here, actor, target ) );
        CHECK( here.ter( target ) == ter_t_door_locked );
        CHECK( actor.get_moves() == moves );
        CHECK( sounds::get_monster_sounds().first.empty() );
    }
    SECTION( "the actor must reach the target" ) {
        for( const tripoint_bub_ms rejected : {
                 actor.pos_bub( here ) + tripoint_rel_ms( 2, 0, 0 ),
                 actor.pos_bub( here ) + tripoint_rel_ms( 0, 0, 1 )
             } ) {
            here.ter_set( rejected, ter_t_door_c );
            CHECK_FALSE( doors::open_immediately( here, actor, rejected ) );
            CHECK( here.ter( rejected ) == ter_t_door_c );
        }
        CHECK_FALSE( doors::open_immediately( here, actor, tripoint_bub_ms( -1, -1, 0 ) ) );
        CHECK( actor.get_moves() == moves );
        CHECK( sounds::get_monster_sounds().first.empty() );
    }
    SECTION( "outside actors cannot open inside-only windows" ) {
        here.ter_set( target, ter_t_window_no_curtains );
        REQUIRE( here.is_outside( actor.pos_bub( here ) ) );
        CHECK_FALSE( doors::open_immediately( here, actor, target ) );
        CHECK( here.ter( target ) == ter_t_window_no_curtains );
        CHECK( actor.get_moves() == moves );
        CHECK( sounds::get_monster_sounds().first.empty() );
    }
    if( &actor == &remote ) {
        CHECK( you.get_moves() == 2000 );
    } else {
        CHECK( remote.get_moves() == 1000 );
    }
    CHECK( actor.activity.id() == waiting );
    CHECK( actor.activity.moves_left == 500 );
    sounds::reset_sounds();
}

TEST_CASE( "open_activity_keeps_delayed_settlement_and_rechecks_target",
           "[gates][open][activity]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_bub_ms target = you.pos_bub( here ) + point::east;
    here.ter_set( target, ter_t_door_c );
    you.set_moves( 100 );
    you.assign_activity( open_tile_activity_actor( target ) );
    REQUIRE_FALSE( you.activity.is_null() );
    REQUIRE( you.activity.moves_total == 100 );
    REQUIRE( here.ter( target ) == ter_t_door_c );
    REQUIRE( you.get_moves() == 100 );

    if( GENERATE( false, true ) ) {
        std::ostringstream saved;
        JsonOut output( saved );
        you.activity.serialize( output );
        you.activity.set_to_null();
        you.activity.deserialize( json_loader::from_string( saved.str() ).get_object() );
        REQUIRE( you.activity.id() == activity_id( "ACT_OPEN_TILE" ) );
        REQUIRE( you.activity.moves_total == 100 );
        REQUIRE( you.activity.moves_left == 100 );
        REQUIRE( here.ter( target ) == ter_t_door_c );
        REQUIRE( you.get_moves() == 100 );
    }

    SECTION( "normal activity completes through the production activity driver" ) {
        you.activity.do_turn( you );
        CHECK( here.ter( target ) == ter_t_door_o );
        CHECK( you.get_moves() == 0 );
        CHECK( you.activity.is_null() );
    }
    SECTION( "another actor locks the door before completion" ) {
        here.ter_set( target, ter_t_door_locked );
        you.activity.do_turn( you );
        CHECK( here.ter( target ) == ter_t_door_locked );
        CHECK( you.activity.is_null() );
    }
    SECTION( "the actor moved away before completion" ) {
        you.setpos( here, tripoint_bub_ms( 65, 60, 0 ) );
        you.activity.do_turn( you );
        CHECK( here.ter( target ) == ter_t_door_c );
        CHECK( you.activity.is_null() );
    }
}

TEST_CASE( "shared_vehicle_open_checks_live_parts_and_inside_access",
           "[gates][open][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_vehicles();
    map &here = get_map();
    avatar &you = get_avatar();
    you.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const tripoint_bub_ms target = you.pos_bub( here ) + point::east;
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), target, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const int part = veh->install_part( here, point_rel_ms::zero, vpart_id( "aisle_curtain" ) );
    REQUIRE( part >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    you.set_moves( 1000 );
    REQUIRE_FALSE( veh->part( part ).open );

    SECTION( "curtain cannot open from outside" ) {
        CHECK_FALSE( doors::open_immediately( here, you, target ) );
        CHECK_FALSE( veh->part( part ).open );
        CHECK( you.get_moves() == 1000 );
    }
    SECTION( "curtain opens from the vehicle tile" ) {
        you.setpos( here, target );
        REQUIRE( doors::open_immediately( here, you, target ) );
        CHECK( veh->part( part ).open );
        CHECK( you.get_moves() == 900 );
    }
    SECTION( "incorporeal actors cannot bypass the terrain interaction restriction" ) {
        you.setpos( here, target );
        you.add_effect( efftype_id( "incorporeal" ), 1_minutes );
        CHECK_FALSE( doors::open_immediately( here, you, target ) );
        CHECK_FALSE( veh->part( part ).open );
        CHECK( you.get_moves() == 1000 );
    }
    SECTION( "invalid saved part index never gets dereferenced" ) {
        you.setpos( here, target );
        doors::opening started = doors::begin_open( here, you, target );
        REQUIRE( started.result == open_tile_result::OPEN_VEHICLE_SINGLE );
        started.vehicle_part = std::numeric_limits<int>::max();
        CHECK_FALSE( doors::finish_open( here, you, target, started ) );
        CHECK_FALSE( veh->part( part ).open );
    }
    SECTION( "removed part cannot be opened through an old activity" ) {
        you.setpos( here, target );
        const doors::opening started = doors::begin_open( here, you, target );
        REQUIRE( started.result == open_tile_result::OPEN_VEHICLE_SINGLE );
        veh->remove_part( veh->part( part ) );
        veh->part_removal_cleanup( here );
        CHECK_FALSE( doors::finish_open( here, you, target, started ) );
    }
    clear_vehicles();
}

TEST_CASE( "door_intents_ignore_attached_client_mutations", "[gates][multiplayer][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    auto &session = g->multiplayer_session();
    session.reset();
    const on_out_of_scope cleanup( [&]() {
        session.reset();
        clear_npcs();
        cata_mp::get_mp_queue().clear();
    } );
    npc &remote = spawn_npc( { 60, 60 }, "test_talker" );
    const cata_mp::player_id player( std::string( 32, 'd' ) );
    remote.set_value( "mp_proxy", std::string( "1" ) );
    remote.set_value( "mp_player_id", player.str() );
    session.remote_actor.bind_player( remote, player, g->npc_lifetimes(),
                                      g->player_controls().claim( player, remote ) );
    session.remote_connected = true;
    session.remote_admission = cata_mp::peer_admission::create( 702 );
    session.host_turn.remote_moves = 100;
    map &here = get_map();
    const bool opening = GENERATE( true, false );
    const bool reachable = GENERATE( true, false );
    const tripoint_bub_ms target = remote.pos_bub( here ) + tripoint( reachable ? 1 : 5, 0, 0 );
    const tripoint_abs_ms absolute = here.get_abs( target );
    const ter_str_id before = opening ? ter_t_door_c : ter_t_door_o;
    here.ter_set( target, before );
    const auto name = remote.name;
    const auto position = remote.pos_abs();
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "action" );
    out.member( "action", opening ? "open" : "close" );
    out.member( "x", absolute.x() );
    out.member( "y", absolute.y() );
    out.member( "z", absolute.z() );
    out.member( "char_stats" );
    out.start_object();
    out.member( "name", "forged" );
    out.end_object();
    out.member( "nested" );
    out.start_object();
    out.member( "type", "trade_delta" );
    out.end_object();
    out.member( "client_tile_changes" );
    out.start_array();
    out.start_object();
    out.member( "x", absolute.x() );
    out.member( "y", absolute.y() );
    out.member( "z", absolute.z() );
    out.member( "ter", "t_wall" );
    out.end_object();
    out.end_array();
    out.end_object();
    REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player",
                                           text.str(), session.remote_admission } ) );
    cata_mp::process_mp_events();
    const ter_str_id expected = reachable ? ( opening ? ter_t_door_o : ter_t_door_c ) : before;
    CHECK( here.ter( target ) == expected );
    CHECK( remote.name == name );
    CHECK( remote.pos_abs() == position );
    CHECK( session.host_turn.client_acted_this_turn );
    CHECK( session.host_turn.remote_moves == 0 );
}
