#pragma once
#ifndef CATA_SRC_SPRITE_GEOMETRY_H
#define CATA_SRC_SPRITE_GEOMETRY_H

#include <optional>

#include "point.h"

// Screen/source pixel coordinates, independent of a graphics backend.
struct sprite_rectangle {
    point origin;
    point size;
};

// Capture these values after sprite/lighting selection, on the renderer owner.
// No map, texture, renderer, or scratch-buffer references escape into this input.
struct sprite_geometry_input {
    point screen_position;
    point sprite_size;
    point screen_tile_size;
    point tileset_tile_size;
    point offset;
    point offset_retracted;
    point extra_offset;
    int stacked_height = 0;
    int retract = 0;
    float pixelscale = 1.0f;
    bool rotate_sprite = false;
    int rotation = 0;
    bool isometric = false;
    bool allow_diagonal_rotation = false;
    bool calculate_opaque_bounds = false;
    sprite_rectangle source_opaque_bounds;
};

struct sprite_geometry_result {
    // Before backend-specific submission adjustments; tint replay uses this rect.
    sprite_rectangle destination;
    std::optional<sprite_rectangle> opaque_bounds;
    double angle = 0;
    bool flip_horizontal = false;
    bool flip_vertical = false;
    // Retained even for isometric sprites: legacy Direct3D adjusts cases 1 and 3.
    int rotation_code = 0;
};

// Pure preparation. Positive sprite and tile dimensions come from the loaded
// tileset. Inputs and returned values can be owned by a job; SDL submission,
// tint scratch, and the ordered per-tile height accumulator stay with the caller.
sprite_geometry_result prepare_sprite_geometry( const sprite_geometry_input &input );

#endif // CATA_SRC_SPRITE_GEOMETRY_H
