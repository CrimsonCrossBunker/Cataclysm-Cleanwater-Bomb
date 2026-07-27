#pragma once
#ifndef CATA_SRC_CATALUA_UI_NAVIGATION_INTERNAL_H
#define CATA_SRC_CATALUA_UI_NAVIGATION_INTERNAL_H

#include <functional>
#include <string>

#include "catalua_sol.h"

namespace cata::lua_ui
{

void install_navigation_api( sol::table &ui, std::function<void()> authorize_access,
                             std::function<bool()> can_queue,
                             std::function<bool( const std::string & )> page_exists );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_NAVIGATION_INTERNAL_H
