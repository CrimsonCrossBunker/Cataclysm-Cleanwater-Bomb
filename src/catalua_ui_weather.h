#pragma once
#ifndef CATA_SRC_CATALUA_UI_WEATHER_H
#define CATA_SRC_CATALUA_UI_WEATHER_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install bounded weather catalogs, deterministic forecasts, live weather
// snapshots, and checked native override controls.
void install_weather_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_WEATHER_H
