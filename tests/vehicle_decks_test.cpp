#include <sstream>
#include <string>

#include "action.h"
#include "active_item_cache.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "input.h"
#include "input_context.h"
#include "input_enums.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "veh_interact.h"
#include "vehicle.h"
#include "vertical_movement.h"
#include "vpart_position.h"

namespace
{
vehicle &make_deck_vehicle()
{
    clear_map_without_vision();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), tripoint_bub_ms( 60, 60, 0 ),
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, tripoint_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    REQUIRE( veh->install_part( here, tripoint_rel_ms::above, vpart_id( "frame" ) ) >= 0 );
    return *veh;
}
} // namespace

TEST_CASE( "vehicle_decks_separate_stacked_components", "[vehicle][decks]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    const int lower = veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "trunk" ) );
    const int upper = veh.install_part( here, tripoint_rel_ms::above, vpart_id( "trunk" ) );
    REQUIRE( lower >= 0 );
    REQUIRE( upper >= 0 );
    for( const bool cached : {
             false, true
         } ) {
        const auto downstairs = veh.parts_at_relative( tripoint_rel_ms::zero, cached );
        const auto upstairs = veh.parts_at_relative( tripoint_rel_ms::above, cached );
        REQUIRE( downstairs.size() == 2 );
        REQUIRE( upstairs.size() == 2 );
        CHECK( veh.part( downstairs.front() ).mount_level == 0 );
        CHECK( veh.part( upstairs.front() ).mount_level == 1 );
    }
    CHECK( veh.get_points().count( veh.abs_part_pos( lower ) ) == 1 );
    CHECK( veh.get_points().count( veh.abs_part_pos( upper ) ) == 1 );
    CHECK( veh.part_with_feature( lower, VPFLAG_CARGO, true ) == lower );
    CHECK( veh.part_with_feature( upper, VPFLAG_CARGO, true ) == upper );
    CHECK_FALSE( veh.can_mount( tripoint_rel_ms::above, vpart_id( "trunk" ).obj() ).success() );
    CHECK( veh.can_unmount( veh.part( upper ) ).success() );
    veh.remove_part( veh.part( upper ) );
    veh.part_removal_cleanup( here );
    CHECK( veh.part_with_feature( tripoint_rel_ms::zero, "CARGO", true ) >= 0 );
    CHECK( veh.part_with_feature( tripoint_rel_ms::above, "CARGO", true ) == -1 );
    CHECK( veh_interact::part_at_mount( veh, tripoint_rel_ms::above ) >= 0 );
    vpart_position( veh, 0 ).set_label( "lower" );
    vpart_position( veh, 1 ).set_label( "upper" );
    CHECK( vpart_position( veh, 0 ).get_label() == "lower" );
    CHECK( vpart_position( veh, 1 ).get_label() == "upper" );
}

TEST_CASE( "opening_a_deck_door_keeps_the_other_deck_closed", "[vehicle][decks]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    const int lower = veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "door" ) );
    const int upper = veh.install_part( here, tripoint_rel_ms::above, vpart_id( "door" ) );
    REQUIRE( lower >= 0 );
    REQUIRE( upper >= 0 );
    REQUIRE_FALSE( veh.part( lower ).open );
    REQUIRE_FALSE( veh.part( upper ).open );

    veh.open_all_at( here, upper );
    CHECK( veh.part( upper ).open );
    CHECK_FALSE( veh.part( lower ).open );
}

