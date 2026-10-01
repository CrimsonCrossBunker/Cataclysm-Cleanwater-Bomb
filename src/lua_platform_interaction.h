#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_INTERACTION_H
#define CATA_SRC_LUA_PLATFORM_INTERACTION_H

#include <functional>
#include <string>
#include <vector>

#include "lua_platform_sol.h"

class uilist;

namespace cata::lua_platform
{

// Populate a fresh native menu without querying it; return entry IDs in native row order.
std::vector<std::string> prepare_game_interaction_menu(
    uilist &menu, const sol::table &entries, const sol::optional<sol::table> &options );

// Install callback-scoped sound playback and interactive targeting services.
// Both namespaces require an active Platform mutation callback.
void install_game_interaction_api(
    sol::table &services,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_INTERACTION_H
