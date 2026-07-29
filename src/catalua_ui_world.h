#pragma once
#ifndef CATA_SRC_CATALUA_UI_WORLD_H
#define CATA_SRC_CATALUA_UI_WORLD_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install bounded active-map observation and mutation APIs.  Map, item and
// vehicle pointers never cross into Lua; live objects use generation-bound
// GameHandle values and all coordinates are explicitly typed.
void install_world_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_WORLD_H
