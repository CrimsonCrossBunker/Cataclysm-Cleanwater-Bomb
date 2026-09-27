#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <avatar.h>
#include <character_id.h>
#include <inventory.h>
#include <item.h>
#include <item_location.h>
#include <item_uid.h>
#include <lua_platform_handle.h>
#include <lua_platform_items.h>
#include <lua_platform_vehicles.h>
#include <math_parser_diag_value.h>
#include <monster.h>
#include <npc.h>
#include <pimpl.h>
#include <pocket_type.h>
#include <ret_val.h>
#include <type_id.h>
#include <veh_type.h>
#include <vehicle.h>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <limits>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"
class Character;

static const itype_id itype_2x4( "2x4" );
static const itype_id itype_apple( "apple" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_soldering_iron_portable( "soldering_iron_portable" );
static const vproto_id vehicle_prototype_car( "car" );

TEST_CASE( "lua_platform_game_handles_reject_wrong_owner_and_world", "[lua][platform]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 7 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 7 );
    const cata::lua_platform::game_handle_runtime newer_runtime( owner, 8 );
    monster value;
    value.set_hp( 1 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            value, { "test_character", 0, 0, 0, 0, {} }, runtime, 11 );

    const std::optional<cata::lua_platform::game_handle_error> wrong_world =
        handle.validation_error( runtime, 12 );
    const std::optional<cata::lua_platform::game_handle_error> wrong_owner =
        handle.validation_error( other_runtime, 11 );
    REQUIRE( wrong_world );
    REQUIRE( wrong_owner );
    CHECK( wrong_world->code == "stale_world" );
    CHECK( wrong_owner->code == "stale_runtime" );
    REQUIRE( handle.validation_error( newer_runtime, 11 ) );
    CHECK( handle.validation_error( newer_runtime, 11 )->code == "stale_runtime" );
    CHECK_FALSE( handle.validation_error( runtime, 11 ) );
}

TEST_CASE( "lua_platform_vehicle_handles_bind_owner_world_and_lifetime",
           "[lua][platform][vehicles]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 41 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 41 );
    vehicle value{ vproto_id() };
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 10, 20, 0, {} }, runtime, 3 );

    CHECK( handle.kind() == cata::lua_platform::game_handle_kind::vehicle );
    CHECK( handle.locator().stable_id > 0 );
    CHECK_FALSE( handle.validation_error( runtime, 3 ) );

    const std::optional<cata::lua_platform::game_handle_error> wrong_world =
        handle.validation_error( runtime, 4 );
    const std::optional<cata::lua_platform::game_handle_error> wrong_owner =
        handle.validation_error( other_runtime, 3 );
    REQUIRE( wrong_world );
    REQUIRE( wrong_owner );
    CHECK( wrong_world->code == "stale_world" );
    CHECK( wrong_owner->code == "stale_runtime" );

    cata::lua_platform::retire_vehicle_handle_identity( value );
    const std::optional<cata::lua_platform::game_handle_error> retired =
        handle.validation_error( runtime, 3 );
    REQUIRE( retired );
    CHECK( retired->code == "stale_vehicle" );

    // A replacement handle is explicit and live; the retired handle never
    // becomes valid again merely because the native address is unchanged.
    const cata::lua_platform::game_handle replacement =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 30, 40, 0, {} }, runtime, 3 );
    CHECK_FALSE( replacement.validation_error( runtime, 3 ) );
    CHECK( replacement.locator().stable_id == handle.locator().stable_id );
}

TEST_CASE( "lua_platform_vehicle_part_handles_require_exact_owner_and_identity",
           "[lua][platform][vehicles]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 42 );
    vehicle first{ vproto_id() };
    vehicle second{ vproto_id() };
    vehicle_part detached_part;

    // A part that is not present in the supplied owner cannot be converted
    // into a resolvable handle; callers must obtain it from vehicles.parts.
    const cata::lua_platform::game_handle invalid =
        cata::lua_platform::game_handle::from_vehicle_part(
            detached_part, first, { "vehicle_part", 0, 0, 0, 0, {} },
            runtime, 7 );
    CHECK( invalid.kind() == cata::lua_platform::game_handle_kind::none );

    const cata::lua_platform::game_handle first_handle =
        cata::lua_platform::game_handle::from_vehicle(
            first, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 7 );
    const cata::lua_platform::game_handle second_handle =
        cata::lua_platform::game_handle::from_vehicle(
            second, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 7 );
    CHECK( first_handle.locator().stable_id != second_handle.locator().stable_id );
}

