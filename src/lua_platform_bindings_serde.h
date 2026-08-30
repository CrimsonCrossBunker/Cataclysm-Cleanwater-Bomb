#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_BINDINGS_SERDE_H
#define CATA_SRC_LUA_PLATFORM_BINDINGS_SERDE_H

#include <functional>

#include "lua_platform_sol.h"

namespace cata::lua_platform
{

// Install the bounded Platform value codec under services.serde. The codec
// uses a strict native allowlist and never invokes a Lua constructor by
// serialized type name.
void install_serde_api(
    sol::state &lua, sol::table &services, std::function<void()> require_values );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_BINDINGS_SERDE_H
