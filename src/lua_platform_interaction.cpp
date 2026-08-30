#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_interaction.h"

#include <algorithm>
#include <array>
#include <cctype>
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
#include "lua_platform_bindings_coords.h"
#include "coordinates.h"
#include "game.h"
#include "input_popup.h"
#include "map.h"
#include "overmap_ui.h"
#include "output.h"
#include "point.h"
#include "popup.h"
#include "ranged.h"
#include "sounds.h"
#include "translations.h"
#include "uilist.h"
#include "units.h"

namespace cata::lua_platform
{

namespace
{

constexpr std::size_t maximum_sound_id_bytes = 128;
constexpr std::size_t maximum_target_prompt_bytes = 1024;
constexpr int maximum_sound_volume = 128;
constexpr int maximum_gameplay_sound_volume = 1000;
constexpr int maximum_sound_fade_ms = 60000;
constexpr int maximum_sound_loops = 100;
constexpr std::size_t maximum_adjacent_candidates = 27;
constexpr std::size_t maximum_sound_description_bytes = 4096;
constexpr int maximum_targeting_range = 1000;
constexpr std::size_t maximum_interaction_text_bytes = 4096;
constexpr std::size_t maximum_interaction_identifier_bytes = 128;
constexpr std::size_t maximum_interaction_choices = 256;

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
                "services.sound.play option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "angle_degrees" ) {
            result.angle_degrees = finite_number(
                                       entry.second, "services.sound.play", key );
            if( result.angle_degrees < -360.0 ||
                result.angle_degrees > 360.0 ) {
                throw std::invalid_argument(
                    "services.sound.play angle_degrees must be within -360..360" );
            }
            result.has_angle = true;
        } else if( key == "pitch_min" ) {
            result.pitch_min = finite_number(
                                   entry.second, "services.sound.play", key );
            result.has_pitch = true;
        } else if( key == "pitch_max" ) {
            result.pitch_max = finite_number(
                                   entry.second, "services.sound.play", key );
            result.has_pitch = true;
        } else {
            throw std::invalid_argument(
                "services.sound.play received unknown option '" + key + "'" );
        }
    }
    if( result.has_pitch && !result.has_angle ) {
        throw std::invalid_argument(
            "services.sound.play pitch options require angle_degrees" );
    }
    validate_pitch_range(
        result.pitch_min, result.pitch_max, "services.sound.play" );
    return result;
}

void play_variant_sound(
    const std::string &id, const std::string &variant,
    const int volume, const sol::optional<sol::table> &requested )
{
    require_sound_id( id, "id", "services.sound.play" );
    require_sound_id( variant, "variant", "services.sound.play" );
    require_sound_volume( volume, "services.sound.play" );
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
            "services.sound.play_ambient received unknown channel '" +
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
                "services.sound.play_ambient option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "channel" ) {
            if( entry.second.get_type() != sol::type::string ) {
                throw std::invalid_argument(
                    "services.sound.play_ambient option 'channel' "
                    "must be a string" );
            }
            result.channel = ambient_channel_from_name(
                                 entry.second.as<std::string>() );
        } else if( key == "fade_in_ms" ) {
            result.fade_in_ms = integer_option(
                                    entry.second,
                                    "services.sound.play_ambient", key );
        } else if( key == "pitch" ) {
            result.pitch = finite_number(
                               entry.second,
                               "services.sound.play_ambient", key );
        } else if( key == "loops" ) {
            result.loops = integer_option(
                               entry.second,
                               "services.sound.play_ambient", key );
        } else {
            throw std::invalid_argument(
                "services.sound.play_ambient received unknown option '" +
                key + "'" );
        }
    }
    if( result.fade_in_ms < 0 ||
        result.fade_in_ms > maximum_sound_fade_ms ) {
        throw std::invalid_argument(
            "services.sound.play_ambient fade_in_ms must be within 0..60000" );
    }
    if( result.pitch != -1.0 &&
        ( result.pitch < 0.25 || result.pitch > 4.0 ) ) {
        throw std::invalid_argument(
            "services.sound.play_ambient pitch must be -1 or within 0.25..4" );
    }
    if( result.loops < -1 || result.loops > maximum_sound_loops ) {
        throw std::invalid_argument(
            "services.sound.play_ambient loops must be within -1..100" );
    }
    return result;
}

