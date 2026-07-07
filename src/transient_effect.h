#pragma once
#ifndef CATA_SRC_TRANSIENT_EFFECT_H
#define CATA_SRC_TRANSIENT_EFFECT_H

#include <cstdint>

/** Opaque handle for a transient visual effect.  Zero means "no handle".
 *  Callers receive one from init_*() and may pass it to cancel_effect()
 *  to abort the effect mid-flight. */
using effect_handle = uint32_t;

/** Categories of transient visual effects tracked by the handle system.
 *  Drives cancel_effect() dispatch to the correct container. */
enum class effect_kind : uint8_t {
    explosion_light,
    bullet,
    creature_move,
    creature_hit,
    creature_attack,
    sct,
    highlight,
};

#endif // CATA_SRC_TRANSIENT_EFFECT_H
