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
                   ( tasks >= 16 && cost >= 50 && cost * tasks >= 2000 ) );
            CHECK( policy.begin( 0, tasks, 512, 20 ) ==
                   ( tasks >= 512 && cost >= 20 && cost * tasks >= 2000 ) );
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
    CHECK_FALSE( policy.begin( 0, 16000, 16, 50 ) );
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
