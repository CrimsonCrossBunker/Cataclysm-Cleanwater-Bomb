#include <string>

#include "activity_type.h"
#include "avatar.h"
#include "calendar.h"
#include "character_attire.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "clzones.h"
#include "flexbuffer_json.h"
#include "field_type.h"
#include "game.h"
#include "effect.h"
#include "json_loader.h"
#include "item.h"
#include "item_category.h"
#include "item_pocket.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_selector.h"
#include "monster.h"
#include "npc.h"
#include "npc_attack.h"
#include "options_helpers.h"
#include "pocket_type.h"
#include "player_helpers.h"
#include "type_id.h"

static const faction_id followers( "your_followers" );

TEST_CASE( "npc_autonomy_respects_pickup_authorization", "[npc][autonomy]" )
{
    clear_map_without_vision();
    npc &guy = spawn_npc( { 50, 50 }, "test_talker" );
    clear_character( guy, true );
    guy.set_fac( followers );
    guy.set_attitude( NPCATT_FOLLOW );
    REQUIRE( guy.is_player_ally() );
    CHECK( npc_follower_rules().has_flag( ally_rule::allow_pick_up ) );
    guy.rules.clear_flag( ally_rule::allow_pick_up );
    guy.find_item();
    CHECK_FALSE( guy.fetching_item );
    item private_item( itype_id( "knife_large" ) );
    private_item.set_owner( faction_id( "free_merchants" ) );
    CHECK_FALSE( guy.would_take_that( private_item, guy.pos_bub() ) );
}

TEST_CASE( "npc_autonomy_supply_limits_and_container_contents", "[npc][autonomy]" )
{
    clear_map_without_vision();
    npc &guy = spawn_npc( { 50, 50 }, "test_talker" );
    clear_character( guy, true );
    guy.set_fac( followers );
    guy.refresh_autonomous_inventory( true );
    item water( itype_id( "water_clean" ) );
    REQUIRE( water.count_by_charges() );
    water.charges = 1000;
    const int amount = guy.autonomous_pickup_quantity( water );
    REQUIRE( amount > 0 );
    CHECK( amount < water.charges );
    CHECK( amount == npc_autonomy::missing_units( 0, 240, water.get_comestible()->quench ) );
    guy.autonomy.water_quench = 240;
    CHECK( guy.autonomous_pickup_quantity( water ) == 0 );
    guy.autonomy.water_quench = 0;
    item bottle( itype_id( "bottle_plastic" ) );
    guy.autonomy.quantities[bottle.typeId()] = 1;
    water.charges = 1;
    REQUIRE( bottle.put_in( water, pocket_type::CONTAINER ).success() );
    CHECK( guy.autonomous_pickup_quantity( bottle ) == 1 );
    item medicine( itype_id( "aspirin" ) );
    CHECK( guy.autonomous_pickup_quantity( medicine ) == 0 );
}

TEST_CASE( "npc_autonomy_rejects_duplicate_tool_stockpiles", "[npc][autonomy]" )
{
    clear_map_without_vision();
    npc &guy = spawn_npc( { 50, 50 }, "test_talker" );
    clear_character( guy, true );
    guy.set_fac( followers );
    guy.refresh_autonomous_inventory( true );
    item knife( itype_id( "knife_large" ) );
    guy.autonomy.quantities[knife.typeId()] = 1;
    CHECK( guy.autonomous_pickup_quantity( knife ) == 0 );
}

TEST_CASE( "npc_autonomy_follows_free_positions_not_the_leader_tile", "[npc][autonomy]" )
{
    clear_map_without_vision();
    npc &guy = spawn_npc( { 50, 50 }, "test_talker" );
    clear_character( guy, true );
    guy.set_fac( followers );
    guy.set_attitude( NPCATT_FOLLOW );
    map &here = get_map();
    get_avatar().setpos( here, guy.pos_bub() + tripoint( 4, 0, 0 ) );
    const tripoint_bub_ms destination = guy.autonomous_follow_position();
    CHECK( destination != get_avatar().pos_bub() );
    CHECK( rl_dist( destination, get_avatar().pos_bub() ) <= 3 );
}

TEST_CASE( "npc_autonomy_partial_pickup_conserves_ground_charges", "[npc][autonomy][pickup]" )
{
    clear_map_without_vision();
    npc &guy = spawn_npc( { 50, 50 }, "test_talker" );
    clear_character( guy, true );
    guy.set_fac( followers );
    guy.worn.wear_item( guy, item( itype_id( "debug_backpack" ) ), false, false );
    guy.refresh_autonomous_inventory( true );
    item ammo( itype_id( "9mm" ) );
    ammo.charges = 1000;
    guy.autonomy.ammo_targets[ammo.ammo_type()] = 30;
    map &here = get_map();
    const tripoint_bub_ms p = guy.pos_bub() + point::east;
    here.add_item_or_charges( p, ammo );
    const std::list<item> picked = guy.pick_up_item_map( p );
    REQUIRE( picked.size() == 1 );
    CHECK( picked.front().charges == 30 );
    int remainder = 0;
    for( const item &left : here.i_at( p ) ) {
        remainder += left.charges;
    }
    CHECK( remainder == 970 );
    // This helper returns detached items; the caller still commits them to inventory.
    CHECK( guy.charges_of( ammo.typeId() ) == 0 );
}

TEST_CASE( "npc_autonomy_rescue_reservations_expire", "[npc][autonomy][medical]" )
{
    clear_map_without_vision();
    set_time_to_day();
    npc &medic = spawn_npc( { 50, 50 }, "test_talker" );
    npc &other = spawn_npc( { 51, 50 }, "test_talker" );
    clear_character( medic, true );
    clear_character( other, true );
    medic.set_fac( followers );
    other.set_fac( followers );
    medic.autonomy.rescue_patient = get_avatar().getID();
    medic.autonomy.rescue_until = calendar::turn + 5_seconds;
    REQUIRE( other.sees( get_map(), medic ) );
    CHECK( other.autonomous_patient_reserved( get_avatar() ) );
    medic.autonomy.rescue_until = calendar::turn - 1_seconds;
    CHECK_FALSE( other.autonomous_patient_reserved( get_avatar() ) );
}

namespace
{
npc &autonomy_test_follower( const point_bub_ms &where )
{
    npc &guy = spawn_npc( where, "test_talker" );
    clear_character( guy, true );
    guy.set_fac( followers );
    guy.set_attitude( NPCATT_FOLLOW );
    get_avatar().setpos( get_map(), tripoint_bub_ms( 50, 52, 0 ) );
    set_time_to_day();
    guy.set_moves( 0 );
    return guy;
}

void complete_autonomy_plan( npc &guy )
{
    for( int turn = 0; turn < 1000 && guy.autonomy.plan.task != npc_autonomy_task::none; ++turn ) {
        guy.set_moves( 100 );
        guy.autonomous_continue_plan();
    }
    REQUIRE( guy.autonomy.plan.task == npc_autonomy_task::none );
}
}

