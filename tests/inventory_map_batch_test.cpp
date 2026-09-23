#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "inventory.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "type_id.h"

// Adapted from CDDA #88527, Matthew Richmond (CC BY-SA 3.0).
TEST_CASE( "inventory_form_from_map_bulk_batching", "[inventory][map][upstream_ports]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const bool assign_invlet = GENERATE( false, true );
    const std::vector<tripoint_bub_ms> positions = { { 60, 60, 0 }, { 61, 60, 0 }, { 62, 60, 0 } };
    for( int i = 0; i < 5; ++i ) {
        here.add_item_or_charges( positions[0], item( itype_id( "rock" ) ) );
        here.add_item_or_charges( positions[0], item( itype_id( "stick" ) ) );
        here.add_item_or_charges( positions[0], item( itype_id( "stick" ) ) );
        here.add_item_or_charges( positions[1], item( itype_id( "stick" ) ) );
        here.add_item_or_charges( positions[1], item( itype_id( "string_36" ) ) );
        here.add_item_or_charges( positions[2], item( itype_id( "rock" ) ) );
    }
    inventory inv;
    for( int refresh = 0; refresh < 2; ++refresh ) {
        inv.form_from_map( here, positions, nullptr, assign_invlet );
        CHECK( inv.count_item( itype_id( "rock" ) ) == 10 );
        CHECK( inv.count_item( itype_id( "stick" ) ) == 15 );
        CHECK( inv.count_item( itype_id( "string_36" ) ) == 5 );
        CHECK( inv.count_item( itype_id( "hammer" ) ) == 0 );
    }
}

BENCHMARK_TEST_CASE( "inventory_multitile_bulk_and_count_benchmark", "[inventory][upstream_ports]" )
{
    clear_map_without_vision();
    map &here = get_map();
    std::vector<tripoint_bub_ms> positions;
    for( int x = 55; x < 65; ++x ) {
        for( int y = 55; y < 65; ++y ) {
            const tripoint_bub_ms pos( x, y, 0 );
            positions.push_back( pos );
            for( int i = 0; i < 10; ++i ) {
                item rock( itype_id( "rock" ), calendar::turn );
                rock.set_var( "batch_test", x * 1000 + y * 10 + i );
                here.add_item_or_charges( pos, rock );
            }
        }
    }
    inventory inv;
    BENCHMARK( "form inventory from 100 tiles / 1000 distinct rocks" ) {
        inv.form_from_map( here, positions, nullptr, false );
        return inv.count_item( itype_id( "rock" ) );
    };
    REQUIRE( inv.count_item( itype_id( "rock" ) ) == 1000 );
    BENCHMARK( "count cached inventory 1000 times" ) {
        int total = 0;
        for( int i = 0; i < 1000; ++i ) {
            total += inv.count_item( itype_id( "rock" ) );
        }
        return total;
    };
}
