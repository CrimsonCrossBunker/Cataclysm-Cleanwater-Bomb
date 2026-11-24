#pragma once
#ifndef CATA_SRC_NEAR_EARTH_ORBIT_MODEL_H
#define CATA_SRC_NEAR_EARTH_ORBIT_MODEL_H

namespace near_earth_orbit_model
{
struct elements {
    double perigee_altitude_km;
    double apogee_altitude_km;
    double inclination_deg;
    double ascending_node_deg;
    double argument_of_perigee_deg;
    double mean_anomaly_deg;
};

struct vector3 {
    double x;
    double y;
    double z;
};

struct state {
    vector3 position_km;
    vector3 velocity_km_s;
    double altitude_km;
    double period_s;
};

state propagate( const elements &orbit, double elapsed_s );
} // namespace near_earth_orbit_model

#endif // CATA_SRC_NEAR_EARTH_ORBIT_MODEL_H