void play_ambient_sound(
    const std::string &id, const std::string &variant,
    const int volume, const sol::optional<sol::table> &requested )
{
    require_sound_id( id, "id", "services.sound.play_ambient" );
    require_sound_id(
        variant, "variant", "services.sound.play_ambient" );
    require_sound_volume( volume, "services.sound.play_ambient" );
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

sounds::sound_t gameplay_sound_type(
    const std::string &name )
{
    if( name == "background" ) {
        return sounds::sound_t::background;
    }
    if( name == "weather" ) {
        return sounds::sound_t::weather;
    }
    if( name == "sensory" ) {
        return sounds::sound_t::sensory;
    }
    if( name == "music" ) {
        return sounds::sound_t::music;
    }
    if( name == "movement" ) {
        return sounds::sound_t::movement;
    }
    if( name == "speech" ) {
        return sounds::sound_t::speech;
    }
    if( name == "electronic_speech" ) {
        return sounds::sound_t::electronic_speech;
    }
    if( name == "activity" ) {
        return sounds::sound_t::activity;
    }
    if( name == "destructive_activity" ) {
        return sounds::sound_t::destructive_activity;
    }
    if( name == "alarm" ) {
        return sounds::sound_t::alarm;
    }
    if( name == "combat" ) {
        return sounds::sound_t::combat;
    }
    if( name == "alert" ) {
        return sounds::sound_t::alert;
    }
    if( name == "order" ) {
        return sounds::sound_t::order;
    }
    throw std::invalid_argument(
        "services.sound.emit received unknown category '" + name + "'" );
}

void emit_gameplay_sound(
    const script_tripoint_coord &position, const int volume,
    const std::string &category, const std::string &description,
    const sol::optional<bool> &ambient,
    const sol::optional<std::string> &id,
    const sol::optional<std::string> &variant )
{
    constexpr std::string_view api_name = "services.sound.emit";
    if( volume < 0 || volume > maximum_gameplay_sound_volume ) {
        throw std::invalid_argument(
            "services.sound.emit volume must be within 0..1000" );
    }
    if( description.size() > maximum_sound_description_bytes ||
        description.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.sound.emit description exceeds its bounded string limit" );
    }
    if( id && !id->empty() ) {
        require_sound_id( *id, "id", api_name );
    }
    if( variant && !variant->empty() ) {
        require_sound_id( *variant, "variant", api_name );
    }
    map &here = require_active_map( api_name );
    const tripoint_bub_ms local =
        require_loaded_position( here, position, api_name );
    sounds::sound(
        local, volume, gameplay_sound_type( category ),
        description, ambient.value_or( false ),
        id.value_or( std::string() ),
        variant.value_or( "default" ) );
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
        message, "message", "services.targeting.choose_adjacent" );
    map &here = require_active_map(
                    "services.targeting.choose_adjacent" );
    return absolute_selection(
               sol::state_view( lua ), here,
               choose_adjacent( message, allow_vertical ) );
}

sol::object choose_direction_offset(
    sol::this_state lua, const std::string &message,
    const bool allow_vertical )
{
    require_target_prompt(
        message, "message", "services.targeting.choose_direction" );
    require_active_map( "services.targeting.choose_direction" );
    return relative_selection(
               sol::state_view( lua ),
               choose_direction( message, allow_vertical ) );
}

sol::object look_around_position( sol::this_state lua )
{
    map &here = require_active_map(
                    "services.targeting.look_around" );
    return absolute_selection(
               sol::state_view( lua ), here, g->look_around() );
}

sol::object choose_map_square(
    sol::this_state lua, const std::string &message,
    const sol::optional<script_tripoint_coord> &requested_center,
    const bool allow_vertical )
{
    require_target_prompt(
        message, "message", "services.targeting.choose_map_square" );
    map &here = require_active_map(
                    "services.targeting.choose_map_square" );
    avatar &player = get_avatar();
    tripoint_bub_ms center =
        player.pos_bub( here ) + player.view_offset;
    if( requested_center ) {
        center = require_loaded_position(
                     here, *requested_center,
                     "services.targeting.choose_map_square" );
    }
    if( !message.empty() ) {
        static_popup popup;
        popup.on_top( true );
        popup.message( "%s", message );
    }
    const look_around_params parameters = {
        true, center, center, false, true, true, allow_vertical
    };
    return absolute_selection(
               sol::state_view( lua ), here,
               g->look_around( parameters ).position );
}