TEST_CASE( "vehicle_deck_stairs_connect_only_the_same_vehicle", "[vehicle][decks]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "aisle" ) ) >= 0 );
    REQUIRE( veh.install_part( here, tripoint_rel_ms::above, vpart_id( "aisle" ) ) >= 0 );
    const int stairs = veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "deck_stairs" ) );
    REQUIRE( stairs >= 0 );
    here.add_vehicle_to_cache( &veh );
    const tripoint_bub_ms lower = veh.mount_to_tripoint( &here, tripoint_rel_ms::zero );
    const tripoint_bub_ms upper = veh.mount_to_tripoint( &here, tripoint_rel_ms::above );
    REQUIRE( veh.deck_transition( here, lower, 1 ).has_value() );
    CHECK( *veh.deck_transition( here, lower, 1 ) == upper );
    CHECK( veh.deck_transition( here, upper, -1 ) == lower );
    CHECK_FALSE( veh.deck_transition( here, lower, -1 ).has_value() );
    CHECK( here.valid_move( lower, upper, false, false ) );
    CHECK_FALSE( here.valid_move( lower, upper, false, true ) );
    CHECK( can_interact_at( ACTION_MOVE_UP, here, lower ) );
    CHECK( can_interact_at( ACTION_MOVE_DOWN, here, upper ) );

    clear_avatar();
    avatar &who = get_avatar();
    const tripoint_abs_ms expected_landing = here.get_abs( upper );
    who.setpos( here, lower, false );
    here.board_vehicle( lower, &who );
    REQUIRE( who.in_vehicle );
    const vertical_move_prompt prompt = make_vertical_move_prompt( who, here, 1 );
    REQUIRE( prompt.options.size() == 1 );
    CHECK( prompt.options.front().selection.target == here.get_abs( upper ) );
    REQUIRE( execute_vertical_move( who, here, prompt.options.front().selection ) );
    CHECK( who.pos_abs() == expected_landing );
    CHECK( who.in_vehicle );
    here.unboard_vehicle( who.pos_bub( here ) );

    veh.remove_part( veh.part( stairs ) );
    veh.part_removal_cleanup( here );
    CHECK_FALSE( veh.deck_transition( here, lower, 1 ).has_value() );
    CHECK_FALSE( can_interact_at( ACTION_MOVE_UP, here, lower ) );
    CHECK_FALSE( can_interact_at( ACTION_MOVE_DOWN, here, upper ) );
}

TEST_CASE( "vehicle_decks_preserve_height_when_turning_moving_and_loading",
           "[vehicle][decks][save]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    veh.precalc_mounts( 1, 90_degrees, point_rel_ms::zero );
    REQUIRE( here.displace_vehicle( veh, tripoint_rel_ms::east ) );
    CHECK( veh.abs_part_pos( 1 ).z() - veh.abs_part_pos( 0 ).z() == 1 );
    CHECK( veh.level_vehicle( here ) );
    CHECK( veh.abs_part_pos( 1 ).z() - veh.abs_part_pos( 0 ).z() == 1 );

    std::ostringstream buffer;
    JsonOut out( buffer );
    veh.serialize( out );
    vehicle loaded{ vproto_id() };
    loaded.deserialize( json_loader::from_string( buffer.str() ).get_object() );
    CHECK( loaded.part( 0 ).mount_level == 0 );
    CHECK( loaded.part( 1 ).mount_level == 1 );
    CHECK( loaded.abs_part_pos( 1 ) == veh.abs_part_pos( 1 ) );
    CHECK_FALSE( veh.can_unmount( veh.part( 0 ) ).success() );
}

TEST_CASE( "vehicle_deck_active_items_retain_their_level", "[vehicle][decks][item]" )
{
    item lower( itype_id( "firecracker_act" ), calendar::turn_zero,
                item::default_charges_tag() );
    item upper = lower;
    lower.activate();
    upper.activate();
    active_item_cache cache;
    REQUIRE( cache.add( lower, tripoint_rel_ms::zero ) );
    REQUIRE( cache.add( upper, tripoint_rel_ms::above ) );
    const auto active = cache.get();
    REQUIRE( active.size() == 2 );
    CHECK( active[0].location == active[1].location );
    CHECK( active[0].mount_level != active[1].mount_level );
}

