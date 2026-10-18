#pragma once
#ifndef CATA_SRC_AI_REACHABILITY_OWNER_H
#define CATA_SRC_AI_REACHABILITY_OWNER_H

#include "ai_reachability.h"
#include "ai_reachability_fwd.h"

namespace ai_reachability
{
// One internal, mutation-free flood owns this view. It must not escape that
// call or invoke gameplay callbacks. Check touched blocks and validate each
// unchanged transparency layer once. A mismatching layer keeps per-cell checks;
// changed cells use the original owner predicate.
class geometry_view
{
    public:
        geometry_view( const map &world, const snapshot &values );
        geometry_view( const geometry_view & ) = delete;
        geometry_view &operator=( const geometry_view & ) = delete;
        bool matches_at( const tripoint_bub_ms &position, int direction );
        bool stale() const;
    private:
        bool matches_block( int layer, int x, int y );
        const std::thread::id owner_thread_;
        const map &world_;
        const snapshot &values_;
        std::array<unsigned char, OVERMAP_LAYERS * MAPSIZE * MAPSIZE> checked_{};
        std::array<unsigned char, OVERMAP_LAYERS> transparency_checked_{};
        bool catalogs_match_ = false;
        bool stale_ = false;
};
} // namespace ai_reachability
#endif // CATA_SRC_AI_REACHABILITY_OWNER_H