TEST_CASE( "lua_platform_vehicle_part_handles_fail_closed_on_remove_and_replace",
           "[lua][platform][vehicles]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 44 );
    vehicle first{ vehicle_prototype_car };
    vehicle second{ vehicle_prototype_car };
    REQUIRE( first.part_count() > 0 );
    REQUIRE( second.part_count() > 0 );

    const cata::lua_platform::game_handle first_handle =
        cata::lua_platform::game_handle::from_vehicle(
            first, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 8 );
    const cata::lua_platform::game_handle second_handle =
        cata::lua_platform::game_handle::from_vehicle(
            second, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 8 );
    vehicle_part &part = first.part( 0 );
    const cata::lua_platform::game_handle part_handle =
        cata::lua_platform::game_handle::from_vehicle_part(
            part, first, { "vehicle_part", 0, 0, 0, 0, {} }, runtime, 8 );
    REQUIRE( part_handle.kind() == cata::lua_platform::game_handle_kind::vehicle_part );
    CHECK( part_handle.resolve_vehicle_part_for_vehicle(
               first_handle, runtime, 8 ).value == &part );

    const std::optional<cata::lua_platform::game_handle_error> wrong_vehicle =
        part_handle.resolve_vehicle_part_for_vehicle(
            second_handle, runtime, 8 ).error;
    REQUIRE( wrong_vehicle );
    CHECK( wrong_vehicle->code == "wrong_vehicle" );

    part.removed = true;
    const std::optional<cata::lua_platform::game_handle_error> removed =
        part_handle.resolve_vehicle_part( runtime, 8 ).error;
    REQUIRE( removed );
    CHECK( removed->code == "stale_vehicle_part" );

    part.removed = false;
    const std::int64_t old_uid = part.get_base().uid().get_value();
    part.set_base( item( part.info().base_item ) );
    CHECK( part.get_base().uid().get_value() != old_uid );
    const std::optional<cata::lua_platform::game_handle_error> replaced =
        part_handle.resolve_vehicle_part( runtime, 8 ).error;
    REQUIRE( replaced );
    CHECK( replaced->code == "stale_vehicle_part" );

    const cata::lua_platform::game_handle replacement_handle =
        cata::lua_platform::game_handle::from_vehicle_part(
            part, first, { "vehicle_part", 0, 0, 0, 0, {} }, runtime, 8 );
    CHECK( replacement_handle.kind() ==
           cata::lua_platform::game_handle_kind::vehicle_part );
    CHECK( replacement_handle.resolve_vehicle_part_for_vehicle(
               first_handle, runtime, 8 ).value == &part );
}

TEST_CASE( "lua_platform_vehicle_handles_fail_closed_after_unload",
           "[lua][platform][vehicles]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 45 );
    std::optional<cata::lua_platform::game_handle> stale;
    {
        vehicle value{ vproto_id() };
        stale = cata::lua_platform::game_handle::from_vehicle(
                    value, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 9 );
        CHECK_FALSE( stale->validation_error( runtime, 9 ) );
    }
    const std::optional<cata::lua_platform::game_handle_error> error =
        stale->validation_error( runtime, 9 );
    REQUIRE( error );
    CHECK( error->code == "destroyed" );
}

TEST_CASE( "lua_platform_vehicle_api_has_no_implicit_vehicle_selector",
           "[lua][platform][vehicles]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_vehicle_api(
        services,
    []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {},
    []() {} );

    const sol::table vehicles = services["vehicles"];
    REQUIRE( vehicles.valid() );
    CHECK( vehicles["parts"].valid() );
    CHECK( vehicles["set_part_enabled"].valid() );
    CHECK( vehicles["open_part_service"].valid() );
    CHECK_FALSE( vehicles["marked_service_vehicle"].valid() );
    CHECK_FALSE( vehicles["current"].valid() );
    CHECK_FALSE( vehicles["nearest"].valid() );
}

TEST_CASE( "lua_platform_vehicle_mutations_use_the_platform_write_gate",
           "[lua][platform][vehicles]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 46 );
    vehicle value{ vproto_id() };
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 10 );

    sol::state lua;
    sol::table services = lua.create_table();
    bool write_called = false;
    cata::lua_platform::install_game_handle_api(
    lua, services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 10 );
    }, []() {} );
    cata::lua_platform::install_vehicle_api(
    services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 10 );
    }, []() {}, [&]() {
        write_called = true;
    } );

    const sol::table vehicles = services["vehicles"];
    const sol::protected_function rename = vehicles["rename"];
    const sol::protected_function_result result = rename( handle, "explicit" );
    REQUIRE( result.valid() );
    CHECK( write_called );
}

