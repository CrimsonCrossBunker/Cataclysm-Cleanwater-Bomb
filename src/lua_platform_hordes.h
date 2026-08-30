#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_HORDES_H
#define CATA_SRC_LUA_PLATFORM_HORDES_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Install detached monster-group definitions plus bounded, existing-overmap
// horde observation and mutation APIs.  Native horde_entity and mongroup
// pointers never cross into Lua; live entries use generation-bound tokens.
// Whole-buffer movement is intentionally not part of this public surface;
// callers use the smaller signal, alert, and per-entry mutation operations.
// Runtime/world lifecycle transitions call reset_horde_tokens() first.
void reset_horde_tokens() noexcept;

void install_horde_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_HORDES_H
