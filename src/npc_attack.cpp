#include "npc_attack.h"

#include <coordinates.h>
#include <gun_mode.h>
#include <map_iterator.h>
#include <type_id.h>
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <memory>
#include <set>
#include <string>
#include <utility>

#include "cata_utility.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "damage.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flag.h"
#include "gun_mode.h"
#include "inventory.h"
#include "iuse_actor.h"
#include "item.h"
#include "item_location.h"
#include "magic.h"
#include "magic_spell_effect_helpers.h"
#include "map.h"
#include "map_iterator.h"
#include "mapdata.h"
#include "messages.h"
#include "monster.h"
#include "npc.h"
#include "pimpl.h"
#include "point.h"
#include "projectile.h"
#include "ranged.h"
#include "ret_val.h"
#include "rng.h"
#include "talker.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"

static const bionic_id bio_hydraulics( "bio_hydraulics" );

static const json_character_flag json_flag_CANNOT_MOVE( "CANNOT_MOVE" );
static const json_character_flag json_flag_SUBTLE_SPELL( "SUBTLE_SPELL" );

namespace npc_attack_constants
{
// if you are attacking your target, multiply potential by this number
static const float target_modifier = 1.5f;
// if you kill the creature, multiply the potential by this number
static const float kill_modifier = 1.5f;
// the amount of penalty if the npc has to change what it's wielding
// update this number and comment when that is no longer a flat -15 moves
static const int base_time_penalty = 3;
// we want this out of our hands, pronto.
// give a large buff to the attack value so it prioritizes this
static const int base_throw_now = 10000;
} // namespace npc_attack_constants

// TODO: make a better, more generic "check if this projectile is blocked" function
// TODO: put this in a namespace for reuse
static bool has_obstruction( const tripoint_bub_ms &from, const tripoint_bub_ms &to,
                             bool check_ally = false )
{
    std::vector<tripoint_bub_ms> line = line_to( from, to );
    // @to is what we want to hit. we don't need to check for obstruction there.
    line.pop_back();
    const map &here = get_map();
    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &line_point : line ) {
        if( here.impassable( line_point ) || ( check_ally && creatures.creature_at( line_point ) ) ) {
            return true;
        }
    }
    return false;
}

// Planning estimate only; the actual attack retains native armor/weakpoint resolution.
static double damage_after_armor( const damage_instance &damage, const Creature &target )
{
    static const bodypart_id torso( "torso" );
    double result = 0.0;
    for( const damage_unit &unit : damage.damage_units ) {
        result += npc_autonomy::effective_damage( unit.amount,
                  target.get_armor_type( unit.type, torso ), unit.res_pen,
                  unit.res_mult * unit.unconditional_res_mult,
                  unit.damage_multiplier * unit.unconditional_damage_mult );
    }
    return result;
}

static bool can_move( const npc &source )
{
    return !source.in_vehicle && source.rules.engagement != combat_engagement::NO_MOVE;
}

static bool can_move_melee( const npc &source )
{
    return can_move( source ) && source.rules.engagement != combat_engagement::FREE_FIRE &&
           source.rules.engagement != combat_engagement::NO_MOVE && !source.has_flag( json_flag_CANNOT_MOVE );
}

bool npc_attack_rating::operator>( const npc_attack_rating &rhs ) const
{
    if( !rhs._value ) {
        return true;
    }
    if( !_value ) {
        return false;
    }
    return *_value > *rhs._value;
}

bool npc_attack_rating::operator>( const int rhs ) const
{
    if( !_value ) {
        return false;
    }
    return *_value > rhs;
}

bool npc_attack_rating::operator<( const int rhs ) const
{
    if( !_value ) {
        return true;
    }
    return *_value < rhs;
}

npc_attack_rating npc_attack_rating::operator-=( const int rhs )
{
    if( _value ) {
        *_value -= rhs;
    }
    return *this;
}

void npc_attack_spell::use( npc &source, const tripoint_bub_ms &location ) const
{
    spell &sp = source.magic->get_spell( attack_spell_id );
    if( source.has_weapon() && !source.get_wielded_item()->has_flag( flag_MAGIC_FOCUS ) &&
        !sp.has_flag( spell_flag::NO_HANDS ) && !source.has_flag( json_flag_SUBTLE_SPELL ) ) {
        source.unwield();
    }
    add_msg_debug( debugmode::debug_filter::DF_NPC, "%s is casting %s", source.disp_name(), sp.name() );
    source.cast_spell( sp, false, location );
}

npc_attack_rating npc_attack_spell::evaluate( const npc &source,
        const Creature *target ) const
{
    const spell &attack_spell = source.magic->get_spell( attack_spell_id );
    npc_attack_rating effectiveness;
    if( !can_use( source ) ) {
        return effectiveness;
    }
    const int time_penalty = base_time_penalty( source );
    const std::vector<tripoint_bub_ms> targetable_points = attack_spell.targetable_locations( source );
    for( const tripoint_bub_ms &targetable_point : targetable_points ) {
        npc_attack_rating effectiveness_at_point = evaluate_tripoint( source, target, targetable_point );
        effectiveness_at_point -= time_penalty;
        if( effectiveness_at_point > effectiveness ) {
            effectiveness = effectiveness_at_point;
        }
    }
    return effectiveness;
}

