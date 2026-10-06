#include "cata_catch.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "overmapbuffer.h"
#include "point.h"
#include "type_id.h"
#include "vehicle.h"

struct starting_vehicle_test_access {
    static vehicle *place( game &world, const point_abs_omt &origin ) {
        return world.place_vehicle_nearby( vproto_id( "airship" ), origin, 1, 1, { "field" } );
    }
};

TEST_CASE( "large_starting_airship_fits_across_overmap_tiles", "[vehicle][airship][start]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_abs_omt origin = project_to<coords::omt>( here.get_abs( tripoint_bub_ms( 60, 60,
                                    0 ) ) );
    for( int x = -1; x <= 1; ++x ) {
        for( int y = -1; y <= 1; ++y ) {
            overmap_buffer.ter_set( origin + point( x, y ), oter_str_id( "forest" ).id() );
        }
    }
    const tripoint_abs_omt goal = origin + point( 1, 0 );
    overmap_buffer.ter_set( goal, oter_str_id( "field" ).id() );

    vehicle *airship = starting_vehicle_test_access::place( *g, origin.xy() );

    REQUIRE( airship );
    CHECK( airship->type == vproto_id( "airship" ) );
    CHECK( project_to<coords::omt>( airship->pos_abs() ) == goal );
    CHECK_FALSE( airship->is_locked );
    CHECK( airship->tracking_on );
    for( const tripoint_abs_ms &part : airship->get_points() ) {
        CHECK( here.inbounds( part ) );
    }
}
