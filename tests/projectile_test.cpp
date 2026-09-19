#include <memory>
#include <set>
#include <string>
#include <vector>

#include "ballistics.h"
#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "damage.h"
#include "dispersion.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
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
