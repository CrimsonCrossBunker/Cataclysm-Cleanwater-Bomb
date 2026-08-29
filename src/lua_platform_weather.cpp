#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_weather.h"

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "coordinates.h"
#include "enum_conversions.h"
#include "game.h"
#include "point.h"
#include "timed_event.h"
#include "units.h"
#include "weather.h"
#include "weather_gen.h"
#include "weather_type.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_weather_limit = 64;
constexpr int maximum_weather_limit = 256;
constexpr int maximum_weather_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_nested_values = 128;
constexpr int default_forecast_limit = 24;
constexpr int maximum_forecast_limit = 168;
constexpr time_duration minimum_forecast_step = 1_minutes;
constexpr time_duration maximum_forecast_step = 24_hours;
constexpr time_duration maximum_forecast_horizon = 14_days;
constexpr int maximum_wind_speed_mph = 300;
constexpr int maximum_wind_direction_degrees = 359;
constexpr double maximum_temperature_kelvin = 1000.0;
constexpr int maximum_custom_light_level = 1000000;
constexpr time_duration maximum_custom_light_duration = 10000_days;
constexpr std::size_t maximum_custom_light_key_bytes = 256;
constexpr std::size_t maximum_pending_custom_light_events = 256;

std::string lowercase_ascii( std::string value )
{
    std::transform(
        value.begin(), value.end(),
        value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>(
                   std::tolower( ch ) );
    } );
    return value;
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

void require_weather_id(
    const script_game_id &id,
    const std::string_view api_name )
{
    if( id.kind() != "weather_type" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<weather_type>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<weather_type>" );
    }
}

const weather_type &resolve_weather(
    const script_game_id &id,
    const std::string_view api_name )
{
    require_weather_id(
        id, api_name );
    return weather_type_id(
               id.value() ).obj();
}

sol::table nested_weather_ids(
    sol::state_view lua,
    const std::vector<weather_type_id> &entries )
{
    const std::size_t returned =
        std::min(
            entries.size(),
            maximum_nested_values );
    sol::table items =
        lua.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            script_game_id(
                "weather_type",
                entries[index].str() );
    }
    sol::table result =
        lua.create_table();
    result["items"] =
        std::move( items );
    result["total"] =
        entries.size();
    result["returned"] =
        returned;
    result["truncated"] =
        returned < entries.size();
    return result;
}

sol::table snapshot_weather_definition(
    sol::state_view lua,
    const weather_type &entry )
{
    sol::table result =
        lua.create_table();
    result["id"] =
        script_game_id(
            "weather_type",
            entry.id.str() );
    result["name"] =
        entry.name.translated();
    result["loaded"] =
        entry.was_loaded;
    result["symbol"] =
        entry.get_symbol();
    result["sun_symbol"] =
        entry.get_sun_symbol();
    result["ranged_penalty"] =
        entry.ranged_penalty;
    result["sight_penalty"] =
        entry.sight_penalty;
    result["light_modifier"] =
        entry.light_modifier;
    result["light_multiplier"] =
        entry.light_multiplier;
    result["sun_multiplier"] =
        entry.sun_multiplier;
    result["sound_attenuation"] =
        entry.sound_attn;
    result["dangerous"] =
        entry.dangerous;
    result["precipitation"] =
        io::enum_to_string(
            entry.precip );
    result["precipitation_mm_per_hour"] =
        precip_mm_per_hour(
            entry.precip );
    result["rains"] =
        entry.rains;
    result["temperature_modifier_c"] =
        units::to_kelvin_delta(
            entry.temperature_modifier );
    result["priority"] =
        entry.priority;
    result["tiles_animation"] =
        entry.tiles_animation;
    result["sound_category"] =
        io::enum_to_string(
            entry.sound_category );
    result["duration_min"] =
        script_time_duration::from_native(
            entry.duration_min );
    result["duration_max"] =
        script_time_duration::from_native(
            entry.duration_max );
    result["required_weathers"] =
        nested_weather_ids(
            lua,
            entry.required_weathers );

    const std::size_t source_returned =
        std::min(
            entry.src.size(),
            maximum_nested_values );
    sol::table source_items =
        lua.create_table(
            static_cast<int>(
                source_returned ), 0 );
    for( std::size_t index = 0;
         index < source_returned;
         ++index ) {
        sol::table source =
            lua.create_table();
        source["weather"] =
            script_game_id(
                "weather_type",
                entry.src[index].
                first.str() );
        source["mod"] =
            entry.src[index].
            second.str();
        source_items[index + 1] =
            std::move( source );
    }
    sol::table sources =
        lua.create_table();
    sources["items"] =
        std::move( source_items );
    sources["total"] =
        entry.src.size();
    sources["returned"] =
        source_returned;
    sources["truncated"] =
        source_returned <
        entry.src.size();
    result["sources"] =
        std::move( sources );
    return result;
}

