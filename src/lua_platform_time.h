#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_TIME_H
#define CATA_SRC_LUA_PLATFORM_TIME_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Extend immutable services.time value factories with native calendar
// snapshots and checked world-clock controls.
void install_time_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_TIME_H
