#include "ionosphere_model.h"

#include <algorithm>
#include <cmath>
#include <stdexcept>

namespace ionosphere_model
{
namespace
{
double chapman_layer( double altitude_km, double peak_km, double scale_km, double peak_density )
{
    const double relative_height = ( altitude_km - peak_km ) / scale_km;
    return peak_density * std::exp( 0.5 * ( 1.0 - relative_height - std::exp( -relative_height ) ) );
}
} // namespace

sample evaluate( double altitude_km, double solar_elevation_deg )
{
    if( !std::isfinite( altitude_km ) || altitude_km < 60.0 || altitude_km > 1000.0 ) {
        throw std::invalid_argument( "ionosphere altitude_km must be between 60 and 1000" );
    }
    if( !std::isfinite( solar_elevation_deg ) || std::abs( solar_elevation_deg ) > 90.0 ) {
        throw std::invalid_argument( "ionosphere solar_elevation_deg must be between -90 and 90" );
    }

    constexpr double radians_per_degree = 0.017453292519943295;
    const double daylight = std::sqrt( std::max( 0.0,
                                      std::sin( solar_elevation_deg * radians_per_degree ) ) );
    const double d_density = chapman_layer( altitude_km, 80.0, 7.0, 1.0e9 * daylight );
    const double e_density = chapman_layer( altitude_km, 110.0, 12.0,
                                           2.0e9 + 9.8e10 * daylight );
    const double f_density = chapman_layer( altitude_km, 320.0 - 40.0 * daylight, 55.0,
                                           1.0e11 + 9.0e11 * daylight );
    const double density = d_density + e_density + f_density;
    return { d_density, e_density, f_density, density, 8.9786628 * std::sqrt( density ) };
}
} // namespace ionosphere_model
