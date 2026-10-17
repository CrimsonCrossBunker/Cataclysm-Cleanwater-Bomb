#if defined(TILES)
#include <algorithm>
#include <future>
#include <memory>
#include <string>
#include <type_traits>
#include <utility>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_tiles.h"
#include "mapdata.h"
#include "tile_lookup.h"
#include "type_id.h"

static_assert( std::is_same_v<decltype( std::declval<const tile_lookup_res &>().tile() ),
               const tile_type &>, "Resolved metadata must remain read-only" );

static void add_tile( tileset &bundle, const std::string &id, int height )
{
    tile_type tile;
    tile.height_3d = height;
    bundle.create_tile_type( id, std::move( tile ) );
}

TEST_CASE( "tile_lookup_frame_keeps_results_and_misses_with_the_frame", "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    add_tile( *bundle, "test_tile", 7 );
    {
        tile_lookup_frame frame( bundle, SPRING );
        const auto first = frame.find( "test_tile", TILE_CATEGORY::NONE, "" );
        REQUIRE( first );
        CHECK( first->tile().height_3d == 7 );
        CHECK( frame.find( "test_tile", TILE_CATEGORY::NONE, "" )->id() == first->id() );
        CHECK_FALSE( frame.find( "missing_tile", TILE_CATEGORY::NONE, "" ) );
        CHECK_FALSE( frame.find( "missing_tile", TILE_CATEGORY::NONE, "" ) );
        CHECK( frame.cache_hits() == 2 );
        CHECK( frame.cached_ids() == 2 );
    }
    // Publication between frames must not inherit a cached missing sprite.
    add_tile( *bundle, "missing_tile", 11 );
    tile_lookup_frame next( bundle, SPRING );
    REQUIRE( next.find( "missing_tile", TILE_CATEGORY::NONE, "" ) );
    CHECK( next.find( "missing_tile", TILE_CATEGORY::NONE, "" )->tile().height_3d == 11 );
}

TEST_CASE( "tile_lookup_frame_pins_borrowed_metadata_lifetime", "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    add_tile( *bundle, "long_lived_tile", 19 );
    std::weak_ptr<const tileset> weak = bundle;
    {
        tile_lookup_frame frame( bundle, SPRING );
        const auto result = frame.find( "long_lived_tile", TILE_CATEGORY::NONE, "" );
        REQUIRE( result );
        bundle.reset();
        CHECK_FALSE( weak.expired() );
        CHECK( result->id() == "long_lived_tile" );
        CHECK( result->tile().height_3d == 19 );
        CHECK( frame.find( "long_lived_tile", TILE_CATEGORY::NONE, "" )->tile().height_3d == 19 );
    }
    CHECK( weak.expired() );
}

TEST_CASE( "tile_lookup_frame_preserves_season_and_variant_precedence", "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    add_tile( *bundle, "seasonal", 1 );
    add_tile( *bundle, "seasonal_season_winter", 2 );
    add_tile( *bundle, "seasonal_var_red", 3 );
    add_tile( *bundle, "seasonal_var_red_season_winter", 4 );
    add_tile( *bundle, "seasonal_blue", 5 );
    add_tile( *bundle, "vp_test", 8 );
    add_tile( *bundle, "vp_test_front_wheel", 9 );
    tile_lookup_frame spring( bundle, SPRING );
    tile_lookup_frame winter( bundle, WINTER );
    CHECK( spring.find( "seasonal", TILE_CATEGORY::NONE, "" )->tile().height_3d == 1 );
    CHECK( winter.find( "seasonal", TILE_CATEGORY::NONE, "" )->tile().height_3d == 2 );
    CHECK( spring.find( "seasonal", TILE_CATEGORY::NONE, "red" )->tile().height_3d == 3 );
    CHECK( winter.find( "seasonal", TILE_CATEGORY::NONE, "red" )->tile().height_3d == 4 );
    CHECK( spring.find( "seasonal", TILE_CATEGORY::NONE, "_blue" )->tile().height_3d == 5 );
    CHECK( spring.find( "seasonal", TILE_CATEGORY::NONE, "absent" )->tile().height_3d == 1 );
    CHECK_FALSE( spring.find( "seasonal", TILE_CATEGORY::NONE, "", 0 ) );

    tile_lookup_frame vehicle( bundle, SPRING );
    CHECK( vehicle.find( "vp_test", TILE_CATEGORY::VEHICLE_PART,
                         "front_wheel_blue" )->tile().height_3d == 9 );
    CHECK( vehicle.find( "vp_test", TILE_CATEGORY::NONE,
                         "front_wheel_blue" )->tile().height_3d == 8 );
}

