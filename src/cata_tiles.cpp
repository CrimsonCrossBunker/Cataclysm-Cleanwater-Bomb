#if defined(TILES)
#include "cata_tiles.h"
#include "tileset_loader.h"
#include "uistate.h"

#include <algorithm>
#include <array>
#include <bitset>
#include <chrono>
#include <climits>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <functional>
#include <iterator>
#include <optional>
#include <set>
#include <sstream>
#include <stdexcept>
#include <tuple>
#include <unordered_set>
#include <variant>

#include "action.h"
#include "avatar.h"
#include "cached_options.h"
#include "calendar.h"
#include "cata_assert.h"
#include "cata_small_literal_vector.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "character.h"
#include "character_id.h"
#include "clzones.h"
#include "colony.h"
#include "color.h"
#include "creature_tracker.h"
#include "cursesdef.h"
#include "cursesport.h"
#include "debug.h"
#include "dialogue.h"
#include "enum_conversions.h"
#include "enums.h"
#include "explosion_light.h"
#include "field.h"
#include "field_type.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "sdl_gamepad.h"
#include "item.h"
#include "item_factory.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "level_cache.h"
#include "lightmap.h"
#include "line.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_extras.h"
#include "map_memory.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "maptile_fwd.h"
#include "mdarray.h"
#include "monster.h"
#include "monstergenerator.h"
#include "mtype.h"
#include "mutation.h"
#include "npc.h"
#include "npc_attack.h"
#include "omdata.h"
#include "output.h"
#include "overlay_ordering.h"
#include "overmap.h"
#include "pixel_minimap.h"
#include "profiling.h"
#include "scent_map.h"
#include "screen_shake.h"
#include "sdl_renderer_recovery.h"
#include "sdl_utils.h"
#include "sdl_wrappers.h"
#include "sdltiles.h"
#include "shockwave.h"
#include "sounds.h"
#include "string_formatter.h"
#include "submap.h"
#include "tileray.h"
#include "translation.h"
#include "trap.h"
#include "type_id.h"
#include "units_utility.h"
#include "value_ptr.h"
#include "veh_type.h"
#include "vehicle.h"
#include "viewer.h"
#include "vpart_position.h"
#include "weather.h"
#include "weather_type.h"
#include "weighted_list.h"

static const efftype_id effect_ridden( "ridden" );

static const itype_id itype_corpse( "corpse" );

static const trait_id trait_INATTENTIVE( "INATTENTIVE" );

static const trap_str_id tr_unfinished_construction( "tr_unfinished_construction" );

// Iterating a vehicle's "structure" parts yields one part per occupied square, so the vehicle
// preview draws exactly one sprite per tile (the same basis the ASCII display_veh() uses).
static const vpart_location_id vpart_location_structure( "structure" );

static const std::string ITEM_HIGHLIGHT( "highlight_item" );
static const std::string ZOMBIE_REVIVAL_INDICATOR( "zombie_revival_indicator" );

static const std::array<std::string, 8> multitile_keys = {{
        "center",
        "corner",
        "edge",
        "t_connection",
        "end_piece",
        "unconnected",
        "open",
        "broken"
    }
};

static const std::string empty_string;
static const std::array<std::string, 17> TILE_CATEGORY_IDS = {{
        "", // TILE_CATEGORY::NONE,
        "vehicle_part", // TILE_CATEGORY::VEHICLE_PART,
        "terrain", // TILE_CATEGORY::TERRAIN,
        "item", // TILE_CATEGORY::ITEM,
        "furniture", // TILE_CATEGORY::FURNITURE,
        "trap", // TILE_CATEGORY::TRAP,
        "field", // TILE_CATEGORY::FIELD,
        "lighting", // TILE_CATEGORY::LIGHTING,
        "monster", // TILE_CATEGORY::MONSTER,
        "bullet", // TILE_CATEGORY::BULLET,
        "hit_entity", // TILE_CATEGORY::HIT_ENTITY,
        "weather", // TILE_CATEGORY::WEATHER,
        "overmap_terrain", // TILE_CATEGORY::OVERMAP_TERRAIN
        "overmap_vision_level", // TILE_CATEGORY::OVERMAP_VISION_LEVEL
        "overmap_weather", // TILE_CATEGORY::OVERMAP_WEATHER
        "map_extra", // TILE_CATEGORY::MAP_EXTRA
        "overmap_note", // TILE_CATEGORY::OVERMAP_NOTE
    }
};

static_assert( TILE_CATEGORY_IDS.size() == static_cast<size_t>( TILE_CATEGORY::last ),
               "TILE_CATEGORY_IDS must match list of TILE_CATEGORY values" );

namespace
{

std::string get_ascii_tile_id( const uint32_t sym, const int FG, const int BG )
{
    return std::string( { 'A', 'S', 'C', 'I', 'I', '_', static_cast<char>( sym ),
                          static_cast<char>( FG ), static_cast<char>( BG )
                        } );
}

pixel_minimap_mode pixel_minimap_mode_from_string( const std::string &mode )
{
    if( mode == "solid" ) {
        return pixel_minimap_mode::solid;
    } else if( mode == "squares" ) {
        return pixel_minimap_mode::squares;
    } else if( mode == "dots" ) {
        return pixel_minimap_mode::dots;
    }

    debugmsg( "Unsupported pixel minimap mode \"" + mode + "\"." );
    return pixel_minimap_mode::solid;
}

// Generic function for hashing points. Untype them to use them.
auto simple_point_hash = []( const point &p )
{
    return p.x + p.y * 65536;
};

} // namespace

#if SDL_MAJOR_VERSION >= 3
// Translate (lit_level, use_night_vision_tiles) to the variant_kind enum the
// GPU shader path consumes. Mirrors the atlas-variant branch in
// draw_sprite_at; keep them in lockstep when one moves.
cata_shader::variant_kind compute_variant_kind( lit_level ll, bool use_nv_tiles )
{
    if( ll == lit_level::MEMORIZED ) {
        return cata_shader::variant_kind::MEMORY;
    }
    if( use_nv_tiles ) {
        return ll == lit_level::LOW
               ? cata_shader::variant_kind::NIGHT
               : cata_shader::variant_kind::OVEREXPOSED;
    }
    if( ll == lit_level::LOW ) {
        return cata_shader::variant_kind::SHADOW;
    }
    return cata_shader::variant_kind::NORMAL;
}
#endif

static int msgtype_to_tilecolor( const game_message_type type, const bool bOldMsg )
{
    const int iBold = bOldMsg ? 0 : 8;

    switch( type ) {
        case m_good:
            return iBold + catacurses::green;
        case m_bad:
            return iBold + catacurses::red;
        case m_mixed:
        case m_headshot:
            return iBold + catacurses::magenta;
        case m_neutral:
            return iBold + catacurses::white;
        case m_warning:
        case m_critical:
            return iBold + catacurses::yellow;
        case m_info:
        case m_grazing:
            return iBold + catacurses::blue;
        default:
            break;
    }

    return -1;
}

formatted_text::formatted_text( const std::string &text, const int color,
                                const direction text_direction )
    : text( text ), color( color )
{
    switch( text_direction ) {
        case direction::NORTHWEST:
        case direction::WEST:
        case direction::SOUTHWEST:
            alignment = text_alignment::right;
            break;
        case direction::NORTH:
        case direction::CENTER:
        case direction::SOUTH:
            alignment = text_alignment::center;
            break;
        default:
            alignment = text_alignment::left;
            break;
    }
}

cata_tiles::cata_tiles( const SDL_Renderer_Ptr &renderer, const GeometryRenderer_Ptr &geometry,
                        tileset_cache &cache ) :
    renderer( renderer ),
    geometry( geometry ),
    cache( cache ),
    minimap( renderer, geometry )
{
    cata_assert( renderer );

    tile_height = 0;
    tile_width = 0;

    in_animation = false;
    do_draw_explosion = false;
    do_draw_custom_explosion = false;
    do_draw_bullet = false;
    do_draw_hit = false;
    do_draw_line = false;
    do_draw_cursor = false;
    do_draw_highlight = false;
    do_draw_weather = false;
    do_draw_sct = false;
    do_draw_zones = false;

    nv_goggles_activated = false;

    on_options_changed();
}

cata_tiles::~cata_tiles() = default;

void cata_tiles::on_options_changed()
{
    memory_map_mode = get_option <std::string>( "MEMORY_MAP_MODE" );

#if SDL_MAJOR_VERSION >= 3
    if( cata_shader::variant_pass *vp = get_shared_variant_pass() ) {
        vp->select_memory_preset(
            cata_shader::memory_preset_from_option_value( memory_map_mode ) );
    }
#endif

    pixel_minimap_settings settings;

    settings.mode =
        pixel_minimap_mode_from_string( get_option<std::string>( "PIXEL_MINIMAP_MODE" ) );
    settings.brightness = get_option<int>( "PIXEL_MINIMAP_BRIGHTNESS" );
    settings.beacon_size = get_option<int>( "PIXEL_MINIMAP_BEACON_SIZE" );
    settings.beacon_blink_interval = get_option<int>( "PIXEL_MINIMAP_BLINK" );
    settings.square_pixels = get_option<bool>( "PIXEL_MINIMAP_RATIO" );
    settings.scale_to_fit = get_option<bool>( "PIXEL_MINIMAP_SCALE_TO_FIT" );

    minimap->set_settings( settings );
}

void tileset::clear()
{
    tile_values.clear();
    shadow_tile_values.clear();
    night_tile_values.clear();
    overexposed_tile_values.clear();
    memory_tile_values.clear();
    silhouette_tile_values.clear();
    tinted_tile_values.clear();
    atlas_descriptors.clear();
    default_item_highlight_index.reset();
    renderer_instance_generation_at_upload = 0;
    gpu_textures_generation_at_upload = 0;
    duplicate_ids.clear();
    tile_ids.clear();
    for( std::unordered_map<std::string, season_tile_value> &m : tile_ids_by_season ) {
        m.clear();
    }
    item_layer_data.clear();
    field_layer_data.clear();
}

uint64_t compute_tileset_filter_fingerprint( const std::string &memory_map_mode )
{
    auto mix = []( uint64_t &h, uint64_t v ) {
        h ^= v + 0x9e3779b97f4a7c15ULL + ( h << 6 ) + ( h >> 2 );
    };
    uint64_t h = 0;
    // SCALING_MODE is stamped onto every texture at CreateTexture time via
    // the SDL default scale quality.
    mix( h, std::hash<std::string> {}( get_option<std::string>( "SCALING_MODE" ) ) );
    if( memory_map_mode == "color_pixel_custom" ) {
        mix( h, static_cast<uint64_t>( get_option<int>( "MEMORY_RGB_DARK_RED" ) ) );
        mix( h, static_cast<uint64_t>( get_option<int>( "MEMORY_RGB_DARK_GREEN" ) ) );
        mix( h, static_cast<uint64_t>( get_option<int>( "MEMORY_RGB_DARK_BLUE" ) ) );
        mix( h, static_cast<uint64_t>( get_option<int>( "MEMORY_RGB_BRIGHT_RED" ) ) );
        mix( h, static_cast<uint64_t>( get_option<int>( "MEMORY_RGB_BRIGHT_GREEN" ) ) );
        mix( h, static_cast<uint64_t>( get_option<int>( "MEMORY_RGB_BRIGHT_BLUE" ) ) );
        const float gamma = get_option<float>( "MEMORY_GAMMA" );
        uint32_t gamma_bits = 0;
        std::memcpy( &gamma_bits, &gamma, sizeof( gamma_bits ) );
        mix( h, static_cast<uint64_t>( gamma_bits ) );
    }
    return h;
}

const tile_type *tileset::find_tile_type( const std::string &id ) const
{
    const auto iter = tile_ids.find( id );
    return iter != tile_ids.end() ? &iter->second : nullptr;
}

std::optional<tile_lookup_res>
tileset::find_tile_type_by_season( const std::string &id, season_type season ) const
{
    cata_assert( season < season_type::NUM_SEASONS );
    const auto iter = tile_ids_by_season[season].find( id );

    if( iter == tile_ids_by_season[season].end() ) {
        return std::nullopt;
    }
    const tileset::season_tile_value &res = iter->second;
    if( res.season_tile ) {
    return res.season_tile;
} else if( res.default_tile ) { // can skip this check, but just in case
    return tile_lookup_res( iter->first, *res.default_tile );
    }
    debugmsg( "empty record found in `tile_ids_by_season` for key: %s", id );
    return std::nullopt;
}

tile_type &tileset::create_tile_type( const std::string &id, tile_type &&new_tile_type )
{
    // Must overwrite existing tile
    // TODO: c++17 - replace [] + find() with insert_or_assign()
    tile_ids[id] = std::move( new_tile_type );
    auto inserted = tile_ids.find( id );

    const std::string &inserted_id = inserted->first;
    tile_type &inserted_tile = inserted->second;

    // populate cache by season
    constexpr size_t suffix_len = 15;
    // NOLINTNEXTLINE(cata-use-mdarray,modernize-avoid-c-arrays)
    constexpr char season_suffix[NUM_SEASONS][suffix_len] = {
        "_season_spring", "_season_summer", "_season_autumn", "_season_winter"
    };
    bool has_season_suffix = false;
    for( int i = 0; i < NUM_SEASONS; i++ ) {
        if( string_ends_with( id, season_suffix[i] ) ) {
            has_season_suffix = true;
            // key is id without _season suffix
            season_tile_value &value = tile_ids_by_season[i][id.substr( 0,
                id.size() - strlen( season_suffix[i] ) )];
            // value stores reference to string id with _season suffix
            value.season_tile = tile_lookup_res( inserted_id, inserted_tile );
            break;
        }
    }
    // tile doesn't have _season suffix, add it as "default" into all four seasons
    if( !has_season_suffix ) {
        for( auto &by_season_map : tile_ids_by_season ) {
            by_season_map[id].default_tile = &inserted_tile;
        }
    }

    return inserted_tile;
}

bool service_mode2_upload_interrupt( const atlas_upload_interrupt interrupt,
                                     atlas_replay_quarantine &quarantine,
                                     const uint64_t instance_before )
{
    if( interrupt == atlas_upload_interrupt::renderer_invalidated ) {
        // The drain is about to destroy the renderer; release the quarantined
        // handles without SDL_DestroyTexture.
        quarantine.abandon_pre_lost_renderer();
    } else if( interrupt == atlas_upload_interrupt::paused ) {
        // Wait out the background; the foreground event queues the rebuild.
        pump_until_renderer_foreground();
    }
    drain_renderer_recovery();
    const bool recovered = renderer_coordinator.state() == renderer_recovery_state::ready;
    if( !quarantine.empty() ) {
        // Destroy on the live renderer only when the drain left it healthy and the
        // instance is unchanged (a reset the renderer survived). A bumped instance
        // or unfinished recovery means the origin renderer is gone -- abandon,
        // since a loss teardown can destroy it before the instance bumps.
        if( recovered && renderer_coordinator.instance_generation() == instance_before ) {
            quarantine.drain_live_renderer();
        } else {
            quarantine.abandon_pre_lost_renderer();
        }
    }
    return recovered;
}

void cata_tiles::load_tileset( const std::string &tileset_id, const bool precheck,
                               const bool force, const bool pump_events, const bool terrain )
{
    renderer_texture_generations gens = renderer_coordinator.texture_generations();
    // Skip the reload only when the same tileset is already bound against the
    // current renderer and texture generations; a generation bump from a
    // device reset or loss invalidates the bundle and must reload.
    if( tileset_ptr && tileset_ptr->get_tileset_id() == tileset_id && !force
        && tileset_ptr->get_renderer_instance_generation_at_upload() == gens.instance
        && tileset_ptr->get_gpu_textures_generation_at_upload() == gens.textures ) {
        return;
    }
    // Snapshot the global mutation-overlay ordering before the candidate parse
    // rewrites it: the ordering must match the bound tileset, so restore it if
    // the load aborts without publishing a new one.
    const std::map<std::string, int> overlay_ordering_snapshot = tileset_mutation_overlay_ordering;
    // TODO: move into clear or somewhere else.
    // reset the overlay ordering from the previous loaded tileset
    tileset_mutation_overlay_ordering.clear();

    // A reset/loss/pause mid-upload aborts the load and quarantines the partial
    // candidate; the live tileset stays bound. Drain outside the upload scope
    // (drains are refused while it owns candidate textures), dispose the
    // quarantine against the resulting renderer, and retry until the upload lands.
    atlas_replay_quarantine quarantine;
    const atlas_upload_poll poll = []() {
        return renderer_coordinator.mode2_upload_poll();
    };
    bool published = false;
    while( true ) {
        atlas_upload_interrupt interrupt = atlas_upload_interrupt::none;
        std::shared_ptr<const tileset> loaded;
        const uint64_t instance_before = gens.instance;
        {
            // Gate drains across the upload (see atlas_upload_scope). A precheck
            // does no GPU upload, so it is neither gated nor polled.
            atlas_upload_scope upload_guard( !precheck );
            loaded = cache.load_tileset( tileset_id, renderer, precheck, force, pump_events, terrain,
                                         memory_map_mode, gens.instance, gens.textures,
                                         precheck ? atlas_upload_poll{} : poll,
                                         precheck ? nullptr : &quarantine, &interrupt );
        }
        if( interrupt == atlas_upload_interrupt::none ) {
            tileset_ptr = loaded;
            published = true;
            break;
        }
        // Recover the renderer and dispose the quarantined candidate; stop when
        // the drain could not ready it rather than spinning on a failed recovery.
        if( !service_mode2_upload_interrupt( interrupt, quarantine, instance_before ) ) {
            break;
        }
        gens = renderer_coordinator.texture_generations();
    }

    if( !published ) {
        // The load aborted with the previous tileset still bound; restore the
        // overlay ordering that matched it.
        tileset_mutation_overlay_ordering = overlay_ordering_snapshot;
    }

    set_draw_scale( 16 );

    // Precalculate fog transparency
    // On isometric tilesets, fog intensity scales with zlevel_height in tile_config.json
    fog_alpha = is_isometric() ? std::min( std::max( int( 255.0f - 255.0f * pow( 155.0f / 255.0f,
        zlevel_height / 100.0f ) ), 40 ), 150 ) : 100;

    if( !precheck && published ) {
        // Service any recovery queued during the now-published upload. An
        // aborted load already drained inside service_mode2_upload_interrupt and
        // left recovery for the next outer boundary, so do not redrain here.
        drain_renderer_recovery();
    }
}

void cata_tiles::reinit()
{
    set_draw_scale( 16 );
    // A tileset reload / renderer recovery invalidates any in-flight present-time
    // overlay: the pixel geometry it published was computed against the old tile
    // metrics and scroll. Drop the async explosion lights and their shockwaves so a
    // stale ring/light doesn't paint onto the rebuilt scene, and clear any shake.
    void_explosion_light();
    clear_screen_shake();
    void_bullet_anim();
    // Wrap so the clear lands on display_buffer rather than the null idle target.
    display_buffer_draw_scope draw_scope;
    if( !draw_scope.should_draw() ) {
        return;
    }
    RenderClear( renderer );
}

void cata_tiles::set_draw_scale( int scale )
{
    cata_assert( tileset_ptr );
    if( scale <= 0 ) {
        debugmsg( "Invalid tileset draw scale %d, using default %d", scale, DEFAULT_TILESET_ZOOM );
        scale = DEFAULT_TILESET_ZOOM;
    }
    const int mult = tileset_ptr->get_tile_pixelscale() * scale;
    const int div = 16;
    tile_width = tileset_ptr->get_tile_width() * mult / div;
    tile_height = tileset_ptr->get_tile_height() * mult / div;
    max_tile_extent = tileset_ptr->get_max_tile_extent();
    // Rounding down because the extent may be negative
    max_tile_extent.p_min.x = divide_round_down( max_tile_extent.p_min.x * mult, div );
    max_tile_extent.p_min.y = divide_round_down( max_tile_extent.p_min.y * mult, div );
    max_tile_extent.p_max.x = divide_round_down( max_tile_extent.p_max.x * mult, div );
    max_tile_extent.p_max.y = divide_round_down( max_tile_extent.p_max.y * mult, div );
    zlevel_height = tileset_ptr->get_zlevel_height();
}

static std::map<tripoint_bub_ms, int> display_npc_attack_potential()
{
    avatar &you = get_avatar();
    npc avatar_as_npc;
    std::ostringstream os;
    JsonOut jsout( os );
    jsout.write( you );
    JsonValue jsin = json_loader::from_string( os.str() );
    jsin.read( avatar_as_npc );
    avatar_as_npc.regen_ai_cache();
    avatar_as_npc.evaluate_best_attack( nullptr );
    std::map<tripoint_bub_ms, int> effectiveness_map;
    std::vector<npc_attack_rating> effectiveness =
        avatar_as_npc.get_current_attack()->all_evaluations( avatar_as_npc, nullptr );
    for( const npc_attack_rating &effectiveness_at_point : effectiveness ) {
        if( !effectiveness_at_point.value() ) {
            continue;
        }
        effectiveness_map[effectiveness_at_point.target()] = *effectiveness_at_point.value();
    }
    return effectiveness_map;
}

