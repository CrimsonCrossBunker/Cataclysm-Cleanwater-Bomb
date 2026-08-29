#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_needs.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

#include "avatar.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "calendar.h"
#include "character.h"
#include "creature.h"
#include "morale_types.h"
#include "vitamin.h"

namespace cata::lua_platform
{

namespace
{

constexpr int maximum_need_magnitude = 1000000;
constexpr int maximum_stored_kcal = 2000000;
constexpr std::int64_t maximum_sleep_adjustment_turns = 31622400;
constexpr int maximum_morale_magnitude = 1000000;

sol::table snapshot_needs(
    sol::state_view lua, const Character &character )
{
    sol::table result = lua.create_table();
    result["hunger"] = character.get_hunger();
    result["starvation"] = character.get_starvation();
    result["thirst"] = character.get_thirst();
    result["instant_thirst"] =
        character.get_instant_thirst();
    result["sleepiness"] = character.get_sleepiness();
    result["sleep_deprivation"] =
        character.get_sleep_deprivation();
    result["stamina"] = character.get_stamina();
    result["stamina_max"] = character.get_stamina_max();
    result["focus"] = character.get_focus();
    result["effective_focus"] =
        character.get_effective_focus();
    result["radiation"] = character.get_rad();
    result["painkiller"] = character.get_painkiller();
    result["oxygen"] = character.oxygen;
    result["oxygen_max"] = character.get_oxygen_max();
    result["stimulant"] = character.get_stim();
    result["stored_kcal"] = character.get_stored_kcal();
    result["healthy_kcal"] = character.get_healthy_kcal();
    result["kcal_fraction"] = character.get_kcal_percent();
    result["kcal_speed_penalty"] =
        character.kcal_speed_penalty();
    result["daily_sleep"] =
        script_time_duration::from_native(
            character.get_daily_sleep() );
    result["continuous_sleep"] =
        script_time_duration::from_native(
            character.get_continuous_sleep() );
    result["lifestyle"] = character.get_lifestyle();
    result["daily_health"] =
        character.get_daily_health();
    result["health_tally"] =
        character.get_health_tally();
    return result;
}

sol::table get_needs(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_needs(
                       state, *character ) ) );
}

struct need_adjustments {
    std::optional<int> hunger;
    std::optional<int> thirst;
    std::optional<int> sleepiness;
    std::optional<int> sleep_deprivation;
    std::optional<int> stamina;
    std::optional<int> focus;
    std::optional<int> radiation;
    std::optional<int> painkiller;
    std::optional<int> oxygen;
    std::optional<int> stimulant;
};

need_adjustments read_need_adjustments(
    const sol::table &requested, const std::string &api_name )
{
    need_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "hunger" && key != "thirst" &&
            key != "sleepiness" &&
            key != "sleep_deprivation" &&
            key != "stamina" && key != "focus" &&
            key != "radiation" && key != "painkiller" &&
            key != "oxygen" && key != "stimulant" ) {
            throw std::invalid_argument(
                api_name + " received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                api_name + " option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        if( value < -maximum_need_magnitude ||
            value > maximum_need_magnitude ) {
            throw std::invalid_argument(
                api_name + " option '" + key +
                "' must be within -1000000..1000000" );
        }
        if( key == "hunger" ) {
            result.hunger = value;
        } else if( key == "thirst" ) {
            result.thirst = value;
        } else if( key == "sleepiness" ) {
            result.sleepiness = value;
        } else if( key == "sleep_deprivation" ) {
            result.sleep_deprivation = value;
        } else if( key == "stamina" ) {
            result.stamina = value;
        } else if( key == "focus" ) {
            result.focus = value;
        } else if( key == "radiation" ) {
            result.radiation = value;
        } else if( key == "painkiller" ) {
            result.painkiller = value;
        } else if( key == "oxygen" ) {
            result.oxygen = value;
        } else {
            result.stimulant = value;
        }
    }
    if( !result.hunger && !result.thirst &&
        !result.sleepiness && !result.sleep_deprivation &&
        !result.stamina && !result.focus &&
        !result.radiation && !result.painkiller &&
        !result.oxygen && !result.stimulant ) {
        throw std::invalid_argument(
            api_name + " requires at least one adjustment" );
    }
    return result;
}

