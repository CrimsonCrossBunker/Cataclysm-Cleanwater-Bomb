#if defined(TILES)

#include "pixel_minimap.h"

#include <algorithm>
#include <bitset>
#include <cmath>
#include <memory>
#include <optional>
#include <stdexcept>
#include <vector>

#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "cata_shader.h"
#include "cata_utility.h"
#include "character.h"
#include "color.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "game.h"
#include "level_cache.h"
#include "lightmap.h"
#include "map.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "math_defines.h"
#include "mdarray.h"
#include "monster.h"
#include "mtype.h"
#include "pixel_minimap_projectors.h"
#include "sdl_utils.h"
#include "sdltiles.h"
#include "type_id.h"
#include "vehicle.h"
#include "viewer.h"
#include "vpart_position.h"

namespace
{

const point total_tiles_count = { MAX_VIEW_DISTANCE * 2 + 1, MAX_VIEW_DISTANCE * 2 + 1 };

point get_pixel_size( const point &tile_size, pixel_minimap_mode mode )
{
    switch( mode ) {
        case pixel_minimap_mode::solid:
            return tile_size;

        case pixel_minimap_mode::squares:
            return { std::max( tile_size.x - 1, 1 ), std::max( tile_size.y - 1, 1 ) };

        case pixel_minimap_mode::dots:
            return { point::south_east };
    }

    return {};
}

/// Returns a number in range [0..1]. The range lasts for @param phase_length_ms (milliseconds).
float get_animation_phase( int phase_length_ms )
{
    if( phase_length_ms == 0 ) {
        return 0.0f;
    }

    return std::fmod<float>( GetTicks(), phase_length_ms ) / phase_length_ms;
}

SDL_Color get_map_color_at( const map &here, const tripoint_bub_ms &p )
{
    if( const optional_vpart_position vp = here.veh_at( p ) ) {
        const vpart_display vd = vp->vehicle().get_display_of_tile( vp->mount_pos3() );
        return curses_color_to_SDL( vd.color );
    }

    if( const furn_id &furn_id = here.furn( p ) ) {
        return curses_color_to_SDL( furn_id->color() );
    }

    return curses_color_to_SDL( here.ter( p )->color() );
}

SDL_Color get_critter_color( Creature *critter, int flicker, int mixture )
{
    SDL_Color result = curses_color_to_SDL( critter->symbol_color() );

    if( const monster *m = dynamic_cast<monster *>( critter ) ) {
        //faction status (attacking or tracking) determines if red highlights get applied to creature
        const monster_attitude matt = m->attitude( &get_player_character() );

        if( ( MATT_ATTACK == matt || MATT_FOLLOW == matt ) &&
            !m->has_flag( mon_flag_APPEARS_NEUTRAL ) ) {
            const SDL_Color red_pixel = SDL_Color{ 0xFF, 0x0, 0x0, 0xFF };
            result = adjust_color_brightness( mix_colors( result, red_pixel, mixture ), flicker );
        }
    }

    return result;
}

} // namespace

pixel_minimap::pixel_minimap( const SDL_Renderer_Ptr &renderer,
                              const GeometryRenderer_Ptr &/* geometry */ ) :
    renderer( renderer ),
    type( pixel_minimap_type::ortho ),
    screen_rect{ 0, 0, 0, 0 }
{
}

pixel_minimap::~pixel_minimap() = default;

void pixel_minimap::set_type( pixel_minimap_type type )
{
    if( this->type != type ) {
        this->type = type;
        reset();
    }
}

void pixel_minimap::set_settings( const pixel_minimap_settings &settings )
{
    this->settings = settings;
    reset();
}

void pixel_minimap::set_screen_rect( const SDL_Rect &screen_rect,
                                     const bool force_scale_to_fit )
{
    if( this->screen_rect == screen_rect &&
        forced_scale_to_fit == force_scale_to_fit &&
        projector ) {
        return;
    }

    this->screen_rect = screen_rect;
    forced_scale_to_fit = force_scale_to_fit;

    projector = create_projector( screen_rect );
    pixel_size = get_pixel_size( projector->get_tile_size(), settings.mode );

    const point size_on_screen = projector->get_tiles_size( total_tiles_count );

    if( forced_scale_to_fit ) {
        // HUD frames fill screen_rect directly across both axes.
        transform_.dest_rect = screen_rect;
        transform_.origin_x = static_cast<float>( screen_rect.x );
        transform_.origin_y = static_cast<float>( screen_rect.y );
        transform_.scale_x = static_cast<float>( screen_rect.w ) / size_on_screen.x;
        transform_.scale_y = static_cast<float>( screen_rect.h ) / size_on_screen.y;
    } else {
        transform_ = compute_minimap_transform(
                         size_on_screen, screen_rect, settings.scale_to_fit );
    }
}