TEST_CASE( "vehicle_deck_switch_bindings", "[vehicle][decks][input]" )
{
    input_context ctxt( "VEH_INTERACT", keyboard_mode::keycode );
    ctxt.register_action( "DESC_LIST_UP" );
    ctxt.register_action( "DESC_LIST_DOWN" );
    ctxt.register_action( "PAGE_UP" );
    ctxt.register_action( "PAGE_DOWN" );
    ctxt.register_action( "VEHICLE_DECK_UP" );
    ctxt.register_action( "VEHICLE_DECK_DOWN" );
    const bool down = GENERATE( false, true );
    const std::string action = down ? "VEHICLE_DECK_DOWN" : "VEHICLE_DECK_UP";
    for( const input_event_t type : {
             input_event_t::keyboard_char, input_event_t::keyboard_code
         } ) {
        CHECK( ctxt.input_to_action( input_event( { keymod_t::ctrl }, down ? KEY_NPAGE : KEY_PPAGE,
                                     type ) ) == action );
    }
    CHECK( ctxt.input_to_action( input_event( { keymod_t::shift }, down ? '.' : ',',
                                 input_event_t::keyboard_code ) ) ==
           ( down ? "DESC_LIST_DOWN" : "DESC_LIST_UP" ) );
    CHECK( ctxt.input_to_action( input_event( down ? KEY_NPAGE : KEY_PPAGE,
                                 input_event_t::keyboard_code ) ) == ( down ? "PAGE_DOWN" : "PAGE_UP" ) );
}

TEST_CASE( "vehicle_deck_modification_activities_keep_the_selected_deck",
           "[vehicle][decks][activity]" )
{
    clear_avatar();
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    avatar &you = get_avatar();
    you.set_mutation( trait_id( "DEBUG_HS" ) );
    you.setpos( here, veh.bub_part_pos( here, 0 ) );
    REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "aisle" ) ) >= 0 );
    here.add_vehicle_to_cache( &veh );

    vehicle_activity_actor install( VEHICLE_INSTALL, 1_seconds, &veh, veh.abs_part_pos( 1 ),
                                    -tripoint_rel_ms::above, 1, vpart_id( "aisle" ) );
    player_activity installing( install );
    install.complete_vehicle( installing, you );
    const int upper = veh.part_with_feature( tripoint_rel_ms::above, "AISLE", true );
    REQUIRE( upper >= 0 );
    const int lower = veh.part_with_feature( tripoint_rel_ms::zero, "AISLE", true );
    REQUIRE( lower >= 0 );
    CHECK( upper != lower );

    vehicle_activity_actor remove( VEHICLE_REMOVE, 1_seconds, &veh, veh.abs_part_pos( upper ),
                                   -tripoint_rel_ms::above, upper, vpart_id( "aisle" ) );
    player_activity removing( remove );
    remove.complete_vehicle( removing, you );
    CHECK( veh.part_with_feature( tripoint_rel_ms::above, "AISLE", true ) == -1 );
    CHECK( veh.part_with_feature( tripoint_rel_ms::zero, "AISLE", true ) >= 0 );
    clear_avatar();
}

TEST_CASE( "vehicle_deck_turret_activity_requires_a_mount_on_the_same_deck",
           "[vehicle][decks][activity][turret]" )
{
    clear_avatar();
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    avatar &you = get_avatar();
    you.set_mutation( trait_id( "DEBUG_HS" ) );
    you.setpos( here, veh.bub_part_pos( here, 0 ) );
    REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "turret_mount" ) ) >= 0 );
    const vpart_id turret( "turret_mossberg_930" );
    REQUIRE( turret.is_valid() );
    REQUIRE_FALSE( veh.can_mount( tripoint_rel_ms::above, turret.obj() ).success() );
    const bool upper_mount = GENERATE( false, true );
    if( upper_mount ) {
        REQUIRE( veh.install_part( here, tripoint_rel_ms::above, vpart_id( "turret_mount" ) ) >= 0 );
    }
    here.add_vehicle_to_cache( &veh );
    const int count_before = veh.part_count();
    vehicle_activity_actor install( VEHICLE_INSTALL, 1_seconds, &veh, veh.abs_part_pos( 1 ),
                                    -tripoint_rel_ms::above, 1, turret );
    player_activity installing( install );
    install.complete_vehicle( installing, you );
    CHECK( veh.part_count() == count_before + ( upper_mount ? 1 : 0 ) );
    CHECK( ( veh.part_with_feature( tripoint_rel_ms::above, "TURRET", true ) >= 0 ) == upper_mount );
    CHECK( veh.part_with_feature( tripoint_rel_ms::zero, "TURRET", true ) == -1 );
    clear_avatar();
}
