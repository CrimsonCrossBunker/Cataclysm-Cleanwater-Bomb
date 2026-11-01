#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <memory>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "martialarts.h"
#include "pimpl.h"
#include "type_id.h"

TEST_CASE( "lua_platform_technique_cooldown_validates_results_and_preserves_native_fallback",
           "[lua][platform][active_technique][cooldown]" )
{
    namespace platform = cata::lua_platform;
    const auto previous = platform::detail::active_runtimes;
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    const auto owner = platform::make_runtime( "cooldown-test", 9011, lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    lua["ccb"] = ccb;
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    const on_out_of_scope cleanup( [&previous]() {
        platform::set_active_runtimes( previous );
    } );
    avatar character;
    character.normalize();
    character.setID( character_id( 9012 ), true );
    ma_technique technique;
    technique.id = matec_id( "test_active_cooldown_strike" );
    technique.cooldown = 8_seconds;
    technique.lua_platform_mod = "cooldown-test";
    technique.lua_platform_cooldown_handler = "unavailable";
    CHECK( technique.activation_cooldown( character ) == 8_seconds );

    const std::vector<std::string> results = {
        "context.base_cooldown_seconds / 2", "0.1", "0", "86400",
        "nil", "true", "'4'", "-1", "86401", "0/0", "math.huge", "2, 3", "error('test failure')"
    };
    for( std::size_t index = 0; index < results.size(); ++index ) {
        INFO( results[index] );
        const std::string handler = "duration_" + std::to_string( index );
        const sol::protected_function_result registered = lua.safe_script(
                    "ccb.runtime.handler('" + handler + "', function(context) "
                    "assert(context.technique_id == 'test_active_cooldown_strike') "
                    "assert(context.character ~= nil) "
                    "assert(context.weapon_id == '') "
                    "assert(context.base_cooldown_seconds == 8) "
                    "return " + results[index] + " end)", sol::script_pass_on_error );
        REQUIRE( registered.valid() );
        technique.lua_platform_cooldown_handler = handler;
        const std::vector<time_duration> expected = { 4_seconds, 1_seconds, 0_seconds, 1_days };
        CHECK( technique.activation_cooldown( character ) ==
               ( index < expected.size() ? expected[index] : 8_seconds ) );
    }
    owner->world_is_ready = false;
    CHECK( technique.activation_cooldown( character ) == 8_seconds );
}

TEST_CASE( "lua_platform_technique_state_is_a_detached_read_only_cooldown_snapshot",
           "[lua][platform][active_technique][cooldown]" )
{
    namespace platform = cata::lua_platform;
    const auto previous = platform::detail::active_runtimes;
    sol::state lua;
    const auto owner = platform::make_runtime( "cooldown-state", 9013, lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    const on_out_of_scope cleanup( [&previous]() {
        platform::set_active_runtimes( previous );
    } );
    avatar character;
    character.normalize();
    character.setID( character_id( 9014 ), true );
    const matec_id technique( "test_active_cooldown_strike" );
    character.martial_arts_data->start_technique_cooldown( technique, 8_seconds );
    const platform::game_handle handle = platform::game_handle::from_creature(
            character, { "avatar", character.getID().get_value(), 0, 0, 0, {} },
            platform::detail::runtime_handle_identity( owner ), platform::runtime_world_generation() );
    sol::protected_function get_state = ccb["services"]["martial_arts"]["technique_state"];
    const platform::script_game_id id( "martial_art_technique", technique.str() );
    sol::protected_function_result call = get_state( handle, id );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table snapshot = result["value"];
    CHECK( snapshot["remaining_seconds"].get<double>() == 8.0 );
    CHECK( snapshot["base_cooldown_seconds"].get<double>() == 8.0 );
    snapshot["remaining_seconds"] = 0;
    CHECK( character.martial_arts_data->technique_cooldown_remaining( technique ) == 8_seconds );
    call = get_state( handle, platform::script_game_id( "item", "rock" ) );
    CHECK_FALSE( call.valid() );
}

#endif
