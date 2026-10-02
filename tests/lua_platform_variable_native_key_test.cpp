#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
#include <cmath>
#include <cstddef>
#include <functional>
#include <limits>
#include <optional>
#include <initializer_list>
#include <memory>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "global_vars.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "lua_platform_variables.h"
#include "math_parser.h"
#include "math_parser_diag_value.h"
#include "math_parser_type.h"
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

sol::table require_error( const sol::protected_function_result &call,
                          const std::string &expected_code )
{
    REQUIRE( call.valid() );
    const sol::table response = call;
    REQUIRE_FALSE( response["ok"].get<bool>() );
    const sol::table error = response["error"];
    CHECK( error["code"].get<std::string>() == expected_code );
    return error;
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
    const sol::protected_function get_string = fixture.variables["get_string"];
    const sol::protected_function get_number = fixture.variables["get_number"];
    const sol::protected_function get_tripoint = fixture.variables["get_tripoint"];
    const sol::protected_function set = fixture.variables["set"];
    const sol::protected_function remove = fixture.variables["remove"];
    const sol::protected_function get_global = fixture.variables["get_global"];
    const sol::protected_function set_global = fixture.variables["set_global"];
    const sol::protected_function remove_global = fixture.variables["remove_global"];
    const sol::protected_function copy = fixture.variables["copy"];
    const sol::protected_function resolve = fixture.variables["resolve"];
    const sol::protected_function set_resolved = fixture.variables["set_resolved"];
    sol::table context = fixture.lua.create_table();
    sol::table strict = fixture.lua.create_table();
    strict["strict"] = true;

    const std::vector<std::string> keys = native_boundary_keys();
    REQUIRE( keys[1].size() == 129 );
    REQUIRE( keys[2].size() == 129 );
    REQUIRE( keys[4].size() == 7 );
    for( const native_owner_case &owner : owners ) {
        for( std::size_t key_index = 0; key_index < keys.size(); ++key_index ) {
            const std::string &key = keys[key_index];
            INFO( "native owner: " << owner.name << ", key index: " << key_index <<
                  ", key bytes: " << key.size() );

            for( const double number : { -3.9, 0.0, 3.9, 2147483647.0, -2147483648.0 } ) {
                require_success( set( owner.handle, key, number ) );
                REQUIRE( owner.get( key ) != nullptr );
                const double expected = owner.get( key )->dbl();
                CHECK( require_value( get_number( owner.handle, key ) )["value"].get<double>() == expected );
                CHECK( require_value( get_number( owner.handle, key, strict ) )["value"].get<double>() == expected );
            }
            for( const tripoint &position : { tripoint::zero, tripoint( -25, 49, -3 ),
                                             tripoint( std::numeric_limits<int>::min(),
                                                       std::numeric_limits<int>::max(), 0 ) } ) {
                require_success( set( owner.handle, key, cata::lua_platform::script_tripoint_coord::from_native(
                                          coords::origin::abs, coords::scale::map_square, position ) ) );
                REQUIRE( owner.get( key ) != nullptr );
                const sol::table result = require_value( get_tripoint( owner.handle, key ) );
                CHECK( result["exists"].get<bool>() );
                CHECK( result["value"].get<cata::lua_platform::script_tripoint_coord>().to_native() ==
                       owner.get( key )->tripoint().raw() );
            }
            const std::string owner_value = std::string( "owner-" ) + owner.name;
            require_success( set( owner.handle, key, owner_value ) );
            REQUIRE( owner.get( key ) != nullptr );
            CHECK( owner.get( key )->str() == owner_value );
            CHECK( require_value( get( owner.handle, key ) )["value"].get<std::string>() ==
                   owner_value );
            CHECK( require_value( get_string( owner.handle, key ) )["value"].get<std::string>() ==
                   owner_value );

            const std::string long_value = std::string( "native\0string", 13 ) +
                                           std::string( 10000, 'v' );
            require_success( set( owner.handle, key, long_value ) );
            CHECK( require_value( get_string( owner.handle, key ) )["value"].get<std::string>() ==
                   long_value );
            require_success( set( owner.handle, key, owner_value ) );

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
            const sol::table missing_owner = require_value( get_string( owner.handle, key ) );
            CHECK_FALSE( missing_owner["exists"].get<bool>() );
            CHECK( missing_owner["value"].get<sol::object>().get_type() == sol::type::nil );
            const sol::table removed_global = require_value( remove_global( key ) );
            CHECK( removed_global["removed"].get<bool>() );
            CHECK( get_globals().maybe_get_global_value( key ) == nullptr );
        }
    }
}