sol::object choose_visible_map_square(
    sol::this_state lua, const std::string &message,
    const int range )
{
    require_target_prompt(
        message, "message",
        "services.targeting.choose_visible_map_square" );
    map &here = require_active_map(
                    "services.targeting.choose_visible_map_square" );
    if( range < 0 || range > maximum_targeting_range ) {
        throw std::invalid_argument(
            "services.targeting.choose_visible_map_square range must be within 0..1000" );
    }
    if( !message.empty() ) {
        static_popup popup;
        popup.on_top( true );
        popup.message( "%s", message );
    }
    avatar viewpoint;
    viewpoint.set_pos_abs_only( get_avatar().pos_abs() );
    const target_handler::trajectory trajectory =
        target_handler::mode_select_only( viewpoint, range );
    if( trajectory.empty() ) {
        return sol::make_object(
                   sol::state_view( lua ), sol::nil );
    }
    return sol::make_object(
               sol::state_view( lua ),
               script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   here.get_abs( trajectory.back() ).raw() ) );
}

tripoint_abs_omt require_overmap_center(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ) {
        throw std::invalid_argument(
            api_name + " center must use absolute coordinates" );
    }
    if( position.native_scale() ==
        coords::scale::overmap_terrain ) {
        return tripoint_abs_omt( position.to_native() );
    }
    if( position.native_scale() ==
        coords::scale::map_square ) {
        return project_to<coords::omt>(
                   tripoint_abs_ms( position.to_native() ) );
    }
    throw std::invalid_argument(
        api_name +
        " center must be an absolute map-square or overmap-terrain Tripoint" );
}

sol::object choose_overmap_point(
    sol::this_state lua, const std::string &message,
    const sol::optional<script_tripoint_coord> &requested_center,
    const sol::optional<int> &requested_distance )
{
    constexpr std::string_view api_name =
        "services.targeting.choose_overmap_point";
    require_target_prompt(
        message, "message", api_name );
    require_active_map( api_name );
    const tripoint_abs_omt center = requested_center ?
                                    require_overmap_center(
                                        *requested_center,
                                        std::string( api_name ) ) :
                                    get_avatar().pos_abs_omt();
    const int distance = requested_distance.value_or(
                             std::numeric_limits<int>::max() );
    if( distance < 0 ||
        ( requested_distance &&
          distance > maximum_targeting_range ) ) {
        throw std::invalid_argument(
            "services.targeting.choose_overmap_point distance must be within 0..1000" );
    }
    if( requested_distance ) {
        ui::omap::range_mark( center, distance );
    }
    const tripoint_abs_omt selected =
        ui::omap::choose_point(
            message, center, false, distance );
    if( requested_distance ) {
        ui::omap::range_mark( center, distance, false );
    }
    if( selected == tripoint_abs_omt::invalid ) {
        return sol::make_object(
                   sol::state_view( lua ), sol::nil );
    }
    return sol::make_object(
               sol::state_view( lua ),
               script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::overmap_terrain,
                   selected.raw() ) );
}

sol::object choose_area(
    sol::this_state lua, const std::string &message,
    const sol::optional<script_tripoint_coord> &requested_start,
    const bool allow_vertical )
{
    require_target_prompt(
        message, "message", "services.targeting.choose_area" );
    map &here = require_active_map(
                    "services.targeting.choose_area" );
    avatar &player = get_avatar();
    tripoint_bub_ms center =
        player.pos_bub( here ) + player.view_offset;
    if( requested_start ) {
        center = require_loaded_position(
                     here, *requested_start,
                     "services.targeting.choose_area" );
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
        "services.targeting.choose_adjacent_for_action" );
    require_target_prompt(
        failure_message, "failure_message",
        "services.targeting.choose_adjacent_for_action" );
    const action_id action = look_up_action( action_name );
    if( action == ACTION_NULL ) {
        throw std::invalid_argument(
            "services.targeting.choose_adjacent_for_action received "
            "an unknown action id" );
    }
    map &here = require_active_map(
                    "services.targeting.choose_adjacent_for_action" );
    return absolute_selection(
               sol::state_view( lua ), here,
               choose_adjacent_highlight(
                   here, message, failure_message, action,
                   allow_vertical, allow_autoselect ) );
}

