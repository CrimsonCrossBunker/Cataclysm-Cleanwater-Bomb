#include <algorithm>
#include <chrono>
#include <cstdint>
#include <iterator>
#include <list>
#include <map>
#include <memory>
#include <string>
#include <string_view>
#include <thread>
#include <utility>
#include <vector>

#include "animation.h"
#include "avatar.h"
#include "cached_options.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "cursesdef.h"
#include "explosion.h"
#include "game.h"
#include "game_constants.h"
#include "input.h"
#include "map.h"
#include "memory_fast.h"
#include "monster.h"
#include "mtype.h"
#include "options.h"
#include "output.h"
#include "player_activity.h"
#include "point.h"
#include "popup.h"
#include "translations.h"
#include "type_id.h"
#include "ui_manager.h"
#include "units_fwd.h"
#include "viewer.h"
#include "weather.h"

#if defined(TILES)
    #include "cata_tiles.h" // all animation functions will be pushed out to a cata_tiles function in some manner
    #include "sdltiles.h"
    #include "weather_type.h"
#endif

static const activity_id ACT_TARGET_PRACTICE( "ACT_TARGET_PRACTICE" );

namespace
{

class basic_animation
{
    public:
        explicit basic_animation( const int scale ) :
            delay( get_option<int>( "ANIMATION_DELAY" ) * scale * 1000000L ) {
        }

        void draw() const {
            static_popup popup;
            popup
            .wait_message( "%s", _( "Hang on a bit…" ) )
            .on_top( true );

            g->invalidate_main_ui_adaptor();
            ui_manager::redraw_invalidated();
            refresh_display();
        }

        void progress() const {
            draw();

            const auto sleep_till = std::chrono::steady_clock::now() + std::chrono::nanoseconds( delay );
            do {
                const auto sleep_for = std::min( sleep_till - std::chrono::steady_clock::now(),
                                                 // Pump events every 100 ms
                                                 std::chrono::nanoseconds( 100000000 ) );
                if( sleep_for > std::chrono::nanoseconds( 0 ) ) {
                    std::this_thread::sleep_for( sleep_for );
                    inp_mngr.pump_events();
                } else {
                    break;
                }
            } while( true );
        }

    private:
        int_least64_t delay;
};

class explosion_animation : public basic_animation
{
    public:
        explosion_animation() :
            basic_animation( EXPLOSION_MULTIPLIER ) {
        }
};

bool skip_bullet_animation_delay()
{
    return get_avatar().activity.id() == ACT_TARGET_PRACTICE;
}

class bullet_animation : public basic_animation
{
    public:
        bullet_animation() : basic_animation( 1 ) {
        }

        void progress() const {
            draw();

            // Skip artificial animation delay to greatly reduce the realtime
            // delay between shots during player target practice activity
            if( !skip_bullet_animation_delay() ) {
                basic_animation::progress();
            }
        }
};

bool is_point_visible( const tripoint_bub_ms &p, int margin = 0 )
{
    const map &here = get_map();

    return g->is_in_viewport( p, margin ) && get_player_view().sees( here, p );
}

bool is_radius_visible( const tripoint_bub_ms &center, int radius )
{
    return is_point_visible( center, -radius );
}

bool is_layer_visible( const std::map<tripoint_bub_ms, explosion_tile> &layer )
{
    return std::any_of( layer.begin(), layer.end(),
    []( const std::pair<tripoint_bub_ms, explosion_tile> &element ) {
        return is_point_visible( element.first );
    } );
}

//! Get p relative to u's current position and view
tripoint_rel_ms relative_view_pos( const avatar &u, const tripoint_bub_ms &p ) noexcept
{
    return p - u.pos_bub() - u.view_offset + point_rel_ms( POSX, POSY );
}

// Convert p to screen position relative to the current terrain view
tripoint_rel_ms relative_view_pos( const game &g, const tripoint_bub_ms &p ) noexcept
{
    return p - g.ter_view_p + point( POSX, POSY );
}

void draw_explosion_curses( game &g, const tripoint_bub_ms &center, const int r,
                            const nc_color &col )
{
    if( !is_radius_visible( center, r ) ) {
        return;
    }
    // TODO: Make it look different from above/below
    const tripoint_rel_ms p = relative_view_pos( get_avatar(), center );

    explosion_animation anim;

    int frame = 0;
    shared_ptr_fast<game::draw_callback_t> explosion_cb =
    make_shared_fast<game::draw_callback_t>( [&]() {
        wattron( g.w_terrain, col );
        if( r == 0 ) {
            mvwaddch( g.w_terrain, point( p.y(), p.x() ), '*' );
        }

        for( int i = 1; i <= frame; ++i ) {
            // corner: top left
            mvwaddch( g.w_terrain, p.xy().raw() + point( -i, -i ), '/' );
            // corner: top right
            mvwaddch( g.w_terrain, p.xy().raw() + point( i, -i ), '\\' );
            // corner: bottom left
            mvwaddch( g.w_terrain, p.xy().raw() + point( -i, i ), '\\' );
            // corner: bottom right
            mvwaddch( g.w_terrain, p.xy().raw() + point( i, i ), '/' );
            for( int j = 1 - i; j < 0 + i; j++ ) {
                // edge: top
                mvwaddch( g.w_terrain, p.xy().raw() + point( j, -i ), '-' );
                // edge: bottom
                mvwaddch( g.w_terrain, p.xy().raw() + point( j, i ), '-' );
                // edge: left
                mvwaddch( g.w_terrain, p.xy().raw() + point( -i, j ), '|' );
                // edge: right
                mvwaddch( g.w_terrain, p.xy().raw() + point( i, j ), '|' );
            }
        }
        wattroff( g.w_terrain, col );
    } );
    g.add_draw_callback( explosion_cb );

    for( frame = 1; frame <= r; ++frame ) {
        anim.progress();
    }
}

constexpr explosion_neighbors operator | ( explosion_neighbors lhs, explosion_neighbors rhs )
{
    return static_cast<explosion_neighbors>( static_cast< int >( lhs ) | static_cast< int >( rhs ) );
}

constexpr explosion_neighbors operator ^ ( explosion_neighbors lhs, explosion_neighbors rhs )
{
    return static_cast<explosion_neighbors>( static_cast< int >( lhs ) ^ static_cast< int >( rhs ) );
}

void draw_custom_explosion_curses( game &g,
                                   const std::list< std::map<tripoint_bub_ms, explosion_tile> > &layers )
{
    avatar &player_character = get_avatar();
    // calculate screen offset relative to player + view offset position
    const tripoint_bub_ms center = player_character.pos_bub() + player_character.view_offset;
    const tripoint topleft( center.x() - getmaxx( g.w_terrain ) / 2,
                            center.y() - getmaxy( g.w_terrain ) / 2, 0 );

    explosion_animation anim;

    auto last_layer_it = layers.begin();
    shared_ptr_fast<game::draw_callback_t> explosion_cb =
    make_shared_fast<game::draw_callback_t>( [&]() {
        for( auto it = layers.begin(); it != std::next( last_layer_it ); ++it ) {
            for( const auto &pr : *it ) {
                // update tripoint in relation to top left corner of curses window
                // mvwputch already filters out of bounds coordinates
                const tripoint p = pr.first.raw() - topleft;
                const explosion_neighbors ngh = pr.second.neighborhood;
                const nc_color col = pr.second.color;

                switch( ngh ) {
                    // '^', 'v', '<', '>'
                    case N_NORTH:
                        mvwputch( g.w_terrain, p.xy(), col, '^' );
                        break;
                    case N_SOUTH:
                        mvwputch( g.w_terrain, p.xy(), col, 'v' );
                        break;
                    case N_WEST:
                        mvwputch( g.w_terrain, p.xy(), col, '<' );
                        break;
                    case N_EAST:
                        mvwputch( g.w_terrain, p.xy(), col, '>' );
                        break;
                    // '|' and '-'
                    case N_NORTH | N_SOUTH:
                    case N_NORTH | N_SOUTH | N_WEST:
                    case N_NORTH | N_SOUTH | N_EAST:
                        mvwputch( g.w_terrain, p.xy(), col, '|' );
                        break;
                    case N_WEST | N_EAST:
                    case N_WEST | N_EAST | N_NORTH:
                    case N_WEST | N_EAST | N_SOUTH:
                        mvwputch( g.w_terrain, p.xy(), col, '-' );
                        break;
                    // '/' and '\'
                    case N_NORTH | N_WEST:
                    case N_SOUTH | N_EAST:
                        mvwputch( g.w_terrain, p.xy(), col, '/' );
                        break;
                    case N_SOUTH | N_WEST:
                    case N_NORTH | N_EAST:
                        mvwputch( g.w_terrain, p.xy(), col, '\\' );
                        break;
                    case N_NO_NEIGHBORS:
                        mvwputch( g.w_terrain, p.xy(), col, '*' );
                        break;
                    case N_WEST | N_EAST | N_NORTH | N_SOUTH:
                        break;
                }
            }
        }
    } );
    g.add_draw_callback( explosion_cb );

    for( last_layer_it = layers.begin(); last_layer_it != layers.end(); ++last_layer_it ) {
        if( is_layer_visible( *last_layer_it ) ) {
            anim.progress();
        }
    }
}
} // namespace

