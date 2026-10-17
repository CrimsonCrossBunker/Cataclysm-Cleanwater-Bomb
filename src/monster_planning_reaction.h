#pragma once
#ifndef CATA_SRC_MONSTER_PLANNING_REACTION_H
#define CATA_SRC_MONSTER_PLANNING_REACTION_H

#include <cfloat>

struct monster_planning_values {
    int anger = 0;
    int morale = 0;
};

struct monster_planning_reaction {
    monster_planning_values values;
    bool draw_aggro = false;
    int denominator = 100;
};

// These policies observe numbers only. The owner applies each result at the
// original effect point and resolves a requested RNG draw before its next query.
inline monster_planning_values react_to_seen_hostile( monster_planning_values current,
        int anger_seen, int fear_seen, bool fleeing, bool has_target )
{
    if( !fleeing && has_target ) {
        if( current.anger <= 20 ) {
            current.anger += anger_seen;
        }
        current.morale -= fear_seen;
    }
    return current;
}

inline monster_planning_reaction react_to_near_hostile( monster_planning_values current,
        int anger_near, int fear_near )
{
    if( current.anger <= 30 ) {
        current.anger += anger_near;
    }
    current.morale -= fear_near;
    return { current, anger_near != 0, 100 };
}

inline monster_planning_reaction react_to_hostile_sighting( monster_planning_values current,
        int anger_seen, bool fleeing )
{
    return { current, !fleeing &&anger_seen != 0, 200 };
}

inline monster_planning_reaction react_to_mating_season( monster_planning_values current,
        int anger_mating, bool season_active )
{
    if( anger_mating > 0 && current.anger <= 30 && season_active ) {
        current.anger += anger_mating;
        return { current, true, 100 };
    }
    return { current, false, 100 };
}

inline monster_planning_values react_to_threatened_cub( monster_planning_values current,
        int anger_cub )
{
    current.anger += anger_cub;
    current.morale += anger_cub / 2;
    return current;
}

inline monster_planning_reaction react_to_weak_target( monster_planning_values current,
        int hp_percent, bool anger_weak, bool fear_weak, bool placate_weak )
{
    if( hp_percent <= 70 ) {
        const int change = 10 - static_cast<int>( hp_percent / 10 );
        if( anger_weak && current.anger <= 40 ) {
            current.anger += change;
            return { current, true, 100 };
        } else if( fear_weak ) {
            current.morale -= change;
        } else if( placate_weak ) {
            current.anger -= change;
        }
    }
    return { current, false, 100 };
}

inline int morale_after_group_observation( int morale, float rating, bool group_morale )
{
    if( group_morale && rating <= 10 ) {
        // Preserve float addition followed by conversion of the whole sum;
        // truncating the delta first differs for negative morale.
        morale += 10 - rating;
    }
    return morale;
}

enum class monster_swarm_action {
    none,
    disperse,
    follow_ally
};

inline monster_swarm_action choose_monster_swarm_action( float rating, float best,
        int wander_turns, bool swarms )
{
    if( swarms ) {
        if( rating < 5 ) {
            return monster_swarm_action::disperse;
        } else if( rating < FLT_MAX && rating > best && wander_turns <= 0 ) {
            return monster_swarm_action::follow_ally;
        }
    }
    return monster_swarm_action::none;
}

#endif // CATA_SRC_MONSTER_PLANNING_REACTION_H
