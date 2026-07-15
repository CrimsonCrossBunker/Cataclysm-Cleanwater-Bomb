#pragma once
#ifndef CATA_SRC_CATA_TILES_H
#define CATA_SRC_CATA_TILES_H

#include <array>
#include <atomic>
#include <bitset>
#include <chrono>
#include <cstddef>
#include <deque>
#include <functional>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <tuple>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include <cstdint>

#include "animation.h"
#include "calendar.h"
#include "cata_small_literal_vector.h"
#include "coordinates.h"
#include "creature.h"
#include "cuboid_rectangle.h"
#include "hsv_color.h"
#include "mapdata.h"
#include "options.h"
#include "pimpl.h"
#include "point.h"
#include "sdl_geometry.h"
#include "sct_effect.h"
#include "sdl_wrappers.h"
#include "shockwave.h"
#include "transient_effect.h"
#include "transient_visual_layer.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weighted_list.h"

#if SDL_MAJOR_VERSION >= 3
#include "cata_shader.h"

namespace cata_shader
{
class variant_pass;
} // namespace cata_shader

// Maps draw-dispatch inputs to the variant_kind enum the GPU shader path
// consumes.
enum class lit_level : uint8_t;
cata_shader::variant_kind compute_variant_kind( lit_level ll, bool use_nv_tiles );
#endif

class Character;
class memorized_tile;
class monster;
class nc_color;
class pixel_minimap;
class vehicle;
struct sprite_screen_bounds;
struct tint_sprite_record;
struct tile_render_info;

namespace catacurses
{
class window;
} // namespace catacurses
enum class direction : unsigned int;
enum class lit_level : uint8_t;
enum class visibility_type : int;


/** Structures */
struct tile_type {
    // fg and bg are both a weighted list of lists of sprite IDs
    weighted_int_list<std::vector<int>> fg, bg;
    bool multitile = false;
    bool rotates = false;
    bool animated = false;
    int height_3d = 0;
    point offset = point::zero;
    point offset_retracted = point::zero;
    float pixelscale = 1.0;

    std::vector<std::string> available_subtiles;
};

// Make sure to change TILE_CATEGORY_IDS if this changes!
enum class TILE_CATEGORY {
    NONE,
    VEHICLE_PART,
    TERRAIN,
    ITEM,
    FURNITURE,
    TRAP,
    FIELD,
    LIGHTING,
    MONSTER,
    BULLET,
    HIT_ENTITY,
    WEATHER,
    OVERMAP_TERRAIN,
    OVERMAP_VISION_LEVEL,
    OVERMAP_WEATHER,
    MAP_EXTRA,
    OVERMAP_NOTE,
    last
};

const std::unordered_map<std::string, TILE_CATEGORY> to_TILE_CATEGORY = {
    {"none", TILE_CATEGORY::NONE},
    {"vehicle_part", TILE_CATEGORY::VEHICLE_PART},
    {"terrain", TILE_CATEGORY::TERRAIN},
    {"item", TILE_CATEGORY::ITEM},
    {"furniture", TILE_CATEGORY::FURNITURE},
    {"trap", TILE_CATEGORY::TRAP},
    {"field", TILE_CATEGORY::FIELD},
    {"lighting", TILE_CATEGORY::LIGHTING},
    {"monster", TILE_CATEGORY::MONSTER},
    {"bullet", TILE_CATEGORY::BULLET},
    {"hit_entity", TILE_CATEGORY::HIT_ENTITY},
    {"weather", TILE_CATEGORY::WEATHER},
    {"overmap_terrain", TILE_CATEGORY::OVERMAP_TERRAIN},
    {"overmap_vision_level", TILE_CATEGORY::OVERMAP_VISION_LEVEL},
    {"overmap_weather", TILE_CATEGORY::OVERMAP_WEATHER},
    {"map_extra", TILE_CATEGORY::MAP_EXTRA},
    {"overmap_note", TILE_CATEGORY::OVERMAP_NOTE}
};

class tile_lookup_res
{
        // references are stored as pointers to support copy assignment of the class
        const std::string *_id;
        tile_type *_tile;
    public:
        tile_lookup_res( const std::string &id, tile_type &tile ): _id( &id ), _tile( &tile ) {}
        inline const std::string &id() {
            return *_id;
        }
        inline tile_type &tile() {
            return *_tile;
        }
};

class texture
{
    private:
        std::shared_ptr<SDL_Texture> sdl_texture_ptr;
        SDL_Rect srcrect = { 0, 0, 0, 0 };
        // Tightest rect containing non-transparent pixels, relative to srcrect origin.
        // Used for tint overlay bounds so transparent padding is excluded.
        SDL_Rect opaque_rect = { 0, 0, 0, 0 };

    public:
        texture( std::shared_ptr<SDL_Texture> ptr,
                 const SDL_Rect &rect ) : sdl_texture_ptr( std::move( ptr ) ),
            srcrect( rect ), opaque_rect( { 0, 0, rect.w, rect.h } ) { }
        texture( std::shared_ptr<SDL_Texture> ptr,
                 const SDL_Rect &rect, const SDL_Rect &opaque ) : sdl_texture_ptr( std::move( ptr ) ),
            srcrect( rect ), opaque_rect( opaque ) { }
        texture() = default;

        /// Returns the width (first) and height (second) of the stored texture.
        std::pair<int, int> dimension() const {
            return std::make_pair( srcrect.w, srcrect.h );
        }
        /// Returns the opaque pixel bounding box relative to the sprite origin.
        const SDL_Rect &get_opaque_rect() const {
            return opaque_rect;
        }
        /// Returns the underlying SDL_Texture pointer (for blend mode changes).
        const std::shared_ptr<SDL_Texture> &get_texture_ptr() const {
            return sdl_texture_ptr;
        }
        /// Interface to @ref SDL_RenderCopyEx, using this as the texture, and
        /// the stored source rectangle. Other parameters are simply passed through.
        int render_copy_ex( const SDL_Renderer_Ptr &renderer, const SDL_Rect *const dstrect,
                            const double angle,
                            const SDL_Point *const center, const CataFlipMode flip ) const {
            RenderCopyEx( renderer, sdl_texture_ptr.get(), &srcrect, dstrect, angle, center, flip );
            return 0;
        }
};

// Reason an atlas upload was interrupted. A separate enum from the recovery
// coordinator's severity so the tileset loader needs no coordinator header;
// the coordinator maps these to severities. paused stops the upload so it
// retries on foreground; the *_invalidated reasons mean a reset or device
// loss was observed mid upload.
enum class atlas_upload_interrupt {
    none,
    paused,
    texture_resources_invalidated,
    renderer_invalidated,
};
// Polled between atlas chunks. Returns the reason to stop, or none.
using atlas_upload_poll = std::function<atlas_upload_interrupt()>;

// Candidate atlas textures captured when an upload is interrupted, kept
// alive past the pause so their destructors never run against a suspended or
// destroyed renderer. Each batch shares one gate captured by every texture's
// deleter: setting it suppresses SDL_DestroyTexture when the originating
// renderer is torn down before the quarantine is drained.
class atlas_replay_quarantine
{
    public:
        using gate = gpu_handle_graveyard::gate;

        struct batch {
            gpu_handle_graveyard handles;
            uint64_t renderer_instance_generation = 0;
        };

        void add( batch &&b );
        bool empty() const {
            return batches_.empty();
        }
        // Abandon gate shared by the most recently added batch's handles, or
        // null when empty, so a caller can tell an abandoned batch (gate set)
        // from a drained one.
        gate last_batch_gate() const {
            return batches_.empty() ? gate{} :
                   batches_.back().handles.current_gate();
        }
        // Destroy the quarantined textures against the still-live renderer.
        void drain_live_renderer();
        // Release C++ ownership without SDL_DestroyTexture because the
        // originating renderer is being destroyed; its device reclaims the
        // GPU memory on teardown.
        void abandon_pre_lost_renderer();

