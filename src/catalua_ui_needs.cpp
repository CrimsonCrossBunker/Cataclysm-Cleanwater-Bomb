#include "catalua_ui_needs.h"

#include <cstddef>
#include <optional>
#include <utility>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"

namespace cata::lua_ui
{

namespace
{

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

} // namespace

void install_need_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> )
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
    game["needs"] = std::move( needs );
}

} // namespace cata::lua_ui
