#pragma once
#ifndef CATA_SRC_CATALUA_UI_EFFECTS_H
#define CATA_SRC_CATALUA_UI_EFFECTS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

class game_handle_runtime;

// Install bounded, detached effect inspection and Platform-callback-gated
// mutation.
// Effect instances never cross the Lua boundary as native references.
void install_effect_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_EFFECTS_H