struct weather_list_options {
    int offset = 0;
    int limit = default_weather_limit;
    std::string query;
    std::optional<bool> dangerous;
    std::optional<bool> rains;
};

int require_nonnegative_integer(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be an integer" );
    }
    const lua_Integer number =
        value.as<lua_Integer>();
    if( number < 0 ||
        number >
        maximum_weather_offset ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be within 0..1000000" );
    }
    return static_cast<int>( number );
}

bool require_boolean(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be a boolean" );
    }
    return value.as<bool>();
}

std::string require_string(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<std::string>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be a string" );
    }
    return value.as<std::string>();
}

weather_list_options read_weather_list_options(
    const sol::optional<sol::table> &requested )
{
    constexpr std::string_view api_name =
        "services.weather.types";
    weather_list_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &option : *requested ) {
        const sol::object key_object =
            option.first;
        if( key_object.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "services.weather.types option keys "
                "must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const sol::object value =
            option.second;
        if( key == "offset" ) {
            result.offset =
                require_nonnegative_integer(
                    value,
                    std::string( api_name ),
                    key );
        } else if( key == "limit" ) {
            result.limit =
                std::min(
                    require_nonnegative_integer(
                        value,
                        std::string( api_name ),
                        key ),
                    maximum_weather_limit );
        } else if( key == "query" ) {
            result.query =
                require_string(
                    value,
                    std::string( api_name ),
                    key );
            if( result.query.size() >
                maximum_query_bytes ) {
                throw std::invalid_argument(
                    "services.weather.types option "
                    "'query' exceeds 128 bytes" );
            }
        } else if( key == "dangerous" ) {
            result.dangerous =
                require_boolean(
                    value,
                    std::string( api_name ),
                    key );
        } else if( key == "rains" ) {
            result.rains =
                require_boolean(
                    value,
                    std::string( api_name ),
                    key );
        } else {
            throw std::invalid_argument(
                "services.weather.types received "
                "unknown option '" + key + "'" );
        }
    }
    return result;
}

sol::table list_weather_types(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const weather_list_options options =
        read_weather_list_options(
            requested );
    const std::string query =
        lowercase_ascii(
            options.query );
    std::vector<const weather_type *> matches;
    for( const weather_type &entry :
         weather_types::get_all() ) {
        if( options.dangerous &&
            entry.dangerous !=
            *options.dangerous ) {
            continue;
        }
        if( options.rains &&
            entry.rains !=
            *options.rains ) {
            continue;
        }
        if( !query.empty() ) {
            const std::string id =
                lowercase_ascii(
                    entry.id.str() );
            const std::string name =
                lowercase_ascii(
                    entry.name.translated() );
            if( id.find( query ) ==
                std::string::npos &&
                name.find( query ) ==
                std::string::npos ) {
                continue;
            }
        }
        matches.push_back( &entry );
    }
    std::sort(
        matches.begin(), matches.end(),
        []( const weather_type * lhs,
    const weather_type * rhs ) {
        return lhs->id.str() <
               rhs->id.str();
    } );

    const std::size_t offset =
        std::min<std::size_t>(
            static_cast<std::size_t>(
                options.offset ),
            matches.size() );
    const std::size_t returned =
        std::min<std::size_t>(
            static_cast<std::size_t>(
                options.limit ),
            matches.size() - offset );
    sol::state_view state( lua );
    sol::table items =
        state.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            snapshot_weather_definition(
                state,
                *matches[offset + index] );
    }
    sol::table result =
        state.create_table();
    result["items"] =
        std::move( items );
    result["total"] =
        matches.size();
    result["returned"] =
        returned;
    result["offset"] =
        offset;
    result["limit"] =
        options.limit;
    result["truncated"] =
        offset + returned <
        matches.size();
    return result;
}