std::vector<npc_attack_rating> npc_attack_spell::all_evaluations( const npc &source,
        const Creature *target ) const
{
    const spell &attack_spell = source.magic->get_spell( attack_spell_id );
    std::vector<npc_attack_rating> effectiveness;
    if( !can_use( source ) ) {
        return effectiveness;
    }
    int time_penalty = this->base_time_penalty( source );
    const std::vector<tripoint_bub_ms> targetable_points = attack_spell.targetable_locations( source );
    for( const tripoint_bub_ms &targetable_point : targetable_points ) {
        npc_attack_rating effectiveness_at_point = evaluate_tripoint( source, target, targetable_point );
        effectiveness_at_point -= time_penalty;
        effectiveness.push_back( effectiveness_at_point );
    }
    return effectiveness;
}

bool npc_attack_spell::can_use( const npc &source ) const
{
    const spell &attack_spell = source.magic->get_spell( attack_spell_id );
    // missing components or energy or something
    return attack_spell.can_cast( source ) &&
           // use the same rules as silent guns
           !( source.rules.has_flag( ally_rule::use_silent ) && attack_spell.sound_volume( source ) >= 5 );
}

int npc_attack_spell::base_time_penalty( const npc &source ) const
{
    const spell &attack_spell = source.magic->get_spell( attack_spell_id );
    int time_penalty = 0;
    if( source.has_weapon() && !source.get_wielded_item()->has_flag( flag_MAGIC_FOCUS ) &&
        !attack_spell.has_flag( spell_flag::NO_HANDS ) && !source.has_flag( json_flag_SUBTLE_SPELL ) ) {
        time_penalty += npc_attack_constants::base_time_penalty;
    }
    // costs a point per second spent.
    time_penalty += std::round( attack_spell.casting_time( source ) * source.speed_rating() ) / 100.0f;
    return time_penalty;
}

npc_attack_rating npc_attack_spell::evaluate_tripoint(
    const npc &source, const Creature *target, const tripoint_bub_ms &location ) const
{
    const map &here = get_map();

    const spell &attack_spell = source.magic->get_spell( attack_spell_id );

    double total_potential = 0;

    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &potential_target : calculate_spell_effect_area( attack_spell, location,
            source ) ) {
        Creature *critter = creatures.creature_at( potential_target );

        if( !critter ) {
            // no critter? no damage! however, we assume fields are worth something
            if( attack_spell_id->field ) {
                const_dialogue d( get_const_talker_for( source ), nullptr );
                total_potential += static_cast<double>( attack_spell.field_intensity( source ) ) /
                                   static_cast<double>( attack_spell_id->field_chance.evaluate( d ) ) / 2.0;
            }
            continue;
        }

        const Creature::Attitude att = source.attitude_to( *critter );
        int damage = 0;
        if( source.sees( here, *critter ) ) {
            damage = attack_spell.dps( source, *critter );
        }
        const int distance_to_me = rl_dist( source.pos_bub(), potential_target );
        const bool friendly_fire = att == Creature::Attitude::FRIENDLY &&
                                   !source.rules.has_flag( ally_rule::avoid_friendly_fire );
        int attitude_mult = 3;
        if( att == Creature::Attitude::FRIENDLY ) {
            attitude_mult = -10;
        } else if( att == Creature::Attitude::NEUTRAL || friendly_fire ) {
            // hitting a neutral creature isn't exactly desired, but it's a lot less than a friendly.
            // if friendly fire is on, we don't care too much, though if an available hit doesn't damage them it would be better.
            attitude_mult = -1;
        }
        int potential = damage * attitude_mult - distance_to_me + 1;
        if( target && critter == target ) {
            potential *= npc_attack_constants::target_modifier;
        }
        if( damage >= critter->get_hp() ) {
            potential *= npc_attack_constants::kill_modifier;
            if( att == Creature::Attitude::NEUTRAL ) {
                // we don't care if we kill a neutral creature in one hit
                potential = std::abs( potential );
            }
            const Creature *source_ptr = &source;
            if( att == Creature::Attitude::FRIENDLY || critter == source_ptr ) {
                // however we under no circumstances want to kill an ally (or ourselves!)
                return npc_attack_rating( std::nullopt, location );
            }
        }
        total_potential += potential;
    }
    return npc_attack_rating( static_cast<int>( std::round( total_potential ) ), location );
}