TEST_CASE( "tile_lookup_frame_keys_native_fallbacks_by_category_and_depth", "[tiles][tile_lookup]" )
{
    const ter_str_id dock( "t_dock" );
    REQUIRE( dock.is_valid() );
    REQUIRE( dock.obj().looks_like == "t_floor" );
    auto bundle = std::make_shared<tileset>();
    add_tile( *bundle, "t_floor", 23 );
    add_tile( *bundle, "corpse", 31 );
    tile_lookup_frame frame( bundle, SPRING );
    CHECK_FALSE( frame.find( "t_dock", TILE_CATEGORY::TERRAIN, "", 1 ) );
    const auto floor = frame.find( "t_dock", TILE_CATEGORY::TERRAIN, "", 2 );
    REQUIRE( floor );
    CHECK( floor->id() == "t_floor" );
    CHECK( floor->tile().height_3d == 23 );
    CHECK_FALSE( frame.find( "t_dock", TILE_CATEGORY::NONE, "", 2 ) );
    CHECK_FALSE( frame.find( "corpse_missing_monster", TILE_CATEGORY::ITEM, "", 1 ) );
    const auto corpse = frame.find( "corpse_missing_monster", TILE_CATEGORY::ITEM, "", 2 );
    REQUIRE( corpse );
    CHECK( corpse->id() == "corpse" );
    CHECK_FALSE( frame.find( "corpse_missing_monster", TILE_CATEGORY::NONE, "", 2 ) );
    CHECK( frame.find( "t_dock", TILE_CATEGORY::TERRAIN, "", 2 )->id() == "t_floor" );
    CHECK_FALSE( frame.find( "t_dock", TILE_CATEGORY::TERRAIN, "", 1 ) );

    // Queries outside a terrain draw use the same rules without retained data.
    tile_lookup_frame direct( bundle, SPRING, false );
    for( int i = 0; i < 2; ++i ) {
        const auto result = direct.find( "t_dock", TILE_CATEGORY::TERRAIN, "", 2 );
        REQUIRE( result );
        CHECK( result->id() == "t_floor" );
        CHECK_FALSE( direct.find( "t_dock", TILE_CATEGORY::TERRAIN, "", 1 ) );
    }
    CHECK( direct.cache_hits() == 0 );
    CHECK( direct.cached_ids() == 0 );
}

TEST_CASE( "independent_tile_lookup_frames_can_resolve_pinned_metadata", "[tiles][tile_lookup]" )
{
    auto first = std::make_shared<tileset>();
    auto second = std::make_shared<tileset>();
    add_tile( *first, "shared_id", 37 );
    add_tile( *second, "shared_id", 41 );
    const auto run = []( std::shared_ptr<const tileset> bundle ) {
        tile_lookup_frame frame( std::move( bundle ), SPRING );
        int observed = 0;
        for( int i = 0; i < 1000; ++i ) {
            const auto result = frame.find( "shared_id", TILE_CATEGORY::NONE, "" );
            if( !result ) {
                return std::make_pair( -1, frame.cache_hits() );
            }
            observed = result->tile().height_3d;
        }
        return std::make_pair( observed, frame.cache_hits() );
    };
    auto a = std::async( std::launch::async, run, first );
    auto b = std::async( std::launch::async, run, second );
    const auto left = a.get();
    const auto right = b.get();
    CHECK( left.first == 37 );
    CHECK( right.first == 41 );
    CHECK( left.second == 999 );
    CHECK( right.second == 999 );
}

static tile_type connected_tile( int height )
{
    tile_type tile;
    tile.height_3d = height;
    tile.multitile = true;
    tile.available_subtiles.assign( tile_lookup_frame::subtile_keys.begin(),
                                    tile_lookup_frame::subtile_keys.end() );
    return tile;
}

// Canonical recursive selection, independent of the new cache and fast path.
static tile_lookup_frame::subtile_result legacy_subtile( tile_lookup_frame &frame,
        const tile_lookup_res &base, TILE_CATEGORY category, int subtile )
{
    tile_lookup_frame::subtile_result result;
    const auto &keys = tile_lookup_frame::subtile_keys;
    const auto &available = base.tile().available_subtiles;
    result.available = base.tile().multitile &&
                       std::find( available.begin(), available.end(), keys[subtile] ) != available.end();
    if( result.available ) {
        result.resolved = frame.find( base.id() + "_" + keys[subtile], category, "" );
    }
    return result;
}

TEST_CASE( "subtile_resolution_matches_recursive_season_and_variant_selection",
           "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    const std::vector<std::string> ids{ "connected", "connected_season_winter",
                                        "connected_var_red", "connected_var_red_season_winter" };
    int height = 0;
    for( const std::string &id : ids ) {
        bundle->create_tile_type( id, connected_tile( ++height ) );
        for( size_t i = 0; i < tile_lookup_frame::subtile_keys.size(); ++i ) {
            // Include declared children with missing sprites and unsupported keys.
            if( i % 3 != 0 ) {
                add_tile( *bundle, id + "_" + tile_lookup_frame::subtile_keys[i], ++height );
            }
        }
    }
    for( season_type season : {
             SPRING, SUMMER, AUTUMN, WINTER
         } ) {
        tile_lookup_frame cached( bundle, season );
        tile_lookup_frame reference( bundle, season, false );
        for( const std::string &variant : {
                 std::string(), std::string( "red" )
             } ) {
            const auto base = cached.find( "connected", TILE_CATEGORY::NONE, variant );
            const auto original = reference.find( "connected", TILE_CATEGORY::NONE, variant );
            REQUIRE( base );
            REQUIRE( original );
            for( int subtile = 0; subtile < 8; ++subtile ) {
                const auto expected = legacy_subtile( reference, *original, TILE_CATEGORY::NONE, subtile );
                for( int repeat = 0; repeat < 3; ++repeat ) {
                    const auto actual = cached.find_subtile( *base, TILE_CATEGORY::NONE, subtile );
                    CHECK( actual.available == expected.available );
                    REQUIRE( actual.resolved.has_value() == expected.resolved.has_value() );
                    if( expected.resolved ) {
                        CHECK( actual.resolved->id() == expected.resolved->id() );
                        CHECK( &actual.resolved->tile() == &expected.resolved->tile() );
                    }
                }
            }
        }
        CHECK( cached.subtile_requests() == 48 );
        CHECK( cached.subtile_cache_hits() == 32 );
    }
}

