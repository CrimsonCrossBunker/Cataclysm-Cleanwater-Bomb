#include <memory>
#include <optional>
#include <utility>

#include "calendar.h"
#include "cata_catch.h"
#include "creature_tracker.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_destination_plan.h"
#include "point.h"
#include "rng.h"
#include "type_id.h"

TEST_CASE( "monster_destination_policy_uses_only_fixed_values", "[monster][destination_plan]" )
{
    const tripoint_abs_ms source{ 31, 34, 2 };
    const tripoint_abs_ms target{ 33, 31, 4 };
    const cata_default_random_engine engine = rng_get_engine();
    CHECK( propose_monster_destination( { source, target, true, false, 2 } ) == target );
    CHECK( !propose_monster_destination( { source, target, false, false, 2 } ) );
    CHECK( propose_monster_destination( { source, target, true, true, 1 } ) ==
           tripoint_abs_ms( 29, 37, 1 ) );
    CHECK( propose_monster_destination( { source, target, false, true, 3 } ) ==
           tripoint_abs_ms( 29, 37, 3 ) );
    CHECK( rng_get_engine() == engine );
}

TEST_CASE( "monster_destination_commit_is_single_use_and_owner_ordered",
           "[monster][destination_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &first_target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    monster &second_target = spawn_test_monster( "mon_zombie", { 50, 52, 0 } );
    source.unset_dest();
    monster_destination_plan first( source, first_target, here, true, false );
    monster_destination_plan second( source, second_target, here, true, false );
    const auto first_proposal = propose_monster_destination( first.view() );
    REQUIRE( first.commit( first_proposal, here ) );
    CHECK( source.get_dest() == first_target.pos_abs() );
    CHECK_FALSE( first.commit( first_proposal, here ) );
    CHECK_FALSE( second.commit( propose_monster_destination( second.view() ), here ) );
    CHECK( source.get_dest() == first_target.pos_abs() );
}

TEST_CASE( "monster_destination_rejects_changed_inputs_and_cancelled_receipts",
           "[monster][destination_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    source.unset_dest();
    monster_destination_plan plan( source, target, here, true, false );
    const auto proposal = propose_monster_destination( plan.view() );
    SECTION( "actor moved" ) {
        source.setpos( here, { 49, 50, 0 } );
    }
    SECTION( "target moved" ) {
        target.setpos( here, { 53, 50, 0 } );
    }
    SECTION( "move budget changed" ) {
        source.mod_moves( -1 );
    }
    SECTION( "policy changed" ) {
        ++source.morale;
    }
    SECTION( "turn advanced" ) {
        calendar::turn += 1_turns;
    }
    SECTION( "owner cancelled" ) {
        plan.cancel();
    }
    SECTION( "output does not match captured policy" ) {
        CHECK_FALSE( plan.commit( source.pos_abs(), here ) );
    }
    CHECK_FALSE( plan.commit( proposal, here ) );
    CHECK_FALSE( source.has_dest() );
}

TEST_CASE( "monster_destination_rejects_dead_removed_and_replaced_entities",
           "[monster][destination_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    source.unset_dest();
    monster_destination_plan plan( source, target, here, true, false );
    const auto proposal = propose_monster_destination( plan.view() );
    SECTION( "actor dead" ) {
        source.set_hp( 0 );
    }
    SECTION( "target dead" ) {
        target.set_hp( 0 );
    }
    SECTION( "actor removed but retained this turn" ) {
        get_creature_tracker().remove( source );
    }
    SECTION( "target removed but retained this turn" ) {
        get_creature_tracker().remove( target );
    }
    SECTION( "replacement at target position" ) {
        const tripoint_bub_ms position = target.pos_bub( here );
        get_creature_tracker().remove( target );
        spawn_test_monster( "mon_zombie", position );
    }
    CHECK_FALSE( plan.commit( proposal, here ) );
    CHECK_FALSE( source.has_dest() );
}

TEST_CASE( "monster_destination_receipt_survives_observed_entity_destruction",
           "[monster][destination_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    monster_destination_plan plan( source, target, here, true, false );
    const auto proposal = propose_monster_destination( plan.view() );
    clear_creatures();
    CHECK_FALSE( plan.commit( proposal, here ) );
}

TEST_CASE( "map_context_receipts_expire_on_destruction_and_context_replacement",
           "[map][destination_plan]" )
{
    safe_reference<map> destroyed;
    {
        auto storage = std::make_unique<map>();
        destroyed = storage->get_context_reference();
        REQUIRE( destroyed.get() == storage.get() );
    }
    CHECK_FALSE( destroyed );

    small_fake_map backing( ter_id( "t_floor" ) );
    map &storage = *backing.cast_to_map();
    const auto old = storage.get_context_reference();
    const tripoint_abs_sm origin = storage.get_abs_sub();
    storage.shift( point_rel_sm::zero );
    CHECK( old.get() == &storage );
    // A coordinate-context replacement retires receipts even if its numerical
    // origin is unchanged. This also covers the hook used by map::load.
    storage.vertical_shift( origin.z() );
    CHECK_FALSE( old );
    const auto fresh = storage.get_context_reference();
    CHECK( fresh.get() == &storage );
    CHECK( storage.get_abs_sub() == origin );
}

TEST_CASE( "monster_destination_rejects_map_context_replacement",
           "[monster][destination_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    source.unset_dest();
    monster_destination_plan plan( source, target, here, true, false );
    const auto proposal = propose_monster_destination( plan.view() );
    here.vertical_shift( here.get_abs_sub().z() );
    CHECK_FALSE( plan.commit( proposal, here ) );
    CHECK_FALSE( source.has_dest() );
    monster_destination_plan fresh( source, target, here, true, false );
    CHECK( fresh.commit( propose_monster_destination( fresh.view() ), here ) );
}

TEST_CASE( "map_move_assignment_retires_both_owner_contexts", "[map][destination_plan]" )
{
    auto source = std::make_unique<map>();
    auto destination = std::make_unique<map>();
    const auto source_reference = source->get_context_reference();
    const auto destination_reference = destination->get_context_reference();
    *destination = std::move( *source );
    CHECK_FALSE( source_reference );
    CHECK_FALSE( destination_reference );
    CHECK( destination->get_context_reference().get() == destination.get() );
}

TEST_CASE( "monster_destination_rechecks_flight_floor_inputs", "[monster][destination_plan]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms position{ 50, 50, 1 };
    monster &source = spawn_test_monster( "mon_bat", position );
    monster &target = spawn_test_monster( "mon_zombie", { 52, 50, 0 } );
    REQUIRE( source.flies() );
    source.unset_dest();
    monster_destination_plan aloft( source, target, here, false, true );
    REQUIRE( aloft.view().flee_z == 0 );
    here.ter_set( position, ter_id( "t_floor" ) );
    CHECK_FALSE( aloft.commit( propose_monster_destination( aloft.view() ), here ) );
    CHECK_FALSE( source.has_dest() );
    monster_destination_plan grounded( source, target, here, false, true );
    REQUIRE( grounded.view().flee_z == 2 );
    REQUIRE( grounded.commit( propose_monster_destination( grounded.view() ), here ) );
    CHECK( source.get_dest().z() == 2 );
}
