#pragma once
#ifndef CATA_SRC_CATALUA_UI_MAGIC_H
#define CATA_SRC_CATALUA_UI_MAGIC_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install detached spell definition and known-spell snapshots.  Native spell
// and known_magic instances never cross the Lua boundary.
void install_magic_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MAGIC_H
