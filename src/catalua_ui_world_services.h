#pragma once
#ifndef CATA_SRC_CATALUA_UI_WORLD_SERVICES_H
#define CATA_SRC_CATALUA_UI_WORLD_SERVICES_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

class game_handle_runtime;

// Install generation-bound spawning, follower, and avatar relocation
// services.  Mutations require game.write and an active callback.  Relocation
// additionally requires game.actions.dangerous.
void install_game_world_service_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<void()> require_dangerous_relocation,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_WORLD_SERVICES_H
