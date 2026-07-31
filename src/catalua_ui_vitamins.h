#pragma once
#ifndef CATA_SRC_CATALUA_UI_VITAMINS_H
#define CATA_SRC_CATALUA_UI_VITAMINS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install native vitamin definition and character pool services.
void install_vitamin_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_VITAMINS_H
