#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_ELEVATION_H
#define CATA_SRC_NORTH_AMERICA_ELEVATION_H

#include <optional>

#include "coordinates.h"

class map;

namespace regional_climate
{
struct coordinates;
} // namespace regional_climate

namespace north_america
{
inline constexpr double floor_height_m = 4.0;
inline constexpr double altitude_limit_m = 16384.0;

// Geographic queries use the same coordinates as the existing North America atlas.
std::optional<double> dem_elevation( regional_climate::coordinates location );
std::optional<double> dem_elevation( point_abs_ms position );
struct water_level {
    double metres;
    bool flat;
};
std::optional<water_level> water_surface_elevation( point_abs_ms position );
bool elevation_active();
double surface_elevation( point_abs_ms position );
double altitude_at( const tripoint_abs_ms &position );
double altitude_at( const map &here, const tripoint_bub_ms &position );
bool within_altitude_limits( double metres );

// Grade is rise divided by horizontal distance. Positive grades are uphill.
double grade_move_multiplier( double grade );
double grade_between( const map &here, const tripoint_bub_ms &from,
                      const tripoint_bub_ms &to );
point surface_slope( const map &here, const tripoint_bub_ms &position );
double temperature_delta_at_height( double altitude_m, double reference_m );
double pressure_ratio_at_height( double altitude_m );
double wind_speed_factor( double altitude_m, double surface_m );
} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_ELEVATION_H
