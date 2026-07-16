#pragma once
#ifndef CATA_SRC_VFX_EMIT_H
#define CATA_SRC_VFX_EMIT_H

#include <vector>

#include "coordinates.h"
#include "type_id.h"
#include "point.h"

// General-purpose entry point for the modern VFX overlay (the light-cover +
// shockwave system that began as the explosion blast effect). It decouples the
// effect from "explosion": a caller describes a SHAPE to light up and a recipe
// to light it with, and the same per-tile colour-wave renderer plays over it.
//
// The blast path (explosion_handler::draw_custom_explosion) still exists and is
// unchanged; this is the convenience channel for non-explosion call sites that
// don't already have a flood-filled tile set — muzzle flashes (point), beams /
// lightning / sword-qi (line), dragon-breath / shotgun fans (cone). Spells keep
// going through draw_custom_explosion since their tiles are already shaped.

enum class vfx_shape : int {
    // Filled disc of `radius` tiles around `origin` — the classic blast. The
    // light wave blooms radially and the shockwave ring is enabled.
    disc,
    // A `width`-tile-wide line from `origin` to `target`. The wave sweeps along
    // the line from the origin; no centred shockwave ring.
    line,
    // An arc of `arc_degrees` opening from `origin` toward `target`, reaching
    // `range` tiles. The wave sweeps outward from the apex; no centred ring.
    cone,
    // A single tile at `origin` (e.g. a muzzle flash). Radial, tiny, no ring.
    point,
    num_vfx_shapes
};

// A description of what to light up. Plain data — no map, no renderer.
struct vfx_emit {
    vfx_shape shape = vfx_shape::disc;
    // disc/point: the centre. line/cone: the source the wave sweeps out from.
    tripoint_bub_ms origin;
    // line/cone: defines the direction (and, for a line, the far end). Ignored
    // for disc/point.
    tripoint_bub_ms target;
    int radius = 1;      // disc: radius in tiles. line: width. unused for point.
    int arc_degrees = 0; // cone: full arc width in degrees.
    int range = 1;       // line/cone: reach in tiles.
    // The explosion_light recipe to render with. Empty -> default_blast.
    explosion_light_str_id light;
};

// Pure geometry: the set of tiles a shape covers, as offsets resolved to
// absolute reality-bubble tiles. Map-free and renderer-free (does NOT clip to
// walls — callers that want wall clipping do it themselves), so it is unit
// tested directly. Tiles are deduplicated.
std::vector<tripoint_bub_ms> vfx_shape_tiles( const vfx_emit &e );

namespace explosion_handler
{
// Rasterise `e` and play the modern light overlay over it, picking the right
// propagation origin and enabling the shockwave ring only for radial shapes
// (disc/point). No-op in tests / curses. The one-line channel for non-spell
// callers.
void play_vfx( const vfx_emit &e );
} // namespace explosion_handler

#endif // CATA_SRC_VFX_EMIT_H