#if defined(TILES)
void explosion_handler::draw_explosion( const tripoint_bub_ms &p, const int r, const nc_color &col )
{
    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }

    if( !use_tiles ) {
        draw_explosion_curses( *g, p, r, col );
        return;
    }

    if( !is_radius_visible( p, r ) ) {
        return;
    }

    explosion_animation anim;

    int i = 1;
    shared_ptr_fast<game::draw_callback_t> explosion_cb =
    make_shared_fast<game::draw_callback_t>( [&]() {
        // TODO: not xpos ypos?
        tilecontext->init_explosion( p, i );
    } );
    g->add_draw_callback( explosion_cb );

    const bool visible = is_radius_visible( p, r );
    for( i = 1; i <= r; i++ ) {
        if( visible ) {
            anim.progress();
        }
    }

    if( r > 0 ) {
        tilecontext->void_explosion();
    }
}

#else
void explosion_handler::draw_explosion( const tripoint_bub_ms &p, const int r, const nc_color &col )
{
    draw_explosion_curses( *g, p, r, col );
}
#endif

#if defined(TILES)
// Modern explosion light overlay (phase one). Computes a per-tile intensity
// (1 at the epicentre, falling to 0 at the rim) from the blast area, then runs
// the animation as a smooth 0..1 progress sweep so the light can bloom outward
// and fade. Rendering is a blended colour cover per tile — no sprites.
static void draw_explosion_light( const std::map<tripoint_bub_ms, nc_color> &all_area,
                                  const explosion_light_str_id &light_effect,
                                  const std::optional<tripoint_bub_ms> &epicenter = std::nullopt,
                                  bool circular_shockwave = true,
                                  const std::optional<tripoint_bub_ms> &shock_target = std::nullopt,
                                  double arc_degrees = 0.0 )
{
    if( all_area.empty() ) {
        return;
    }

    // Restrict to the avatar's current z-level and find the propagation origin.
    // Prefer the origin the caller passed (the blast's true epicentre, or — for a
    // directional shape like a line/cone — the caster tile the wave sweeps out
    // from); fall back to the area centroid (which drifts off-centre when the
    // blast is clipped by walls on one side). The per-tile coord below is distance
    // from this origin, so for a line/cone the wave reads as travelling along the
    // shape from its origin rather than blooming from the middle of the tiles.
    avatar &player_character = get_avatar();
    const tripoint_rel_ms view_center = relative_view_pos( player_character,
                                        player_character.pos_bub() );

    std::map<tripoint_bub_ms, float> radial;
    double sx = 0.0;
    double sy = 0.0;
    int n = 0;
    for( const auto &pr : all_area ) {
        const tripoint_rel_ms rel = relative_view_pos( player_character, pr.first );
        if( rel.z() != view_center.z() ) {
            continue;
        }
        radial[pr.first] = 0.0f;
        sx += pr.first.x();
        sy += pr.first.y();
        n++;
    }
    if( n == 0 ) {
        return;
    }
    // Use the true origin if it is on the drawn z-level; otherwise the centroid.
    double cx = sx / n;
    double cy = sy / n;
    if( epicenter && epicenter->z() == radial.begin()->first.z() ) {
        cx = epicenter->x();
        cy = epicenter->y();
    }

    // Per-tile radial coordinate (0 at centre, 1 at rim) drives the wave timing in
    // explosion_light::sample(). We only ever light the flood-filled blast area
    // (never a bare geometric disc), so the light cannot bleed through walls; the
    // sample()-side rim taper keeps the outer edge from looking ragged in the open
    // while walls naturally clip it where the blast was actually blocked.
    float max_d = 0.0001f;
    for( auto &pr : radial ) {
        const double dx = pr.first.x() - cx;
        const double dy = pr.first.y() - cy;
        const float d = static_cast<float>( std::sqrt( dx * dx + dy * dy ) );
        pr.second = d;
        max_d = std::max( max_d, d );
    }
    for( auto &pr : radial ) {
        pr.second = std::clamp( pr.second / max_d, 0.0f, 1.0f );
    }

    // A named effect that doesn't resolve is almost always a typo in JSON. We can't
    // validate it at data-load time (explosion_data is embedded in many types and
    // explosion lights may load after), so flag it here, once per bad id, then fall
    // back to the default recipe rather than silently dropping the modder's intent.
    if( !light_effect.is_empty() && !light_effect.is_valid() ) {
        static std::set<explosion_light_str_id> warned;
        if( warned.insert( light_effect ).second ) {
            debugmsg( "explosion light_effect '%s' is not a defined explosion_light; "
                      "using default_blast", light_effect.str() );
        }
    }
    const explosion_light_str_id &effect =
        light_effect.is_empty() ? explosion_lights::default_blast : light_effect;
    const explosion_light &eff = effect.is_valid() ? *effect : *explosion_lights::default_blast;

    // Total progress span: a rim tile is reached by the clear wave last, at
    // wave_travel (front travel) + N*wave_gap (one front per colour stop, then the
    // clear front) + fade (its fall), plus the worst-case spread jitter. Run a
    // small margin past that so the final fade completes.
    const int num_stops = std::max<int>( 1, static_cast<int>( eff.stops.size() ) );
    const float end_progress = eff.wave_travel + static_cast<float>( num_stops ) * eff.wave_gap +
                               eff.fade + eff.spread_jitter + 0.05f;

    // Asynchronous: register the blast and return immediately. It advances itself
    // by real elapsed time each frame (cata_tiles::advance_explosion_lights), so
    // the game keeps running and the player can act right away; the light plays out
    // in the background and several blasts in one turn overlap. Duration scales
    // gently with radius (per the recipe's duration_* fields) so big blasts read as
    // a travelling wave; small ones stay snappy. per_ms converts elapsed wall-clock
    // into progress.
    const float duration_ms = eff.duration_ms( max_d );
    const float per_ms = end_progress / duration_ms;


    // Centre tile (rounded centroid) at the blast's z-level, used as both the light
    // origin and the shockwave epicentre. The blast is on one z-level.
    int center_z = 0;
    if( !radial.empty() ) {
        center_z = radial.begin()->first.z();
    }
    const tripoint_bub_ms center( static_cast<int>( std::lround( cx ) ),
                                  static_cast<int>( std::lround( cy ) ), center_z );

    // Recipe-declared screen shake (independent of the sound-driven shake). Seed
    // from the epicentre so successive blasts jitter on different axes without an
    // RNG. Gating (options/intensity) lives in the trigger.
    if( eff.screen_shake_magnitude > 0.0f && eff.screen_shake_duration_ms > 0.0f ) {
        const uint32_t seed = ( static_cast<uint32_t>( center.x() ) * 73856093U ) ^
                              ( static_cast<uint32_t>( center.y() ) * 19349663U );
        maybe_trigger_screen_shake_recipe( eff.screen_shake_magnitude,
                                           eff.screen_shake_duration_ms, seed );
    }

    // Derive the directional shockwave geometry. A circular blast is a disc ring.
    // Otherwise the front sweeps from the origin toward the target: a cone when an
    // arc was given, a line beam otherwise. shock_target defaults to the origin if
    // the caller didn't pass one (degenerate axis -> the frame builder keeps the
    // default axis, so it simply reads as a faint disc).
    shockwave_state::sw_shape shock_shape = shockwave_state::sw_shape::disc;
    float shock_half_angle = 0.0f;
    if( !circular_shockwave ) {
        if( arc_degrees > 0.0 ) {
            shock_shape = shockwave_state::sw_shape::cone;
            constexpr double deg_to_rad = 3.14159265358979323846 / 180.0;
            shock_half_angle = static_cast<float>( arc_degrees * 0.5 * deg_to_rad );
        } else {
            shock_shape = shockwave_state::sw_shape::line;
        }
    }
    const tripoint_bub_ms shock_tgt = shock_target.value_or( center );

    tilecontext->init_explosion_light( radial, effect, center, max_d, per_ms, end_progress,
                                       circular_shockwave, shock_shape, shock_tgt,
                                       shock_half_angle );
}
#endif

