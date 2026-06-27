#pragma once
#ifndef CATA_SRC_TRANSIENT_EFFECT_H
#define CATA_SRC_TRANSIENT_EFFECT_H

#include <stdint.h>
#include <vector>

#include "coords_fwd.h"

// Opaque handle for a transient visual effect.  Zero = invalid / no effect.
using effect_handle = uint32_t;

// Category of a transient visual effect, used to dispatch erase-on-cancel.
enum class effect_kind : uint8_t {
    explosion_light,
    bullet,
    creature_move,
    creature_hit,
    sct,
    highlight,
};

// Lightweight descriptor linking a handle to its associated tiles for
// reality-bubble departure checks.
struct transient_effect {
    effect_handle handle;
    effect_kind kind;
    std::vector<tripoint_bub_ms> tiles; // tiles this effect covers
};

#endif
