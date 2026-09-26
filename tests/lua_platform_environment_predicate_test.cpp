#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "condition.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "type_id.h"
#include "weather.h"
#include "weather_type.h"

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

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
        for( int season = 0; season <= 8; ++season ) {
            for( const time_duration offset : {
                     -1_turns, 0_turns, 1_turns
                     } ) {
                if( season == 0 && offset < 0_turns ) {
                    continue;
                }
                calendar::turn = calendar::turn_zero + calendar::season_length() * season + offset;
                for( const std::string wanted : {
                         "spring", "summer", "autumn", "winter", "", "unknown"
                     } ) {
                    CAPTURE( eternal, season, to_turns<int>( offset ), wanted );
                    lua["wanted"] = wanted;
                    conditional_t legacy( json_loader::from_string(
                                              R"({"is_season":")" + wanted + R"("})" ).get_object() );
                    const sol::protected_function_result actual = season_query();
                    REQUIRE( actual.valid() );
                    CHECK( actual.get<bool>() == legacy( context ) );
                }
            }
        }
    }
    sol::protected_function weather_query = lua.load(
            "return services.weather.current().weather.value == wanted" );
    std::vector<std::string> weather_ids;
    weather_ids.reserve( weather_types::get_all().size() );
    for( const weather_type &definition : weather_types::get_all() ) {
        weather_ids.push_back( definition.id.str() );
    }
    REQUIRE_FALSE( weather_ids.empty() );
    std::vector<std::string> wanted_ids = weather_ids;
    wanted_ids.emplace_back( "" );
    wanted_ids.emplace_back( "unknown" );
    for( const std::string &current : weather_ids ) {
        get_weather().weather_id = weather_type_id( current );
        for( const std::string &wanted : wanted_ids ) {
            CAPTURE( current, wanted );
            lua["wanted"] = wanted;
            conditional_t legacy( json_loader::from_string(
                                      R"({"is_weather":")" + wanted + R"("})" ).get_object() );
            const sol::protected_function_result actual = weather_query();
            REQUIRE( actual.valid() );
            CHECK( actual.get<bool>() == legacy( context ) );
        }
    }

    // Exercise the native str_or_var translation object accepted by these
    // selectors, and compare it with the migration's services.translate path.
    const std::string translated_season_source =
        seasons[season_of_year( calendar::turn )];
    lua["wanted"] = translated_season_source;
    conditional_t translated_season( json_loader::from_string(
                                         R"({"is_season":{"str":")" +
                                         translated_season_source + R"(","i18n":true}})"
                                     ).get_object() );
    sol::protected_function translated_season_query = lua.load(
                "return services.time_snapshot().season_id == services.translate(wanted)" );
    const sol::protected_function_result translated_season_result = translated_season_query();
    REQUIRE( translated_season_result.valid() );
    CHECK( translated_season_result.get<bool>() == translated_season( context ) );

    const std::string translated_weather_source = weather_ids.front();
    get_weather().weather_id = weather_type_id( translated_weather_source );
    lua["wanted"] = translated_weather_source;
    conditional_t translated_weather( json_loader::from_string(
                                          R"({"is_weather":{"str":")" +
                                          translated_weather_source + R"(","i18n":true}})"
                                      ).get_object() );
    sol::protected_function translated_weather_query = lua.load(
                "return services.weather.current().weather.value == services.translate(wanted)" );
    const sol::protected_function_result translated_weather_result = translated_weather_query();
    REQUIRE( translated_weather_result.valid() );
    CHECK( translated_weather_result.get<bool>() == translated_weather( context ) );
}

#endif
