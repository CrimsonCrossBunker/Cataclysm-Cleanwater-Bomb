#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_WORLD_SERVICES_H
#define CATA_SRC_LUA_PLATFORM_WORLD_SERVICES_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Install source-only relocation and native Avatar teleport services into an
// existing services.relocation table.  The enabled and disabled routes
// intentionally share this installer boundary while legacy functions remain
// unchanged.
void install_relocation_move_api(
    sol::table &relocation,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_write,
    const std::function<void()> &require_dangerous_relocation,
    const std::function<bool()> &has_active_callback );

// Install generation-bound spawning, follower, and avatar relocation
// services. Mutations require an active Platform write callback. Relocation
// additionally requires the explicit dangerous-relocation guard.
void install_game_world_service_api(
    sol::table &services,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_read,
    const std::function<void()> &require_write,
    const std::function<void()> &require_dangerous_relocation,
    const std::function<bool()> &has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_WORLD_SERVICES_H
