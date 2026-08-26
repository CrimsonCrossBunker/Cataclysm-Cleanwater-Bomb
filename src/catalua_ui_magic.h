#pragma once
#ifndef CATA_SRC_CATALUA_UI_MAGIC_H
#define CATA_SRC_CATALUA_UI_MAGIC_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

class game_handle_runtime;

// Install detached spell definition and known-spell snapshots.  Native spell
// and known_magic instances never cross the Lua boundary.
void install_magic_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_MAGIC_H
