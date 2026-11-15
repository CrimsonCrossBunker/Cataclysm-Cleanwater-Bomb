#include "climate_seasons.h"

#include <algorithm>
#include <cmath>
#include <iterator>

#include "regional_climate.h"

namespace regional_climate
{
namespace
{
constexpr double leaf_base_c = 5;
constexpr double colour_base_c = 13;
constexpr int smoothing_days = 5;

constexpr int wrap( int day )
{
    return ( day + model_year_days ) % model_year_days;
}
} // namespace

temperature_normal temperature_for_day( const normals &climate, double model_day )
{
    model_day = std::fmod( model_day + model_year_days, model_year_days );
    const int quarter = static_cast<int>( model_day / 91 );
    const double quarter_day = model_day - quarter * 91;
    const int month = quarter * 3 + ( quarter_day < 31 ? 0 : quarter_day < 61 ? 1 : 2 );
    const double day = quarter_day - ( month % 3 == 0 ? 0 : month % 3 == 1 ? 31 : 61 );
    const auto length = []( int index ) {
        return index % 3 == 0 ? 31.0 : 30.0;
    };
    const double half = length( month ) / 2;
    const int neighbour = ( month + ( day < half ? 11 : 1 ) ) % 12;
    const double weight = std::abs( day - half ) / ( half + length( neighbour ) / 2 );
    const monthly_normal &current = climate.months[month];
    const monthly_normal &adjacent = climate.months[neighbour];
    const double low = current.low_c + ( adjacent.low_c - current.low_c ) * weight;
    const double high = current.high_c + ( adjacent.high_c - current.high_c ) * weight;
    return { month, ( high + low ) / 2, ( high - low ) / 2 };
}

seasonal_cycle seasonal_calendar( const normals &climate )
{
    std::array<double, model_year_days> daily{};
    std::array<double, model_year_days> smoothed{};
    for( int day = 0; day < model_year_days; ++day ) {
        daily[day] = temperature_for_day( climate, day + 0.5 ).mean_c;
    }
    for( int day = 0; day < model_year_days; ++day ) {
        for( int previous = 0; previous < smoothing_days; ++previous ) {
            smoothed[day] += daily[wrap( day - previous )] / smoothing_days;
        }
    }

    seasonal_cycle result;
    const auto [coldest_it, warmest_it] = std::minmax_element( smoothed.begin(), smoothed.end() );
    const int coldest = std::distance( smoothed.begin(), coldest_it );
    const int warmest = std::distance( smoothed.begin(), warmest_it );
    const int warming_days = wrap( warmest - coldest );
    for( int day = 0; day < model_year_days; ++day ) {
        const bool warming = wrap( day - coldest ) < warming_days;
        result.air[day] = smoothed[day] < 10 ? WINTER : smoothed[day] >= 22 ? SUMMER :
                          warming ? SPRING : AUTUMN;
    }

    // A generic temperature-driven deciduous canopy, independent of the air seasons.
    if( *coldest_it >= 16 ) {
        result.foliage.fill( SUMMER );
        return result;
    }
    result.foliage.fill( WINTER );
    double growing_degrees = 0;
    bool leafed_out = false;
    bool full_leaf = false;
    for( int elapsed = 1; elapsed <= warming_days; ++elapsed ) {
        const int day = wrap( coldest + elapsed );
        growing_degrees += std::max( 0.0, daily[day] - leaf_base_c );
        leafed_out = leafed_out || ( growing_degrees >= 85 && smoothed[day] >= 7 );
        full_leaf = full_leaf || ( leafed_out && growing_degrees >= 180 );
        result.foliage[day] = full_leaf ? SUMMER : leafed_out ? SPRING : WINTER;
    }
    if( !leafed_out ) {
        return result;
    }
    double cooling_degrees = 0;
    for( int elapsed = 1; elapsed < model_year_days - warming_days; ++elapsed ) {
        const int day = wrap( warmest + elapsed );
        cooling_degrees += std::max( 0.0, colour_base_c - daily[day] );
        growing_degrees += std::max( 0.0, daily[day] - leaf_base_c );
        full_leaf = full_leaf || growing_degrees >= 180;
        if( cooling_degrees >= 180 || smoothed[day] <= 0 ) {
            break;
        }
        result.foliage[day] = cooling_degrees >= 55 ? AUTUMN : full_leaf ? SUMMER : SPRING;
    }
    return result;
}
} // namespace regional_climate
