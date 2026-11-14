#include "cata_catch.h"
#include "coordinates.h"
#include "north_america.h"
#include "north_america_ecology.h"

TEST_CASE( "north_america_geographic_vegetation_and_population", "[north_america]" )
{
    const point_abs_omt winnipeg( -75949, -46747 );
    const point_abs_omt tucson( -151555, 13001 );
    const point_abs_omt fairbanks( -122921, -178545 );
    const point_abs_omt nunavut( -25769, -154568 );
    CHECK( north_america::ecoregion_code( winnipeg ) == "9.2" );
    CHECK( north_america::ecoregion_code( tucson ) == "10.2" );
    CHECK( north_america::ecoregion_code( fairbanks ) == "3.1" );
    CHECK( north_america::forest_adjustment( fairbanks ) > north_america::forest_adjustment(
               winnipeg ) );
    CHECK( north_america::rural_city_multiplier( project_to<coords::om>( winnipeg ) ) >
           north_america::rural_city_multiplier( project_to<coords::om>( nunavut ) ) );
}

TEST_CASE( "north_america_coarse_highway_samples_match_full_raster", "[north_america]" )
{
    const point_abs_omt origin( -75970, -46772 );
    const auto coarse = north_america::raster( origin, 7, 7, 9 );
    const auto full = north_america::raster( origin, 55, 55 );
    for( int y = 0; y < 7; ++y ) {
        for( int x = 0; x < 7; ++x ) {
            CHECK( coarse[y * 7 + x] == full[y * 9 * 55 + x * 9] );
        }
    }
    CHECK( north_america::suitable_for_highway_intersection( project_to<coords::om>( origin ) ) );
    CHECK_FALSE( north_america::suitable_for_highway_intersection( point_abs_om( 35, 0 ) ) );
}