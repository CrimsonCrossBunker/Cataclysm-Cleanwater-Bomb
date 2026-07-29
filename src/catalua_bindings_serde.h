#pragma once
#ifndef CATA_SRC_CATALUA_BINDINGS_SERDE_H
#define CATA_SRC_CATALUA_BINDINGS_SERDE_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install the bounded API v5 value codec under game.serde.  The codec uses a
// strict native allowlist and never invokes a Lua constructor by serialized
// type name.
void install_serde_api(
    sol::state &lua, sol::table &game, std::function<void()> require_values );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_BINDINGS_SERDE_H
