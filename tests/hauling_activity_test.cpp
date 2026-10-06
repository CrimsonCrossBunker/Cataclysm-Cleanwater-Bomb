#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "map_iterator.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"

static const itype_id itype_test_rock( "test_rock" );

TEST_CASE( "hauling_keeps_one_location_per_item", "[activity][hauling]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    restore_on_out_of_scope restore_haul_list( you.haul_list );
    const tripoint_bub_ms pos = you.pos_bub();
    item &rock = here.add_item_or_charges( pos, item( itype_test_rock, calendar::turn ) );
    const item_location location( map_cursor( pos ), &rock );

    you.haul_list = { location, location };
    CHECK_FALSE( you.trim_haul_list( here.get_haulable_items( pos ) ) );
    REQUIRE( you.haul_list.size() == 1 );
    CHECK( you.haul_list.front() == location );
}

TEST_CASE( "autohauling_skips_a_target_already_moved", "[activity][hauling]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    restore_on_out_of_scope restore_haul_list( you.haul_list );
    const tripoint_bub_ms dest = you.pos_bub();
    const tripoint_bub_ms src = dest + tripoint_rel_ms::west;
    item &rock = here.add_item_or_charges( src, item( itype_test_rock, calendar::turn ) );
    const item_location location( map_cursor( src ), &rock );

    you.haul_list.clear();
    you.set_moves( 100000 );
    player_activity activity( move_items_activity_actor( { location, location }, { 0, 0 },
            false, tripoint_rel_ms::zero, true ) );
    CHECK( capture_debugmsg_during( [&]() {
        activity.do_turn( you );
    } ).empty() );
    CHECK( here.get_haulable_items( src ).empty() );
    CHECK( here.get_haulable_items( dest ).size() == 1 );
}