TEST_CASE( "lua_platform_variable_string_reads_preserve_handle_errors",
           "[lua][platform][semantic][variables]" )
{
    avatar player;
    player.normalize();
    player.setID( character_id( 4913 ), true );
    variable_api_fixture fixture;
    const sol::protected_function get_string = fixture.variables["get_string"];
    const sol::protected_function get_tripoint = fixture.variables["get_tripoint"];
    const game_handle current = cata::lua_platform::game_handle::from_creature(
                                    player, { "avatar", player.getID().get_value(), 0, 0, 0, {} },
                                    fixture.runtime, 1 );
    const game_handle wrong_kind;
    require_error( get_string( wrong_kind, "key" ), "wrong_kind" );
    require_error( get_tripoint( wrong_kind, "key" ), "wrong_kind" );

    const game_handle_runtime stale_runtime( fixture.runtime_owner, 2 );
    const game_handle stale = cata::lua_platform::game_handle::from_creature(
                                  player, { "avatar", player.getID().get_value(), 0, 0, 0, {} },
                                  stale_runtime, 1 );
    require_error( get_string( stale, "key" ), "stale_runtime" );
    require_error( get_tripoint( stale, "key" ), "stale_runtime" );

    item item_value( itype_id( "rock" ) );
    item_identity_cleanup retire_item{ item_value };
    const game_handle item_handle = cata::lua_platform::game_handle::from_item(
                                        item_value, { "character_inventory", item_value.uid().get_value(), 0, 0, 0, {} },
                                        fixture.runtime, 1 );
    cata::lua_platform::retire_item_handle_identity( item_value );
    require_error( get_string( item_handle, "key" ), "stale_item" );
    require_error( get_tripoint( item_handle, "key" ), "stale_item" );
    CHECK_FALSE( current.validation_error( fixture.runtime, 1 ) );
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

TEST_CASE( "lua_platform_strict_numeric_reads_distinguish_type_failure_missing_and_zero",
           "[lua][platform][semantic][variables][math]" )
{
    global_values_restore restore_global_values;
    variable_api_fixture fixture;
    const sol::protected_function read_global = fixture.variables["get_global_number"];
    const sol::protected_function read_context = fixture.variables["get_context_number"];
    const sol::protected_function read_owner = fixture.variables["get_number"];
    sol::table strict = fixture.lua.create_table();
    strict["strict"] = true;
    sol::table permissive = fixture.lua.create_table();
    permissive["strict"] = false;
    const auto make_value = []( const int shape ) -> std::optional<diag_value> {
        switch( shape ) {
            case 0: return std::nullopt;
            case 1: return diag_value{};
            case 2: return diag_value( 0.0 );
            case 3: return diag_value( -3.9 );
            case 4: return diag_value( std::string( "7.9" ) );
            case 5: return diag_value( diag_array( 5000, diag_value( 4.0 ) ) );
            case 6: return diag_value( tripoint_abs_ms( -3, 4, 5 ) );
            case 7: return diag_value( diag_value::legacy_value( "7.9" ) );
            default: return diag_value( diag_value::legacy_value( "not-a-number" ) );
        }
    };
    const std::vector<std::string> keys = { "", std::string( 10000, 'k' ), std::string( "raw\0key", 7 ) };
    for( const bool context_scope : { false, true } ) {
        for( const std::string &key : keys ) {
            for( int shape = 0; shape < ( context_scope ? 7 : 9 ); ++shape ) {
                CAPTURE( context_scope, key.size(), shape );
                const std::optional<diag_value> native_value = make_value( shape );
                double expected = 0.0;
                std::string type_error;
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    if( native_value ) {
                        try {
                            expected = native_value->dbl( const_dialogue{} );
                        } catch( const math::exception &error ) {
                            type_error = error.what();
                        }
                    }
                } );
                get_globals().remove_global_value( key );
                sol::table data = fixture.lua.create_table();
                if( context_scope ) {
                    if( shape == 1 ) {
                        data.raw_set( key, fixture.services["types"]["null"].get<sol::object>() );
                    } else if( shape == 2 || shape == 3 ) {
                        data.raw_set( key, native_value->dbl() );
                    } else if( shape == 4 ) {
                        data.raw_set( key, native_value->str() );
                    } else if( shape == 5 ) {
                        // Contents need not be convertible or acyclic: only
                        // the native outer array type determines this error.
                        sol::table cycle = fixture.lua.create_table();
                        cycle["self"] = cycle;
                        data.raw_set( key, cycle );
                    } else if( shape == 6 ) {
                        data.raw_set( key, cata::lua_platform::script_tripoint_coord::from_native(
                                          coords::origin::abs, coords::scale::map_square,
                                          native_value->tripoint().raw() ) );
                    }
                } else if( native_value ) {
                    // Legacy conversion caches belong to each independent
                    // comparison; do not reuse the oracle's converted value.
                    get_globals().set_global_value( key, *make_value( shape ) );
                }
                sol::protected_function_result call;
                const std::string actual_diagnostic = capture_debugmsg_during( [&]() {
                    call = context_scope ? read_context( data, key, strict ) : read_global( key, strict );
                } );
                CHECK( actual_diagnostic == native_diagnostic );
                if( type_error.empty() ) {
                    const sol::table value = require_value( call );
                    CHECK( value["exists"].get<bool>() == native_value.has_value() );
                    if( native_value ) {
                        CHECK( value["value"].get<double>() == expected );
                    } else {
                        CHECK( value["value"].get<sol::object>().get_type() == sol::type::nil );
                    }
                } else {
                    const sol::table error = require_error( call, "variable_type_mismatch" );
                    CHECK( error["message"].get<std::string>() == type_error );
                    CHECK( actual_diagnostic.empty() );
                    // Existing callers retain the diagnostic-and-zero mode.
                    const std::string permissive_diagnostic = capture_debugmsg_during( [&]() {
                        const sol::table value = context_scope ? require_value( read_context( data, key, permissive ) ) :
                                                 require_value( read_global( key, permissive ) );
                        CHECK( value["exists"].get<bool>() );
                        CHECK( value["value"].get<double>() == 0.0 );
                    } );
                    CHECK_FALSE( permissive_diagnostic.empty() );
                }
            }
        }
    }
    sol::table data = fixture.lua.create_table();
    for( const bool flag : { false, true } ) {
        data["flag"] = flag;
        CHECK( require_value( read_context( data, "flag", strict ) )["value"].get<double>() ==
               ( flag ? 1.0 : 0.0 ) );
    }
    CHECK_FALSE( require_value( read_context( sol::nil, "missing", strict ) )["exists"].get<bool>() );
    require_error( read_owner( game_handle{}, "key", strict ), "wrong_kind" );
    avatar alpha;
    alpha.normalize();
    alpha.setID( character_id( 4913 ), true );
    const game_handle owner = game_handle::from_creature(
                                 alpha, { "avatar", alpha.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    CHECK_FALSE( require_value( read_owner( owner, "missing", strict ) )["exists"].get<bool>() );
    alpha.set_value( "wrong", diag_value( std::string( "9" ) ) );
    require_error( read_owner( owner, "wrong", strict ), "variable_type_mismatch" );
    const game_handle_runtime old_generation( fixture.runtime_owner, 2 );
    const game_handle stale = game_handle::from_creature(
                                 alpha, { "avatar", alpha.getID().get_value(), 0, 0, 0, {} }, old_generation, 1 );
    require_error( read_owner( stale, "wrong", strict ), "stale_runtime" );
    for( const sol::object &bad : {
             sol::make_object( fixture.lua, 1.0 ), sol::make_object( fixture.lua, "true" ),
             sol::make_object( fixture.lua, fixture.lua.create_table() )
         } ) {
        sol::table options = fixture.lua.create_table();
        options["strict"] = bad;
        CHECK_FALSE( read_global( "missing", options ).valid() );
        CHECK_FALSE( read_context( data, "missing", options ).valid() );
        CHECK_FALSE( read_owner( game_handle{}, "missing", options ).valid() );
    }
}

TEST_CASE( "native_invalid_legacy_number_diagnostic_names_value_and_requested_type",
           "[lua][platform][semantic][variables][math]" )
{
    for( const bool strict : { false, true } ) {
        diag_value stored( diag_value::legacy_value( "not-a-number" ) );
        const std::string diagnostic = capture_debugmsg_during( [&]() {
            // Native legacy conversion uses its diagnostic-and-zero path even
            // inside a strict read; each independent value owns its cache.
            CHECK( ( strict ? stored.dbl( const_dialogue{} ) : stored.dbl() ) == 0.0 );
        } );
        CHECK( diagnostic.find( "Could not convert legacy value \"not-a-number\" to a double" ) !=
               std::string::npos );
    }
}

TEST_CASE( "lua_platform_numeric_variable_duration_matches_native_presence_and_conversion",
           "[lua][platform][semantic][variables][time]" )
{
    global_values_restore restore_global_values;
    variable_api_fixture fixture;
    const sol::protected_function read_global = fixture.variables["get_global_number"];
    const sol::protected_function read_context = fixture.variables["get_context_number"];
    const sol::protected_function duration = fixture.services["time"]["duration_from_turns"];
    const std::string key = std::string( 300, 'k' ) + '\0' + "tail";
    const std::vector<std::optional<diag_value>> values = {
        std::nullopt, diag_value{}, diag_value( 0.0 ), diag_value( 3.9 ), diag_value( -3.9 ),
        diag_value( 2147483647.75 ), diag_value( -2147483648.75 ),
        diag_value( std::string( "3.9" ) ), diag_value( diag_array( 5000, diag_value( 4.0 ) ) ),
        diag_value( tripoint_abs_ms( 3, 4, 5 ) ),
        diag_value( diag_value::legacy_value( "-3.9" ) ),
        diag_value( diag_value::legacy_value( "not-a-number" ) ),
    };
    for( const bool context_scope : { false, true } ) {
        for( const int fallback : { 0, 7, calendar::INDEFINITELY_LONG } ) {
            for( std::size_t i = 0; i < values.size(); ++i ) {
                if( context_scope && i >= 10 ) {
                    continue; // Lua callback values do not have a legacy-string type.
                }
                CAPTURE( context_scope, fallback, i );
                dialogue conversation;
                get_globals().remove_global_value( key );
                if( values[i] ) {
                    if( context_scope ) {
                        conversation.set_value( key, *values[i] );
                    } else {
                        get_globals().set_global_value( key, *values[i] );
                    }
                }
                std::ostringstream input;
                JsonOut writer( input );
                writer.start_object();
                writer.member( context_scope ? "context_val" : "global_val", key );
                writer.member( "default", fallback );
                writer.end_object();
                duration_or_var native;
                native.deserialize( json_loader::from_string( input.str() ) );
                time_duration expected;
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    expected = native.evaluate( conversation );
                } );
                sol::table data = fixture.lua.create_table();
                if( context_scope && values[i] ) {
                    if( i == 1 ) {
                        data.raw_set( key, fixture.services["types"]["null"].get<sol::object>() );
                    } else if( values[i]->is_dbl() ) {
                        data.raw_set( key, values[i]->dbl() );
                    } else if( values[i]->is_str() ) {
                        data.raw_set( key, values[i]->str() );
                    } else if( values[i]->is_array() ) {
                        sol::table oversized = fixture.lua.create_table();
                        for( int entry = 1; entry <= 5000; ++entry ) {
                            oversized[entry] = 4.0;
                        }
                        data.raw_set( key, oversized );
                    } else {
                        data.raw_set( key, cata::lua_platform::script_tripoint_coord::from_native(
                                          coords::origin::abs, coords::scale::map_square,
                                          values[i]->tripoint().raw() ) );
                    }
                } else if( !context_scope && values[i] ) {
                    // Reset the legacy conversion cache before the second path.
                    get_globals().set_global_value( key, *values[i] );
                }
                time_duration actual;
                const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                    const sol::table result = context_scope ? require_value( read_context( data, key ) ) :
                                              require_value( read_global( key ) );
                    CHECK( result["exists"].get<bool>() == values[i].has_value() );
                    if( !result["exists"].get<bool>() ) {
                        CHECK( result["value"].get<sol::object>().get_type() == sol::type::nil );
                        actual = time_duration::from_turns( fallback );
                    } else {
                        const sol::protected_function_result converted = duration( result["value"].get<double>() );
                        REQUIRE( converted.valid() );
                        actual = converted.get<cata::lua_platform::script_time_duration>().to_native();
                    }
                } );
                CHECK( actual == expected );
                CHECK( platform_diagnostic == native_diagnostic );
            }
        }
    }
    sol::table data = fixture.lua.create_table();
    data[key] = true;
    CHECK( require_value( read_context( data, key ) )["value"].get<double>() == diag_value( true ).dbl() );
    data[key] = false;
    CHECK( require_value( read_context( data, key ) )["value"].get<double>() == diag_value( false ).dbl() );
    const sol::table missing = require_value( read_context( sol::nil, key ) );
    CHECK_FALSE( missing["exists"].get<bool>() );
    for( const double bad : { std::numeric_limits<double>::infinity(),
                             -std::numeric_limits<double>::infinity(),
                             std::numeric_limits<double>::quiet_NaN(), 2147483648.0, -2147483649.0 } ) {
        CAPTURE( bad );
        const sol::protected_function_result rejected = duration( bad );
        CHECK_FALSE( rejected.valid() );
    }
}

