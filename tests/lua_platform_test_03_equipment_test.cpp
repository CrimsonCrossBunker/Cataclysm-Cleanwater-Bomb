#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <avatar.h>
#include <calendar.h>
#include <character.h>
#include <character_id.h>
#include <faction.h>
#include <inventory.h>
#include <item.h>
#include <item_location.h>
#include <item_uid.h>
#include <lua_platform_handle.h>
#include <lua_platform_items.h>
#include <lua_platform_npcs.h>
#include <pimpl.h>
#include <talker_character.h>
#include <type_id.h>
#include <units.h>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <list>
#include <memory>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "bionics.h"
#include "cata_catch.h"
#include "lua_platform_sol.h"
#include "npc.h"

static const bionic_id bio_blade( "bio_blade" );
static const bionic_id bio_power_storage( "bio_power_storage" );
static const faction_id faction_robofac( "robofac" );
static const faction_id faction_your_followers( "your_followers" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_backpack_hiking( "backpack_hiking" );
static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_stick( "stick" );

namespace
{

struct platform_equipment_fixture {
    explicit platform_equipment_fixture( const std::size_t runtime_number,
                                         const std::size_t world_number,
                                         const int actor_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        actor.normalize();
        actor.setID( character_id( actor_number ), true );
        actor_handle = cata::lua_platform::game_handle::from_creature(
                           actor,
        { "avatar", actor.getID().get_value(), 0, 0, 0, {} },
        runtime, active_world_generation );

        services = lua.create_table();
        cata::lua_platform::install_game_handle_api(
            lua, services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_item_api(
            services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
    }

    sol::table holder( const cata::lua_platform::game_handle &character,
                       const std::string &slot = "inventory" ) {
        sol::table result = lua.create_table();
        result["kind"] = "character";
        result["character"] = character;
        result["slot"] = slot;
        return result;
    }

    item *add_item( const itype_id &id ) {
        item value( id, calendar::turn_zero );
        return &actor.inv->add_item(
                   std::move( value ), false, false, false );
    }

    item *add_worn_item( const itype_id &id ) {
        item value( id, calendar::turn_zero );
        const auto worn = actor.wear_item(
                              value, false, false, true, true );
        if( !worn ) {
            return nullptr;
        }
        const auto worn_iterator = *worn;
        return std::addressof( *worn_iterator );
    }

    cata::lua_platform::game_handle item_handle(
        item &value, const std::string &scope = "character_inventory" ) const {
        return cata::lua_platform::game_handle::from_item(
                   value,
        { scope, value.uid().get_value(), 0, 0, 0, {} },
        runtime, active_world_generation );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    avatar actor;
    cata::lua_platform::game_handle actor_handle;
    sol::state lua;
    sol::table services;
    bool write_called = false;
};

TEST_CASE( "lua_platform_inventory_weapon_state_matches_native_stow_condition",
           "[lua][platform][inventory][weapon][semantic]" )
{
    platform_equipment_fixture fixture( 207, 1, 6207 );
    const sol::protected_function weapon_state =
        fixture.services["inventory"]["weapon_state"];
    const auto check_native_match = [&]() {
        const talker_character_const native_actor( &fixture.actor );
        const bool native_armed =
            !native_actor.unarmed_attack() &&
            static_cast<bool>( fixture.actor.get_wielded_item() );
        const bool native_can_stow =
            !native_actor.unarmed_attack() && native_actor.can_stash_weapon();
        const sol::protected_function_result result = weapon_state(
                    fixture.actor_handle );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        const sol::table value = envelope["value"].get<sol::table>();
        CHECK( value["armed"].get<bool>() == native_armed );
        CHECK( value["can_stow"].get<bool>() == native_can_stow );
    };

    check_native_match();
    item wielded_value( itype_rock, calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield(
                 wielded_value, std::nullopt, false ) );
    check_native_match();
}

TEST_CASE( "lua_platform_equipment_stow_current_physical_weapon",
           "[lua][platform][equipment][weapon][semantic]" )
{
    platform_equipment_fixture fixture( 208, 1, 6208 );
    REQUIRE( fixture.add_worn_item( itype_debug_backpack ) != nullptr );
    item weapon( itype_rock, calendar::turn_zero );
    const itype_id weapon_type = weapon.typeId();
    REQUIRE( fixture.actor.Character::wield(
                 weapon, std::nullopt, false ) );

    const sol::protected_function stow_current_weapon =
        fixture.services["equipment"]["stow_current_weapon"];
    const sol::protected_function_result result = stow_current_weapon(
                fixture.actor_handle );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( value["invoked"].get<bool>() );
    CHECK( value["path"].get<std::string>() == "remove_weapon_i_add" );
    CHECK_FALSE( value["bionic_deactivated"].valid() );
    CHECK_FALSE( fixture.actor.has_weapon() );
    bool weapon_is_in_inventory = false;
    fixture.actor.visit_items( [&]( item * entry, item * ) {
        weapon_is_in_inventory = weapon_is_in_inventory ||
                                 ( entry != nullptr &&
                                   entry->typeId() == weapon_type );
        return VisitResponse::NEXT;
    } );
    CHECK( weapon_is_in_inventory );
    CHECK( fixture.actor.has_amount( weapon_type, 1 ) );
}

TEST_CASE( "lua_platform_equipment_stow_current_weapon_without_weapon",
           "[lua][platform][equipment][weapon][semantic]" )
{
    platform_equipment_fixture fixture( 210, 1, 6210 );
    REQUIRE_FALSE( fixture.actor.has_weapon() );
    const sol::protected_function stow_current_weapon =
        fixture.services["equipment"]["stow_current_weapon"];
    const sol::protected_function_result result = stow_current_weapon(
                fixture.actor_handle );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( value["invoked"].get<bool>() );
    CHECK( value["path"].get<std::string>() == "remove_weapon_i_add" );
    CHECK_FALSE( value["bionic_deactivated"].valid() );
    CHECK_FALSE( fixture.actor.has_weapon() );
}

TEST_CASE( "lua_platform_equipment_stow_current_weapon_bionic_branch",
           "[lua][platform][equipment][weapon][bionic][semantic]" )
{
    platform_equipment_fixture fixture( 209, 1, 6209 );
    fixture.actor.add_bionic( bio_power_storage );
    fixture.actor.add_bionic( bio_power_storage );
    fixture.actor.set_power_level( fixture.actor.get_max_power_level() );
    fixture.actor.add_bionic( bio_blade );
    bionic &weapon_bionic = fixture.actor.bionic_at_index(
                                fixture.actor.get_bionics().size() - 1 );
    REQUIRE( fixture.actor.activate_bionic( weapon_bionic ) );
    REQUIRE( fixture.actor.is_using_bionic_weapon() );

    const sol::protected_function stow_current_weapon =
        fixture.services["equipment"]["stow_current_weapon"];
    const sol::protected_function_result result = stow_current_weapon(
                fixture.actor_handle );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( value["invoked"].get<bool>() );
    CHECK( value["path"].get<std::string>() == "weapon_bionic" );
    CHECK( value["bionic_deactivated"].get<bool>() );
    CHECK_FALSE( fixture.actor.has_weapon() );
    CHECK_FALSE( fixture.actor.is_using_bionic_weapon() );
}

TEST_CASE( "lua_platform_equipment_stow_current_weapon_failed_bionic_no_fallback",
           "[lua][platform][equipment][weapon][bionic][semantic]" )
{
    platform_equipment_fixture fixture( 212, 1, 6212 );
    fixture.actor.add_bionic( bio_power_storage );
    fixture.actor.add_bionic( bio_power_storage );
    fixture.actor.set_power_level( fixture.actor.get_max_power_level() );
    fixture.actor.add_bionic( bio_blade );
    bionic &weapon_bionic = fixture.actor.bionic_at_index(
                                fixture.actor.get_bionics().size() - 1 );
    REQUIRE( fixture.actor.activate_bionic( weapon_bionic ) );
    weapon_bionic.incapacitated_time = 1_turns;

    const sol::protected_function stow_current_weapon =
        fixture.services["equipment"]["stow_current_weapon"];
    const sol::protected_function_result result = stow_current_weapon(
                fixture.actor_handle );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( value["invoked"].get<bool>() );
    CHECK( value["path"].get<std::string>() == "weapon_bionic" );
    CHECK_FALSE( value["bionic_deactivated"].get<bool>() );
    CHECK( fixture.actor.has_weapon() );
    CHECK( fixture.actor.is_using_bionic_weapon() );
}

TEST_CASE( "lua_platform_inventory_has_stolen_from_matches_native_condition",
           "[lua][platform][inventory][ownership][semantic]" )
{
    platform_equipment_fixture fixture( 211, 1, 6211 );
    npc owner;
    owner.normalize();
    owner.setID( character_id( 6212 ), true );
    owner.set_fac( faction_your_followers );
    REQUIRE( owner.get_faction() != nullptr );
    REQUIRE( owner.inv_dump().empty() );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            owner, { "npc", owner.getID().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );

    item *held_item = fixture.add_item( itype_rock );
    REQUIRE( held_item != nullptr );
    const sol::protected_function has_stolen_from =
        fixture.services["inventory"]["has_stolen_from"];
    const talker_character_const native_holder( &fixture.actor );
    const talker_character_const native_owner( &owner );
    const auto check_native_match = [&]( const bool expected_value ) {
        const bool expected = native_holder.has_stolen_item( native_owner );
        CHECK( expected == expected_value );
        const sol::protected_function_result result = has_stolen_from(
                    fixture.actor_handle, owner_handle );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        CHECK( envelope["value"].get<bool>() == expected );

        const bool reverse_expected = native_owner.has_stolen_item( native_holder );
        CHECK_FALSE( reverse_expected );
        const sol::protected_function_result reverse_result = has_stolen_from(
                    owner_handle, fixture.actor_handle );
        REQUIRE( reverse_result.valid() );
        const sol::table reverse_envelope = reverse_result.get<sol::table>();
        REQUIRE( reverse_envelope["ok"].get<bool>() );
        CHECK( reverse_envelope["value"].get<bool>() == reverse_expected );
    };

    // With available_to_take=true, the native predicate treats an item with
    // no old-owner faction as a match.
    check_native_match( true );
    held_item->set_old_owner( owner.get_faction()->id );
    check_native_match( true );
    REQUIRE( faction_robofac.is_valid() );
    REQUIRE( faction_robofac != owner.get_faction()->id );
    held_item->set_old_owner( faction_robofac );
    check_native_match( false );
}

TEST_CASE( "lua_platform_equipment_wield_inventory_to_wield",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 201, 1, 6201 );
    item *source_item = fixture.add_item( itype_rock );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::table result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result result = wield(
                fixture.actor_handle, source_handle,
                result_holder_1,
                result_holder_2 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    CHECK( envelope["value"].get<sol::table>()["operation"].get<std::string>() ==
           "wield" );
    CHECK( fixture.actor.has_weapon() );
    CHECK( source_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_wear_inventory_to_worn",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 202, 1, 6202 );
    item *source_item = fixture.add_item( itype_backpack );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wear =
        fixture.services["equipment"]["wear"];

    const sol::table result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result result = wear(
                fixture.actor_handle, source_handle,
                result_holder_1,
                result_holder_2 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    const cata::lua_platform::game_handle worn_handle =
        value["handle"].get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> worn =
        worn_handle.resolve_item( fixture.active_runtime,
                                  fixture.active_world_generation );
    REQUIRE( static_cast<bool>( worn ) );
    CHECK( fixture.actor.is_worn( *worn.value ) );
    CHECK( source_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_takeoff_to_explicit_holder",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 203, 1, 6203 );
    item *worn_item = fixture.add_worn_item( itype_backpack );
    REQUIRE( worn_item != nullptr );
    const cata::lua_platform::game_handle worn_handle =
        fixture.item_handle( *worn_item, "character_worn" );
    const sol::protected_function unequip =
        fixture.services["equipment"]["unequip"];

    const sol::protected_function_result result = unequip(
                fixture.actor_handle, worn_handle,
                fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const cata::lua_platform::game_handle moved_handle =
        envelope["value"].get<sol::table>()["handle"]
        .get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> moved =
        moved_handle.resolve_item( fixture.active_runtime,
                                   fixture.active_world_generation );
    REQUIRE( static_cast<bool>( moved ) );
    CHECK( !fixture.actor.is_wearing( itype_backpack ) );
    CHECK( fixture.actor.has_item( *moved.value ) );
    CHECK( worn_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_unwield_to_explicit_holder",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 204, 1, 6204 );
    item wielded_value( itype_rock, calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield( wielded_value, std::nullopt, false ) );
    item_location wielded_location = fixture.actor.get_wielded_item();
    REQUIRE( wielded_location );
    item *wielded_item = wielded_location.get_item();
    REQUIRE( wielded_item != nullptr );
    const cata::lua_platform::game_handle wielded_handle =
        fixture.item_handle( *wielded_item, "character_wielded" );
    const sol::protected_function unequip =
        fixture.services["equipment"]["unequip"];

    const sol::protected_function_result result = unequip(
                fixture.actor_handle, wielded_handle,
                fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const cata::lua_platform::game_handle moved_handle =
        envelope["value"].get<sol::table>()["handle"]
        .get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> moved =
        moved_handle.resolve_item( fixture.active_runtime,
                                   fixture.active_world_generation );
    REQUIRE( static_cast<bool>( moved ) );
    CHECK_FALSE( fixture.actor.has_weapon() );
    CHECK( fixture.actor.has_item( *moved.value ) );
    CHECK( wielded_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_atomic_swap",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 205, 1, 6205 );
    item old_value( itype_rock, calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield( old_value, std::nullopt, false ) );
    item_location old_location = fixture.actor.get_wielded_item();
    REQUIRE( old_location );
    const std::int64_t old_uid = old_location->uid().get_value();
    item *next_item = fixture.add_item( itype_stick );
    REQUIRE( next_item != nullptr );
    const cata::lua_platform::game_handle next_handle =
        fixture.item_handle( *next_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::table result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result result = wield(
                fixture.actor_handle, next_handle,
                result_holder_1,
                result_holder_2 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( fixture.actor.has_weapon() );
    CHECK( fixture.actor.get_wielded_item()->typeId() == itype_stick );
    CHECK( value["displaced_count"].get<std::size_t>() == 1 );
    const sol::table displaced = value["displaced"].get<sol::table>()[1];
    CHECK( displaced["source_uid"].get<std::int64_t>() == old_uid );
    const cata::lua_platform::game_handle displaced_handle =
        displaced["handle"].get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> displaced_item =
        displaced_handle.resolve_item( fixture.active_runtime,
                                       fixture.active_world_generation );
    REQUIRE( static_cast<bool>( displaced_item ) );
    CHECK( displaced_item.value->typeId() == itype_rock );
    CHECK( fixture.actor.has_item( *displaced_item.value ) );
    CHECK( next_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_conflict_destination_rollback",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 206, 1, 6206 );
    const int maximum_worn = item( itype_backpack_hiking ).max_worn();
    REQUIRE( maximum_worn > 0 );
    item *existing = nullptr;
    for( int index = 0; index < maximum_worn; ++index ) {
        existing = fixture.add_worn_item( itype_backpack_hiking );
        REQUIRE( existing != nullptr );
    }
    item *source_item = fixture.add_item( itype_backpack_hiking );
    REQUIRE( source_item != nullptr );
    item *destination_blocker = fixture.add_item( itype_backpack_hiking );
    REQUIRE( destination_blocker != nullptr );
    source_item->set_owner( fixture.actor );
    destination_blocker->set_owner( fixture.actor );
    REQUIRE_FALSE( fixture.actor.can_wear( *source_item ).success() );
    REQUIRE( existing->stacks_with( *destination_blocker ) );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wear =
        fixture.services["equipment"]["wear"];

    const sol::table result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result result = wear(
                fixture.actor_handle, source_handle,
                result_holder_1,
                result_holder_2 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "destination_rejected" );
    CHECK( fixture.actor.is_wearing( itype_backpack_hiking ) );
    CHECK( fixture.actor.has_item( *source_item ) );
    CHECK( fixture.actor.has_item( *destination_blocker ) );
}

TEST_CASE( "lua_platform_equipment_stale_actor_item",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 207, 1, 6207 );
    item *source_item = fixture.add_item( itype_rock );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];
    cata::lua_platform::retire_item_handle_identity( *source_item );

    const sol::table stale_item_result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table stale_item_result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result stale_item_result = wield(
                fixture.actor_handle, source_handle,
                stale_item_result_holder_1,
                stale_item_result_holder_2 );
    REQUIRE( stale_item_result.valid() );
    CHECK_FALSE( stale_item_result.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale_item_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_item" );

    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 207 );
    const cata::lua_platform::game_handle stale_actor =
        cata::lua_platform::game_handle::from_creature(
            fixture.actor, { "character", fixture.actor.getID().get_value(), 0, 0, 0, {} },
            other_runtime, fixture.active_world_generation );
    const sol::table stale_actor_result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table stale_actor_result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result stale_actor_result = wield(
                stale_actor, source_handle,
                stale_actor_result_holder_1,
                stale_actor_result_holder_2 );
    REQUIRE( stale_actor_result.valid() );
    CHECK_FALSE( stale_actor_result.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale_actor_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
}

TEST_CASE( "lua_platform_equipment_wrong_owner",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 208, 1, 6208 );
    avatar owner;
    owner.normalize();
    owner.setID( character_id( 7208 ), true );
    item *foreign_item = &owner.inv->add_item(
                             item( itype_rock, calendar::turn_zero ),
                             false, false, false );
    REQUIRE( foreign_item != nullptr );
    const cata::lua_platform::game_handle foreign_handle =
        cata::lua_platform::game_handle::from_item(
            *foreign_item,
    { "character_inventory", foreign_item->uid().get_value(), 0, 0, 0, {} },
    fixture.runtime, fixture.active_world_generation );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::table result_holder_1 = fixture.holder( fixture.actor_handle );
    const sol::table result_holder_2 = fixture.holder( fixture.actor_handle );
    const sol::protected_function_result result = wield(
                fixture.actor_handle, foreign_handle,
                result_holder_1,
                result_holder_2 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_holder" );
    CHECK( owner.has_item( *foreign_item ) );
    CHECK_FALSE( fixture.actor.has_weapon() );
}

TEST_CASE( "lua_platform_equipment_participant_death",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 209, 1, 6209 );
    npc dying;
    dying.normalize();
    dying.setID( character_id( 7209 ), true );
    cata::lua_platform::register_npc_handle_identity( dying );
    item *source_item = &dying.inv->add_item(
                            item( itype_rock, calendar::turn_zero ),
                            false, false, false );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle dying_handle =
        cata::lua_platform::game_handle::from_creature(
            dying, { "npc", dying.getID().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const cata::lua_platform::game_handle source_handle =
        cata::lua_platform::game_handle::from_item(
            *source_item,
    { "character_inventory", source_item->uid().get_value(), 0, 0, 0, {} },
    fixture.runtime, fixture.active_world_generation );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];
    cata::lua_platform::retire_npc_handle_identity( dying );

    fixture.write_called = false;
    const sol::table result_holder_1 = fixture.holder( dying_handle );
    const sol::table result_holder_2 = fixture.holder( dying_handle );
    const sol::protected_function_result result = wield(
                dying_handle, source_handle,
                result_holder_1, result_holder_2 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( fixture.write_called );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_identity" );
}

TEST_CASE( "lua_platform_equipment_public_surface_has_no_legacy_helpers",
           "[lua][platform][equipment][contract]" )
{
    platform_equipment_fixture fixture( 210, 1, 6210 );
    const sol::table equipment = fixture.services["equipment"];
    REQUIRE( equipment.valid() );
    const std::set<std::string> expected = { "stow_current_weapon", "unequip", "wear", "wield" };
    std::set<std::string> exposed;
    for( const auto &entry : equipment ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK( equipment["wield"].valid() );
    CHECK( equipment["wear"].valid() );
    CHECK( equipment["unequip"].valid() );
    CHECK( equipment["stow_current_weapon"].valid() );

    const sol::table inventory = fixture.services["inventory"];
    CHECK_FALSE( inventory["remove"].valid() );
    CHECK_FALSE( inventory["wield"].valid() );
    CHECK_FALSE( inventory["wear"].valid() );

    cata::lua_platform::install_npc_api(
        fixture.services,
    [fixture_ptr = &fixture]() {
        return fixture_ptr->active_runtime;
    },
    [fixture_ptr = &fixture]() {
        return fixture_ptr->active_world_generation;
    },
    []() {}, []() {}, []() {} );
    const sol::table npcs = fixture.services["npcs"];
    REQUIRE( npcs.valid() );
    CHECK_FALSE( npcs["equipment"].valid() );
}

} // namespace

#endif // CATA_ENABLE_LUA_PLATFORM