TEST_CASE( "subtile_fallback_keeps_category_and_frame_identity", "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    bundle->create_tile_type( "corpse_missing_monster", connected_tile( 3 ) );
    add_tile( *bundle, "corpse", 11 );
    {
        tile_lookup_frame frame( bundle, SPRING );
        const auto base = frame.find( "corpse_missing_monster", TILE_CATEGORY::NONE, "" );
        REQUIRE( base );
        const auto none = frame.find_subtile( *base, TILE_CATEGORY::NONE, 0 );
        REQUIRE( none.available );
        CHECK_FALSE( none.resolved );
        const auto item = frame.find_subtile( *base, TILE_CATEGORY::ITEM, 0 );
        REQUIRE( item.resolved );
        CHECK( item.resolved->id() == "corpse" );
        CHECK_FALSE( frame.find_subtile( *base, TILE_CATEGORY::NONE, 0 ).resolved );
    }
    add_tile( *bundle, "corpse_missing_monster_center", 29 );
    tile_lookup_frame next( bundle, SPRING );
    const auto base = next.find( "corpse_missing_monster", TILE_CATEGORY::NONE, "" );
    REQUIRE( base );
    const auto result = next.find_subtile( *base, TILE_CATEGORY::NONE, 0 );
    REQUIRE( result.resolved );
    CHECK( result.resolved->tile().height_3d == 29 );
}

TEST_CASE( "subtile_results_survive_cache_growth_and_pin_metadata", "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    for( int i = 0; i < 512; ++i ) {
        const std::string id = "connected_" + std::to_string( i );
        bundle->create_tile_type( id, connected_tile( i ) );
        add_tile( *bundle, id + "_center", 1000 + i );
    }
    std::weak_ptr<const tileset> weak = bundle;
    {
        tile_lookup_frame frame( bundle, SPRING );
        bundle.reset();
        const auto first = frame.find( "connected_0", TILE_CATEGORY::NONE, "" );
        REQUIRE( first );
        const auto child = frame.find_subtile( *first, TILE_CATEGORY::NONE, 0 );
        REQUIRE( child.resolved );
        for( int i = 1; i < 512; ++i ) {
            const auto base = frame.find( "connected_" + std::to_string( i ), TILE_CATEGORY::NONE, "" );
            REQUIRE( base );
            REQUIRE( frame.find_subtile( *base, TILE_CATEGORY::NONE, 0 ).resolved );
        }
        CHECK_FALSE( weak.expired() );
        CHECK( child.resolved->tile().height_3d == 1000 );
        CHECK( frame.find_subtile( *first, TILE_CATEGORY::NONE,
                                   0 ).resolved->id() == child.resolved->id() );
        CHECK_FALSE( frame.find_subtile( *first, TILE_CATEGORY::NONE, -1 ).available );
        CHECK_FALSE( frame.find_subtile( *first, TILE_CATEGORY::NONE, 8 ).available );
    }
    CHECK( weak.expired() );
}

TEST_CASE( "subtile_availability_and_independent_frames_preserve_owner_boundaries",
           "[tiles][tile_lookup]" )
{
    auto bundle = std::make_shared<tileset>();
    tile_type base = connected_tile( 1 );
    base.available_subtiles = { "center" };
    bundle->create_tile_type( "connected", std::move( base ) );
    add_tile( *bundle, "connected_center", 13 );
    add_tile( *bundle, "connected_edge", 19 );
    const auto run = []( std::shared_ptr<const tileset> values ) {
        tile_lookup_frame frame( std::move( values ), SPRING );
        const auto parent = frame.find( "connected", TILE_CATEGORY::NONE, "" );
        if( !parent ) {
            return false;
        }
        for( int i = 0; i < 1000; ++i ) {
            const auto center = frame.find_subtile( *parent, TILE_CATEGORY::NONE, 0 );
            const auto edge = frame.find_subtile( *parent, TILE_CATEGORY::NONE, 2 );
            if( !center.resolved || center.resolved->tile().height_3d != 13 || edge.available ) {
                return false;
            }
        }
        return frame.subtile_cache_hits() == 1998;
    };
    auto first = std::async( std::launch::async, run, bundle );
    auto second = std::async( std::launch::async, run, bundle );
    CHECK( first.get() );
    CHECK( second.get() );
}
#endif // TILES
