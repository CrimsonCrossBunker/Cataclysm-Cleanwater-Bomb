#include "catalua_ui_interaction.h"

#include <algorithm>
#include <array>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "action.h"
#include "avatar.h"
#include "catalua_bindings_coords.h"
#include "coordinates.h"
#include "game.h"
#include "map.h"
#include "point.h"
#include "popup.h"
#include "sounds.h"
#include "translations.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_sound_id_bytes = 128;
constexpr std::size_t maximum_target_prompt_bytes = 1024;
constexpr int maximum_sound_volume = 128;
constexpr int maximum_sound_fade_ms = 60000;
constexpr int maximum_sound_loops = 100;
constexpr std::size_t maximum_adjacent_candidates = 27;

void require_active_callback(
    const std::function<bool()> &has_active_callback,
    const std::string_view api_name )
{
    if( !has_active_callback() ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " is only available from an active callback" );
    }
}

void require_sound_id(
    const std::string &value, const std::string_view field,
    const std::string_view api_name )
{
    if( value.empty() || value.size() > maximum_sound_id_bytes ||
        value.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) + " " + std::string( field ) +
            " must contain 1 to 128 bytes" );
    }
}

void require_sound_volume(
    const int volume, const std::string_view api_name )
{
    if( volume < 0 || volume > maximum_sound_volume ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " volume must be within 0..128" );
    }
}

double finite_number(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field )
{
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" +
            std::string( field ) + "' must be a number" );
    }
    const double result = value.as<double>();
    if( !std::isfinite( result ) ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" +
            std::string( field ) + "' must be finite" );
    }
    return result;
}

int integer_option(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" +
            std::string( field ) + "' must be an integer" );
    }
    const lua_Integer result = value.as<lua_Integer>();
    if( result < std::numeric_limits<int>::min() ||
        result > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" +
            std::string( field ) + "' is outside the integer range" );
    }
    return static_cast<int>( result );
}

struct variant_sound_options {
    bool has_angle = false;
    double angle_degrees = 0.0;
    double pitch_min = -1.0;
    double pitch_max = -1.0;
    bool has_pitch = false;
};

void validate_pitch_range(
    const double minimum, const double maximum,
    const std::string_view api_name )
{
    const bool engine_default = minimum == -1.0 && maximum == -1.0;
    if( engine_default ) {
        return;
    }
    if( minimum < 0.25 || maximum > 4.0 || minimum > maximum ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " pitch range must be -1/-1 or ordered within 0.25..4" );
    }
}

variant_sound_options read_variant_sound_options(
    const sol::optional<sol::table> &requested )
{
    variant_sound_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.sound.play option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "angle_degrees" ) {
            result.angle_degrees = finite_number(
                                       entry.second, "game.sound.play", key );
            if( result.angle_degrees < -360.0 ||
                result.angle_degrees > 360.0 ) {
                throw std::invalid_argument(
                    "game.sound.play angle_degrees must be within -360..360" );
            }
            result.has_angle = true;
        } else if( key == "pitch_min" ) {
            result.pitch_min = finite_number(
                                   entry.second, "game.sound.play", key );
            result.has_pitch = true;
        } else if( key == "pitch_max" ) {
            result.pitch_max = finite_number(
                                   entry.second, "game.sound.play", key );
            result.has_pitch = true;
        } else {
            throw std::invalid_argument(
                "game.sound.play received unknown option '" + key + "'" );
        }
    }
    if( result.has_pitch && !result.has_angle ) {
        throw std::invalid_argument(
            "game.sound.play pitch options require angle_degrees" );
    }
    validate_pitch_range(
        result.pitch_min, result.pitch_max, "game.sound.play" );
    return result;
}

void play_variant_sound(
    const std::string &id, const std::string &variant,
    const int volume, const sol::optional<sol::table> &requested )
{
    require_sound_id( id, "id", "game.sound.play" );
    require_sound_id( variant, "variant", "game.sound.play" );
    require_sound_volume( volume, "game.sound.play" );
    const variant_sound_options options =
        read_variant_sound_options( requested );
    if( options.has_angle ) {
        sfx::play_variant_sound(
            id, variant, volume,
            units::from_degrees( options.angle_degrees ),
            options.pitch_min, options.pitch_max );
    } else {
        sfx::play_variant_sound( id, variant, volume );
    }
}

