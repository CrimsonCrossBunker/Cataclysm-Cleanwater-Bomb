#include "sprite_geometry.h"
#include <point.h>

#include "cata_utility.h"

sprite_geometry_result prepare_sprite_geometry( const sprite_geometry_input &input )
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