    private:
        std::vector<batch> batches_;
};

/**
 * Bundles per-tile rendering state so the draw path carries all lighting
 * decisions in one place. Future fields (light color tint, per-tile
 * brightness) extend this struct without adding parameters to every function.
 */
struct tile_render_params {
    lit_level ll;
    bool use_night_vision_tiles = false;
    // When set, the sprite is recolored toward this color (vehicle part paint).
    std::optional<RGBColor> tint = std::nullopt;
};

/**
* Holds weighted map of sprites for contextual tile layering
* e.g. different sprites for item "pen" on "f_desk"
*/
class layer_context_sprites
{
    public:
        std::string id;
        std::map<std::string, int> sprite;
        //draw order is sorted by layer
        int layer;
        point offset;
        int total_weight;
        //if set, appends to the sprite name for handling contexts
        std::string append_suffix;
};

// Inputs needed to re-upload one atlas after renderer recreate or
// device-texture reset. image_path_u8 is a UTF-8 byte sequence so the
// descriptor avoids a cata_path dependency.
// Test-only seam (full definition in sdl_renderer_recovery.h), befriended below.
struct renderer_recovery_test_support;

struct atlas_replay_descriptor {
    std::string image_path_u8;
    int color_key_r = -1;
    int color_key_g = -1;
    int color_key_b = -1;
    int sprite_width = 0;
    int sprite_height = 0;
    int atlas_offset = 0;
    int expected_tilecount = 0;
};

class tileset
{
    private:
        struct season_tile_value {
            tile_type *default_tile = nullptr;
            std::optional<tile_lookup_res> season_tile = std::nullopt;
        };

        std::string tileset_id;

        bool tile_isometric = false;
        // Unscaled default size of sprites. See cata_tiles::tile_(width|height)
        // for more detail.
        int tile_width = 0;
        int tile_height = 0;
        // The maximum extent of loaded sprites.
        half_open_rectangle<point> max_tile_extent;
        int zlevel_height = 0;

        float prevent_occlusion_min_dist = 0.0;
        float prevent_occlusion_max_dist = 0.0;

        // multiplier for pixel-doubling tilesets
        float tile_pixelscale = 1.0f;

        std::vector<texture> tile_values;
        std::vector<texture> shadow_tile_values;
        std::vector<texture> night_tile_values;
        std::vector<texture> overexposed_tile_values;
        std::vector<texture> memory_tile_values;
        std::vector<texture> silhouette_tile_values;

        // Lazily-baked HSV-tinted variants of base sprites, keyed by
        // (sprite_index << 32 | packed RGBA). Filled on demand by
        // get_tinted_tile (a const memoizing accessor, hence mutable) and cleared
        // whenever base textures are (re)uploaded.
        mutable std::unordered_map<uint64_t, texture> tinted_tile_values;

        // Descriptors recorded during JSON parsing; replayed by upload_atlases.
        std::vector<atlas_replay_descriptor> atlas_descriptors;
        // Sprite index of the synthetic highlight overlay, or nullopt when
        // the tileset defines its own ITEM_HIGHLIGHT.
        std::optional<int> default_item_highlight_index;

        // Renderer-instance and device-texture epochs the textures were
        // uploaded against. A bundle whose epochs differ from the live ones
        // is stale and must be reuploaded before use.
        uint64_t renderer_instance_generation_at_upload = 0;
        uint64_t gpu_textures_generation_at_upload = 0;
        // Memory-map mode the atlases were uploaded with, retained so a
        // device-reset replay regenerates the memory tiles identically.
        std::string memory_map_mode_at_upload;

        std::unordered_set<std::string> duplicate_ids;

        std::unordered_map<std::string, tile_type> tile_ids;
        // caches both "default" and "_season_XXX" tile variants (to reduce the number of lookups)
        // either variant can be either a `nullptr` or a pointer/reference to the real value (stored inside `tile_ids`)
        std::array<std::unordered_map<std::string, season_tile_value>, season_type::NUM_SEASONS>
        tile_ids_by_season;

        static const texture *get_if_available( const size_t index,
                                                const decltype( shadow_tile_values ) &tiles ) {
            return index < tiles.size() ? & tiles[index] : nullptr;
        }

        friend class tileset_cache;
        friend struct renderer_recovery_test_support;

    public:

        std::unordered_map<std::string, std::vector<layer_context_sprites>> item_layer_data;
        std::unordered_map<std::string, std::vector<layer_context_sprites>> field_layer_data;

        void clear();

        bool is_isometric() const {
            return tile_isometric;
        }
        int get_tile_width() const {
            return tile_width;
        }
        int get_tile_height() const {
            return tile_height;
        }
        const half_open_rectangle<point> &get_max_tile_extent() const {
            return max_tile_extent;
        }
        int get_zlevel_height() const {
            return zlevel_height;
        }
        float get_tile_pixelscale() const {
            return tile_pixelscale;
        }
        float get_prevent_occlusion_min_dist() const {
            return prevent_occlusion_min_dist;
        }
        float get_prevent_occlusion_max_dist() const {
            return prevent_occlusion_max_dist;
        }
        const std::string &get_tileset_id() const {
            return tileset_id;
        }

        const texture *get_tile( const size_t index ) const {
            return get_if_available( index, tile_values );
        }
        const texture *get_night_tile( const size_t index ) const {
            return get_if_available( index, night_tile_values );
        }
        const texture *get_shadow_tile( const size_t index ) const {
            return get_if_available( index, shadow_tile_values );
        }
        const texture *get_overexposed_tile( const size_t index ) const {
            return get_if_available( index, overexposed_tile_values );
        }
        const texture *get_memory_tile( const size_t index ) const {
            return get_if_available( index, memory_tile_values );
        }
        const texture *get_silhouette_tile( const size_t index ) const {
            return get_if_available( index, silhouette_tile_values );
        }
        /**
         * Returns an HSV-tinted variant of sprite \p index recolored toward
         * \p color, baking and caching it on first use. \p source is the already
         * looked-up base/lit texture to recolor (so the tint stacks on the right
         * light variant); falls back to the plain base tile when null.
         * Returns nullptr if the sprite can't be tinted.
         */
        const texture *get_tinted_tile( const SDL_Renderer_Ptr &renderer, size_t index,
                                        const RGBColor &color, const texture *source ) const;
        void clear_tinted_tiles() {
            tinted_tile_values.clear();
        }

        const std::unordered_set<std::string> &get_duplicate_ids() const {
            return duplicate_ids;
        }

        const std::vector<atlas_replay_descriptor> &get_atlas_descriptors() const {
            return atlas_descriptors;
        }
        void append_atlas_descriptor( atlas_replay_descriptor desc ) {
            atlas_descriptors.push_back( std::move( desc ) );
        }
        std::optional<int> get_default_item_highlight_index() const {
            return default_item_highlight_index;
        }
        void set_default_item_highlight_index( std::optional<int> idx ) {
            default_item_highlight_index = idx;
        }
        uint64_t get_renderer_instance_generation_at_upload() const {
            return renderer_instance_generation_at_upload;
        }
        uint64_t get_gpu_textures_generation_at_upload() const {
            return gpu_textures_generation_at_upload;
        }
        void set_upload_generations( uint64_t renderer_instance_gen, uint64_t gpu_textures_gen ) {
            renderer_instance_generation_at_upload = renderer_instance_gen;
            gpu_textures_generation_at_upload = gpu_textures_gen;
        }
        const std::string &get_memory_map_mode_at_upload() const {
            return memory_map_mode_at_upload;
        }
        void set_memory_map_mode_at_upload( const std::string &mode ) {
            memory_map_mode_at_upload = mode;
        }
        // Drop the per-variant atlas textures. Safe to call repeatedly; the
        // descriptors and metadata are retained for a later replay.
        void release_gpu_atlases() {
            tile_values.clear();
            shadow_tile_values.clear();
            night_tile_values.clear();
            overexposed_tile_values.clear();
            memory_tile_values.clear();
            silhouette_tile_values.clear();
            // The tinted-tile cache keys on the raw base-texture pointers we just
            // freed (see cata_tiles_color.cpp::get_tinted_tile). Leaving it populated
            // would let a replay-reallocated texture collide with a stale key and
            // return a dangling/wrong tinted sprite, so drop it alongside the atlases.
            tinted_tile_values.clear();
        }

