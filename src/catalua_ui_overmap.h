#pragma once
#ifndef CATA_SRC_CATALUA_UI_OVERMAP_H
#define CATA_SRC_CATALUA_UI_OVERMAP_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install bounded, existing-overmap-only observation, search and mutation
// APIs. Calls may load saved overmaps, but never generate new overmaps.
void install_overmap_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_OVERMAP_H
