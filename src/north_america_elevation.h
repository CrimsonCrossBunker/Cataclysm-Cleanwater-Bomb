#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_ELEVATION_H
#define CATA_SRC_NORTH_AMERICA_ELEVATION_H

#include <optional>

#include "coordinates.h"
#include "point.h"

class map;
class mapgendata;

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
double altitude_at( const tripoint_abs_omt &position );
int minimum_overmap_z( point_abs_omt location );
int maximum_overmap_z( point_abs_omt location );
std::optional<tripoint_abs_omt> overmap_at_altitude( point_abs_omt location, double metres );
double altitude_at( const map &here, const tripoint_bub_ms &position );
double occupant_altitude( const map &here, const tripoint_bub_ms &position );
bool within_altitude_limits( double metres );
void grade_generated_surface( mapgendata &dat );
void extend_foundation( map &here, const tripoint_bub_ms &p, double previous_altitude );

// Grade is rise divided by horizontal distance. Positive grades are uphill.
inline constexpr double walking_grade_limit = 1.0;
inline constexpr double rope_grade_limit = 4.0;
double grade_move_multiplier( double grade );
bool sheer_slope( const map &here, const tripoint_bub_ms &from, const tripoint_bub_ms &to );
double grade_between( const map &here, const tripoint_bub_ms &from,
                      const tripoint_bub_ms &to );
point surface_slope( const map &here, const tripoint_bub_ms &position );
int surface_relief_shade( point slope );
double temperature_delta_at_height( double altitude_m, double reference_m );
double pressure_ratio_at_height( double altitude_m );
double air_density_ratio_at_height( double altitude_m );
double wind_speed_factor( double altitude_m, double surface_m );
} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_ELEVATION_H