const std::array<std::pair<std::string_view, sfx::channel>, 31>
ambient_channel_names = {{
        { "any", sfx::channel::any },
        { "daytime_outdoors_env", sfx::channel::daytime_outdoors_env },
        { "nighttime_outdoors_env", sfx::channel::nighttime_outdoors_env },
        { "underground_env", sfx::channel::underground_env },
        { "indoors_env", sfx::channel::indoors_env },
        { "indoors_rain_env", sfx::channel::indoors_rain_env },
        { "outdoors_snow_env", sfx::channel::outdoors_snow_env },
        { "outdoors_flurry_env", sfx::channel::outdoors_flurry_env },
        { "outdoors_thunderstorm_env", sfx::channel::outdoors_thunderstorm_env },
        { "outdoors_rainstorm_env", sfx::channel::outdoors_rainstorm_env },
        { "outdoors_rain_env", sfx::channel::outdoors_rain_env },
        { "outdoors_drizzle_env", sfx::channel::outdoors_drizzle_env },
        { "outdoor_blizzard", sfx::channel::outdoor_blizzard },
        { "deafness_tone", sfx::channel::deafness_tone },
        { "danger_extreme_theme", sfx::channel::danger_extreme_theme },
        { "danger_high_theme", sfx::channel::danger_high_theme },
        { "danger_medium_theme", sfx::channel::danger_medium_theme },
        { "danger_low_theme", sfx::channel::danger_low_theme },
        { "stamina_75", sfx::channel::stamina_75 },
        { "stamina_50", sfx::channel::stamina_50 },
        { "stamina_35", sfx::channel::stamina_35 },
        { "idle_chainsaw", sfx::channel::idle_chainsaw },
        { "chainsaw_theme", sfx::channel::chainsaw_theme },
        { "player_activities", sfx::channel::player_activities },
        { "exterior_engine_sound", sfx::channel::exterior_engine_sound },
        { "interior_engine_sound", sfx::channel::interior_engine_sound },
        { "radio", sfx::channel::radio },
        { "outdoors_portal_storm_env", sfx::channel::outdoors_portal_storm_env },
        { "outdoors_clear_env", sfx::channel::outdoors_clear_env },
        { "outdoors_cloudy_env", sfx::channel::outdoors_cloudy_env },
        { "outdoors_sunny_env", sfx::channel::outdoors_sunny_env }
    }
};

sfx::channel ambient_channel_from_name( const std::string &name )
{
    const auto found = std::find_if(
                           ambient_channel_names.begin(),
                           ambient_channel_names.end(),
    [&name]( const auto & entry ) {
        return entry.first == name;
    } );
    if( found == ambient_channel_names.end() ) {
        throw std::invalid_argument(
            "game.sound.play_ambient received unknown channel '" +
            name + "'" );
    }
    return found->second;
}

struct ambient_sound_options {
    sfx::channel channel = sfx::channel::any;
    int fade_in_ms = 0;
    double pitch = -1.0;
    int loops = 0;
};

ambient_sound_options read_ambient_sound_options(
    const sol::optional<sol::table> &requested )
{
    ambient_sound_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.sound.play_ambient option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "channel" ) {
            if( entry.second.get_type() != sol::type::string ) {
                throw std::invalid_argument(
                    "game.sound.play_ambient option 'channel' "
                    "must be a string" );
            }
            result.channel = ambient_channel_from_name(
                                 entry.second.as<std::string>() );
        } else if( key == "fade_in_ms" ) {
            result.fade_in_ms = integer_option(
                                    entry.second,
                                    "game.sound.play_ambient", key );
        } else if( key == "pitch" ) {
            result.pitch = finite_number(
                               entry.second,
                               "game.sound.play_ambient", key );
        } else if( key == "loops" ) {
            result.loops = integer_option(
                               entry.second,
                               "game.sound.play_ambient", key );
        } else {
            throw std::invalid_argument(
                "game.sound.play_ambient received unknown option '" +
                key + "'" );
        }
    }
    if( result.fade_in_ms < 0 ||
        result.fade_in_ms > maximum_sound_fade_ms ) {
        throw std::invalid_argument(
            "game.sound.play_ambient fade_in_ms must be within 0..60000" );
    }
    if( result.pitch != -1.0 &&
        ( result.pitch < 0.25 || result.pitch > 4.0 ) ) {
        throw std::invalid_argument(
            "game.sound.play_ambient pitch must be -1 or within 0.25..4" );
    }
    if( result.loops < -1 || result.loops > maximum_sound_loops ) {
        throw std::invalid_argument(
            "game.sound.play_ambient loops must be within -1..100" );
    }
    return result;
}