void npc_attack_melee::use( npc &source, const tripoint_bub_ms &location ) const
{
    if( !source.is_wielding( weapon ) ) {
        if( !source.wield( weapon ) ) {
            debugmsg( "ERROR: npc tried to equip a weapon it couldn't wield" );
        }
        return;
    }
    Creature *critter = get_creature_tracker().creature_at( location );
    if( !critter ) {
        debugmsg( "ERROR: npc tried to attack null critter" );
        return;
    }
    int target_distance = rl_dist( source.pos_bub(), location );
    if( !source.is_adjacent( critter, true ) ) {
        if( target_distance <= weapon.reach_range( source ).first ) {
            add_msg_debug( debugmode::debug_filter::DF_NPC, "%s is attempting a reach attack",
                           source.disp_name() );
            // check for friendlies in the line of fire
            std::vector<tripoint_bub_ms> path = line_to( source.pos_bub(), location );
            path.pop_back(); // Last point is the target
            bool can_attack = true;
            for( const tripoint_bub_ms &path_point : path ) {
                Creature *inter = get_creature_tracker().creature_at( path_point );
                if( inter != nullptr && source.attitude_to( *inter ) == Creature::Attitude::FRIENDLY ) {
                    add_msg_debug( debugmode::debug_filter::DF_NPC, "%s aborted a reach attack; ally in the way",
                                   source.disp_name() );
                    can_attack = false;
                    break;
                }
            }
            if( can_attack ) {
                source.reach_attack( location );
            } else if( can_move_melee( source ) ) {
                source.avoid_friendly_fire();
            } else {
                source.look_for_player( get_player_character() );
            }
        } else {
            source.update_path( location );
            if( source.path.size() > 1 && !source.has_flag( json_flag_CANNOT_MOVE ) ) {
                bool clear_path = can_move_melee( source );
                if( clear_path && source.mem_combat.formation_distance == -1 ) {
                    source.move_to_next();
                    add_msg_debug( debugmode::DF_NPC_MOVEAI,
                                   "<color_light_gray>%s has no nearby ranged allies.  Going for attack.</color>", source.name );
                } else if( clear_path && source.mem_combat.formation_distance > target_distance ) {
                    source.move_to_next();
                    add_msg_debug( debugmode::DF_NPC_MOVEAI,
                                   "<color_light_gray>%s is at least %i away from ranged allies, enemy within %i.  Going for attack.</color>",
                                   source.name, source.mem_combat.formation_distance, target_distance );
                } else if( clear_path &&
                           source.mem_combat.formation_distance > source.closest_enemy_to_friendly_distance() ) {
                    source.move_to_next();
                    //add_msg_debug( debugmode::DF_NPC_MOVEAI,
                    //               "<color_light_gray>%s is at least %i away from allies, enemy within %i of ally.  Going for attack.</color>",
                    //               source.name, source.mem_combat.formation_distance, source.closest_enemy_to_friendly_distance() );
                } else if( source.mem_combat.formation_distance <= source.mem_combat.engagement_distance ) {
                    add_msg_debug( debugmode::DF_NPC_MOVEAI,
                                   "<color_light_gray>%s can't path to melee target, and is staying close to ranged allies.  Stay in place.</color>",
                                   source.name );
                    source.move_pause();
                } else {
                    add_msg_debug( debugmode::DF_NPC_MOVEAI,
                                   "<color_light_gray>%s can't path to melee target, and is not staying close to ranged allies.  Get close to player.</color>",
                                   source.name );
                    source.look_for_player( get_player_character() );
                }
            } else if( source.path.size() == 1 ) {
                if( critter != nullptr ) {
                    if( source.can_use_offensive_cbm() ) {
                        source.activate_bionic_by_id( bio_hydraulics );
                    }
                    add_msg_debug( debugmode::debug_filter::DF_NPC, "%s is attempting a melee attack",
                                   source.disp_name() );
                    source.melee_attack( *critter, true );
                }
            } else if( !source.has_flag( json_flag_CANNOT_MOVE ) ) {
                source.look_for_player( get_player_character() );
            } else {
                source.move_pause();
            }
        }
    } else if( source.mem_combat.formation_distance != -1 &&
               source.mem_combat.formation_distance <= target_distance &&
               rng( NPC_PERSONALITY_MIN, NPC_PERSONALITY_MAX ) > source.personality.aggression ) {
        add_msg_debug( debugmode::DF_NPC_MOVEAI,
                       "<color_light_gray>%s decided to fall back to formation with allies.</color>", source.name );
        source.look_for_player( get_player_character() );
    } else {
        // may wish to add a break here to see if target is out of formation with allies, and consider running back.
        add_msg_debug( debugmode::debug_filter::DF_NPC, "%s is attempting a melee attack",
                       source.disp_name() );
        source.melee_attack( *critter, true );
    }
}

tripoint_range<tripoint_bub_ms> npc_attack_melee::targetable_points( const npc &source ) const
{
    return get_map().points_in_radius( source.pos_bub(), 8 );
}

npc_attack_rating npc_attack_melee::evaluate( const npc &source,
        const Creature *target ) const
{
    npc_attack_rating effectiveness( std::nullopt, source.pos_bub() );
    if( !can_use( source ) ) {
        return effectiveness;
    }
    const int time_penalty = base_time_penalty( source );
    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &targetable_point : targetable_points( source ) ) {
        if( Creature *critter = creatures.creature_at( targetable_point ) ) {
            if( source.attitude_to( *critter ) != Creature::Attitude::HOSTILE ) {
                // no point in swinging a sword at a friendly!
                continue;
            }
            npc_attack_rating effectiveness_at_point = evaluate_critter( source, target, critter );
            effectiveness_at_point -= time_penalty;
            if( effectiveness_at_point > effectiveness ) {
                effectiveness = effectiveness_at_point;
            }
        }
    }
    return effectiveness;
}