TEST_CASE( "npc_autonomy_loaded_backpack_change_preserves_belongings", "[npc][autonomy][equipment]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    item old_pack( itype_id( "backpack" ) );
    REQUIRE( old_pack.put_in( item( itype_id( "knife_large" ) ), pocket_type::CONTAINER ).success() );
    const auto worn = guy.wear_item( old_pack, false );
    REQUIRE( worn.has_value() );
    const item_location previous( guy, &**worn );
    item_location candidate = guy.i_add( item( itype_id( "debug_backpack" ) ) );
    REQUIRE( candidate );
    const int knives = guy.amount_of( itype_id( "knife_large" ) );
    const int packs = guy.amount_of( itype_id( "backpack" ) );
    REQUIRE( guy.sees( get_map(), get_avatar() ) );
    guy.autonomous_plan_equipment( candidate, previous );
    REQUIRE( guy.autonomy.plan.task == npc_autonomy_task::equipment );
    CHECK( guy.is_worn( *previous ) );
    CHECK( guy.autonomy.plan.work_done == 0 );
    CHECK( guy.autonomy.announced_actions.empty() );

    SECTION( "boarding suspends the plan without moving items" ) {
        guy.in_vehicle = true;
        guy.set_moves( 100 );
        CHECK_FALSE( guy.autonomous_continue_plan() );
        CHECK( guy.get_moves() == 100 );
        CHECK( guy.is_worn( *previous ) );
        CHECK( guy.amount_of( itype_id( "knife_large" ) ) == knives );
        guy.in_vehicle = false;
    }
    SECTION( "separation does not stop a carried equipment change" ) {
        get_avatar().setpos( get_map(), guy.pos_bub() + tripoint( 15, 0, 0 ) );
        guy.set_moves( 100 );
        CHECK( guy.autonomous_continue_plan() );
        CHECK( guy.get_moves() < 100 );
    }
    SECTION( "favorite changes cancel before detaching anything" ) {
        candidate->is_favorite = true;
        guy.set_moves( 100 );
        CHECK_FALSE( guy.autonomous_continue_plan() );
        CHECK( guy.autonomy.plan.task == npc_autonomy_task::none );
        CHECK( guy.is_worn( *previous ) );
        CHECK( guy.amount_of( itype_id( "knife_large" ) ) == knives );
        return;
    }
    complete_autonomy_plan( guy );
    CHECK( guy.amount_of( itype_id( "knife_large" ) ) == knives );
    CHECK( guy.amount_of( itype_id( "backpack" ) ) == packs );
    bool wearing_upgrade = false;
    for( const item_location &loc : guy.worn.top_items_loc( guy ) ) {
        wearing_upgrade |= loc->typeId() == itype_id( "debug_backpack" );
    }
    CHECK( wearing_upgrade );
}

TEST_CASE( "npc_autonomy_will_not_replace_a_favorite_backpack", "[npc][autonomy][equipment]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    item old_pack( itype_id( "backpack" ) );
    old_pack.is_favorite = true;
    const auto worn = guy.wear_item( old_pack, false );
    REQUIRE( worn );
    const item_location previous( guy, &**worn );
    item_location candidate = guy.i_add( item( itype_id( "debug_backpack" ) ) );
    REQUIRE( candidate );
    CHECK_FALSE( guy.autonomous_plan_equipment( candidate, previous ) );
    CHECK( guy.autonomy.plan.task == npc_autonomy_task::none );
    CHECK( guy.is_worn( *previous ) );
}

TEST_CASE( "npc_autonomy_sharing_requires_bilateral_permission_and_conserves_supplies",
           "[npc][autonomy][supplies]" )
{
    clear_map_without_vision();
    npc &donor = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &recipient = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    REQUIRE( donor.wear_item( item( itype_id( "debug_backpack" ) ), false ) );
    REQUIRE( recipient.wear_item( item( itype_id( "debug_backpack" ) ), false ) );
    item medicine( itype_id( "bandages" ) );
    REQUIRE_FALSE( medicine.count_by_charges() );
    for( int count = 0; count < 12; ++count ) {
        REQUIRE( donor.i_add( medicine ) );
    }
    REQUIRE( donor.rules.has_flag( ally_rule::share_supplies ) );
    REQUIRE( recipient.rules.has_flag( ally_rule::share_supplies ) );
    donor.rules.clear_flag( ally_rule::share_supplies );
    CHECK_FALSE( donor.autonomous_supply_step() );
    donor.rules.set_flag( ally_rule::share_supplies );
    recipient.rules.clear_flag( ally_rule::share_supplies );
    CHECK_FALSE( donor.autonomous_supply_step() );
    // The previous check consumed this low-frequency decision window.
    donor.autonomy.supplies_checked = calendar::before_time_starts;
    recipient.rules.set_flag( ally_rule::share_supplies );
    REQUIRE( donor.sees( get_map(), recipient ) );
    donor.autonomous_supply_step();
    REQUIRE( donor.autonomy.plan.task == npc_autonomy_task::share );
    CHECK( recipient.amount_of( medicine.typeId() ) == 0 );
    SECTION( "permission revoked during preparation" ) {
        recipient.rules.clear_flag( ally_rule::share_supplies );
        complete_autonomy_plan( donor );
        CHECK( recipient.amount_of( medicine.typeId() ) == 0 );
        CHECK( donor.amount_of( medicine.typeId() ) == 12 );
    }
    SECTION( "authorized transfer retains the donor reserve" ) {
        complete_autonomy_plan( donor );
        CHECK( recipient.amount_of( medicine.typeId() ) == 1 );
        CHECK( donor.amount_of( medicine.typeId() ) == 11 );
    }
}

TEST_CASE( "npc_autonomy_invalidated_plan_cannot_recreate_an_item", "[npc][autonomy][plan]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ) );
    item_location candidate = guy.i_add( item( itype_id( "backpack" ) ) );
    REQUIRE( candidate );
    guy.autonomy.plan.task = npc_autonomy_task::equipment;
    guy.autonomy.plan.source = candidate;
    guy.autonomy.plan.expires = calendar::turn + 1_minutes;
    guy.autonomy.plan.work_required = 100;
    candidate.remove_item();
    guy.set_moves( 100 );
    CHECK_FALSE( guy.autonomous_continue_plan() );
    CHECK( guy.get_moves() == 100 );
    CHECK( guy.autonomy.plan.task == npc_autonomy_task::none );
    CHECK( guy.amount_of( itype_id( "backpack" ) ) == 0 );
}

TEST_CASE( "npc_autonomy_organizes_real_nested_locations_without_losing_items",
           "[npc][autonomy][pockets]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ) );
    item slow_container( itype_id( "backpack" ) );
    REQUIRE( slow_container.put_in( item( itype_id( "bandages" ) ),
                                    pocket_type::CONTAINER ).success() );
    item_location container = guy.i_add( slow_container );
    REQUIRE( container );
    guy.autonomous_organize_step();
    REQUIRE( guy.autonomy.plan.task == npc_autonomy_task::organize );
    REQUIRE( guy.autonomy.plan.source.has_parent() );
    CHECK( guy.autonomy.plan.work_done == 0 );
    CHECK( guy.amount_of( itype_id( "bandages" ) ) == 1 );
    SECTION( "parent unload prohibition is rechecked" ) {
        guy.autonomy.plan.source.parent_pocket()->settings.set_unloadable( false );
        guy.set_moves( 100 );
        CHECK_FALSE( guy.autonomous_continue_plan() );
        CHECK( guy.get_moves() == 100 );
        CHECK_FALSE( container->empty_container() );
        CHECK( guy.amount_of( itype_id( "bandages" ) ) == 1 );
        return;
    }
    complete_autonomy_plan( guy );
    CHECK( container->empty_container() );
    CHECK( guy.amount_of( itype_id( "bandages" ) ) == 1 );
}

TEST_CASE( "npc_autonomy_defaults_need_no_individual_supply_permissions",
           "[npc][autonomy][rules]" )
{
    npc_follower_rules rules;
    CHECK( rules.has_flag( ally_rule::allow_pick_up ) );
    CHECK( rules.has_flag( ally_rule::share_supplies ) );
    CHECK( rules.has_flag( ally_rule::avoid_friendly_fire ) );
    CHECK_FALSE( rules.has_flag( ally_rule::use_silent ) );
    CHECK_FALSE( rules.has_flag( ally_rule::use_grenades ) );
    CHECK_FALSE( rules.has_flag( ally_rule::allow_bash ) );
}