void play_ambient_sound(
    const std::string &id, const std::string &variant,
    const int volume, const sol::optional<sol::table> &requested )
{
    require_sound_id( id, "id", "game.sound.play_ambient" );
    require_sound_id(
        variant, "variant", "game.sound.play_ambient" );
    require_sound_volume( volume, "game.sound.play_ambient" );
    const ambient_sound_options options =
        read_ambient_sound_options( requested );
    sfx::play_ambient_variant_sound(
        id, variant, volume, options.channel,
        options.fade_in_ms, options.pitch, options.loops );
}

void require_target_prompt(
    const std::string &value, const std::string_view field,
    const std::string_view api_name )
{
    if( value.size() > maximum_target_prompt_bytes ||
        value.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) + " " + std::string( field ) +
            " exceeds the 1024-byte limit" );
    }
}

map &require_active_map( const std::string_view api_name )
{
    if( g == nullptr ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " requires an active game" );
    }
    return get_map();
}

tripoint_bub_ms require_loaded_position(
    map &here, const script_tripoint_coord &position,
    const std::string_view api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    const tripoint_abs_ms absolute( position.to_native() );
    if( !here.inbounds( absolute ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " position is outside the active map" );
    }
    return here.get_bub( absolute );
}

sol::object absolute_selection(
    sol::state_view state, map &here,
    const std::optional<tripoint_bub_ms> &selected )
{
    if( !selected ) {
        return sol::make_object( state, sol::nil );
    }
    return sol::make_object(
               state,
               script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   here.get_abs( *selected ).raw() ) );
}

sol::object relative_selection(
    sol::state_view state,
    const std::optional<tripoint_rel_ms> &selected )
{
    if( !selected ) {
        return sol::make_object( state, sol::nil );
    }
    return sol::make_object(
               state,
               script_tripoint_coord::from_native(
                   coords::origin::relative,
                   coords::scale::map_square,
                   selected->raw() ) );
}

sol::object choose_adjacent_position(
    sol::this_state lua, const std::string &message,
    const bool allow_vertical )
{
    require_target_prompt(
        message, "message", "game.targeting.choose_adjacent" );
    map &here = require_active_map(
                    "game.targeting.choose_adjacent" );
    return absolute_selection(
               sol::state_view( lua ), here,
               choose_adjacent( message, allow_vertical ) );
}

sol::object choose_direction_offset(
    sol::this_state lua, const std::string &message,
    const bool allow_vertical )
{
    require_target_prompt(
        message, "message", "game.targeting.choose_direction" );
    require_active_map( "game.targeting.choose_direction" );
    return relative_selection(
               sol::state_view( lua ),
               choose_direction( message, allow_vertical ) );
}

sol::object look_around_position( sol::this_state lua )
{
    map &here = require_active_map(
                    "game.targeting.look_around" );
    return absolute_selection(
               sol::state_view( lua ), here, g->look_around() );
}

