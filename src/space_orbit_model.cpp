#include "space_orbit_model.h"

#include <cmath>
#include <stdexcept>

namespace space_model
{
vector3 operator+( vector3 a, vector3 b )
{
    return { a.x + b.x, a.y + b.y, a.z + b.z };
}

vector3 operator-( vector3 a, vector3 b )
{
    return { a.x - b.x, a.y - b.y, a.z - b.z };
}

vector3 operator*( vector3 a, double scale )
{
    return { a.x * scale, a.y * scale, a.z * scale };
}

double dot( vector3 a, vector3 b )
{
    return a.x * b.x + a.y * b.y + a.z * b.z;
}

vector3 cross( vector3 a, vector3 b )
{
    return { a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x };
}

double norm( vector3 a )
{
    return std::hypot( a.x, a.y, a.z );
}

void validate_time( double time_s )
{
    if( !std::isfinite( time_s ) || std::abs( time_s ) > 1.0e11 ) {
        throw std::invalid_argument( "space time must be within +/- 1e11 simulation seconds" );
    }
}

void validate_vector( vector3 value )
{
    const double length = norm( value );
    if( !std::isfinite( length ) || length > 1.0e9 ) {
        throw std::invalid_argument( "space vector magnitude must be finite and at most 1e9" );
    }
}

double radius_km( body center )
{
    return center == body::earth ? 6371.0 : 1737.4;
}

double mu( body center )
{
    return center == body::earth ? 398600.435507 : 4902.800118;
}

orbital_state propagate( const orbit &elements, double time_s )
{
    validate_time( time_s );
    validate_time( elements.epoch_s );
    const double radius = radius_km( elements.center );
    const double periapsis = radius + elements.periapsis_altitude_km;
    const double apoapsis = radius + elements.apoapsis_altitude_km;
    const double limit = elements.center == body::earth ? 450000.0 : lunar_influence_radius_km;
    if( !std::isfinite( periapsis ) || !std::isfinite( apoapsis ) || periapsis <= radius ||
        apoapsis < periapsis || apoapsis > limit ) {
        throw std::invalid_argument( "invalid periapsis or apoapsis for space orbit" );
    }
    const auto angle = []( double value, double maximum ) {
        return std::isfinite( value ) && value >= 0.0 && value <= maximum;
    };
    if( !angle( elements.inclination_deg, 180.0 ) || !angle( elements.ascending_node_deg, 360.0 ) ||
        !angle( elements.argument_of_periapsis_deg, 360.0 ) ||
        !angle( elements.mean_anomaly_deg, 360.0 ) ) {
        throw std::invalid_argument( "invalid space orbit angle" );
    }

    const double axis = ( periapsis + apoapsis ) * 0.5;
    const double e = ( apoapsis - periapsis ) / ( apoapsis + periapsis );
    const double motion = std::sqrt( mu( elements.center ) / ( axis * axis * axis ) );
    const double period = 2.0 * pi / motion;
    const double mean = std::remainder( elements.mean_anomaly_deg * rad +
                                       motion * std::remainder( time_s - elements.epoch_s, period ), 2.0 * pi );
    // Keep the Newton iteration bracketed for highly eccentric orbits.
    double lo = -pi;
    double hi = pi;
    double anomaly = mean;
    for( int i = 0; i < 48; ++i ) {
        const double residual = anomaly - e * std::sin( anomaly ) - mean;
        if( std::abs( residual ) < 1.0e-14 ) {
            break;
        }
        if( residual < 0.0 ) {
            lo = anomaly;
        } else {
            hi = anomaly;
        }
        const double next = anomaly - residual / ( 1.0 - e * std::cos( anomaly ) );
        anomaly = next > lo && next < hi ? next : ( lo + hi ) * 0.5;
    }

    const double node = elements.ascending_node_deg * rad;
    const double inc = elements.inclination_deg * rad;
    const double arg = elements.argument_of_periapsis_deg * rad;
    const vector3 u{ std::cos( node ), std::sin( node ), 0.0 };
    const vector3 v{ -u.y * std::cos( inc ), u.x * std::cos( inc ), std::sin( inc ) };
    const vector3 p = u * std::cos( arg ) + v * std::sin( arg );
    const vector3 q = u * -std::sin( arg ) + v * std::cos( arg );
    const double c = std::cos( anomaly );
    const double s = std::sin( anomaly );
    const double minor_ratio = std::sqrt( 1.0 - e * e );
    const double r = axis * ( 1.0 - e * c );
    const double speed = motion * axis * axis / r;
    return { { elements.center, time_s, p * ( axis * ( c - e ) ) + q * ( axis * minor_ratio * s ),
               p * ( -speed * s ) + q * ( speed * minor_ratio * c )
             }, r - radius, period };
}
} // namespace space_model
