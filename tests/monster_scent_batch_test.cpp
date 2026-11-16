#include "cata_catch.h"
#include "map.h"
#include "map_helpers.h"
#include "monster_scent_batch.h"
#include "options_helpers.h"
#include "scent_map.h"
#include "thread_pool.h"

TEST_CASE( "monster_scent_batch_rejects_changed_scent", "[monster][threading][scent]" )
{
    override_option enabled( "MULTITHREADING_ENABLED", "true" );
    clear_map();
    map &here = get_map();
    scent_map &scents = get_scent();
    scents.reset();
    const tripoint_bub_ms source( 40, 40, here.get_abs_sub().z() );
    scents.set( source, 50 );
    monster_scent_batch batch;
    // Exercise publication with an expensive observation; timing policy itself
    // is checked deterministically in monster_batch_policy_test.cpp.
    for( int i = 0; i < 64; ++i ) {
        monster_scent_batch::observe_serial( 1000 );
    }
    for( int x = 30; x < 62; ++x ) {
        for( int y = 30; y < 46; ++y ) {
            batch.add( tripoint_bub_ms( x, y, source.z() ) );
        }
    }
    batch.prepare( here, scents );
    const auto directions = monster_scent_batch::directions( here, scents, source, 10 );
    if( get_thread_pool().num_workers() < 2 ) {
        CHECK_FALSE( directions );
        return;
    }
    REQUIRE( directions );
    for( int x = 30; x < 62; ++x ) {
        for( int y = 30; y < 46; ++y ) {
            REQUIRE( monster_scent_batch::directions( here, scents,
                     tripoint_bub_ms( x, y, source.z() ), 10 ) );
        }
    }
    REQUIRE( directions->size() == 1 );
    CHECK( directions->front() == source );
    SECTION( "changing scent invalidates published rankings" ) {
        scents.set( source, 70 );
    }
    SECTION( "reset invalidates published rankings" ) {
        scents.reset();
    }
    SECTION( "decay invalidates published rankings" ) {
        scents.decay();
    }
    SECTION( "loading scent invalidates published rankings" ) {
        scents.deserialize( scents.serialize() );
    }
    SECTION( "shifting scent invalidates published rankings" ) {
        scents.shift( point_rel_ms( 1, 0 ) );
    }
    CHECK_FALSE( monster_scent_batch::directions( here, scents, source, 10 ) );
    scents.reset();
}

TEST_CASE( "monster_scent_batch_skips_sparse_work", "[monster][threading][scent]" )
{
    override_option enabled( "MULTITHREADING_ENABLED", "true" );
    clear_map();
    map &here = get_map();
    scent_map &scents = get_scent();
    monster_scent_batch batch;
    const tripoint_bub_ms source( 40, 40, here.get_abs_sub().z() );
    for( int x = 30; x < 70; ++x ) {
        batch.add( tripoint_bub_ms( x, 40, source.z() ) );
    }
    batch.prepare( here, scents );
    CHECK_FALSE( monster_scent_batch::directions( here, scents, source, 10 ) );
}
