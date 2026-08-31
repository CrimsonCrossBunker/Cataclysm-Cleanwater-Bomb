#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_hordes_read_surface_is_registered",
           "[lua][platform][hordes][contract]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_horde_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::object hordes_object = services["hordes"];
    REQUIRE( hordes_object.is<sol::table>() );
    const sol::table hordes = hordes_object.as<sol::table>();
    CHECK( hordes["limits"].get_type() == sol::type::function );
    CHECK( hordes["definitions"].get_type() == sol::type::function );
    CHECK( hordes["definition"].get_type() == sol::type::function );
    CHECK( hordes["monsters"].get_type() == sol::type::function );
    CHECK( hordes["contains"].get_type() == sol::type::function );
    CHECK( hordes["entities"].get_type() == sol::type::function );
    CHECK( hordes["entity"].get_type() == sol::type::function );
    CHECK( hordes["legacy_groups"].get_type() == sol::type::function );
    CHECK( hordes["legacy_group"].get_type() == sol::type::function );
    CHECK( hordes["summary"].get_type() == sol::type::function );
    CHECK( hordes["spawn_entity"].get_type() == sol::type::function );
    CHECK( hordes["alert_entity"].get_type() == sol::type::function );
    CHECK( hordes["remove_entity"].get_type() == sol::type::function );
    CHECK( hordes["spawn_legacy_group"].get_type() == sol::type::function );
    CHECK( hordes["update_legacy_group"].get_type() == sol::type::function );
    CHECK( hordes["remove_legacy_group"].get_type() == sol::type::function );
    CHECK_FALSE( hordes["signal"].valid() );
    CHECK_FALSE( hordes["advance"].valid() );
}

TEST_CASE( "lua_platform_hordes_alert_entity_commits_with_before_and_after",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const cata::lua_platform::script_tripoint_coord position =
        make_position( tripoint_abs_ms( 1000, 1000, 0 ) );
    const cata::lua_platform::script_tripoint_coord original_destination =
        make_position( tripoint_abs_ms( 0, 0, 0 ) );
    const cata::lua_platform::script_tripoint_coord new_destination =
        make_position( tripoint_abs_ms( 1020, 1010, 0 ) );
    constexpr int original_intensity = 0;
    constexpr int new_intensity = 31;

    const sol::protected_function_result spawn_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    CHECK( spawn_value["status"].get<std::string>() == "committed" );
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_entity"]( token );
    } );

    const sol::protected_function_result alert_result =
        hordes["alert_entity"]( token, new_destination, new_intensity );
    REQUIRE( alert_result.valid() );
    const sol::table alert_envelope = alert_result.get<sol::table>();
    REQUIRE( alert_envelope["ok"].get<bool>() );
    const sol::table alert_value = alert_envelope["value"].get<sol::table>();
    CHECK( alert_value["status"].get<std::string>() == "committed" );

    const sol::table before = alert_value["before"].get<sol::table>();
    const sol::table after = alert_value["after"].get<sol::table>();
    REQUIRE( before.valid() );
    REQUIRE( after.valid() );
    CHECK( before["destination"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           original_destination );
    CHECK( before["tracking_intensity"].get<int>() == original_intensity );
    CHECK( after["destination"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           new_destination );
    CHECK( after["tracking_intensity"].get<int>() == new_intensity );
    CHECK( after["token"].get<sol::userdata>()
           ["identity_generation"].get<std::size_t>() ==
           token["identity_generation"].get<std::size_t>() );
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );
}

