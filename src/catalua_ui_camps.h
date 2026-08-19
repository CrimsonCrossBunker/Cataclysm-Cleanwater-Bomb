#pragma once
#ifndef CATA_SRC_CATALUA_UI_CAMPS_H
#define CATA_SRC_CATALUA_UI_CAMPS_H

#include <cstddef>
#include <functional>

#include "catalua_game_handle.h"
#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install bounded faction-camp discovery and control services.
void install_camp_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_CAMPS_H
