#include <map>
#include <string>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_catch.h"
#include "construction.h"
#include "coordinates.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "requirements.h"
#include "type_id.h"

static const construction_str_id construction_constr_metal_gangway( "constr_metal_gangway" );
static const itype_id itype_2x4( "2x4" );
static const itype_id itype_nail( "nail" );
static const itype_id itype_splinter( "splinter" );
static const itype_id itype_steel_plate( "steel_plate" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_open_air( "t_open_air" );

TEST_CASE( "gangways_have_working_deconstruction_recipes", "[construction][gangway]" )
{
    const bool metal = GENERATE( false, true );
    CAPTURE( metal );
    clear_avatar();
    clear_map( -2, 1 );
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms standing( 60, 60, 1 );
    const tripoint_bub_ms bridge( 61, 60, 1 );
    here.ter_set( standing, ter_t_floor );
    you.setpos( here, standing );
    const construction_str_id id( metal ? "constr_remove_st_gangway" : "constr_remove_wd_gangway" );
    REQUIRE( id.is_valid() );
    const construction &con = id.obj();
    CHECK( con.group == construction_group_str_id( metal ? "remove_metal_floor" : "remove_floor" ) );
    CHECK( con.time == 180000 );
    CHECK( con.requirements.is_valid() );
    here.ter_set( bridge, ter_t_floor );
    CHECK_FALSE( can_construct( con, bridge ) );
    here.ter_set( bridge, ter_str_id( metal ? "t_floor_metal_gangway" : "t_floor_wooden_gangway" ) );
    REQUIRE( can_construct( con, bridge ) );
    partial_con partial;
    partial.id = id.id();
    here.partial_con_set( bridge, partial );
    build_construction_activity_actor actor( here.get_abs( bridge ) );
    player_activity activity;
    actor.complete_construction( activity, you );
    CHECK( here.ter( bridge ) == ter_t_open_air );
    CHECK( here.partial_con_at( bridge ) == nullptr );
    CHECK( here.ter( standing ) == ter_t_floor );
    CHECK( you.pos_bub() == standing );
    CHECK_FALSE( can_construct( con, bridge ) );

    std::map<itype_id, int> salvage;
    for( const item &it : here.i_at( standing ) ) {
        salvage[it.typeId()] += it.count_by_charges() ? it.charges : 1;
    }
    if( metal ) {
        const construction &build = construction_constr_metal_gangway.obj();
        const auto &components = build.requirements->get_components();
        REQUIRE( components.size() == 1 );
        REQUIRE( components.front().size() == 1 );
        CHECK( components.front().front().type == itype_steel_plate );
        CHECK( components.front().front().count == 2 );
        CHECK( salvage[itype_steel_plate] >= 1 );
        CHECK( salvage[itype_steel_plate] <= components.front().front().count );
        CHECK( item( itype_steel_plate ).weight() * salvage[itype_steel_plate] <=
               item( itype_steel_plate ).weight() * 2 );
        CHECK( salvage.size() == 1 );
    } else {
        CHECK( salvage[itype_splinter] >= 2 );
        CHECK( salvage[itype_splinter] <= 32 );
        CHECK( salvage[itype_2x4] <= 8 );
        CHECK( salvage[itype_nail] >= 5 );
        CHECK( salvage[itype_nail] <= 10 );
    }
}
