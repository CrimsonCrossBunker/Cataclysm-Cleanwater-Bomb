#include <array>
#include <future>
#include <vector>

#include "cata_catch.h"
#include "sprite_geometry.h"

static sprite_geometry_input ordinary_sprite()
{
    sprite_geometry_input input;
    input.screen_position = point( 100, 200 );
    input.sprite_size = point( 20, 40 );
    input.screen_tile_size = point( 10, 10 );
    input.tileset_tile_size = point( 20, 20 );
    input.calculate_opaque_bounds = true;
    input.source_opaque_bounds = { point( 3, 4 ), point( 6, 8 ) };
    return input;
}

static void check_same_geometry( const sprite_geometry_result &actual,
                                 const sprite_geometry_result &expected )
{
    CHECK( actual.destination.origin == expected.destination.origin );
    CHECK( actual.destination.size == expected.destination.size );
    CHECK( actual.angle == expected.angle );
    CHECK( actual.flip_horizontal == expected.flip_horizontal );
    CHECK( actual.flip_vertical == expected.flip_vertical );
    CHECK( actual.rotation_code == expected.rotation_code );
    REQUIRE( actual.opaque_bounds.has_value() == expected.opaque_bounds.has_value() );
    if( actual.opaque_bounds ) {
        CHECK( actual.opaque_bounds->origin == expected.opaque_bounds->origin );
        CHECK( actual.opaque_bounds->size == expected.opaque_bounds->size );
    }
}

TEST_CASE( "sprite_geometry_preserves_rotation_contract", "[sprite_geometry][tiles]" )
{
    struct rotation_case {
        int rotation;
        bool diagonal;
        double angle;
        bool flip_horizontal;
        bool flip_vertical;
        int code;
    };
    const std::array<rotation_case, 16> cases = {{
            { 0, false, 0, false, false, 0 },
            { 1, false, 90, false, false, 1 },
            { 2, false, 0, true, true, 2 },
            { 3, false, -90, false, false, 3 },
            { 4, false, 0, false, false, 0 },
            { 5, false, 90, false, false, 1 },
            { 6, false, 0, true, true, 2 },
            { 7, false, -90, false, false, 3 },
            { 8, false, 0, false, false, 0 },
            { -1, false, 0, true, false, -1 },
            { -5, false, 0, false, false, -1 },
            { 5, true, 45, false, false, 5 },
            { 6, true, -45, false, false, 6 },
            { 7, true, -135, false, false, 7 },
            { 8, true, 135, false, false, 8 },
            { 9, true, 0, false, false, 9 }
        }
    };
    for( const rotation_case &test : cases ) {
        CAPTURE( test.rotation, test.diagonal );
        sprite_geometry_input input = ordinary_sprite();
        input.rotate_sprite = true;
        input.rotation = test.rotation;
        input.allow_diagonal_rotation = test.diagonal;
        const sprite_geometry_result result = prepare_sprite_geometry( input );
        CHECK( result.angle == test.angle );
        CHECK( result.flip_horizontal == test.flip_horizontal );
        CHECK( result.flip_vertical == test.flip_vertical );
        CHECK( result.rotation_code == test.code );

        // Isometric sprites suppress angle and vertical flips, but retain the
        // explicit horizontal mirror and the code used by the backend adapter.
        input.isometric = true;
        const sprite_geometry_result iso = prepare_sprite_geometry( input );
        CHECK( iso.angle == 0 );
        CHECK( iso.flip_horizontal == ( test.rotation == -1 ) );
        CHECK_FALSE( iso.flip_vertical );
        CHECK( iso.rotation_code == test.code );

        // Backgrounds without manual variants, and pre-rotated variants, must
        // never receive another transform at submission.
        input.isometric = false;
        input.rotate_sprite = false;
        const sprite_geometry_result unrotated = prepare_sprite_geometry( input );
        CHECK( unrotated.angle == 0 );
        CHECK_FALSE( unrotated.flip_horizontal );
        CHECK_FALSE( unrotated.flip_vertical );
        CHECK( unrotated.rotation_code == 0 );
    }
}

TEST_CASE( "sprite_geometry_preserves_negative_offsets_height_and_retraction",
           "[sprite_geometry][tiles]" )
{
    sprite_geometry_input input = ordinary_sprite();
    input.sprite_size = point( 32, 48 );
    input.screen_tile_size = point( 12, 9 );
    input.tileset_tile_size = point( 16, 24 );
    input.offset = point( -3, -5 );
    input.offset_retracted = point( 5, 7 );
    input.extra_offset = point( 1, 2 );
    input.stacked_height = 4;
    input.pixelscale = 0.75f;
    struct retraction_case {
        int retract;
        point origin;
    };
    const std::array<retraction_case, 7> cases = {{
            { -50, point( 98, 194 ) }, { 0, point( 98, 194 ) },
            { 25, point( 100, 197 ) }, { 50, point( 101, 199 ) },
            { 99, point( 103, 203 ) }, { 100, point( 104, 203 ) },
            { 150, point( 104, 203 ) }
        }
    };
    for( const retraction_case &test : cases ) {
        CAPTURE( test.retract );
        input.retract = test.retract;
        const sprite_geometry_result result = prepare_sprite_geometry( input );
        CHECK( result.destination.origin == test.origin );
        CHECK( result.destination.size == point( 18, 13 ) );
        CHECK( input.stacked_height == 4 );
    }
    // Interpolation truncates toward zero; negative screen offsets then floor.
    input.offset = point( 3, 5 );
    input.offset_retracted = point( -5, -7 );
    input.retract = 25;
    CHECK( prepare_sprite_geometry( input ).destination.origin == point( 101, 200 ) );
}