TEST_CASE( "npc_autonomy_loaded_rules_keep_commands_and_default_missing_permissions",
           "[npc][autonomy][rules][save]" )
{
    npc_follower_rules rules;
    std::string saved = "{}";
    SECTION( "missing fields use current defaults even on reused rules" ) {
        rules.clear_flags();
        rules.set_specific_override_state( ally_rule::share_supplies, false );
    }
    SECTION( "legacy explicit prohibitions remain prohibitions" ) {
        saved = R"({"allow_pick_up":false,"share_supplies":false})";
    }
    SECTION( "modern explicit prohibitions supersede legacy permissions" ) {
        saved = R"({"allow_pick_up":true,"share_supplies":true,)"
                R"("rule_allow_pick_up":false,"rule_share_supplies":false})";
    }
    SECTION( "temporary prohibitions override automatic defaults" ) {
        saved = R"({"override_enable_share_supplies":true,"override_share_supplies":false})";
    }
    SECTION( "enabled override without value must not inherit the base permission" ) {
        saved = R"({"rule_share_supplies":true,"override_enable_share_supplies":true})";
    }
    const JsonObject data = json_loader::from_string( saved );
    rules.deserialize( data );
    const bool prohibited = data.has_member( "allow_pick_up" );
    CHECK( rules.has_flag( ally_rule::allow_pick_up ) == !prohibited );
    CHECK( rules.has_flag( ally_rule::share_supplies, false ) == !prohibited );
    const bool overridden = data.has_member( "override_enable_share_supplies" );
    CHECK( rules.has_override_enable( ally_rule::share_supplies ) == overridden );
    CHECK_FALSE( rules.has_override( ally_rule::share_supplies ) );
    CHECK( rules.has_flag( ally_rule::share_supplies ) == ( !prohibited && !overridden ) );
}

TEST_CASE( "npc_autonomy_equips_loaded_ground_gun_without_backpack",
           "[npc][autonomy][weapon]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    item gun( itype_id( "glock_19" ) );
    gun.ammo_set( itype_id( "9mm" ), 15 );
    REQUIRE( gun.ammo_remaining() == 15 );
    REQUIRE_FALSE( gun.is_silent() );
    REQUIRE_FALSE( guy.can_stash( gun ) );
    REQUIRE( guy.can_wield( gun ).success() );
    map &here = get_map();
    const tripoint_bub_ms p = guy.pos_bub();
    here.add_item_or_charges( p, gun );
    guy.set_moves( 1000 );
    SECTION( "a new follower uses normal firearms without rule configuration" ) {
        REQUIRE( guy.autonomous_weapon_step() );
        REQUIRE( guy.get_wielded_item() );
        CHECK( guy.get_wielded_item()->typeId() == gun.typeId() );
        CHECK( guy.get_wielded_item()->ammo_remaining() == 15 );
        CHECK( here.i_at( p ).empty() );
        CHECK( guy.get_moves() < 1000 );
    }
    SECTION( "a pickup prohibition remains authoritative" ) {
        guy.rules.clear_flag( ally_rule::allow_pick_up );
        CHECK_FALSE( guy.autonomous_weapon_step() );
        CHECK( here.i_at( p ).size() == 1 );
        CHECK( guy.get_moves() == 1000 );
    }
    SECTION( "a firearm prohibition does not turn into forced gun pickup" ) {
        guy.set_wielded_item( item( itype_id( "crowbar" ) ) );
        guy.rules.clear_flag( ally_rule::use_guns );
        CHECK_FALSE( guy.autonomous_weapon_step() );
        CHECK( here.i_at( p ).size() == 1 );
        CHECK( guy.get_wielded_item()->typeId() == itype_id( "crowbar" ) );
    }
    SECTION( "a silent order remains authoritative" ) {
        guy.set_wielded_item( item( itype_id( "crowbar" ) ) );
        guy.rules.set_flag( ally_rule::use_silent );
        CHECK_FALSE( guy.autonomous_weapon_step() );
        CHECK( here.i_at( p ).size() == 1 );
    }
    SECTION( "private equipment is not stolen" ) {
        here.i_at( p ).begin()->set_owner( faction_id( "free_merchants" ) );
        CHECK_FALSE( guy.autonomous_weapon_step() );
        CHECK( here.i_at( p ).size() == 1 );
    }
}

TEST_CASE( "npc_autonomy_ground_weapon_is_usable_in_combat_but_not_under_immediate_attack",
           "[npc][autonomy][weapon][combat]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    map &here = get_map();
    item gun( itype_id( "glock_19" ) );
    gun.ammo_set( itype_id( "9mm" ), 15 );
    const tripoint_bub_ms p = guy.pos_bub();
    here.add_item_or_charges( p, gun );
    int distance = 10;
    SECTION( "a distant melee threat leaves time to arm" ) {
        CHECK( distance > 6 );
    }
    SECTION( "a nearby threat prevents optional weapon retrieval" ) {
        distance = 1;
    }
    monster &enemy = spawn_test_monster( "mon_zombie", p + tripoint( distance, 0, 0 ) );
    guy.ai_cache.target = g->shared_from<Creature>( enemy );
    guy.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( enemy ) );
    guy.ai_cache.total_danger = 1;
    guy.set_moves( 1000 );
    REQUIRE_FALSE( guy.is_safe() );
    if( distance == 1 ) {
        CHECK_FALSE( guy.autonomous_weapon_step() );
        CHECK( here.i_at( p ).size() == 1 );
    } else {
        guy.autonomous_combat_action();
        REQUIRE( guy.get_wielded_item() );
        CHECK( here.i_at( p ).empty() );
        CHECK( guy.get_moves() < 1000 );
        guy.evaluate_best_attack( &enemy );
        CHECK( dynamic_cast<npc_attack_gun *>( guy.get_current_attack().get() ) != nullptr );
    }
}

TEST_CASE( "npc_autonomy_prepares_a_stowed_gun_from_loose_rounds_and_an_empty_magazine",
           "[npc][autonomy][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    item_location gun = guy.i_add( item( itype_id( "glock_19" ) ) );
    REQUIRE( gun );
    REQUIRE( gun->magazine_current() == nullptr );
    REQUIRE( guy.i_add( item( itype_id( "glockmag" ), calendar::turn, 0 ) ) );
    REQUIRE( guy.i_add( item( itype_id( "9mm" ), calendar::turn, 15 ) ) );
    REQUIRE( guy.is_safe() );
    REQUIRE( guy.sees( get_map(), get_avatar() ) );
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_reload_step() );
    CHECK( guy.get_moves() < 100 );
    // The first action fills the spare mag, the second inserts it in the stowed gun.
    CHECK( gun->ammo_remaining() == 0 );
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_reload_step() );
    CHECK( guy.get_moves() < 100 );
    REQUIRE( gun->magazine_current() != nullptr );
    CHECK( gun->ammo_remaining() == 15 );
    CHECK( guy.autonomy.ammunition[ammotype( "9mm" )] == 15 );
    CHECK( guy.autonomy.quantities[itype_id( "glockmag" )] == 1 );
    CHECK_FALSE( guy.autonomous_reload_step() );
}

TEST_CASE( "npc_autonomy_magazine_demand_includes_stowed_guns_and_inserted_magazines",
           "[npc][autonomy][pickup][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    item gun( itype_id( "glock_19" ) );
    gun.ammo_set( itype_id( "9mm" ), 15 );
    REQUIRE( guy.i_add( gun ) );
    item mag( itype_id( "glockmag" ), calendar::turn, 0 );
    CHECK( guy.autonomous_pickup_quantity( mag ) == 1 );
    REQUIRE( guy.i_add( mag ) );
    guy.refresh_autonomous_inventory( true );
    CHECK( guy.autonomous_pickup_quantity( mag ) == 0 );
    CHECK( guy.autonomy.ammunition[ammotype( "9mm" )] == 15 );
    CHECK( guy.autonomy.quantities[itype_id( "glockmag" )] == 2 );
    CHECK( guy.autonomous_pickup_quantity( item( itype_id( "stanag30" ) ) ) == 0 );
}