TEST_CASE( "lua_platform_vehicle_part_service_rejects_invalid_requests_before_ui",
           "[lua][platform][vehicles][vehicle_service]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 47 );
    std::size_t active_world = 11;
    vehicle target{ vproto_id() };
    const cata::lua_platform::game_handle vehicle_handle =
        cata::lua_platform::game_handle::from_vehicle(
            target, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, active_world );
    npc mechanic;
    mechanic.normalize();
    mechanic.setID( character_id( 1220 ), true );
    mechanic.set_value( "vehicle_part_service_status", "unchanged" );
    const cata::lua_platform::game_handle mechanic_handle =
        cata::lua_platform::game_handle::from_creature(
            mechanic, { "npc", 1220, 0, 0, 0, {} }, runtime, active_world );

    sol::state lua;
    sol::table services = lua.create_table();
    bool allow_write = true;
    bool write_called = false;
    cata::lua_platform::install_game_handle_api(
    lua, services, [&]() {
        return runtime;
    }, [&]() {
        return active_world;
    }, []() {} );
    cata::lua_platform::install_vehicle_api(
    services, [&]() {
        return runtime;
    }, [&]() {
        return active_world;
    }, []() {}, [&]() {
        write_called = true;
        if( !allow_write ) {
            throw std::runtime_error( "Part service requires a writable runtime phase" );
        }
    } );
    const sol::protected_function open = services["vehicles"]["open_part_service"];
    REQUIRE( open.valid() );
    const auto check_error = [&]( const cata::lua_platform::game_handle & vehicle,
                                  const cata::lua_platform::game_handle & provider,
    const std::string & code ) {
        const sol::protected_function_result result = open( vehicle, provider );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() == code );
    };

    SECTION( "read_only_phase_rejects_before_resolving_or_opening_ui" ) {
        allow_write = false;
        const sol::protected_function_result result = open( vehicle_handle, mechanic_handle );
        REQUIRE_FALSE( result.valid() );
        const sol::error error = result;
        CHECK( std::string( error.what() ).find( "Part service requires a writable runtime phase" ) !=
               std::string::npos );
    }
    SECTION( "vehicle_must_be_an_explicit_vehicle_handle" ) {
        check_error( mechanic_handle, mechanic_handle, "wrong_kind" );
    }
    SECTION( "mechanic_must_be_an_explicit_creature_handle" ) {
        check_error( vehicle_handle, vehicle_handle, "wrong_kind" );
    }
    SECTION( "mechanic_must_be_an_npc" ) {
        monster creature;
        creature.set_hp( 1 );
        const cata::lua_platform::game_handle creature_handle =
            cata::lua_platform::game_handle::from_creature(
                creature, { "test_creature", 0, 0, 0, 0, {} }, runtime, active_world );
        check_error( vehicle_handle, creature_handle, "wrong_subtype" );
    }
    SECTION( "retired_vehicle_identity_is_rejected" ) {
        cata::lua_platform::retire_vehicle_handle_identity( target );
        check_error( vehicle_handle, mechanic_handle, "stale_vehicle" );
    }
    SECTION( "replaced_mechanic_identity_is_rejected" ) {
        mechanic.setID( character_id( 1221 ), true );
        check_error( vehicle_handle, mechanic_handle, "stale_identity" );
    }
    SECTION( "replaced_world_is_rejected" ) {
        ++active_world;
        check_error( vehicle_handle, mechanic_handle, "stale_world" );
    }
    SECTION( "invalid_repair_and_install_multipliers_are_rejected" ) {
        for( const double multiplier : {
                 -1.0, 0.0, 1000.1, std::numeric_limits<double>::infinity(),
                 std::numeric_limits<double>::quiet_NaN()
                 } ) {
            CAPTURE( multiplier );
            CHECK_FALSE( open( vehicle_handle, mechanic_handle, multiplier, 1.0 ).valid() );
            CHECK_FALSE( open( vehicle_handle, mechanic_handle, 1.0, multiplier ).valid() );
        }
    }
    CHECK( write_called );
    CHECK( target.maybe_get_value( "vehicle_part_repair_target" ) == nullptr );
    CHECK( mechanic.get_value( "vehicle_part_service_status" ).str() == "unchanged" );
    CHECK( mechanic.maybe_get_value( "vehicle_part_repair_price_multiplier" ) == nullptr );
    CHECK( mechanic.maybe_get_value( "vehicle_part_install_price_multiplier" ) == nullptr );
}

TEST_CASE( "lua_platform_vehicle_cargo_requires_part_handle_not_index",
           "[lua][platform][vehicles][items]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 43 );
    vehicle value{ vproto_id() };
    const cata::lua_platform::game_handle vehicle_handle =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 1 );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
    lua, services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {} );
    cata::lua_platform::install_item_api(
    services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {} );

    const sol::table item_services = services["items"];
    REQUIRE( item_services.valid() );
    const sol::protected_function page = item_services["page"];
    const sol::table typed_holder = lua.create_table_with(
                                        "kind", "vehicle_cargo",
                                        "vehicle", vehicle_handle,
                                        // Deliberately wrong kind: the
                                        // resolver must reject it, not scan.
                                        "part", vehicle_handle );
    const sol::protected_function_result wrong_part = page( typed_holder );
    REQUIRE( wrong_part.valid() );
    const sol::table wrong_part_envelope = wrong_part.get<sol::table>();
    CHECK_FALSE( wrong_part_envelope["ok"].get<bool>() );
    CHECK( wrong_part_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_kind" );

    const sol::table index_holder = lua.create_table_with(
                                        "kind", "vehicle_cargo",
                                        "vehicle", vehicle_handle,
                                        "part_index", 0 );
    const sol::protected_function_result old_index = page( index_holder );
    CHECK_FALSE( old_index.valid() );
}

TEST_CASE( "lua_platform_game_handles_fail_closed_after_owner_retirement", "[lua][platform]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 3 );
    item value;
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_item(
            value, { "retired_item", value.uid().get_value(), 0, 0, 0, {} }, runtime, 1 );
    CHECK( runtime.has_live_owner() );

    owner->retire();

    CHECK_FALSE( runtime.has_live_owner() );
    CHECK_FALSE( runtime.is_active_match( runtime ) );
    const std::optional<cata::lua_platform::game_handle_error> error =
        handle.validation_error( runtime, 1 );
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_game_handles_reject_destroyed_items", "[lua][platform]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 5 );
    std::optional<cata::lua_platform::game_handle> handle;
    {
        item value;
        handle = cata::lua_platform::game_handle::from_item(
                     value, { "destroyed_item", value.uid().get_value(), 0, 0, 0, {} },
                     runtime, 1 );
        const std::optional<cata::lua_platform::game_handle_error> before_destroy =
            handle->validation_error( runtime, 1 );
        REQUIRE( before_destroy );
        CHECK( before_destroy->code == "invalid_item" );
    }

    const std::optional<cata::lua_platform::game_handle_error> error =
        handle->validation_error( runtime, 1 );
    REQUIRE( error );
    CHECK( error->code == "destroyed" );
}

