#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <debug.h>
#include <type_id.h>
#include <array>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <optional>
#include <random>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "condition.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "global_vars.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "rng.h"
#include "translation.h"
#include "weather.h"

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform

TEST_CASE( "lua_platform_string_variable_owners_match_native_assignment",
           "[lua][platform][strings][semantic]" )
{
    restore_on_out_of_scope restore_weather( get_weather().weather_id );
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
        -- Variables retain their larger array bound: 511 values plus the root node.
        local wide = {}
        for i = 1, 511 do wide[i] = i end
        assert(services.variables.set(array_owner, "wide_array", wide).ok)
        assert(#services.variables.get(array_owner, "wide_array").value.value == 511)
        wide[512] = 512
        assert(not pcall(services.variables.set, array_owner, "wide_array", wide))
        assert(#services.variables.get(array_owner, "wide_array").value.value == 511)
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
        return current == (type(value.value) == "string" and value.value or "")
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
    // Native str_or_var calls diag_value::str(): a number yields an empty
    // string (with a native debug diagnostic), never its formatted digits.
    environment_source.set_value( "environment_input", diag_value( 1.0 ) );
    sol::protected_function numeric_string = lua.load( "return tostring(1.0)" );
    const sol::protected_function_result numeric_result = numeric_string();
    REQUIRE( numeric_result.valid() );
    const std::string numeric_text = numeric_result.get<std::string>();
    get_weather().weather_id = weather_type_id( numeric_text );
    lua["current"] = numeric_text;
    lua["fallback"] = "";
    const std::string nonstring_condition = R"({"is_weather":{")" +
                                            ( indirect ? "var_val" : source_key ) + R"(":")" +
                                            ( indirect ? "environment_ref" : "environment_input" ) +
                                            R"(","default":""}})";
    const conditional_t nonstring_predicate(
        json_loader::from_string( nonstring_condition ).get_object() );
    const sol::protected_function_result nonstring_actual = environment_query();
    REQUIRE( nonstring_actual.valid() );
    bool native_nonstring_result = false;
    const std::string native_nonstring_diagnostic = capture_debugmsg_during( [&]() {
        native_nonstring_result = nonstring_predicate( context );
    } );
    CHECK( native_nonstring_diagnostic.find(
               "Type mismatch in diag_value: requested string, got double" ) != std::string::npos );
    CHECK( nonstring_actual.get<bool>() == native_nonstring_result );
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