TEST_CASE( "npc_autonomy_reload_respects_access_and_stops_when_conditions_change",
           "[npc][autonomy][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    guy.set_wielded_item( item( itype_id( "glock_19" ) ) );
    item mag( itype_id( "glockmag" ) );
    mag.ammo_set( itype_id( "9mm" ), 15 );
    item_location source = guy.i_add( mag );
    REQUIRE( source );
    REQUIRE( source.has_parent() );
    SECTION( "a private magazine is not used" ) {
        source->set_owner( faction_id( "free_merchants" ) );
    }
    SECTION( "a favorite magazine is not moved" ) {
        source->is_favorite = true;
    }
    SECTION( "an unload prohibition is respected" ) {
        source.parent_pocket()->settings.set_unloadable( false );
    }
    SECTION( "a firearm prohibition is respected" ) {
        guy.rules.clear_flag( ally_rule::use_guns );
    }
    SECTION( "an immediate threat stops optional preparation" ) {
        monster &enemy = spawn_test_monster( "mon_zombie", guy.pos_bub() + tripoint( 1, 0, 0 ) );
        guy.ai_cache.target = g->shared_from<Creature>( enemy );
        guy.ai_cache.total_danger = 1;
        REQUIRE_FALSE( guy.is_safe() );
    }
    SECTION( "nearby ground ammunition must go through authorized pickup" ) {
        source.remove_item();
        get_map().add_item_or_charges( guy.pos_bub(), mag );
    }
    guy.set_moves( 100 );
    CHECK_FALSE( guy.autonomous_reload_step() );
    CHECK( guy.get_moves() == 100 );
    CHECK( guy.get_wielded_item()->ammo_remaining() == 0 );
    if( source ) {
        CHECK( source->ammo_remaining() == 15 );
    } else {
        REQUIRE( get_map().i_at( guy.pos_bub() ).size() == 1 );
        CHECK( get_map().i_at( guy.pos_bub() ).begin()->ammo_remaining() == 15 );
    }
}

TEST_CASE( "npc_autonomy_reload_resumes_after_danger_without_losing_ammunition",
           "[npc][autonomy][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    guy.set_wielded_item( item( itype_id( "glock_19" ) ) );
    item mag( itype_id( "glockmag" ) );
    mag.ammo_set( itype_id( "9mm" ), 15 );
    item_location source = guy.i_add( mag );
    REQUIRE( source );
    guy.set_moves( 100 );
    guy.ai_cache.total_danger = 1;
    REQUIRE_FALSE( guy.is_safe() );
    CHECK_FALSE( guy.autonomous_reload_step() );
    CHECK( guy.get_moves() == 100 );
    REQUIRE( source );
    CHECK( source->ammo_remaining() == 15 );
    guy.ai_cache.total_danger = 0;
    REQUIRE( guy.is_safe() );
    REQUIRE( guy.autonomous_reload_step() );
    CHECK( guy.get_moves() < 100 );
    CHECK( guy.get_wielded_item()->ammo_remaining() == 15 );
    CHECK( guy.autonomy.ammunition[ammotype( "9mm" )] == 15 );
    CHECK_FALSE( guy.autonomous_reload_step() );
}

TEST_CASE( "npc_autonomy_drinks_before_optional_inventory_work",
           "[npc][autonomy][survival]" )
{
    clear_map_without_vision();
    clear_avatar();
    override_option food_enabled( "NO_NPC_FOOD", "false" );
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( guy.i_add( item( itype_id( "water_clean" ), calendar::turn, 4 ).in_its_container() ) );
    guy.set_thirst( 300 );
    guy.set_hunger( 0 );
    guy.set_sleepiness( 0 );
    guy.set_all_parts_temp_conv( BODYTEMP_NORM );
    guy.autonomy.plan.task = npc_autonomy_task::organize;
    guy.autonomy.plan.work_required = 500;
    guy.set_moves( 100 );
    guy.move();
    CHECK( guy.get_thirst() < 300 );
    CHECK( guy.autonomy.plan.work_done == 0 );
    CHECK( guy.get_moves() < 100 );
    CHECK( guy.get_attitude() == NPCATT_FOLLOW );
}

TEST_CASE( "npc_autonomy_survival_does_not_override_danger_or_assigned_orders",
           "[npc][autonomy][survival]" )
{
    clear_map_without_vision();
    clear_avatar();
    override_option food_enabled( "NO_NPC_FOOD", "false" );
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( guy.i_add( item( itype_id( "water_clean" ), calendar::turn, 4 ).in_its_container() ) );
    guy.set_thirst( 300 );
    SECTION( "danger keeps optional survival work out of combat" ) {
        guy.ai_cache.total_danger = 1;
    }
    SECTION( "waiting is not silently changed into following" ) {
        guy.set_attitude( NPCATT_WAIT );
    }
    SECTION( "an existing activity is left alone" ) {
        guy.assign_activity( activity_id( "ACT_WAIT" ), 1000 );
    }
    const npc_attitude before = guy.get_attitude();
    guy.set_moves( 100 );
    guy.autonomous_needs_action();
    CHECK( guy.get_thirst() == 300 );
    CHECK( guy.get_moves() == 100 );
    CHECK( guy.get_attitude() == before );
}

TEST_CASE( "npc_autonomy_gets_warm_before_optional_equipment_work",
           "[npc][autonomy][survival][equipment]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( guy.i_add( item( itype_id( "sweater" ) ) ) );
    guy.set_thirst( 0 );
    guy.set_hunger( 0 );
    guy.set_sleepiness( 0 );
    guy.set_all_parts_temp_conv( BODYTEMP_VERY_COLD );
    guy.set_all_parts_temp_cur( BODYTEMP_VERY_COLD );
    REQUIRE_FALSE( guy.is_wearing( itype_id( "sweater" ) ) );
    guy.set_moves( 100 );
    guy.autonomous_needs_action();
    CHECK( guy.is_wearing( itype_id( "sweater" ) ) );
    CHECK( guy.get_attitude() == NPCATT_FOLLOW );
}

