#pragma once
#ifndef CATA_SRC_MONSTER_TARGET_CANDIDATES_H
#define CATA_SRC_MONSTER_TARGET_CANDIDATES_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <map>
#include <utility>
#include <vector>

#include "compute_budget.h"

class cata_thread_pool;
struct point;

// A conservative XY broad phase. Z, death, attitude, visibility and target
// selection remain live owner queries, in the original monster-list order.
class monster_target_candidates
{
    public:
        using cell = std::pair<int, int>;
        using indices = std::vector<std::size_t, compute_allocator<std::size_t>>;
        static constexpr std::size_t max_windows = 64;
        static cell cell_at( const point &pos );
        explicit monster_target_candidates( int range );
        void add( const point &pos );
        void move( std::size_t index, const point &pos );
        void warm( const point &pos );
        const indices &query( const point &pos, cata_thread_pool &pool );
    private:
        struct window {
            bool ready = false;
            bool prefetch = false;
            std::uint64_t last_used = 0;
            std::uint64_t checked_movement = 0;
            indices candidates;
        };
        struct movement {
            cell previous;
            cell next;
        };
        static constexpr std::size_t movement_history_size = 256;
        bool overlaps( cell observer, cell target ) const;
        void validate( cell key, window &entry );
        void prepare( cata_thread_pool &pool, window &requested );
        const int cell_range_;
        std::uint64_t query_clock_ = 0;
        std::uint64_t movement_clock_ = 0;
        std::array<movement, movement_history_size> movements_{};
        std::vector<cell, compute_allocator<cell>> cells_;
        std::map<cell, window> windows_;
};

#endif // CATA_SRC_MONSTER_TARGET_CANDIDATES_H
