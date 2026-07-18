#pragma once
#ifndef CATA_SRC_VIEW_SNAPSHOT_H
#define CATA_SRC_VIEW_SNAPSHOT_H

#include <array>
#include <cstdint>
#include <optional>
#include <string>
#include <variant>
#include <vector>

#include "character_id.h"
#include "coords_fwd.h"
#include "enums.h"
#include "game_constants.h"
#include "hsv_color.h"
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
    // ═══ L3 semantic data — immutable after the dirty-gated rebuild ═══
    // Belongs to the server↔client boundary: only the coordinate (pos) lives
    // here; static content (ter/furn/trap etc.) is captured separately in
    // sprite::*_content fields.  No L1-L2 rendering artifacts.
    struct tile_view_data {
        const tripoint_bub_ms pos;
        explicit tile_view_data( const tripoint_bub_ms &p ) : pos( p ) {}
    };

    // ═══ L1-L2 rendering scratch — per-frame mutable ═══
    // All fields are recomputed or mutated every frame during the layer loop.
    // They are purely client-side (sprite bounds, tint RGBA, height stack) and
    // must never appear in a server-produced snapshot.
    struct tile_render_scratch {
        // Accumulator for 3d tallness of sprites rendered here so far; also
        // used as a save/restore scratch variable during vehicle drawing.
        int height_3d = 0;

        explicit tile_render_scratch( int h3d = 0 ) : height_3d( h3d ) {}
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
        // these change.  Fields, items, and vehicle parts are captured
        // per-frame in draw(); creatures remain on the live path for now.
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

        // Field data captured every frame just before the layer loop.
        // Fields can appear between the dirty-gated rebuild and draw
        // time (an intermediate draw during handle_action can consume
        // the dirty flag before a later action creates the field),
        // so a one-shot rebuild-time capture is insufficient.
        // Default-constructed field_type_id (null) means no displayable
        // field is present on this tile.
        field_type_id field_content;
        int field_intensity = 0;

        // Item data for the topmost visible item, captured per-frame
        // alongside fields.  Items can appear or disappear between the
        // dirty-gated rebuild and the layer loop (monster drops, pickup
        // during handle_action, etc.), so a one-shot rebuild-time
        // capture is insufficient.
        // Default-constructed itype_id (null) means no displayable
        // topmost item is visible on this tile.
        itype_id item_content;
        mtype_id item_corpse_mtype;
        std::string item_variant;
        int item_count = 0;
        bool sees_items = false;

        // Vehicle part data captured per-frame.  Vehicles move and parts
        // change state every turn (movement, open/close, break), so a
        // one-shot rebuild-time capture is insufficient.
        // Default-constructed vpart_id (null) means no vehicle part is
        // present on this tile.
        vpart_id vpart_content;
        int vpart_subtile = 0;           // 0 = normal, open_, broken
        int vpart_rotation = 0;          // angle_to_dir4(face.dir - 270°)
        std::string vpart_variant;       // variant id string
        std::string vpart_carried_furn;  // carried furniture id
        bool vpart_has_cargo = false;    // for cargo highlight
        std::optional<RGBColor> vpart_tint;  // custom paint color

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
        void set_field_content( const field_type_id &fid, const int intensity ) {
            field_content = fid;
            field_intensity = intensity;
        }
        void set_item_content( const itype_id &it, const mtype_id &corpse_mt,
                               const std::string &variant, const int count,
                               const bool sees ) {
            item_content = it;
            item_corpse_mtype = corpse_mt;
            item_variant = variant;
            item_count = count;
            sees_items = sees;
        }
        void set_vpart_content( const vpart_id &id, const int subtile,
                                const int rotation, const std::string &variant,
                                const std::string &carried_furn, const bool has_cargo,
                                const std::optional<RGBColor> &tint ) {
            vpart_content = id;
            vpart_subtile = subtile;
            vpart_rotation = rotation;
            vpart_variant = variant;
            vpart_carried_furn = carried_furn;
            vpart_has_cargo = has_cargo;
            vpart_tint = tint;
        }
    };

    tile_view_data view;
    tile_render_scratch scratch;
    std::variant<vision_effect, sprite> var;

    tile_render_info( const tile_view_data &v, const tile_render_scratch &s,
                      const vision_effect &var )
        : view( v ), scratch( s ), var( var ) {}

    tile_render_info( const tile_view_data &v, const tile_render_scratch &s,
                      const sprite &var )
        : view( v ), scratch( s ), var( var ) {}
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
                // NOLINTNEXTLINE(cata-large-inline-function)
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
                // Range-based for support for per-z-level row iteration.
                auto begin()       {
                    return rows.begin();
                }
                auto end()         {
                    return rows.end();
                }
                auto begin() const {
                    return rows.begin();
                }
                auto end()   const {
                    return rows.end();
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
// 1. COORDINATE SPLIT: origin is tripoint_abs_ms, but tile_view_data::pos
//    is tripoint_bub_ms (bubble-relative).  Server-side snapshots must use world-
//    absolute coordinates throughout.
//
// 2. ✅ RESOLVED: tile_render_info split into tile_view_data (L3, const pos) and
//    tile_render_scratch (L1-L2, per-frame mutable).  The layer loop no longer
//    writes rendering state into the same struct that holds the semantic coordinate.
//
// 3. ✅ RESOLVED: transient RGBA tint, screen-space bounds, and sprite recordings
//    live in a sparse per-row sidecar in cata_tiles::draw; tile_render_scratch
//    retains only the height accumulator and tile_view_data only the L3 coordinate.
//
// 4. MISSING L3 DATA (not captured yet; live-read every frame):
//    - creature data (CreatureView: type id, facing, mount/summoner flags)
//    - light scalar/color (currently read live from the level cache while drawing)
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
