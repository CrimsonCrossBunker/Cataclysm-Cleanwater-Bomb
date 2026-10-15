#include <future>
#include <limits>
#include <memory>
#include <random>
#include <thread>

#include "ai_reachability.h"
#include "cata_catch.h"
#include "rng.h"
#include "thread_pool.h"

namespace
{
std::unique_ptr<ai_reachability::snapshot> geometry_fixture()
{
    auto values = std::make_unique<ai_reachability::snapshot>();
    values->terrain = { 0, ai_reachability::present | ai_reachability::movable,
                        ai_reachability::present | ai_reachability::movable | ai_reachability::vertical,
                        ai_reachability::present | ai_reachability::vertical
                      };
    values->furniture_nonblocking = { 1, 0 };
    std::mt19937 random( 20261015 ); // NOLINT(cata-determinism)
    for( auto &block : values->blocks ) {
        block.uniform = random() % 3 == 0;
        for( auto &cell : block.cells ) {
            cell = { static_cast<int>( random() % 4 ), static_cast<int>( random() % 2 ) };
        }
    }
    for( auto &layer : values->transparent ) {
        for( auto &column : layer ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                column[y] = random() % 3 == 0;
            }
        }
    }
    for( auto &layer : values->opaque_passable ) {
        for( auto &column : layer ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                column[y] = random() % 5 == 0;
            }
        }
    }
    return values;
}
std::unique_ptr<ai_reachability::output> independent_predicate(
    const ai_reachability::snapshot &values )
{
    auto result = std::make_unique<ai_reachability::output>();
    for( int z = 0; z < OVERMAP_LAYERS; ++z ) {
        for( int x = 0; x < MAPSIZE_X; ++x ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                result->passable[z][x][y] = values.transparent[z][x][y] ||
                                            values.opaque_passable[z][x][y];
                // The legacy down predicate takes terrain from above, furniture
                // and transparency from the destination. Preserve that asymmetry.
                for( int direction : {
                         1, -1
                     } ) {
                    const int source_z = direction == 1 ? z : z + 1;
                    bool allowed = false;
                    if( source_z < OVERMAP_LAYERS ) {
                        const auto &terrain_cell = values.at( source_z, x, y );
                        const auto &furniture_cell = values.at( z, x, y );
                        const unsigned flags = values.terrain[terrain_cell.terrain];
                        const bool exists = flags & ai_reachability::present;
                        const bool has_opening = flags & ai_reachability::vertical;
                        const bool can_step = ( flags & ai_reachability::movable ) &&
                                              values.furniture_nonblocking[furniture_cell.furniture];
                        allowed = exists && has_opening && ( can_step || values.transparent[z][x][y] );
                    }
                    auto &grid = direction == 1 ? result->up : result->down;
                    grid[z][x][y] = allowed;
                }
            }
        }
    }
    return result;
}
} // namespace

TEST_CASE( "ai_reachability_geometry_retains_vertical_predicate_and_partition_edges",
           "[monster][ai_reachability]" )
{
    auto values = geometry_fixture();
    auto expected = independent_predicate( *values );
    const unsigned workers = GENERATE( 0U, 2U, 3U, 4U );
    ai_reachability::frame frame( workers );
    auto request = frame.try_acquire();
    REQUIRE( request );
    frame.capture() = *values;
    const cata_default_random_engine rng_before = rng_get_engine();
    REQUIRE( frame.prepare( request ) );
    REQUIRE( frame.result() != nullptr );
    CHECK( frame.result()->passable == expected->passable );
    CHECK( frame.result()->up == expected->up );
    CHECK( frame.result()->down == expected->down );
    CHECK( frame.used_workers() == ( workers > 0 ) );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "ai_reachability_result_rejects_cancel_stale_and_nested_requests",
           "[monster][ai_reachability]" )
{
    ai_reachability::frame frame( 4 );
    {
        auto request = frame.try_acquire();
        REQUIRE( request );
        CHECK_FALSE( frame.try_acquire() );
        frame.capture() = *geometry_fixture();
        SECTION( "owner_invalidation_rejects_held_request" ) {
            frame.invalidate();
            CHECK_FALSE( frame.prepare( request ) );
        }
        SECTION( "cancellation_before_prepare" ) {
            frame.cancel();
            CHECK_FALSE( frame.prepare( request ) );
        }
        SECTION( "cancellation_during_prepare_or_publication" ) {
            std::thread cancel( [&frame]() {
                frame.cancel();
            } );
            frame.prepare( request );
            cancel.join();
        }
        SECTION( "completed_result_invalidated_before_use" ) {
            REQUIRE( frame.prepare( request ) );
            REQUIRE( frame.result() != nullptr );
            frame.invalidate();
        }
        CHECK( frame.result() == nullptr );
    }
    auto retry = frame.try_acquire();
    REQUIRE( retry );
    frame.capture() = *geometry_fixture();
    REQUIRE( frame.prepare( retry ) );
    CHECK( frame.result() != nullptr );
}

