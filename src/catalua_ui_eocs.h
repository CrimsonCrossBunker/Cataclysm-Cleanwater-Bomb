#pragma once
#ifndef CATA_SRC_CATALUA_UI_EOCS_H
#define CATA_SRC_CATALUA_UI_EOCS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install the authored EOC bridge.  EOC definitions remain native-owned;
// Lua receives detached metadata and invokes them through bounded contexts.
void install_eoc_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> has_active_callback );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_EOCS_H
