#pragma once
#ifndef CATA_SRC_MAP_VISIBILITY_H
#define CATA_SRC_MAP_VISIBILITY_H

#include "coordinates.h"
#include "mdarray.h"

class map;
struct level_cache;
class submap;
struct visibility_variables;

// Rebuild one level's light-based visibility with a synchronous observer
// snapshot. The map owns invalidation, exploration and presentation notices.
void rebuild_visibility_cache_grid( const map &here, level_cache &map_cache, int zlev,
                                    const visibility_variables &variables,
                                    const cata::mdarray<const submap *, point_bub_sm> &field_submaps,
                                    cata::mdarray<int, point_bub_sm> &sm_squares_seen );

#endif // CATA_SRC_MAP_VISIBILITY_H