std::vector<npc_attack_rating> npc_attack_melee::all_evaluations( const npc &source,
        const Creature *target ) const
{
    std::vector<npc_attack_rating> effectiveness;
    if( !can_use( source ) ) {
        return effectiveness;
    }
    const int time_penalty = base_time_penalty( source );
    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &targetable_point : targetable_points( source ) ) {
        if( Creature *critter = creatures.creature_at( targetable_point ) ) {
            if( source.attitude_to( *critter ) != Creature::Attitude::HOSTILE ) {
                // no point in swinging a sword at a friendly!
                continue;
            }
            npc_attack_rating effectiveness_at_point = evaluate_critter( source, target, critter );
            effectiveness_at_point -= time_penalty;
            effectiveness.push_back( effectiveness_at_point );
        }
    }
    return effectiveness;
}

bool npc_attack_melee::can_use( const npc &source ) const
{
    // can't attack with something you can't wield
    return source.is_wielding( weapon ) || source.can_wield( weapon ).success();
}

int npc_attack_melee::base_time_penalty( const npc &source ) const
{
    return source.is_wielding( weapon ) ? 0 : npc_attack_constants::base_time_penalty;
}

npc_attack_rating npc_attack_melee::evaluate_critter( const npc &source,
        const Creature *target, Creature *critter ) const
{
    if( !critter ) {
        return npc_attack_rating{};
    }

    // Can't melee creatures that are underwater beneath a solid surface
    if( critter->is_underwater() ) {
        const map &here = get_map();
        if( here.has_flag( ter_furn_flag::TFLAG_SWIM_UNDER, critter->pos_bub() ) ) {
            return npc_attack_rating{};
        }
    }

    const double damage = damage_after_armor( weapon.base_damage_melee(), *critter );
    const int reach_range = weapon.reach_range( source ).first;
    const int approach = std::max( 0, rl_dist( source.pos_bub(), critter->pos_bub() ) - reach_range );
    const int attack_moves = std::max( 25, weapon.attack_time( source ) );
    const double hit = std::clamp( 0.5 + ( source.get_melee_hit_base() -
                                         critter->get_dodge_base() ) * 0.08, 0.1, 0.95 );
    double potential = npc_autonomy::attack_utility( damage, hit,
                       attack_moves + approach * 100, critter->get_hp(),
                       source.autonomous_reserved_damage( *critter ), approach * 50 );
    if( damage * hit >= critter->get_hp() ) {
        potential *= npc_attack_constants::kill_modifier;
    }
    if( target == critter ) {
        potential *= npc_attack_constants::target_modifier;
    }
    return npc_attack_rating( static_cast<int>( std::round( potential ) ), critter->pos_bub(),
                              static_cast<int>( std::round( damage * hit ) ) );
}

void npc_attack_gun::use( npc &source, const tripoint_bub_ms &location ) const
{
    if( !source.is_wielding( gun ) ) {
        if( !source.wield( gun ) ) {
            debugmsg( "ERROR: npc tried to equip a weapon it couldn't wield" );
        }
        return;
    }

    if( !gunmode->ammo_sufficient( &source ) ) {
        source.do_reload( form_loc_recursive( source, *gunmode.target ) );
        add_msg_debug( debugmode::debug_filter::DF_NPC, "%s is reloading %s", source.disp_name(),
                       gun.display_name() );
        return;
    }

    if( has_obstruction( source.pos_bub(), location, false ) ||
        ( source.rules.has_flag( ally_rule::avoid_friendly_fire ) &&
          !source.wont_hit_friend( location, *gunmode, false ) ) ) {
        if( can_move( source ) ) {
            source.avoid_friendly_fire();
        } else {
            source.move_pause();
        }
        return;
    }

    source.autonomous_announce( "attack", _( "I'll cover you with my gun." ) );
    const Target_attributes target( source.pos_bub(), location );
    const aim_mods_cache aim_cache = source.gen_aim_mods_cache( *gunmode );
    // Stop aiming once this shot meets the requested confidence, not only at zero recoil.
    while( target.range > 1 && source.get_moves() > 0 &&
           source.confident_gun_mode_range( gunmode, source.recoil ) < target.range ) {
        const double improvement = source.aim_per_move( *gunmode, source.recoil, target, aim_cache );
        if( improvement <= MIN_RECOIL_IMPROVEMENT ) {
            break;
        }
        source.recoil = std::max( 0.0, source.recoil - improvement );
        source.mod_moves( -1 );
    }
    if( source.get_moves() <= 0 ) {
        return;
    }
    for( const auto &mode : gun.gun_all_modes() ) {
        if( mode.second.target == gunmode.target && mode.second.qty == gunmode.qty &&
            mode.second.flags == gunmode.flags ) {
            gun.gun_set_mode( mode.first );
            break;
        }
    }
    if( source.is_hallucination() ) {
        source.pretend_fire( &source, gunmode.qty, *gunmode.target );
    } else {
        source.fire_gun( get_map(), location, gunmode.qty, *gunmode.target, item_location() );
    }
    add_msg_debug( debugmode::debug_filter::DF_NPC, "%s fires %s", source.disp_name(),
                   gun.display_name() );
}

