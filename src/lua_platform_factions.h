#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_FACTIONS_H
#define CATA_SRC_LUA_PLATFORM_FACTIONS_H

#include <functional>

#include "lua_platform_handle.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install native faction catalogs and active-world faction services.
void install_faction_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_FACTIONS_H
