#include "cata_catch.h"

#include <algorithm>
#include <array>

#include "calendar.h"
#include "climate_seasons.h"
#include "regional_climate.h"

namespace
{
regional_climate::seasonal_cycle cycle_for( const std::array<double, 12> &temperatures )
{
    regional_climate::normals climate;
    for( std::size_t month = 0; month < temperatures.size(); ++month ) {
        climate.months[month].low_c = temperatures[month] - 4;
        climate.months[month].high_c = temperatures[month] + 4;
    }
    return regional_climate::seasonal_calendar( climate );
}
} // namespace

TEST_CASE( "thermal_seasons_and_leaf_stages_follow_local_temperature", "[regional_climate]" )
{
    const auto continental = cycle_for( { -10, -8, -1, 8, 15, 22, 25, 23, 16, 8, 0, -8 } );
    CHECK( continental.air[15] == WINTER );
    CHECK( continental.air[136] == SPRING );
    CHECK( continental.air[200] == SUMMER );
    CHECK( continental.air[264] == AUTUMN );
    CHECK( std::count( continental.air.begin(), continental.air.end(), WINTER ) > 91 );
    CHECK( std::count( continental.air.begin(), continental.air.end(), SUMMER ) < 91 );
    CHECK( std::count( continental.foliage.begin(), continental.foliage.end(), SPRING ) > 0 );
    CHECK( std::count( continental.foliage.begin(), continental.foliage.end(), AUTUMN ) > 0 );
    CHECK( continental.foliage[264] == SUMMER );
    CHECK( continental.foliage[345] == WINTER );

    const auto cool_coast = cycle_for( { 1, 2, 4, 7, 11, 14, 17, 17, 14, 10, 6, 2 } );
    CHECK( std::count( cool_coast.air.begin(), cool_coast.air.end(), SUMMER ) == 0 );
    CHECK( std::count( cool_coast.foliage.begin(), cool_coast.foliage.end(), SUMMER ) > 0 );

    const auto tropical = cycle_for( { 24, 24, 25, 26, 27, 28, 28, 28, 27, 26, 25, 24 } );
    CHECK( std::all_of( tropical.air.begin(), tropical.air.end(),
    []( season_type value ) {
        return value == SUMMER;
    } ) );
    CHECK( tropical.foliage == tropical.air );
}
