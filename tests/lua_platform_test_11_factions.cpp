#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_faction_for_character_requires_exact_live_handle",
           "[lua][platform][factions]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 64 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 64 );
    cata::lua_platform::game_handle_runtime active_runtime = runtime;
    std::size_t active_world = 22;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return active_world;
    },
    []() {} );
    cata::lua_platform::install_faction_api(
        services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return active_world;
    },
    []() {}, []() {} );

    monster wrong_subtype;
    wrong_subtype.set_hp( 1 );
    const cata::lua_platform::game_handle npc_labeled_monster =
        cata::lua_platform::game_handle::from_creature(
            wrong_subtype, { "npc", 7006, 0, 0, 0, {} }, runtime,
            active_world );
    const sol::table faction_services = services["factions"];
    const sol::protected_function for_character =
        faction_services["for_character"];
    const sol::protected_function_result subtype_result =
        for_character( npc_labeled_monster );
    REQUIRE( subtype_result.valid() );
    CHECK( subtype_result.get<sol::table>()["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_subtype" );

    avatar character;
    character.normalize();
    character.setID( character_id( 7007 ), true );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "avatar", 7007, 0, 0, 0, {} }, runtime,
            active_world );
    active_world = 23;
    const sol::protected_function_result world_result =
        for_character( character_handle );
    REQUIRE( world_result.valid() );
    CHECK( world_result.get<sol::table>()["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_world" );

    active_world = 22;
    active_runtime = other_runtime;
    const sol::protected_function_result runtime_result =
        for_character( character_handle );
    REQUIRE( runtime_result.valid() );
    CHECK( runtime_result.get<sol::table>()["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_faction_mutation_gate_precedes_typed_target_preflight",
           "[lua][platform][factions]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 65 );
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_faction_api(
        services,
        [runtime]() {
        return runtime;
    },
    []() {
        return std::size_t( 24 );
    },
    []() {},
    [&]() {
        write_gate_called = true;
    } );

    const sol::table faction_services = services["factions"];
    const sol::protected_function set_relationship =
        faction_services["set_relationship"];
    const cata::lua_platform::script_game_id source(
        "faction", "source_faction" );
    const cata::lua_platform::script_game_id wrong_target(
        "item", "rock" );
    sol::table updates = lua.create_table();
    updates["knows_your_voice"] = true;
    const sol::protected_function_result result =
        set_relationship( source, wrong_target, updates );
    CHECK_FALSE( result.valid() );
    CHECK( write_gate_called );
    CHECK_FALSE( faction_services["player"].valid() );
}

#endif // CATA_ENABLE_LUA_PLATFORM