bool npc_attack_gun::can_use( const npc &source ) const
{
    if( !source.is_wielding( gun ) && !source.can_wield( gun ).success() ) {
        return false;
    }
    return gunmode->ammo_sufficient( &source ) ||
           static_cast<bool>( source.find_usable_ammo(
                                  form_loc_recursive( const_cast<npc &>( source ), *gunmode.target ) ) );
}

int npc_attack_gun::base_time_penalty( const npc &source ) const
{
    const item &weapon = *gunmode;
    int time_penalty = 0;
    if( !source.is_wielding( gun ) ) {
        time_penalty += npc_attack_constants::base_time_penalty;
    }
    // we want the need to reload a gun cumulative with needing to wield the gun
    if( !weapon.ammo_sufficient( &source ) ) {
        time_penalty += npc_attack_constants::base_time_penalty;
    }
    return time_penalty;
}

tripoint_range<tripoint_bub_ms> npc_attack_gun::targetable_points( const npc &source ) const
{
    const item &weapon = *gunmode;
    int range = weapon.gun_range( &source );
    if( !weapon.ammo_sufficient( &source ) ) {
        const item_location ammo = source.find_usable_ammo(
                                       form_loc_recursive( const_cast<npc &>( source ), *gunmode.target ) );
        if( ammo ) {
            item prepared( weapon );
            prepared.ammo_set( ammo->ammo_current(), 1 );
            range = prepared.gun_range( &source );
        }
    }
    return get_map().points_in_radius( source.pos_bub(), range );
}

std::vector<tripoint_bub_ms> npc_attack_gun::targetable_creatures( const npc &source ) const
{
    const auto bounds = targetable_points( source );
    const tripoint_bub_ms minimum = bounds.min();
    const tripoint_bub_ms maximum = bounds.max();
    creature_tracker &tracker = get_creature_tracker();
    std::vector<tripoint_bub_ms> positions;
    const auto &monsters = tracker.get_monsters_list();
    const size_t creature_count = monsters.size() + tracker.active_npc.size() + 1;
    if( bounds.size() <= creature_count ) {
        // Tiny ranges in dense crowds are cheaper to scan than the whole creature list.
        for( const tripoint_bub_ms &p : bounds ) {
            if( tracker.creature_at( p ) ) {
                positions.push_back( p );
            }
        }
        return positions;
    }
    positions.reserve( creature_count );
    const auto consider = [&]( const Creature &critter ) {
        const tripoint_bub_ms p = critter.pos_bub();
        if( p.x() < minimum.x() || p.x() > maximum.x() ||
            p.y() < minimum.y() || p.y() > maximum.y() ||
            p.z() < minimum.z() || p.z() > maximum.z() || critter.is_dead_state() ) {
            return;
        }
        // Preserve the original tracker lookup, including riders and hallucination filtering.
        if( tracker.creature_at( p ) ) {
            positions.push_back( p );
        }
    };
    for( const auto &mon : monsters ) {
        if( mon ) {
            consider( *mon );
        }
    }
    for( const auto &person : tracker.active_npc ) {
        if( person ) {
            consider( *person );
        }
    }
    consider( get_player_character() );
    // Equal attack scores retain the original x-then-y-then-z tile traversal order.
    std::sort( positions.begin(), positions.end(), []( const tripoint_bub_ms &a,
    const tripoint_bub_ms &b ) {
        if( a.z() != b.z() ) {
            return a.z() < b.z();
        }
        return a.y() != b.y() ? a.y() < b.y() : a.x() < b.x();
    } );
    positions.erase( std::unique( positions.begin(), positions.end() ), positions.end() );
    return positions;
}

npc_attack_rating npc_attack_gun::evaluate(
    const npc &source, const Creature *target ) const
{
    npc_attack_rating effectiveness( std::nullopt, source.pos_bub() );
    if( !can_use( source ) ) {
        return effectiveness;
    }
    const int time_penalty = base_time_penalty( source );
    for( const tripoint_bub_ms &point : targetable_creatures( source ) ) {
        npc_attack_rating evaluated = evaluate_tripoint( source, target, point );
        evaluated -= time_penalty;
        if( evaluated > effectiveness ) {
            effectiveness = evaluated;
        }
    }
    return effectiveness;
}

std::vector<npc_attack_rating> npc_attack_gun::all_evaluations( const npc &source,
        const Creature *target ) const
{
    std::vector<npc_attack_rating> effectiveness;
    if( !can_use( source ) ) {
        return effectiveness;
    }
    const int time_penalty = base_time_penalty( source );
    const auto positions = targetable_creatures( source );
    effectiveness.reserve( positions.size() );
    for( const tripoint_bub_ms &point : positions ) {
        npc_attack_rating evaluated = evaluate_tripoint( source, target, point );
        evaluated -= time_penalty;
        effectiveness.push_back( evaluated );
    }
    return effectiveness;
}

