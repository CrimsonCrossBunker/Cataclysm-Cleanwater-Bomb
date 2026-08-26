#pragma once
#ifndef CATA_SRC_CATALUA_UI_REGISTRY_H
#define CATA_SRC_CATALUA_UI_REGISTRY_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

// Install bounded, detached snapshots of immutable game definition registries
// below ccb.services.registry. The Lua side never receives a pointer, userdata,
// or mutable game object, and no global registry table is created.
void install_registry_api(
    sol::state &lua, sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_typed_read );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_REGISTRY_H
