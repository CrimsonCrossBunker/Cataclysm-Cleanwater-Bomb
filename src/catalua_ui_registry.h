#pragma once
#ifndef CATA_SRC_CATALUA_UI_REGISTRY_H
#define CATA_SRC_CATALUA_UI_REGISTRY_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install bounded, detached snapshots of immutable game definition registries.
// The Lua side never receives a pointer, userdata, or mutable game object.
// The global registry table preserves the API v4 string-id contract, while
// game.definitions provides API v5 typed GameId lookup and discovery.
void install_registry_api(
    sol::state &lua, sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_typed_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_REGISTRY_H