void explosion_handler::draw_custom_explosion(
    const std::map<tripoint_bub_ms, nc_color> &all_area, const std::optional<std::string> &tile_id,
    const explosion_light_str_id &light_effect, const std::optional<tripoint_bub_ms> &epicenter,
    bool circular_shockwave, const std::optional<tripoint_bub_ms> &shock_target,
    double arc_degrees )
{
    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }

#if defined(TILES)
    // Modern light-overlay path: a blended colour cover that blooms outward then
    // fades, instead of the legacy expanding sprite. Taken whenever tiles are on
    // and the blast hasn't explicitly opted back into legacy sprites. tile_id
    // (used by spells/creature hits to name a specific sprite) keeps the legacy
    // path so those bespoke sprites still show.
    const bool legacy_opt_out = light_effect.str() == explosion_lights::legacy_sprite_id;
    if( use_tiles && !tile_id && !legacy_opt_out ) {
        draw_explosion_light( all_area, light_effect, epicenter, circular_shockwave,
                              shock_target, arc_degrees );
        return;
    }
#else
    ( void )light_effect;
    ( void )epicenter;
    ( void )circular_shockwave;
    ( void )shock_target;
    ( void )arc_degrees;
#endif

    constexpr explosion_neighbors all_neighbors = N_NORTH | N_SOUTH | N_WEST | N_EAST;
    // We will "shell" the explosion area
    // Each phase will strip a single layer of points
    // A layer contains all points that have less than 4 neighbors in cardinal directions
    // Layers will first be generated, then drawn in inverse order

    // Start by getting rid of everything except current z-level
    std::map<tripoint_bub_ms, explosion_tile> neighbors;
    avatar &player_character = get_avatar();
#if defined(TILES)
    if( !use_tiles ) {
        for( const auto &pr : all_area ) {
            const tripoint_rel_ms relative_point = relative_view_pos( player_character, pr.first );
            if( relative_point.z() == 0 ) {
                neighbors[pr.first] = explosion_tile{ N_NO_NEIGHBORS, pr.second, tile_id };
            }
        }
    } else {
        // In tiles mode, the coordinates have to be absolute
        const tripoint_rel_ms view_center = relative_view_pos( player_character,
                                            player_character.pos_bub() );
        for( const auto &pr : all_area ) {
            // Relative point is only used for z level check
            const tripoint_rel_ms relative_point = relative_view_pos( player_character, pr.first );
            if( relative_point.z() == view_center.z() ) {
                neighbors[pr.first] = explosion_tile{ N_NO_NEIGHBORS, pr.second, tile_id };
            }
        }
    }
