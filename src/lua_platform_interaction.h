#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_INTERACTION_H
#define CATA_SRC_LUA_PLATFORM_INTERACTION_H

#include <functional>
#include <memory>
#include <string>
#include <vector>

#include "lua_platform_sol.h"

class uilist;
class string_input_popup_imgui;

namespace cata::lua_platform
{

// Populate a fresh native menu without querying it; return entry IDs in native row order.
std::vector<std::string> prepare_game_interaction_menu(
    uilist &menu, const sol::table &entries, const sol::optional<sol::table> &options );

// Prepare an owned native popup, including deferred label/help/history text,
// without querying input. The caller owns the window; providers are invoked
// during preparation and are never stored in the popup or exposed to Lua.
std::unique_ptr<string_input_popup_imgui> prepare_game_text_input_popup(
    const sol::object &title, const sol::optional<sol::table> &options );

// Install callback-scoped sound playback and interactive targeting services.
// Both namespaces require an active Platform mutation callback.
void install_game_interaction_api(
    sol::table &services,
    const std::function<void()> &require_actions,
    const std::function<bool()> &has_active_callback );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_INTERACTION_H