TEST_CASE( "lua_platform_coordinate_variable_reads_match_native_types_presence_and_projection",
           "[lua][platform][semantic][variables][coords]" )
{
    global_values_restore restore_global_values;
    avatar alpha;
    avatar beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 4925 ), true );
    beta.setID( character_id( 4926 ), true );
    variable_api_fixture fixture;
    const game_handle alpha_handle = game_handle::from_creature(
                                         alpha, { "avatar", alpha.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    const game_handle beta_handle = game_handle::from_creature(
                                        beta, { "avatar", beta.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    const sol::protected_function read_owner = fixture.variables["get_tripoint"];
    const sol::protected_function read_global = fixture.variables["get_global_tripoint"];
    const sol::protected_function read_context = fixture.variables["get_context_tripoint"];
    const tripoint negative( -25, 49, -3 );
    const std::vector<std::optional<diag_value>> values = {
        std::nullopt, diag_value{}, diag_value( tripoint_abs_ms( negative ) ),
        diag_value( tripoint_abs_ms( std::numeric_limits<int>::min(),
                                   std::numeric_limits<int>::max(), 0 ) ),
        diag_value( 3.9 ), diag_value( true ), diag_value( negative.to_string() ),
        diag_value( diag_array( 5000, diag_value( 4.0 ) ) ),
        diag_value( diag_value::legacy_value( negative.to_string() ) ),
        diag_value( diag_value::legacy_value( "not-a-coordinate" ) ),
    };
    for( const var_type scope : { var_type::u, var_type::npc, var_type::global, var_type::context } ) {
        for( const std::string &key : { std::string{}, std::string( "raw\0tail", 8 ),
                                       std::string( 10000, 'k' ), std::string( "坐标" ) } ) {
            for( std::size_t index = 0; index < values.size(); ++index ) {
                if( scope == var_type::context && index >= 8 ) {
                    continue; // Callback Lua strings do not have a legacy storage type.
                }
                CAPTURE( scope, key.size(), index );
                dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
                sol::table data = fixture.lua.create_table();
                const auto reset_storage = [&]() {
                    alpha.remove_value( key );
                    beta.remove_value( key );
                    get_globals().remove_global_value( key );
                    if( values[index] ) {
                        switch( scope ) {
                            case var_type::u:
                                alpha.set_value( key, *values[index] );
                                break;
                            case var_type::npc:
                                beta.set_value( key, *values[index] );
                                break;
                            case var_type::global:
                                get_globals().set_global_value( key, *values[index] );
                                break;
                            default:
                                conversation.set_value( key, *values[index] );
                                break;
                        }
                    }
                };
                reset_storage();
                const var_info info{ scope, key };
                tripoint_abs_ms expected;
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    expected = read_var_value( info, conversation ).tripoint();
                } );
                reset_storage(); // Do not reuse a Native legacy conversion cache as evidence.
                if( scope == var_type::context && values[index] ) {
                    if( index == 1 ) {
                        data.raw_set( key, fixture.services["types"]["null"].get<sol::object>() );
                    } else if( index == 5 ) {
                        data.raw_set( key, true );
                    } else if( values[index]->is_dbl() ) {
                        data.raw_set( key, values[index]->dbl() );
                    } else if( values[index]->is_str() ) {
                        data.raw_set( key, values[index]->str() );
                    } else if( values[index]->is_array() ) {
                        sol::table oversized = fixture.lua.create_table();
                        for( int entry = 1; entry <= 5000; ++entry ) {
                            oversized[entry] = 4.0;
                        }
                        data.raw_set( key, oversized );
                    } else {
                        data.raw_set( key, cata::lua_platform::script_tripoint_coord::from_native(
                                          coords::origin::abs, coords::scale::map_square, values[index]->tripoint().raw() ) );
                    }
                }
                tripoint actual;
                const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                    const sol::table result = scope == var_type::context ? require_value( read_context( data, key ) ) :
                                              scope == var_type::global ? require_value( read_global( key ) ) :
                                              require_value( read_owner( scope == var_type::u ? alpha_handle : beta_handle, key ) );
                    CHECK( result["exists"].get<bool>() == values[index].has_value() );
                    if( result["exists"].get<bool>() ) {
                        const auto coordinate = result["value"].get<cata::lua_platform::script_tripoint_coord>();
                        CHECK( coordinate.native_origin() == coords::origin::abs );
                        CHECK( coordinate.native_scale() == coords::scale::map_square );
                        actual = coordinate.to_native();
                        CHECK( coordinate.project_to( "omt" ).to_native() ==
                               project_to<coords::omt>( expected ).raw() );
                    } else {
                        CHECK( result["value"].get<sol::object>().get_type() == sol::type::nil );
                        actual = tripoint::zero; // Native read_var_value missing -> monostate -> zero.
                    }
                } );
                CHECK( actual == expected.raw() );
                CHECK( platform_diagnostic == native_diagnostic );
            }
        }
    }
    sol::table invalid = fixture.lua.create_table();
    for( const auto &coordinate : {
             cata::lua_platform::script_tripoint_coord::from_native(
                 coords::origin::abs, coords::scale::overmap_terrain, negative ),
             cata::lua_platform::script_tripoint_coord::from_native(
                 coords::origin::relative, coords::scale::map_square, negative ) } ) {
        invalid["key"] = coordinate;
        CHECK_FALSE( read_context( invalid, "key" ).valid() );
    }
    const sol::table missing = require_value( read_context( sol::nil, "key" ) );
    CHECK_FALSE( missing["exists"].get<bool>() );
}

TEST_CASE( "lua_platform_indirect_numeric_duration_matches_native_participants_and_pointer_types",
           "[lua][platform][semantic][variables][time]" )
{
    global_values_restore restore_global_values;
    avatar alpha;
    avatar beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 4921 ), true );
    beta.setID( character_id( 4922 ), true );
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::string );
    fixture.lua["services"] = fixture.services;
    fixture.lua["alpha"] = game_handle::from_creature(
                              alpha, { "avatar", alpha.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    fixture.lua["beta"] = game_handle::from_creature(
                             beta, { "avatar", beta.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    // The migration tool tests execute the generated expression. Here the
    // same one-pass operation calls real registered APIs against Native
    // duration_or_var, including diagnostics and unrelated large arrays.
    const sol::protected_function_result loaded = fixture.lua.safe_script( R"(
        local function value(result) assert(result.ok); return result.value end
        function read_duration(data, pointer_key, fallback)
            local pointer = value(services.variables.get_context_string(data, pointer_key))
            if pointer.exists == false then return services.time.duration(fallback, "turn") end
            local text, result = pointer.value
            if string.sub(text, 1, 2) == "u_" then
                result = value(services.variables.get_number(alpha, string.sub(text, 3)))
            elseif string.sub(text, 1, 2) == "n_" then
                result = value(services.variables.get_number(beta, string.sub(text, 3)))
            elseif string.sub(text, 1, 1) == "_" then
                result = value(services.variables.get_context_number(data, string.sub(text, 2)))
            else
                result = value(services.variables.get_global_number(text))
            end
            if result.exists == false then return services.time.duration(fallback, "turn") end
            return services.time.duration_from_turns(result.value)
        end
    )", sol::script_pass_on_error );
    REQUIRE( loaded.valid() );
    const sol::protected_function read_duration = fixture.lua["read_duration"];
    const std::string pointer_key = std::string( "pointer\0", 8 ) + std::string( 300, 'p' );
    const std::string raw_key = std::string( "raw\0tail", 8 );
    const std::vector<std::optional<diag_value>> pointers = {
        std::nullopt, diag_value{}, diag_value( 12.0 ),
        diag_value( diag_array( 5000, diag_value( 4.0 ) ) ),
        diag_value( "u_key" ), diag_value( "n_key" ), diag_value( "_key" ), diag_value( "key" ),
        diag_value( "u_" ), diag_value( "n_" ), diag_value( "_" ), diag_value( "" ),
        diag_value( "var_next" ), diag_value( "u_" + raw_key ),
        diag_value( std::string( 10000, 'k' ) ),
    };
    for( std::size_t index = 0; index < pointers.size(); ++index ) {
        for( const bool present : { false, true } ) {
            for( const int fallback : { -7, calendar::INDEFINITELY_LONG } ) {
                CAPTURE( index, present, fallback );
                dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
                sol::table data = fixture.lua.create_table();
                for( const std::string &key : { std::string( "key" ), std::string{}, raw_key,
                                               std::string( "var_next" ), std::string( 10000, 'k' ) } ) {
                    alpha.remove_value( key );
                    beta.remove_value( key );
                    get_globals().remove_global_value( key );
                    if( present ) {
                        // Distinct values detect accidental scope/owner fallback.
                        alpha.set_value( key, diag_value( 3.9 ) );
                        beta.set_value( key, diag_value( -4.9 ) );
                        conversation.set_value( key, diag_value( 5.9 ) );
                        data.raw_set( key, 5.9 );
                        get_globals().set_global_value( key, diag_value( -6.9 ) );
                    }
                }
                if( pointers[index] ) {
                    conversation.set_value( pointer_key, *pointers[index] );
                    if( index == 1 ) {
                        data.raw_set( pointer_key, fixture.services["types"]["null"].get<sol::object>() );
                    } else if( pointers[index]->is_dbl() ) {
                        data.raw_set( pointer_key, pointers[index]->dbl() );
                    } else if( pointers[index]->is_array() ) {
                        sol::table oversized = fixture.lua.create_table();
                        for( int entry = 1; entry <= 5000; ++entry ) {
                            oversized[entry] = 4.0;
                        }
                        data.raw_set( pointer_key, oversized );
                    } else {
                        data.raw_set( pointer_key, pointers[index]->str() );
                    }
                }
                std::ostringstream input;
                JsonOut writer( input );
                writer.start_object();
                writer.member( "var_val", pointer_key );
                writer.member( "default", fallback );
                writer.end_object();
                duration_or_var native;
                native.deserialize( json_loader::from_string( input.str() ) );
                time_duration expected;
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    expected = native.evaluate( conversation );
                } );
                time_duration actual;
                const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                    const sol::protected_function_result converted = read_duration( data, pointer_key, fallback );
                    REQUIRE( converted.valid() );
                    actual = converted.get<cata::lua_platform::script_time_duration>().to_native();
                } );
                CHECK( actual == expected );
                CHECK( platform_diagnostic == native_diagnostic );
            }
        }
    }
}

