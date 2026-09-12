#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_VARIABLES_H
#define CATA_SRC_LUA_PLATFORM_VARIABLES_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Install generation-safe variables attached to creature and vehicle talkers.
// This domain service is independent from EOC execution and is shared with
// the Lua-first Platform.
void install_variable_api(
    sol::table &services,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_read,
    const std::function<void()> &require_write,
    const std::function<bool()> &has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_VARIABLES_H
