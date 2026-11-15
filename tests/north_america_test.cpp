#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "item_group.h"
#include "north_america.h"
#include "options.h"
#include "options_helpers.h"

TEST_CASE( "north_america_jurisdictions_follow_borders", "[north_america][worldgen]" )
{
    CHECK( north_america::jurisdiction_at( point_abs_ms::zero ) == "US-MA" );
    CHECK( north_america::jurisdiction_at( point_abs_ms( -2366147, 738224 ) ) == "US-TX" );
    CHECK( north_america::jurisdiction_at( point_abs_ms( -649984, -162480 ) ) == "CA-ON" );
    CHECK( north_america::jurisdiction_at( point_abs_ms( -2966130, 2139454 ) ) == "MX-CMX" );
    CHECK( north_america::jurisdiction_at( point_abs_ms( -3487129, -1904703 ) ) == "US-WA" );
    CHECK( north_america::jurisdiction_at( point_abs_ms( -3485687, -1906585 ) ) == "CA-BC" );
    CHECK( north_america::jurisdiction_at( point_abs_ms( 105754, -803 ) ).empty() );
}

TEST_CASE( "north_america_regional_loot_scope_uses_spawn_location",
           "[north_america][item_group]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    const item_group_id magazines( "mags_common" );
    const item_group_id texas_magazines( "mags_common-US-TX" );
    const item_group_id police_footwear( "cop_shoes" );
    const point_abs_ms dallas( -2366147, 738224 );
    const point_abs_ms toronto( -649984, -162480 );
    const mtype_id swat( "mon_zombie_swat" );
    const mtype_id ert( "mon_zombie_swat_ca" );
    REQUIRE( item_group::group_is_defined( texas_magazines ) );

    g->north_america_world = false;
    {
        const north_america::scoped_regional_loot classic( dallas );
        CHECK( north_america::regional_item_group( magazines ) == magazines );
        CHECK( north_america::regional_monster( swat, toronto ) == swat );
    }

    g->north_america_world = true;
    {
        const north_america::scoped_regional_loot texas( dallas );
        CHECK( north_america::regional_item_group( magazines ) == texas_magazines );
        CHECK( item_group::item_from( police_footwear ).typeId() == itype_id( "boots_western" ) );
        {
            const north_america::scoped_regional_loot massachusetts( point_abs_ms::zero );
            CHECK( north_america::regional_item_group( magazines ) == magazines );
        }
        CHECK( north_america::regional_item_group( magazines ) == texas_magazines );
    }
    CHECK( north_america::regional_item_group( magazines ) == magazines );
    CHECK( north_america::regional_monster( swat, toronto ) == ert );
    CHECK( north_america::regional_monster( swat, dallas ) == swat );
}

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
