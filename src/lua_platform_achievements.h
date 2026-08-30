#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_ACHIEVEMENTS_H
#define CATA_SRC_LUA_PLATFORM_ACHIEVEMENTS_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install native achievement definitions, live progress, and manual controls.
void install_achievement_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_ACHIEVEMENTS_H
