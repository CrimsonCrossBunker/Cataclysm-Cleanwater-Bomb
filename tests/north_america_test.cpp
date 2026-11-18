#include <algorithm>
#include <cmath>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "game.h"
#include "item_group.h"
#include "mapdata.h"
#include "north_america.h"
#include "north_america_soil.h"
#include "north_america_transport.h"
#include "options.h"
#include "options_helpers.h"
#include "weather.h"
#include "weather_gen.h"

static const item_group_id item_group_cop_shoes( "cop_shoes" );
static const item_group_id item_group_fresh_produce( "fresh_produce" );
static const item_group_id item_group_fresh_produce_CA_ON( "fresh_produce-CA-ON" );
static const item_group_id item_group_fresh_produce_MX_CMX( "fresh_produce-MX-CMX" );
static const item_group_id item_group_guns_swat( "guns_swat" );
static const item_group_id item_group_guns_swat_CA( "guns_swat-CA" );
static const item_group_id item_group_guns_swat_MX( "guns_swat-MX" );
static const item_group_id item_group_mags_common( "mags_common" );
static const item_group_id item_group_mags_common_US_TX( "mags_common-US-TX" );
static const item_group_id item_group_police_armory_any_pistol( "police_armory_any_pistol" );
static const item_group_id item_group_police_armory_any_pistol_CA( "police_armory_any_pistol-CA" );
static const item_group_id item_group_police_armory_any_pistol_MX( "police_armory_any_pistol-MX" );
static const item_group_id item_group_roadmap_stock( "roadmap_stock" );
static const item_group_id item_group_roadmap_stock_CA_ON( "roadmap_stock-CA-ON" );

static const itype_id itype_boots_western( "boots_western" );

static const mtype_id mon_zombie_swat( "mon_zombie_swat" );
static const mtype_id mon_zombie_swat_ca( "mon_zombie_swat_ca" );

static const ter_str_id ter_t_atlas_soil_heavy_clay( "t_atlas_soil_heavy_clay" );
static const ter_str_id ter_t_atlas_soil_loam( "t_atlas_soil_loam" );
static const ter_str_id ter_t_atlas_soil_prairie( "t_atlas_soil_prairie" );
static const ter_str_id ter_t_atlas_soil_prairie_dead_grass( "t_atlas_soil_prairie_dead_grass" );
static const ter_str_id ter_t_atlas_soil_prairie_grass( "t_atlas_soil_prairie_grass" );
static const ter_str_id ter_t_atlas_soil_prairie_long_grass( "t_atlas_soil_prairie_long_grass" );
static const ter_str_id ter_t_atlas_soil_prairie_tilled( "t_atlas_soil_prairie_tilled" );
static const ter_str_id ter_t_atlas_soil_sandy_loam( "t_atlas_soil_sandy_loam" );
static const ter_str_id ter_t_dirt( "t_dirt" );
static const ter_str_id ter_t_dirtmound( "t_dirtmound" );
static const ter_str_id ter_t_grass_dead( "t_grass_dead" );
static const ter_str_id ter_t_grass_long( "t_grass_long" );

static void check_regional_item_group( const item_group_id &base, const item_group_id &expected )
{
    const item_group_id *const regional = north_america::regional_item_group( base );
    REQUIRE( regional != nullptr );
    CHECK( *regional == expected );
}

TEST_CASE( "north_america_sets_local_civic_flags_and_supplies", "[north_america][worldgen]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    const point_abs_ms toronto( -649984, -162480 );
    const point_abs_ms mexico_city( -2966130, 2139454 );

    g->north_america_world = true;
    {
        const north_america::scoped_regional_loot canada( toronto );
        CHECK( north_america::civic_flag_variant() == "canadian_flag" );
        check_regional_item_group( item_group_fresh_produce, item_group_fresh_produce_CA_ON );
        check_regional_item_group( item_group_police_armory_any_pistol,
                                   item_group_police_armory_any_pistol_CA );
        check_regional_item_group( item_group_guns_swat, item_group_guns_swat_CA );
        check_regional_item_group( item_group_roadmap_stock, item_group_roadmap_stock_CA_ON );
    }
    {
        const north_america::scoped_regional_loot mexico( mexico_city );
        CHECK( north_america::civic_flag_variant() == "mexican_flag" );
        check_regional_item_group( item_group_fresh_produce, item_group_fresh_produce_MX_CMX );
        check_regional_item_group( item_group_police_armory_any_pistol,
                                   item_group_police_armory_any_pistol_MX );
        check_regional_item_group( item_group_guns_swat, item_group_guns_swat_MX );
    }
    g->north_america_world = false;
    const north_america::scoped_regional_loot classic( toronto );
    CHECK( north_america::civic_flag_variant().empty() );
    CHECK( north_america::regional_item_group( item_group_fresh_produce ) == nullptr );
    CHECK( north_america::regional_item_group( item_group_police_armory_any_pistol ) == nullptr );
    CHECK( north_america::regional_item_group( item_group_roadmap_stock ) == nullptr );
}