        tile_type &create_tile_type( const std::string &id, tile_type &&new_tile_type );
        const tile_type *find_tile_type( const std::string &id ) const;

        /**
         * Looks up tile by id + season suffix AND just raw id
         * Example: if id == "t_tree_apple" and season == SPRING
         *    will first look up "t_tree_apple_season_spring"
         *    if not found, will look up "t_tree_apple"
         *    if still nothing is found, will return std::nullopt
         * @param id : "raw" tile id (without season suffix)
         * @param season : season suffix encoded as season_type enum
         * @return std::nullopt if no tile is found,
         *    std::optional with found id (e.g. "t_tree_apple_season_spring" or "t_tree_apple) and found tile.
         *
         * Note: this method is guaranteed to return pointers to the keys and values stored inside the
         * `tileset::tile_ids` collection. I.e. result of this method call is invalidated when
         *  the corresponding `tileset` is invalidated.
         */
        std::optional<tile_lookup_res> find_tile_type_by_season( const std::string &id,
                season_type season ) const;
};

// Hashes the options baked into tileset textures so changing any of them
// invalidates the cache key and forces a reupload. Always folds in
// SCALING_MODE; adds MEMORY_RGB_{DARK,BRIGHT}_{R,G,B} and MEMORY_GAMMA under
// the "color_pixel_custom" memory map mode.
uint64_t compute_tileset_filter_fingerprint( const std::string &memory_map_mode );

struct tileset_cache_key {
    std::string tileset_id;
    std::string memory_preset;
    uint64_t filter_fingerprint = 0;

    bool operator==( const tileset_cache_key &other ) const {
        return tileset_id == other.tileset_id
               && memory_preset == other.memory_preset
               && filter_fingerprint == other.filter_fingerprint;
    }
};

struct tileset_cache_key_hash {
    std::size_t operator()( const tileset_cache_key &key ) const noexcept {
        const std::size_t h1 = std::hash<std::string> {}( key.tileset_id );
        const std::size_t h2 = std::hash<std::string> {}( key.memory_preset );
        const std::size_t h3 = std::hash<uint64_t> {}( key.filter_fingerprint );
        std::size_t h = h1;
        h ^= h2 + 0x9e3779b97f4a7c15ULL + ( h << 6 ) + ( h >> 2 );
        h ^= h3 + 0x9e3779b97f4a7c15ULL + ( h << 6 ) + ( h >> 2 );
        return h;
    }
};

class tileset_cache
{
    public:
        // Look up or load a tileset bundle. current_renderer_instance_gen and
        // current_gpu_textures_gen are compared against the bundle's recorded
        // generations; a mismatch on either treats the cached entry as stale
        // and reloads. A fresh upload builds an isolated candidate, published only
        // on full success; on interrupt the candidate moves into *quarantine, the
        // live entry stays, and *out_interrupt reports the reason with a null return.
        std::shared_ptr<const tileset> load_tileset( const std::string &tileset_id,
                const SDL_Renderer_Ptr &renderer, bool precheck,
                bool force, bool pump_events, bool terrain,
                const std::string &memory_map_mode,
                uint64_t current_renderer_instance_gen,
                uint64_t current_gpu_textures_gen,
                const atlas_upload_poll &poll = {},
                atlas_replay_quarantine *quarantine = nullptr,
                atlas_upload_interrupt *out_interrupt = nullptr );

        // Drop the atlas textures on every live cached tileset. Called before
        // renderer destruction so the handles are freed against the live
        // renderer. Expired entries are pruned. Idempotent.
        void release_live_atlases();

        // Re-upload atlases over every live cached tileset against `renderer`
        // and the given generations, replaying each bundle's descriptors and
        // memory-map mode. poll is consulted between entries and chunks; on
        // interrupt the upload stops, candidates quarantine, and the reason returns.
        atlas_upload_interrupt replay_live_atlases( const SDL_Renderer_Ptr &renderer,
                uint64_t renderer_instance_gen, uint64_t gpu_textures_gen,
                const atlas_upload_poll &poll, atlas_replay_quarantine &quarantine );
    private:
        class loader;
        friend struct renderer_recovery_test_support;

        // Return the cached bundle at key when it is present and its recorded
        // generations match the current ones; null on a miss or a stale entry.
        // The single freshness predicate behind the fetch path's cache hit.
        std::shared_ptr<tileset> find_fresh_cached( const tileset_cache_key &key,
                uint64_t current_renderer_instance_gen, uint64_t current_gpu_textures_gen ) const;

        std::unordered_map<tileset_cache_key, std::weak_ptr<tileset>, tileset_cache_key_hash>
        tilesets_;
};


enum class text_alignment : int {
    left,
    center,
    right,
};

struct formatted_text {
    std::string text;
    int color;
    text_alignment alignment;

    formatted_text( const std::string &text, const int color, const text_alignment alignment )
        : text( text ), color( color ), alignment( alignment ) {
    }

    formatted_text( const std::string &text, int color, direction text_direction );
};

/** type used for color blocks overlays.
 * first: The SDL blend mode used for the color.
 * second:
 *     - A point where to draw the color block (x, y)
 *     - The color of the block at 'point'.
 */
using color_block_overlay_container = std::pair<SDL_BlendMode, std::multimap<point, SDL_Color>>;

class cata_tiles
{
        friend class cata_tiles_test_helper;

    public:
        cata_tiles( const SDL_Renderer_Ptr &render, const GeometryRenderer_Ptr &geometry,
                    tileset_cache &cache );
        ~cata_tiles();

        /** Reload tileset, with the given scale. Scale is divided by 16 to allow for scales < 1 without risking
         *  float inaccuracies. */
        void set_draw_scale( int scale );

        void on_options_changed();

        // checks if the tileset_ptr is valid
        bool is_valid() {
            return tileset_ptr != nullptr;
        }

        /** Draw to screen */
        void draw( const point &dest, const tripoint_bub_ms &center, int width, int height,
                   std::multimap<point, formatted_text> &overlay_strings,
                   color_block_overlay_container &color_blocks );
        void draw_om( const point &dest, const tripoint_abs_omt &center_abs_omt, bool blink );

        /** Minimap functionality */
        void draw_minimap( const point &dest, const tripoint_bub_ms &center, int width, int height );

        /**
         * Resolve a candidate tile id (following looks_like fallbacks) and return
         * the id of an existing sprite, or an empty string if none is found.
         * Public wrapper around find_tile_looks_like for callers outside the
         * renderer (e.g. per-ammo bullet sprite lookup in ballistics).
         */
        std::string find_bullet_sprite_id( const std::string &id, TILE_CATEGORY category );

    protected:
        /** How many rows and columns of tiles fit into given dimensions, fully
         ** or partially shown, but disregarding any extra contents outside the
         ** basic x range of [0, tile_width) and the basic y range of
         ** [0, tile_width / 2) (isometric) or [0, tile_height) (non-isometric) **/
        point get_window_base_tile_counts( const point &size ) const;
        static point get_window_base_tile_counts(
            const point &size, const point &tile_size, bool iso );
        /** Coordinate range of tiles at the given relative z-level that fit
         ** into the given dimensions, fully or partially shown, according to
         ** the maximum tile extent. May be negative, and 0 corresponds to the
         ** first fully or partially shown base tile at relative z of 0 as
         ** defined by `get_window_base_tile_counts`. **/
        half_open_rectangle<point> get_window_any_tile_range( const point &size, int z ) const;
        /** Coordinate range of fully shown tiles that fit into the given
         ** dimensions, disregarding any extra contents outside the basic x
         ** range of [0, tile_width] and the basic y range of [0, tile_width / 2)
         ** (isometric) or [0, tile_height) (non-isometric) **/
        half_open_rectangle<point> get_window_full_base_tile_range( const point &size ) const;