sol::table get_weather_type(
    sol::this_state lua,
    const script_game_id &id )
{
    const weather_type &entry =
        resolve_weather(
            id, "services.weather.type" );
    sol::state_view state( lua );
    return snapshot_weather_definition(
               state, entry );
}

script_unit_value temperature_value(
    const units::temperature temperature )
{
    return script_unit_value::
           from_canonical_number(
               "temperature", "kelvin",
               units::to_kelvin(
                   temperature ) );
}

sol::table snapshot_weather_point(
    sol::state_view lua,
    const w_point &point,
    const weather_type_id &condition,
    const time_point &at )
{
    sol::table result =
        lua.create_table();
    result["at"] =
        script_time_point::from_native(
            at );
    result["weather"] =
        script_game_id(
            "weather_type",
            condition.str() );
    result["temperature"] =
        temperature_value(
            point.temperature );
    result["temperature_c"] =
        units::to_celsius(
            point.temperature );
    result["humidity"] =
        point.humidity;
    result["pressure"] =
        point.pressure;
    result["wind_speed_mph"] =
        point.windpower;
    result["wind_direction_degrees"] =
        point.winddirection;
    result["wind_description"] =
        point.wind_desc;
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            point.location.raw() );
    if( condition.is_valid() ) {
        result["precipitation_mm_per_hour"] =
            precip_mm_per_hour(
                condition->precip );
        result["sunlight"] =
            incident_sunlight(
                condition, at );
        result["sun_irradiance"] =
            incident_sun_irradiance(
                condition, at );
        result["moonlight"] =
            incident_moonlight(
                condition, at );
    } else {
        result["precipitation_mm_per_hour"] =
            0.0;
        result["sunlight"] =
            0.0;
        result["sun_irradiance"] =
            0.0;
        result["moonlight"] =
            0.0;
    }
    result["is_day"] =
        is_day( at );
    result["is_night"] =
        is_night( at );
    return result;
}

sol::table snapshot_current_weather(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.current" );
    const weather_manager &weather =
        get_weather_const();
    sol::state_view state( lua );
    sol::table result =
        state.create_table();
    result["weather"] =
        script_game_id(
            "weather_type",
            weather.weather_id.str() );
    if( weather.weather_id.is_valid() ) {
        result["type"] =
            snapshot_weather_definition(
                state,
                weather.weather_id.obj() );
    } else {
        result["type"] =
            sol::nil;
    }
    result["temperature"] =
        temperature_value(
            weather.temperature );
    result["temperature_c"] =
        units::to_celsius(
            weather.temperature );
    result["wind_speed_mph"] =
        weather.windspeed;
    result["wind_direction_degrees"] =
        weather.winddirection;
    result["next_update"] =
        script_time_point::from_native(
            weather.nextweather );
    result["changed"] =
        weather.weather_changed;
    result["lightning_active"] =
        weather.lightning_active;
    if( weather.weather_override !=
        WEATHER_NULL ) {
        result["weather_override"] =
            script_game_id(
                "weather_type",
                weather.weather_override.str() );
    } else {
        result["weather_override"] =
            sol::nil;
    }
    if( weather.forced_temperature ) {
        result["temperature_override"] =
            temperature_value(
                *weather.forced_temperature );
    } else {
        result["temperature_override"] =
            sol::nil;
    }
    if( weather.windspeed_override ) {
        result["wind_speed_override_mph"] =
            *weather.windspeed_override;
    } else {
        result["wind_speed_override_mph"] =
            sol::nil;
    }
    if( weather.wind_direction_override ) {
        result["wind_direction_override_degrees"] =
            *weather.wind_direction_override;
    } else {
        result["wind_direction_override_degrees"] =
            sol::nil;
    }
    result["precise"] =
        snapshot_weather_point(
            state,
            *weather.weather_precise,
            weather.weather_id,
            calendar::turn );
    return result;
}

