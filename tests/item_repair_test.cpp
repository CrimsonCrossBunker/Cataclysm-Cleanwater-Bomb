#include <initializer_list>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "clone_ptr.h"
#include "coordinates.h"
#include "fault.h"
#include "item.h"
#include "item_location.h"
#include "item_repair.h"
#include "itype.h"
#include "iuse_actor.h"
#include "flexbuffer_json.h"
#include "iuse.h"
#include "point.h"
#include "value_ptr.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "rng.h"
#include "type_id.h"

static const activity_id ACT_MEND_ITEM( "ACT_MEND_ITEM" );
static const activity_id ACT_REPAIR_ITEM( "ACT_REPAIR_ITEM" );
static const fault_fix_id fault_fix_mend_blade_grind( "mend_blade_grind" );
static const fault_fix_id
fault_fix_mend_fault_fail_to_feed_manual_feed( "mend_fault_fail_to_feed_manual_feed" );
static const fault_fix_id fault_fix_mend_spearhead_grind( "mend_spearhead_grind" );
static const fault_fix_id fault_fix_mend_spearhead_straighten( "mend_spearhead_straighten" );
static const fault_id fault_blade_cracked( "fault_blade_cracked" );
static const fault_id fault_blade_rolled_edge( "fault_blade_rolled_edge" );
static const fault_id fault_fail_to_feed( "fault_fail_to_feed" );
static const fault_id fault_spearhead_bent_socket( "fault_spearhead_bent_socket" );
static const fault_id fault_spearhead_chipping( "fault_spearhead_chipping" );
static const fault_id fault_spearhead_warped( "fault_spearhead_warped" );
static const itype_id itype_glock_19( "glock_19" );
static const itype_id itype_integrated_welder( "integrated_welder" );
static const itype_id itype_knife_combat( "knife_combat" );
static const itype_id itype_magazine_battery_mod( "magazine_battery_mod" );
static const itype_id itype_mc_steel_chunk( "mc_steel_chunk" );
static const itype_id itype_metal_honing_rod( "metal_honing_rod" );
static const itype_id itype_qt_spear_steel( "qt_spear_steel" );
static const itype_id itype_small_storage_battery( "small_storage_battery" );
static const itype_id itype_welding_kit( "welding_kit" );
static const ter_str_id ter_t_wall( "t_wall" );

static item welding_kit( int charges = 1000 )
{
    item tool( itype_welding_kit );
    REQUIRE( tool.put_in( item( itype_magazine_battery_mod ), pocket_type::MOD ).success() );
    item battery( itype_small_storage_battery );
    battery.ammo_set( battery.ammo_default(), charges );
    REQUIRE( tool.put_in( battery, pocket_type::MAGAZINE_WELL ).success() );
    return tool;
}

static item_location damaged_spear( Character &you )
{
    // Relevant fields from the reported save: ordinary damage, no degradation or faults.
    item spear;
    spear.deserialize( json_loader::from_string(
                           R"({"typeid":"qt_spear_steel","damaged":2000})" ).get_object() );
    REQUIRE( you.wield( spear ) );
    return you.get_wielded_item();
}

static void supply_repair_materials( Character &you )
{
    const repair_item_actor *actor = dynamic_cast<const repair_item_actor *>(
                                         itype_welding_kit->get_use( "repair_metal" )->get_actor_ptr() );
    REQUIRE( actor );
    you.set_skill_level( actor->used_skill, 10 );
    for( int n = 0; n < 30; ++n ) {
        get_map().add_item_or_charges( you.pos_bub(), item( itype_mc_steel_chunk ) );
    }
    you.invalidate_crafting_inventory();
}

TEST_CASE( "item_repair_menu_starts_ordinary_damage_repair", "[item][repair][repair_menu]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );
    supply_repair_materials( you );
    const item_location tool = you.i_add( welding_kit() );

    REQUIRE( target->typeId() == itype_qt_spear_steel );
    REQUIRE( target->damage() == 2000 );
    REQUIRE( target->degradation() == 0 );
    REQUIRE( target->faults.empty() );
    you.mend_item( item_location( target ), false );
    REQUIRE( you.activity.id() == ACT_REPAIR_ITEM );
    REQUIRE( you.activity.targets.size() == 2 );
    CHECK( you.activity.targets[0] == tool );
    CHECK( you.activity.targets[1] == target );
    CHECK( you.activity.get_str_value( 0 ) == "repair_metal" );
    CHECK( you.activity.get_value( 0, 0 ) == 0 ); // Keep the normal repeat choice.
}

