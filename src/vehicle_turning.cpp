#include "vehicle_turning.h"

#include <cmath>
#include <optional>

std::optional<vehicle_turning_arc> vehicle_turning_arc::through( double forward, double lateral )
{
    constexpr double pi = 3.14159265358979323846;
    if( !std::isfinite( forward ) || !std::isfinite( lateral ) ||
        forward < 2.0 || std::abs( lateral ) < 0.5 || std::abs( lateral ) > forward ) {
        return std::nullopt;
    }
    const double curvature = 2.0 * lateral / ( forward * forward + lateral * lateral );
    // Reject arcs requiring a sharper step than ordinary steering.
    if( std::abs( curvature ) * std::sqrt( 2.0 ) > pi / 12.0 ) {
        return std::nullopt;
    }
    return vehicle_turning_arc { 2.0 * std::atan2( lateral, forward ), curvature };
}
