#pragma once
#ifndef CATA_SRC_CATALUA_UI_CRAFTING_H
#define CATA_SRC_CATALUA_UI_CRAFTING_H

#include <functional>

#include "catalua_game_handle.h"
#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install detached, bounded recipe and requirement queries.  Craft execution
// is added through the regular safe-point action queue in the same module.
void install_crafting_api(
    sol::table &game,
    const game_handle_runtime &runtime_generation,
    std::function<std::size_t()> world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> can_mutate,
    std::function<std::string()> source_id );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_CRAFTING_H