#else
    for( const auto &pr : all_area ) {
        const tripoint_rel_ms relative_point = relative_view_pos( player_character, pr.first );
        if( relative_point.z( ) == 0 ) {
            neighbors[pr.first] = explosion_tile{ N_NO_NEIGHBORS, pr.second, tile_id };
        }
    }
#endif

    // Searches for a neighbor, sets the neighborhood flag on current point and on the neighbor
    const auto set_neighbors = [&]( const tripoint_bub_ms & pos,
                                    explosion_neighbors & ngh,
                                    explosion_neighbors here,
    explosion_neighbors there ) {
        if( ( ngh & here ) == N_NO_NEIGHBORS ) {
            auto other = neighbors.find( pos );
            if( other != neighbors.end() ) {
                ngh = ngh | here;
                other->second.neighborhood = other->second.neighborhood | there;
            }
        }
    };

    // If the point we are about to remove has a neighbor in a given direction
    // unset that neighbor's flag that our current point is its neighbor
    const auto unset_neighbor = [&]( const tripoint_bub_ms & pos,
                                     const explosion_neighbors ngh,
                                     explosion_neighbors here,
    explosion_neighbors there ) {
        if( ( ngh & here ) != N_NO_NEIGHBORS ) {
            auto other = neighbors.find( pos );
            if( other != neighbors.end() ) {
                other->second.neighborhood = ( other->second.neighborhood | there ) ^ there;
            }
        }
    };

    // Find all neighborhoods
    for( auto &pr : neighbors ) {
        const tripoint_bub_ms &pt = pr.first;
        explosion_neighbors &ngh = pr.second.neighborhood;

        set_neighbors( pt + point::west, ngh, N_WEST, N_EAST );
        set_neighbors( pt + point::east, ngh, N_EAST, N_WEST );
        set_neighbors( pt + point::north, ngh, N_NORTH, N_SOUTH );
        set_neighbors( pt + point::south, ngh, N_SOUTH, N_NORTH );
    }

    // We need to save the layers because we will draw them in reverse order
    std::list< std::map<tripoint_bub_ms, explosion_tile> > layers;
    while( !neighbors.empty() ) {
        std::map<tripoint_bub_ms, explosion_tile> layer;
        bool changed = false;
        // Find a layer that can be drawn
        for( const auto &pr : neighbors ) {
            if( pr.second.neighborhood != all_neighbors ) {
                changed = true;
                layer.insert( pr );
            }
        }
        if( !changed ) {
            // An error, but a minor one - let it slide
            return;
        }
        // Remove the layer from the area to process
        for( const auto &pr : layer ) {
            const tripoint_bub_ms &pt = pr.first;
            const explosion_neighbors ngh = pr.second.neighborhood;

            unset_neighbor( pt + point::west, ngh, N_WEST, N_EAST );
            unset_neighbor( pt + point::east, ngh, N_EAST, N_WEST );
            unset_neighbor( pt + point::north, ngh, N_NORTH, N_SOUTH );
            unset_neighbor( pt + point::south, ngh, N_SOUTH, N_NORTH );
            neighbors.erase( pr.first );
        }

        layers.push_front( std::move( layer ) );
    }

#if defined(TILES)
    if( !use_tiles ) {
        draw_custom_explosion_curses( *g, layers );
        return;
    }

    explosion_animation anim;
    // We need to draw all explosions up to now
    std::map<tripoint_bub_ms, explosion_tile> combined_layer;

    shared_ptr_fast<game::draw_callback_t> explosion_cb =
    make_shared_fast<game::draw_callback_t>( [&]() {
        tilecontext->init_custom_explosion_layer( combined_layer );
    } );
    g->add_draw_callback( explosion_cb );

    for( const auto &layer : layers ) {
        combined_layer.insert( layer.begin(), layer.end() );
        if( is_layer_visible( layer ) ) {
            anim.progress();
        }
    }

    tilecontext->void_custom_explosion();
#else
    draw_custom_explosion_curses( *g, layers );
#endif
}

namespace
{

void draw_bullet_curses( map &m, const tripoint_bub_ms &t, const char bullet,
                         const tripoint_bub_ms *const p )
{
    if( !is_point_visible( t ) ) {
        return;
    }

    avatar &player_character = get_avatar();
    const tripoint_bub_ms vp = player_character.pos_bub() + player_character.view_offset;

    if( vp.z() != t.z() ) {
        return;
    }

    shared_ptr_fast<game::draw_callback_t> bullet_cb = make_shared_fast<game::draw_callback_t>( [&]() {
        if( p != nullptr && p->z() == vp.z() ) {
            m.drawsq( g->w_terrain, *p, drawsq_params().center( vp ) );
        }
        mvwputch( g->w_terrain, t.xy().raw() - vp.xy().raw() + point( POSX, POSY ), c_red, bullet );
    } );
    g->add_draw_callback( bullet_cb );
    bullet_animation().progress();
}

#if defined(TILES)
// Direction of travel at trajectory point i (uses the segment leading into i).
direction get_bullet_dir( const std::vector<tripoint_bub_ms> &trajectory, size_t i )
{
    return i == 0 && trajectory.size() > 1 ?
           direction_from( trajectory[i], trajectory[i + 1] ) :
           ( i >= 1 && i < trajectory.size() ) ?
           direction_from( trajectory[i - 1], trajectory[i] ) :
           direction::NORTH;
}

std::string bullet_sprite_id( const char bullet )
{
    switch( bullet ) {
        case '*':
            return "animation_bullet_normal";
        case '#':
            return "animation_bullet_flame";
        case '`':
            return "animation_bullet_shrapnel";
        default:
            return {};
    }
}

// Directional tracer sprite for the gun-line: an upward-pointing (0deg) beam
// streak that the renderer rotates to the travel direction. Mirrors CBN's
// "animation_bullet_*_0deg" convention. These sprites are flagged rotates:true
// in the tileset; falls back to the round bullet sprite if absent.
std::string tracer_sprite_id( const char bullet )
{
    std::string directional;
    switch( bullet ) {
        case '*':
            directional = "animation_bullet_normal_0deg";
            break;
        case '#':
            directional = "animation_bullet_flame_0deg";
            break;
        case '`':
            directional = "animation_bullet_shrapnel_0deg";
            break;
        default:
            return bullet_sprite_id( bullet );
    }
    // Only use the directional streak if the tileset actually provides it
    // (following looks_like). Otherwise fall back to the round bullet sprite
    // so the gun line still renders on tilesets without _0deg tracers.
    if( tilecontext ) {
        const std::string resolved =
            tilecontext->find_bullet_sprite_id( directional, TILE_CATEGORY::BULLET );
        if( !resolved.empty() ) {
            return resolved;
        }
    }
    return bullet_sprite_id( bullet );
}

// Map a travel direction to this renderer's rotation index. 0 == sprite's
// default orientation (north/up). Cardinals reuse the engine's existing
// rota codes (1=E, 2=S, 3=W); diagonals use the extended codes 5-8 added to
// draw_sprite_at(). NOTE: cardinals follow THIS engine's handedness
// (case 1 renders +90 deg), which is mirrored from CBN on E/W; the diagonal
// angles (45/-45/-135/135) match CBN exactly.
int get_bullet_rotation( direction dir )
{
    switch( dir ) {
        case direction::NORTH:
            return 0;
        case direction::EAST:
            return 1; // +90
        case direction::SOUTH:
            return 2; // 180
        case direction::WEST:
            return 3; // -90
        case direction::NORTHEAST:
            return 5; // +45
        case direction::NORTHWEST:
            return 6; // -45
        case direction::SOUTHWEST:
            return 7; // -135
        case direction::SOUTHEAST:
            return 8; // +135
        default:
            return 0;
    }
}
#endif // TILES

} // namespace

