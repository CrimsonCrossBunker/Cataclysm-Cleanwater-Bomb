#include <sstream>
#include <string>

#include "action.h"
#include "active_item_cache.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "clzones.h"
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
    const vertical_move_prompt return_prompt = make_vertical_move_prompt( who, here, -1 );
    REQUIRE( return_prompt.options.size() == 1 );
    REQUIRE( execute_vertical_move( who, here, return_prompt.options.front().selection ) );
    CHECK( who.pos_abs() == here.get_abs( lower ) );
    CHECK( who.in_vehicle );
    here.unboard_vehicle( who.pos_bub( here ) );

    veh.remove_part( veh.part( stairs ) );
    veh.part_removal_cleanup( here );
    CHECK_FALSE( veh.deck_transition( here, lower, 1 ).has_value() );
    CHECK_FALSE( can_interact_at( ACTION_MOVE_UP, here, lower ) );
    CHECK_FALSE( can_interact_at( ACTION_MOVE_DOWN, here, upper ) );
}

TEST_CASE( "double_decker_rv_has_usable_stairs", "[vehicle][decks]" )
{
    clear_map_without_vision();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vproto_id( "rv_double_decker" ), tripoint_bub_ms( 60, 60, 0 ),
                                     90_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    const tripoint_bub_ms lower = veh->mount_to_tripoint( &here, tripoint_rel_ms( -2, 1, 0 ) );
    const tripoint_bub_ms upper = veh->mount_to_tripoint( &here, tripoint_rel_ms( -2, 1, 1 ) );
    CHECK( veh->deck_transition( here, lower, 1 ) == upper );
    CHECK( veh->deck_transition( here, upper, -1 ) == lower );
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
    // The containing submap supplies the vehicle's absolute origin when loading.
    loaded.set_submap_moved( &here, project_to<coords::sm>( veh.pos_bub( here ) ) );
    CHECK( loaded.part( 0 ).mount_level == 0 );
    CHECK( loaded.part( 1 ).mount_level == 1 );
    CHECK( loaded.abs_part_pos( 1 ) == veh.abs_part_pos( 1 ) );
    CHECK_FALSE( veh.can_unmount( veh.part( 0 ) ).success() );
}

TEST_CASE( "vehicle_deck_zones_follow_their_cargo", "[vehicle][decks][zones][save]" )
{
    clear_avatar();
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    veh.set_owner( get_avatar() );
    const int upper = veh.install_part( here, tripoint_rel_ms::above, vpart_id( "trunk" ) );
    REQUIRE( upper >= 0 );
    bool lower_cargo = false;
    SECTION( "cargo_only_upstairs" ) {}
    SECTION( "stacked_cargo" ) {
        REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "trunk" ) ) >= 0 );
        lower_cargo = true;
    }
    here.add_vehicle_to_cache( &veh );
    const auto add_zone = [&]( const tripoint_rel_ms &mount ) {
        const tripoint_abs_ms pos = veh.mount_to_tripoint_abs( mount );
        REQUIRE( zones.add( "Cargo", zone_type_id( "LOOT_FOOD" ), veh.get_owner(), false, true,
                            pos, pos, nullptr, true, &here ) != nullptr );
    };
    add_zone( tripoint_rel_ms::above );
    if( lower_cargo ) {
        add_zone( tripoint_rel_ms::zero );
    }
    REQUIRE( veh.loot_zones.count( tripoint_rel_ms::above ) == 1 );
    CHECK( here.get_vehicle_zones( 0 ).size() == ( lower_cargo ? 1 : 0 ) );
    REQUIRE( here.get_vehicle_zones( 1 ).size() == 1 );

    REQUIRE( here.displace_vehicle( veh, tripoint_rel_ms::east ) );
    REQUIRE( here.check_vehicle_zones( 1 ) );
    const auto upstairs = here.get_vehicle_zones( 1 );
    REQUIRE( upstairs.size() == 1 );
    CHECK( upstairs.front()->get_start_point() == veh.abs_part_pos( upper ) );
    CHECK( here.get_vehicle_zones( 0 ).size() == ( lower_cargo ? 1 : 0 ) );

    std::ostringstream buffer;
    JsonOut out( buffer );
    veh.serialize( out );
    vehicle loaded{ vproto_id() };
    loaded.deserialize( json_loader::from_string( buffer.str() ).get_object() );
    loaded.set_submap_moved( &here, project_to<coords::sm>( veh.pos_bub( here ) ) );
    loaded.zones_dirty = true;
    REQUIRE( loaded.refresh_zones() );
    REQUIRE( loaded.loot_zones.count( tripoint_rel_ms::above ) == 1 );
    CHECK( loaded.loot_zones.find( tripoint_rel_ms::above )->second.get_start_point() ==
           veh.abs_part_pos( upper ) );

    veh.remove_part( veh.part( upper ) );
    CHECK( veh.loot_zones.count( tripoint_rel_ms::above ) == 0 );
    CHECK( veh.loot_zones.count( tripoint_rel_ms::zero ) == ( lower_cargo ? 1 : 0 ) );
    zones.clear();
}

