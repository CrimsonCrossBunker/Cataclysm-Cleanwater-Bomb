#include <optional>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "type_id.h"

// Hidden: exercises the real save/load path in the disposable test world.
TEST_CASE( "dimension_travel_keeps_loaded_unique_special_state", "[.][dimension][upstream_ports]" )
{
    clear_map_without_vision();
    clear_avatar();
    get_avatar().setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    const dimension_id destination = g->get_dimension_prefix();
    const overmap_special_id marker( "test_dimension_marker" );
    overmap_buffer.global_state.placed_unique_specials.insert( marker );
    overmap_buffer.global_state.unique_special_count[marker] = 13;
    // Re-enter the already generated dimension: this uses the same save/clear/load
    // path as A -> B without depending on random generation of another world.
    REQUIRE( g->travel_to_dimension( destination, {}, {}, std::nullopt ) );
    CHECK( overmap_buffer.contains_unique_special( marker ) );
    CHECK( overmap_buffer.get_unique_special_count( marker ) == 13 );
    // A second reload also checks that the restored state is saved again.
    REQUIRE( g->travel_to_dimension( destination, {}, {}, std::nullopt ) );
    CHECK( overmap_buffer.contains_unique_special( marker ) );
    CHECK( overmap_buffer.get_unique_special_count( marker ) == 13 );
    overmap_buffer.global_state.placed_unique_specials.erase( marker );
    overmap_buffer.global_state.unique_special_count.erase( marker );
}
