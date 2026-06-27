#pragma once
#ifndef CATA_SRC_TRANSIENT_VISUAL_LAYER_H
#define CATA_SRC_TRANSIENT_VISUAL_LAYER_H

#include <unordered_map>
#include <vector>

#include "transient_effect.h"

// Thin owner/catalogue for all transient visual effects, sitting on top of the
// draw snapshot.  Handles time-expiry + reality-bubble-departure cleanup.
// Actual state lives in cata_tiles (existing containers).
//
// TODO(2D3): This is a forward skeleton.  Handle management and bubble checking
// currently live directly on cata_tiles (m_handle_index, any_tile_in_bubble).
// When the draw snapshot seam (§3 of sim-render-decoupling-plan) matures, this
// layer should become the canonical owner and cata_tiles should delegate to it.
class transient_visual_layer
{
    public:
        effect_handle allocate( effect_kind kind, void *ptr );
        void release( effect_handle h );

        // Check whether any tile associated with `tiles` is still inside the
        // reality bubble.
        bool any_tile_in_bubble( const std::vector<tripoint_bub_ms> &tiles ) const;

        // Returns true if the handle still exists.
        bool valid( effect_handle h ) const;

    private:
        effect_handle m_next = 1;
        // handle to (kind, pointer-to-element) index.
        struct entry { effect_kind kind = effect_kind::explosion_light; void *ptr = nullptr; };
        std::unordered_map<effect_handle, entry> m_index;
};

#endif
