#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_time.h"

#include <array>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>

#include "calendar.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "game.h"
#include "timed_event.h"

namespace cata::lua_platform
{

namespace
{

std::string season_id( const season_type season )
{
    static constexpr std::array<std::string_view, NUM_SEASONS> names = {
        "spring", "summer", "autumn", "winter"
    };
    const int index = static_cast<int>( season );
    return index >= 0 &&
           index < static_cast<int>( names.size() ) ?
           std::string(
               names[static_cast<std::size_t>( index )] ) :
           "unknown";
}

std::string moon_phase_id( const moon_phase phase )
{
    static constexpr std::array<std::string_view, MOON_PHASE_MAX> names = {
        "new",
        "waxing_crescent",
        "waxing_half",
        "waxing_gibbous",
        "full",
        "waning_gibbous",
        "waning_half",
        "waning_crescent"
    };
    const int index = static_cast<int>( phase );
    return index >= 0 &&
           index < static_cast<int>( names.size() ) ?
           std::string(
               names[static_cast<std::size_t>( index )] ) :
           "unknown";
}

std::int64_t turn_number(
    const time_point &point )
{
    return to_turn<std::int64_t>( point );
}

std::int64_t duration_turns(
    const time_duration &duration )
{
    return to_turns<std::int64_t>( duration );
}

void require_snapshot_point(
    const time_point &point,
    const std::string_view api_name )
{
    const std::int64_t turn =
        turn_number( point );
    if( turn <
        turn_number( calendar::turn_zero ) ||
        turn >
        turn_number( calendar::turn_max ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " point must be within turn_zero..turn_max" );
    }
}

sol::table snapshot_season(
    sol::state_view lua,
    const season_type season,
    const time_point &point )
{
    sol::table result =
        lua.create_table();
    result["id"] =
        season_id( season );
    result["index"] =
        static_cast<int>( season );
    result["name"] =
        calendar::name_season( season );
    result["day"] =
        day_of_season<int>( point ) + 1;
    return result;
}

sol::table snapshot_point(
    sol::state_view lua,
    const time_point &point )
{
    require_snapshot_point(
        point, "services.time.snapshot" );
    const season_type season =
        season_of_year( point );
    const std::int64_t point_turn =
        turn_number( point );
    const std::int64_t season_turns =
        duration_turns(
            calendar::season_length() );
    const std::int64_t year_turns =
        duration_turns(
            calendar::year_length() );
    const std::int64_t year_offset =
        duration_turns(
            calendar::turn_zero_offset() );
    const std::int64_t day_turns =
        duration_turns( 1_days );
    const std::int64_t day_of_year =
        ( point_turn + year_offset ) %
        year_turns / day_turns;

    sol::table result =
        lua.create_table();
    result["point"] =
        script_time_point::from_native(
            point );
    result["turn"] =
        point_turn;
    result["display"] =
        ::to_string( point );
    result["time_of_day"] =
        to_string_time_of_day( point );
    result["year"] =
        ( point_turn + year_offset ) /
        year_turns + 1;
    result["day_of_year"] =
        day_of_year + 1;
    result["second"] =
        static_cast<int>(
            point_turn % 60 );
    result["minute"] =
        minute_of_hour<int>( point );
    result["hour"] =
        hour_of_day<int>( point );
    result["season"] =
        snapshot_season(
            lua, season, point );
    result["moon_phase"] =
        moon_phase_id(
            get_moon_phase( point ) );
    result["is_day"] =
        is_day( point );
    result["is_night"] =
        is_night( point );
    result["is_dawn"] =
        is_dawn( point );
    result["is_dusk"] =
        is_dusk( point );
    result["is_twilight"] =
        is_twilight( point );
    result["sunrise"] =
        script_time_point::from_native(
            sunrise( point ) );
    result["sunset"] =
        script_time_point::from_native(
            sunset( point ) );
    result["daylight"] =
        script_time_point::from_native(
            daylight_time( point ) );
    result["nightfall"] =
        script_time_point::from_native(
            night_time( point ) );
    result["noon"] =
        script_time_point::from_native(
            ::noon( point ) );
    result["turns_since_cataclysm"] =
        point_turn -
        turn_number(
            calendar::start_of_cataclysm );
    result["turns_since_game_start"] =
        point_turn -
        turn_number(
            calendar::start_of_game );
    result["season_turns"] =
        season_turns;
    return result;
}

sol::table calendar_snapshot(
    sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result =
        state.create_table();
    result["now"] =
        snapshot_point(
            state, calendar::turn );
    result["turn_zero"] =
        script_time_point::from_native(
            calendar::turn_zero );
    result["start_of_cataclysm"] =
        script_time_point::from_native(
            calendar::start_of_cataclysm );
    result["start_of_game"] =
        script_time_point::from_native(
            calendar::start_of_game );
    result["season_length"] =
        script_time_duration::from_native(
            calendar::season_length() );
    result["year_length"] =
        script_time_duration::from_native(
            calendar::year_length() );
    result["turn_zero_offset"] =
        script_time_duration::from_native(
            calendar::turn_zero_offset() );
    sol::table initial_season =
        state.create_table();
    initial_season["id"] =
        season_id(
            calendar::initial_season );
    initial_season["index"] =
        static_cast<int>(
            calendar::initial_season );
    initial_season["name"] =
        calendar::name_season(
            calendar::initial_season );
    result["initial_season"] =
        std::move( initial_season );
    result["eternal_season"] =
        calendar::eternal_season();
    result["eternal_day"] =
        calendar::eternal_day();
    result["eternal_night"] =
        calendar::eternal_night();
    return result;
}

sol::table time_limits(
    sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result =
        state.create_table();
    result["minimum"] =
        script_time_point::from_native(
            calendar::turn_zero );
    result["maximum"] =
        script_time_point::from_native(
            calendar::turn_max );
    result["minimum_turn"] =
        turn_number(
            calendar::turn_zero );
    result["maximum_turn"] =
        turn_number(
            calendar::turn_max );
    result["set_now_simulates_turns"] =
        false;
    return result;
}

void require_active_game(
    const std::string_view api_name )
{
    if( g == nullptr ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " requires an active game" );
    }
}

sol::table set_now(
    sol::this_state lua,
    const script_time_point &requested,
    const sol::optional<script_time_point> &expected )
{
    constexpr std::string_view api_name =
        "services.time.set_now";
    require_active_game( api_name );
    const time_point target =
        requested.to_native();
    require_snapshot_point(
        target, api_name );
    const time_point previous =
        calendar::turn;

    sol::state_view state( lua );
    if( expected &&
        expected->to_native() != previous ) {
        return make_game_error_result(
        state, {
            "conflict",
            "The world clock no longer matches expected"
        } );
    }

    calendar::turn = target;
    sol::table value =
        state.create_table();
    value["previous"] =
        snapshot_point(
            state, previous );
    value["current"] =
        snapshot_point(
            state, calendar::turn );
    value["delta"] =
        script_time_duration::from(
            turn_number( target ) -
            turn_number( previous ),
            "turn" );
    value["simulated_turns"] =
        false;
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

sol::table advance(
    sol::this_state lua,
    const script_time_duration &duration,
    const sol::optional<script_time_point> &expected )
{
    constexpr std::string_view api_name =
        "services.time.advance";
    require_active_game( api_name );
    const std::int64_t current =
        turn_number( calendar::turn );
    const std::int64_t delta =
        duration.turns();
    if( ( delta > 0 &&
          current >
          std::numeric_limits<int>::max() -
          delta ) ||
        ( delta < 0 &&
          current < -delta ) ) {
        throw std::invalid_argument(
            "services.time.advance would exceed "
            "turn_zero..turn_max" );
    }
    return set_now(
               lua,
               script_time_point::from_turn(
                   current + delta ),
               expected );
}

sol::table reschedule_events(
    sol::this_state lua,
    const std::string &key,
    const script_time_duration &duration )
{
    constexpr std::string_view api_name =
        "services.time.reschedule";
    require_active_game( api_name );
    if( key.size() > 256 || key.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.time.reschedule key must be at most 256 bytes" );
    }
    const std::int64_t turns = duration.turns();
    if( turns < -31536000 || turns > 31536000 ) {
        throw std::invalid_argument(
            "services.time.reschedule duration must be within +/-31536000 turns" );
    }
    const std::size_t matched = static_cast<std::size_t>( std::count_if(
                                    get_timed_events().get_all().begin(),
                                    get_timed_events().get_all().end(),
    [&key]( const timed_event & event ) {
        return event.key == key;
    } ) );
    get_timed_events().set_all( key, duration.to_native() );

    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["key"] = key;
    value["duration"] = duration;
    value["matched"] = matched;
    value["changed"] = matched != 0;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_time_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::table time =
        services["time"];
    time.set_function(
        "snapshot",
        [require_read](
            sol::this_state lua,
    const sol::optional<script_time_point> &point ) {
        require_read();
        sol::state_view state( lua );
        return snapshot_point(
                   state,
                   point ?
                   point->to_native() :
                   calendar::turn );
    } );
    time.set_function(
        "calendar",
    [require_read]( sol::this_state lua ) {
        require_read();
        return calendar_snapshot( lua );
    } );
    time.set_function(
        "limits",
    [require_read]( sol::this_state lua ) {
        require_read();
        return time_limits( lua );
    } );
    time.set_function(
        "set_now",
        [require_write](
            sol::this_state lua,
            const script_time_point & point,
    const sol::optional<script_time_point> &expected ) {
        require_write();
        return set_now(
                   lua, point, expected );
    } );
    time.set_function(
        "advance",
        [require_write](
            sol::this_state lua,
            const script_time_duration & duration,
    const sol::optional<script_time_point> &expected ) {
        require_write();
        return advance(
                   lua, duration, expected );
    } );
    time.set_function(
        "reschedule",
        [require_write]( sol::this_state lua,
                         const std::string & key,
    const script_time_duration & duration ) {
        require_write();
        return reschedule_events( lua, key, duration );
    } );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
