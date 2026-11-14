#include <coordinates.h>
#include <enums.h>
#include <point.h>
#include <vehicle_uid.h>
#include <functional>
#include <initializer_list>
#include <list>
#include <optional>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "flag.h"
#include "game_constants.h"
#include "handle_liquid.h"
#include "iexamine.h"
#include "item.h"
#include "item_location.h"
#include "item_pocket.h"
#include "item_uid.h"
#include "item_unload.h"
#include "liquid_transfer.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "mapdata.h"
#include "npc.h"
#include "player_helpers.h"
#include "ret_val.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

namespace
{
class liquid_owner_fixture
{
    public:
        restore_on_out_of_scope<time_point> time{ calendar::turn };
        restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };
        liquid_owner_fixture() {
            clear_avatar();
            clear_map_without_vision();
            get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
            get_avatar().set_moves( 517 );
        }
        ~liquid_owner_fixture() {
            clear_npcs();
            clear_avatar();
        }
        npc &actor() {
            npc &who = spawn_npc( { 60, 60 }, "test_talker" );
            clear_character( who, true );
            who.set_moves( 1500 );
            return who;
        }
};
} // namespace

TEST_CASE( "liquid_transfer_charges_its_actor_and_refreshes_its_carried_weight",
           "[liquid][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
    liquid_dest_opt target;
    target.dest_opt = LD_ITEM;
    target.item_loc = who.get_wielded_item();
    item water( itype_id( "water_clean" ), calendar::turn, 20 );
    water.set_owner( faction_id( "your_followers" ) );
    water.set_old_owner( faction_id( "free_merchants" ) );
    const int capacity = target.item_loc->get_remaining_capacity_for_liquid( water, true );
    REQUIRE( capacity > 0 );
    water.charges = capacity + 1;
    const units::mass before = who.weight_carried();
    REQUIRE( liquid_handler::transfer_liquid( who, water, target ) );
    CHECK( water.charges == 1 );
    CHECK( target.item_loc->legacy_front().charges == capacity );
    CHECK( target.item_loc->legacy_front().get_owner() == water.get_owner() );
    CHECK( target.item_loc->legacy_front().get_old_owner() == water.get_old_owner() );
    CHECK( who.weight_carried() > before );
    CHECK( who.weight_carried() == target.item_loc->weight() );
    CHECK( who.get_moves() == 1400 );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( who.activity );
    CHECK_FALSE( get_avatar().activity );
    CHECK_FALSE( liquid_handler::transfer_liquid( who, water, target ) );
    CHECK( water.charges == 1 );
    CHECK( who.get_moves() == 1400 );
}

