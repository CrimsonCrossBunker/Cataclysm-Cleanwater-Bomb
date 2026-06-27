#pragma once
#ifndef CATA_SRC_VIEW_SNAPSHOT_H
#define CATA_SRC_VIEW_SNAPSHOT_H

#include <array>
#include <cstdint>
#include <string>
#include <variant>
#include <vector>

#include "cata_small_literal_vector.h"
#include "character_id.h"
#include "coords_fwd.h"
#include "enums.h"
#include "game_constants.h"
#include "type_id.h"

#if defined(TILES)

// Accumulated screen-pixel bounding box of all sprites drawn for a single tile
// during the current frame. Used by the ortho tint overlay to cover the full
// sprite extent instead of a fixed tile_width x tile_height rect.
// NOLINTNEXTLINE(cata-xy)
struct sprite_screen_bounds {
    int x = 0, y = 0, w = 0, h = 0;
    bool valid = false;
    // NOLINTNEXTLINE(cata-large-inline-function,cata-xy)
    void expand( int rx, int ry, int rw, int rh ) {
        if( !valid ) {
            x = rx;
            y = ry;
            w = rw;
            h = rh;
            valid = true;
        } else {
            const int nx = x < rx ? x : rx; // NOLINT(cata-combine-locals-into-point)
            const int ny = y < ry ? y : ry;
            const int x2 = ( x + w > rx + rw ) ? x + w : rx + rw;
            const int y2 = ( y + h > ry + rh ) ? y + h : ry + rh;
            x = nx;
            y = ny;
            w = x2 - nx;
            h = y2 - ny;
        }
    }
};

// Snapshot of a single sprite draw call, recorded during the layer loop so the
// ortho tint overlay can replay the sprite as a white silhouette into a mask
// texture. Captures everything needed to reproduce the draw at the same screen
// position with the silhouette color filter variant.
struct tint_sprite_record {
    int sprite_index;      // index into tileset tile_values / silhouette_tile_values
    struct { // NOLINT(cata-xy)
        int x, y, w, h;
    } destination;         // screen-space destination rect at time of draw
    double angle;          // rotation angle (0, -90, 90)
    int flip;              // CataFlipMode cast to int (avoids SDL include)
};

struct tile_render_info {
    struct common {
        const tripoint_bub_ms pos;

        // ═══ TODO(client-server): L1-L2 rendering state mixed into L3 snapshot ═══
        //
        // L1 = client-side: sprite selection, RGBA tint, visibility dimming
        // L2 = client-side: draw-list ordering, scene composition, animation
        // L3 = server↔client boundary: semantic type-ids, scalar light, flags
        //
        // The fields below — height_3d, bounds, tint_sprites, needs_tint, tint_color —
        // are all L1-L2 rendering artifacts computed or mutated every frame during the
        // layer loop.  They do NOT belong in the L3 semantic boundary: the server must
        // not compute RGBA tint, screen-space bounds, or sprite recordings.  Only
        // light_scalar (float) and light_color (semantic name, not RGB) cross the
        // boundary.
        //
        // Worse, these fields are *mutated during consumption* — the layer loop writes
        // height_3d, tint_color, bounds, and tint_sprites every frame.  An immutable
        // snapshot model requires splitting common into:
        //   tile_view_data  (L3, const after rebuild): pos, static content, visibility,
        //                    light scalar + semantic light color
        //   tile_render_scratch (L1-L2, per-frame mutable): height_3d, bounds,
        //                    tint_sprites, needs_tint, tint_color
        //
        // height_3d is additionally used as a save/restore scratch variable during
        // vehicle drawing, which is fundamentally incompatible with an immutable
        // snapshot.

        // accumulator for 3d tallness of sprites rendered here so far;
        int height_3d = 0;
        // Ortho tint overlay state, populated during the draw prepass and layer
        // loop. For tiles where needs_tint is true:
        //   bounds       - union of all content sprite screen rects (opaque only)
        //   tint_sprites - draw records for silhouette mask replay
        //   tint_color   - precomputed RGBA tint from the colored light cache
        sprite_screen_bounds bounds;
        small_literal_vector<tint_sprite_record, 4> tint_sprites;
        bool needs_tint = false;
        struct {
            uint8_t r, g, b, a;
        } tint_color = { 0, 0, 0, 0 };

