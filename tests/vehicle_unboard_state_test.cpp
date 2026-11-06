#include <optional>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "coordinates.h"
#include "debug.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vpart_position.h"

TEST_CASE( "unboarding_repairs_stale_passenger_state", "[vehicle][character]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms location( 60, 60, 0 );
    you.setpos( here, location );
    const std::string state = GENERATE( "normal", "missing_flag", "missing_id", "missing_vehicle" );
    std::optional<vpart_reference> seat;
    if( state != "missing_vehicle" ) {
        vehicle *veh = here.add_vehicle( vproto_id( "none" ), location, 0_degrees, 0 );
        REQUIRE( veh != nullptr );
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "seat" ) ) >= 0 );
        veh->refresh();
        here.add_vehicle_to_cache( veh );
        here.board_vehicle( location, &you );
        REQUIRE( you.in_vehicle );
        seat = here.veh_at( location ).part_with_feature( "BOARDABLE", true );
        REQUIRE( seat );
        if( state == "missing_flag" ) {
            seat->part().remove_flag( vp_flag::passenger_flag );
        } else if( state == "missing_id" ) {
            seat->part().passenger_id = character_id( 999999 );
        }
    } else {
        you.in_vehicle = true;
    }
    you.controlling_vehicle = true;
    const std::string diagnostics = capture_debugmsg_during( [&here, &location]() {
        here.unboard_vehicle( location );
    } );
    CHECK( diagnostics.empty() );
    CHECK_FALSE( you.in_vehicle );
    CHECK_FALSE( you.controlling_vehicle );
    if( seat ) {
        CHECK_FALSE( seat->part().has_flag( vp_flag::passenger_flag ) );
    }
}

