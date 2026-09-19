#include <initializer_list>
#include <list>
#include <utility>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "item.h"
#include "item_location.h"
#include "iuse.h"
#include "map.h"
#include "map_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"

static const itype_id itype_water_clean( "water_clean" );

TEST_CASE( "heating_completion_handles_removed_target", "[activity][heating]" )
{
    clear_avatar();
    avatar &guy = get_avatar();
    item_location water = guy.i_add( item( itype_water_clean ) );
    REQUIRE( water );
    heating_requirements cost{ 250_ml, 1, 100 };
    heater source{};
    source.consume_flag = false;
    guy.assign_activity( heat_activity_actor( { { water, 1 } }, cost, source ) );
    water.remove_item();
    REQUIRE_FALSE( water );

    guy.activity.actor->finish( guy.activity, guy );

    CHECK_FALSE( guy.activity );
    CHECK( guy.backlog.empty() );
}

TEST_CASE( "heating_completion_handles_removed_heater", "[activity][heating]" )
{
    clear_avatar();
    avatar &guy = get_avatar();
    item_location water = guy.i_add( item( itype_water_clean ) );
    REQUIRE( water );
    const int charges = water->charges;
    heating_requirements cost{ 250_ml, 1, 100 };
    heater source{};
    source.consume_flag = true;
    // A heater location may become invalid while the activity completes.
    guy.assign_activity( heat_activity_actor( { { water, 1 } }, cost, source ) );

    guy.activity.actor->finish( guy.activity, guy );

    CHECK_FALSE( guy.activity );
    REQUIRE( water );
    CHECK( water->charges == charges );
}

TEST_CASE( "vehicle_heating_uses_the_selected_fuel", "[activity][heating][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const int battery = veh->install_part( here, point_rel_ms::zero,
                                           vpart_id( "small_storage_battery" ) );
    REQUIRE( battery >= 0 );
    veh->part( battery ).ammo_set( itype_id( "battery" ), 100 );
    const bool fueled = GENERATE( false, true );
    if( fueled ) {
        const int tank = veh->install_part( here, point_rel_ms::zero,
                                            vpart_id( "small_pressure_tank" ) );
        REQUIRE( tank >= 0 );
        veh->part( tank ).ammo_set( itype_id( "propane" ), 10 );
    }
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    heater source{};
    source.consume_flag = true;
    source.pseudo_flag = true;
    source.heating_effect = 2;
    source.fuel_type = itype_id( "propane" );
    source.vpt = here.get_abs( pos );
    item_location food = you.i_add( item( itype_id( "meat_cooked" ) ) );
    REQUIRE( food );
    heating_requirements cost{ 250_ml, 1, 100 };
    you.assign_activity( heat_activity_actor( { { food, 1 } }, cost, source ) );

    you.activity.actor->finish( you.activity, you );

    CHECK_FALSE( you.activity );
    CHECK( veh->fuel_left( here, itype_id( "propane" ) ) == ( fueled ? 8 : 0 ) );
    CHECK( veh->fuel_left( here, itype_id( "battery" ) ) == 100 );
    if( !fueled ) {
        REQUIRE( food );
        CHECK_FALSE( food->has_flag( flag_id( "HOT" ) ) );
    }
}
