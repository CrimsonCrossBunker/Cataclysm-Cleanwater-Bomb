#pragma once
#ifndef CATA_SRC_CATALUA_UI_ACTIONS_INTERNAL_H
#define CATA_SRC_CATALUA_UI_ACTIONS_INTERNAL_H

#include <cstdint>
#include <functional>
#include <string>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Lua binding detail.  Keep this declaration separate from the queue's public
// game-loop API so ordinary C++ users do not need to include Sol2/Lua headers.
void install_action_api( sol::table &game, std::function<void()> authorize_access,
                         std::function<void()> authorize_dangerous,
                         std::function<bool()> dangerous_available,
                         std::function<std::string()> source_id,
                         std::function<bool()> can_mutate );

// Queue a context action for dispatch at the next safe game-input boundary.
// Dangerous actions are never injected directly: processing the request asks
// the player for one-time confirmation first.
std::uint64_t enqueue_context_action( const std::string &action,
                                      int context_revision,
                                      const std::string &source_id );

// Queue a recipe start for the next safe game-input boundary.  The recipe is
// resolved again at dispatch so a data reload or changed character state
// cannot turn a previously validated request into an unchecked mutation.
std::uint64_t enqueue_craft_action( const std::string &recipe,
                                    int batch,
                                    bool long_craft,
                                    const std::string &source_id );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_ACTIONS_INTERNAL_H