        common( const tripoint_bub_ms &pos, const int height_3d )
            : pos( pos ), height_3d( height_3d ) {}
    };

    struct vision_effect {
        visibility_type vis;

        explicit vision_effect( const visibility_type vis )
            : vis( vis ) {}
    };

    struct sprite {
        lit_level ll;
        std::array<bool, 5> invisible;

        // Static-layer semantic content (type id + connection subtile/rotation,
        // graffiti text, partial-construction presence) captured during the
        // dirty-gated draw-cache rebuild and consumed by the draw_* functions
        // in their normal visible branch — the renderer no longer reads the map
        // live for these layers.
        //
        // Only the static layers are captured here — terrain, furniture, trap,
        // partial construction, graffiti — because the rebuild runs only when
        // the cache is marked dirty (player action), which matches how often
        // these change. Dynamic content (fields, items, vehicles, creatures)
        // changes every turn and is left on the live path for now.
        //
        // A null/empty content field means nothing was captured for that layer
        // (memory / override / invisible tiles, or simply nothing present).
        ter_id ter_content;
        int ter_content_subtile = 0;
        int ter_content_rotation = 0;
        furn_id furn_content;
        int furn_content_subtile = 0;
        int furn_content_rotation = 0;
        trap_id trap_content;
        int trap_content_subtile = 0;
        int trap_content_rotation = 0;
        bool part_con_content = false;
        // Graffiti is captured as text + rotation; empty text means no graffiti
        // was present on this visible tile (distinct from "not captured").
        bool graffiti_captured = false;
        std::string graffiti_content;
        int graffiti_content_rotation = 0;

        sprite( const lit_level ll, const std::array<bool, 5> &inv )
            : ll( ll ), invisible( inv ) {}

        void set_ter_content( const ter_id &t, const int subtile, const int rotation ) {
            ter_content = t;
            ter_content_subtile = subtile;
            ter_content_rotation = rotation;
        }
        void set_furn_content( const furn_id &f, const int subtile, const int rotation ) {
            furn_content = f;
            furn_content_subtile = subtile;
            furn_content_rotation = rotation;
        }
        void set_trap_content( const trap_id &tr, const int subtile, const int rotation ) {
            trap_content = tr;
            trap_content_subtile = subtile;
            trap_content_rotation = rotation;
        }
        void set_graffiti_content( const std::string &text, const int rotation ) {
            graffiti_captured = true;
            graffiti_content = text;
            graffiti_content_rotation = rotation;
        }
    };

    common com;
    std::variant<vision_effect, sprite> var;

    tile_render_info( const common &com, const vision_effect &var )
        : com( com ), var( var ) {}

    tile_render_info( const common &com, const sprite &var )
        : com( com ), var( var ) {}
};

/**
 * Flat-storage replacement for the former
 * std::map<int, std::map<int, std::vector<tile_render_info>>> draw-points cache.
 *
 * The z dimension is a fixed array indexed by (zlevel + OVERMAP_DEPTH); the row
 * dimension is a contiguous vector offset by the first row touched. Both reuse
 * their buffers across frames (see soft_clear) so the per-move rebuild no longer
 * frees and reallocates std::map nodes / row vectors every step — that churn was
 * the dominant movement-time render cost. operator[] auto-grows like the old
 * std::map operator[], so an untouched [z][row] still reads back empty.
 */
class draw_points_cache_t
{
    public:
        using row_vec = std::vector<tile_render_info>;