npc_attack_rating npc_attack_gun::evaluate_tripoint(
    const npc &source, const Creature *target, const tripoint_bub_ms &location ) const
{
    const Creature *critter = get_creature_tracker().creature_at( location );
    if( !critter || !source.sees( get_map(), *critter ) ||
        source.attitude_to( *critter ) != Creature::Attitude::HOSTILE ) {
        return npc_attack_rating( std::nullopt, location );
    }
    const item *weapon = gunmode.target;
    std::optional<item> prepared;
    int reload_moves = 0;
    if( !weapon->ammo_sufficient( &source ) ) {
        const item_location ammo = source.find_usable_ammo(
                                       form_loc_recursive( const_cast<npc &>( source ), *gunmode.target ) );
        if( !ammo ) {
            return npc_attack_rating( std::nullopt, location );
        }
        reload_moves = source.item_reload_cost( *weapon, *ammo,
                       ammo->is_magazine() ? ammo->ammo_remaining() : 1 );
        prepared.emplace( *weapon );
        prepared->ammo_set( ammo->ammo_current(), ammo->is_magazine() ? ammo->ammo_remaining() : 1 );
        weapon = &*prepared;
    }
    const int distance = rl_dist( source.pos_bub(), location );
    if( distance > weapon->gun_range( &source ) ) {
        return npc_attack_rating( std::nullopt, location );
    }
    const bool avoids_friendly_fire = source.rules.has_flag( ally_rule::avoid_friendly_fire );
    const bool obstructed = has_obstruction( source.pos_bub(), location, avoids_friendly_fire ) ||
                            ( avoids_friendly_fire && !source.wont_hit_friend( location, *weapon, false ) );
    // An immobile shooter cannot resolve a blocked firing lane by sidestepping.
    if( obstructed && !can_move( source ) ) {
        return npc_attack_rating( std::nullopt, location );
    }
    const int shots = std::min( gunmode.qty, weapon->shots_remaining( get_map(), &source ) );
    const double damage = damage_after_armor( weapon->gun_damage(), *critter ) * shots;
    const int aim_recoil = source.most_accurate_aiming_method_limit( *weapon );
    const double hit = npc_autonomy::hit_estimate( distance,
                       source.confident_gun_mode_range( gunmode, aim_recoil ), critter->ranged_target_size() );
    // One native aim calculation, rather than simulating every aiming move per candidate.
    const Target_attributes attributes( source.pos_bub(), location );
    const aim_mods_cache cache = source.gen_aim_mods_cache( *weapon );
    const int starting_recoil = source.is_wielding( gun ) ? source.recoil : MAX_RECOIL;
    const double gain = source.aim_per_move( *weapon, starting_recoil, attributes, cache );
    const bool needs_aim = distance > 1 &&
                           source.confident_gun_mode_range( gunmode, starting_recoil ) < distance;
    const int aim_moves = needs_aim && gain > MIN_RECOIL_IMPROVEMENT ?
                         std::clamp( static_cast<int>( std::ceil( std::max( 0, starting_recoil - aim_recoil ) /
                                     gain ) ), 0, 300 ) : 0;
    const int preparation = reload_moves + aim_moves + ( source.is_wielding( gun ) ? 0 : 100 );
    const int approach_moves = std::max( 0, distance - 2 ) * 100 * std::max( 1, source.get_speed() ) /
                               std::max( 1, critter->get_speed() );
    const int firing_moves = 100 + std::max( 0, shots - 1 ) * 10;
    const int exposure = std::max( 0, preparation + firing_moves - approach_moves );
    double potential = npc_autonomy::attack_utility( damage, hit, preparation + firing_moves,
                       critter->get_hp(), source.autonomous_reserved_damage( *critter ), exposure );
    if( obstructed ) {
        potential *= 0.25;
    }
    if( damage * hit >= critter->get_hp() ) {
        potential *= npc_attack_constants::kill_modifier;
    }
    if( target == critter ) {
        potential *= npc_attack_constants::target_modifier;
    }
    return npc_attack_rating( static_cast<int>( std::round( potential ) ), location,
                              static_cast<int>( std::round( damage * hit ) ) );
}

void npc_attack_activate_item::use( npc &source, const tripoint_bub_ms &/*location*/ ) const
{
    if( !source.wield( activatable_item ) ) {
        debugmsg( "%s can't wield %s it tried to activate", source.disp_name(),
                  activatable_item.display_name() );
        return;
    }
    // npc::wield may invalidate activatable_item's reference
    source.activate_item( *source.get_wielded_item() );
}

bool npc_attack_activate_item::can_use( const npc &source ) const
{
    if( !activatable_item.has_flag( flag_NPC_ACTIVATE ) ) {
        //TODO: make this more complete. only does BOMB type items
        return false;
    }
    const bool can_use_grenades = !source.is_hallucination() && ( !source.is_player_ally() ||
        source.rules.has_flag( ally_rule::use_grenades ) );
    return can_use_grenades;
}

npc_attack_rating npc_attack_activate_item::evaluate(
    const npc &source, const Creature * /*target*/ ) const
{
    if( !can_use( source ) ) {
        return npc_attack_rating( std::nullopt, source.pos_bub() );
    }
    // until we have better logic for grenades it's better to keep this as a last resort...
    const int emergency = source.emergency() ? 1 : 0;
    return npc_attack_rating( emergency, source.pos_bub() );
}

