#pragma once
#ifndef CATA_SRC_NPC_AUTONOMY_H
#define CATA_SRC_NPC_AUTONOMY_H

#include <algorithm>
#include <cstdint>
#include <map>
#include <optional>
#include <string>

#include "calendar.h"
#include "character_id.h"
#include "coordinates.h"
#include "item_location.h"
#include "memory_fast.h"
#include "type_id.h"

class Creature;

enum class npc_autonomy_task { none, equipment, organize, share, deposit };

struct npc_autonomy_plan {
    npc_autonomy_task task = npc_autonomy_task::none;
    item_location source;
    item_location target;
    std::optional<character_id> recipient;
    tripoint_abs_ms destination = tripoint_abs_ms::invalid;
    bool target_required = false;
    int quantity = 0;
    int work_done = 0;
    int work_required = 0;
    time_point expires = calendar::before_time_starts;
};

// Transient planning data: no ownership of live items and no serialized policy changes.
struct npc_autonomy_state {
    time_point inventory_checked = calendar::before_time_starts;
    time_point maintenance_checked = calendar::before_time_starts;
    time_point equipment_checked = calendar::before_time_starts;
    time_point loot_checked = calendar::before_time_starts;
    time_point supplies_checked = calendar::before_time_starts;
    time_point pockets_checked = calendar::before_time_starts;
    time_point tactics_checked = calendar::before_time_starts;
    time_point recovering_until = calendar::before_time_starts;
    time_point withdrawing_until = calendar::before_time_starts;
    time_point follow_checked = calendar::before_time_starts;
    std::optional<tripoint_abs_ms> follow_goal;
    std::optional<tripoint_abs_ms> tactical_goal;
    std::optional<tripoint_abs_ms> tactical_enemy;
    npc_autonomy_plan plan;
    item_location weapon_goal;
    time_point weapon_goal_until = calendar::before_time_starts;
    item_location failed_weapon;
    time_point failed_weapon_until = calendar::before_time_starts;
    std::map<itype_id, int> quantities;
    std::map<quality_id, int> tool_qualities;
    std::map<ammotype, int> ammunition;
    std::map<ammotype, int> ammo_targets;
    int food_kcal = 0;
    int water_quench = 0;
    int healing_units = 0;
    int food_target = 2400;
    int water_target = 240;
    int healing_target = 6;
    int magazine_target = 2;
    bool air_hazard = false;
    std::string decision;
    time_point decision_until = calendar::before_time_starts;
    std::map<std::string, time_point> failed_actions;
    std::map<std::string, time_point> serviced_actions;
    weak_ptr_fast<Creature> attack_target;
    time_point attack_until = calendar::before_time_starts;
    int committed_damage = 0;
    time_point position_until = calendar::before_time_starts;
    std::optional<tripoint_abs_ms> seat_goal;
    time_point seat_until = calendar::before_time_starts;
    std::map<tripoint_abs_ms, time_point> failed_seats;
    std::optional<tripoint_abs_ms> search_origin;
    std::optional<tripoint_abs_ms> search_goal;
    std::map<tripoint_abs_ms, time_point> searched_positions;
    time_point search_checked = calendar::before_time_starts;
    time_point leader_seen = calendar::before_time_starts;
    int equipment_cursor = 0;
    int maintenance_cursor = 0;
    time_point announcement_checked = calendar::before_time_starts;
    std::map<std::string, time_point> announced_actions;
    std::map<tripoint_abs_ms, time_point> failed_loot;
    std::optional<character_id> rescue_patient;
    time_point rescue_until = calendar::before_time_starts;
    std::string reason;
};

