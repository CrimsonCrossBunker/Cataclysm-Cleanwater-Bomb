#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "global_vars.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "math_parser_diag_value.h"
#include "type_id.h"
#include "vehicle.h"
#include "veh_type.h"

namespace
{

using cata::lua_platform::game_handle;
using cata::lua_platform::game_handle_runtime;

struct global_values_restore {
    global_variables::impl_t values = get_globals().get_global_values();

    ~global_values_restore() {
        get_globals().set_global_values( std::move( values ) );
    }
};

struct variable_api_fixture {
    sol::state lua;
    sol::table services;
    sol::table variables;
    cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    game_handle_runtime runtime{ runtime_owner, 1 };

    variable_api_fixture() {
        lua.open_libraries( sol::lib::base );
        services = lua.create_table();
        const game_handle_runtime current = runtime;
        const std::function<game_handle_runtime()> current_runtime = [current]() {
            return current;
        };
        const std::function<std::size_t()> current_world_generation = []() {
            return std::size_t( 1 );
        };
        cata::lua_platform::install_value_type_api( lua, services, []() {} );
        cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world_generation, []() {} );
        cata::lua_platform::install_variable_api(
            services, current_runtime, current_world_generation,
        []() {}, []() {}, []() {
            return true;
        } );
        variables = services["variables"];
    }
};

struct item_identity_cleanup {
    item &value;

    ~item_identity_cleanup() {
        cata::lua_platform::retire_item_handle_identity( value );
    }
};

struct vehicle_identity_cleanup {
    vehicle &value;

    ~vehicle_identity_cleanup() {
        cata::lua_platform::retire_vehicle_handle_identity( value );
    }
};

struct native_owner_case {
    const char *name;
    game_handle handle;
    std::function<const diag_value *( const std::string & )> get;
};

sol::table require_success( const sol::protected_function_result &call )
{
    REQUIRE( call.valid() );
    sol::table response = call;
    REQUIRE( response["ok"].get<bool>() );
    return response;
}

sol::table require_value( const sol::protected_function_result &call )
{
    const sol::table response = require_success( call );
    return response["value"];
}

std::vector<std::string> native_boundary_keys()
{
    std::string multibyte;
    for( int index = 0; index < 43; ++index ) {
        multibyte.append( "\xE7\x95\x8C", 3 );
    }
    return {
        "",
        std::string( 129, 'k' ),
        std::move( multibyte ),
        "line\nbreak",
        std::string( "nul\0key", 7 )
    };
}

} // namespace

