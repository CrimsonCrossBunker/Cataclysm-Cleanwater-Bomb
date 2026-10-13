#pragma once
#ifndef CATA_SRC_MONSTER_DESTINATION_PLAN_H
#define CATA_SRC_MONSTER_DESTINATION_PLAN_H

#include <optional>

#include "calendar.h"
#include "coordinates.h"
#include "safe_reference.h"

class Creature;
class map;
class monster;
struct mtype;

// Immutable values for the chosen target's destination policy. The owner has
// already resolved sensing, triggers and the optional flight-floor query.
struct monster_destination_view {
    tripoint_abs_ms source;
    tripoint_abs_ms target;
    bool hostile = false;
    bool fleeing = false;
    int flee_z = 0;
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
        bool consumed_ = false;
};

#endif // CATA_SRC_MONSTER_DESTINATION_PLAN_H