std::vector<tripoint_bub_ms> read_adjacent_candidates(
    map &here, const sol::table &requested,
    const tripoint_bub_ms &origin,
    const std::string &api_name )
{
    if( requested.size() > maximum_adjacent_candidates ) {
        throw std::invalid_argument(
            api_name + " accepts "
            "at most 27 candidates" );
    }
    std::vector<tripoint_bub_ms> result;
    result.reserve( requested.size() );
    for( std::size_t index = 1; index <= requested.size(); ++index ) {
        const sol::object value = requested[index];
        if( !value.is<script_tripoint_coord>() ) {
            throw std::invalid_argument(
                api_name + " candidates "
                "must be Tripoint values" );
        }
        const tripoint_bub_ms candidate = require_loaded_position(
                                              here, value.as<script_tripoint_coord>(),
                                              api_name );
        const tripoint delta = ( candidate - origin ).raw();
        if( std::abs( delta.x ) > 1 ||
            std::abs( delta.y ) > 1 ||
            std::abs( delta.z ) > 1 ) {
            throw std::invalid_argument(
                api_name + " candidate "
                "is not adjacent to the requested center" );
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
        "services.targeting.choose_adjacent_where" );
    require_target_prompt(
        failure_message, "failure_message",
        "services.targeting.choose_adjacent_where" );
    map &here = require_active_map(
                    "services.targeting.choose_adjacent_where" );
    const tripoint_bub_ms center =
        get_avatar().pos_bub( here );
    const std::vector<tripoint_bub_ms> candidates =
        read_adjacent_candidates(
            here, requested_candidates, center,
            "services.targeting.choose_adjacent_where" );
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

sol::object choose_adjacent_where_at(
    sol::this_state lua,
    const script_tripoint_coord &requested_center,
    const std::string &message,
    const std::string &failure_message,
    const sol::table &requested_candidates,
    const bool allow_vertical,
    const bool allow_autoselect )
{
    constexpr std::string_view api_name =
        "services.targeting.choose_adjacent_where_at";
    require_target_prompt(
        message, "message", api_name );
    require_target_prompt(
        failure_message, "failure_message", api_name );
    map &here = require_active_map( api_name );
    const tripoint_bub_ms center =
        require_loaded_position(
            here, requested_center,
            std::string( api_name ) );
    const std::vector<tripoint_bub_ms> candidates =
        read_adjacent_candidates(
            here, requested_candidates, center,
            std::string( api_name ) );
    return absolute_selection(
               sol::state_view( lua ), here,
               choose_adjacent_highlight(
                   here, center, message, failure_message,
    [&candidates]( const tripoint_bub_ms & position ) {
        return std::binary_search(
                   candidates.begin(), candidates.end(), position );
    },
    allow_vertical, allow_autoselect ) );
}

struct text_input_options {
    std::string description;
    std::string default_text;
    std::string identifier;
    int width = 40;
};

std::string bounded_interaction_text(
    const sol::object &value, const std::string &field,
    const std::size_t maximum )
{
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument(
            "services.interaction.input_text option '" + field +
            "' must be a string" );
    }
    const std::string result = value.as<std::string>();
    if( result.size() > maximum ||
        result.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.interaction.input_text option '" + field +
            "' exceeds its native text bound" );
    }
    return result;
}

