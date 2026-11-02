#include "cata_catch.h"
#include "map.h"
#include "map_helpers.h"
#include "monster_scent_batch.h"
#include "options_helpers.h"
#include "scent_map.h"

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
    for( int x = 30; x < 70; ++x ) {
        batch.add( tripoint_bub_ms( x, 40, source.z() ) );
    }
    batch.prepare( here, scents );
    const auto directions = monster_scent_batch::directions( here, scents, source, 10 );
    REQUIRE( directions );
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
    CHECK_FALSE( monster_scent_batch::directions( here, scents, source, 10 ) );
    scents.reset();
}
