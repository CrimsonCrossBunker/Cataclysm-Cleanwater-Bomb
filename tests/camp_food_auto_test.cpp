#include <string>

#include "basecamp.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "debug.h"
#include "faction.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "npc.h"
#include "npctalk.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "point.h"
#include "stomach.h"
#include "type_id.h"

TEST_CASE( "automatic_food_distribution_uses_an_accessible_camp", "[camp][npc]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    npc trader;
    trader.set_fac( faction_id( "free_merchants" ) );
    const tripoint_bub_ms location( 60, 60, 0 );
    trader.setpos( here, location );
    const tripoint_abs_omt own_pos = trader.pos_abs_omt();
    const tripoint_abs_omt other_pos = own_pos + tripoint_rel_omt( -2, -2, 0 );
    basecamp other_camp( "other camp", other_pos );
    other_camp.set_owner( faction_id( "your_followers" ) );
    REQUIRE_FALSE( other_camp.allowed_access_by( trader ) );
    overmap_buffer.add_camp( other_camp );
    const on_out_of_scope cleanup( [&own_pos, &other_pos]() {
        overmap_buffer.remove_camp( own_pos.xy() );
        overmap_buffer.remove_camp( other_pos.xy() );
    } );
    bool accessible = false;
    SECTION( "nearby_unrelated_camp_does_not_hide_the_traders_camp" ) {
        basecamp own_camp( "merchant camp", own_pos );
        own_camp.set_owner( trader.get_fac_id() );
        overmap_buffer.add_camp( own_camp );
        accessible = true;
    }
    SECTION( "no_authorized_camp_keeps_the_food" ) {
    }
    faction &owner = *trader.get_faction();
    owner.empty_food_supply();
    here.add_item( location, item( itype_id( "test_100_kcal" ) ) );
    const std::string diagnostics = capture_debugmsg_during( [&trader]() {
        talk_function::distribute_food_auto( trader );
    } );
    CHECK( diagnostics.empty() );
    CHECK( owner.food_supply().kcal() == ( accessible ? 100 : 0 ) );
    CHECK( here.i_at( location ).empty() == accessible );
}

