#pragma once
#ifndef CATA_SRC_CATALUA_UI_ACTIONS_H
#define CATA_SRC_CATALUA_UI_ACTIONS_H

#include <optional>

namespace cata::lua_ui
{

// Dispatch at most one request from the regular avatar input loop.  nullopt
// means no request; the bool matches game::handle_action's return convention.
std::optional<bool> process_next_action();

void clear_actions();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_ACTIONS_H
