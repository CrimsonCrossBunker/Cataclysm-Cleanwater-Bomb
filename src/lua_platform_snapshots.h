#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_SNAPSHOTS_H
#define CATA_SRC_LUA_PLATFORM_SNAPSHOTS_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Add bounded, read-only world and exact-Character snapshots to the Platform
// services table. Every result contains copied Lua values only; no native game
// object is exposed and no ambient avatar is selected.
void install_snapshot_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_SNAPSHOTS_H
