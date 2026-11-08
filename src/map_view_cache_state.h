#pragma once
#ifndef CATA_SRC_MAP_VIEW_CACHE_STATE_H
#define CATA_SRC_MAP_VIEW_CACHE_STATE_H

#include <cstdint>

#include "character_id.h"
#include "safe_reference.h"

class map;

// One observer of map changes. A view acknowledges its own revision; rebuilding
// it never consumes another view's invalidation. Owner thread only.
class map_view_cache_state
{
    public:
        void observe( map &source, character_id observer );

        // Used by draw_cache_rebuild_guard, including exception/reentrant dirtiness.
        bool dirty = true;

    private:
        safe_reference<map> source_;
        uint64_t revision_ = 0;
        character_id observer_;
};

#endif // CATA_SRC_MAP_VIEW_CACHE_STATE_H
