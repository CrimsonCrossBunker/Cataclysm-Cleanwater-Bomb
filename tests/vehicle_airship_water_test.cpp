#include "cata_catch.h"
#include "coordinates.h"
#include "map.h"
#include "map_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

TEST_CASE( "buoyant_airship_stays_above_water_without_a_saved_flight_flag",
           "[vehicle][airship][water]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const bool balloon = GENERATE( false, true );
    if( balloon ) {
        REQUIRE( veh->install_part( here, point_rel_ms::zero,
                                    vpart_id( "airship_balloon" ) ) >= 0 );
    }
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    REQUIRE( veh->is_airship( here ) == balloon );
    here.ter_set( pos, ter_id( "t_water_dp" ) );
    veh->set_flying( false );

    veh->check_falling_or_floating();

    CHECK( veh->is_flying_in_air() == balloon );
    CHECK( veh->is_in_water( true ) == !balloon );
    if( balloon ) {
        CHECK( veh->act_on_map( here ) == veh );
    }
}
