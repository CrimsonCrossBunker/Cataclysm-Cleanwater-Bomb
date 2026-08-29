#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_PROFICIENCIES_H
#define CATA_SRC_LUA_PLATFORM_PROFICIENCIES_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Install the native proficiency definition and character learning service.
void install_proficiency_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_PROFICIENCIES_H