template<typename T>
sol::table bounded_strings(
    sol::state_view lua,
    const T &entries )
{
    const std::size_t returned =
        std::min(
            entries.size(),
            maximum_nested_values );
    sol::table items =
        lua.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        items[index + 1] =
            entries[index];
    }
    sol::table result =
        lua.create_table();
    result["items"] =
        std::move( items );
    result["total"] =
        entries.size();
    result["returned"] =
        returned;
    result["truncated"] =
        returned < entries.size();
    return result;
}

sol::table snapshot_generator(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.generator" );
    const weather_generator &generator =
        get_weather_const().
        get_cur_weather_gen();
    sol::state_view state( lua );
    sol::table result =
        state.create_table();
    result["id"] =
        script_game_id(
            "weather_generator",
            generator.id.str() );
    result["loaded"] =
        generator.was_loaded;
    result["base_temperature_c"] =
        generator.base_temperature;
    result["base_humidity"] =
        generator.base_humidity;
    result["base_pressure"] =
        generator.base_pressure;
    result["base_wind_mph"] =
        generator.base_wind;
    result["wind_distribution_peaks"] =
        generator.base_wind_distrib_peaks;
    result["wind_season_variation"] =
        generator.base_wind_season_variation;

    sol::table seasonal =
        state.create_table();
    sol::table spring =
        state.create_table();
    spring["temperature_modifier"] =
        generator.spring_temp_manual_mod;
    spring["humidity_modifier"] =
        generator.spring_humidity_manual_mod;
    seasonal["spring"] =
        std::move( spring );
    sol::table summer =
        state.create_table();
    summer["temperature_modifier"] =
        generator.summer_temp_manual_mod;
    summer["humidity_modifier"] =
        generator.summer_humidity_manual_mod;
    seasonal["summer"] =
        std::move( summer );
    sol::table autumn =
        state.create_table();
    autumn["temperature_modifier"] =
        generator.autumn_temp_manual_mod;
    autumn["humidity_modifier"] =
        generator.autumn_humidity_manual_mod;
    seasonal["autumn"] =
        std::move( autumn );
    sol::table winter =
        state.create_table();
    winter["temperature_modifier"] =
        generator.winter_temp_manual_mod;
    winter["humidity_modifier"] =
        generator.winter_humidity_manual_mod;
    seasonal["winter"] =
        std::move( winter );
    result["seasonal"] =
        std::move( seasonal );
    result["blacklist"] =
        bounded_strings(
            state,
            generator.weather_black_list );
    result["whitelist"] =
        bounded_strings(
            state,
            generator.weather_white_list );
    result["sorted_weather"] =
        nested_weather_ids(
            state,
            generator.sorted_weather );
    return result;
}