// NOLINTNEXTLINE(readability-function-size)
void cata_tiles::draw( const point &dest, const tripoint_bub_ms &center, int width, int height,
                       std::multimap<point, formatted_text> &overlay_strings,
                       color_block_overlay_container &color_blocks )
{
    display_buffer_draw_scope draw_scope;
    if( display_buffer_scope_is_invalid() || !g ) {
        return;
    }
    CATA_PROFILE_SCOPE_NAMED( "tiles.draw" );

    // Prevent divide-by-zero if no tile width/height specified
    if( tile_width == 0 || tile_height == 0 ) {
        return;
    }

    has_animated_tiles_ = false;

    // Advance all real-time transient effects (explosion lights, bullet
    // tracers, creature glides, SCT labels, highlights, screen shake)
    // by the elapsed wall-clock time before drawing so every sprite
    // reflects the current frame.
    advance_all_transient_effects();

    {
        //set clipping to prevent drawing over stuff we shouldn't
        SDL_Rect clipRect = {dest.x, dest.y, width, height};
        RenderSetClipRect( renderer, &clipRect );

        //fill render area with opaque black to prevent artifacts where no new pixels are drawn.
        //alpha must be 255: the color-modulated geometry backend composites via a BLEND texture,
        //so an alpha-0 fill would be a no-op and leave the persistent display_buffer uncleared.
        geometry->rect( renderer, clipRect, SDL_Color{ 0, 0, 0, 255 } );
    }

    const point s = get_window_base_tile_counts( point( width, height ) );

    init_light();
    map &here = get_map();
    const visibility_variables &cache = here.get_visibility_variables_cache();

    o = is_isometric() ? center.xy().raw() : center.xy().raw() - point( POSX, POSY );

    op = dest;
    screentile_width = s.x;
    screentile_height = s.y;
    CATA_PROFILE_PLOT( "tiles.tile_width_px", static_cast<int64_t>( tile_width ) );
    CATA_PROFILE_PLOT( "tiles.viewport_slots",
                       static_cast<int64_t>( s.x ) * static_cast<int64_t>( s.y ) );

    const int num_ranges = is_isometric() ? 1 + fov_3d_z_range : 1;
    std::vector<half_open_rectangle<point>> z_any_tile_range( num_ranges );
    for( int z = 0; z < num_ranges; ++z ) {
        z_any_tile_range[z] = get_window_any_tile_range( { width, height }, -z );
    }
    const half_open_rectangle<point> &top_any_tile_range = z_any_tile_range[0];
    const half_open_rectangle<point> &bottom_any_tile_range = z_any_tile_range[num_ranges - 1];
    cata_assert( top_any_tile_range.p_min.x == bottom_any_tile_range.p_min.x );
    cata_assert( top_any_tile_range.p_max.x == bottom_any_tile_range.p_max.x );
    cata_assert( top_any_tile_range.p_min.y >= bottom_any_tile_range.p_min.y );
    cata_assert( top_any_tile_range.p_max.y >= bottom_any_tile_range.p_max.y );
    const int min_col = top_any_tile_range.p_min.x;
    const int max_col = top_any_tile_range.p_max.x;
    const int min_row = bottom_any_tile_range.p_min.y;
    const int max_row = top_any_tile_range.p_max.y;

    avatar &you = get_avatar();
    //limit the render area to maximum view range (121x121 square centered on player)
    const tripoint_bub_ms you_pos = you.pos_bub( here );
    const point min_visible( you_pos.x() % SEEX, you_pos.y() % SEEY );
    const point max_visible( ( you_pos.x() % SEEX ) + ( MAPSIZE - 1 ) * SEEX,
                             ( you_pos.y() % SEEY ) + ( MAPSIZE - 1 ) * SEEY );
    const int draw_min_z = std::max( you.posz() - fov_3d_z_range, -OVERMAP_DEPTH );

    // Map memory should be at least the size of the view range
    // so that new tiles can be memorized, and at least the size of the display
    // since at farthest zoom displayed area may be bigger than view range.
    point min_mm_reg = min_visible;
    point max_mm_reg = max_visible;
    if( is_isometric() ) {
        std::optional<point> northmost = tile_to_player( { min_col, min_row } );
        if( !northmost.has_value() ) {
            northmost = tile_to_player( { min_col + 1, min_row } );
        }
        std::optional<point> southmost = tile_to_player( { max_col, max_row } );
        if( !southmost.has_value() ) {
            southmost = tile_to_player( { max_col - 1, max_row } );
        }
        std::optional<point> westmost = tile_to_player( { min_col, max_row } );
        if( !westmost.has_value() ) {
            westmost = tile_to_player( { min_col + 1, max_row } );
        }
        std::optional<point> eastmost = tile_to_player( { max_col, min_row } );
        if( !eastmost.has_value() ) {
            eastmost = tile_to_player( { max_col - 1, min_row } );
        }
        if( northmost.has_value() && southmost.has_value()
            && westmost.has_value() && eastmost.has_value() ) {
            min_mm_reg = point( std::min( min_mm_reg.x, westmost->x ),
                                std::min( min_mm_reg.y, northmost->y ) );
            max_mm_reg = point( std::max( max_mm_reg.x, eastmost->x ),
                                std::max( max_mm_reg.y, southmost->y ) );
        }
    } else {
        std::optional<point> northwest = tile_to_player( { min_col, min_row } );
        std::optional<point> southeast = tile_to_player( { max_col, max_row } );
        if( northwest.has_value() && southeast.has_value() ) {
            min_mm_reg = point( std::min( min_mm_reg.x, northwest->x ),
                                std::min( min_mm_reg.y, northwest->y ) );
            max_mm_reg = point( std::max( max_mm_reg.x, southeast->x ),
                                std::max( max_mm_reg.y, southeast->y ) );
        }
    }

    //invalidate draw_points_cache if viewport dimensions have changed
    point_rel_ms top_left( min_col, min_row );
    point_rel_ms bottom_right( max_col, max_row );
    if( top_left != here.prev_top_left || bottom_right != here.prev_bottom_right || o != here.prev_o ) {
        set_draw_cache_dirty();
    }
    here.prev_top_left = top_left;
    here.prev_bottom_right = bottom_right;
    here.prev_o = o;

    {
        CATA_PROFILE_SCOPE_NAMED( "tiles.map_memory_prepare" );
        you.prepare_map_memory_region(
            here.get_abs( tripoint_bub_ms( min_mm_reg.x, min_mm_reg.y, center.z() ) ),
            here.get_abs( tripoint_bub_ms( max_mm_reg.x, max_mm_reg.y, center.z() ) )
        );
    }

    //set up a default tile for the edges outside the render area
    visibility_type offscreen_type = visibility_type::HIDDEN;
    if( cache.u_is_boomered ) {
        offscreen_type = visibility_type::BOOMER_DARK;
    }

    //retrieve night vision goggle status once per draw
    auto vision_cache = you.get_vision_modes();
    nv_goggles_activated = vision_cache[NV_GOGGLES];

    // check that the creature for which we'll draw the visibility map is still alive at that point
    if( g->display_overlay_state( ACTION_DISPLAY_VISIBILITY ) &&
        g->displaying_visibility_creature ) {
        const Creature *creature = g->displaying_visibility_creature;
        const auto is_same_creature_predicate = [&creature]( const Creature & c ) {
            return creature == &c;
        };
        if( g->get_creature_if( is_same_creature_predicate ) == nullptr )  {
            g->displaying_visibility_creature = nullptr;
        }
    }
    const point half_tile( tile_width / 2, 0 );
    const point quarter_tile( tile_width / 4, tile_height / 4 );
    const auto apply_visible = [&]( const tripoint_bub_ms & np, const level_cache & ch, map & here ) {
        return np.y() < min_visible.y || np.y() > max_visible.y ||
               np.x() < min_visible.x || np.x() > max_visible.x ||
               would_apply_vision_effects( here.get_visibility( ch.visibility_cache[np.x()][np.y()],
                   cache ) );
    };
    std::map<tripoint_bub_ms, int> npc_attack_rating_map;
    int max_npc_effectiveness = 0;
    if( g->display_overlay_state( ACTION_DISPLAY_NPC_ATTACK_POTENTIAL ) ) {
        npc_attack_rating_map = display_npc_attack_potential();
        for( const std::pair<const tripoint_bub_ms, int> &pair : npc_attack_rating_map ) {
            max_npc_effectiveness = std::max( pair.second, max_npc_effectiveness );
        }
    }

    if( here.draw_points_cache_dirty ) {
        CATA_PROFILE_SCOPE_NAMED( "tiles.draw_cache_rebuild" );
        here.draw_points_cache_dirty = false;
        // overlay_strings and color_blocks are generated with draw_points and thus are cleared together
        // Soft clear: keep the per-z/per-row buffers and each row's vector capacity
        // so the per-move rebuild reuses last frame's buffers instead of freeing and
        // reallocating every step. Freeing here was the dominant movement-time cost
        // (profiled: std::map _Erase_tree + vector reserve/realloc churn). All access
        // is via operator[], so leftover empty rows are indistinguishable from absent.
        here.draw_points_cache.tiles.soft_clear();
        here.overlay_strings_cache.clear();
        here.color_blocks_cache = {};

        // Populate view_snapshot metadata. The region is parameterised
        // explicitly (observer + viewport) so a non-avatar observer or a
        // different viewport region can produce its own snapshot later
        // without changing any rendering code.
        // origin.z = draw_min_z (bottom z-level of the viewport),
        // observer_z = centre z-level of the viewport (avatar's current z).
        here.draw_points_cache.origin = here.get_abs(
                                            tripoint_bub_ms( min_visible.x, min_visible.y, draw_min_z ) );
        here.draw_points_cache.observer_z = center.z();
        here.draw_points_cache.size = point( max_col - min_col, max_row - min_row );
        here.draw_points_cache.observer = you.getID();

        // Monotonic generation counter: bumped once per snapshot rebuild
        // (dirty gate), not per render frame, so the server can use it as an
        // authoritative state version for client interpolation.
        here.draw_points_cache.generation++;

        if( g->display_overlay_state( ACTION_DISPLAY_VEHICLE_AI ) ) {
            for( const wrapped_vehicle &elem : here.get_vehicles() ) {
                const vehicle &veh = *elem.v;
                const point_bub_ms veh_pos = veh.pos_bub( here ).xy();
                for( const auto &overlay_data : veh.get_debug_overlay_data() ) {
                    const point_bub_ms pt = veh_pos + std::get<0>( overlay_data );
                    const int color = std::get<1>( overlay_data );
                    const std::string &text = std::get<2>( overlay_data );
                    overlay_strings.emplace( player_to_screen( pt ),
                                             formatted_text( text, color,
                                                     text_alignment::left ) );
                }
            }
        }

        // Generate new draw points
        creature_tracker &creatures = get_creature_tracker();
        for( int row = min_row; row < max_row; row ++ ) {
            // Reserve columns on each row
            for( int zlevel = center.z(); zlevel >= draw_min_z; zlevel -- ) {
                here.draw_points_cache.tiles[zlevel][row].reserve( std::max( 0, max_col - min_col ) );
            }
            for( int col = min_col; col < max_col; col ++ ) {
                const std::optional<point> temp = tile_to_player( { col, row } );
                if( !temp.has_value() ) {
                    continue;
                }
                for( int zlevel = center.z(); zlevel >= draw_min_z; zlevel -- ) {
                    // todo: conversion slightly simplified, a couple of calls already use pos as tripoint_bub_ms
                    const tripoint_bub_ms pos( point_bub_ms( temp.value() ), zlevel );
                    const tripoint_abs_ms pos_global = here.get_abs( pos );
                    const int &x = pos.x();
                    const int &y = pos.y();
                    const bool is_center_z = zlevel == center.z();
                    const level_cache &ch2 = here.access_cache( zlevel );

                    // light level is used for choosing between grayscale filter and normal lit tiles.
                    lit_level ll;
                    // invisible to normal eyes
                    std::array<bool, 5> invisible;
                    invisible[0] = false;

                    if( y < min_visible.y || y > max_visible.y || x < min_visible.x || x > max_visible.x ) {
                        if( you.has_memory_at( pos_global ) ) {
                            ll = lit_level::MEMORIZED;
                            invisible[0] = true;
                        } else if( has_draw_override( pos ) ) {
                            ll = lit_level::DARK;
                            invisible[0] = true;
                        } else {
                            if( would_apply_vision_effects( offscreen_type ) ) {
                                here.draw_points_cache.tiles[zlevel][row].emplace_back( tile_render_info::tile_view_data{ pos },
                                        tile_render_info::tile_render_scratch{},
                                        tile_render_info::vision_effect{ offscreen_type } );
                            }
                            break;
                        }
                    } else {
                        ll = ch2.visibility_cache[x][y];
                    }

                    if( is_center_z ) {
                        // Add scent value to the overlay_strings list for every visible tile when
                        // displaying scent
                        if( g->display_overlay_state( ACTION_DISPLAY_SCENT ) && !invisible[0] ) {
                            const int scent_value = get_scent().get( pos );
                            if( scent_value > 0 ) {
                                here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ) + half_tile,
                                                                    formatted_text( std::to_string( scent_value ),
                                                                            8 + catacurses::yellow, direction::NORTH ) );
                            }
                        }

                        // Add scent type to the overlay_strings list for every visible tile when
                        // displaying scent
                        if( g->display_overlay_state( ACTION_DISPLAY_SCENT_TYPE ) && !invisible[0] ) {
                            const scenttype_id scent_type = get_scent().get_type( pos );
                            if( !scent_type.is_empty() ) {
                                here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ) + half_tile,
                                                                    formatted_text( scent_type.c_str(),
                                                                            8 + catacurses::yellow, direction::NORTH ) );
                            }
                        }

                        if( g->display_overlay_state( ACTION_DISPLAY_RADIATION ) ) {
                            const auto rad_override = radiation_override.find( pos );
                            const bool rad_overridden = rad_override != radiation_override.end();
                            if( rad_overridden || !invisible[0] ) {
                                const int rad_value = rad_overridden ? rad_override->second :
                                                      here.get_radiation( pos );
                                catacurses::base_color col;
                                if( rad_value > 0 ) {
                                    col = catacurses::green;
                                } else {
                                    col = catacurses::cyan;
                                }
                                here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ) + half_tile,
                                                                    formatted_text( std::to_string( rad_value ),
                                                                            8 + col, direction::NORTH ) );
                            }
                        }

                        if( g->display_overlay_state( ACTION_DISPLAY_NPC_ATTACK_POTENTIAL ) ) {
                            if( npc_attack_rating_map.count( pos ) ) {
                                const int val = npc_attack_rating_map.at( pos );
                                short color;
                                if( val <= 0 ) {
                                    color = catacurses::red;
                                } else if( val == max_npc_effectiveness ) {
                                    color = catacurses::cyan;
                                } else {
                                    color = catacurses::white;
                                }
                                here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ) + half_tile,
                                                                    formatted_text( std::to_string( val ), color,
                                                                            direction::NORTH ) );
                            }
                        }

                        // Add temperature value to the overlay_strings list for every visible tile when
                        // displaying temperature
                        if( g->display_overlay_state( ACTION_DISPLAY_TEMPERATURE ) && !invisible[0] ) {
                            const units::temperature temp_value = get_weather().get_temperature( pos );
                            const float celsius_temp_value = units::to_celsius( temp_value );
                            short color;
                            const short bold = 8;
                            if( celsius_temp_value > 40 ) {
                                color = catacurses::red;
                            } else if( celsius_temp_value > 25 ) {
                                color = catacurses::yellow + bold;
                            } else if( celsius_temp_value > 10 ) {
                                color = catacurses::green + bold;
                            } else if( celsius_temp_value > 0 ) {
                                color = catacurses::white + bold;
                            } else if( celsius_temp_value > -10 ) {
                                color = catacurses::cyan + bold;
                            } else {
                                color = catacurses::blue + bold;
                            }

                            std::string temp_str;
                            if( get_option<std::string>( "USE_CELSIUS" ) == "celsius" ) {
                                temp_str = string_format( "%.0f", celsius_temp_value );
                            } else if( get_option<std::string>( "USE_CELSIUS" ) == "kelvin" ) {
                                temp_str = string_format( "%.0f", units::to_kelvin( temp_value ) );
                            } else {
                                temp_str = string_format( "%.0f", units::to_fahrenheit( temp_value ) );
                            }
                            here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ),
                                                                formatted_text( temp_str, color,
                                                                        text_alignment::left ) );
                        }

                        if( g->display_overlay_state( ACTION_DISPLAY_SNOW_DEPTH ) && !invisible[0] ) {
                            const double snow_mm = get_weather().get_snow_depth_mm(
                                                       project_to<coords::omt>( here.get_abs( pos ) ) );
                            short color;
                            const short bold = 8;
                            if( snow_mm >= 500 ) {
                                color = catacurses::white + bold;
                            } else if( snow_mm >= 250 ) {
                                color = catacurses::cyan + bold;
                            } else if( snow_mm >= 100 ) {
                                color = catacurses::blue + bold;
                            } else if( snow_mm >= 1 ) {
                                color = catacurses::green + bold;
                            } else {
                                color = catacurses::dark_gray;
                            }

                            std::string snow_str = string_format( "%.0f", snow_mm );
                            here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ),
                                                                formatted_text( snow_str, color,
                                                                        text_alignment::left ) );
                        }

                        if( g->display_overlay_state( ACTION_DISPLAY_VISIBILITY ) &&
                            g->displaying_visibility_creature && !invisible[0] ) {
                            const bool visibility = g->displaying_visibility_creature->sees( here, pos );

                            // color overlay.
                            SDL_Color block_color = visibility ? windowsPalette[catacurses::green] :
                                                    SDL_Color{ 192, 192, 192, 255 };
                            block_color.a = 100;
                            here.color_blocks_cache.first = SDL_BLENDMODE_BLEND;
                            here.color_blocks_cache.second.emplace( player_to_screen( point_bub_ms( x, y ) ), block_color );

                            // overlay string
                            std::string visibility_str = visibility ? "+" : "-";
                            here.overlay_strings_cache.emplace( player_to_screen( point_bub_ms( x, y ) ) + quarter_tile,
                                                                formatted_text( visibility_str, catacurses::black,
                                                                        direction::NORTH ) );
                        }

                        static std::vector<SDL_Color> lighting_colors;
                        // color hue in the range of [0..10], 0 being white,  10 being blue
                        auto draw_debug_tile = [&]( const int color_hue, const std::string & text ) {
                            if( lighting_colors.empty() ) {
                                SDL_Color white = { 255, 255, 255, 255 };
                                SDL_Color blue = { 0, 0, 255, 255 };
                                lighting_colors = color_linear_interpolate( white, blue, 9 );
                            }
                            point tile_pos = player_to_screen( point_bub_ms( x, y ) );

                            // color overlay
                            SDL_Color color = lighting_colors[std::min( std::max( 0, color_hue ), 10 )];
                            color.a = 100;
                            here.color_blocks_cache.first = SDL_BLENDMODE_BLEND;
                            here.color_blocks_cache.second.emplace( tile_pos, color );

                            // string overlay
                            here.overlay_strings_cache.emplace(
                                tile_pos + quarter_tile,
                                formatted_text( text, catacurses::black, direction::NORTH ) );
                        };

                        if( g->display_overlay_state( ACTION_DISPLAY_LIGHTING ) ) {
                            if( g->displaying_lighting_condition == 0 ) {
                                const float light = here.ambient_light_at( {x, y, center.z()} );
                                // note: lighting will be constrained in the [1.0, 11.0] range.
                                int intensity =
                                    static_cast<int>( std::max( 1.0, LIGHT_AMBIENT_LIT - light + 1.0 ) ) - 1;
                                draw_debug_tile( intensity, string_format( "%.1f", light ) );
                            }
                        }

                        if( g->display_overlay_state( ACTION_DISPLAY_TRANSPARENCY ) ) {
                            const float tr = here.light_transparency( tripoint_bub_ms{x, y, center.z()} );
                            int intensity =  tr <= LIGHT_TRANSPARENCY_SOLID ? 10 :  static_cast<int>
                                             ( ( tr - LIGHT_TRANSPARENCY_OPEN_AIR ) * 8 );
                            draw_debug_tile( intensity, string_format( "%.2f", tr ) );
                        }
                    }

                    if( !invisible[0] ) {
                        const visibility_type vis_type = here.get_visibility( ll, cache );
                        if( would_apply_vision_effects( vis_type ) ) {
                            const Creature *critter = creatures.creature_at( pos, true );
                            if( has_draw_override( pos ) || you.has_memory_at( pos_global ) ||
                                ( critter &&
                                  ( critter->has_flag( mon_flag_ALWAYS_VISIBLE )
                                    || you.sees_with_specials( *critter ) ) ) ) {
                                invisible[0] = true;
                            } else {
                                here.draw_points_cache.tiles[zlevel][row].emplace_back( tile_render_info::tile_view_data{ pos },
                                        tile_render_info::tile_render_scratch{},
                                        tile_render_info::vision_effect{ vis_type } );
                                break;
                            }
                        }
                    }
                    for( int i = 0; i < 4; i++ ) {
                        const tripoint_bub_ms np = pos + neighborhood[i];
                        invisible[1 + i] = apply_visible( np, ch2, here );
                    }

                    tile_render_info::sprite sprite_var{ ll, invisible };
                    // Capture static-layer semantic content here, in the
                    // dirty-gated draw-cache rebuild, mirroring each draw_*
                    // layer function's normal (visible, non-override) branch.
                    // The static-layer draw functions read these captured copies
                    // in their normal visible branch instead of reading the map
                    // live every frame. Override/memory branches are not
                    // captured and stay on the live path: overrides are only
                    // populated transiently by explosion/construction/editmap
                    // previews, and the memory branch is the invisible path,
                    // both left for later work.
                    if( !invisible[0] ) {
                        // Terrain
                        const ter_id &cap_t = here.ter( pos );
                        if( cap_t ) {
                            int cap_subtile = 0;
                            int cap_rotation = 0;
                            const std::bitset<NUM_TERCONN> &connect_group = cap_t.obj().connect_to_groups;
                            const std::bitset<NUM_TERCONN> &rotate_group = cap_t.obj().rotate_to_groups;
                            if( connect_group.any() ) {
                                map::get_connect_values( pos, cap_subtile, cap_rotation, connect_group,
                                                         rotate_group, {} );
                            } else {
                                map::get_terrain_orientation( pos, cap_rotation, cap_subtile, {}, invisible,
                                                              rotate_group );
                            }
                            sprite_var.set_ter_content( cap_t, cap_subtile, cap_rotation );
                        }
                        // Furniture
                        const furn_id &cap_f = here.furn( pos );
                        if( cap_f ) {
                            const std::array<int, 4> fn = {
                                static_cast<int>( here.furn( pos + point::south ) ),
                                static_cast<int>( here.furn( pos + point::east ) ),
                                static_cast<int>( here.furn( pos + point::west ) ),
                                static_cast<int>( here.furn( pos + point::north ) )
                            };
                            int cap_subtile = 0;
                            int cap_rotation = 0;
                            const std::bitset<NUM_TERCONN> &connect_group = cap_f.obj().connect_to_groups;
                            const std::bitset<NUM_TERCONN> &rotate_group = cap_f.obj().rotate_to_groups;
                            if( connect_group.any() ) {
                                map::get_furn_connect_values( pos, cap_subtile, cap_rotation, connect_group,
                                                              rotate_group, {} );
                            } else {
                                map::get_tile_values_with_ter( pos, cap_f.to_i(), fn, cap_subtile, cap_rotation,
                                                               rotate_group );
                            }
                            sprite_var.set_furn_content( cap_f, cap_subtile, cap_rotation );
                        }
                        // Trap (only when the avatar can actually see it, matching draw_trap)
                        const trap &cap_tr = here.tr_at( pos );
                        if( !cap_tr.is_null() && cap_tr.can_see( pos, you ) ) {
                            const std::array<int, 4> tn = {
                                static_cast<int>( here.tr_at( pos + point::south ).loadid ),
                                static_cast<int>( here.tr_at( pos + point::east ).loadid ),
                                static_cast<int>( here.tr_at( pos + point::west ).loadid ),
                                static_cast<int>( here.tr_at( pos + point::north ).loadid )
                            };
                            int cap_subtile = 0;
                            int cap_rotation = 0;
                            map::get_tile_values( cap_tr.loadid.to_i(), tn, cap_subtile, cap_rotation, 0 );
                            sprite_var.set_trap_content( cap_tr.loadid, cap_subtile, cap_rotation );
                        }
                        // Partial construction (no orientation; presence only)
                        sprite_var.part_con_content = here.partial_con_at( pos ) != nullptr;
                        // Graffiti (rotation depends only on passability; text is
                        // the semantic content). Always recorded for visible tiles
                        // so the check can also catch a stale "appeared" graffiti.
                        if( here.has_graffiti_at( pos ) ) {
                            sprite_var.set_graffiti_content( here.graffiti_at( pos ),
                                                             here.passable( pos ) ? 1 : 0 );
                        } else {
                            sprite_var.set_graffiti_content( std::string{}, 0 );
                        }
                    }

                    here.draw_points_cache.tiles[zlevel][row].emplace_back( tile_render_info::tile_view_data{ pos },
                            tile_render_info::tile_render_scratch{},
                            sprite_var );
                    // Stop building draw points below when floor reached
                    if( here.dont_draw_lower_floor( pos ) ) {
                        break;
                    }
                }
            }
        }
    }
    overlay_strings = here.overlay_strings_cache;
    color_blocks = here.color_blocks_cache;

    // Precompute creature positions once per draw so the critter layers can skip
    // the per-tile creature_at hash lookup (there are usually a handful of creatures
    // versus thousands of visible tiles). Consumed by draw_critter_at (early-out on
    // empty tiles) and draw_critter_above (skip the upward flying-shadow scan when
    // nothing is above). Matches creature_at's sources: monsters (incl.
    // hallucinations), npcs, and the avatar.
    m_creature_positions.clear();
    m_creature_columns.clear();
    for( Creature &cr : g->all_creatures() ) {
        const tripoint_bub_ms cpos = cr.pos_bub();
        m_creature_positions.insert( cpos );
        m_creature_columns.insert( cpos.xy() );
    }

    // Refresh dynamic field, item, and vehicle-part content every frame.
    // These values can change after the dirty-gated static snapshot was built,
    // so they still need live queries.  Keep them in one traversal of the draw
    // point cache: animation frames previously walked the same z/row/tile
    // structure three times before starting the layer loop.
    {
        CATA_PROFILE_SCOPE_NAMED( "tiles.dynamic_cache_refresh" );
        map &here = get_map();
        auto &vp_ov = vpart_override;
        for( int zlevel = center.z(); zlevel >= draw_min_z; zlevel-- ) {
            for( int row = min_row; row < max_row; row++ ) {
                for( tile_render_info &tri : here.draw_points_cache.tiles[zlevel][row] ) {
                    tile_render_info::sprite *const var =
                        std::get_if<tile_render_info::sprite>( &tri.var );
                    if( !var ) {
                        continue;
                    }

                    if( !var->invisible[0] ) {
                        const field &f = here.field_at( tri.view.pos );
                        const field_type_id disp_fld = f.displayed_field_type();
                        if( disp_fld ) {
                            var->set_field_content( disp_fld,
                                                    f.displayed_intensity() );
                        } else {
                            var->set_field_content( fd_null, 0 );
                        }

                        if( here.sees_some_items( tri.view.pos,
                                                  get_player_character() ) ) {
                            const maptile &tile = here.maptile_at( tri.view.pos );
                            const int count = static_cast<int>( tile.get_item_count() );
                            if( count > 0 ) {
                                const item &itm = tile.get_uppermost_item();
                                const mtype *const mon = itm.get_mtype();
                                var->set_item_content(
                                    itm.typeId(),
                                    mon ? mon->id : mtype_id::NULL_ID(),
                                    itm.has_itype_variant()
                                    ? itm.itype_variant().id : std::string{},
                                    count, true );
                            } else {
                                var->set_item_content( itype_id::NULL_ID(),
                                                       mtype_id::NULL_ID(), std::string{},
                                                       count, true );
                            }
                        } else {
                            var->set_item_content( itype_id::NULL_ID(),
                                                   mtype_id::NULL_ID(), std::string{},
                                                   0, false );
                        }
                    }

                    // Vehicle content has three cases in priority order:
                    // override, a visible live part, or an invisible memorized part.
                    const auto ov = vp_ov.find( tri.view.pos );
                    if( ov != vp_ov.end() && std::get<0>( ov->second ) ) {
                        const char part_mod = std::get<1>( ov->second );
                        var->set_vpart_content(
                            std::get<0>( ov->second ),
                            part_mod == 1 ? open_ :
                            part_mod == 2 ? broken : 0,
                            angle_to_dir4( std::get<2>( ov->second )
                                           - 270_degrees ),
                            std::string{},
                            std::string{},
                            std::get<3>( ov->second ) != 0,
                            std::nullopt );
                        continue;
                    }
                    if( !var->invisible[0] ) {
                        // Normal: read live vehicle data.
                        const optional_vpart_position ovp =
                            here.veh_at( tri.view.pos );
                        if( ovp ) {
                            const vehicle &veh = ovp->vehicle();
                            const vpart_display vd =
                                veh.get_display_of_tile(
                                    ovp->mount_pos() );
                            if( !vd.id.is_null() ) {
                                const int subtile =
                                    vd.is_open ? open_ :
                                    vd.is_broken ? broken : 0;
                                var->set_vpart_content(
                                    vd.id, subtile,
                                    angle_to_dir4( veh.face.dir()
                                                   - 270_degrees ),
                                    vd.variant.id,
                                    vd.carried_furn,
                                    vd.has_cargo,
                                    get_vpart_tint( veh,
                                                    ovp->mount_pos() ) );
                                continue;
                            }
                        }
                    } else {
                        // Memory: invisible tile.
                        const memorized_tile &t =
                            get_vpart_memory_at(
                                here.get_abs( tri.view.pos ) );
                        std::string_view tid = t.get_dec_id();
                        if( !tid.empty() ) {
                            std::string_view tvar;
                            const size_t sep = tid.find(
                                                   vehicles::variant_separator );
                            if( sep != std::string::npos ) {
                                tvar = tid.substr( sep + 1 );
                                tid = tid.substr( 0, sep );
                            }
                            var->set_vpart_content(
                                vpart_id( std::string( tid ) ),
                                t.get_dec_subtile(),
                                t.get_dec_rotation(),
                                std::string( tvar ),
                                std::string{},
                                false,
                                std::nullopt );
                            continue;
                        }
                    }
                    // No vehicle part on this tile
                    var->set_vpart_content(
                        vpart_id::NULL_ID(), 0, 0,
                        std::string{}, std::string{},
                        false, std::nullopt );
                }
            }
        }
    }

    {
        CATA_PROFILE_SCOPE_NAMED( "tiles.layer_loop" );

        // Build only the layers that can produce output this frame.  Zone marks
        // and revival indicators are normally inactive; keeping them out of the
        // hot loop avoids a function call and lookup for every visible tile.
        using draw_layer = decltype( &cata_tiles::draw_furniture );
        std::array<draw_layer, 11> drawing_layers;
        std::size_t drawing_layer_count = 0;
        const auto add_layer = [&]( const draw_layer layer ) {
            drawing_layers[drawing_layer_count++] = layer;
        };
        add_layer( &cata_tiles::draw_terrain );
        add_layer( &cata_tiles::draw_furniture );
        add_layer( &cata_tiles::draw_graffiti );
        add_layer( &cata_tiles::draw_trap );
        add_layer( &cata_tiles::draw_part_con );
        add_layer( &cata_tiles::draw_field_or_item );
        add_layer( &cata_tiles::draw_vpart_no_roof );
        add_layer( &cata_tiles::draw_vpart_roof );
        add_layer( &cata_tiles::draw_critter_at );
        if( g->is_zones_manager_open() ) {
            add_layer( &cata_tiles::draw_zone_mark );
        }
        if( tileset_ptr->find_tile_type( ZOMBIE_REVIVAL_INDICATOR ) ) {
            add_layer( &cata_tiles::draw_zombie_revival_indicators );
        }

        // Skip drawing shadow of critters above if there is no shadow sprite
        bool do_draw_shadow = false;
        if( find_tile_looks_like( "shadow", TILE_CATEGORY::NONE, "" ) ) {
            do_draw_shadow = true;
        }

        // Multi z-level draw mode
        // Start drawing from the lowest visible z-level (some off-screen tiles
        // are considered visible here to simplify the logic.)
        // Collect gliding critters during the row loop; they are redrawn on top in a
        // deferred overlay pass below so terrain painted in later rows can't cover them.
        m_deferred_glide_critters.clear();
        m_collecting_glide_critters = !m_creature_anims.empty() || !m_creature_hit_anims.empty() ||
                                      !m_creature_attack_anims.empty();
        int cur_zlevel = std::max( center.z() - fov_3d_z_range, -OVERMAP_DEPTH );
        bool draw_aborted = false;
        struct tinted_tile_scratch {
            tile_render_info *tile = nullptr;
            sprite_screen_bounds bounds;
            small_literal_vector<tint_sprite_record, 4> sprites;
            SDL_Color color = { 0, 0, 0, 0 };
        };
        struct row_sprite_entry {
            tile_render_info *tile = nullptr;
            tinted_tile_scratch *tint = nullptr;
            unsigned sparse_layers = 0;
        };
        enum sparse_layer : unsigned {
            layer_graffiti = 1U << 0,
            layer_trap = 1U << 1,
            layer_part_con = 1U << 2,
            layer_field_item = 1U << 3,
            layer_vpart = 1U << 4,
            layer_critter = 1U << 5,
            layer_revival = 1U << 6
        };
        std::vector<row_sprite_entry> row_sprites;
        std::vector<tinted_tile_scratch> row_tinted;
        while( cur_zlevel <= center.z() && !draw_aborted ) {
            const half_open_rectangle<point> &cur_any_tile_range = is_isometric()
                ? z_any_tile_range[center.z() - cur_zlevel] : top_any_tile_range;
            // For each row
            const bool iso = is_isometric();
            const level_cache &zlev_cache = here.access_cache( cur_zlevel );
            // FIXME: colored light tint overlay disabled in isometric mode pending
            // a non-silhouette implementation. The hybrid mask path requires render
            // target switches that stall the GPU pipeline, and the simple diamond
            // path alone does not justify the per-sprite bounds tracking overhead
            // in the layer loop. Revisit when SDL_gpu or a shader-based tint path
            // is available.
            const bool zlev_has_color = zlev_cache.has_colored_lights && !iso;
            for( int row = cur_any_tile_range.p_min.y; row < cur_any_tile_range.p_max.y; row ++ ) {
                if( renderer_should_abort_frame() ) {
                    // Abort emitting tiles mid-draw. Post-loop bookkeeping still runs
                    // so map memory and overrides stay consistent; invalidation kept
                    // for the next frame.
                    draw_aborted = true;
                    break;
                }
                // --- Per-tile prepass ---
                // Initialize base height and decide which tiles need a colored light
                // tint overlay. We do this before the layer loop so that:
                //   (a) we can skip bounds/sprite tracking for tiles that won't be tinted,
                //   (b) the overlay pass later can iterate only tinted tiles.
                auto &row_points = here.draw_points_cache.tiles[cur_zlevel][row];
                row_sprites.clear();
                row_tinted.clear();
                if( row_sprites.capacity() < row_points.size() ) {
                    row_sprites.reserve( row_points.size() );
                }
                if( row_tinted.capacity() < row_points.size() ) {
                    // Keeps pointers stored in row_sprites stable while tinted
                    // sidecars are appended during this row's prepass.
                    row_tinted.reserve( row_points.size() );
                }
                for( tile_render_info &p : row_points ) {
                    p.scratch.height_3d = ( cur_zlevel - center.z() ) * zlevel_height;
                    tile_render_info::sprite *const var =
                        std::get_if<tile_render_info::sprite>( &p.var );
                    if( !var ) {
                        continue;
                    }
                    unsigned sparse_layers = 0;
                    if( !var->graffiti_content.empty() ||
                        ( !graffiti_override.empty() &&
                          graffiti_override.find( p.view.pos ) != graffiti_override.end() ) ) {
                        sparse_layers |= layer_graffiti;
                    }
                    // Invisible traps may still be drawn from map memory.  Any
                    // active trap override can also alter a neighboring tile's
                    // connectivity, so retain the full trap pass in that rare mode.
                    if( var->trap_content || var->invisible[0] || !trap_override.empty() ) {
                        sparse_layers |= layer_trap;
                    }
                    if( var->part_con_content ) {
                        sparse_layers |= layer_part_con;
                    }
                    if( var->field_content || ( var->sees_items && var->item_count > 0 ) ||
                        ( !field_override.empty() && field_override.find( p.view.pos ) != field_override.end() ) ||
                        ( !item_override.empty() && item_override.find( p.view.pos ) != item_override.end() ) ) {
                        sparse_layers |= layer_field_item;
                    }
                    if( !var->vpart_content.is_null() ||
                        ( !vpart_override.empty() && vpart_override.find( p.view.pos ) != vpart_override.end() ) ) {
                        sparse_layers |= layer_vpart;
                    }
                    if( m_creature_positions.find( p.view.pos ) != m_creature_positions.end() ||
                        ( do_draw_shadow && m_creature_columns.find( p.view.pos.xy() ) != m_creature_columns.end() ) ||
                        ( !monster_override.empty() && monster_override.find( p.view.pos ) != monster_override.end() ) ) {
                        sparse_layers |= layer_critter;
                    }
                    if( !var->invisible[0] && var->sees_items && var->item_count > 0 &&
                        ( item_override.empty() || item_override.find( p.view.pos ) == item_override.end() ) ) {
                        sparse_layers |= layer_revival;
                    }
                    row_sprites.push_back( { &p, nullptr, sparse_layers } );
                    // Only visible sprite tiles can receive a tint.
                    if( !zlev_has_color || var->ll == lit_level::DARK || var->ll == lit_level::BLANK ||
                        var->ll == lit_level::MEMORIZED ) {
                        continue;
                    }
                    const light_color_rgb &lc =
                        zlev_cache.light_color_cache[p.view.pos.x()][p.view.pos.y()];
                    if( !lc.is_colored() ) {
                        continue;
                    }
                    // Isolate the chromatic (saturated) component by subtracting
                    // the achromatic floor (min channel). Pure white light (equal
                    // RGB) produces zero saturation and no tint.
                    const float min_ch = std::min( { lc.r, lc.g, lc.b } );
                    const float sat_r = lc.r - min_ch;
                    const float sat_g = lc.g - min_ch;
                    const float sat_b = lc.b - min_ch;
                    const float sat_mag = std::max( { sat_r, sat_g, sat_b } );
                    if( sat_mag < 0.01f ) {
                        continue;
                    }
                    // Alpha: ratio of saturated energy to total scalar light.
                    // Effect is subtle under bright ambient, vivid in darkness.
                    const float scalar = zlev_cache.lm[p.view.pos.x()][p.view.pos.y()].max();
                    const float ratio = scalar > 0.1f ? std::min( 1.0f, sat_mag / scalar ) : 0.0f;
                    const Uint8 alpha = static_cast<Uint8>( ratio * 80.0f );
                    if( alpha == 0 ) {
                        continue;
                    }
                    // Normalize saturated color to full brightness for the SDL tint.
                    row_tinted.emplace_back();
                    tinted_tile_scratch &tint = row_tinted.back();
                    tint.tile = &p;
                    tint.color = {
                        static_cast<Uint8>( sat_r / sat_mag * 255.0f ),
                        static_cast<Uint8>( sat_g / sat_mag * 255.0f ),
                        static_cast<Uint8>( sat_b / sat_mag * 255.0f ),
                        alpha
                    };
                    row_sprites.back().tint = &tint;
                }
                // --- Layer loop ---
                // Draw all layers (terrain, furniture, items, creatures, etc.).
                // For ortho tinted tiles, we wire up m_cur_bounds and m_cur_tint_sprites
                // so that draw_sprite_at accumulates the screen extent and records
                // each sprite for later silhouette replay. Zone marks and revival
                // indicators are UI overlays that shouldn't affect tint bounds.
                for( std::size_t layer_index = 0; layer_index < drawing_layer_count; ++layer_index ) {
                    const draw_layer f = drawing_layers[layer_index];
                    const bool track_bounds = !iso &&
                                              f != &cata_tiles::draw_zone_mark &&
                                              f != &cata_tiles::draw_zombie_revival_indicators;
                    const auto draw_sprite = [&]( row_sprite_entry & entry,
                    const tile_render_info::sprite & var ) {
                        tile_render_info &p = *entry.tile;
                        const bool ortho_tint = track_bounds && entry.tint;
                        m_cur_bounds = ortho_tint ? &entry.tint->bounds : nullptr;
                        m_cur_tint_sprites = ortho_tint ? &entry.tint->sprites : nullptr;

                        // Get visibility variables
                        lit_level ll = var.ll;
                        std::array<bool, 5> invisible = var.invisible;

                        // Point the static-layer draw functions at this tile's
                        // cached draw point so their normal visible branch draws
                        // the terrain/furniture/trap/partial-construction/graffiti
                        // from the captured content instead of reading the map
                        // live. Mirrors the m_cur_bounds pattern: per-tile state
                        // handed to the layer functions without changing their
                        // shared signature.
                        m_cur_tile = &p;

                        if( f == &cata_tiles::draw_vpart_no_roof || f == &cata_tiles::draw_vpart_roof ) {
                            int temp_height_3d = p.scratch.height_3d;
                            // Reset height_3d to base when drawing vehicles
                            p.scratch.height_3d = ( cur_zlevel - center.z() ) * zlevel_height;
                            // Draw
                            if( !( this->*f )( p.view.pos, ll, p.scratch.height_3d, invisible ) ) {
                                // If no vpart drawn, revert height_3d changes
                                p.scratch.height_3d = temp_height_3d;
                            }
                        } else if( f == &cata_tiles::draw_critter_at ) {
                            // Draw
                            if( !( this->*f )( p.view.pos, ll, p.scratch.height_3d, invisible ) && do_draw_shadow &&
                                here.dont_draw_lower_floor( p.view.pos ) ) {
                                // Draw shadow of flying critters on bottom-most tile if no other critter drawn
                                draw_critter_above( p.view.pos, ll, p.scratch.height_3d, invisible );
                            }
                        } else {
                            // Draw
                            ( this->*f )( p.view.pos, ll, p.scratch.height_3d, invisible );
                        }
                    };

                    if( f == &cata_tiles::draw_terrain ) {
                        // Vision-effect entries only produce output in the terrain
                        // pass.  Process them once here, then keep the remaining
                        // layers on the compact row_sprites pointer list.
                        std::size_t sprite_index = 0;
                        for( tile_render_info &p : row_points ) {
                            if( const tile_render_info::vision_effect *const var =
                                    std::get_if<tile_render_info::vision_effect>( &p.var ) ) {
                                m_cur_bounds = nullptr;
                                m_cur_tint_sprites = nullptr;
                                apply_vision_effects( p.view.pos, var->vis, p.scratch.height_3d );
                            } else {
                                row_sprite_entry &entry = row_sprites[sprite_index++];
                                draw_sprite( entry, std::get<tile_render_info::sprite>( p.var ) );
                            }
                        }
                    } else {
                        for( row_sprite_entry &entry : row_sprites ) {
                            const unsigned candidates = entry.sparse_layers;
                            if( ( f == &cata_tiles::draw_graffiti && !( candidates & layer_graffiti ) ) ||
                                ( f == &cata_tiles::draw_trap && !( candidates & layer_trap ) ) ||
                                ( f == &cata_tiles::draw_part_con && !( candidates & layer_part_con ) ) ||
                                ( f == &cata_tiles::draw_field_or_item && !( candidates & layer_field_item ) ) ||
                                ( ( f == &cata_tiles::draw_vpart_no_roof || f == &cata_tiles::draw_vpart_roof ) &&
                                  !( candidates & layer_vpart ) ) ||
                                ( f == &cata_tiles::draw_critter_at && !( candidates & layer_critter ) ) ||
                                ( f == &cata_tiles::draw_zombie_revival_indicators &&
                                  !( candidates & layer_revival ) ) ) {
                                continue;
                            }
                            draw_sprite( entry,
                                         std::get<tile_render_info::sprite>( entry.tile->var ) );
                        }
                    }
                }
                m_cur_bounds = nullptr;
                m_cur_tint_sprites = nullptr;
                m_cur_tile = nullptr;

                // --- Colored light tint overlay ---
                // After all content layers are drawn, overlay a color tint on tiles
                // that have colored light (emergency beacons, colored fields,
                // dawn/dusk light, etc). Tint eligibility and color were precomputed
                // in the per-tile prepass above; row_tinted holds only eligible tiles.
                if( !row_tinted.empty() ) {
#if SDL_MAJOR_VERSION >= 3
                    // Sprite rendering can leave a variant shader bound across same-variant
                    // runs. The tint overlay is plain renderer geometry/copy work, so it must
                    // start from null GPU render state or SDL3 may apply the sprite shader to
                    // only part of a row depending on which sprite path was hit first.
                    if( cata_shader::variant_pass *vp = get_shared_variant_pass() ) {
                        if( !vp->flush() ) {
                            display_buffer_scope_signal_recovery_required();
                            throw std::runtime_error(
                                "cata_tiles::draw: variant_pass flush failed before tint overlay; renderer in undefined state" );
                        }
                    }
#endif
                    const int zlev_base = ( cur_zlevel - center.z() ) * zlevel_height;
                    if( iso ) {
                        // Iso: flat tint rect over the tile footprint (unchanged
                        // from the original tint overlay code).
                        SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_BLEND );
                        for( const tinted_tile_scratch &tint : row_tinted ) {
                            const tile_render_info *const tp = tint.tile;
                            const point screen = player_to_screen( tp->view.pos.xy() );
                            const SDL_Rect draw_rect = {
                                screen.x, screen.y - zlev_base, tile_width, tile_height
                            };
                            geometry->rect( renderer, draw_rect, tint.color );
                        }
                        SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_NONE );
                    } else {
                        // Ortho: hybrid tint overlay with two paths.
                        //
                        // "Simple" tiles whose sprites fit inside the tile footprint
                        // get a cheap colored rect (same as iso). "Complex" tiles
                        // with oversized sprites (tall 32x64 characters, multi-layer
                        // gear, etc) would show a color seam at the tile boundary or
                        // a rectangular halo around transparent padding. These use a
                        // per-pixel silhouette mask instead:
                        //
                        //   1. Switch render target to a scratch texture (tint_mask_tex).
                        //   2. Replay recorded sprites using their white silhouette
                        //      variants (RGB=255, original alpha). This builds a
                        //      combined alpha mask of the tile's visible pixels.
                        //   3. Switch back to the display buffer and composite the
                        //      mask with the tile's tint color/alpha.
                        //
                        // Complex tiles are batched: contiguous tiles with the same
                        // tint color share a single target switch + composite. A union
                        // area growth cap (2x sum of member areas) prevents degenerate
                        // batches when tiles are far apart in screen space.

                        std::vector<const tinted_tile_scratch *> batch_tiles;
                        SDL_Color batch_color = { 0, 0, 0, 0 };
                        SDL_Rect batch_union = { 0, 0, 0, 0 };
                        int64_t batch_sum_area = 0;
                        SDL_Rect saved_clip;
                        bool clip_saved = false;

                        // Flush the current complex-tile batch: render all accumulated
                        // silhouettes into the mask texture, then composite to screen.
                        auto flush_tint_batch = [&]() {
                            if( batch_tiles.empty() ) {
                                return;
                            }
                            ensure_tint_mask_texture( batch_union.w, batch_union.h );
                            if( !tint_mask_tex ) {
                                batch_tiles.clear();
                                batch_sum_area = 0;
                                return;
                            }

                            // Save display-buffer clip so Phase 2 can restore it.
                            if( !clip_saved ) {
                                RenderGetClipRect( renderer, &saved_clip );
                                clip_saved = true;
                            }

                            // Phase 1: build the silhouette mask.
                            {
                                scoped_render_target mask_scope( renderer, tint_mask_tex.get()
#if SDL_MAJOR_VERSION >= 3
                                                                 , get_shared_variant_pass()
#endif
                                                               );
                                if( !mask_scope.is_valid() ) {
                                    // variant_pass may have failed to unbind; later
                                    // target switches would cross with shader bound.
                                    batch_tiles.clear();
                                    batch_sum_area = 0;
                                    if( !mask_scope.boundary_intact() ) {
                                        // Boundary lost: latch so the enclosing dtor skips detach.
                                        display_buffer_scope_signal_recovery_required();
                                    }
                                    throw std::runtime_error( mask_scope.boundary_intact()
                                                              ? "cata_tiles::flush_tint_batch: variant_pass refused boundary"
                                                              : "cata_tiles::flush_tint_batch: scoped_render_target boundary lost" );
                                }
                                // Clip is per-target; clear defensively for reused mask.
                                RenderSetClipRect( renderer, nullptr );
                                SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_NONE );
                                SetRenderDrawColor( renderer, 0, 0, 0, 0 );
                                const SDL_Rect clear_rect = { 0, 0, batch_union.w, batch_union.h };
                                RenderFillRect( renderer, &clear_rect );

                                for( const tinted_tile_scratch *bp : batch_tiles ) {
                                    for( const tint_sprite_record &rec : bp->sprites ) {
                                        const texture *sil = tileset_ptr->get_silhouette_tile( rec.sprite_index );
                                        if( !sil ) {
                                            continue;
                                        }
                                        // Translate to mask-local coordinates.
                                        SDL_Rect mask_dest = {
                                            rec.destination.x - batch_union.x,
                                            rec.destination.y - batch_union.y,
                                            rec.destination.w,
                                            rec.destination.h
                                        };
                                        sil->render_copy_ex( renderer, &mask_dest, rec.angle, nullptr,
                                                             static_cast<CataFlipMode>( rec.flip ) );
                                    }
                                }
                                // Explicit restore before phase 2 so a failure
                                // aborts compositing instead of leaving the draw
                                // landing in the mask.
                                if( !mask_scope.restore() ) {
                                    batch_tiles.clear();
                                    batch_sum_area = 0;
                                    if( !mask_scope.boundary_intact() ) {
                                        display_buffer_scope_signal_recovery_required();
                                    }
                                    throw std::runtime_error( mask_scope.boundary_intact()
                                                              ? "cata_tiles::flush_tint_batch: variant_pass refused boundary on restore"
                                                              : "cata_tiles::flush_tint_batch: failed to restore display_buffer render target" );
                                }
                            }

                            // Phase 2: composite the mask to the display buffer.
                            RenderSetClipRect( renderer, &saved_clip );

                            const SDL_Rect comp_src = { 0, 0, batch_union.w, batch_union.h };
                            SetTextureColorMod( tint_mask_tex, batch_color.r,
                                                batch_color.g, batch_color.b );
                            SetTextureAlphaMod( tint_mask_tex, batch_color.a );
                            RenderCopy( renderer, tint_mask_tex, &comp_src, &batch_union );
                            SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_BLEND );

                            batch_tiles.clear();
                            batch_sum_area = 0;
                        };

                        SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_BLEND );
                        for( const tinted_tile_scratch &tint : row_tinted ) {
                            const tile_render_info *const tp = tint.tile;
                            const point screen = player_to_screen( tp->view.pos.xy() );
                            const SDL_Rect tile_rect = {
                                screen.x, screen.y - zlev_base, tile_width, tile_height
                            };

                            // Simple: all recorded sprites fit inside the tile rect,
                            // so a flat colored rect matches the sprite extent exactly.
                            // On the SDL3 gpu/D3D12 backend, ALSO force the simple path:
                            // the complex silhouette-mask path switches render target
                            // mid-frame (scoped_render_target), whose command-queue flush
                            // SIGSEGVs in D3D12_PushFragmentUniformData. The flat rect
                            // tint is a minor visual downgrade for oversized sprites
                            // (boxy glow instead of outline-hugging) but avoids the crash;
                            // other backends keep the precise silhouette mask.
                            const bool simple = gpu_d3d12_mode ||
                                                !tint.bounds.valid ||
                                                tint.sprites.empty() ||
                                                ( tint.bounds.x >= tile_rect.x &&
                                                  tint.bounds.y >= tile_rect.y &&
                                                  tint.bounds.x + tint.bounds.w <= tile_rect.x + tile_rect.w &&
                                                  tint.bounds.y + tint.bounds.h <= tile_rect.y + tile_rect.h );
                            if( simple ) {
                                // Must flush any pending complex batch before drawing
                                // a simple tile to preserve correct draw order.
                                flush_tint_batch();
                                const SDL_Color tc = tint.color;
#if SDL_MAJOR_VERSION >= 3
                                // SDL3's straight-alpha draw-color modulation renders the fill
                                // dimmer than SDL2 for the same alpha. Composite as a premultiplied
                                // source to keep the additive look: out = tint*a + dst*(1-a).
                                // SDL_BLENDMODE_BLEND_PREMULTIPLIED is SDL3-only; the SDL2 geometry
                                // helper already produces the expected intensity.
                                const Uint8 a = tc.a;
                                SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_BLEND_PREMULTIPLIED );
                                SetRenderDrawColor( renderer,
                                                    static_cast<Uint8>( tc.r * a / 255 ),
                                                    static_cast<Uint8>( tc.g * a / 255 ),
                                                    static_cast<Uint8>( tc.b * a / 255 ),
                                                    a );
                                RenderFillRect( renderer, &tile_rect );
#else
                                geometry->rect( renderer, tile_rect, tc );
#endif
                                continue;
                            }

                            // Complex: sprites extend beyond the tile footprint.
                            // Accumulate into the current batch or start a new one.

                            // Color change forces a new batch.
                            const SDL_Color tile_tc = tint.color;
                            if( batch_tiles.empty() ||
                                std::memcmp( &batch_color, &tile_tc, sizeof( SDL_Color ) ) != 0 ) {
                                flush_tint_batch();
                                batch_color = tile_tc;
                            }
                            // Area growth cap: if the union bounding box would exceed
                            // 2x the summed area of its members, the batch has too
                            // much empty space and the mask texture is wastefully large.
                            if( !batch_tiles.empty() ) {
                                // NOLINTNEXTLINE(cata-combine-locals-into-point)
                                const int new_x = std::min( batch_union.x,
                                                            tint.bounds.x );
                                const int new_y = std::min( batch_union.y, tint.bounds.y );
                                const int new_r = std::max( batch_union.x + batch_union.w,
                                                            tint.bounds.x + tint.bounds.w );
                                const int new_b = std::max( batch_union.y + batch_union.h,
                                                            tint.bounds.y + tint.bounds.h );
                                const int64_t union_area = static_cast<int64_t>( new_r - new_x ) *
                                                           ( new_b - new_y );
                                const int64_t sum_area = batch_sum_area +
                                                         static_cast<int64_t>( tint.bounds.w ) * tint.bounds.h;
                                if( union_area > sum_area * 2 ) {
                                    flush_tint_batch();
                                    batch_color = tile_tc;
                                }
                            }
                            // Grow the batch union rect to include this tile.
                            if( batch_tiles.empty() ) {
                                batch_union = {
                                    tint.bounds.x, tint.bounds.y,
                                    tint.bounds.w, tint.bounds.h
                                };
                                batch_sum_area = static_cast<int64_t>( tint.bounds.w ) * tint.bounds.h;
                            } else {
                                const int nx = std::min( batch_union.x, tint.bounds.x );
                                const int ny = std::min( batch_union.y, tint.bounds.y );
                                const int nr = std::max( batch_union.x + batch_union.w,
                                                         tint.bounds.x + tint.bounds.w );
                                const int nb = std::max( batch_union.y + batch_union.h,
                                                         tint.bounds.y + tint.bounds.h );
                                batch_union = { nx, ny, nr - nx, nb - ny };
                                batch_sum_area += static_cast<int64_t>( tint.bounds.w ) * tint.bounds.h;
                            }
                            batch_tiles.push_back( &tint );
                        }
                        flush_tint_batch();
                        SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_NONE );
                    }
                }
            }
            // --- Per-z-level deferred critter flush ---
            // A small subset of animating critters defer to here: only those whose
            // sprite is pushed DOWN/south this frame (see draw_critter_at), because the
            // southern row that would overdraw them is painted later. Redraw them on top
            // of this z-level's terrain, but BEFORE the next z-level paints its
            // fog/shadow overlay (flushing once after the whole z-loop would let a
            // lower-level animation punch through the inter-z shadow layer). Pure
            // east/west glides and upward motion are NOT deferred — they draw in place
            // during the row loop and keep natural painter occlusion (tall terrain and
            // creatures to the south correctly cover them). All entries collected during
            // this level's row loop belong to this level, so this drains them.
            if( m_collecting_glide_critters && !m_deferred_glide_critters.empty() ) {
                m_collecting_glide_critters = false;
                for( deferred_glide_critter &c : m_deferred_glide_critters ) {
                    draw_critter_at( c.pos, c.ll, c.height_3d, c.invisible );
                }
                m_deferred_glide_critters.clear();
                m_collecting_glide_critters = true;
            }
            cur_zlevel += 1;
        }
        m_collecting_glide_critters = false;
        m_deferred_glide_critters.clear();
    }

    // display number of monsters to spawn in mapgen preview
    for( int row = top_any_tile_range.p_min.y; row < top_any_tile_range.p_max.y; row ++ ) {
        for( const tile_render_info &p : here.draw_points_cache.tiles[center.z()][row] ) {
            const tile_render_info::sprite *const
            var = std::get_if<tile_render_info::sprite>( &p.var );
            if( !var ) {
                continue;
            }
            const auto mon_override = monster_override.find( p.view.pos );
            if( mon_override != monster_override.end() ) {
                const int count = std::get<1>( mon_override->second );
                const bool more = std::get<2>( mon_override->second );
                if( count > 1 || more ) {
                    std::string text = "x" + std::to_string( count );
                    if( more ) {
                        text += "+";
                    }
                    overlay_strings.emplace( player_to_screen( p.view.pos.xy() ) + half_tile,
                                             formatted_text( text, catacurses::red,
                                                     direction::NORTH ) );
                }
            }
        }
    }
    // tile overrides are already drawn in the previous code
    void_radiation_override();
    void_terrain_override();
    void_furniture_override();
    void_graffiti_override();
    void_trap_override();
    void_field_override();
    void_item_override();
    void_vpart_override();
    void_monster_override();

    // Map memory is no longer written here: the sim-side map::update_map_memory
    // pass (run in do_turn) is now the sole writer, so the tiles draw path is
    // pure-read.

    in_animation = do_draw_explosion || do_draw_custom_explosion ||
                   has_explosion_light_anim() ||
                   has_bullet_anim() ||
                   do_draw_bullet || do_draw_hit || do_draw_line ||
                   do_draw_cursor || do_draw_highlight || do_draw_weather ||
                   do_draw_sct || do_draw_zones || do_draw_async_anim ||
                   has_sct() || has_highlight();

    draw_footsteps_frame( center );
    if( in_animation ) {
        if( do_draw_explosion ) {
            draw_explosion_frame();
        }
        if( do_draw_custom_explosion ) {
            draw_custom_explosion_frame();
        }
        if( has_explosion_light_anim() ) {
            draw_explosion_light_frame( center.z() );
        }
        if( do_draw_bullet ) {
            draw_bullet_frame();
        }
        if( has_bullet_anim() ) {
            draw_bullet_anim_frame( center.z() );
        }
        if( do_draw_hit ) {
            void_hit();
            if( do_draw_hit ) {
                draw_hit_frame();
            }
        }
        if( do_draw_line ) {
            draw_line();
            void_line();
        }
        if( do_draw_weather ) {
            draw_weather_frame();
            void_weather();
        }
        if( do_draw_sct ) {
            draw_sct_frame( overlay_strings );
            void_sct();
        }
        if( has_sct() ) {
            draw_sct_frame( center.z(), overlay_strings );
        }
        if( do_draw_zones ) {
            draw_zones_frame();
            void_zones();
        }
        if( do_draw_cursor ) {
            draw_cursor();
            void_cursor();
        }
        if( do_draw_highlight ) {
            draw_highlight();
            void_highlight();
        }
        if( has_highlight() ) {
            draw_highlights( center.z() );
        }
        if( do_draw_async_anim ) {
            draw_async_anim();
        }
    } else if( you.view_offset != tripoint_rel_ms::zero && !you.in_vehicle ) {
        // check to see if player is located at ter
        draw_from_id_string( "cursor", TILE_CATEGORY::NONE, empty_string,
                             tripoint_bub_ms( g->ter_view_p.xy(), center.z() ), 0, 0, lit_level::LIT,
                             false );
    }
    if( you.controlling_vehicle ) {
        std::optional<tripoint_rel_ms> indicator_offset = g->get_veh_dir_indicator_location( true );
        if( indicator_offset ) {
            draw_from_id_string( "cursor", TILE_CATEGORY::NONE, empty_string,
                                 tripoint_bub_ms( you.pos_bub().xy(), center.z() ) + indicator_offset->xy(),
                                 0, 0, lit_level::LIT, false );
        }
    }

    // Draw gamepad direction indicator
    if( gamepad::is_active() ) {
        gamepad::direction dir = gamepad::get_left_stick_direction();
        if( dir != gamepad::direction::NONE ) {
            tripoint offset = gamepad::direction_to_offset( dir );
            tripoint_bub_ms indicator_pos = you.pos_bub() + tripoint_rel_ms( offset.x, offset.y, 0 );
            draw_from_id_string( "cursor", TILE_CATEGORY::NONE, empty_string,
                                 tripoint_bub_ms( indicator_pos.xy(), center.z() ),
                                 0, 0, lit_level::LIT, false );
        }
    }

    RenderSetClipRect( renderer, nullptr );
