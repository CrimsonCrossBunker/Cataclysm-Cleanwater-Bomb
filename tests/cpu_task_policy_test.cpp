#include <limits>

#include "cata_catch.h"
#include "cpu_scheduler.h"

TEST_CASE( "cpu_quota_learns_cost_and_limits_concurrency", "[threading][cpu_policy]" )
{
    cpu_task_policy policy;
    CHECK( policy.choose( 1000, 16, 16 ) == 0 );
    for( int i = 0; i < 3; ++i ) {
        policy.observe( 1000, 0, 1000000 );
    }
    CHECK( policy.choose( 1000, 16, 16 ) == 1 );
    policy.observe( 1000, 1, 600000 );
    CHECK( policy.choose( 1000, 16, 16 ) == 1 );
    policy.observe( 1000, 1, 600000 );
    policy.observe( 1000, 1, 600000 );
    CHECK( policy.choose( 1000, 16, 16 ) == 2 );
    CHECK( policy.choose( 1000, 1, 16 ) == 1 );
    CHECK( policy.choose( 1000, 0, 16 ) == 0 );
    CHECK( policy.choose( 31, 16, 16 ) == 0 );
    CHECK( policy.choose( 32, 16, 16 ) <= 1 );
    CHECK( policy.choose( 100, 16, 16 ) == 0 );
    CHECK( policy.statistics().parallel_batches == 3 );
}

TEST_CASE( "cpu_quota_rejects_overhead_and_refreshes_baseline", "[threading][cpu_policy]" )
{
    cpu_task_policy policy;
    for( int i = 0; i < 3; ++i ) {
        policy.observe( 1000, 0, 1000000 );
    }
    policy.observe( 1000, 1, 1200000 );
    CHECK( policy.choose( 1000, 8, 1 ) == 0 );
    for( int i = 4; i < 32; ++i ) {
        policy.observe( 1000, 1, 600000 );
    }
    CHECK( policy.choose( 1000, 8, 1 ) == 0 );
    const auto before = policy.statistics().batches;
    policy.observe( 0, 0, 1 );
    policy.observe( 1000, 65, 1 );
    policy.observe( 1000, 0, 0 );
    policy.observe( 1000, 0, -1 );
    policy.observe( 1000, 0, std::numeric_limits<double>::quiet_NaN() );
    policy.observe( 1000, 0, std::numeric_limits<double>::infinity() );
    CHECK( policy.statistics().batches == before );
}