void pixel_minimap::reset()
{
    projector.reset();
    geometry_batch_.clear();
    beacons_.clear();
}

//the main call for drawing the pixel minimap to the screen
void pixel_minimap::draw( const SDL_Rect &screen_rect, const tripoint_bub_ms &center,
                          const bool force_scale_to_fit )
{
    if( !g || !renderer ) {
        return;
    }

    if( screen_rect.w <= 0 || screen_rect.h <= 0 ) {
        return;
    }

    set_screen_rect( screen_rect, force_scale_to_fit );
    if( transform_.dest_rect.w <= 0 || transform_.dest_rect.h <= 0 ) {
        has_blinking_beacons_ = false;
        return;
    }

    if( renderer_boundary_recovery_pending() ) {
        display_buffer_scope_signal_recovery_required();
        throw std::runtime_error(
            "pixel_minimap::draw: renderer boundary recovery pending" );
    }

    if( cata_shader::variant_pass *vp = get_shared_variant_pass() ) {
        if( !vp->flush() ) {
            display_buffer_scope_signal_recovery_required();
            throw std::runtime_error(
                "pixel_minimap::draw: variant_pass refused boundary" );
        }
    }

    const bool had_caller_clip = RenderIsClipEnabled( renderer );
    SDL_Rect caller_clip{ 0, 0, 0, 0 };
    SDL_Rect effective_clip = transform_.dest_rect;
    if( had_caller_clip ) {
        RenderGetClipRect( renderer, &caller_clip );
        if( !GetRectIntersection( caller_clip, transform_.dest_rect, effective_clip ) ) {
            has_blinking_beacons_ = false;
            return;
        }
    }

    const int clip_left = effective_clip.x;
    const int clip_top = effective_clip.y;
    const int clip_right = effective_clip.x + effective_clip.w;
    const int clip_bottom = effective_clip.y + effective_clip.h;

    const SDL_Color bg_color{
        static_cast<Uint8>( pixel_minimap_r ),
        static_cast<Uint8>( pixel_minimap_g ),
        static_cast<Uint8>( pixel_minimap_b ),
        static_cast<Uint8>( pixel_minimap_a )
    };

    geometry_batch_.clear();
    beacons_.clear();
    has_blinking_beacons_ = false;

    geometry_batch_.append_quad( static_cast<float>( transform_.dest_rect.x ),
                                 static_cast<float>( transform_.dest_rect.y ),
                                 static_cast<float>( transform_.dest_rect.w ),
                                 static_cast<float>( transform_.dest_rect.h ),
                                 to_fcolor( bg_color ) );

    const map &here = get_map();
    const level_cache &access_cache = here.access_cache( center.z() );
    const bool nv_goggle = get_player_character().get_vision_modes()[NV_GOGGLES];
    const viewer &player_view = get_player_view();
    creature_tracker &creatures = get_creature_tracker();

    //handles the enemy faction red highlights
    //this value should be divisible by 200
    const int indicator_length = settings.beacon_blink_interval * 200; //default is 2000 ms, 2 seconds

    int flicker = 100;
    int mixture = 0;

    if( indicator_length > 0 ) {
        const float t = get_animation_phase( 2 * indicator_length );
        const float s = std::sin( 2 * M_PI * t );

        flicker = lerp_clamped( 25, 100, std::abs( s ) );
        mixture = lerp_clamped( 0, 100, std::max( s, 0.0f ) );
    }

    const point_rel_ms start( center.x() - total_tiles_count.x / 2,
                              center.y() - total_tiles_count.y / 2 );
    const point tile_size = projector->get_tile_size();
    const int native_beacon_w = std::max( tile_size.x * settings.beacon_size / 2, 2 );
    const int native_beacon_h = std::max( tile_size.y * settings.beacon_size / 2, 2 );
    const point scaled_beacon_size(
        std::max( static_cast<int>( std::lround( native_beacon_w * transform_.scale_x ) ), 1 ),
        std::max( static_cast<int>( std::lround( native_beacon_h * transform_.scale_y ) ), 1 ) );

    for( int y = 0; y < total_tiles_count.y; ++y ) {
        for( int x = 0; x < total_tiles_count.x; ++x ) {
            const tripoint_bub_ms p = start + tripoint_bub_ms( x, y, center.z() );
            if( !here.inbounds( p ) ) {
                // p might be out-of-bounds when peeking at submap boundary. Example: center=(64,59,-5), start=(4,-1) -> p=(4,-1,-5)
                continue;
            }
            const lit_level lighting = access_cache.visibility_cache[p.x()][p.y()];
            if( lighting == lit_level::DARK || lighting == lit_level::BLANK ) {
                continue;
            }

            const point native_pos = projector->get_tile_pos( { x, y }, total_tiles_count );
            const point screen_pos(
                snap_to_pixel( transform_.origin_x, transform_.scale_x, native_pos.x ),
                snap_to_pixel( transform_.origin_y, transform_.scale_y, native_pos.y ) );
            const point screen_end(
                snap_to_pixel( transform_.origin_x, transform_.scale_x,
                               native_pos.x + pixel_size.x ),
                snap_to_pixel( transform_.origin_y, transform_.scale_y,
                               native_pos.y + pixel_size.y ) );
            const point quad_size( std::max( screen_end.x - screen_pos.x, 1 ),
                                   std::max( screen_end.y - screen_pos.y, 1 ) );

            if( screen_pos.x + quad_size.x > clip_left && screen_pos.x < clip_right &&
                screen_pos.y + quad_size.y > clip_top && screen_pos.y < clip_bottom ) {
                SDL_Color color = get_map_color_at( here, p );

                //color terrain according to lighting conditions
                if( nv_goggle ) {
                    if( lighting == lit_level::LOW ) {
                        color = color_pixel_nightvision( color );
                    } else {
                        color = color_pixel_overexposed( color );
                    }
                } else if( lighting == lit_level::LOW ) {
                    color = color_pixel_grayscale( color );
                }

                color = adjust_color_brightness( color, settings.brightness );

                if( color != bg_color ) {
                    geometry_batch_.append_quad( static_cast<float>( screen_pos.x ),
                                                 static_cast<float>( screen_pos.y ),
                                                 static_cast<float>( quad_size.x ),
                                                 static_cast<float>( quad_size.y ),
                                                 to_fcolor( color ) );
                }
            }

            Creature *critter = creatures.creature_at( p, true );
            if( critter == nullptr || !player_view.sees( here, *critter ) ) {
                continue;
            }

            if( indicator_length > 0 ) {
                has_blinking_beacons_ = true;
            }

            if( screen_pos.x + scaled_beacon_size.x >= clip_left &&
                screen_pos.x - scaled_beacon_size.x < clip_right &&
                screen_pos.y + scaled_beacon_size.y >= clip_top &&
                screen_pos.y - scaled_beacon_size.y < clip_bottom ) {
                const SDL_Rect critter_rect{
                    screen_pos.x, screen_pos.y, scaled_beacon_size.x, scaled_beacon_size.y
                };
                const SDL_Color critter_color = get_critter_color( critter, flicker, mixture );
                beacons_.push_back( beacon{ critter_rect, critter_color } );
            }
        }
    }

    for( const beacon &b : beacons_ ) {
        append_beacon( geometry_batch_, b.rect, b.color, 3 );
    }

    SDL_BlendMode prior_blend = SDL_BLENDMODE_NONE;
    GetRenderDrawBlendMode( renderer, prior_blend );
    const SDL_BlendMode desired_blend =
        bg_color.a < 0xFF ? SDL_BLENDMODE_BLEND : SDL_BLENDMODE_NONE;
    const bool change_blend = prior_blend != desired_blend;

    const SDL_Rect *const restore_clip = had_caller_clip ? &caller_clip : nullptr;
    on_out_of_scope restore_render_state( [this, restore_clip, change_blend, prior_blend]() {
        RenderSetClipRect( renderer, restore_clip );
        if( change_blend ) {
            SetRenderDrawBlendMode( renderer, prior_blend );
        }
    } );

    RenderSetClipRect( renderer, &effective_clip );
    if( change_blend ) {
        SetRenderDrawBlendMode( renderer, desired_blend );
    }
    render_quad_batch( renderer, geometry_batch_ );
}

std::unique_ptr<pixel_minimap_projector> pixel_minimap::create_projector(
    const SDL_Rect &max_screen_rect )
const
{
    switch( type ) {
        case pixel_minimap_type::ortho:
            return std::make_unique<pixel_minimap_ortho_projector>(
                       total_tiles_count, max_screen_rect, settings.square_pixels );

        case pixel_minimap_type::iso:
            return std::make_unique<pixel_minimap_iso_projector>( total_tiles_count, max_screen_rect,
                    settings.square_pixels );
    }

    return nullptr;
}

#endif // SDL_TILES