TEST_CASE( "npc_autonomy_triage_chooses_treatable_urgent_injuries_not_spawn_order",
           "[npc][autonomy][medical]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &medic = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &minor = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    npc &urgent = autonomy_test_follower( point_bub_ms( 49, 50 ) );
    medic.set_thirst( 0 );
    medic.set_hunger( 0 );
    medic.set_sleepiness( 0 );
    medic.set_stored_kcal( medic.get_healthy_kcal() );
    medic.set_all_parts_temp_conv( BODYTEMP_NORM );
    REQUIRE( medic.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( medic.i_add( item( itype_id( "bandages" ) ) ) );
    const bodypart_id torso( "torso" );
    minor.set_part_hp_cur( torso, minor.get_part_hp_max( torso ) * 70 / 100 );
    urgent.add_effect( efftype_id( "bleed" ), 10_minutes, torso );
    REQUIRE( medic.sees( get_map(), urgent ) );
    REQUIRE( medic.autonomous_care_priority( urgent ) > medic.autonomous_care_priority( minor ) );
    SECTION( "the bleeding teammate is selected first" ) {
        CHECK( medic.autonomous_triage_patient() == &urgent );
        medic.autonomous_needs_action();
        CHECK( medic.autonomy.rescue_patient == urgent.getID() );
        CHECK( medic.autonomy.rescue_until > calendar::turn );
    }
    SECTION( "an existing medic reservation leaves the next patient available" ) {
        minor.autonomy.rescue_patient = urgent.getID();
        minor.autonomy.rescue_until = calendar::turn + 5_seconds;
        CHECK( medic.autonomous_triage_patient() == &minor );
    }
    SECTION( "critical self injury preempts less urgent team treatment" ) {
        medic.set_part_hp_cur( torso, medic.get_part_hp_max( torso ) / 5 );
        CHECK( medic.autonomous_triage_patient() == &medic );
    }
    SECTION( "no medicine means no repeated impossible treatment" ) {
        medic.remove_items_with( []( const item &it ) {
            return it.typeId() == itype_id( "bandages" );
        } );
        CHECK( medic.autonomous_triage_patient() == nullptr );
    }
}

TEST_CASE( "npc_autonomy_follower_sleep_candidates_stay_with_the_team",
           "[npc][autonomy][sleep]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    const tripoint_bub_ms distant_bed( 60, 50, 0 );
    get_map().furn_set( distant_bed, furn_id( "f_bed" ) );
    const auto candidates = guy.find_sleep_candidates();
    REQUIRE_FALSE( candidates.empty() );
    for( const auto &candidate : candidates ) {
        CHECK( rl_dist( get_map().get_bub( candidate.target ), get_avatar().pos_bub() ) <= 6 );
        CHECK( get_map().get_bub( candidate.target ) != distant_bed );
    }
}

TEST_CASE( "npc_autonomy_missing_water_does_not_block_available_warmth",
           "[npc][autonomy][survival]" )
{
    clear_map_without_vision();
    clear_avatar();
    override_option food_enabled( "NO_NPC_FOOD", "false" );
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( guy.i_add( item( itype_id( "sweater" ) ) ) );
    guy.set_thirst( 1100 );
    guy.set_hunger( 0 );
    guy.set_sleepiness( 0 );
    guy.set_all_parts_temp_conv( BODYTEMP_VERY_COLD );
    guy.set_all_parts_temp_cur( BODYTEMP_VERY_COLD );
    guy.set_moves( 100 );
    guy.autonomous_needs_action();
    CHECK( guy.is_wearing( itype_id( "sweater" ) ) );
    CHECK( guy.get_thirst() == 1100 );
}

TEST_CASE( "npc_autonomy_supply_distribution_prioritizes_the_wounded_recipient",
           "[npc][autonomy][supplies][medical]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &donor = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &healthy = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    npc &wounded = autonomy_test_follower( point_bub_ms( 49, 50 ) );
    REQUIRE( donor.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( healthy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( wounded.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    for( int i = 0; i < 12; ++i ) {
        REQUIRE( donor.i_add( item( itype_id( "bandages" ) ) ) );
    }
    wounded.add_effect( efftype_id( "bleed" ), 10_minutes, bodypart_id( "torso" ) );
    donor.set_moves( 100 );
    donor.autonomous_supply_step();
    REQUIRE( donor.autonomy.plan.task == npc_autonomy_task::share );
    CHECK( donor.autonomy.plan.recipient == wounded.getID() );
    complete_autonomy_plan( donor );
    CHECK( wounded.amount_of( itype_id( "bandages" ) ) > 0 );
    CHECK( healthy.amount_of( itype_id( "bandages" ) ) == 0 );
    CHECK( donor.amount_of( itype_id( "bandages" ) ) +
           wounded.amount_of( itype_id( "bandages" ) ) == 12 );
}


TEST_CASE( "npc_autonomy_intent_speech_is_rate_limited_and_respects_silence",
           "[npc][autonomy][speech]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_announce( "reload", "Reloading." ) );
    CHECK( guy.get_moves() == 100 );
    CHECK_FALSE( guy.autonomous_announce( "reload", "Reloading." ) );
    CHECK_FALSE( guy.autonomous_announce( "equipment", "Changing equipment." ) );
    calendar::turn += 10_seconds;
    CHECK_FALSE( guy.autonomous_announce( "reload", "Reloading." ) );
    CHECK( guy.autonomous_announce( "equipment", "Changing equipment." ) );
    calendar::turn += 1_minutes;
    CHECK( guy.autonomous_announce( "reload", "Reloading." ) );
    calendar::turn += 10_seconds;
    const time_point previous = guy.autonomy.announcement_checked;
    guy.rules.set_flag( ally_rule::use_silent );
    CHECK_FALSE( guy.autonomous_announce( "retreat", "Falling back!", true ) );
    CHECK( guy.autonomy.announcement_checked == previous );
    guy.rules.clear_flag( ally_rule::use_silent );
    guy.rules.clear_flag( ally_rule::allow_complain );
    CHECK_FALSE( guy.autonomous_announce( "pickup", "Collecting supplies." ) );
    CHECK( guy.autonomous_announce( "retreat", "Falling back!", true ) );
    calendar::turn += 10_seconds;
    get_avatar().setpos( get_map(), guy.pos_bub() + tripoint( 20, 0, 0 ) );
    CHECK_FALSE( guy.autonomous_announce( "rescue", "Coming to help!", true ) );
}

TEST_CASE( "npc_autonomy_empty_gun_preparation_does_not_depend_on_leader_proximity",
           "[npc][autonomy][reload][follow]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    guy.set_wielded_item( item( itype_id( "glock_19" ) ) );
    item magazine( itype_id( "glockmag" ) );
    magazine.ammo_set( itype_id( "9mm" ), 15 );
    REQUIRE( guy.i_add( magazine ) );
    get_avatar().setpos( get_map(), guy.pos_bub() + tripoint( 20, 0, 0 ) );
    const tripoint_bub_ms position = guy.pos_bub();
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_follow_maintenance() );
    CHECK( guy.get_wielded_item()->ammo_remaining() == 15 );
    CHECK( guy.pos_bub() == position );
    CHECK( guy.get_moves() < 100 );
    CHECK( guy.get_attitude() == NPCATT_FOLLOW );
}

TEST_CASE( "npc_autonomy_separated_follower_uses_carried_warmth_without_searching_ground",
           "[npc][autonomy][survival][follow]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    get_avatar().setpos( get_map(), guy.pos_bub() + tripoint( 15, 0, 0 ) );
    guy.set_thirst( 0 );
    guy.set_hunger( 0 );
    guy.set_sleepiness( 0 );
    guy.set_all_parts_temp_conv( BODYTEMP_VERY_COLD );
    guy.set_all_parts_temp_cur( BODYTEMP_VERY_COLD );
    const tripoint_bub_ms position = guy.pos_bub();
    SECTION( "carried clothing is used without the leader present" ) {
        REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
        REQUIRE( guy.i_add( item( itype_id( "sweater" ) ) ) );
        guy.set_moves( 100 );
        guy.autonomous_needs_action();
        CHECK( guy.is_wearing( itype_id( "sweater" ) ) );
        CHECK( guy.get_moves() < 100 );
    }
    SECTION( "external clothing does not start a detour while separated" ) {
        get_map().add_item_or_charges( position + tripoint( 1, 0, 0 ),
                                     item( itype_id( "sweater" ) ) );
        guy.set_moves( 100 );
        guy.autonomous_needs_action();
        CHECK_FALSE( guy.is_wearing( itype_id( "sweater" ) ) );
        CHECK( guy.get_moves() == 100 );
        CHECK_FALSE( guy.ai_cache.warmth_plan.active() );
    }
    CHECK( guy.pos_bub() == position );
    CHECK( guy.get_attitude() == NPCATT_FOLLOW );
}

TEST_CASE( "npc_autonomy_optional_maintenance_rotates_to_supply_distribution",
           "[npc][autonomy][supplies][scheduling]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &donor = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &recipient = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    REQUIRE( donor.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( recipient.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    for( int i = 0; i < 12; ++i ) {
        REQUIRE( donor.i_add( item( itype_id( "bandages" ) ) ) );
    }
    donor.autonomy.maintenance_cursor = 2;
    donor.set_moves( 100 );
    REQUIRE( donor.autonomous_follow_maintenance() );
    CHECK( donor.autonomy.maintenance_cursor == 3 );
    CHECK( donor.autonomy.plan.task == npc_autonomy_task::share );
    CHECK( donor.autonomy.plan.recipient == recipient.getID() );
    complete_autonomy_plan( donor );
    CHECK( recipient.amount_of( itype_id( "bandages" ) ) > 0 );
}

TEST_CASE( "npc_autonomy_disabling_sharing_does_not_disable_authorized_surplus_deposit",
           "[npc][autonomy][supplies][zones]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    const item medicine( itype_id( "bandages" ) );
    for( int i = 0; i < 12; ++i ) {
        REQUIRE( guy.i_add( medicine ) );
    }
    guy.rules.clear_flag( ally_rule::share_supplies );
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    const on_out_of_scope cleanup( [&zones]() {
        zones.clear();
    } );
    const auto type = medicine.get_category_of_contents().zone();
    REQUIRE( type.has_value() );
    const tripoint_bub_ms destination = guy.pos_bub() + tripoint( 1, 0, 0 );
    const tripoint_abs_ms absolute = get_map().get_abs( destination );
    REQUIRE( zones.add( "Medical supplies", *type, guy.get_fac_id(), false, true,
                        absolute, absolute, nullptr, true, nullptr, false ) != nullptr );
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_supply_step() );
    REQUIRE( guy.autonomy.plan.task == npc_autonomy_task::deposit );
    complete_autonomy_plan( guy );
    CHECK( guy.amount_of( medicine.typeId() ) == 11 );
    REQUIRE( get_map().i_at( destination ).size() == 1 );
    CHECK( get_map().i_at( destination ).begin()->typeId() == medicine.typeId() );
}

TEST_CASE( "npc_autonomy_decision_cooldown_and_emergency_preemption",
           "[npc][autonomy][scheduling]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.autonomous_decision_result( "equipment", true );
    CHECK( guy.autonomous_decision_score( "equipment", 0.5 ) >
           guy.autonomous_decision_score( "organize", 0.5 ) );
    CHECK( guy.autonomous_decision_score( "treat_injury", 0.95 ) >
           guy.autonomous_decision_score( "equipment", 0.5 ) );
    guy.autonomous_decision_result( "pickup", false );
    CHECK( guy.autonomous_decision_score( "pickup", 0.7 ) < 0 );
    calendar::turn += 3_seconds;
    CHECK( guy.autonomous_decision_score( "pickup", 0.7 ) > 0 );
}

TEST_CASE( "npc_autonomy_target_claims_expire_and_do_not_make_targets_exclusive",
           "[npc][autonomy][combat][team]" )
{
    clear_map_without_vision();
    npc &observer = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &shooter = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    monster &enemy = spawn_test_monster( "mon_zombie", observer.pos_bub() + tripoint( 8, 0, 0 ) );
    observer.ai_cache.friends.push_back( g->shared_from<Creature>( shooter ) );
    REQUIRE( observer.sees( get_map(), shooter ) );
    shooter.autonomous_reserve_attack( enemy, 20 );
    CHECK( observer.autonomous_reserved_damage( enemy ) == 20 );
    shooter.autonomy.recovering_until = calendar::turn + 1_seconds;
    CHECK( observer.autonomous_reserved_damage( enemy ) == 0 );
    shooter.autonomy.recovering_until = calendar::before_time_starts;
    calendar::turn += 1_seconds;
    CHECK( observer.autonomous_reserved_damage( enemy ) == 0 );
}

TEST_CASE( "npc_autonomy_seat_and_position_claims_are_separate_and_temporary",
           "[npc][autonomy][vehicle][team]" )
{
    clear_map_without_vision();
    npc &first = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &second = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    REQUIRE( second.sees( get_map(), first ) );
    const tripoint_abs_ms destination = first.pos_abs() + tripoint( 2, 0, 0 );
    first.autonomy.seat_goal = destination;
    first.autonomy.seat_until = calendar::turn + 3_seconds;
    CHECK( second.autonomous_position_reserved( destination, true ) );
    CHECK_FALSE( second.autonomous_position_reserved( destination, false ) );
    calendar::turn += 3_seconds;
    CHECK_FALSE( second.autonomous_position_reserved( destination, true ) );
}

TEST_CASE( "npc_autonomy_search_uses_last_observation_not_unseen_player_position",
           "[npc][autonomy][follow][memory]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    map &here = get_map();
    get_avatar().setpos( here, guy.pos_bub() + tripoint( 10, 0, 0 ) );
    for( int y = 20; y <= 80; ++y ) {
        here.ter_set( tripoint_bub_ms( 52, y, guy.posz() ), ter_id( "t_wall" ) );
    }
    here.invalidate_map_cache( guy.posz() );
    here.build_map_cache( guy.posz() );
    REQUIRE_FALSE( guy.sees( here, get_avatar() ) );
    SECTION( "without an observation the follower waits rather than tracking through walls" ) {
        guy.last_player_seen_pos.reset();
        const tripoint_bub_ms start = guy.pos_bub();
        guy.set_moves( 100 );
        guy.look_for_player( get_avatar() );
        CHECK( guy.pos_bub() == start );
    }
    SECTION( "the remembered position drives the search" ) {
        const tripoint_abs_ms remembered = here.get_abs( guy.pos_bub() + tripoint( 0, -4, 0 ) );
        guy.last_player_seen_pos = remembered;
        guy.set_moves( 100 );
        guy.look_for_player( get_avatar() );
        CHECK( guy.autonomy.search_origin == remembered );
        CHECK( guy.autonomy.search_goal == remembered );
        CHECK( rl_dist( guy.pos_abs(), remembered ) < 4 );
    }
}

TEST_CASE( "npc_autonomy_remote_camp_changes_both_pickup_and_reserve_targets",
           "[npc][autonomy][supplies]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.assigned_camp = guy.pos_abs_omt();
    guy.refresh_autonomous_inventory( true );
    const int local_food = guy.autonomy.food_target;
    const int local_water = guy.autonomy.water_target;
    guy.assigned_camp = guy.pos_abs_omt() + tripoint( 10, 0, 0 );
    guy.refresh_autonomous_inventory( true );
    CHECK( guy.autonomy.food_target == local_food * 2 );
    CHECK( guy.autonomy.water_target == local_water * 2 );
    CHECK( guy.autonomy.magazine_target == 3 );
}

TEST_CASE( "npc_autonomy_cbm_defaults_are_automatic_and_explicit_reserves_still_win",
           "[npc][autonomy][bionics]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    REQUIRE( guy.rules.cbm_recharge == cbm_recharge_rule::CBM_RECHARGE_AUTO );
    REQUIRE( guy.rules.cbm_reserve == cbm_reserve_rule::CBM_RESERVE_AUTO );
    guy.set_max_power_level( 1000_kJ );
    guy.set_power_level( 300_kJ );
    CHECK( guy.can_use_offensive_cbm() );
    guy.rules.cbm_reserve = cbm_reserve_rule::CBM_RESERVE_MOST;
    CHECK_FALSE( guy.can_use_offensive_cbm() );
    guy.rules.cbm_reserve = cbm_reserve_rule::CBM_RESERVE_NONE;
    CHECK( guy.can_use_offensive_cbm() );
}

TEST_CASE( "npc_autonomy_energy_save_defaults_and_explicit_overrides",
           "[npc][autonomy][rules][save]" )
{
    npc_follower_rules rules;
    SECTION( "missing fields select automatic energy management" ) {
        rules.cbm_reserve = cbm_reserve_rule::CBM_RESERVE_ALL;
        rules.cbm_recharge = cbm_recharge_rule::CBM_RECHARGE_ALL;
        rules.deserialize( json_loader::from_string( "{}" ) );
        CHECK( rules.cbm_reserve == cbm_reserve_rule::CBM_RESERVE_AUTO );
        CHECK( rules.cbm_recharge == cbm_recharge_rule::CBM_RECHARGE_AUTO );
    }
    SECTION( "saved automatic values remain automatic" ) {
        rules.deserialize( json_loader::from_string( R"({"cbm_reserve":-1,"cbm_recharge":-1})" ) );
        CHECK( rules.cbm_reserve == cbm_reserve_rule::CBM_RESERVE_AUTO );
        CHECK( rules.cbm_recharge == cbm_recharge_rule::CBM_RECHARGE_AUTO );
    }
    SECTION( "existing explicit percentages remain authoritative" ) {
        rules.deserialize( json_loader::from_string( R"({"cbm_reserve":75,"cbm_recharge":25})" ) );
        CHECK( rules.cbm_reserve == cbm_reserve_rule::CBM_RESERVE_MOST );
        CHECK( rules.cbm_recharge == cbm_recharge_rule::CBM_RECHARGE_LITTLE );
    }
}

TEST_CASE( "npc_followers_hold_formation_without_suppressing_real_panic",
           "[npc][autonomy][combat][retreat]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    guy.ai_cache.my_weapon_value = 3.0;
    guy.mem_combat.assess_ally = 20;
    guy.mem_combat.assess_enemy = 21;
    guy.mem_combat.swarm_count = 1;
    guy.mem_combat.panic = 0;
    guy.mem_combat.repositioning = true;
    const efftype_id retreat( "npc_run_away" );
    guy.add_effect( retreat, 20_turns );
    REQUIRE( guy.sees( get_map(), get_avatar() ) );
    bool should_hold = true;
    SECTION( "healthy melee follower rallies beside the leader" ) {}
    SECTION( "overwhelming enemies still allow retreat" ) {
        guy.mem_combat.assess_enemy = 100;
        should_hold = false;
    }
    SECTION( "real panic is not overridden by following" ) {
        guy.mem_combat.panic = 30;
        should_hold = false;
    }
    SECTION( "exhaustion still allows retreat" ) {
        guy.set_stamina( 0 );
        should_hold = false;
    }
    guy.act_on_danger_assessment();
    CHECK( guy.has_effect( retreat ) == !should_hold );
    if( should_hold ) {
        CHECK_FALSE( guy.mem_combat.repositioning );
    }
}

TEST_CASE( "npc_repositioning_is_short_and_does_not_discount_a_fighting_teammate",
           "[npc][autonomy][combat][retreat]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    guy.personality.bravery = 10;
    guy.mem_combat.panic = 0;
    guy.mem_combat.assess_ally = 1;
    guy.mem_combat.assess_enemy = 10;
    guy.ai_cache.my_weapon_value = 0;
    guy.act_on_danger_assessment();
    const efftype_id retreat( "npc_run_away" );
    REQUIRE( guy.has_effect( retreat ) );
    CHECK( guy.mem_combat.repositioning );
    CHECK( guy.get_effect( retreat ).get_duration() <= 2_turns );
    npc &observer = autonomy_test_follower( point_bub_ms( 49, 50 ) );
    observer.set_per_base( 20 );
    observer.reset_stats();
    const float repositioning_value = observer.evaluate_character( guy, false, false );
    guy.remove_effect( retreat );
    const float standing_value = observer.evaluate_character( guy, false, false );
    CHECK( repositioning_value == Approx( standing_value ) );
}

TEST_CASE( "npc_retrieves_a_nearby_loaded_gun_before_a_distant_enemy_enters_melee_range",
           "[npc][autonomy][weapon][combat]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    guy.set_skill_level( skill_id( "gun" ), 10 );
    guy.set_skill_level( skill_id( "pistol" ), 10 );
    item crowbar( itype_id( "crowbar" ) );
    REQUIRE( guy.wield( crowbar ) );
    item gun( itype_id( "glock_19" ) );
    gun.ammo_set( itype_id( "9mm" ), 15 );
    const tripoint_bub_ms ground = guy.pos_bub() + tripoint( 2, 0, 0 );
    get_map().add_item_or_charges( ground, gun );
    monster &enemy = spawn_test_monster( "mon_zombie", guy.pos_bub() + tripoint( 20, 0, 0 ) );
    guy.ai_cache.target = {};
    guy.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( enemy ) );
    guy.ai_cache.total_danger = 1;
    REQUIRE( guy.sees( get_map(), enemy ) );
    bool forbidden = false;
    SECTION( "distant visible enemy need not already be selected as attack target" ) {}
    SECTION( "explicit pickup prohibition remains effective" ) {
        guy.rules.clear_flag( ally_rule::allow_pick_up );
        forbidden = true;
    }
    SECTION( "an immediate attacker prevents retrieval" ) {
        monster &close = spawn_test_monster( "mon_zombie", guy.pos_bub() + tripoint( -1, 0, 0 ) );
        guy.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( close ) );
        forbidden = true;
    }
    guy.set_moves( 1000 );
    const tripoint_bub_ms start = guy.pos_bub();
    CHECK( guy.autonomous_weapon_step() == !forbidden );
    if( forbidden ) {
        CHECK( guy.pos_bub() == start );
        CHECK( guy.get_wielded_item()->typeId() == crowbar.typeId() );
    } else {
        CHECK( guy.get_moves() < 1000 );
        CHECK( guy.pos_bub() != start );
        guy.set_moves( 1000 );
        REQUIRE( guy.autonomous_weapon_step() );
        CHECK( guy.get_wielded_item()->typeId() == gun.typeId() );
        CHECK( get_map().i_at( ground ).empty() );
    }
}

