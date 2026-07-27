#pragma once
#ifndef CATA_SRC_CATALUA_UI_GAME_H
#define CATA_SRC_CATALUA_UI_GAME_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Add bounded, read-only game-data snapshots to the Lua `game` table.  Every
// result contains copied Lua values only; no native game object is exposed.
void install_game_snapshot_api( sol::table &game, std::function<void()> require_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_GAME_H