text_input_options read_text_input_options(
    const sol::optional<sol::table> &requested )
{
    text_input_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.interaction.input_text option names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "description" ) {
            result.description = bounded_interaction_text(
                                     entry.second, key,
                                     maximum_interaction_text_bytes );
        } else if( key == "default" ) {
            result.default_text = bounded_interaction_text(
                                      entry.second, key,
                                      maximum_interaction_text_bytes );
        } else if( key == "identifier" ) {
            result.identifier = bounded_interaction_text(
                                    entry.second, key,
                                    maximum_interaction_identifier_bytes );
        } else if( key == "width" ) {
            result.width = integer_option(
                               entry.second,
                               "services.interaction.input_text", key );
            if( result.width < 10 || result.width > 240 ) {
                throw std::invalid_argument(
                    "services.interaction.input_text width must be within 10..240" );
            }
        } else {
            throw std::invalid_argument(
                "services.interaction.input_text received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

bool confirm_interaction( const std::string &message )
{
    require_target_prompt(
        message, "message", "services.interaction.confirm" );
    return query_yn( message );
}

sol::table input_interaction_text(
    sol::this_state lua, const std::string &title,
    const sol::optional<sol::table> &requested_options )
{
    require_target_prompt(
        title, "title", "services.interaction.input_text" );
    const text_input_options options =
        read_text_input_options( requested_options );
    string_input_popup_imgui popup(
        options.width, options.default_text );
    popup.set_label( title );
    popup.set_description( options.description );
    popup.set_identifier( options.identifier );
    popup.set_max_input_length(
        static_cast<int>( maximum_interaction_text_bytes ) );
    const std::string entered = popup.query();
    const bool accepted = !popup.cancelled();
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["cancelled"] = !accepted;
    value["value"] = accepted ? entered : options.default_text;
    return value;
}

sol::table input_interaction_number(
    sol::this_state lua, const std::string &description,
    const int default_value )
{
    require_target_prompt(
        description, "description",
        "services.interaction.input_number" );
    number_input_popup<int> popup( 55, default_value );
    popup.set_label( _( "Input a value:" ) );
    popup.set_description( description );
    const int entered = popup.query();
    const bool accepted = !popup.cancelled();
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["cancelled"] = !accepted;
    value["value"] = accepted ? entered : default_value;
    return value;
}

struct interaction_choice {
    std::string id;
    std::string label;
    std::string description;
    bool enabled = true;
    int hotkey = MENU_AUTOASSIGN;
};

struct interaction_choice_options {
    std::string title = "Select an option.";
    bool allow_cancel = true;
    bool highlight_disabled = false;
};

std::string required_choice_text(
    const sol::table &entry, const std::string &field,
    const std::size_t maximum )
{
    const sol::object value = entry[field];
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument(
            "services.interaction.choose entries require string '" +
            field + "' fields" );
    }
    const std::string result = value.as<std::string>();
    if( result.empty() || result.size() > maximum ||
        result.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.interaction.choose entry '" + field +
            "' is outside its native text bound" );
    }
    return result;
}

std::vector<interaction_choice> read_interaction_choices(
    const sol::table &requested )
{
    if( requested.size() == 0 ||
        requested.size() > maximum_interaction_choices ) {
        throw std::invalid_argument(
            "services.interaction.choose requires 1..256 entries" );
    }
    std::vector<interaction_choice> result;
    result.reserve( requested.size() );
    for( std::size_t index = 1;
         index <= requested.size(); ++index ) {
        const sol::object raw_entry = requested.raw_get<sol::object>( index );
        if( !raw_entry.is<sol::table>() ) {
            throw std::invalid_argument(
                "services.interaction.choose entries must be a dense table array" );
        }
        const sol::table entry = raw_entry.as<sol::table>();
        interaction_choice choice;
        choice.id = required_choice_text(
                        entry, "id", maximum_interaction_identifier_bytes );
        if( std::any_of(
                result.begin(), result.end(),
        [&choice]( const interaction_choice & existing ) {
        return existing.id == choice.id;
    } ) ) {
            throw std::invalid_argument(
                "services.interaction.choose entry ids must be unique" );
        }
        choice.label = required_choice_text(
                           entry, "label", maximum_target_prompt_bytes );
        const sol::object description = entry["description"];
        if( description.valid() &&
            description.get_type() != sol::type::nil ) {
            choice.description = bounded_interaction_text(
                                     description, "description",
                                     maximum_interaction_text_bytes );
        }
        const sol::object enabled = entry["enabled"];
        if( enabled.valid() && enabled.get_type() != sol::type::nil ) {
            if( !enabled.is<bool>() ) {
                throw std::invalid_argument(
                    "services.interaction.choose entry enabled must be boolean" );
            }
            choice.enabled = enabled.as<bool>();
        }
        const sol::object hotkey = entry["hotkey"];
        if( hotkey.valid() && hotkey.get_type() != sol::type::nil ) {
            const std::string text = bounded_interaction_text(
                                         hotkey, "hotkey", 1 );
            if( text.size() != 1 ||
                std::isalnum(
                    static_cast<unsigned char>( text.front() ) ) == 0 ) {
                throw std::invalid_argument(
                    "services.interaction.choose entry hotkey must be one ASCII letter or digit" );
            }
            choice.hotkey = static_cast<unsigned char>( text.front() );
        }
        result.push_back( std::move( choice ) );
    }
    return result;
}