TEST_CASE( "prairie_soil_keeps_its_terrain_through_planting", "[north_america][farming]" )
{

    CHECK( north_america::mapped_soil_at( point_abs_ms( -2341315,
                                          -1609560 ) ) == ter_t_atlas_soil_prairie );
    CHECK( north_america::mapped_soil_at( point_abs_ms( -2015172,
                                          -1184597 ) ) == ter_t_atlas_soil_prairie );
    CHECK( north_america::mapped_soil_at( point_abs_ms( -2660946,
                                          -1974662 ) ) == ter_t_atlas_soil_prairie );
    REQUIRE( ter_t_atlas_soil_prairie.is_valid() );
    REQUIRE( ter_t_atlas_soil_prairie_tilled.is_valid() );
    CHECK( ter_t_atlas_soil_prairie->has_flag( ter_furn_flag::TFLAG_DIGGABLE ) );
    CHECK( ter_t_atlas_soil_prairie->has_flag( ter_furn_flag::TFLAG_PLOWABLE ) );
    CHECK( ter_t_atlas_soil_prairie_tilled->has_flag( ter_furn_flag::TFLAG_PLANTABLE ) );
    CHECK( north_america::canonical_soil( ter_t_atlas_soil_prairie.id() ) == ter_t_dirt );
    CHECK( north_america::canonical_soil( ter_t_atlas_soil_prairie_tilled.id() ) == ter_t_dirtmound );
    CHECK( north_america::tilled_soil( ter_t_atlas_soil_prairie.id() ) ==
           ter_t_atlas_soil_prairie_tilled );
    CHECK( north_america::planted_soil( ter_t_atlas_soil_prairie_tilled.id() ) ==
           ter_t_atlas_soil_prairie );
    CHECK( north_america::tilled_soil( ter_t_dirt.id() ) == ter_t_dirtmound );
    CHECK( north_america::planted_soil( ter_t_dirtmound.id() ) == ter_t_dirt );

    REQUIRE( ter_t_atlas_soil_prairie_long_grass.is_valid() );
    CHECK( north_america::canonical_soil( ter_t_atlas_soil_prairie_long_grass.id() ) ==
           ter_t_grass_long );
    CHECK( ter_t_atlas_soil_prairie_long_grass->has_flag( ter_furn_flag::TFLAG_SMALL_HIDE ) );
    CHECK( ter_t_atlas_soil_prairie_long_grass->transforms_into == ter_t_atlas_soil_prairie_grass );
    CHECK( north_america::tilled_soil( ter_t_atlas_soil_prairie_long_grass.id() ) ==
           ter_t_atlas_soil_prairie_tilled );
    CHECK( north_america::preserve_soil( ter_t_atlas_soil_prairie_long_grass.id(),
                                         ter_t_grass_dead.id() ) ==
           ter_t_atlas_soil_prairie_dead_grass );
}

TEST_CASE( "atlas_soils_affect_the_crop_root_zone_after_tilling", "[north_america][farming]" )
{
    const north_america::crop_soil_properties baseline = north_america::crop_soil_at(
                ter_t_atlas_soil_loam.id() );
    const north_america::crop_soil_properties loose = north_america::crop_soil_at(
                north_america::tilled_soil( ter_t_atlas_soil_sandy_loam.id() ) );
    const north_america::crop_soil_properties dense = north_america::crop_soil_at(
                ter_t_atlas_soil_heavy_clay.id() );
    const north_america::crop_soil_properties black_soil = north_america::crop_soil_at(
                ter_t_atlas_soil_prairie.id() );

    CHECK( loose.water_capacity < baseline.water_capacity );
    CHECK( loose.drainage > dense.drainage );
    CHECK( dense.infiltration < baseline.infiltration );
    CHECK( black_soil.water_capacity > baseline.water_capacity );
    CHECK( black_soil.root_growth > dense.root_growth );

    const ter_id planted = north_america::planted_soil( north_america::tilled_soil(
                               ter_t_atlas_soil_prairie.id() ) );
    CHECK( north_america::crop_soil_at( planted ).water_capacity == black_soil.water_capacity );
    CHECK( north_america::crop_soil_at( ter_t_dirt.id() ).root_growth ==
           baseline.root_growth );
}

