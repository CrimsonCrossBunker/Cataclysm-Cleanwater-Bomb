#pragma once
#ifndef CATA_SRC_CATALUA_UI_NEEDS_H
#define CATA_SRC_CATALUA_UI_NEEDS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

class game_handle_runtime;

// Install generation-safe character need and health services.
void install_need_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

// Install generation-safe character sensitivity services.
void install_sensitive_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_NEEDS_H