interaction_choice_options read_interaction_choice_options(
    const sol::optional<sol::table> &requested )
{
    interaction_choice_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.interaction.choose option names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "title" ) {
            result.title = bounded_interaction_text(
                               entry.second, key,
                               maximum_target_prompt_bytes );
            if( result.title.empty() ) {
                throw std::invalid_argument(
                    "services.interaction.choose title cannot be empty" );
            }
        } else if( key == "allow_cancel" ||
                   key == "highlight_disabled" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    "services.interaction.choose boolean option '" +
                    key + "' must be boolean" );
            }
            if( key == "allow_cancel" ) {
                result.allow_cancel = entry.second.as<bool>();
            } else {
                result.highlight_disabled = entry.second.as<bool>();
            }
        } else {
            throw std::invalid_argument(
                "services.interaction.choose received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table choose_interaction_entry(
    sol::this_state lua, const sol::table &requested_entries,
    const sol::optional<sol::table> &requested_options )
{
    const std::vector<interaction_choice> choices =
        read_interaction_choices( requested_entries );
    const interaction_choice_options options =
        read_interaction_choice_options( requested_options );
    uilist menu;
    menu.text = options.title;
    menu.allow_cancel = options.allow_cancel;
    menu.hilight_disabled = options.highlight_disabled;
    menu.desc_enabled = std::any_of(
                            choices.begin(), choices.end(),
    []( const interaction_choice & choice ) {
        return !choice.description.empty();
    } );
    for( std::size_t index = 0;
         index < choices.size(); ++index ) {
        const interaction_choice &choice = choices[index];
        menu.entries.emplace_back(
            static_cast<int>( index ), choice.enabled,
            choice.hotkey, choice.label,
            choice.description );
    }
    menu.query();
    const bool accepted = menu.ret >= 0 &&
                          menu.ret < static_cast<int>( choices.size() );
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["cancelled"] = !accepted;
    if( accepted ) {
        const std::size_t index =
            static_cast<std::size_t>( menu.ret );
        value["index"] = index + 1;
        value["id"] = choices[index].id;
    } else {
        value["index"] = sol::nil;
        value["id"] = sol::nil;
    }
    return value;
}

} // namespace