TEST_CASE( "atlas_housing_resolves_by_jurisdiction", "[north_america][worldgen]" )
{
    const auto check = []( std::string_view code, const char *expected ) {
        const overmap_special_id home = north_america::regional_house_for( code );
        CHECK( home == overmap_special_id( expected ) );
        CHECK( home.is_valid() );
    };

    check( "US-MA", "house_regional_cape_cod" );
    check( "US-WA", "house_regional_craftsman" );
    check( "US-LA", "house_regional_shotgun" );
    check( "US-IL", "house_regional_brick_bungalow" );
    check( "US-TX", "house_regional_ranch" );
    check( "CA-MB", "house_regional_prairie" );
    check( "CA-QC", "house_regional_quebec" );
    check( "MX-CHH", "house_regional_adobe" );
    check( "MX-JAL", "house_regional_mexican_patio" );
    CHECK( north_america::regional_house_for( "" ).is_null() );
}

TEST_CASE( "atlas_roads_agree_across_chunk_edges", "[north_america][worldgen]" )
{
    // Highway 401 west of Toronto, including an observed twelve-lane section.
    const point_abs_omt origin( -28800, -6450 );
    const auto all = north_america::road_network( origin, 64, 64 );
    const auto left = north_america::road_network( origin, 32, 64 );
    const auto right = north_america::road_network( origin + point( 32, 0 ), 32, 64 );
    REQUIRE( std::any_of( all.begin(), all.end(), []( const north_america::road_cell & tile ) {
        return tile.lanes == 12;
    } ) );
    for( int y = 0; y < 64; ++y ) {
        for( int x = 0; x < 32; ++x ) {
            CHECK( left[y * 32 + x].connections == all[y * 64 + x].connections );
            CHECK( right[y * 32 + x].connections == all[y * 64 + x + 32].connections );
        }
    }
}

TEST_CASE( "reusing_climate_normals_preserves_water_freeze_temperature_samples",
           "[north_america][weather]" )
{
    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = true;
    const auto &generator = get_weather().get_cur_weather_gen();
    const tripoint_abs_ms water( -1825851, -1120910, 0 );
    const auto climate = generator.climate_at( water );
    REQUIRE( climate );
    const time_point start = calendar::turn_zero + calendar::year_length() + 8_hours;
    for( int day = 1; day <= 10; ++day ) {
        const time_point sample = start - day * 1_days;
        CHECK( generator.get_weather_temperature( water, sample, 1326, &climate ) ==
               generator.get_weather_temperature( water, sample, 1326 ) );
    }
}

TEST_CASE( "atlas_subsoil_uses_permafrost_and_annual_normals", "[north_america][weather]" )
{
    CHECK( north_america::permafrost_coverage_at( point_abs_ms( -2306833, -4917212 ) ) == 95 );
    CHECK( north_america::permafrost_coverage_at( point_abs_ms( -2272670, -3965536 ) ) == 70 );
    CHECK( north_america::permafrost_coverage_at( point_abs_ms::zero ) == 0 );

    const restore_on_out_of_scope saved_mode( g->north_america_world );
    g->north_america_world = true;
    const weather_generator &generator = get_weather().get_cur_weather_gen();
    const time_point summer = calendar::turn_zero + calendar::season_length() * 1.5;
    const time_point winter = calendar::turn_zero + calendar::season_length() * 3.5;
    const auto temperature = [&]( int z, const time_point & turn ) {
        return units::to_celsius( generator.get_ground_temperature( tripoint_abs_ms( 0, 0, z ),
                                  turn, 0 ) );
    };
    CHECK( std::abs( temperature( -1, summer ) - temperature( -1, winter ) ) > 1.0 );
    CHECK( temperature( -6, summer ) == Approx( temperature( -6, winter ) ) );
}

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
    const point_abs_ms dallas( -2366147, 738224 );
    const point_abs_ms toronto( -649984, -162480 );
    REQUIRE( item_group::group_is_defined( item_group_mags_common_US_TX ) );

    g->north_america_world = false;
    {
        const north_america::scoped_regional_loot classic( dallas );
        CHECK( north_america::regional_item_group( item_group_mags_common ) == nullptr );
        CHECK( north_america::regional_monster( mon_zombie_swat, toronto ) == mon_zombie_swat );
    }

    g->north_america_world = true;
    {
        const north_america::scoped_regional_loot texas( dallas );
        check_regional_item_group( item_group_mags_common, item_group_mags_common_US_TX );
        CHECK( item_group::item_from( item_group_cop_shoes ).typeId() == itype_boots_western );
        {
            const north_america::scoped_regional_loot massachusetts( point_abs_ms::zero );
            CHECK( north_america::regional_item_group( item_group_mags_common ) == nullptr );
        }
        check_regional_item_group( item_group_mags_common, item_group_mags_common_US_TX );
    }
    CHECK( north_america::regional_item_group( item_group_mags_common ) == nullptr );
    CHECK( north_america::regional_monster( mon_zombie_swat, toronto ) == mon_zombie_swat_ca );
    CHECK( north_america::regional_monster( mon_zombie_swat, dallas ) == mon_zombie_swat );
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