        std::optional<tile_lookup_res> find_tile_with_season( const std::string &id ) const;

        std::optional<tile_lookup_res>
        find_tile_looks_like( const std::string &id, TILE_CATEGORY category, const std::string &variant,
                              int looks_like_jumps_limit = 10 ) const;

        // this templated method is used only from it's own cpp file, so it's ok to declare it here
        template<typename T>
        std::optional<tile_lookup_res>
        find_tile_looks_like_by_string_id( std::string_view id, TILE_CATEGORY category,
                                           int looks_like_jumps_limit ) const;

        bool find_overlay_looks_like( bool male, const std::string &overlay, const std::string &variant,
                                      std::string &draw_id );

    private:
        bool draw_from_id_string_internal( const std::string &id, const tripoint_bub_ms &pos, int subtile,
                                           int rota,
                                           lit_level ll, int retract, bool apply_night_vision_goggles, int &height_3d );
        bool draw_from_id_string_internal( const std::string &id, TILE_CATEGORY category,
                                           const std::string &subcategory, const tripoint_bub_ms &pos, int subtile, int rota,
                                           lit_level ll, int retract, bool apply_night_vision_goggles, int &height_3d, int intensity_level,
                                           const std::string &variant, const point &offset );
    protected:
        bool draw_from_id_string( const std::string &id, const tripoint_bub_ms &pos, int subtile, int rota,
                                  lit_level ll,
                                  bool apply_night_vision_goggles );
        bool draw_from_id_string( const std::string &id, const tripoint_abs_omt &pos, int subtile, int rota,
                                  lit_level ll,
                                  bool apply_night_vision_goggles ) {
            // A number of operations follow this pattern, i.e. tripoint_abs_omt coordinates are cast to tripoint_bub_ms and the call
            // is forwarded to the "normal" operation. This relies on the underlying logic being the same regardless of the coordinate
            // system and scale.
            return draw_from_id_string( id, tripoint_bub_ms( pos.raw() ), subtile, rota, ll,
                                        apply_night_vision_goggles );
        }
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_bub_ms &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles );
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_abs_omt &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles ) {
            return draw_from_id_string( id, category, subcategory, tripoint_bub_ms( pos.raw() ), subtile, rota,
                                        ll, apply_night_vision_goggles );
        }
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_bub_ms &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles, int &height_3d );
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_abs_omt &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles, int &height_3d ) {
            return draw_from_id_string( id, category, subcategory, tripoint_bub_ms( pos.raw() ), subtile, rota,
                                        ll, apply_night_vision_goggles, height_3d );
        };
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_bub_ms &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles, int &height_3d, int intensity_level );
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_bub_ms &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles, int &height_3d, int intensity_level,
                                  const std::string &variant );
        bool draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                  const std::string &subcategory, const tripoint_bub_ms &pos, int subtile, int rota,
                                  lit_level ll, bool apply_night_vision_goggles, int &height_3d, int intensity_level,
                                  const std::string &variant, const point &offset );
        bool draw_sprite_at(
            const tile_type &tile, const weighted_int_list<std::vector<int>> &svlist,
            const point &, unsigned int loc_rand, bool rota_fg, int rota,
            const tile_render_params &rp, int retract, int &height_3d, const point &offset,
            bool allow_diagonal_rota = false );
        bool draw_tile_at( const tile_type &tile, const point &, unsigned int loc_rand, int rota,
                           const tile_render_params &rp, int retract, int &height_3d,
                           const point &offset, bool allow_diagonal_rota = false );

        /* Tile Picking */

        /** Map memory */
        const memorized_tile &get_terrain_memory_at( const tripoint_abs_ms &p ) const;
        const memorized_tile &get_furniture_memory_at( const tripoint_abs_ms &p ) const;
        const memorized_tile &get_trap_memory_at( const tripoint_abs_ms &p ) const;
        const memorized_tile &get_vpart_memory_at( const tripoint_abs_ms &p ) const;

        /** Drawing Layers */
        bool would_apply_vision_effects( visibility_type visibility ) const;
        bool apply_vision_effects( const tripoint_bub_ms &pos, visibility_type visibility, int &height_3d );
        void draw_square_below( const point_bub_ms &p, const nc_color &col, int sizefactor );
        bool draw_terrain( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                           const std::array<bool, 5> &invisible );
        bool draw_furniture( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                             const std::array<bool, 5> &invisible );
        bool draw_graffiti( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                            const std::array<bool, 5> &invisible );
        bool draw_trap( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                        const std::array<bool, 5> &invisible );
        bool draw_part_con( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                            const std::array<bool, 5> &invisible );
        bool draw_field_or_item( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                 const std::array<bool, 5> &invisible );
        bool draw_vpart( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                         const std::array<bool, 5> &invisible, bool roof );
        bool draw_vpart_no_roof( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                 const std::array<bool, 5> &invisible );
        bool draw_vpart_roof( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                              const std::array<bool, 5> &invisible );
        // Paint color to tint the vehicle part displayed at \p mount of \p veh,
        // or nullopt when it is unpainted or the VEHICLE_PART_COLOR option is off.
        std::optional<RGBColor> get_vpart_tint( const vehicle &veh,
                                                const point_rel_ms &mount ) const;
        bool draw_critter_at( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                              const std::array<bool, 5> &invisible );
        bool draw_critter_above( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                 const std::array<bool, 5> &invisible );

        // Pixel offset to add to the sprite currently being drawn so a creature
        // appears to glide from its old tile to its new one. Set by
        // draw_critter_at (guarded so it is restored to zero afterwards) and read
        // by player_to_screen; zero for terrain/everything else.
        point m_entity_draw_offset;
        bool draw_zone_mark( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                             const std::array<bool, 5> &invisible );
        bool draw_zombie_revival_indicators( const tripoint_bub_ms &pos, lit_level ll, int &height_3d,
                                             const std::array<bool, 5> &invisible );
        void draw_zlevel_overlay( const tripoint_bub_ms &p, lit_level ll, int &height_3d );
        void draw_entity_with_overlays( const Character &ch, const tripoint_bub_ms &p, lit_level ll,
                                        int &height_3d, FacingDirection facing_override = FacingDirection::NONE );
        void draw_entity_with_overlays( const Character &ch, const tripoint_abs_omt &p, lit_level ll,
                                        int &height_3d ) {
            draw_entity_with_overlays( ch, tripoint_bub_ms( p.raw() ), ll, height_3d );
        }

        void draw_entity_with_overlays( const monster &mon, const tripoint_bub_ms &p, lit_level ll,
                                        int &height_3d );

        bool draw_item_highlight( const tripoint_bub_ms &pos, int &height_3d );

    public:
        /**
         * Draw a vehicle's layout into @p w_disp using graphical tiles, centered on the
         * structural part under @p cursor_vp_mount. Used by veh_interact as a graphical
         * alternative to the ASCII display_veh(). @p cpart is set to the structural part
         * index under the cursor (matching the ASCII path's contract).
         * Returns false without drawing for isometric tilesets, so the caller can fall
         * back to the ASCII display.
         */
        bool draw_vehicle_preview( const catacurses::window &w_disp, const vehicle &veh,
                                   const point_rel_ms &cursor_vp_mount, int &cpart );

        /**
         * Render @p ch (base sprite plus mutation/worn/wielded overlays) into an
         * internally-owned, offscreen render target, scaled to @p scale (16 == native
         * tile size). The canvas is sized to fit the scaled sprite exactly, with one
         * extra tile of headroom above for overlays that draw upward (hair, hats); the
         * used pixel size is returned in @p out_w / @p out_h so the caller can size its
         * ImGui::Image to match. The character is centred horizontally and bottom-aligned.
         * Returns nullptr for isometric tilesets or on render-target failure; the returned
         * texture is owned by cata_tiles and stays valid until the next call.
         */
        SDL_Texture *render_character_preview( const Character &ch, int scale, int &out_w,
                                               int &out_h );

        // Animation layers
        void init_explosion( const tripoint_bub_ms &p, int radius );
        void draw_explosion_frame();
        void void_explosion();

        void init_custom_explosion_layer( const std::map<tripoint_bub_ms, explosion_tile> &layer );
        void draw_custom_explosion_frame();
        void void_custom_explosion();

        // Modern explosion light overlay (phase one): a blended colour cover per
        // tile, driven by a 0..1 progress sweep, replacing the legacy sprites.
        // Registers (appends) a new asynchronous blast that advances itself each
        // frame; several may overlap. \p radius_tiles is the blast's max extent in
        // tiles (used to size the shockwave ring). \p per_ms / \p end_progress
        // drive the real-time sweep.  Returns a handle so the caller can cancel
        // the blast mid-flight via cancel_effect().
        effect_handle init_explosion_light( const std::map<tripoint_bub_ms, float> &intensity,
                                            const explosion_light_str_id &effect,
                                            const tripoint_bub_ms &center, float radius_tiles,
                                            float per_ms, float end_progress,
                                            bool circular_shockwave = true,
                                            shockwave_state::sw_shape shock_shape =
                                                shockwave_state::sw_shape::disc,
                                            const tripoint_bub_ms &shock_target = tripoint_bub_ms(),
                                            float shock_half_angle = 0.0f );
        // Advance all active explosion lights by real elapsed time and drop the
        // finished ones. Called once at the start of each draw().
        void advance_explosion_lights();
        // True while any explosion light overlay is playing. Used by the input loop
        // to raise its redraw rate so the blast plays smoothly while idle.
        bool has_explosion_light_anim() const {
            return !m_explosion_lights.empty();
        }
        void draw_explosion_light_frame( int view_z );
        void void_explosion_light();

        // --- Asynchronous bullet animation (ANIMATION_PROJECTILES_ASYNC) -----
        // Mirrors the explosion-light async model: a shot registers its visible
        // flight path here and returns immediately, so the game keeps running and
        // many units firing in one turn don't each block the main thread. The
        // animation advances by real elapsed time every frame.
        //   as_line  true  -> the whole path shows at once for a short life (the
        //                     BULLETS_AS_LASERS gun-line look).
        //            false -> a single bullet sprite sweeps tile-to-tile along the
        //                     path (the classic moving-dot look).
        // per_ms drives the sweep (dot) or the life countdown (line).
        // Returns a handle so the caller can cancel the tracer mid-flight.
        effect_handle init_bullet_anim( const std::vector<tripoint_bub_ms> &points,
                                        const std::vector<std::string> &sprites,
                                        const std::vector<int> &rotations,
                                        bool as_line, float per_ms );
        // Advance all active bullet animations by real elapsed time, dropping the
        // finished ones. Called once at the start of each draw().
        void advance_bullet_anims();
        // True while any async bullet animation is playing (raises idle redraw rate).
        bool has_bullet_anim() const {
            return !m_bullet_anims.empty();
        }
        void draw_bullet_anim_frame( int view_z );
        // Drop all in-flight bullet animations (used on tileset reload / renderer
        // recovery, like void_explosion_light), so stale tiles computed against old
        // metrics don't paint onto the rebuilt scene.
        void void_bullet_anim();

        // --- Asynchronous SCT (Scrolling Combat Text) ---
        // Fire-and-forget floating combat-text labels that rise and fade over real
        // time.  Follows the same async model as explosion lights and bullet anims:
        // the caller registers a label and returns immediately; the label advances
        // every draw frame and is cleaned up when its duration expires.  Lives
        // alongside the legacy overlay_strings SCT path (init_draw_sct / void_sct).
        // Returns a handle so the caller can cancel the label mid-flight.
        effect_handle init_sct( const tripoint_bub_ms &pos, const std::string &text, nc_color color,
                                float duration_ms = 800.0f );
        void advance_sct();
        bool has_sct() const { return !m_sct_effects.empty(); }
        void draw_sct_frame( int view_z,
                             std::multimap<point, formatted_text> &overlay_strings );

        // --- Unified transient-effect advance ---
        // Advances all transient effects (explosion lights, bullet tracers,
        // creature move glides, SCT labels, highlights, screen shake) by real
        // elapsed time.  Called once at the start of draw() in place of the
        // individual advance_* calls.
        void advance_all_transient_effects();

        // Advance the sound-driven screen shake by real elapsed time. Called once at
        // the start of each draw(), alongside the other wall-clock animations.
        void advance_screen_shake_frame();
        // Capped elapsed-ms helper shared by the wall-clock present effects above:
        // returns the steady-clock ms since the tick stored in \p last_ms (which it
        // updates), clamped to one frame's worth, or 0 on the priming call.
        static int64_t capped_frame_dt_ms( std::optional<int64_t> &last_ms );

        void init_draw_bullet( const tripoint_bub_ms &p, std::string name, int rotation = 0 );
        void init_draw_bullets( const std::vector<tripoint_bub_ms> &ps,
                                const std::vector<std::string> &names, const std::vector<int> &rotations );
        void draw_bullet_frame();
        void void_bullet();

        // \p damage_fraction scales the reaction; \p dir_tiles is the knockback
        // direction (victim - attacker, in tiles; zero if unknown). \p dead skips
        // the reaction so a freshly-killed creature's bounce can't linger and get
        // mistakenly triggered when something else later steps onto the tile.
        void init_draw_hit( const Creature &critter, float damage_fraction = 1.0f,
                            const point &dir_tiles = point::zero, bool dead = false );
        void draw_hit_frame();
        void void_hit();
        // Prune expired hit animations.  Returns true if any were removed.
        bool expire_hit_animations();

        // --- Creature move animation (opt-in CREATURE_MOVE_ANIM) ---
        // Interpolation curve for the per-tile glide.
        enum class move_anim_curve : int {
            smooth = 0,   // ease-in-out horizontal glide
            parabola,     // smooth horizontal + symmetric half-tile vertical hop
            leap,         // backward bob + long hang over origin, then short quick fall
        };
        // Register (or restart) a glide for a creature that just moved from
        // \p from_abs to \p to_abs. New animations overwrite any existing one for
        // the same creature and play from the start, so they never block the game.
        // No-op when the option is off, on z-changes, or on jumps further than one
        // tile (teleports snap instantly). \p is_player gates the avatar's glide on
        // the separate PLAYER_MOVE_ANIM option.  Returns a handle so the caller
        // can cancel the glide mid-flight via cancel_effect().
        effect_handle start_creature_move_anim( const tripoint_abs_ms &from_abs,
                                                const tripoint_abs_ms &to_abs, bool is_player );
        // Advance all active glides by real elapsed time and drop finished ones.
        void advance_creature_move_anims();
        // True while any creature move glide is in flight. Used by the input loop
        // to raise its redraw rate so the glide looks smooth instead of stepping.
        bool has_creature_move_anim() const {
            return !m_creature_anims.empty();
        }
        // Register (or restart) a "got hit" reaction for the creature now standing
        // at \p pos_abs. No-op when the CREATURE_HIT_ANIM option is off. Shares the
        // redraw framerate and deferred-overlay path with the move glide.
        // \p damage_fraction is the hit's damage as a fraction of the creature's max
        // HP (0..1); it scales the reaction magnitude between a small floor and a
        // half-tile maximum. \p dir_tiles is the knockback direction (attacker ->
        // victim, in tiles); when zero, or when the curve option is "bounce", a
        // vertical pop-and-fall is used instead of a horizontal knockback.
        // \p is_player gates the avatar's reaction on the separate PLAYER_HIT_ANIM option.
        // Returns a handle so the caller can cancel via cancel_effect().
        effect_handle start_creature_hit_anim( const tripoint_abs_ms &pos_abs, float damage_fraction,
                                               const point &dir_tiles, bool is_player );
        // True while any hit reaction is in flight.
        bool has_creature_hit_anim() const {
            return !m_creature_hit_anims.empty();
        }
        // Register (or restart) an attack lunge for the attacker at \p pos_abs that
        // just struck a target in direction \p dir_tiles (attacker -> target, in
        // tiles): a quick lunge toward the target and back. No-op when the
        // CREATURE_ATTACK_ANIM option is off. \p is_player gates the avatar's lunge
        // on the separate PLAYER_ATTACK_ANIM option.  Returns a handle so the
        // caller can cancel the lunge mid-flight via cancel_effect().
        effect_handle start_creature_attack_anim( const tripoint_abs_ms &pos_abs,
                                                  const point &dir_tiles, bool is_player );
        // True while any attack lunge is in flight.
        bool has_creature_attack_anim() const {
            return !m_creature_attack_anims.empty();
        }
        // True while any creature or overlay animation (glide, hit, attack,
        // SCT label, or highlight) is in flight.  Used by the input loop to
        // raise its redraw rate so animations look smooth instead of stepping.
        // (Explosion lights and bullet tracers have their own independent
        // has_* gates that are checked separately in the in_animation gate.)
        bool has_creature_anim() const {
            return has_creature_move_anim() || has_creature_hit_anim() ||
                   has_creature_attack_anim() || has_sct() || has_highlight();
        }

        void draw_footsteps_frame( const tripoint_bub_ms &center );

        // pseudo-animated layer, not really though.
        void init_draw_line( const tripoint_bub_ms &p, std::vector<tripoint_bub_ms> trajectory,
                             std::string line_end_name, bool target_line );
        void draw_line();
        void void_line();

        void init_draw_cursor( const tripoint_bub_ms &p );
        void draw_cursor();
        void void_cursor();

        void init_draw_highlight( const tripoint_bub_ms &p );
        void draw_highlight();
        void void_highlight();

        // --- Asynchronous highlight overlay ---
        // Fire-and-forget highlight that fades over real time, following the
        // same async model as explosion lights.  Lives alongside the legacy
        // synchronous path (init_draw_highlight / void_highlight).
        effect_handle add_highlight( const tripoint_bub_ms &pos,
                                     float duration_ms = 500.0f );
        void advance_highlights();
        bool has_highlight() const { return !m_highlights.empty(); }
        void draw_highlights( int view_z );

        // --- Handle system ---
        // Allocate a new handle for a freshly-created effect, registering
        // its category in the handle index so cancel_effect() can later
        // dispatch to the correct container.
        effect_handle alloc_handle( effect_kind kind );
        // Cancel an effect by its handle.  No-op if unknown.  Walks the
        // matching container and erases the entry whose handle matches.
        void cancel_effect( effect_handle h );
        // True if at least one tile in `tiles` is inside the loaded map grid
        // (the reality bubble).  Used by advance_* to drop effects that have
        // left the player's vicinity.
        bool any_tile_in_bubble( const std::vector<tripoint_bub_ms> &tiles ) const;

        void init_draw_weather( weather_printable weather, std::string name );
        void draw_weather_frame();
        void void_weather();

        void init_draw_sct();
        void draw_sct_frame( std::multimap<point, formatted_text> &overlay_strings );
        void void_sct();

        void init_draw_zones( const tripoint_bub_ms &start, const tripoint_bub_ms &end,
                              const tripoint_rel_ms &offset );
        void draw_zones_frame();
        void void_zones();

        void init_draw_async_anim( const tripoint_bub_ms &p, const std::string &tile_id );
        void draw_async_anim();
        bool void_async_anim();

        void init_draw_radiation_override( const tripoint_bub_ms &p, int rad );
        void void_radiation_override();

        void init_draw_terrain_override( const tripoint_bub_ms &p, const ter_id &id );
        void void_terrain_override();

        void init_draw_furniture_override( const tripoint_bub_ms &p, const furn_id &id );
        void void_furniture_override();

        void init_draw_graffiti_override( const tripoint_bub_ms &p, bool has );
        void void_graffiti_override();

        void init_draw_trap_override( const tripoint_bub_ms &p, const trap_id &id );
        void void_trap_override();

        void init_draw_field_override( const tripoint_bub_ms &p, const field_type_id &id );
        void void_field_override();

        void init_draw_item_override( const tripoint_bub_ms &p, const itype_id &id, const mtype_id &mid,
                                      bool hilite );
        void void_item_override();

        void init_draw_vpart_override( const tripoint_bub_ms &p, const vpart_id &id, int part_mod,
                                       const units::angle &veh_dir, bool hilite, const point_rel_ms &mount );
        void void_vpart_override();

        void init_draw_monster_override( const tripoint_bub_ms &p, const mtype_id &id, int count,
                                         bool more, Creature::Attitude att );
        void void_monster_override();

        bool has_draw_override( const tripoint_bub_ms &p ) const;

        void set_disable_occlusion( bool val );

        /**
         * Initialize the current tileset (load tile images, load mapping), using the current
         * tileset as it is set in the options.
         * @param tileset_id Ident of the tileset, as it appears in the options.
         * @param precheck If true, only loads the meta data of the tileset (tile dimensions).
         * @param force If true, forces loading the tileset even if it is already loaded.
         * @param pump_events Handle window events and refresh the screen when necessary.
         *        Please ensure that the tileset is not accessed when this method is
         *        executing if you set it to true.
         * @param terrain If true, this will be an overmap/terrain tileset
         * @throw std::exception On any error.
         */
        void load_tileset( const std::string &tileset_id, bool precheck = false,
                           bool force = false, bool pump_events = false, bool terrain = false );
        /**
         * Reinitializes the current tileset, like @ref init, but using the original screen information.
         * @throw std::exception On any error.
         */
        void reinit();

        bool is_isometric() const {
            return tileset_ptr->is_isometric();
        }
        int get_tile_height() const {
            return tile_height;
        }
        int get_tile_width() const {
            return tile_width;
        }
        half_open_rectangle<point> get_max_tile_extent() const {
            return max_tile_extent;
        }
        void do_tile_loading_report();
        std::optional<point> tile_to_player( const point &colrow ) const;
        static std::optional<point_bub_ms> tile_to_player(
            const point &colrow, const point_bub_ms &o,
            const point &base_tile_cnt, bool iso );
        point player_to_tile( const point_bub_ms &pos ) const;
        point player_to_screen( const point_bub_ms &pos ) const;
        point player_to_screen( const point_abs_omt &pos ) const {
            // This weird type casting relies on the underlying logic being the same regardless of the coordinate system and scale.
            return player_to_screen( point_bub_ms( pos.raw() ) );
        }
        static point_bub_ms screen_to_player(
            const point &scr_pos, const point &tile_size,
            const point &win_size, const point_bub_ms &center,
            bool iso );
        static std::vector<options_manager::id_and_option> build_renderer_list();
        static std::vector<options_manager::id_and_option> build_display_list();
    private:
        std::pair<std::string, bool> get_omt_id_rotation_and_subtile( const tripoint_abs_omt &omp,
                int &rota, int &subtile );
    protected:
        template <typename maptype>
        void tile_loading_report_map( const maptype &tiletypemap, TILE_CATEGORY category,
                                      const std::string &prefix = "" );
        template <typename Sequence>
        void tile_loading_report_seq_types( const Sequence &tiletypes, TILE_CATEGORY category,
                                            const std::string &prefix = "" );
        template <typename Sequence>
        void tile_loading_report_seq_ids( const Sequence &tiletypes, TILE_CATEGORY category,
                                          const std::string &prefix = "" );
        template <typename basetype>
        void tile_loading_report_count( size_t count, TILE_CATEGORY category,
                                        const std::string &prefix = "" );
        /**
         * Generic tile_loading_report, begin and end are iterators, id_func translates the iterator
         * to an id string (result of id_func must be convertible to string).
         */
        template<typename Iter, typename Func>
        void lr_generic( Iter begin, Iter end, Func id_func, TILE_CATEGORY category,
                         const std::string &prefix );

        void tile_loading_report_dups();

        /** Lighting */
        void init_light();

        /** Variables */
        const SDL_Renderer_Ptr &renderer;
        const GeometryRenderer_Ptr &geometry;
        tileset_cache &cache;

