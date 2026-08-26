#pragma once
#ifndef CATA_SRC_CATALUA_UI_TIME_H
#define CATA_SRC_CATALUA_UI_TIME_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

// Extend immutable services.time value factories with native calendar
// snapshots and checked world-clock controls.
void install_time_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_TIME_H