#if SDL_MAJOR_VERSION >= 3
    // Unbind any GPU render state held across sprite batches so ImGui or the
    // next-frame draws see clean state. On flush failure the bind boundary
    // forbids a target switch: abort the unbind, latch recovery, and throw.
    if( cata_shader::variant_pass *vp = get_shared_variant_pass() ) {
        if( !vp->flush() ) {
            draw_scope.abort_unbind();
            display_buffer_scope_signal_recovery_required();
            throw std::runtime_error(
                "cata_tiles::draw: variant_pass flush failed at end of frame; renderer in undefined state" );
        }
    }
#endif
}

void cata_tiles::set_draw_cache_dirty()
{
    get_map().draw_points_cache_dirty = true;
}

void cata_tiles::draw_minimap( const point &dest, const tripoint_bub_ms &center, int width,
                               int height )
{
    minimap->set_type( is_isometric() ? pixel_minimap_type::iso : pixel_minimap_type::ortho );
    minimap->draw( SDL_Rect{ dest.x, dest.y, width, height }, center );
}

bool cata_tiles::has_blinking_minimap() const
{
    return minimap->has_blinking_beacons();
}

void cata_tiles::reset_minimap()
{
    minimap->reset();
}

void cata_tiles::reset_tint_mask()
{
    tint_mask_tex.reset();
    tint_mask_w = 0;
    tint_mask_h = 0;
}

point cata_tiles::get_window_base_tile_counts(
    const point &size, const point &tile_size, const bool iso )
{
    if( iso ) {
        //  |---sx---|
        //  w        |
        //  ~
        //         1\  }h
        //  /\/\/\/\2\ --
        //  \/\/\/\3\/  |
        //  /\/\/\/\4\  sy
        //  \/\/\/\5\/  |
        //  /\/\/\/\6\ --
        //
        // The rhombuses above represent the basic tiles excluding any extra
        // pixel that represents things in the z direction. `w = tile_width / 2`
        // is half basic tile width and `h = tile_width / 4` is half basic tile
        // height. `tile_height` is unrelated to and can be large than the basic
        // tile height `tile_width / 2`.
        //
        // There is no strict requirement about the exact position of pixels
        // in a sprite, except that the basic tiles should be able to densely
        // tile the screen area, and any extra pixels should only be used to
        // represent the z direction because they will be occluded by sprites in
        // the next row and occlude sprites in the previous row.
        //
        // Only the area from (0, 0) to (tile_width, tile_width / 2) is
        // considered when checking which tiles are on-screen, and the exact
        // position of pixels is disregarded. The numbers in the figure above
        // denote the first to the last drawn cells in the vertical direction.
        // Therefore, we can see that,
        //
        // cols = 1 + divide_round_up(sx, w)
        // rows = 1 + divide_round_up(sy, h)
        // ||
        // \/
        const int columns = divide_round_up( size.x * 2, tile_size.x ) + 1;
        const int rows = divide_round_up( size.y * 4, tile_size.x ) + 1;
        return point( columns, rows );
    } else {
        // Only the area from (0, 0) to (tile_width, tile_height) is considered
        // when checking which tiles are on-screen.
        const int columns = divide_round_up( size.x, tile_size.x );
        const int rows = divide_round_up( size.y, tile_size.y );
        return point( columns, rows );
    }
}

point cata_tiles::get_window_base_tile_counts( const point &size ) const
{
    return get_window_base_tile_counts(
           size, point( tile_width, tile_height ), is_isometric() );
}

half_open_rectangle<point> cata_tiles::get_window_any_tile_range(
    const point &size, const int z ) const
{
    // (following comments in get_window_base_tile_counts)
    //
    // Based on the maximum tile extent, these ensure that any tile that can be
    // possibly on screen is included in the range.
    if( is_isometric() ) {
    // z-level below => negative z_height => smaller row_beg and row_end
    const int z_height = zlevel_height * z;
    const int col_beg = divide_round_down( ( tile_width - max_tile_extent.p_max.x ) * 2,
                                           tile_width );
        const int col_end = divide_round_up( ( size.x - max_tile_extent.p_min.x ) * 2,
                                             tile_width ) + 1;
        const int row_beg = divide_round_down( ( z_height + tile_height
            - max_tile_extent.p_max.y ) * 4,
                                               tile_width );
        // The difference between the default sprite height `tile_height` and
        // base tile height `tile_width / 2` should be added to the tile extent
        // here. Because `player_to_screen` shifts the sprite up by this extra
        // height, it means this extra height should be subtracted from the
        // minimum extent.
        // (sy + zh - miny + th - tw / 2) / (tw / 4) + 1 =>
        const int row_end = divide_round_up( ( size.y + z_height
                                               - max_tile_extent.p_min.y + tile_height ) * 4,
                                             tile_width ) - 1;
        return { { col_beg, row_beg }, { col_end, row_end } };
    } else {
        const int col_beg = divide_round_down( tile_width - max_tile_extent.p_max.x, tile_width );
        const int col_end = divide_round_up( size.x - max_tile_extent.p_min.x, tile_width );
        const int row_beg = divide_round_down( tile_height - max_tile_extent.p_max.y, tile_height );
        const int row_end = divide_round_up( size.y - max_tile_extent.p_min.y, tile_height );
        return { { col_beg, row_beg }, { col_end, row_end } };
    }
}

half_open_rectangle<point> cata_tiles::get_window_full_base_tile_range( const point &size ) const
{
    if( is_isometric() ) {
    // (following comments in get_window_base_tile_counts)
    //
    // Only the area from (0, 0) to (tile_width, tile_width / 2) is
    // considered when checking which tiles are fully on-screen, and the
    // exact position of pixels is disregarded. In the figure above, as
    // opposed to 1-6, only 2-5 are fully shown on-screen. Therefore, we can
    // see that,
    //
    // cols = divide_round_down(sx, w) - 1
    // rows = divide_round_down(sy, h) - 1
    // ||
    // \/
    const int columns = divide_round_down( size.x * 2, tile_width ) - 1;
        const int rows = divide_round_down( size.y * 4, tile_width ) - 1;
        //NOLINTNEXTLINE(cata-use-named-point-constants): the name would be confusing here (screen 'NSWE' are not map NSWE)
        return { { 1, 1 }, { columns + 1, rows + 1 } };
    } else {
        // Only the area from (0, 0) to (tile_width, tile_height) is considered
        // when checking which tiles are fully on-screen.
        const int columns = divide_round_down( size.x, tile_width );
        const int rows = divide_round_down( size.y, tile_height );
        return { point::zero, { columns, rows } };
    }
}

std::optional<point_bub_ms> cata_tiles::tile_to_player(
    const point &colrow, const point_bub_ms &o, const point &base_tile_cnt,
    const bool iso )
{
    if( iso ) {
        // (following comments in get_window_base_tile_counts)
        //
        // Based on the screen tile pattern, the player position can be calculated
        // from the column and row numbers as follows
        if( modulo( colrow.y - base_tile_cnt.y / 2, 2 )
            != modulo( colrow.x - base_tile_cnt.x / 2, 2 ) ) {
            return std::nullopt;
        }
        return o + point_rel_ms {
            divide_round_down( colrow.x - colrow.y - base_tile_cnt.x / 2
            + base_tile_cnt.y / 2, 2 ),
            divide_round_down( colrow.y + colrow.x - base_tile_cnt.y / 2
            - base_tile_cnt.x / 2, 2 ),
        };
    } else {
        return point_rel_ms( colrow ) + o;
    }
}

std::optional<point> cata_tiles::tile_to_player( const point &colrow ) const
{
    std::optional<point_bub_ms> ret = tile_to_player(
                                          colrow, point_bub_ms( o ),
                                          point( screentile_width, screentile_height ), is_isometric() );
    if( ret.has_value() ) {
        return ret.value().raw();
    } else {
        return std::nullopt;
    }
}

point cata_tiles::player_to_tile( const point_bub_ms &pos ) const
{
    // (calculate the screen position according to cata_tiles::tile_to_player)
    if( is_isometric() ) {
    // (division rounded down):
    //
    // pos.x = ( col - row - sx / 2 + sy / 2 ) / 2 + o.x;
    // pos.y = ( row + col - sy / 2 - sx / 2 ) / 2 + o.y;
    // ( col - sx / 2 ) % 2 = ( row - sy / 2 ) % 2
    // ||
    // \/
    const int col = pos.y() + pos.x() + screentile_width / 2 - o.y - o.x;
        const int row = pos.y() - pos.x() + screentile_height / 2 - o.y + o.x;
        return { col, row };
    } else {
        return pos.raw() - o;
    }
}

// Map a 0..1 linear glide progress to the horizontal fraction travelled toward
// the destination (0 = old tile, 1 = new tile). May leave [0,1] to overshoot.
static float move_anim_eased( cata_tiles::move_anim_curve curve, float t )
{
    t = std::clamp( t, 0.0f, 1.0f );
    switch( curve ) {
        case cata_tiles::move_anim_curve::smooth:
        case cata_tiles::move_anim_curve::parabola:
            // smoothstep: ease in and out.
            return t * t * ( 3.0f - 2.0f * t );
        case cata_tiles::move_anim_curve::leap: {
            // easeInBack: a subtle backward anticipation, a long hang near the
            // origin, then a quick rush to the destination. A small overshoot
            // coefficient keeps the back-step slight (~1% of a tile) and elegant.
            constexpr float s = 0.6f;
            return t * t * ( ( s + 1.0f ) * t - s );
        }
    }
    return t;
}

// Vertical hop fraction (0 = on the ground, 1 = peak height) for the configured
// curve. Smooth has no hop.
static float move_anim_hop( cata_tiles::move_anim_curve curve, float t )
{
    t = std::clamp( t, 0.0f, 1.0f );
    switch( curve ) {
        case cata_tiles::move_anim_curve::smooth:
            return 0.0f;
        case cata_tiles::move_anim_curve::parabola:
            // Symmetric arc, peaking mid-glide.
            return 4.0f * t * ( 1.0f - t );
        case cata_tiles::move_anim_curve::leap: {
            // Physical jump: a fast launch that eases into the apex, a long hang
            // at the top, then a short gravity-accelerated fall that lands hard.
            constexpr float rise_end = 0.22f;
            constexpr float fall_start = 0.78f;
            if( t < rise_end ) {
                const float s = t / rise_end;
                // ease-out: quick launch, velocity settling to zero at the apex.
                return s * ( 2.0f - s );
            } else if( t < fall_start ) {
                return 1.0f;
            } else {
                const float s = ( t - fall_start ) / ( 1.0f - fall_start );
                // gravity: hangs a moment, then accelerates down for a snappy landing.
                return 1.0f - s * s;
            }
        }
    }
    return 0.0f;
}

// "Got hit" bounce height fraction (0 = on the ground, 1 = peak) over 0..1
// progress: a quick pop up that eases into the apex, then a gravity-accelerated
// fall that lands hard. Same design language as the leap move curve.
static float hit_anim_bounce( float t )
{
    t = std::clamp( t, 0.0f, 1.0f );
    constexpr float rise_end = 0.35f;
    if( t < rise_end ) {
        const float s = t / rise_end;
        // ease-out: fast launch settling to zero velocity at the apex.
        return s * ( 2.0f - s );
    } else {
        const float s = ( t - rise_end ) / ( 1.0f - rise_end );
        // gravity: accelerates downward for a snappy landing.
        return 1.0f - s * s;
    }
}

// Displacement fraction (0 = at rest, 1 = peak offset) for a "lunge out and back"
// motion over 0..1 progress, shared by the hit knockback and the attack lunge: a
// fast push out to the peak near the start, then an ease back to rest. Peaks at
// ~30% progress so the recoil reads as a sharp jab.
static float lunge_out_and_back( float t )
{
    t = std::clamp( t, 0.0f, 1.0f );
    constexpr float out_end = 0.3f;
    if( t < out_end ) {
        const float s = t / out_end;
        // ease-out push to the peak.
        return s * ( 2.0f - s );
    } else {
        const float s = ( t - out_end ) / ( 1.0f - out_end );
        // smoothstep ease back to rest.
        return 1.0f - s * s * ( 3.0f - 2.0f * s );
    }
}

effect_handle cata_tiles::start_creature_move_anim( const tripoint_abs_ms &from_abs,
        const tripoint_abs_ms &to_abs, bool is_player )
{
    if( !get_option<bool>( "CREATURE_MOVE_ANIM" ) ) {
        return 0;
    }
    // The avatar's glide is additionally gated on the separate player option.
    if( is_player && !get_option<bool>( "PLAYER_MOVE_ANIM" ) ) {
        return 0;
    }
    const tripoint_rel_ms d = from_abs - to_abs;
    // A no-op "move" to the same tile happens when game::update_map re-sets the
    // player's position after a real step (to re-express it post map-shift). Must
    // NOT erase the glide the real move just registered, or the player never
    // animates. Leave any in-flight animation untouched.
    if( d.x() == 0 && d.y() == 0 && d.z() == 0 ) {
        return 0;
    }
    // Snap z-changes and teleports (jumps further than one tile): drop any stale
    // animation at the destination so the sprite appears instantly.
    if( d.z() != 0 || std::abs( d.x() ) > 1 || std::abs( d.y() ) > 1 ) {
        m_creature_anims.erase( to_abs );
        return 0;
    }

    const float total_ms = std::max( 1, get_option<int>( "CREATURE_MOVE_ANIM_TIME" ) );

    creature_move_anim anim;
    anim.delta_tiles = point( d.x(), d.y() );
    anim.progress = 0.0f;
    anim.per_ms = 1.0f / total_ms;
    const std::string curve_opt = get_option<std::string>( "CREATURE_MOVE_ANIM_CURVE" );
    if( curve_opt == "parabola" ) {
        anim.curve = move_anim_curve::parabola;
    } else if( curve_opt == "leap" ) {
        anim.curve = move_anim_curve::leap;
    } else {
        anim.curve = move_anim_curve::smooth;
    }
    // New animation overwrites any prior one for this creature and plays from 0.
    // If a glide was already in flight to this tile, drop its stale handle.
    if( auto old = m_creature_anims.find( to_abs ); old != m_creature_anims.end() ) {
        m_handle_index.erase( old->second.handle );
    }
    m_creature_anims[to_abs] = anim;
    const effect_handle h = alloc_handle( effect_kind::creature_move );
    m_creature_anims[to_abs].handle = h;
    return h;
}

void cata_tiles::advance_creature_move_anims()
{
    if( m_creature_anims.empty() && m_creature_hit_anims.empty() &&
        m_creature_attack_anims.empty() ) {
        m_creature_anim_last_ms.reset();
        return;
    }
    const int64_t now_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                               std::chrono::steady_clock::now().time_since_epoch() ).count();
    if( !m_creature_anim_last_ms ) {
        m_creature_anim_last_ms = now_ms;
        return;
    }
    const int64_t dt_raw = now_ms - *m_creature_anim_last_ms;
    m_creature_anim_last_ms = now_ms;
    if( dt_raw <= 0 ) {
        return;
    }
    // Clamp the step. Between registering an animation (progress 0) and the next
    // draw that actually shows it, an unbounded amount of wall-clock can elapse:
    // the rest of the turn is processed (monsters act, the map may shift and hit
    // disk) before control returns to the idle redraw loop. Advancing by that raw
    // gap would jump a freshly-started glide straight to its end, so the player
    // sees only the tail of the motion or nothing at all — the "doesn't trigger
    // reliably" symptom. Capping each step to ~one frame at the floor framerate
    // (15 FPS -> ~66ms) makes the glide start from near its beginning regardless
    // of how long the turn took, at the cost of the animation running slightly
    // longer in real time after a heavy turn (imperceptible, and self-corrects).
    constexpr int64_t max_step_ms = 1000 / 15;
    const int64_t dt = std::min( dt_raw, max_step_ms );
    map &here = get_map();
    for( auto it = m_creature_anims.begin(); it != m_creature_anims.end(); ) {
        it->second.progress += it->second.per_ms * static_cast<float>( dt );
        bool erase_this = it->second.progress >= 1.0f;
        if( !erase_this && !here.inbounds( here.get_bub( it->first ) ) ) {
            erase_this = true;
        }
        if( erase_this ) {
            m_handle_index.erase( it->second.handle );
            it = m_creature_anims.erase( it );
        } else {
            ++it;
        }
    }
    for( auto it = m_creature_hit_anims.begin(); it != m_creature_hit_anims.end(); ) {
        it->second.progress += it->second.per_ms * static_cast<float>( dt );
        bool erase_this = it->second.progress >= 1.0f;
        if( !erase_this && !here.inbounds( here.get_bub( it->first ) ) ) {
            erase_this = true;
        }
        if( erase_this ) {
            m_handle_index.erase( it->second.handle );
            it = m_creature_hit_anims.erase( it );
        } else {
            ++it;
        }
    }
    for( auto it = m_creature_attack_anims.begin(); it != m_creature_attack_anims.end(); ) {
        it->second.progress += it->second.per_ms * static_cast<float>( dt );
        bool erase_this = it->second.progress >= 1.0f;
        if( !erase_this && !here.inbounds( here.get_bub( it->first ) ) ) {
            erase_this = true;
        }
        if( erase_this ) {
            m_handle_index.erase( it->second.handle );
            it = m_creature_attack_anims.erase( it );
        } else {
            ++it;
        }
    }
}