std::vector<npc_attack_rating> npc_attack_activate_item::all_evaluations( const npc &source,
        const Creature * /*target*/ ) const
{
    std::vector<npc_attack_rating> effectiveness;
    if( !can_use( source ) ) {
        return effectiveness;
    }
    // until we have better logic for grenades it's better to keep this as a last resort...
    const int emergency = source.emergency() ? 1 : 0;
    effectiveness.emplace_back( emergency, source.pos_bub() );
    return effectiveness;
}

void npc_attack_throw::use( npc &source, const tripoint_bub_ms &location ) const
{
    const item_location wielded_item = source.get_wielded_item();
    const bool keep_wielded = wielded_item && !source.is_wielding( thrown_item ) &&
                              wielded_item->has_flag( flag_THROW_KEEP_WIELDED );

    if( !source.is_wielding( thrown_item ) && !keep_wielded ) {
        if( !source.wield( thrown_item ) ) {
            debugmsg( "ERROR: npc tried to equip a weapon it couldn't wield" );
        }
        return;
    }

    if( has_obstruction( source.pos_bub(), location, false ) ||
        ( source.rules.has_flag( ally_rule::avoid_friendly_fire ) &&
          !source.wont_hit_friend( location, thrown_item, true ) ) ) {
        if( can_move( source ) ) {
            source.avoid_friendly_fire();
        } else {
            source.move_pause();
        }
        return;
    }

    if( keep_wielded ) {
        add_msg_debug( debugmode::debug_filter::DF_NPC, "%s throws the %s with the %s",
                       source.disp_name(), thrown_item.display_name(),
                       wielded_item->display_name() );
        item thrown( thrown_item );
        if( thrown_item.count_by_charges() && thrown_item.charges > 1 ) {
            thrown_item.mod_charges( -1 );
            thrown.charges = 1;
        } else {
            source.i_rem( &thrown_item );
        }
        source.throw_item( location, thrown );
    } else {
        item_location weapon = source.get_wielded_item();
        add_msg_debug( debugmode::debug_filter::DF_NPC, "%s throws the %s", source.disp_name(),
                       weapon->display_name() );
        item thrown( *weapon );
        if( weapon->count_by_charges() && weapon->charges > 1 ) {
            weapon->mod_charges( -1 );
            thrown.charges = 1;
        } else {
            source.remove_weapon();
        }
        source.throw_item( location, thrown );
    }
}

bool npc_attack_throw::can_use( const npc &source ) const
{
    // Don't throw anything if we're hallucination
    // TODO: make an analogue of pretend_fire function
    if( source.is_hallucination() ) {
        return false;
    }

    const item_location wielded_item = source.get_wielded_item();
    const bool keep_wielded = wielded_item && !source.is_wielding( thrown_item ) &&
                              wielded_item->has_flag( flag_THROW_KEEP_WIELDED );
    if( !source.is_wielding( thrown_item ) && !keep_wielded &&
        !source.can_wield( thrown_item ).success() ) {
        return false;
    }

    item single_item( thrown_item );
    if( single_item.count_by_charges() ) {
        single_item.charges = 1;
    }

    // Always allow throwing items that are flagged as throw now to
    // get rid of dangerous items ASAP, even if ranged attacks aren't allowed
    if( thrown_item.has_flag( flag_NPC_THROW_NOW ) ) {
        return true;
    }

    if( source.is_player_ally() && !source.rules.has_flag( ally_rule::use_guns ) ) {
        return false;
    }

    // Items flagged as NPC_THROWN are always allowed
    if( thrown_item.has_flag( flag_NPC_THROWN ) ) {
        return true;
    }

    bool throwable = source.throw_range( single_item ) > 0 && !source.is_worn( thrown_item ) &&
                     !thrown_item.has_flag( flag_NPC_ACTIVATE );
    throwable = throwable && !thrown_item.is_gun() && !thrown_item.is_armor() &&
                !thrown_item.is_comestible() && !thrown_item.is_magazine() && !thrown_item.is_tool();
    // TODO: Better choose what should be thrown
    return throwable;
}

int npc_attack_throw::base_penalty( const npc &source ) const
{
    item single_item( thrown_item );
    if( single_item.count_by_charges() ) {
        single_item.charges = 1;
    }
    const item_location wielded_item = source.get_wielded_item();
    const bool keep_wielded = wielded_item && !source.is_wielding( thrown_item ) &&
                              wielded_item->has_flag( flag_THROW_KEEP_WIELDED );
    const int time_penalty = ( source.is_wielding( single_item ) || keep_wielded ) ? 0 :
                             npc_attack_constants::base_time_penalty;

    return time_penalty;
}

tripoint_range<tripoint_bub_ms> npc_attack_throw::targetable_points( const npc &source ) const
{
    item single_item( thrown_item );
    if( single_item.count_by_charges() ) {
        single_item.charges = 1;
    }
    const int range = source.throw_range( single_item );
    return get_map().points_in_radius( source.pos_bub(), range );
}

