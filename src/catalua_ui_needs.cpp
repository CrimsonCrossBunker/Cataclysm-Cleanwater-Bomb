#if CATA_ENABLE_LUA_UI

#include "catalua_ui_needs.h"

#include <cstddef>
#include <cstdint>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"
#include "vitamin.h"

namespace cata::lua_ui
{

namespace
{

constexpr int maximum_need_magnitude = 1000000;
constexpr int maximum_stored_kcal = 2000000;
constexpr std::int64_t maximum_sleep_adjustment_turns = 31622400;

Character *resolve_character(
    const game_handle &handle, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    Character *character = resolved.value->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not a character"
        };
    }
    return character;
}

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
    Character *character = resolve_character(
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
            key != "sleep_deprivation" ) {
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
        } else {
            result.sleep_deprivation = value;
        }
    }
    if( !result.hunger && !result.thirst &&
        !result.sleepiness && !result.sleep_deprivation ) {
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
            requested_adjustments, "game.needs.set" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
            requested_deltas, "game.needs.modify" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
            "game.needs.set_calories kcal "
            "must be within 0..2000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
            "game.needs.modify_calories delta "
            "must be within -1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
    Character *character = resolve_character(
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
            "game.needs.set_gut_calories kcal cannot be negative" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
    Character *character = resolve_character(
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
    require_vitamin_id( id, "game.needs.get_gut_vitamin" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
    require_vitamin_id( id, "game.needs.set_gut_vitamin" );
    if( requested_amount < 0 ) {
        throw std::invalid_argument(
            "game.needs.set_gut_vitamin amount cannot be negative" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
    require_vitamin_id( id, "game.needs.modify_gut_vitamin" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
                "game.needs.modify_sleep option keys "
                "must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "daily" && key != "continuous" ) {
            throw std::invalid_argument(
                "game.needs.modify_sleep received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<script_time_duration>() ) {
            throw std::invalid_argument(
                "game.needs.modify_sleep option '" + key +
                "' must be a TimeDuration" );
        }
        const script_time_duration value =
            entry.second.as<script_time_duration>();
        if( value.turns() < -maximum_sleep_adjustment_turns ||
            value.turns() > maximum_sleep_adjustment_turns ) {
            throw std::invalid_argument(
                "game.needs.modify_sleep option '" + key +
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
            "game.needs.modify_sleep requires "
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
    Character *character = resolve_character(
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
            "game.needs.reset_sleep scope must be "
            "'daily', 'continuous', or 'all'" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
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
                "game.needs.set_health option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "lifestyle" && key != "daily_health" ) {
            throw std::invalid_argument(
                "game.needs.set_health received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "game.needs.set_health option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        if( value < -200 || value > 200 ) {
            throw std::invalid_argument(
                "game.needs.set_health option '" + key +
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
            "game.needs.set_health requires "
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
    Character *character = resolve_character(
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
                "game.needs.modify_health option keys "
                "must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "lifestyle" && key != "daily_health" &&
            key != "daily_health_cap" &&
            key != "health_tally" ) {
            throw std::invalid_argument(
                "game.needs.modify_health received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "game.needs.modify_health option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        const int maximum =
            key == "health_tally" ?
            maximum_need_magnitude : 200;
        if( value < -maximum || value > maximum ) {
            throw std::invalid_argument(
                "game.needs.modify_health option '" + key +
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
            "game.needs.modify_health requires "
            "at least one adjustment" );
    }
    if( result.daily_health.has_value() !=
        result.daily_health_cap.has_value() ) {
        throw std::invalid_argument(
            "game.needs.modify_health daily_health and "
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
    Character *character = resolve_character(
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

struct sensitive_adjustments {
    std::optional<int> sensitive;
    std::optional<int> sensitive_mod;
};

sensitive_adjustments read_sensitive_adjustments(
    const sol::table &requested, const std::string &api_name, bool allow_negative )
{
{
    sensitive_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "sensitive" && key != "sensitive_mod" ) {
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
        const int maximum = key == "sensitive" ? maximum_need_magnitude : 500;
        if( value < ( allow_negative ? -maximum : 0 ) || value > maximum ) {
            throw std::invalid_argument(
                api_name + " option '" + key + "' must be within " +
                ( allow_negative ? std::to_string( -maximum ) : "0" ) +
                ".." + std::to_string( maximum ) );
        }
        if( key == "sensitive" ) {
            result.sensitive = value;
        } else {
            result.sensitive_mod = value;
        }
    }
    if( !result.sensitive && !result.sensitive_mod ) {
        throw std::invalid_argument(
            api_name + " requires at least one adjustment" );
    }
    return result;
}

sol::table snapshot_sensitive(
    sol::state_view lua, const Character &character )
{
    sol::table result = lua.create_table();
    result["sensitive"] = character.get_sensitive();
    result["sensitive_mod"] =
        character.get_sensitive_mod();
    result["sensitive_mod_total"] =
        character.get_sensitive_mod_total();
    return result;
}

} // namespace

void install_sensitive_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table sensitive = lua.create_table();
    sensitive.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   handle, current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        return make_game_value_result(
                   state, sol::make_object(
                       state, snapshot_sensitive(
                           state, *character ) ) );
    } );
    sensitive.set_function(
        "set",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & adjustments ) {
        require_write();
        const sensitive_adjustments parsed = read_sensitive_adjustments(
                                                adjustments, "game.sensitive.set", false );
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   handle, current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        sol::table before = snapshot_sensitive( state, *character );
        if( parsed.sensitive ) {
            character->set_sensitive( *parsed.sensitive );
        }
        if( parsed.sensitive_mod ) {
            character->set_sensitive_mod( *parsed.sensitive_mod );
        }
        sol::table value = state.create_table();
        value["before"] = std::move( before );
        value["after"] = snapshot_sensitive( state, *character );
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    } );
    sensitive.set_function(
        "modify",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & deltas ) {
        require_write();
        const sensitive_adjustments parsed = read_sensitive_adjustments(
                                                deltas, "game.sensitive.modify", true );
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        Character *character = resolve_character(
                                   handle, current_runtime_generation(),
                                   current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        sol::table before = snapshot_sensitive( state, *character );
        if( parsed.sensitive ) {
            character->mod_sensitive( *parsed.sensitive );
        }
        if( parsed.sensitive_mod ) {
            character->mod_sensitive_mod( *parsed.sensitive_mod );
        }
        sol::table value = state.create_table();
        value["before"] = std::move( before );
        value["after"] = snapshot_sensitive( state, *character );
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    } );
    game["sensitive"] = std::move( sensitive );
}

void install_need_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
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
    game["needs"] = std::move( needs );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
