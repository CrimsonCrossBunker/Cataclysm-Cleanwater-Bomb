#include <activity_actor.h>
#include <bodypart.h>
#include <cata_utility.h>
#include <character_id.h>
#include <clone_ptr.h>
#include <coordinates.h>
#include <point.h>
#include <cstdint>
#include <functional>
#include <list>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "damage.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_uid.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "pet_inventory_ui.h"
#include "pet_slot.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"

static const damage_type_id damage_bash( "bash" );

static const efftype_id effect_ridden( "ridden" );

static const itype_id itype_anvil( "anvil" );
static const itype_id itype_aspirin( "aspirin" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_padded_armor_horse( "padded_armor_horse" );
static const itype_id itype_rock( "rock" );

static const mtype_id mon_horse( "mon_horse" );

static const pet_slot_id pet_slot_armor( "armor" );
static const pet_slot_id pet_slot_storage( "storage" );

TEST_CASE( "loaded_backpack_can_be_installed_on_a_horse", "[monster][pet_equipment]" )
{
    clear_avatar();
    avatar &rider = get_avatar();
    monster horse( mon_horse );
    item bag( itype_backpack );
    item cargo( itype_rock );
    cargo.set_var( "cargo_marker", "keep" );
    REQUIRE( bag.put_in( cargo, pocket_type::CONTAINER ).success() );
    const units::mass loaded_weight = bag.weight();
    item_location source = rider.i_add( bag );

    REQUIRE( pet_inventory_ui::install_equipment( rider, horse, pet_slot_storage,
             source ).success() );
    CHECK_FALSE( source );
    const item *installed = horse.get_pet_storage();
    REQUIRE( installed != nullptr );
    CHECK( installed->weight() == loaded_weight );
    const auto contents = installed->all_items_top( pocket_type::CONTAINER );
    REQUIRE( contents.size() == 1 );
    CHECK( contents.front()->get_var( "cargo_marker" ) == "keep" );
    CHECK( horse.get_carried_weight() == loaded_weight );
}

TEST_CASE( "failed_horse_equipment_installation_keeps_loaded_bag", "[monster][pet_equipment]" )
{
    clear_avatar();
    avatar &rider = get_avatar();
    monster horse( mon_horse );
    while( horse.get_carried_weight() <= horse.weight_capacity() ) {
        horse.add_item( item( itype_anvil ) );
    }
    item bag( itype_backpack );
    REQUIRE( bag.put_in( item( itype_rock ), pocket_type::CONTAINER ).success() );
    item_location source = rider.i_add( bag );
    const units::mass original_weight = source->weight();
    const int original_moves = rider.get_moves();

    CHECK_FALSE( pet_inventory_ui::install_equipment( rider, horse, pet_slot_storage,
                 source ).success() );
    REQUIRE( source );
    CHECK( source->weight() == original_weight );
    CHECK( rider.get_moves() == original_moves );
    CHECK( horse.get_pet_storage() == nullptr );
}

TEST_CASE( "mounted_equipment_transfer_does_not_double_count_the_rider",
           "[monster][pet_equipment]" )
{
    clear_avatar();
    avatar &rider = get_avatar();
    monster horse( mon_horse );
    horse.mounted_player = &rider;
    horse.add_effect( effect_ridden, 1_turns, true );
    item bag( itype_backpack );
    REQUIRE( bag.put_in( item( itype_rock ), pocket_type::CONTAINER ).success() );
    item_location source = rider.i_add( bag );
    const units::mass before = horse.get_load_weight();
    CHECK( before == horse.get_carried_weight() + rider.get_weight() );

    REQUIRE( pet_inventory_ui::install_equipment( rider, horse, pet_slot_storage,
             source ).success() );
    CHECK( horse.get_load_weight() == before );
    CHECK( horse.get_load_weight( &rider ) == before );
}

TEST_CASE( "horse_overmap_markers_follow_identity_and_survive_saving", "[monster][overmap][save]" )
{
    clear_avatar();
    avatar &rider = get_avatar();
    restore_on_out_of_scope restore_markers( overmap_buffer.global_state.tracked_pets );
    overmap_buffer.global_state.tracked_pets.clear();
    monster horse( mon_horse );
    horse.friendly = -1;
    horse.unique_name = "Comet";
    overmap_buffer.update_tracked_pet( horse, rider );
    const int64_t uid = horse.uid().get_value();
    REQUIRE( overmap_buffer.has_tracked_pet( horse.pos_abs_omt() ) );
    auto markers = overmap_buffer.get_tracked_pets( horse.pos_abs_omt() );
    REQUIRE( markers.size() == 1 );
    CHECK( markers.front().uid == uid );
    CHECK( markers.front().name == horse.get_name() );

    horse.unique_name = "Cloud";
    overmap_buffer.update_tracked_pet( horse, rider );
    REQUIRE( overmap_buffer.global_state.tracked_pets.size() == 1 );
    CHECK( overmap_buffer.global_state.tracked_pets.front().name == horse.get_name() );

    overmap_global_state loaded;
    deserialize_wrapper( [&loaded]( const JsonValue & value ) {
        loaded.deserialize( value.get_object() );
    }, serialize( overmap_buffer.global_state ) );
    REQUIRE( loaded.tracked_pets.size() == 1 );
    CHECK( loaded.tracked_pets.front().uid == uid );
    CHECK( loaded.tracked_pets.front().owner == rider.getID() );
    CHECK( loaded.tracked_pets.front().position == horse.pos_abs_omt() );

    horse.set_value( "hide_overmap_marker", "yes" );
    overmap_buffer.update_tracked_pet( horse, rider );
    CHECK_FALSE( overmap_buffer.has_tracked_pet( horse.pos_abs_omt() ) );
    horse.set_value( "hide_overmap_marker", "no" );
    overmap_buffer.update_tracked_pet( horse, rider );
    REQUIRE( overmap_buffer.has_tracked_pet( horse.pos_abs_omt() ) );
    horse.friendly = 0;
    overmap_buffer.update_tracked_pet( horse, rider );
    CHECK_FALSE( overmap_buffer.has_tracked_pet( horse.pos_abs_omt() ) );
}

TEST_CASE( "horse_marker_observation_preserves_the_tamers_identity",
           "[monster][overmap][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();
    avatar &observer = get_avatar();
    npc owner;
    owner.setID( character_id( 700201 ) );
    REQUIRE( owner.getID() != observer.getID() );
    restore_on_out_of_scope restore_markers( overmap_buffer.global_state.tracked_pets );
    overmap_buffer.global_state.tracked_pets.clear();
    monster &horse = spawn_test_monster( "mon_horse", observer.pos_bub() + tripoint::east );
    horse.friendly = -1;
    overmap_buffer.update_tracked_pet( horse, owner );
    REQUIRE( overmap_buffer.global_state.tracked_pets.size() == 1 );
    const tripoint_abs_omt previous = horse.pos_abs_omt();
    horse.setpos( horse.pos_abs() + tripoint( 48, 0, 0 ) );
    REQUIRE( horse.pos_abs_omt() != previous );
    horse.unique_name = "Cloud";
    overmap_buffer.update_tracked_pet( horse, observer );
    const overmap_tracked_pet &marker = overmap_buffer.global_state.tracked_pets.front();
    CHECK( marker.owner == owner.getID() );
    CHECK( marker.position == horse.pos_abs_omt() );
    CHECK( marker.name == horse.get_name() );
    CHECK_FALSE( overmap_buffer.has_tracked_pet( horse.pos_abs_omt() ) );
    overmap_buffer.update_tracked_pet( horse, observer, true );
    CHECK( overmap_buffer.global_state.tracked_pets.front().owner == observer.getID() );
    CHECK( overmap_buffer.has_tracked_pet( horse.pos_abs_omt() ) );
}

TEST_CASE( "same_named_horses_keep_separate_overmap_markers", "[monster][overmap][save]" )
{
    clear_avatar();
    avatar &rider = get_avatar();
    restore_on_out_of_scope restore_markers( overmap_buffer.global_state.tracked_pets );
    overmap_buffer.global_state.tracked_pets.clear();
    monster first( mon_horse );
    monster second( mon_horse );
    first.friendly = -1;
    second.friendly = -1;
    first.unique_name = "Comet";
    second.unique_name = first.unique_name;
    overmap_buffer.update_tracked_pet( first, rider );
    overmap_buffer.update_tracked_pet( second, rider );
    REQUIRE( first.pos_abs_omt() == second.pos_abs_omt() );
    auto markers = overmap_buffer.get_tracked_pets( first.pos_abs_omt() );
    REQUIRE( markers.size() == 2 );
    CHECK( markers.front().name == markers.back().name );
    CHECK( markers.front().uid != markers.back().uid );

    overmap_buffer.remove_tracked_pet( first.uid().get_value() );
    markers = overmap_buffer.get_tracked_pets( second.pos_abs_omt() );
    REQUIRE( markers.size() == 1 );
    CHECK( markers.front().uid == second.uid().get_value() );
}

TEST_CASE( "horse_mounting_counts_equipment_and_cargo", "[monster][mount][pet_equipment]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();
    avatar &rider = get_avatar();
    monster &horse = spawn_test_monster( "mon_horse", rider.pos_bub() + tripoint::east );
    horse.friendly = -1;
    REQUIRE( rider.can_mount( horse ) );
    while( horse.get_load_weight( &rider ) <= horse.weight_capacity() ) {
        horse.add_item( item( itype_rock ) );
    }
    REQUIRE( horse.get_carried_weight() <= horse.weight_capacity() );
    CHECK_FALSE( rider.can_mount( horse ) );
    CHECK( horse.get_load_weight( &rider ) == horse.get_carried_weight() + rider.get_weight() );
}

TEST_CASE( "overloaded_ridden_horse_moves_more_slowly", "[monster][mount][pet_equipment]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();
    avatar &rider = get_avatar();
    monster &horse = spawn_test_monster( "mon_horse", rider.pos_bub() + tripoint::east );
    horse.friendly = -1;
    REQUIRE( rider.can_mount( horse ) );
    rider.mount_creature( horse );
    REQUIRE( rider.is_mounted() );
    const double unloaded_speed = rider.mount_speed();
    REQUIRE( unloaded_speed > 0.0 );
    while( horse.get_load_weight() <= horse.weight_capacity() ) {
        horse.add_item( item( itype_anvil ) );
    }
    CHECK( rider.mount_speed() < unloaded_speed );
    CHECK( rider.mount_speed() > 0.0 );
}

TEST_CASE( "horse_cargo_can_transfer_partial_charge_stacks", "[monster][pet_equipment][inventory]" )
{
    clear_avatar();
    avatar &rider = get_avatar();
    monster horse( mon_horse );
    REQUIRE( horse.equip_pet_equipment( pet_slot_storage, item( itype_backpack ) ) );
    item medicine( itype_aspirin );
    medicine.charges = 10;
    const item_location source = rider.i_add( medicine );
    const pet_inventory_ui::transfer_request outgoing { true, source, 0, 3 };
    REQUIRE( pet_inventory_ui::transfer_item( rider, horse, outgoing ).success() );
    REQUIRE( source );
    CHECK( source->charges == 7 );
    item *storage = horse.get_pet_storage();
    auto contents = storage->all_items_top( pocket_type::CONTAINER );
    REQUIRE( contents.size() == 1 );
    REQUIRE( contents.front()->charges == 3 );
    const int64_t cargo_uid = contents.front()->uid().get_value();
    CHECK_FALSE( pet_inventory_ui::transfer_item( rider, horse,
    { false, item_location(), cargo_uid, 4 } ).success() );
    CHECK( contents.front()->charges == 3 );
    REQUIRE( pet_inventory_ui::transfer_item( rider, horse,
    { false, item_location(), cargo_uid, 2 } ).success() );
    CHECK( rider.charges_of( itype_aspirin ) == 9 );
    CHECK( contents.front()->charges == 1 );
}

TEST_CASE( "animal_cargo_activity_moves_one_item_per_turn_and_can_be_cancelled",
           "[monster][pet_equipment][activity]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();
    avatar &rider = get_avatar();
    REQUIRE( rider.wear_item( item( itype_backpack ), false ) );
    monster &horse = spawn_test_monster( "mon_horse", rider.pos_bub() + tripoint::east );
    horse.friendly = -1;
    REQUIRE( horse.equip_pet_equipment( pet_slot_storage, item( itype_backpack ) ) );
    const item_location first_source = rider.i_add( item( itype_rock ) );
    const item_location second_source = rider.i_add( item( itype_aspirin ) );
    std::vector<pet_inventory_ui::transfer_request> requests {
        { true, first_source, 0, 1 }, { true, second_source, 0, 1 }
    };
    rider.assign_activity( pet_inventory_ui::transfer_activity_actor( horse.uid().get_value(),
                           rider.getID(), requests ) );
    REQUIRE( rider.activity );
    rider.set_moves( 100 );
    rider.activity.do_turn( rider );
    CHECK_FALSE( first_source );
    REQUIRE( second_source );
    REQUIRE( rider.has_item( *second_source ) );
    REQUIRE( rider.activity );
    CHECK( horse.get_pet_storage()->all_items_top( pocket_type::CONTAINER ).size() == 1 );

    std::ostringstream saved;
    JsonOut output( saved );
    rider.activity.actor->serialize( output );
    INFO( saved.str() );
    rider.cancel_activity();
    CHECK( second_source );
    REQUIRE( rider.has_item( *second_source ) );
    CHECK( horse.get_pet_storage()->all_items_top( pocket_type::CONTAINER ).size() == 1 );

    std::unique_ptr<activity_actor> restored;
    deserialize_wrapper( [&restored]( const JsonValue & value ) {
        JsonValue data = value;
        restored = pet_inventory_ui::transfer_activity_actor::deserialize( data );
    }, saved.str() );
    REQUIRE( restored );
    rider.assign_activity( *restored );
    rider.set_moves( 100 );
    rider.activity.do_turn( rider );
    CHECK_FALSE( rider.activity );
    CHECK( horse.get_pet_storage()->all_items_top( pocket_type::CONTAINER ).size() == 2 );
}

TEST_CASE( "animal_cargo_activity_stops_when_the_animal_is_unavailable",
           "[monster][pet_equipment][activity]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();
    avatar &rider = get_avatar();
    monster &horse = spawn_test_monster( "mon_horse", rider.pos_bub() + tripoint::east );
    horse.friendly = -1;
    REQUIRE( horse.equip_pet_equipment( pet_slot_storage, item( itype_backpack ) ) );
    const item_location source = rider.i_add( item( itype_rock ) );
    rider.assign_activity( pet_inventory_ui::transfer_activity_actor( horse.uid().get_value(),
    rider.getID(), { { true, source, 0, 1 } } ) );
    REQUIRE( rider.activity );
    SECTION( "out_of_reach" ) {
        horse.setpos( rider.pos_abs() + tripoint( 3, 0, 0 ) );
    }
    SECTION( "no_longer_tame" ) {
        horse.friendly = 0;
    }
    SECTION( "another_floor" ) {
        horse.setpos( rider.pos_abs() + tripoint::below );
    }
    SECTION( "blocked_by_terrain" ) {
        get_map().ter_set( horse.pos_bub(), ter_id( "t_wall" ) );
    }
    const int original_moves = 100;
    rider.set_moves( original_moves );
    rider.activity.do_turn( rider );
    CHECK_FALSE( rider.activity );
    REQUIRE( source );
    CHECK( rider.has_item( *source ) );
    CHECK( horse.get_pet_storage()->all_items_top( pocket_type::CONTAINER ).empty() );
    CHECK( rider.get_moves() == original_moves );
}

TEST_CASE( "animal_cargo_resume_rechecks_reach_after_partial_completion",
           "[monster][pet_equipment][activity][regression]" )
{
    clear_avatar();
    clear_map_without_vision();
    clear_creatures();
    avatar &rider = get_avatar();
    REQUIRE( rider.wear_item( item( itype_backpack ), false ) );
    monster &horse = spawn_test_monster( "mon_horse", rider.pos_bub() + tripoint::east );
    horse.friendly = -1;
    REQUIRE( horse.equip_pet_equipment( pet_slot_storage, item( itype_backpack ) ) );
    const item_location first = rider.i_add( item( itype_rock ) );
    const item_location second = rider.i_add( item( itype_aspirin ) );
    rider.assign_activity( pet_inventory_ui::transfer_activity_actor( horse.uid().get_value(),
    rider.getID(), { { true, first, 0, 1 }, { true, second, 0, 1 } } ) );
    rider.set_moves( 100 );
    rider.activity.do_turn( rider );
    REQUIRE( rider.activity );
    REQUIRE_FALSE( first );
    REQUIRE( second );
    std::ostringstream saved;
    JsonOut output( saved );
    rider.activity.actor->serialize( output );
    rider.cancel_activity();
    horse.setpos( rider.pos_abs() + tripoint::below );
    std::unique_ptr<activity_actor> restored;
    deserialize_wrapper( [&restored]( const JsonValue & value ) {
        JsonValue data = value;
        restored = pet_inventory_ui::transfer_activity_actor::deserialize( data );
    }, saved.str() );
    REQUIRE( restored );
    rider.assign_activity( *restored );
    rider.set_moves( 100 );
    rider.activity.do_turn( rider );
    CHECK_FALSE( rider.activity );
    CHECK( second );
    CHECK( rider.get_moves() == 100 );
    CHECK( horse.get_pet_storage()->all_items_top( pocket_type::CONTAINER ).size() == 1 );
}

TEST_CASE( "padded_horse_barding_reduces_actual_damage", "[monster][pet_equipment][armor]" )
{
    monster horse( mon_horse );
    const int initial_hp = horse.get_hp();
    const damage_instance strike( damage_bash, 30 );
    const float unarmored = horse.deal_damage( nullptr, bodypart_id( "torso" ), strike ).total_damage();
    horse.set_hp( initial_hp );
    const item barding( itype_padded_armor_horse );
    REQUIRE( horse.equip_pet_equipment( pet_slot_armor, barding ) );
    CHECK( horse.get_carried_weight() == barding.weight() );
    CHECK( horse.get_worn_armor_val( damage_bash ) > 0 );
    const float armored = horse.deal_damage( nullptr, bodypart_id( "torso" ), strike ).total_damage();
    CHECK( armored < unarmored );
}
