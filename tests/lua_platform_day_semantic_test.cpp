#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
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
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

TEST_CASE( "lua_platform_is_day_matches_legacy_calendar_boundaries",
           "[lua][platform][day][semantic]" )
{
    using namespace cata::lua_platform;
    clear_active_runtimes();
    restore_on_out_of_scope restore_turn( calendar::turn );
    const bool old_day = calendar::eternal_day();
    const bool old_night = calendar::eternal_night();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( "day_semantics", 4901, lua );
    on_out_of_scope cleanup( [old_day, old_night]() {
        clear_active_runtimes();
        calendar::set_eternal_day( old_day );
        calendar::set_eternal_night( old_night );
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    runtime_world_ready( true );
    lua["services"] = ccb["services"];
    // This is the migrator's ordinary Lua expression, using the real service.
    sol::protected_function predicate = lua.load(
                                            "return not services.gameplay.environment.is_night()" );
    conditional_t legacy( "is_day" );
    dialogue context;
    for( const bool eternal_day : {
             false, true
         } ) {
        for( const bool eternal_night : {
                 false, true
             } ) {
            calendar::set_eternal_day( eternal_day );
            calendar::set_eternal_night( eternal_night );
            for( int season = 0; season < 4; ++season ) {
                const time_point date = calendar::turn_zero + calendar::season_length() * season;
                const std::array<time_point, 6> boundaries = {{
                        date, sunrise( date ), daylight_time( date ), noon( date ),
                        sunset( date ), night_time( date )
                    }
                };
                for( const time_point boundary : boundaries ) {
                    for( const int offset : {
                             -1, 0, 1
                             } ) {
                        calendar::turn = boundary + time_duration::from_seconds( offset );
                        CAPTURE( eternal_day, eternal_night, season, offset );
                        const sol::protected_function_result actual = predicate();
                        REQUIRE( actual.valid() );
                        CHECK( actual.get<bool>() == legacy( context ) );
                    }
                }
            }
        }
    }
}

#endif
