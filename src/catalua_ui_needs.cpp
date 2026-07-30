#include "catalua_ui_needs.h"

#include <cstddef>
#include <cstdint>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"

namespace cata::lua_ui
{

namespace
{

constexpr int maximum_need_magnitude = 1000000;
constexpr int maximum_stored_kcal = 2000000;
constexpr std::int64_t maximum_sleep_adjustment_turns = 31622400;

Character *resolve_character(
    const game_handle &handle, const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

} // namespace

void install_need_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
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
    game["needs"] = std::move( needs );
}

} // namespace cata::lua_ui
