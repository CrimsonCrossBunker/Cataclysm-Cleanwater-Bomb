#pragma once
#ifndef CATA_SRC_MONSTER_TARGET_BATCH_H
#define CATA_SRC_MONSTER_TARGET_BATCH_H

#include <vector>

#include "coordinates.h"
#include "cpu_scheduler.h"
#include "line.h"

struct monster_target_geometry {
    tripoint_bub_ms position;
    FastDistanceApproximation distance{ 0 };
};

// No creature or map access on workers; the blocking join precedes sensing.
inline void prepare_monster_target_geometry( const tripoint_bub_ms &origin,
        bool euclidean, std::vector<monster_target_geometry> &candidates )
{
    cpu_parallel_for( cpu_task_kind::monster_targets, candidates.size(), 128,
    [&]( std::size_t begin, std::size_t end ) {
        for( std::size_t i = begin; i < end; ++i ) {
            monster_target_geometry &entry = candidates[i];
            entry.distance = euclidean ? trig_dist_fast( origin, entry.position ) :
                             square_dist_fast( origin, entry.position );
        }
    } );
}

#endif // CATA_SRC_MONSTER_TARGET_BATCH_H
