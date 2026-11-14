#include <cstddef>
#include <memory>
#include <new>

#include "ai_reachability.h"
#include "cata_catch.h"
#include "compute_budget.h"
#include "rng.h"
#include "thread_pool.h"
#include "tile_preparation.h"
#include "vision_preparation.h"

namespace
{
// Reserve the remaining allowance without allocating 64 MiB just for a test.
// Production owners encounter the identical admission failure when other
// owners retain buffers. The scope releases it even when an assertion fails.
class memory_pressure
{
    public:
        memory_pressure() : budget_( compute_byte_budget() ), bytes_( budget_.limit() - budget_.used() ) {
            REQUIRE( budget_.acquire( bytes_ ) );
        }
        ~memory_pressure() {
            budget_.release( bytes_ );
        }
    private:
        byte_budget &budget_;
        std::size_t bytes_;
};
} // namespace

TEST_CASE( "compute_domains_share_workers_and_release_retained_buffers", "[compute_resources]" )
{
    auto pool = get_compute_pool();
    const long owners = pool.use_count();
    const std::size_t before = compute_byte_budget().used();
    {
        ai_reachability::frame ai( 4 );
        vision_preparation::frame vision( 2 );
        tile_preparation::frame tiles( 1 );
        CHECK( pool.use_count() == owners + 3 );
        CHECK( ai.worker_count() == 4 );
        CHECK( vision.worker_count() == 2 );
        CHECK( tiles.worker_count() == 1 );
        auto ai_lease = ai.try_acquire();
        REQUIRE( ai_lease );
        ai.capture().terrain.resize( 100 );
        auto vision_lease = vision.try_acquire( 60 );
        REQUIRE( vision_lease );
        vision.capture();
        auto tiles_lease = tiles.try_acquire( 16384 );
        REQUIRE( tiles_lease );
        CHECK( compute_byte_budget().used() > before + sizeof( ai_reachability::snapshot ) +
               sizeof( vision_preparation::snapshot ) );
    }
    CHECK( pool.use_count() == owners );
    CHECK( compute_byte_budget().used() == before );
}

TEST_CASE( "compute_memory_pressure_rejects_speculation_without_partial_results",
           "[compute_resources]" )
{
    const auto rng_before = rng_get_engine();
    const std::size_t before = compute_byte_budget().used();
    {
        ai_reachability::frame ai( 4 );
        vision_preparation::frame vision( 2 );
        tile_preparation::frame tiles( 2 );
        {
            memory_pressure pressure;
            auto request = ai.try_acquire();
            REQUIRE( request );
            CHECK_THROWS_AS( ai.capture(), std::bad_alloc );
            CHECK( ai.result() == nullptr );
            auto sight = vision.try_acquire( 60 );
            REQUIRE( sight );
            CHECK_THROWS_AS( vision.capture(), std::bad_alloc );
            CHECK_FALSE( tiles.try_acquire( 16384 ) );
            CHECK( tiles.results().empty() );
        }
        {
            auto request = ai.try_acquire();
            REQUIRE( request );
            ai.capture();
            memory_pressure pressure;
            CHECK_FALSE( ai.prepare( request ) );
            CHECK( ai.result() == nullptr );
            CHECK_FALSE( ai.used_workers() );
        }
        {
            auto sight = vision.try_acquire( 60 );
            REQUIRE( sight );
            vision.capture();
            memory_pressure pressure;
            CHECK_FALSE( vision.prepare() );
            CHECK_FALSE( vision.used_workers() );
        }
        // Budget rejection does not disable the owner permanently.
        auto tiles_lease = tiles.try_acquire( 16384 );
        REQUIRE( tiles_lease );
        tiles.capture().resize( 16384 );
        tiles.prepare();
        CHECK( tiles.results().size() == 16384 );
        CHECK( tiles.used_workers() );
    }
    CHECK( compute_byte_budget().used() == before );
    CHECK( rng_get_engine() == rng_before );
}
