#include "regional_climate.h"

#include <algorithm>
#include <cmath>
#include <functional>
#include <map>
#include <numeric>
#include <string_view>
#include <utility>
#include <vector>

#include "flexbuffer_json.h"
#include "math_defines.h"
#include "point.h"

namespace regional_climate
{
namespace
{
using cartesian = std::array<double, 3>;
constexpr double radians_per_degree = M_PI / 180.0;
constexpr double earth_radius_m = 6371000.0;
constexpr std::array<std::string_view, 4> systems = { "frontal", "monsoon", "convective", "trade_wind" };

struct station {
    coordinates location;
    cartesian position;
    normals data;
};

std::map<std::string, station> stations;

cartesian on_sphere( coordinates location )
{
    const double latitude = location.latitude * radians_per_degree;
    const double longitude = location.longitude * radians_per_degree;
    return { std::cos( latitude ) *std::cos( longitude ), std::cos( latitude ) *std::sin( longitude ),
             std::sin( latitude ) };
}

double distance_squared( const cartesian &a, const cartesian &b )
{
    const double x = a[0] - b[0];
    const double y = a[1] - b[1];
    const double z = a[2] - b[2];
    return x * x + y * y + z * z;
}
} // namespace

rain_system monthly_normal::dominant_system() const
{
    return static_cast<rain_system>( std::max_element( system_weights.begin(), system_weights.end() ) -
                                     system_weights.begin() );
}

double normals::annual_precipitation_mm() const
{
    return std::accumulate( months.begin(), months.end(), 0.0,
    []( double sum, const monthly_normal & month ) {
        return sum + month.precipitation_mm;
    } );
}

std::optional<coordinates> station_location( const std::string &id )
{
    const auto found = stations.find( id );
    return found == stations.end() ? std::nullopt : std::optional<coordinates>
           ( found->second.location );
}

coordinates offset_metres( coordinates origin, double east, double north )
{
    // Spherical transverse Mercator inverse, centred on the starting longitude.
    const double north_angle = origin.latitude * radians_per_degree + north / earth_radius_m;
    const double east_angle = east / earth_radius_m;
    // Fold distant generated terrain back to the nearest model boundary rather than wrapping it.
    const double y = std::clamp( north_angle, 0.0, M_PI / 2.0 );
    const double x = std::clamp( east_angle, -M_PI / 2.0, M_PI / 2.0 );
    return { std::asin( std::sin( y ) / std::cosh( x ) ) / radians_per_degree,
             std::remainder( origin.longitude + std::atan2( std::sinh( x ), std::cos( y ) ) /
                             radians_per_degree, 360.0 ) };
}

std::optional<normals> at( coordinates location )
{
    if( stations.empty() || !std::isfinite( location.latitude ) ||
        !std::isfinite( location.longitude ) ||
        std::abs( location.latitude ) > 90.0 || std::abs( location.longitude ) > 180.0 ) {
        return std::nullopt;
    }
    const cartesian position = on_sphere( location );
    // Blend the closest stations. Taper to zero at the fifth to avoid jumps as neighbours change.
    std::array<std::pair<double, const station *>, 5> closest{};
    for( auto &entry : closest ) {
        entry.first = 4.0;
    }
    for( const auto &entry : stations ) {
        const double d = distance_squared( position, entry.second.position );
        if( d < 1e-16 ) {
            return entry.second.data;
        }
        const auto insert = std::find_if( closest.begin(), closest.end(), [d]( const auto & candidate ) {
            return !candidate.second || d < candidate.first;
        } );
        if( insert != closest.end() ) {
            std::move_backward( insert, closest.end() - 1, closest.end() );
            *insert = { d, &entry.second };
        }
    }
    const double cutoff = closest.back().first;
    normals result{};
    double total_weight = 0;
    for( auto it = closest.begin(); it != closest.end() - 1 && it->second; ++it ) {
        const double relative_weight = ( cutoff - it->first ) / it->first;
        const double weight = relative_weight * relative_weight;
        total_weight += weight;
        for( size_t i = 0; i < result.months.size(); ++i ) {
            const monthly_normal &source = it->second->data.months[i];
            monthly_normal &dest = result.months[i];
            dest.low_c += source.low_c * weight;
            dest.high_c += source.high_c * weight;
            dest.precipitation_mm += source.precipitation_mm * weight;
            dest.wet_days += source.wet_days * weight;
            for( size_t system = 0; system < systems.size(); ++system ) {
                dest.system_weights[system] += source.system_weights[system] * source.precipitation_mm * weight;
            }
        }
    }
    if( total_weight == 0 ) {
        return closest.front().second->data;
    }
    for( monthly_normal &dest : result.months ) {
        if( dest.precipitation_mm > 0 ) {
            for( double &weight : dest.system_weights ) {
                weight /= dest.precipitation_mm;
            }
        }
        dest.low_c /= total_weight;
        dest.high_c /= total_weight;
        dest.precipitation_mm /= total_weight;
        dest.wet_days /= total_weight;
    }
    return result;
}

double precipitation_rate( const monthly_normal &normal, double days_in_game_month,
                           double hour, int day, unsigned seed, double spatial_phase )
{
    if( normal.precipitation_mm <= 0 || normal.wet_days <= 0 || days_in_game_month <= 0 ) {
        return 0;
    }
    const double wet_days = std::min( normal.wet_days, days_in_game_month );
    const auto roll = [day, seed]( int salt ) {
        return ( std::hash<tripoint> {}( tripoint( day, static_cast<int>( seed ), salt ) ) &
                 0xffffff ) / 16777216.0;
    };
    const double local_roll = roll( 0 ) + spatial_phase;
    if( local_roll - std::floor( local_roll ) >= wet_days / days_in_game_month ) {
        return 0;
    }
    double pick = roll( 1 );
    size_t system = 0;
    for( ; system + 1 < systems.size() && pick >= normal.system_weights[system]; ++system ) {
        pick -= normal.system_weights[system];
    }
    // Fronts produce longer events. Summer showers tend to start in the afternoon.
    constexpr std::array<double, 4> duration = { 12.0, 4.0, 3.0, 7.0 };
    constexpr std::array<double, 4> earliest = { 0.0, 13.0, 12.0, 0.0 };
    const double start = earliest[system] +
                         std::floor( roll( 2 ) * ( 24.0 - duration[system] - earliest[system] + 1.0 ) );
    return hour >= start && hour < start + duration[system] ?
           normal.precipitation_mm / wet_days / duration[system] : 0.0;
}

void load_station( const JsonObject &jo, const std::string & )
{
    const std::string id = jo.get_string( "id" );
    const coordinates location{ jo.get_float( "latitude" ), jo.get_float( "longitude" ) };
    if( !std::isfinite( location.latitude ) || !std::isfinite( location.longitude ) ||
        std::abs( location.latitude ) > 90.0 || std::abs( location.longitude ) > 180.0 ) {
        jo.throw_error( "Climate station coordinates are out of range" );
    }
    jo.get_string( "name" );
    jo.get_string( "source_station" );
    const JsonArray months = jo.get_array( "months" );
    station entry{ location, on_sphere( location ), {} };
    if( months.size() != entry.data.months.size() ) {
        jo.throw_error_at( "months", "Climate stations require twelve monthly normals, January first" );
    }
    for( size_t i = 0; i < months.size(); ++i ) {
        const JsonArray row = months.get_array( i );
        monthly_normal &month = entry.data.months[i];
        if( row.size() != 5 ) {
            row.throw_error( "Expected low C, high C, precipitation mm, wet days and rain system" );
        }
        month.low_c = row.get_float( 0 );
        month.high_c = row.get_float( 1 );
        month.precipitation_mm = row.get_float( 2 );
        month.wet_days = row.get_float( 3 );
        const std::string system = row.get_string( 4 );
        const auto found = std::find( systems.begin(), systems.end(), system );
        if( found == systems.end() || !std::isfinite( month.low_c ) || !std::isfinite( month.high_c ) ||
            !std::isfinite( month.precipitation_mm ) || !std::isfinite( month.wet_days ) ||
            month.low_c > month.high_c || month.precipitation_mm < 0 ||
            month.wet_days < 0 || month.wet_days > 31 ||
            ( month.precipitation_mm > 0 && month.wet_days == 0 ) ) {
            row.throw_error( "Invalid climate monthly normal" );
        }
        month.system_weights[found - systems.begin()] = 1.0;
    }
    stations.insert_or_assign( id, std::move( entry ) );
}

void reset()
{
    stations.clear();
}
} // namespace regional_climate
