#include <string>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_catch.h"
#include "construction.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "game_constants.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const construction_str_id construction_constr_open_air( "constr_open_air" );
static const ter_str_id ter_t_open_air( "t_open_air" );
static const ter_str_id ter_t_pit( "t_pit" );
static const ter_str_id ter_t_rock( "t_rock" );
static const ter_str_id ter_t_wall( "t_wall" );

static void complete_pit_excavation( const tripoint_bub_ms &pit )
{
    map &here = get_map();
    partial_con partial;
    partial.id = construction_constr_open_air.id();
    here.partial_con_set( pit, partial );
    build_construction_activity_actor actor( here.get_abs( pit ) );
    player_activity activity;
    actor.complete_construction( activity, get_avatar() );
}

TEST_CASE( "excavated_pits_have_a_floor_for_falling_items_and_monsters",
           "[construction][pit_excavation][zlevel]" )
{
    clear_avatar();
    clear_map( -2, 0 );
    map &here = get_map();
    const tripoint_bub_ms pit( 61, 60, 0 );
    const tripoint_bub_ms below = pit + tripoint::below;
    const std::string material = GENERATE( "t_soil", "t_rock" );
    CAPTURE( material );
    get_avatar().setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    here.ter_set( pit, ter_t_pit );
    // Surround the landing tile with solid terrain so a failed placement
    // cannot silently spill the item into a neighboring room.
    for( const tripoint_bub_ms &p : here.points_in_radius( below, 2 ) ) {
        here.ter_set( p, ter_t_rock );
    }
    here.ter_set( below, ter_str_id( material ) );
    REQUIRE( can_construct( construction_constr_open_air.obj(), pit ) );
    complete_pit_excavation( pit );
    CHECK( here.ter( pit ) == ter_t_open_air );
    CHECK( here.ter( below ) == ter_str_id( material == "t_soil" ? "t_dirt" :
                                            "t_rock_floor_no_roof" ) );
    CHECK( here.passable( below ) );
    CHECK( here.has_floor( below ) );
    CHECK( here.ter( below + tripoint::east ) == ter_t_rock );

    SECTION( "items remain on the accessible pit floor" ) {
        here.add_item_or_charges( pit, item( itype_id( "rock" ) ) );
        REQUIRE( here.i_at( pit ).size() == 1 );
        here.process_falling();
        CHECK( here.i_at( pit ).empty() );
        REQUIRE( here.i_at( below ).size() == 1 );
        CHECK( here.i_at( below ).only_item().typeId() == itype_id( "rock" ) );
    }
    SECTION( "monsters land in the excavated space" ) {
        monster &zombie = spawn_test_monster( "mon_zombie", pit );
        zombie.gravity_check( &here );
        CHECK( zombie.pos_bub( here ) == below );
        CHECK_FALSE( zombie.is_dead() );
        CHECK( get_creature_tracker().creature_at<monster>( below ) == &zombie );
        CHECK( here.passable( zombie.pos_bub( here ) ) );
    }
}

TEST_CASE( "pit_excavation_preserves_existing_lower_terrain",
           "[construction][pit_excavation][zlevel]" )
{
    clear_avatar();
    clear_map( -2, 0 );
    map &here = get_map();
    const tripoint_bub_ms pit( 61, 60, 0 );
    const tripoint_bub_ms below = pit + tripoint::below;
    get_avatar().setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
    const std::string terrain = GENERATE( "t_floor", "t_rock_floor", "t_open_air",
                                          "t_water_dp", "t_lava" );
    CAPTURE( terrain );
    const ter_str_id original( terrain );
    here.ter_set( pit, ter_t_pit );
    here.ter_set( below, original );
    REQUIRE( can_construct( construction_constr_open_air.obj(), pit ) );
    complete_pit_excavation( pit );
    CHECK( here.ter( pit ) == ter_t_open_air );
    CHECK( here.ter( below ) == original );
}

TEST_CASE( "pit_excavation_rejects_blocked_or_missing_lower_levels",
           "[construction][pit_excavation][zlevel]" )
{
    clear_avatar();
    clear_map( -2, 0 );
    map &here = get_map();
    const tripoint_bub_ms pit( 61, 60, 0 );
    const tripoint_bub_ms below = pit + tripoint::below;
    here.ter_set( pit, ter_t_pit );
    here.ter_set( below, ter_t_wall );
    CHECK_FALSE( can_construct( construction_constr_open_air.obj(), pit ) );

    // Also check completion: the terrain may have changed since work began.
    complete_pit_excavation( pit );
    CHECK( here.ter( pit ) == ter_t_pit );
    CHECK( here.ter( below ) == ter_t_wall );

    const tripoint_bub_ms bottom( pit.xy(), -OVERMAP_DEPTH );
    here.ter_set( bottom, ter_t_pit );
    CHECK_FALSE( can_construct( construction_constr_open_air.obj(), bottom ) );
}
