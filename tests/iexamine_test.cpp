#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "iexamine.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "point.h"
#include "stomach.h"
#include "translation.h"
#include "type_id.h"

TEST_CASE( "mapdata_examine" )
{
    ter_t data;
    data.set_examine( iexamine_functions{iexamine::always_true, iexamine::water_source, no_translation( "test water source" ) } );

    CHECK( data.has_examine( iexamine::water_source ) );
    CHECK_FALSE( data.has_examine( iexamine::fungus ) );
    CHECK_FALSE( data.has_examine( iexamine::dirtmound ) );
    CHECK_FALSE( data.has_examine( iexamine::none ) );
}

TEST_CASE( "examine_bush" )
{
    clear_map_without_vision();
    map &m = get_map();
    const tripoint_bub_ms &pine_loc = tripoint_bub_ms::zero;
    const tripoint_bub_ms &elderberry_loc = pine_loc + tripoint::east;

    m.ter_set( pine_loc, ter_id( "t_tree_pine" ) );
    m.ter_set( elderberry_loc, ter_id( "t_tree_elderberry" ) );

    CHECK( m.ter( pine_loc )->has_examine( iexamine::harvest_ter ) );
    CHECK( m.ter( elderberry_loc )->has_examine( iexamine::harvest_ter_nectar ) );

    // In spring, pine is harvestable but elderberry is not
    calendar::turn = calendar::turn_zero;
    CHECK( m.ter( pine_loc )->can_examine( pine_loc ) );
    CHECK_FALSE( m.ter( elderberry_loc )->can_examine( elderberry_loc ) );

    // In summer, both are harvestable
    calendar::turn = calendar::turn_zero + calendar::season_length() + 1_days;
    CHECK( m.ter( pine_loc )->can_examine( pine_loc ) );
    CHECK( m.ter( elderberry_loc )->can_examine( elderberry_loc ) );

    // In fall, just pine again
    calendar::turn = calendar::turn_zero + calendar::season_length() * 2 + 1_days;
    CHECK( m.ter( pine_loc )->can_examine( pine_loc ) );
    CHECK_FALSE( m.ter( elderberry_loc )->can_examine( elderberry_loc ) );
}

TEST_CASE( "mill_finalize_counts_stackable_food_by_charges", "[iexamine][mill][stackable]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &you = get_player_character();
    const tripoint_bub_ms mill_pos = tripoint_bub_ms::zero;
    const furn_id wind_mill( "f_wind_mill" );
    const furn_id wind_mill_active( "f_wind_mill_active" );
    const itype_id dried_rice( "dry_rice" );
    const itype_id wheat_free_flour( "flour_wheat_free" );

    here.furn_set( mill_pos, wind_mill_active );
    item rice( dried_rice, calendar::turn_zero );
    REQUIRE( rice.count_by_charges() );
    rice.charges = 240;
    here.add_item( mill_pos, rice );

    iexamine::mill_finalize( you, here, mill_pos );

    int rice_count = 0;
    int flour_count = 0;
    for( const item &it : here.i_at( mill_pos ) ) {
        if( it.typeId() == dried_rice ) {
            rice_count += it.count();
        } else if( it.typeId() == wheat_free_flour ) {
            flour_count += it.count();
            CHECK( you.compute_effective_nutrients( it ).kcal() == 65 );
        }
    }

    CHECK( here.furn( mill_pos ) == wind_mill );
    CHECK( rice_count == 0 );
    CHECK( flour_count == 960 );
}

TEST_CASE( "mill_finalize_leaves_incomplete_charge_batch", "[iexamine][mill][stackable]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &you = get_player_character();
    const tripoint_bub_ms mill_pos = tripoint_bub_ms::zero;
    const furn_id wind_mill( "f_wind_mill" );
    const furn_id wind_mill_active( "f_wind_mill_active" );
    const itype_id cooked_acorns( "acorns_cooked" );
    const itype_id wheat_free_flour( "flour_wheat_free" );

    here.furn_set( mill_pos, wind_mill_active );
    item acorns( cooked_acorns, calendar::turn_zero );
    REQUIRE( acorns.count_by_charges() );
    acorns.charges = 3;
    here.add_item( mill_pos, acorns );

    iexamine::mill_finalize( you, here, mill_pos );

    int acorn_count = 0;
    int flour_count = 0;
    for( const item &it : here.i_at( mill_pos ) ) {
        if( it.typeId() == cooked_acorns ) {
            acorn_count += it.count();
        } else if( it.typeId() == wheat_free_flour ) {
            flour_count += it.count();
        }
    }

    CHECK( here.furn( mill_pos ) == wind_mill );
    CHECK( acorn_count == 1 );
    CHECK( flour_count == 3 );
}
