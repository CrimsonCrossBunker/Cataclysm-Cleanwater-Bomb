#include "near_earth_orbit_model.h"

#include <cmath>
#include <stdexcept>

namespace near_earth_orbit_model
{
state propagate( const elements &orbit, double elapsed_s )
{
    if( !std::isfinite( orbit.perigee_altitude_km ) || !std::isfinite( orbit.apogee_altitude_km ) ||
        orbit.perigee_altitude_km < 160.0 || orbit.apogee_altitude_km > 2000.0 ||
        orbit.perigee_altitude_km > orbit.apogee_altitude_km ) {
        throw std::invalid_argument( "orbit altitudes must satisfy 160 <= perigee <= apogee <= 2000 km" );
    }
    const auto valid_angle = []( double angle, double maximum ) {
        return std::isfinite( angle ) && angle >= 0.0 && angle <= maximum;
    };
    if( !valid_angle( orbit.inclination_deg, 180.0 ) ||
        !valid_angle( orbit.ascending_node_deg, 360.0 ) ||
        !valid_angle( orbit.argument_of_perigee_deg, 360.0 ) ||
        !valid_angle( orbit.mean_anomaly_deg, 360.0 ) ) {
        throw std::invalid_argument( "orbit inclination must be within 0 to 180 degrees; other angles within 0 to 360" );
    }
    if( !std::isfinite( elapsed_s ) ) {
        throw std::invalid_argument( "orbit elapsed_s must be finite" );
    }

    constexpr double earth_radius_km = 6371.0;
    constexpr double earth_mu_km3_s2 = 398600.435507;
    constexpr double pi = 3.14159265358979323846;
    constexpr double radians_per_degree = pi / 180.0;
    const double perigee = earth_radius_km + orbit.perigee_altitude_km;
    const double apogee = earth_radius_km + orbit.apogee_altitude_km;
    const double semimajor = ( perigee + apogee ) * 0.5;
    const double eccentricity = ( apogee - perigee ) / ( apogee + perigee );
    const double mean_motion = std::sqrt( earth_mu_km3_s2 / ( semimajor * semimajor * semimajor ) );
    const double period = 2.0 * pi / mean_motion;
    const double mean_anomaly = std::remainder( orbit.mean_anomaly_deg * radians_per_degree +
                                mean_motion * std::remainder( elapsed_s, period ), 2.0 * pi );
    double eccentric_anomaly = mean_anomaly;
    for( int iteration = 0; iteration < 8; ++iteration ) {
        const double delta = ( eccentric_anomaly - eccentricity * std::sin( eccentric_anomaly ) -
                               mean_anomaly ) / ( 1.0 - eccentricity * std::cos( eccentric_anomaly ) );
        eccentric_anomaly -= delta;
        if( std::abs( delta ) < 1.0e-13 ) {
            break;
        }
    }

    const double cos_e = std::cos( eccentric_anomaly );
    const double sin_e = std::sin( eccentric_anomaly );
    const double axis_ratio = std::sqrt( 1.0 - eccentricity * eccentricity );
    const double radius_factor = 1.0 - eccentricity * cos_e;
    const double velocity_scale = mean_motion * semimajor / radius_factor;

    const double inclination = orbit.inclination_deg * radians_per_degree;
    const double node = orbit.ascending_node_deg * radians_per_degree;
    const double perigee_angle = orbit.argument_of_perigee_deg * radians_per_degree;
    const auto to_inertial = [&]( double plane_x, double plane_y ) -> vector3 {
        const double along_node = plane_x * std::cos( perigee_angle ) - plane_y * std::sin( perigee_angle );
        const double across_node = plane_x * std::sin( perigee_angle ) + plane_y * std::cos( perigee_angle );
        const double equatorial = across_node * std::cos( inclination );
        return { along_node * std::cos( node ) - equatorial * std::sin( node ),
                 along_node * std::sin( node ) + equatorial * std::cos( node ),
                 across_node * std::sin( inclination ) };
    };

    return { to_inertial( semimajor * ( cos_e - eccentricity ), semimajor * axis_ratio * sin_e ),
             to_inertial( -velocity_scale * sin_e, velocity_scale * axis_ratio * cos_e ),
             semimajor * radius_factor - earth_radius_km, period };
}
} // namespace near_earth_orbit_model
