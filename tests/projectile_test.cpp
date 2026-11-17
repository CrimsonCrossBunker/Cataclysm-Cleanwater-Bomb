#include <algorithm>
#include <memory>
#include <set>
#include <string>
#include <vector>

#include "ammo_effect.h"
#include "ballistics.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "damage.h"
#include "dispersion.h"
#include "effect.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "lua_platform_runtime.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "npc.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "projectile.h"
#include "ret_val.h"
#include "rng.h"
#include "type_id.h"
#include "value_ptr.h"

static const efftype_id effect_bile_stink( "bile_stink" );

static const itype_id itype_308( "308" );
static const itype_id itype_boomer_head( "boomer_head" );
static const itype_id itype_hazmat_suit( "hazmat_suit" );
static const itype_id itype_m1a( "m1a" );
static const itype_id itype_mask_gas( "mask_gas" );

TEST_CASE( "bundled_ammo_effects_preserve_native_explosion_defaults", "[projectile][ammo]" )
{
    const ammo_effect_str_id null_effect = ammo_effect_str_id::NULL_ID();
    REQUIRE( null_effect.is_valid() );
    CHECK( null_effect.id().id() == null_effect );
    const ammo_effect_str_id mortar( "EXPLOSIVE_60mmHE" );
    REQUIRE( mortar.is_valid() );
    CHECK( mortar->aoe_explosion_data.shrapnel.casing_mass == 500 );
    CHECK( mortar->aoe_explosion_data.shrapnel.fragment_mass == Approx( 0.005 ) );
    const ammo_effect_str_id grenade( "EXPLOSIVE_GRENADE" );
    REQUIRE( grenade.is_valid() );
    CHECK( grenade->aoe_explosion_data.distance_factor == Approx( 0.75 ) );
    CHECK( grenade->aoe_explosion_data.shrapnel.fragment_mass == Approx( 0.08 ) );
}

TEST_CASE( "gene_sting_ammo_mutates_only_a_damaged_character", "[projectile][ammo]" )
{
    clear_avatar();
    clear_map_without_vision();
    cata::lua_platform::runtime_world_ready( true );
    Character &target = get_player_character();
    const tripoint_bub_ms position( 60, 60, 0 );
    target.setpos( get_map(), position );
    monster &shooter = spawn_test_monster( "mon_zombie", position + tripoint_rel_ms::east );
    const ammo_effect_str_id sting( "GENE_STING_BARB" );
    REQUIRE( sting.is_valid() );
    const std::vector<trait_id> original = target.get_mutations();
    rng_set_engine_seed( 70731 );
    apply_ammo_effects( &shooter, position, { sting }, 0 );
    CHECK( target.get_mutations() == original );
    for( int hit = 0; hit < 4; ++hit ) {
        apply_ammo_effects( &shooter, position, { sting }, 1 );
    }
    CHECK( target.get_mutations() != original );
    clear_avatar();
}

