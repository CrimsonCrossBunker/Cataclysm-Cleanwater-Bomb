#include <cstring>
#include <future>
#include <memory>
#include <limits>
#include <random>

#include "cata_catch.h"
#include "line.h"
#include "rng.h"
#include "cata_scope_helpers.h"
#include "thread_pool.h"
#include "vision_preparation.h"

namespace
{
using vision_preparation::snapshot;
using vision_preparation::output;
struct views {
    array_of_grids_of<float> out;
    array_of_grids_of<const float> in;
    array_of_grids_of<const bool> floors;
    views( output &o, const snapshot &s ) {
        for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
            out[z] = &o[z];
            in[z] = &s.transparency[z];
            floors[z] = &s.floors[z];
        }
    }
};
std::unique_ptr<snapshot> fixture( unsigned seed )
{
    auto data = std::make_unique<snapshot>();
    std::mt19937 random( seed );
    data->origin = tripoint_bub_ms( MAPSIZE_X / 2, MAPSIZE_Y / 2, 0 );
    for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
        for( int x = 0; x < MAPSIZE_X; ++x ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                const unsigned v = random();
                data->transparency[z][x][y] = v % 11 == 0 ? LIGHT_TRANSPARENCY_SOLID :
                                              v % 7 == 0 ? 0.8f : LIGHT_TRANSPARENCY_OPEN_AIR;
                data->floors[z][x][y] = v % 13 == 0;
            }
        }
    }
    return data;
}
void baseline( output &out, const snapshot &s )
{
    restore_on_out_of_scope restore( trigdist );
    trigdist = s.trig_distance;
    views v( out, s );
    cast_zlight<float, sight_calc, sight_check, accumulate_transparency>(
        v.out, v.in, v.floors, s.origin, s.offset_distance, s.numerator, s.direction );
}
void finish( vision_preparation::frame &frame, output &out,
             const snapshot &s, const vision_preparation::frame::lease &lease )
{
    views v( out, s );
    REQUIRE( frame.prepare() );
    REQUIRE( frame.used_workers() );
    CHECK( frame.horizontal_cost_ms() >= 0.0 );
    REQUIRE( frame.apply( v.out, lease ) );
    vision_preparation::cast_vertical( v.out, v.in, v.floors, s.origin, s.offset_distance,
                                       s.numerator, s.direction, s.trig_distance );
}
void equal( const output &expected, const output &actual )
{
    for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
        INFO( "level=" << z - OVERMAP_DEPTH );
        CHECK( std::memcmp( &expected[z], &actual[z], sizeof( expected[z] ) ) == 0 );
    }
}
} // namespace

TEST_CASE( "vision_preparation_matches_serial_full_volume", "[vision][preparation]" )
{
    const unsigned workers = GENERATE( 1U, 2U, 4U );
    const bool circular = GENERATE( false, true );
    const auto direction = GENERATE( vertical_direction::UP, vertical_direction::DOWN,
                                     vertical_direction::BOTH );
    const auto origin = GENERATE( tripoint_bub_ms( MAPSIZE_X / 2, MAPSIZE_Y / 2, 0 ),
                                  tripoint_bub_ms( 0, MAPSIZE_Y - 1, -OVERMAP_DEPTH ),
                                  tripoint_bub_ms( MAPSIZE_X - 1, 1, OVERMAP_HEIGHT ) );
    auto data = fixture( 20261012 );
    data->origin = origin;
    data->trig_distance = circular;
    data->direction = direction;
    auto expected = std::make_unique<output>();
    // Cumulative camera/origin values must survive even in untouched cells.
    ( *expected )[OVERMAP_DEPTH][0][0] = -0.25f;
    ( *expected )[OVERMAP_DEPTH][1][1] = 0.6f;
    ( *expected )[OVERMAP_DEPTH][0][2] = std::numeric_limits<float>::quiet_NaN();
    ( *expected )[OVERMAP_DEPTH][2][0] = -0.0f;
    ( *expected )[origin.z() + OVERMAP_DEPTH][origin.x()][origin.y()] = 1.0f;
    auto actual = std::make_unique<output>( *expected );
    baseline( *expected, *data );
    vision_preparation::frame frame( workers );
    auto lease = frame.try_acquire( MAX_VIEW_DISTANCE );
    REQUIRE( lease );
    frame.capture() = *data;
    finish( frame, *actual, frame.capture(), lease );
    equal( *expected, *actual );
}

