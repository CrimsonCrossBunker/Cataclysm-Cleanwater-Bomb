#include <algorithm>
#include <functional>
#include <string>
#include <utility>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "current_map.h"
#include "debug.h"
#include "item.h"
#include "map.h"
#include "pocket_type.h"
#include "point.h"
#include "scenario.h"
#include "start_location.h"
#include "type_id.h"

static const itype_id itype_jeans( "jeans" );
static const start_location_id start_location_sloc_ocean_shore( "sloc_ocean_shore" );
static const string_id<scenario> scenario_beach_day( "beach_day" );
static const ter_str_id ter_t_floor( "t_floor" );

TEST_CASE( "Test_origin_offset" )
{
    const point_rel_om &offset = scenario_beach_day.obj().get_origin_offset();
    const start_location &beach = start_location_sloc_ocean_shore.obj();
    const point_abs_om origin = point_abs_om::zero + offset;

    tripoint_abs_omt omtstart = tripoint_abs_omt::invalid;

    auto ret = beach.find_player_initial_location( origin );
    omtstart = ret.first;

    CHECK( !omtstart.is_invalid() );
}

TEST_CASE( "start_location_prepare_map_spills_decayed_corpse_contents_onto_tinymap",
           "[start_location][map]" )
{
    const time_point old_turn = calendar::turn;
    const on_out_of_scope restore_turn( [old_turn]() {
        calendar::turn = old_turn;
    } );
    calendar::turn = calendar::start_of_cataclysm;

    const tripoint_abs_omt omtstart( 10, 10, 0 );
    const tripoint_omt_ms corpse_pos( 9, 14, 0 );

    {
        tinymap setup_map;
        setup_map.load( omtstart, false );
        setup_map.ter_set( corpse_pos, ter_t_floor );
        setup_map.furn_set( corpse_pos, furn_str_id::NULL_ID() );
        setup_map.i_clear( corpse_pos );

        item corpse = item::make_corpse( mtype_id::NULL_ID(), calendar::start_of_cataclysm );
        corpse.force_insert_item( item( itype_jeans, calendar::start_of_cataclysm ),
                                  pocket_type::CONTAINER );
        setup_map.add_item( corpse_pos, corpse );
        setup_map.save();
    }

    calendar::turn = calendar::start_of_cataclysm + 365_days;

    map unloaded_main_map;
    swap_map swap_unloaded( unloaded_main_map );

    const std::string err = capture_debugmsg_during( [&]() {
        start_location_sloc_ocean_shore.obj().prepare_map( omtstart );
    } );
    CHECK( err.empty() );

    tinymap verify_map;
    verify_map.load( omtstart, false );
    const map_stack items = verify_map.i_at( corpse_pos );
    const bool has_spilled_jeans = std::any_of( items.begin(), items.end(), []( const item & it ) {
        return it.typeId() == itype_jeans;
    } );
    const bool has_corpse = std::any_of( items.begin(), items.end(), []( const item & it ) {
        return it.is_corpse();
    } );
    CHECK( has_spilled_jeans );
    CHECK_FALSE( has_corpse );
}
