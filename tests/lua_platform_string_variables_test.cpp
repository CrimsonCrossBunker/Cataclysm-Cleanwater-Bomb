#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "condition.h"
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
#include "weather.h"

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
    const std::string input = R"({"set_string_var":{")" + source_key +
                              R"(":"string_input"},"target_var":{")" +
                              ( indirect ? "var_val" : target_key ) + R"(":")" +
                              ( indirect ? "destination" : "legacy_output" ) + R"("}})";
    legacy.parse_sub_effect( json_loader::from_string( input ).get_object(), "string_acceptance" );
    for( const talk_effect_fun_t &effect : legacy.effects ) {
        effect( context );
    }
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    sol::state lua;
    lua.open_libraries( sol::lib::base );
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
    const cata::lua_platform::game_handle player_handle =
        cata::lua_platform::game_handle::from_creature(
            player, { "avatar", 4801, 0, 0, 0, {} }, runtime, 1 );
    const cata::lua_platform::game_handle partner_handle =
        cata::lua_platform::game_handle::from_creature(
            partner, { "npc", 4802, 0, 0, 0, {} }, runtime, 1 );
    player.set_value( "array_input", diag_value( diag_array{
        diag_value{}, diag_value( 0.0 ),
        diag_value( diag_array{ diag_value( "nested" ), diag_value{} } ), diag_value{}
    } ) );
    lua.open_libraries( sol::lib::base );
    lua["services"] = services;
    lua["array_owner"] = player_handle;
    const sol::protected_function_result array_read = lua.safe_script( R"(
        local result = services.variables.get(array_owner, "array_input")
        assert(result.ok and result.value.exists)
        local values = result.value.value
        assert(#values == 4)
        assert(values[1] == services.types.null and values[2] == 0)
        assert(#values[3] == 2 and values[3][1] == "nested")
        assert(values[3][2] == services.types.null and values[4] == services.types.null)
        assert(services.variables.set(array_owner, "array_output", values).ok)
        local restored = services.variables.get(array_owner, "array_output").value.value
        assert(#restored == 4 and #restored[3] == 2)
        assert(restored[1] == services.types.null and restored[4] == services.types.null)
        local cycle = {}; cycle[1] = cycle
        for _, invalid in ipairs({{[2]=1}, {bad=1}, cycle, {function() end}}) do
            local ok = pcall(services.variables.set, array_owner, "array_output", invalid)
            assert(not ok)
            local unchanged = services.variables.get(array_owner, "array_output").value.value
            assert(#unchanged == 4 and unchanged[3][1] == "nested")
        end
    )", sol::script_pass_on_error );
    REQUIRE( array_read.valid() );
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
    sol::table participants = lua.create_table();
    participants["alpha"] = player_handle;
    participants["beta"] = partner_handle;
    data["participant_reference"] = source_npc ? "n_string_input" : "u_string_input";
    const sol::protected_function_result participant_read = resolve(
                data, player_handle, "var", "participant_reference", participants );
    REQUIRE( participant_read.valid() );
    const sol::table participant_result = participant_read;
    REQUIRE( participant_result["ok"].get<bool>() );
    const sol::table participant_snapshot = participant_result["value"];
    CHECK( participant_snapshot["value"].get<std::string>() == value );
    participants[source_npc ? "beta" : "alpha"] = sol::nil;
    const sol::protected_function_result missing_participant = resolve(
                data, player_handle, "var", "participant_reference", participants );
    REQUIRE( missing_participant.valid() );
    const sol::table missing_result = missing_participant;
    REQUIRE( missing_result["ok"].get<bool>() );
    const sol::table missing_snapshot = missing_result["value"];
    CHECK_FALSE( missing_snapshot["exists"].get<bool>() );
    // Compose the same typed variable read with native environment predicates.
    // A stored null is present and must not select the missing-value fallback.
    const std::array<std::string, 4> seasons = { "spring", "summer", "autumn", "winter" };
    Character &environment_source = source_npc ? static_cast<Character &>( partner ) : player;
    context.set_value( "environment_ref", source_npc ? "n_environment_input" : "u_environment_input" );
    lua["services"] = services;
    lua["data"] = data;
    lua["source"] = source_npc ? partner_handle : player_handle;
    lua["scope"] = source_npc ? "npc" : "u";
    sol::protected_function environment_query = lua.load( R"(
        local result = services.variables.resolve(data, source, scope, "environment_input")
        assert(result.ok)
        local value = result.value
        if value.exists == false then return current == fallback end
        return current == tostring(value.value or "")
    )" );
    for( const std::string selector : {
             "is_season", "is_weather"
         } ) {
        const std::string current = selector == "is_season" ?
                                    seasons[season_of_year( calendar::turn )] : get_weather().weather_id.str();
        lua["current"] = current;
        lua["fallback"] = current;
        for( int state = 0; state < 4; ++state ) {
            CAPTURE( selector, source_npc, state );
            environment_source.remove_value( "environment_input" );
            if( state == 1 ) {
                environment_source.set_value( "environment_input", current );
            } else if( state == 2 ) {
                environment_source.set_value( "environment_input", "unknown" );
            } else if( state == 3 ) {
                environment_source.set_value( "environment_input", diag_value{} );
            }
            std::string condition_json = R"({")";
            condition_json += selector;
            condition_json += R"(":{")";
            condition_json += indirect ? "var_val" : source_key;
            condition_json += R"(":")";
            condition_json += indirect ? "environment_ref" : "environment_input";
            condition_json += R"(","default":")";
            condition_json += current;
            condition_json += R"("}})";
            conditional_t predicate( json_loader::from_string( condition_json ).get_object() );
            const sol::protected_function_result actual = environment_query();
            if( !actual.valid() ) {
                const sol::error error = actual;
                FAIL( error.what() );
            }
            CHECK( actual.get<bool>() == predicate( context ) );
        }
    }
    sol::protected_function set = services["variables"]["set_resolved"];
    sol::protected_function_result write = set(
            data, target_npc ? partner_handle : player_handle,
            target_npc ? "npc" : "u", "platform_output", value );
    REQUIRE( write.valid() );
    sol::table write_result = write;
    REQUIRE( write_result["ok"].get<bool>() );
    participants["alpha"] = player_handle;
    participants["beta"] = partner_handle;
    data["write_reference"] = target_npc ? "n_indirect_output" : "u_indirect_output";
    const sol::protected_function_result indirect_write = set(
                data, player_handle, "var", "write_reference", value, participants );
    REQUIRE( indirect_write.valid() );
    const sol::table indirect_result = indirect_write;
    REQUIRE( indirect_result["ok"].get<bool>() );
    const Character &indirect_target = target_npc ? static_cast<Character &>( partner ) : player;
    CHECK( indirect_target.get_value( "indirect_output" ).str() == value );
    participants[target_npc ? "beta" : "alpha"] = sol::nil;
    const sol::protected_function_result absent_write = set(
                data, player_handle, "var", "write_reference", "wrong", participants );
    REQUIRE( absent_write.valid() );
    const sol::table absent_result = absent_write;
    CHECK_FALSE( absent_result["ok"].get<bool>() );
    CHECK( indirect_target.get_value( "indirect_output" ).str() == value );
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
    nested._deserialize( json_loader::from_string( R"([null,[1,null,"tail"],{"tripoint":[1,2,3]}])" ),
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
    const cata::lua_platform::game_handle stale_target = cata::lua_platform::game_handle::from_creature(
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
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    sol::state lua;
    lua.open_libraries( sol::lib::base );
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
    // Global values must retain the same missing/present-null distinction
    // when consumed as dynamic strings by environment conditions.
    lua["services"] = services;
    lua["key"] = key;
    sol::protected_function query = lua.load( R"(
        local result = services.variables.resolve(nil, nil, "global", key)
        assert(result.ok)
        local value = result.value
        if value.exists == false then return current == fallback end
        return current == tostring(value.value or "")
    )" );
    dialogue context;
    const bool indirect = GENERATE( false, true );
    context.set_value( "environment_global_ref", key );
    const std::array<std::string, 4> seasons = { "spring", "summer", "autumn", "winter" };
    for( const std::string selector : {
             "is_season", "is_weather"
         } ) {
        const std::string current = selector == "is_season" ?
                                    seasons[season_of_year( calendar::turn )] : get_weather().weather_id.str();
        lua["current"] = current;
        lua["fallback"] = current;
        for( int state = 0; state < 4; ++state ) {
            CAPTURE( selector, state, indirect );
            get_globals().remove_global_value( key );
            if( state == 1 ) {
                get_globals().set_global_value( key, current );
            } else if( state == 2 ) {
                get_globals().set_global_value( key, "unknown" );
            } else if( state == 3 ) {
                get_globals().set_global_value( key, diag_value{} );
            }
            const std::string condition_json = R"({")" + selector + R"(":{")" +
                                               ( indirect ? "var_val" : "global_val" ) + R"(":")" +
                                               ( indirect ? "environment_global_ref" : key ) +
                                               R"(","default":")" + current + R"("}})";
            conditional_t predicate( json_loader::from_string( condition_json ).get_object() );
            const sol::protected_function_result actual = query();
            REQUIRE( actual.valid() );
            CHECK( actual.get<bool>() == predicate( context ) );
        }
    }
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
