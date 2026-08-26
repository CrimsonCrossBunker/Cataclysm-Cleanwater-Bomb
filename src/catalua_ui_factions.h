#pragma once
#ifndef CATA_SRC_CATALUA_UI_FACTIONS_H
#define CATA_SRC_CATALUA_UI_FACTIONS_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

// Install native faction catalogs and active-world faction services.
void install_faction_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_FACTIONS_H