TEST_CASE( "liquid_transfer_rejects_missing_self_and_non_transfer_destinations",
           "[liquid][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    item water( itype_id( "water_clean" ), calendar::turn, 2 );
    liquid_dest_opt target;
    SECTION( "missing_container" ) {
        target.dest_opt = LD_ITEM;
    }
    SECTION( "consume_belongs_to_consumption" ) {
        target.dest_opt = LD_CONSUME;
    }
    SECTION( "cancel" ) {
        target.dest_opt = LD_NULL;
    }
    SECTION( "self" ) {
        who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
        target.dest_opt = LD_ITEM;
        target.item_loc = who.get_wielded_item();
        REQUIRE( target.item_loc->fill_with( water, 1 ) == 1 );
        item &inside = target.item_loc->legacy_front();
        CHECK_FALSE( liquid_handler::transfer_liquid( who, inside, target ) );
        CHECK( inside.charges == 1 );
        return;
    }
    CHECK_FALSE( liquid_handler::transfer_liquid( who, water, target ) );
    CHECK( water.charges == 2 );
    CHECK( who.get_moves() == 1500 );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "liquid_transfer_uses_only_the_selected_vehicle_tank", "[liquid][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), who.pos_bub() + tripoint::east,
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const int first = veh->install_part( here, point_rel_ms::zero, vpart_id( "tank_test" ) );
    REQUIRE( first >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms( 1, 0 ), vpart_id( "frame" ) ) >= 0 );
    const int second = veh->install_part( here, point_rel_ms( 1, 0 ), vpart_id( "tank_test" ) );
    REQUIRE( second >= 0 );
    veh->refresh();
    liquid_dest_opt target;
    target.dest_opt = LD_VEH;
    target.veh = veh;
    item water( itype_id( "water_clean" ), calendar::turn, 3 );
    SECTION( "selected" ) {
        REQUIRE( liquid_handler::transfer_liquid( who, water, target, second ) );
        CHECK( water.charges == 0 );
        CHECK( veh->part( first ).ammo_remaining() == 0 );
        CHECK( veh->part( second ).ammo_remaining() == 3 );
        CHECK( who.get_moves() == 500 );
    }
    SECTION( "missing_choice_does_not_open_menu" ) {
        CHECK_FALSE( liquid_handler::transfer_liquid( who, water, target ) );
        CHECK( water.charges == 3 );
        CHECK( who.get_moves() == 1500 );
    }
    SECTION( "stale_index" ) {
        CHECK_FALSE( liquid_handler::transfer_liquid( who, water, target, 100000 ) );
        CHECK( water.charges == 3 );
        CHECK( who.get_moves() == 1500 );
    }
    SECTION( "incompatible_tank_does_not_fall_back_to_empty_tank" ) {
        REQUIRE( veh->part( second ).ammo_set( itype_id( "gasoline" ), 3 ) == 3 );
        CHECK_FALSE( liquid_handler::transfer_liquid( who, water, target, second ) );
        CHECK( water.charges == 3 );
        CHECK( veh->part( first ).ammo_remaining() == 0 );
        CHECK( veh->part( second ).ammo_remaining() == 3 );
        CHECK( who.get_moves() == 1500 );
    }
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "liquid_transfer_ground_and_keg_keep_quantity_on_invalid_targets",
           "[liquid][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    map &here = get_map();
    liquid_dest_opt target;
    target.pos = who.pos_bub() + tripoint::east;
    target.dest_opt = LD_GROUND;
    bool valid = true;
    SECTION( "ground" ) {}
    SECTION( "keg" ) {
        target.dest_opt = LD_KEG;
        here.furn_set( target.pos, furn_id( "f_wood_keg" ) );
        REQUIRE( iexamine::has_keg( target.pos ) );
    }
    SECTION( "missing_keg" ) {
        target.dest_opt = LD_KEG;
        valid = false;
    }
    SECTION( "blocked_ground" ) {
        here.furn_set( target.pos, furn_id( "f_no_item" ) );
        REQUIRE_FALSE( here.can_put_items_ter_furn( target.pos ) );
        valid = false;
    }
    item water( itype_id( "water_clean" ), calendar::turn, 4 );
    CHECK( liquid_handler::transfer_liquid( who, water, target ) == valid );
    CHECK( water.charges == ( valid ? 0 : 4 ) );
    CHECK( who.get_moves() == ( valid ? 1400 : 1500 ) );
    CHECK( get_avatar().get_moves() == 517 );
    if( valid ) {
        const map_stack items = here.i_at( target.pos );
        REQUIRE( items.size() == 1 );
        CHECK( items.begin()->charges == 4 );
    }
}

TEST_CASE( "native_unload_updates_the_operating_characters_recoil", "[unload][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    item revolver( itype_id( "sw629" ) );
    revolver.ammo_set( revolver.ammo_default(), 1 );
    who.set_wielded_item( revolver );
    item_location source = who.get_wielded_item();
    who.recoil = 11;
    get_avatar().recoil = 29;
    REQUIRE( who.Character::unload( source, true ) );
    CHECK( who.get_wielded_item()->ammo_remaining() == 0 );
    CHECK( who.recoil == MAX_RECOIL );
    CHECK( get_avatar().recoil == 29 );
    CHECK( get_avatar().get_moves() == 517 );
}