tripoint_abs_ms require_forecast_position(
    const script_tripoint_coord &position )
{
    if( position.native_origin() !=
        coords::origin::abs ||
        position.native_scale() !=
        coords::scale::map_square ) {
        throw std::invalid_argument(
            "services.weather.forecast option 'position' "
            "must be an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms(
               position.to_native() );
}

struct forecast_options {
    time_point start = calendar::turn;
    tripoint_abs_ms position;
    time_duration step = 1_hours;
    int limit = default_forecast_limit;
    bool respect_override = true;
};

forecast_options read_forecast_options(
    const sol::optional<sol::table> &requested )
{
    require_active_game(
        "services.weather.forecast" );
    forecast_options result;
    result.position =
        get_avatar().pos_abs();
    if( !requested ) {
        return result;
    }
    for( const auto &option : *requested ) {
        const sol::object key_object =
            option.first;
        if( key_object.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "services.weather.forecast option keys "
                "must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const sol::object value =
            option.second;
        if( key == "start" ) {
            if( !value.is<script_time_point>() ) {
                throw std::invalid_argument(
                    "services.weather.forecast option "
                    "'start' must be a TimePoint" );
            }
            result.start =
                value.as<script_time_point>().
                to_native();
        } else if( key == "position" ) {
            if( !value.is<script_tripoint_coord>() ) {
                throw std::invalid_argument(
                    "services.weather.forecast option "
                    "'position' must be a TripointCoord" );
            }
            result.position =
                require_forecast_position(
                    value.as <
                    script_tripoint_coord > () );
        } else if( key == "step" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.weather.forecast option "
                    "'step' must be a TimeDuration" );
            }
            result.step =
                value.as<script_time_duration>().
                to_native();
        } else if( key == "limit" ) {
            result.limit =
                require_nonnegative_integer(
                    value,
                    "services.weather.forecast",
                    key );
            if( result.limit >
                maximum_forecast_limit ) {
                result.limit =
                    maximum_forecast_limit;
            }
        } else if( key == "respect_override" ) {
            result.respect_override =
                require_boolean(
                    value,
                    "services.weather.forecast",
                    key );
        } else {
            throw std::invalid_argument(
                "services.weather.forecast received "
                "unknown option '" + key + "'" );
        }
    }
    const std::int64_t step_turns =
        to_turns<std::int64_t>(
            result.step );
    if( result.step <
        minimum_forecast_step ||
        result.step >
        maximum_forecast_step ) {
        throw std::invalid_argument(
            "services.weather.forecast option 'step' "
            "must be within 1 minute..24 hours" );
    }
    const std::int64_t horizon =
        result.limit == 0 ? 0 :
        step_turns *
        static_cast<std::int64_t>(
            result.limit - 1 );
    if( horizon >
        to_turns<std::int64_t>(
            maximum_forecast_horizon ) ) {
        throw std::invalid_argument(
            "services.weather.forecast horizon "
            "exceeds 14 days" );
    }
    const std::int64_t start_turn =
        to_turn<std::int64_t>(
            result.start );
    if( start_turn < 0 ||
        start_turn >
        to_turn<std::int64_t>(
            calendar::turn_max ) -
        horizon ) {
        throw std::invalid_argument(
            "services.weather.forecast range is "
            "outside turn_zero..turn_max" );
    }
    return result;
}

sol::table forecast_weather(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const forecast_options options =
        read_forecast_options(
            requested );
    const weather_manager &manager =
        get_weather_const();
    const weather_generator &generator =
        manager.get_cur_weather_gen();
    const unsigned seed =
        g->get_seed();

    sol::state_view state( lua );
    sol::table items =
        state.create_table(
            options.limit, 0 );
    for( int index = 0;
         index < options.limit;
         ++index ) {
        const time_point at =
            options.start +
            options.step * index;
        const w_point point =
            generator.get_weather(
                options.position,
                at, seed );
        weather_type_id condition =
            generator.get_weather_conditions(
                point );
        if( options.respect_override &&
            manager.weather_override !=
            WEATHER_NULL ) {
            condition =
                manager.weather_override;
        }
        items[index + 1] =
            snapshot_weather_point(
                state, point,
                condition, at );
    }
    sol::table result =
        state.create_table();
    result["items"] =
        std::move( items );
    result["returned"] =
        options.limit;
    result["limit"] =
        options.limit;
    result["start"] =
        script_time_point::from_native(
            options.start );
    result["step"] =
        script_time_duration::from_native(
            options.step );
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            options.position.raw() );
    result["respected_override"] =
        options.respect_override &&
        manager.weather_override !=
        WEATHER_NULL;
    return result;
}

sol::table refreshed_weather_result(
    sol::this_state lua,
    weather_manager &weather )
{
    weather.set_nextweather(
        calendar::turn );
    sol::state_view state( lua );
    return make_game_value_result(
               state,
               sol::make_object(
                   state,
                   snapshot_current_weather(
                       lua ) ) );
}

