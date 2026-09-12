#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <functional>
#include <string>

#include "cata_catch.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_martial_arts.h"
#include "lua_platform_sol.h"
#include "martialarts.h"
#include "translation.h"
#include "type_id.h"

static const matec_id matec_tech_base_headbutt( "tech_base_headbutt" );

TEST_CASE( "lua_platform_technique_short_description_matches_native_string_mutator",
           "[lua][platform][martial_arts][semantic]" )
{
    REQUIRE( matec_tech_base_headbutt.is_valid() );
    dialogue context;
    const JsonObject input = json_loader::from_string(
                                 R"({"value":{"mutator":"ma_technique_description","matec_id":"tech_base_headbutt"}})" ).get_object();
    const str_or_var legacy = get_str_or_var( input.get_member( "value" ), "value" );
    const std::string expected = legacy.evaluate( context );
    REQUIRE_FALSE( expected.empty() );
    REQUIRE( expected != matec_tech_base_headbutt->get_description() );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime generation{ owner, 1 };
    cata::lua_platform::install_martial_art_api(
    services, [generation]() {
        return generation;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {} );
    sol::protected_function get = services["martial_arts"]["technique_definition"];
    sol::protected_function_result call = get(
            cata::lua_platform::script_game_id( "martial_art_technique", technique.str() ) );
    REQUIRE( call.valid() );
    sol::table snapshot = call;
    CHECK( snapshot["flavor_description"].get<std::string>() == expected );
    CHECK( snapshot["description"].get<std::string>() == matec_tech_base_headbutt->get_description() );
    CHECK( snapshot["name"].get<std::string>() == matec_tech_base_headbutt->name.translated() );
}

#endif