effect_handle cata_tiles::start_creature_hit_anim( const tripoint_abs_ms &pos_abs,
        float damage_fraction,
        const point &dir_tiles, bool is_player )
{
    if( !get_option<bool>( "CREATURE_HIT_ANIM" ) ) {
        return 0;
    }
    if( is_player && !get_option<bool>( "PLAYER_HIT_ANIM" ) ) {
        return 0;
    }
    const float total_ms = std::max( 1, get_option<int>( "CREATURE_HIT_ANIM_TIME" ) );
    creature_hit_anim anim;
    anim.progress = 0.0f;
    anim.per_ms = 1.0f / total_ms;
    // Scale reaction magnitude by damage: 0% -> 0.1 tile, 100% -> 0.5 tile.
    const float frac = std::clamp( damage_fraction, 0.0f, 1.0f );
    anim.magnitude_tiles = 0.1f + 0.4f * frac;
    // Use horizontal knockback only when the option asks for it AND we have a
    // direction; otherwise fall back to the vertical bounce.
    const bool want_knockback = get_option<std::string>( "CREATURE_HIT_ANIM_CURVE" ) == "knockback";
    if( want_knockback && ( dir_tiles.x != 0 || dir_tiles.y != 0 ) ) {
        anim.dir_tiles = dir_tiles;
    } else {
        anim.dir_tiles = point::zero;
    }
    // Restart from the top if the creature is hit again mid-reaction.
    // If a hit reaction was already playing, drop its stale handle first.
    if( auto old = m_creature_hit_anims.find( pos_abs ); old != m_creature_hit_anims.end() ) {
        m_handle_index.erase( old->second.handle );
    }
    m_creature_hit_anims[pos_abs] = anim;
    const effect_handle h = alloc_handle( effect_kind::creature_hit );
    m_creature_hit_anims[pos_abs].handle = h;
    return h;
}

effect_handle cata_tiles::start_creature_attack_anim( const tripoint_abs_ms &pos_abs,
        const point &dir_tiles, bool is_player )
{
    if( !get_option<bool>( "CREATURE_ATTACK_ANIM" ) ) {
        return 0;
    }
    if( is_player && !get_option<bool>( "PLAYER_ATTACK_ANIM" ) ) {
        return 0;
    }
    if( dir_tiles.x == 0 && dir_tiles.y == 0 ) {
        return 0;
    }
    const float total_ms = std::max( 1, get_option<int>( "CREATURE_ATTACK_ANIM_TIME" ) );
    creature_attack_anim anim;
    anim.progress = 0.0f;
    anim.per_ms = 1.0f / total_ms;
    anim.dist_tiles = 0.5f;
    anim.dir_tiles = dir_tiles;
    // If an attack lunge was already playing, drop its stale handle first.
    if( auto old = m_creature_attack_anims.find( pos_abs ); old != m_creature_attack_anims.end() ) {
        m_handle_index.erase( old->second.handle );
    }
    m_creature_attack_anims[pos_abs] = anim;
    const effect_handle h = alloc_handle( effect_kind::creature_attack );
    m_creature_attack_anims[pos_abs].handle = h;
    return h;
}

point cata_tiles::player_to_screen( const point_bub_ms &pos ) const
{
    const point colrow = player_to_tile( pos );
    if( is_isometric() ) {
        // To ensure the first fully drawn basic tile (col or row = 1, according
        // to the definition in get_window_full_base_tile_range) starts at 0,
        return m_entity_draw_offset + op + point{
            // left = ( col - 1 ) * ( tw / 2.0 ) =>
            divide_round_down( ( colrow.x - 1 ) * tile_width, 2 ),
            // top = ( row - 1 ) * ( tw / 4.0 ) - th + tw / 2.0 =>
            // (shifted so that sprites with default height end at the basic height
            // of `tile_width / 4`)
            divide_round_down( ( colrow.y + 1 ) * tile_width, 4 ) - tile_height,
        };
    } else {
        return m_entity_draw_offset + op + point{ colrow.x * tile_width, colrow.y * tile_height };
    }
}

void cata_tiles::ensure_tint_mask_texture( const int w, const int h )
{
    // Reuse the existing texture if it's large enough; only reallocate when
    // the requested size exceeds the current allocation.
    if( tint_mask_tex && tint_mask_w >= w && tint_mask_h >= h ) {
        return;
    }
    // Grow to at least the requested size, rounding up to avoid frequent
    // reallocation for slightly varying sprite sizes.
    const int alloc_w = std::max( w, tint_mask_w );
    const int alloc_h = std::max( h, tint_mask_h );
    tint_mask_tex = CreateTexture( renderer, SDL_PIXELFORMAT_ARGB8888,
                                   SDL_TEXTUREACCESS_TARGET, alloc_w, alloc_h );
    SetTextureBlendMode( tint_mask_tex, SDL_BLENDMODE_BLEND );
    tint_mask_w = alloc_w;
    tint_mask_h = alloc_h;
}

point_bub_ms cata_tiles::screen_to_player(
    const point &scr_pos, const point &tile_size,
    const point &win_size, const point_bub_ms &center,
    const bool iso )
{
    if( tile_size.x == 0 || tile_size.y == 0 ) {
        debugmsg( "tile_size is 0 in screen_to_player" );
        return center;
    }

    // `scr_pos` is the offset from the window origin
    const point base_tile = get_window_base_tile_counts( win_size, tile_size, iso );
    if( iso ) {
        // Unlike `player_to_screen`, not shifting vertically here because only
        // the base tile is considered.
        //
        // col = round_down( x / ( tw / 2.0 ) ) + 1 =>
        // row = round_down( y / ( tw / 4.0 ) ) + 1 =>
        const point colrow( divide_round_down( scr_pos.x * 2, tile_size.x ) + 1,
                            divide_round_down( scr_pos.y * 4, tile_size.x ) + 1 );
        const std::optional<point_bub_ms> player_1 = tile_to_player(
                colrow, center, base_tile, iso );
        const std::optional<point_bub_ms> player_2 = tile_to_player(
                //NOLINTNEXTLINE(cata-use-named-point-constants): the name would be confusing here (screen 'NSWE' are not map NSWE)
                colrow + point( 1, 0 ), center, base_tile, iso );
        // We do not know the precise shape of the base tile, assuming rhombuses.
        // TODO: maybe let tilesets provide the exact shape of the base tile.
        if( player_1.has_value() ) {
            // cell at `colrow` => |/|
            const point pos_in_cell = scr_pos - point(
                                          // relative to top-right of the cell:
                                          // dx = x - col * ( tw / 2.0 ) =>
                                          divide_round_down( colrow.x * tile_size.x, 2 ),
                                          // dy = y - ( row - 1 ) * ( tw / 4.0 ) =>
                                          divide_round_down( ( colrow.y - 1 ) * tile_size.x, 4 ) );
            if( pos_in_cell.y * 2 <= -pos_in_cell.x ) {
                // top-left of the cell, which is one tile north of player_1
                return player_1.value() + point_rel_ms( 0, -1 );
            } else {
                // lower-right of the cell, which is player_1
                return player_1.value();
            }
        } else {
            // cell at `colrow` => |\|
            const point pos_in_cell = scr_pos - point(
                                          // relative to top-left of the cell:
                                          // dx = x - ( col - 1 ) * ( tw / 2.0 ) =>
                                          divide_round_down( ( colrow.x - 1 ) * tile_size.x, 2 ),
                                          // dy = y - ( row - 1 ) * ( tw / 4.0 ) =>
                                          divide_round_down( ( colrow.y - 1 ) * tile_size.x, 4 ) );
            if( pos_in_cell.y * 2 <= pos_in_cell.x ) {
                // top-right of the cell, which is one tile north of player_2
                return player_2.value() + point_rel_ms( 0, -1 );
            } else {
                // lower-left of the cell, which is one tile northwest of player_2
                return player_2.value() + point_rel_ms( -1, -1 );
            }
        }
    } else {
        return tile_to_player( point( divide_round_down( scr_pos.x, tile_size.x ),
                                      divide_round_down( scr_pos.y, tile_size.y ) ),
                               // similar to the subtraction by `POSX`/`POSY` in cata_tiles::draw
                               center - point_rel_ms( win_size.x / tile_size.x / 2,
                                       win_size.y / tile_size.y / 2 ),
                               base_tile, iso ).value();
    }
}

bool cata_tiles::draw_from_id_string( const std::string &id, const tripoint_bub_ms &pos,
                                      int subtile,
                                      int rota,
                                      lit_level ll, bool apply_night_vision_goggles )
{
    int nullint = 0;
    return cata_tiles::draw_from_id_string( id, TILE_CATEGORY::NONE, empty_string, pos, subtile,
                                            rota, ll, apply_night_vision_goggles, nullint, 0 );
}

bool cata_tiles::draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                      const std::string &subcategory, const tripoint_bub_ms &pos,
                                      int subtile, int rota, lit_level ll,
                                      bool apply_night_vision_goggles )
{
    int nullint = 0;
    return cata_tiles::draw_from_id_string( id, category, subcategory, pos, subtile, rota,
                                            ll, apply_night_vision_goggles, nullint, 0 );
}

bool cata_tiles::draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                      const std::string &subcategory, const tripoint_bub_ms &pos,
                                      int subtile, int rota, lit_level ll,
                                      bool apply_night_vision_goggles, int &height_3d, int intensity )
{
    return cata_tiles::draw_from_id_string_internal( id, category, subcategory, pos, subtile, rota,
            ll, -1, apply_night_vision_goggles, height_3d, intensity, "", point() );
}

bool cata_tiles::draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                      const std::string &subcategory, const tripoint_bub_ms &pos,
                                      int subtile, int rota, lit_level ll,
                                      bool apply_night_vision_goggles, int &height_3d )
{
    return cata_tiles::draw_from_id_string_internal( id, category, subcategory, pos, subtile, rota,
            ll, -1, apply_night_vision_goggles, height_3d, 0, "", point() );
}

bool cata_tiles::draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                      const std::string &subcategory, const tripoint_bub_ms &pos,
                                      int subtile, int rota, lit_level ll,
                                      bool apply_night_vision_goggles, int &height_3d,
                                      int intensity_level, const std::string &variant )
{
    return cata_tiles::draw_from_id_string_internal( id, category, subcategory, pos, subtile, rota,
            ll, -1, apply_night_vision_goggles, height_3d, intensity_level,
            variant, point() );
}

bool cata_tiles::draw_from_id_string( const std::string &id, TILE_CATEGORY category,
                                      const std::string &subcategory, const tripoint_bub_ms &pos,
                                      int subtile, int rota, lit_level ll,
                                      bool apply_night_vision_goggles, int &height_3d,
                                      int intensity_level, const std::string &variant,
                                      const point &offset )
{
    return cata_tiles::draw_from_id_string_internal( id, category, subcategory, pos, subtile, rota,
            ll, -1, apply_night_vision_goggles, height_3d, intensity_level,
            variant, offset );
}
bool cata_tiles::draw_from_id_string_internal( const std::string &id, const tripoint_bub_ms &pos,
        int subtile,
        int rota,
        lit_level ll, int retract, bool apply_night_vision_goggles, int &height_3d )
{
    return cata_tiles::draw_from_id_string_internal( id, TILE_CATEGORY::NONE, empty_string, pos,
            subtile,
            rota, ll, retract, apply_night_vision_goggles, height_3d, 0, "", point() );
}

std::optional<tile_lookup_res>
cata_tiles::find_tile_with_season( const std::string &id ) const
{
    const season_type season = season_of_year( calendar::turn );
    return tileset_ptr->find_tile_type_by_season( id, season );
}

template<typename T>
std::optional<tile_lookup_res>
cata_tiles::find_tile_looks_like_by_string_id( std::string_view id, TILE_CATEGORY category,
        const int looks_like_jumps_limit ) const
{
    const string_id<T> s_id( id );
    if( !s_id.is_valid() ) {
    return std::nullopt;
}
const T &obj = s_id.obj();
return find_tile_looks_like( obj.looks_like, category, "", looks_like_jumps_limit - 1 );
}

std::string cata_tiles::find_bullet_sprite_id( const std::string &id, TILE_CATEGORY category )
{
    std::optional<tile_lookup_res> res = find_tile_looks_like( id, category, "" );
    return res ? res->id() : std::string{};
}

std::optional<tile_lookup_res>
cata_tiles::find_tile_looks_like( const std::string &id, TILE_CATEGORY category,
                                  const std::string &variant,
                                  const int looks_like_jumps_limit ) const
{
    if( id.empty() || looks_like_jumps_limit <= 0 ) {
        return std::nullopt;
    }

    /*
    *  Note on memory management:
    *  This method must returns pointers to the objects (std::string *id  and tile_type * tile)
    *  that are valid when this method returns. Ideally they should have the lifetime
    *  that is equal or exceeds lifetime of `this` or `this::tileset_ptr`.
    *  For example, `id` argument may have shorter lifetime and thus should not be returned!
    *  The result of `find_tile_with_season` is OK to be returned, because it's guaranteed to
    *  return pointers to the keys and values that are stored inside the `tileset_ptr`.
    */
    // Try the variant first
    if( !variant.empty() ) {
        if( category != TILE_CATEGORY::VEHICLE_PART ) {
            //indicates a sprite suffix
            if( variant[0] == '_' ) {
                if( auto ret = find_tile_with_season( id + variant ) ) {
                    return ret; // with variant
                }
            } else if( auto ret = find_tile_with_season( id + "_var_" + variant ) ) {
                return ret; // with variant
            }
        } else {
            std::string_view variant_chunk = variant;
            while( !variant_chunk.empty() ) {
                if( auto ret = find_tile_with_season( id + "_" + std::string( variant_chunk ) ) ) {
                    return ret; // with variant, but vehicle parts have weird variant suffixes
                }
                const size_t next_start = variant_chunk.rfind( '_' );
                if( next_start != std::string::npos ) {
                    variant_chunk = variant_chunk.substr( 0, next_start );
                } else {
                    variant_chunk = variant_chunk.substr( 0, 0 );
                }
            }
        }
    }
    if( auto ret = find_tile_with_season( id ) ) {
        return ret; // no variant
    }

    // Then do looks_like
    switch( category ) {
        case TILE_CATEGORY::FURNITURE:
            return find_tile_looks_like_by_string_id<furn_t>( id, category,
                    looks_like_jumps_limit );
        case TILE_CATEGORY::TERRAIN:
            return find_tile_looks_like_by_string_id<ter_t>( id, category, looks_like_jumps_limit );
        case TILE_CATEGORY::FIELD:
            return find_tile_looks_like_by_string_id<field_type>( id, category,
                    looks_like_jumps_limit );
        case TILE_CATEGORY::MONSTER:
            return find_tile_looks_like_by_string_id<mtype>( id, category, looks_like_jumps_limit );
        case TILE_CATEGORY::OVERMAP_VISION_LEVEL: {
            size_t id_end = id.find( '$' );
            om_vision_level level = io::string_to_enum<om_vision_level>( id.substr( id_end + 1 ) );
            oter_vision_id vision_id( id.substr( 0, id_end ) );
            // This shouldn't fail, but better safe than sorry
            const oter_vision::level *viewed = vision_id->viewed( level );
            if( viewed != nullptr && !viewed->looks_like.empty() ) {
                return find_tile_looks_like( viewed->looks_like, TILE_CATEGORY::OVERMAP_TERRAIN, variant,
                                             looks_like_jumps_limit - 1 );
            }
            return std::nullopt;
        }
        case TILE_CATEGORY::OVERMAP_TERRAIN: {
            std::optional<tile_lookup_res> ret;
            const oter_type_str_id type_tmp( id );
            if( !type_tmp.is_valid() ) {
                return ret;
            }

            int jump_limit = looks_like_jumps_limit;
            for( const std::string &looks_like : type_tmp.obj().looks_like ) {

                ret = find_tile_looks_like( looks_like, category, "", jump_limit - 1 );
                if( ret.has_value() ) {
                    return ret;
                }

                jump_limit--;
                if( jump_limit <= 0 ) {
                    return ret;
                }
            }

            return ret;
        }

        case TILE_CATEGORY::VEHICLE_PART: {
            const int lljl = looks_like_jumps_limit - 1;
            // vehicle parts start with vp_ for their tiles, but not their IDs
            const vpart_id vpid( id.substr( 3 ) );
            if( !vpid.is_valid() ) {
                return std::nullopt;
            }
            const std::string &looks_like = vpid->looks_like;
            if( looks_like.empty() ) {
                return std::nullopt;
            }
            if( auto ret = find_tile_looks_like( "vp_" + looks_like, category, variant, lljl ) ) {
                return ret;
            }
            if( auto ret = find_tile_looks_like( looks_like, category, variant, lljl ) ) {
                return ret;
            }
            if( auto ret = find_tile_looks_like( looks_like, TILE_CATEGORY::FURNITURE, variant, lljl ) ) {
                return ret;
            }
            return std::nullopt;
        }

        case TILE_CATEGORY::ITEM: {
            if( !item::type_is_defined( itype_id( id ) ) ) {
                if( string_starts_with( id, "corpse_" ) ) {
                    return find_tile_looks_like(
                               "corpse", category, "", looks_like_jumps_limit - 1
                           );
                }
                return std::nullopt;
            }
            const itype *new_it = item::find_type( itype_id( id ) );
            return find_tile_looks_like( new_it->looks_like.str(), category, "",
                                         looks_like_jumps_limit - 1 );
        }

        default:
            return std::nullopt;
    }
}

bool cata_tiles::find_overlay_looks_like( const bool male, const std::string &overlay,
        const std::string &variant, std::string &draw_id )
{
    bool exists = false;

    std::string looks_like;
    std::string over_type;

    if( string_starts_with( overlay, "worn_" ) ) {
        looks_like = overlay.substr( 5 );
        over_type = "worn_";
    } else if( string_starts_with( overlay, "wielded_" ) ) {
        looks_like = overlay.substr( 8 );
        over_type = "wielded_";
    } else {
        looks_like = overlay;
    }

    // Try to draw variants, then fall back to drawing the base
    // We can potentially do this twice for a variant of an active mutation
    for( int i = 0; i < 2; ++i ) {
        draw_id.clear();
        str_append( draw_id,
                    ( male ? "overlay_male_" : "overlay_female_" ), over_type, looks_like, "_var_",
                    variant );
        if( tileset_ptr->find_tile_type( draw_id ) ) {
            return true;
        }
        draw_id.clear();
        str_append( draw_id, "overlay_", over_type, looks_like, "_var_", variant );
        if( tileset_ptr->find_tile_type( draw_id ) ) {
            return true;
        }
        if( string_starts_with( looks_like, "mutation_active_" ) ) {
            looks_like = "mutation_" + looks_like.substr( 16 );
            continue;
        }
        break;
    }
    for( int cnt = 0; cnt < 10 && !looks_like.empty(); cnt++ ) {
        draw_id.clear();
        str_append( draw_id,
                    ( male ? "overlay_male_" : "overlay_female_" ), over_type, looks_like );
        if( tileset_ptr->find_tile_type( draw_id ) ) {
            exists = true;
            break;
        }
        draw_id.clear();
        str_append( draw_id, "overlay_", over_type, looks_like );
        if( tileset_ptr->find_tile_type( draw_id ) ) {
            exists = true;
            break;
        }
        if( string_starts_with( looks_like, "mutation_active_" ) ) {
            looks_like = "mutation_" + looks_like.substr( 16 );
            continue;
        }
        if( !item::type_is_defined( itype_id( looks_like ) ) ) {
            break;
        }
        const itype *new_it = item::find_type( itype_id( looks_like ) );
        looks_like = new_it->looks_like.str();
    }
    return exists;
}

void cata_tiles::set_disable_occlusion( const bool val )
{
    disable_occlusion = val;
}

bool cata_tiles::draw_from_id_string_internal( const std::string &id, TILE_CATEGORY category,
        const std::string &subcategory, const tripoint_bub_ms &pos,
        int subtile, int rota, lit_level ll, int retract,
        bool apply_night_vision_goggles, int &height_3d,
        int intensity_level, const std::string &variant,
        const point &offset )
{
    bool nv_color_active = apply_night_vision_goggles && get_option<bool>( "NV_GREEN_TOGGLE" );
    // If the ID string does not produce a drawable tile
    // it will revert to the "unknown" tile.
    // The "unknown" tile is one that is highly visible so you kinda can't miss it :D

    const tile_type *tt = nullptr;
    std::optional<tile_lookup_res> res;

    // translate from player-relative to screen relative tile position
    const point screen_pos = player_to_screen( pos.xy() );

    if( retract < 0 && ( prevent_occlusion_transp || prevent_occlusion_retract ) ) {
        if( prevent_occlusion == 0 || disable_occlusion ) {
            retract = 0;
        } else if( prevent_occlusion == 1 ) {
            retract = 100;
        } else {
            // Squared-distance fast path. The retract value saturates to 100 for
            // tiles at or inside d_min and to 0 for tiles at or beyond d_max; only
            // tiles in the annulus between the two need the real euclidean distance
            // for interpolation. Comparing squared distances lets us skip the
            // per-tile std::sqrt for the common case (most visible tiles are clearly
            // outside d_max -> retract 0). Thresholds are read fresh here (not cached
            // at frame start) so option/tileset changes take effect immediately.
            const point ref = is_isometric() ? o :
                              point( static_cast<int>( o.x + ( screentile_width / 2.0f ) ),
                                     static_cast<int>( o.y - 1 + ( screentile_height / 2.0f ) ) );
            const point tgt = pos.raw().xy();
            const float dx = static_cast<float>( ref.x - tgt.x );
            const float dy = static_cast<float>( ref.y - tgt.y );
            const float dist_sq = dx * dx + dy * dy;

            const float d_min = prevent_occlusion_min_dist > 0.0 ? prevent_occlusion_min_dist :
                                tileset_ptr->get_prevent_occlusion_min_dist();
            const float d_max = prevent_occlusion_max_dist > 0.0 ? prevent_occlusion_max_dist :
                                tileset_ptr->get_prevent_occlusion_max_dist();
            // Squared-distance fast path, valid only for well-ordered
            // non-negative thresholds (d_min >= 0 && d_max > d_min) — the normal
            // runtime config. Squaring preserves ordering only for non-negative
            // operands, and d_max > d_min guarantees the interpolation slope is
            // 1/(d_max-d_min) (never the d_range<=0 step branch). Under those
            // constraints this is exactly equivalent to the original formula but
            // skips the per-tile std::sqrt outside the [d_min,d_max] annulus
            // (most visible tiles sit beyond d_max -> retract 0). Any other
            // threshold config (negative, inverted, or the disabled default
            // d_min=-1,d_max=0) falls through to the unchanged original formula.
            if( d_min >= 0.0f && d_max > d_min ) {
                const float d_min_sq = d_min * d_min;
                const float d_max_sq = d_max * d_max;
                if( dist_sq <= d_min_sq ) {
                    retract = 100;
                } else if( dist_sq >= d_max_sq ) {
                    retract = 0;
                } else {
                    const float distance = std::sqrt( dist_sq );
                    retract = static_cast<int>( 100.0 * ( 1.0 - std::clamp( ( distance - d_min ) /
                        ( d_max - d_min ), 0.0f, 1.0f ) ) );
                }
            } else {
                const float distance = std::sqrt( dist_sq );
                const float d_range = d_max - d_min;
                const float d_slope = d_range <= 0.0f ? 100.0 : 1.0 / d_range;
                retract = static_cast<int>( 100.0 * ( 1.0 - std::clamp( ( distance - d_min ) * d_slope, 0.0f,
                    1.0f ) ) );
            }
        }

        // Adding to the id like this breaks the fragile string handling that vision level uses for looks_like.
        if( prevent_occlusion_transp && retract > 0 && category != TILE_CATEGORY::OVERMAP_VISION_LEVEL ) {
            res = find_tile_looks_like( id + "_transparent", category, variant );
            if( res ) {
                tt = &res -> tile();
            }
        }
    }

    // check if there is an available intensity tile and if there is use that instead of the basic tile
    // this is only relevant for fields
    if( intensity_level > 0 ) {
        res = find_tile_looks_like( id + "_int" + std::to_string( intensity_level ), category, variant );
        if( res ) {
            tt = &res -> tile();
        }
    }
    // if a tile with intensity hasn't already been found then fall back to a base tile
    if( !res ) {
        res = find_tile_looks_like( id, category, variant );
        if( res ) {
            tt = &res -> tile();
        }
    }

    map &here = get_map();
    const std::string &found_id = res ? res->id() : id;

    if( !tt ) {
        // Use fog overlay as fallback for transparent terrain
        if( category == TILE_CATEGORY::TERRAIN && !here.dont_draw_lower_floor( tripoint_bub_ms( pos ) ) ) {
            draw_zlevel_overlay( tripoint_bub_ms( pos ), ll, height_3d );

            // t_open_air is plentiful at high z-levels
            // Skipping the rest of the fallback code will significantly improve performance
            if( id == "t_open_air" ) {
                return true;
            }
        }

        bool is_linear = false;
        uint32_t sym = UNKNOWN_UNICODE;
        nc_color col = c_white;
        if( category == TILE_CATEGORY::FURNITURE ) {
            const furn_str_id fid( found_id );
            if( fid.is_valid() ) {
                const furn_t &f = fid.obj();
                sym = f.symbol();
                col = f.color();
            }
        } else if( category == TILE_CATEGORY::TERRAIN ) {
            const ter_str_id tid( found_id );
            if( tid.is_valid() ) {
                const ter_t &t = tid.obj();
                sym = t.symbol();
                col = t.color();
            }
        } else if( category == TILE_CATEGORY::MONSTER ) {
            const mtype_id mid( found_id );
            if( mid.is_valid() ) {
                const mtype &mt = mid.obj();
                sym = UTF8_getch( mt.sym );
                col = mt.color;
            }
        } else if( category == TILE_CATEGORY::VEHICLE_PART ) {
            const vpart_id vpid( string_starts_with( found_id, "vp_" ) ? found_id.substr( 3 ) : found_id );
            if( vpid.is_valid() ) {
                const vpart_info &vpi = *vpid;
                if( vpi.variants.count( variant ) ) {
                    const vpart_variant &vv = vpi.variants.at( variant );
                    if( subtile == open_ ) {
                        sym = '\'';
                    } else {
                        sym = vv.get_symbol_curses( 90_degrees * rota, subtile == broken );
                    }
                    col = vpi.color;
                    subtile = -1;
                    rota = 0;
                } else if( ll != lit_level::MEMORIZED ) {
                    debugmsg( "invalid variant '%s' on vpart_id '%s'", variant, vpid.str() );
                }
            } else if( ll != lit_level::MEMORIZED ) {
                debugmsg( "invalid vpart_id '%s'", vpid.str() );
            }
        } else if( category == TILE_CATEGORY::FIELD ) {
            const field_type_id fid = field_type_id( found_id );
            sym = fid->get_intensity_level().symbol;
            col = fid->get_intensity_level().color;
        } else if( category == TILE_CATEGORY::TRAP ) {
            const trap_str_id tmp( found_id );
            if( tmp.is_valid() ) {
                const trap &t = tmp.obj();
                sym = t.sym;
                col = t.color;
            }
        } else if( category == TILE_CATEGORY::ITEM ) {
            item tmp;
            if( string_starts_with( found_id, "corpse_" ) ) {
                tmp = item( itype_corpse, calendar::turn_zero );
            } else {
                tmp = item( itype_id( found_id ), calendar::turn_zero );
            }
            if( !variant.empty() ) {
                tmp.set_itype_variant( variant );
            } else {
                tmp.clear_itype_variant();
            }
            sym = static_cast<uint8_t>( tmp.symbol().empty() ? ' ' : tmp.symbol().front() );
            col = tmp.color();
        } else if( category == TILE_CATEGORY::OVERMAP_WEATHER ) {
            const weather_type_id weather_def( id );
            if( weather_def.is_valid() ) {
                sym = weather_def->symbol;
                col = weather_def->map_color;
            }
        } else if( category == TILE_CATEGORY::OVERMAP_VISION_LEVEL ) {
            size_t id_end = id.find( '$' );
            om_vision_level level = io::string_to_enum<om_vision_level>( id.substr( id_end + 1 ) );
            oter_vision_id vision_id( id.substr( 0, id_end ) );
            // if we have gotten this far, this call can't fail, because the id never would have
            // been generated to get it. Nonetheless, better safe than sorry
            if( const oter_vision::level *viewed = vision_id->viewed( level ) ) {
                sym = viewed->symbol;
                col = viewed->color;
            }
        } else if( category == TILE_CATEGORY::OVERMAP_TERRAIN ) {
            const oter_type_str_id tmp( id );
            if( tmp.is_valid() ) {
                is_linear = tmp->is_linear();
                if( !is_linear ) {
                    // if rota is for a omt with connections, it can be outside the bounds of
                    // om_direction::type. We can't do anything about that now, so just stay inbounds
                    rota %= om_direction::size;
                    sym = tmp->get_rotated( static_cast<om_direction::type>( rota ) )->get_uint32_symbol();
                } else {
                    sym = tmp->get_uint32_symbol();
                }
                col = tmp->get_color();
            }
        } else if( category == TILE_CATEGORY::OVERMAP_NOTE ) {
            sym = static_cast<uint8_t>( id[5] );
            col = color_from_string( id.substr( 7, id.length() - 1 ) );
        }
        // Special cases for walls
        switch( sym ) {
            case LINE_XOXO:
            case LINE_XOXO_UNICODE:
                sym = LINE_XOXO_C;
                break;
            case LINE_OXOX:
            case LINE_OXOX_UNICODE:
                sym = LINE_OXOX_C;
                break;
            case LINE_XXOO:
            case LINE_XXOO_UNICODE:
                sym = LINE_XXOO_C;
                break;
            case LINE_OXXO:
            case LINE_OXXO_UNICODE:
                sym = LINE_OXXO_C;
                break;
            case LINE_OOXX:
            case LINE_OOXX_UNICODE:
                sym = LINE_OOXX_C;
                break;
            case LINE_XOOX:
            case LINE_XOOX_UNICODE:
                sym = LINE_XOOX_C;
                break;
            case LINE_XXXO:
            case LINE_XXXO_UNICODE:
                sym = LINE_XXXO_C;
                break;
            case LINE_XXOX:
            case LINE_XXOX_UNICODE:
                sym = LINE_XXOX_C;
                break;
            case LINE_XOXX:
            case LINE_XOXX_UNICODE:
                sym = LINE_XOXX_C;
                break;
            case LINE_OXXX:
            case LINE_OXXX_UNICODE:
                sym = LINE_OXXX_C;
                break;
            case LINE_XXXX:
            case LINE_XXXX_UNICODE:
                sym = LINE_XXXX_C;
                break;
            default:
                // sym goes unchanged
                break;
        }

        if( sym != 0 && sym < 256 ) {
            // see cursesport.cpp, function wattron
            const int pairNumber = col.to_color_pair_index();
            const cata_cursesport::pairs &colorpair = cata_cursesport::colorpairs[pairNumber];
            // What about isBlink?
            const bool isBold = col.is_bold();
            const int FG = colorpair.FG + ( isBold ? 8 : 0 );
            std::string generic_id = get_ascii_tile_id( sym, FG, -1 );

            // do not rotate fallback tiles for non line drawings (roads and such)
            if( !is_linear ) {
                rota = 0;
            }
            if( tileset_ptr->find_tile_type( generic_id ) ) {
                return draw_from_id_string_internal( generic_id, pos, subtile, rota,
                                                     ll, retract, nv_color_active, height_3d );
            }
            // Try again without color this time (using default color).
            generic_id = get_ascii_tile_id( sym, -1, -1 );
            if( tileset_ptr->find_tile_type( generic_id ) ) {
                return draw_from_id_string_internal( generic_id, pos, subtile, rota,
                                                     ll, retract, nv_color_active, height_3d );
            }
        }
    }

    // if id is not found, try to find a tile for the category+subcategory combination
    const std::string &category_id = TILE_CATEGORY_IDS[static_cast<size_t>( category )];
    if( !tt ) {
        if( !category_id.empty() && !subcategory.empty() ) {
            tt = tileset_ptr->find_tile_type( "unknown_" + category_id + "_" + subcategory );
        }
    }

    // if at this point we have no tile, try just the category
    if( !tt ) {
        if( !category_id.empty() ) {
            tt = tileset_ptr->find_tile_type( "unknown_" + category_id );
        }
    }

    // if we still have no tile, we're out of luck, fall back to unknown
    if( !tt ) {
        tt = tileset_ptr->find_tile_type( "unknown" );
    }

    //  this really shouldn't happen, but the tileset creator might have forgotten to define
    // an unknown tile
    if( !tt ) {
        return false;
    }

    const tile_type &display_tile = *tt;
    // check to see if the display_tile is multitile, and if so if it has the key related to
    // subtile
    if( subtile != -1 && display_tile.multitile ) {
        const auto &display_subtiles = display_tile.available_subtiles;
        const auto end = std::end( display_subtiles );
        if( std::find( begin( display_subtiles ), end, multitile_keys[subtile] ) != end ) {
            // append subtile name to tile and re-find display_tile
            return draw_from_id_string_internal(
                       found_id + "_" + multitile_keys[subtile], category, subcategory, pos, -1, rota, ll,
                       retract, nv_color_active, height_3d, 0, "", point() );
        }
    }

    // seed the PRNG to get a reproducible random int
    // TODO: faster solution here
    unsigned int seed = 0;
    creature_tracker &creatures = get_creature_tracker();
    // TODO: determine ways other than category to differentiate more types of sprites
    switch( category ) {
        case TILE_CATEGORY::TERRAIN:
        case TILE_CATEGORY::FIELD:
        case TILE_CATEGORY::LIGHTING:
            // stationary map tiles, seed based on map coordinates
            seed = simple_point_hash( here.get_abs( pos ).raw().xy() );
            break;
        case TILE_CATEGORY::VEHICLE_PART:
            // vehicle parts, seed based on coordinates within the vehicle
            // TODO: also use some vehicle id, for less predictability
        {
            // new scope for variable declarations
            const auto vp_override = vpart_override.find( tripoint_bub_ms( pos ) );
            const bool vp_overridden = vp_override != vpart_override.end();
            if( vp_overridden ) {
                const vpart_id &vp_id = std::get<0>( vp_override->second );
                if( vp_id ) {
                    const point_rel_ms &mount = std::get<4>( vp_override->second );
                    seed = simple_point_hash( mount.raw() );
                }
            } else {
                const optional_vpart_position vp = here.veh_at( pos );
                if( vp ) {
                    seed = simple_point_hash( vp->mount_pos().raw() );
                }
            }
        }
        break;
        case TILE_CATEGORY::FURNITURE: {
            // If the furniture is not movable, we'll allow seeding by the position
            // since we won't get the behavior that occurs where the tile constantly
            // changes when the player grabs the furniture and drags it, causing the
            // seed to change.
            const furn_str_id fid( found_id );
            if( fid.is_valid() ) {
                const furn_t &f = fid.obj();
                if( !f.is_movable() ) {
                    seed = simple_point_hash( here.get_abs( pos ).raw().xy() );
                }
            }
        }
        break;
        case TILE_CATEGORY::OVERMAP_WEATHER:
        case TILE_CATEGORY::OVERMAP_TERRAIN:
        case TILE_CATEGORY::OVERMAP_VISION_LEVEL:
        case TILE_CATEGORY::MAP_EXTRA:
            seed = simple_point_hash( pos.raw().xy() );
            break;
        case TILE_CATEGORY::NONE:
            // graffiti
            if( found_id == "graffiti" ) {
                seed = std::hash<std::string> {}( here.graffiti_at( pos ) );
            } else if( string_starts_with( found_id, "graffiti" ) ) {
                seed = simple_point_hash( here.get_abs( pos ).raw().xy() );
            }
            break;
        case TILE_CATEGORY::ITEM:
        case TILE_CATEGORY::TRAP:
        case TILE_CATEGORY::BULLET:
        case TILE_CATEGORY::HIT_ENTITY:
            // TODO: come up with ways to make random sprites consistent for these types
            break;
        case TILE_CATEGORY::WEATHER:
            seed = rng_bits(); // Doesn't need to be deterministic
            break;
        case TILE_CATEGORY::MONSTER:
            // FIXME: add persistent id to Creature type, instead of using monster pointer address
            if( monster_override.find( tripoint_bub_ms( pos ) ) == monster_override.end() ) {
                seed = reinterpret_cast<uintptr_t>( creatures.creature_at<monster>( pos ) );
            }
            break;
        default:
            // player
            if( string_starts_with( found_id, "player_" ) ) {
                seed = std::hash<std::string> {}( get_player_character().name );
                break;
            }
            // NPC
            if( string_starts_with( found_id, "npc_" ) ) {
                if( npc *const guy = creatures.creature_at<npc>( pos ) ) {
                    seed = guy->getID().get_value();
                    break;
                }
            }
    }

    // make sure we aren't going to rotate the tile if it shouldn't be rotated.
    // BULLET is exempt: projectile sprites are intentionally rotated to point
    // along the trajectory even though the tile itself is flagged rotates:false.
    if( !display_tile.rotates && !( category == TILE_CATEGORY::NONE )
        && !( category == TILE_CATEGORY::MONSTER )
        && !( category == TILE_CATEGORY::BULLET ) ) {
        rota = 0;
    }

    unsigned int loc_rand = 0;
    // only bother mixing up a hash/random value if the tile has some sprites to randomly pick
    // between
    if( display_tile.fg.size() > 1 || display_tile.bg.size() > 1 ) {
        static const auto rot32 = []( const unsigned int x, const int k ) {
            return ( x << k ) | ( x >> ( 32 - k ) );
        };
        // use a fair mix function to turn the "random" seed into a random int
        // taken from public domain code at http://burtleburtle.net/bob/c/lookup3.c 2015/12/11
        unsigned int a = seed;
        unsigned int b = -seed;
        unsigned int c = seed * seed;
        c ^= b;
        c -= rot32( b, 14 );
        a ^= c;
        a -= rot32( c, 11 );
        b ^= a;
        b -= rot32( a, 25 );
        c ^= b;
        c -= rot32( b, 16 );
        a ^= c;
        a -= rot32( c, 4 );
        b ^= a;
        b -= rot32( a, 14 );
        c ^= b;
        c -= rot32( b, 24 );
        loc_rand = c;

        // idle tile animations:
        if( display_tile.animated ) {
            has_animated_tiles_ = true;
            // idle animations run during the user's turn, and the animation speed
            // needs to be defined by the tileset to look good, so we use system clock:
            std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
            auto now_ms = std::chrono::time_point_cast<std::chrono::milliseconds>( now );
            std::chrono::milliseconds value = now_ms.time_since_epoch();
            // aiming roughly at the standard 60 frames per second:
            int animation_frame = value.count() / 17;
            // offset by log_rand so that everything does not blink at the same time:
            animation_frame += loc_rand;
            int frames_in_loop = display_tile.fg.get_weight();
            if( frames_in_loop == 1 ) {
                frames_in_loop = display_tile.bg.get_weight();
            }
            // loc_rand is actually the weighed index of the selected tile, and
            // for animations the "weight" is the number of frames to show the tile for:
            loc_rand = animation_frame % frames_in_loop;
        }
    }

    if( ! prevent_occlusion_retract ) {
        retract = 0;
    }

    //draw it!
    tile_render_params rp{ ll, nv_color_active };
    // Vehicle parts carry a per-instance paint color via pending_part_tint_
    // (set by draw_vpart). Only apply it to vehicle part sprites.
    if( category == TILE_CATEGORY::VEHICLE_PART ) {
        rp.tint = pending_part_tint_;
    }
    draw_tile_at( display_tile, screen_pos, loc_rand, rota, rp,
                  retract, height_3d, offset, /*allow_diagonal_rota:*/ category == TILE_CATEGORY::BULLET );

    return true;
}

