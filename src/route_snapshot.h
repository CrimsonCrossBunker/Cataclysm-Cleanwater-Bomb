#pragma once
#ifndef CATA_SRC_ROUTE_SNAPSHOT_H
#define CATA_SRC_ROUTE_SNAPSHOT_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <vector>

#include "coordinates.h"

inline constexpr std::array<int, 8> route_x_offset{ -1, 1, 0, 0, 1, -1, -1, 1 };
inline constexpr std::array<int, 8> route_y_offset{ 0, 0, -1, 1, -1, 1, -1, 1 };

// All costs and avoidance decisions are captured by the owner thread.
// No map, creature, callback, registry or mutable cache reaches the search.
struct route_snapshot {
    struct cell {
        bool avoid = false;
        std::array<int, 8> entering_cost{};
    };
    tripoint_bub_ms start;
    tripoint_bub_ms target;
    tripoint_bub_ms min;
    tripoint_bub_ms max;
    int max_length = 0;
    bool euclidean = false;
    std::vector<cell> cells;

    std::size_t index( const tripoint_bub_ms &p ) const;
};

struct route_snapshot_result {
    std::vector<tripoint_bub_ms> path;
    // Record every decision used by A*, including rejected alternatives.
    std::vector<uint8_t> checked_avoid;
    std::vector<uint8_t> checked_cost;
};

route_snapshot_result search_route_snapshot( const route_snapshot &snapshot );

#endif // CATA_SRC_ROUTE_SNAPSHOT_H