        // Row storage for a single z-level, addressed by absolute screen row.
        // row_base is the absolute row of rows[0].
        class level_rows
        {
            public:
                row_vec &operator[]( const int row ) {
                    if( !initialized ) {
                        row_base = row;
                        initialized = true;
                    }
                    if( row < row_base ) {
                        // Prepend empty rows. tile_render_info has a const member
                        // (deleted copy/move assignment), so vector::insert — which
                        // shifts via assignment — won't compile. Rebuild front-to-back
                        // using move-construction only.
                        std::vector<row_vec> grown;
                        grown.reserve( rows.size() + static_cast<size_t>( row_base - row ) );
                        grown.resize( static_cast<size_t>( row_base - row ) );
                        for( row_vec &r : rows ) {
                            grown.push_back( std::move( r ) );
                        }
                        rows.swap( grown );
                        row_base = row;
                    }
                    const size_t idx = static_cast<size_t>( row - row_base );
                    if( idx >= rows.size() ) {
                        rows.resize( idx + 1 );
                    }
                    return rows[idx];
                }
                void soft_clear() {
                    for( row_vec &r : rows ) {
                        r.clear(); // keep capacity
                    }
                }
            private:
                int row_base = 0;
                bool initialized = false;
                std::vector<row_vec> rows;
        };

        level_rows &operator[]( const int zlevel ) {
            return levels[zlevel + OVERMAP_DEPTH];
        }
        void soft_clear() {
            for( level_rows &lr : levels ) {
                lr.soft_clear();
            }
        }
    private:
        std::array<level_rows, OVERMAP_LAYERS> levels;
};

// ═══ Client-server roadmap ═══
//
// view_snapshot is the first step toward the L3 semantic boundary, but it
// currently carries a pre-existing working buffer (draw_points_cache_t) that
// mixes L3 semantic data with L1-L2 rendering artifacts.  Known gaps:
//
// 1. COORDINATE SPLIT: origin is tripoint_abs_ms, but tile_render_info::common::pos
//    is tripoint_bub_ms (bubble-relative).  Server-side snapshots must use world-
//    absolute coordinates throughout.
//
// 2. MUTABLE DURING CONSUMPTION: the layer loop writes height_3d, tint_color, bounds,
//    and tint_sprites into the cache every frame.  A true snapshot must be immutable
//    after production.  Requires splitting tile_render_info into tile_view_data (L3,
//    const) and tile_render_scratch (L1-L2, mutable).
//
// 3. FALSE SUMMIT: despite the name, this struct is NOT yet a clean L3 boundary type.
//    The tiles member contains RGBA tint (L1), screen-space bounds (L2), and sprite
//    recordings (L1) — all client-side computations.  See tile_render_info::common
//    for the full TODO.
//
// 4. MISSING L3 DATA (not captured yet; live-read every frame):
//    - field data (type + intensity)
//    - item data (topmost item itype_id + count)
//    - vehicle part data (vpart_id + display state + paint color name)
//    - creature data (CreatureView: type id, facing, mount/summoner flags)
//    - light scalar (float from lm[][]) — currently only computed RGBA tint is stored
//    - memorized tile content (for invisible/memory tiles)
//    - per-tile version (for delta encoding)
//
// 5. GENERATION: a bare monotonic uint64_t; for client-server the client needs game
//    turn + sub-turn tick to interpolate between snapshots.
//
// 6. SERIALIZATION: character_id has serialize(); draw_points_cache_t and
//    tile_render_info do not.  The full snapshot chain must be serializable for
//    network transmission.
//
// 7. OWNERSHIP: currently embedded in map; future: produced by simulate_turn()
//    per observer as a standalone value object.
//
// None of these gaps block the current refactor — they are documented here so
// future work has a single source of truth for what remains.
struct view_snapshot {
    // World-absolute coordinate of tiles[0][0], i.e. the top-left corner
    // of the viewport at its bottom z-level. origin.z is draw_min_z,
    // distinct from observer_z.
    tripoint_abs_ms origin;

    // z-level of the observer, used for height_3d computation in the
    // layer loop: height_3d = (cur_zlevel - observer_z) * zlevel_height.
    int observer_z = 0;

    // Viewport dimensions in tile columns × rows.
    point size;

    // Observer whose FOV / visibility / memory this snapshot reflects.
    // character_id() (value=-1, !is_valid()) means "no observer."
    character_id observer;

    // Per-tile draw-point array: levels[z + OVERMAP_DEPTH][row] vector.
    draw_points_cache_t tiles;

    // Monotonic generation counter. Incremented once per snapshot rebuild
    // (dirty gate), not per render frame. For client/server this is the
    // authoritative game-state version; the client uses it for interpolation.
    uint64_t generation = 0;
};

#endif // TILES
#endif // CATA_SRC_VIEW_SNAPSHOT_H
