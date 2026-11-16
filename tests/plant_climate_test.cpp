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


TEST_CASE( "regional_field_calendar_tracks_pre_cataclysm_sowing", "[farming][weather]" )
{
    const field_crop spring{ itype_id( "seed_potato_raw" ), 116, 294 };
    const field_crop winter{ itype_id( "seed_red_winter_wheat" ), 275, 200 };
    const time_duration year = calendar::year_length();
    const time_point new_year = calendar::turn_zero - calendar::turn_zero_offset();
    const time_point may = new_year + year * ( 139.0 / 365 );
    const time_point march = new_year + year * ( 80.0 / 365 );
    CHECK_FALSE( spring.sowing_date( march ) );
    REQUIRE( spring.sowing_date( may ) );
    CHECK( *spring.sowing_date( may ) < may );
    REQUIRE( winter.sowing_date( may ) );
    CHECK( *winter.sowing_date( may ) < new_year );
    CHECK_FALSE( spring.sowing_date( new_year + year * ( 310.0 / 365 ) ) );
}

TEST_CASE( "regional_farms_select_distinct_local_mix", "[farming][north_america]" )
{
    const auto iowa = regional_field_crop( "US-IA", 0 );
    const auto maine = regional_field_crop( "US-ME", 0 );
    const auto sinaloa = regional_field_crop( "MX-SIN", 0 );
    REQUIRE( iowa );
    REQUIRE( maine );
    REQUIRE( sinaloa );
    CHECK( iowa->seed == itype_id( "seed_corn" ) );
    CHECK( maine->seed == itype_id( "seed_potato_raw" ) );
    CHECK( sinaloa->planting_day > sinaloa->harvest_day );
}