TEST_CASE( "lua_platform_string_assignment_lazy_choices_match_native_rng_and_values",
           "[lua][platform][strings][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [&saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.setID( character_id( 4821 ), true );
    partner.setID( character_id( 4822 ), true );
    platform::register_npc_handle_identity( partner );
    const on_out_of_scope retire_partner( [&]() {
        platform::retire_npc_handle_identity( partner );
    } );
    dialogue conversation( get_talker_for( player ), get_talker_for( partner ) );
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "string_assignment_values", 4823, lua );
    const on_out_of_scope cleanup_runtime( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    lua["ccb"] = ccb;
    const bool translated = GENERATE( false, true );
    const std::size_t choice_count = GENERATE( std::size_t( 1 ), std::size_t( 3 ), std::size_t( 65 ) );
    const std::string target_scope = GENERATE( "u_val", "npc_val", "context_val" );
    const std::string source_key( "assignment\0source", sizeof( "assignment\0source" ) - 1 );
    const std::vector<std::string> target_keys = {
        "", source_key, std::string( 10000, 'k' )
    };
    const sol::protected_function_result loaded = lua.safe_script( R"(
local services=ccb.services
local function value(result) assert(result.ok);return result.value end
return function(actor,partner,data,key,target_scope,target_key,count,translated)
 local function read(owner,fallback)
  local result=value(services.variables.get_string(owner,key))
  if result.exists==false then
   if translated then return services.translate(fallback) end
   return fallback
  end
  return result.value
 end
 local providers={}
 for i=1,count do
  local kind=(i-1)%3
  if kind==0 then providers[i]=function() return read(actor,'Alpha fallback.') end
  elseif kind==1 then providers[i]=function() return read(partner,'Beta fallback.') end
  else providers[i]=function()
   if translated then return services.translate('Literal candidate.') end
   return 'Literal candidate.'
  end end
 end
 local selected=providers[services.random.native_int(0,#providers-1)+1]()
 if target_scope=='context_val' then data[target_key]=selected
 else value(services.variables.set(target_scope=='u_val' and actor or partner,target_key,selected)) end
 return selected
end
)", sol::script_pass_on_error );
    REQUIRE( loaded.valid() );
    const sol::protected_function assign = loaded.get<sol::protected_function>();
    bool completed = false;
    lua.set_function( "accept", [&]( const sol::table & ) {
        const auto handle_for = [&]( Character &actor, const bool is_npc ) {
            return platform::game_handle::from_creature(
                       actor, { is_npc ? "npc" : "avatar", actor.getID().get_value(), 0, 0, 0, {} },
                       platform::detail::runtime_handle_identity( runtime ), platform::runtime_world_generation() );
        };
        const platform::game_handle alpha_handle = handle_for( player, false );
        const platform::game_handle beta_handle = handle_for( partner, true );
        for( const std::string &target_key : target_keys ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( "set_string_var" );
                json.start_array();
                for( std::size_t index = 0; index < choice_count; ++index ) {
                    if( index % 3 == 2 ) {
                        json.write( "Literal candidate." );
                    } else {
                        json.start_object();
                        json.member( index % 3 == 0 ? "u_val" : "npc_val", source_key );
                        json.member( "default", index % 3 == 0 ? "Alpha fallback." : "Beta fallback." );
                        json.end_object();
                    }
                }
                json.end_array();
                json.member( "i18n", translated );
                json.member( "target_var" );
                json.start_object();
                json.member( target_scope, target_key );
                json.end_object();
                json.end_object();
            }
            talk_effect_t native_assignment;
            native_assignment.parse_sub_effect( json_loader::from_string( source.str() ).get_object(),
                                                "string_assignment_values" );
            for( int state = 0; state < 4; ++state ) {
                const auto reset_sources = [&]() {
                    player.remove_value( source_key );
                    partner.remove_value( source_key );
                    if( state == 1 ) {
                        player.set_value( source_key, std::string() );
                        partner.set_value( source_key, std::string() );
                    } else if( state == 2 ) {
                        player.set_value( source_key, std::string( 10000, 'a' ) + '\0' + "alpha" );
                        partner.set_value( source_key, std::string( 10000, 'b' ) + '\0' + "beta" );
                    } else if( state == 3 ) {
                        player.set_value( source_key, diag_value{} );
                        partner.set_value( source_key, diag_value{} );
                    }
                };
                for( const unsigned int seed : { 4824U, 4825U } ) {
                    reset_sources();
                    rng_set_engine_seed( seed );
                    for( const talk_effect_fun_t &effect : native_assignment.effects ) {
                        effect( conversation );
                    }
                    const std::string expected = target_scope == "context_val" ?
                                                 conversation.get_value( target_key ).str() :
                                                 ( target_scope == "u_val" ? player : static_cast<Character &>( partner ) ).get_value( target_key ).str();
                    const cata_default_random_engine native_rng_after = rng_get_engine(); // NOLINT(cata-determinism)
                    reset_sources();
                    sol::table data = lua.create_table();
                    rng_set_engine_seed( seed );
                    const sol::protected_function_result result = assign(
                                alpha_handle, beta_handle, data, source_key, target_scope, target_key,
                                choice_count, translated );
                    CAPTURE( target_scope, target_key.size(), choice_count, translated, state, seed );
                    REQUIRE( result.valid() );
                    CHECK( result.get<std::string>() == expected );
                    CHECK( rng_get_engine() == native_rng_after );
                    if( target_scope == "context_val" ) {
                        CHECK( data.raw_get<std::string>( target_key ) == expected );
                    } else {
                        const Character &target = target_scope == "u_val" ? player : static_cast<Character &>( partner );
                        CHECK( target.get_value( target_key ).str() == expected );
                    }
                }
            }
        }
        completed = true;
    } );
    sol::protected_function_result registered = ccb["runtime"]["handler"]( "accept", lua["accept"] );
    REQUIRE( registered.valid() );
    registered = ccb["runtime"]["on"]( "world_ready", "accept" );
    REQUIRE( registered.valid() );
    platform::runtime_world_ready( true );
    REQUIRE( completed );
}

TEST_CASE( "lua_platform_indirect_string_assignment_matches_native_targets_and_diagnostics",
           "[lua][platform][strings][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    restore_on_out_of_scope restore_globals( get_globals().get_global_values() );
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [&saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 4841 ), true );
    beta.setID( character_id( 4842 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );
    dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::string );
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "indirect_string_assignment", 4843, lua );
    const on_out_of_scope cleanup_runtime( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    lua["ccb"] = ccb;
    const sol::protected_function_result loaded = lua.safe_script( R"(
local services=ccb.services
local function value(result) assert(result.ok);return result.value end
return function(alpha,beta,data,key,text)
 services.random.native_int(0,0)
 local result=value(services.variables.get_context_string(data,key))
 local name=result.exists==false and '' or result.value
 if string.sub(name,1,2)=='u_' then value(services.variables.set(alpha,string.sub(name,3),text))
 elseif string.sub(name,1,2)=='n_' then value(services.variables.set(beta,string.sub(name,3),text))
 elseif string.sub(name,1,1)=='_' then data[string.sub(name,2)]=text
 else value(services.variables.set_global(name,text)) end
end
)", sol::script_pass_on_error );
    REQUIRE( loaded.valid() );
    const sol::protected_function assign = loaded.get<sol::protected_function>();
    bool completed = false;
    lua.set_function( "accept", [&]( const sol::table & ) {
        const auto handle_for = [&]( Character &actor, const bool is_npc ) {
            return platform::game_handle::from_creature(
                       actor, { is_npc ? "npc" : "avatar", actor.getID().get_value(), 0, 0, 0, {} },
                       platform::detail::runtime_handle_identity( runtime ), platform::runtime_world_generation() );
        };
        const platform::game_handle alpha_handle = handle_for( alpha, false );
        const platform::game_handle beta_handle = handle_for( beta, true );
        const std::string assigned = std::string( 10000, 'v' ) + '\0' + "u_not_followed";
        const std::vector<std::string> keys = {
            "", std::string( "pointer\0key", sizeof( "pointer\0key" ) - 1 ), std::string( 10000, 'k' )
        };
        const diag_array array_pointer( 5000, diag_value( std::string( "u_not_followed" ) ) );
        for( const std::string &key : keys ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( "set_string_var", assigned );
                json.member( "target_var" );
                json.start_object();
                json.member( "var_val", key );
                json.end_object();
                json.end_object();
            }
            talk_effect_t native_assignment;
            native_assignment.parse_sub_effect( json_loader::from_string( source.str() ).get_object(),
                                                "indirect_string_assignment" );
            const std::vector<std::optional<diag_value>> pointers = {
                std::nullopt, diag_value{}, diag_value( 42.0 ), diag_value( array_pointer ),
                diag_value( std::string() ), diag_value( std::string( "u_" ) ), diag_value( std::string( "n_" ) ),
                diag_value( std::string( "_" ) ), diag_value( "u_" + key ), diag_value( "n_" + key ),
                diag_value( "_" + key ), diag_value( std::string( "var_u_not_followed" ) ),
                diag_value( key ), diag_value( std::string( "global\0key", sizeof( "global\0key" ) - 1 ) )
            };
            for( const auto &pointer : pointers ) {
                conversation.remove_value( key );
                if( pointer ) {
                    conversation.set_value( key, *pointer );
                }
                // Determine the expected destination without producing a
                // second diagnostic from a wrong-type pointer.
                const std::string pointer_text = pointer && pointer->is_str() ? pointer->str() : std::string();
                const var_info target = process_variable( pointer_text );
                rng_set_engine_seed( 4844 );
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    for( const talk_effect_fun_t &effect : native_assignment.effects ) {
                        effect( conversation );
                    }
                } );
                const cata_default_random_engine native_rng_after = rng_get_engine(); // NOLINT(cata-determinism)
                const std::string native_value = target.type == var_type::context ? conversation.get_value( target.name ).str() :
                                                 target.type == var_type::u ? alpha.get_value( target.name ).str() :
                                                 target.type == var_type::npc ? beta.get_value( target.name ).str() :
                                                 get_globals().get_global_value( target.name ).str();
                REQUIRE( native_value == assigned );
                sol::table data = lua.create_table();
                if( pointer ) {
                    if( pointer->is_str() ) {
                        data.raw_set( key, pointer->str() );
                    } else if( pointer->is_empty() ) {
                        data.raw_set( key, ccb["services"]["types"]["null"].get<sol::object>() );
                    } else if( pointer->is_dbl() ) {
                        data.raw_set( key, 42.0 );
                    } else {
                        sol::table entries = lua.create_table();
                        for( int index = 1; index <= 5000; ++index ) {
                            entries[index] = "u_not_followed";
                        }
                        data.raw_set( key, entries );
                    }
                }
                if( target.type == var_type::u ) {
                    alpha.remove_value( target.name );
                } else if( target.type == var_type::npc ) {
                    beta.remove_value( target.name );
                } else if( target.type == var_type::global ) {
                    get_globals().remove_global_value( target.name );
                }
                rng_set_engine_seed( 4844 );
                const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                    const sol::protected_function_result result = assign(
                                alpha_handle, beta_handle, data, key, assigned );
                    REQUIRE( result.valid() );
                } );
                CAPTURE( key.size(), pointer_text.size(), target.name.size() );
                CHECK( platform_diagnostic == native_diagnostic );
                CHECK( rng_get_engine() == native_rng_after );
                const std::string actual = target.type == var_type::context ? data.raw_get<std::string>( target.name ) :
                                           target.type == var_type::u ? alpha.get_value( target.name ).str() :
                                           target.type == var_type::npc ? beta.get_value( target.name ).str() :
                                           get_globals().get_global_value( target.name ).str();
                CHECK( actual == native_value );
            }
        }
        completed = true;
    } );
    sol::protected_function_result registered = ccb["runtime"]["handler"]( "accept", lua["accept"] );
    REQUIRE( registered.valid() );
    registered = ccb["runtime"]["on"]( "world_ready", "accept" );
    REQUIRE( registered.valid() );
    platform::runtime_world_ready( true );
    REQUIRE( completed );
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
    // Global resolution does not use the context.  An explicit table keeps
    // this value test independent of optional-table argument consumption.
    sol::protected_function query = lua.load( R"(
        local result = services.variables.resolve({}, nil, "global", key)
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
            std::string condition_json = R"({")";
            condition_json += selector;
            condition_json += R"(":{")";
            condition_json += indirect ? "var_val" : "global_val";
            condition_json += R"(":")";
            condition_json += indirect ? "environment_global_ref" : key;
            condition_json += R"(","default":")";
            condition_json += current;
            condition_json += R"("}})";
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

