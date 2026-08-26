#pragma once
#ifndef CATA_SRC_CATALUA_UI_EOCS_H
#define CATA_SRC_CATALUA_UI_EOCS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

class game_handle_runtime;

// Install generation-safe variables attached to creature and vehicle talkers.
// This domain service is independent from EOC execution and is shared with
// the Lua-first Platform.
void install_variable_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> has_active_callback );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_EOCS_H
