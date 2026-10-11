#pragma once
#ifndef CATA_SRC_TILE_PREPARATION_H
#define CATA_SRC_TILE_PREPARATION_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <vector>

class cata_thread_pool;

namespace tile_preparation
{
enum sparse_layer : unsigned {
    layer_graffiti = 1U << 0,
    layer_trap = 1U << 1,
    layer_part_con = 1U << 2,
    layer_field_item = 1U << 3,
    layer_vpart = 1U << 4,
    layer_critter = 1U << 5,
    layer_revival = 1U << 6
};

// Captured by the renderer owner. No world, registry, SDL, or Lua references.
// Light values have the same finite, nonnegative contract as the light cache.
struct input {
    bool sprite = false;
    bool invisible = false;
    bool graffiti = false;
    bool graffiti_override = false;
    bool trap = false;
    bool trap_override_active = false;
    bool construction = false;
    bool field = false;
    bool visible_items = false;
    bool field_override = false;
    bool item_override = false;
    bool vehicle = false;
    bool vehicle_override = false;
    bool creature = false;
    bool shadow = false;
    bool creature_override = false;
    bool tint_eligible = false;
    std::array<float, 3> light = {};
    float scalar_light = 0.0f;
};

struct result {
    unsigned layers = 0;
    std::array<std::uint8_t, 4> tint = {};
};

// Same kernel for the serial path and worker batches. Does not consume RNG.
result prepare( const input &values ) noexcept;

// Renderer-owned buffers and bounded workers. capture()/results() are owner-
// thread interfaces. prepare() blocks until every submitted task has completed,
// including exceptional exits, before inputs/results may be reused or destroyed.
class frame
{
    public:
        // Owner-thread lease prevents a nested renderer request from replacing
        // results while the outer draw still consumes them. No allocation.
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
                explicit lease( frame *owner );
                frame *owner_;
        };
        lease try_acquire( std::size_t count );
        explicit frame( unsigned workers );
        ~frame();
        frame( const frame & ) = delete;
        frame &operator=( const frame & ) = delete;
        std::vector<input> &capture();
        void prepare();
        const std::vector<result> &results() const;
        unsigned worker_count() const;
        bool used_workers() const;
        bool can_parallelize( std::size_t count ) const;

    private:
        std::unique_ptr<cata_thread_pool> pool_;
        std::vector<input> inputs_;
        std::vector<result> results_;
        bool used_workers_ = false;
        bool leased_ = false;
};
} // namespace tile_preparation

#endif // CATA_SRC_TILE_PREPARATION_H
