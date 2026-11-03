#pragma once
#ifndef CATA_SRC_MONSTER_TARGET_FRAME_H
#define CATA_SRC_MONSTER_TARGET_FRAME_H

#include <memory>
#include <vector>

#include "coordinates.h"
#include "memory_fast.h"

class Creature;
class creature_tracker;
class monster;

// One owner-thread simulation pass. Only value indices cross the worker boundary.
class monster_target_frame
{
    public:
        explicit monster_target_frame( creature_tracker &tracker );
        ~monster_target_frame();
        monster_target_frame( const monster_target_frame & ) = delete;
        monster_target_frame &operator=( const monster_target_frame & ) = delete;
        static bool collect( const monster &observer, std::vector<shared_ptr_fast<monster>> &out );
        static void population_changed( const creature_tracker &tracker );
        static void moved( const Creature *actor, const tripoint_abs_ms &position );
    private:
        struct impl;
        std::unique_ptr<impl> impl_;
        monster_target_frame *previous_;
        inline static thread_local monster_target_frame *active_ = nullptr;
};

#endif // CATA_SRC_MONSTER_TARGET_FRAME_H