#if defined(TILES)
/* Bullet Animation -- Maybe change this to animate the ammo itself flying through the air?*/
// need to have a version where there is no player defined, possibly. That way shrapnel works as intended
void game::draw_bullet( const tripoint_bub_ms &t, const int /*i*/,
                        const std::vector<tripoint_bub_ms> &/*trajectory*/, const char bullet,
                        const std::string &custom_sprite )
{
    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }
    if( !use_tiles ) {
        draw_bullet_curses( get_map(), t, bullet, nullptr );
        return;
    }

    if( !is_point_visible( t ) ) {
        return;
    }

    static const std::string bullet_unknown  {};
    static const std::string bullet_normal   {"animation_bullet_normal"};
    static const std::string bullet_flame    {"animation_bullet_flame"};
    static const std::string bullet_shrapnel {"animation_bullet_shrapnel"};

    // An ammo/throw-specific sprite (looked up in projectile_attack) takes
    // precedence over the generic per-symbol sprite, mirroring CBN.
    const std::string &bullet_type =
        !custom_sprite.empty() ? custom_sprite
        : bullet == '*' ? bullet_normal
        : bullet == '#' ? bullet_flame
        : bullet == '`' ? bullet_shrapnel
        : bullet_unknown;

    shared_ptr_fast<draw_callback_t> bullet_cb = make_shared_fast<draw_callback_t>( [&]() {
        tilecontext->init_draw_bullet( t, bullet_type );
    } );
    add_draw_callback( bullet_cb );

    bullet_animation().progress();
    tilecontext->void_bullet();
}

#else
void game::draw_bullet( const tripoint_bub_ms &t, const int i,
                        const std::vector<tripoint_bub_ms> &trajectory,
                        const char bullet, const std::string &/*custom_sprite*/ )
{
    draw_bullet_curses( m, t, bullet, &trajectory[i] );
}
#endif

#if defined(TILES)
// Draw the entire trajectory at once as a line of rotated tracer sprites (CBN-style gun line).
void game::draw_bullet_line( const std::vector<tripoint_bub_ms> &trajectory, const char bullet,
                             const std::string &custom_sprite )
{
    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }
    if( trajectory.size() < 2 ) {
        return;
    }

    if( !use_tiles ) {
        // Curses fallback: highlight every visible tile of the trajectory in one frame.
        avatar &player_character = get_avatar();
        const tripoint_bub_ms vp = player_character.pos_bub() + player_character.view_offset;
        map &here = get_map();
        shared_ptr_fast<draw_callback_t> line_cb = make_shared_fast<draw_callback_t>( [&]() {
            for( const tripoint_bub_ms &p : trajectory ) {
                if( is_point_visible( p ) && p.z() == vp.z() ) {
                    here.drawsq( g->w_terrain, p, drawsq_params().highlight( true ) );
                }
            }
        } );
        add_draw_callback( line_cb );
        bullet_animation().progress();
        return;
    }

    // Per-ammo/throw sprite (looked up in projectile_attack) wins; otherwise the
    // directional beam streak (animation_bullet_*_0deg), rotated per-tile to point
    // along the trajectory. Rotating a directional streak (not the round dot) is
    // what makes the flight path read as a continuous gun line.
    const std::string sprite = !custom_sprite.empty() ? custom_sprite : tracer_sprite_id( bullet );

    std::vector<tripoint_bub_ms> points;
    std::vector<std::string> sprites;
    std::vector<int> rotations;
    points.reserve( trajectory.size() );
    sprites.reserve( trajectory.size() );
    rotations.reserve( trajectory.size() );
    for( size_t i = 0; i < trajectory.size(); ++i ) {
        if( !is_point_visible( trajectory[i] ) ) {
            continue;
        }
        points.push_back( trajectory[i] );
        sprites.push_back( sprite );
        // A single bullet sprite, rotated to point along the trajectory. The
        // renderer rotates it per-tile (incl. diagonals) so the whole flight
        // path reads as one continuous gun line.
        rotations.push_back( get_bullet_rotation( get_bullet_dir( trajectory, i ) ) );
    }
    if( points.empty() ) {
        return;
    }

    shared_ptr_fast<draw_callback_t> line_cb = make_shared_fast<draw_callback_t>( [&]() {
        tilecontext->init_draw_bullets( points, sprites, rotations );
    } );
    add_draw_callback( line_cb );
    bullet_animation().progress();
    tilecontext->void_bullet();
}