TEST_CASE( "mindovermatter_ammo_applies_the_original_stun_and_immunity",
           "[projectile][ammo][mindovermatter]" )
{
    const ammo_effect_str_id neural( "NEURAL_STUNGUN" );
    const ammo_effect_str_id exodii( "EXODII_NEURAL_STUNGUN" );
    if( !neural.is_valid() ) {
        return;
    }
    REQUIRE( exodii.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    cata::lua_platform::runtime_world_ready( true );
    Character &target = get_player_character();
    const tripoint_bub_ms position( 60, 60, 0 );
    target.setpos( get_map(), position );
    monster &source = spawn_test_monster( "mon_zombie", position + tripoint_rel_ms::east );
    const efftype_id paralysis( "effect_electrokin_paralysis" );
    const efftype_id stunned( "psi_stunned" );
    const trait_id immune( "NPC_TELEPATHY_IMMUNE" );

    rng_set_engine_seed( 70731 );
    apply_ammo_effects( &source, position + tripoint_rel_ms::west, { neural }, 0 );
    apply_ammo_effects( &source, position, { neural }, 0 );
    REQUIRE( target.has_effect( paralysis ) );
    CHECK( to_turns<int>( target.get_effect_dur( paralysis ) ) >= 15 );
    CHECK( to_turns<int>( target.get_effect_dur( paralysis ) ) < 60 );
    target.set_mutation( immune );
    apply_ammo_effects( &source, position, { exodii }, 0 );
    CHECK_FALSE( target.has_effect( stunned ) );
    target.unset_mutation( immune );
    apply_ammo_effects( &source, position, { exodii }, 0 );
    REQUIRE( target.has_effect( stunned ) );
    CHECK( to_turns<int>( target.get_effect_dur( stunned ) ) >= 15 );
    CHECK( to_turns<int>( target.get_effect_dur( stunned ) ) < 60 );
    monster &mindless = spawn_test_monster( "mon_blob", position + tripoint_rel_ms::west );
    apply_ammo_effects( &source, mindless.pos_bub(), { exodii }, 10 );
    CHECK_FALSE( mindless.has_effect( stunned ) );
    clear_avatar();
}

TEST_CASE( "aftershock_vahagn_retargets_five_monsters_once_per_turn",
           "[projectile][ammo][aftershock]" )
{
    const ammo_effect_str_id vahagn( "VAHAGN" );
    if( !vahagn.is_valid() ) {
        return;
    }
    clear_avatar();
    clear_map_without_vision();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    cata::lua_platform::runtime_world_ready( true );
    Character &shooter = get_player_character();
    map &here = get_map();
    const tripoint_bub_ms position( 60, 60, 0 );
    shooter.setpos( here, position );
    const efftype_id marked( "smart_targeted" );
    const efftype_id fired_at( "vahagan_fired_at" );
    std::vector<monster *> targets;
    for( int offset = -3; offset <= 3; ++offset ) {
        const tripoint_bub_ms tile = position + tripoint_rel_ms( 4, offset, 0 );
        monster &target = spawn_test_monster( "mon_moxie_scavenger", tile );
        target.add_effect( marked, 1_minutes );
        targets.push_back( &target );
    }
    set_time( calendar::turn - time_past_midnight( calendar::turn ) + 12_hours );
    for( const monster *target : targets ) {
        REQUIRE( target->sees( here, position ) );
    }
    const auto hit = [&]() {
        apply_ammo_effects( &shooter, position + tripoint_rel_ms::west * 5, { vahagn }, 0 );
        std::vector<bool> retargeted;
        for( const monster *target : targets ) {
            retargeted.push_back( target->has_effect( fired_at ) );
            CHECK( target->has_effect( marked ) != retargeted.back() );
        }
        return retargeted;
    };
    const std::vector<bool> first = hit();
    CHECK( std::count( first.begin(), first.end(), true ) == 5 );
    CHECK( hit() == first );
    clear_avatar();
}

TEST_CASE( "recovered_arrow_preserves_stack_identity", "[projectile][ammo][stacking]" )
{
    clear_avatar();
    clear_map_without_vision();
    Character &shooter = get_player_character();
    map &here = get_map();
    const tripoint_bub_ms origin( 60, 60, 0 );
    shooter.setpos( here, origin );
    shooter.set_str_base( 30 );
    // This arrow has 100% recovery, so the test does not depend on a lucky shot.
    arm_shooter( shooter, itype_id( "greatbow_meteor" ), {}, itype_id( "arrow_meteor" ) );
    item &bow = *shooter.get_wielded_item();
    item &arrow = bow.first_ammo();
    arrow.set_var( "item_label", "recover me" );
    arrow.set_favorite( true );
    arrow.set_damage( 1000 );
    const item original = arrow;
    const unsigned int seed = 192026;
    CAPTURE( seed );
    rng_set_engine_seed( seed );
    REQUIRE( shooter.fire_gun( here, origin + tripoint_rel_ms::east * 5, 1, bow ) == 1 );

    int recovered = 0;
    for( const tripoint_bub_ms &pos : here.points_in_radius( origin, 30 ) ) {
        for( const item &it : here.i_at( pos ) ) {
            if( it.typeId() != original.typeId() ) {
                continue;
            }
            recovered += it.charges;
            CHECK( it.get_var( "item_label" ) == original.get_var( "item_label" ) );
            CHECK( it.damage() == original.damage() );
            CHECK( it.is_favorite == original.is_favorite );
            CHECK( it.stacks_with( original ) );
        }
    }
    CHECK( recovered == 1 );
}


static tripoint_bub_ms projectile_end_point( const std::vector<tripoint_bub_ms> &range,
        const item &gun, int speed, int proj_range )
{
    projectile test_proj;
    test_proj.speed = speed;
    test_proj.range = proj_range;
    test_proj.impact = gun.gun_damage();
    test_proj.proj_effects = gun.ammo_effects();
    test_proj.critical_multiplier = gun.ammo_data()->ammo->critical_multiplier;

    dealt_projectile_attack attack;

    projectile_attack( attack, test_proj, range[0], range[2], dispersion_sources(),
                       &get_player_character(), nullptr );

    return attack.end_point;
}

TEST_CASE( "projectiles_through_obstacles", "[projectile]" )
{
    clear_map_without_vision();
    map &here = get_map();
    creature_tracker &creatures = get_creature_tracker();

    // Move the player out of the way of the test area
    get_player_character().setpos( here, tripoint_bub_ms{ 2, 2, 0 } );

    // Ensure that a projectile fired from a gun can pass through a chain link fence
    // First, set up a test area - three tiles in a row
    // One on either side clear, with a chainlink fence in the middle
    std::vector<tripoint_bub_ms> range = {
        tripoint_bub_ms::zero,
        tripoint_bub_ms::zero + tripoint_rel_ms::east,
        tripoint_bub_ms::zero + tripoint_rel_ms::east * 2
    };
    for( const tripoint_bub_ms &pt : range ) {
        REQUIRE( here.inbounds( pt ) );
        here.ter_set( pt, ter_id( "t_dirt" ) );
        here.furn_set( pt, furn_id( "f_null" ) );
        REQUIRE_FALSE( creatures.creature_at( pt ) );
        REQUIRE( here.is_transparent( pt ) );
    }

    // Set an obstacle in the way, a chain fence
    here.ter_set( range[1], ter_id( "t_chainfence" ) );

    // Create a gun to fire a projectile from
    item gun( itype_m1a );
    item mag( gun.magazine_default() );
    mag.ammo_set( itype_308, 5 );
    gun.put_in( mag, pocket_type::MAGAZINE_WELL );

    // Check that a bullet with the correct amount of speed can through obstacles
    CHECK( projectile_end_point( range, gun, 1000, 3 ) == range[2] );

    // But that a bullet without the correct amount cannot
    CHECK( projectile_end_point( range, gun, 10, 3 ) == range[0] );
}

static npc &liquid_projectiles_setup( Character &player )
{
    clear_avatar();
    clear_npcs();
    clear_map_without_vision();

    arm_shooter( player, itype_boomer_head );
    const tripoint_bub_ms next_to = player.adjacent_tile();

    npc &dummy = spawn_npc( next_to.xy(), "mi-go_prisoner" );
    dummy.clear_worn();
    dummy.clear_mutations();

    return dummy;
}

TEST_CASE( "liquid_projectiles_applies_effect", "[projectile_effect]" )
{
    map &here = get_map();
    Character &player = get_player_character();
    npc &dummy = liquid_projectiles_setup( player );
    const item hazmat( itype_hazmat_suit );

    REQUIRE( dummy.top_items_loc().empty() );

    //Fire on naked NPC and check that it got the effect
    SECTION( "Naked NPC gets the effect" ) {
        player.fire_gun( here, dummy.pos_bub(), 100, *player.get_wielded_item() );
        CHECK( dummy.has_effect( effect_bile_stink ) );
    }

    dummy.clear_effects();

    //Fire on NPC with hazmat suit + gas mask and check that it didn't get the effect
    SECTION( "Hazmat NPC doesn't get the effect" ) {
        dummy.wear_item( hazmat );
        dummy.wear_item( item( itype_mask_gas ) );
        player.fire_gun( here, dummy.pos_bub(), 100, *player.get_wielded_item() );
        CHECK( !dummy.has_effect( effect_bile_stink ) );
    }
}
