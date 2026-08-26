#pragma once
#ifndef CATA_SRC_CATALUA_UI_CRAFTING_H
#define CATA_SRC_CATALUA_UI_CRAFTING_H

#include <functional>

#include "catalua_game_handle.h"
#include "catalua_sol.h"

namespace cata::lua
{

// Install detached, bounded recipe and requirement queries.
void install_crafting_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_CRAFTING_H