TEST_CASE( "lua_platform_native_variable_keys_keep_native_string_range",
           "[lua][platform][semantic][variables]" )
{
    global_values_restore restore_global_values;
    avatar player;
    player.normalize();
    player.setID( character_id( 4911 ), true );
    item item_value( itype_id( "rock" ) );
    vehicle vehicle_value{ vproto_id() };
    item_identity_cleanup retire_item{ item_value };
    vehicle_identity_cleanup retire_vehicle{ vehicle_value };

    variable_api_fixture fixture;
    const game_handle player_handle = cata::lua_platform::game_handle::from_creature(
                                          player, { "avatar", player.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    const game_handle item_handle = cata::lua_platform::game_handle::from_item(
                                        item_value, { "character_inventory", item_value.uid().get_value(), 0, 0, 0, {} },
                                        fixture.runtime, 1 );
    const game_handle vehicle_handle = cata::lua_platform::game_handle::from_vehicle(
                                           vehicle_value, { "map_vehicle", 0, 0, 0, 0, {} }, fixture.runtime, 1 );

    const std::array<native_owner_case, 3> owners = {{
            {
                "creature", player_handle, [&player]( const std::string & key )
                {
                    return player.maybe_get_value( key );
                }
            },
            {
                "item", item_handle, [&item_value]( const std::string & key )
                {
                    return item_value.maybe_get_value( key );
                }
            },
            {
                "vehicle", vehicle_handle, [&vehicle_value]( const std::string & key )
                {
                    return vehicle_value.maybe_get_value( key );
                }
            }
        }
    };

    const sol::protected_function get = fixture.variables["get"];
    const sol::protected_function set = fixture.variables["set"];
    const sol::protected_function remove = fixture.variables["remove"];
    const sol::protected_function get_global = fixture.variables["get_global"];
    const sol::protected_function set_global = fixture.variables["set_global"];
    const sol::protected_function remove_global = fixture.variables["remove_global"];
    const sol::protected_function copy = fixture.variables["copy"];
    const sol::protected_function resolve = fixture.variables["resolve"];
    const sol::protected_function set_resolved = fixture.variables["set_resolved"];
    sol::table context = fixture.lua.create_table();

    const std::vector<std::string> keys = native_boundary_keys();
    REQUIRE( keys[1].size() == 129 );
    REQUIRE( keys[2].size() == 129 );
    REQUIRE( keys[4].size() == 7 );
    for( const native_owner_case &owner : owners ) {
        for( std::size_t key_index = 0; key_index < keys.size(); ++key_index ) {
            const std::string &key = keys[key_index];
            INFO( "native owner: " << owner.name << ", key index: " << key_index <<
                  ", key bytes: " << key.size() );

            const std::string owner_value = std::string( "owner-" ) + owner.name;
            require_success( set( owner.handle, key, owner_value ) );
            REQUIRE( owner.get( key ) != nullptr );
            CHECK( owner.get( key )->str() == owner_value );
            CHECK( require_value( get( owner.handle, key ) )["value"].get<std::string>() ==
                   owner_value );

            CHECK( require_value( resolve( context, owner.handle, "u", key ) )[
            "value"].get<std::string>() == owner_value );
            require_success( set_resolved( context, owner.handle, "u", key, "resolved-owner" ) );
            CHECK( owner.get( key )->str() == "resolved-owner" );

            require_success( copy( owner.handle, key, sol::nil, key ) );
            CHECK( require_value( get_global( key ) )["value"].get<std::string>() ==
                   "resolved-owner" );
            CHECK( require_value( resolve( context, sol::nil, "global", key ) )[
            "value"].get<std::string>() == "resolved-owner" );

            require_success( set_global( key, "global-value" ) );
            CHECK( require_value( get_global( key ) )["value"].get<std::string>() ==
                   "global-value" );
            require_success( set_resolved( context, sol::nil, "global", key,
                                           "resolved-global" ) );
            CHECK( require_value( resolve( context, sol::nil, "global", key ) )[
            "value"].get<std::string>() == "resolved-global" );

            require_success( copy( sol::nil, key, owner.handle, key ) );
            CHECK( require_value( get( owner.handle, key ) )["value"].get<std::string>() ==
                   "resolved-global" );
            const sol::table removed_owner = require_value( remove( owner.handle, key ) );
            CHECK( removed_owner["removed"].get<bool>() );
            CHECK( owner.get( key ) == nullptr );
            const sol::table removed_global = require_value( remove_global( key ) );
            CHECK( removed_global["removed"].get<bool>() );
            CHECK( get_globals().maybe_get_global_value( key ) == nullptr );
        }
    }
}

TEST_CASE( "lua_platform_native_variable_long_keys_survive_var_indirection",
           "[lua][platform][semantic][variables]" )
{
    global_values_restore restore_global_values;
    avatar player;
    player.normalize();
    player.setID( character_id( 4912 ), true );
    variable_api_fixture fixture;
    const game_handle player_handle = cata::lua_platform::game_handle::from_creature(
                                          player, { "avatar", player.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    const std::string long_key( 129, 'v' );
    sol::table context = fixture.lua.create_table();
    context["actor_reference"] = std::string( "u_" ) + long_key;
    context["global_reference"] = long_key;
    player.set_value( long_key, "actor-before" );
    get_globals().set_global_value( long_key, diag_value( "global-before" ) );

    const sol::protected_function resolve = fixture.variables["resolve"];
    const sol::protected_function set_resolved = fixture.variables["set_resolved"];
    const sol::protected_function get = fixture.variables["get"];
    const sol::protected_function get_global = fixture.variables["get_global"];

    CHECK( require_value( resolve( context, player_handle, "var", "actor_reference" ) )[
            "value"].get<std::string>() == "actor-before" );
    require_success( set_resolved( context, player_handle, "var", "actor_reference",
                                   "actor-after" ) );
    CHECK( require_value( get( player_handle, long_key ) )["value"].get<std::string>() ==
           "actor-after" );

    CHECK( require_value( resolve( context, sol::nil, "var", "global_reference" ) )[
            "value"].get<std::string>() == "global-before" );
    require_success( set_resolved( context, sol::nil, "var", "global_reference",
                                   "global-after" ) );
    CHECK( require_value( get_global( long_key ) )["value"].get<std::string>() ==
           "global-after" );
}

TEST_CASE( "lua_platform_callback_context_variable_keys_remain_bounded",
           "[lua][platform][semantic][variables]" )
{
    variable_api_fixture fixture;
    sol::table context = fixture.lua.create_table();
    const sol::protected_function resolve = fixture.variables["resolve"];
    const sol::protected_function set_resolved = fixture.variables["set_resolved"];

    const std::string maximum_key( 128, 'c' );
    require_success( set_resolved( context, sol::nil, "context", maximum_key, "accepted" ) );
    CHECK( require_value( resolve( context, sol::nil, "context", maximum_key ) )[
            "value"].get<std::string>() == "accepted" );

    for( const std::string &key : native_boundary_keys() ) {
        INFO( "context key bytes: " << key.size() );
        CHECK_FALSE( resolve( context, sol::nil, "context", key ).valid() );
        CHECK_FALSE( set_resolved( context, sol::nil, "context", key, "rejected" ).valid() );
        CHECK_FALSE( resolve( context, sol::nil, "var", key ).valid() );
        CHECK_FALSE( set_resolved( context, sol::nil, "var", key, "rejected" ).valid() );

        context["context_target"] = std::string( "_" ) + key;
        CHECK_FALSE( resolve( context, sol::nil, "var", "context_target" ).valid() );
        CHECK_FALSE( set_resolved( context, sol::nil, "var", "context_target",
                                   "rejected" ).valid() );
    }
}

TEST_CASE( "lua_platform_native_non_nul_variable_keys_round_trip_in_save_json",
           "[lua][platform][semantic][variables]" )
{
    const std::array<std::string, 2> keys = {{
            "line\nbreak",
            std::string( 129, 's' )
        }
    };
    avatar creature;
    creature.normalize();
    for( std::size_t index = 0; index < keys.size(); ++index ) {
        creature.set_value( keys[index], diag_value( "saved-creature-" + std::to_string( index ) ) );
    }

    std::ostringstream creature_json;
    {
        JsonOut json( creature_json );
        creature.serialize( json );
    }
    const JsonObject creature_record = json_loader::from_string( creature_json.str() ).get_object();
    global_variables::impl_t restored_creature_values;
    REQUIRE( creature_record.read( "values", restored_creature_values ) );
    for( std::size_t index = 0; index < keys.size(); ++index ) {
        const auto creature_value = restored_creature_values.find( keys[index] );
        REQUIRE( creature_value != restored_creature_values.end() );
        CHECK( creature_value->second.str() == "saved-creature-" + std::to_string( index ) );
    }

    global_variables globals;
    for( std::size_t index = 0; index < keys.size(); ++index ) {
        globals.set_global_value( keys[index], diag_value( "saved-global-" + std::to_string( index ) ) );
    }
    std::ostringstream global_json;
    {
        JsonOut json( global_json );
        json.start_object();
        globals.serialize( json );
        json.end_object();
    }
    const JsonObject global_record = json_loader::from_string( global_json.str() ).get_object();
    global_variables::impl_t restored_global_values;
    REQUIRE( global_record.read( "global_vals", restored_global_values ) );
    for( std::size_t index = 0; index < keys.size(); ++index ) {
        const auto global_value = restored_global_values.find( keys[index] );
        REQUIRE( global_value != restored_global_values.end() );
        CHECK( global_value->second.str() == "saved-global-" + std::to_string( index ) );
    }
}

#endif // defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
