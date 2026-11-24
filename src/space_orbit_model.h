#pragma once
#ifndef CATA_SRC_SPACE_ORBIT_MODEL_H
#define CATA_SRC_SPACE_ORBIT_MODEL_H

namespace space_model
{
enum class body { earth, moon };
constexpr double pi = 3.14159265358979323846;
constexpr double rad = pi / 180.0;
constexpr double earth_rotation_rad_s = 2.0 * pi / 86164.0905;
constexpr double lunar_influence_radius_km = 66100.0;

struct vector3 {
    double x;
    double y;
    double z;
};

vector3 operator+( vector3 a, vector3 b );
vector3 operator-( vector3 a, vector3 b );
vector3 operator*( vector3 a, double scale );
double dot( vector3 a, vector3 b );
vector3 cross( vector3 a, vector3 b );
double norm( vector3 a );
void validate_time( double time_s );
void validate_vector( vector3 value );
double radius_km( body center );
double mu( body center );

struct orbit {
    body center;
    double periapsis_altitude_km;
    double apoapsis_altitude_km;
    double inclination_deg = 0;
    double ascending_node_deg = 0;
    double argument_of_periapsis_deg = 0;
    double mean_anomaly_deg = 0;
    double epoch_s = 0;
};

struct state {
    body center;
    double time_s;
    vector3 position_km;
    vector3 velocity_km_s;
};

struct orbital_state {
    state motion;
    double altitude_km;
    double period_s;
};

orbital_state propagate( const orbit &elements, double time_s );
} // namespace space_model

#endif // CATA_SRC_SPACE_ORBIT_MODEL_H
