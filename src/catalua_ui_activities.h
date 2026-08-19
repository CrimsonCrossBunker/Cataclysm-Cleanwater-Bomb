#pragma once
#ifndef CATA_SRC_CATALUA_UI_ACTIVITIES_H
#define CATA_SRC_CATALUA_UI_ACTIVITIES_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

class game_handle_runtime;

// Install bounded native activity actors and activity lifecycle operations.
// Lua receives generation-checked handles and detached state snapshots only.
void install_activity_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_ACTIVITIES_H