bool cata_tiles::draw_sprite_at(
    const tile_type &tile, const weighted_int_list<std::vector<int>> &svlist,
    const point &p, unsigned int loc_rand, bool rota_fg, int rota,
    const tile_render_params &rp, int retract, int &height_3d, const point &offset,
    bool allow_diagonal_rota )
{
    const std::vector<int> *picked = svlist.pick( loc_rand );
    if( !picked ) {
        return true;
    }
    const std::vector<int> &spritelist = *picked;
    if( spritelist.empty() ) {
        return true;
    }

    int ret = 0;
    // blit foreground based on rotation
    bool rotate_sprite = false;
    int sprite_num = 0;
    if( !rota_fg && spritelist.size() == 1 ) {
        // don't rotate, a background tile without manual rotations
        rotate_sprite = false;
        sprite_num = 0;
    } else if( spritelist.size() == 1 ) {
        // just one tile, apply SDL sprite rotation if not in isometric mode
        rotate_sprite = true;
        sprite_num = 0;
    } else {
        // multiple rotated tiles defined, don't apply sprite rotation after picking one
        rotate_sprite = false;
        // two tiles, tile 0 is N/S, tile 1 is E/W
        // four tiles, 0=N, 1=E, 2=S, 3=W
        // extending this to more than 4 rotated tiles will require changing rota to degrees
        sprite_num = rota % spritelist.size();
    }

    const int sprite_index = spritelist[sprite_num];
    const texture *sprite_tex = tileset_ptr->get_tile( sprite_index );

    bool shader_bound = false;
#if SDL_MAJOR_VERSION >= 3
    // Try the GPU shader variant first. On success the main atlas drives
    // the render and the variant transform happens per-pixel in the
    // fragment shader. On unsupported variant (NORMAL, custom MEMORY
    // preset, clean session-disable) try_begin reports use_atlas; abort_frame
    // means undefined shader state -- latch recovery and throw.
    if( cata_shader::variant_pass *vp = get_shared_variant_pass() ) {
        // A painted vehicle part is recolored on the CPU below, so force NORMAL
        // (no GPU variant transform); otherwise the shader samples the base atlas
        // and ignores the tinted texture. NORMAL also clears prior shader state.
        const cata_shader::variant_kind v =
            rp.tint ? cata_shader::variant_kind::NORMAL
            : compute_variant_kind( rp.ll, rp.use_night_vision_tiles );
        const cata_shader::variant_pass::begin_result br = vp->try_begin( v );
        if( br == cata_shader::variant_pass::begin_result::abort_frame ) {
            display_buffer_scope_signal_recovery_required();
            throw std::runtime_error(
                "cata_tiles::draw_sprite_at: variant_pass left renderer in undefined shader-state bind" );
        }
        shader_bound = ( br == cata_shader::variant_pass::begin_result::bound );
    }
#endif

    //use night vision colors when in use
    //then use low light tile if available
    if( !shader_bound ) {
        if( rp.ll == lit_level::MEMORIZED ) {
            if( const texture *ptr = tileset_ptr->get_memory_tile( sprite_index ) ) {
                sprite_tex = ptr;
            }
        } else if( rp.use_night_vision_tiles ) {
            if( rp.ll != lit_level::LOW ) {
                if( const texture *ptr = tileset_ptr->get_overexposed_tile( sprite_index ) ) {
                    sprite_tex = ptr;
                }
            } else {
                if( const texture *ptr = tileset_ptr->get_night_tile( sprite_index ) ) {
                    sprite_tex = ptr;
                }
            }
        } else if( rp.ll == lit_level::LOW ) {
            if( const texture *ptr = tileset_ptr->get_shadow_tile( sprite_index ) ) {
                sprite_tex = ptr;
            }
        }
    }

    // Recolor the chosen (light-adjusted) sprite toward the vehicle part's paint.
    if( rp.tint ) {
        if( const texture *tinted = tileset_ptr->get_tinted_tile(
                                        renderer, sprite_index, *rp.tint, sprite_tex ) ) {
            sprite_tex = tinted;
        }
    }

    int width = 0;
    int height = 0;
    std::tie( width, height ) = sprite_tex->dimension();

    const point &tile_offset = retract <= 0
                               ? tile.offset
                               : ( retract >= 100
                                   ? tile.offset_retracted
                                   : tile.offset
                                   + ( ( tile.offset_retracted - tile.offset ) * retract ) / 100
                                 );
    SDL_Rect destination;
    // Using divide_round_down because the offset might be negative.
    destination.x = p.x + divide_round_down( ( tile_offset.x + offset.x ) * tile_width,
        tileset_ptr->get_tile_width() );
    destination.y = p.y + divide_round_down( ( tile_offset.y + offset.y - height_3d ) * tile_width,
        tileset_ptr->get_tile_width() );
    destination.w = width * tile_width * tile.pixelscale / tileset_ptr->get_tile_width();
    destination.h = height * tile_height * tile.pixelscale / tileset_ptr->get_tile_height();

    const bool iso = is_isometric();

    // --- Tint bounds tracking (ortho only) ---
    // Accumulate the screen-space extent of opaque pixels for this tile so the
    // tint overlay knows the actual sprite footprint. We use the pre-computed
    // opaque_rect (tightest non-transparent bounding box, computed at tileset
    // load) rather than the full destination rect to avoid tinting transparent
    // padding around sprites. When the sprite is flipped, mirror the opaque
    // rect to match.
    if( m_cur_bounds ) {
        SDL_Rect opq = sprite_tex->get_opaque_rect();
        if( opq.w > 0 && opq.h > 0 ) {
            if( rotate_sprite ) {
                // rota == -1 is horizontal flip only.
                // rota % 4 == 2 is 180 degrees, implemented as H+V flip.
                if( rota == -1 || ( !iso && rota % 4 == 2 ) ) {
                    opq.x = width - opq.x - opq.w;
                }
                if( !iso && rota % 4 == 2 ) {
                    opq.y = height - opq.y - opq.h;
                }
            }
            // Scale from source pixel coords to destination screen coords.
            m_cur_bounds->expand(
                destination.x + opq.x * destination.w / width,
                destination.y + opq.y * destination.h / height,
                opq.w * destination.w / width,
                opq.h * destination.h / height );
        }
    }

    // --- Pre-compute rotation for tint recording ---
    // We need the final angle/flip values both for the actual render call below
    // and for recording into tint_sprites (which replays the sprite as a white
    // silhouette during the tint overlay pass). Compute them once here.
    double render_angle = 0;
    CataFlipMode render_flip = SDL_FLIP_NONE;
    if( rotate_sprite ) {
        if( rota == -1 ) {
            render_flip = SDL_FLIP_HORIZONTAL;
        } else if( !iso ) {
            // Non-bullet tiles keep the historical `% 4` fold exactly. Bullets
            // opt into the extended codes (5-8) for true diagonal rotation.
            const int r = allow_diagonal_rota ? rota : ( rota % 4 );
            switch( r ) {
                case 1:
                    render_angle = 90;
                    break;
                case 2:
                    render_flip = static_cast<CataFlipMode>( SDL_FLIP_HORIZONTAL | SDL_FLIP_VERTICAL );
                    break;
                case 3:
                    render_angle = -90;
                    break;
                // Diagonal rotations, only reachable when allow_diagonal_rota.
                case 5:
                    render_angle = 45;
                    break;
                case 6:
                    render_angle = -45;
                    break;
                case 7:
                    render_angle = -135;
                    break;
                case 8:
                    render_angle = 135;
                    break;
                default:
                    break;
            }
        }
    }

    // Record this sprite for silhouette mask replay. Must happen before the
    // actual render because the render path may modify destination (d3d offset
    // workaround). Only active for ortho tiles that need tinting.
    if( m_cur_tint_sprites ) {
        m_cur_tint_sprites->push_back( { sprite_index,
            { destination.x, destination.y, destination.w, destination.h },
            render_angle, static_cast<int>( render_flip ) } );
    }

    if( rotate_sprite ) {
        if( rota == -1 ) {
            // flip horizontally
            ret = sprite_tex->render_copy_ex(
                      renderer, &destination, 0, nullptr,
                      static_cast<CataFlipMode>( SDL_FLIP_HORIZONTAL ) );
        } else {
            // Non-bullet tiles keep the historical `% 4` fold exactly. Bullets
            // opt into the extended codes (5-8) for true diagonal rotation.
            const int r = allow_diagonal_rota ? rota : ( rota % 4 );
            switch( r ) {
                default:
                case 0:
                    // unrotated (and 180, with just two sprites)
                    ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                      SDL_FLIP_NONE );
                    break;
                case 1:
                    // 90 degrees (and 270, with just two sprites)
#if defined(_WIN32) && defined(CROSS_LINUX)
                    // For an unknown reason, additional offset is required in direct3d mode
                    // for cross-compilation from Linux to Windows
                    if( direct3d_mode ) {
                        destination.y -= 1;
                    }
#endif
                    if( !iso ) {
                        // never rotate isometric tiles
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 90, nullptr,
                                                          SDL_FLIP_NONE );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
                case 2:
                    // 180 degrees, implemented with flips instead of rotation
                    if( !iso ) {
                        // never flip isometric tiles vertically
                        ret = sprite_tex->render_copy_ex(
                                  renderer, &destination, 0, nullptr,
                                  static_cast<CataFlipMode>( SDL_FLIP_HORIZONTAL | SDL_FLIP_VERTICAL ) );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
                case 3:
                    // 270 degrees
#if defined(_WIN32) && defined(CROSS_LINUX)
                    // For an unknown reason, additional offset is required in direct3d mode
                    // for cross-compilation from Linux to Windows
                    if( direct3d_mode ) {
                        destination.x -= 1;
                    }
#endif
                    if( !iso ) {
                        // never rotate isometric tiles
                        ret = sprite_tex->render_copy_ex( renderer, &destination, -90, nullptr,
                                                          SDL_FLIP_NONE );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
                case 5:
                    // 45 degrees (diagonal, bullets only)
                    if( !iso ) {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 45, nullptr,
                                                          SDL_FLIP_NONE );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
                case 6:
                    // -45 degrees (diagonal, bullets only)
                    if( !iso ) {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, -45, nullptr,
                                                          SDL_FLIP_NONE );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
                case 7:
                    // -135 degrees (diagonal, bullets only)
                    if( !iso ) {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, -135, nullptr,
                                                          SDL_FLIP_NONE );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
                case 8:
                    // 135 degrees (diagonal, bullets only)
                    if( !iso ) {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 135, nullptr,
                                                          SDL_FLIP_NONE );
                    } else {
                        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr,
                                                          SDL_FLIP_NONE );
                    }
                    break;
            }
        }
    } else {
        // don't rotate, same as case 0 above
        ret = sprite_tex->render_copy_ex( renderer, &destination, 0, nullptr, SDL_FLIP_NONE );
    }

    printErrorIf( ret != 0, "SDL_RenderCopyEx() failed" );
#if SDL_MAJOR_VERSION >= 3
    // variant_pass unbinds on frame-end flush; nothing to do per-sprite.
    ( void )shader_bound;
#endif
    // this reference passes all the way back up the call chain back to
    // cata_tiles::draw() here.draw_points_cache.tiles[z][row][col].scratch.height_3d
    // where we are accumulating the height of every sprite stacked up in a tile
    height_3d += tile.height_3d;
    return true;
}

bool cata_tiles::draw_tile_at(
    const tile_type &tile, const point &p, unsigned int loc_rand, int rota,
    const tile_render_params &rp, int retract, int &height_3d,
    const point &offset, bool allow_diagonal_rota )
{
    int fake_int = height_3d;
    draw_sprite_at( tile, tile.bg, p, loc_rand, /*fg:*/ false, rota, rp,
                    retract, fake_int, offset, allow_diagonal_rota );
    draw_sprite_at( tile, tile.fg, p, loc_rand, /*fg:*/ true, rota, rp,
                    retract, height_3d, offset, allow_diagonal_rota );
    return true;
}

bool cata_tiles::would_apply_vision_effects( const visibility_type visibility ) const
{
    return visibility != visibility_type::CLEAR;
}

bool cata_tiles::apply_vision_effects( const tripoint_bub_ms &pos,
                                       const visibility_type visibility,
                                       int &height_3d )
{
    if( !would_apply_vision_effects( visibility ) ) {
        return false;
    }
    std::string light_name;
    switch( visibility ) {
        case visibility_type::HIDDEN:
            light_name = "lighting_hidden";
            break;
        case visibility_type::LIT:
            light_name = "lighting_lowlight_light";
            break;
        case visibility_type::BOOMER:
            light_name = "lighting_boomered_light";
            break;
        case visibility_type::BOOMER_DARK:
            light_name = "lighting_boomered_dark";
            break;
        case visibility_type::DARK:
            light_name = "lighting_lowlight_dark";
            break;
        case visibility_type::CLEAR:
            // should never happen
            break;
    }

    // lighting is never rotated, though, could possibly add in random rotation?
    draw_from_id_string( light_name, TILE_CATEGORY::LIGHTING, empty_string, pos, 0, 0,
                         lit_level::LIT, false, height_3d );

    return true;
}

const memorized_tile &cata_tiles::get_terrain_memory_at( const tripoint_abs_ms &p ) const
{
    const memorized_tile &mt = get_avatar().get_memorized_tile( p );
    if( !mt.get_ter_id().empty() ) {
        return mt;
    }
    return mm_submap::default_tile;
}

const memorized_tile &cata_tiles::get_furniture_memory_at( const tripoint_abs_ms &p ) const
{
    const memorized_tile &mt = get_avatar().get_memorized_tile( p );
    if( string_starts_with( mt.get_dec_id(), "f_" ) ) {
        return mt;
    }
    return mm_submap::default_tile;
}

const memorized_tile &cata_tiles::get_trap_memory_at( const tripoint_abs_ms &p ) const
{
    const memorized_tile &mt = get_avatar().get_memorized_tile( p );
    if( string_starts_with( mt.get_dec_id(), "tr_" ) ) {
        return mt;
    }
    return mm_submap::default_tile;
}

const memorized_tile &cata_tiles::get_vpart_memory_at( const tripoint_abs_ms &p ) const
{
    const memorized_tile &mt = get_avatar().get_memorized_tile( p );
    if( string_starts_with( mt.get_dec_id(), "vp_" ) ) {
        return mt;
    }
    return mm_submap::default_tile;
}

void cata_tiles::draw_square_below( const point_bub_ms &p, const nc_color &col,
                                    const int sizefactor )
{
    const SDL_Color sdlcol = curses_color_to_SDL( col );
    SDL_Rect sdlrect;
    const point screen = player_to_screen( p );
    if( is_isometric() ) {
        // See comments in get_window_base_tile_counts for an explanation of tile width and height
        // tw / sizefactor * 3.0 / 4.0
        sdlrect.w = ( tile_width * 3 ) / ( sizefactor * 4 );
        if( tile_width % 2 != sdlrect.w % 2 ) {
            sdlrect.w++;
        }
        // (tw / 2.0) / sizefactor * 3.0 / 4.0
        sdlrect.h = ( tile_width * 3 ) / ( sizefactor * 8 );
        if( tile_width / 2 % 2 != sdlrect.h % 2 ) {
            sdlrect.h++;
        }
        // scrx + (tw - rectw) / 2.0
        sdlrect.x = screen.x + divide_round_down( tile_width - sdlrect.w, 2 );
        // scry + th - tw / 2.0 + (tw / 2.0 - recth) / 2.0
        // Adding th and subtracting tw/2 here to cancel out the shifting in player_to_screen.
        sdlrect.y = screen.y + tile_height + divide_round_down( -tile_width - sdlrect.h * 2, 4 );
    } else {
        sdlrect.w = tile_width / sizefactor;
        if( tile_width % 2 != sdlrect.w % 2 ) {
            sdlrect.w++;
        }
        sdlrect.h = tile_height / sizefactor;
        if( tile_height % 2 != sdlrect.h % 2 ) {
            sdlrect.h++;
        }
        sdlrect.x = screen.x + divide_round_down( tile_width - sdlrect.w, 2 );
        sdlrect.y = screen.y + divide_round_down( tile_height - sdlrect.h, 2 );
    }
    geometry->rect( renderer, sdlrect, sdlcol );
}

bool cata_tiles::draw_terrain( const tripoint_bub_ms &p, const lit_level ll, int &height_3d,
                               const std::array<bool, 5> &invisible )
{
    map &here = get_map();
    const auto override = terrain_override.find( p );
    const bool overridden = override != terrain_override.end();
    bool neighborhood_overridden = overridden;
    if( !neighborhood_overridden ) {
        for( const point &dir : neighborhood ) {
            if( terrain_override.find( p + dir ) != terrain_override.end() ) {
                neighborhood_overridden = true;
                break;
            }
        }
    }
    // Normal path: read from the cache populated during the rebuild pass.
    // No live map access — terrain content and orientation were captured
    // when the draw cache was rebuilt (dirty-gated).
    if( !invisible[0] && !neighborhood_overridden ) {
        const tile_render_info::sprite &cap =
            std::get<tile_render_info::sprite>( m_cur_tile->var );

        if( !cap.ter_content ) {
            return false;
        }
        // Legacy mode does not draw fog sprites
        if( fov_3d_z_range == 0 && cap.ter_content.id().str() == "t_open_air" ) {
            return false;
        }
        return draw_from_id_string( cap.ter_content.id().str(), TILE_CATEGORY::TERRAIN, empty_string,
                                    p, cap.ter_content_subtile, cap.ter_content_rotation,
                                    ll, nv_goggles_activated, height_3d );
    }
    // Override / memory / invisible path: live-read from the map because
    // override previews and memory tiles are not captured into the cache.
    const ter_id &t = here.ter( p );
    const std::string &tname = t.id().str();
    // Legacy mode does not draw fog sprites
    if( fov_3d_z_range == 0 && tname == "t_open_air" ) {
        return false;
    }
    if( invisible[0] ? overridden : neighborhood_overridden ) {
        // and then draw the override terrain
        const ter_id &t2 = overridden ? override->second : t;
        if( t2 ) {
            // both the current and neighboring overrides may change the appearance
            // of the tile, so always re-calculate it.
            int subtile = 0;
            int rotation = 0;
            const std::bitset<NUM_TERCONN> &connect_group = t2.obj().connect_to_groups;
            const std::bitset<NUM_TERCONN> &rotate_group = t2.obj().rotate_to_groups;

            if( connect_group.any() ) {
                map::get_connect_values( p, subtile, rotation, connect_group, rotate_group,
                                         terrain_override );
            } else {
                map::get_terrain_orientation( p, rotation, subtile, terrain_override, invisible,
                                              rotate_group );
            }
            const std::string &tname = t2.id().str();
            // tile overrides are never memorized
            // tile overrides are always shown with full visibility
            const lit_level lit = overridden ? lit_level::LIT : ll;
            const bool nv = overridden ? false : nv_goggles_activated;
            return draw_from_id_string( tname, TILE_CATEGORY::TERRAIN, empty_string, p, subtile,
                                        rotation, lit, nv, height_3d );
        }
    } else if( invisible[0] ) {
        // try drawing memory if invisible and not overridden
        const memorized_tile &mt = get_terrain_memory_at( here.get_abs( p ) );
        if( !mt.get_ter_id().empty() ) {
            return draw_from_id_string(
                       mt.get_ter_id(), TILE_CATEGORY::TERRAIN, empty_string, p, mt.get_ter_subtile(),
                       mt.get_ter_rotation(), lit_level::MEMORIZED, nv_goggles_activated, height_3d );
        }
    }
    return false;
}

bool cata_tiles::draw_furniture( const tripoint_bub_ms &p, const lit_level ll, int &height_3d,
                                 const std::array<bool, 5> &invisible )
{
    map &here = get_map();
    const auto display_override =
        [this, &here]( const tripoint_bub_ms & q,
    const bool allow_vehicle_ladder ) -> std::optional<furn_id> {
        const auto override = furniture_override.find( q );
        if( override != furniture_override.end() )
        {
            return override->second;
        }
        return allow_vehicle_ladder ? here.vehicle_ladder_furniture_at( q ) : std::nullopt;
    };
    const auto explicit_override = furniture_override.find( p );
    const bool explicitly_overridden = explicit_override != furniture_override.end();
    std::optional<furn_id> override;
    if( explicitly_overridden ) {
        override = explicit_override->second;
    } else if( !invisible[0] ) {
        override = display_override( p, true );
    }
    const bool vehicle_ladder_overridden = override.has_value() && !explicitly_overridden;
    const bool overridden = override.has_value();
    bool neighborhood_overridden = overridden;
    if( !neighborhood_overridden ) {
        for( std::size_t i = 0; i < neighborhood.size(); ++i ) {
            if( display_override( p + neighborhood[i], !invisible[i + 1] ) ) {
                neighborhood_overridden = true;
                break;
            }
        }
    }
    // Normal path: read from the cache populated during the rebuild pass.
    // No live map access — furniture content and orientation were captured
    // when the draw cache was rebuilt (dirty-gated).
    if( !invisible[0] && !neighborhood_overridden ) {
        const tile_render_info::sprite &cap =
            std::get<tile_render_info::sprite>( m_cur_tile->var );

        if( !cap.furn_content ) {
            return false;
        }
        return draw_from_id_string( cap.furn_content.id().str(), TILE_CATEGORY::FURNITURE,
                                    empty_string, p, cap.furn_content_subtile,
                                    cap.furn_content_rotation,
                                    ll, nv_goggles_activated, height_3d );
    }
    // Override / memory / invisible path: live-read from the map because
    // override previews and memory tiles are not captured into the cache.
    const furn_id &f = here.furn( p );
    if( invisible[0] ? overridden : neighborhood_overridden ) {
        // and then draw the override furniture
        const furn_id f2 = overridden ? *override : f;
        if( f2 ) {
            // both the current and neighboring overrides may change the appearance
            // of the tile, so always re-calculate it.
            const auto furn = [&]( const tripoint_bub_ms & q, const bool invis ) -> furn_id {
                const std::optional<furn_id> override = display_override( q, !invis );
                return override ? *override :
                ( !overridden || !invis ) ? here.furn( q ) : furn_str_id::NULL_ID().id();
            };
            const std::array<int, 4> neighborhood = {
                static_cast<int>( furn( p + point::south, invisible[1] ) ),
                static_cast<int>( furn( p + point::east, invisible[2] ) ),
                static_cast<int>( furn( p + point::west, invisible[3] ) ),
                static_cast<int>( furn( p + point::north, invisible[4] ) )
            };
            int subtile = 0;
            int rotation = 0;
            const furn_id &tile_values_furn = vehicle_ladder_overridden ? f2 : f;
            const std::bitset<NUM_TERCONN> &connect_group = tile_values_furn.obj().connect_to_groups;
            const std::bitset<NUM_TERCONN> &rotate_group = tile_values_furn.obj().rotate_to_groups;

            if( connect_group.any() ) {
                map::get_furn_connect_values( p, subtile, rotation, connect_group, rotate_group, {} );
            } else {
                map::get_tile_values_with_ter( p, tile_values_furn.to_i(), neighborhood, subtile,
                                               rotation, rotate_group );
            }
            map::get_tile_values_with_ter( p, f2.to_i(), neighborhood, subtile, rotation, 0 );
            const std::string &fname = f2.id().str();
            // tile overrides are never memorized
            // tile overrides are always shown with full visibility
            const lit_level lit = explicitly_overridden ? lit_level::LIT : ll;
            const bool nv = explicitly_overridden ? false : nv_goggles_activated;
            return draw_from_id_string( fname, TILE_CATEGORY::FURNITURE, empty_string, p, subtile,
                                        rotation, lit, nv, height_3d );
        }
    } else if( invisible[0] ) {
        // try drawing memory if invisible and not overridden
        const memorized_tile &mt = get_furniture_memory_at( here.get_abs( p ) );
        if( !mt.get_dec_id().empty() ) {
            return draw_from_id_string(
                       mt.get_dec_id(), TILE_CATEGORY::FURNITURE, empty_string, p, mt.get_dec_subtile(),
                       mt.get_dec_rotation(), lit_level::MEMORIZED, nv_goggles_activated, height_3d );
        }
    }
    return false;
}

bool cata_tiles::draw_trap( const tripoint_bub_ms &p, const lit_level ll, int &height_3d,
                            const std::array<bool, 5> &invisible )
{
    const auto override = trap_override.find( p );
    const bool overridden = override != trap_override.end();
    bool neighborhood_overridden = overridden;
    if( !neighborhood_overridden ) {
        for( const point &dir : neighborhood ) {
            if( trap_override.find( p + dir ) != trap_override.end() ) {
                neighborhood_overridden = true;
                break;
            }
        }
    }

    // Normal path: read from the cache populated during the rebuild pass.
    // The rebuild only captures a trap when it is visible to the avatar
    // (tr.can_see gate), so a non-null trap_content here implies both
    // "trap present" and "trap visible to the observer".  No live map access.
    if( !invisible[0] && !neighborhood_overridden ) {
        const tile_render_info::sprite &cap =
            std::get<tile_render_info::sprite>( m_cur_tile->var );

        if( !cap.trap_content ) {
            return false;
        }
        return draw_from_id_string( cap.trap_content.id().str(), TILE_CATEGORY::TRAP, empty_string,
                                    p, cap.trap_content_subtile, cap.trap_content_rotation,
                                    ll, nv_goggles_activated, height_3d );
    }
    // Override / memory / invisible path: live-read from the map because
    // override previews and memory tiles are not captured into the cache.
    avatar &you = get_avatar();
    map &here = get_map();
    const trap &tr = here.tr_at( p );
    if( overridden || ( !invisible[0] && neighborhood_overridden &&
                        tr.can_see( p, you ) ) ) {
        // and then draw the override trap
        const trap_id &tr2 = overridden ? override->second : tr.loadid;
        if( tr2 ) {
            // both the current and neighboring overrides may change the appearance
            // of the tile, so always re-calculate it.
            const auto tr_at = [&]( const tripoint_bub_ms & q, const bool invis ) -> trap_id {
                const auto it = trap_override.find( q );
                return it != trap_override.end() ? it->second :
                                          ( !overridden || !invis ) ? here.tr_at( q ).loadid : tr_null;
            };
            const std::array<int, 4> neighborhood = {
                static_cast<int>( tr_at( p + point::south, invisible[1] ) ),
                static_cast<int>( tr_at( p + point::east, invisible[2] ) ),
                static_cast<int>( tr_at( p + point::west, invisible[3] ) ),
                static_cast<int>( tr_at( p + point::north, invisible[4] ) )
            };
            int subtile = 0;
            int rotation = 0;
            map::get_tile_values( tr2.to_i(), neighborhood, subtile, rotation, 0 );
            const std::string &trname = tr2.id().str();
            // tile overrides are never memorized
            // tile overrides are always shown with full visibility
            const lit_level lit = overridden ? lit_level::LIT : ll;
            const bool nv = overridden ? false : nv_goggles_activated;
            return draw_from_id_string( trname, TILE_CATEGORY::TRAP, empty_string, p, subtile,
                                        rotation, lit, nv, height_3d );
        }
    } else if( invisible[0] ) {
        // try drawing memory if invisible and not overridden
        const memorized_tile &mt = get_trap_memory_at( here.get_abs( p ) );
        if( !mt.get_dec_id().empty() ) {
            return draw_from_id_string(
                       mt.get_dec_id(), TILE_CATEGORY::TRAP, empty_string, p, mt.get_dec_subtile(),
                       mt.get_dec_rotation(),
                       lit_level::MEMORIZED, nv_goggles_activated, height_3d );
        }
    }
    return false;
}

