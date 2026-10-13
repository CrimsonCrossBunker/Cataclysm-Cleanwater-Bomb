#pragma once
#ifndef CATA_SRC_MONSTER_MOVEMENT_PLAN_H
#define CATA_SRC_MONSTER_MOVEMENT_PLAN_H

#include <cstddef>
#include <optional>

#include "calendar.h"
#include "coordinates.h"
#include "safe_reference.h"
#include "type_id.h"

class Creature;
class map;
class monster;
class vehicle;
struct mtype;

struct monster_movement_proposal {
    tripoint_abs_ms step;
    tripoint_bub_ms goal;
    bool pacified = false;
    bool can_open_doors = false;
};

enum class monster_movement_result {
    acted,
    blocked,
    stale,
    cancelled
};

/**
 * Method to make monster movement speed consistent in the face of staggering behavior and
 * differing distance metrics.
 * It works by scaling the cost to take a step by
 * how much that step reduces the distance to your goal.
 * Since it incorporates the current distance metric,
 * it also scales for diagonal vs orthogonal movement.
 **/
float monster_stagger_adjustment( const tripoint_bub_ms &source, const tripoint_bub_ms &goal,
                                  const tripoint_bub_ms &step, bool use_trig_distance );

// Owner-only commit envelope. Capture after the sequenced candidate scan has
// performed its unlock/shove effects. Only the numeric proposal can be handed
// to preparation work; all world/creature/vehicle references remain on the owner.
class monster_movement_plan
{
    public:
        monster_movement_plan( monster &source, map &here, monster_movement_proposal proposal );
        monster_movement_plan( const monster_movement_plan & ) = delete;
        monster_movement_plan &operator=( const monster_movement_plan & ) = delete;
        monster_movement_proposal proposal() const {
            return proposal_;
        }
        monster_movement_result commit( const monster_movement_proposal &proposal, map &here );
        void cancel() {
            consumed_ = true;
        }
    private:
        safe_reference<Creature> source_;
        safe_reference<Creature> occupant_;
        safe_reference<map> map_;
        safe_reference<vehicle> vehicle_;
        monster_movement_proposal proposal_;
        tripoint_abs_ms source_position_;
        tripoint_abs_sm origin_;
        tripoint_abs_ms vehicle_position_;
        std::optional<tripoint_abs_ms> previous_goal_;
        ter_id terrain_;
        furn_id furniture_;
        const mtype *source_type_;
        time_point turn_;
        std::size_t vehicle_part_ = 0;
        int moves_;
        int anger_;
        int morale_;
        int friendly_;
        int hp_;
        bool had_occupant_ = false;
        bool had_vehicle_ = false;
        bool hallucination_;
        bool effect_pacified_;
        bool consumed_ = false;
};

#endif // CATA_SRC_MONSTER_MOVEMENT_PLAN_H
