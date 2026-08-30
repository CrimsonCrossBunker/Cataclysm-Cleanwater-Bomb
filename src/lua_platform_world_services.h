#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_WORLD_SERVICES_H
#define CATA_SRC_LUA_PLATFORM_WORLD_SERVICES_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Install the source-only relocation move vertical slice into an existing
// services.relocation table.  The enabled and disabled routes intentionally
// share this installer boundary while the legacy relocation functions remain
// unchanged.
void install_relocation_move_api(
    sol::table &relocation,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_write,
    std::function<void()> require_dangerous_relocation,
    std::function<bool()> has_active_callback );

// Install generation-bound spawning, follower, and avatar relocation
// services. Mutations require an active Platform write callback. Relocation
// additionally requires the explicit dangerous-relocation guard.
void install_game_world_service_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<void()> require_dangerous_relocation,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_WORLD_SERVICES_H
