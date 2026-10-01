#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "global_vars.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "math_parser_diag_value.h"
#include "talker.h"
#include "type_id.h"

namespace
{

using cata::lua_platform::game_handle;
using cata::lua_platform::game_handle_runtime;

struct global_values_restore {
    global_variables::impl_t previous = get_globals().get_global_values();

    ~global_values_restore() {
        get_globals().set_global_values( std::move( previous ) );
    }
};

struct variable_snapshot_fixture {
    sol::state lua;
    sol::table services;
    sol::table variables;
    const cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const game_handle_runtime runtime{ runtime_owner, 1 };

    variable_snapshot_fixture() {
        lua.open_libraries( sol::lib::base );
        services = lua.create_table();
        cata::lua_platform::install_value_type_api( lua, services, []() {} );
        cata::lua_platform::install_game_handle_api(
        lua, services, [this]() {
            return runtime;
        }, []() {
            return std::size_t( 1 );
        }, []() {} );
        cata::lua_platform::install_variable_api(
        services, [this]() {
            return runtime;
        }, []() {
            return std::size_t( 1 );
        }, []() {}, []() {}, []() {
            return true;
        } );
        variables = services["variables"];
    }

    game_handle owner( avatar &player ) const {
        return cata::lua_platform::game_handle::from_creature(
                   player, { "avatar", player.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    }
};

sol::table require_result_value( const sol::protected_function_result &call )
{
    REQUIRE( call.valid() );
    const sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    return result["value"];
}

diag_value oversized_native_array()
{
    // The root array plus 512 scalar children exceeds the Lua bridge's 512-node
    // snapshot limit, while native diag_value storage has no such limit.
    diag_array values;
    values.reserve( 512 );
    for( int index = 0; index < 512; ++index ) {
        values.emplace_back( index );
    }
    return diag_value( std::move( values ) );
}

} // namespace

TEST_CASE( "lua_platform_context_keys_match_native_variable_storage",
           "[lua][platform][semantic][variables]" )
{
    variable_snapshot_fixture fixture;
    avatar player;
    const sol::protected_function resolve = fixture.variables["resolve"];
    const sol::protected_function set_resolved = fixture.variables["set_resolved"];
    const sol::object null_value = fixture.services["types"]["null"];
    const std::vector<std::string> keys = {
        "", std::string( 300, 'k' ), std::string( "raw\0key", 7 ), "\n\t\x7f原生键"
    };
    for( const std::string &key : keys ) {
        INFO( key.size() );
        dialogue native( get_talker_for( player ), nullptr );
        sol::table context = fixture.lua.create_table();
        const var_info direct{ var_type::context, key };
        const sol::table missing = require_result_value(
                                      resolve( context, sol::nil, "context", key ) );
        CHECK_FALSE( missing["exists"].get<bool>() );
        CHECK( maybe_read_var_value( direct, native ) == nullptr );

        native.set_value( key, "before" );
        context.raw_set( key, "before" );
        const sol::table direct_result = require_result_value(
                                            resolve( context, sol::nil, "context", key ) );
        REQUIRE( maybe_read_var_value( direct, native ) != nullptr );
        CHECK( direct_result["exists"].get<bool>() );
        CHECK( direct_result["value"].get<std::string>() ==
               read_var_value( direct, native ).str() );

        const std::string pointer = std::string( "pointer\0", 8 ) + key;
        native.set_value( pointer, "_" + key );
        context.raw_set( pointer, "_" + key );
        const var_info indirect{ var_type::var, pointer };
        const sol::table indirect_result = require_result_value(
                                              resolve( context, sol::nil, "var", pointer ) );
        CHECK( indirect_result["exists"].get<bool>() );
        CHECK( indirect_result["value"].get<std::string>() ==
               read_var_value( indirect, native ).str() );

        native.set_value( key, "after" );
        const sol::table updated = require_result_value(
                                      set_resolved( context, sol::nil, "var", pointer, "after" ) );
        CHECK( updated["existed"].get<bool>() );
        CHECK( updated["before"].get<std::string>() == "before" );
        CHECK( context.raw_get<std::string>( key ) == read_var_value( direct, native ).str() );

        native.set_value( key, diag_value{} );
        require_result_value( set_resolved( context, sol::nil, "context", key, null_value ) );
        const sol::table empty = require_result_value(
                                    resolve( context, sol::nil, "context", key ) );
        REQUIRE( maybe_read_var_value( direct, native ) != nullptr );
        CHECK( read_var_value( direct, native ).is_empty() );
        CHECK( empty["exists"].get<bool>() );
        CHECK( empty["value"].get<sol::object>().get_type() == sol::type::nil );

        native.remove_value( key );
        require_result_value( set_resolved( context, sol::nil, "context", key, sol::nil ) );
        const sol::table removed = require_result_value(
                                      resolve( context, sol::nil, "context", key ) );
        CHECK_FALSE( removed["exists"].get<bool>() );
        CHECK( maybe_read_var_value( direct, native ) == nullptr );
    }
}

TEST_CASE( "lua_platform_context_string_query_matches_native_type_diagnostics",
           "[lua][platform][semantic][variables]" )
{
    variable_snapshot_fixture fixture;
    avatar player;
    dialogue native( get_talker_for( player ), nullptr );
    sol::table context = fixture.lua.create_table();
    const std::string key = std::string( "\0context", 8 ) + "变量" + std::string( 300, 'k' );
    const sol::protected_function query = fixture.variables["get_context_string"];
    const sol::table missing = require_result_value( query( context, key ) );
    CHECK_FALSE( missing["exists"].get<bool>() );
    CHECK( missing["value"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( native.maybe_get_value( key ) == nullptr );
    CHECK_FALSE( require_result_value( query( sol::nil, key ) )["exists"].get<bool>() );

    const sol::object empty = fixture.services["types"]["null"];
    const std::string raw_text = std::string( 10000, 's' ) + std::string( "\0尾", 4 );
    const tripoint_abs_ms point( 1, -2, 3 );
    const auto position = cata::lua_platform::script_tripoint_coord::from_native(
                              coords::origin::abs, coords::scale::map_square, point.raw() );
    sol::table large = fixture.lua.create_table();
    for( int index = 1; index <= 512; ++index ) {
        large[index] = index;
    }
    sol::object nested = sol::make_object( fixture.lua, "leaf" );
    diag_value nested_native( "leaf" );
    for( int depth = 0; depth < 12; ++depth ) {
        sol::table parent = fixture.lua.create_table();
        parent[1] = nested;
        nested = sol::make_object( fixture.lua, parent );
        diag_array values;
        values.push_back( std::move( nested_native ) );
        nested_native = diag_value( std::move( values ) );
    }
    const std::vector<std::pair<diag_value, sol::object>> cases = {
        { diag_value( "" ), sol::make_object( fixture.lua, "" ) },
        { diag_value( raw_text ), sol::make_object( fixture.lua, raw_text ) },
        { diag_value{}, empty },
        { diag_value( 73.0 ), sol::make_object( fixture.lua, 73.0 ) },
        { diag_value( true ), sol::make_object( fixture.lua, true ) },
        { diag_value( point ), sol::make_object( fixture.lua, position ) },
        { oversized_native_array(), sol::make_object( fixture.lua, large ) },
        { nested_native, nested }
    };
    for( const auto &test_case : cases ) {
        native.set_value( key, test_case.first );
        context.raw_set( key, test_case.second );
        REQUIRE( native.maybe_get_value( key ) != nullptr );
        std::string expected;
        const std::string native_diagnostic = capture_debugmsg_during( [&]() {
            expected = native.get_value( key ).str();
        } );
        sol::table result;
        const std::string actual_diagnostic = capture_debugmsg_during( [&]() {
            result = require_result_value( query( context, key ) );
        } );
        CHECK( result["exists"].get<bool>() );
        CHECK( result["value"].get<std::string>() == expected );
        CHECK( actual_diagnostic == native_diagnostic );
    }
    const auto relative = cata::lua_platform::script_tripoint_coord::from_native(
                              coords::origin::relative, coords::scale::map_square, tripoint::zero );
    context.raw_set( key, relative );
    CHECK_FALSE( query( context, key ).valid() );
    const game_handle unsupported = fixture.owner( player );
    context.raw_set( key, unsupported );
    CHECK_FALSE( query( context, key ).valid() );
}

TEST_CASE( "lua_platform_global_string_query_preserves_native_type_semantics",
           "[lua][platform][semantic][variables]" )
{
    global_values_restore restore_globals;
    variable_snapshot_fixture fixture;
    const sol::protected_function get_string = fixture.variables["get_global_string"];
    const sol::protected_function get_snapshot = fixture.variables["get_global"];
    REQUIRE( get_string.valid() );
    REQUIRE( get_snapshot.valid() );
    const std::string key = std::string( 1, '\0' ) + "变量" + std::string( 300, 'k' );
    get_globals().remove_global_value( key );
    const sol::table missing = require_result_value( get_string( key ) );
    CHECK_FALSE( missing["exists"].get<bool>() );
    CHECK( missing["value"].get<sol::object>().get_type() == sol::type::nil );

    const auto compare = [&]( const diag_value &stored, const bool type_mismatch ) {
        get_globals().set_global_value( key, stored );
        const diag_value *native = get_globals().maybe_get_global_value( key );
        REQUIRE( native != nullptr );
        std::string native_string;
        std::string native_diagnostic;
        sol::table value;
        std::string platform_diagnostic;
        if( type_mismatch ) {
            native_diagnostic = capture_debugmsg_during( [&]() {
                native_string = native->str();
            } );
            get_globals().set_global_value( key, stored );
            platform_diagnostic = capture_debugmsg_during( [&]() {
                value = require_result_value( get_string( key ) );
            } );
            CHECK( native_diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            CHECK( platform_diagnostic == native_diagnostic );
        } else {
            native_string = native->str();
            get_globals().set_global_value( key, stored );
            value = require_result_value( get_string( key ) );
        }
        CHECK( value["exists"].get<bool>() );
        CHECK( value["value"].get<std::string>() == native_string );
    };
    compare( diag_value( "" ), false );
    compare( diag_value( std::string( 10000, 'x' ) + std::string( 1, '\0' ) + "熟练度" ), false );
    compare( diag_value( diag_value::legacy_value( "native legacy string" ) ), false );
    compare( diag_value(), false );
    compare( diag_value( 73 ), true );
    compare( diag_value( tripoint_abs_ms( 1, 2, 3 ) ), true );
    compare( oversized_native_array(), true );
    // A full-value snapshot still rejects this native array; the string query
    // has already matched native behavior without traversing its elements.
    CHECK_FALSE( get_snapshot( key ).valid() );
    diag_value nested( "leaf" );
    for( int depth = 0; depth < 12; ++depth ) {
        nested = diag_value( diag_array{ nested } );
    }
    compare( nested, true );
    CHECK_FALSE( get_snapshot( key ).valid() );
}

TEST_CASE( "lua_platform_variable_mutations_can_skip_before_snapshots",
           "[lua][platform][semantic][variables]" )
{
    global_values_restore restore_globals;
    avatar player;
    player.normalize();
    player.setID( character_id( 5921 ), true );
    variable_snapshot_fixture fixture;
    const game_handle owner = fixture.owner( player );

    const std::string actor_key = "snapshot_options_actor";
    const std::string global_key = "snapshot_options_global";
    const diag_value oversized = oversized_native_array();
    sol::table options = fixture.lua.create_table();
    options["include_before"] = false;

    const sol::protected_function set = fixture.variables["set"];
    const sol::protected_function remove = fixture.variables["remove"];
    const sol::protected_function set_global = fixture.variables["set_global"];
    const sol::protected_function remove_global = fixture.variables["remove_global"];
    const sol::protected_function set_resolved = fixture.variables["set_resolved"];

    player.set_value( actor_key, oversized );
    const sol::protected_function_result default_actor_set = set( owner, actor_key, "actor-small" );
    CHECK_FALSE( default_actor_set.valid() );
    REQUIRE( player.maybe_get_value( actor_key ) != nullptr );
    CHECK( *player.maybe_get_value( actor_key ) == oversized );

    const sol::table actor_set_value = require_result_value(
                                           set( owner, actor_key, "actor-small", options ) );
    CHECK( actor_set_value["existed"].get<bool>() );
    CHECK( actor_set_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( actor_set_value["after"].get<std::string>() == "actor-small" );
    REQUIRE( player.maybe_get_value( actor_key ) != nullptr );
    CHECK( player.get_value( actor_key ).str() == "actor-small" );

    player.set_value( actor_key, oversized );
    const sol::protected_function_result default_actor_remove = remove( owner, actor_key );
    CHECK_FALSE( default_actor_remove.valid() );
    REQUIRE( player.maybe_get_value( actor_key ) != nullptr );
    CHECK( *player.maybe_get_value( actor_key ) == oversized );

    const sol::table actor_remove_value = require_result_value( remove( owner, actor_key, options ) );
    CHECK( actor_remove_value["removed"].get<bool>() );
    CHECK( actor_remove_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( player.maybe_get_value( actor_key ) == nullptr );

    get_globals().set_global_value( global_key, oversized );
    const sol::protected_function_result default_global_set =
        set_global( global_key, "global-small" );
    CHECK_FALSE( default_global_set.valid() );
    REQUIRE( get_globals().maybe_get_global_value( global_key ) != nullptr );
    CHECK( *get_globals().maybe_get_global_value( global_key ) == oversized );

    const sol::table global_set_value = require_result_value(
                                            set_global( global_key, "global-small", options ) );
    CHECK( global_set_value["existed"].get<bool>() );
    CHECK( global_set_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( global_set_value["after"].get<std::string>() == "global-small" );

    get_globals().set_global_value( global_key, oversized );
    const sol::protected_function_result default_global_remove = remove_global( global_key );
    CHECK_FALSE( default_global_remove.valid() );
    REQUIRE( get_globals().maybe_get_global_value( global_key ) != nullptr );
    CHECK( *get_globals().maybe_get_global_value( global_key ) == oversized );

    const sol::table global_remove_value = require_result_value( remove_global( global_key, options ) );
    CHECK( global_remove_value["removed"].get<bool>() );
    CHECK( global_remove_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( get_globals().maybe_get_global_value( global_key ) == nullptr );

    sol::table context = fixture.lua.create_table();
    player.set_value( actor_key, "default-before" );
    const sol::table default_resolved_value = require_result_value( set_resolved(
                context, owner, "u", actor_key, "default-after" ) );
    CHECK( default_resolved_value["existed"].get<bool>() );
    CHECK( default_resolved_value["before"].get<std::string>() == "default-before" );
    CHECK( default_resolved_value["after"].get<std::string>() == "default-after" );

    context["actor_reference"] = "u_" + actor_key;
    player.set_value( actor_key, oversized );
    const sol::table resolved_actor_value = require_result_value( set_resolved(
            context, owner, "var", "actor_reference", "resolved-actor", sol::nil, options ) );
    CHECK( resolved_actor_value["existed"].get<bool>() );
    CHECK( resolved_actor_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( player.get_value( actor_key ).str() == "resolved-actor" );

    context["global_reference"] = global_key;
    get_globals().set_global_value( global_key, oversized );
    const sol::table resolved_global_value = require_result_value( set_resolved(
                context, sol::nil, "var", "global_reference", "resolved-global", sol::nil,
                options ) );
    CHECK( resolved_global_value["existed"].get<bool>() );
    CHECK( resolved_global_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( get_globals().get_global_value( global_key ).str() == "resolved-global" );

    context["context_value"] = "context-before";
    const sol::table resolved_context_value = require_result_value( set_resolved(
                context, sol::nil, "context", "context_value", "context-after", sol::nil,
                options ) );
    CHECK( resolved_context_value["existed"].get<bool>() );
    CHECK( resolved_context_value["before"].get<sol::object>().get_type() == sol::type::nil );
    CHECK( resolved_context_value["after"].get<std::string>() == "context-after" );
    CHECK( context["context_value"].get<std::string>() == "context-after" );
}

#endif
