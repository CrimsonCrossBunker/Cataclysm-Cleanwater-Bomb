#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <functional>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "character.h"
#include "character_id.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "global_vars.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "math_parser_diag_value.h"
#include "npc.h"

TEST_CASE( "lua_platform_string_variable_owners_match_native_assignment",
           "[lua][platform][strings][semantic]" )
{
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.setID( character_id( 4801 ), true );
    partner.setID( character_id( 4802 ), true );
    cata::lua_platform::register_npc_handle_identity( partner );
    struct identity_cleanup {
        npc &value;
        ~identity_cleanup() {
            cata::lua_platform::retire_npc_handle_identity( value );
        }
    } cleanup{ partner };
    player.set_value( "string_input", "alpha value" );
    partner.set_value( "string_input", "beta value" );
    const bool source_npc = GENERATE( false, true );
    const bool target_npc = GENERATE( false, true );
    const bool indirect = GENERATE( false, true );
    const std::string source_key = source_npc ? "npc_val" : "u_val";
    const std::string target_key = target_npc ? "npc_val" : "u_val";
    dialogue context( get_talker_for( player ), get_talker_for( partner ) );
    context.set_value( "destination", target_npc ? "n_legacy_output" : "u_legacy_output" );
    talk_effect_t legacy;
    const std::string input = "{\"set_string_var\":{\"" + source_key +
                              "\":\"string_input\"},\"target_var\":{\"" +
                              ( indirect ? "var_val" : target_key ) + "\":\"" +
                              ( indirect ? "destination" : "legacy_output" ) + "\"}}";
    legacy.parse_sub_effect( json_loader::from_string( input ).get_object(), "string_acceptance" );
    for( const talk_effect_fun_t &effect : legacy.effects ) {
        effect( context );
    }
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_game_handle_api( lua, services, [runtime]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {} );
    cata::lua_platform::install_variable_api( services, [runtime]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {}, []() {
        return true;
    } );
    const auto player_handle = cata::lua_platform::game_handle::from_creature(
                                   player, { "avatar", 4801, 0, 0, 0, {} }, runtime, 1 );
    const auto partner_handle = cata::lua_platform::game_handle::from_creature(
                                    partner, { "npc", 4802, 0, 0, 0, {} }, runtime, 1 );
    sol::table data = lua.create_table();
    sol::protected_function resolve = services["variables"]["resolve"];
    sol::protected_function_result read = resolve(
            data, source_npc ? partner_handle : player_handle,
            source_npc ? "npc" : "u", "string_input" );
    REQUIRE( read.valid() );
    sol::table read_result = read;
    REQUIRE( read_result["ok"].get<bool>() );
    sol::table snapshot = read_result["value"];
    const std::string value = snapshot["value"];
    CHECK( value == ( source_npc ? "beta value" : "alpha value" ) );
    // Generated Lua resolves indirect prefixes before this single-owner API.
    sol::protected_function set = services["variables"]["set_resolved"];
    sol::protected_function_result write = set(
            data, target_npc ? partner_handle : player_handle,
            target_npc ? "npc" : "u", "platform_output", value );
    REQUIRE( write.valid() );
    sol::table write_result = write;
    REQUIRE( write_result["ok"].get<bool>() );
    const Character &target = target_npc ? static_cast<const Character &>( partner ) : player;
    CHECK( target.get_value( "platform_output" ).str() == target.get_value( "legacy_output" ).str() );
    sol::protected_function_result null_write = set(
                data, target_npc ? partner_handle : player_handle,
                target_npc ? "npc" : "u", "platform_output", sol::nil );
    REQUIRE( null_write.valid() );
    sol::table null_result = null_write;
    REQUIRE( null_result["ok"].get<bool>() );
    REQUIRE( target.maybe_get_value( "platform_output" ) != nullptr );
    CHECK( target.get_value( "platform_output" ).is_empty() );
    sol::protected_function_result null_read = resolve(
                data, target_npc ? partner_handle : player_handle,
                target_npc ? "npc" : "u", "platform_output" );
    REQUIRE( null_read.valid() );
    sol::table null_read_result = null_read;
    REQUIRE( null_read_result["ok"].get<bool>() );
    sol::table null_snapshot = null_read_result["value"];
    CHECK( null_snapshot["exists"].get<bool>() );
    CHECK( null_snapshot["value"].get<sol::object>().get_type() == sol::type::nil );

    diag_value nested;
    nested._deserialize( json_loader::from_string( "[null,[1,null,\"tail\"],{\"tripoint\":[1,2,3]}]" ),
                         false );
    Character &copy_source = source_npc ? static_cast<Character &>( partner ) : player;
    copy_source.set_value( "nested_source", nested );
    sol::protected_function copy = services["variables"]["copy"];
    sol::protected_function_result copied = copy(
            source_npc ? partner_handle : player_handle, "nested_source",
            target_npc ? partner_handle : player_handle, "nested_target" );
    REQUIRE( copied.valid() );
    sol::table copy_result = copied;
    REQUIRE( copy_result["ok"].get<bool>() );
    CHECK( target.get_value( "nested_target" ) == nested );
    copy_source.set_value( "nested_source", "changed after copy" );
    CHECK( target.get_value( "nested_target" ) == nested );
    const auto stale_target = cata::lua_platform::game_handle::from_creature(
                                  player, { "avatar", 4801, 0, 0, 0, {} }, runtime, 2 );
    sol::protected_function_result rejected = copy(
                partner_handle, "string_input", stale_target, "nested_target" );
    REQUIRE( rejected.valid() );
    sol::table error_result = rejected;
    CHECK_FALSE( error_result["ok"].get<bool>() );
    CHECK( target.get_value( "nested_target" ) == nested );

}

