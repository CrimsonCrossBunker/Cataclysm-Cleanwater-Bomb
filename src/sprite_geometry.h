#pragma once
#ifndef CATA_SRC_SPRITE_GEOMETRY_H
#define CATA_SRC_SPRITE_GEOMETRY_H

#include <optional>

#include "point.h"
#include "cata_utility.h"
#include "cata_compiler_support.h"

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
CATA_FORCEINLINE sprite_geometry_result prepare_sprite_geometry( const sprite_geometry_input
        &input )
{
    sprite_geometry_result result;
    const point tile_offset = input.retract <= 0 ? input.offset :
                              input.retract >= 100 ? input.offset_retracted :
                              input.offset + ( input.offset_retracted - input.offset ) * input.retract / 100;
    result.destination.origin = input.screen_position + point(
                                    divide_round_down( ( tile_offset.x + input.extra_offset.x ) * input.screen_tile_size.x,
                                        input.tileset_tile_size.x ),
                                    divide_round_down( ( tile_offset.y + input.extra_offset.y - input.stacked_height ) *
                                        input.screen_tile_size.x, input.tileset_tile_size.x ) );
    result.destination.size = point(
                                  input.sprite_size.x * input.screen_tile_size.x * input.pixelscale / input.tileset_tile_size.x,
                                  input.sprite_size.y * input.screen_tile_size.y * input.pixelscale / input.tileset_tile_size.y );

    if( input.rotate_sprite ) {
        result.rotation_code = input.rotation == -1 ? -1 :
                               input.allow_diagonal_rotation ? input.rotation : input.rotation % 4;
        if( input.rotation == -1 ) {
            result.flip_horizontal = true;
        } else if( !input.isometric ) {
            switch( result.rotation_code ) {
                case 1:
                    result.angle = 90;
                    break;
                case 2:
                    result.flip_horizontal = true;
                    result.flip_vertical = true;
                    break;
                case 3:
                    result.angle = -90;
                    break;
                case 5:
                    result.angle = 45;
                    break;
                case 6:
                    result.angle = -45;
                    break;
                case 7:
                    result.angle = -135;
                    break;
                case 8:
                    result.angle = 135;
                    break;
                default:
                    break;
            }
        }
    }

    if( input.calculate_opaque_bounds && input.source_opaque_bounds.size.x > 0 &&
        input.source_opaque_bounds.size.y > 0 ) {
        sprite_rectangle opaque = input.source_opaque_bounds;
        // Preserve the existing tint footprint, including its modulo-4 folding
        // for diagonal bullets. Quarter-turn bounds were not rotated here.
        if( input.rotate_sprite ) {
            if( input.rotation == -1 || ( !input.isometric && input.rotation % 4 == 2 ) ) {
                opaque.origin.x = input.sprite_size.x - opaque.origin.x - opaque.size.x;
            }
            if( !input.isometric && input.rotation % 4 == 2 ) {
                opaque.origin.y = input.sprite_size.y - opaque.origin.y - opaque.size.y;
            }
        }
        result.opaque_bounds = sprite_rectangle {
            result.destination.origin + point(
            opaque.origin.x *result.destination.size.x / input.sprite_size.x,
            opaque.origin.y *result.destination.size.y / input.sprite_size.y ),
            point( opaque.size.x *result.destination.size.x / input.sprite_size.x,
            opaque.size.y *result.destination.size.y / input.sprite_size.y )
        };
    }
    return result;
}

#endif // CATA_SRC_SPRITE_GEOMETRY_H