sol::object choose_area(
    sol::this_state lua, const std::string &message,
    const sol::optional<script_tripoint_coord> &requested_start,
    const bool allow_vertical )
{
    require_target_prompt(
        message, "message", "game.targeting.choose_area" );
    map &here = require_active_map(
                    "game.targeting.choose_area" );
    avatar &player = get_avatar();
    tripoint_bub_ms center =
        player.pos_bub( here ) + player.view_offset;
    if( requested_start ) {
        center = require_loaded_position(
                     here, *requested_start,
                     "game.targeting.choose_area" );
    }

    static_popup popup;
    popup.on_top( true );
    popup.message(
        "%s (%s)", message, _( "Select first point." ) );
    const look_around_result first = g->look_around(
                                         false, center, center, false, true, false,
                                         false, tripoint_bub_ms::zero,
                                         allow_vertical );
    sol::state_view state( lua );
    if( !first.position ) {
        return sol::make_object( state, sol::nil );
    }

    popup.message(
        "%s (%s)", message, _( "Select second point." ) );
    const look_around_result second = g->look_around(
                                          false, center, *first.position, true, true, false,
                                          false, tripoint_bub_ms::zero,
                                          allow_vertical );
    if( !second.position ) {
        return sol::make_object( state, sol::nil );
    }

    const tripoint_bub_ms minimum(
        std::min( first.position->x(), second.position->x() ),
        std::min( first.position->y(), second.position->y() ),
        std::min( first.position->z(), second.position->z() ) );
    const tripoint_bub_ms maximum(
        std::max( first.position->x(), second.position->x() ),
        std::max( first.position->y(), second.position->y() ),
        std::max( first.position->z(), second.position->z() ) );
    sol::table result = state.create_table();
    result["first"] = script_tripoint_coord::from_native(
                          coords::origin::abs, coords::scale::map_square,
                          here.get_abs( minimum ).raw() );
    result["second"] = script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           here.get_abs( maximum ).raw() );
    return sol::make_object( state, std::move( result ) );
}

sol::object choose_adjacent_for_action(
    sol::this_state lua, const std::string &message,
    const std::string &failure_message,
    const std::string &action_name,
    const bool allow_vertical,
    const bool allow_autoselect )
{
    require_target_prompt(
        message, "message",
        "game.targeting.choose_adjacent_for_action" );
    require_target_prompt(
        failure_message, "failure_message",
        "game.targeting.choose_adjacent_for_action" );
    const action_id action = look_up_action( action_name );
    if( action == ACTION_NULL ) {
        throw std::invalid_argument(
            "game.targeting.choose_adjacent_for_action received "
            "an unknown action id" );
    }
    map &here = require_active_map(
                    "game.targeting.choose_adjacent_for_action" );
    return absolute_selection(
               sol::state_view( lua ), here,
               choose_adjacent_highlight(
                   here, message, failure_message, action,
                   allow_vertical, allow_autoselect ) );
}

std::vector<tripoint_bub_ms> read_adjacent_candidates(
    map &here, const sol::table &requested )
{
    if( requested.size() > maximum_adjacent_candidates ) {
        throw std::invalid_argument(
            "game.targeting.choose_adjacent_where accepts "
            "at most 27 candidates" );
    }
    const tripoint_bub_ms origin = get_avatar().pos_bub( here );
    std::vector<tripoint_bub_ms> result;
    result.reserve( requested.size() );
    for( std::size_t index = 1; index <= requested.size(); ++index ) {
        const sol::object value = requested[index];
        if( !value.is<script_tripoint_coord>() ) {
            throw std::invalid_argument(
                "game.targeting.choose_adjacent_where candidates "
                "must be Tripoint values" );
        }
        const tripoint_bub_ms candidate = require_loaded_position(
                                              here, value.as<script_tripoint_coord>(),
                                              "game.targeting.choose_adjacent_where" );
        const tripoint delta = ( candidate - origin ).raw();
        if( std::abs( delta.x ) > 1 ||
            std::abs( delta.y ) > 1 ||
            std::abs( delta.z ) > 1 ) {
            throw std::invalid_argument(
                "game.targeting.choose_adjacent_where candidate "
                "is not adjacent to the avatar" );
        }
        result.push_back( candidate );
    }
    std::sort( result.begin(), result.end() );
    result.erase(
        std::unique( result.begin(), result.end() ),
        result.end() );
    return result;
}

sol::object choose_adjacent_where(
    sol::this_state lua, const std::string &message,
    const std::string &failure_message,
    const sol::table &requested_candidates,
    const bool allow_vertical,
    const bool allow_autoselect )
{
    require_target_prompt(
        message, "message",
        "game.targeting.choose_adjacent_where" );
    require_target_prompt(
        failure_message, "failure_message",
        "game.targeting.choose_adjacent_where" );
    map &here = require_active_map(
                    "game.targeting.choose_adjacent_where" );
    const std::vector<tripoint_bub_ms> candidates =
        read_adjacent_candidates( here, requested_candidates );
    return absolute_selection(
               sol::state_view( lua ), here,
               choose_adjacent_highlight(
                   here, message, failure_message,
    [&candidates]( const tripoint_bub_ms & position ) {
        return std::binary_search(
                   candidates.begin(), candidates.end(), position );
    },
    allow_vertical, allow_autoselect ) );
}

} // namespace

