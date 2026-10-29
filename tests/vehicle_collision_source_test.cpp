#include <functional>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "coordinates.h"
#include "debug.h"
#include "effect.h"
#include "effect_source.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_helpers.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const efftype_id effect_bleed( "bleed" );
static const vpart_id vpart_plating_spiked( "plating_spiked" );
static const vproto_id vehicle_prototype_bicycle( "bicycle" );
static const vproto_id vehicle_prototype_car( "car" );

TEST_CASE( "vehicle_collision_bleeding_handles_missing_driver",
           "[vehicle][collision][effect][bleed]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms vehicle_position( 60, 60, 0 );
    vehicle *veh = here.add_vehicle( vehicle_prototype_car, vehicle_position, 0_degrees, 0,
                                    veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    const point_rel_ms mount = veh->part( 0 ).mount;
    const int sharp_part = veh->install_part( here, mount, vpart_plating_spiked );
    REQUIRE( sharp_part >= 0 );

    const bool with_driver = GENERATE( false, true );
    CAPTURE( with_driver );
    if( with_driver ) {
        int controls_part = -1;
        for( const vpart_reference &part : veh->get_all_parts() ) {
            if( part.has_feature( "CONTROLS" ) ) {
                controls_part = part.part_index();
                break;
            }
        }
        REQUIRE( controls_part >= 0 );
        here.board_vehicle( veh->bub_part_pos( here, controls_part ), &you );
        you.controlling_vehicle = true;
    }
    REQUIRE( veh->get_driver( here ) == ( with_driver ? &you : nullptr ) );

    const tripoint_bub_ms target_position = vehicle_position + tripoint( 10, 0, 0 );
    monster &target = spawn_test_monster( "mon_zombie", target_position, false );
    target.set_hp( 100000 );
    veh->velocity = 1000;
    veh_collision collision;
    const std::string diagnostics = capture_debugmsg_during( [&]() {
        collision = veh->part_collision( here, sharp_part, here.get_abs( target_position ),
                                        false, false );
    } );

    CHECK( diagnostics.empty() );
    REQUIRE( collision.type == veh_coll_body );
    bool has_bleeding = false;
    for( const std::reference_wrapper<const effect> &entry : target.get_effects() ) {
        const effect &bleeding = entry.get();
        if( bleeding.get_id() == effect_bleed ) {
            has_bleeding = true;
            CHECK( bleeding.get_source().resolve_creature() == ( with_driver ? &you : nullptr ) );
        }
    }
    REQUIRE( has_bleeding );
}

TEST_CASE( "vehicle_collision_ejects_boarded_and_unboarded_characters",
           "[vehicle][collision][passenger]" )
{
    clear_avatar();
    clear_map_without_vision();
    build_test_map( ter_id( "t_pavement" ) );
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms vehicle_position( 60, 60, 0 );
    vehicle *veh = here.add_vehicle( vehicle_prototype_bicycle, vehicle_position, 0_degrees,
                                    0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    const auto seats = veh->get_avail_parts( "BOARDABLE" );
    REQUIRE( seats.begin() != seats.end() );
    const int seat_index = seats.begin()->part_index();
    const tripoint_bub_ms seat_position = veh->bub_part_pos( here, seat_index );
    REQUIRE( veh->part_with_feature( seat_index, VPFLAG_SEATBELT, true ) == -1 );

    const std::string boarding_state = GENERATE( "standing", "boarded", "unresolved_passenger" );
    const bool boarded = boarding_state != "standing";
    const bool unresolved_passenger = boarding_state == "unresolved_passenger";
    CAPTURE( boarding_state );
    if( boarded ) {
        here.board_vehicle( seat_position, &you );
        you.controlling_vehicle = true;
        if( unresolved_passenger ) {
            veh->part( seat_index ).passenger_id = character_id();
        }
    } else {
        you.setpos( here, seat_position );
    }
    REQUIRE( you.in_vehicle == boarded );
    REQUIRE( veh->get_passenger( seat_index ) ==
             ( boarded && !unresolved_passenger ? &you : nullptr ) );
    REQUIRE( veh->get_riders().size() == 1 );
    REQUIRE( you.get_str() * 150 + 500 < 60 * 80 );

    veh->velocity = 0;
    const std::string diagnostics = capture_debugmsg_during( [&]() {
        here.shake_vehicle( *veh, 6000, 0_degrees );
    } );

    INFO( diagnostics );
    CHECK( diagnostics.empty() );
    CHECK_FALSE( you.in_vehicle );
    CHECK_FALSE( you.controlling_vehicle );
    CHECK_FALSE( veh->part( seat_index ).has_flag( vp_flag::passenger_flag ) );
    CHECK( you.pos_bub( here ) != seat_position );
}
