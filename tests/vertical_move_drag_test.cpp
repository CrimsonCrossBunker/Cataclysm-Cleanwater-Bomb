#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "npc.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "vertical_movement.h"

TEST_CASE( "vertical_movement_preserves_drag_choice_cancellation", "[movement][vertical][drag]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms( 30, 30, 0 ) );
    const tripoint_bub_ms origin( 60, 60, 2 );
    const tripoint_bub_ms destination = origin + tripoint::below;
    here.ter_set( origin, ter_id( "t_stairs_down" ) );
    here.ter_set( destination, ter_id( "t_stairs_up" ) );
    npc &who = spawn_npc( origin.xy(), "test_talker" );
    who.setpos( here, origin, false );
    who.set_moves( 1000 );
    who.grab( object_type::FURNITURE, tripoint_rel_ms::east );
    const bool supplied_choices = GENERATE( false, true );
    const std::string direction = GENERATE( "cancel", "zero", "vertical", "too_far" );
    CAPTURE( supplied_choices, direction );
    vertical_move_choices choices;
    choices.landing = here.get_abs( destination );
    if( direction == "zero" ) {
        choices.drag_direction = tripoint_rel_ms::zero;
    } else if( direction == "vertical" ) {
        choices.drag_direction = tripoint_rel_ms::above;
    } else if( direction == "too_far" ) {
        choices.drag_direction = tripoint_rel_ms( 2, 0, 0 );
    }
    g->vertical_move( who, -1, false, false, supplied_choices ? &choices : nullptr );
    REQUIRE( who.pos_bub() == destination );
    CHECK( who.get_moves() == 900 );
    const bool cancelled = !supplied_choices || direction == "cancel";
    CHECK( who.get_grab_type() == ( cancelled ? object_type::NONE : object_type::FURNITURE ) );
    CHECK( who.grab_point == ( cancelled ? tripoint_rel_ms::zero :
                               tripoint_rel_ms( 1, 0, 1 ) ) );
}
