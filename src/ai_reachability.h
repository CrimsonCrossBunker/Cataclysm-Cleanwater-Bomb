#pragma once
#ifndef CATA_SRC_AI_REACHABILITY_H
#define CATA_SRC_AI_REACHABILITY_H

#include <array>
#include <atomic>
#include <bitset>
#include <cstdint>
#include <memory>
#include <thread>
#include <utility>
#include <vector>

#include "coordinates.h"
#include "map_scale_constants.h"

class cata_thread_pool;

namespace ai_reachability
{
using grid = std::array<std::array<std::bitset<MAPSIZE_Y>, MAPSIZE_X>, OVERMAP_LAYERS>;
enum terrain_bits : unsigned char {
    present = 1,
    movable = 2,
    vertical = 4
};
struct cell {
    int terrain = 0;
    int furniture = 0;
};
struct block {
    std::pair<std::uint64_t, std::uint64_t> version{};
    bool uniform = true;
    std::array<cell, SEEX * SEEY> cells{};
    const cell &at( int x, int y ) const;
};
// Owner-captured IDs and descriptor values only. No world, registry, creature,
// Lua, SDL, borrowed submap pointers or gameplay RNG are accessible to kernels.
struct snapshot {
    std::array<block, OVERMAP_LAYERS * MAPSIZE * MAPSIZE> blocks;
    grid transparent;
    // Owner-resolved complete map::passable for opaque, potentially movable cells.
    grid opaque_passable;
    std::vector<unsigned char> terrain;
    std::vector<unsigned char> furniture_nonblocking;
    const cell &at( int z, int x, int y ) const;
};
struct output {
    // Publish only in the fresh capture interval of the original bitmap rebuild.
    // Vehicles and fields may change later without a geometry stamp change.
    grid passable;
    grid up;
    grid down;
};
// Each caller owns complete x columns, including all bits of each bitset.
void prepare_columns( const snapshot &values, output &result, int begin_x, int end_x );
bool should_prepare( std::size_t population, double preceding_flood_ms,
                     bool owner_allows_workers );

// One tracker owns its executor, snapshot and reusable result. prepare joins
// every accepted task on all exits; mutations invalidate the cached result.
class frame
{
    public:
        class lease
        {
            public:
                ~lease();
                lease( lease &&other ) noexcept;
                lease( const lease & ) = delete;
                lease &operator=( const lease & ) = delete;
                lease &operator=( lease && ) = delete;
                explicit operator bool() const noexcept;
            private:
                friend class frame;
                lease( frame *owner, std::uint64_t generation );
                frame *owner_;
                std::uint64_t generation_;
        };
        explicit frame( unsigned workers );
        ~frame();
        frame( const frame & ) = delete;
        frame &operator=( const frame & ) = delete;
        lease try_acquire();
        snapshot &capture();
        bool prepare( const lease &request );
        const output *result() const;
        const snapshot *captured() const;
        void invalidate();
        void cancel() noexcept;
        unsigned worker_count() const;
        bool used_workers() const;
    private:
        void assert_owner() const;
        const std::thread::id owner_thread_;
        std::unique_ptr<snapshot> snapshot_;
        std::unique_ptr<output> output_;
        std::atomic<bool> cancelled_{ false };
        std::uint64_t generation_ = 0;
        std::uint64_t ready_generation_ = 0;
        bool leased_ = false;
        bool used_workers_ = false;
        // Join workers before any of their inputs or outputs are destroyed.
        std::unique_ptr<cata_thread_pool> pool_;
};
} // namespace ai_reachability
#endif // CATA_SRC_AI_REACHABILITY_H
