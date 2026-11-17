#include <functional>
#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "debug.h"
#include "iexamine.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "mill.h"
#include "point.h"
#include "plant_climate.h"
#include "player_helpers.h"
#include "stomach.h"
#include "translation.h"
#include "type_id.h"

static const itype_id itype_acorns_cooked( "acorns_cooked" );
static const itype_id itype_dry_rice( "dry_rice" );
static const itype_id itype_dry_wheat_stalks( "dry_wheat_stalks" );
static const itype_id itype_fermentable_liquid_mixture( "fermentable_liquid_mixture" );
static const itype_id itype_flour_wheat_free( "flour_wheat_free" );
static const itype_id itype_wheat_stalks( "wheat_stalks" );

TEST_CASE( "mapdata_examine" )
{
    ter_t data;
    data.set_examine( iexamine_functions{iexamine::always_true, iexamine::water_source, no_translation( "test water source" ) } );

    CHECK( data.has_examine( iexamine::water_source ) );
    CHECK_FALSE( data.has_examine( iexamine::fungus ) );
    CHECK_FALSE( data.has_examine( iexamine::dirtmound ) );
    CHECK_FALSE( data.has_examine( iexamine::none ) );
}

TEST_CASE( "flower_examine_handlers_remain_distinct", "[iexamine]" )
{
    const iexamine_examine_function handlers[] = {
        iexamine::flower_poppy, iexamine::flower_cactus,
        iexamine::flower_dahlia, iexamine::flower_marloss
    };
    for( const iexamine_examine_function expected : handlers ) {
        furn_t flower;
        flower.set_examine( iexamine_functions{ iexamine::always_true, expected,
                                                no_translation( "test flower" ) } );
        for( const iexamine_examine_function candidate : handlers ) {
            CHECK( flower.has_examine( candidate ) == ( candidate == expected ) );
        }
    }
    CHECK_FALSE( furn_str_id( "f_dahlia" )->has_examine( iexamine::flower_poppy ) );
    CHECK_FALSE( furn_str_id( "f_flower_marloss" )->has_examine( iexamine::flower_dahlia ) );
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

    const auto &fruit = m.ter( elderberry_loc )->fruit_climate;
    REQUIRE( fruit );
    REQUIRE( has_local_fruit_climate( m.get_abs( elderberry_loc ) ) );
    bool ripe_seen = false;
    bool unripe_seen = false;
    for( time_duration elapsed = 0_days; elapsed < calendar::year_length(); elapsed += 1_days ) {
        calendar::turn = calendar::turn_zero + elapsed;
        const bool ripe = local_fruit_is_ripe( *fruit, m.get_abs( elderberry_loc ), calendar::turn );
        CAPTURE( calendar::turn, ripe );
        CHECK( m.ter( pine_loc )->can_examine( pine_loc ) );
        CHECK( m.ter( elderberry_loc )->can_examine( elderberry_loc ) == ripe );
        ripe_seen = ripe_seen || ripe;
        unripe_seen = unripe_seen || !ripe;
    }
    CHECK( ripe_seen );
    CHECK( unripe_seen );
}

