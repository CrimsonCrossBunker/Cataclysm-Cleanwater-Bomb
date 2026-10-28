#if defined(TILES)

#include <map>
#include <memory>
#include <string>

#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "cata_tiles.h"
#include "options.h"
#include "sdl_renderer_recovery.h"
#include "sdl_wrappers.h"
#include "sdltiles.h"

TEST_CASE( "failed_atlas_allocation_keeps_the_previous_tileset",
           "[tiles][tileset_upload_failure]" )
{
    software_render_fixture fixture;
    REQUIRE( fixture.available() );
    restore_on_out_of_scope restore_tilesets( TILESETS );
    const std::string id = "allocation_failure_ortho";
    TILESETS[id] = cata_path( cata_path::root_path::base, "tests/data/render-boundary/ortho" );
    const auto &renderer = get_sdl_renderer();
    tileset_cache cache;
    const auto load = [&]( bool force, const atlas_upload_poll & poll = {} ) {
        return cache.load_tileset( id, renderer, false, force, false, false,
                                   "color_pixel_darken", 1, 1, poll );
    };
    const auto original = load( false );
    REQUIRE( original );
    REQUIRE( original->get_tile( 0 ) );
    const auto original_texture = original->get_tile( 0 )->get_texture_ptr();
    REQUIRE( original_texture );

    int fail_on_poll = 2;
    SECTION( "first chunk cannot allocate a texture" ) {
        fail_on_poll = 2;
    }
    SECTION( "a later chunk fails after a partial upload" ) {
        fail_on_poll = 3;
    }

    const SDL_PropertiesID properties = SDL_GetRendererProperties( renderer.get() );
    const Sint64 original_limit = SDL_GetNumberProperty( properties,
        SDL_PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER, 0 );
    on_out_of_scope restore_limit( [&]() {
        SDL_SetNumberProperty( properties, SDL_PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER, original_limit );
    } );
    int polls = 0;
    const atlas_upload_poll reject_texture = [&]() {
        if( ++polls == fail_on_poll ) {
            // The loader has already sized its 2x2 chunk.  Make SDL itself
            // reject the allocation, without allocating a huge image or
            // exhausting the test machine's memory.
            REQUIRE( SDL_SetNumberProperty( properties, SDL_PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER, 1 ) );
        }
        return atlas_upload_interrupt::none;
    };
    CHECK_THROWS_WITH( load( true, reject_texture ),
                       Catch::Matchers::Contains( "Failed to create tileset atlas texture" ) );
    CHECK( polls == fail_on_poll );
    REQUIRE( SDL_SetNumberProperty( properties, SDL_PROP_RENDERER_MAX_TEXTURE_SIZE_NUMBER,
                                    original_limit ) );
    CHECK( load( false ) == original );
    CHECK( original->get_tile( 0 )->get_texture_ptr() == original_texture );

    // Failure must not poison the cache or prevent a later successful reload.
    const auto replacement = load( true );
    REQUIRE( replacement );
    CHECK( replacement != original );
    REQUIRE( replacement->get_tile( 0 ) );
    CHECK( replacement->get_tile( 0 )->get_texture_ptr() );
    CHECK( load( false ) == replacement );
}

#endif // TILES
