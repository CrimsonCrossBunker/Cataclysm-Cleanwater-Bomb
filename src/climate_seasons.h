#pragma once
#ifndef CATA_SRC_CLIMATE_SEASONS_H
#define CATA_SRC_CLIMATE_SEASONS_H

#include <array>
#include <optional>

#include "calendar.h"
#include "regional_climate.h"

namespace regional_climate
{
constexpr int model_year_days = 364;

struct temperature_normal {
    int month;
    double mean_c;
    double daily_range_c;
};

temperature_normal temperature_for_day( const normals &climate, double model_day );

struct seasonal_cycle {
    std::array<season_type, model_year_days> air;
    std::array<season_type, model_year_days> foliage;
};

seasonal_cycle seasonal_calendar( const normals &climate );
void set_calendar_location( std::optional<coordinates> location );
} // namespace regional_climate

#endif // CATA_SRC_CLIMATE_SEASONS_H