bool cata_tiles::draw_part_con( const tripoint_bub_ms &p, const lit_level ll, int &height_3d,
                                const std::array<bool, 5> &invisible )
{
    // Draw the partial construction from the presence captured into the draw
    // cache during the rebuild pass (see draw_terrain). Captured only for
    // visible tiles, so the visibility gate mirrors the capture condition.
    const tile_render_info::sprite &cap =
        std::get<tile_render_info::sprite>( m_cur_tile->var );
    if( cap.part_con_content && !invisible[0] ) {
        std::string const &trname = tr_unfinished_construction.str();
        return draw_from_id_string( trname, TILE_CATEGORY::TRAP, empty_string, p, 0,
                                    0, ll, nv_goggles_activated, height_3d );
    }
    return false;
}

bool cata_tiles::draw_graffiti( const tripoint_bub_ms &p, const lit_level ll, int &height_3d,
                                const std::array<bool, 5> &invisible )
{
    map &here = get_map();
    const auto override = graffiti_override.find( p );
    const bool overridden = override != graffiti_override.end();
    // Determine graffiti text and rotation: cached (from the rebuild pass, see
    // draw_terrain) for the normal visible path; live for the override path,
    // whose transient previews are not captured into the cache. An empty cached
    // text means no graffiti was present on this visible tile.
    std::string graffiti_text;
    int rotation = 0;
    lit_level lit = ll;
    if( overridden ) {
        if( !override->second ) {
            return false;
        }
        // The override only toggles presence; the displayed text still comes
        // from the live map (overrides carry no graffiti text of their own).
        graffiti_text = here.graffiti_at( p );
        rotation = here.passable( p ) ? 1 : 0;
        lit = lit_level::LIT;
    } else {
        const tile_render_info::sprite &cap =
            std::get<tile_render_info::sprite>( m_cur_tile->var );
        if( invisible[0] || cap.graffiti_content.empty() ) {
            return false;
        }
        graffiti_text = cap.graffiti_content;
        rotation = cap.graffiti_content_rotation;
    }
    const std::string tile = "graffiti_" +
                             to_upper_case( string_replace( remove_punctuations( graffiti_text ), " ",
                                 "_" ) ).substr( 0, 32 );
    return draw_from_id_string( tileset_ptr->find_tile_type( tile ) ? tile : "graffiti",
                                TILE_CATEGORY::NONE, empty_string, p, 0, rotation, lit, false, height_3d );
}

bool cata_tiles::draw_field_or_item( const tripoint_bub_ms &p, const lit_level ll, int &height_3d,
                                     const std::array<bool, 5> &invisible )
{
    const auto fld_override = field_override.find( p );
    const bool fld_overridden = fld_override != field_override.end();
    // Primary field type from the per-frame draw-points cache.
    // fd_null means no displayable field is present on this tile.
    const tile_render_info::sprite &cap =
        std::get<tile_render_info::sprite>( m_cur_tile->var );
    const field_type_id &cached_fld = cap.field_content;
    const field_type_id &fld = fld_overridden ?
                               fld_override->second : cached_fld;
    const auto it_override = item_override.find( p );
    const bool it_overridden = it_override != item_override.end();

    // Empty field/item tiles are overwhelmingly common.  The per-frame cache
    // already tells us whether an item is visible, so avoid all live map reads
    // for the common case.
    if( !fld_overridden && !cached_fld && !it_overridden &&
        ( invisible[0] || !cap.sees_items || cap.item_count == 0 ) ) {
        return false;
    }

    // The full field object is needed only when a displayable live field was
    // captured.  Avoid resolving a submap for item-only and empty tiles.
    map &here = get_map();
    field *const f = !fld_overridden && cached_fld ? &here.field_at( p ) : nullptr;

    bool ret_draw_field = false;
    bool ret_draw_items = false;

    auto draw_layer_field = [&]( const std::string & terfurn_key,
    const lit_level & ll, const field_entry & fe, const std::array<int, 4> &neighborhood ) {
        auto itt = tileset_ptr->field_layer_data.find( terfurn_key );
        if( itt != tileset_ptr->field_layer_data.end() ) {
            const bool nv = nv_goggles_activated;
            int subtile = 0;
            int rotation = 0;
            map::get_tile_values( fld.to_i(), neighborhood, subtile, rotation, 0 );

            // go through all the layer variants
            for( const layer_context_sprites &layer_var : itt->second ) {
                if( fld.id().str() == layer_var.id ) {

                    // get the sprite to draw
                    // roll is based on the maptile seed to keep visuals consistent
                    int roll = simple_point_hash( p.xy().raw() ) % layer_var.total_weight;
                    std::string sprite_to_draw;
                    for( const auto &sprite_list : layer_var.sprite ) {
                        roll = roll - sprite_list.second;
                        if( roll < 0 ) {
                            sprite_to_draw = sprite_list.first;
                            break;
                        }
                    }

                    // if we have found info on the item go through and draw its stuff
                    ret_draw_field = draw_from_id_string( sprite_to_draw, TILE_CATEGORY::FIELD, empty_string, p,
                                                          subtile, rotation, ll, nv, height_3d, fe.get_field_intensity(), "", layer_var.offset );
                    break;
                }
            }
            return true;
        }
        return false;
    };

    auto draw_layer_item = [&]( const std::string & terfurn_key, const maptile & tile,
                                std::string & variant,
    bool & drawtop ) {
        // go through all the layer variants
        auto itt = tileset_ptr->item_layer_data.find( terfurn_key );
        if( itt != tileset_ptr->item_layer_data.end() ) {
            for( const layer_context_sprites &layer_var : itt->second ) {
                for( const item &i : tile.get_items() ) {
                    if( i.typeId().str() == layer_var.id ) {
                        // if an item matches draw it and break
                        const std::string layer_it_category = i.typeId()->get_item_type_string();
                        const lit_level layer_lit = ll;
                        const bool layer_nv = nv_goggles_activated;

                        // get the sprite to draw
                        // roll is based on the item seed to keep visuals consistent
                        int roll = i.seed % layer_var.total_weight;
                        std::string sprite_to_draw;
                        for( const auto &sprite_list : layer_var.sprite ) {
                            roll = roll - sprite_list.second;
                            if( roll < 0 ) {
                                sprite_to_draw = sprite_list.first;
                                break;
                            }
                        }

                        if( i.has_itype_variant() ) {
                            variant = i.itype_variant().id;
                        }
                        if( !layer_var.append_suffix.empty() ) {
                            variant += layer_var.append_suffix;
                        }
                        // if we have found info on the item go through and draw its stuff
                        draw_from_id_string( sprite_to_draw, TILE_CATEGORY::ITEM, layer_it_category, p, 0,
                                             0, layer_lit, layer_nv, height_3d, 0, variant, layer_var.offset );

                        // if the top item is already being layered don't draw it later
                        if( i.typeId() == tile.get_uppermost_item().typeId() ) {
                            drawtop = false;
                        }

                        break;
                    }
                }
            }
            return true;
        }
        return false;
    };

    // go through each field and draw it
    if( !fld_overridden && f ) {
        const maptile &tile = here.maptile_at( p );

        for( const std::pair<const field_type_id, field_entry> &fd_pr : *f ) {
            const field_type_id &fld = fd_pr.first;
            if( !invisible[0] && fld.obj().display_field ) {
                const lit_level lit = ll;

                auto has_field = [&]( field_type_id fld, const tripoint_bub_ms & q,
                const bool invis ) -> field_type_id {
                    // go through the fields and see if they are equal
                    field_type_id found = fd_null;
                    for( std::pair<const field_type_id, field_entry> &this_fld : here.field_at( q ) )
                    {
                        if( this_fld.first == fld ) {
                            found = fld;
                        }
                    }
                    const auto it = field_override.find( q );
                    return it != field_override.end() ? it->second :
                           ( !fld_overridden || !invis ) ?  found : fd_null;
                };
                // for rotation information
                const std::array<int, 4> neighborhood = { {
                        static_cast<int>( has_field( fld, p + point::south, invisible[1] ) ),
                        static_cast<int>( has_field( fld, p + point::east, invisible[2] ) ),
                        static_cast<int>( has_field( fld, p + point::west, invisible[3] ) ),
                        static_cast<int>( has_field( fld, p + point::north, invisible[4] ) )
                    }
                };

                int subtile = 0;
                int rotation = 0;
                map::get_tile_values( fld.to_i(), neighborhood, subtile, rotation, 0 );

                //get field intensity
                int intensity = fd_pr.second.get_field_intensity();

                // start by drawing the layering data if available
                bool has_drawn_field = draw_layer_field( tile.get_furn_t().id.str(), lit, fd_pr.second,
                    neighborhood );
                if( !has_drawn_field ) {
                    has_drawn_field = draw_layer_field( tile.get_ter_t().id.str(), lit, fd_pr.second,
                                                        neighborhood );
                }
                if( !has_drawn_field ) {
                    draw_from_id_string( fld.id().str(), TILE_CATEGORY::FIELD, empty_string,
                                         p, subtile, rotation, ll, nv_goggles_activated, height_3d, intensity );
                }
            }
        }
    } else if( fld_overridden ) {
        // draw the override
        const field_type_id &fld = fld_override->second;
        if( fld.obj().display_field ) {
            const lit_level lit = lit_level::LIT;

            auto field_at = [&]( const tripoint_bub_ms & q, const bool invis ) -> field_type_id {
                const auto it = field_override.find( q );
                return it != field_override.end() ? it->second :
                                           ( !fld_overridden || !invis ) ? here.field_at( q ).displayed_field_type() : fd_null;
            };
            // for rotation information
            const std::array<int, 4> neighborhood = {
                static_cast<int>( field_at( p + point::south, invisible[1] ) ),
                static_cast<int>( field_at( p + point::east, invisible[2] ) ),
                static_cast<int>( field_at( p + point::west, invisible[3] ) ),
                static_cast<int>( field_at( p + point::north, invisible[4] ) )
            };

            int subtile = 0;
            int rotation = 0;
            map::get_tile_values( fld.to_i(), neighborhood, subtile, rotation, 0 );

            //get field intensity
            int intensity = fld_overridden ? 0 : here.field_at( p ).displayed_intensity();
            ret_draw_field = draw_from_id_string( fld.id().str(), TILE_CATEGORY::FIELD, empty_string,
                                                  p, subtile, rotation, lit, false, height_3d, intensity );
        }
    }

    if( fld.obj().display_items ) {
        itype_id it_id;
        mtype_id mon_id;
        std::string variant;
        bool hilite = false;
        bool drawtop = true;
        const itype *it_type;
        const maptile &tile = here.maptile_at( p );

        if( !invisible[0] ) {
            bool has_drawn_item = draw_layer_item( tile.get_furn_t().id.str(), tile, variant, drawtop );
            // start by drawing the layering data if available
            // attempt furniture ids, then flags, then terrain ids, then flags
            if( !has_drawn_item ) {
                for( const std::string &f : tile.get_furn_t().get_flags() ) {
                    has_drawn_item |= draw_layer_item( f, tile, variant, drawtop );
                }
                if( !has_drawn_item ) {
                    has_drawn_item = draw_layer_item( tile.get_ter_t().id.str(), tile, variant, drawtop );
                    if( !has_drawn_item ) {
                        for( const std::string &f : tile.get_ter_t().get_flags() ) {
                            draw_layer_item( f, tile, variant, drawtop );
                        }
                    }
                }
            }
        }

        variant.clear();
        if( drawtop || it_overridden ) {
            if( it_overridden ) {
                it_id = std::get<0>( it_override->second );
                mon_id = std::get<1>( it_override->second );
                hilite = std::get<2>( it_override->second );
                it_type = item::find_type( it_id );
            } else if( !invisible[0] && cap.sees_items ) {
                it_id = cap.item_content;
                mon_id = cap.item_corpse_mtype;
                if( !cap.item_variant.empty() ) {
                    variant = cap.item_variant;
                }
                hilite = cap.item_count > 1;
                it_type = item::find_type( it_id );
            } else {
                it_type = nullptr;
            }
            if( it_type && !it_id.is_null() ) {

                const std::string disp_id = it_id == itype_corpse && mon_id ?
                                            "corpse_" + mon_id.str() : it_id.str();
                const std::string it_category = it_type->get_item_type_string();
                const lit_level lit = it_overridden ? lit_level::LIT : ll;
                const bool nv = it_overridden ? false : nv_goggles_activated;

                ret_draw_items = draw_from_id_string( disp_id, TILE_CATEGORY::ITEM, it_category, p, 0,
                                                      0, lit, nv, height_3d, 0, variant );
                if( ret_draw_items && hilite ) {
                    draw_item_highlight( p, height_3d );
                }
            }
        }
        // we may still need to draw the highlight
        else if( cap.item_count > 1 && cap.sees_items ) {
            draw_item_highlight( p, height_3d );
        }
    }
    return ret_draw_field && ret_draw_items;
}

bool cata_tiles::draw_vpart_no_roof( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                     const std::array<bool, 5> &invisible )
{
    return draw_vpart( p, ll, height_3d, invisible, false );
}

bool cata_tiles::draw_vpart_roof( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                  const std::array<bool, 5> &invisible )
{
    return draw_vpart( p, ll, height_3d, invisible, true );
}

bool cata_tiles::draw_vpart( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                             const std::array<bool, 5> &invisible, bool roof )
{
    const tile_render_info::sprite &cap =
        std::get<tile_render_info::sprite>( m_cur_tile->var );

    if( cap.vpart_content.is_null() ) {
        return false;
    }

    if( !invisible[0] ) {
        // Normal or override path — both read from the per-frame cache
        int height_3d_temp = height_3d;
        pending_part_tint_ = cap.vpart_tint;
        const bool ret = draw_from_id_string(
                             "vp_" + cap.vpart_content.str(),
                             TILE_CATEGORY::VEHICLE_PART, empty_string, p,
                             cap.vpart_subtile, cap.vpart_rotation, ll,
                             nv_goggles_activated, height_3d_temp, 0,
                             cap.vpart_variant );
        pending_part_tint_ = std::nullopt;
        if( ret && cap.vpart_has_cargo ) {
            draw_item_highlight( p, height_3d_temp );
        }
        if( !roof ) {
            height_3d = height_3d_temp;
        }
        if( ret && !cap.vpart_carried_furn.empty() ) {
            draw_from_id_string( cap.vpart_carried_furn,
                                 TILE_CATEGORY::FURNITURE, empty_string, p, 0,
                                 angle_to_dir4( 0_degrees ), ll,
                                 nv_goggles_activated, height_3d );
        }
        return ret;
    } else if( !roof ) {
        // Memory path: invisible, no-roof only.
        // Use a local copy of height_3d so the memory tile does not
        // affect z-ordering of tiles drawn after it.
        int height_3d_mem = height_3d;
        return draw_from_id_string(
                   cap.vpart_content.str(),
                   TILE_CATEGORY::VEHICLE_PART, empty_string, p,
                   cap.vpart_subtile, cap.vpart_rotation,
                   lit_level::MEMORIZED, nv_goggles_activated,
                   height_3d_mem, 0, cap.vpart_variant );
    }
    return false;
}

bool cata_tiles::draw_vehicle_preview( const catacurses::window &w_disp, const vehicle &veh,
                                       const point_rel_ms &cursor_vp_mount, int &cpart )
{
    // Reuses the normal map sprite path (draw_from_id_string, exactly as draw_vpart does) to
    // render the vehicle into an arbitrary curses window, without modifying the core renderer.
    // The trick: temporarily repoint the draw origin (o/op) and scale at the target window, draw
    // each part at a synthetic tile coordinate relative to the cursor, then restore on exit.

    // Isometric tilesets use a different projection that this simple rectangular grid does
    // not handle; signal the caller to fall back to the ASCII display.
    if( is_isometric() ) {
        return false;
    }

    // This temporarily rescales the shared tile context. cata_tiles::draw() does not reset
    // the scale every frame, so we must restore it before returning or the map would stay
    // at the preview scale.
    const int saved_zoom = g->get_zoom();
    // Fixed preview scale (16 == native tile size). Lower it to fit more of large vehicles.
    constexpr int preview_scale = 16;
    set_draw_scale( preview_scale );

    // Target window rectangle, in screen pixels.
    const window_dimensions dim = get_window_dimensions( w_disp );
    const point win_px_beg = dim.window_pos_pixel;
    const point win_px_size = dim.window_size_pixel;
    const point center_px = win_px_beg + win_px_size / 2;

    // Repurpose the draw origin so a synthetic tile coordinate maps straight to a screen
    // pixel: player_to_screen( pos ) == op + ( pos - o ) * { tile_width, tile_height } in the
    // non-isometric case. With o == (0,0) and op == window centre, synthetic tile (0,0)
    // lands at the centre, where the cursor part is drawn.
    o = point::zero;
    op = center_px;

    // Clip to the panel so an oversized vehicle does not bleed into neighbouring windows.
    const SDL_Rect clip{ win_px_beg.x, win_px_beg.y, win_px_size.x, win_px_size.y };
    RenderSetClipRect( renderer, &clip );

    int center_part = -1;
    // One sprite per structural square, mirroring the ASCII display_veh().
    for( const int part_idx : veh.all_parts_at_location( vpart_location_structure ) ) {
        const vehicle_part &vp = veh.part( part_idx );
        const vpart_display vd = veh.get_display_of_tile( vp.mount, false, false );
        if( vd.id.is_null() ) {
            continue;
        }
        // Same fixed, heading-independent layout transform the ASCII view uses.
        const point_rel_ms q = ( vp.mount + cursor_vp_mount ).rotate( 3 );
        const tripoint_bub_ms screen_tile( tripoint( q.x(), q.y(), 0 ) );
        const int subtile = vd.is_open ? open_ : vd.is_broken ? broken : 0;
        // Canonical (un-rotated) orientation, the tile analogue of the ASCII path's
        // rotate=false symbols. If the whole vehicle looks rotated by a multiple of 90
        // degrees, change this to 1, 2 or 3.
        const int rotation = 0;
        int height_3d = 0;
        // Tint with the DISPLAYED part's paint (which may be a board/door on top
        // of this structure frame), mirroring the main-map path. The frame itself
        // is never colored by a palette, so checking vp here would always be empty.
        pending_part_tint_ = get_vpart_tint( veh, vp.mount );
        draw_from_id_string( "vp_" + vd.id.str(), TILE_CATEGORY::VEHICLE_PART, empty_string,
                             screen_tile, subtile, rotation, lit_level::LIT, false, height_3d, 0,
                             vd.variant.id );
        pending_part_tint_ = std::nullopt;
        if( vd.has_cargo ) {
            // Cargo space holding items: overlay the item-highlight, as the map path does.
            draw_item_highlight( screen_tile, height_3d );
        }
        if( q == point_rel_ms::zero ) {
            center_part = part_idx;   // the part under the cursor, drawn at the window centre
        }
    }
    cpart = center_part;

    // Mark the selected cell with the "cursor" sprite (the yellow selection box, the same
    // sprite the look-around cursor uses). The cursor part is at the synthetic origin, i.e.
    // the window centre. Drawn after the parts so it sits on top, and still inside the clip.
    draw_from_id_string( "cursor", tripoint_bub_ms( tripoint::zero ), 0, 0, lit_level::LIT,
                         false );

    // Restore the clip rectangle and the map draw scale.
    RenderSetClipRect( renderer, nullptr );
    set_draw_scale( saved_zoom );
    return true;
}

SDL_Texture *cata_tiles::render_character_preview( const Character &ch, const int scale,
        int &out_w, int &out_h )
{
    // The paper-doll preview reuses the normal map sprite path (draw_entity_with_overlays,
    // the same routine that paints the player on the map) but redirects the draw origin and
    // render target at an offscreen texture, the same trick draw_vehicle_preview uses for the
    // vehicle construction UI. Isometric tilesets use a projection this flat layout does not
    // handle, so bail and let the caller show nothing.
    out_w = 0;
    out_h = 0;
    if( is_isometric() || scale <= 0 ) {
        return nullptr;
    }

    // draw() resets o/op every map frame, so they need no manual restore, but set_draw_scale
    // persists across frames; capture and restore it like draw_vehicle_preview does.
    const int saved_zoom = g->get_zoom();
    set_draw_scale( scale );

    // Character sprites are not tile-sized: they carry per-sprite offsets and overlays (hair,
    // hats, mutations) that extend above and around the base tile by an amount that varies per
    // tileset. Rather than guess a headroom that fits every case, draw into a generous work
    // canvas, then read the rendered pixels back to find the tight non-transparent bounding box
    // and crop to exactly that. This removes the dead space above the sprite for any tileset.
    const int work_w = tile_width * 3;
    const int work_h = tile_height * 3;
    if( work_w <= 0 || work_h <= 0 ) {
        set_draw_scale( saved_zoom );
        return nullptr;
    }

    if( !char_preview_work_tex || char_preview_work_w != work_w || char_preview_work_h != work_h ) {
        char_preview_work_tex = CreateTexture( renderer, SDL_PIXELFORMAT_ARGB8888,
                                               SDL_TEXTUREACCESS_TARGET, work_w, work_h );
        if( !char_preview_work_tex ) {
            set_draw_scale( saved_zoom );
            return nullptr;
        }
        SetTextureBlendMode( char_preview_work_tex, SDL_BLENDMODE_BLEND );
        char_preview_work_w = work_w;
        char_preview_work_h = work_h;
    }

    // Place the base tile centred horizontally and one tile up from the bottom, leaving a full
    // tile of margin on every side so even large overlays land inside the work canvas.
    op = point( tile_width, work_h - tile_height * 2 );
    o = point::zero;
    m_entity_draw_offset = point::zero;

    // Pixel buffer for readback: ARGB8888, 4 bytes per pixel.
    std::vector<uint32_t> pixels( static_cast<size_t>( work_w ) * work_h, 0 );
    bool drawn = false;
    {
        scoped_render_target preview_scope( renderer, char_preview_work_tex.get()
#if SDL_MAJOR_VERSION >= 3
                                            , get_shared_variant_pass()
#endif
                                          );
        if( preview_scope.is_valid() ) {
            const SDL_Rect clip{ 0, 0, work_w, work_h };
            RenderSetClipRect( renderer, &clip );
            SetRenderDrawColor( renderer, 0, 0, 0, 0 );
            RenderClear( renderer );

            int height_3d = 0;
            // Force a stable right-facing pose regardless of the avatar's current facing.
            draw_entity_with_overlays( ch, tripoint_bub_ms( tripoint::zero ), lit_level::BRIGHT,
                                       height_3d, FacingDirection::RIGHT );

            const SDL_Rect full{ 0, 0, work_w, work_h };
            drawn = RenderReadPixels( renderer, &full, SDL_PIXELFORMAT_ARGB8888, pixels.data(),
                                      work_w * 4 );
            RenderSetClipRect( renderer, nullptr );
        }
    }

    if( !drawn ) {
        set_draw_scale( saved_zoom );
        return nullptr;
    }

    // Scan for the bounding box of any non-zero (non-transparent) pixel. The canvas was cleared
    // to all-zero bytes, so a pixel is "drawn" iff it is non-zero -- no need to assume which byte
    // is alpha, sidestepping format/endianness concerns.
    point min( work_w, work_h );
    point max = point::north_west;
    for( int y = 0; y < work_h; y++ ) {
        const uint32_t *row = pixels.data() + static_cast<size_t>( y ) * work_w;
        for( int x = 0; x < work_w; x++ ) {
            if( row[x] != 0 ) {
                min.x = std::min( min.x, x );
                max.x = std::max( max.x, x );
                min.y = std::min( min.y, y );
                max.y = std::max( max.y, y );
            }
        }
    }

    if( max.x < min.x || max.y < min.y ) {
        // Nothing was drawn (e.g. a tileset with no player sprite); show nothing.
        set_draw_scale( saved_zoom );
        return nullptr;
    }

    const int crop_w = max.x - min.x + 1;
    const int crop_h = max.y - min.y + 1;

    // (Re)allocate the cropped result target at the exact bounding-box size, so ImGui::Image
    // samples it with default 0..1 UVs and no padding shows around the sprite.
    if( !char_preview_tex || char_preview_w != crop_w || char_preview_h != crop_h ) {
        char_preview_tex = CreateTexture( renderer, SDL_PIXELFORMAT_ARGB8888,
                                          SDL_TEXTUREACCESS_TARGET, crop_w, crop_h );
        if( !char_preview_tex ) {
            set_draw_scale( saved_zoom );
            return nullptr;
        }
        SetTextureBlendMode( char_preview_tex, SDL_BLENDMODE_BLEND );
        char_preview_w = crop_w;
        char_preview_h = crop_h;
    }

    SDL_Texture *result = nullptr;
    {
        scoped_render_target crop_scope( renderer, char_preview_tex.get()
#if SDL_MAJOR_VERSION >= 3
                                         , get_shared_variant_pass()
#endif
                                       );
        if( crop_scope.is_valid() ) {
            SetRenderDrawColor( renderer, 0, 0, 0, 0 );
            RenderClear( renderer );
            const SDL_Rect src{ min.x, min.y, crop_w, crop_h };
            const SDL_Rect dst{ 0, 0, crop_w, crop_h };
            RenderCopy( renderer, char_preview_work_tex, &src, &dst );
            result = char_preview_tex.get();
            out_w = crop_w;
            out_h = crop_h;
        }
    }

    set_draw_scale( saved_zoom );
    return result;
}

