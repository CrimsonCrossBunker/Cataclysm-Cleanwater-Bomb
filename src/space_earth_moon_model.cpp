#include "space_earth_moon_model.h"

namespace space_model
{
state moon_ephemeris( double time_s )
{
    // Fixed gameplay epoch and orbital plane, not an astronomical calendar ephemeris.
    constexpr double axis_km = 384400.0;
    constexpr double eccentricity = 0.0549;
    const double earth = radius_km( body::earth );
    return propagate( { body::earth, axis_km * ( 1.0 - eccentricity ) - earth,
                        axis_km * ( 1.0 + eccentricity ) - earth, 23.4, 0.0, 0.0, 0.0, 0.0
                      }, time_s ).motion;
}

state recenter( const state &motion, body center )
{
    validate_time( motion.time_s );
    validate_vector( motion.position_km );
    validate_vector( motion.velocity_km_s );
    if( motion.center == center ) {
        return motion;
    }
    const state moon = moon_ephemeris( motion.time_s );
    const double sign = center == body::earth ? 1.0 : -1.0;
    return { center, motion.time_s, motion.position_km + moon.position_km * sign,
             motion.velocity_km_s + moon.velocity_km_s * sign };
}
} // namespace space_model
