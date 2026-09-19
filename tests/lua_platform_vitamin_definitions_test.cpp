#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <string>
#include <vector>

#include "cata_catch.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_vitamins.h"
#include "vitamin.h"

TEST_CASE( "lua_platform_vitamin_definition_order", "[lua][vitamins]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_vitamin_api( services, [runtime]() {
        return runtime;
    }, []() {
        return std::size_t{ 1 };
    }, []() {}, []() {} );
    sol::protected_function definitions = services["vitamins"]["definitions"];
    const auto &native = vitamin::all();
    REQUIRE( native.size() > 2 );
    std::vector<std::string> sorted;
    for( const vitamin &definition : native ) {
        sorted.push_back( definition.get_id().str() );
    }
    std::sort( sorted.begin(), sorted.end() );
    for( const std::string &order : {
             std::string( "native" ), std::string( "id" ), std::string()
         } ) {
        sol::table options = lua.create_table();
        if( !order.empty() ) {
            options["order"] = order;
        }
        options["offset"] = 1;
        options["limit"] = 2;
        sol::protected_function_result call = definitions( options );
        REQUIRE( call.valid() );
        sol::table page = call;
        sol::table items = page["items"];
        REQUIRE( items.size() == 2 );
        for( std::size_t index = 1; index <= 2; ++index ) {
            sol::table item = items[index];
            const std::string expected = order == "native" ? native[index].get_id().str() : sorted[index];
            CHECK( item["id"].get<cata::lua_platform::script_game_id>().value() == expected );
        }
    }
    const auto lower = []( std::string text ) {
        std::transform( text.begin(), text.end(), text.begin(), []( unsigned char ch ) {
            return static_cast<char>( std::tolower( ch ) );
        } );
        return text;
    };
    const std::string query = "a";
    std::vector<std::string> expected_filtered;
    for( const vitamin &definition : native ) {
        if( lower( definition.get_id().str() ).find( query ) != std::string::npos ||
            lower( definition.name() ).find( query ) != std::string::npos ) {
            expected_filtered.push_back( definition.get_id().str() );
        }
    }
    REQUIRE_FALSE( expected_filtered.empty() );
    for( std::size_t offset = 0; offset < expected_filtered.size(); ++offset ) {
        sol::table options = lua.create_table();
        options["order"] = "native";
        options["query"] = query;
        options["offset"] = offset;
        options["limit"] = 1;
        sol::protected_function_result call = definitions( options );
        REQUIRE( call.valid() );
        sol::table page = call;
        CHECK( page["total"].get<std::size_t>() == expected_filtered.size() );
        sol::table item = page["items"][1];
        CHECK( item["id"].get<cata::lua_platform::script_game_id>().value() == expected_filtered[offset] );
    }
    sol::table invalid = lua.create_table();
    invalid["order"] = "invalid";
    CHECK_FALSE( definitions( invalid ).valid() );
    invalid["order"] = false;
    CHECK_FALSE( definitions( invalid ).valid() );
}

#endif
