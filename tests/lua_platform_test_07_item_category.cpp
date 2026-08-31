#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_item_category_spawn_rate_service_surface_and_basic_mutations",
           "[lua][platform][item_categories][spawn_rate]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_item_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table item_categories = services["item_categories"];
    REQUIRE( item_categories.valid() );
    CHECK( item_categories["spawn_rate"].valid() );
    CHECK( item_categories["set_spawn_rate"].valid() );
    CHECK( item_categories["set_spawn_rates"].valid() );
    const sol::table items = services["items"];
    REQUIRE( items.valid() );
    CHECK_FALSE( items["spawn_rate"].valid() );
    CHECK_FALSE( items["set_spawn_rate"].valid() );
    CHECK_FALSE( items["set_spawn_rates"].valid() );

    const cata::lua_platform::script_game_id food(
        "item_category", "food" );
    const cata::lua_platform::script_game_id tools(
        "item_category", "tools" );
    const item_category_id food_id( "food" );
    const item_category_id tools_id( "tools" );
    REQUIRE( food_id.is_valid() );
    REQUIRE( tools_id.is_valid() );
    const float food_before = food_id.obj().get_spawn_rate();
    const float tools_before = tools_id.obj().get_spawn_rate();
    on_out_of_scope restore_rates( [food_before, tools_before]() {
        item_category_id( "food" ).obj().set_spawn_rate( food_before );
        item_category_id( "tools" ).obj().set_spawn_rate( tools_before );
    } );

    const sol::protected_function read = item_categories["spawn_rate"];
    const sol::protected_function_result read_result = read( food );
    REQUIRE( read_result.valid() );
    const sol::table read_envelope = read_result.get<sol::table>();
    REQUIRE( read_envelope["ok"].get<bool>() );
    CHECK( read_envelope["value"].get<float>() == food_before );

    const sol::protected_function set = item_categories["set_spawn_rate"];
    const sol::protected_function_result set_result = set( food, 7.5 );
    REQUIRE( set_result.valid() );
    const sol::table set_envelope = set_result.get<sol::table>();
    REQUIRE( set_envelope["ok"].get<bool>() );
    const sol::table set_value = set_envelope["value"].get<sol::table>();
    CHECK( set_value["id"].get<cata::lua_platform::script_game_id>() == food );
    CHECK( set_value["before"].get<float>() == food_before );
    CHECK( set_value["after"].get<float>() == 7.5F );
    CHECK( set_value["changed"].get<bool>() );

    sol::table batch = lua.create_table();
    batch[1] = lua.create_table_with(
                   "id", tools, "spawn_rate", 2.5 );
    batch[2] = lua.create_table_with(
                   "id", food, "spawn_rate", 3.5 );
    const sol::protected_function set_batch = item_categories["set_spawn_rates"];
    const sol::protected_function_result batch_result = set_batch( batch );
    REQUIRE( batch_result.valid() );
    const sol::table batch_envelope = batch_result.get<sol::table>();
    REQUIRE( batch_envelope["ok"].get<bool>() );
    const sol::table batch_value = batch_envelope["value"].get<sol::table>();
    CHECK( batch_value["count"].get<lua_Integer>() == 2 );
    const sol::table batch_items = batch_value["items"].get<sol::table>();
    CHECK( batch_items[1].get<sol::table>()["id"].get<
           cata::lua_platform::script_game_id>() == tools );
    CHECK( batch_items[1].get<sol::table>()["before"].get<float>() == tools_before );
    CHECK( batch_items[1].get<sol::table>()["after"].get<float>() == 2.5F );
    CHECK( batch_items[2].get<sol::table>()["before"].get<float>() == 7.5F );
    CHECK( batch_items[2].get<sol::table>()["after"].get<float>() == 3.5F );
    CHECK( food_id.obj().get_spawn_rate() == 3.5F );
    CHECK( tools_id.obj().get_spawn_rate() == 2.5F );
}

