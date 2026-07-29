#pragma once
#ifndef CATA_SRC_CATALUA_UI_MUTATIONS_H
#define CATA_SRC_CATALUA_UI_MUTATIONS_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Install detached, paginated mutation definition snapshots.  Character
// mutation state and write operations are added by the same namespace.
void install_mutation_api(
    sol::table &game,
    std::function<void()> require_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MUTATIONS_H