TEST_CASE( "item_repair_tools_preserve_tool_and_material_requirements",
           "[item][repair][repair_menu]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );
    item tool = welding_kit();
    bool available = true;
    bool discoverable = true;

    SECTION( "carried_tool" ) {
        supply_repair_materials( you );
        you.i_add( tool );
    }
    SECTION( "ground_tool" ) {
        supply_repair_materials( you );
        get_map().add_item_or_charges( you.pos_bub(), tool );
    }
    SECTION( "missing_components" ) {
        you.i_add( tool );
        available = false;
    }
    SECTION( "no_power" ) {
        supply_repair_materials( you );
        you.i_add( welding_kit( 0 ) );
        available = false;
    }
    SECTION( "integrated_welder_does_not_repair_tempered_steel" ) {
        supply_repair_materials( you );
        you.i_add( item( itype_integrated_welder ) );
        discoverable = false;
    }
    SECTION( "out_of_reach" ) {
        supply_repair_materials( you );
        get_map().add_item_or_charges( you.pos_bub() + point( 2, 0 ), tool );
        discoverable = false;
    }
    SECTION( "behind_a_wall" ) {
        supply_repair_materials( you );
        const tripoint_bub_ms pos = you.pos_bub() + point::east;
        get_map().ter_set( pos, ter_t_wall );
        get_map().add_item_or_charges( pos, tool );
        discoverable = false;
    }
    you.invalidate_crafting_inventory();
    const std::vector<item_repair::tool_option> options = item_repair::tools_for( you, target );
    if( !discoverable ) {
        CHECK( options.empty() );
    } else {
        REQUIRE( options.size() == 1 );
        CHECK( options[0].available == available );
        if( available ) {
            REQUIRE( item_repair::start( you, target, options[0] ) );
            CHECK( you.activity.targets[0] == options[0].tool );
            CHECK( you.activity.targets[1] == target );
        }
    }
    if( !discoverable || !available ) {
        you.mend_item( item_location( target ), false );
        CHECK( you.activity.is_null() );
        CHECK( target->damage() == 2000 );
    }
}

TEST_CASE( "item_repair_fault_mending_remains_available", "[item][repair][repair_menu]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );
    supply_repair_materials( you );
    you.i_add( welding_kit() );
    target->set_fault( fault_spearhead_bent_socket, true, nullptr, true );
    REQUIRE( target->has_fault( fault_spearhead_bent_socket ) );
    you.mend_item( item_location( target ), false );
    CHECK( you.activity.id() == ACT_MEND_ITEM );
}

TEST_CASE( "item_repair_restores_faultless_combat_wear_to_full", "[item][repair][repair_menu]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );
    supply_repair_materials( you );
    item_location tool = you.i_add( welding_kit() );
    const repair_item_actor *actor = dynamic_cast<const repair_item_actor *>(
                                         tool->get_use( "repair_metal" )->get_actor_ptr() );
    REQUIRE( actor );
    restore_on_out_of_scope<cata_default_random_engine> restore_engine( rng_get_engine() );
    const unsigned seed = 20261012;
    CAPTURE( seed );
    rng_set_engine_seed( seed );

    // The saved state and two later wear/repair cycles use the normal repair activity.
    for( int cycle = 0; cycle < 3; ++cycle ) {
        if( cycle > 0 ) {
            // Accelerate wear attempts, without changing the actual fault selection rules.
            for( int attempt = 0; attempt < 30 && target->damage() == 0; ++attempt ) {
                you.handle_melee_wear( target, 100000.0f );
                if( !target->faults.empty() ) {
                    // Discard faulted samples to exercise ordinary damage specifically.
                    you.remove_weapon();
                    item fresh( itype_qt_spear_steel );
                    REQUIRE( you.wield( fresh ) );
                    target = you.get_wielded_item();
                }
            }
        }
        REQUIRE( target->damage() > 0 );
        REQUIRE( target->degradation() == 0 );
        REQUIRE( target->faults.empty() );
        REQUIRE( actor->repair_chance( you, *target, repair_item_actor::RT_REPAIR ).second == 0.0f );
        const int charge_before = tool->ammo_remaining();
        you.mend_item( item_location( target ), false );
        REQUIRE( you.activity.id() == ACT_REPAIR_ITEM );
        you.activity.values = { 3 }; // Existing "repeat until fully repaired" activity choice.
        for( int attempt = 0; attempt < 100 && !you.activity.is_null(); ++attempt ) {
            repair_item_finish( &you.activity, &you, true );
            if( !you.activity.is_null() ) {
                CHECK( you.activity.moves_left == actor->move_cost );
            }
        }
        CHECK( you.activity.is_null() );
        CHECK( target->damage() == 0 );
        CHECK( target->degradation() == 0 );
        CHECK( target->faults.empty() );
        CHECK( tool->ammo_remaining() < charge_before );
    }
}

