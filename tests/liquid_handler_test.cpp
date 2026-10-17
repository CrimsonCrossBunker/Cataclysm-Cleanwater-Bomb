#include <utility>

#include "enums.h"
#include "flexbuffer_json.h"
#include <initializer_list>

#include "avatar.h"
#include "cached_options.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "coordinates.h"
#include "flag.h"
#include "handle_liquid.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "stomach.h"
#include "type_id.h"
#include "units.h"

// *INDENT-OFF*
static const itype_id itype_test_liquid_1ml( "test_liquid_1ml" );
static const itype_id itype_test_watertight_open_sealed_container_250ml( "test_watertight_open_sealed_container_250ml" );
static const itype_id itype_gasoline( "gasoline" );
static const itype_id itype_water_clean( "water_clean" );
// *INDENT-ON*

TEST_CASE( "temporary_liquid_drinks_apply_each_serving", "[liquid][handler]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.set_thirst( 500 );
    item water{ itype_water_clean };
    water.charges = 3;
    for( int remaining = 2; remaining >= 0; --remaining ) {
        liquid_dest_opt target;
        target.dest_opt = LD_CONSUME;
        const auto before = you.stomach.get_water();
        const int moves = you.get_moves();
        REQUIRE( liquid_handler::handle_liquid( water, target, nullptr, 0 ) );
        CHECK( water.charges == remaining );
        CHECK( you.stomach.get_water() > before );
        CHECK( you.get_moves() < moves );
    }
}

// handle_liquid should return false when a pre-set LD_ITEM target is full
// and pour_into fails. Before the fix, handle_item_target unconditionally
// returned true, causing infinite loops in callers like handle_liquid_or_spill.
TEST_CASE( "handle_liquid_returns_false_when_target_container_is_full",
           "[liquid][handler]" )
{
    avatar &dummy = get_avatar();
    map &here = get_map();

    clear_avatar();
    clear_map_without_vision();

    const tripoint_bub_ms player_pos = dummy.pos_bub();
    const tripoint_bub_ms container_pos = player_pos + tripoint::east;

    // Create a container and fill it to capacity
    item container( itype_test_watertight_open_sealed_container_250ml );
    item filler( itype_test_liquid_1ml );
    filler.charges = 250;
    REQUIRE( container.fill_with( filler, 250 ) > 0 );
    // Verify it's actually full
    REQUIRE( container.get_remaining_capacity_for_liquid( item( itype_test_liquid_1ml ), true ) == 0 );

    // Place the full container on the map and get an item_location for it
    here.add_item_or_charges( container_pos, container );
    map_stack items_at = here.i_at( container_pos );
    REQUIRE( !items_at.empty() );
    item_location cont_loc( map_cursor( container_pos ), &items_at.only_item() );
    REQUIRE( cont_loc.get_item() != nullptr );

    // Create liquid to pour
    item liquid( itype_test_liquid_1ml );
    liquid.charges = 10;

    // Pre-set the liquid target to the full container
    liquid_dest_opt target;
    target.dest_opt = LD_ITEM;
    target.item_loc = cont_loc;

    const int moves_before = dummy.get_moves();
    const int charges_before = liquid.charges;

    bool result = liquid_handler::handle_liquid( liquid, target, nullptr, 0 );

    CHECK_FALSE( result );
    CHECK( liquid.charges == charges_before );
    CHECK( dummy.get_moves() == moves_before );
}

TEST_CASE( "no_reload_container_rejects_poured_liquid", "[liquid][handler]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos = you.pos_bub() + tripoint::east;

    item container( itype_test_watertight_open_sealed_container_250ml );
    item liquid( itype_test_liquid_1ml );
    liquid.charges = 10;
    REQUIRE( container.get_remaining_capacity_for_liquid( liquid, true ) > 0 );
    container.set_flag( flag_NO_RELOAD );
    CHECK( container.get_remaining_capacity_for_liquid( liquid, true ) == 0 );
    here.add_item_or_charges( pos, container );
    item_location target_loc( map_cursor( pos ), &here.i_at( pos ).only_item() );
    liquid_dest_opt target;
    target.dest_opt = LD_ITEM;
    target.item_loc = target_loc;

    CHECK_FALSE( liquid_handler::handle_liquid( liquid, target, nullptr, 0 ) );
    CHECK( liquid.charges == 10 );
    CHECK( target_loc->empty() );
}

