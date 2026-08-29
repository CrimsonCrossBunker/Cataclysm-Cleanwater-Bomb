#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_WORLD_INFO_H
#define CATA_SRC_LUA_PLATFORM_WORLD_INFO_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install detached message, engine-constant, and gameplay RNG services.
// Message reads and constants require the live-world read boundary. Message
// writes and RNG calls additionally require an active Platform callback.
void install_world_info_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_WORLD_INFO_H
