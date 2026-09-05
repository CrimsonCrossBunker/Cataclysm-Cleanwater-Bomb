#include <vector>

#include "activity_actor_definitions.h"
#include "activity_handlers.h"
#include "avatar.h"
#include "cata_catch.h"
#include "character_attire.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "pickup.h"
#include "player_helpers.h"
#include "type_id.h"

TEST_CASE( "zone_disassembly_releases_reservation_on_cancel", "[activities][zones][reservation]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.name = "Reservation test";
    map &here = get_map();
    const tripoint_bub_ms pos = you.pos_bub( here );
    item &target = here.add_item_or_charges( pos, item( itype_id( "sheet" ) ) );
    REQUIRE( target.is_disassemblable() );
    you.i_add( item( itype_id( "scissors" ) ) );
    multi_disassemble_activity_actor actor;
    you.assign_activity( actor );
    actor.multi_activity_can_do( you, pos );
    REQUIRE( target.get_var( "activity_var" ) == you.name );
    you.cancel_activity();
    CHECK_FALSE( target.has_var( "activity_var" ) );
    CHECK( you.may_activity_occupancy_after_end_items_loc.empty() );
    you.backlog.clear();
}

TEST_CASE( "pickup_releases_legacy_own_reservation", "[activities][zones][reservation]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.name = "Reservation test";
    you.wear_item( item( itype_id( "backpack" ) ), false );
    map &here = get_map();
    const tripoint_bub_ms pos = you.pos_bub( here );
    item &target = here.add_item_or_charges( pos, item( itype_id( "hammer" ) ) );
    target.set_var( "activity_var", you.name );
    std::vector<item_location> targets{ item_location( map_cursor( pos ), &target ) };
    std::vector<int> quantities{ 0 };
    bool stashed = true;
    Pickup::pick_info info;
    you.set_moves( 1000 );
    REQUIRE( Pickup::do_pickup( targets, quantities, true, stashed, info ) );
    const auto hammers = you.cache_get_items_with( itype_id( "hammer" ) );
    REQUIRE( hammers.size() == 1 );
    CHECK_FALSE( hammers.front()->has_var( "activity_var" ) );
}
