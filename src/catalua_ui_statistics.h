#pragma once
#ifndef CATA_SRC_CATALUA_UI_STATISTICS_H
#define CATA_SRC_CATALUA_UI_STATISTICS_H

#include <functional>

#include "catalua_sol.h"

namespace cata::lua
{

// Install native event history, statistic, transformation, and score queries.
void install_statistics_api(
    sol::table &game,
    std::function<void()> require_read );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_STATISTICS_H