TEST_CASE( "lua_platform_global_null_is_distinct_from_removal",
           "[lua][platform][strings][semantic]" )
{
    const std::string key = "lua_semantic_null_global";
    struct global_cleanup {
        const std::string &key;
        ~global_cleanup() {
            get_globals().remove_global_value( key );
        }
    } cleanup{ key };
    REQUIRE( get_globals().maybe_get_global_value( key ) == nullptr );
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_variable_api( services, [runtime]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {}, []() {
        return true;
    } );
    sol::protected_function set = services["variables"]["set_global"];
    sol::protected_function_result write = set( key, sol::nil );
    REQUIRE( write.valid() );
    sol::table result = write;
    REQUIRE( result["ok"].get<bool>() );
    REQUIRE( get_globals().maybe_get_global_value( key ) != nullptr );
    CHECK( get_globals().get_global_value( key ).is_empty() );
    sol::protected_function copy = services["variables"]["copy"];
    sol::protected_function_result self_copy = copy( sol::nil, key, sol::nil, key );
    REQUIRE( self_copy.valid() );
    sol::table self_result = self_copy;
    REQUIRE( self_result["ok"].get<bool>() );
    sol::table self_metadata = self_result["value"];
    CHECK( self_metadata["source_exists"].get<bool>() );
    CHECK( self_metadata["destination_existed"].get<bool>() );
    CHECK( get_globals().get_global_value( key ).is_empty() );
    sol::protected_function_result missing_copy = copy(
                sol::nil, "lua_semantic_missing_copy_source", sol::nil, key );
    REQUIRE( missing_copy.valid() );
    sol::table missing_result = missing_copy;
    REQUIRE( missing_result["ok"].get<bool>() );
    sol::table missing_metadata = missing_result["value"];
    CHECK_FALSE( missing_metadata["source_exists"].get<bool>() );
    CHECK( get_globals().maybe_get_global_value( key ) != nullptr );
    sol::protected_function remove = services["variables"]["remove_global"];
    sol::protected_function_result erased = remove( key );
    REQUIRE( erased.valid() );
    CHECK( get_globals().maybe_get_global_value( key ) == nullptr );
}

#endif
