#pragma once
#ifndef CATA_SRC_MONSTER_DANGER_SEARCH_H
#define CATA_SRC_MONSTER_DANGER_SEARCH_H

#include <cstdlib>

#include "game_constants.h"
#include "line.h"
#include "map_scale_constants.h"
#include "monfaction.h"
#include "point.h"

// Values captured on the owner. No worker follows a creature or faction pointer.
struct monster_danger_candidate {
    tripoint position;
    mf_attitude attitude = MFA_NEUTRAL;
    bool character = false;
    bool character_hostile = false;
    bool angry = false;
    bool hallucination = false;
};

inline bool monster_danger_group_possible( mf_attitude attitude, bool contains_character )
{
    return contains_character || attitude == MFA_HATE || attitude == MFA_BY_MOOD;
}

inline bool monster_danger_possible( const tripoint &origin,
                                    const monster_danger_candidate &candidate, bool circular_distance )
{
    if( candidate.hallucination ||
        ( candidate.character ? !candidate.character_hostile :
          candidate.attitude != MFA_HATE && !( candidate.attitude == MFA_BY_MOOD && candidate.angry ) ) ) {
        return false;
    }
    if( std::abs( origin.z - candidate.position.z ) > fov_3d_z_range ) {
        return false;
    }
    // Match Creature::sees, including rl_dist's integer truncation.
    const int distance = circular_distance ? static_cast<int>( trig_dist( origin, candidate.position ) ) :
                         square_dist( origin, candidate.position );
    return distance <= MAX_VIEW_DISTANCE;
}

#endif // CATA_SRC_MONSTER_DANGER_SEARCH_H