TEST_CASE( "lua_platform_hordes_alert_entity_invalid_intensity_is_unchanged",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const cata::lua_platform::script_tripoint_coord position =
        make_position( tripoint_abs_ms( 1100, 1000, 0 ) );
    const cata::lua_platform::script_tripoint_coord original_destination =
        make_position( tripoint_abs_ms( 0, 0, 0 ) );
    const cata::lua_platform::script_tripoint_coord committed_destination =
        make_position( tripoint_abs_ms( 1120, 1010, 0 ) );
    constexpr int original_intensity = 0;
    constexpr int committed_intensity = 37;

    const sol::protected_function_result spawn_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    CHECK( spawn_value["status"].get<std::string>() == "committed" );
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_entity"]( token );
    } );

    const sol::protected_function_result invalid_result =
        hordes["alert_entity"]( token, committed_destination, -1 );
    CHECK_FALSE( invalid_result.valid() );

    // There is no public injection seam for making the post-insert token
    // resolution fail, so that post-commit rollback branch remains uncovered.
    const sol::protected_function_result committed_result =
        hordes["alert_entity"](
            token, committed_destination, committed_intensity );
    REQUIRE( committed_result.valid() );
    const sol::table committed_envelope = committed_result.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    const sol::table committed_value =
        committed_envelope["value"].get<sol::table>();
    CHECK( committed_value["status"].get<std::string>() == "committed" );
    const sol::table before = committed_value["before"].get<sol::table>();
    REQUIRE( before.valid() );
    CHECK( before["destination"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           original_destination );
    CHECK( before["tracking_intensity"].get<int>() == original_intensity );
}

