#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_ACTIVITIES_H
#define CATA_SRC_LUA_PLATFORM_ACTIVITIES_H

#include <cstddef>
#include <functional>
#include <set>

#include "coordinates.h"
#include "item_location.h"
#include "lua_platform_sol.h"
#include "pickup.h"

namespace cata::lua_platform
{

class game_handle_runtime;

using activity_pickup_selector = std::function<drop_locations(
                                     const std::set<tripoint_bub_ms> &, Pickup::pick_info & )>;

// Install bounded native activity actors and activity lifecycle operations.
// Lua receives generation-checked handles and detached state snapshots only.
// The optional selector seam keeps activity semantics testable without opening UI.
void install_activity_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> has_active_callback,
    activity_pickup_selector pickup_selector = {} );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_ACTIVITIES_H