namespace npc_autonomy
{
// Shared arbitration for survival and maintenance; emergencies always outrank commitment.
inline double action_score( double urgency, int move_cost, double risk, bool committed,
                            int waiting_seconds = 0 )
{
    const double priority = std::clamp( urgency, 0.0, 1.0 );
    return priority * 1000.0 + ( priority >= 0.85 ? 1000.0 : 0.0 ) +
           ( committed ? 60.0 : 0.0 ) + std::clamp( waiting_seconds, 0, 600 ) -
           std::min( 150.0, std::max( 0, move_cost ) / 20.0 ) -
           std::clamp( risk, 0.0, 1.0 ) * 500.0;
}

inline double hit_estimate( int distance, int confident_range, double target_size )
{
    const double ratio = std::max( 1, confident_range ) *
                         std::clamp( target_size / 0.5, 0.25, 2.0 ) / std::max( 1, distance );
    return std::clamp( 0.5 * ratio * ratio, 0.02, 0.98 );
}

inline double attack_utility( double effective_damage, double hit_chance, int action_moves,
                              int target_hp, int reserved_damage, int exposure_moves )
{
    const double expected = std::max( 0.0, effective_damage ) * std::clamp( hit_chance, 0.0, 1.0 );
    const double useful = std::min( expected, static_cast<double>( std::max( 1, target_hp ) ) );
    // Saturation is a preference, not an exclusive claim: never forbid a necessary attack.
    const double saturation = reserved_damage >= target_hp ? 0.35 : 1.0;
    return useful * 100.0 / std::max( 25, action_moves ) * saturation /
           ( 1.0 + std::max( 0, exposure_moves ) / 200.0 );
}

inline double effective_damage( double amount, double armor, double penetration,
                                double armor_multiplier, double damage_multiplier )
{
    return std::max( 0.0, amount - std::max( 0.0, armor - penetration ) *
                     std::max( 0.0, armor_multiplier ) ) * std::max( 0.0, damage_multiplier );
}

inline int expedition_stock( int daily, bool expedition )
{
    return std::max( 0, daily ) * ( expedition ? 2 : 1 );
}

// Quotas use whole charges, never discard the remainder of a ground stack.
inline int missing_units( int current, int target, int per_unit = 1 )
{
    if( per_unit <= 0 || current >= target ) {
        return 0;
    }
    return ( target - current + per_unit - 1 ) / per_unit;
}
inline bool action_window( int distance, int own_speed, int enemy_speed, int move_cost )
{
    if( distance <= 2 || own_speed <= 0 || enemy_speed <= 0 || move_cost < 0 ) {
        return false;
    }
    // Reserve two tiles and a full reaction turn; use 64-bit arithmetic for long tasks.
    return static_cast<std::int64_t>( distance - 2 ) * 100 * own_speed >
           ( static_cast<std::int64_t>( move_cost ) + own_speed ) * enemy_speed;
}
inline time_duration cadence( time_duration base, int identity )
{
    return base + time_duration::from_seconds( std::max( 0, identity ) % 5 );
}

inline int balanced_units( int donor, int recipient, int per_unit = 1 )
{
    if( per_unit <= 0 || donor <= recipient ) {
        return 0;
    }
    return static_cast<int>( ( static_cast<std::int64_t>( donor ) - recipient ) /
                             ( 2LL * per_unit ) );
}

inline int work_slice( int available, int required, int done )
{
    return std::min( { std::max( 0, available ), 100, std::max( 0, required - done ) } );
}

inline int care_priority( int lowest_hp_percent, bool bleeding, bool infected, bool bitten )
{
    const int hp = std::clamp( lowest_hp_percent, 0, 100 );
    return std::max( { hp < 25 ? 1000 : ( 100 - hp ) * 7,
                       bleeding ? 850 : 0, infected ? 750 : 0, bitten ? 550 : 0 } );
}

// Compare the first useful attack, including retrieval and closing to weapon range.
inline double combat_weapon_value( double value, int distance, int range, int preparation_moves )
{
    const double closing_moves = std::max( 0, distance - std::max( 1, range ) ) * 100.0;
    // Closing both delays our first attack and exposes us to approaching enemies.
    return std::max( 0.0, value ) * 100.0 /
           ( 100.0 + std::max( 0, preparation_moves ) + closing_moves * 2.0 );
}

inline bool worthwhile_upgrade( double current, double candidate )
{
    return candidate > current + 3.0 && candidate > current * 1.15;
}
}

#endif // CATA_SRC_NPC_AUTONOMY_H
