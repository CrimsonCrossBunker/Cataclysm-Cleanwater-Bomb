#include "catalua_ui_needs.h"

#include <cstddef>
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
    const sol::table &requested )
{
    need_adjustments result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.needs.set option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "hunger" && key != "thirst" &&
            key != "sleepiness" &&
            key != "sleep_deprivation" ) {
            throw std::invalid_argument(
                "game.needs.set received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "game.needs.set option '" + key +
                "' must be an integer" );
        }
        const int value = entry.second.as<int>();
        if( value < -maximum_need_magnitude ||
            value > maximum_need_magnitude ) {
            throw std::invalid_argument(
                "game.needs.set option '" + key +
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
            "game.needs.set requires at least one adjustment" );
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
        read_need_adjustments( requested_adjustments );
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
    game["needs"] = std::move( needs );
}

} // namespace cata::lua_ui
