#pragma once
#ifndef CATA_SRC_CATALUA_UI_SKILLS_H
#define CATA_SRC_CATALUA_UI_SKILLS_H

#include <cstddef>
#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install the native skill definition and character skill service.
void install_skill_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_SKILLS_H