TEST_CASE( "ai_reachability_failed_task_drains_and_recovers_without_partial_result",
           "[monster][ai_reachability]" )
{
    ai_reachability::frame frame( 4 );
    {
        auto request = frame.try_acquire();
        auto &values = frame.capture();
        values = *geometry_fixture();
        values.blocks.back().uniform = true;
        values.blocks.back().cells[0].terrain = std::numeric_limits<int>::max();
        CHECK_FALSE( frame.prepare( request ) );
        CHECK( frame.result() == nullptr );
    }
    auto retry = frame.try_acquire();
    frame.capture() = *geometry_fixture();
    const auto expected = independent_predicate( frame.capture() );
    REQUIRE( frame.prepare( retry ) );
    CHECK( frame.result()->passable == expected->passable );
    CHECK( frame.result()->up == expected->up );
}

TEST_CASE( "ai_reachability_independent_owners_and_nested_pool_admission",
           "[monster][ai_reachability]" )
{
    auto run = []() {
        ai_reachability::frame frame( 2 );
        auto request = frame.try_acquire();
        frame.capture() = *geometry_fixture();
        if( !frame.prepare( request ) ) {
            return false;
        }
        return frame.result()->up == independent_predicate( *geometry_fixture() )->up;
    };
    auto first = std::async( std::launch::async, run );
    auto second = std::async( std::launch::async, run );
    CHECK( first.get() );
    CHECK( second.get() );
    cata_thread_pool outer( 1 );
    auto nested = outer.submit_returning( []() {
        ai_reachability::frame frame( 4 );
        return frame.worker_count() == 0 && !frame.try_acquire();
    } );
    CHECK( nested.get() );
}

TEST_CASE( "ai_reachability_preparation_requires_measured_dense_owner_work",
           "[monster][ai_reachability]" )
{
    CHECK_FALSE( ai_reachability::should_prepare( 63, 2.0, true ) );
    CHECK_FALSE( ai_reachability::should_prepare( 759, 0.99, true ) );
    CHECK_FALSE( ai_reachability::should_prepare( 759, 2.0, false ) );
    CHECK_FALSE( ai_reachability::should_prepare( 759, std::numeric_limits<double>::quiet_NaN(),
            true ) );
    CHECK( ai_reachability::should_prepare( 759, 1.0, true ) );
}

BENCHMARK_TEST_CASE( "ai_reachability_geometry_preparation_benchmark", "[ai_reachability]" )
{
    const unsigned workers = GENERATE( 0U, 2U, 4U );
    ai_reachability::frame frame( workers );
    {
        auto request = frame.try_acquire();
        frame.capture() = *geometry_fixture();
        REQUIRE( frame.prepare( request ) );
    }
    BENCHMARK( workers == 0 ? "owned serial geometry" : workers == 2 ? "two geometry workers" :
               "four geometry workers" ) {
        auto request = frame.try_acquire();
        return frame.prepare( request );
    };
}
