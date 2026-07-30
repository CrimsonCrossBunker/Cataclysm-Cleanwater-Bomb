#pragma once
#ifndef CATA_SRC_CATALUA_UI_CAMPS_H
#define CATA_SRC_CATALUA_UI_CAMPS_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install bounded faction-camp discovery and control services.
void install_camp_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_CAMPS_H