TEST_CASE( "mill_finalize_counts_stackable_food_by_charges", "[iexamine][mill][stackable]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &you = get_player_character();
    const tripoint_bub_ms mill_pos = tripoint_bub_ms::zero;
    const furn_id wind_mill( "f_wind_mill" );
    const furn_id wind_mill_active( "f_wind_mill_active" );

    here.furn_set( mill_pos, wind_mill_active );
    item rice( itype_dry_rice, calendar::turn_zero );
    REQUIRE( rice.count_by_charges() );
    rice.charges = 240;
    here.add_item( mill_pos, rice );

    mill::finish( here, mill_pos );

    int rice_count = 0;
    int flour_count = 0;
    for( const item &it : here.i_at( mill_pos ) ) {
        if( it.typeId() == itype_dry_rice ) {
            rice_count += it.count();
        } else if( it.typeId() == itype_flour_wheat_free ) {
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
    const tripoint_bub_ms mill_pos = tripoint_bub_ms::zero;
    const furn_id wind_mill( "f_wind_mill" );
    const furn_id wind_mill_active( "f_wind_mill_active" );

    here.furn_set( mill_pos, wind_mill_active );
    item acorns( itype_acorns_cooked, calendar::turn_zero );
    REQUIRE( acorns.count_by_charges() );
    acorns.charges = 3;
    here.add_item( mill_pos, acorns );

    mill::finish( here, mill_pos );

    int acorn_count = 0;
    int flour_count = 0;
    for( const item &it : here.i_at( mill_pos ) ) {
        if( it.typeId() == itype_acorns_cooked ) {
            acorn_count += it.count();
        } else if( it.typeId() == itype_flour_wheat_free ) {
            flour_count += it.count();
        }
    }

    CHECK( here.furn( mill_pos ) == wind_mill );
    CHECK( acorn_count == 1 );
    CHECK( flour_count == 3 );
}

TEST_CASE( "empty_compost_tank_recovers_after_liquid_removal", "[iexamine][compost]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos = tripoint_bub_ms::zero;
    Character &worker = get_player_character();
    clear_character( worker );
    worker.setpos( here, pos );
    worker.set_moves( 100 );
    here.furn_set( pos, furn_id( "f_compost_full" ) );
    REQUIRE( here.i_at( pos ).empty() );
    const std::string debug_message = capture_debugmsg_during( [&] {
        iexamine::compost_full( get_player_character(), pos );
    } );
    CHECK( debug_message.empty() );
    CHECK( here.furn( pos ) == furn_id( "f_compost_empty" ) );
}

TEST_CASE( "compost_fermentation_preserves_biomass_age", "[iexamine][compost]" )
{
    restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 20_days;
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos = tripoint_bub_ms::zero;
    Character &worker = get_player_character();
    clear_character( worker );
    worker.setpos( here, pos );
    worker.set_moves( 100 );
    here.furn_set( pos, furn_id( "f_compost_full" ) );
    item biomass( itype_fermentable_liquid_mixture, calendar::turn );
    biomass.charges = 10;
    biomass.set_age( 10_days );
    REQUIRE( biomass.age() == 10_days );
    here.add_item( pos, biomass );
    REQUIRE( here.i_at( pos ).size() == 1 );
    const std::string debug_message = capture_debugmsg_during( [&] {
        iexamine::compost_full( get_player_character(), pos );
    } );
    CHECK( debug_message.empty() );
    REQUIRE( here.i_at( pos ).size() == 1 );
    CHECK( here.i_at( pos ).only_item().age() == 10_days );
    CHECK( here.i_at( pos ).only_item().charges == 10 );
    CHECK( here.furn( pos ) == furn_id( "f_compost_full" ) );
}

TEST_CASE( "stook_preserves_grain_quantity_and_nutrients", "[iexamine][stook][stackable]" )
{
    clear_map_without_vision();
    map &here = get_map();
    Character &you = get_player_character();
    const tripoint_bub_ms pos = tripoint_bub_ms::zero;
    const int count = GENERATE( 1, 10 );
    Character &worker = get_player_character();
    clear_character( worker );
    worker.setpos( here, pos );
    worker.set_moves( 100 );
    here.furn_set( pos, furn_id( "f_stook_full" ) );
    item grain( itype_wheat_stalks, calendar::turn - 336_hours, count );
    const int kcal = you.compute_effective_nutrients( grain ).kcal();
    REQUIRE( grain.count() == count );
    here.add_item( pos, grain );

    iexamine::stook_full( you, pos );

    int dried_count = 0;
    for( const item &it : here.i_at( pos ) ) {
        REQUIRE( it.typeId() == itype_dry_wheat_stalks );
        dried_count += it.count();
        CHECK( you.compute_effective_nutrients( it ).kcal() == kcal );
    }
    CHECK( dried_count == count );
    CHECK( here.furn( pos ) == furn_str_id::NULL_ID() );
}
