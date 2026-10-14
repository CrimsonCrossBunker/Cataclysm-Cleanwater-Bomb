#if defined(TILES)
#include <algorithm>
#include <array>
#include <cstdint>
#include <map>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_tiles.h"
#include "color.h"
#include "cursesport.h"
#include "output.h"
#include "item.h"
#include "level_cache.h"
#include "lightmap.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_memory.h"
#include "options.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "sdl_renderer_recovery.h"
#include "sdl_wrappers.h"
#include "sdltiles.h"
#include "type_id.h"

static std::array<std::uint32_t, 4096> draw_boundary_pixels( const tripoint_bub_ms &center,
        int extent = 64, std::multimap<point, formatted_text> *annotations = nullptr )
{
    display_buffer_draw_scope scope;
    REQUIRE_FALSE( display_buffer_scope_is_invalid() );
    const auto &renderer = get_sdl_renderer();
    SetRenderDrawColor( renderer, 0, 0, 0, 255 );
    RenderClear( renderer );
    std::multimap<point, formatted_text> text;
    color_block_overlay_container blocks;
    tilecontext->draw( point::zero, center, extent, extent, text, blocks );
    if( annotations ) {
        *annotations = text;
    }
    std::array<std::uint32_t, 4096> pixels{};
    const SDL_Rect area{ 0, 0, 64, 64 };
    REQUIRE( RenderReadPixels( renderer, &area, SDL_PIXELFORMAT_ABGR8888, pixels.data(), 256 ) );
    return pixels;
}

