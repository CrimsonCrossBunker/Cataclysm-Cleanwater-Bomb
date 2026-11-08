#include "bionic_world_effects.h"

#include <set>
#include <utility>
#include <vector>

#include "ballistics.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "damage.h"
#include "dispersion.h"
#include "item.h"
#include "line.h"
#include "map.h"
#include "map_iterator.h"
#include "mapdata.h"
#include "material.h"
#include "projectile.h"
#include "sounds.h"
#include "translations.h"
#include "type_id.h"
#include "units.h"

bool bionic_resonance( Character &who, map &here )
{
    const character_action_guard lifetime( who );
    if( !lifetime ) {
        return false;
    }
    //~Sound of a bionic sonic-resonator shaking the area
    sounds::sound( who.pos_bub( here ), 30, sounds::sound_t::combat, _( "VRRRRMP!" ), false,
                   "bionic", "bio_resonator" );
    // Snapshot positions before destruction can shift the local map.
    std::vector<tripoint_abs_ms> affected;
    for( const tripoint_bub_ms &p : here.points_in_radius( who.pos_bub( here ), 1 ) ) {
        affected.push_back( here.get_abs( p ) );
    }
    for( const tripoint_abs_ms &p : affected ) {
        // Preserve the native three bashes, including their random draws.
        for( int hit = 0; hit < 3; ++hit ) {
            here.bash( here.get_bub( p ), 110 );
            if( !lifetime ) {
                return false;
            }
        }
    }
    return true;
}

bool bionic_magnetic_attraction( Character &who, map &here )
{
    const character_action_guard lifetime( who );
    if( !lifetime ) {
        return false;
    }
    static const std::set<material_id> affected_materials = {
        material_id( "iron" ), material_id( "steel" ), material_id( "lc_steel" ),
        material_id( "mc_steel" ), material_id( "hc_steel" ), material_id( "ch_steel" ),
        material_id( "qt_steel" ), material_id( "budget_steel" )
    };
    // Keep the native one-item-per-tile selection and detach the complete batch
    // before launching anything, so an item cannot be attracted twice.
    std::vector<std::pair<item, tripoint_abs_ms>> affected;
    const units::mass weight_cap = who.weight_capacity();
    for( const tripoint_bub_ms &p : here.points_in_radius( who.pos_bub( here ), 10 ) ) {
        if( p == who.pos_bub( here ) || !here.has_items( p ) ||
            here.has_flag( ter_furn_flag::TFLAG_SEALED, p ) ) {
            continue;
        }
        map_stack stack = here.i_at( p );
        for( auto it = stack.begin(); it != stack.end(); ++it ) {
            if( it->weight() < weight_cap && it->made_of_any( affected_materials ) ) {
                affected.emplace_back( *it, here.get_abs( p ) );
                stack.erase( it );
                break;
            }
        }
    }
    size_t placed = 0;
    const on_out_of_scope restore_pending( [&]() {
        // Returning an unlaunched item is not another drop action. Use the map's
        // insertion API to restore its caches without running on_drop again.
        for( ; placed < affected.size(); ++placed ) {
            auto &pending = affected[placed];
            here.add_item( here.get_bub( pending.second ), std::move( pending.first ) );
        }
    } );
    while( placed < affected.size() ) {
        if( !lifetime ) {
            return false;
        }
        const auto &pending = affected[placed];
        const tripoint_bub_ms source = here.get_bub( pending.second );
        const tripoint_bub_ms target = who.pos_bub( here );
        projectile proj;
        proj.speed = 50;
        proj.impact = damage_instance();
        proj.impact.add_damage( damage_type_id( "bash" ), pending.first.weight() / 250_gram );
        // Stop one tile short of the activator, as in the native ability.
        proj.range = rl_dist( source, target ) - 1;
        proj.proj_effects = {
            ammo_effect_str_id( "NO_ITEM_DAMAGE" ), ammo_effect_str_id( "DRAW_AS_LINE" ),
            ammo_effect_str_id( "NO_DAMAGE_SCALING" ), ammo_effect_str_id( "JET" )
        };
        dealt_projectile_attack dealt;
        const tripoint_abs_ms bubble_origin = here.get_abs( tripoint_bub_ms::zero );
        projectile_attack( dealt, proj, &here, source, target, dispersion_sources{ 0 }, &who );
        const tripoint_abs_ms destination = bubble_origin + tripoint_rel_ms( dealt.end_point.raw() );
        here.add_item_or_charges( here.get_bub( destination ), pending.first );
        ++placed;
    }
    return static_cast<bool>( lifetime );
}
