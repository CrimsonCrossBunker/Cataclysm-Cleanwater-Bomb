#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
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