TEST_CASE( "complete_renderer_consumes_values_across_projection_and_resource_lifecycle",
           "[tiles][renderer_boundary]" )
{
    for( bool iso : {
             false, true
         } ) {
        INFO( iso );
        clear_map_without_vision();
        clear_avatar();
        map &here = get_map();
        avatar &you = get_avatar();
        const tripoint_bub_ms center( 50, 50, 0 );
        you.setpos( here, center );
        set_time_to_day();
        you.recalc_sight_limits();
        software_render_fixture fixture;
        REQUIRE( fixture.available() );
        REQUIRE( renderer_recovery_test_support::install_character_preview_targets() );
        on_out_of_scope release_context( [] { tilecontext.reset(); } );
        restore_on_out_of_scope restore_tilesets( TILESETS );
        restore_on_out_of_scope restore_x( POSX );
        restore_on_out_of_scope restore_y( POSY );
        POSX = 8;
        POSY = 8;
        override_option preparation( "RENDER_PREPARATION_WORKERS", "0" );
        override_option memory( "MEMORY_MAP_MODE", "color_pixel_sepia_light" );
        const std::string id = iso ? "boundary_iso" : "boundary_ortho";
        TILESETS[id] = cata_path( cata_path::root_path::base,
                                  iso ? "tests/data/render-boundary/iso" : "tests/data/render-boundary/ortho" );
        tilecontext->load_tileset( id );
        tilecontext->set_draw_scale( 16 );
        REQUIRE( tilecontext->is_isometric() == iso );
        here.invalidate_map_cache( 0 );
        here.build_map_cache( 0, true );
        here.invalidate_visibility_cache();
        here.update_visibility_cache( 0 );
        const auto plain = draw_boundary_pixels( center );
        REQUIRE( std::any_of( plain.begin(), plain.end(), []( std::uint32_t p ) {
            return ( p & 0xffffff ) != 0;
        } ) );
        REQUIRE( here.add_field( center + point::east, field_type_id( "fd_smoke" ), 1 ) );
        here.add_item_or_charges( center + point::south, item( itype_id( "rock" ), calendar::turn ) );
        // The public dirty notifier intentionally ignores test_mode. This
        // renderer fixture explicitly publishes changed owner inputs instead.
        here.draw_points_cache_dirty = true;
        const auto dynamic = draw_boundary_pixels( center );
        CHECK( dynamic != plain );
        const tripoint_bub_ms preview = center + point::north;
        const ter_id actual = here.ter( preview );
        tilecontext->init_draw_terrain_override( preview, ter_id( "t_wall" ) );
        const auto overridden = draw_boundary_pixels( center );
        CHECK( overridden != dynamic );
        CHECK( here.ter( preview ) == actual );
        // Overrides expire at the end of the frame; the next owner capture is
        // again live state rather than retained borrowed preview metadata.
        const auto restored = draw_boundary_pixels( center );
        CHECK( restored == dynamic );
        const auto before_reset = draw_boundary_pixels( center );
        renderer_coordinator.request_recovery( renderer_recovery_severity::device_reset );
        REQUIRE_FALSE( renderer_coordinator.is_render_allowed() );
        renderer_coordinator.drain_pending();
        REQUIRE( renderer_coordinator.is_render_allowed() );
        tilecontext->load_tileset( id );
        CHECK( draw_boundary_pixels( center ) == before_reset );
        tilecontext->load_tileset( id, false, true );
        tilecontext->set_draw_scale( 16 );
        CHECK( draw_boundary_pixels( center ) == before_reset );
        level_cache &level = here.access_cache( 0 );
        level.has_colored_lights = true;
        for( int x = 0; x < MAPSIZE_X; ++x ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                level.light_color_cache[x][y] = light_color_rgb{ 500.0f, 0.0f, 0.0f };
            }
        }
        const auto colored = draw_boundary_pixels( center );
        // The legacy colored overlay is intentionally disabled for isometric
        // projection. The orthogonal complete pass must apply the owned tint.
        if( iso ) {
            CHECK( colored == before_reset );
        } else {
            CHECK( colored != before_reset );
        }
        for( int y = 35; y <= 65; ++y ) {
            here.ter_set( tripoint_bub_ms( 52, y, 0 ), ter_id( "t_wall" ) );
        }
        const tripoint_bub_ms hidden = center + point( 4, 0 );
        const tripoint_abs_ms absolute = here.get_abs( hidden );
        here.ter_set( hidden, ter_id( "t_floor" ) );
        here.invalidate_map_cache( 0 );
        here.build_map_cache( 0, true );
        here.invalidate_visibility_cache();
        here.update_visibility_cache( 0 );
        REQUIRE_FALSE( you.sees( here, hidden ) );
        you.memorize_terrain( absolute, "t_wall", 0, 0 );
        REQUIRE( you.has_memory_at( absolute ) );
        here.draw_points_cache_dirty = true;
        const auto remembered = draw_boundary_pixels( center );
        CHECK( you.get_memorized_tile( absolute ).get_ter_id() == "t_wall" );
        bool captured_hidden = false;
        for( const auto &row : here.draw_points_cache.tiles[0] ) {
            for( const auto &tile : row ) {
                if( tile.view.pos == hidden ) {
                    const auto *sprite = std::get_if<tile_render_info::sprite>( &tile.var );
                    REQUIRE( sprite );
                    INFO( static_cast<int>( sprite->ll ) );
                    REQUIRE( sprite->invisible[0] );
                    captured_hidden = true;
                }
            }
        }
        REQUIRE( captured_hidden );
        you.memorize_terrain( absolute, "t_floor", 0, 0 );
        here.draw_points_cache_dirty = true;
        const auto refreshed = draw_boundary_pixels( center );
        CHECK( remembered != refreshed );
        CHECK( here.ter( hidden ) == ter_id( "t_floor" ) );
    }
}
TEST_CASE( "draw_cache_sprite_indices_follow_append_relocation_and_rebuild",
           "[tiles][renderer_boundary]" )
{
    draw_points_cache_t cache;
    const tripoint_bub_ms origin( 50, 50, 0 );
    const auto add = [&]( draw_points_cache_t::row_vec & row, int x, bool sprite ) {
        const tile_render_info::tile_view_data view{ origin + point( x, 0 ) };
        if( sprite ) {
            row.emplace_back( view, tile_render_info::tile_render_scratch{},
                              tile_render_info::sprite{ lit_level::LIT, {} } );
        } else {
            row.emplace_back( view, tile_render_info::tile_render_scratch{},
                              tile_render_info::vision_effect{ visibility_type::HIDDEN } );
        }
    };
    auto &row = cache[0][10];
    for( int i = 0; i < 80; ++i ) {
        add( row, i, i % 3 == 1 );
    }
    const auto verify = [&]( draw_points_cache_t::row_vec & values ) {
        std::vector<std::size_t> expected;
        std::size_t index = 0;
        for( const auto &entry : values ) {
            if( std::holds_alternative<tile_render_info::sprite>( entry.var ) ) {
                expected.push_back( index );
            }
            ++index;
        }
        CHECK( values.sprite_indices() == expected );
        for( const std::size_t i : values.sprite_indices() ) {
            CHECK( values[i].view.pos == origin + point( static_cast<int>( i ), 0 ) );
        }
    };
    verify( row );
    // Prepending rows moves their storage; indices must still address this row.
    add( cache[0][5], 0, false );
    verify( cache[0][10] );
    cache.soft_clear();
    CHECK( cache[0][10].size() == 0 );
    CHECK( cache[0][10].sprite_indices().empty() );
    add( cache[0][10], 0, false );
    add( cache[0][10], 1, true );
    verify( cache[0][10] );
}

