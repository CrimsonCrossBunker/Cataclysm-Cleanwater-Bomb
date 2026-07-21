#pragma once
#ifndef CATA_SRC_CATALUA_UI_IMGUI_H
#define CATA_SRC_CATALUA_UI_IMGUI_H

#include <memory>

namespace cata::lua_ui
{

class script_ui_renderer;

// Create the production ImGui adapter.  Tiles builds render it through SDL;
// character builds render the same calls through ImTui.
std::unique_ptr<script_ui_renderer> make_imgui_script_ui_renderer();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_IMGUI_H
