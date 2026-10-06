#include <algorithm>
#include <initializer_list>
#include <list>
#include <utility>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "iuse.h"
#include "map.h"
#include "map_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "visitable.h"

static const flag_id json_flag_HOT( "HOT" );

static const itype_id itype_battery( "battery" );
static const itype_id itype_chemistry_set( "chemistry_set" );
static const itype_id itype_hotplate( "hotplate" );
static const itype_id itype_meat_cooked( "meat_cooked" );
static const itype_id itype_propane( "propane" );
static const itype_id itype_propane_cooker( "propane_cooker" );
static const itype_id itype_water_clean( "water_clean" );

static const vpart_id vpart_dashboard( "dashboard" );
static const vpart_id vpart_frame( "frame" );
static const vpart_id vpart_small_pressure_tank( "small_pressure_tank" );
static const vpart_id vpart_small_storage_battery( "small_storage_battery" );

static const vproto_id vehicle_prototype_none( "none" );

TEST_CASE( "chemistry_set_can_heat_with_its_hotplate", "[activity][heating]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    you.setpos( here, pos );
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    const int battery = veh->install_part( here, point_rel_ms::zero,
                                           vpart_small_storage_battery );
    REQUIRE( battery >= 0 );
    veh->part( battery ).ammo_set( itype_battery, 100 );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_dashboard ) >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    item_location kit = you.i_add( item( itype_chemistry_set ) );
    REQUIRE( kit );
    REQUIRE( kit->type->get_use( "HEAT_ALL_ITEMS" ) );
    const auto connection = kit->link_to( here.veh_at( pos ), link_state::vehicle_port );
    INFO( connection.str() );
    REQUIRE( connection.success() );
    const heater source = find_heater( &you, kit.get_item(), false );
    CHECK( source.available_heater == 100 );
    CHECK( source.heating_effect == 1 );
    CHECK( source.consume_flag );
    CHECK_FALSE( source.pseudo_flag );
    item_location food( map_cursor( pos ), &here.add_item_or_charges( pos,
                        item( itype_meat_cooked ) ) );
    REQUIRE( food );
    heating_requirements cost{ 250_ml, 1, 100 };
    you.assign_activity( heat_activity_actor( { { food, 1 } }, cost, source ) );
    you.activity.actor->finish( you.activity, you );
    CHECK_FALSE( you.activity );
    CHECK( veh->connected_battery_power_level( here ).first == 99 );
    const auto is_heated_food = []( const item & heated ) {
        return heated.typeId() == itype_meat_cooked && heated.has_flag( json_flag_HOT );
    };
    const map_stack ground_items = here.i_at( pos );
    CHECK( ( you.has_item_with( is_heated_food ) ||
             std::any_of( ground_items.begin(), ground_items.end(), is_heated_food ) ) );
}

TEST_CASE( "heating_completion_handles_removed_target", "[activity][heating]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &guy = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    item_location water( map_cursor( pos ), &here.add_item_or_charges( pos,
                         item( itype_water_clean ) ) );
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
    clear_map_without_vision();
    avatar &guy = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    item_location water( map_cursor( pos ), &here.add_item_or_charges( pos,
                         item( itype_water_clean ) ) );
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
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    const int battery = veh->install_part( here, point_rel_ms::zero,
                                           vpart_small_storage_battery );
    REQUIRE( battery >= 0 );
    const int battery_charge = GENERATE( 0, 100 );
    veh->part( battery ).ammo_set( itype_battery, battery_charge );
    const bool fueled = GENERATE( false, true );
    if( fueled ) {
        const point_rel_ms tank_mount( 1, 0 );
        REQUIRE( veh->install_part( here, tank_mount, vpart_frame ) >= 0 );
        const int tank = veh->install_part( here, tank_mount,
                                            vpart_small_pressure_tank );
        REQUIRE( tank >= 0 );
        veh->part( tank ).ammo_set( itype_propane, 10 );
    }
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    if( fueled ) {
        item cooker( itype_propane_cooker );
        REQUIRE( veh->prepare_tool( here, cooker ) > 0 );
        const heater selected = find_heater( &you, &cooker, true );
        CHECK( selected.available_heater > 0 );
        CHECK( selected.fuel_type == itype_propane );
        const heater indirect = find_vehicle_heater( pos, cooker );
        CHECK( indirect.pseudo_flag );
        CHECK( indirect.available_heater == 10 );
        CHECK( indirect.heating_effect == 2 );
        CHECK( indirect.fuel_type == itype_propane );
        CHECK( indirect.vpt == here.get_abs( pos ) );
        const heater electric = find_vehicle_heater( pos, item( itype_hotplate ) );
        CHECK( electric.available_heater == battery_charge );
        CHECK( electric.fuel_type == itype_battery );
    }
    heater source{};
    source.consume_flag = true;
    source.pseudo_flag = true;
    source.heating_effect = 2;
    source.fuel_type = itype_propane;
    source.vpt = here.get_abs( pos );
    item_location food = you.i_add( item( itype_meat_cooked ) );
    REQUIRE( food );
    heating_requirements cost{ 250_ml, 1, 100 };
    you.assign_activity( heat_activity_actor( { { food, 1 } }, cost, source ) );

    you.activity.actor->do_turn( you.activity, you );
    CHECK( static_cast<bool>( you.activity ) == fueled );
    if( you.activity ) {
        you.activity.actor->finish( you.activity, you );
    }

    CHECK_FALSE( you.activity );
    CHECK( veh->fuel_left( here, itype_propane ) == ( fueled ? 8 : 0 ) );
    CHECK( veh->fuel_left( here, itype_battery ) == battery_charge );
    if( !fueled ) {
        REQUIRE( food );
        CHECK_FALSE( food->has_flag( json_flag_HOT ) );
    }
}