TEST_CASE( "integral_unload_settles_only_fuel_actually_transferred",
           "[unload][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    who.set_wielded_item( item( itype_id( "test_multimag_turret_flamethrower" ) ) );
    item_location gun = who.get_wielded_item();
    REQUIRE( gun->uses_firing_requirements() );
    item_pocket *fuel = gun->pocket_by_id( "fuel" );
    REQUIRE( fuel );
    item gasoline( itype_id( "gasoline" ), calendar::turn, 20 );
    gasoline.set_owner( faction_id( "your_followers" ) );
    gasoline.set_old_owner( faction_id( "free_merchants" ) );
    REQUIRE( fuel->insert_item( gasoline ).success() );
    gun->set_flag( flag_FILTHY );

    liquid_dest_opt destination;
    destination.dest_opt = LD_ITEM;
    item &bottle = get_map().add_item_or_charges( who.pos_bub(),
                   item( itype_id( "bottle_plastic" ) ) );
    destination.item_loc = item_location( map_cursor( who.pos_bub() ), &bottle );
    item existing = gasoline;
    existing.charges = 10000;
    const int capacity = bottle.get_remaining_capacity_for_liquid( existing, true );
    REQUIRE( capacity > gasoline.charges );
    int transferred = 5;
    bool cancel = false;
    SECTION( "partial_container" ) {}
    SECTION( "full_transfer" ) {
        transferred = gasoline.charges;
    }
    SECTION( "cancel" ) {
        transferred = 0;
        cancel = true;
    }
    SECTION( "full_destination" ) {
        transferred = 0;
    }
    existing.charges = capacity - transferred;
    existing.set_flag( flag_FILTHY );
    REQUIRE( bottle.fill_with( existing, existing.charges ) == existing.charges );
    const int before_bottle = bottle.legacy_front().charges;
    // Direct fixture construction bypasses normal wield/reload cache updates.
    who.invalidate_weight_carried_cache();
    const units::mass before_weight = who.weight_carried();
    REQUIRE( before_weight == gun->weight() );
    const int unload_cost = transferred > 0 ? who.item_reload_cost( *gun, gasoline,
                            transferred ) / 2 : 0;
    int calls = 0;
    const bool complete = unload_ammo_pocket( who, *gun, *fuel,
    [&]( item & output, const item & original ) {
        ++calls;
        CHECK( &original == fuel->all_items_top().front() );
        CHECK( output.has_flag( flag_FILTHY ) );
        CHECK_FALSE( original.has_flag( flag_FILTHY ) );
        if( !cancel ) {
            liquid_handler::transfer_liquid( who, output, destination );
        }
        return output.charges == 0;
    } );
    CHECK( calls == 1 );
    CHECK( complete == ( transferred == gasoline.charges ) );
    CHECK( gun->ammo_remaining_in_pocket( "fuel" ) == gasoline.charges - transferred );
    CHECK( bottle.legacy_front().charges == before_bottle + transferred );
    CHECK( gun->ammo_remaining_in_pocket( "fuel" ) + bottle.legacy_front().charges ==
           gasoline.charges + before_bottle );
    CHECK( bottle.legacy_front().get_owner() == gasoline.get_owner() );
    CHECK( bottle.legacy_front().get_old_owner() == gasoline.get_old_owner() );
    if( transferred > 0 ) {
        CHECK( who.weight_carried() < before_weight );
    } else {
        CHECK( who.weight_carried() == before_weight );
    }
    CHECK( who.weight_carried() == gun->weight() );
    CHECK( who.get_moves() == 1500 - unload_cost - ( transferred > 0 ? 100 : 0 ) );
    CHECK( get_avatar().get_moves() == 517 );
    CHECK_FALSE( get_avatar().activity );
    CHECK_FALSE( who.activity );
}

TEST_CASE( "integral_unload_keeps_earlier_transfers_when_a_later_stack_is_partial",
           "[unload][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    who.set_wielded_item( item( itype_id( "test_multimag_turret_flamethrower" ) ) );
    item_location gun = who.get_wielded_item();
    item_pocket *fuel = gun->pocket_by_id( "fuel" );
    REQUIRE( fuel );
    item gasoline( itype_id( "gasoline" ), calendar::turn, 10 );
    REQUIRE( fuel->insert_item( gasoline, false, false ).success() );
    REQUIRE( fuel->insert_item( gasoline, false, false ).success() );
    REQUIRE( fuel->all_items_top().size() == 2 );
    liquid_dest_opt destination;
    destination.dest_opt = LD_ITEM;
    item &bottle = get_map().add_item_or_charges( who.pos_bub(),
                   item( itype_id( "bottle_plastic" ) ) );
    destination.item_loc = item_location( map_cursor( who.pos_bub() ), &bottle );
    item existing = gasoline;
    existing.charges = 10000;
    const int capacity = bottle.get_remaining_capacity_for_liquid( existing, true );
    REQUIRE( capacity > 12 );
    existing.charges = capacity - 12;
    REQUIRE( bottle.fill_with( existing, existing.charges ) == existing.charges );
    item moved = gasoline;
    moved.charges = 12;
    const int unload_cost = who.item_reload_cost( *gun, moved, 12 ) / 2;
    int calls = 0;
    CHECK_FALSE( unload_ammo_pocket( who, *gun, *fuel,
    [&]( item & output, const item & ) {
        ++calls;
        liquid_handler::transfer_liquid( who, output, destination );
        return output.charges == 0;
    } ) );
    CHECK( calls == 2 );
    REQUIRE( fuel->all_items_top().size() == 1 );
    CHECK( fuel->all_items_top().front()->charges == 8 );
    CHECK( bottle.legacy_front().charges == capacity );
    CHECK( who.get_moves() == 1500 - unload_cost - 200 );
    CHECK( get_avatar().get_moves() == 517 );
}

