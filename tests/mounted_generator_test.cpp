#include <string>

#include "cata_catch.h"
#include "coordinates.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"

namespace
{
struct generator_rig {
    vehicle *veh;
    int generator;
    int tank;
    int battery;
};

generator_rig make_generator_rig( const std::string &id )
{
    clear_avatar();
    clear_map_without_vision();
    clear_vehicles();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), tripoint_bub_ms( 60, 60, 0 ),
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    if( !vpart_id( id )->has_flag( "APPLIANCE" ) ) {
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    }
    const int generator = veh->install_part( here, point_rel_ms::zero, vpart_id( id ) );
    REQUIRE( generator >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms( 0, 1 ), vpart_id( "frame" ) ) >= 0 );
    const int battery = veh->install_part( here, point_rel_ms( 0, 1 ),
                                           vpart_id( "small_storage_battery" ) );
    REQUIRE( battery >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms( 1, 0 ), vpart_id( "frame" ) ) >= 0 );
    const int tank = veh->install_part( here, point_rel_ms( 1, 0 ), vpart_id( "tank" ) );
    REQUIRE( tank >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    veh->part( battery ).ammo_set( itype_id( "battery" ), 0 );
    veh->part( generator ).enabled = true;
    return { veh, generator, tank, battery };
}

void run_generator( vehicle &veh )
{
    for( int turn = 0; turn < 100; ++turn ) {
        veh.power_parts( get_map() );
    }
}
} // namespace

TEST_CASE( "mounted_generators_use_only_compatible_vehicle_fuel", "[vehicle][mounted_generator]" )
{
    const std::string model = GENERATE( "portable_generator", "12000_gasoline_generator",
                                        "diesel_generator", "military_generator" );
    const std::string fuel = GENERATE( "gasoline", "diesel", "biodiesel", "jp8", "lamp_oil",
                                       "motor_oil", "water_clean" );
    CAPTURE( model, fuel );
    const generator_rig rig = make_generator_rig( "veh_" + model );
    const int initial_fuel = rig.veh->part( rig.tank ).ammo_set( itype_id( fuel ), 1000 );
    REQUIRE( initial_fuel > 0 );
    REQUIRE( rig.veh->part( rig.generator ).ammo_remaining() == 0 );
    const bool diesel = model == "diesel_generator" || model == "military_generator";
    const bool compatible = diesel ? fuel != "gasoline" && fuel != "water_clean" : fuel == "gasoline";
    CHECK( ( rig.veh->active_reactor_epower( get_map() ) > 0_W ) == compatible );
    run_generator( *rig.veh );
    CHECK( ( rig.veh->part( rig.battery ).ammo_remaining() > 0 ) == compatible );
    CHECK( ( rig.veh->part( rig.tank ).ammo_remaining() < initial_fuel ) == compatible );
    CHECK( rig.veh->part( rig.generator ).ammo_remaining() == 0 );
}

TEST_CASE( "mounted_generator_retains_internal_fuel_and_respects_unavailable_tanks",
           "[vehicle][mounted_generator]" )
{
    const generator_rig rig = make_generator_rig( "veh_portable_generator" );
    REQUIRE( rig.veh->part( rig.tank ).ammo_set( itype_id( "gasoline" ), 1000 ) == 1000 );
    SECTION( "internal_fuel_first_then_vehicle_tank" ) {
        REQUIRE( rig.veh->part( rig.generator ).ammo_set( itype_id( "gasoline" ), 1000 ) == 1000 );
        run_generator( *rig.veh );
        CHECK( rig.veh->part( rig.battery ).ammo_remaining() > 0 );
        CHECK( rig.veh->part( rig.generator ).ammo_remaining() < 1000 );
        CHECK( rig.veh->part( rig.tank ).ammo_remaining() == 1000 );
        rig.veh->part( rig.generator ).ammo_unset();
        run_generator( *rig.veh );
        CHECK( rig.veh->part( rig.tank ).ammo_remaining() < 1000 );
    }
    SECTION( "broken_tank_cannot_supply_fuel" ) {
        rig.veh->set_hp( rig.veh->part( rig.tank ), 0, false );
        CHECK( rig.veh->active_reactor_epower( get_map() ) == 0_W );
        run_generator( *rig.veh );
        CHECK( rig.veh->part( rig.battery ).ammo_remaining() == 0 );
        CHECK( rig.veh->part( rig.tank ).ammo_remaining() == 1000 );
    }
    SECTION( "carried_vehicle_tank_cannot_supply_fuel" ) {
        rig.veh->part( rig.tank ).set_flag( vp_flag::carried_flag );
        CHECK( rig.veh->active_reactor_epower( get_map() ) == 0_W );
        run_generator( *rig.veh );
        CHECK( rig.veh->part( rig.battery ).ammo_remaining() == 0 );
        CHECK( rig.veh->part( rig.tank ).ammo_remaining() == 1000 );
    }
    SECTION( "empty_tank_stops_generator" ) {
        rig.veh->part( rig.tank ).ammo_unset();
        CHECK( rig.veh->active_reactor_epower( get_map() ) == 0_W );
        run_generator( *rig.veh );
        CHECK( rig.veh->part( rig.battery ).ammo_remaining() == 0 );
        CHECK_FALSE( rig.veh->part( rig.generator ).enabled );
    }
}

TEST_CASE( "appliance_generator_still_uses_its_own_fuel", "[vehicle][mounted_generator]" )
{
    const generator_rig rig = make_generator_rig( "ap_portable_generator" );
    REQUIRE( rig.veh->part( rig.tank ).ammo_set( itype_id( "gasoline" ), 1000 ) == 1000 );
    CHECK( rig.veh->active_reactor_epower( get_map() ) == 0_W );
    run_generator( *rig.veh );
    CHECK( rig.veh->part( rig.battery ).ammo_remaining() == 0 );
    CHECK( rig.veh->part( rig.tank ).ammo_remaining() == 1000 );
    REQUIRE( rig.veh->part( rig.generator ).ammo_set( itype_id( "gasoline" ), 1000 ) == 1000 );
    rig.veh->part( rig.generator ).enabled = true;
    run_generator( *rig.veh );
    CHECK( rig.veh->part( rig.battery ).ammo_remaining() > 0 );
    CHECK( rig.veh->part( rig.generator ).ammo_remaining() < 1000 );
    CHECK( rig.veh->part( rig.tank ).ammo_remaining() == 1000 );
}