TEST_CASE( "vehicle_deck_cables_reconnect_and_disconnect_at_the_selected_port",
           "[vehicle][decks][power][save]" )
{
    clear_avatar();
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    const int lower = veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "dashboard" ) );
    const int upper = veh.install_part( here, tripoint_rel_ms::above, vpart_id( "dashboard" ) );
    REQUIRE( lower >= 0 );
    REQUIRE( upper >= 0 );
    here.add_vehicle_to_cache( &veh );
    item lower_cord( itype_id( "test_power_cord" ) );
    item upper_cord( itype_id( "test_power_cord" ) );
    REQUIRE( lower_cord.link_to( here.veh_at( veh.bub_part_pos( here, lower ) ),
                                link_state::vehicle_port ).success() );
    REQUIRE( upper_cord.link_to( here.veh_at( veh.bub_part_pos( here, upper ) ),
                                link_state::vehicle_port ).success() );
    CHECK( upper_cord.link().t_mount == tripoint_rel_ms::above );

    std::ostringstream buffer;
    JsonOut out( buffer );
    upper_cord.link().serialize( out );
    item loaded_cord( itype_id( "test_power_cord" ) );
    loaded_cord.link().deserialize( json_loader::from_string( buffer.str() ).get_object() );
    CHECK( loaded_cord.link().t_mount == tripoint_rel_ms::above );
    CHECK_FALSE( loaded_cord.link().t_veh );
    lower_cord.process( here, nullptr, veh.bub_part_pos( here, lower ) );
    loaded_cord.process( here, nullptr, veh.bub_part_pos( here, upper ) );
    CHECK( loaded_cord.link().t_veh.get() == &veh );
    CHECK( veh.part( upper ).has_flag( vp_flag::linked_flag ) );
    CHECK( veh.part( lower ).has_flag( vp_flag::linked_flag ) );

    veh.unlink_cables( here, tripoint_rel_ms::above, get_avatar(), true, false, false );
    CHECK_FALSE( veh.part( upper ).has_flag( vp_flag::linked_flag ) );
    CHECK( veh.part( lower ).has_flag( vp_flag::linked_flag ) );
    loaded_cord.process( here, nullptr, veh.bub_part_pos( here, upper ) );
    CHECK( loaded_cord.has_no_links() );
    CHECK_FALSE( lower_cord.has_no_links() );
}

