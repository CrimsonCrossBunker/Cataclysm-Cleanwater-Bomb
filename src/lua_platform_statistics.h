#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_STATISTICS_H
#define CATA_SRC_LUA_PLATFORM_STATISTICS_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install native event history, statistic, transformation, and score queries.
void install_statistics_api(
    sol::table &services,
    std::function<void()> require_read );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_STATISTICS_H
