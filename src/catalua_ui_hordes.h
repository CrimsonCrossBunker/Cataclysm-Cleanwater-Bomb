#pragma once
#ifndef CATA_SRC_CATALUA_UI_HORDES_H
#define CATA_SRC_CATALUA_UI_HORDES_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

class game_handle_runtime;

// Install detached monster-group definitions plus bounded, existing-overmap
// horde observation and mutation APIs.  Native horde_entity and mongroup
// pointers never cross into Lua; live entries use generation-bound tokens.
void install_horde_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_HORDES_H
