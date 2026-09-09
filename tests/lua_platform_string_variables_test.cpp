#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
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
}

#endif
