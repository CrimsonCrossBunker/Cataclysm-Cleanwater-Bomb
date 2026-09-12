#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_MARTIAL_ARTS_H
#define CATA_SRC_LUA_PLATFORM_MARTIAL_ARTS_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Install native martial-art definitions and character style services.
void install_martial_art_api(
    sol::table &services,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_read,
    const std::function<void()> &require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_MARTIAL_ARTS_H
