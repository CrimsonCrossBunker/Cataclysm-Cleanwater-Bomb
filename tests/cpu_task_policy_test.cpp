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
    policy.observe( 1000, cpu_worker_limit + 1, 1 );
    policy.observe( 1000, 0, 0 );
    policy.observe( 1000, 0, -1 );
    policy.observe( 1000, 0, std::numeric_limits<double>::quiet_NaN() );
    policy.observe( 1000, 0, std::numeric_limits<double>::infinity() );
    CHECK( policy.statistics().batches == before );
}

TEST_CASE( "cpu_subsystem_quotas_support_auto_and_manual_limits", "[threading][cpu_policy]" )
{
    CHECK( cpu_worker_limit == 128 );
    CHECK( cpu_worker_quota( -1 ) == cpu_worker_limit );
    CHECK( cpu_worker_quota( 0 ) == 0 );
    CHECK( cpu_worker_quota( 1 ) == 1 );
    CHECK( cpu_worker_quota( 4 ) == 4 );
    CHECK( cpu_worker_quota( 128 ) == 128 );
    CHECK( cpu_worker_quota( 129 ) == cpu_worker_limit );
}

TEST_CASE( "cpu_latency_sensitive_batches_start_parallel", "[threading][cpu_policy]" )
{
    cpu_task_policy policy;
    CHECK( policy.choose( 900, 31, 1, true ) == 31 );
    CHECK( policy.choose( 900, 3, 1, true ) == 3 );
    CHECK( policy.choose( 900, 0, 1, true ) == 0 );
    CHECK( policy.choose( 1, 31, 1, true ) == 0 );
    CHECK( policy.choose( 900, 256, 1, true ) == cpu_worker_limit );
    policy.observe( 900, 31, 100000000 );
    CHECK( policy.choose( 900, 31, 1, true ) > 0 );
    CHECK( policy.choose( 900, 7, 1, true ) <= 7 );
}

TEST_CASE( "cpu_latency_sensitive_batches_avoid_slow_serial_probes", "[threading][cpu_policy]" )
{
    cpu_task_policy policy;
    policy.observe( 900, 0, 13000000000.0 );
    CHECK( policy.choose( 900, 31, 1, true ) == 31 );
    for( int i = 1; i < 32; ++i ) {
        policy.observe( 900, 31, 500000000 );
    }
    CHECK( policy.choose( 900, 31, 1, true ) > 0 );
    CHECK( policy.choose( 900, 31, 1, true ) < 31 );
}

TEST_CASE( "cpu_latency_sensitive_small_batches_can_rebaseline", "[threading][cpu_policy]" )
{
    cpu_task_policy policy;
    for( int i = 0; i < 32; ++i ) {
        policy.observe( 900, 7, 100000 );
    }
    CHECK( policy.choose( 900, 31, 1, true ) == 0 );
}

TEST_CASE( "cpu_quota_can_learn_beyond_64_workers", "[threading][cpu_policy]" )
{
    cpu_task_policy policy;
    for( int i = 0; i < 3; ++i ) {
        policy.observe( 4096, 0, 100000000 );
    }
    for( unsigned workers = 1; workers <= cpu_worker_limit; workers *= 2 ) {
        REQUIRE( policy.choose( 4096, cpu_worker_limit, 1 ) == workers );
        for( int i = 0; i < 3; ++i ) {
            policy.observe( 4096, workers, 100000000.0 / ( workers + 1 ) );
        }
    }
    CHECK( policy.choose( 4096, cpu_worker_limit, 1 ) == cpu_worker_limit );
    CHECK( policy.choose( 4096, 65, 1 ) <= 65 );
    CHECK( policy.choose( 4096, 256, 1 ) <= cpu_worker_limit );
    CHECK( policy.choose( 32, cpu_worker_limit, 1 ) <= 31 );
}