sol::table set_weather_override(
    sol::this_state lua,
    const script_game_id &id )
{
    const weather_type &entry =
        resolve_weather(
            id,
            "services.weather.set_override" );
    require_active_game(
        "services.weather.set_override" );
    weather_manager &weather =
        get_weather();
    weather.weather_override =
        entry.id;
    return refreshed_weather_result(
               lua, weather );
}

sol::table clear_weather_override(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.clear_override" );
    weather_manager &weather =
        get_weather();
    weather.weather_override =
        WEATHER_NULL;
    return refreshed_weather_result(
               lua, weather );
}

sol::table set_temperature_override(
    sol::this_state lua,
    const script_unit_value &temperature )
{
    if( temperature.kind() !=
        "temperature" ) {
        throw std::invalid_argument(
            "services.weather.set_temperature_override "
            "requires UnitValue<temperature>" );
    }
    const double kelvin =
        temperature.value_as(
            "kelvin" );
    if( !std::isfinite( kelvin ) ||
        kelvin < 0.0 ||
        kelvin >
        maximum_temperature_kelvin ) {
        throw std::invalid_argument(
            "services.weather.set_temperature_override "
            "must be within 0..1000 kelvin" );
    }
    require_active_game(
        "services.weather.set_temperature_override" );
    weather_manager &weather =
        get_weather();
    weather.forced_temperature =
        units::from_kelvin(
            static_cast<float>(
                kelvin ) );
    weather.clear_temp_cache();
    sol::state_view state( lua );
    return make_game_value_result(
               state,
               sol::make_object(
                   state,
                   snapshot_current_weather(
                       lua ) ) );
}

sol::table clear_temperature_override(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.clear_temperature_override" );
    weather_manager &weather =
        get_weather();
    weather.forced_temperature =
        std::nullopt;
    weather.clear_temp_cache();
    sol::state_view state( lua );
    return make_game_value_result(
               state,
               sol::make_object(
                   state,
                   snapshot_current_weather(
                       lua ) ) );
}

struct wind_options {
    std::optional<int> speed;
    std::optional<int> direction;
    bool clear_speed = false;
    bool clear_direction = false;
    bool changed = false;
};

int require_wind_integer(
    const sol::object &value,
    const std::string &key,
    const int maximum )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            "services.weather.set_wind option '" +
            key + "' must be an integer" );
    }
    const lua_Integer number =
        value.as<lua_Integer>();
    if( number < 0 ||
        number > maximum ) {
        throw std::invalid_argument(
            "services.weather.set_wind option '" +
            key + "' is outside its supported range" );
    }
    return static_cast<int>( number );
}

