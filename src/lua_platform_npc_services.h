#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_NPC_SERVICES_H
#define CATA_SRC_LUA_PLATFORM_NPC_SERVICES_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

class game_handle_runtime;

// Add domain-shaped native NPC services without coupling them to EOC names.
void install_npc_domain_services(
    sol::table &npcs,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_read,
    const std::function<void()> &require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_NPC_SERVICES_H
