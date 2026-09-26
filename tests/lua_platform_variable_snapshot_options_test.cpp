#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <string>
#include <utility>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "global_vars.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "math_parser_diag_value.h"
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
