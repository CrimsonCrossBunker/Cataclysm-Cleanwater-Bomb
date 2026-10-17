#pragma once
#ifndef CATA_SRC_VISION_PREPARATION_H
#define CATA_SRC_VISION_PREPARATION_H

#include <array>
#include <atomic>
#include <cstdint>
#include <memory>
#include <thread>
#include <vector>

#include "coordinates.h"
#include "shadowcasting.h"

class cata_thread_pool;

namespace vision_preparation
{
using light_grid = cata::mdarray<float, point_bub_ms>;
using floor_grid = cata::mdarray<bool, point_bub_ms>;
using output = std::array<light_grid, OVERMAP_LAYERS>;

// Values captured by the map owner. No map/cache, avatar, registry, SDL or Lua
// pointers, and no gameplay RNG. Distance policy is captured with the grids.
struct snapshot {
    std::array<light_grid, OVERMAP_LAYERS> transparency;
    std::array<floor_grid, OVERMAP_LAYERS> floors;
    tripoint_bub_ms origin;
    int offset_distance = 0;
    float numerator = 1.0f;
    vertical_direction direction = vertical_direction::BOTH;
    bool trig_distance = false;
};

// Internal pure kernels. Callers own all supplied grids. Each segment may
// overlap another on axes/diagonals: parallel callers MUST use private outputs.
void cast_horizontal( const array_of_grids_of<float> &out,
                      const array_of_grids_of<const float> &in,
                      const array_of_grids_of<const bool> &floors,
                      const snapshot &parameters, unsigned segment );
void cast_vertical( const array_of_grids_of<float> &out,
                    const array_of_grids_of<const float> &in,
                    const array_of_grids_of<const bool> &floors,
                    const tripoint_bub_ms &origin, int offset_distance,
                    float numerator, vertical_direction direction, bool trig_distance );

// Scheduling policy only: the owner measures the preceding horizontal cast.
// Cold/cheap casts stay serial; completed worker kernel costs refresh admission.
// The 2ms threshold covers measured capture/clear/merge overhead on Linux.
// Owners can disable admission for sessions that have not been validated.
bool should_prepare( int radius, double horizontal_cost_ms, unsigned workers = 4,
                     bool owner_allows_workers = true );

// One map owns the executor and reusable buffers. No asynchronous result escapes:
// prepare joins every submitted task on success AND failure before returning.
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
        lease try_acquire( int radius );
        snapshot &capture();
        bool prepare();
        bool apply( const array_of_grids_of<float> &out, const lease &request );
        // Owner invalidation rejects completed stale results. Cancellation may
        // be requested from another thread; all tasks are still joined.
        void invalidate();
        void cancel() noexcept;
        unsigned worker_count() const;
        bool used_workers() const;
        double horizontal_cost_ms() const;
    private:
        void assert_owner() const;
        const std::thread::id owner_thread_;
        std::unique_ptr<snapshot> snapshot_;
        std::vector<std::unique_ptr<output>> outputs_;
        std::atomic<bool> cancelled_{ false };
        std::uint64_t generation_ = 0;
        std::uint64_t ready_generation_ = 0;
        // One distinct scalar per chunk, read by the owner only after joining.
        std::array<double, 4> horizontal_costs_ms_{};
        bool leased_ = false;
        bool used_workers_ = false;
        // Declared last: shutdown/join precedes destruction of all buffers.
        std::unique_ptr<cata_thread_pool> pool_;
};
} // namespace vision_preparation
#endif // CATA_SRC_VISION_PREPARATION_H