TEST_CASE( "lua_platform_hordes_update_legacy_group_commits_multi_field_update",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_sm &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   position.raw() );
    };
    const tripoint_abs_sm group_position = get_map().get_abs_sub();
    const tripoint_abs_sm original_target_position(
        group_position.x() + 2, group_position.y() + 3,
        group_position.z() );
    const tripoint_abs_sm original_nemesis_target_position(
        group_position.x() - 4, group_position.y() + 1,
        group_position.z() );
    const tripoint_abs_sm updated_target_position(
        group_position.x() + 8, group_position.y() - 2,
        group_position.z() );
    const tripoint_abs_sm updated_nemesis_target_position(
        group_position.x() - 6, group_position.y() - 5,
        group_position.z() );

    sol::table spawn_options = lua.create_table();
    spawn_options["group"] = cata::lua_platform::script_game_id(
                                  "monster_group", "GROUP_ZOMBIE" );
    spawn_options["position"] = make_position( group_position );
    spawn_options["population"] = 111;
    spawn_options["interest"] = 27;
    spawn_options["dying"] = false;
    spawn_options["horde"] = true;
    spawn_options["behavior"] = "roam";
    spawn_options["target"] = make_position( original_target_position );
    spawn_options["nemesis_target"] =
        make_position( original_nemesis_target_position );

    const sol::protected_function_result spawn_result =
        hordes["spawn_legacy_group"]( spawn_options );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    CHECK( spawn_value["status"].get<std::string>() == "committed" );
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_legacy_group"]( token );
    } );

    sol::table update_options = lua.create_table();
    update_options["population"] = 456;
    update_options["interest"] = 83;
    update_options["dying"] = true;
    update_options["horde"] = false;
    update_options["behavior"] = "nemesis";
    update_options["target"] = make_position( updated_target_position );
    update_options["nemesis_target"] =
        make_position( updated_nemesis_target_position );

    const sol::protected_function_result update_result =
        hordes["update_legacy_group"]( token, update_options );
    REQUIRE( update_result.valid() );
    const sol::table update_envelope = update_result.get<sol::table>();
    REQUIRE( update_envelope["ok"].get<bool>() );
    const sol::table update_value = update_envelope["value"].get<sol::table>();
    CHECK( update_value["status"].get<std::string>() == "committed" );
    const sol::table before = update_value["before"].get<sol::table>();
    const sol::table after = update_value["after"].get<sol::table>();
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );

    CHECK( before["population"].get<unsigned int>() == 111U );
    CHECK( before["interest"].get<int>() == 27 );
    CHECK_FALSE( before["dying"].get<bool>() );
    CHECK( before["horde"].get<bool>() );
    CHECK( before["behavior"].get<std::string>() == "roam" );
    CHECK( before["target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_target_position ) );
    CHECK( before["nemesis_target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_nemesis_target_position ) );

    CHECK( after["population"].get<unsigned int>() == 456U );
    CHECK( after["interest"].get<int>() == 83 );
    CHECK( after["dying"].get<bool>() );
    CHECK_FALSE( after["horde"].get<bool>() );
    CHECK( after["behavior"].get<std::string>() == "nemesis" );
    CHECK( after["target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( updated_target_position ) );
    CHECK( after["nemesis_target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( updated_nemesis_target_position ) );
}

TEST_CASE( "lua_platform_hordes_update_legacy_group_invalid_target_is_unchanged",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_sm &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   position.raw() );
    };
    const tripoint_abs_sm group_position = get_map().get_abs_sub();
    const tripoint_abs_sm original_target_position(
        group_position.x() + 3, group_position.y() + 2,
        group_position.z() );
    const tripoint_abs_sm original_nemesis_target_position(
        group_position.x() - 2, group_position.y() - 3,
        group_position.z() );
    const tripoint_abs_sm invalid_target_position(
        group_position.x() + 7, group_position.y() + 7,
        group_position.z() + 1 );

    sol::table spawn_options = lua.create_table();
    spawn_options["group"] = cata::lua_platform::script_game_id(
                                  "monster_group", "GROUP_ZOMBIE" );
    spawn_options["position"] = make_position( group_position );
    spawn_options["population"] = 222;
    spawn_options["interest"] = 36;
    spawn_options["dying"] = false;
    spawn_options["horde"] = true;
    spawn_options["behavior"] = "roam";
    spawn_options["target"] = make_position( original_target_position );
    spawn_options["nemesis_target"] =
        make_position( original_nemesis_target_position );

    const sol::protected_function_result spawn_result =
        hordes["spawn_legacy_group"]( spawn_options );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_legacy_group"]( token );
    } );

    sol::table invalid_options = lua.create_table();
    invalid_options["population"] = 777;
    invalid_options["interest"] = 91;
    invalid_options["dying"] = true;
    invalid_options["horde"] = false;
    invalid_options["behavior"] = "nemesis";
    invalid_options["target"] = make_position( invalid_target_position );
    invalid_options["nemesis_target"] =
        make_position( tripoint_abs_sm(
                           group_position.x() - 8,
                           group_position.y() + 6,
                           group_position.z() ) );

    const sol::protected_function_result invalid_result =
        hordes["update_legacy_group"]( token, invalid_options );
    CHECK_FALSE( invalid_result.valid() );

    const sol::protected_function_result read_result =
        hordes["legacy_group"]( token );
    REQUIRE( read_result.valid() );
    const sol::table read_envelope = read_result.get<sol::table>();
    REQUIRE( read_envelope["ok"].get<bool>() );
    const sol::table after = read_envelope["value"].get<sol::table>();

    CHECK( after["population"].get<unsigned int>() == 222U );
    CHECK( after["interest"].get<int>() == 36 );
    CHECK_FALSE( after["dying"].get<bool>() );
    CHECK( after["horde"].get<bool>() );
    CHECK( after["behavior"].get<std::string>() == "roam" );
    CHECK( after["target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_target_position ) );
    CHECK( after["nemesis_target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_nemesis_target_position ) );
}

TEST_CASE( "lua_platform_hordes_tokens_bind_identity_and_context",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 41 );
    cata::lua_platform::game_handle_runtime current_runtime = runtime;
    std::size_t current_world_generation = 9;
    cata::lua_platform::install_horde_api(
        services,
        [&current_runtime]() {
        return current_runtime;
    },
    [&current_world_generation]() {
        return current_world_generation;
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const tripoint_abs_ms native_position =
        project_to<coords::ms>( get_map().get_abs_sub() );
    const cata::lua_platform::script_tripoint_coord position =
        make_position( native_position );
    const sol::protected_function_result spawn_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::userdata token =
        spawn_envelope["value"].get<sol::table>()["token"];
    REQUIRE( token.valid() );

    CHECK( token["runtime_generation"].get<std::size_t>() == 41 );
    CHECK( token["world_generation"].get<std::size_t>() == 9 );
    CHECK( token["owner_generation"].get<std::size_t>() > 0 );
    CHECK( token["identity_generation"].get<std::size_t>() > 0 );
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result duplicate_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( duplicate_result.valid() );
    CHECK( duplicate_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "occupied" );
    CHECK( token_is_valid( token ).get<bool>() );

    const auto other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    current_runtime = cata::lua_platform::game_handle_runtime(
                          other_owner, 41 );
    const sol::protected_function_result wrong_runtime_result =
        hordes["entity"]( token );
    REQUIRE( wrong_runtime_result.valid() );
    CHECK( wrong_runtime_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
    CHECK_FALSE( token_is_valid( token ).get<bool>() );

    current_runtime = runtime;
    current_world_generation = 10;
    const sol::protected_function_result wrong_world_result =
        hordes["entity"]( token );
    REQUIRE( wrong_world_result.valid() );
    CHECK( wrong_world_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_world" );

    current_world_generation = 9;
    const sol::protected_function_result remove_result =
        hordes["remove_entity"]( token );
    REQUIRE( remove_result.valid() );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["status"].get<std::string>() == "committed" );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["removed"].get<bool>() );
    CHECK_FALSE( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result replacement_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( replacement_result.valid() );
    REQUIRE( replacement_result.get<sol::table>()["ok"].get<bool>() );
    const sol::userdata replacement_token =
        replacement_result.get<sol::table>()["value"].get<sol::table>()
        ["token"];
    REQUIRE( replacement_token.valid() );
    CHECK( token["identity_generation"].get<std::size_t>() !=
           replacement_token["identity_generation"].get<std::size_t>() );
    const sol::protected_function_result stale_replacement_read =
        hordes["entity"]( token );
    REQUIRE( stale_replacement_read.valid() );
    CHECK( stale_replacement_read.get<sol::table>()["error"]
           .get<sol::table>()["code"].get<std::string>() ==
           "missing_horde_entity" );

    const sol::protected_function_result replacement_remove_result =
        hordes["remove_entity"]( replacement_token );
    REQUIRE( replacement_remove_result.valid() );
    REQUIRE( replacement_remove_result.get<sol::table>()["ok"].get<bool>() );

    cata::lua_platform::reset_horde_tokens();
    const sol::protected_function_result stale_owner_result =
        hordes["entity"]( token );
    REQUIRE( stale_owner_result.valid() );
    CHECK( stale_owner_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_owner" );
}

TEST_CASE( "lua_platform_hordes_entity_pages_are_stable_and_bounded",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 42 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 11 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_map_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const auto make_omt_position = []( const tripoint_abs_omt &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::overmap_terrain,
                   position.raw() );
    };
    const tripoint_abs_ms first_position =
        project_to<coords::ms>( get_map().get_abs_sub() );
    const tripoint_abs_ms second_position(
        first_position.x() + 1, first_position.y(), first_position.z() );
    const cata::lua_platform::script_game_id zombie_id(
        "monster", "mon_zombie" );
    const sol::protected_function_result first_spawn =
        hordes["spawn_entity"]( make_map_position( first_position ), zombie_id );
    const sol::protected_function_result second_spawn =
        hordes["spawn_entity"]( make_map_position( second_position ), zombie_id );
    REQUIRE( first_spawn.valid() );
    REQUIRE( second_spawn.valid() );
    REQUIRE( first_spawn.get<sol::table>()["ok"].get<bool>() );
    REQUIRE( second_spawn.get<sol::table>()["ok"].get<bool>() );
    const sol::userdata first_token =
        first_spawn.get<sol::table>()["value"].get<sol::table>()["token"];
    const sol::userdata second_token =
        second_spawn.get<sol::table>()["value"].get<sol::table>()["token"];
    on_out_of_scope cleanup( [&hordes, first_token, second_token]() {
        hordes["remove_entity"]( first_token );
        hordes["remove_entity"]( second_token );
    } );

    sol::table options = lua.create_table();
    options["radius"] = 0;
    options["limit"] = 1;
    options["monster"] = zombie_id;
    const cata::lua_platform::script_tripoint_coord center =
        make_omt_position( project_to<coords::omt>( first_position ) );

    const sol::protected_function_result first_page_result =
        hordes["entities"]( center, options );
    REQUIRE( first_page_result.valid() );
    const sol::table first_page = first_page_result.get<sol::table>();
    REQUIRE( first_page["total"].get<std::size_t>() >= 2 );
    REQUIRE( first_page["returned"].get<std::size_t>() == 1 );
    REQUIRE( first_page["has_more"].get<bool>() );

    options["offset"] = 1;
    const sol::protected_function_result second_page_result =
        hordes["entities"]( center, options );
    REQUIRE( second_page_result.valid() );
    const sol::table second_page = second_page_result.get<sol::table>();
    REQUIRE( second_page["returned"].get<std::size_t>() == 1 );
    const sol::table first_page_item =
        first_page["items"].get<sol::table>()[1].get<sol::table>();
    const sol::table second_page_item =
        second_page["items"].get<sol::table>()[1].get<sol::table>();
    const sol::userdata first_page_token = first_page_item["token"];
    const sol::userdata second_page_token = second_page_item["token"];
    CHECK( first_page_token["identity_generation"].get<std::size_t>() !=
           second_page_token["identity_generation"].get<std::size_t>() );
}

TEST_CASE( "lua_platform_hordes_remove_legacy_group_is_single_commit",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 43 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 12 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_sm &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   position.raw() );
    };
    const tripoint_abs_sm position = get_map().get_abs_sub();
    sol::table options = lua.create_table();
    options["group"] = cata::lua_platform::script_game_id(
                             "monster_group", "GROUP_ZOMBIE" );
    options["position"] = make_position( position );
    options["population"] = 73;
    options["horde"] = true;
    options["behavior"] = "roam";
    const sol::protected_function_result spawn_result =
        hordes["spawn_legacy_group"]( options );
    REQUIRE( spawn_result.valid() );
    REQUIRE( spawn_result.get<sol::table>()["ok"].get<bool>() );
    const sol::table spawn_value =
        spawn_result.get<sol::table>()["value"].get<sol::table>();
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );
    CHECK( token["owner_generation"].get<std::size_t>() > 0 );
    CHECK( token["identity_generation"].get<std::size_t>() > 0 );
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result remove_result =
        hordes["remove_legacy_group"]( token );
    REQUIRE( remove_result.valid() );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    const sol::table remove_value = remove_envelope["value"].get<sol::table>();
    CHECK( remove_value["status"].get<std::string>() == "committed" );
    CHECK( remove_value["removed"].get<bool>() );
    CHECK_FALSE( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result stale_read =
        hordes["legacy_group"]( token );
    REQUIRE( stale_read.valid() );
    CHECK( stale_read.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "missing_legacy_horde" );

    const sol::protected_function_result replacement_result =
        hordes["spawn_legacy_group"]( options );
    REQUIRE( replacement_result.valid() );
    REQUIRE( replacement_result.get<sol::table>()["ok"].get<bool>() );
    const sol::userdata replacement_token =
        replacement_result.get<sol::table>()["value"].get<sol::table>()
        ["token"];
    REQUIRE( replacement_token.valid() );
    CHECK( token["identity_generation"].get<std::size_t>() !=
           replacement_token["identity_generation"].get<std::size_t>() );
    const sol::protected_function_result stale_replacement_read =
        hordes["legacy_group"]( token );
    REQUIRE( stale_replacement_read.valid() );
    CHECK( stale_replacement_read.get<sol::table>()["error"]
           .get<sol::table>()["code"].get<std::string>() ==
           "missing_legacy_horde" );

    const sol::protected_function_result replacement_remove =
        hordes["remove_legacy_group"]( replacement_token );
    REQUIRE( replacement_remove.valid() );
    REQUIRE( replacement_remove.get<sol::table>()["ok"].get<bool>() );
}

#endif // CATA_ENABLE_LUA_PLATFORM