TEST_CASE( "lua_platform_item_category_spawn_rates_fail_closed_without_mutation",
           "[lua][platform][item_categories][spawn_rate][validation]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_item_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const cata::lua_platform::script_game_id food(
        "item_category", "food" );
    const cata::lua_platform::script_game_id tools(
        "item_category", "tools" );
    const cata::lua_platform::script_game_id missing(
        "item_category", "missing_item_category" );
    const cata::lua_platform::script_game_id wrong_kind( "item", "rock" );
    const item_category_id food_id( "food" );
    const item_category_id tools_id( "tools" );
    REQUIRE( food_id.is_valid() );
    REQUIRE( tools_id.is_valid() );
    const float food_before = food_id.obj().get_spawn_rate();
    const float tools_before = tools_id.obj().get_spawn_rate();
    on_out_of_scope restore_rates( [food_before, tools_before]() {
        item_category_id( "food" ).obj().set_spawn_rate( food_before );
        item_category_id( "tools" ).obj().set_spawn_rate( tools_before );
    } );

    const sol::table item_categories = services["item_categories"];
    const sol::protected_function set = item_categories["set_spawn_rate"];
    const sol::protected_function set_batch = item_categories["set_spawn_rates"];
    const auto check_unchanged = [&]() {
        CHECK( food_id.obj().get_spawn_rate() == food_before );
        CHECK( tools_id.obj().get_spawn_rate() == tools_before );
    };
    const auto check_single_rejected = [&]( const cata::lua_platform::script_game_id &id,
            const double rate ) {
        const sol::protected_function_result result = set( id, rate );
        CHECK_FALSE( result.valid() );
        check_unchanged();
    };
    const auto make_update = [&lua]( const cata::lua_platform::script_game_id &id,
                                     const auto &rate ) {
        sol::table update = lua.create_table();
        update["id"] = id;
        update["spawn_rate"] = rate;
        return update;
    };
    const auto check_batch_rejected = [&]( const sol::table &batch ) {
        const sol::protected_function_result result = set_batch( batch );
        CHECK_FALSE( result.valid() );
        check_unchanged();
    };

    check_single_rejected( food, -0.1 );
    check_single_rejected( food, 1000000.1 );
    check_single_rejected( food, std::numeric_limits<double>::quiet_NaN() );
    check_single_rejected( food,
                           std::numeric_limits<double>::infinity() );
    check_single_rejected( missing, 2.0 );
    check_single_rejected( wrong_kind, 2.0 );

    sol::table duplicate = lua.create_table();
    duplicate[1] = make_update( food, 11.0 );
    duplicate[2] = make_update( food, 12.0 );
    check_batch_rejected( duplicate );

    sol::table invalid_category = lua.create_table();
    invalid_category[1] = make_update( missing, 11.0 );
    check_batch_rejected( invalid_category );

    sol::table valid_then_invalid = lua.create_table();
    valid_then_invalid[1] = make_update( tools, 11.0 );
    valid_then_invalid[2] = make_update( missing, 12.0 );
    check_batch_rejected( valid_then_invalid );

    sol::table wrong_category_kind = lua.create_table();
    wrong_category_kind[1] = make_update( wrong_kind, 11.0 );
    check_batch_rejected( wrong_category_kind );

    sol::table nan_rate = lua.create_table();
    nan_rate[1] = make_update(
                       food, std::numeric_limits<double>::quiet_NaN() );
    check_batch_rejected( nan_rate );

    sol::table infinite_rate = lua.create_table();
    infinite_rate[1] = make_update(
                            food, std::numeric_limits<double>::infinity() );
    check_batch_rejected( infinite_rate );

    sol::table negative_rate = lua.create_table();
    negative_rate[1] = make_update( food, -0.1 );
    check_batch_rejected( negative_rate );

    sol::table excessive_rate = lua.create_table();
    excessive_rate[1] = make_update( food, 1000000.1 );
    check_batch_rejected( excessive_rate );

    sol::table invalid_rate_type = lua.create_table();
    sol::table invalid_rate_entry = lua.create_table();
    invalid_rate_entry["id"] = food;
    invalid_rate_entry["spawn_rate"] = true;
    invalid_rate_type[1] = std::move( invalid_rate_entry );
    check_batch_rejected( invalid_rate_type );

    sol::table too_many = lua.create_table();
    for( int index = 1; index <= 257; ++index ) {
        too_many[index] = make_update( food, 1.0 );
    }
    check_batch_rejected( too_many );
}

#endif // CATA_ENABLE_LUA_PLATFORM
