#include <cstddef>
#include <functional>
#include <optional>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "coordinates.h"
#include "debug.h"
#include "enums.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const vpart_location_id vpart_location_structure( "structure" );
static const vproto_id vehicle_prototype_test_van( "test_van" );

TEST_CASE( "removing_vehicle_part_clears_its_fake_from_map_cache",
           "[vehicle][vehicle_fake][cache]" )
{
    clear_avatar();
    clear_map_without_vision();
    build_test_map( ter_id( "t_pavement" ) );
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vehicle_prototype_test_van, tripoint_bub_ms( 60, 60, 0 ),
                                     45_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );

    int fake_index = -1;
    for( const vpart_reference &part : veh->get_all_parts_with_fakes() ) {
        if( part.part().is_fake &&
            veh->parts_at_relative( part.mount_pos(), true, true ).size() == 1 &&
            veh->part( part.part().fake_part_to ).info().location != vpart_location_structure ) {
            fake_index = part.part_index();
            break;
        }
    }
    REQUIRE( fake_index >= 0 );
    const int real_index = veh->part( fake_index ).fake_part_to;
    const tripoint_bub_ms fake_position = veh->bub_part_pos( here, fake_index );
    const point_rel_ms fake_mount = veh->part( fake_index ).mount;
    const std::string real_type = veh->part( real_index ).info().id.str();
    REQUIRE( here.veh_at( fake_position ) );
    REQUIRE( here.veh_at( fake_position )->part_index() == static_cast<size_t>( fake_index ) );

    veh->remove_part( veh->part( real_index ) );
    REQUIRE( veh->part( fake_index ).removed );
    std::vector<std::string> remaining_parts;
    for( const int index : veh->parts_at_relative( fake_mount, false, true ) ) {
        const vehicle_part &part = veh->part( index );
        remaining_parts.push_back( part.info().id.str() + " at " +
                                   veh->bub_part_pos( here, part ).to_string() );
    }
    CAPTURE( real_type, fake_mount, fake_position, veh->part( fake_index ).mount, remaining_parts );
    REQUIRE( veh->parts_at_relative( fake_mount, false, true ).empty() );

    const std::string diagnostics = capture_debugmsg_during( [&]() {
        const optional_vpart_position cached = here.veh_at( fake_position );
        CHECK_FALSE( cached );
        if( cached ) {
            cached->vehicle().get_display_of_tile( cached->mount_pos() );
        }
    } );
    CHECK( diagnostics.empty() );

    veh->part_removal_cleanup( here );
    CHECK_FALSE( here.veh_at( fake_position ) );
}
