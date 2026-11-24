#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_SPACE_MODELS_H
#define CATA_SRC_LUA_PLATFORM_SPACE_MODELS_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{
void install_space_models_api( sol::table &services, const std::function<void()> &require_read );
} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_SPACE_MODELS_H
