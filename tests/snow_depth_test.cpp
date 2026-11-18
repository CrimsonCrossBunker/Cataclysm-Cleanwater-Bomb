#include <string>
#include <unordered_map>

#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "weather.h"

static const weather_type_id weather_sunny( "sunny" );
TEST_CASE( "snowpack_accumulates_settles_and_loses_water", "[snow][weather]" )
{
    omt_snow_state pack;
    advance_snowpack( pack, 2, -8, 100, 0, 12 );
    REQUIRE( pack.water_mm == Approx( 24 ) );
    REQUIRE( pack.depth_mm > 250 );

    SECTION( "dry windy air removes snow water even below freezing" ) {
        omt_snow_state calm = pack;
        advance_snowpack( calm, 0, -8, 100, 0, 12 );
        advance_snowpack( pack, 0, -8, 35, 20, 12 );
        CHECK( calm.water_mm == Approx( 24 ) );
        CHECK( pack.water_mm < calm.water_mm );
        CHECK( pack.depth_mm < calm.depth_mm );
    }
    SECTION( "thaw and rainfall melt an existing pack" ) {
        omt_snow_state dry = pack;
        advance_snowpack( dry, 0, 4, 100, 0, 6 );
        advance_snowpack( pack, 12, 4, 100, 0, 6 );
        CHECK( pack.water_mm < dry.water_mm );
        advance_snowpack( pack, 10, 10, 80, 7, 24 );
        CHECK( pack.water_mm == 0 );
        CHECK( pack.depth_mm == 0 );
    }
    SECTION( "pack compacts and stops growing at its maximum depth" ) {
        advance_snowpack( pack, 15, -12, 100, 0, 20 );
        REQUIRE( pack.depth_mm == 800 );
        advance_snowpack( pack, 0, -12, 100, 0, 24 );
        CHECK( pack.depth_mm < 800 );
    }
}

TEST_CASE( "old_snowpack_reconstructs_water_equivalent", "[snow][weather]" )
{
    omt_snow_state legacy{ 360, calendar::turn };
    advance_snowpack( legacy, 0, -5, 100, 0, 1 );
    CHECK( legacy.water_mm == Approx( 30 ) );
    CHECK( legacy.depth_mm < 360 );
}

TEST_CASE( "snow_is_queried_per_ground_weather_cell", "[snow][weather]" )
{
    weather_manager &weather = get_weather();
    weather.snow_depth_map.clear();
    weather.weather_id = weather_sunny;
    const tripoint_abs_omt near_cell( -1, 0, 0 );
    const tripoint_abs_omt same_cell( -2, 0, 0 );
    const tripoint_abs_omt other_cell( 0, 0, 0 );
    REQUIRE( snow_climate_cell( near_cell ) == snow_climate_cell( same_cell ) );
    REQUIRE( snow_climate_cell( near_cell ) != snow_climate_cell( other_cell ) );
    weather.snow_depth_map[snow_climate_cell( near_cell )] = { 550, calendar::turn };
    weather.snow_depth_map[snow_climate_cell( other_cell )] = { 50, calendar::turn };
    CHECK( weather.get_snow_depth_mm( same_cell ) == 550 );
    CHECK( weather.get_snow_depth_mm( other_cell ) == 50 );
    CHECK( weather.get_snow_depth_mm( near_cell + tripoint::below ) == 0 );
    weather.snow_depth_map.clear();
}

TEST_CASE( "snow_movement_penalty", "[snow][movement]" )
{
    clear_map();
    clear_character( get_player_character() );
    weather_manager &weather = get_weather();
    weather.snow_depth_map.clear();
    weather.weather_id = weather_sunny;

    Character &player = get_player_character();
    map &here = get_map();
    const tripoint_abs_omt cell = snow_climate_cell( player.pos_abs_omt() );
    const tripoint_bub_ms pos = player.pos_bub();
    here.ter_set( pos, ter_id( "t_grass" ) );
    here.ter_set( pos + tripoint::above, ter_id( "t_open_air" ) );
    here.build_map_cache( pos.z() );
    here.build_map_cache( pos.z() + 1 );

    weather.snow_depth_map[cell] = { 0, calendar::turn };
    const int clear_cost = player.run_cost( 100 );

    weather.snow_depth_map[cell] = { 249, calendar::turn };
    CHECK( player.run_cost( 100 ) == clear_cost );
    weather.snow_depth_map[cell] = { 250, calendar::turn };
    const int medium_cost = player.run_cost( 100 );
    CHECK( medium_cost > clear_cost );
    weather.snow_depth_map[cell] = { 500, calendar::turn };
    CHECK( player.run_cost( 100 ) > medium_cost );

    here.ter_set( pos + tripoint::above, ter_id( "t_floor" ) );
    here.build_map_cache( pos.z() );
    here.build_map_cache( pos.z() + 1 );
    CHECK( player.run_cost( 100 ) == clear_cost );
    CHECK( weather.get_surface_snow_cover( here, pos ) == snow_cover::none );
    CHECK( weather.get_surface_snow_cover( here, pos + tripoint::above ) == snow_cover::deep );
    weather.snow_depth_map.clear();
}
