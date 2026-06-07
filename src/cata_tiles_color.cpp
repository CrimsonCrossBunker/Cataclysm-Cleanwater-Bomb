#if defined(TILES)
#include "cata_tiles.h"

#include <cstddef>
#include <cstdint>
#include <memory>
#include <optional>
#include <utility>

#include "hsv_color.h"
#include "options.h"
#include "sdl_utils.h"
#include "sdl_wrappers.h"
#include "vehicle.h"

// Self-contained rendering helpers for vehicle part coloring, kept out of
// tileset_loader.cpp / cata_tiles.cpp so those files stay almost untouched:
//  - tileset::get_tinted_tile bakes (and caches) an HSV-recolored sprite.
//  - cata_tiles::get_vpart_tint resolves the paint color of a displayed part.

const texture *tileset::get_tinted_tile( const SDL_Renderer_Ptr &renderer, const size_t index,
        const RGBColor &color, const texture *source ) const
{
    if( source == nullptr ) {
        source = get_tile( index );
    }
    if( source == nullptr ) {
        return nullptr;
    }

    // Key on the source texture identity (which encodes the sprite AND its light
    // variant; pointers are stable until the next upload, when this cache is
    // cleared) mixed with the exact RGBA, so a part tinted in shadow does not
    // get reused at full light.
    const uint64_t color_key = ( static_cast<uint64_t>( color.r ) << 24 ) |
                               ( static_cast<uint64_t>( color.g ) << 16 ) |
                               ( static_cast<uint64_t>( color.b ) << 8 ) |
                               static_cast<uint64_t>( color.a );
    const uint64_t key = reinterpret_cast<uintptr_t>( source ) ^
                         ( color_key * 0x9E3779B97F4A7C15ULL );
    const auto cached = tinted_tile_values.find( key );
    if( cached != tinted_tile_values.end() ) {
        return &cached->second;
    }

    const std::pair<int, int> dim = source->dimension();
    const int w = dim.first;
    const int h = dim.second;
    if( w <= 0 || h <= 0 ) {
        return nullptr;
    }

    // Render the (already light-adjusted) source sprite to an offscreen target
    // and read it back so its pixels can be recolored in HSV space.
    SDL_Texture_Ptr target = CreateTexture( renderer, SDL_PIXELFORMAT_RGBA8888,
                                            SDL_TEXTUREACCESS_TARGET, w, h );
    if( !target ) {
        return nullptr;
    }
    SetTextureBlendMode( target, SDL_BLENDMODE_BLEND );

    SDL_Surface_Ptr surf = create_surface_32( w, h );
    if( !surf ) {
        return nullptr;
    }
    {
        scoped_render_target swap_target( renderer, target.get() );
        if( !swap_target.is_valid() ) {
            return nullptr;
        }
        SetRenderDrawColor( renderer, 0, 0, 0, 0 );
        RenderClear( renderer );
        const SDL_Rect dst{ 0, 0, w, h };
        source->render_copy_ex( renderer, &dst, 0.0, nullptr, SDL_FLIP_NONE );
        const SDL_Rect read_rect{ 0, 0, w, h };
        if( !RenderReadPixels( renderer, &read_rect, GetSurfacePixelFormat( surf ),
                               surf->pixels, surf->pitch ) ) {
            return nullptr;
        }
    }

    // Recolor non-transparent pixels. create_surface_32 is tightly packed
    // (pitch == w*4), matching the linear walk used by apply_color_filter.
    SDL_Color *pix = static_cast<SDL_Color *>( surf->pixels );
    for( int y = 0, ey = surf->h; y < ey; ++y ) {
        for( int x = 0, ex = surf->w; x < ex; ++x, ++pix ) {
            if( pix->a == 0x00 ) {
                continue;
            }
            *pix = static_cast<SDL_Color>( tint_blend( RGBColor( *pix ), color ) );
        }
    }

    std::shared_ptr<SDL_Texture> tex_ptr = CreateTextureFromSurface( renderer, surf );
    if( !tex_ptr ) {
        return nullptr;
    }
    SetTextureBlendMode( tex_ptr, SDL_BLENDMODE_BLEND );
    texture baked( tex_ptr, SDL_Rect{ 0, 0, w, h }, source->get_opaque_rect() );
    const auto inserted = tinted_tile_values.emplace( key, std::move( baked ) );
    return &inserted.first->second;
}

std::optional<RGBColor> cata_tiles::get_vpart_tint( const vehicle &veh,
        const point_rel_ms &mount ) const
{
    if( !get_option<bool>( "VEHICLE_PART_COLOR" ) ) {
        return std::nullopt;
    }
    const int part_idx = veh.part_displayed_at( mount, true );
    if( part_idx < 0 ) {
        return std::nullopt;
    }
    const vehicle_part &vp = veh.part( part_idx );
    if( !vp.has_custom_color() ) {
        return std::nullopt;
    }
    return vp.get_color().fg;
}

#endif // TILES