TEST_CASE( "cold_gasoline_can_be_split_between_containers", "[liquid][handler]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    item gasoline( itype_gasoline );
    gasoline.charges = 15401;
    gasoline.set_item_temperature( units::from_celsius( -20 ) );
    REQUIRE( gasoline.made_of( phase_id::LIQUID ) );
    REQUIRE( liquid_handler::can_handle_liquid( gasoline ) );

    item first( itype_test_watertight_open_sealed_container_250ml );
    const int first_amount = first.get_remaining_capacity_for_liquid( gasoline, true );
    REQUIRE( first_amount > 0 );
    const int first_fill = first.fill_with( gasoline, first_amount / 2 );
    REQUIRE( first_fill > 0 );
    gasoline.charges -= first_fill;
    const tripoint_bub_ms first_pos = you.pos_bub() + tripoint::east;
    const tripoint_bub_ms second_pos = you.pos_bub() + tripoint::west;
    here.add_item_or_charges( first_pos, first );
    here.add_item_or_charges( second_pos, item( itype_test_watertight_open_sealed_container_250ml ) );
    item_location first_loc( map_cursor( first_pos ), &here.i_at( first_pos ).only_item() );
    item_location second_loc( map_cursor( second_pos ), &here.i_at( second_pos ).only_item() );

    REQUIRE( you.pour_into( first_loc, gasoline, true, true ) );
    CHECK( first_loc->only_item().charges > first_fill );
    REQUIRE( you.pour_into( second_loc, gasoline, true, true ) );
    CHECK( second_loc->only_item().charges > 0 );
    CHECK( gasoline.charges + first_loc->only_item().charges +
           second_loc->only_item().charges == 15401 );
}

TEST_CASE( "saved_frozen_fuel_recovers_its_liquid_phase", "[liquid][save]" )
{
    item gasoline( itype_gasoline );
    gasoline.charges = 15401;
    gasoline.set_item_temperature( units::from_celsius( -80 ) );
    REQUIRE( gasoline.is_frozen_liquid() );

    item loaded;
    deserialize_from_string( loaded, serialize( gasoline ) );
    CHECK( loaded.charges == 15401 );
    CHECK_FALSE( loaded.is_frozen_liquid() );
    CHECK( loaded.made_of( phase_id::LIQUID ) );
    CHECK( liquid_handler::can_handle_liquid( loaded ) );

    gasoline.unset_flag( flag_FROZEN );
    REQUIRE( gasoline.is_frozen_liquid() );
    deserialize_from_string( loaded, serialize( gasoline ) );
    CHECK( loaded.made_of( phase_id::LIQUID ) );

    item water( itype_water_clean );
    water.set_item_temperature( units::from_celsius( -20 ) );
    REQUIRE( water.is_frozen_liquid() );
    item loaded_water;
    deserialize_from_string( loaded_water, serialize( water ) );
    CHECK( loaded_water.is_frozen_liquid() );
}

TEST_CASE( "hydrocarbon_fuels_remain_liquid_in_cold_weather", "[liquid][temperature]" )
{
    for( const std::pair<itype_id, int> &fuel : {
    std::pair<itype_id, int> { itype_id( "diesel" ), -20 },
    { itype_id( "jp8" ), -47 }, { itype_id( "avgas" ), -58 },
    { itype_id( "biodiesel" ), -10 }, { itype_id( "gasoline" ), -60 },
    { itype_id( "lamp_oil" ), -47 }, { itype_id( "crude_lamp_oil" ), -40 },
    { itype_id( "motor_oil" ), -30 }, { itype_id( "crude_oil" ), -40 },
    { itype_id( "napalm" ), -40 }, { itype_id( "gelled_gasoline" ), -60 },
    { itype_id( "flamethrower_fuel" ), -60 }
         } ) {
        CAPTURE( fuel.first.str() );
        item liquid( fuel.first );
        liquid.set_item_temperature( units::from_celsius( fuel.second + 10 ) );
        CHECK( liquid.made_of( phase_id::LIQUID ) );
        CHECK( liquid_handler::can_handle_liquid( liquid ) );
        liquid.set_item_temperature( units::from_celsius( fuel.second - 10 ) );
        CHECK( liquid.is_frozen_liquid() );
    }
}

// Regression guard: on_pickup with a spillable container should handle all
// liquid without hanging. Exercises the real item_pocket::on_pickup ->
// handle_liquid_or_spill production path.
TEST_CASE( "on_pickup_spillable_container_handles_all_liquid",
           "[liquid][spill]" )
{
    avatar &dummy = get_avatar();
    map &here = get_map();

    clear_avatar();
    clear_map_without_vision();

    restore_on_out_of_scope<test_mode_spilling_action_t> restore_spill( test_mode_spilling_action );
    test_mode_spilling_action = test_mode_spilling_action_t::spill_all;

    // Create a spillable container with liquid
    item container( itype_test_watertight_open_sealed_container_250ml );
    item liquid( itype_test_liquid_1ml );
    liquid.charges = 5;
    REQUIRE( container.put_in( liquid, pocket_type::CONTAINER ).success() );
    REQUIRE( container.is_bucket_nonempty() );

    // Call the real on_pickup path
    container.on_pickup( dummy );

    // All liquid should have been handled (spilled to ground in test mode)
    CHECK( container.is_container_empty() );

    // Liquid should be on the ground at player position
    bool found_liquid = false;
    for( const item &ground_item : here.i_at( dummy.pos_bub() ) ) {
        if( ground_item.typeId() == itype_test_liquid_1ml ) {
            found_liquid = true;
            break;
        }
    }
    CHECK( found_liquid );
}