TEST_CASE( "npc_combat_can_prepare_a_carried_gun_from_real_ammunition",
           "[npc][autonomy][combat][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    item_location gun = guy.i_add( item( itype_id( "glock_19" ) ) );
    REQUIRE( gun );
    REQUIRE( guy.i_add( item( itype_id( "glockmag" ), calendar::turn, 0 ) ) );
    REQUIRE( guy.i_add( item( itype_id( "9mm" ), calendar::turn, 15 ) ) );
    int distance = 20;
    bool allowed = true;
    SECTION( "a distant enemy leaves time for magazine preparation" ) {}
    SECTION( "a close enemy prevents optional preparation" ) {
        distance = 1;
        allowed = false;
    }
    SECTION( "explicit gun prohibition is respected" ) {
        guy.rules.clear_flag( ally_rule::use_guns );
        allowed = false;
    }
    monster &enemy = spawn_test_monster( "mon_zombie", guy.pos_bub() + tripoint( distance, 0, 0 ) );
    guy.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( enemy ) );
    guy.ai_cache.total_danger = 1;
    guy.set_moves( 100 );
    CHECK( guy.autonomous_reload_step() == allowed );
    if( allowed ) {
        CHECK( guy.get_moves() < 100 );
        guy.set_moves( 100 );
        REQUIRE( guy.autonomous_reload_step() );
        CHECK( gun->ammo_sufficient( &guy ) );
        CHECK( gun->ammo_remaining() == 1 );
        CHECK( guy.autonomy.ammunition[ammotype( "9mm" )] == 15 );
    } else {
        CHECK( guy.get_moves() == 100 );
        CHECK( gun->ammo_remaining() == 0 );
    }
}

