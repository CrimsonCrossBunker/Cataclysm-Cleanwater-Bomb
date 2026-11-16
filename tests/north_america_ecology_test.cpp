#include "cata_catch.h"

#include <algorithm>
#include "coordinates.h"
#include "north_america.h"
#include "north_america_ecology.h"
#include "north_america_transport.h"
#include "overmap.h"

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
    CHECK( north_america::rural_city_multiplier( project_to<coords::om>( winnipeg + point( 600,
            0 ) ) ) > north_america::rural_city_multiplier( project_to<coords::om>( nunavut ) ) );
}

TEST_CASE( "north_america_uses_footprints_and_limits_remote_town_sizes", "[north_america]" )
{
    const point_abs_om winnipeg = project_to<coords::om>( point_abs_omt( -75949, -46747 ) );
    const auto &districts = north_america::urban_districts_in( winnipeg );
    REQUIRE( !districts.empty() );
    CHECK( north_america::in_urban_footprint( districts.front().center ) );
    CHECK( north_america::rural_town_size( districts.front().center ) == 0 );

    const auto &places = north_america::cities();
    const auto churchill = std::find_if( places.begin(),
    places.end(), []( const north_america::place & p ) {
        return p.name == "Churchill";
    } );
    REQUIRE( churchill != places.end() );
    const int city_size = north_america::named_city_size( churchill->population );
    for( int east = -720; east <= 720; east += 120 ) {
        for( int north = -720; north <= 720; north += 120 ) {
            CHECK( north_america::rural_town_size( churchill->position + point( east, north ) ) < city_size );
        }
    }
}

TEST_CASE( "north_america_arterial_links_survive_separate_tile_queries", "[north_america]" )
{
    const auto winnipeg = project_to<coords::om>( point_abs_omt( -75949, -46747 ) );
    const auto &districts = north_america::urban_districts_in( winnipeg );
    REQUIRE( !districts.empty() );
    const auto center = districts.front().center;
    const auto junction = north_america::road_network( center, 1, 1 ).front();
    const auto neighbour = north_america::road_network( center + point::north, 1, 1 ).front();
    CHECK( junction.urban_arterial );
    CHECK( junction.lanes >= 4 );
    CHECK( om_lines::has_segment( junction.connections, om_direction::type::north ) );
    CHECK( om_lines::has_segment( neighbour.connections, om_direction::type::south ) );
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