TEST_CASE( "renderer_mixed_cache_keeps_worker_indices_and_preview_counts",
           "[tiles][renderer_boundary]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms center( 50, 50, 0 );
    you.setpos( here, center );
    set_time_to_day();
    you.recalc_sight_limits();
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    on_out_of_scope release_context( [] { tilecontext.reset(); } );
    restore_on_out_of_scope restore_tilesets( TILESETS );
    restore_on_out_of_scope restore_x( POSX );
    restore_on_out_of_scope restore_y( POSY );
    POSX = POSY = 8;
    const std::string id = "boundary_worker_indices";
    TILESETS[id] = cata_path( cata_path::root_path::base, "tests/data/render-boundary/ortho" );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );
    here.invalidate_visibility_cache();
    here.update_visibility_cache( 0 );
    std::array<std::uint32_t, 4096> serial{};
    for( const int workers : {
             0, 2
         } ) {
        INFO( workers );
        override_option preparation( "RENDER_PREPARATION_WORKERS", std::to_string( workers ) );
        renderer_recovery_test_support::remove_character_preview_context();
        REQUIRE( renderer_recovery_test_support::install_character_preview_targets() );
        tilecontext->load_tileset( id );
        tilecontext->set_draw_scale( 16 );
        here.draw_points_cache_dirty = true;
        // A real mixed visible/vision-effect frame, above the production16384
        // threshold. Read the same physical64x64 region of its actual SDL target.
        const auto pixels = draw_boundary_pixels( center, 1024 );
        CHECK( renderer_recovery_test_support::tile_preparation_used_workers() == ( workers != 0 ) );
        std::size_t sprites = 0;
        std::size_t effects = 0;
        for( const auto &row : here.draw_points_cache.tiles[0] ) {
            for( const auto &tile : row ) {
                if( std::holds_alternative<tile_render_info::sprite>( tile.var ) ) {
                    ++sprites;
                } else {
                    ++effects;
                }
            }
        }
        CHECK( sprites > 0 );
        CHECK( effects > 0 );
        if( workers == 0 ) {
            serial = pixels;
        } else {
            CHECK( pixels == serial );
        }
        tilecontext->init_draw_monster_override( center + point::east, mtype_id( "mon_zombie" ),
                3, false, Creature::Attitude::HOSTILE );
        std::multimap<point, formatted_text> annotations;
        draw_boundary_pixels( center, 1024, &annotations );
        CHECK( std::any_of( annotations.begin(), annotations.end(), []( const auto & entry ) {
            return entry.second.text == "x3";
        } ) );
        annotations.clear();
        draw_boundary_pixels( center, 1024, &annotations );
        CHECK( std::none_of( annotations.begin(), annotations.end(), []( const auto & entry ) {
            return entry.second.text == "x3";
        } ) );
    }
}
#endif // TILES
