#pragma once
#ifndef CATA_SRC_CATALUA_UI_INTERACTION_H
#define CATA_SRC_CATALUA_UI_INTERACTION_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

// Install callback-scoped sound playback and interactive targeting services.
// Both namespaces require an active Platform mutation callback.
void install_game_interaction_api(
    sol::table &game,
    std::function<void()> require_actions,
    std::function<bool()> has_active_callback );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_INTERACTION_H
