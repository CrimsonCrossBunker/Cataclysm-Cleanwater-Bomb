#include "sprite_submission.h"

#if defined(TILES)
#include "cata_tiles.h"
#include "output.h"

bool submit_sprite_command( const sprite_draw_command &command, const sprite_asset_binding &binding,
                            render_command_order &order, render_resource_stamp current, int &height_3d )
{
    if( !order.accept( command.ticket, current ) ) {
        return false;
    }
    const sprite_geometry_result &geometry = command.geometry;
    SDL_Rect destination{ geometry.destination.origin.x, geometry.destination.origin.y,
                          geometry.destination.size.x, geometry.destination.size.y };
    const CataFlipMode flip = static_cast<CataFlipMode>(
                                  ( geometry.flip_horizontal ? SDL_FLIP_HORIZONTAL : SDL_FLIP_NONE ) |
                                  ( geometry.flip_vertical ? SDL_FLIP_VERTICAL : SDL_FLIP_NONE ) );
#if defined(_WIN32) && defined(CROSS_LINUX)
    if( binding.direct3d ) {
        if( geometry.rotation_code == 1 ) {
            --destination.y;
        } else if( geometry.rotation_code == 3 ) {
            --destination.x;
        }
    }
#endif
    const int result = binding.sprite.render_copy_ex( binding.renderer, &destination,
                       geometry.angle, nullptr, flip );
    if( command.gray_overlay && binding.silhouette ) {
        const auto &color = *command.gray_overlay;
        const auto &texture = binding.silhouette->get_texture_ptr();
        SetTextureBlendMode( texture, SDL_BLENDMODE_BLEND );
        SetTextureColorMod( texture, color[0], color[1], color[2] );
        SetTextureAlphaMod( texture, color[3] );
        binding.silhouette->render_copy_ex( binding.renderer, &destination, geometry.angle, nullptr, flip );
        SetTextureAlphaMod( texture, 255 );
        SetTextureColorMod( texture, 255, 255, 255 );
        SetTextureBlendMode( texture, SDL_BLENDMODE_NONE );
    }
    printErrorIf( result != 0, "SDL_RenderCopyEx() failed" );
    height_3d += command.height_delta;
    return true;
}
#endif // TILES
