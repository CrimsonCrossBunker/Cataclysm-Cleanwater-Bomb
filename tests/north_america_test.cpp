#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "north_america.h"
#include "options.h"
#include "options_helpers.h"

TEST_CASE( "north_america_is_a_new_world_map_option", "[north_america][option]" )
{
    const auto defaults = get_options().get_world_defaults();
    CHECK( defaults.at( "WORLD_MAP_GENERATION" ).getDefaultValue() == "north_america" );

    override_option map_mode( "WORLD_MAP_GENERATION", "classic_random" );
    CHECK( get_option<std::string>( "WORLD_MAP_GENERATION" ) == "classic_random" );
    CHECK_FALSE( north_america::available() );
    CHECK_FALSE( north_america::offer_starting_city() );

    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = true;
    CHECK( north_america::active() );
}

TEST_CASE( "north_america_atlas_contains_real_water_and_land", "[north_america]" )
{
    using north_america::terrain;
    const auto tile_at = []( point_abs_ms p ) {
        return north_america::raster( project_to<coords::omt>( p ), 1, 1 ).front();
    };

    CHECK( tile_at( point_abs_ms::zero ) == terrain::land );
    CHECK( tile_at( point_abs_ms( 105754, -803 ) ) == terrain::ocean );
    CHECK( tile_at( point_abs_ms( -1270243, -177663 ) ) == terrain::lake );
    CHECK( tile_at( point_abs_ms( -1812420, 1207665 ) ) == terrain::river );
    CHECK( tile_at( point_abs_ms( -2966130, 2139454 ) ) == terrain::land );

    // The same tiles in overlapping requests agree even when they are at a chunk edge.
    const point_abs_omt coast( 1133, 67 );
    const auto full = north_america::raster( coast, 64, 2 );
    const auto left = north_america::raster( coast, 32, 2 );
    const auto right = north_america::raster( coast + point( 32, 0 ), 32, 2 );
    for( int y = 0; y < 2; ++y ) {
        for( int x = 0; x < 32; ++x ) {
            CHECK( full[y * 64 + x] == left[y * 32 + x] );
            CHECK( full[y * 64 + x + 32] == right[y * 32 + x] );
        }
    }
}

TEST_CASE( "north_american_latitude_changes_seasonal_daylight", "[north_america][calendar]" )
{
    const auto bedford = north_america::location( point_abs_ms::zero );
    const auto mexico = north_america::location( point_abs_ms( -2966130, 2139454 ) );
    CHECK( bedford.latitude == Approx( 42.47 ) );
    CHECK( bedford.longitude == Approx( -71.2894 ) );
    CHECK( mexico.latitude == Approx( 19.43 ).margin( 0.001 ) );
    CHECK( mexico.longitude == Approx( -99.13 ).margin( 0.001 ) );

    const auto daylight = []( time_point day, const regional_climate::coordinates & place ) {
        calendar::set_location( place.latitude, place.longitude );
        return sunset( day ) - sunrise( day );
    };
    const time_point summer = calendar::turn_zero + calendar::season_length() * 1.5;
    const time_point winter = calendar::turn_zero + calendar::season_length() * 3.5;
    CHECK( daylight( summer, bedford ) > daylight( summer, mexico ) );
    CHECK( daylight( winter, bedford ) < daylight( winter, mexico ) );
    calendar::set_location( 42.47f, -71.2894f );
}