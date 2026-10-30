#include <optional>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "craft_command.h"
#include "crafting.h"
#include "item.h"
#include "item_components.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_iterator.h"
#include "player_helpers.h"
#include "point.h"
#include "recipe.h"
#include "requirements.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

static const furn_str_id furn_f_sample_freezer( "f_sample_freezer" );
static const furn_str_id furn_f_workbench( "f_workbench" );
static const itype_id itype_2x4( "2x4" );
static const itype_id itype_soldering_iron_portable( "soldering_iron_portable" );
static const recipe_id recipe_cudgel_test_charged_fast_stepless(
    "cudgel_test_charged_fast_stepless" );
static const skill_id skill_fabrication( "fabrication" );
static const ter_str_id ter_t_pavement( "t_pavement" );
static const ter_str_id ter_t_rock( "t_rock" );
static const trait_id trait_DEBUG_CNF( "DEBUG_CNF" );
static const trait_id trait_DEBUG_HS( "DEBUG_HS" );
static const vpart_id vpart_cargo_space( "cargo_space" );
static const vpart_id vpart_frame( "frame" );
static const vproto_id vehicle_prototype_none( "none" );

// Item volume overrides use units of 250 ml.  Two separate boards can fit on
// nearby tiles while their combined in-progress craft exceeds one tile.
static item board_with_volume( int quarter_liters )
{
    item board( itype_2x4 );
    board.set_var( "volume", quarter_liters );
    return board;
}

TEST_CASE( "craft_placement_is_checked_before_material_and_tool_debits",
           "[crafting][placement]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    you.setpos( here, origin );
    you.toggle_trait( trait_DEBUG_CNF );
    you.set_skill_level( skill_fabrication, 10 );
    const recipe &rec = recipe_cudgel_test_charged_fast_stepless.obj();
    you.learn_recipe( &rec );

    int board_volume = 2000;
    bool fits = true;
    SECTION( "exactly_one_thousand_liters" ) {}
    SECTION( "one_thousand_liters_plus_half_a_liter" ) {
        board_volume = 2001;
        fits = false;
    }
    SECTION( "oversized_batch" ) {
        board_volume = 2400;
        fits = false;
    }
    const tripoint_bub_ms supply_a = origin + tripoint( 3, 0, 0 );
    const tripoint_bub_ms supply_b = origin + tripoint( -3, 0, 0 );
    const tripoint_bub_ms tool_pos = origin + tripoint( 0, 3, 0 );
    REQUIRE_FALSE( here.add_item_or_charges( supply_a, board_with_volume( board_volume ) ).is_null() );
    REQUIRE_FALSE( here.add_item_or_charges( supply_b, board_with_volume( board_volume ) ).is_null() );
    item &tool = here.add_item_or_charges( tool_pos,
                                           tool_with_ammo( itype_soldering_iron_portable, 100 ) );
    item &second_tool = here.add_item_or_charges( tool_pos,
                        tool_with_ammo( itype_soldering_iron_portable, 100 ) );
    const auto remaining_charges = [&]() {
        return tool.ammo_remaining() + second_tool.ammo_remaining();
    };
    const int initial_charges = remaining_charges();
    REQUIRE( initial_charges >= 60 );
    REQUIRE_FALSE( you.has_trait( trait_DEBUG_HS ) );
    REQUIRE( you.can_make( &rec, 2 ) );
    REQUIRE( here.max_volume( origin ) == 1000_liter );

    craft_command command( &rec, 2, false, &you, origin );
    command.execute( true );
    item craft = command.create_in_progress_craft();
    CHECK( craft.is_null() == !fits );
    CHECK( here.i_at( supply_a ).empty() == fits );
    CHECK( here.i_at( supply_b ).empty() == fits );
    if( fits ) {
        CHECK( remaining_charges() < initial_charges );
        REQUIRE( craft.is_craft() );
        CHECK( craft.volume() == 1000_liter );
        CHECK_FALSE( here.add_item_or_charges( origin, craft, false ).is_null() );
    } else {
        CHECK( remaining_charges() == initial_charges );
        if( !craft.is_null() ) {
            return;
        }
        // A rejected large batch must leave its inputs usable for a smaller one.
        craft_command retry( &rec, 1, false, &you, origin );
        retry.execute( true );
        item smaller = retry.create_in_progress_craft();
        REQUIRE( smaller.is_craft() );
        CHECK( smaller.volume() == board_volume * 250_ml );
        CHECK_FALSE( here.add_item_or_charges( origin, smaller, false ).is_null() );
    }
}