TEST_CASE( "npc_ground_gun_readiness_uses_real_carried_ammunition_without_consuming_it",
           "[npc][autonomy][combat][weapon][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    item magazine( itype_id( "glockmag" ) );
    magazine.ammo_set( itype_id( "9mm" ), 15 );
    item_location carried = guy.i_add( magazine );
    REQUIRE( carried );
    get_map().add_item_or_charges( guy.pos_bub(), item( itype_id( "glock_19" ) ) );
    item_location gun( map_cursor( guy.pos_bub() ), &*get_map().i_at( guy.pos_bub() ).begin() );
    bool allowed = true;
    SECTION( "compatible loaded magazine enables the unloaded ground gun" ) {}
    SECTION( "reserved ammunition is not borrowed by planning" ) {
        carried->is_favorite = true;
        allowed = false;
    }
    SECTION( "gun prohibition prevents optimistic readiness" ) {
        guy.rules.clear_flag( ally_rule::use_guns );
        allowed = false;
    }
    item prepared;
    int cost = 0;
    guy.set_moves( 100 );
    CHECK( guy.autonomous_gun_readiness( gun, prepared, cost, true ) == allowed );
    if( allowed ) {
        CHECK( prepared.ammo_sufficient( &guy ) );
        CHECK( cost > 0 );
    }
    CHECK( gun->ammo_remaining() == 0 );
    CHECK( carried->ammo_remaining() == 15 );
    CHECK( guy.get_moves() == 100 );
}

