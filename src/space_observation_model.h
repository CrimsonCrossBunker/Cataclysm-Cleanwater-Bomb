#pragma once
#ifndef CATA_SRC_SPACE_OBSERVATION_MODEL_H
#define CATA_SRC_SPACE_OBSERVATION_MODEL_H

#include <optional>

#include "space_orbit_model.h"

namespace space_model
{
struct observer {
    double latitude_deg;
    double longitude_deg;
    double altitude_km;
};

struct observation {
    double azimuth_deg;
    double elevation_deg;
    double distance_km;
    double range_rate_km_s;
    bool visible;
};

struct pass_window {
    double rise_s;
    double peak_s;
    double set_s;
    double peak_elevation_deg;
    bool clipped_at_start;
    bool clipped_at_end;
};

struct sightline {
    bool earth_blocked;
    bool moon_blocked;
    double distance_km;
    double light_time_s;
};

observation observe( const state &target, const observer &site, double minimum_elevation_deg );
std::optional<pass_window> next_pass( const orbit &elements, const observer &site, double begin_s,
                                     double end_s, double minimum_elevation_deg );
sightline line_of_sight( const state &from, const state &to );
bool sunlit( const state &target, vector3 direction_to_sun );
} // namespace space_model

#endif // CATA_SRC_SPACE_OBSERVATION_MODEL_H
