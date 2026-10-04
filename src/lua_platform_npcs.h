#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_NPCS_H
#define CATA_SRC_LUA_PLATFORM_NPCS_H

#include <cstddef>
#include <functional>

#include "lua_platform_sol.h"

enum class avatar_talk_to_result;

namespace cata::lua_platform
{

class game_handle_runtime;

namespace detail
{

// Build the detached synchronous result returned after native dialogue teardown.
sol::table make_npc_dialogue_result( sol::state_view state,
                                     avatar_talk_to_result result );

} // namespace detail

// Install native NPC class catalogs and generation-safe NPC services.
void install_npc_api(
    sol::table &services,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation,
    const std::function<void()> &require_read,
    const std::function<void()> &require_write,
    const std::function<void()> &invalidate_handles );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_NPCS_H