#if SDL_MAJOR_VERSION >= 3
        // Variant pass is process-lifetime, owned alongside the renderer.
        // Consumers reach it via get_shared_variant_pass in sdltiles.h.
#endif
        std::shared_ptr<const tileset> tileset_ptr;

        // the scaled default sprite width and height. in non-isometric mode,
        // the basic tile width and height equal the default sprite width and
        // height, but in isometric mode, the basic tile height is always
        // `tile_width / 2`, and `tile_height` is only the default sprite height.
        int tile_height = 0;
        int tile_width = 0;
        // The scaled maximum extent of loaded sprites.
        half_open_rectangle<point> max_tile_extent;
        int zlevel_height = 0;
        // The number of visible tiles in a row or column
        // (see get_window_base_tile_counts for detail).
        int screentile_width = 0;
        int screentile_height = 0;

        int fog_alpha = 0;

        // During the layer loop, these point to the current tile's tint tracking
        // state. draw_sprite_at uses them to accumulate screen bounds and record
        // sprites for later silhouette replay. Only set for ortho tiles that need
        // tinting; null for iso tiles, UI overlays, and non-tinted tiles.
        sprite_screen_bounds *m_cur_bounds = nullptr;
        small_literal_vector<tint_sprite_record, 4> *m_cur_tint_sprites = nullptr;

        // The cached draw point for the current tile, set by the layer loop
        // before each draw_* call, mirroring the m_cur_bounds pattern (pass
        // per-tile state to a layer function without changing the shared
        // layer-fn signature). The static-layer draw functions read the
        // terrain/furniture/trap/partial-construction/graffiti content captured
        // on its sprite variant in their normal visible branch instead of
        // reading the map live. A pointer to the outer tile_render_info (not the
        // nested sprite) so the type stays forward-declarable here — cata_tiles.h
        // must not include map.h (map.h includes this header). Null outside the
        // sprite branch of the layer loop.
        const tile_render_info *m_cur_tile = nullptr;

        // Set by draw_vpart around its draw_from_id_string call so the vehicle
        // part sprite gets recolored with the part's paint color; nullopt
        // otherwise. Consumed when building tile_render_params.
        std::optional<RGBColor> pending_part_tint_ = std::nullopt;

        // Per-draw caches rebuilt once per draw() from g->all_creatures(). Let the
        // critter layers skip the per-tile creature_at hash lookup for the ~all
        // tiles that hold no creature:
        //   m_creature_positions - exact tiles, for draw_critter_at's early-out.
        //   m_creature_columns   - (x,y) columns containing any creature, for
        //     draw_critter_above: a creature only casts a downward shadow within
        //     its own column, so columns with no creature skip the upward z-scan.
        std::unordered_set<tripoint_bub_ms> m_creature_positions;
        std::unordered_set<point_bub_ms> m_creature_columns;

        // Active per-creature move glides, keyed by the creature's *destination*
        // absolute position (where it now sits, i.e. where draw_critter_at finds
        // it). progress runs 0->1: at 0 the sprite is offset back to its old tile,
        // at 1 it sits on the real (new) tile.
        struct creature_move_anim {
            effect_handle handle = 0;  // for cancel_effect(); zero until registered
            point delta_tiles;         // (old - new) tile delta, converted to pixels at draw time
            float progress = 0.0f;     // 0..1
            float per_ms = 0.0f;       // progress increment per millisecond
            move_anim_curve curve = move_anim_curve::smooth;
        };
        std::map<tripoint_abs_ms, creature_move_anim> m_creature_anims;
        // steady_clock timestamp (ms) of the last advance, for real-time stepping.
        std::optional<int64_t> m_creature_anim_last_ms;

        // Active per-creature "got hit" reactions, keyed by the creature's absolute
        // position. Either a vertical pop-and-fall (bounce) or a horizontal
        // knockback-and-return, sharing the offset injection and deferred-overlay
        // path with the move glide.
        struct creature_hit_anim {
            effect_handle handle = 0;  // for cancel_effect(); zero until registered
            float progress = 0.0f;     // 0..1
            float per_ms = 0.0f;       // progress increment per millisecond
            float magnitude_tiles = 0.5f; // peak displacement in tiles (damage-scaled)
            // Knockback direction (victim - attacker) in tiles. Zero -> vertical bounce.
            point dir_tiles;
        };
        std::map<tripoint_abs_ms, creature_hit_anim> m_creature_hit_anims;

        // Active per-creature attack lunges, keyed by the attacker's absolute
        // position: a quick lunge toward the struck target and back.
        struct creature_attack_anim {
            effect_handle handle = 0;  // for cancel_effect(); zero until registered
            float progress = 0.0f;     // 0..1
            float per_ms = 0.0f;       // progress increment per millisecond
            float dist_tiles = 0.5f;   // peak lunge distance in tiles
            point dir_tiles;           // lunge direction (target - attacker) in tiles
        };
        std::map<tripoint_abs_ms, creature_attack_anim> m_creature_attack_anims;

        // Gliding critters are drawn in a deferred overlay pass after the whole
        // z-level row loop, so their offset/parabola sprite sits on top of terrain
        // instead of being overdrawn by rows painted later (the "moving up gets
        // blocked by the ground" artifact).
        struct deferred_glide_critter {
            tripoint_bub_ms pos;
            lit_level ll = lit_level::BLANK;
            int height_3d = 0;
            std::array<bool, 5> invisible = {};
        };
        std::vector<deferred_glide_critter> m_deferred_glide_critters;
        // True during the main row loop: draw_critter_at records gliding critters
        // for the deferred pass instead of drawing them in place. False during the
        // deferred pass itself so they draw normally.
        bool m_collecting_glide_critters = false;

        // Scratch render target for the ortho silhouette mask tint path. Sized
        // to fit the largest batched sprite region; reused across tiles/frames.
        SDL_Texture_Ptr tint_mask_tex;
        int tint_mask_w = 0;
        int tint_mask_h = 0;
        void ensure_tint_mask_texture( int w, int h );

        // Render targets for the character-creation paper-doll preview. The work target is the
        // generous canvas the character is drawn into; its non-transparent pixels are read back to
        // find a tight bounding box, then copied into the cropped target that the caller displays.
        // Both reused across redraws, reallocated only when their required size changes.
        SDL_Texture_Ptr char_preview_work_tex;
        int char_preview_work_w = 0;
        int char_preview_work_h = 0;
        SDL_Texture_Ptr char_preview_tex;
        int char_preview_w = 0;
        int char_preview_h = 0;

        bool in_animation = false;

        bool disable_occlusion = false;

        bool do_draw_explosion = false;
        bool do_draw_custom_explosion = false;
        bool do_draw_bullet = false;
        bool do_draw_hit = false;
        bool do_draw_line = false;
        bool do_draw_cursor = false;
        bool do_draw_highlight = false;
        bool do_draw_weather = false;
        bool do_draw_sct = false;
        bool do_draw_zones = false;
        bool do_draw_async_anim = false;

        tripoint_bub_ms exp_pos;
        int exp_rad = 0;

        std::map<tripoint_bub_ms, explosion_tile> custom_explosion_layer;
        std::map<tripoint_bub_ms, std::string> async_anim_layer;

        // Modern explosion light overlay state.
        // Active explosion light overlays. Each plays asynchronously: the blast
        // is registered when it fires and then advances by real elapsed time every
        // frame (like the creature glides), so the game keeps running and the
        // player can act immediately. Several can overlap (concurrent blasts in one
        // turn). progress runs 0..end_progress; finished entries are dropped.
        struct active_explosion_light {
            effect_handle handle = 0;  // for cancel_effect(); zero until registered
            std::map<tripoint_bub_ms, float> radial; // per-tile radial coord (0..1)
            explosion_light_str_id effect;
            tripoint_bub_ms center;
            float radius_tiles = 0.0f;
            float progress = 0.0f;
            float per_ms = 0.0f;       // progress increment per millisecond
            float end_progress = 1.0f; // progress value at which the blast is done
            // Whether the shockwave (if the recipe has one) is an expanding ring
            // centred on `center`. True for radial blasts (disc). False for
            // directional shapes (line/cone): the shockwave is built from
            // shock_shape + shock_target + shock_half_angle instead of a centred
            // circle. See draw_explosion_light_frame.
            bool circular_shockwave = true;
            // Directional shockwave geometry, used only when circular_shockwave is
            // false. shock_shape selects line vs cone; shock_target gives the
            // direction the front sweeps toward (from `center`); shock_half_angle
            // is the cone's half-width in radians (0 for line).
            shockwave_state::sw_shape shock_shape = shockwave_state::sw_shape::disc;
            tripoint_bub_ms shock_target;
            float shock_half_angle = 0.0f;
        };
        std::vector<active_explosion_light> m_explosion_lights;
        // steady_clock timestamp (ms) of the last advance, for real-time stepping.
        std::optional<int64_t> m_explosion_light_last_ms;
        // Same, for the sound-driven screen shake decay.
        std::optional<int64_t> m_screen_shake_last_ms;

        // Active asynchronous bullet animations. Each is registered when a shot
        // fires and advances by real elapsed time every frame (like the explosion
        // lights), so several concurrent shots overlap without blocking the turn.
        // Finished entries are dropped in advance_bullet_anims().
        struct active_bullet_anim {
            effect_handle handle = 0;  // for cancel_effect(); zero until registered
            std::vector<tripoint_bub_ms> points; // visible flight path tiles
            std::vector<std::string> sprites;    // per-point sprite id
            std::vector<int> rotations;          // per-point rotation
            bool as_line = false;                // whole-line vs moving-dot
            float head = 0.0f;                   // dot: float index along points
            float life = 0.0f;                   // line: progress 0..1 over its life
            float per_ms = 0.0f;                 // advance rate per ms
            // Countdown (ms) before this shot's animation starts. Staggers the
            // rounds of a full-auto burst (which all register in the same tick,
            // before any frame advances) so they fly in sequence — the "哒哒哒"
            // rhythm — instead of as one simultaneous wall of bullets. Counts down
            // in advance_bullet_anims(); the anim is invisible and frozen until it
            // hits zero.
            float start_delay_ms = 0.0f;
        };
        std::vector<active_bullet_anim> m_bullet_anims;
        // steady_clock timestamp (ms) of the last bullet-anim advance.
        std::optional<int64_t> m_bullet_anim_last_ms;

        // Active asynchronous SCT labels.  Each rises from its tile and fades
        // over real time.  Finished entries are dropped in advance_sct().
        std::vector<sct_effect> m_sct_effects;
        // steady_clock timestamp (ms) of the last SCT advance.
        std::optional<int64_t> m_sct_last_ms;

        // Active asynchronous highlight overlays.  Each fades over real time
        // and is dropped when its life expires or it leaves the reality bubble.
        struct highlight_effect {
            tripoint_bub_ms pos;
            float life_ms = 0.0f;          // remaining life
            effect_handle handle = 0;       // for cancel_effect()
        };
        std::vector<highlight_effect> m_highlights;
        // steady_clock timestamp (ms) of the last highlight advance.
        std::optional<int64_t> m_highlights_last_ms;

        // --- Handle infrastructure ---
        // Entry in the handle index: stores only the effect category so
        // cancel_effect() knows which container to search.
        struct handle_entry { effect_kind kind; };
        // Monotonically-increasing handle counter.  Zero means "no handle".
        effect_handle m_next_handle = 1;
        // Maps each allocated handle to its effect kind so cancel_effect()
        // can dispatch to the correct container.
        std::unordered_map<effect_handle, handle_entry> m_handle_index;

        std::vector<tripoint_bub_ms> bul_pos;
        std::vector<std::string> bul_id;
        std::vector<int> bul_rotation;

        struct hit_animation {
            weak_ptr_fast<Creature> creature_ptr;
            std::chrono::steady_clock::time_point timestamp;
        };
        std::deque<hit_animation> hit_animations;

        tripoint_bub_ms line_pos;
        bool is_target_line = false;
        std::vector<tripoint_bub_ms> line_trajectory;
        std::string line_endpoint_id;

        std::vector<tripoint_bub_ms> cursors;
        std::vector<tripoint_bub_ms> highlights;

        weather_printable anim_weather;
        std::string weather_name;

        tripoint_bub_ms zone_start;
        tripoint_bub_ms zone_end;
        tripoint_rel_ms zone_offset;

        // offset values, in tile coordinates, not pixels
        point o;
        // offset for drawing, in pixels.
        point op;

        std::map<tripoint_bub_ms, int> radiation_override;
        std::map<tripoint_bub_ms, ter_id> terrain_override;
        std::map<tripoint_bub_ms, furn_id> furniture_override;
        std::map<tripoint_bub_ms, bool> graffiti_override;
        std::map<tripoint_bub_ms, trap_id> trap_override;
        std::map<tripoint_bub_ms, field_type_id> field_override;
        // bool represents item highlight
        std::map<tripoint_bub_ms, std::tuple<itype_id, mtype_id, bool>> item_override;
        // int, angle, bool represents part_mod, veh_dir, and highlight respectively
        // point represents the mount direction
        std::map<tripoint_bub_ms, std::tuple<vpart_id, int, units::angle, bool, point_rel_ms>>
                vpart_override;
        // int represents spawn count
        std::map<tripoint_bub_ms, std::tuple<mtype_id, int, bool, Creature::Attitude>> monster_override;

    private:
        /**
         * Tracks active night vision goggle status for each draw call.
         * Allows usage of night vision tilesets during sprite rendering.
         */
        bool nv_goggles_activated = false;
        // Set during draw() when any tile with animated=true is rendered.
        bool has_animated_tiles_ = false;

        pimpl<pixel_minimap> minimap;

    public:
        // True if the last draw() rendered any animated tiles.
        bool has_animated_tiles() const {
            return has_animated_tiles_;
        }

        // True if the minimap rendered critters with blinking beacons.
        bool has_blinking_minimap() const;

        // Drop the pixel minimap's renderer-owned resources and cache so
        // they rebuild against the live renderer on the next draw.
        void reset_minimap();

        // Drop the scratch silhouette mask target so the next tinted ortho
        // draw reallocates it against the live renderer.
        void reset_tint_mask();

        // Draw caches persist data between draws and are only recalculated when dirty
        void set_draw_cache_dirty();

        std::string memory_map_mode = "color_pixel_sepia";
};

#endif // CATA_SRC_CATA_TILES_H
