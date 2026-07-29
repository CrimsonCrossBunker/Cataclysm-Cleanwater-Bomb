#pragma once
#ifndef CATA_SRC_CATALUA_UI_MISSIONS_H
#define CATA_SRC_CATALUA_UI_MISSIONS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install detached mission definitions plus generation-bound mission tokens.
// Mission pointers and mutable mission_type objects never cross into Lua.
void install_mission_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MISSIONS_H
