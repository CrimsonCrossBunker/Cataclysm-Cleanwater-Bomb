#include <array>
#include <cstdint>
#include <functional>
#include <memory>
#include <vector>

#include "bresenham.h"
#include "cata_catch.h"
#include "line.h"

TEST_CASE( "typed_bresenham_matches_same_level_3d_traversal", "[line][bresenham]" )
{
    const point_bub_ms source( 13, -7 );
    for( int dx = -12; dx <= 12; ++dx ) {
        for( int dy = -12; dy <= 12; ++dy ) {
            const point_bub_ms target = source + point_rel_ms( dx, dy );
            for( int slope : {
                     -25, -3, 0, 1, 7, 25
                     } ) {
                for( int stop_after : {
                         1, 4, 100
                     } ) {
                    CAPTURE( dx, dy, slope, stop_after );
                    std::vector<point> expected;
                    bresenham( tripoint_bub_ms( source, 2 ), tripoint_bub_ms( target, 2 ), slope, 0,
                    [&]( const tripoint_bub_ms & p ) {
                        expected.push_back( p.xy().raw() );
                        return static_cast<int>( expected.size() ) < stop_after;
                    } );
                    std::vector<point> actual;
                    bresenham_2d( source, target, slope, [&]( const point_bub_ms & p ) {
                        actual.push_back( p.raw() );
                        return static_cast<int>( actual.size() ) < stop_after;
                    } );
                    CHECK( static_cast<bool>( actual == expected ) );
                    std::vector<point> erased;
                    bresenham( source, target, slope, [&]( const point_bub_ms & p ) {
                        erased.push_back( p.raw() );
                        return static_cast<int>( erased.size() ) < stop_after;
                    } );
                    CHECK( static_cast<bool>( erased == expected ) );
                    if( stop_after == 100 ) {
                        if( source == target ) {
                            expected.push_back( source.raw() );
                        }
                        CHECK( static_cast<bool>( line_to( source.raw(), target.raw(), slope ) == expected ) );
                    }
                }
            }
        }
    }
}

TEST_CASE( "typed_bresenham_preserves_callback_state_and_early_exit", "[line][bresenham]" )
{
    std::vector<int> visited;
    auto callback = [count = std::make_unique<int>( 0 ), &visited]( const point_bub_ms & p ) mutable {
        visited.push_back( p.x() );
        return ++ *count < 3;
    };
    bresenham_2d( point_bub_ms::zero, point_bub_ms( 8, 0 ), 0, callback );
    CHECK( visited == std::vector<int> { 1, 2, 3 } );
    visited.clear();
    bresenham_2d( point_bub_ms::zero, point_bub_ms( 8, 0 ), 0, callback );
    CHECK( visited == std::vector<int> { 1 } );
    visited.clear();
    bresenham_2d( point_bub_ms::zero, point_bub_ms::zero, 0, callback );
    CHECK( visited.empty() );
}

namespace
{
// Fixed, allocation-free transparency grid. Both paths inspect the same cells.
std::uint64_t scan_visibility_rays( bool typed, bool obstacles )
{
    std::array<bool, 128 * 128> transparent;
    transparent.fill( true );
    if( obstacles ) {
        for( int y = 0; y < 128; ++y ) {
            transparent[y * 128 + 43] = false;
            transparent[y * 128 + 83] = false;
        }
    }
    std::uint64_t checksum = 0;
    for( int ray = 0; ray < 4096; ++ray ) {
        const point_bub_ms from( 48 + ray % 32, 48 + ( ray / 32 ) % 32 );
        const point_bub_ms to( 4 + ( ray * 17 ) % 120, 4 + ( ray * 29 ) % 120 );
        bool visible = true;
        auto inspect = [&]( const point_bub_ms & p ) {
            if( p == to ) {
                return false;
            }
            ++checksum;
            visible = transparent[p.y() * 128 + p.x()];
            return visible;
        };
        if( typed ) {
            bresenham_2d( from, to, 0, inspect );
        } else {
            bresenham( from, to, 0, inspect );
        }
        checksum += visible;
    }
    return checksum;
}
} // namespace

TEST_CASE( "typed_visibility_scans_preserve_occlusion_results", "[line][bresenham]" )
{
    CHECK( scan_visibility_rays( true, false ) == scan_visibility_rays( false, false ) );
    CHECK( scan_visibility_rays( true, true ) == scan_visibility_rays( false, true ) );
}

BENCHMARK_TEST_CASE( "typed_bresenham_visibility_benchmark", "[line][bresenham]" )
{
    BENCHMARK( "std_function_open_4096_rays" ) {
        return scan_visibility_rays( false, false );
    };
    BENCHMARK( "typed_open_4096_rays" ) {
        return scan_visibility_rays( true, false );
    };
    BENCHMARK( "std_function_obstructed_4096_rays" ) {
        return scan_visibility_rays( false, true );
    };
    BENCHMARK( "typed_obstructed_4096_rays" ) {
        return scan_visibility_rays( true, true );
    };
}
