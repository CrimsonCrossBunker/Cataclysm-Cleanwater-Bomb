#pragma once
#ifndef CATA_SRC_MONSTER_GOAL_POLICY_H
#define CATA_SRC_MONSTER_GOAL_POLICY_H

#include <cstddef>
#include <optional>

#include "coordinates.h"

struct monster_patrol_view {
    std::size_t count = 0;
    int current = -1;
    std::optional<tripoint_abs_ms> goal;
};

enum class monster_point_goal {
    fixed,
    patrol,
    furniture
};

inline std::size_t choose_monster_patrol_index( std::size_t current, std::size_t count,
        bool reached_current_stop )
{
    return count > 1 && reached_current_stop ? ( current + 1 ) % count : current;
}

#endif // CATA_SRC_MONSTER_GOAL_POLICY_H
