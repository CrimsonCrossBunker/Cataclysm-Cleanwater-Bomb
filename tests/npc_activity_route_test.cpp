#include <cstddef>
#include <list>
#include <optional>

#include "activity_actor_definitions.h"
#include "activity_item_handling.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "map_helpers.h"
#include "npc.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "npc_work_route_waits_without_growing_backlog", "[npc][activity][crafting]" )
{
    clear_avatar();
    clear_map_without_vision();
    npc &worker = spawn_npc( { 60, 60 }, "test_talker" );
    clear_character( worker, true );

    SECTION( "crafting" ) {
        worker.assign_activity( multi_craft_activity_actor() );
    }
    SECTION( "disassembly" ) {
        worker.assign_activity( multi_disassemble_activity_actor() );
    }

    const activity_id original = worker.activity.id();
    const std::size_t backlog_size = worker.backlog.size();
    const tripoint_bub_ms destination{ 64, 60, 0 };
    requirement_failure_reasons failures;

    for( int turn = 0; turn < 110; ++turn ) {
        worker.set_moves( turn % 2 == 0 ? 0 : -1 );
        player_activity current = worker.activity;
        const std::optional<bool> routed = multi_activity_actor::route(
                                               worker, current, destination, failures, false );
        REQUIRE( routed.has_value() );
        REQUIRE( *routed );
        REQUIRE( worker.backlog.size() == backlog_size );
        REQUIRE( worker.activity.id() == original );
        REQUIRE_FALSE( worker.has_destination() );
    }

    // Once moves are available, the same task can start travelling normally.
    worker.set_moves( 100 );
    player_activity current = worker.activity;
    const std::optional<bool> routed = multi_activity_actor::route(
                                           worker, current, destination, failures, false );
    REQUIRE( routed.has_value() );
    CHECK( *routed );
    CHECK( worker.has_destination() );
    CHECK( worker.backlog.size() == backlog_size );
}
