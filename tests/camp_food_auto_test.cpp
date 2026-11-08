#include <functional>
#include <string>

#include "basecamp.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "clzones.h"
#include "coordinates.h"
#include "debug.h"
#include "faction.h"
#include "game.h"
#include "item.h"
#include "map.h"
#include "map_helpers.h"
#include "npc.h"
#include "npctalk.h"
#include "overmapbuffer.h"
#include "pimpl.h"
#include "player_helpers.h"
#include "point.h"
#include "stomach.h"
#include "type_id.h"

static const faction_id faction_free_merchants( "free_merchants" );
static const faction_id faction_tacoma_commune( "tacoma_commune" );
static const faction_id faction_your_followers( "your_followers" );
static const itype_id itype_test_100_kcal( "test_100_kcal" );

static const zone_type_id zone_type_CAMP_FOOD( "CAMP_FOOD" );

TEST_CASE( "automatic_food_distribution_uses_an_accessible_camp", "[camp][npc]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    npc trader;
    trader.set_fac( faction_free_merchants );
    const tripoint_bub_ms location( 60, 60, 0 );
    trader.setpos( here, location );
    const tripoint_abs_omt own_pos = trader.pos_abs_omt();
    const tripoint_abs_omt other_pos = own_pos + tripoint_rel_omt( -2, -2, 0 );
    basecamp other_camp( "other camp", other_pos );
    other_camp.set_owner( faction_your_followers );
    REQUIRE_FALSE( other_camp.allowed_access_by( trader ) );
    overmap_buffer.add_camp( other_camp );
    const on_out_of_scope cleanup( [&own_pos, &other_pos]() {
        overmap_buffer.remove_camp( own_pos.xy() );
        overmap_buffer.remove_camp( other_pos.xy() );
    } );
    bool accessible = false;
    faction_id recipient = trader.get_fac_id();
    SECTION( "nearby_unrelated_camp_does_not_hide_the_traders_camp" ) {
        basecamp own_camp( "merchant camp", own_pos );
        own_camp.set_owner( trader.get_fac_id() );
        overmap_buffer.add_camp( own_camp );
        accessible = true;
    }
    SECTION( "no_authorized_camp_keeps_the_food" ) {
    }
    SECTION( "allied_camp_receives_food_using_its_own_zones" ) {
        recipient = faction_tacoma_commune;
        basecamp allied_camp( "allied camp", own_pos );
        allied_camp.set_owner( recipient );
        REQUIRE( allied_camp.allowed_access_by( trader ) );
        overmap_buffer.add_camp( allied_camp );
        accessible = true;
    }
    faction &owner = *g->faction_manager_ptr->get( recipient );
    owner.empty_food_supply();
    trader.get_faction()->empty_food_supply();
    zone_manager &zones = zone_manager::get_manager();
    const tripoint_abs_ms existing_zone = here.get_abs( location + tripoint::east );
    REQUIRE( zones.add( "existing camp food", zone_type_CAMP_FOOD, recipient, false, true,
                        existing_zone, existing_zone ) );
    const on_out_of_scope cleanup_zones( [&zones]() {
        zones.clear();
    } );
    here.add_item( location, item( itype_test_100_kcal ) );
    const std::string diagnostics = capture_debugmsg_during( [&trader]() {
        talk_function::distribute_food_auto( trader );
    } );
    CHECK( diagnostics.empty() );
    CHECK( owner.food_supply().kcal() == ( accessible ? 100 : 0 ) );
    CHECK( here.i_at( location ).empty() == accessible );
    CHECK( zones.get_zones( recipient ).size() == 1 );
    if( recipient != trader.get_fac_id() ) {
        CHECK( trader.get_faction()->food_supply().kcal() == 0 );
    }
}