TEST_CASE( "vehicle_deck_power_connections_install_on_the_selected_deck",
           "[vehicle][decks][power]" )
{
    vehicle &veh = make_deck_vehicle();
    map &here = get_map();
    REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, vpart_id( "dashboard" ) ) >= 0 );
    const int upper = veh.install_part( here, tripoint_rel_ms::above, vpart_id( "dashboard" ) );
    REQUIRE( upper >= 0 );
    vehicle *other = here.add_vehicle( vproto_id( "none" ), tripoint_bub_ms( 62, 60, 0 ),
                                      0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( other != nullptr );
    REQUIRE( other->install_part( here, tripoint_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const int port = other->install_part( here, tripoint_rel_ms::zero, vpart_id( "dashboard" ) );
    REQUIRE( port >= 0 );
    here.add_vehicle_to_cache( &veh );
    here.add_vehicle_to_cache( other );
    item cord( itype_id( "test_power_cord" ) );
    REQUIRE( cord.link_to( here.veh_at( veh.bub_part_pos( here, upper ) ),
                           here.veh_at( other->bub_part_pos( here, port ) ),
                           link_state::vehicle_port ).success() );
    const int cable = veh.part_with_feature( tripoint_rel_ms::above, "POWER_TRANSFER", false );
    REQUIRE( cable >= 0 );
    CHECK( veh.part_with_feature( tripoint_rel_ms::zero, "POWER_TRANSFER", false ) == -1 );
    const auto remote = veh.get_remote_part( here, veh.part( cable ) );
    REQUIRE( remote.has_value() );
    CHECK( &remote->vehicle() == other );
    CHECK( remote->part().target.first == veh.abs_part_pos( upper ) );
    const item detached = other->part_to_item( here, remote->part() );
    CHECK( detached.link().t_mount == tripoint_rel_ms::above );
    CHECK( detached.link().t_veh.get() == &veh );
}

TEST_CASE( "vehicle_deck_cable_loads_legacy_mount_as_deck_zero", "[vehicle][decks][save]" )
{
    item::link_data link;
    link.deserialize( json_loader::from_string( R"({"link_t_mount":[2,3]})" ).get_object() );
    CHECK( link.t_mount == tripoint_rel_ms( 2, 3, 0 ) );
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
    const int char_page = down ? KEY_NPAGE : KEY_PPAGE;
    const int code_page = down ? keycode::npage : keycode::ppage;
    CHECK( ctxt.input_to_action( input_event( { keymod_t::ctrl }, char_page,
                                 input_event_t::keyboard_char ) ) == action );
    CHECK( ctxt.input_to_action( input_event( { keymod_t::ctrl }, code_page,
                                 input_event_t::keyboard_code ) ) == action );
    CHECK( ctxt.input_to_action( input_event( { keymod_t::shift }, down ? '.' : ',',
                                 input_event_t::keyboard_code ) ) ==
           ( down ? "DESC_LIST_DOWN" : "DESC_LIST_UP" ) );
    CHECK( ctxt.input_to_action( input_event( code_page,
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
    const vpart_id trunk( "trunk" );
    REQUIRE( veh.install_part( here, tripoint_rel_ms::zero, trunk ) >= 0 );
    here.add_vehicle_to_cache( &veh );

    vehicle_activity_actor install( VEHICLE_INSTALL, 1_seconds, &veh, veh.abs_part_pos( 1 ),
                                    -tripoint_rel_ms::above, 1, trunk );
    player_activity installing( install );
    install.complete_vehicle( installing, you );
    const int upper = veh.part_with_feature( tripoint_rel_ms::above, "CARGO", true );
    REQUIRE( upper >= 0 );
    const int lower = veh.part_with_feature( tripoint_rel_ms::zero, "CARGO", true );
    REQUIRE( lower >= 0 );
    CHECK( upper != lower );

    vehicle_activity_actor remove( VEHICLE_REMOVE, 1_seconds, &veh, veh.abs_part_pos( upper ),
                                   -tripoint_rel_ms::above, upper, trunk );
    player_activity removing( remove );
    remove.complete_vehicle( removing, you );
    CHECK( veh.part_with_feature( tripoint_rel_ms::above, "CARGO", true ) == -1 );
    CHECK( veh.part_with_feature( tripoint_rel_ms::zero, "CARGO", true ) >= 0 );
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