bool cata_tiles::draw_critter_at( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                  const std::array<bool, 5> &invisible )
{
    const map &here = get_map();

    // Fast path: with no creature on this tile (and no debug monster override
    // active), there is nothing to draw here — skip the creature_at hash lookup.
    if( monster_override.empty() && m_creature_positions.find( p ) == m_creature_positions.end() ) {
        return false;
    }

    // Apply creature animation offsets (move glide, got-hit reaction, attack lunge)
    // to this sprite. Guarded so terrain and everything drawn afterward keep a zero
    // offset. All kinds defer to the post-z-level overlay pass so the offset sprite
    // sits on top of terrain instead of being overdrawn by rows painted later.
    restore_on_out_of_scope restore_entity_offset( m_entity_draw_offset );
    if( !m_creature_anims.empty() || !m_creature_hit_anims.empty() ||
        !m_creature_attack_anims.empty() ) {
        const tripoint_abs_ms abs = here.get_abs( p );
        const auto move_it = m_creature_anims.find( abs );
        const auto hit_it = m_creature_hit_anims.find( abs );
        const auto atk_it = m_creature_attack_anims.find( abs );
        const bool has_move = move_it != m_creature_anims.end();
        const bool has_hit = hit_it != m_creature_hit_anims.end();
        const bool has_atk = atk_it != m_creature_attack_anims.end();
        if( has_move || has_hit || has_atk ) {
            // Keep the idle redraw heartbeat alive while any animation is active.
            has_animated_tiles_ = true;
            // Pixel vector for moving one tile in direction d, in this view's basis
            // (handles isometric and zoom exactly).
            const point screen_here = player_to_screen( p.xy() );
            const auto tile_dir_to_px = [&]( const point & d ) -> point {
                const point screen_there = player_to_screen( p.xy() + point_rel_ms( d.x, d.y ) );
                return screen_there - screen_here;
            };
            point off;
            if( has_move ) {
                const creature_move_anim &anim = move_it->second;
                // Remaining fraction of the trip back to the old tile.
                const float t = move_anim_eased( anim.curve, anim.progress );
                const float back = 1.0f - t;
                const point raw_delta = tile_dir_to_px( anim.delta_tiles );
                off.x += static_cast<int>( raw_delta.x * back );
                off.y += static_cast<int>( raw_delta.y * back );
                // Half-tile vertical hop (curve-dependent shape; zero for smooth).
                const float h = move_anim_hop( anim.curve, anim.progress );
                if( h != 0.0f ) {
                    off.y -= static_cast<int>( h * ( tile_height * 0.5f ) );
                }
            }
            if( has_hit ) {
                const creature_hit_anim &anim = hit_it->second;
                if( anim.dir_tiles.x != 0 || anim.dir_tiles.y != 0 ) {
                    // Horizontal knockback: pushed away from the attacker and back.
                    const float k = lunge_out_and_back( anim.progress ) * anim.magnitude_tiles;
                    const point dir_px = tile_dir_to_px( anim.dir_tiles );
                    off.x += static_cast<int>( dir_px.x * k );
                    off.y += static_cast<int>( dir_px.y * k );
                } else {
                    // Vertical pop-and-fall, on top of any glide motion.
                    const float b = hit_anim_bounce( anim.progress );
                    off.y -= static_cast<int>( b * ( tile_height * anim.magnitude_tiles ) );
                }
            }
            if( has_atk ) {
                // Lunge toward the struck target and back.
                const creature_attack_anim &anim = atk_it->second;
                const float l = lunge_out_and_back( anim.progress ) * anim.dist_tiles;
                const point dir_px = tile_dir_to_px( anim.dir_tiles );
                off.x += static_cast<int>( dir_px.x * l );
                off.y += static_cast<int>( dir_px.y * l );
            }
            // Defer to the post-row overlay pass ONLY when the sprite is pushed DOWN
            // (off.y > 0), i.e. it visually intrudes into the tile row to the south.
            // That southern row is painted later, so it would overdraw the intruding
            // part of this sprite — the "moving up gets covered by the ground"
            // artifact the deferred pass exists to fix. When the sprite stays put
            // vertically or moves up/north (off.y <= 0, including pure east/west
            // glides and upward hops), it only intrudes into already-painted northern
            // rows, so the normal in-place draw is correct and keeps natural painter
            // occlusion: tall terrain and creatures south of the mover still cover it.
            if( m_collecting_glide_critters && off.y > 0 ) {
                m_deferred_glide_critters.push_back( { p, ll, height_3d, invisible } );
                return false;
            }
            m_entity_draw_offset = off;
        }
    }

    bool result;
    bool is_player;
    bool sees_player;
    Creature::Attitude attitude;
    Character &you = get_player_character();
    const Creature *pcritter = get_creature_tracker().creature_at( p, true );
    // creature_at returns monsters first. If the monster is underwater beneath a
    // solid surface (invisible), fall back to the player/NPC sharing the tile.
    if( pcritter != nullptr && pcritter->is_underwater() &&
        here.has_flag( ter_furn_flag::TFLAG_SWIM_UNDER, p ) &&
        !you.is_underwater() ) {
        if( you.pos_bub() == p ) {
            pcritter = &you;
        } else {
            pcritter = get_creature_tracker().creature_at<npc>( p );
        }
    }
    const bool always_visible = pcritter && pcritter->has_flag( mon_flag_ALWAYS_VISIBLE );
    const auto override = monster_override.find( p );
    if( override != monster_override.end() ) {
        const mtype_id id = std::get<0>( override->second );
        if( !id ) {
            return false;
        }
        is_player = false;
        sees_player = false;
        attitude = std::get<3>( override->second );
        const std::string &chosen_id = id.str();
        const std::string &ent_subcategory = id.obj().species.empty() ?
                                             empty_string : id.obj().species.begin()->str();
        result = draw_from_id_string( chosen_id, TILE_CATEGORY::MONSTER, ent_subcategory, p,
                                      corner, 0, lit_level::LIT, false, height_3d );
    } else if( !invisible[0] || always_visible ) {
        if( pcritter == nullptr ) {
            return false;
        }
        const Creature &critter = *pcritter;

        if( !you.sees( here, critter ) ) {
            const_dialogue d( get_const_talker_for( you ), get_const_talker_for( critter ) );
            enchant_cache::special_vision sees_with_special = you.enchantment_cache->get_vision( d );
            if( !sees_with_special.is_empty() ) {
                const enchant_cache::special_vision_descriptions special_vis_desc =
                    you.enchantment_cache->get_vision_description_struct( sees_with_special, d );
                return draw_from_id_string( special_vis_desc.id, TILE_CATEGORY::NONE, empty_string, p, 0, 0,
                                            lit_level::LIT, false, height_3d );
            }
            return false;
        }
        result = false;
        sees_player = false;
        is_player = false;
        attitude = Creature::Attitude::ANY;
        const monster *m = dynamic_cast<const monster *>( &critter );
        if( m != nullptr ) {
            const TILE_CATEGORY ent_category = TILE_CATEGORY::MONSTER;
            std::string ent_subcategory = empty_string;
            if( !m->type->species.empty() ) {
                ent_subcategory = m->type->species.begin()->str();
            }
            const int subtile = corner;
            // depending on the toggle flip sprite left or right
            int rot_facing = -2;
            if( m->facing == FacingDirection::RIGHT ) {
                rot_facing = 0;
            } else if( m->facing == FacingDirection::LEFT ) {
                rot_facing = -1;
            }
            if( rot_facing >= -1 ) {
                std::string chosen_id = m->type->id.str();
                if( m->has_effect( effect_ridden ) ) {
                    int pl_under_height = 6;
                    if( m->mounted_player ) {
                        draw_entity_with_overlays( *m->mounted_player, p, ll, pl_under_height );
                    }
                    const std::string prefix = "rid_";
                    std::string copy_id = chosen_id;
                    const std::string ridden_id = copy_id.insert( 0, prefix );
                    const tile_type *tt = tileset_ptr->find_tile_type( ridden_id );
                    if( tt ) {
                        chosen_id = ridden_id;
                    }
                }

                if( m->has_flag( mon_flag_COPY_SUMMONER_LOOK ) && m->get_summoner() != nullptr ) {
                    const Character *caster_char = m->get_summoner()->as_character();
                    if( caster_char != nullptr ) {
                        // caster is character
                        draw_entity_with_overlays( *caster_char, p, ll, height_3d, m->facing );
                        result = true;
                    }
                    const monster *caster_mon = m->get_summoner()->as_monster();
                    if( caster_mon != nullptr ) {
                        // caster is another monster
                        result = draw_from_id_string( caster_mon->type->id.str(), ent_category, ent_subcategory, p,
                                                      subtile, rot_facing, ll, false, height_3d );
                    }
                } else if( m->has_flag( mon_flag_COPY_AVATAR_LOOK ) ) {
                    draw_entity_with_overlays( *get_avatar().as_character(), p, ll, height_3d, m->facing );
                } else {
                    result = draw_from_id_string( chosen_id, ent_category, ent_subcategory, p,
                                                  subtile, rot_facing, ll, false, height_3d );
                }

                draw_entity_with_overlays( *m, p, ll, height_3d );
                sees_player = m->sees( here, you );
                attitude = m->attitude_to( you );
            }
        }
        const Character *pl = dynamic_cast<const Character *>( &critter );
        if( pl != nullptr ) {
            draw_entity_with_overlays( *pl, p, ll, height_3d );
            result = true;
            if( pl->is_avatar() ) {
                is_player = true;
            } else {
                sees_player = pl->sees( here, you );
                attitude = pl->attitude_to( you );
            }
        }
    } else {
        // invisible
        if( pcritter == nullptr ) {
            return false;
        }
        const_dialogue d( get_const_talker_for( you ), get_const_talker_for( *pcritter ) );
        const enchant_cache::special_vision sees_with_special = you.enchantment_cache->get_vision( d );
        if( !sees_with_special.is_empty() ) {

            const bool scope_is_blocking = you.is_avatar() && ( you.as_avatar()->cant_see( p ) ||
                sees_with_special.ignores_aiming_cone );
            if( !scope_is_blocking ) {
                const enchant_cache::special_vision_descriptions special_vis_desc =
                    you.enchantment_cache->get_vision_description_struct( sees_with_special, d );
                return draw_from_id_string( special_vis_desc.id, TILE_CATEGORY::NONE, empty_string, p,
                                            0, 0, lit_level::LIT, false, height_3d );
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    if( result && !is_player && show_creature_overlay_icons ) {
        // Attitude/sees-player icons are UI overlays, not body sprites.
        // Exclude from tint bounds and tint replay tracking.
        sprite_screen_bounds *saved_bounds = m_cur_bounds;
        auto *saved_tint = m_cur_tint_sprites;
        m_cur_bounds = nullptr;
        m_cur_tint_sprites = nullptr;
        std::string draw_id = "overlay_" + Creature::attitude_raw_string( attitude );
        if( sees_player && !you.has_trait( trait_INATTENTIVE ) ) {
            draw_id += "_sees_player";
        }
        if( tileset_ptr->find_tile_type( draw_id ) ) {
            draw_from_id_string( draw_id, TILE_CATEGORY::NONE, empty_string, p, 0, 0,
                                 lit_level::LIT, false, height_3d );
        }
        m_cur_bounds = saved_bounds;
        m_cur_tint_sprites = saved_tint;
    }
    return result;
}

bool cata_tiles::draw_critter_above( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                     const std::array<bool, 5> &invisible )
{
    if( invisible[0] ) {
        return false;
    }

    // No creature anywhere in this (x,y) column — nothing can cast a shadow down
    // onto this tile, so skip the upward creature_at scan entirely. This is the
    // common case (creatures are sparse); only columns that actually contain a
    // creature pay for the scan.
    if( m_creature_columns.find( p.xy() ) == m_creature_columns.end() ) {
        return false;
    }

    tripoint_bub_ms scan_p( p + tripoint::above );
    map &here = get_map();
    Character &you = get_player_character();
    const Creature *pcritter = nullptr;
    // Search for a creature above
    while( pcritter == nullptr && scan_p.z() <= OVERMAP_HEIGHT &&
           !here.dont_draw_lower_floor( scan_p ) &&
           scan_p.z() - you.posz() <= fov_3d_z_range ) {
        pcritter = get_creature_tracker().creature_at( scan_p, true );
        scan_p.z()++;
    }

    // Abort if no creature found
    if( pcritter == nullptr ) {
        return false;
    }
    const Creature &critter = *pcritter;

    // Shadow and attitude icons are UI overlays, not body sprites.
    // Exclude from tint bounds and tint replay tracking.
    sprite_screen_bounds *saved_bounds = m_cur_bounds;
    auto *saved_tint = m_cur_tint_sprites;
    m_cur_bounds = nullptr;
    m_cur_tint_sprites = nullptr;

    // Draw shadow
    if( draw_from_id_string( "shadow", TILE_CATEGORY::NONE, empty_string, p,
                             0, 0, ll, false, height_3d ) && scan_p.z() - 1 > you.posz() && you.sees( here, critter ) ) {

        bool is_player = false;
        bool sees_player = false;
        Creature::Attitude attitude = Creature::Attitude::ANY;

        // Get critter status disposition if monster
        const monster *m = dynamic_cast<const monster *>( &critter );
        if( m != nullptr ) {
            sees_player = m->sees( here, you );
            attitude = m->attitude_to( you );
        }

        // Get critter status disposition if character
        const Character *pl = dynamic_cast<const Character *>( &critter );
        if( pl != nullptr ) {
            if( pl->is_avatar() ) {
                is_player = true;
            } else {
                sees_player = pl->sees( here, you );
                attitude = pl->attitude_to( you );
            }
        }

        // Draw overlay for shadow owner
        if( !is_player ) {
            std::string draw_id = "overlay_" + Creature::attitude_raw_string( attitude );
            if( sees_player && !you.has_trait( trait_INATTENTIVE ) ) {
                draw_id += "_sees_player";
            }
            if( tileset_ptr->find_tile_type( draw_id ) ) {
                draw_from_id_string( draw_id, TILE_CATEGORY::NONE, empty_string, p, 0, 0,
                                     lit_level::LIT, false, height_3d );
            }
        }
        m_cur_bounds = saved_bounds;
        m_cur_tint_sprites = saved_tint;
        return true;
    } else {
        m_cur_bounds = saved_bounds;
        m_cur_tint_sprites = saved_tint;
        return false;
    }
}

bool cata_tiles::draw_zone_mark( const tripoint_bub_ms &p, lit_level ll, int &height_3d,
                                 const std::array<bool, 5> &invisible )
{
    if( invisible[0] ) {
        return false;
    }

    if( !g->is_zones_manager_open() ) {
        return false;
    }

    const zone_manager &mgr = zone_manager::get_manager();
    const tripoint_abs_ms abs = get_map().get_abs( p );
    const zone_data *zone = mgr.get_bottom_zone( abs );

    if( zone && zone->has_options() ) {
        const mark_option *option = dynamic_cast<const mark_option *>( &zone->get_options() );

        if( option && !option->get_mark().empty() ) {
            return draw_from_id_string( option->get_mark(), TILE_CATEGORY::NONE, empty_string, p,
                                        0, 0, ll, nv_goggles_activated, height_3d );
        }
    }

    return false;
}

bool cata_tiles::draw_zombie_revival_indicators( const tripoint_bub_ms &pos, const lit_level /*ll*/,
        int &height_3d, const std::array<bool, 5> &invisible )
{
    if( invisible[0] || item_override.find( pos ) != item_override.end() ) {
        return false;
    }

    const tile_render_info::sprite &cap =
        std::get<tile_render_info::sprite>( m_cur_tile->var );
    if( !cap.sees_items || cap.item_count == 0 ) {
        return false;
    }

    map &here = get_map();
    for( item &i : here.i_at( pos ) ) {
        if( i.can_revive() ) {
            return draw_from_id_string( ZOMBIE_REVIVAL_INDICATOR, TILE_CATEGORY::NONE,
                                        empty_string, pos, 0, 0, lit_level::LIT, false, height_3d );
        }
    }
    return false;
}

void cata_tiles::draw_zlevel_overlay( const tripoint_bub_ms &p, const lit_level ll, int &height_3d )
{
    // Draws zlevel fog using geometry renderer
    // Slower than sprites so only use as fallback when sprite missing
    const point screen = player_to_screen( p.xy() );
    SDL_Rect draw_rect;
    if( is_isometric() ) {
        // See comments in get_window_base_tile_counts for an explanation of tile width
        // and height.
        //
        // Because different tilesets may have different tile shapes, we cannot
        // draw a tile that fits every tileset, so this only acts as a placeholder
        // and the tilesets should make a tile that matches the shape of other
        // sprites.
        draw_rect.x = screen.x;
        // scry
        // + th - tw / 2.0   /* cancel out the shifting in player_to_screen */
        // - height_3d
        // + tw / 8.0        /* shift 1/4 of normal height to avoid overlap among overlays */
        draw_rect.y = screen.y + tile_height - tile_width * 3 / 8 - height_3d;
        draw_rect.w = tile_width;
        // Make the tile half the normal height to avoid overlap among overlays
        draw_rect.h = tile_width / 4;
    } else {
        draw_rect.x = screen.x;
        draw_rect.y = screen.y - height_3d;
        draw_rect.w = tile_width;
        draw_rect.h = tile_height;
    }

    // Overlay color is based on light level
    SDL_Color fog_color = curses_color_to_SDL( c_black );
    if( ll == lit_level::BRIGHT_ONLY || ll == lit_level::BRIGHT || ll == lit_level::LIT ) {
        fog_color = curses_color_to_SDL( c_light_gray );
    } else if( ll == lit_level::LOW ) {
        fog_color = curses_color_to_SDL( c_dark_gray );
    }
    // Setting for fog transparency
    // On isometric tilesets, fog intensity scales with zlevel_height in tile_config.json
    fog_color.a = fog_alpha;

    // Change blend mode for transparency to work
    // Disable after to avoid visual bugs
    SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_BLEND );
    geometry->rect( renderer, draw_rect, fog_color );
    SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_NONE );
}

void cata_tiles::draw_entity_with_overlays( const Character &ch, const tripoint_bub_ms &p,
        lit_level ll, int &height_3d, const FacingDirection facing_override )
{
    std::vector<trait_id> override_look_muts = ch.get_functioning_mutations( true,
    false, []( const mutation_branch & mut ) {
        return mut.override_look.has_value();
    } );

    // TODO: make monster show proper effects instead of inheriting the one of a character
    const FacingDirection facing = facing_override == FacingDirection::NONE ? ch.facing :
                                   facing_override;

    // first draw the character itself(i guess this means a tileset that
    // takes this seriously needs a naked sprite)
    int prev_height_3d = height_3d;
    if( override_look_muts.empty() ) {
        std::string ent_name;

        if( ch.is_npc() ) {
            ent_name = ch.male ? "npc_male" : "npc_female";
        } else {
            ent_name = ch.male ? "player_male" : "player_female";
        }
        // depending on the toggle flip sprite left or right
        if( facing == FacingDirection::RIGHT ) {
            draw_from_id_string( ent_name, TILE_CATEGORY::NONE, "", p, corner, 0, ll, false,
                                 height_3d );
        } else if( facing == FacingDirection::LEFT ) {
            draw_from_id_string( ent_name, TILE_CATEGORY::NONE, "", p, corner, -1, ll, false,
                                 height_3d );
        }
    } else {
        mutation_branch::OverrideLook override_look = override_look_muts.at(
                0 ).obj().override_look.value();
        TILE_CATEGORY category;
        if( to_TILE_CATEGORY.find( override_look.tile_category ) != to_TILE_CATEGORY.end() ) {
            category = to_TILE_CATEGORY.at( override_look.tile_category );
        } else {
            debugmsg( "invalid tile category %s", override_look.tile_category );
            category = TILE_CATEGORY::NONE;
        }
        if( facing == FacingDirection::RIGHT ) {
            draw_from_id_string( override_look.id, category, "", p, corner, 0, ll, false,
                                 height_3d );
        } else if( facing == FacingDirection::LEFT ) {
            draw_from_id_string( override_look.id, category, "", p, corner, -1, ll, false,
                                 height_3d );
        }
    }

    // next up, draw all the overlays
    std::vector<std::pair<std::string, std::string>> overlays = override_look_muts.empty() ?
        ch.get_overlay_ids() : ch.get_overlay_ids_when_override_look();
    for( const std::pair<std::string, std::string> &overlay : overlays ) {
        std::string draw_id = overlay.first;
        if( find_overlay_looks_like( ch.male, overlay.first, overlay.second, draw_id ) ) {
            int overlay_height_3d = prev_height_3d;
            if( facing == FacingDirection::RIGHT ) {
                draw_from_id_string( draw_id, TILE_CATEGORY::NONE, "", p, corner, /*rota:*/ 0, ll,
                                     false, overlay_height_3d );
            } else if( facing == FacingDirection::LEFT ) {
                draw_from_id_string( draw_id, TILE_CATEGORY::NONE, "", p, corner, /*rota:*/ -1, ll,
                                     false, overlay_height_3d );
            }
            // the tallest height-having overlay is the one that counts
            height_3d = std::max( height_3d, overlay_height_3d );
        }
    }
}

void cata_tiles::draw_entity_with_overlays( const monster &mon, const tripoint_bub_ms &p,
        lit_level ll, int &height_3d )
{
    // TODO: move drawing the monster from draw_critter_at() here

    std::vector<std::pair<std::string, std::string>> overlays = mon.get_overlay_ids();
    for( const std::pair<std::string, std::string> &overlay : overlays ) {
        std::string draw_id = overlay.first;
        if( find_overlay_looks_like( true, overlay.first, overlay.second, draw_id ) ) {
            int overlay_height_3d = height_3d;
            if( mon.facing == FacingDirection::RIGHT ) {
                draw_from_id_string( draw_id, TILE_CATEGORY::NONE, "", p, corner, /*rota:*/ 0, ll,
                                     false, overlay_height_3d );
            } else if( mon.facing == FacingDirection::LEFT ) {
                draw_from_id_string( draw_id, TILE_CATEGORY::NONE, "", p, corner, /*rota:*/ -1, ll,
                                     false, overlay_height_3d );
            }

            height_3d = std::max( height_3d, overlay_height_3d );
        }
    }
}

bool cata_tiles::draw_item_highlight( const tripoint_bub_ms &pos, int &height_3d )
{
    return draw_from_id_string( ITEM_HIGHLIGHT, TILE_CATEGORY::NONE, empty_string, pos, 0, 0,
                                lit_level::LIT, false, height_3d );
}

std::shared_ptr<tileset> tileset_cache::find_fresh_cached( const tileset_cache_key &key,
        const uint64_t current_renderer_instance_gen, const uint64_t current_gpu_textures_gen ) const
{
    const auto it = tilesets_.find( key );
    if( it == tilesets_.end() ) {
        return nullptr;
    }
    std::shared_ptr<tileset> cached = it->second.lock();
    if( cached
        && cached->get_renderer_instance_generation_at_upload() == current_renderer_instance_gen
        && cached->get_gpu_textures_generation_at_upload() == current_gpu_textures_gen ) {
        return cached;
    }
    return nullptr;
}

std::shared_ptr<const tileset> tileset_cache::load_tileset( const std::string &tileset_id,
        const SDL_Renderer_Ptr &renderer, const bool precheck, const bool force, const bool pump_events,
        const bool terrain, const std::string &memory_map_mode,
        const uint64_t current_renderer_instance_gen, const uint64_t current_gpu_textures_gen,
        const atlas_upload_poll &poll, atlas_replay_quarantine *const quarantine,
        atlas_upload_interrupt *const out_interrupt )
{
    if( out_interrupt ) {
        *out_interrupt = atlas_upload_interrupt::none;
    }
    const tileset_cache_key key {
        tileset_id, memory_map_mode, compute_tileset_filter_fingerprint( memory_map_mode )
    };

    // Reuse a bundle uploaded against the current generations unless a reload
    // is forced. A metadata-only precheck bundle (empty id) is rebuilt when a
    // real load arrives.
    if( !force ) {
        if( std::shared_ptr<tileset> fresh = find_fresh_cached( key, current_renderer_instance_gen,
            current_gpu_textures_gen ) ) {
            if( precheck || !fresh->get_tileset_id().empty() ) {
                return fresh;
            }
        }
    }

    // Build the candidate in isolation and publish only on a fully successful
    // upload, so an interrupted load never replaces the live bundle in the
    // cache or in any consumer.
    std::shared_ptr<tileset> candidate = std::make_shared<tileset>();
    loader loader( *candidate, renderer, memory_map_mode );
    const atlas_upload_interrupt interrupt =
        loader.load( tileset_id, precheck, pump_events, terrain,
                     current_renderer_instance_gen, current_gpu_textures_gen, poll, quarantine );
    if( interrupt != atlas_upload_interrupt::none ) {
        if( out_interrupt ) {
            *out_interrupt = interrupt;
        }
        // Candidate dropped; its textures are already in the quarantine. The
        // cache entry and every live tileset_ptr stay on the previous bundle.
        return nullptr;
    }
    // load() recorded the generations on the bundle during upload.
    // insert_or_assign so an expired weak_ptr at this key is replaced instead
    // of being kept alongside a duplicate emplace attempt.
    tilesets_.insert_or_assign( key, candidate );
    return candidate;
}

void tileset_cache::release_live_atlases()
{
    for( auto it = tilesets_.begin(); it != tilesets_.end(); ) {
        std::shared_ptr<tileset> ts = it->second.lock();
        if( !ts ) {
            it = tilesets_.erase( it );
            continue;
        }
        ts->release_gpu_atlases();
        ++it;
    }
}

atlas_upload_interrupt tileset_cache::replay_live_atlases( const SDL_Renderer_Ptr &renderer,
        const uint64_t renderer_instance_gen, const uint64_t gpu_textures_gen,
        const atlas_upload_poll &poll, atlas_replay_quarantine &quarantine )
{
    for( auto it = tilesets_.begin(); it != tilesets_.end(); ) {
        if( poll ) {
            const atlas_upload_interrupt interrupt = poll();
            if( interrupt != atlas_upload_interrupt::none ) {
                return interrupt;
            }
        }
        std::shared_ptr<tileset> ts = it->second.lock();
        if( !ts ) {
            it = tilesets_.erase( it );
            continue;
        }
        const atlas_upload_interrupt interrupt =
            loader::upload_atlases( *ts, renderer, ts->get_memory_map_mode_at_upload(),
                                    ts->get_atlas_descriptors(), renderer_instance_gen,
                                    gpu_textures_gen, false, poll, &quarantine );
        if( interrupt != atlas_upload_interrupt::none ) {
            return interrupt;
        }
        ++it;
    }
    return atlas_upload_interrupt::none;
}


/* Animation Functions */
/* -- Inits */
void cata_tiles::init_explosion( const tripoint_bub_ms &p, int radius )
{
    do_draw_explosion = true;
    exp_pos = p;
    exp_rad = radius;
}
void cata_tiles::init_custom_explosion_layer( const std::map<tripoint_bub_ms, explosion_tile>
        &layer )
{
    do_draw_custom_explosion = true;
    custom_explosion_layer = layer;
}
effect_handle cata_tiles::init_explosion_light( const std::map<tripoint_bub_ms, float> &intensity,
        const explosion_light_str_id &effect,
        const tripoint_bub_ms &center, float radius_tiles,
        float per_ms, float end_progress,
        bool circular_shockwave,
        shockwave_state::sw_shape shock_shape,
        const tripoint_bub_ms &shock_target,
        float shock_half_angle )
{
    // Append a new asynchronous blast; existing ones keep playing (concurrent
    // overlap). It advances itself each frame via advance_explosion_lights().
    active_explosion_light a;
    a.radial = intensity;
    a.effect = effect;
    a.center = center;
    a.radius_tiles = radius_tiles;
    a.progress = 0.0f;
    a.per_ms = per_ms;
    a.end_progress = end_progress;
    a.circular_shockwave = circular_shockwave;
    a.shock_shape = shock_shape;
    a.shock_target = shock_target;
    a.shock_half_angle = shock_half_angle;
    m_explosion_lights.push_back( std::move( a ) );
    const effect_handle h = alloc_handle( effect_kind::explosion_light );
    m_explosion_lights.back().handle = h;
    return h;
}
// Elapsed steady-clock ms since the last tick stored in \p last_ms, capped so a
// long stall (pause, heavy turn) advances at most one frame's worth instead of
// jumping the whole effect. Updates \p last_ms and returns 0 on the priming call
// (when last_ms was empty) or when no positive time has passed. Shared by the
// wall-clock present effects (explosion lights, screen shake).
int64_t cata_tiles::capped_frame_dt_ms( std::optional<int64_t> &last_ms )
{
    const int64_t now_ms = std::chrono::duration_cast<std::chrono::milliseconds>(
                               std::chrono::steady_clock::now().time_since_epoch() ).count();
    if( !last_ms ) {
        last_ms = now_ms;
        return 0;
    }
    const int64_t dt_raw = now_ms - *last_ms;
    last_ms = now_ms;
    if( dt_raw <= 0 ) {
        return 0;
    }
    constexpr int64_t max_step_ms = 1000 / 15;
    return std::min( dt_raw, max_step_ms );
}
void cata_tiles::advance_explosion_lights()
{
    if( m_explosion_lights.empty() ) {
        m_explosion_light_last_ms.reset();
        // No blasts: make sure no stale distortion rings linger. The shockwave
        // list is only rebuilt by draw_explosion_light_frame(), which stops being
        // called once the list is empty, so clear it here instead.
        clear_shockwaves();
        return;
    }
    const int64_t dt = capped_frame_dt_ms( m_explosion_light_last_ms );
    if( dt <= 0 ) {
        return;
    }
    for( auto it = m_explosion_lights.begin(); it != m_explosion_lights.end(); ) {
        it->progress += it->per_ms * static_cast<float>( dt );
        bool erase_this = it->progress >= it->end_progress;
        // A centred blast leaves the bubble together with its centre.
        if( !erase_this && !get_map().inbounds( it->center ) ) {
            erase_this = true;
        }
        if( erase_this ) {
            m_handle_index.erase( it->handle );
            it = m_explosion_lights.erase( it );
        } else {
            ++it;
        }
    }
    // If the last blast just finished, drop its distortion ring now rather than
    // waiting for a frame draw that will no longer happen.
    if( m_explosion_lights.empty() ) {
        clear_shockwaves();
    }
}
void cata_tiles::advance_screen_shake_frame()
{
    if( !screen_shake_active() ) {
        m_screen_shake_last_ms.reset();
        return;
    }
    const int64_t dt = capped_frame_dt_ms( m_screen_shake_last_ms );
    if( dt <= 0 ) {
        return;
    }
    advance_screen_shake( dt );
}
effect_handle cata_tiles::init_bullet_anim( const std::vector<tripoint_bub_ms> &points,
        const std::vector<std::string> &sprites,
        const std::vector<int> &rotations,
        bool as_line, float per_ms )
{
    if( points.empty() ) {
        return 0;
    }
    active_bullet_anim anim;
    anim.points = points;
    anim.sprites = sprites;
    anim.rotations = rotations;
    anim.as_line = as_line;
    anim.per_ms = per_ms;
    constexpr float burst_gap_ms = 55.0f;
    constexpr float max_stagger_ms = 275.0f;
    const auto pending = std::count_if( m_bullet_anims.begin(), m_bullet_anims.end(),
    []( const active_bullet_anim & a ) {
        return a.head == 0.0f && a.life == 0.0f;
    } );
    anim.start_delay_ms = std::min( max_stagger_ms,
                                    burst_gap_ms * static_cast<float>( pending ) );
    m_bullet_anims.push_back( std::move( anim ) );
    const effect_handle h = alloc_handle( effect_kind::bullet );

    m_bullet_anims.back().handle = h;
    return h;
}
void cata_tiles::advance_bullet_anims()
{
    if( m_bullet_anims.empty() ) {
        m_bullet_anim_last_ms.reset();
        return;
    }
    const int64_t dt = capped_frame_dt_ms( m_bullet_anim_last_ms );
    if( dt <= 0 ) {
        return;
    }
    for( auto it = m_bullet_anims.begin(); it != m_bullet_anims.end(); ) {
        // Hold this shot frozen and invisible until its stagger delay elapses, then
        // spend only the leftover dt (the overshoot past zero) on its first step so
        // the rhythm stays even regardless of where the delay lands within a frame.
        float step_ms = static_cast<float>( dt );
        if( it->start_delay_ms > 0.0f ) {
            it->start_delay_ms -= step_ms;
            if( it->start_delay_ms > 0.0f ) {
                ++it;
                continue;
            }
            // Crossed zero this frame: the negative remainder is the leftover time.
            step_ms = -it->start_delay_ms;
            it->start_delay_ms = 0.0f;
        }
        if( it->as_line ) {
            // The whole gun-line shows at once; per_ms counts its short life to 1.
            it->life += it->per_ms * step_ms;
            if( it->life >= 1.0f ) {
                m_handle_index.erase( it->handle );
                it = m_bullet_anims.erase( it );
                continue;
            }
        } else {
            // The dot sweeps one point per per_ms step; done past the last point.
            it->head += it->per_ms * step_ms;
            if( it->head >= static_cast<float>( it->points.size() ) ) {
                m_handle_index.erase( it->handle );
                it = m_bullet_anims.erase( it );
                continue;
            }
        }
        // Drop the tracer if all its path tiles have left the reality bubble.
        if( !it->points.empty() && !any_tile_in_bubble( it->points ) ) {
            m_handle_index.erase( it->handle );
            it = m_bullet_anims.erase( it );
            continue;
        }
        ++it;
    }
}
void cata_tiles::init_draw_bullet( const tripoint_bub_ms &p, std::string name, int rotation )
{
    do_draw_bullet = true;
    bul_pos.push_back( p );
    bul_id.push_back( std::move( name ) );
    bul_rotation.push_back( rotation );
}
void cata_tiles::init_draw_bullets( const std::vector<tripoint_bub_ms> &ps,
                                    const std::vector<std::string> &names, const std::vector<int> &rotations )
{
    do_draw_bullet = true;
    bul_pos.insert( bul_pos.end(), ps.begin(), ps.end() );
    bul_id.insert( bul_id.end(), names.begin(), names.end() );
    bul_rotation.insert( bul_rotation.end(), rotations.begin(), rotations.end() );
}
void cata_tiles::init_draw_hit( const Creature &critter, float damage_fraction,
                                const point &dir_tiles, bool dead )
{
    hit_animation hit;
    hit.timestamp = std::chrono::steady_clock::now();
    hit.creature_ptr = g->shared_from( critter );
    do_draw_hit = true;
    hit_animations.push_front( hit );
    // Optional "got hit" reaction, sharing the move-animation machinery. Skip it
    // for a creature that just died: it gets a death animation instead, and a
    // lingering bounce keyed to this now-empty tile would be wrongly replayed if
    // another creature (e.g. the player) steps onto the tile within its lifetime.
    if( !dead ) {
        start_creature_hit_anim( critter.pos_abs(), damage_fraction, dir_tiles,
                                 critter.is_avatar() );
    }
}

void cata_tiles::init_draw_line( const tripoint_bub_ms &p, std::vector<tripoint_bub_ms> trajectory,
                                 std::string name, bool target_line )
{
    do_draw_line = true;
    is_target_line = target_line;
    line_pos = p;
    line_endpoint_id = std::move( name );
    line_trajectory = std::move( trajectory );
}
void cata_tiles::init_draw_cursor( const tripoint_bub_ms &p )
{
    do_draw_cursor = true;
    cursors.emplace_back( p );
}
void cata_tiles::init_draw_highlight( const tripoint_bub_ms &p )
{
    do_draw_highlight = true;
    highlights.emplace_back( p );
}
void cata_tiles::init_draw_weather( weather_printable weather, std::string name )
{
    do_draw_weather = true;
    weather_name = std::move( name );
    anim_weather = std::move( weather );
}
void cata_tiles::init_draw_sct()
{
    do_draw_sct = true;
}
void cata_tiles::init_draw_zones( const tripoint_bub_ms &_start, const tripoint_bub_ms &_end,
                                  const tripoint_rel_ms &_offset )
{
    do_draw_zones = true;
    zone_start = _start;
    zone_end = _end;
    zone_offset = _offset;
}
void cata_tiles::init_draw_async_anim( const tripoint_bub_ms &p, const std::string &tile_id )
{
    do_draw_async_anim = true;
    async_anim_layer[ p ] = tile_id;
}
void cata_tiles::init_draw_radiation_override( const tripoint_bub_ms &p, const int rad )
{
    radiation_override.emplace( p, rad );
}
void cata_tiles::init_draw_terrain_override( const tripoint_bub_ms &p, const ter_id &id )
{
    terrain_override.emplace( p, id );
}
void cata_tiles::init_draw_furniture_override( const tripoint_bub_ms &p, const furn_id &id )
{
    furniture_override.emplace( p, id );
}
void cata_tiles::init_draw_graffiti_override( const tripoint_bub_ms &p, const bool has )
{
    graffiti_override.emplace( p, has );
}
void cata_tiles::init_draw_trap_override( const tripoint_bub_ms &p, const trap_id &id )
{
    trap_override.emplace( p, id );
}
void cata_tiles::init_draw_field_override( const tripoint_bub_ms &p, const field_type_id &id )
{
    field_override.emplace( p, id );
}
void cata_tiles::init_draw_item_override( const tripoint_bub_ms &p, const itype_id &id,
        const mtype_id &mid, const bool hilite )
{
    item_override.emplace( p, std::make_tuple( id, mid, hilite ) );
}
void cata_tiles::init_draw_vpart_override( const tripoint_bub_ms &p, const vpart_id &id,
        const int part_mod, const units::angle &veh_dir, const bool hilite, const point_rel_ms &mount )
{
    vpart_override.emplace( p, std::make_tuple( id, part_mod, veh_dir, hilite, mount ) );
}
void cata_tiles::init_draw_monster_override( const tripoint_bub_ms &p, const mtype_id &id,
        const int count,
        const bool more, const Creature::Attitude att )
{
    monster_override.emplace( p, std::make_tuple( id, count, more, att ) );
}

/* -- Void Animators */
void cata_tiles::void_explosion()
{
    do_draw_explosion = false;
    exp_pos = {-1, -1, -1};
    exp_rad = -1;
}
void cata_tiles::void_custom_explosion()
{
    do_draw_custom_explosion = false;
    custom_explosion_layer.clear();
}
void cata_tiles::void_explosion_light()
{
    for( const active_explosion_light &a : m_explosion_lights ) {
        m_handle_index.erase( a.handle );
    }
    m_explosion_lights.clear();
    m_explosion_light_last_ms.reset();
    clear_shockwaves();
}
void cata_tiles::void_bullet()
{
    do_draw_bullet = false;
    bul_pos.clear();
    bul_id.clear();
    bul_rotation.clear();
}
void cata_tiles::void_hit()
{
    const std::chrono::milliseconds max_age = std::chrono::milliseconds( 50 );
    const std::chrono::steady_clock::time_point now = std::chrono::steady_clock::now();
    while( !hit_animations.empty() && now - hit_animations.back().timestamp > max_age ) {
        hit_animations.pop_back();
    }

    if( hit_animations.empty() ) {
        do_draw_hit = false;
    }
}
bool cata_tiles::expire_hit_animations()
{
    if( !do_draw_hit ) {
        return false;
    }
    const size_t before = hit_animations.size();
    void_hit();
    return hit_animations.size() != before;
}
void cata_tiles::void_line()
{
    do_draw_line = false;
    is_target_line = false;
    line_pos = { -1, -1, -1 };
    line_endpoint_id.clear();
    line_trajectory.clear();
}
void cata_tiles::void_cursor()
{
    do_draw_cursor = false;
    cursors.clear();
}
void cata_tiles::void_highlight()
{
    do_draw_highlight = false;
    highlights.clear();
}
void cata_tiles::void_weather()
{
    do_draw_weather = false;
    weather_name.clear();
    anim_weather.vdrops.clear();
}
void cata_tiles::void_sct()
{
    do_draw_sct = false;
}

// --- Asynchronous SCT (Scrolling Combat Text) ---

effect_handle cata_tiles::init_sct( const tripoint_bub_ms &pos, const std::string &text,
                                    nc_color color, float duration_ms )
{
    sct_effect eff;
    eff.pos = pos;
    eff.text = text;
    eff.color = color;
    eff.duration_ms = duration_ms;
    eff.elapsed_ms = 0.0f;
    eff.screen_y_offset = 0.0f;
    m_sct_effects.push_back( std::move( eff ) );
    const effect_handle h = alloc_handle( effect_kind::sct );

    m_sct_effects.back().handle = h;
    return h;
}

void cata_tiles::advance_sct()
{
    if( m_sct_effects.empty() ) {
        m_sct_last_ms.reset();
        return;
    }
    const int64_t dt = capped_frame_dt_ms( m_sct_last_ms );
    if( dt <= 0 ) {
        return;
    }
    const float dt_s = static_cast<float>( dt ) / 1000.0f;
    map &here = get_map();
    for( auto it = m_sct_effects.begin(); it != m_sct_effects.end(); ) {
        it->elapsed_ms += static_cast<float>( dt );
        it->screen_y_offset -= it->rise_speed_px_per_s * dt_s;
        bool erase_this = it->elapsed_ms >= it->duration_ms;
        if( !erase_this && !here.inbounds( it->pos ) ) {
            erase_this = true;
        }
        if( erase_this ) {
            m_handle_index.erase( it->handle );
            it = m_sct_effects.erase( it );
        } else {
            ++it;
        }
    }
}

void cata_tiles::draw_sct_frame( int view_z,
                                 std::multimap<point, formatted_text> &overlay_strings )
{
    const bool use_font = get_option<bool>( "ANIMATION_SCT_USE_FONT" );
    for( const sct_effect &eff : m_sct_effects ) {
        if( eff.pos.z() != view_z ) {
            continue;
        }
        const float alpha = 1.0f - ( eff.elapsed_ms / eff.duration_ms );
        if( alpha <= 0.0f ) {
            continue;
        }

        const point screen_p = player_to_screen( eff.pos.xy() ) +
                               point( 0, static_cast<int>( eff.screen_y_offset ) );
        const int FG = eff.color.to_color_pair_index();

        if( use_font ) {
            overlay_strings.emplace(
                screen_p,
                formatted_text( eff.text, FG, text_alignment::center ) );
        } else {
            int cx = 0;
            for( const char ch : eff.text ) {
                const std::string generic_id = get_ascii_tile_id(
                                                   static_cast<uint32_t>( static_cast<unsigned char>( ch ) ), FG, -1 );
                if( tileset_ptr->find_tile_type( generic_id ) ) {
                    const point char_p = screen_p + point( cx * tile_width, 0 );
                    if( const std::optional<point> tile_p = tile_to_player( char_p ) ) {
                        draw_from_id_string( generic_id, TILE_CATEGORY::NONE, empty_string,
                                             tripoint_bub_ms( point_bub_ms( *tile_p ), eff.pos.z() ),
                                             0, 0, lit_level::LIT, false );
                    }
                }
                ++cx;
            }
        }
    }
}

// --- Handle system ---

effect_handle cata_tiles::alloc_handle( effect_kind kind )
{
    const effect_handle h = m_next_handle++;
    m_handle_index[h] = { kind };
    return h;
}

void cata_tiles::cancel_effect( effect_handle h )
{
    auto it = m_handle_index.find( h );
    if( it == m_handle_index.end() ) {
        return;
    }
    const effect_kind kind = it->second.kind;
    m_handle_index.erase( it );

    switch( kind ) {
        case effect_kind::explosion_light:
            for( auto e = m_explosion_lights.begin(); e != m_explosion_lights.end(); ++e ) {
                if( e->handle == h ) {
                    m_explosion_lights.erase( e );
                    return;
                }
            }
            break;
        case effect_kind::bullet:
            for( auto e = m_bullet_anims.begin(); e != m_bullet_anims.end(); ++e ) {
                if( e->handle == h ) {
                    m_bullet_anims.erase( e );
                    return;
                }
            }
            break;
        case effect_kind::creature_move:
            for( auto e = m_creature_anims.begin(); e != m_creature_anims.end(); ++e ) {
                if( e->second.handle == h ) {
                    m_creature_anims.erase( e );
                    return;
                }
            }
            break;
        case effect_kind::creature_hit:
            for( auto e = m_creature_hit_anims.begin(); e != m_creature_hit_anims.end(); ++e ) {
                if( e->second.handle == h ) {
                    m_creature_hit_anims.erase( e );
                    return;
                }
            }
            break;
        case effect_kind::creature_attack:
            for( auto e = m_creature_attack_anims.begin(); e != m_creature_attack_anims.end(); ++e ) {
                if( e->second.handle == h ) {
                    m_creature_attack_anims.erase( e );
                    return;
                }
            }
            break;
        case effect_kind::sct:
            for( auto e = m_sct_effects.begin(); e != m_sct_effects.end(); ++e ) {
                if( e->handle == h ) {
                    m_sct_effects.erase( e );
                    return;
                }
            }
            break;
        case effect_kind::highlight:
            for( auto e = m_highlights.begin(); e != m_highlights.end(); ++e ) {
                if( e->handle == h ) {
                    m_highlights.erase( e );
                    return;
                }
            }
            break;
    }
}

bool cata_tiles::any_tile_in_bubble( const std::vector<tripoint_bub_ms> &tiles ) const
{
    map &here = get_map();
    for( const tripoint_bub_ms &t : tiles ) {
        if( here.inbounds( t ) ) {
            return true;
        }
    }
    return false;
}

// --- Unified transient-effect advance ---

void cata_tiles::advance_all_transient_effects()
{
    advance_creature_move_anims();
    advance_explosion_lights();
    advance_bullet_anims();
    advance_sct();
    advance_highlights();
    advance_screen_shake_frame();
}

// --- Asynchronous highlight overlay ---

effect_handle cata_tiles::add_highlight( const tripoint_bub_ms &pos, float duration_ms )
{
    highlight_effect h;
    h.pos = pos;
    h.life_ms = duration_ms;
    m_highlights.push_back( h );
    const effect_handle hl = alloc_handle( effect_kind::highlight );

    m_highlights.back().handle = hl;
    return hl;
}

void cata_tiles::advance_highlights()
{
    if( m_highlights.empty() ) {
        m_highlights_last_ms.reset();
        return;
    }
    const int64_t dt = capped_frame_dt_ms( m_highlights_last_ms );
    if( dt <= 0 ) {
        return;
    }
    map &here = get_map();
    for( auto it = m_highlights.begin(); it != m_highlights.end(); ) {
        it->life_ms -= static_cast<float>( dt );
        bool erase_this = it->life_ms <= 0.0f;
        if( !erase_this && !here.inbounds( it->pos ) ) {
            erase_this = true;
        }
        if( erase_this ) {
            m_handle_index.erase( it->handle );
            it = m_highlights.erase( it );
        } else {
            ++it;
        }
    }
}

void cata_tiles::draw_highlights( int view_z )
{
    for( const highlight_effect &h : m_highlights ) {
        if( h.pos.z() != view_z ) {
            continue;
        }
        draw_from_id_string( "highlight", h.pos, 0, 0, lit_level::LIT, false );
    }
}

void cata_tiles::void_zones()
{
    do_draw_zones = false;
}
bool cata_tiles::void_async_anim()
{
    if( !do_draw_async_anim ) {
        return false;
    }
    do_draw_async_anim = false;
    async_anim_layer.clear();
    return true;
}
void cata_tiles::void_radiation_override()
{
    radiation_override.clear();
}
void cata_tiles::void_terrain_override()
{
    terrain_override.clear();
}
void cata_tiles::void_furniture_override()
{
    furniture_override.clear();
}
void cata_tiles::void_graffiti_override()
{
    graffiti_override.clear();
}
void cata_tiles::void_trap_override()
{
    trap_override.clear();
}
void cata_tiles::void_field_override()
{
    field_override.clear();
}
void cata_tiles::void_item_override()
{
    item_override.clear();
}
void cata_tiles::void_vpart_override()
{
    vpart_override.clear();
}
void cata_tiles::void_monster_override()
{
    monster_override.clear();
}

bool cata_tiles::has_draw_override( const tripoint_bub_ms &p ) const
{
    return radiation_override.find( p ) != radiation_override.end() ||
           terrain_override.find( p ) != terrain_override.end() ||
           furniture_override.find( p ) != furniture_override.end() ||
           graffiti_override.find( p ) != graffiti_override.end() ||
           trap_override.find( p ) != trap_override.end() ||
           field_override.find( p ) != field_override.end() ||
           item_override.find( p ) != item_override.end() ||
           vpart_override.find( p ) != vpart_override.end() ||
           monster_override.find( p ) != monster_override.end();
}

/* -- Animation Renders */
void cata_tiles::draw_explosion_frame()
{
    std::string exp_name = "explosion";
    int subtile = 0;
    int rotation = 0;

    for( int i = 1; i < exp_rad; ++i ) {
        subtile = corner;
        rotation = 0;

        draw_from_id_string( exp_name, exp_pos + point( -i, -i ),
                             subtile, rotation++, lit_level::LIT, nv_goggles_activated );
        draw_from_id_string( exp_name, exp_pos + point( -i, i ),
                             subtile, rotation++, lit_level::LIT, nv_goggles_activated );
        draw_from_id_string( exp_name, exp_pos + point( i, i ),
                             subtile, rotation++, lit_level::LIT, nv_goggles_activated );
        draw_from_id_string( exp_name, exp_pos + point( i, -i ),
                             subtile, rotation, lit_level::LIT, nv_goggles_activated );

        subtile = edge;
        for( int j = 1 - i; j < 0 + i; j++ ) {
            rotation = 0;
            draw_from_id_string( exp_name, exp_pos + point( j, -i ),
                                 subtile, rotation, lit_level::LIT, nv_goggles_activated );
            draw_from_id_string( exp_name, exp_pos + point( j, i ),
                                 subtile, rotation, lit_level::LIT, nv_goggles_activated );

            rotation = 1;
            draw_from_id_string( exp_name, exp_pos + point( -i, j ),
                                 subtile, rotation, lit_level::LIT, nv_goggles_activated );
            draw_from_id_string( exp_name, exp_pos + point( i, j ),
                                 subtile, rotation, lit_level::LIT, nv_goggles_activated );
        }
    }
}

void cata_tiles::draw_custom_explosion_frame()
{
    // TODO: Make the drawing code handle all the missing tiles: <^>v and *
    // TODO: Add more explosion tiles, like "strong explosion", so that it displays more info
    static const std::string exp_strong = "explosion";
    static const std::string exp_medium = "explosion_medium";
    static const std::string exp_weak = "explosion_weak";
    int subtile = 0;
    int rotation = 0;

    for( const auto &pr : custom_explosion_layer ) {
        const explosion_neighbors ngh = pr.second.neighborhood;
        const nc_color col = pr.second.color;

        switch( ngh ) {
            case N_NORTH:
            case N_SOUTH:
                subtile = edge;
                rotation = 1;
                break;
            case N_WEST:
            case N_EAST:
                subtile = edge;
                rotation = 0;
                break;
            case N_NORTH | N_SOUTH:
            case N_NORTH | N_SOUTH | N_WEST:
            case N_NORTH | N_SOUTH | N_EAST:
                subtile = edge;
                rotation = 1;
                break;
            case N_WEST | N_EAST:
            case N_WEST | N_EAST | N_NORTH:
            case N_WEST | N_EAST | N_SOUTH:
                subtile = edge;
                rotation = 0;
                break;
            case N_SOUTH | N_EAST:
                subtile = corner;
                rotation = 0;
                break;
            case N_NORTH | N_EAST:
                subtile = corner;
                rotation = 1;
                break;
            case N_NORTH | N_WEST:
                subtile = corner;
                rotation = 2;
                break;
            case N_SOUTH | N_WEST:
                subtile = corner;
                rotation = 3;
                break;
            case N_NO_NEIGHBORS:
            case N_WEST | N_EAST | N_NORTH | N_SOUTH:
                // Needs some special tile
                subtile = edge;
                break;
        }

        const tripoint_bub_ms &p = pr.first;
        std::string explosion_tile_id;
        // Use target sprite if exist, otherwise col will determine fallback sprite
        if( pr.second.tile_name &&
            find_tile_looks_like( *pr.second.tile_name, TILE_CATEGORY::NONE, "" ) ) {
            explosion_tile_id = *pr.second.tile_name;
        } else if( col == c_red ) {
            explosion_tile_id = exp_strong;
        } else if( col == c_yellow ) {
            explosion_tile_id = exp_medium;
        } else if( col == c_black ) {
            // c_black results in no fallback sprite
            return;
        } else {
            explosion_tile_id = exp_weak;
        }

        draw_from_id_string( explosion_tile_id, p, subtile, rotation, lit_level::LIT,
                             nv_goggles_activated );
    }
}
void cata_tiles::draw_explosion_light_frame( int view_z )
{
    if( m_explosion_lights.empty() ) {
        clear_shockwaves();
        return;
    }

    // Rebuilt fresh each frame from the live blast list (one ring per blast that
    // has a shockwave). Published for the present-time warp blit; this runs every
    // present frame with the current scroll, so player_to_screen + tile size give
    // exact pixel coordinates.
    std::vector<shockwave_state> shockwaves;
    const float tile_px = ( tile_width + tile_height ) * 0.5f;

    SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_BLEND );
    for( const active_explosion_light &blast : m_explosion_lights ) {
        // The blast is anchored to the z-level it fired on. If the view has since
        // moved to another level (stairs, elevator, looking up/down), don't paint
        // it onto an unrelated floor — it keeps advancing in time and ends normally,
        // it just isn't drawn here. The 2D player_to_screen mapping carries no z.
        if( blast.center.z() != view_z ) {
            continue;
        }
        const explosion_light_str_id &eff_id =
            blast.effect.is_empty() ? explosion_lights::default_blast : blast.effect;
        if( !eff_id.is_valid() ) {
            continue;
        }
        const explosion_light &eff = *eff_id;

        if( eff.shockwave && eff.shockwave_strength > 0.0f && blast.radius_tiles > 0.0f ) {
            const point c_scr = player_to_screen( blast.center.xy() );
            shockwave_state sw;
            sw.active = true;
            // Origin = middle of the epicentre tile (apex for line/cone).
            sw.center_x = static_cast<float>( c_scr.x ) + tile_width * 0.5f;
            sw.center_y = static_cast<float>( c_scr.y ) + tile_height * 0.5f;
            const float radius_px = blast.radius_tiles * tile_px;
            // Front sweeps out at shockwave_speed relative to the light's own front.
            sw.radius = blast.progress * eff.shockwave_speed * radius_px;
            sw.thickness = eff.shockwave_thickness * tile_px;
            // Shape: a radial ring for a disc blast; a flat front along the axis for
            // a line; an angular slice for a cone. circular_shockwave gates the disc;
            // otherwise the directional geometry stored on the blast is used.
            if( blast.circular_shockwave ) {
                sw.shape = shockwave_state::sw_shape::disc;
            } else {
                sw.shape = blast.shock_shape;
                // Axis from the origin toward the target, in screen pixels.
                const point t_scr = player_to_screen( blast.shock_target.xy() );
                const float ax = static_cast<float>( t_scr.x ) - static_cast<float>( c_scr.x );
                const float ay = static_cast<float>( t_scr.y ) - static_cast<float>( c_scr.y );
                const float alen = std::sqrt( ax * ax + ay * ay );
                if( alen > 1e-3f ) {
                    sw.axis_x = ax / alen;
                    sw.axis_y = ay / alen;
                }
                sw.half_angle = blast.shock_half_angle;
                // A line front is infinite across its axis unless bounded; without
                // this a beam warps the entire screen width. Confine it to a tube a
                // few tiles wide around the beam (cosine taper to the edge). Cones
                // are already bounded by their angular sector, so leave half_width 0.
                if( sw.shape == shockwave_state::sw_shape::line ) {
                    sw.half_width = std::max( sw.thickness, tile_px * 1.5f );
                }
            }
            // Envelope the strength over the blast's life so the front eases in and,
            // crucially, fades out instead of snapping off when the blast ends (a
            // constant strength followed by a hard cut reads as abrupt). t is the
            // blast's normalised progress; a quick attack then a smooth (squared)
            // release to zero.
            const float t = blast.end_progress > 0.0f
                            ? std::clamp( blast.progress / blast.end_progress, 0.0f, 1.0f )
                            : 1.0f;
            constexpr float attack = 0.12f;
            constexpr float release = 0.45f;
            const float rise = std::clamp( t / attack, 0.0f, 1.0f );
            float fall = std::clamp( ( 1.0f - t ) / release, 0.0f, 1.0f );
            fall *= fall; // ease the tail so it settles softly to zero
            const float env = rise * fall;
            sw.strength = eff.shockwave_strength * tile_px * env;
            if( sw.strength > 0.0f ) {
                shockwaves.push_back( sw );
            }
        }

        for( const auto &pr : blast.radial ) {
            // Stable per-tile seed (constant across frames): drives the wave-arrival
            // spread jitter and colour grain, so the wavefront edge is irregular but
            // doesn't crawl between frames. Cast to unsigned before multiplying so the
            // spatial hash wraps as intended rather than overflowing signed int (UB).
            const uint32_t tile_seed =
                static_cast<uint32_t>( pr.first.x() ) * 73856093U ^
                static_cast<uint32_t>( pr.first.y() ) * 19349663U;
            // Per-frame seed: drives the live flicker. Mix in the quantised progress
            // so the flicker animates without shimmering between sub-pixels.
            const uint32_t frame_q = static_cast<uint32_t>( blast.progress * 32.0f );
            const uint32_t frame_seed = tile_seed ^ ( frame_q * 83492791U );

            const explosion_light_sample s =
                eff.sample( pr.second, blast.progress, tile_seed, frame_seed, blast.radius_tiles );
            if( s.a == 0 ) {
                continue;
            }

            const point scr = player_to_screen( pr.first.xy() );
            SDL_Rect draw_rect;
            draw_rect.x = scr.x;
            draw_rect.y = scr.y;
            draw_rect.w = tile_width;
            draw_rect.h = tile_height;

            const SDL_Color col{ s.r, s.g, s.b, s.a };
            geometry->rect( renderer, draw_rect, col );
        }
    }
    SetRenderDrawBlendMode( renderer, SDL_BLENDMODE_NONE );

    // Cap the number of concurrent shockwave fronts. The present-time warp blit
    // costs O(grid_vertices * shockwaves) trig calls every frame, so a full-auto
    // energy burst (one front per shot, all live at once) can spike frame time for
    // a few hundred ms. Past the cap, keep only the strongest fronts — strength
    // dominates the visible distortion, and the dropped weak ones are imperceptible
    // anyway. Threshold is generous so normal play (a blast or two) never clips.
    constexpr size_t max_shockwaves = 6;
    if( shockwaves.size() > max_shockwaves ) {
        std::partial_sort( shockwaves.begin(), shockwaves.begin() + max_shockwaves,
        shockwaves.end(), []( const shockwave_state & a, const shockwave_state & b ) {
            return a.strength > b.strength;
        } );
        shockwaves.resize( max_shockwaves );
    }
    set_shockwaves( std::move( shockwaves ) );
}
void cata_tiles::draw_bullet_frame()
{
    for( size_t i = 0; i < bul_pos.size(); ++i ) {
        draw_from_id_string( bul_id[i], TILE_CATEGORY::BULLET, empty_string, bul_pos[i], 0,
                             bul_rotation[i], lit_level::LIT, false );
    }
}
void cata_tiles::draw_bullet_anim_frame( int view_z )
{
    for( const active_bullet_anim &anim : m_bullet_anims ) {
        // Not yet started (still in its burst-stagger delay): draw nothing.
        if( anim.start_delay_ms > 0.0f ) {
            continue;
        }
        if( anim.as_line ) {
            // Whole gun-line: every visible point of the flight path, at once.
            for( size_t i = 0; i < anim.points.size(); ++i ) {
                if( anim.points[i].z() != view_z ) {
                    continue;
                }
                draw_from_id_string( anim.sprites[i], TILE_CATEGORY::BULLET, empty_string,
                                     anim.points[i], 0, anim.rotations[i], lit_level::LIT, false );
            }
        } else {
            // Moving dot: just the current head point, clamped to the path.
            const size_t idx = std::min( static_cast<size_t>( anim.head ),
                                         anim.points.size() - 1 );
            if( anim.points[idx].z() != view_z ) {
                continue;
            }
            draw_from_id_string( anim.sprites[idx], TILE_CATEGORY::BULLET, empty_string,
                                 anim.points[idx], 0, anim.rotations[idx], lit_level::LIT, false );
        }
    }
}
void cata_tiles::void_bullet_anim()
{
    for( const active_bullet_anim &a : m_bullet_anims ) {
        m_handle_index.erase( a.handle );
    }
    m_bullet_anims.clear();
    m_bullet_anim_last_ms.reset();
}
void cata_tiles::draw_hit_frame()
{
    const std::string hit_overlay = "animation_hit";

    for( const hit_animation &hit : hit_animations ) {
        const shared_ptr_fast<Creature> creature = hit.creature_ptr.lock();
        if( !creature ) {
            continue; // creature gone, skip this hit
        }
        const tripoint_bub_ms draw_pos = creature->pos_bub();

        draw_from_id_string( hit_overlay, draw_pos, 0, 0, lit_level::LIT, false );
    }
}
void cata_tiles::draw_line()
{
    map &here = get_map();

    if( line_trajectory.empty() ) {
        return;
    }
    static std::string line_overlay = "animation_line";
    if( !is_target_line || get_player_view().sees( here, line_pos ) ) {
        for( auto it = line_trajectory.begin(); it != line_trajectory.end() - 1; ++it ) {
            draw_from_id_string( line_overlay, *it, 0, 0, lit_level::LIT, false );
        }
    }

    draw_from_id_string( line_endpoint_id, line_trajectory.back(), 0, 0, lit_level::LIT, false );
}
void cata_tiles::draw_cursor()
{
    for( const tripoint_bub_ms &p : cursors ) {
        draw_from_id_string( "cursor", p, 0, 0, lit_level::LIT, false );
    }
}
void cata_tiles::draw_highlight()
{
    for( const tripoint_bub_ms &p : highlights ) {
        draw_from_id_string( "highlight", p, 0, 0, lit_level::LIT, false );
    }
}
void cata_tiles::draw_weather_frame()
{

    for( auto &vdrop : anim_weather.vdrops ) {
        // TODO: Z-level awareness if weather ever happens on anything but z-level 0.
        point p( vdrop.first, vdrop.second );
        if( !is_isometric() ) {
            // currently in ASCII screen coordinates
            const std::optional temp = tile_to_player( p );
            if( !temp.has_value() ) {
                continue;
            }
            p = temp.value();
        }
        const tripoint_bub_ms pos( point_bub_ms( p ), 0 );
        draw_from_id_string( weather_name, TILE_CATEGORY::WEATHER, empty_string, pos, 0, 0,
                             lit_level::LIT, nv_goggles_activated );
    }
}