TEST_CASE( "craft_placement_checks_ground_and_vehicle_destinations", "[crafting][placement]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    you.setpos( here, origin );
    item_components components;
    item board = board_with_volume( 200 );
    components.add( board );
    item craft( &recipe_cudgel_test_charged_fast_stepless.obj(), 1, components,
                std::vector<item_comp> {}, false );
    REQUIRE( craft.volume() == 50_liter );

    for( const tripoint_bub_ms &p : here.points_in_radius( origin, 2 ) ) {
        here.ter_set( p, ter_t_rock );
    }
    SECTION( "blocked_ground_does_not_accept_a_craft" ) {
        CHECK_FALSE( can_place_craft( you, craft, origin, false ) );
        CHECK_FALSE( can_place_craft( you, craft, std::nullopt, true ) );
    }
    SECTION( "nearby_workbench_overrides_the_supplied_target" ) {
        const tripoint_bub_ms distant_target = origin + tripoint( 10, 0, 0 );
        for( const tripoint_bub_ms &p : here.points_in_radius( distant_target, 2 ) ) {
            here.ter_set( p, ter_t_rock );
        }
        const tripoint_bub_ms bench = origin + tripoint::east;
        here.ter_set( bench, ter_t_pavement );
        here.furn_set( bench, furn_f_workbench );
        CHECK( can_place_craft( you, craft, distant_target, false ) );
    }
    SECTION( "forced_ground_placement_ignores_a_distant_target" ) {
        const tripoint_bub_ms distant_target = origin + tripoint( 10, 0, 0 );
        CHECK( can_place_craft( you, craft, distant_target, false ) );
        CHECK_FALSE( can_place_craft( you, craft, distant_target, true ) );
    }
    SECTION( "empty_hands_do_not_need_ground_space" ) {
        REQUIRE_FALSE( you.is_armed() );
        CHECK( can_place_craft( you, craft, std::nullopt, false ) );
    }
    SECTION( "vehicle_cargo_can_hold_a_craft_when_ground_cannot" ) {
        // Restore the mounting tile before creating the vehicle.
        here.ter_set( origin, ter_t_pavement );
        vehicle *veh = here.add_vehicle( vehicle_prototype_none, origin, 0_degrees, 0 );
        REQUIRE( veh != nullptr );
        REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
        const int cargo = veh->install_part( here, point_rel_ms::zero, vpart_cargo_space );
        REQUIRE( cargo >= 0 );
        here.add_vehicle_to_cache( veh );
        here.ter_set( origin, ter_t_rock );
        CHECK( can_place_craft( you, craft, origin, false ) );
        REQUIRE( veh->add_item( here, veh->part( cargo ), board_with_volume( 4000 ) ) );
        CHECK_FALSE( can_place_craft( you, craft, origin, false ) );
    }
}

TEST_CASE( "craft_placement_uses_destination_capacity_instead_of_a_fixed_volume_limit",
           "[crafting][placement]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms origin( 60, 60, 0 );
    you.setpos( here, origin );
    item_components components;
    item board = board_with_volume( 4800 );
    components.add( board );
    item craft( &recipe_cudgel_test_charged_fast_stepless.obj(), 1, components,
                std::vector<item_comp> {}, false );
    REQUIRE( craft.volume() == 1200_liter );
    CHECK_FALSE( can_place_craft( you, craft, origin, false ) );
    here.furn_set( origin, furn_f_sample_freezer );
    REQUIRE( here.free_volume( origin ) > craft.volume() );
    CHECK( can_place_craft( you, craft, origin, false ) );
    CHECK_FALSE( here.add_item_or_charges( origin, craft, false ).is_null() );
}
