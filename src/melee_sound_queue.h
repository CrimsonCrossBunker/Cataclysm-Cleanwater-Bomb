#pragma once
#ifndef CATA_SRC_MELEE_SOUND_QUEUE_H
#define CATA_SRC_MELEE_SOUND_QUEUE_H

#include <chrono>
#include <cstddef>
#include <cstdint>
#include <optional>
#include <queue>
#include <random>
#include <string>
#include <vector>

#include "units.h"

namespace sfx
{
// Presentation values only: no creature, item, map or resource references.
struct queued_sound {
    std::string id;
    std::string variant;
    std::string season;
    bool indoors = false;
    bool night = false;
    int volume = 0;
    units::angle angle = 0_degrees;
    unsigned int random_seed = 0;
};

struct melee_sound_sequence {
    queued_sound swing;
    std::optional<queued_sound> hit;
    int weapon_volume = 0;
    bool target_monster = false;
};

// Owned by the audio presentation service and serviced on the main thread.
// The audio backend already owns playback; scheduling needs no extra worker.
class melee_sound_queue
{
    public:
        using clock = std::chrono::steady_clock;
        static constexpr size_t capacity = 1024;
        bool enqueue( melee_sound_sequence sequence, clock::time_point now );
        std::optional<queued_sound> pop_due( clock::time_point now );
        void clear();
        bool empty() const;
        size_t size() const;

    private:
        struct pending_sound {
            clock::time_point due;
            uint64_t order;
            queued_sound sound;
        };
        struct later {
            bool operator()( const pending_sound &lhs, const pending_sound &rhs ) const;
        };
        std::priority_queue<pending_sound, std::vector<pending_sound>, later> pending;
        uint64_t next_order = 0;
        // Deliberately independent of the simulation RNG, including its seed.
        std::minstd_rand0 random_engine;
};

} // namespace sfx
#endif // CATA_SRC_MELEE_SOUND_QUEUE_H