TEST_CASE( "unload_liquid_destination_uses_vehicle_and_tank_identity",
           "[unload][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    npc &who = fixture.actor();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), who.pos_bub() + tripoint::east,
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const int first = veh->install_part( here, point_rel_ms::zero, vpart_id( "tank_test" ) );
    REQUIRE( first >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms( 1, 0 ), vpart_id( "frame" ) ) >= 0 );
    const int second = veh->install_part( here, point_rel_ms( 1, 0 ), vpart_id( "tank_test" ) );
    REQUIRE( second >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    REQUIRE( here.veh_at( who.pos_bub() + tripoint::east ) );
    who.set_wielded_item( item( itype_id( "bottle_plastic" ) ) );
    item water( itype_id( "water_clean" ), calendar::turn, 2 );
    item_location root = who.get_wielded_item();
    REQUIRE( root->fill_with( water, 2 ) == 2 );
    item &source = root->legacy_front();
    unload_liquid_choice choice;
    choice.source = source.uid().get_value();
    choice.kind = LD_VEH;
    choice.vehicle = veh->uid().get_value();
    choice.tank = veh->part( second ).get_base().uid().get_value();
    bool valid = true;
    SECTION( "selected_tank" ) {}
    SECTION( "unknown_tank" ) {
        choice.tank = -1;
        valid = false;
    }
    SECTION( "different_vehicle" ) {
        choice.vehicle = -1;
        valid = false;
    }
    CHECK( receive_unloaded_item( who, source, *root, &source,
                                  std::vector<unload_liquid_choice> { choice } ) == valid );
    CHECK( source.charges == ( valid ? 0 : 2 ) );
    CHECK( veh->part( first ).ammo_remaining() == 0 );
    CHECK( veh->part( second ).ammo_remaining() == ( valid ? 2 : 0 ) );
    CHECK( who.get_moves() == ( valid ? 500 : 1500 ) );
    CHECK( get_avatar().get_moves() == 517 );
}

TEST_CASE( "bulk_keg_pouring_matches_incremental_item_volume", "[liquid][keg][transfer_owner]" )
{
    liquid_owner_fixture fixture;
    map &here = get_map();
    const tripoint_bub_ms pos = get_avatar().pos_bub() + tripoint::east;
    here.furn_set( pos, furn_id( "f_wood_keg" ) );
    const units::volume capacity = here.furn( pos ).obj().keg_capacity;
    REQUIRE( capacity > 0_ml );
    for( const char *id : {
             "jp8", "water_clean"
         } ) {
        for( int existing : {
                 0, 7
             } ) {
            for( int available : {
                     1, 200000
                 } ) {
                CAPTURE( id, existing, available );
                here.i_clear( pos );
                item stored( itype_id( id ), calendar::turn, existing );
                if( existing > 0 ) {
                    here.add_item( pos, stored );
                }
                item expected( stored );
                int transferred = 0;
                while( transferred < available && expected.volume() < capacity ) {
                    ++expected.charges;
                    ++transferred;
                }
                item source( itype_id( id ), calendar::turn, available );
                REQUIRE( iexamine::pour_into_keg( pos, source, true ) );
                REQUIRE( here.i_at( pos ).size() == 1 );
                CHECK( here.i_at( pos ).only_item().charges == existing + transferred );
                CHECK( source.charges == available - transferred );
                if( expected.volume() >= capacity ) {
                    CHECK_FALSE( iexamine::pour_into_keg( pos, source, true ) );
                    CHECK( source.charges == available - transferred );
                }
            }
        }
    }
}
