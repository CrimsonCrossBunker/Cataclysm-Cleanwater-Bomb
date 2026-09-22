#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cstddef>
#include <string>
#include <vector>

#include "bodypart.h"
#include "cata_catch.h"
#include "flag.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_registry.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_registry_native_order_pages", "[lua][registry]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_registry_api( lua, services, []() {}, []() {} );
    for( const std::string &kind : {
             std::string( "body_part" ), std::string( "json_flag" )
         } ) {
        std::vector<std::string> native;
        if( kind == "body_part" ) {
            for( const body_part_type &entry : body_part_type::get_all() ) {
                native.push_back( entry.id.str() );
            }
        } else {
            for( const json_flag &entry : json_flag::get_all() ) {
                native.push_back( entry.id.str() );
            }
        }
        REQUIRE_FALSE( native.empty() );
        std::vector<std::string> sorted = native;
        std::sort( sorted.begin(), sorted.end() );
        for( const bool typed : {
                 false, true
             } ) {
            sol::table api = typed ? services["registry"]["definitions"].get<sol::table>() :
                             services["registry"].get<sol::table>();
            sol::protected_function list = api["list"];
            // Alternate orders against the same catalog to exercise cached indexes.
            for( const std::string &order : {
                     std::string( "native" ), std::string(), std::string( "id" ), std::string( "native" )
                 } ) {
                const auto &expected = order == "native" ? native : sorted;
                for( std::size_t offset = 0; offset < expected.size(); offset += 17 ) {
                    sol::table options = lua.create_table();
                    if( !order.empty() ) {
                        options["order"] = order;
                    }
                    options["offset"] = offset;
                    options["limit"] = 17;
                    sol::protected_function_result call = list( kind, options );
                    REQUIRE( call.valid() );
                    sol::table page = call;
                    sol::table entries = page["entries"];
                    REQUIRE( entries.size() == std::min<std::size_t>( 17, expected.size() - offset ) );
                    for( std::size_t index = 1; index <= entries.size(); ++index ) {
                        sol::table entry = entries[index];
                        const std::string id = typed ? entry["id"].get<cata::lua_platform::script_game_id>().value() :
                                               entry["id"].get<std::string>();
                        CHECK( id == expected[offset + index - 1] );
                    }
                }
            }
            sol::table invalid = lua.create_table();
            invalid["order"] = "invalid";
            CHECK_FALSE( list( kind, invalid ).valid() );
            invalid["order"] = 1;
            CHECK_FALSE( list( kind, invalid ).valid() );
        }
    }
}

#endif