TEST_CASE( "npc_selects_a_ready_carried_gun_for_a_distant_visible_enemy",
           "[npc][autonomy][combat][weapon]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    guy.set_wielded_item( item( itype_id( "crowbar" ) ) );
    guy.set_skill_level( skill_id( "gun" ), 10 );
    guy.set_skill_level( skill_id( "pistol" ), 10 );
    item gun( itype_id( "glock_19" ) );
    gun.ammo_set( itype_id( "9mm" ), 15 );
    REQUIRE( guy.i_add( gun ) );
    monster &enemy = spawn_test_monster( "mon_zombie", guy.pos_bub() + tripoint( 20, 0, 0 ) );
    guy.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( enemy ) );
    guy.ai_cache.total_danger = 1;
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_carried_weapon_step() );
    CHECK( guy.get_wielded_item()->typeId() == gun.typeId() );
    CHECK( guy.get_moves() < 100 );
    CHECK_FALSE( guy.autonomous_carried_weapon_step() );
}

TEST_CASE( "npc_ground_weapon_reservations_expire_and_ignore_the_owner",
           "[npc][autonomy][combat][weapon]" )
{
    clear_map_without_vision();
    npc &first = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    npc &second = autonomy_test_follower( point_bub_ms( 49, 50 ) );
    get_map().add_item_or_charges( first.pos_bub(), item( itype_id( "glock_19" ) ) );
    item &gun = *get_map().i_at( first.pos_bub() ).begin();
    first.autonomy.weapon_goal = item_location( map_cursor( first.pos_bub() ), &gun );
    first.autonomy.weapon_goal_until = calendar::turn + 3_seconds;
    REQUIRE( second.sees( get_map(), first ) );
    CHECK( second.autonomous_target_reserved( gun ) );
    CHECK_FALSE( first.autonomous_target_reserved( gun ) );
    first.autonomy.weapon_goal_until = calendar::turn - 1_seconds;
    CHECK_FALSE( second.autonomous_target_reserved( gun ) );
}

TEST_CASE( "npc_can_pick_up_an_empty_ground_gun_then_insert_a_real_carried_magazine",
           "[npc][autonomy][combat][weapon][reload]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    REQUIRE( guy.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    guy.set_skill_level( skill_id( "gun" ), 10 );
    guy.set_skill_level( skill_id( "pistol" ), 10 );
    guy.set_wielded_item( item( itype_id( "crowbar" ) ) );
    item magazine( itype_id( "glockmag" ) );
    magazine.ammo_set( itype_id( "9mm" ), 15 );
    REQUIRE( guy.i_add( magazine ) );
    get_map().add_item_or_charges( guy.pos_bub(), item( itype_id( "glock_19" ) ) );
    monster &enemy = spawn_test_monster( "mon_zombie", guy.pos_bub() + tripoint( 20, 0, 0 ) );
    guy.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( enemy ) );
    guy.ai_cache.total_danger = 1;
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_weapon_step() );
    REQUIRE( guy.get_wielded_item() );
    CHECK( guy.get_wielded_item()->typeId() == itype_id( "glock_19" ) );
    CHECK( guy.get_wielded_item()->ammo_remaining() == 0 );
    CHECK( guy.get_moves() < 100 );
    guy.set_moves( 100 );
    REQUIRE( guy.autonomous_reload_step() );
    CHECK( guy.get_wielded_item()->ammo_remaining() == 15 );
    CHECK( guy.get_moves() < 100 );
    CHECK( guy.autonomy.ammunition[ammotype( "9mm" )] == 15 );
}

TEST_CASE( "npc_follow_position_reuses_a_valid_existing_route",
           "[npc][autonomy][follow][path]" )
{
    clear_map_without_vision();
    npc &guy = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    guy.rules = npc_follower_rules();
    get_avatar().setpos( get_map(), tripoint_bub_ms( 54, 50, 0 ) );
    const tripoint_bub_ms goal( 53, 49, 0 );
    guy.autonomy.follow_goal = get_map().get_abs( goal );
    guy.autonomy.follow_checked = calendar::turn;
    guy.path = { tripoint_bub_ms( 51, 49, 0 ), tripoint_bub_ms( 52, 49, 0 ), goal };
    const auto original = guy.path;
    CHECK( guy.autonomous_follow_position() == goal );
    CHECK( guy.path == original );
    guy.setpos( get_map(), goal );
    CHECK( guy.autonomous_follow_position() == goal );
    CHECK( guy.path.empty() );
}

TEST_CASE( "npc_medical_approach_uses_safe_adjacent_tiles_and_preserves_failed_routes",
           "[npc][autonomy][medical][path]" )
{
    clear_map_without_vision();
    npc &medic = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    medic.rules = npc_follower_rules();
    npc &patient = autonomy_test_follower( point_bub_ms( 53, 50 ) );
    const tripoint_bub_ms original_step( 50, 49, 0 );
    medic.path = { original_step };
    bool reachable = true;
    SECTION( "medical approach stops beside the patient instead of on their tile" ) {}
    SECTION( "hold position prevents a medical detour" ) {
        medic.rules.set_flag( ally_rule::hold_the_line );
        reachable = false;
    }
    SECTION( "a patient surrounded by fire is not approached" ) {
        for( const tripoint_bub_ms &p : get_map().points_in_radius( patient.pos_bub(), 1 ) ) {
            if( p != patient.pos_bub() ) {
                get_map().add_field( p, field_type_id( "fd_fire" ), 3, 0_turns, false );
            }
        }
        reachable = false;
    }
    CHECK( medic.autonomous_patient_route( patient ) == reachable );
    if( reachable ) {
        REQUIRE_FALSE( medic.path.empty() );
        CHECK( medic.path.back() != patient.pos_bub() );
        CHECK( rl_dist( medic.path.back(), patient.pos_bub() ) == 1 );
    } else {
        REQUIRE( medic.path.size() == 1 );
        CHECK( medic.path.front() == original_step );
    }
}

TEST_CASE( "npc_prioritizes_urgent_team_treatment_before_optional_weapon_retrieval",
           "[npc][autonomy][combat][medical]" )
{
    clear_map_without_vision();
    clear_avatar();
    npc &medic = autonomy_test_follower( point_bub_ms( 50, 50 ) );
    medic.rules = npc_follower_rules();
    REQUIRE( medic.wear_item( item( itype_id( "debug_backpack" ) ), false ).has_value() );
    REQUIRE( medic.i_add( item( itype_id( "bandages" ) ) ) );
    npc &patient = autonomy_test_follower( point_bub_ms( 51, 50 ) );
    const bodypart_id torso( "torso" );
    patient.set_part_hp_cur( torso, patient.get_part_hp_max( torso ) / 5 );
    patient.add_effect( efftype_id( "bleed" ), 10_minutes, torso );
    item gun( itype_id( "glock_19" ) );
    gun.ammo_set( itype_id( "9mm" ), 15 );
    get_map().add_item_or_charges( medic.pos_bub(), gun );
    monster &enemy = spawn_test_monster( "mon_zombie", medic.pos_bub() + tripoint( 20, 0, 0 ) );
    enemy.set_speed_base( 1 );
    medic.ai_cache.hostile_guys.push_back( g->shared_from<Creature>( enemy ) );
    medic.ai_cache.friends.push_back( g->shared_from<Creature>( patient ) );
    medic.ai_cache.total_danger = 1;
    medic.ai_cache.target = {};
    medic.set_moves( 100 );
    medic.autonomous_combat_action();
    CHECK( medic.autonomy.rescue_patient == patient.getID() );
    CHECK( medic.autonomy.rescue_until > calendar::turn );
    CHECK( get_map().i_at( medic.pos_bub() ).size() == 1 );
    CHECK( medic.get_moves() == 100 );
}
