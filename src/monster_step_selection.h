#pragma once
#ifndef CATA_SRC_MONSTER_STEP_SELECTION_H
#define CATA_SRC_MONSTER_STEP_SELECTION_H

#include "coordinates.h"

// One candidate at a time: the owner still queries terrain/creatures and performs
// unlock/shove effects in their existing order. These values contain no borrowed
// world state. Evaluation neither queries the world nor consumes its RNG.
struct monster_step_selection {
    bool selected = false;
    tripoint_abs_ms destination;
    float switch_chance = 0.0f;
};

enum class monster_step_kind {
    attack,
    door,
    weighted
};

struct monster_step_candidate {
    tripoint_abs_ms destination;
    monster_step_kind kind = monster_step_kind::weighted;
    float progress = 0.0f;
    bool bad_choice = false;
};

struct monster_step_proposal {
    monster_step_selection next;
    tripoint_abs_ms candidate;
    bool select_without_draw = false;
    bool needs_draw = false;
    bool stop_if_selected = false;
    float numerator = 0.0f;
};

inline monster_step_proposal propose_monster_step( const monster_step_selection &current,
        const monster_step_candidate &candidate, bool staggers, bool pathed )
{
    monster_step_proposal result{ current, candidate.destination };
    if( candidate.kind != monster_step_kind::weighted ) {
        result.select_without_draw = true;
        result.stop_if_selected = candidate.kind == monster_step_kind::attack;
        return result;
    }

    // Retain even non-positive contributions and the original float arithmetic.
    result.next.switch_chance += candidate.progress * 2;
    if( candidate.progress > 0 ) {
        result.select_without_draw = !current.selected;
        result.needs_draw = current.selected;
        result.numerator = candidate.progress;
        result.stop_if_selected = !staggers && ( !candidate.bad_choice || pathed );
    }
    return result;
}

inline monster_step_selection resolve_monster_step( const monster_step_proposal &proposal,
        bool draw_succeeded )
{
    monster_step_selection result = proposal.next;
    if( proposal.select_without_draw || ( proposal.needs_draw && draw_succeeded ) ) {
        result.selected = true;
        result.destination = proposal.candidate;
    }
    return result;
}

#endif // CATA_SRC_MONSTER_STEP_SELECTION_H
