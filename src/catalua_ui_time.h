#pragma once
#ifndef CATA_SRC_CATALUA_UI_TIME_H
#define CATA_SRC_CATALUA_UI_TIME_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Extend the immutable game.time value factories with native calendar
// snapshots and checked world-clock controls.
void install_time_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_TIME_H