TEST_CASE( "sprite_geometry_keeps_tint_footprint_before_backend_adjustment",
           "[sprite_geometry][tiles]" )
{
    sprite_geometry_input input = ordinary_sprite();
    input.rotate_sprite = true;
    const sprite_geometry_result normal = prepare_sprite_geometry( input );
    CHECK( normal.destination.origin == point( 100, 200 ) );
    CHECK( normal.destination.size == point( 10, 20 ) );
    REQUIRE( normal.opaque_bounds );
    CHECK( normal.opaque_bounds->origin == point( 101, 202 ) );
    CHECK( normal.opaque_bounds->size == point( 3, 4 ) );

    input.rotation = -1;
    REQUIRE( prepare_sprite_geometry( input ).opaque_bounds );
    CHECK( prepare_sprite_geometry( input ).opaque_bounds->origin == point( 105, 202 ) );
    input.rotation = 2;
    CHECK( prepare_sprite_geometry( input ).opaque_bounds->origin == point( 105, 214 ) );
    input.isometric = true;
    CHECK( prepare_sprite_geometry( input ).opaque_bounds->origin == point( 101, 202 ) );
    input.isometric = false;
    input.rotation = 1;
    const sprite_geometry_result quarter_turn = prepare_sprite_geometry( input );
    CHECK( quarter_turn.angle == 90 );
    CHECK( quarter_turn.destination.origin == point( 100, 200 ) );
    CHECK( quarter_turn.opaque_bounds->origin == point( 101, 202 ) );

    // Characterize the existing diagonal footprint separately from its actual
    // transform; changing that tint behavior belongs to a later visual fix.
    input.rotation = 6;
    input.allow_diagonal_rotation = true;
    const sprite_geometry_result diagonal = prepare_sprite_geometry( input );
    CHECK( diagonal.angle == -45 );
    CHECK_FALSE( diagonal.flip_horizontal );
    CHECK( diagonal.opaque_bounds->origin == point( 105, 214 ) );
    input.source_opaque_bounds.size.x = 0;
    CHECK_FALSE( prepare_sprite_geometry( input ).opaque_bounds );
    input.source_opaque_bounds.size.x = 6;
    input.calculate_opaque_bounds = false;
    CHECK_FALSE( prepare_sprite_geometry( input ).opaque_bounds );
}

TEST_CASE( "sprite_geometry_owned_batches_prepare_identically_in_parallel",
           "[sprite_geometry][tiles]" )
{
    std::vector<sprite_geometry_input> inputs;
    std::vector<sprite_geometry_result> expected;
    for( int i = 0; i < 64; ++i ) {
        sprite_geometry_input input = ordinary_sprite();
        input.screen_position += point( i * 3, -i * 7 );
        input.rotation = i % 10 - 1;
        input.rotate_sprite = i % 3 != 0;
        input.isometric = i % 2 != 0;
        input.allow_diagonal_rotation = i % 5 != 0;
        input.retract = i * 2;
        input.offset = point( -5, 7 );
        input.offset_retracted = point( 5, -7 );
        input.stacked_height = i;
        inputs.push_back( input );
        expected.push_back( prepare_sprite_geometry( input ) );
    }
    std::vector<std::future<std::vector<sprite_geometry_result>>> jobs;
    for( int i = 0; i < 4; ++i ) {
        // Each job owns its inputs and results, preserving their original order.
        jobs.push_back( std::async( std::launch::async, [owned = inputs]() {
            std::vector<sprite_geometry_result> results;
            results.reserve( owned.size() );
            for( const sprite_geometry_input &input : owned ) {
                results.push_back( prepare_sprite_geometry( input ) );
            }
            return results;
        } ) );
    }
    // No job may observe changes in the producer's inputs or borrow its memory.
    inputs.clear();
    for( std::future<std::vector<sprite_geometry_result>> &job : jobs ) {
        const std::vector<sprite_geometry_result> actual = job.get();
        REQUIRE( actual.size() == expected.size() );
        for( size_t i = 0; i < actual.size(); ++i ) {
            check_same_geometry( actual[i], expected[i] );
        }
    }
}