// Complete the real activity so requirements, fault removal and durability changes run.
static void finish_mending( Character &you, const item_location &target,
                            const fault_id &fault, const fault_fix_id &fix )
{
    REQUIRE( target->has_fault( fault ) );
    you.assign_activity( mend_item_activity_actor( fix->time, target, fault, fix ) );
    you.activity.actor->finish( you.activity, you );
    REQUIRE( you.activity.is_null() );
}

TEST_CASE( "item_mending_restores_residual_wear_after_the_last_fault",
           "[item][repair][repair_menu][mending]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );

    for( const int damage : {
             1000, 1250, 2000, 3250
         } ) {
        CAPTURE( damage );
        // Reduced fault rates and blocked faults leave more wear than faults.
        // Reuse one weapon through repeated cycles, without a separate repair kit.
        target->force_set_damage( damage );
        REQUIRE( target->set_fault( fault_spearhead_bent_socket, false, nullptr, true ) );
        finish_mending( you, target, fault_spearhead_bent_socket,
                        fault_fix_mend_spearhead_straighten );
        CHECK( target->faults.empty() );
        CHECK( target->degradation() == 0 );
        CHECK( target->damage() == 0 );
    }
}

TEST_CASE( "item_mending_restores_residual_wear_only_after_all_mechanical_faults",
           "[item][repair][repair_menu][mending]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );
    target->force_set_damage( 3250 );
    REQUIRE( target->set_fault( fault_spearhead_bent_socket, false, nullptr, true ) );
    REQUIRE( target->set_fault( fault_spearhead_chipping, false, nullptr, true ) );
    REQUIRE( target->set_fault( fault_spearhead_warped, false, nullptr, true ) );
    get_map().add_item_or_charges( you.pos_bub(), item( itype_metal_honing_rod ) );
    you.invalidate_crafting_inventory();

    finish_mending( you, target, fault_spearhead_bent_socket,
                    fault_fix_mend_spearhead_straighten );
    CHECK( target->damage() == 2250 );
    CHECK( target->has_fault( fault_spearhead_chipping ) );
    CHECK( target->has_fault( fault_spearhead_warped ) );
    finish_mending( you, target, fault_spearhead_chipping, fault_fix_mend_spearhead_grind );
    CHECK( target->faults.empty() );
    CHECK( target->damage() == 0 );
}

TEST_CASE( "item_mending_preserves_requirements_for_full_repair",
           "[item][repair][repair_menu][mending]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item_location target = damaged_spear( you );
    REQUIRE( target->set_fault( fault_spearhead_chipping, false, nullptr, true ) );

    finish_mending( you, target, fault_spearhead_chipping, fault_fix_mend_spearhead_grind );
    CHECK( target->damage() == 2000 );
    CHECK( target->has_fault( fault_spearhead_chipping ) );
    get_map().add_item_or_charges( you.pos_bub(), item( itype_metal_honing_rod ) );
    you.invalidate_crafting_inventory();
    finish_mending( you, target, fault_spearhead_chipping, fault_fix_mend_spearhead_grind );
    CHECK( target->faults.empty() );
    CHECK( target->damage() == 0 );
}

TEST_CASE( "item_mending_does_not_bypass_irreparable_faults",
           "[item][repair][repair_menu][mending]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item knife( itype_knife_combat );
    REQUIRE( you.wield( knife ) );
    item_location target = you.get_wielded_item();
    target->force_set_damage( 3250 );
    REQUIRE( target->set_fault( fault_blade_cracked, false, nullptr, true ) );
    REQUIRE( fault_blade_cracked->get_fixes().empty() );
    REQUIRE( target->set_fault( fault_blade_rolled_edge, false, nullptr, true ) );
    get_map().add_item_or_charges( you.pos_bub(), item( itype_metal_honing_rod ) );
    you.invalidate_crafting_inventory();

    finish_mending( you, target, fault_blade_rolled_edge, fault_fix_mend_blade_grind );
    CHECK_FALSE( target->has_fault( fault_blade_rolled_edge ) );
    CHECK( target->has_fault( fault_blade_cracked ) );
    CHECK( target->degradation() == fault_blade_cracked->degradation_mod() );
    CHECK( target->damage() == 2250 );
}

TEST_CASE( "item_mending_a_gun_malfunction_does_not_restore_durability",
           "[item][repair][repair_menu][mending]" )
{
    clear_avatar();
    clear_map_without_vision();
    set_time_to_day();
    Character &you = get_player_character();
    item gun( itype_glock_19 );
    REQUIRE( you.wield( gun ) );
    item_location target = you.get_wielded_item();
    target->force_set_damage( 2000 );
    REQUIRE( target->set_fault( fault_fail_to_feed, true, nullptr, true ) );

    finish_mending( you, target, fault_fail_to_feed,
                    fault_fix_mend_fault_fail_to_feed_manual_feed );
    CHECK( target->faults.empty() );
    CHECK( target->damage() == 2000 );
}