TEST_CASE( "lua_context_string_lookup_matches_native_unrestricted_keys",
           "[lua][platform][strings][semantic]" )
{
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    sol::table data = lua.create_table();
    lua["data"] = data;
    sol::protected_function read = lua.load( R"(
        local value = data[key]
        if value == nil then return "fallback" end
        if type(value) == "string" then return value end
        return ""
    )" );
    for( const std::string &key : std::vector<std::string> {
    "", std::string( "nul\0key", 7 ), "control\nkey", std::string( 129, 'k' ), "中文键"
    } ) {
        CAPTURE( key.size() );
        std::ostringstream input;
        JsonOut writer( input );
        writer.start_object();
        writer.member( "value" );
        writer.start_object();
        writer.member( "context_val", key );
        writer.member( "default", "fallback" );
        writer.end_object();
        writer.end_object();
        const JsonObject object = json_loader::from_string( input.str() ).get_object();
        const str_or_var native = get_str_or_var( object.get_member( "value" ), "value" );
        dialogue context;
        lua["key"] = key;
        const auto compare = [&]( const std::string & expected ) {
            const sol::protected_function_result actual = read();
            REQUIRE( actual.valid() );
            CHECK( actual.get<std::string>() == expected );
            CHECK( native.evaluate( context ) == expected );
        };
        compare( "fallback" );
        const std::string long_value( 9000, 'v' );
        context.set_value( key, long_value );
        data.raw_set( key, long_value );
        compare( long_value );
        context.set_value( key, diag_value{} );
        data.raw_set( key, services["types"]["null"].get<sol::object>() );
        compare( "" );
        context.set_value( key, diag_value( 42.0 ) );
        data.raw_set( key, 42.0 );
        const std::string diagnostic = capture_debugmsg_during( [&]() {
            compare( "" );
        } );
        CHECK( diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
        data.raw_set( key, sol::nil );
    }
}


TEST_CASE( "lua_migration_indirect_string_native_pointer_baseline",
           "[lua][platform][strings][semantic]" )
{
    restore_on_out_of_scope restore_globals( get_globals().get_global_values() );
    const std::string empty_global = std::string( "empty-global" ) + '\0' + "raw suffix";
    get_globals().set_global_value( "", empty_global );
    for( const std::string &key : std::vector<std::string> {
    "", std::string( "pointer\0key", 11 ), "pointer\nkey", std::string( 9000, 'p' )
    } ) {
        CAPTURE( key.size() );
        std::ostringstream input;
        JsonOut writer( input );
        writer.start_object();
        writer.member( "value" );
        writer.start_object();
        writer.member( "var_val", key );
        writer.member( "default", "fallback" );
        writer.end_object();
        writer.end_object();
        const JsonObject object = json_loader::from_string( input.str() ).get_object();
        const str_or_var native = get_str_or_var( object.get_member( "value" ), "value" );
        const translation_or_var translated = get_translation_or_var(
                object.get_member( "value" ), "value" );
        dialogue context;
        CHECK( native.evaluate( context ) == "fallback" );
        CHECK( translated.evaluate( context ).translated() == to_translation( "fallback" ).translated() );
        context.set_value( key, diag_value{} );
        CHECK( native.evaluate( context ) == empty_global );
        CHECK( translated.evaluate( context ).translated() == empty_global );
        context.set_value( key, "" );
        CHECK( native.evaluate( context ) == empty_global );
        CHECK( translated.evaluate( context ).translated() == empty_global );
        for( const diag_value &pointer : {
                 diag_value( 42.0 ), diag_value( diag_array{ diag_value( "u_key" ) } )
             } ) {
            context.set_value( key, pointer );
            const std::string diagnostic = capture_debugmsg_during( [&]() {
                CHECK( native.evaluate( context ) == empty_global );
                CHECK( translated.evaluate( context ).translated() == empty_global );
            } );
            CHECK( diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
        }
        // Prefixes select a scope once; a missing participant is a missing value.
        for( const std::string pointer : {
                 "u_key", "n_key"
             } ) {
            context.set_value( key, pointer );
            const std::string diagnostic = capture_debugmsg_during( [&]() {
                CHECK( native.evaluate( context ) == "fallback" );
                CHECK( translated.evaluate( context ).translated() == to_translation( "fallback" ).translated() );
            } );
            CHECK( diagnostic.find( pointer == "u_key" ?
                                    "Tried to use an invalid alpha talker" :
                                    "Tried to use an invalid beta talker" ) != std::string::npos );
        }
        // A referenced string that itself looks like a pointer is not followed.
        const std::string target = "native_indirect_target";
        context.set_value( target, "u_not_followed" );
        context.set_value( key, "_" + target );
        CHECK( native.evaluate( context ) == "u_not_followed" );
        CHECK( translated.evaluate( context ).translated() == "u_not_followed" );
        const std::string stored_raw = std::string( 10000, 'v' ) + '\0' + "u_not_followed";
        context.set_value( target, stored_raw );
        CHECK( translated.evaluate( context ).translated() == stored_raw );
        context.set_value( target, diag_value{} );
        CHECK( native.evaluate( context ).empty() );
        CHECK( translated.evaluate( context ).translated().empty() );
        context.remove_value( target );
        CHECK( native.evaluate( context ) == "fallback" );
        CHECK( translated.evaluate( context ).translated() == to_translation( "fallback" ).translated() );
        avatar alpha;
        npc beta;
        alpha.set_value( key, "alpha-value" );
        beta.set_value( key, "beta-value" );
        dialogue participants( get_talker_for( alpha ), get_talker_for( beta ) );
        participants.set_value( key, "u_" + key );
        CHECK( native.evaluate( participants ) == "alpha-value" );
        CHECK( translated.evaluate( participants ).translated() == "alpha-value" );
        participants.set_value( key, "n_" + key );
        CHECK( native.evaluate( participants ) == "beta-value" );
        CHECK( translated.evaluate( participants ).translated() == "beta-value" );
        get_globals().set_global_value( target, "global-value" );
        participants.set_value( key, target );
        CHECK( native.evaluate( participants ) == "global-value" );
        CHECK( translated.evaluate( participants ).translated() == "global-value" );
    }
}

#endif
