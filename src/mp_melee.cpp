#include "mp_melee.h"

#include <algorithm>

#include "character.h"
#include "creature_tracker.h"
#include "effect.h"
#include "enums.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "magic_enchantment.h"
#include "map.h"
#include "npc.h"
#include "translations.h"

namespace cata_mp
{
void execute_melee_intent( Character &actor, map &here, const melee_intent &intent )
{
    if( actor.pos_abs() != intent.origin || !here.inbounds( intent.target ) ||
        intent.origin == intent.target || actor.is_dead_state() ||
        actor.has_flag( json_character_flag( "CANNOT_ATTACK" ) ) ||
        actor.has_effect( efftype_id( "incorporeal" ) ) ) {
        return;
    }
    const tripoint_bub_ms target = here.get_bub( intent.target );
    Creature *victim = get_creature_tracker().creature_at( target, true );
    if( intent.action != melee_action::reach && ( !victim || victim->is_dead_state() ) ) {
        return;
    }
    if( intent.action == melee_action::reach ) {
        const item_location weapon = actor.get_wielded_item();
        if( weapon && !actor.used_weapon() && !weapon->is_gun() ) {
            return;
        }
        const int reach = weapon ? weapon->current_reach_range( actor ).first : std::max( 1,
                          static_cast<int>( actor.calculate_by_enchantment( 1,
                                            enchant_vals::mod::MELEE_RANGE_MODIFIER ) ) );
        if( rl_dist( intent.origin, intent.target ) > reach ||
            ( victim && !actor.can_reach_attack( *victim ) ) ) {
            return;
        }
    } else if( intent.action == melee_action::strike &&
               !actor.is_adjacent( victim, false ) &&
               !here.on_matching_stairs( actor.pos_bub( here ), target ) ) {
        return;
    }
    if( !actor.try_break_relax_gas( _( "Your willpower asserts itself, and so do you!" ),
                                    _( "You're too pacified to strike anything." ) ) ) {
        return;
    }
    const int before = actor.get_moves();
    if( intent.action == melee_action::reach ) {
        actor.reach_attack( target, -1, intent.allow_collateral );
    } else if( intent.action == melee_action::technique ) {
        actor.use_active_technique( *victim, intent.technique );
    } else {
        actor.melee_attack( *victim, true );
    }
    if( actor.get_moves() < before && victim && victim->is_npc() ) {
        victim->as_npc()->on_attacked( actor );
    }
}

} // namespace cata_mp
