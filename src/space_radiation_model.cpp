#include "space_radiation_model.h"

#include <algorithm>
#include <cmath>
#include <stdexcept>

#include "space_earth_moon_model.h"

namespace space_model
{
radiation_sample radiation( const state &target, double shield_g_cm2, double solar_event_strength,
                            double duration_s )
{
    if( !( shield_g_cm2 >= 0.0 && shield_g_cm2 <= 10000.0 && solar_event_strength >= 0.0 &&
           solar_event_strength <= 100.0 && duration_s >= 0.0 && duration_s <= 1.0e9 ) ) {
        throw std::invalid_argument( "invalid gameplay radiation shielding, solar strength, or exposure duration" );
    }
    const state earth = recenter( target, body::earth );
    const state moon = recenter( target, body::moon );
    const double distance = norm( earth.position_km );
    if( distance < radius_km( body::earth ) - 1.0e-8 ||
        norm( moon.position_km ) < radius_km( body::moon ) - 1.0e-8 ) {
        throw std::invalid_argument( "space radiation sample lies inside Earth or Moon" );
    }
    const double altitude = std::max( 0.0, distance - radius_km( body::earth ) );
    const double polar = std::abs( earth.position_km.z ) / distance;
    const double atmosphere = -std::expm1( -std::pow( altitude / 125.0, 3.0 ) );
    const double deep_space = -std::expm1( -std::pow( altitude / 22000.0, 2.0 ) );
    const double access = atmosphere * ( deep_space + ( 1.0 - deep_space ) * ( 0.08 + 0.32 * polar ) );
    const auto belt = [&]( double peak, double width ) {
        return std::exp( -0.5 * std::pow( ( altitude - peak ) / width, 2.0 ) );
    };
    // Tunable game hazard curves, not measurements or a particle transport model.
    const double trapped = atmosphere * std::exp( -9.0 * polar * polar ) *
                           ( 1.8 * belt( 3500.0, 1600.0 ) + 0.7 * belt( 20000.0, 7500.0 ) ) *
                           std::exp( -shield_g_cm2 / 12.0 );
    const double galactic = 0.06 * access * std::exp( -shield_g_cm2 / 150.0 );
    const double solar = 0.25 * solar_event_strength * access * std::exp( -shield_g_cm2 / 7.0 );
    const double total = galactic + trapped + solar;
    return { galactic, trapped, solar, total, total * duration_s / 3600.0 };
}
} // namespace space_model
