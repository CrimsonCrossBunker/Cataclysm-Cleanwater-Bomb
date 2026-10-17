#include "sprite_submission.h"

#if defined(TILES)
#include "cata_tiles.h"
#include "output.h"

bool submit_sprite_command( const sprite_draw_command &command, const sprite_asset_binding &binding,
                            render_command_order &order, render_resource_stamp current, int &height_3d )
{
    if( !binding.sprite ) {
        order.cancel();
        return false;
    }
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
    const auto &atlas = binding.sprite->get_texture_ptr();
    if( command.texture_mod ) {
        const auto &mod = *command.texture_mod;
        SetTextureColorMod( atlas, mod[0], mod[1], mod[2] );
        SetTextureAlphaMod( atlas, mod[3] );
    }
    int result = 0;
    if( command.lighting ) {
        const auto corners = smooth_lighting::lit_quad( *command.lighting );
        std::array<SDL_Vertex, 4> vertices;
        for( std::size_t i = 0; i < vertices.size(); ++i ) {
            const smooth_lighting::lit_vertex &c = corners[i];
            vertices[i] = { { c.x, c.y }, { c.light.x, c.light.y, c.light.column, c.light.row },
                { c.u, c.v }
            };
        }
        static constexpr std::array<int, 6> indices = { 0, 1, 2, 0, 2, 3 };
        RenderGeometry( binding.renderer, atlas.get(), vertices.data(), vertices.size(),
                        indices.data(), indices.size() );
    } else {
        result = binding.sprite->render_copy_ex( binding.renderer, &destination,
            geometry.angle, nullptr, flip );
    }
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
    if( command.texture_mod ) {
        SetTextureColorMod( atlas, 255, 255, 255 );
        SetTextureAlphaMod( atlas, 255 );
    }
    printErrorIf( result != 0, "SDL_RenderCopyEx() failed" );
    height_3d += command.height_delta;
    return true;
}
#endif // TILES
