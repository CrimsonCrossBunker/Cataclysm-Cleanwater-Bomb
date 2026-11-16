#include "cata_catch.h"
#include "monster_batch_policy.h"

TEST_CASE( "monster_batches_use_actual_work_not_population", "[monster][threading]" )
{
    for( const std::size_t tasks : { 4, 12, 16, 50, 100, 400, 1600, 16000 } ) {
        for( const double cost : { 0.5, 5.0, 20.0, 50.0, 200.0, 1000.0 } ) {
            monster_batch_policy policy;
            CHECK_FALSE( policy.begin( 0, tasks, 16, 50 ) );
            for( int sample = 0; sample < 8; ++sample ) {
                policy.observe( 0, cost );
            }
            CHECK( policy.begin( 0, tasks, 16, 50 ) ==
                   ( tasks >= 16 && cost * tasks >= 2000 ) );
            CHECK( policy.begin( 0, tasks, 512, 20 ) ==
                   ( tasks >= 512 && cost * tasks >= 10240 ) );
            CHECK_FALSE( policy.begin( 1, tasks, 16, 50 ) );
        }
    }
}

TEST_CASE( "monster_batches_back_off_when_capture_or_validation_dominates", "[monster][threading]" )
{
    for( const double useful : { 0.0, 100.0, 1000.0 } ) {
        monster_batch_policy policy;
        for( int sample = 0; sample < 8; ++sample ) {
            policy.observe( 0, 200 );
            policy.observe( 1, 200 );
        }
        REQUIRE( policy.begin( 0, 32, 16, 50 ) );
        policy.finish( 0, 32, 1000, useful );
        for( int round = 0; round < 16; ++round ) {
            CHECK_FALSE( policy.begin( 0, 32, 16, 50 ) );
        }
        CHECK( policy.begin( 0, 32, 16, 50 ) );
        CHECK( policy.begin( 1, 32, 16, 50 ) );
        CHECK( policy.begin( 0, 400, 16, 50 ) );
        policy.finish( 0, 32, 100, 1000 );
        CHECK( policy.begin( 0, 32, 16, 50 ) );
    }
}

TEST_CASE( "monster_batches_adapt_when_work_becomes_cheaper", "[monster][threading]" )
{
    monster_batch_policy policy;
    for( int sample = 0; sample < 8; ++sample ) {
        policy.observe( 0, 1000 );
    }
    REQUIRE( policy.begin( 0, 400, 16, 50 ) );
    for( int sample = 0; sample < 64; ++sample ) {
        policy.observe( 0, 1 );
    }
    CHECK_FALSE( policy.begin( 0, 400, 16, 50 ) );
    CHECK( policy.begin( 0, 16000, 16, 50 ) );
}

TEST_CASE( "monster_batches_do_not_wake_workers_for_tiny_chunks", "[monster][threading]" )
{
    CHECK( monster_batch_policy::chunks( 12, 31, 8, 200 ) == 1 );
    CHECK( monster_batch_policy::chunks( 100, 31, 8, 200 ) == 12 );
    CHECK( monster_batch_policy::chunks( 400, 128, 256, 20 ) == 1 );
    CHECK( monster_batch_policy::chunks( 1024, 128, 256, 20 ) == 4 );
    CHECK( monster_batch_policy::chunks( 16000, 2, 256, 20 ) == 2 );
    CHECK( monster_batch_policy::chunks( 16000, 0, 256, 20 ) == 0 );
}

TEST_CASE( "monster_batches_periodically_refresh_serial_cost", "[monster][threading]" )
{
    monster_batch_policy policy;
    for( int sample = 0; sample < 8; ++sample ) {
        policy.observe( 0, 200 );
    }
    for( int round = 0; round < 15; ++round ) {
        CHECK( policy.begin( 0, 32, 16, 50 ) );
        policy.finish( 0, 32, 100, 2000 );
    }
    CHECK_FALSE( policy.begin( 0, 32, 16, 50 ) );
    CHECK( policy.begin( 0, 32, 16, 50 ) );
}

TEST_CASE( "monster_batches_admit_cheap_tasks_only_when_batch_amortizes_cost", "[monster][threading]" )
{
    monster_batch_policy policy;
    for( int sample = 0; sample < 8; ++sample ) {
        policy.observe( 0, 35 );
    }
    CHECK_FALSE( policy.worth_collecting( 0, 50, 16, 50 ) );
    REQUIRE( policy.worth_collecting( 0, 100, 16, 50 ) );
    REQUIRE( policy.begin( 0, 100, 16, 50 ) );
    CHECK( monster_batch_policy::chunks( 100, 31, 8, 35 ) == 7 );
    policy.finish( 0, 100, 1800, 3500 );
    CHECK( policy.begin( 0, 100, 16, 50 ) );

    // Collection is an upper bound; actual candidates must qualify again.
    CHECK_FALSE( policy.begin( 0, 12, 16, 50 ) );
    policy.finish( 0, 100, 3000, 3500 );
    for( int round = 0; round < 16; ++round ) {
        CHECK_FALSE( policy.begin( 0, 100, 16, 50 ) );
    }
    CHECK( policy.begin( 0, 100, 16, 50 ) );
}

TEST_CASE( "monster_batch_cost_sampling_is_bounded_after_warmup", "[monster][threading]" )
{
    monster_batch_policy policy;
    for( int i = 0; i < 8; ++i ) {
        REQUIRE( policy.should_observe( 0 ) );
        policy.observe( 0, 35 );
    }
    CHECK( policy.estimate( 0 ) == Approx( 35 ) );
    for( int cycle = 0; cycle < 4; ++cycle ) {
        for( int i = 0; i < 15; ++i ) {
            CHECK_FALSE( policy.should_observe( 0 ) );
        }
        REQUIRE( policy.should_observe( 0 ) );
        policy.observe( 0, 70 );
    }
    CHECK( policy.estimate( 0 ) > 35 );
    CHECK( policy.should_observe( 1 ) );
    CHECK( policy.estimate( 1 ) == 0 );
}