void install_game_interaction_api(
    sol::table &game,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback )
{
    sol::state_view state( game.lua_state() );

    sol::table sound = state.create_table();
    sound.set_function(
        "play",
        [require_actions, has_active_callback](
            const std::string & id, const std::string & variant,
    const int volume, const sol::optional<sol::table> &options ) {
        require_actions();
        require_active_callback(
            has_active_callback, "game.sound.play" );
        play_variant_sound( id, variant, volume, options );
    } );
    sound.set_function(
        "play_ambient",
        [require_actions, has_active_callback](
            const std::string & id, const std::string & variant,
    const int volume, const sol::optional<sol::table> &options ) {
        require_actions();
        require_active_callback(
            has_active_callback, "game.sound.play_ambient" );
        play_ambient_sound( id, variant, volume, options );
    } );
    sound.set_function(
        "channels",
    [require_actions]( sol::this_state lua ) {
        require_actions();
        sol::state_view lua_state( lua );
        sol::table result = lua_state.create_table(
                                static_cast<int>( ambient_channel_names.size() ), 0 );
        for( std::size_t index = 0;
             index < ambient_channel_names.size(); ++index ) {
            result[index + 1] =
                std::string( ambient_channel_names[index].first );
        }
        return result;
    } );
    game["sound"] = std::move( sound );

    const auto authorize = [
                               require_actions,
                               has_active_callback
    ]( const std::string_view api_name ) {
        require_actions();
        require_active_callback(
            has_active_callback, api_name );
    };
    sol::table targeting = state.create_table();
    targeting.set_function(
        "choose_adjacent",
        [authorize](
            sol::this_state lua, const std::string & message,
    const sol::optional<bool> &allow_vertical ) {
        authorize( "game.targeting.choose_adjacent" );
        return choose_adjacent_position(
                   lua, message, allow_vertical.value_or( false ) );
    } );
    targeting.set_function(
        "choose_direction",
        [authorize](
            sol::this_state lua, const std::string & message,
    const sol::optional<bool> &allow_vertical ) {
        authorize( "game.targeting.choose_direction" );
        return choose_direction_offset(
                   lua, message, allow_vertical.value_or( false ) );
    } );
    targeting.set_function(
        "look_around",
    [authorize]( sol::this_state lua ) {
        authorize( "game.targeting.look_around" );
        return look_around_position( lua );
    } );
    targeting.set_function(
        "choose_area",
        [authorize](
            sol::this_state lua, const std::string & message,
            const sol::optional<script_tripoint_coord> &start,
    const sol::optional<bool> &allow_vertical ) {
        authorize( "game.targeting.choose_area" );
        return choose_area(
                   lua, message, start,
                   allow_vertical.value_or( false ) );
    } );
    targeting.set_function(
        "choose_adjacent_for_action",
        [authorize](
            sol::this_state lua, const std::string & message,
            const std::string & failure_message,
            const std::string & action,
            const sol::optional<bool> &allow_vertical,
    const sol::optional<bool> &allow_autoselect ) {
        authorize(
            "game.targeting.choose_adjacent_for_action" );
        return choose_adjacent_for_action(
                   lua, message, failure_message, action,
                   allow_vertical.value_or( false ),
                   allow_autoselect.value_or( true ) );
    } );
    targeting.set_function(
        "choose_adjacent_where",
        [authorize](
            sol::this_state lua, const std::string & message,
            const std::string & failure_message,
            const sol::table & candidates,
            const sol::optional<bool> &allow_vertical,
    const sol::optional<bool> &allow_autoselect ) {
        authorize( "game.targeting.choose_adjacent_where" );
        return choose_adjacent_where(
                   lua, message, failure_message, candidates,
                   allow_vertical.value_or( false ),
                   allow_autoselect.value_or( true ) );
    } );
    game["targeting"] = std::move( targeting );
}

} // namespace cata::lua_ui
