#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_INTERACTION_H
#define CATA_SRC_LUA_PLATFORM_INTERACTION_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install callback-scoped sound playback and interactive targeting services.
// Both namespaces require an active Platform mutation callback.
void install_game_interaction_api(
    sol::table &services,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_INTERACTION_H
