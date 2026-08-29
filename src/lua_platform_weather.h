#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_WEATHER_H
#define CATA_SRC_LUA_PLATFORM_WEATHER_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install bounded weather catalogs, deterministic forecasts, live weather
// snapshots, and checked native override controls.
void install_weather_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_WEATHER_H