wind_options read_wind_options(
    const sol::table &requested )
{
    wind_options result;
    for( const auto &option : requested ) {
        const sol::object key_object =
            option.first;
        if( key_object.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "services.weather.set_wind option keys "
                "must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const sol::object value =
            option.second;
        if( key == "speed_mph" ) {
            result.speed =
                require_wind_integer(
                    value, key,
                    maximum_wind_speed_mph );
            result.changed = true;
        } else if( key ==
                   "direction_degrees" ) {
            result.direction =
                require_wind_integer(
                    value, key,
                    maximum_wind_direction_degrees );
            result.changed = true;
        } else if( key ==
                   "clear_speed" ) {
            result.clear_speed =
                require_boolean(
                    value,
                    "services.weather.set_wind",
                    key );
            result.changed =
                result.changed ||
                result.clear_speed;
        } else if( key ==
                   "clear_direction" ) {
            result.clear_direction =
                require_boolean(
                    value,
                    "services.weather.set_wind",
                    key );
            result.changed =
                result.changed ||
                result.clear_direction;
        } else {
            throw std::invalid_argument(
                "services.weather.set_wind received "
                "unknown option '" + key + "'" );
        }
    }
    if( result.speed &&
        result.clear_speed ) {
        throw std::invalid_argument(
            "services.weather.set_wind cannot set and "
            "clear speed together" );
    }
    if( result.direction &&
        result.clear_direction ) {
        throw std::invalid_argument(
            "services.weather.set_wind cannot set and "
            "clear direction together" );
    }
    if( !result.changed ) {
        throw std::invalid_argument(
            "services.weather.set_wind requires at "
            "least one override change" );
    }
    return result;
}

sol::table set_wind(
    sol::this_state lua,
    const sol::table &requested )
{
    const wind_options options =
        read_wind_options(
            requested );
    require_active_game(
        "services.weather.set_wind" );
    weather_manager &weather =
        get_weather();
    if( options.speed ) {
        weather.windspeed_override =
            *options.speed;
    } else if( options.clear_speed ) {
        weather.windspeed_override =
            std::nullopt;
    }
    if( options.direction ) {
        weather.wind_direction_override =
            *options.direction;
    } else if( options.clear_direction ) {
        weather.wind_direction_override =
            std::nullopt;
    }
    return refreshed_weather_result(
               lua, weather );
}

sol::table clear_overrides(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.clear_overrides" );
    weather_manager &weather =
        get_weather();
    weather.weather_override =
        WEATHER_NULL;
    weather.forced_temperature =
        std::nullopt;
    weather.windspeed_override =
        std::nullopt;
    weather.wind_direction_override =
        std::nullopt;
    weather.clear_temp_cache();
    return refreshed_weather_result(
               lua, weather );
}

sol::table refresh_weather(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.refresh" );
    return refreshed_weather_result(
               lua, get_weather() );
}

sol::table activate_lightning(
    sol::this_state lua )
{
    require_active_game(
        "services.weather.activate_lightning" );
    weather_manager &weather =
        get_weather();
    // Preserve the legacy lightning EOC's altitude gate.  The effect only
    // arms lightning for an above-ground player; it never clears a pending
    // strike when the player is underground.
    if( get_player_character().posz() >= 0 ) {
        weather.lightning_active = true;
    }
    sol::state_view state( lua );
    return make_game_value_result(
               state,
               sol::make_object(
                   state,
                   snapshot_current_weather(
                       lua ) ) );
}

sol::table override_light(
    sol::this_state lua, const int level,
    const script_time_duration &requested_duration,
    const sol::optional<std::string> &requested_key )
{
    constexpr std::string_view api_name =
        "services.weather.override_light";
    require_active_game( api_name );
    if( level < 0 ||
        level > maximum_custom_light_level ) {
        throw std::invalid_argument(
            "services.weather.override_light level must be within 0..1000000" );
    }
    const time_duration duration =
        requested_duration.to_native();
    if( duration < 0_turns ||
        duration > maximum_custom_light_duration ) {
        throw std::invalid_argument(
            "services.weather.override_light duration must be within 0 turns..10000 days" );
    }
    const std::string key =
        requested_key.value_or( std::string() );
    if( key.size() >
            maximum_custom_light_key_bytes ||
        key.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.weather.override_light key exceeds 256 bytes" );
    }
    const time_point expires_at =
        calendar::turn + duration + 1_seconds;
    timed_event_manager &timed_events =
        get_timed_events();
    bool replaced = false;
    if( !key.empty() ) {
        if( timed_event *event = timed_events.get(
                timed_event_type::CUSTOM_LIGHT_LEVEL, key ) ) {
            event->when = expires_at;
            event->strength = level;
            replaced = true;
        }
    }
    if( !replaced ) {
        const std::size_t pending =
            static_cast<std::size_t>( std::count_if(
                timed_events.get_all().begin(),
                timed_events.get_all().end(),
        []( const timed_event &event ) {
            return event.type ==
                   timed_event_type::CUSTOM_LIGHT_LEVEL;
        } ) );
        if( pending >= maximum_pending_custom_light_events ) {
            throw std::invalid_argument(
                "services.weather.override_light pending "
                "custom light event limit reached" );
        }
        timed_events.add(
            timed_event_type::CUSTOM_LIGHT_LEVEL,
            expires_at, -1, level, key );
    }

    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["level"] = level;
    value["duration"] = requested_duration;
    value["expires_at"] =
        script_time_point::from_native(
            expires_at );
    value["key"] = key;
    value["accepted"] = true;
    value["replaced"] = replaced;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table weather_limits(
    sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result =
        state.create_table();
    result["catalog_limit"] =
        maximum_weather_limit;
    result["maximum_catalog_offset"] =
        maximum_weather_offset;
    result["maximum_nested_values"] =
        maximum_nested_values;
    result["forecast_limit"] =
        maximum_forecast_limit;
    result["forecast_minimum_step"] =
        script_time_duration::from_native(
            minimum_forecast_step );
    result["forecast_maximum_step"] =
        script_time_duration::from_native(
            maximum_forecast_step );
    result["forecast_maximum_horizon"] =
        script_time_duration::from_native(
            maximum_forecast_horizon );
    result["maximum_wind_speed_mph"] =
        maximum_wind_speed_mph;
    result["maximum_wind_direction_degrees"] =
        maximum_wind_direction_degrees;
    result["maximum_temperature_kelvin"] =
        maximum_temperature_kelvin;
    result["maximum_custom_light_level"] =
        maximum_custom_light_level;
    result["maximum_custom_light_duration"] =
        script_time_duration::from_native(
            maximum_custom_light_duration );
    result["maximum_custom_light_key_bytes"] =
        maximum_custom_light_key_bytes;
    result["maximum_pending_custom_light_events"] =
        maximum_pending_custom_light_events;
    return result;
}

} // namespace

void install_weather_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua(
        services.lua_state() );
    sol::table weather =
        lua.create_table();
    weather.set_function(
        "types",
        [require_read](
            sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_weather_types(
                   state, options );
    } );
    weather.set_function(
        "type",
        [require_read](
            sol::this_state state,
    const script_game_id & id ) {
        require_read();
        return get_weather_type(
                   state, id );
    } );
    weather.set_function(
        "current",
        [require_read](
    sol::this_state state ) {
        require_read();
        return snapshot_current_weather(
                   state );
    } );
    weather.set_function(
        "generator",
        [require_read](
    sol::this_state state ) {
        require_read();
        return snapshot_generator(
                   state );
    } );
    weather.set_function(
        "forecast",
        [require_read](
            sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return forecast_weather(
                   state, options );
    } );
    weather.set_function(
        "limits",
        [require_read](
    sol::this_state state ) {
        require_read();
        return weather_limits(
                   state );
    } );
    weather.set_function(
        "set_override",
        [require_write](
            sol::this_state state,
    const script_game_id & id ) {
        require_write();
        return set_weather_override(
                   state, id );
    } );
    weather.set_function(
        "clear_override",
        [require_write](
    sol::this_state state ) {
        require_write();
        return clear_weather_override(
                   state );
    } );
    weather.set_function(
        "set_temperature_override",
        [require_write](
            sol::this_state state,
    const script_unit_value & temperature ) {
        require_write();
        return set_temperature_override(
                   state, temperature );
    } );
    weather.set_function(
        "clear_temperature_override",
        [require_write](
    sol::this_state state ) {
        require_write();
        return clear_temperature_override(
                   state );
    } );
    weather.set_function(
        "set_wind",
        [require_write](
            sol::this_state state,
    const sol::table & options ) {
        require_write();
        return set_wind(
                   state, options );
    } );
    weather.set_function(
        "clear_overrides",
        [require_write](
    sol::this_state state ) {
        require_write();
        return clear_overrides(
                   state );
    } );
    weather.set_function(
        "refresh",
        [require_write](
    sol::this_state state ) {
        require_write();
        return refresh_weather(
                   state );
    } );
    weather.set_function(
        "activate_lightning",
        [require_write](
    sol::this_state state ) {
        require_write();
        return activate_lightning(
                   state );
    } );
    weather.set_function(
        "override_light",
        [require_write](
            sol::this_state state, const int level,
            const script_time_duration &duration,
            const sol::optional<std::string> &key ) {
        require_write();
        return override_light(
                   state, level, duration, key );
    } );
    services["weather"] =
        std::move( weather );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
