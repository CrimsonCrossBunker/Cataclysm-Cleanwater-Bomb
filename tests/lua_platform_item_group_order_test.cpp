#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_test_support.h"
#include "item_group.h"
#include "itype.h"

TEST_CASE( "lua_platform_item_group_native_order", "[lua][items]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_item_api(
    services, []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    }, []() {}, []() {} );
    const item_group_id group( "forest" );
    std::vector<std::string> native;
    for( const itype *entry : item_group::every_possible_item_from( group ) ) {
        REQUIRE( entry != nullptr );
        native.push_back( entry->get_id().str() );
    }
    REQUIRE( native.size() > 1 );
    std::vector<std::string> sorted = native;
    std::sort( sorted.begin(), sorted.end() );
    sorted.erase( std::unique( sorted.begin(), sorted.end() ), sorted.end() );
    sol::protected_function list = services["items"]["possible_from_group"];
    const cata::lua_platform::script_game_id id( "item_group", group.str() );
    for( const std::string &order : {
             std::string( "native" ), std::string(),
             std::string( "id" )
         } ) {
        sol::table options = lua.create_table();
        if( !order.empty() ) {
            options["order"] = order;
        }
        sol::protected_function_result call = order.empty() ? list( id ) : list( id, options );
        REQUIRE( call.valid() );
        sol::table page = call;
        sol::table items = page["items"];
        const auto &expected = order == "native" ? native : sorted;
        CHECK( page["total"].get<std::size_t>() == expected.size() );
        REQUIRE( items.size() == expected.size() );
        for( std::size_t index = 0; index < expected.size(); ++index ) {
            CHECK( items[index + 1].get<cata::lua_platform::script_game_id>().value() ==
                   expected[index] );
        }
    }
    sol::table invalid = lua.create_table();
    invalid["order"] = "invalid";
    CHECK_FALSE( list( id, invalid ).valid() );
    invalid["order"] = true;
    CHECK_FALSE( list( id, invalid ).valid() );
    invalid["order"] = sol::nil;
    invalid["limit"] = 1;
    CHECK_FALSE( list( id, invalid ).valid() );
}

#endif