TEST_CASE( "lua_platform_coordinate_reflection_matches_native_variable_scopes",
           "[lua][platform][semantic][variables][coords]" )
{
    global_values_restore restore_global_values;
    avatar alpha;
    avatar beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 4927 ), true );
    beta.setID( character_id( 4928 ), true );
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::string );
    fixture.lua["services"] = fixture.services;
    fixture.lua["alpha"] = game_handle::from_creature(
                               alpha, { "avatar", alpha.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    fixture.lua["beta"] = game_handle::from_creature(
                              beta, { "avatar", beta.getID().get_value(), 0, 0, 0, {} }, fixture.runtime, 1 );
    REQUIRE( fixture.lua.safe_script( R"(
        local variables = services.variables
        local function value(result) assert(result.ok); return result.value end
        local function target(scope, key, data)
            if scope ~= 'var_val' then return scope, key end
            local pointer = value(variables.get_context_string(data, key))
            local text = pointer.exists == false and '' or pointer.value
            if string.sub(text, 1, 2) == 'u_' then return 'u_val', string.sub(text, 3) end
            if string.sub(text, 1, 2) == 'n_' then return 'npc_val', string.sub(text, 3) end
            if string.sub(text, 1, 1) == '_' then return 'context_val', string.sub(text, 2) end
            return 'global_val', text
        end
        function reflect_variables(center_scope, center_key, output_scope, output_key, data)
            local scope, key = target(center_scope, center_key, data)
            local read
            if scope == 'context_val' then read = value(variables.get_context_tripoint(data, key))
            elseif scope == 'global_val' then read = value(variables.get_global_tripoint(key))
            else read = value(variables.get_tripoint(scope == 'u_val' and alpha or beta, key)) end
            local center = read.exists and read.value or services.coords.tripoint_abs_ms(0, 0, 0)
            local relative = value(variables.get_context_tripoint(data, 'relative')).value
            local reflected = relative:mirror_around(center)
            scope, key = target(output_scope, output_key, data)
            if scope == 'context_val' then data[key] = reflected
            elseif scope == 'global_val' then
                value(variables.set_global(key, reflected, {include_before = false}))
            else
                value(variables.set(scope == 'u_val' and alpha or beta, key, reflected,
                    {include_before = false}))
            end
            return reflected
        end
    )", sol::script_pass_on_error ).valid() );
    const sol::protected_function reflect = fixture.lua["reflect_variables"];
    const std::array<std::pair<const char *, var_type>, 5> scopes = {{
            { "u_val", var_type::u }, { "npc_val", var_type::npc },
            { "global_val", var_type::global }, { "context_val", var_type::context },
            { "var_val", var_type::var }
        }};
    for( const auto &center_scope : scopes ) {
        for( const auto &output_scope : scopes ) {
            for( const std::string &suffix : { std::string{}, std::string( "raw\0tail", 8 ),
                                              std::string( 10000, 'k' ) } ) {
                CAPTURE( center_scope.first, output_scope.first, suffix.size() );
                dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
                const std::string center_key = "center" + suffix;
                const std::string output_key = "output" + suffix;
                conversation.set_value( center_key, diag_value( "n_" + center_key ) );
                conversation.set_value( output_key, diag_value( "n_" + output_key ) );
                // Direct context coordinates and indirect pointers occupy the same key
                // only in their respective cases; never infer a second pointer hop.
                const var_type center_owner = center_scope.second == var_type::var ? var_type::npc :
                                              center_scope.second;
                const var_type output_owner = output_scope.second == var_type::var ? var_type::npc :
                                              output_scope.second;
                write_var_value( center_owner, center_key, &conversation,
                                 diag_value( tripoint_abs_ms( 3, 4, -1 ) ) );
                write_var_value( output_owner, output_key, &conversation,
                                 diag_value( diag_array( 5000, diag_value( 4.0 ) ) ) );
                conversation.set_value( "relative", diag_value( tripoint_abs_ms( 11, -2, 8 ) ) );
                sol::table data = fixture.lua.create_table();
                if( center_scope.second == var_type::context ) {
                    data.raw_set( center_key, cata::lua_platform::script_tripoint_coord::from_native(
                                      coords::origin::abs, coords::scale::map_square, tripoint( 3, 4, -1 ) ) );
                } else if( center_scope.second == var_type::var ) {
                    data.raw_set( center_key, "n_" + center_key );
                }
                if( output_scope.second == var_type::var ) {
                    data.raw_set( output_key, "n_" + output_key );
                } else if( output_scope.second == var_type::context ) {
                    sol::table old = fixture.lua.create_table();
                    for( int index = 1; index <= 5000; ++index ) {
                        old[index] = 4.0;
                    }
                    data.raw_set( output_key, old );
                }
                data["relative"] = cata::lua_platform::script_tripoint_coord::from_native(
                                       coords::origin::abs, coords::scale::map_square, tripoint( 11, -2, 8 ) );
                std::ostringstream input;
                {
                    JsonOut writer( input );
                    writer.start_object();
                    writer.member( "mirror_coordinates" );
                    writer.start_object();
                    writer.member( output_scope.first, output_key );
                    writer.end_object();
                    writer.member( "center_var" );
                    writer.start_object();
                    writer.member( center_scope.first, center_key );
                    writer.end_object();
                    writer.member( "relative_var" );
                    writer.start_object();
                    writer.member( "context_val", "relative" );
                    writer.end_object();
                    writer.end_object();
                }
                talk_effect_t native_effect;
                native_effect.parse_sub_effect( json_loader::from_string( input.str() ).get_object(),
                                                "mirror_coordinate_scope_comparison" );
                for( const talk_effect_fun_t &effect : native_effect.effects ) {
                    effect( conversation );
                }
                const tripoint expected = read_var_value( { output_owner, output_key }, conversation ).tripoint().raw();
                CHECK( expected == tripoint( -5, 10, -10 ) );
                write_var_value( output_owner, output_key, &conversation,
                                 diag_value( diag_array( 5000, diag_value( 4.0 ) ) ) );
                const sol::protected_function_result call = reflect(
                            center_scope.first, center_key, output_scope.first, output_key, data );
                REQUIRE( call.valid() );
                CHECK( call.get<cata::lua_platform::script_tripoint_coord>().to_native() == expected );
                const tripoint stored = output_owner == var_type::context ?
                                        data.raw_get<cata::lua_platform::script_tripoint_coord>( output_key ).to_native() :
                                        read_var_value( { output_owner, output_key }, conversation ).tripoint().raw();
                CHECK( stored == expected );
            }
        }
    }
}

TEST_CASE( "lua_platform_registered_reflection_rejects_frame_and_range_errors",
           "[lua][platform][semantic][coords]" )
{
    variable_api_fixture fixture;
    fixture.lua["services"] = fixture.services;
    REQUIRE( fixture.lua.safe_script( R"(
        function reflect(relative, center) return relative:mirror_around(center) end
        local minimum, maximum = -2147483648, 2147483647
        local source = services.coords.tripoint_abs_ms(minimum, maximum, minimum)
        local result = reflect(source, source)
        assert(result.x == minimum and result.y == maximum and result.z == minimum)
    )", sol::script_pass_on_error ).valid() );
    const sol::protected_function reflect = fixture.lua["reflect"];
    const auto coordinate = []( coords::origin origin, coords::scale scale, tripoint raw ) {
        return cata::lua_platform::script_tripoint_coord::from_native( origin, scale, raw );
    };
    const auto zero = coordinate( coords::origin::abs, coords::scale::map_square, tripoint::zero );
    CHECK_FALSE( reflect( zero, coordinate( coords::origin::relative,
                                           coords::scale::map_square, tripoint::zero ) ).valid() );
    CHECK_FALSE( reflect( zero, coordinate( coords::origin::abs,
                                           coords::scale::overmap_terrain, tripoint::zero ) ).valid() );
    CHECK_FALSE( reflect( coordinate( coords::origin::abs, coords::scale::map_square,
                                     tripoint( std::numeric_limits<int>::min(), 0, 0 ) ), zero ).valid() );
}

TEST_CASE( "lua_platform_location_adjust_matches_native_fractional_units_and_missing_coordinates",
           "[lua][platform][semantic][variables][coords]" )
{
    global_values_restore restore_global_values;
    avatar alpha;
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::math );
    fixture.lua["services"] = fixture.services;
    REQUIRE( fixture.lua.safe_script( R"(
        local function value(result) assert(result.ok); return result.value end
        function adjust_location(key, x, y, z, overmap, override, data)
            local function truncate_axis(number)
                assert(number == number and number ~= math.huge and number ~= -math.huge)
                local axis = math.modf(number)
                assert(axis >= -2147483648 and axis <= 2147483647)
                return axis
            end
            local read = value(services.variables.get_global_tripoint(key))
            local location = read.exists and read.value or services.coords.tripoint_abs_ms(0, 0, 0)
            local factor = overmap and services.coords.tripoint_rel_omt(1, 0, 0):to('ms').x or 1
            location = location:add(services.coords.tripoint_rel_ms(
                truncate_axis(x * factor), truncate_axis(y * factor), 0))
            z = truncate_axis(z)
            if override then location = services.coords.tripoint_abs_ms(location.x, location.y, z)
            else location = location:add(services.coords.tripoint_rel_ms(0, 0, z)) end
            data.result = location
            return location
        end
    )", sol::script_pass_on_error ).valid() );
    const sol::protected_function adjust = fixture.lua["adjust_location"];
    struct adjustment_case {
        double x;
        double y;
        double z;
        bool overmap;
        bool override_z;
        tripoint expected_offset;
    };
    const std::array<adjustment_case, 6> cases = {{
            { -1.7, 2.7, -0.7, false, false, tripoint( -1, 2, 0 ) },
            { -1.7, 2.7, -0.7, true, false, tripoint( -40, 64, 0 ) },
            { -1.7, 2.7, -0.7, true, true, tripoint( -40, 64, 0 ) },
            { 0.0, 0.0, 3.9, false, false, tripoint( 0, 0, 3 ) },
            { 0.0, 0.0, -3.9, false, true, tripoint( 0, 0, -3 ) },
            { 2147483647.9, -2147483648.9, 0.0, false, false,
              tripoint( std::numeric_limits<int>::max(), std::numeric_limits<int>::min(), 0 ) }
        }};
    const std::vector<std::optional<diag_value>> sources = {
        std::nullopt, diag_value{}, diag_value( tripoint_abs_ms( 0, 0, 5 ) ),
        diag_value( diag_value::legacy_value( tripoint( 0, 0, 5 ).to_string() ) )
    };
    for( const std::string &key : { std::string{}, std::string( "raw\0key", 7 ),
                                   std::string( 10000, 'k' ) } ) {
        for( std::size_t source_index = 0; source_index < sources.size(); ++source_index ) {
            for( const adjustment_case &adjustment : cases ) {
                CAPTURE( key.size(), source_index, adjustment.x, adjustment.y,
                         adjustment.z, adjustment.overmap, adjustment.override_z );
                const auto reset_source = [&]() {
                    get_globals().remove_global_value( key );
                    if( sources[source_index] ) {
                        get_globals().set_global_value( key, *sources[source_index] );
                    }
                };
                reset_source();
                dialogue conversation( get_talker_for( alpha ), nullptr );
                std::ostringstream input;
                {
                    JsonOut writer( input );
                    writer.start_object();
                    writer.member( "location_variable_adjust" );
                    writer.start_object();
                    writer.member( "global_val", key );
                    writer.end_object();
                    writer.member( "output_var" );
                    writer.start_object();
                    writer.member( "context_val", "result" );
                    writer.end_object();
                    writer.member( "x_adjust", adjustment.x );
                    writer.member( "y_adjust", adjustment.y );
                    writer.member( "z_adjust", adjustment.z );
                    writer.member( "overmap_tile", adjustment.overmap );
                    writer.member( "z_override", adjustment.override_z );
                    writer.end_object();
                }
                talk_effect_t native_effect;
                native_effect.parse_sub_effect( json_loader::from_string( input.str() ).get_object(),
                                                "location_adjust_coordinate_comparison" );
                for( const talk_effect_fun_t &effect : native_effect.effects ) {
                    effect( conversation );
                }
                const tripoint expected = conversation.get_value( "result" ).tripoint().raw();
                const int base_z = source_index >= 2 && !adjustment.override_z ? 5 : 0;
                CHECK( expected == tripoint( adjustment.expected_offset.x,
                                             adjustment.expected_offset.y, adjustment.expected_offset.z + base_z ) );
                reset_source(); // Read the original legacy value, not Native's conversion cache.
                sol::table data = fixture.lua.create_table();
                sol::table old = fixture.lua.create_table();
                for( int index = 1; index <= 5000; ++index ) {
                    old[index] = 4.0;
                }
                data["result"] = old;
                const sol::protected_function_result call = adjust(
                            key, adjustment.x, adjustment.y, adjustment.z,
                            adjustment.overmap, adjustment.override_z, data );
                REQUIRE( call.valid() );
                CHECK( call.get<cata::lua_platform::script_tripoint_coord>().to_native() == expected );
                CHECK( data["result"].get<cata::lua_platform::script_tripoint_coord>().to_native() == expected );
            }
        }
    }
    sol::table data = fixture.lua.create_table();
    for( const double invalid : { std::numeric_limits<double>::infinity(),
                                 std::numeric_limits<double>::quiet_NaN(), 2147483648.0, -2147483649.0 } ) {
        // Native floating-to-int conversion has no defined result here; reject
        // before writing rather than claiming parity with undefined behavior.
        data["result"] = "untouched";
        CHECK_FALSE( adjust( "missing", invalid, 0.0, 0.0, false, false, data ).valid() );
        CHECK( data["result"].get<std::string>() == "untouched" );
    }
}

TEST_CASE( "lua_platform_literal_arithmetic_matches_native_parser_binding_and_double_precision",
           "[lua][platform][semantic][coords][math]" )
{
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::math );
    struct arithmetic_case {
        const char *source;
        double expected;
        const char *lua_expression;
    };
    // These ordinary Lua expressions are captured migration output. Tool
    // regressions execute the current emitter; this oracle checks its Native
    // operator semantics without exposing the legacy parser to Mod authors.
    const std::vector<arithmetic_case> cases = {
        { "1 +2 * 3", 7.0, R"lua(
(function() local values = {};
values[1] = 1.0;
values[2] = 2.0;
values[3] = 3.0;
values[4] = values[2] * values[3];
values[5] = values[1] + values[4];
return values[5] end)()
)lua" },
        { "(1 + 2) * 3", 9.0, R"lua(
(function() local values = {};
values[1] = 1.0;
values[2] = 2.0;
values[3] = values[1] + values[2];
values[4] = 3.0;
values[5] = values[3] * values[4];
return values[5] end)()
)lua" },
        { "-2^2", 4.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = -(values[1]);
values[3] = 2.0;
values[4] = values[2] ^ values[3];
return values[4] end)()
)lua" },
        { "-(2^2)", -4.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = 2.0;
values[3] = values[1] ^ values[2];
values[4] = -(values[3]);
return values[4] end)()
)lua" },
        { "2^-2", 0.25, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = 2.0;
values[3] = -(values[2]);
values[4] = values[1] ^ values[3];
return values[4] end)()
)lua" },
        { "2^3^2", 512.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = 3.0;
values[3] = 2.0;
values[4] = values[2] ^ values[3];
values[5] = values[1] ^ values[4];
return values[5] end)()
)lua" },
        { "-5%2", -1.0, R"lua(
(function() local values = {};
values[1] = 5.0;
values[2] = -(values[1]);
values[3] = 2.0;
values[4] = math.fmod(values[2], values[3]);
return values[4] end)()
)lua" },
        { "5%-2", 1.0, R"lua(
(function() local values = {};
values[1] = 5.0;
values[2] = 2.0;
values[3] = -(values[2]);
values[4] = math.fmod(values[1], values[3]);
return values[4] end)()
)lua" },
        { "14%6%4", 0.0, R"lua(
(function() local values = {};
values[1] = 14.0;
values[2] = 6.0;
values[3] = 4.0;
values[4] = math.fmod(values[2], values[3]);
values[5] = math.fmod(values[1], values[4]);
return values[5] end)()
)lua" },
        { "14%6*4", 14.0, R"lua(
(function() local values = {};
values[1] = 14.0;
values[2] = 6.0;
values[3] = 4.0;
values[4] = values[2] * values[3];
values[5] = math.fmod(values[1], values[4]);
return values[5] end)()
)lua" },
        { "14*6%4", 0.0, R"lua(
(function() local values = {};
values[1] = 14.0;
values[2] = 6.0;
values[3] = values[1] * values[2];
values[4] = 4.0;
values[5] = math.fmod(values[3], values[4]);
return values[5] end)()
)lua" },
        { "+2--3", 5.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = values[1];
values[3] = 3.0;
values[4] = -(values[3]);
values[5] = values[2] - values[4];
return values[5] end)()
)lua" },
        { ".5 + 1.e1", 10.5, R"lua(
(function() local values = {};
values[1] = 0.5;
values[2] = 10.0;
values[3] = values[1] + values[2];
return values[3] end)()
)lua" },
        { "1\v+\f2", 3.0, R"lua(
(function() local values = {};
values[1] = 1.0;
values[2] = 2.0;
values[3] = values[1] + values[2];
return values[3] end)()
)lua" },
        { "9007199254740993 + 1", 9007199254740992.0, R"lua(
(function() local values = {};
values[1] = 9007199254740992.0;
values[2] = 1.0;
values[3] = values[1] + values[2];
return values[3] end)()
)lua" },
        { "(1e300 + 1e300) / 1e300", 2.0, R"lua(
(function() local values = {};
values[1] = 1.0000000000000001e+300;
values[2] = 1.0000000000000001e+300;
values[3] = values[1] + values[2];
values[4] = 1.0000000000000001e+300;
values[5] = values[3] / values[4];
return values[5] end)()
)lua" }
    };
    dialogue conversation;
    for( const arithmetic_case &row : cases ) {
        CAPTURE( row.source );
        math_exp native;
        REQUIRE( native.parse( row.source ) );
        const double expected = native.eval( conversation );
        CHECK( expected == row.expected );
        const sol::protected_function_result call = fixture.lua.safe_script(
                    std::string( "return " ) + row.lua_expression, sol::script_pass_on_error );
        REQUIRE( call.valid() );
        CHECK( call.get<double>() == expected );
    }
}