npc_attack_rating npc_attack_throw::evaluate(
    const npc &source, const Creature *target ) const
{
    npc_attack_rating effectiveness( std::nullopt, source.pos_bub() );
    if( !can_use( source ) ) {
        // please don't throw your pants...
        return effectiveness;
    }
    const temp_crafting_inventory &available_weapons = source.crafting_inventory( tripoint_bub_ms::zero,
        -1 );
    if( &thrown_item == best_weapon &&
        available_weapons.amount_of( thrown_item.typeId() ) <= 1 &&
        available_weapons.charges_of( thrown_item.typeId() ) <= 1 ) {
        // Don't throw if it's the best individual killy-thing we've got
        return effectiveness;
    }
    const int penalty = base_penalty( source );
    const bool throw_now = thrown_item.has_flag( flag_NPC_THROW_NOW );
    // TODO: Should this be a field to cache the result?
    const bool avoids_friendly_fire = source.rules.has_flag( ally_rule::avoid_friendly_fire );
    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &potential : targetable_points( source ) ) {

        // hot potato! HOT POTATO!
        // Calculated for all targetable points, not just those with targets
        if( throw_now ) {
            // TODO: Take into account distance to allies too
            const int distance_to_me = rl_dist( potential, source.pos_bub() );
            int result = npc_attack_constants::base_throw_now + distance_to_me;
            if( !has_obstruction( source.pos_bub(), potential, avoids_friendly_fire ) ) {
                // More likely to pick a target tile that isn't obstructed
                result += 100;
            }
            return npc_attack_rating( result, potential );
        }

        if( Creature *critter = creatures.creature_at( potential ) ) {
            if( source.attitude_to( *critter ) != Creature::Attitude::HOSTILE ) {
                // no point in friendly fire!
                continue;
            }
            npc_attack_rating effectiveness_at_point = evaluate_tripoint( source, target,
                potential );
            effectiveness_at_point -= penalty;
            if( effectiveness_at_point > effectiveness ) {
                effectiveness = effectiveness_at_point;
            }
        }
    }
    return effectiveness;
}

std::vector<npc_attack_rating> npc_attack_throw::all_evaluations( const npc &source,
        const Creature *target ) const
{
    std::vector<npc_attack_rating> effectiveness;
    if( !can_use( source ) ) {
        // please don't throw your pants...
        return effectiveness;
    }
    const int penalty = base_penalty( source );
    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &potential : targetable_points( source ) ) {
        if( Creature *critter = creatures.creature_at( potential ) ) {
            if( source.attitude_to( *critter ) != Creature::Attitude::HOSTILE ) {
                // no point in friendly fire!
                continue;
            }
            npc_attack_rating effectiveness_at_point = evaluate_tripoint( source, target,
                potential );
            effectiveness_at_point -= penalty;
            effectiveness.push_back( effectiveness_at_point );
        }
    }
    return effectiveness;
}

npc_attack_rating npc_attack_throw::evaluate_tripoint(
    const npc &source, const Creature *target, const tripoint_bub_ms &location ) const
{
    if( has_obstruction( source.pos_bub(), location ) ) {
        return npc_attack_rating( std::nullopt, location );
    }
    item single_item( thrown_item );
    if( single_item.count_by_charges() ) {
        single_item.charges = 1;
    }

    Creature::Attitude att = Creature::Attitude::NEUTRAL;
    const Creature *critter = get_creature_tracker().creature_at( location );
    if( critter ) {
        att = source.attitude_to( *critter );
    }

    if( att != Creature::Attitude::HOSTILE ) {
        // No point in throwing stuff at neutral/friendly targets
        return npc_attack_rating( std::nullopt, location );
    }

    if( source.rules.has_flag( ally_rule::avoid_friendly_fire ) &&
        !source.wont_hit_friend( location, thrown_item, true ) ) {
        // Avoid friendy fire
        return npc_attack_rating( std::nullopt, location );
    }

    const float throw_mult = throw_cost( source, single_item ) * source_speed_rating / 100.0f;
    const int damage = source.thrown_item_total_damage_raw( single_item );
    float dps = damage / throw_mult;
    const int distance_to_me = rl_dist( location, source.pos_bub() );
    float suitable_item_mult = -0.15f;
    if( distance_to_me > 1 ) {
        if( thrown_item.has_flag( flag_NPC_THROWN ) ) {
            suitable_item_mult = 0.08f * std::min( distance_to_me - 1, 5 );
        }
        const item_location wielded_item = source.get_wielded_item();
        if( wielded_item && !source.is_wielding( thrown_item ) &&
            wielded_item->has_flag( flag_THROW_KEEP_WIELDED ) ) {
            suitable_item_mult += 0.10f;
        }
    } else {
        suitable_item_mult = -0.35f;
    }

    double potential = dps * ( 1.0 + suitable_item_mult );
    if( potential > 0.0f && critter && damage >= critter->get_hp() ) {
        potential *= npc_attack_constants::kill_modifier;
    }
    if( potential > 0.0f && target && critter && target->pos_bub() == critter->pos_bub() ) {
        potential *= npc_attack_constants::target_modifier;
    }
    return npc_attack_rating( static_cast<int>( std::round( potential ) ), location );
}
