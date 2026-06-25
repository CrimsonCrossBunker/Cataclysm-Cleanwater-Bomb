#if defined(TILES)

#include "pixel_minimap.h"

#include <algorithm>
#include <array>
#include <bitset>
#include <cmath>
#include <cstdlib>
#include <functional>
#include <iterator>
#include <memory>
#include <optional>
#include <tuple>
#include <utility>
#include <vector>

#include "cached_options.h"
#include "cata_assert.h"
#include "cata_tiles.h"
#include "cata_utility.h"
#include "character.h"
#include "color.h"
#include "creature.h"
#include "creature_tracker.h"
#include "debug.h"
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

//creates the texture that individual minimap updates are drawn to
//later, the main texture is drawn to the display buffer
//the surface is needed to determine the color format needed by the texture
SDL_Texture_Ptr create_cache_texture( const SDL_Renderer_Ptr &renderer, int tile_width,
                                      int tile_height )
{
    return CreateTexture( renderer,
                          SDL_PIXELFORMAT_ARGB8888,
                          SDL_TEXTUREACCESS_TARGET,
                          tile_width,
                          tile_height );
}

SDL_Color get_map_color_at( const tripoint_bub_ms &p )
{
    const map &here = get_map();
    if( const optional_vpart_position vp = here.veh_at( p ) ) {
        const vpart_display vd = vp->vehicle().get_display_of_tile( vp->mount_pos() );
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

// a texture pool to avoid recreating textures every time player changes their view
// at most 142 out of 144 textures can be in use due to regular player movement
//  (moving from submap corner to new corner) with MAPSIZE = 11
// textures are dumped when the player moves more than one submap in one update
//  (teleporting, z-level change) to prevent running out of the remaining pool
class pixel_minimap::shared_texture_pool
{
    public:
        explicit shared_texture_pool( const std::function<SDL_Texture_Ptr()> &generator ) {
            const size_t pool_size = ( MAPSIZE + 1 ) * ( MAPSIZE + 1 );

            texture_pool.reserve( pool_size );
            inactive_index.reserve( pool_size );

            for( size_t i = 0; i < pool_size; ++i ) {
                texture_pool.emplace_back( generator() );
                inactive_index.push_back( i );
            }
        }

        //reserves a texture from the inactive group and returns tracking info
        SDL_Texture_Ptr request_tex( size_t &index ) {
            if( inactive_index.empty() ) {
                debugmsg( "Ran out of available textures in the pool." );
                //shouldn't be happening, but minimap will just be default color instead of crashing
                return nullptr;
            }
            index = inactive_index.back();
            inactive_index.pop_back();
            return std::move( texture_pool[index] );
        }

        //releases the provided texture back into the inactive pool to be used again
        //called automatically in the submap cache destructor
        void release_tex( size_t index, SDL_Texture_Ptr &&ptr ) {
            if( ptr ) {
                inactive_index.push_back( index );
                texture_pool[index] = std::move( ptr );
            }
        }

    private:
        std::vector<SDL_Texture_Ptr> texture_pool;
        std::vector<size_t> inactive_index;
};

//reserve the SEEX * SEEY submap tiles
pixel_minimap::submap_cache::submap_cache( shared_texture_pool &pool ) :
    pool( pool )
{
    chunk_tex = pool.request_tex( texture_index );
}

//handle the release of the borrowed texture
pixel_minimap::submap_cache::~submap_cache()
{
    pool.release_tex( texture_index, std::move( chunk_tex ) );
}

SDL_Color &pixel_minimap::submap_cache::color_at( const point &p )
{
    cata_assert( p.x >= 0 && p.x < SEEX );
    cata_assert( p.y >= 0 && p.y < SEEY );

    return minimap_colors[p.y * SEEX + p.x];
}

pixel_minimap::pixel_minimap( const SDL_Renderer_Ptr &renderer,
                              const GeometryRenderer_Ptr &geometry ) :
    renderer( renderer ),
    geometry( geometry ),
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

void pixel_minimap::prepare_cache_for_updates( const tripoint_bub_ms &center )
{
    const tripoint_abs_sm new_center_sm = get_map().get_abs_sub() + rebase_rel(
            coords::project_to<coords::sm>
            ( center ) );
    const tripoint_rel_sm center_sm_diff = cached_center_sm - new_center_sm;

    //invalidate the cache if the game shifted more than one submap in the last update, or if z-level changed.
    if( std::abs( center_sm_diff.x() ) > 1 ||
        std::abs( center_sm_diff.y() ) > 1 ||
        std::abs( center_sm_diff.z() ) > 0 ) {
        cache.clear();
    } else {
        for( auto &mcp : cache ) {
            mcp.second.touched = false;
        }
    }

    cached_center_sm = new_center_sm;
}

//deletes the mapping of unused submap caches from the main map
//the touched flag prevents deletion
void pixel_minimap::clear_unused_cache()
{
    for( auto it = cache.begin(); it != cache.end(); ) {
        it = it->second.touched ? std::next( it ) : cache.erase( it );
    }
}

//draws individual updates to the submap cache texture
//returns true if any chunk texture was actually repainted this frame
bool pixel_minimap::flush_cache_updates()
{
    // Each chunk owns a separate texture, so the updates cannot share a single
    // bind. The old code wrapped every chunk in its own scoped_render_target,
    // which captured and restored the prior target per chunk -- 2 SetRenderTarget
    // calls per chunk. On the SDL3 GPU backend each SDL_SetRenderTarget forces a
    // full GPU command-queue flush (FlushRenderCommands -> GPU_RunCommandQueue),
    // so that cost was 2N flushes per frame and scaled with the visible chunk
    // count. Capture the caller's prior target once, switch directly between
    // chunk textures, and restore once at the end: N+1 switches instead of 2N.

    // Skip entirely when nothing changed so we never touch the render target.
    bool any_updates = false;
    for( const auto &mcp : cache ) {
        if( !mcp.second.update_list.empty() ) {
            any_updates = true;
            break;
        }
    }
    if( !any_updates ) {
        return false;
    }

    // Recovery already latched: the renderer may be dangling after a LOST
    // handover, so even SDL_GetRenderTarget is unsafe. Refuse before any SDL
    // call, mirroring scoped_render_target's pre-switch refusal.
    if( renderer_boundary_recovery_pending() ) {
        display_buffer_scope_signal_recovery_required();
        throw std::runtime_error(
            "pixel_minimap::flush_cache_updates: renderer boundary recovery pending" );
    }

#if SDL_MAJOR_VERSION >= 3
    cata_shader::variant_pass *const vp = get_shared_variant_pass();
#else
    cata_shader::variant_pass *const vp = nullptr;
#endif

    // Capture the prior target once; every chunk shares the same caller target.
    SDL_Texture *const prior_target = SDL_GetRenderTarget( renderer.get() );

    for( auto &mcp : cache ) {
        if( mcp.second.update_list.empty() ) {
            continue;
        }

        const bind_result r = permanent_render_target_bind( renderer, mcp.second.chunk_tex.get(), vp );
        if( r != bind_result::ok ) {
            // failed_in_switch already latched recovery and left the renderer
            // undefined; refused_pre_switch means a null renderer. Either way the
            // chunk did not paint and re-binding the prior target is unsafe, so
            // abort the frame like the original scoped path did. (Skip the
            // restore: another switch on an undefined renderer deepens corruption.)
            display_buffer_scope_signal_recovery_required();
            throw std::runtime_error(
                "pixel_minimap::flush_cache_updates: scoped_render_target boundary lost" );
        }

        if( !mcp.second.ready ) {
            mcp.second.ready = true;

            SetRenderDrawColor( renderer, 0x00, 0x00, 0x00, 0x00 );
            RenderClear( renderer );

            for( int y = 0; y < SEEY; ++y ) {
                for( int x = 0; x < SEEX; ++x ) {
                    const point tile_pos = projector->get_tile_pos( { x, y }, { SEEX, SEEY } );
                    const point tile_size = projector->get_tile_size();

                    const SDL_Rect rect = SDL_Rect{ tile_pos.x, tile_pos.y, tile_size.x, tile_size.y };

                    geometry->rect( renderer, rect, SDL_Color() );
                }
            }
        }

        for( const point &p : mcp.second.update_list ) {
            const point tile_pos = projector->get_tile_pos( p, { SEEX, SEEY } );
            const SDL_Color tile_color = mcp.second.color_at( p );

            if( pixel_size.x == 1 && pixel_size.y == 1 ) {
                SetRenderDrawColor( renderer, tile_color.r, tile_color.g, tile_color.b, tile_color.a );
                RenderDrawPoint( renderer, tile_pos );
            } else {
                geometry->rect( renderer, tile_pos, pixel_size.x, pixel_size.y, tile_color );
            }
        }

        mcp.second.update_list.clear();
    }

    // Restore the caller's prior target once. A failure leaves later draws
    // landing on a chunk texture or an undefined target, so propagate like the
    // original per-chunk restore did.
    const bind_result rr = permanent_render_target_bind( renderer, prior_target, vp );
    if( rr != bind_result::ok ) {
        display_buffer_scope_signal_recovery_required();
        throw std::runtime_error(
            "pixel_minimap::flush_cache_updates: failed to restore prior render target" );
    }

    // Reached only when any_updates was true, so at least one chunk repainted.
    return true;
}

void pixel_minimap::update_cache_at( const tripoint_bub_sm &sm_pos )
{
    const map &here = get_map();
    const level_cache &access_cache = here.access_cache( sm_pos.z() );
    const bool nv_goggle = get_player_character().get_vision_modes()[NV_GOGGLES];

    submap_cache &cache_item = get_cache_at( here.get_abs_sub() + rebase_rel( sm_pos ) );
    const tripoint_bub_ms ms_pos = coords::project_to<coords::ms>( sm_pos );

    cache_item.touched = true;

    for( int y = 0; y < SEEY; ++y ) {
        for( int x = 0; x < SEEX; ++x ) {
            const tripoint_bub_ms p = ms_pos + tripoint{x, y, 0};
            const lit_level lighting = access_cache.visibility_cache[p.x()][p.y()];

            SDL_Color color;

            if( lighting == lit_level::BLANK || lighting == lit_level::DARK ) {
                // TODO: Map memory?
                color = { Uint8( pixel_minimap_r ), Uint8( pixel_minimap_g ), Uint8( pixel_minimap_b ), Uint8( pixel_minimap_a ) };
            } else {
                color = get_map_color_at( p );

                //color terrain according to lighting conditions
                if( nv_goggle ) {
                    if( lighting == lit_level::LOW ) {
                        color = color_pixel_nightvision( color );
                    } else if( lighting != lit_level::DARK && lighting != lit_level::BLANK ) {
                        color = color_pixel_overexposed( color );
                    }
                } else if( lighting == lit_level::LOW ) {
                    color = color_pixel_grayscale( color );
                }

                color = adjust_color_brightness( color, settings.brightness );
            }

            SDL_Color &current_color = cache_item.color_at( { x, y } );

            if( current_color != color ) {
                current_color = color;
                cache_item.update_list.emplace_back( x, y );
            }
        }
    }
}

pixel_minimap::submap_cache &pixel_minimap::get_cache_at( const tripoint_abs_sm &abs_sm_pos )
{
    auto it = cache.find( abs_sm_pos );

    if( it == cache.end() ) {
        it = cache.emplace( abs_sm_pos, submap_cache( *tex_pool ) ).first;
    }

    return it->second;
}

bool pixel_minimap::process_cache( const tripoint_bub_ms &center )
{
    prepare_cache_for_updates( center );

    for( int y = 0; y < MAPSIZE; ++y ) {
        for( int x = 0; x < MAPSIZE; ++x ) {
            update_cache_at( { x, y, center.z()} );
        }
    }

    const bool chunks_repainted = flush_cache_updates();
    clear_unused_cache();
    return chunks_repainted;
}

void pixel_minimap::set_screen_rect( const SDL_Rect &screen_rect )
{
    if( this->screen_rect == screen_rect && main_tex && tex_pool && projector ) {
        return;
    }

    this->screen_rect = screen_rect;

    projector = create_projector( screen_rect );
    pixel_size = get_pixel_size( projector->get_tile_size(), settings.mode );

    const point size_on_screen = projector->get_tiles_size( total_tiles_count );

    if( settings.scale_to_fit ) {
        main_tex_clip_rect = SDL_Rect{ 0, 0, size_on_screen.x, size_on_screen.y };
        screen_clip_rect = fit_rect_inside( main_tex_clip_rect, screen_rect );

        main_tex = create_cache_texture( renderer, size_on_screen.x, size_on_screen.y );
        // This texture is scaled to fit the screen; use linear filtering for smooth presentation.
        SetTextureScaleQuality( main_tex, "linear" );

    } else {
        const point d( ( size_on_screen.x - screen_rect.w ) / 2, ( size_on_screen.y - screen_rect.h ) / 2 );

        main_tex_clip_rect = SDL_Rect{
            std::max( d.x, 0 ),
            std::max( d.y, 0 ),
            size_on_screen.x - 2 * std::max( d.x, 0 ),
            size_on_screen.y - 2 * std::max( d.y, 0 )
        };

        screen_clip_rect = SDL_Rect{
            screen_rect.x - std::min( d.x, 0 ),
            screen_rect.y - std::min( d.y, 0 ),
            main_tex_clip_rect.w,
            main_tex_clip_rect.h
        };

        main_tex = create_cache_texture( renderer, size_on_screen.x, size_on_screen.y );
    }

    cache.clear();

    // main_tex was just recreated, so any cached skip-state refers to a dead
    // texture; force a full repaint next render.
    main_tex_valid_ = false;

    const point chunk_size = projector->get_tiles_size( { SEEX, SEEY } );

    const auto chunk_texture_generator = [&chunk_size, this]() {
        SDL_Texture_Ptr result = create_cache_texture( renderer, chunk_size.x, chunk_size.y );
        SetTextureBlendMode( result, SDL_BLENDMODE_BLEND );
        return result;
    };

    tex_pool = std::make_unique<shared_texture_pool>( chunk_texture_generator );
}

void pixel_minimap::reset()
{
    projector.reset();
    cache.clear();
    main_tex.reset();
    tex_pool.reset();
    main_tex_valid_ = false;
}

void pixel_minimap::render( const tripoint_bub_ms &center, const bool chunks_repainted )
{
    const tripoint_abs_sm abs_sub = get_map().get_abs_sub();

    // Scan critters every frame: a critter can enter or leave view even when the
    // camera is still, and this also refreshes has_blinking_beacons_, which the
    // caller relies on to drive animation regardless of whether we repaint.
    std::vector<beacon> beacons = collect_critter_beacons( center );

    // main_tex content is fully determined by the camera position, the chunk
    // textures, and the beacon layer. If none changed since the last paint and
    // the texture is still valid, reuse it: skip the bind / clear / chunk-copy /
    // beacon draw, which on the SDL3 GPU backend each force a full command-queue
    // flush. Just re-composite the existing main_tex to the screen. Position is
    // compared at tile resolution (center + abs_sub) because a move within one
    // submap still shifts the rendered image.
    //
    // The background color (pixel_minimap_r/g/b/a) and brightness are NOT part
    // of this check: today they only change via set_settings()/reset() or the
    // init_ui() first-init path, both of which clear main_tex_valid_. If a
    // feature is ever added that mutates those global color values at runtime
    // without going through reset(), it must also invalidate this cache.
    const bool unchanged = main_tex_valid_ &&
                           !chunks_repainted &&
                           abs_sub == last_render_abs_sub &&
                           center == last_render_center &&
                           beacons == last_beacons_;

    if( unchanged ) {
        RenderCopy( renderer, main_tex, &main_tex_clip_rect, &screen_clip_rect );
        return;
    }

    scoped_render_target main_scope( renderer, main_tex.get()
#if SDL_MAJOR_VERSION >= 3
                                     , get_shared_variant_pass()
#endif
                                   );
    if( !main_scope.is_valid() ) {
        if( !main_scope.boundary_intact() ) {
            display_buffer_scope_signal_recovery_required();
        }
        // main_tex unpainted: the RenderCopy below would composite stale data.
        throw std::runtime_error( main_scope.boundary_intact()
                                  ? "pixel_minimap::render: variant_pass refused boundary"
                                  : "pixel_minimap::render: scoped_render_target boundary lost" );
    }
    SetRenderDrawColor( renderer, pixel_minimap_r, pixel_minimap_g, pixel_minimap_b,
                        pixel_minimap_a );
    RenderClear( renderer );

    render_cache( center );
    for( const beacon &b : beacons ) {
        draw_beacon( b.rect, b.color );
    }

    // Restore so the compositing RenderCopy below lands on the caller's prior
    // target, not main_tex.
    if( !main_scope.restore() ) {
        if( !main_scope.boundary_intact() ) {
            display_buffer_scope_signal_recovery_required();
        }
        // main_tex was repainted, so its valid bit no longer reflects a clean
        // restore; clear it so the next frame does not trust a stale skip.
        main_tex_valid_ = false;
        throw std::runtime_error( main_scope.boundary_intact()
                                  ? "pixel_minimap::render: variant_pass refused boundary on restore"
                                  : "pixel_minimap::render: failed to restore prior render target" );
    }

    // Paint succeeded: record what main_tex now holds so the next frame can
    // decide whether to skip.
    main_tex_valid_ = true;
    last_render_abs_sub = abs_sub;
    last_render_center = center;
    last_beacons_ = std::move( beacons );

    RenderCopy( renderer, main_tex, &main_tex_clip_rect, &screen_clip_rect );
}

void pixel_minimap::render_cache( const tripoint_bub_ms &center )
{
    const tripoint_abs_sm sm_center = get_map().get_abs_sub() + rebase_rel(
                                          coords::project_to<coords::sm>
                                          ( center ) );
    const tripoint_rel_sm sm_offset {
        total_tiles_count.x / SEEX / 2,
        total_tiles_count.y / SEEY / 2, 0
    };

    point_rel_ms ms_offset;
    tripoint_bub_sm quotient;
    point_sm_ms remainder;
    std::tie( quotient, remainder ) = coords::project_remain<coords::sm>( center );

    point_sm_ms ms_base_offset = point_sm_ms( ( total_tiles_count.x / 2 ) % SEEX,
                                 ( total_tiles_count.y / 2 ) % SEEY );
    ms_offset = ms_base_offset - remainder;

    for( const auto &elem : cache ) {
        if( !elem.second.touched ) {
            continue;   // What you gonna do with all that junk?
        }

        const tripoint_rel_sm rel_pos = elem.first - sm_center;

        if( std::abs( rel_pos.x() ) > sm_offset.x() + 1 ||
            std::abs( rel_pos.y() ) > sm_offset.y() + 1 ||
            rel_pos.z() != 0 ) {
            continue;
        }

        const tripoint_rel_sm sm_pos = tripoint_rel_sm( rel_pos ) + sm_offset;
        const tripoint_rel_ms ms_pos = coords::project_to<coords::ms>( sm_pos ) + ms_offset;

        const SDL_Rect chunk_rect = projector->get_chunk_rect( ms_pos.xy().raw(), {SEEX, SEEY} );

        RenderCopy( renderer, elem.second.chunk_tex, nullptr, &chunk_rect );
    }
}

std::vector<pixel_minimap::beacon> pixel_minimap::collect_critter_beacons(
    const tripoint_bub_ms &center )
{
    std::vector<beacon> beacons;
    has_blinking_beacons_ = false;

    const map &m = get_map();

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

    const level_cache &access_cache = m.access_cache( center.z() );

    const point_rel_ms start( center.x() - total_tiles_count.x / 2,
                              center.y() - total_tiles_count.y / 2 );
    const point beacon_size = {
        std::max<int>( projector->get_tile_size().x *settings.beacon_size / 2, 2 ),
        std::max<int>( projector->get_tile_size().y *settings.beacon_size / 2, 2 )
    };

    creature_tracker &creatures = get_creature_tracker();
    for( int y = 0; y < total_tiles_count.y; y++ ) {
        for( int x = 0; x < total_tiles_count.x; x++ ) {
            const tripoint_bub_ms p = start + tripoint_bub_ms( x, y, center.z() );
            if( !m.inbounds( p ) ) {
                // p might be out-of-bounds when peeking at submap boundary. Example: center=(64,59,-5), start=(4,-1) -> p=(4,-1,-5)
                continue;
            }
            const lit_level lighting = access_cache.visibility_cache[p.x()][p.y()];

            if( lighting == lit_level::DARK || lighting == lit_level::BLANK ) {
                continue;
            }

            Creature *critter = creatures.creature_at( p, true );

            if( critter == nullptr || !get_player_view().sees( m, *critter ) ) {
                continue;
            }

            const point critter_pos = projector->get_tile_pos( { x, y }, total_tiles_count );
            const SDL_Rect critter_rect = SDL_Rect{ critter_pos.x, critter_pos.y, beacon_size.x, beacon_size.y };
            const SDL_Color critter_color = get_critter_color( critter, flicker, mixture );

            if( indicator_length > 0 ) {
                has_blinking_beacons_ = true;
            }
            beacons.push_back( beacon{ critter_rect, critter_color } );
        }
    }

    return beacons;
}

//the main call for drawing the pixel minimap to the screen
void pixel_minimap::draw( const SDL_Rect &screen_rect, const tripoint_bub_ms &center )
{
    if( !g ) {
        return;
    }

    if( screen_rect.w <= 0 || screen_rect.h <= 0 ) {
        return;
    }

    set_screen_rect( screen_rect );
    const bool chunks_repainted = process_cache( center );
    render( center, chunks_repainted );
}

void pixel_minimap::draw_beacon( const SDL_Rect &rect, const SDL_Color &color )
{
    for( int x = -rect.w, x_max = rect.w; x <= x_max; ++x ) {
        for( int y = -rect.h + std::abs( x ), y_max = rect.h - std::abs( x ); y <= y_max; ++y ) {
            const int divisor = 2 * ( std::abs( y ) == rect.h - std::abs( x ) ? 1 : 0 ) + 1;

            SetRenderDrawColor( renderer, color.r / divisor, color.g / divisor, color.b / divisor, 0xFF );
            RenderDrawPoint( renderer, point( rect.x + x, rect.y + y ) );
        }
    }
}

std::unique_ptr<pixel_minimap_projector> pixel_minimap::create_projector(
    const SDL_Rect &max_screen_rect )
const
{
    switch( type ) {
        case pixel_minimap_type::ortho:
            return std::make_unique<pixel_minimap_ortho_projector> ( total_tiles_count, max_screen_rect,
                    settings.square_pixels );

        case pixel_minimap_type::iso:
            return std::make_unique<pixel_minimap_iso_projector>( total_tiles_count, max_screen_rect,
                    settings.square_pixels );
    }

    return nullptr;
}

#endif // SDL_TILES
