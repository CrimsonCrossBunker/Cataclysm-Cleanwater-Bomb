#pragma once
#ifndef CATA_SRC_CATALUA_UI_CREATURES_H
#define CATA_SRC_CATALUA_UI_CREATURES_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

class game_handle_runtime;

// Install bounded creature queries and detached snapshots.  Live game objects
// cross the Lua boundary only through generation-checked GameHandle values.
void install_creature_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_CREATURES_H