TEST_CASE( "lua_platform_item_handles_reject_null_item_instances", "[lua][platform]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 12 );
    item value;
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_item(
            value, { "null_item", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );

    const std::optional<cata::lua_platform::game_handle_error> error =
        handle.validation_error( runtime, 1 );
    REQUIRE( error );
    CHECK( error->code == "invalid_item" );
}

TEST_CASE( "lua_platform_item_transform_retires_old_handle_and_reissues_identity",
           "[lua][platform]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 13 );
    item value( itype_rock );
    const cata::lua_platform::game_handle old_handle =
        cata::lua_platform::game_handle::from_item(
            value, { "character_carried", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );

    CHECK_FALSE( old_handle.validation_error( runtime, 1 ) );
    cata::lua_platform::retire_item_handle_identity( value );

    const std::optional<cata::lua_platform::game_handle_error> stale =
        old_handle.validation_error( runtime, 1 );
    REQUIRE( stale );
    CHECK( stale->code == "stale_item" );

    const cata::lua_platform::game_handle replacement =
        cata::lua_platform::game_handle::from_item(
            value, { "character_carried", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );
    CHECK_FALSE( replacement.validation_error( runtime, 1 ) );
}

TEST_CASE( "lua_platform_item_holder_resolution_rejects_wrong_character",
           "[lua][platform][items]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 14 );
    avatar character;
    character.normalize();
    character.setID( character_id( 6400 ), true );
    item value( itype_rock );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "character_inventory", 0, 0, 0, 0, {} },
            runtime, 1 );
    const cata::lua_platform::game_handle item_handle =
        cata::lua_platform::game_handle::from_item(
            value, { "character_inventory", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );

    Character *resolved_character = nullptr;
    item *resolved_item = nullptr;
    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK_FALSE( cata::lua_platform::resolve_exact_item_for_character(
                     character_handle, item_handle, runtime, 1,
                     resolved_character, resolved_item, error ) );
    REQUIRE( error );
    CHECK( error->code == "not_owned" );
    CHECK( resolved_character == &character );
    CHECK( resolved_item == nullptr );
}

TEST_CASE( "lua_platform_item_page_is_the_only_public_traversal_entry",
           "[lua][platform][items][pagination]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_item_api(
        services,
    []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {},
    []() {} );

    const sol::table items = services["items"];
    REQUIRE( items.valid() );
    CHECK( items["page"].valid() );
    CHECK_FALSE( items["pockets"].valid() );
    CHECK_FALSE( items["contents"].valid() );

    const sol::table inventory = services["inventory"];
    REQUIRE( inventory.valid() );
    CHECK( inventory["remove_type"].valid() );
    CHECK_FALSE( inventory["find"].valid() );
    CHECK_FALSE( inventory["list"].valid() );
    CHECK_FALSE( inventory["filter"].valid() );
}

TEST_CASE( "lua_platform_inventory_remove_type_matches_character_removal_scope",
           "[lua][platform][items][mutation][semantic]" )
{
    // Native f_remove_item_with delegates through talker_character directly
    // to Character::remove_items_with; this service does the same, preserving
    // that method's inventory, worn, wielded, and nested-item traversal.
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 32 );
    constexpr std::size_t world_generation = 1;
    const itype_id backpack_type( "backpack" );

    avatar native_character;
    native_character.normalize();
    native_character.setID( character_id( 6401 ), true );
    item &native_inventory_match = native_character.inv->add_item(
                                       item( backpack_type ), false, false, false );
    item native_nested_container( itype_debug_backpack );
    REQUIRE( native_nested_container.put_in(
                 item( backpack_type ), pocket_type::CONTAINER ).success() );
    item &native_inventory_container = native_character.inv->add_item(
                                          std::move( native_nested_container ),
                                          false, false, false );
    item *native_nested_match = nullptr;
    for( item *contained : native_inventory_container.all_items_top() ) {
        if( contained->typeId() == backpack_type ) {
            native_nested_match = contained;
        }
    }
    REQUIRE( native_nested_match != nullptr );
    item native_worn_match( backpack_type );
    const auto native_worn = native_character.wear_item(
                                 native_worn_match, false, false, true, true );
    REQUIRE( native_worn.has_value() );
    REQUIRE( native_character.has_item( native_inventory_match ) );
    REQUIRE( native_character.has_item( native_inventory_container ) );
    REQUIRE( native_character.has_item( *native_nested_match ) );
    REQUIRE( native_character.has_item( **native_worn ) );
    item native_wielded_match( itype_rock );
    REQUIRE( native_character.Character::wield(
                 native_wielded_match, std::nullopt, false ) );
    const item_location native_wielded_location = native_character.get_wielded_item();
    REQUIRE( native_wielded_location );
    item *native_wielded_item = native_wielded_location.get_item();
    REQUIRE( native_wielded_item != nullptr );
    REQUIRE( native_character.has_item( *native_wielded_item ) );

    const auto native_backpacks = native_character.remove_items_with(
        [&backpack_type]( const item &entry ) {
            return entry.typeId() == backpack_type;
        } );
    CHECK( native_backpacks.size() == 3 );
    CHECK_FALSE( native_character.is_wearing( backpack_type ) );
    CHECK_FALSE( native_character.has_amount( backpack_type, 1 ) );
    const auto native_rocks = native_character.remove_items_with(
        []( const item &entry ) {
            return entry.typeId() == itype_rock;
        } );
    CHECK( native_rocks.size() == 1 );
    CHECK_FALSE( native_character.has_weapon() );
    native_character.inv->add_item( item( itype_2x4 ), false, false, false );
    const itype_id unknown_item_type( "__unknown_remove_type_test__" );
    const auto native_unknown = native_character.remove_items_with(
        [&unknown_item_type]( const item &entry ) {
            return entry.typeId() == unknown_item_type;
        } );
    CHECK( native_unknown.empty() );
    CHECK( native_character.has_amount( itype_2x4, 1 ) );

    avatar character;
    character.normalize();
    character.setID( character_id( 6402 ), true );

    item &inventory_match = character.inv->add_item(
                                item( backpack_type ), false, false, false );
    item nested_container( itype_debug_backpack );
    REQUIRE( nested_container.put_in(
                 item( backpack_type ), pocket_type::CONTAINER ).success() );
    item &nested_inventory_container = character.inv->add_item(
        std::move( nested_container ), false, false, false );
    item *nested_inventory_match = nullptr;
    for( item *contained : nested_inventory_container.all_items_top() ) {
        if( contained->typeId() == backpack_type ) {
            nested_inventory_match = contained;
        }
    }
    REQUIRE( nested_inventory_match != nullptr );
    item worn_match( backpack_type );
    const auto worn = character.wear_item(
                          worn_match, false, false, true, true );
    REQUIRE( worn.has_value() );
    item wielded_match( itype_rock );
    REQUIRE( character.Character::wield(
                 wielded_match, std::nullopt, false ) );

    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "avatar", character.getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const cata::lua_platform::game_handle removed_item_handle =
        cata::lua_platform::game_handle::from_item(
            inventory_match,
            { "character_inventory", inventory_match.uid().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const cata::lua_platform::game_handle nested_item_handle =
        cata::lua_platform::game_handle::from_item(
            *nested_inventory_match,
            { "character_inventory", nested_inventory_match->uid().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const item_location wielded_location = character.get_wielded_item();
    REQUIRE( wielded_location );
    item *wielded_item = wielded_location.get_item();
    REQUIRE( wielded_item != nullptr );
    REQUIRE( character.has_item( inventory_match ) );
    REQUIRE( character.has_item( nested_inventory_container ) );
    REQUIRE( character.has_item( *nested_inventory_match ) );
    REQUIRE( character.has_item( **worn ) );
    REQUIRE( character.has_item( *wielded_item ) );
    const cata::lua_platform::game_handle wielded_item_handle =
        cata::lua_platform::game_handle::from_item(
            *wielded_item,
            { "character_wielded", wielded_item->uid().get_value(), 0, 0, 0, {} },
            runtime, world_generation );

    sol::state lua;
    sol::table services = lua.create_table();
    int write_gate_calls = 0;
    const auto current_runtime = [&]() {
        return runtime;
    };
    const auto current_world = [&]() {
        return world_generation;
    };
    cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_item_api(
        services, current_runtime, current_world, []() {}, [&]() {
        ++write_gate_calls;
    } );

    const sol::protected_function remove_type =
        services["inventory"]["remove_type"];
    const sol::protected_function_result backpack_result = remove_type(
                character_handle,
                cata::lua_platform::script_game_id( "item", "backpack" ) );
    REQUIRE( backpack_result.valid() );
    const sol::table backpack_envelope = backpack_result.get<sol::table>();
    REQUIRE( backpack_envelope["ok"].get<bool>() );
    const sol::table backpack_value =
        backpack_envelope["value"].get<sol::table>();
    CHECK( backpack_value["removed"].get<std::size_t>() ==
           native_backpacks.size() );
    CHECK_FALSE( character.is_wearing( backpack_type ) );
    CHECK_FALSE( character.has_amount( backpack_type, 1 ) );
    CHECK( removed_item_handle.validation_error(
               runtime, world_generation ).has_value() );
    CHECK( nested_item_handle.validation_error(
               runtime, world_generation ).has_value() );

    const sol::protected_function_result wielded_result = remove_type(
                character_handle,
                cata::lua_platform::script_game_id( "item", "rock" ) );
    REQUIRE( wielded_result.valid() );
    const sol::table wielded_envelope = wielded_result.get<sol::table>();
    REQUIRE( wielded_envelope["ok"].get<bool>() );
    CHECK( wielded_envelope["value"].get<sol::table>()
           ["removed"].get<std::size_t>() == native_rocks.size() );
    CHECK_FALSE( character.has_weapon() );
    CHECK( wielded_item_handle.validation_error(
               runtime, world_generation ).has_value() );

    character.inv->add_item( item( itype_2x4 ), false, false, false );
    const std::uint64_t before_unknown_id =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result unknown_result = remove_type(
                character_handle,
                cata::lua_platform::script_game_id(
                    "item", unknown_item_type.str() ) );
    REQUIRE( unknown_result.valid() );
    const sol::table unknown_envelope = unknown_result.get<sol::table>();
    REQUIRE( unknown_envelope["ok"].get<bool>() );
    CHECK( unknown_envelope["value"].get<sol::table>()
           ["removed"].get<std::size_t>() == native_unknown.size() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           before_unknown_id );
    CHECK( character.has_amount( itype_2x4, 1 ) );

    avatar &avatar_decoy = character;
    item &avatar_decoy_apple = avatar_decoy.inv->add_item(
                                   item( itype_apple ), false, false, false );
    REQUIRE( avatar_decoy.has_item( avatar_decoy_apple ) );
    npc native_npc;
    native_npc.normalize();
    native_npc.setID( character_id( 6410 ), true );
    item &native_npc_apple = native_npc.inv->add_item(
                                 item( itype_apple ), false, false, false );
    REQUIRE( native_npc.has_item( native_npc_apple ) );
    const auto native_npc_removed = native_npc.remove_items_with(
        []( const item &entry ) {
            return entry.typeId() == itype_apple;
        } );
    CHECK( native_npc_removed.size() == 1 );

    npc platform_npc;
    platform_npc.normalize();
    platform_npc.setID( character_id( 6411 ), true );
    item &platform_npc_apple = platform_npc.inv->add_item(
                                   item( itype_apple ), false, false, false );
    REQUIRE( platform_npc.has_item( platform_npc_apple ) );
    cata::lua_platform::register_npc_handle_identity( platform_npc );
    const cata::lua_platform::game_handle npc_handle =
        cata::lua_platform::game_handle::from_creature(
            platform_npc, { "npc", platform_npc.getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const sol::protected_function_result npc_result = remove_type(
                npc_handle, cata::lua_platform::script_game_id( "item", "apple" ) );
    REQUIRE( npc_result.valid() );
    const sol::table npc_envelope = npc_result.get<sol::table>();
    REQUIRE( npc_envelope["ok"].get<bool>() );
    CHECK( npc_envelope["value"].get<sol::table>()
           ["removed"].get<std::size_t>() == native_npc_removed.size() );
    CHECK_FALSE( platform_npc.has_amount( itype_apple, 1 ) );
    CHECK( avatar_decoy.has_amount( itype_apple, 1 ) );
    CHECK( write_gate_calls == 4 );
    cata::lua_platform::retire_npc_handle_identity( platform_npc );
}

TEST_CASE( "lua_platform_inventory_consume_by_type_matches_native_talker_search",
           "[lua][platform][items][mutation][semantic]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 33 );
    constexpr std::size_t world_generation = 1;
    avatar character;
    character.normalize();
    character.setID( character_id( 6403 ), true );
    item &apple = character.inv->add_item(
                      item( itype_apple ), false, false, false );

    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "avatar", character.getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const cata::lua_platform::game_handle apple_handle =
        cata::lua_platform::game_handle::from_item(
            apple, { "character_inventory", apple.uid().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    sol::state lua;
    sol::table services = lua.create_table();
    int write_gate_calls = 0;
    const auto current_runtime = [&]() {
        return runtime;
    };
    const auto current_world = [&]() {
        return world_generation;
    };
    cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_item_api(
        services, current_runtime, current_world, []() {}, [&]() {
        ++write_gate_calls;
    } );
    const sol::protected_function consume =
        services["inventory"]["consume_by_type"];

    // Native f_consume_item falls through to has_amount(count) even when a
    // positive requested charge amount is unavailable.
    const std::uint64_t epoch_before_amount =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result amount_result = consume(
                character_handle,
                cata::lua_platform::script_game_id( "item", "apple" ), 1, 9 );
    REQUIRE( amount_result.valid() );
    const sol::table amount_envelope = amount_result.get<sol::table>();
    REQUIRE( amount_envelope["ok"].get<bool>() );
    const sol::table amount_value = amount_envelope["value"].get<sol::table>();
    CHECK( amount_value["matched"].get<bool>() );
    CHECK( amount_value["count"].get<int>() == 1 );
    CHECK( amount_value["charges"].get<int>() == 9 );
    CHECK_FALSE( character.has_amount( itype_apple, 1 ) );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           epoch_before_amount );
    CHECK( apple_handle.validation_error(
               runtime, world_generation ).has_value() );

    // A zero count with unavailable charges reaches native has_amount(id, 0),
    // which matches and performs no mutation rather than showing the popup.
    const std::uint64_t epoch_before_zero =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result zero_result = consume(
                character_handle,
                cata::lua_platform::script_game_id( "item", "apple" ), 0, 2 );
    REQUIRE( zero_result.valid() );
    const sol::table zero_envelope = zero_result.get<sol::table>();
    REQUIRE( zero_envelope["ok"].get<bool>() );
    CHECK( zero_envelope["value"].get<sol::table>()
           ["matched"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           epoch_before_zero );

    const std::uint64_t epoch_before_out_of_range =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result out_of_range_result = consume(
                character_handle,
                cata::lua_platform::script_game_id( "item", "apple" ),
                static_cast<std::int64_t>( std::numeric_limits<int>::max() ) + 1,
                0 );
    CHECK_FALSE( out_of_range_result.valid() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           epoch_before_out_of_range );

    // count-by-charges item types move count to charges when charges is zero.
    REQUIRE( item::count_by_charges( itype_battery ) );
    item battery( itype_battery );
    battery.charges = 5;
    item &stored_battery = character.inv->add_item(
                              std::move( battery ), false, false, false );
    const cata::lua_platform::game_handle battery_handle =
        cata::lua_platform::game_handle::from_item(
            stored_battery, { "character_inventory", stored_battery.uid().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const std::uint64_t epoch_before_partial_charges =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result battery_result = consume(
                character_handle,
                cata::lua_platform::script_game_id( "item", "battery" ), 2, 0 );
    REQUIRE( battery_result.valid() );
    const sol::table battery_envelope = battery_result.get<sol::table>();
    REQUIRE( battery_envelope["ok"].get<bool>() );
    const sol::table battery_value = battery_envelope["value"].get<sol::table>();
    CHECK( battery_value["matched"].get<bool>() );
    CHECK( battery_value["count"].get<int>() == 0 );
    CHECK( battery_value["charges"].get<int>() == 2 );
    CHECK( character.charges_of( itype_battery ) == 3 );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           epoch_before_partial_charges );
    const auto partially_consumed_battery = battery_handle.resolve_item(
                runtime, world_generation );
    REQUIRE( partially_consumed_battery );
    CHECK( partially_consumed_battery.value->charges == 3 );

    const std::uint64_t epoch_before_full_charges =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result full_battery_result = consume(
                character_handle,
                cata::lua_platform::script_game_id( "item", "battery" ), 0, 3 );
    REQUIRE( full_battery_result.valid() );
    const sol::table full_battery_envelope = full_battery_result.get<sol::table>();
    REQUIRE( full_battery_envelope["ok"].get<bool>() );
    CHECK( full_battery_envelope["value"].get<sol::table>()
           ["matched"].get<bool>() );
    CHECK_FALSE( character.has_amount( itype_battery, 1 ) );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           epoch_before_full_charges );
    CHECK( battery_handle.validation_error(
               runtime, world_generation ).has_value() );

    // talker_character's in_tools=true path includes ammo stored in tools.
    item tool( itype_soldering_iron_portable );
    tool.ammo_set( itype_battery, 5 );
    item &stored_tool = character.inv->add_item(
                            std::move( tool ), false, false, false );
    const std::uint64_t epoch_before_tool_charges =
        cata::lua_platform::item_holder_mutation_generation();
    const sol::protected_function_result tool_result = consume(
                character_handle,
                cata::lua_platform::script_game_id( "item", "battery" ), 0, 2 );
    REQUIRE( tool_result.valid() );
    const sol::table tool_envelope = tool_result.get<sol::table>();
    REQUIRE( tool_envelope["ok"].get<bool>() );
    CHECK( tool_envelope["value"].get<sol::table>()
           ["matched"].get<bool>() );
    CHECK( stored_tool.ammo_remaining() == 3 );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           epoch_before_tool_charges );
    CHECK( write_gate_calls == 6 );

    // Do not invoke the unmatched branch in this headless test: production
    // calls the native modal popup directly, with no Lua notice text limit.
}

TEST_CASE( "lua_platform_item_page_binds_cursor_to_root_and_generations",
           "[lua][platform][items][pagination][semantic]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime active_runtime( owner, 31 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 31 );
    std::size_t active_world = 1;

    avatar character;
    character.normalize();
    character.setID( character_id( 6401 ), true );
    character.inv->add_item(
        item( itype_rock ), false, false, false );
    character.inv->add_item(
        item( itype_2x4 ), false, false, false );
    item nested_container( itype_debug_backpack );
    REQUIRE( nested_container.put_in(
                 item( itype_rock ), pocket_type::CONTAINER ).success() );
    character.inv->add_item(
        std::move( nested_container ), false, false, false );

    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "character", character.getID().get_value(), 0, 0, 0, {} },
            active_runtime, active_world );

    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [&]() {
        return active_runtime;
    };
    const auto current_world = [&]() {
        return active_world;
    };
    cata::lua_platform::install_game_handle_api(
    lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_item_api(
    services, current_runtime, current_world, []() {}, []() {} );

    const sol::table holder = lua.create_table_with(
                                  "kind", "character",
                                  "character", character_handle,
                                  "slot", "inventory" );
    const sol::table options = lua.create_table_with(
                                   "page_size", 1,
                                   "max_depth", 8,
                                   "recursive", true );
    const sol::table item_services = services["items"];
    const sol::protected_function page = item_services["page"];

    const sol::protected_function_result first_result = page( holder, options );
    REQUIRE( first_result.valid() );
    const sol::table first_envelope = first_result.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_page = first_envelope["value"].get<sol::table>();
    REQUIRE( first_page["returned"].get<std::size_t>() == 1 );
    REQUIRE_FALSE( first_page["complete"].get<bool>() );
    REQUIRE( first_page["truncated"].get<bool>() );
    REQUIRE( first_page["stop_reason"].get<std::string>() == "page" );
    REQUIRE( first_page["continuation"].is<sol::table>() );
    const sol::table continuation =
        first_page["continuation"].get<sol::table>();

    const sol::protected_function_result next_result =
        page( holder, options, continuation );
    REQUIRE( next_result.valid() );
    const sol::table next_envelope = next_result.get<sol::table>();
    REQUIRE( next_envelope["ok"].get<bool>() );
    CHECK( next_envelope["value"].get<sol::table>()["returned"].get<std::size_t>() == 1 );

    const sol::protected_function_result reused_result =
        page( holder, options, continuation );
    REQUIRE( reused_result.valid() );
    const sol::table reused_envelope = reused_result.get<sol::table>();
    CHECK_FALSE( reused_envelope["ok"].get<bool>() );
    CHECK( reused_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    active_world = 1;
    const sol::protected_function_result second_first_result = page( holder, options );
    REQUIRE( second_first_result.valid() );
    const sol::table second_first = second_first_result.get<sol::table>();
    const sol::table second_value = second_first["value"].get<sol::table>();
    const sol::table second_continuation =
        second_value["continuation"].get<sol::table>();
    active_world = 2;
    const sol::protected_function_result wrong_world_result =
        page( holder, options, second_continuation );
    REQUIRE( wrong_world_result.valid() );
    const sol::table wrong_world = wrong_world_result.get<sol::table>();
    CHECK_FALSE( wrong_world["ok"].get<bool>() );
    CHECK( wrong_world["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    active_world = 1;
    active_runtime = cata::lua_platform::game_handle_runtime( owner, 31 );
    const sol::protected_function_result owner_first_result = page( holder, options );
    REQUIRE( owner_first_result.valid() );
    const sol::table owner_first = owner_first_result.get<sol::table>();
    REQUIRE( owner_first["ok"].get<bool>() );
    const sol::table owner_value = owner_first["value"].get<sol::table>();
    const sol::table owner_continuation =
        owner_value["continuation"].get<sol::table>();

    active_runtime = other_runtime;
    const sol::protected_function_result wrong_owner_result =
        page( holder, options, owner_continuation );
    REQUIRE( wrong_owner_result.valid() );
    const sol::table wrong_owner = wrong_owner_result.get<sol::table>();
    CHECK_FALSE( wrong_owner["ok"].get<bool>() );
    CHECK( wrong_owner["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    active_runtime = cata::lua_platform::game_handle_runtime( owner, 31 );
    const sol::protected_function_result third_first_result = page( holder, options );
    REQUIRE( third_first_result.valid() );
    const sol::table third_first = third_first_result.get<sol::table>();
    const sol::table third_value = third_first["value"].get<sol::table>();
    const sol::table mutation_continuation =
        third_value["continuation"].get<sol::table>();
    cata::lua_platform::bump_item_query_mutation_epoch();
    const sol::protected_function_result stale_result =
        page( holder, options, mutation_continuation );
    REQUIRE( stale_result.valid() );
    const sol::table stale_envelope = stale_result.get<sol::table>();
    CHECK_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    const sol::table depth_options = lua.create_table_with(
                                         "page_size", 256,
                                         "max_depth", 0,
                                         "recursive", true );
    const sol::protected_function_result depth_result = page( holder, depth_options );
    REQUIRE( depth_result.valid() );
    const sol::table depth_envelope = depth_result.get<sol::table>();
    REQUIRE( depth_envelope["ok"].get<bool>() );
    const sol::table depth_page = depth_envelope["value"].get<sol::table>();
    CHECK_FALSE( depth_page["complete"].get<bool>() );
    CHECK( depth_page["truncated"].get<bool>() );
    CHECK( depth_page["stop_reason"].get<std::string>() == "max_depth" );

    character.inv->clear();
    for( int index = 0; index < 65; ++index ) {
        item entry( itype_rock );
        entry.set_var( "page_entry", index );
        character.inv->add_item( std::move( entry ), false, false, false );
    }
    cata::lua_platform::bump_item_query_mutation_epoch();
    lua.open_libraries( sol::lib::base );
    lua["services"] = services;
    lua["holder"] = holder;
    const sol::protected_function_result default_pages = lua.safe_script( R"(
        local page = services.items.page
        local first = page(holder).value
        assert(first.returned == 64 and not first.complete)
        local cursor = first.continuation
        for _, invalid in ipairs({false, 7, "bad", function() end}) do
            assert(not pcall(page, holder, invalid, cursor))
        end
        local resumed = page(holder, nil, cursor)
        assert(resumed.ok)
        local last = resumed.value
        assert(last.returned == 1 and last.complete and last.continuation == nil)
        local seen = {}
        for _, entry in ipairs(first.items) do seen[entry.uid] = true end
        assert(not seen[last.items[1].uid])
        local reused = page(holder, nil, cursor)
        assert(not reused.ok and reused.error.code == "stale_continuation")
        local unknown = page(holder, nil, {continuation_id=0})
        assert(not unknown.ok and unknown.error.code == "stale_continuation")
    )", sol::script_pass_on_error );
    REQUIRE( default_pages.valid() );
}

#endif // CATA_ENABLE_LUA_PLATFORM
