#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <string>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "condition.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "weather.h"

TEST_CASE( "lua_platform_environment_strings_match_native_predicates",
           "[lua][platform][environment_predicate][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    restore_on_out_of_scope restore_turn( calendar::turn );
    restore_on_out_of_scope restore_weather( get_weather().weather_id );
    const bool old_eternal = calendar::eternal_season();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "environment_strings", 4902, lua );
    on_out_of_scope cleanup( [old_eternal]() {
        clear_active_runtimes();
        calendar::set_eternal_season( old_eternal );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];
    dialogue context;
    sol::protected_function season_query = lua.load(
            "return services.time_snapshot().season_id == wanted" );
    for( const bool eternal : {
             false, true
         } ) {
        calendar::set_eternal_season( eternal );
        for( int season = 0; season < 4; ++season ) {
            calendar::turn = calendar::turn_zero + calendar::season_length() * season;
            for( const std::string wanted : {
                     "spring", "summer", "autumn", "winter", "", "unknown"
                 } ) {
                CAPTURE( eternal, season, wanted );
                lua["wanted"] = wanted;
                conditional_t legacy( json_loader::from_string(
                                          "{\"is_season\":\"" + wanted + "\"}" ).get_object() );
                const sol::protected_function_result actual = season_query();
                REQUIRE( actual.valid() );
                CHECK( actual.get<bool>() == legacy( context ) );
            }
        }
    }
    sol::protected_function weather_query = lua.load(
            "return services.weather.current().weather.value == wanted" );
    for( const std::string current : {
             "sunny", "rain", "snowing"
         } ) {
        get_weather().weather_id = weather_type_id( current );
        for( const std::string wanted : {
                 "sunny", "rain", "snowing", "", "unknown"
             } ) {
            CAPTURE( current, wanted );
            lua["wanted"] = wanted;
            conditional_t legacy( json_loader::from_string(
                                      "{\"is_weather\":\"" + wanted + "\"}" ).get_object() );
            const sol::protected_function_result actual = weather_query();
            REQUIRE( actual.valid() );
            CHECK( actual.get<bool>() == legacy( context ) );
        }
    }
}

#endif
