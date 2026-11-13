#pragma once
#ifndef CATA_SRC_MONSTER_TARGET_CANDIDATES_H
#define CATA_SRC_MONSTER_TARGET_CANDIDATES_H

#include <cstddef>
#include <map>
#include <utility>
#include <vector>

#include "compute_budget.h"

class cata_thread_pool;

// A conservative XY broad phase. Z, death, attitude, visibility and target
// selection remain live owner queries, in the original monster-list order.
class monster_target_candidates
{
    public:
        using cell = std::pair<int, int>;
        using indices = std::vector<std::size_t, compute_allocator<std::size_t>>;
        static constexpr std::size_t max_windows = 64;
        static cell cell_at( int x, int y );
        explicit monster_target_candidates( int range );
        void add( int x, int y );
        void move( std::size_t index, int x, int y );
        void warm( int x, int y );
        const indices &query( int x, int y, cata_thread_pool &pool );
    private:
        struct window {
            bool ready = false;
            indices candidates;
        };
        bool overlaps( cell observer, cell target ) const;
        void prepare( cata_thread_pool &pool );
        const int cell_range_;
        std::vector<cell, compute_allocator<cell>> cells_;
        std::map<cell, window> windows_;
};

#endif // CATA_SRC_MONSTER_TARGET_CANDIDATES_H
