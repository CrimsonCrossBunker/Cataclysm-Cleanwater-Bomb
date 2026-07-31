#pragma once
#ifndef CATA_SRC_CATALUA_UI_MARTIAL_ARTS_H
#define CATA_SRC_CATALUA_UI_MARTIAL_ARTS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install native martial-art definitions and character style services.
void install_martial_art_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MARTIAL_ARTS_H
