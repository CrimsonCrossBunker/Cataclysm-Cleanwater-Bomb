#pragma once
#ifndef CATA_SRC_CATALUA_UI_NAVIGATION_H
#define CATA_SRC_CATALUA_UI_NAVIGATION_H

#include <cstddef>
#include <map>
#include <optional>
#include <string>

#include "catalua_ui_state.h"

namespace cata::lua_ui
{

enum class navigation_request_type : int {
    open_page,
    back,
    close
};

using navigation_parameters = std::map<std::string, script_persistent_value>;

struct navigation_request {
    navigation_request_type type = navigation_request_type::close;
    std::string page_id;
    navigation_parameters parameters;
};

// Navigation is queued from Lua callbacks and consumed only by a page host or
// the regular game input loop.  This prevents an event/draw callback from
// creating or destroying a UI while the current ImGui frame is on the stack.
std::optional<navigation_request> take_navigation_request();
void clear_navigation_requests();
std::size_t pending_navigation_request_count();

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_NAVIGATION_H