TEST_CASE( "lua_platform_literal_functions_match_native_math_values_and_signed_zero",
           "[lua][platform][semantic][coords][math]" )
{
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::math );
    struct function_case {
        const char *source;
        double expected;
        const char *lua_expression;
    };
    // Captured ordinary Lua migration output. Tool tests independently execute
    // the current emitter; the Native parser remains private to this oracle.
    const std::vector<function_case> cases = {
        { "abs(-3)", 3.0, R"lua(
(function() local values = {};
values[1] = 3.0;
values[2] = -(values[1]);
values[3] = math.abs(values[2]);
return values[3] end)()
)lua" },
        { "max()", 0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
return values[1] end)()
)lua" },
        { "min()", 0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
return values[1] end)()
)lua" },
        { "max(2,min(3,1+4),-1)", 3.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = 3.0;
values[3] = 1.0;
values[4] = 4.0;
values[5] = values[3] + values[4];
values[6] = values[2];
if values[5] < values[6] then values[6] = values[5] end;
values[7] = 1.0;
values[8] = -(values[7]);
values[9] = values[1];
if values[6] > values[9] then values[9] = values[6] end;
if values[8] > values[9] then values[9] = values[8] end;
return values[9] end)()
)lua" },
        { "-abs(-2)^2", 4.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = -(values[1]);
values[3] = math.abs(values[2]);
values[4] = -(values[3]);
values[5] = 2.0;
values[6] = values[4] ^ values[5];
return values[6] end)()
)lua" },
        { "floor(2.9)", 2.0, R"lua(
(function() local values = {};
values[1] = 2.8999999999999999;
values[2] = math.floor(values[1]) + 0.0;
if values[2] == 0.0 and 1.0 / values[1] < 0.0 then values[2] = -0.0 end;
return values[2] end)()
)lua" },
        { "floor(-2.9)", -3.0, R"lua(
(function() local values = {};
values[1] = 2.8999999999999999;
values[2] = -(values[1]);
values[3] = math.floor(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
return values[3] end)()
)lua" },
        { "ceil(2.1)", 3.0, R"lua(
(function() local values = {};
values[1] = 2.1000000000000001;
values[2] = math.ceil(values[1]) + 0.0;
if values[2] == 0.0 and 1.0 / values[1] < 0.0 then values[2] = -0.0 end;
return values[2] end)()
)lua" },
        { "ceil(-2.1)", -2.0, R"lua(
(function() local values = {};
values[1] = 2.1000000000000001;
values[2] = -(values[1]);
values[3] = math.ceil(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
return values[3] end)()
)lua" },
        { "trunc(2.9)", 2.0, R"lua(
(function() local values = {};
values[1] = 2.8999999999999999;
values[2] = math.modf(values[1]) + 0.0;
if values[2] == 0.0 and 1.0 / values[1] < 0.0 then values[2] = -0.0 end;
return values[2] end)()
)lua" },
        { "trunc(-2.9)", -2.0, R"lua(
(function() local values = {};
values[1] = 2.8999999999999999;
values[2] = -(values[1]);
values[3] = math.modf(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
return values[3] end)()
)lua" },
        { "round(2.5)", 3.0, R"lua(
(function() local values = {};
values[1] = 2.5;
values[2] = math.floor(math.abs(values[1])) + 0.0;
if math.abs(values[1]) - values[2] >= 0.5 then values[2] = values[2] + 1.0 end;
if values[1] < 0.0 or 1.0 / values[1] < 0.0 then values[2] = -values[2] end;
return values[2] end)()
)lua" },
        { "round(-2.5)", -3.0, R"lua(
(function() local values = {};
values[1] = 2.5;
values[2] = -(values[1]);
values[3] = math.floor(math.abs(values[2])) + 0.0;
if math.abs(values[2]) - values[3] >= 0.5 then values[3] = values[3] + 1.0 end;
if values[2] < 0.0 or 1.0 / values[2] < 0.0 then values[3] = -values[3] end;
return values[3] end)()
)lua" },
        { "round(0.49999999999999994)", 0.0, R"lua(
(function() local values = {};
values[1] = 0.49999999999999994;
values[2] = math.floor(math.abs(values[1])) + 0.0;
if math.abs(values[1]) - values[2] >= 0.5 then values[2] = values[2] + 1.0 end;
if values[1] < 0.0 or 1.0 / values[1] < 0.0 then values[2] = -values[2] end;
return values[2] end)()
)lua" },
        { "round(-0.49999999999999994)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.49999999999999994;
values[2] = -(values[1]);
values[3] = math.floor(math.abs(values[2])) + 0.0;
if math.abs(values[2]) - values[3] >= 0.5 then values[3] = values[3] + 1.0 end;
if values[2] < 0.0 or 1.0 / values[2] < 0.0 then values[3] = -values[3] end;
return values[3] end)()
)lua" },
        { "floor(9007199254740992)+floor(1)", 9007199254740992.0, R"lua(
(function() local values = {};
values[1] = 9007199254740992.0;
values[2] = math.floor(values[1]) + 0.0;
if values[2] == 0.0 and 1.0 / values[1] < 0.0 then values[2] = -0.0 end;
values[3] = 1.0;
values[4] = math.floor(values[3]) + 0.0;
if values[4] == 0.0 and 1.0 / values[3] < 0.0 then values[4] = -0.0 end;
values[5] = values[2] + values[4];
return values[5] end)()
)lua" },
        { "ceil(9007199254740992)+ceil(1)", 9007199254740992.0, R"lua(
(function() local values = {};
values[1] = 9007199254740992.0;
values[2] = math.ceil(values[1]) + 0.0;
if values[2] == 0.0 and 1.0 / values[1] < 0.0 then values[2] = -0.0 end;
values[3] = 1.0;
values[4] = math.ceil(values[3]) + 0.0;
if values[4] == 0.0 and 1.0 / values[3] < 0.0 then values[4] = -0.0 end;
values[5] = values[2] + values[4];
return values[5] end)()
)lua" },
        { "trunc(9007199254740992)+trunc(1)", 9007199254740992.0, R"lua(
(function() local values = {};
values[1] = 9007199254740992.0;
values[2] = math.modf(values[1]) + 0.0;
if values[2] == 0.0 and 1.0 / values[1] < 0.0 then values[2] = -0.0 end;
values[3] = 1.0;
values[4] = math.modf(values[3]) + 0.0;
if values[4] == 0.0 and 1.0 / values[3] < 0.0 then values[4] = -0.0 end;
values[5] = values[2] + values[4];
return values[5] end)()
)lua" },
        { "round(9007199254740992)+round(1)", 9007199254740992.0, R"lua(
(function() local values = {};
values[1] = 9007199254740992.0;
values[2] = math.floor(math.abs(values[1])) + 0.0;
if math.abs(values[1]) - values[2] >= 0.5 then values[2] = values[2] + 1.0 end;
if values[1] < 0.0 or 1.0 / values[1] < 0.0 then values[2] = -values[2] end;
values[3] = 1.0;
values[4] = math.floor(math.abs(values[3])) + 0.0;
if math.abs(values[3]) - values[4] >= 0.5 then values[4] = values[4] + 1.0 end;
if values[3] < 0.0 or 1.0 / values[3] < 0.0 then values[4] = -values[4] end;
values[5] = values[2] + values[4];
return values[5] end)()
)lua" },
        { "sqrt(9)+log(e)", 4.0, R"lua(
(function() local values = {};
values[1] = 9.0;
values[2] = math.sqrt(values[1]);
values[3] = 2.718281828459045;
values[4] = math.log(values[3]);
values[5] = values[2] + values[4];
return values[5] end)()
)lua" },
        { "sin(pi/2)", 1.0, R"lua(
(function() local values = {};
values[1] = 3.141592653589793;
values[2] = 2.0;
values[3] = values[1] / values[2];
values[4] = math.sin(values[3]);
return values[4] end)()
)lua" },
        { "cos(π)", -1.0, R"lua(
(function() local values = {};
values[1] = 3.141592653589793;
values[2] = math.cos(values[1]);
return values[2] end)()
)lua" },
        { "tan(0)", 0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = math.tan(values[1]);
return values[2] end)()
)lua" },
        { "true+false+_test_()", 43.0, R"lua(
(function() local values = {};
values[1] = 1.0;
values[2] = 0.0;
values[3] = values[1] + values[2];
values[4] = 42.0;
values[5] = values[3] + values[4];
return values[5] end)()
)lua" },
        { "2^ceil(2.1)", 8.0, R"lua(
(function() local values = {};
values[1] = 2.0;
values[2] = 2.1000000000000001;
values[3] = math.ceil(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
values[4] = values[1] ^ values[3];
return values[4] end)()
)lua" },
        { "floor(-0)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
values[3] = math.floor(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
return values[3] end)()
)lua" },
        { "ceil(-0.25)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.25;
values[2] = -(values[1]);
values[3] = math.ceil(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
return values[3] end)()
)lua" },
        { "trunc(-0.25)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.25;
values[2] = -(values[1]);
values[3] = math.modf(values[2]) + 0.0;
if values[3] == 0.0 and 1.0 / values[2] < 0.0 then values[3] = -0.0 end;
return values[3] end)()
)lua" },
        { "round(-0.25)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.25;
values[2] = -(values[1]);
values[3] = math.floor(math.abs(values[2])) + 0.0;
if math.abs(values[2]) - values[3] >= 0.5 then values[3] = values[3] + 1.0 end;
if values[2] < 0.0 or 1.0 / values[2] < 0.0 then values[3] = -values[3] end;
return values[3] end)()
)lua" },
        { "sqrt(-0)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
values[3] = math.sqrt(values[2]);
return values[3] end)()
)lua" },
        { "sin(-0)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
values[3] = math.sin(values[2]);
return values[3] end)()
)lua" },
        { "tan(-0)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
values[3] = math.tan(values[2]);
return values[3] end)()
)lua" },
        { "min(0,-0)", 0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = -(values[2]);
values[4] = values[1];
if values[3] < values[4] then values[4] = values[3] end;
return values[4] end)()
)lua" },
        { "min(-0,0)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
values[3] = 0.0;
values[4] = values[2];
if values[3] < values[4] then values[4] = values[3] end;
return values[4] end)()
)lua" },
        { "max(0,-0)", 0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = -(values[2]);
values[4] = values[1];
if values[3] > values[4] then values[4] = values[3] end;
return values[4] end)()
)lua" },
        { "max(-0,0)", -0.0, R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
values[3] = 0.0;
values[4] = values[2];
if values[3] > values[4] then values[4] = values[3] end;
return values[4] end)()
)lua" },
        { "min(1,0/0,2)", 1.0, R"lua(
(function() local values = {};
values[1] = 1.0;
values[2] = 0.0;
values[3] = 0.0;
values[4] = values[2] / values[3];
values[5] = 2.0;
values[6] = values[1];
if values[4] < values[6] then values[6] = values[4] end;
if values[5] < values[6] then values[6] = values[5] end;
return values[6] end)()
)lua" },
        { "max(1,0/0,2)", 2.0, R"lua(
(function() local values = {};
values[1] = 1.0;
values[2] = 0.0;
values[3] = 0.0;
values[4] = values[2] / values[3];
values[5] = 2.0;
values[6] = values[1];
if values[4] > values[6] then values[6] = values[4] end;
if values[5] > values[6] then values[6] = values[5] end;
return values[6] end)()
)lua" },
        { "min(0/0,1)", std::numeric_limits<double>::quiet_NaN(), R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = 1.0;
values[5] = values[3];
if values[4] < values[5] then values[5] = values[4] end;
return values[5] end)()
)lua" },
        { "max(0/0,1)", std::numeric_limits<double>::quiet_NaN(), R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = 1.0;
values[5] = values[3];
if values[4] > values[5] then values[5] = values[4] end;
return values[5] end)()
)lua" },
        { "round(0/0)", std::numeric_limits<double>::quiet_NaN(), R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = math.floor(math.abs(values[3])) + 0.0;
if math.abs(values[3]) - values[4] >= 0.5 then values[4] = values[4] + 1.0 end;
if values[3] < 0.0 or 1.0 / values[3] < 0.0 then values[4] = -values[4] end;
return values[4] end)()
)lua" }
    };
    dialogue conversation;
    for( const function_case &row : cases ) {
        CAPTURE( row.source );
        math_exp native;
        REQUIRE( native.parse( row.source ) );
        const double expected = native.eval( conversation );
        const sol::protected_function_result call = fixture.lua.safe_script(
                    std::string( "return " ) + row.lua_expression, sol::script_pass_on_error );
        REQUIRE( call.valid() );
        const double actual = call.get<double>();
        if( std::isnan( row.expected ) ) {
            CHECK( std::isnan( expected ) );
            CHECK( std::isnan( actual ) );
        } else {
            CHECK( expected == row.expected );
            CHECK( actual == expected );
            if( expected == 0.0 ) {
                CHECK( std::signbit( expected ) == std::signbit( row.expected ) );
                CHECK( std::signbit( actual ) == std::signbit( expected ) );
            }
        }
    }
}

