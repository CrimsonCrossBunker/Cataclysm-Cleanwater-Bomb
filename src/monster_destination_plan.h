#pragma once
#ifndef CATA_SRC_MONSTER_DESTINATION_PLAN_H
#define CATA_SRC_MONSTER_DESTINATION_PLAN_H

#include <optional>
#include <cstddef>
#include <utility>

#include "calendar.h"
#include "coordinates.h"
#include "safe_reference.h"
#include "monster_goal_policy.h"
#include "type_id.h"

class Creature;
class map;
class monster;
struct mtype;

// Immutable values for creature or point destination policy. The owner has
// already resolved sensing, triggers and the optional flight-floor query.
struct monster_destination_view {
    tripoint_abs_ms source;
    tripoint_abs_ms target;
    bool hostile = false;
    bool fleeing = false;
    int flee_z = 0;
    bool force_goal = false;
};

std::optional<tripoint_abs_ms> propose_monster_destination( const monster_destination_view &view );

// Owner-only envelope; neither this receipt nor its weak references are worker
// input. A proposal is single-use and cannot outlive the actor/map context or
// silently overwrite a goal after its observed inputs change. This is the final
// destination policy, not permission to defer the preceding sensing/trigger loop.
class monster_destination_plan
{
    public:
        monster_destination_plan( monster &source, Creature &target, map &here,
                                  bool hostile, bool fleeing );
        // Direct follow goal, after the owner's docile/leash/pet checks.
        monster_destination_plan( monster &source, Creature &target, map &here );
        // Selected point goal, after ordered patrol or furniture/path queries.
        monster_destination_plan( monster &source, map &here, const tripoint_abs_ms &destination,
                                  monster_point_goal kind );
        monster_destination_plan( const monster_destination_plan & ) = delete;
        monster_destination_plan &operator=( const monster_destination_plan & ) = delete;

        monster_destination_view view() const {
            return view_;
        }
        bool commit( const std::optional<tripoint_abs_ms> &proposal, map &here );
        void cancel() {
            consumed_ = true;
        }
    private:
        monster_destination_plan( monster &source, map &here );
        safe_reference<Creature> source_;
        safe_reference<Creature> target_;
        safe_reference<map> map_;
        monster_destination_view view_;
        tripoint_abs_sm origin_;
        std::optional<tripoint_abs_ms> previous_goal_;
        const mtype *source_type_;
        int moves_;
        int anger_;
        int morale_;
        int friendly_;
        int hp_;
        bool flies_;
        time_point turn_;
        bool has_target_ = false;
        monster_point_goal point_kind_ = monster_point_goal::fixed;
        std::optional<std::pair<ter_id, furn_id>> tile_;
        int patrol_index_ = -1;
        std::size_t patrol_count_ = 0;
        bool consumed_ = false;
};

#endif // CATA_SRC_MONSTER_DESTINATION_PLAN_H
