#include "space_observation_model.h"

#include <algorithm>
#include <cmath>
#include <stdexcept>

#include "space_earth_moon_model.h"

namespace space_model
{
namespace
{
void validate_observer( const observer &site, double mask )
{
    if( !( std::abs( site.latitude_deg ) <= 90 && std::abs( site.longitude_deg ) <= 180 &&
           site.altitude_km >= 0 && site.altitude_km <= 100 && mask >= 0 && mask < 90 ) ) {
        throw std::invalid_argument( "invalid space observer or elevation mask" );
    }
}

bool sphere_blocks( vector3 start, vector3 step, double max_projection, vector3 center,
                    double radius )
{
    const vector3 relative = start - center;
    const double offset = std::clamp( -dot( relative, step ), 0.0, max_projection );
    return norm( relative + step * offset ) < radius - 1.0e-8;
}
} // namespace

observation observe( const state &target, const observer &site, double minimum_elevation_deg )
{
    validate_observer( site, minimum_elevation_deg );
    const state earth = recenter( target, body::earth );
    const double lat = site.latitude_deg * rad;
    const double lon = site.longitude_deg * rad +
                       std::remainder( earth.time_s * earth_rotation_rad_s, 2.0 * pi );
    const vector3 up{ std::cos( lat ) * std::cos( lon ), std::cos( lat ) * std::sin( lon ),
                      std::sin( lat ) };
    const vector3 east{ -std::sin( lon ), std::cos( lon ), 0.0 };
    const vector3 north = cross( up, east );
    const vector3 origin = up * ( radius_km( body::earth ) + site.altitude_km );
    const vector3 relative = earth.position_km - origin;
    const double range = norm( relative );
    if( range < 1.0e-9 ) {
        throw std::invalid_argument( "observation target coincides with the observer" );
    }
    const double azimuth = std::fmod( std::atan2( dot( relative, east ), dot( relative, north ) ) /
                                     rad + 360.0, 360.0 );
    const double elevation = std::asin( std::clamp( dot( relative, up ) / range, -1.0, 1.0 ) ) / rad;
    const vector3 site_velocity = cross( { 0.0, 0.0, earth_rotation_rad_s }, origin );
    return { azimuth, elevation, range, dot( earth.velocity_km_s - site_velocity, relative ) / range,
             elevation >= minimum_elevation_deg };
}

std::optional<pass_window> next_pass( const orbit &elements, const observer &site, double begin_s,
                                     double end_s, double minimum_elevation_deg )
{
    validate_time( begin_s );
    validate_time( end_s );
    validate_observer( site, minimum_elevation_deg );
    if( begin_s >= end_s ) {
        throw std::invalid_argument( "space pass search end must follow its start" );
    }
    const orbital_state initial = propagate( elements, begin_s );
    const double pericenter = radius_km( elements.center ) + elements.periapsis_altitude_km;
    const double apocenter = radius_km( elements.center ) + elements.apoapsis_altitude_km;
    const double axis = ( pericenter + apocenter ) * 0.5;
    const double step = std::clamp( initial.period_s / 256.0 * std::pow( pericenter / axis, 1.5 ),
                                    1.0, 120.0 );
    const double sample_count = std::ceil( ( end_s - begin_s ) / step );
    if( sample_count > 32768 ) {
        throw std::invalid_argument( "space pass search needs more than 32768 samples; shorten the window" );
    }
    const auto elevation = [&]( double time_s ) {
        return observe( propagate( elements, time_s ).motion, site, minimum_elevation_deg ).elevation_deg;
    };
    const auto crossing = [&]( double lo, double hi, bool rising ) {
        for( int i = 0; i < 24; ++i ) {
            const double mid = ( lo + hi ) * 0.5;
            if( ( elevation( mid ) >= minimum_elevation_deg ) == rising ) {
                hi = mid;
            } else {
                lo = mid;
            }
        }
        return rising ? hi : lo;
    };
    double previous = begin_s;
    double peak_time = begin_s;
    double peak = elevation( begin_s );
    const bool clipped_start = peak >= minimum_elevation_deg;
    bool found = clipped_start;
    double rise = begin_s;
    double set = end_s;
    bool clipped_end = true;
    for( int i = 1; i <= static_cast<int>( sample_count ); ++i ) {
        const double time = i == static_cast<int>( sample_count ) ? end_s : begin_s + i * step;
        const double angle = elevation( time );
        if( angle >= minimum_elevation_deg ) {
            if( !found ) {
                rise = crossing( previous, time, true );
                peak = angle;
                peak_time = time;
                found = true;
            } else if( angle > peak ) {
                peak = angle;
                peak_time = time;
            }
        } else if( found ) {
            set = crossing( previous, time, false );
            clipped_end = false;
            break;
        }
        previous = time;
    }
    if( !found ) {
        return std::nullopt;
    }
    double lo = std::max( rise, peak_time - step );
    double hi = std::min( set, peak_time + step );
    for( int i = 0; i < 24; ++i ) {
        const double left = ( 2.0 * lo + hi ) / 3.0;
        const double right = ( lo + 2.0 * hi ) / 3.0;
        if( elevation( left ) < elevation( right ) ) {
            lo = left;
        } else {
            hi = right;
        }
    }
    const double refined_time = ( lo + hi ) * 0.5;
    const double refined_peak = elevation( refined_time );
    if( refined_peak > peak ) {
        peak = refined_peak;
        peak_time = refined_time;
    }
    return pass_window{ rise, peak_time, set, peak, clipped_start, clipped_end };
}

sightline line_of_sight( const state &from, const state &to )
{
    if( from.time_s != to.time_s ) {
        throw std::invalid_argument( "space sightline endpoints must share the same time" );
    }
    const vector3 earth_from = recenter( from, body::earth ).position_km;
    const vector3 delta = recenter( to, body::earth ).position_km - earth_from;
    const double range = norm( delta );
    const vector3 step = range > 0 ? delta * ( 1.0 / range ) : vector3{ 0.0, 0.0, 0.0 };
    return { sphere_blocks( earth_from, step, range, { 0.0, 0.0, 0.0 }, radius_km( body::earth ) ),
             sphere_blocks( earth_from, step, range, moon_ephemeris( from.time_s ).position_km,
                            radius_km( body::moon ) ), range, range / 299792.458 };
}

bool sunlit( const state &target, vector3 direction_to_sun )
{
    validate_vector( direction_to_sun );
    const double magnitude = norm( direction_to_sun );
    if( magnitude < 1.0e-12 ) {
        throw std::invalid_argument( "direction to sun must be nonzero" );
    }
    const vector3 direction = direction_to_sun * ( 1.0 / magnitude );
    const state earth = recenter( target, body::earth );
    constexpr double ray_km = 1.0e10;
    return !sphere_blocks( earth.position_km, direction, ray_km, { 0.0, 0.0, 0.0 },
                           radius_km( body::earth ) ) &&
           !sphere_blocks( earth.position_km, direction, ray_km,
                           moon_ephemeris( earth.time_s ).position_km, radius_km( body::moon ) );
}
} // namespace space_model
