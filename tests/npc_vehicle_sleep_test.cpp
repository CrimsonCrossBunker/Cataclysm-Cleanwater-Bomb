#include <enums.h>
#include <initializer_list>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "map.h"
#include "map_helpers.h"
#include "npc.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

TEST_CASE( "following_npc_sleep_search_respects_moving_vehicle",
           "[npc][sleep][vehicle][upstream_ports]" )
{
    clear_map_without_vision();
    clear_avatar();
    const override_option npc_food( "NO_NPC_FOOD", "false" );
    map &here = get_map();
    avatar &player = get_avatar();
    const tripoint_bub_ms driver( 60, 60, 0 );
    const tripoint_bub_ms passenger( 61, 60, 0 );
    const tripoint_bub_ms bed( 63, 60, 0 );
    player.setpos( here, driver );
    npc &companion = spawn_npc( passenger.xy(), "test_talker" );
    clear_character( companion, true );
    companion.set_fac( faction_id( "your_followers" ) );
    companion.set_attitude( NPCATT_FOLLOW );
    REQUIRE( companion.is_walking_with() );
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), driver, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    for( const point_rel_ms &mount : {
             point_rel_ms( 0, 0 ), point_rel_ms( 1, 0 )
         } ) {
        REQUIRE( veh->install_part( here, mount, vpart_id( "frame" ) ) >= 0 );
        REQUIRE( veh->install_part( here, mount, vpart_id( "seat" ) ) >= 0 );
    }
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    here.board_vehicle( driver, &player );
    here.board_vehicle( passenger, &companion );
    REQUIRE( player.in_vehicle );
    REQUIRE( companion.in_vehicle );
    REQUIRE_FALSE( player.in_sleep_state() );
    here.furn_set( bed, furn_id( "f_bed" ) );
    here.build_map_cache( 0 );

    const bool moving = GENERATE( false, true );
    veh->velocity = moving ? 1000 : 0;
    const auto candidates = companion.find_sleep_candidates();
    REQUIRE_FALSE( candidates.empty() );
    CHECK( candidates.front().target == here.get_abs( moving ? passenger : bed ) );
    if( moving ) {
        for( const auto &candidate : candidates ) {
            CHECK( candidate.target == here.get_abs( passenger ) );
        }
    }
    here.unboard_vehicle( driver );
    here.unboard_vehicle( passenger );
}