TEST_CASE( "vision_preparation_owns_input_and_distance_policy", "[vision][preparation]" )
{
    auto original = fixture( 193 );
    original->trig_distance = true;
    auto expected = std::make_unique<output>();
    auto actual = std::make_unique<output>();
    baseline( *expected, *original );
    vision_preparation::frame frame( 2 );
    auto lease = frame.try_acquire( MAX_VIEW_DISTANCE );
    REQUIRE( lease );
    frame.capture() = *original;
    original.reset();
    restore_on_out_of_scope restore( trigdist );
    trigdist = false;
    rng_set_engine_seed( 317 );
    const unsigned next = rng_bits();
    rng_set_engine_seed( 317 );
    finish( frame, *actual, frame.capture(), lease );
    CHECK( rng_bits() == next );
    equal( *expected, *actual );
}

TEST_CASE( "vision_preparation_rejects_stale_cancelled_and_nested_requests",
           "[vision][preparation]" )
{
    auto data = fixture( 433 );
    auto actual = std::make_unique<output>();
    vision_preparation::frame frame( 2 );
    for( bool cancel : {
             false, true
         } ) {
        auto lease = frame.try_acquire( MAX_VIEW_DISTANCE );
        REQUIRE( lease );
        CHECK_FALSE( frame.try_acquire( MAX_VIEW_DISTANCE ) );
        frame.capture() = *data;
        REQUIRE( frame.prepare() );
        if( cancel ) {
            frame.cancel();
        } else {
            frame.invalidate();
        }
        views v( *actual, *data );
        CHECK_FALSE( frame.apply( v.out, lease ) );
        auto zero = std::make_unique<output>();
        equal( *zero, *actual );
    }
    // Immediate reuse must not admit writes from a previous request.
    auto expected = std::make_unique<output>();
    baseline( *expected, *data );
    auto lease = frame.try_acquire( MAX_VIEW_DISTANCE );
    REQUIRE( lease );
    frame.capture() = *data;
    finish( frame, *actual, frame.capture(), lease );
    equal( *expected, *actual );
}

TEST_CASE( "vision_preparation_uses_bounded_workers_and_small_serial_fallback",
           "[vision][preparation]" )
{
    vision_preparation::frame disabled( 0 );
    CHECK_FALSE( disabled.try_acquire( MAX_VIEW_DISTANCE ) );
    vision_preparation::frame bounded( 19 );
    CHECK( bounded.worker_count() <= 4 );
    CHECK_FALSE( bounded.try_acquire( 31 ) );
    cata_thread_pool pool( 1 );
    auto result = pool.submit_returning( []() {
        vision_preparation::frame nested( 4 );
        return nested.worker_count() == 0 && !nested.try_acquire( MAX_VIEW_DISTANCE );
    } );
    CHECK( result.get() );
}

TEST_CASE( "vision_admission_keeps_cheap_and_short_casts_serial", "[vision][preparation]" )
{
    // Room pilot: 0.033ms serial vs 1.37ms forced parallel. No snapshot/pool
    // allocation should precede a qualifying measured horizontal workload.
    for( double cost : {
             0.0, 0.033, 1.99
         } ) {
        CHECK_FALSE( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, cost ) );
    }
    CHECK( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, 2.0 ) );
    CHECK_FALSE( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, 4.2, 0 ) );
    CHECK_FALSE( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, 4.2, 1 ) );
    CHECK( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, 4.2, 2 ) );
    CHECK_FALSE( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, 4.2, 4, false ) );
    CHECK( vision_preparation::should_prepare( MAX_VIEW_DISTANCE, 4.2 ) );
    CHECK_FALSE( vision_preparation::should_prepare( 31, 4.2 ) );
    CHECK_FALSE( vision_preparation::should_prepare( MAX_VIEW_DISTANCE,
                 std::numeric_limits<double>::quiet_NaN() ) );
    CHECK_FALSE( vision_preparation::should_prepare( MAX_VIEW_DISTANCE,
                 std::numeric_limits<double>::infinity() ) );
}

TEST_CASE( "vision_serial_cost_observation_preserves_visibility", "[vision][preparation]" )
{
    auto data = fixture( 824 );
    const auto direction = GENERATE( vertical_direction::UP, vertical_direction::DOWN,
                                     vertical_direction::BOTH );
    data->direction = direction;
    auto expected = std::make_unique<output>();
    auto actual = std::make_unique<output>();
    baseline( *expected, *data );
    views v( *actual, *data );
    restore_on_out_of_scope restore( trigdist );
    trigdist = data->trig_distance;
    double cost = -1.0;
    cast_zlight<float, sight_calc, sight_check, accumulate_transparency>(
        v.out, v.in, v.floors, data->origin, data->offset_distance, data->numerator,
        direction, &cost );
    CHECK( cost >= 0.0 );
    equal( *expected, *actual );
}
