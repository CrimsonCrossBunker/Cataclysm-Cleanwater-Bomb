#pragma once
#ifndef CATA_SRC_CATALUA_UI_GAME_INFO_H
#define CATA_SRC_CATALUA_UI_GAME_INFO_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install detached message, engine-constant, and gameplay RNG services.
// Message reads and constants require game.read.  Message writes require
// game.actions, while RNG calls additionally require an active callback so a
// failed candidate reload cannot consume gameplay randomness.
void install_game_info_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_GAME_INFO_H