sol::table set_needs(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested_adjustments,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const need_adjustments adjustments =
        read_need_adjustments(
            requested_adjustments, "services.needs.set" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    if( adjustments.hunger ) {
        character->set_hunger( *adjustments.hunger );
    }
    if( adjustments.thirst ) {
        character->set_thirst( *adjustments.thirst );
    }
    if( adjustments.sleepiness ) {
        character->set_sleepiness( *adjustments.sleepiness );
    }
    if( adjustments.sleep_deprivation ) {
        character->set_sleep_deprivation(
            *adjustments.sleep_deprivation );
    }
    if( adjustments.stamina ) {
        character->set_stamina( *adjustments.stamina );
    }
    if( adjustments.focus ) {
        character->mod_focus(
            *adjustments.focus - character->get_focus() );
    }
    if( adjustments.radiation ) {
        character->set_rad( *adjustments.radiation );
    }
    if( adjustments.painkiller ) {
        character->set_painkiller( *adjustments.painkiller );
    }
    if( adjustments.oxygen ) {
        character->oxygen = std::clamp(
                                *adjustments.oxygen, 0,
                                character->get_oxygen_max() );
    }
    if( adjustments.stimulant ) {
        character->set_stim( *adjustments.stimulant );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table modify_needs(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested_deltas,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const need_adjustments deltas =
        read_need_adjustments(
            requested_deltas, "services.needs.modify" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    if( deltas.hunger ) {
        character->mod_hunger( *deltas.hunger );
    }
    if( deltas.thirst ) {
        character->mod_thirst( *deltas.thirst );
    }
    if( deltas.sleepiness ) {
        character->mod_sleepiness( *deltas.sleepiness );
    }
    if( deltas.sleep_deprivation ) {
        character->mod_sleep_deprivation(
            *deltas.sleep_deprivation );
    }
    if( deltas.stamina ) {
        character->mod_stamina( *deltas.stamina );
    }
    if( deltas.focus ) {
        character->mod_focus( *deltas.focus );
    }
    if( deltas.radiation ) {
        character->mod_rad( *deltas.radiation );
    }
    if( deltas.painkiller ) {
        character->mod_painkiller( *deltas.painkiller );
    }
    if( deltas.oxygen ) {
        character->oxygen = std::clamp(
                                character->oxygen + *deltas.oxygen,
                                0, character->get_oxygen_max() );
    }
    if( deltas.stimulant ) {
        character->mod_stim( *deltas.stimulant );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_calories(
    sol::this_state lua, const game_handle &handle,
    const int requested_kcal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_kcal < 0 ||
        requested_kcal > maximum_stored_kcal ) {
        throw std::invalid_argument(
            "services.needs.set_calories kcal "
            "must be within 0..2000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    character->set_stored_kcal( requested_kcal );
    sol::table value = state.create_table();
    value["requested"] = requested_kcal;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table modify_calories(
    sol::this_state lua, const game_handle &handle,
    const int requested_delta, const bool ignore_weariness,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_delta < -maximum_need_magnitude ||
        requested_delta > maximum_need_magnitude ) {
        throw std::invalid_argument(
            "services.needs.modify_calories delta "
            "must be within -1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const int before_kcal = character->get_stored_kcal();
    sol::table before =
        snapshot_needs( state, *character );
    character->mod_stored_kcal(
        requested_delta, ignore_weariness );
    const int after_kcal = character->get_stored_kcal();
    sol::table value = state.create_table();
    value["requested_delta"] = requested_delta;
    value["applied_delta"] = after_kcal - before_kcal;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

void require_vitamin_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "vitamin" || !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<vitamin>" );
    }
}

sol::table snapshot_gut_vitamin(
    sol::state_view lua, const Character &character,
    const vitamin_id &id )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id( "vitamin", id.str() );
    result["amount"] = character.guts.get_vitamin( id );
    return result;
}

sol::table get_gut_calories(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, character->guts.get_calories() ) );
}

sol::table set_gut_calories(
    sol::this_state lua, const game_handle &handle,
    const int requested_kcal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_kcal < 0 ) {
        throw std::invalid_argument(
            "services.needs.set_gut_calories kcal cannot be negative" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = character->guts.get_calories();
    character->guts.mod_calories( requested_kcal - before );
    sol::table value = state.create_table();
    value["requested"] = requested_kcal;
    value["before"] = before;
    value["after"] = character->guts.get_calories();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table modify_gut_calories(
    sol::this_state lua, const game_handle &handle,
    const int requested_delta,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = character->guts.get_calories();
    character->guts.mod_calories( requested_delta );
    const int after = character->guts.get_calories();
    sol::table value = state.create_table();
    value["requested_delta"] = requested_delta;
    value["applied_delta"] = after - before;
    value["before"] = before;
    value["after"] = after;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_gut_vitamin(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id( id, "services.needs.get_gut_vitamin" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_gut_vitamin(
                       state, *character, vitamin_id( id.value() ) ) ) );
}

sol::table set_gut_vitamin(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &id, const int requested_amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id( id, "services.needs.set_gut_vitamin" );
    if( requested_amount < 0 ) {
        throw std::invalid_argument(
            "services.needs.set_gut_vitamin amount cannot be negative" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const vitamin_id vitamin( id.value() );
    sol::table before = snapshot_gut_vitamin( state, *character, vitamin );
    character->guts.set_vitamin( vitamin, requested_amount );
    sol::table value = state.create_table();
    value["requested"] = requested_amount;
    value["before"] = std::move( before );
    value["after"] = snapshot_gut_vitamin( state, *character, vitamin );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table modify_gut_vitamin(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &id, const int requested_delta,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id( id, "services.needs.modify_gut_vitamin" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const vitamin_id vitamin( id.value() );
    const int before_amount = character->guts.get_vitamin( vitamin );
    sol::table before = snapshot_gut_vitamin( state, *character, vitamin );
    character->guts.mod_vitamin( vitamin, requested_delta );
    const int after_amount = character->guts.get_vitamin( vitamin );
    sol::table value = state.create_table();
    value["requested_delta"] = requested_delta;
    value["applied_delta"] = after_amount - before_amount;
    value["before"] = std::move( before );
    value["after"] = snapshot_gut_vitamin( state, *character, vitamin );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_vitamin(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id( id, "services.needs.get_vitamin" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int amount =
        character->vitamin_get( vitamin_id( id.value() ) );
    return make_game_value_result(
               state, sol::make_object( state, amount ) );
}

sol::table set_vitamin(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &id, const int requested_amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id( id, "services.needs.set_vitamin" );
    if( std::abs( static_cast<std::int64_t>( requested_amount ) ) >
        maximum_need_magnitude ) {
        throw std::invalid_argument(
            "services.needs.set_vitamin amount is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const vitamin_id vitamin( id.value() );
    const int before = character->vitamin_get( vitamin );
    character->vitamin_set( vitamin, requested_amount );
    sol::table value = state.create_table();
    value["id"] = id;
    value["before"] = before;
    value["after"] = character->vitamin_get( vitamin );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table modify_vitamin(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &id, const int requested_delta,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_vitamin_id( id, "services.needs.modify_vitamin" );
    if( std::abs( static_cast<std::int64_t>( requested_delta ) ) >
        maximum_need_magnitude ) {
        throw std::invalid_argument(
            "services.needs.modify_vitamin delta is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const vitamin_id vitamin( id.value() );
    const int before = character->vitamin_get( vitamin );
    character->vitamin_mod( vitamin, requested_delta );
    sol::table value = state.create_table();
    value["id"] = id;
    value["before"] = before;
    value["after"] = character->vitamin_get( vitamin );
    value["requested_delta"] = requested_delta;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table get_daily_calories(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_day,
    const sol::optional<std::string> &requested_type,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const int day = requested_day.value_or( 0 );
    if( day < 0 || day > 30 ) {
        throw std::invalid_argument(
            "services.needs.daily_calories day must be within 0..30" );
    }
    const std::string type = requested_type.value_or( "total" );
    if( type != "spent" && type != "gained" &&
        type != "ingested" && type != "total" ) {
        throw std::invalid_argument(
            "services.needs.daily_calories type must be spent, gained, ingested, or total" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar *player = character->as_avatar();
    if( player == nullptr ) {
        return make_game_error_result(
        state, {
            "wrong_subtype",
            "Calorie diary history exists only for the avatar"
        } );
    }
    const int amount = player->get_daily_calories(
                           static_cast<unsigned>( day ), type );
    sol::table value = state.create_table();
    value["day"] = day;
    value["type"] = type;
    value["calories"] = amount;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

morale_type require_morale_id(
    const script_game_id &id, const std::string &api_name )
{
    if( id.kind() != "morale" || !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<morale>" );
    }
    return morale_type( id.value() );
}

sol::table morale_state(
    sol::state_view lua, const Character &character,
    const sol::optional<script_game_id> &requested_type,
    const std::string &api_name )
{
    sol::table result = lua.create_table();
    result["total"] = character.get_morale_level();
    if( requested_type ) {
        const morale_type native_type =
            require_morale_id( *requested_type, api_name );
        result["type"] = *requested_type;
        result["type_bonus"] =
            character.has_morale( native_type );
    }
    return result;
}

sol::table get_morale(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<script_game_id> &requested_type,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.needs.morale";
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, morale_state(
                       state, *character, requested_type,
                       std::string( api_name ) ) ) );
}

struct morale_add_options {
    int maximum_bonus = 0;
    script_time_duration duration =
        script_time_duration::from_native( 1_hours );
    script_time_duration decay_start =
        script_time_duration::from_native( 30_minutes );
    bool capped = false;
};

morale_add_options read_morale_add_options(
    const sol::optional<sol::table> &requested )
{
    morale_add_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.needs.add_morale option names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "maximum_bonus" ) {
            if( !entry.second.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.needs.add_morale maximum_bonus must be an integer" );
            }
            const lua_Integer value = entry.second.as<lua_Integer>();
            if( value < -maximum_morale_magnitude ||
                value > maximum_morale_magnitude ) {
                throw std::invalid_argument(
                    "services.needs.add_morale maximum_bonus must be within "
                    "-1000000..1000000" );
            }
            result.maximum_bonus = static_cast<int>( value );
        } else if( key == "duration" || key == "decay_start" ) {
            if( !entry.second.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.needs.add_morale option '" + key +
                    "' must be a TimeDuration" );
            }
            const script_time_duration value =
                entry.second.as<script_time_duration>();
            if( value.to_native() < 0_turns ||
                value.to_native() > 10000_days ) {
                throw std::invalid_argument(
                    "services.needs.add_morale option '" + key +
                    "' must be within 0 turns..10000 days" );
            }
            if( key == "duration" ) {
                result.duration = value;
            } else {
                result.decay_start = value;
            }
        } else if( key == "capped" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    "services.needs.add_morale capped must be a boolean" );
            }
            result.capped = entry.second.as<bool>();
        } else {
            throw std::invalid_argument(
                "services.needs.add_morale received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table add_morale(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_type, const int bonus,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.needs.add_morale";
    if( bonus < -maximum_morale_magnitude ||
        bonus > maximum_morale_magnitude ) {
        throw std::invalid_argument(
            "services.needs.add_morale bonus must be within -1000000..1000000" );
    }
    const morale_type native_type =
        require_morale_id( requested_type,
                           std::string( api_name ) );
    const morale_add_options options =
        read_morale_add_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::optional<script_game_id> type_for_snapshot =
        requested_type;
    sol::table before = morale_state(
                            state, *character, type_for_snapshot,
                            std::string( api_name ) );
    character->add_morale(
        native_type, bonus, options.maximum_bonus,
        options.duration.to_native(),
        options.decay_start.to_native(), options.capped );
    sol::table value = state.create_table();
    value["type"] = requested_type;
    value["bonus"] = bonus;
    value["maximum_bonus"] = options.maximum_bonus;
    value["duration"] = options.duration;
    value["decay_start"] = options.decay_start;
    value["capped"] = options.capped;
    value["before"] = std::move( before );
    value["after"] = morale_state(
                         state, *character, type_for_snapshot,
                         std::string( api_name ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_morale(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_type,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.needs.remove_morale";
    const morale_type native_type =
        require_morale_id( requested_type,
                           std::string( api_name ) );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::optional<script_game_id> type_for_snapshot =
        requested_type;
    sol::table before = morale_state(
                            state, *character, type_for_snapshot,
                            std::string( api_name ) );
    character->rem_morale( native_type );
    sol::table value = state.create_table();
    value["type"] = requested_type;
    value["before"] = std::move( before );
    value["after"] = morale_state(
                         state, *character, type_for_snapshot,
                         std::string( api_name ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table clear_morale(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::optional<script_game_id> no_type;
    sol::table before = morale_state(
                            state, *character, no_type,
                            "services.needs.clear_morale" );
    character->clear_morale();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = morale_state(
                         state, *character, no_type,
                         "services.needs.clear_morale" );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct sleep_adjustments {
    std::optional<script_time_duration> daily;
    std::optional<script_time_duration> continuous;
};

sleep_adjustments read_sleep_adjustments(
    const sol::table &requested )
{
    sleep_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.needs.modify_sleep option keys "
                "must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "daily" && key != "continuous" ) {
            throw std::invalid_argument(
                "services.needs.modify_sleep received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<script_time_duration>() ) {
            throw std::invalid_argument(
                "services.needs.modify_sleep option '" + key +
                "' must be a TimeDuration" );
        }
        const script_time_duration value =
            entry.second.as<script_time_duration>();
        if( value.turns() < -maximum_sleep_adjustment_turns ||
            value.turns() > maximum_sleep_adjustment_turns ) {
            throw std::invalid_argument(
                "services.needs.modify_sleep option '" + key +
                "' cannot exceed 366 days in magnitude" );
        }
        if( key == "daily" ) {
            result.daily = value;
        } else {
            result.continuous = value;
        }
    }
    if( !result.daily && !result.continuous ) {
        throw std::invalid_argument(
            "services.needs.modify_sleep requires "
            "at least one adjustment" );
    }
    return result;
}

sol::table modify_sleep(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested_adjustments,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const sleep_adjustments adjustments =
        read_sleep_adjustments( requested_adjustments );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    if( adjustments.daily ) {
        character->mod_daily_sleep(
            adjustments.daily->to_native() );
    }
    if( adjustments.continuous ) {
        character->mod_continuous_sleep(
            adjustments.continuous->to_native() );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table reset_sleep(
    sol::this_state lua, const game_handle &handle,
    const std::string &scope,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( scope != "daily" && scope != "continuous" &&
        scope != "all" ) {
        throw std::invalid_argument(
            "services.needs.reset_sleep scope must be "
            "'daily', 'continuous', or 'all'" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    if( scope == "daily" || scope == "all" ) {
        character->reset_daily_sleep();
    }
    if( scope == "continuous" || scope == "all" ) {
        character->reset_continuous_sleep();
    }
    sol::table value = state.create_table();
    value["scope"] = scope;
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct health_adjustments {
    std::optional<int> lifestyle;
    std::optional<int> daily_health;
};

health_adjustments read_health_adjustments(
    const sol::table &requested )
{
    health_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.needs.set_health option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "lifestyle" && key != "daily_health" ) {
            throw std::invalid_argument(
                "services.needs.set_health received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "services.needs.set_health option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        if( value < -200 || value > 200 ) {
            throw std::invalid_argument(
                "services.needs.set_health option '" + key +
                "' must be within -200..200" );
        }
        if( key == "lifestyle" ) {
            result.lifestyle = value;
        } else {
            result.daily_health = value;
        }
    }
    if( !result.lifestyle && !result.daily_health ) {
        throw std::invalid_argument(
            "services.needs.set_health requires "
            "at least one adjustment" );
    }
    return result;
}

sol::table set_health(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested_adjustments,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const health_adjustments adjustments =
        read_health_adjustments( requested_adjustments );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    if( adjustments.lifestyle ) {
        character->set_lifestyle( *adjustments.lifestyle );
    }
    if( adjustments.daily_health ) {
        character->set_daily_health(
            *adjustments.daily_health );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct health_deltas {
    std::optional<int> lifestyle;
    std::optional<int> daily_health;
    std::optional<int> daily_health_cap;
    std::optional<int> health_tally;
};

health_deltas read_health_deltas(
    const sol::table &requested )
{
    health_deltas result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.needs.modify_health option keys "
                "must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "lifestyle" && key != "daily_health" &&
            key != "daily_health_cap" &&
            key != "health_tally" ) {
            throw std::invalid_argument(
                "services.needs.modify_health received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "services.needs.modify_health option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        const int maximum =
            key == "health_tally" ?
            maximum_need_magnitude : 200;
        if( value < -maximum || value > maximum ) {
            throw std::invalid_argument(
                "services.needs.modify_health option '" + key +
                "' exceeds its supported magnitude" );
        }
        if( key == "lifestyle" ) {
            result.lifestyle = value;
        } else if( key == "daily_health" ) {
            result.daily_health = value;
        } else if( key == "daily_health_cap" ) {
            result.daily_health_cap = value;
        } else {
            result.health_tally = value;
        }
    }
    if( !result.lifestyle && !result.daily_health &&
        !result.daily_health_cap && !result.health_tally ) {
        throw std::invalid_argument(
            "services.needs.modify_health requires "
            "at least one adjustment" );
    }
    if( result.daily_health.has_value() !=
        result.daily_health_cap.has_value() ) {
        throw std::invalid_argument(
            "services.needs.modify_health daily_health and "
            "daily_health_cap must be provided together" );
    }
    return result;
}

sol::table modify_health(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested_deltas,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const health_deltas deltas =
        read_health_deltas( requested_deltas );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before =
        snapshot_needs( state, *character );
    if( deltas.lifestyle ) {
        character->mod_livestyle( *deltas.lifestyle );
    }
    if( deltas.daily_health ) {
        character->mod_daily_health(
            *deltas.daily_health,
            *deltas.daily_health_cap );
    }
    if( deltas.health_tally ) {
        character->mod_health_tally(
            *deltas.health_tally );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_needs( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_need_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    sol::table needs = lua.create_table();
    needs.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_needs(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "set",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & adjustments ) {
        require_write();
        return set_needs(
                   lua_state, handle, adjustments,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & deltas ) {
        require_write();
        return modify_needs(
                   lua_state, handle, deltas,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "set_calories",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const int kcal ) {
        require_write();
        return set_calories(
                   lua_state, handle, kcal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify_calories",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const int delta,
    const sol::optional<bool> &ignore_weariness ) {
        require_write();
        return modify_calories(
                   lua_state, handle, delta,
                   ignore_weariness.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "get_gut_calories",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_gut_calories(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "set_gut_calories",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle, const int kcal ) {
        require_write();
        return set_gut_calories(
                   lua_state, handle, kcal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify_gut_calories",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle, const int delta ) {
        require_write();
        return modify_gut_calories(
                   lua_state, handle, delta,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "get_gut_vitamin",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle, const script_game_id & id ) {
        require_read();
        return get_gut_vitamin(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "set_gut_vitamin",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle, const script_game_id & id,
    const int amount ) {
        require_write();
        return set_gut_vitamin(
                   lua_state, handle, id, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify_gut_vitamin",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle, const script_game_id & id,
    const int delta ) {
        require_write();
        return modify_gut_vitamin(
                   lua_state, handle, id, delta,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "get_vitamin",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const script_game_id &id ) {
        require_read();
        return get_vitamin(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "set_vitamin",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &id, const int amount ) {
        require_write();
        return set_vitamin(
                   lua_state, handle, id, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify_vitamin",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &id, const int delta ) {
        require_write();
        return modify_vitamin(
                   lua_state, handle, id, delta,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "daily_calories",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<int> &day,
    const sol::optional<std::string> &type ) {
        require_read();
        return get_daily_calories(
                   lua_state, handle, day, type,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "morale",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<script_game_id> &type ) {
        require_read();
        return get_morale(
                   lua_state, handle, type,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "add_morale",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &type, const int bonus,
            const sol::optional<sol::table> &options ) {
        require_write();
        return add_morale(
                   lua_state, handle, type, bonus, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "remove_morale",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &type ) {
        require_write();
        return remove_morale(
                   lua_state, handle, type,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "clear_morale",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return clear_morale(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify_sleep",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & adjustments ) {
        require_write();
        return modify_sleep(
                   lua_state, handle, adjustments,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "reset_sleep",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & scope ) {
        require_write();
        return reset_sleep(
                   lua_state, handle, scope,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "set_health",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & adjustments ) {
        require_write();
        return set_health(
                   lua_state, handle, adjustments,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    needs.set_function(
        "modify_health",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & deltas ) {
        require_write();
        return modify_health(
                   lua_state, handle, deltas,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["needs"] = std::move( needs );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
