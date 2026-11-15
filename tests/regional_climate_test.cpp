#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "regional_climate.h"
#include "weather.h"
#include "weather_gen.h"

TEST_CASE( "regional_climate_uses_station_normals_and_interpolates_neighbours",
           "[regional_climate]" )
{
    using namespace regional_climate;
    const auto bedford = station_location( "bedford_hanscom" );
    const auto boston = station_location( "boston_logan" );
    REQUIRE( bedford );
    REQUIRE( boston );
    const auto west = at( *bedford );
    const auto coast = at( *boston );
    const auto between = at( { ( bedford->latitude + boston->latitude ) / 2,
                               ( bedford->longitude + boston->longitude ) / 2 } );
    REQUIRE( west );
    REQUIRE( coast );
    REQUIRE( between );
    CHECK( west->annual_precipitation_mm() == Approx( 1082.05 ).margin( 0.05 ) );
    CHECK( west->months[0].low_c == Approx( -7.67 ) );
    CHECK( west->months[0].dominant_system() == rain_system::frontal );
    CHECK( between->months[0].low_c > west->months[0].low_c );
    CHECK( between->months[0].low_c < coast->months[0].low_c );
    CHECK( offset_metres( *bedford, 1000, 0 ).longitude > bedford->longitude );
    CHECK( offset_metres( *bedford, 0, 1000 ).latitude > bedford->latitude );
    CHECK_FALSE( at( { 91, -71 } ) );

    const auto tucson = at( { 32.1313, -110.9552 } );
    REQUIRE( tucson );
    CHECK( tucson->months[7].dominant_system() == rain_system::monsoon );
    CHECK( tucson->months[7].precipitation_mm > tucson->months[4].precipitation_mm );
}

TEST_CASE( "regional_climate_event_rate_accounts_for_monthly_water", "[regional_climate]" )
{
    using namespace regional_climate;
    monthly_normal normal;
    normal.precipitation_mm = 100;
    normal.wet_days = 10;
    for( const rain_system system : {
             rain_system::frontal, rain_system::monsoon
         } ) {
        normal.system_weights.fill( 0 );
        normal.system_weights[static_cast<unsigned>( system )] = 1;
        double total = 0;
        int wet_hours = 0;
        for( int day = 0; day < 3000; ++day ) {
            for( int hour = 0; hour < 24; ++hour ) {
                const double rate = precipitation_rate( normal, 30, hour + 0.5, day, 3845 );
                if( rate > 0 ) {
                    total += rate;
                    ++wet_hours;
                    if( system == rain_system::monsoon && hour < 13 ) {
                        FAIL( "monsoon shower starts before the afternoon" );
                    }
                }
            }
        }
        CHECK( total / 100 == Approx( 100 ).margin( 10 ) );
        CHECK( wet_hours == Approx( system == rain_system::frontal ? 12000 : 4000 ).epsilon( 0.1 ) );
    }
}

TEST_CASE( "weather_generator_anchors_the_start_to_bedford", "[regional_climate]" )
{
    weather_generator generator;
    const restore_on_out_of_scope restore_origin( get_weather().climate_origin );
    get_weather().climate_origin = point_abs_ms( 20000, -90000 );
    const tripoint_abs_ms start( 20000, -90000, 0 );
    CHECK_FALSE( generator.climate_at( start ) );
    generator.climate_station = "bedford_hanscom";
    const auto local = generator.climate_at( start );
    const auto south = generator.climate_at( start + tripoint( 0, 1200000, 0 ) );
    REQUIRE( local );
    REQUIRE( south );
    CHECK( local->annual_precipitation_mm() == Approx( 1082.05 ).margin( 0.05 ) );
    CHECK( south->months[0].high_c > local->months[0].high_c );
}