void install_game_interaction_api(
    sol::table &services,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback )
{
    sol::state_view state( services.lua_state() );

    sol::table interaction = state.create_table();
    interaction.set_function(
        "confirm",
        [require_actions, has_active_callback](
    const std::string & message ) {
        require_actions();
        require_active_callback(
            has_active_callback, "services.interaction.confirm" );
        return confirm_interaction( message );
    } );
    interaction.set_function(
        "input_text",
        [require_actions, has_active_callback](
            sol::this_state lua, const std::string & title,
    const sol::optional<sol::table> &options ) {
        require_actions();
        require_active_callback(
            has_active_callback, "services.interaction.input_text" );
        return input_interaction_text(
                   lua, title, options );
    } );
    interaction.set_function(
        "input_number",
        [require_actions, has_active_callback](
            sol::this_state lua,
            const std::string & description,
    const int default_value ) {
        require_actions();
        require_active_callback(
            has_active_callback,
            "services.interaction.input_number" );
        return input_interaction_number(
                   lua, description, default_value );
    } );
    interaction.set_function(
        "choose",
        [require_actions, has_active_callback](
            sol::this_state lua, const sol::table & entries,
    const sol::optional<sol::table> &options ) {
        require_actions();
        require_active_callback(
            has_active_callback, "services.interaction.choose" );
        return choose_interaction_entry(
                   lua, entries, options );
    } );
    services["interaction"] = std::move( interaction );

    sol::table sound = state.create_table();
    sound.set_function(
        "play",
        [require_actions, has_active_callback](
            const std::string & id, const std::string & variant,
    const int volume, const sol::optional<sol::table> &options ) {
        require_actions();
        require_active_callback(
            has_active_callback, "services.sound.play" );
        play_variant_sound( id, variant, volume, options );
    } );
    sound.set_function(
        "play_ambient",
        [require_actions, has_active_callback](
            const std::string & id, const std::string & variant,
    const int volume, const sol::optional<sol::table> &options ) {
        require_actions();
        require_active_callback(
            has_active_callback, "services.sound.play_ambient" );
        play_ambient_sound( id, variant, volume, options );
    } );
    sound.set_function(
        "emit",
        [require_actions, has_active_callback](
            const script_tripoint_coord & position,
            const int volume, const std::string & category,
            const std::string & description,
            const sol::optional<bool> &ambient,
            const sol::optional<std::string> &id,
    const sol::optional<std::string> &variant ) {
        require_actions();
        require_active_callback(
            has_active_callback, "services.sound.emit" );
        emit_gameplay_sound(
            position, volume, category, description,
            ambient, id, variant );
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
    services["sound"] = std::move( sound );

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
        authorize( "services.targeting.choose_adjacent" );
        return choose_adjacent_position(
                   lua, message, allow_vertical.value_or( false ) );
    } );
    targeting.set_function(
        "choose_direction",
        [authorize](
            sol::this_state lua, const std::string & message,
    const sol::optional<bool> &allow_vertical ) {
        authorize( "services.targeting.choose_direction" );
        return choose_direction_offset(
                   lua, message, allow_vertical.value_or( false ) );
    } );
    targeting.set_function(
        "look_around",
    [authorize]( sol::this_state lua ) {
        authorize( "services.targeting.look_around" );
        return look_around_position( lua );
    } );
    targeting.set_function(
        "choose_map_square",
        [authorize](
            sol::this_state lua, const std::string & message,
            const sol::optional<script_tripoint_coord> &center,
    const sol::optional<bool> &allow_vertical ) {
        authorize( "services.targeting.choose_map_square" );
        return choose_map_square(
                   lua, message, center,
                   allow_vertical.value_or( false ) );
    } );
    targeting.set_function(
        "choose_visible_map_square",
        [authorize](
            sol::this_state lua, const std::string & message,
    const int range ) {
        authorize(
            "services.targeting.choose_visible_map_square" );
        return choose_visible_map_square(
                   lua, message, range );
    } );
    targeting.set_function(
        "choose_overmap_point",
        [authorize](
            sol::this_state lua, const std::string & message,
            const sol::optional<script_tripoint_coord> &center,
    const sol::optional<int> &distance ) {
        authorize( "services.targeting.choose_overmap_point" );
        return choose_overmap_point(
                   lua, message, center, distance );
    } );
    targeting.set_function(
        "choose_area",
        [authorize](
            sol::this_state lua, const std::string & message,
            const sol::optional<script_tripoint_coord> &start,
    const sol::optional<bool> &allow_vertical ) {
        authorize( "services.targeting.choose_area" );
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
            "services.targeting.choose_adjacent_for_action" );
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
        authorize( "services.targeting.choose_adjacent_where" );
        return choose_adjacent_where(
                   lua, message, failure_message, candidates,
                   allow_vertical.value_or( false ),
                   allow_autoselect.value_or( true ) );
    } );
    targeting.set_function(
        "choose_adjacent_where_at",
        [authorize](
            sol::this_state lua,
            const script_tripoint_coord & center,
            const std::string & message,
            const std::string & failure_message,
            const sol::table & candidates,
            const sol::optional<bool> &allow_vertical,
    const sol::optional<bool> &allow_autoselect ) {
        authorize(
            "services.targeting.choose_adjacent_where_at" );
        return choose_adjacent_where_at(
                   lua, center, message, failure_message,
                   candidates,
                   allow_vertical.value_or( false ),
                   allow_autoselect.value_or( true ) );
    } );
    services["targeting"] = std::move( targeting );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