void game::draw_bullet_async( const std::vector<tripoint_bub_ms> &trajectory, const char bullet,
                              const bool as_line, const std::string &custom_sprite )
{
    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }
    if( !use_tiles || trajectory.size() < 2 ) {
        return;
    }

    // Collect the visible flight path the same way draw_bullet_line does: a
    // directional streak sprite rotated per-tile so the path reads as a gun line.
    const std::string sprite = !custom_sprite.empty() ? custom_sprite : tracer_sprite_id( bullet );
    std::vector<tripoint_bub_ms> points;
    std::vector<std::string> sprites;
    std::vector<int> rotations;
    points.reserve( trajectory.size() );
    sprites.reserve( trajectory.size() );
    rotations.reserve( trajectory.size() );
    for( size_t i = 0; i < trajectory.size(); ++i ) {
        if( !is_point_visible( trajectory[i] ) ) {
            continue;
        }
        points.push_back( trajectory[i] );
        sprites.push_back( sprite );
        rotations.push_back( get_bullet_rotation( get_bullet_dir( trajectory, i ) ) );
    }
    if( points.empty() ) {
        return;
    }

    // Derive the sweep rate from ANIMATION_DELAY so the async dot keeps the same
    // perceived speed as the legacy blocking version (one point per delay-ms).
    // A zero delay (instant) collapses to a one-frame show. The line variant just
    // needs a short visible life; tie it to the same scale.
    const int delay_ms = std::max( 1, get_option<int>( "ANIMATION_DELAY" ) );
    const float dot_per_ms = 1.0f / static_cast<float>( delay_ms );
    // The whole-line look lives for roughly the time the dot would take to cross
    // the path, so a long shot's line lingers a touch longer than a short one,
    // capped so it never overstays.
    const float line_life_ms = std::min( 400.0f,
                                         static_cast<float>( delay_ms ) * static_cast<float>( points.size() ) );
    const float line_per_ms = 1.0f / std::max( 1.0f, line_life_ms );

    tilecontext->init_bullet_anim( points, sprites, rotations, as_line,
                                   as_line ? line_per_ms : dot_per_ms );
    g->invalidate_main_ui_adaptor();
}
#else
void game::draw_bullet_line( const std::vector<tripoint_bub_ms> &trajectory, const char /*bullet*/,
                             const std::string &/*custom_sprite*/ )
{
    if( trajectory.size() < 2 ) {
        return;
    }
    avatar &player_character = get_avatar();
    const tripoint_bub_ms vp = player_character.pos_bub() + player_character.view_offset;
    map &here = get_map();
    shared_ptr_fast<draw_callback_t> line_cb = make_shared_fast<draw_callback_t>( [&]() {
        for( const tripoint_bub_ms &p : trajectory ) {
            if( is_point_visible( p ) && p.z() == vp.z() ) {
                here.drawsq( g->w_terrain, p, drawsq_params().highlight( true ) );
            }
        }
    } );
    add_draw_callback( line_cb );
    bullet_animation().progress();
}
void game::draw_bullet_async( const std::vector<tripoint_bub_ms> &/*trajectory*/,
                              const char /*bullet*/,
                              const bool /*as_line*/, const std::string &/*custom_sprite*/ )
{
    // Curses has no asynchronous projectile path; callers fall back to the
    // synchronous draw_bullet / draw_bullet_line in this build.
}
#endif

namespace
{
// short visual animation (player, monster, ...) (hit, dodge, ...)
// cTile is a UTF-8 strings, and must be a single cell wide!
void hit_animation( const avatar &u, const tripoint_bub_ms &center, nc_color cColor,
                    const std::string &cTile )
{
    const tripoint_rel_ms init_pos = relative_view_pos( u, center );
    // Only show animation if initially visible
    if( init_pos.z() == 0 && is_valid_in_w_terrain( init_pos.xy() ) ) {
        shared_ptr_fast<game::draw_callback_t> hit_cb = make_shared_fast<game::draw_callback_t>( [&]() {
            // In case the window is resized during waiting, we always re-calculate the animation position
            const tripoint_rel_ms pos = relative_view_pos( u, center );
            if( pos.z() == 0 && is_valid_in_w_terrain( pos.xy() ) ) {
                mvwprintz( g->w_terrain, pos.xy().raw(), cColor, cTile );
            }
        } );
        g->add_draw_callback( hit_cb );

        ui_manager::redraw();
        inp_mngr.set_timeout( get_option<int>( "ANIMATION_DELAY" ) );
        // Skip input (if any), because holding down a key with sleep_for can get yourself killed
        inp_mngr.get_input_event();
        inp_mngr.reset_timeout();
    }
}

void draw_hit_mon_curses( const tripoint_bub_ms &center, const monster &m, const avatar &u,
                          const bool dead )
{
    hit_animation( u, center, red_background( m.type->color ), dead ? "%" : m.symbol() );
}

} // namespace

#if defined(TILES)
void game::draw_hit_mon( const tripoint_bub_ms &p, const monster &m, const bool dead, const int dam,
                         const Creature *source )
{
    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }

    if( !use_tiles ) {
        draw_hit_mon_curses( p, m, u, dead );
        return;
    }

    // Use creature reference to resolve sprite position at draw time. A dam of
    // -1 means the caller didn't supply a damage amount, so use a full reaction.
    const int max_hp = m.get_hp_max();
    const float frac = ( dam >= 0 && max_hp > 0 )
                       ? static_cast<float>( dam ) / max_hp : 1.0f;
    // Knockback direction: from the attacker toward the victim (victim - source).
    point dir;
    if( source ) {
        const tripoint_rel_ms d = m.pos_abs() - source->pos_abs();
        dir = point( std::clamp( d.x(), -1, 1 ), std::clamp( d.y(), -1, 1 ) );
    }
    tilecontext->init_draw_hit( m, frac, dir, dead );
}

#else
void game::draw_hit_mon( const tripoint_bub_ms &p, const monster &m, const bool dead, const int,
                         const Creature * )
{
    draw_hit_mon_curses( p, m, u, dead );
}
#endif

namespace
{
void draw_hit_player_curses( const game &/* g */, const Character &p, const int dam )
{
    nc_color const col = !dam ? yellow_background( p.symbol_color() ) : red_background(
                             p.symbol_color() );
    hit_animation( get_avatar(), p.pos_bub(), col, p.symbol() );
}
} //namespace

#if defined(TILES)
void game::draw_hit_player( const Character &p, const int dam, const float damage_fraction,
                            const Creature *source ) const
{
    if( test_mode || !tilecontext ) {
        // avoid segfault from null tilecontext in tests
        return;
    }
    if( !use_tiles ) {
        draw_hit_player_curses( *this, p, dam );
        return;
    }
    // Knockback direction: from the attacker toward the victim (victim - source).
    point dir;
    if( source ) {
        const tripoint_rel_ms d = p.pos_abs() - source->pos_abs();
        dir = point( std::clamp( d.x(), -1, 1 ), std::clamp( d.y(), -1, 1 ) );
    }
    // Use creature reference to resolve sprite position at draw time
    tilecontext->init_draw_hit( p, damage_fraction, dir, false );
    // this creates a blocking delay in user inputs, to give the player time to mentally register the hit
    bullet_animation().progress();
}
#else
void game::draw_hit_player( const Character &p, const int dam, const float, const Creature * ) const
{
    draw_hit_player_curses( *this, p, dam );
}
#endif

