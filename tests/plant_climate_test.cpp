#include "cata_catch.h"

#include "calendar.h"
#include "plant_climate.h"
#include "weather.h"

TEST_CASE( "crop_heat_units_account_for_cold_and_heat_stress", "[farming][weather]" )
{
    const crop_climate_profile tomato{ 10, 26, 0, 38, 690, 510, 88, 0.68 };
    const crop_climate_profile pea{ 4.4, 19, -4, 29, 480, 320, 63, 0.7 };

    CHECK( tomato.heat_units( 14, 24 ) == Approx( 9 ) );
    CHECK( tomato.heat_units( 7, 11 ) == 0 );
    CHECK( pea.heat_units( 7, 11 ) > 0 );
    CHECK( tomato.heat_units( -2, 26 ) == 0 );
    CHECK( tomato.heat_units( 18, 33 ) < tomato.heat_units( 18, 26 ) );
    CHECK( tomato.heat_units( 18, 39 ) == 0 );
}

TEST_CASE( "closed_windows_and_walls_retain_heat_longer", "[weather]" )
{
    const double masonry = indoor_heat_retention( 0.28, 0, 5 );
    const double closed_window = indoor_heat_retention( 0.53, 0, 5 );
    const double open_window = indoor_heat_retention( 0.21, 1, 5 );

    CHECK( masonry > closed_window );
    CHECK( closed_window > open_window );
    CHECK( indoor_heat_retention( 0.21, 1, 20 ) < open_window );
    CHECK( indoor_heat_retention( 0.28, 0, 20 ) == Approx( masonry ) );
}
