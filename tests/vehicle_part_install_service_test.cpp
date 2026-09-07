#include <memory>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "npc.h"
#include "npctalk.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "veh_interact.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"

static const efftype_id effect_currently_busy( "currently_busy" );

static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_horn_bicycle( "horn_bicycle" );

static const ter_str_id ter_t_wall( "t_wall" );

static const vpart_id vpart_foot_pedals( "foot_pedals" );
static const vpart_id vpart_frame( "frame" );
static const vpart_id vpart_horn_bicycle( "horn_bicycle" );

static const vproto_id vehicle_prototype_none( "none" );

namespace
{
struct installation_service_fixture {
    map &here = get_map();
    avatar &player = get_avatar();
    npc *mechanic = nullptr;
    vehicle *target = nullptr;
    std::vector<point_rel_ms> selected_mounts;

    installation_service_fixture() {
        clear_avatar();
        clear_map_without_vision();
        clear_npcs();
        player.setpos( here, tripoint_bub_ms( 60, 60, 0 ) );
        player.wear_item( item( itype_debug_backpack ) );
        mechanic = &spawn_npc( point_bub_ms( 61, 60 ), "thug" );
        clear_character( *mechanic );
        mechanic->wear_item( item( itype_debug_backpack ) );
        mechanic->op_of_u.owed = 0;
        mechanic->set_value( "vehicle_part_service_status", "working" );
        mechanic->add_effect( effect_currently_busy, 1_hours );
        target = here.add_vehicle( vehicle_prototype_none, tripoint_bub_ms( 64, 60, 0 ),
                                   0_degrees, 0, veh_spawn_status::UNDAMAGED );
        REQUIRE( target != nullptr );
        REQUIRE( target->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
        REQUIRE( target->install_part( here, point_rel_ms::east, vpart_frame ) >= 0 );
        REQUIRE( target->install_part( here, point_rel_ms( 2, 0 ), vpart_frame ) >= 0 );
        target->set_owner( player );
        target->set_value( "vehicle_part_repair_target", "yes" );
        here.add_vehicle_to_cache( target );
        selected_mounts = veh_interact::service_installation_mounts( here, *target,
                          point_rel_ms::zero, point_rel_ms( 2, 0 ), vpart_horn_bicycle.obj() );
        const std::vector<point_rel_ms> expected_mounts = {
            point_rel_ms::zero, point_rel_ms::east, point_rel_ms( 2, 0 )
        };
        REQUIRE( selected_mounts == expected_mounts );
    }

    ~installation_service_fixture() {
        clear_npcs();
    }

    std::vector<vehicle_part_install_service_entry> entries() const {
        item supplied( itype_horn_bicycle );
        supplied.set_var( "service_test_source", "mechanic" );
        item owned( itype_horn_bicycle );
        owned.set_var( "service_test_source", "player" );
        // Only two parts are supplied for the three compatible selected mounts.
        return {
            { selected_mounts[0], supplied, true, 1200 },
            { selected_mounts[1], owned, false, 300 }
        };
    }

    vehicle_part_install_service_activity_actor order() const {
        return vehicle_part_install_service_activity_actor(
                   20_minutes, mechanic->getID(), target->pos_abs(),
                   talk_function::vehicle_service_state_snapshot( *target ), vpart_horn_bicycle,
                   entries(), vpart_horn_bicycle->variants.begin()->first, 90, false );
    }

    void check_refund( const std::string &status ) const {
        CHECK( mechanic->op_of_u.owed == 1500 );
        CHECK( mechanic->get_value( "vehicle_part_service_status" ).str() == status );
        CHECK_FALSE( mechanic->has_effect( effect_currently_busy ) );
        CHECK( character_has_item_with_var_val( *mechanic, "service_test_source", "mechanic" ) );
        CHECK_FALSE( character_has_item_with_var_val( *mechanic, "service_test_source", "player" ) );
        CHECK( character_has_item_with_var_val( player, "service_test_source", "player" ) );
        CHECK_FALSE( character_has_item_with_var_val( player, "service_test_source", "mechanic" ) );
        CHECK( mechanic->amount_of( itype_horn_bicycle ) == 1 );
        CHECK( player.amount_of( itype_horn_bicycle ) == 1 );
    }
};

std::unique_ptr<activity_actor> reload_installation_order( const activity_actor &actor )
{
    std::ostringstream buffer;
    JsonOut jsout( buffer );
    actor.serialize( jsout );
    JsonValue data = json_loader::from_string( buffer.str() );
    return vehicle_part_install_service_activity_actor::deserialize( data );
}
} // namespace

TEST_CASE( "vehicle_installation_service_completes_a_batch",
           "[vehicle][activity][vehicle_service]" )
{
    installation_service_fixture f;
    const int original_count = f.target->part_count();
    std::unique_ptr<activity_actor> actor = f.order().clone();
    SECTION( "without_reloading" ) {
    }
    SECTION( "after_save_and_reload" ) {
        actor = reload_installation_order( *actor );
    }
    player_activity act;
    actor->start( act, f.player );
    CHECK( act.moves_total == to_moves<int>( 20_minutes ) );
    actor->finish( act, f.player );
    CHECK( f.target->part_count() == original_count + 2 );
    for( const vehicle_part_install_service_entry &entry : f.entries() ) {
        const int index = f.target->part_with_feature( entry.mount, "HORN", false );
        REQUIRE( index >= 0 );
        CHECK( f.target->part( index ).info().id == vpart_horn_bicycle );
        CHECK( f.target->part( index ).direction == 90_degrees );
        CHECK( f.target->part( index ).variant == vpart_horn_bicycle->variants.begin()->first );
    }
    CHECK( f.target->parts_at_relative( f.selected_mounts.back(), false ).size() == 1 );
    CHECK( f.target->part_with_feature( f.selected_mounts.back(), "HORN", false ) < 0 );
    CHECK( f.mechanic->get_value( "vehicle_part_service_status" ).str() == "complete" );
    CHECK_FALSE( f.mechanic->has_effect( effect_currently_busy ) );
    CHECK( f.mechanic->op_of_u.owed == 0 );
    // Completion remains settled across a save; neither cancellation nor another
    // finish may refund or manufacture the installed parts.
    actor = reload_installation_order( *actor );
    actor->canceled( act, f.player );
    actor->finish( act, f.player );
    CHECK( f.mechanic->op_of_u.owed == 0 );
    CHECK( f.target->part_count() == original_count + 2 );
    CHECK( f.target->parts_at_relative( f.selected_mounts.back(), false ).size() == 1 );
    CHECK( f.player.amount_of( itype_horn_bicycle ) == 0 );
    CHECK( f.mechanic->amount_of( itype_horn_bicycle ) == 0 );
}

TEST_CASE( "vehicle_installation_service_refunds_each_source_once",
           "[vehicle][activity][vehicle_service]" )
{
    installation_service_fixture f;
    const int original_count = f.target->part_count();
    std::unique_ptr<activity_actor> actor = reload_installation_order( f.order() );
    player_activity act;
    actor->canceled( act, f.player );
    f.check_refund( "cancelled" );
    actor = reload_installation_order( *actor );
    actor->canceled( act, f.player );
    actor->finish( act, f.player );
    f.check_refund( "cancelled" );
    CHECK( f.target->part_count() == original_count );
    for( const point_rel_ms &mount : f.selected_mounts ) {
        CHECK( f.target->part_with_feature( mount, "HORN", false ) < 0 );
    }
}

TEST_CASE( "vehicle_installation_service_invalidates_the_entire_batch",
           "[vehicle][activity][vehicle_service]" )
{
    installation_service_fixture f;
    auto entries = f.entries();
    std::string snapshot = talk_function::vehicle_service_state_snapshot( *f.target );
    SECTION( "vehicle_changed_during_wait" ) {
        f.target->mod_hp( f.target->part( 0 ), -1 );
    }
    SECTION( "two_individually_valid_entries_conflict_at_the_same_mount" ) {
        entries[1].mount = entries[0].mount;
    }
    SECTION( "the_installation_location_became_blocked" ) {
        f.here.ter_set( f.target->bub_part_pos( f.here, 1 ), ter_t_wall );
    }
    const int original_count = f.target->part_count();
    vehicle_part_install_service_activity_actor actor(
        20_minutes, f.mechanic->getID(), f.target->pos_abs(), snapshot,
        vpart_horn_bicycle, entries, "", 0, false );
    player_activity act;
    actor.finish( act, f.player );
    f.check_refund( "invalidated" );
    CHECK( f.target->part_count() == original_count );
    actor.canceled( act, f.player );
    f.check_refund( "invalidated" );
}

TEST_CASE( "vehicle_installation_service_checks_joint_engine_restrictions",
           "[vehicle][activity][vehicle_service]" )
{
    installation_service_fixture f;
    std::vector<vehicle_part_install_service_entry> entries = {
        { point_rel_ms::zero, item( vpart_foot_pedals->base_item ), true, 100 },
        { point_rel_ms::east, item( vpart_foot_pedals->base_item ), true, 100 }
    };
    for( const vehicle_part_install_service_entry &entry : entries ) {
        REQUIRE_FALSE( veh_interact::service_installation_denial(
                           *f.target, entry.mount, vpart_foot_pedals.obj() ) );
    }
    const std::string original = talk_function::vehicle_service_state_snapshot( *f.target );
    CHECK_FALSE( vehicle_part_install_service_activity_actor::can_install_order(
                     f.here, *f.target, vpart_foot_pedals, entries ) );
    CHECK( talk_function::vehicle_service_state_snapshot( *f.target ) == original );
    CHECK( &f.here.veh_at( f.target->pos_abs() )->vehicle() == f.target );
    entries.pop_back();
    CHECK( vehicle_part_install_service_activity_actor::can_install_order(
               f.here, *f.target, vpart_foot_pedals, entries ) );
}

TEST_CASE( "vehicle_installation_service_loads_legacy_single_part_orders",
           "[vehicle][activity][vehicle_service]" )
{
    installation_service_fixture f;
    std::ostringstream buffer;
    JsonOut jsout( buffer );
    jsout.start_object();
    jsout.member( "mechanic_id", f.mechanic->getID() );
    jsout.member( "install_time", 10_minutes );
    jsout.member( "vehicle_pos", f.target->pos_abs() );
    jsout.member( "vehicle_snapshot", talk_function::vehicle_service_state_snapshot( *f.target ) );
    jsout.member( "mount", point_rel_ms::zero );
    jsout.member( "part_id", vpart_horn_bicycle );
    jsout.member( "reserved_part", item( itype_horn_bicycle ) );
    jsout.member( "supplied_by_mechanic", false );
    jsout.member( "paid_cost", 300 );
    jsout.member( "variant", "" );
    jsout.member( "direction_degrees", 0 );
    jsout.member( "disable_flyable", false );
    jsout.end_object();
    JsonValue data = json_loader::from_string( buffer.str() );
    std::unique_ptr<activity_actor> actor =
        vehicle_part_install_service_activity_actor::deserialize( data );
    player_activity act;
    SECTION( "finishes_the_original_order" ) {
        actor->finish( act, f.player );
        CHECK( f.target->part_with_feature( point_rel_ms::zero, "HORN", false ) >= 0 );
        CHECK( f.mechanic->op_of_u.owed == 0 );
    }
    SECTION( "refunds_the_original_order" ) {
        actor->canceled( act, f.player );
        actor->canceled( act, f.player );
        CHECK( f.mechanic->op_of_u.owed == 300 );
        CHECK( f.player.amount_of( itype_horn_bicycle ) == 1 );
    }
}
