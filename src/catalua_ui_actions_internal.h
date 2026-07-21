#pragma once
#ifndef CATA_SRC_CATALUA_UI_ACTIONS_INTERNAL_H
#define CATA_SRC_CATALUA_UI_ACTIONS_INTERNAL_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Lua binding detail.  Keep this declaration separate from the queue's public
// game-loop API so ordinary C++ users do not need to include Sol2/Lua headers.
void install_action_api( sol::table &game, std::function<void()> authorize_access,
                         std::function<bool()> can_mutate );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_ACTIONS_INTERNAL_H