TEST_CASE( "lua_platform_temperature_math_matches_native_float_units",
           "[lua][platform][semantic][coords][math]" )
{
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::math, sol::lib::string );
    struct temperature_case {
        const char *source;
        const char *lua_expression;
    };
    // Native units::temperature stores float. Lua must reproduce conversion
    // boundaries and float intermediates, rather than use double-only offsets.
    const std::vector<temperature_case> cases = {
        { "celsius(0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(values[1]) - native_float(273.150));
return values[2] end)()
)lua" },
        { "celsius(-0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(values[2]) - native_float(273.150));
return values[3] end)()
)lua" },
        { "celsius(273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(values[1]) - native_float(273.150));
return values[2] end)()
)lua" },
        { "celsius(310.15)", R"lua(
(function() local values = {};
values[1] = 310.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(values[1]) - native_float(273.150));
return values[2] end)()
)lua" },
        { "celsius(-273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(values[2]) - native_float(273.150));
return values[3] end)()
)lua" },
        { "celsius(-459.67)", R"lua(
(function() local values = {};
values[1] = 459.67000000000002;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(values[2]) - native_float(273.150));
return values[3] end)()
)lua" },
        { "celsius(1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(values[1]) - native_float(273.150));
return values[2] end)()
)lua" },
        { "celsius(-1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(values[2]) - native_float(273.150));
return values[3] end)()
)lua" },
        { "celsius(16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(values[1]) - native_float(273.150));
return values[2] end)()
)lua" },
        { "celsius(-16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(values[2]) - native_float(273.150));
return values[3] end)()
)lua" },
        { "celsius(1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(values[1]) - native_float(273.150));
return values[2] end)()
)lua" },
        { "celsius(-1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(values[2]) - native_float(273.150));
return values[3] end)()
)lua" },
        { "fahrenheit(0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(native_float(values[1]) * native_float(1.8)) - native_float(459.67));
return values[2] end)()
)lua" },
        { "fahrenheit(-0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(native_float(values[2]) * native_float(1.8)) - native_float(459.67));
return values[3] end)()
)lua" },
        { "fahrenheit(273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(native_float(values[1]) * native_float(1.8)) - native_float(459.67));
return values[2] end)()
)lua" },
        { "fahrenheit(310.15)", R"lua(
(function() local values = {};
values[1] = 310.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(native_float(values[1]) * native_float(1.8)) - native_float(459.67));
return values[2] end)()
)lua" },
        { "fahrenheit(-273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(native_float(values[2]) * native_float(1.8)) - native_float(459.67));
return values[3] end)()
)lua" },
        { "fahrenheit(-459.67)", R"lua(
(function() local values = {};
values[1] = 459.67000000000002;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(native_float(values[2]) * native_float(1.8)) - native_float(459.67));
return values[3] end)()
)lua" },
        { "fahrenheit(1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(native_float(values[1]) * native_float(1.8)) - native_float(459.67));
return values[2] end)()
)lua" },
        { "fahrenheit(-1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(native_float(values[2]) * native_float(1.8)) - native_float(459.67));
return values[3] end)()
)lua" },
        { "fahrenheit(16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(native_float(values[1]) * native_float(1.8)) - native_float(459.67));
return values[2] end)()
)lua" },
        { "fahrenheit(-16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(native_float(values[2]) * native_float(1.8)) - native_float(459.67));
return values[3] end)()
)lua" },
        { "fahrenheit(1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(native_float(native_float(values[1]) * native_float(1.8)) - native_float(459.67));
return values[2] end)()
)lua" },
        { "fahrenheit(-1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(native_float(native_float(values[2]) * native_float(1.8)) - native_float(459.67));
return values[3] end)()
)lua" },
        { "from_celsius(0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
return values[2] end)()
)lua" },
        { "from_celsius(-0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(values[2] + native_float(273.150));
return values[3] end)()
)lua" },
        { "from_celsius(273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
return values[2] end)()
)lua" },
        { "from_celsius(310.15)", R"lua(
(function() local values = {};
values[1] = 310.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
return values[2] end)()
)lua" },
        { "from_celsius(-273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(values[2] + native_float(273.150));
return values[3] end)()
)lua" },
        { "from_celsius(-459.67)", R"lua(
(function() local values = {};
values[1] = 459.67000000000002;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(values[2] + native_float(273.150));
return values[3] end)()
)lua" },
        { "from_celsius(1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
return values[2] end)()
)lua" },
        { "from_celsius(-1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(values[2] + native_float(273.150));
return values[3] end)()
)lua" },
        { "from_celsius(16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
return values[2] end)()
)lua" },
        { "from_celsius(-16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(values[2] + native_float(273.150));
return values[3] end)()
)lua" },
        { "from_celsius(1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
return values[2] end)()
)lua" },
        { "from_celsius(-1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float(values[2] + native_float(273.150));
return values[3] end)()
)lua" },
        { "from_fahrenheit(0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float((values[1] + native_float(459.67)) / native_float(1.8));
return values[2] end)()
)lua" },
        { "from_fahrenheit(-0.0)", R"lua(
(function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float((values[2] + native_float(459.67)) / native_float(1.8));
return values[3] end)()
)lua" },
        { "from_fahrenheit(273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float((values[1] + native_float(459.67)) / native_float(1.8));
return values[2] end)()
)lua" },
        { "from_fahrenheit(310.15)", R"lua(
(function() local values = {};
values[1] = 310.14999999999998;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float((values[1] + native_float(459.67)) / native_float(1.8));
return values[2] end)()
)lua" },
        { "from_fahrenheit(-273.15)", R"lua(
(function() local values = {};
values[1] = 273.14999999999998;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float((values[2] + native_float(459.67)) / native_float(1.8));
return values[3] end)()
)lua" },
        { "from_fahrenheit(-459.67)", R"lua(
(function() local values = {};
values[1] = 459.67000000000002;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float((values[2] + native_float(459.67)) / native_float(1.8));
return values[3] end)()
)lua" },
        { "from_fahrenheit(1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float((values[1] + native_float(459.67)) / native_float(1.8));
return values[2] end)()
)lua" },
        { "from_fahrenheit(-1e-40)", R"lua(
(function() local values = {};
values[1] = 9.9999999999999993e-41;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float((values[2] + native_float(459.67)) / native_float(1.8));
return values[3] end)()
)lua" },
        { "from_fahrenheit(16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float((values[1] + native_float(459.67)) / native_float(1.8));
return values[2] end)()
)lua" },
        { "from_fahrenheit(-16777217.0)", R"lua(
(function() local values = {};
values[1] = 16777217.0;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float((values[2] + native_float(459.67)) / native_float(1.8));
return values[3] end)()
)lua" },
        { "from_fahrenheit(1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float((values[1] + native_float(459.67)) / native_float(1.8));
return values[2] end)()
)lua" },
        { "from_fahrenheit(-1e+30)", R"lua(
(function() local values = {};
values[1] = 1e+30;
values[2] = -(values[1]);
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[3] = native_float((values[2] + native_float(459.67)) / native_float(1.8));
return values[3] end)()
)lua" },
        { "celsius(from_celsius(37))+fahrenheit(from_fahrenheit(98.6))", R"lua(
(function() local values = {};
values[1] = 37.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
values[3] = native_float(native_float(values[2]) - native_float(273.150));
values[4] = 98.599999999999994;
values[5] = native_float((values[4] + native_float(459.67)) / native_float(1.8));
values[6] = native_float(native_float(native_float(values[5]) * native_float(1.8)) - native_float(459.67));
values[7] = values[3] + values[6];
return values[7] end)()
)lua" }
    };
    dialogue conversation;
    for( const temperature_case &row : cases ) {
        CAPTURE( row.source );
        math_exp native;
        REQUIRE( native.parse( row.source ) );
        const double expected = native.eval( conversation );
        const sol::protected_function_result call = fixture.lua.safe_script(
                    std::string( "return " ) + row.lua_expression, sol::script_pass_on_error );
        REQUIRE( call.valid() );
        const double actual = call.get<double>();
        CHECK( actual == expected );
        if( expected == 0.0 ) {
            CHECK( std::signbit( actual ) == std::signbit( expected ) );
        }
    }
}