#if defined(TILES)
void game::draw_creature_attack( const Creature &attacker, const Creature &target )
{
    if( test_mode || !use_tiles || !tilecontext ) {
        return;
    }
    const tripoint_rel_ms d = target.pos_abs() - attacker.pos_abs();
    const point dir( std::clamp( d.x(), -1, 1 ), std::clamp( d.y(), -1, 1 ) );
    tilecontext->start_creature_attack_anim( attacker.pos_abs(), dir, attacker.is_avatar() );
}
#else
void game::draw_creature_attack( const Creature &, const Creature & )
{
}
#endif

/* Line drawing code, not really an animation but should be separated anyway */
namespace
{
void draw_line_curses( game &g, const tripoint_bub_ms &center,
                       const std::vector<tripoint_bub_ms> &ret,
                       bool noreveal )
{

    avatar &player_character = get_avatar();
    map &here = get_map();
    drawsq_params params = drawsq_params().highlight( true ).center( center );
    creature_tracker &creatures = get_creature_tracker();
    for( const tripoint_bub_ms &p : ret ) {
        const Creature *critter = creatures.creature_at( p, true );

        // NPCs and monsters get drawn with inverted colors
        if( critter && player_character.sees( here, *critter ) ) {
            critter->draw( g.w_terrain, center, true );
        } else if( noreveal && !player_character.sees( here,  p ) ) {
            // Draw a meaningless symbol. Avoids revealing tile, but keeps feedback
            const char sym = '?';
            const nc_color col = c_dark_gray;
            const catacurses::window &w = g.w_terrain;
            const int k = p.x() + getmaxx( w ) / 2 - center.x();
            const int j = p.y() + getmaxy( w ) / 2 - center.y();
            mvwputch( w, point( k, j ), col, sym );
        } else {
            // This function reveals tile at p and writes it to the player's memory
            here.drawsq( g.w_terrain, p, params );
        }
    }
}
} //namespace

#if defined(TILES)
void game::draw_line( const tripoint_bub_ms &p, const tripoint_bub_ms &center,
                      const std::vector<tripoint_bub_ms> &points, bool noreveal )
{
    const map &here = get_map();

    if( !u.sees( here, p ) ) {
        return;
    }

    if( !use_tiles ) {
        draw_line_curses( *this, center, points, noreveal );
        return;
    }

    tilecontext->init_draw_line( p, points, "line_target", true );
}

#else
void game::draw_line( const tripoint_bub_ms &p, const tripoint_bub_ms &center,
                      const std::vector<tripoint_bub_ms> &points, bool noreveal )
{
    const map &here = get_map();

    if( !u.sees( here, p ) ) {
        return;
    }

    draw_line_curses( *this, center, points, noreveal );
}
#endif

namespace
{
void draw_line_curses( game &g, const std::vector<tripoint_bub_ms> &points )
{
    avatar &player_character = get_avatar();
    map &here = get_map();
    for( const tripoint_bub_ms &p : points ) {
        here.drawsq( g.w_terrain, p, drawsq_params().highlight( true ) );
    }

    const tripoint_rel_ms p = points.empty() ? tripoint_rel_ms {POSX, POSY, 0} :
                              relative_view_pos( player_character, points.back() );
    mvwputch( g.w_terrain, p.xy().raw(), c_white, 'X' );
}
} //namespace

#if defined(TILES)
void game::draw_line( const tripoint_bub_ms &p, const std::vector<tripoint_bub_ms> &points )
{
    draw_line_curses( *this, points );
    tilecontext->init_draw_line( p, points, "line_trail", false );
}
#else
void game::draw_line( const tripoint_bub_ms &/*p*/, const std::vector<tripoint_bub_ms> &points )
{
    draw_line_curses( *this, points );
}
#endif

#if defined(TILES)
void game::draw_cursor( const tripoint_bub_ms &p ) const
{
    const tripoint_rel_ms rp = relative_view_pos( *this, p );
    mvwputch_inv( w_terrain, rp.xy().raw(), c_light_green, 'X' );
    tilecontext->init_draw_cursor( p );
}
#else
void game::draw_cursor( const tripoint_bub_ms &p ) const
{
    const tripoint_rel_ms rp = relative_view_pos( *this, p );
    mvwputch_inv( w_terrain, rp.xy().raw(), c_light_green, 'X' );
}
#endif

void game::draw_cursor_unobscuring( const tripoint_bub_ms &p ) const
{
    const tripoint_rel_ms rp = relative_view_pos( *this, p );
    mvwputch_inv( w_terrain, ( rp.xy() + point::north_east ).raw(), c_cyan, "↙" );
    mvwputch_inv( w_terrain, ( rp.xy() + point::south_east ).raw(), c_cyan, "↖" );
    mvwputch_inv( w_terrain, ( rp.xy() + point::north_west ).raw(), c_cyan, "↘" );
    mvwputch_inv( w_terrain, ( rp.xy() + point::south_west ).raw(), c_cyan, "↗" );
#if defined(TILES)
    tilecontext->init_draw_cursor( p );
#endif
}

#if defined(TILES)
void game::draw_highlight( const tripoint_bub_ms &p )
{
    tilecontext->init_draw_highlight( p );
}
#else
void game::draw_highlight( const tripoint_bub_ms & )
{
    // Do nothing
}
#endif

namespace
{
void draw_weather_curses( const catacurses::window &win, const weather_printable &w )
{
    wattron( win, w.colGlyph );
    const std::string symbol = w.get_symbol();
    for( const auto &drop : w.vdrops ) {
        mvwprintw( win, point( drop.first, drop.second ), symbol );
    }
    wattroff( win, w.colGlyph );
}
} //namespace

#if defined(TILES)
void game::draw_weather( const weather_printable &w ) const
{
    if( !use_tiles ) {
        draw_weather_curses( w_terrain, w );
        return;
    }

    tilecontext->init_draw_weather( w, w.wtype->tiles_animation );
}
#else
void game::draw_weather( const weather_printable &w ) const
{
    draw_weather_curses( w_terrain, w );
}
#endif

