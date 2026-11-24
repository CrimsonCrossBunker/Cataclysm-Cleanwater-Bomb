#include "space_lunar_transfer_model.h"

#include <cmath>
#include <stdexcept>

#include "space_earth_moon_model.h"

namespace space_model
{
lunar_transfer plan_lunar_transfer( double departure_s, double earth_parking_altitude_km,
                                    double lunar_parking_altitude_km )
{
    validate_time( departure_s );
    if( !std::isfinite( earth_parking_altitude_km ) || earth_parking_altitude_km < 160.0 ||
        earth_parking_altitude_km > 100000.0 || !std::isfinite( lunar_parking_altitude_km ) ||
        lunar_parking_altitude_km < 20.0 || lunar_parking_altitude_km > 20000.0 ) {
        throw std::invalid_argument( "transfer parking altitudes must be Earth 160..100000 km and Moon 20..20000 km" );
    }
    const double earth_radius = radius_km( body::earth );
    const double parking_radius = earth_radius + earth_parking_altitude_km;
    const double earth_mu = mu( body::earth );
    const auto half_period = [&]( double arrival_radius ) {
        const double axis = ( parking_radius + arrival_radius ) * 0.5;
        return pi * std::sqrt( axis * axis * axis / earth_mu );
    };

    // Aim the coplanar half ellipse at the Moon at encounter, not at departure.
    double encounter = departure_s + half_period( 384400.0 );
    for( int i = 0; i < 16; ++i ) {
        encounter = departure_s + half_period( norm( moon_ephemeris( encounter ).position_km ) );
    }
    const state moon = moon_ephemeris( encounter );
    const vector3 normal = cross( moon.position_km, moon.velocity_km_s );
    const vector3 direction = moon.position_km * ( -1.0 / norm( moon.position_km ) );
    const double inclination = std::atan2( std::hypot( normal.x, normal.y ), normal.z );
    const double node = std::atan2( normal.x, -normal.y );
    const vector3 u{ std::cos( node ), std::sin( node ), 0.0 };
    const vector3 v{ -u.y * std::cos( inclination ), u.x * std::cos( inclination ),
                     std::sin( inclination ) };
    const auto positive_deg = []( double angle ) {
        return std::fmod( angle / rad + 360.0, 360.0 );
    };
    const orbit arc{ body::earth, earth_parking_altitude_km, norm( moon.position_km ) - earth_radius,
                     inclination / rad, positive_deg( node ),
                     positive_deg( std::atan2( dot( direction, v ), dot( direction, u ) ) ),
                     0.0, departure_s };
    const state departure = propagate( arc, departure_s ).motion;
    const double circular_speed = std::sqrt( earth_mu / parking_radius );
    const double departure_speed = norm( departure.velocity_km_s );
    const state parking{ body::earth, departure_s, departure.position_km,
                         departure.velocity_km_s * ( circular_speed / departure_speed ) };
    const auto lunar_state = [&]( double time_s ) {
        return recenter( propagate( arc, time_s ).motion, body::moon );
    };
    // Find the first bracket at the lunar sphere of influence before refining it.
    double lo = departure_s;
    double hi = encounter;
    for( int i = 1; i <= 128; ++i ) {
        const double sample = departure_s + ( encounter - departure_s ) * i / 128.0;
        if( norm( lunar_state( sample ).position_km ) <= lunar_influence_radius_km ) {
            hi = sample;
            break;
        }
        lo = sample;
    }
    for( int i = 0; i < 36; ++i ) {
        const double mid = ( lo + hi ) * 0.5;
        if( norm( lunar_state( mid ).position_km ) <= lunar_influence_radius_km ) {
            hi = mid;
        } else {
            lo = mid;
        }
    }

    // Estimate a tangential parking burn from encounter excess speed. This does not
    // target a real lunar periapsis or model a powered approach through the sphere.
    const double excess = norm( lunar_state( encounter ).velocity_km_s );
    const double lunar_radius = radius_km( body::moon ) + lunar_parking_altitude_km;
    const double lunar_circular = std::sqrt( mu( body::moon ) / lunar_radius );
    const double capture = std::hypot( excess, std::sqrt( 2.0 ) * lunar_circular ) - lunar_circular;
    return { arc, hi, encounter, departure_speed - circular_speed, capture, parking, lunar_state( hi ) };
}
} // namespace space_model
