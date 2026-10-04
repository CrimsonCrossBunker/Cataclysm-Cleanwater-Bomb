#include <functional>
#include <map>
#include <utility>
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "enums.h"
#include "map.h"
#include "map_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

static const vproto_id vehicle_prototype_SmallFlier1( "SmallFlier1" );

TEST_CASE( "rotorcraft_hover_requires_running_engine_and_consumes_fuel",
           "[vehicle][rotorcraft][fuel]" )
{
    clear_map( -2, 1 );
    map &here = get_map();
    here.vertical_shift( 1 );
    on_out_of_scope cleanup( [&here]() {
        here.vertical_shift( 0 );
        clear_map( -2, 1 );
    } );
    vehicle *veh = here.add_vehicle( vehicle_prototype_SmallFlier1,
                                     tripoint_bub_ms( 60, 60, 1 ), 0_degrees, 100,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->is_rotorcraft( here ) );
    const bool engine_running = GENERATE( false, true );
    veh->engine_on = engine_running;
    veh->set_flying( true );
    veh->check_falling_or_floating();
    CHECK( veh->is_flying_in_air() == engine_running );
    CHECK( veh->is_falling != engine_running );

    if( engine_running ) {
        const auto usage = veh->fuel_usage();
        REQUIRE_FALSE( usage.empty() );
        const itype_id fuel = usage.begin()->first;
        const int before = veh->fuel_left( here, fuel );
        REQUIRE( before > 0 );
        for( int turn = 0; turn < 20; ++turn ) {
            veh->gain_moves( here );
            veh->idle( here, true );
        }
        CHECK( veh->velocity == 0 );
        CHECK( veh->fuel_left( here, fuel ) < before );

        veh->drain( here, fuel, veh->fuel_left( here, fuel ) );
        veh->check_falling_or_floating();
        CHECK_FALSE( veh->is_flying_in_air() );
        CHECK( veh->is_falling );
    }
}