namespace
{
void draw_sct_curses( const game &g )
{
    avatar &player_character = get_avatar();
    const tripoint_rel_ms off = relative_view_pos( player_character,
                                tripoint_bub_ms::zero );

    for( const scrollingcombattext::cSCT &text : SCT.vSCT ) {
        const int dy = off.y() + text.getPosY();
        const int dx = off.x() + text.getPosX();

        if( !is_valid_in_w_terrain( { dx, dy } ) ) {
            continue;
        }

        const bool is_old = text.getStep() >= scrollingcombattext::iMaxSteps / 2;

        nc_color const col1 = msgtype_to_color( text.getMsgType( "first" ),  is_old );
        nc_color const col2 = msgtype_to_color( text.getMsgType( "second" ), is_old );

        mvwprintz( g.w_terrain, point( dx, dy ), col1, text.getText( "first" ) );
        wprintz( g.w_terrain, col2, text.getText( "second" ) );
    }
}
} //namespace

#if defined(TILES)
void game::draw_sct() const
{
    if( use_tiles ) {
        tilecontext->init_draw_sct();
    } else {
        draw_sct_curses( *this );
    }
}
#else
void game::draw_sct() const
{
    draw_sct_curses( *this );
}
#endif

namespace
{
void draw_zones_curses( const catacurses::window &w, const tripoint_bub_ms &start,
                        const tripoint_bub_ms &end,
                        const tripoint_rel_ms &offset )
{
    if( end.x() < start.x() || end.y() < start.y() || end.z() < start.z() ) {
        return;
    }

    nc_color    const col = invert_color( c_light_green );

    wattron( w, col );
    mvwrectf( w, ( start - offset ).xy().raw(), '~', end.x() - start.x() + 1, end.y() - start.y() + 1 );
    wattroff( w, col );
}
} //namespace

#if defined(TILES)
void game::draw_zones( const tripoint_bub_ms &start, const tripoint_bub_ms &end,
                       const tripoint_rel_ms &offset ) const
{
    if( use_tiles ) {
        tilecontext->init_draw_zones( start, end, offset );
    } else {
        draw_zones_curses( w_terrain, start, end, offset );
    }
}
#else
void game::draw_zones( const tripoint_bub_ms &start, const tripoint_bub_ms &end,
                       const tripoint_rel_ms &offset ) const
{
    draw_zones_curses( w_terrain, start, end, offset );
}
#endif

#if defined(TILES)
void game::draw_async_anim( const tripoint_bub_ms &p, std::string_view tile_id,
                            const std::string &ncstr,
                            const nc_color &nccol )
{
    const map &here = get_map();

    if( test_mode ) {
        // avoid segfault from null tilecontext in tests
        return;
    }

    if( !get_option<bool>( "ANIMATIONS" ) ) {
        return;
    }

    if( !u.sees( here, p ) ) {
        return;
    }

    if( !use_tiles ) {
        if( !ncstr.empty() ) {
            g->init_draw_async_anim_curses( p, ncstr, nccol );
        }
        return;
    }

    tilecontext->init_draw_async_anim( p, std::string( tile_id ) );
    g->invalidate_main_ui_adaptor();
}
#else
void game::draw_async_anim( const tripoint_bub_ms &p, std::string_view,
                            const std::string &ncstr,
                            const nc_color &nccol )
{
    if( !ncstr.empty() ) {
        g->init_draw_async_anim_curses( p, ncstr, nccol );
    }
}
#endif

#if defined(TILES)
void game::draw_radiation_override( const tripoint_bub_ms &p, const int rad )
{
    if( use_tiles ) {
        tilecontext->init_draw_radiation_override( p, rad );
    }
}
#else
void game::draw_radiation_override( const tripoint_bub_ms &, const int )
{
}
#endif

#if defined(TILES)
void game::draw_terrain_override( const tripoint_bub_ms &p, const ter_id &id )
{
    if( use_tiles ) {
        tilecontext->init_draw_terrain_override( p, id );
    }
}
#else
void game::draw_terrain_override( const tripoint_bub_ms &, const ter_id & )
{
}
#endif

#if defined(TILES)
void game::draw_furniture_override( const tripoint_bub_ms &p, const furn_id &id )
{
    if( use_tiles ) {
        tilecontext->init_draw_furniture_override( p, id );
    }
}
#else
void game::draw_furniture_override( const tripoint_bub_ms &, const furn_id & )
{
}
#endif

#if defined(TILES)
void game::draw_graffiti_override( const tripoint_bub_ms &p, const bool has )
{
    if( use_tiles ) {
        tilecontext->init_draw_graffiti_override( p, has );
    }
}
#else
void game::draw_graffiti_override( const tripoint_bub_ms &, const bool )
{
}
#endif

#if defined(TILES)
void game::draw_trap_override( const tripoint_bub_ms &p, const trap_id &id )
{
    if( use_tiles ) {
        tilecontext->init_draw_trap_override( p, id );
    }
}
#else
void game::draw_trap_override( const tripoint_bub_ms &, const trap_id & )
{
}
#endif

#if defined(TILES)
void game::draw_field_override( const tripoint_bub_ms &p, const field_type_id &id )
{
    if( use_tiles ) {
        tilecontext->init_draw_field_override( p, id );
    }
}
#else
void game::draw_field_override( const tripoint_bub_ms &, const field_type_id & )
{
}
#endif

#if defined(TILES)
void game::draw_item_override( const tripoint_bub_ms &p, const itype_id &id, const mtype_id &mid,
                               const bool hilite )
{
    if( use_tiles ) {
        tilecontext->init_draw_item_override( p, id, mid, hilite );
    }
}
#else
void game::draw_item_override( const tripoint_bub_ms &, const itype_id &, const mtype_id &,
                               const bool )
{
}
#endif

#if defined(TILES)
void game::draw_vpart_override(
    const tripoint_bub_ms &p, const vpart_id &id, const int part_mod, const units::angle &veh_dir,
    const bool hilite, const point_rel_ms &mount )
{
    if( use_tiles ) {
        tilecontext->init_draw_vpart_override( p, id, part_mod, veh_dir, hilite, mount );
    }
}
#else
void game::draw_vpart_override( const tripoint_bub_ms &, const vpart_id &, const int,
                                const units::angle &, const bool, const point_rel_ms & )
{
}
#endif

#if defined(TILES)
void game::draw_monster_override( const tripoint_bub_ms &p, const mtype_id &id, const int count,
                                  const bool more, const Creature::Attitude att )
{
    if( use_tiles ) {
        tilecontext->init_draw_monster_override( p, id, count, more, att );
    }
}
#else
void game::draw_monster_override( const tripoint_bub_ms &, const mtype_id &, const int,
                                  const bool, const Creature::Attitude )
{
}
#endif