void cata_tiles::draw_sct_frame( std::multimap<point, formatted_text> &overlay_strings )
{
    const bool use_font = get_option<bool>( "ANIMATION_SCT_USE_FONT" );
    tripoint_bub_ms player_pos = get_player_character().pos_bub();

    for( const scrollingcombattext::cSCT &sct : SCT.vSCT ) {
        const point iD( sct.getPosX(), sct.getPosY() );
        const int full_text_length = utf8_width( sct.getText() );

        point iOffset;

        for( int j = 0; j < 2; ++j ) {
            std::string sText = sct.getText( ( j == 0 ) ? "first" : "second" );
            int FG = msgtype_to_tilecolor( sct.getMsgType( ( j == 0 ) ? "first" : "second" ),
                                           sct.getStep() >= scrollingcombattext::iMaxSteps / 2 );

            if( use_font ) {
                const direction direction = sct.getDirection();
                // Compensate for string length offset added at SCT creation
                // (it will be readded using font size and proper encoding later).
                const int direction_offset = ( -displace_XY( direction ).x + 1 ) *
                                             full_text_length / 2;

                overlay_strings.emplace(
                    player_to_screen( iD + point_bub_ms( direction_offset, 0 ) ),
                    formatted_text( sText, FG, direction ) );
            } else {
                for( char &it : sText ) {
                    const std::string generic_id = get_ascii_tile_id( it, FG, -1 );

                    if( tileset_ptr->find_tile_type( generic_id ) ) {
                        draw_from_id_string( generic_id, TILE_CATEGORY::NONE, empty_string,
                                             iD + tripoint_bub_ms( point_bub_ms( iOffset ), player_pos.z() ),
                                             0, 0, lit_level::LIT, false );
                    }

                    if( is_isometric() ) {
                        iOffset.y++;
                    }
                    iOffset.x++;
                }
            }
        }
    }
}

void cata_tiles::draw_zones_frame()
{
    tripoint_bub_ms player_pos = get_player_character().pos_bub();
    for( int iY = zone_start.y(); iY <= zone_end.y(); ++ iY ) {
        for( int iX = zone_start.x(); iX <= zone_end.x(); ++iX ) {
            draw_from_id_string( "highlight", TILE_CATEGORY::NONE, empty_string,
                                 tripoint_bub_ms( iX, iY, player_pos.z() ) + zone_offset.xy(),
                                 0, 0, lit_level::LIT, false );
        }
    }

}

void cata_tiles::draw_async_anim()
{
    // game::draw_async_anim can be called multiple times, storing each animation to be played in async_anim_layer
    // Iterate through every tripoint-tileid pair in async_anim_layer
    for( const auto &anim : async_anim_layer ) {
        const tripoint_bub_ms p = anim.first;
        const std::string tile_id = anim.second;
        // Only draw if sprite found
        if( find_tile_looks_like( tile_id, TILE_CATEGORY::NONE, "" ) ) {
            draw_from_id_string( tile_id, p, 0, 0, lit_level::LIT, nv_goggles_activated );
        }
    }
}

void cata_tiles::draw_footsteps_frame( const tripoint_bub_ms &center )
{
    static const std::string id_footstep = "footstep";
    static const std::string id_footstep_above = "footstep_above";
    static const std::string id_footstep_below = "footstep_below";

    const tile_type *tl_above = tileset_ptr->find_tile_type( id_footstep_above );
    const tile_type *tl_below = tileset_ptr->find_tile_type( id_footstep_below );

    for( const tripoint_bub_ms &pos : sounds::get_footstep_markers() ) {
        if( pos.z() > center.z() && tl_above ) {
            draw_from_id_string( id_footstep_above, pos, 0, 0, lit_level::LIT, false );
        } else if( pos.z() < center.z() && tl_below ) {
            draw_from_id_string( id_footstep_below, pos, 0, 0, lit_level::LIT, false );
        } else {
            draw_from_id_string( id_footstep, pos, 0, 0, lit_level::LIT, false );
        }
    }
}
/* END OF ANIMATION FUNCTIONS */

void cata_tiles::tile_loading_report_dups()
{

    std::vector<std::string> dups_list;
    const std::unordered_set<std::string> &dups_set = tileset_ptr->get_duplicate_ids();
    std::copy( dups_set.begin(), dups_set.end(), std::back_inserter( dups_list ) );
    // NOLINTNEXTLINE(cata-use-localized-sorting)
    std::sort( dups_list.begin(), dups_list.end() );

    std::string res;
    for( const std::string &s : dups_list ) {
        res += s;
        res += " ";
    }
    DebugLog( D_INFO, DC_ALL ) << "Have duplicates: " << res;
}

void cata_tiles::init_light()
{
    g->reset_light_level();
}

void cata_tiles::do_tile_loading_report()
{
    DebugLog( D_INFO, DC_ALL ) << "Loaded tileset: " << tileset_ptr->get_tileset_id();

    if( !g->is_core_data_loaded() ) {
        // There's nothing to do anymore without the core data.
        return;
    }

    tile_loading_report_seq_types( vehicles::parts::get_all(), TILE_CATEGORY::VEHICLE_PART, "vp_" );
    tile_loading_report_count<ter_t>( ter_t::count(), TILE_CATEGORY::TERRAIN );

    std::map<itype_id, const itype *> items;
    for( const itype *e : item_controller->all() ) {
        items.emplace( e->get_id(), e );
    }
    tile_loading_report_map( items, TILE_CATEGORY::ITEM );

    tile_loading_report_count<furn_t>( furn_t::count(), TILE_CATEGORY::FURNITURE );
    tile_loading_report_count<trap>( trap::count(), TILE_CATEGORY::TRAP );
    tile_loading_report_count<field_type>( field_type::count(), TILE_CATEGORY::FIELD );

    // TODO: LIGHTING

    tile_loading_report_seq_types( MonsterGenerator::generator().get_all_mtypes(),
                                   TILE_CATEGORY::MONSTER );

    // TODO: BULLET
    // TODO: HIT_ENTITY
    std::vector<std::string> weather_overlays;
    for( const weather_type &weather : weather_types::get_all() ) {
        weather_overlays.emplace_back( weather.tiles_animation );
    }
    std::sort( weather_overlays.begin(), weather_overlays.end() );
    weather_overlays.erase( std::unique( weather_overlays.begin(), weather_overlays.end() ),
                            weather_overlays.end() );
    tile_loading_report_seq_ids( weather_overlays, TILE_CATEGORY::WEATHER );
    tile_loading_report_seq_types( weather_types::get_all(), TILE_CATEGORY::OVERMAP_WEATHER );

    std::vector<oter_type_str_id> oter_types;
    for( const oter_t &oter : overmap_terrains::get_all() ) {
        oter_types.push_back( oter.get_type_id() );
    }
    std::sort( oter_types.begin(), oter_types.end() );
    oter_types.erase( std::unique( oter_types.begin(), oter_types.end() ), oter_types.end() );
    tile_loading_report_seq_ids( oter_types, TILE_CATEGORY::OVERMAP_TERRAIN );

    std::vector<std::string> oter_vision_levels;
    for( const oter_vision &level : oter_vision::get_all() ) {
        oter_vision_levels.push_back( level.get_id().str() + "$" +
                                      io::enum_to_string( om_vision_level::details ) );
        oter_vision_levels.push_back( level.get_id().str() + "$" +
                                      io::enum_to_string( om_vision_level::outlines ) );
        oter_vision_levels.push_back( level.get_id().str() + "$" +
                                      io::enum_to_string( om_vision_level::vague ) );
    }
    tile_loading_report_seq_ids( oter_vision_levels, TILE_CATEGORY::OVERMAP_VISION_LEVEL );

    std::vector<map_extra_id> map_extra_ids = MapExtras::get_all_function_names();
    map_extra_ids.erase(
        std::remove_if( map_extra_ids.begin(), map_extra_ids.end(),
    []( const map_extra_id & id ) {
        return id->visibility == map_extra_visibility::none;
    } ), map_extra_ids.end() );
    tile_loading_report_seq_ids( map_extra_ids, TILE_CATEGORY::MAP_EXTRA );

    // TODO: OVERMAP_NOTE

    static_assert( static_cast<int>( TILE_CATEGORY::last ) == 17,
                   "If you add more tile categories then update this tile loading report and then "
                   "increment the value in this static_assert accordingly" );

    tile_loading_report_dups();

    // needed until DebugLog ostream::flush bugfix lands
    DebugLog( D_INFO, DC_ALL );
}

template<typename Iter, typename Func>
void cata_tiles::lr_generic( Iter begin, Iter end, Func id_func, TILE_CATEGORY category,
                             const std::string &prefix )
{
    std::string missing_list;
    std::string missing_with_looks_like_list;
    for( ; begin != end; ++begin ) {
        const std::string id_string = id_func( begin );

        if( !tileset_ptr->find_tile_type( prefix + id_string ) &&
            !find_tile_looks_like( id_string, category, "" ) ) {
            missing_list.append( id_string + " " );
        } else if( !tileset_ptr->find_tile_type( prefix + id_string ) ) {
            missing_with_looks_like_list.append( id_string + " " );
        }
    }
    const std::string &category_name = TILE_CATEGORY_IDS[static_cast<size_t>( category )];
    DebugLog( D_INFO, DC_ALL ) << "Missing " << category_name << ": " << missing_list;
    DebugLog( D_INFO, DC_ALL ) << "Missing " << category_name <<
                                  " (but looks_like tile exists): " << missing_with_looks_like_list;
}

template <typename maptype>
void cata_tiles::tile_loading_report_map( const maptype &tiletypemap, TILE_CATEGORY category,
        const std::string &prefix )
{
    lr_generic( tiletypemap.begin(), tiletypemap.end(),
    []( const decltype( tiletypemap.begin() ) & v ) {
        // c_str works for std::string and for string_id!
        return v->first.c_str();
    }, category, prefix );
}

template <typename Sequence>
void cata_tiles::tile_loading_report_seq_types( const Sequence &tiletypes, TILE_CATEGORY category,
        const std::string &prefix )
{
    lr_generic( tiletypes.begin(), tiletypes.end(),
    []( const decltype( tiletypes.begin() ) & v ) {
        return v->id.c_str();
    }, category, prefix );
}

template <typename Sequence>
void cata_tiles::tile_loading_report_seq_ids( const Sequence &tiletypes, TILE_CATEGORY category,
        const std::string &prefix )
{
    lr_generic( tiletypes.begin(), tiletypes.end(),
    []( const decltype( tiletypes.begin() ) & v ) {
        // c_str works for std::string and for string_id!
        return v->c_str();
    }, category, prefix );
}

template <typename base_type>
void cata_tiles::tile_loading_report_count( const size_t count, TILE_CATEGORY category,
        const std::string &prefix )
{
    lr_generic( static_cast<size_t>( 0 ), count,
    []( const size_t i ) {
        return int_id<base_type>( i ).id().str();
    }, category, prefix );
}

std::vector<options_manager::id_and_option> cata_tiles::build_renderer_list()
{
    std::vector<options_manager::id_and_option> renderer_names;
    std::vector<options_manager::id_and_option> default_renderer_names = {
#   if defined(_WIN32)
        { "direct3d", to_translation( "direct3d" ) },
#   endif
        { "software", to_translation( "software" ) },
        { "opengl", to_translation( "opengl" ) },
        { "opengles2", to_translation( "opengles2" ) },
    };
    const int numRenderDrivers = GetNumRenderDrivers();
    for( int ii = 0; ii < numRenderDrivers; ii++ ) {
        const char *name = GetRenderDriverName( ii );
        // First default renderer name we will put first on the list. We can use it later as
        // default value.
        if( name == default_renderer_names.front().first ) {
            renderer_names.emplace( renderer_names.begin(), default_renderer_names.front() );
        } else {
            renderer_names.emplace_back( name, no_translation( name ) );
        }
    }
    DebugLog( D_INFO, DC_ALL ) << "SDL render devices: " << enumerate_as_string( renderer_names,
    []( const options_manager::id_and_option & iao ) {
        return iao.first;
    }, enumeration_conjunction::none );

    return renderer_names.empty() ? default_renderer_names : renderer_names;
}

std::vector<options_manager::id_and_option> cata_tiles::build_display_list()
{
    std::vector<options_manager::id_and_option> display_names;
    std::vector<options_manager::id_and_option> default_display_names = {
        { "0", to_translation( "Display 0" ) }
    };

    const int numdisplays = GetNumVideoDisplays();
    display_names.reserve( numdisplays );
    for( int i = 0 ; i < numdisplays ; i++ ) {
        display_names.emplace_back( std::to_string( i ),
                                    no_translation( GetDisplayName( i ) ) );
    }

    return display_names.empty() ? default_display_names : display_names;
}

#endif // SDL_TILES
