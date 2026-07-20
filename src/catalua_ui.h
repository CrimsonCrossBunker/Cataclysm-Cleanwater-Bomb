#pragma once
#ifndef CATA_SRC_CATALUA_UI_H
#define CATA_SRC_CATALUA_UI_H

#include <string_view>

namespace cata::lua_ui
{

constexpr int api_version = 1;

// Lua module names are converted from dotted names to paths below data/lua or
// config/lua.  Exposed for focused tests of the sandbox boundary.
bool is_safe_module_name( std::string_view name );

// Reload scripts, let the user choose a registered page, and run it as a
// regular cataimgui window.  The runtime is initialized lazily on first use.
void show();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_H