TEST_CASE( "lua_platform_pure_math_conditions_match_native_comparison_and_truth",
           "[lua][platform][semantic][variables][math]" )
{
    variable_api_fixture fixture;
    fixture.lua.open_libraries( sol::lib::math, sol::lib::string );
    struct predicate_case {
        const char *source;
        bool expected;
        const char *lua_expression;
    };
    // Compare actual conditional_t loading/evaluation with ordinary emitted
    // Lua, including nonzero/NaN truth and numeric comparison subexpressions.
    const std::vector<predicate_case> cases = {
        { "2 > 1", true, R"lua(
((function() local values = {};
values[1] = 2.0;
values[2] = 1.0;
values[3] = (values[1] > values[2]) and 1.0 or 0.0;
return values[3] end)() ~= 0.0)
)lua" },
        { "1.25e2 >= 125", true, R"lua(
((function() local values = {};
values[1] = 125.0;
values[2] = 125.0;
values[3] = (values[1] >= values[2]) and 1.0 or 0.0;
return values[3] end)() ~= 0.0)
)lua" },
        { "1 >= 0", true, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = 0.0;
values[3] = (values[1] >= values[2]) and 1.0 or 0.0;
return values[3] end)() ~= 0.0)
)lua" },
        { "1 != 0", true, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = 0.0;
values[3] = (values[1] ~= values[2]) and 1.0 or 0.0;
return values[3] end)() ~= 0.0)
)lua" },
        { "1 != 1", false, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = 1.0;
values[3] = (values[1] ~= values[2]) and 1.0 or 0.0;
return values[3] end)() ~= 0.0)
)lua" },
        { "1 + 2 > 0", true, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = 2.0;
values[3] = values[1] + values[2];
values[4] = 0.0;
values[5] = (values[3] > values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "1 / 0 > 0", true, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = 0.0;
values[5] = (values[3] > values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "0 / 0 == 0", false, R"lua(
((function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = 0.0;
values[5] = (values[3] == values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "0 / 0 != 0", true, R"lua(
((function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = 0.0;
values[5] = (values[3] ~= values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "0 / 0 < 0", false, R"lua(
((function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
values[4] = 0.0;
values[5] = (values[3] < values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "0 / 0", true, R"lua(
((function() local values = {};
values[1] = 0.0;
values[2] = 0.0;
values[3] = values[1] / values[2];
return values[3] end)() ~= 0.0)
)lua" },
        { "0", false, R"lua(
((function() local values = {};
values[1] = 0.0;
return values[1] end)() ~= 0.0)
)lua" },
        { "-0", false, R"lua(
((function() local values = {};
values[1] = 0.0;
values[2] = -(values[1]);
return values[2] end)() ~= 0.0)
)lua" },
        { "-1", true, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = -(values[1]);
return values[2] end)() ~= 0.0)
)lua" },
        { "2 < 1 < 1", true, R"lua(
((function() local values = {};
values[1] = 2.0;
values[2] = 1.0;
values[3] = (values[1] < values[2]) and 1.0 or 0.0;
values[4] = 1.0;
values[5] = (values[3] < values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "2 > 1 == 1", true, R"lua(
((function() local values = {};
values[1] = 2.0;
values[2] = 1.0;
values[3] = (values[1] > values[2]) and 1.0 or 0.0;
values[4] = 1.0;
values[5] = (values[3] == values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "(2 > 1) + (3 != 4) == 2", true, R"lua(
((function() local values = {};
values[1] = 2.0;
values[2] = 1.0;
values[3] = (values[1] > values[2]) and 1.0 or 0.0;
values[4] = 3.0;
values[5] = 4.0;
values[6] = (values[4] ~= values[5]) and 1.0 or 0.0;
values[7] = values[3] + values[6];
values[8] = 2.0;
values[9] = (values[7] == values[8]) and 1.0 or 0.0;
return values[9] end)() ~= 0.0)
)lua" },
        { "round(-2.5) <= -3", true, R"lua(
((function() local values = {};
values[1] = 2.5;
values[2] = -(values[1]);
values[3] = math.floor(math.abs(values[2])) + 0.0;
if math.abs(values[2]) - values[3] >= 0.5 then values[3] = values[3] + 1.0 end;
if values[2] < 0.0 or 1.0 / values[2] < 0.0 then values[3] = -values[3] end;
values[4] = 3.0;
values[5] = -(values[4]);
values[6] = (values[3] <= values[5]) and 1.0 or 0.0;
return values[6] end)() ~= 0.0)
)lua" },
        { "max(1,2) == 2", true, R"lua(
((function() local values = {};
values[1] = 1.0;
values[2] = 2.0;
values[3] = values[1];
if values[2] > values[3] then values[3] = values[2] end;
values[4] = 2.0;
values[5] = (values[3] == values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" },
        { "celsius(from_celsius(37)) == 37", true, R"lua(
((function() local values = {};
values[1] = 37.0;
local native_float = function(value) return (string.unpack("f", string.pack("f", value))) end;
values[2] = native_float(values[1] + native_float(273.150));
values[3] = native_float(native_float(values[2]) - native_float(273.150));
values[4] = 37.0;
values[5] = (values[3] == values[4]) and 1.0 or 0.0;
return values[5] end)() ~= 0.0)
)lua" }
    };
    dialogue conversation;
    for( const predicate_case &row : cases ) {
        CAPTURE( row.source );
        const conditional_t native( json_loader::from_string(
                                        std::string( "{\"math\":[\"" ) + row.source + "\"]}" ).get_object() );
        finalize_conditions();
        const bool expected = native( conversation );
        CHECK( expected == row.expected );
        const sol::protected_function_result call = fixture.lua.safe_script(
                    std::string( "return " ) + row.lua_expression, sol::script_pass_on_error );
        REQUIRE( call.valid() );
        CHECK( call.get<bool>() == expected );
    }
}

TEST_CASE( "native_variable_reads_do_not_share_missing_beta_mutation_fallback",
           "[lua][platform][semantic][variables]" )
{
    avatar alpha;
    alpha.set_value( "key", diag_value( 11.0 ) );
    dialogue conversation( get_talker_for( alpha ), nullptr );
    const var_info info{ var_type::npc, "key" };
    const diag_value *read = nullptr;
    const std::string read_diagnostic = capture_debugmsg_during( [&]() {
        read = maybe_read_var_value( info, conversation );
    } );
    CHECK( read == nullptr );
    CHECK( read_diagnostic.find( "invalid beta talker" ) != std::string::npos );
    const std::string guarded_write_diagnostic = capture_debugmsg_during( [&]() {
        write_var_value( var_type::npc, "key", &conversation, diag_value( 33.0 ) );
    } );
    CHECK( alpha.get_value( "key" ).dbl() == 11.0 );
    CHECK( guarded_write_diagnostic.find( "invalid beta talker" ) != std::string::npos );
    const std::string write_diagnostic = capture_debugmsg_during( [&]() {
        conversation.actor( true )->set_value( "key", diag_value( 22.0 ) );
    } );
    CHECK( alpha.get_value( "key" ).dbl() == 22.0 );
    CHECK( write_diagnostic.find( "invalid beta talker" ) != std::string::npos );
}

#endif // defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
