#include <array>
#include <list>
#include <set>

#include "active_item_cache.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "item.h"
#include "item_rot.h"
#include "item_temperature.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "point.h"
#include "type_id.h"

static const itype_id itype_firecracker_act( "firecracker_act" );

TEST_CASE( "daily_rot_batch_validates_inputs_and_restores_scope", "[item][rot][threading]" )
{
    std::array<item, 32> owners;
    const item_rot_input input{ units::from_fahrenheit( 65 ), 0.7f, 937_seconds,
                                false, false, false };
    const auto expected = calculate_item_rot_increments( input );
    REQUIRE_FALSE( item_rot_batch::find( &owners.front(), input, false, false ) );
    {
        item_rot_batch outer;
        for( const item &owner : owners ) {
            outer.add( &owner, input );
        }
        outer.prepare();
        for( unsigned mushy = 0; mushy < 2; ++mushy ) {
            for( unsigned cold = 0; cold < 2; ++cold ) {
                const auto value = item_rot_batch::find( &owners.front(), input, cold, mushy );
                REQUIRE( value );
                CHECK( to_turns<int>( *value ) == to_turns<int>( expected[mushy * 2 + cold] ) );
            }
        }
        auto changed = input;
        changed.elapsed += 1_seconds;
        CHECK_FALSE( item_rot_batch::find( &owners.front(), changed, false, false ) );
        {
            item_rot_batch inner;
            for( const item &owner : owners ) {
                inner.add( &owner, changed );
            }
            inner.prepare();
            CHECK_FALSE( item_rot_batch::find( &owners.front(), input, false, false ) );
            REQUIRE( item_rot_batch::find( &owners.front(), changed, false, false ) );
        }
        REQUIRE( item_rot_batch::find( &owners.front(), input, false, false ) );
    }
    CHECK_FALSE( item_rot_batch::find( &owners.front(), input, false, false ) );
}

TEST_CASE( "item_thermal_batch_validates_inputs_and_restores_outer_scope", "[item][temperature][threading]" )
{
    std::array<item, 32> owners;
    const item_temperature_input input{ 293.15f, 263.15f, 526.3f, 1000.0f, 1000, 1.0f,
                                       4.0f, 2.0f, 334.0f, 273.15f, 601 };
    const auto expected = calculate_item_temperature( input );
    REQUIRE_FALSE( item_temperature_batch::find( &owners.front(), input ) );
    {
        item_temperature_batch outer;
        for( const item &owner : owners ) {
            outer.add( &owner, input );
        }
        outer.prepare();
        const auto prepared = item_temperature_batch::find( &owners.front(), input );
        REQUIRE( prepared );
        CHECK( prepared->temperature == expected.temperature );
        CHECK( prepared->energy == expected.energy );
        CHECK( prepared->frozen == expected.frozen );
        auto changed = input;
        ++changed.turns;
        CHECK_FALSE( item_temperature_batch::find( &owners.front(), changed ) );
        {
            item_temperature_batch inner;
            for( const item &owner : owners ) {
                inner.add( &owner, changed );
            }
            inner.prepare();
            CHECK_FALSE( item_temperature_batch::find( &owners.front(), input ) );
            REQUIRE( item_temperature_batch::find( &owners.front(), changed ) );
        }
        REQUIRE( item_temperature_batch::find( &owners.front(), input ) );
    }
    CHECK_FALSE( item_temperature_batch::find( &owners.front(), input ) );
}

TEST_CASE( "active_item_processing_preview_does_not_rotate", "[item][threading]" )
{
    active_item_cache cache;
    std::list<item> items;
    for( int i = 0; i < 4; ++i ) {
        items.emplace_back( itype_id( "apple" ), calendar::turn_zero );
        REQUIRE( cache.add( items.back(), point_rel_ms( i, 0 ) ) );
    }
    // Expired references must not consume the processing quota.
    items.pop_front();
    REQUIRE( cache.peek_for_processing( 0 ).empty() );
    const auto first = cache.peek_for_processing( 32 );
    REQUIRE( first.size() == 1 );
    CHECK( first.front().item_ref.get() == &items.front() );
    const auto repeated = cache.peek_for_processing( 32 );
    REQUIRE( repeated.size() == first.size() );
    CHECK( repeated.front().item_ref == first.front().item_ref );
    const auto actual = cache.get_for_processing();
    REQUIRE( actual.size() == first.size() );
    CHECK( actual.front().item_ref == first.front().item_ref );
    const auto next = cache.peek_for_processing( 1 );
    REQUIRE( next.size() == 1 );
    CHECK_FALSE( next.front().item_ref == first.front().item_ref );
}

TEST_CASE( "place_active_item_at_various_coordinates", "[item]" )
{
    clear_map( -OVERMAP_DEPTH, OVERMAP_HEIGHT );
    map &here = get_map();
    REQUIRE( here.get_submaps_with_active_items().empty() );
    // An arbitrary active item.
    item active( itype_firecracker_act, calendar::turn_zero, item::default_charges_tag() );
    active.activate();

    // For each space in a wide area place the item and check if the cache has been updated.
    int z = 0;
    for( int x = 0; x < MAPSIZE_X; ++x ) {
        for( int y = 0; y < MAPSIZE_Y; ++y ) {
            REQUIRE( here.i_at( tripoint_bub_ms{ x, y, z } ).empty() );
            CAPTURE( x, y, z );
            tripoint_abs_sm abs_loc = here.get_abs_sub() + tripoint( x / SEEX, y / SEEY, z );
            CAPTURE( abs_loc );
            REQUIRE( here.get_submaps_with_active_items().empty() );
            REQUIRE( here.get_submaps_with_active_items().find( abs_loc ) ==
                     here.get_submaps_with_active_items().end() );
            item &item_ref = here.add_item( tripoint_bub_ms( x, y, z ), active );
            here.update_submaps_with_active_items();
            REQUIRE( item_ref.active );
            REQUIRE_FALSE( here.get_submaps_with_active_items().empty() );
            REQUIRE( here.get_submaps_with_active_items().find( abs_loc ) !=
                     here.get_submaps_with_active_items().end() );
            REQUIRE_FALSE( here.i_at( tripoint_bub_ms{ x, y, z } ).empty() );
            here.i_clear( tripoint_bub_ms{ x, y, z } );
            here.process_items();
        }
    }
}
