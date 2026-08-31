#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_game_handles_reject_wrong_owner_and_world", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 44 );
    vehicle first{ vproto_id( "car" ) };
    vehicle second{ vproto_id( "car" ) };
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    CHECK_FALSE( vehicles["marked_service_vehicle"].valid() );
    CHECK_FALSE( vehicles["current"].valid() );
    CHECK_FALSE( vehicles["nearest"].valid() );
}

TEST_CASE( "lua_platform_vehicle_mutations_use_the_platform_write_gate",
           "[lua][platform][vehicles]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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

TEST_CASE( "lua_platform_vehicle_cargo_requires_part_handle_not_index",
           "[lua][platform][vehicles][items]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 13 );
    item value( itype_id( "rock" ) );
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
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 14 );
    avatar character;
    character.normalize();
    character.setID( character_id( 6400 ), true );
    item value( itype_id( "rock" ) );
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
    CHECK_FALSE( inventory["find"].valid() );
    CHECK_FALSE( inventory["list"].valid() );
    CHECK_FALSE( inventory["filter"].valid() );
}

TEST_CASE( "lua_platform_item_page_binds_cursor_to_root_and_generations",
           "[lua][platform][items][pagination]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime active_runtime( owner, 31 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 31 );
    std::size_t active_world = 1;

    avatar character;
    character.normalize();
    character.setID( character_id( 6401 ), true );
    character.inv->add_item(
        item( itype_id( "rock" ) ), false, false, false );
    character.inv->add_item(
        item( itype_id( "2x4" ) ), false, false, false );
    item nested_container( itype_id( "debug_backpack" ) );
    REQUIRE( nested_container.put_in(
                  item( itype_id( "rock" ) ), pocket_type::CONTAINER ).success() );
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
}

#endif // CATA_ENABLE_LUA_PLATFORM
