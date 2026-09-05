#pragma once
#ifndef CATA_SRC_CALENDAR_UI_H
#define CATA_SRC_CALENDAR_UI_H

#include <string_view>

#include "calendar.h"

namespace calendar_ui
{

enum class granularity : int {
    year,
    season,
    day,
    hour,
    minute,
    turn,
    last,
};

/**
 * Displays ui element that allows to select and return time point.
 * ignore_eternal_season edits absolute dates before the opening season is established.
 */
time_point select_time_point( time_point initial_value,
                              std::string_view title,
                              calendar_ui::granularity granularity_level = calendar_ui::granularity::turn,
                              bool ignore_eternal_season = false );
} // namespace calendar_ui

#endif // CATA_SRC_CALENDAR_UI_H
