#include "mp_melee.h"

#include <algorithm>
#include <sstream>

#include "character.h"
#include "cata_scope_helpers.h"
#include "rng.h"
#include "creature_tracker.h"
#include "effect.h"
#include "enums.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "json.h"
#include "magic_enchantment.h"
#include "map.h"
#include "mp_pickup.h"
#include "npc.h"
#include "skill.h"
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

std::string make_melee_result( const Character &actor, pickup_host_state &state )
{
    const std::string inventory = make_inventory_update( actor, state );
    std::ostringstream text;
    JsonOut out( text );
    out.start_object();
    out.member( "type", "melee_result" );
    out.member( "inventory" );
    *out.get_stream() << inventory;
    out.set_need_separator();
    out.member( "stamina", actor.get_stamina() );
    out.member( "focus", actor.get_focus_pool() );
    out.member( "recoil", actor.recoil );
    out.member( "pain", actor.get_pain() );
    out.member( "skills" );
    out.start_object();
    for( const auto &entry : actor.get_all_skills() ) {
        out.member( entry.first.str(), entry.second );
    }
    out.end_object();
    out.member( "effects" );
    out.start_array();
    for( const effect &eff : actor.get_effects() ) {
        out.write( eff );
    }
    out.end_array();
    out.end_object();
    return text.str();
}

bool apply_melee_result( Character &actor, const JsonObject &message, pickup_client_state &state )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const int stamina = message.get_int( "stamina" );
    const int focus = message.get_int( "focus" );
    const double recoil = message.get_float( "recoil" );
    const int pain = message.get_int( "pain" );
    SkillLevelMap skills;
    for( const JsonMember &entry : message.get_object( "skills" ) ) {
        const skill_id id( entry.name() );
        if( !id.is_valid() ) {
            message.throw_error_at( "skills", "Unknown skill in melee result" );
        }
        skills[id].deserialize( entry.get_object() );
    }
    std::vector<effect> effects;
    for( JsonObject entry : message.get_array( "effects" ) ) {
        effect eff;
        eff.deserialize( entry );
        effects.push_back( eff );
    }
    JsonObject inventory = message.get_object( "inventory" );
    inventory.allow_omitted_members();
    if( !apply_inventory_update( actor, inventory, state ) ) {
        return false;
    }
    actor.set_stamina( stamina );
    actor.set_focus_pool( focus );
    actor.recoil = recoil;
    actor.set_pain( pain );
    for( const auto &entry : skills ) {
        actor.get_skill_level_object( entry.first ) = entry.second;
    }
    actor.restore_effects_snapshot( effects );
    return true;
}
} // namespace cata_mp
