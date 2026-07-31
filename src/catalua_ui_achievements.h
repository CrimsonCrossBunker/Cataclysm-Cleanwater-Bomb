#pragma once
#ifndef CATA_SRC_CATALUA_UI_ACHIEVEMENTS_H
#define CATA_SRC_CATALUA_UI_ACHIEVEMENTS_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install native achievement definitions, live progress, and manual controls.
void install_achievement_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_ACHIEVEMENTS_H
