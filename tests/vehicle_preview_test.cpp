#if defined(TILES)
#include <utility>

#include "cata_catch.h"
#include "cata_tiles.h"
#include "coordinates.h"
#include "point.h"

TEST_CASE( "vehicle_preview_selection_covers_both_corners", "[tiles][vehicle_preview]" )
{
    point_rel_ms first( 0, 0 );
    point_rel_ms second( 2, 1 );
    if( GENERATE( false, true ) ) {
        std::swap( first, second );
    }
    const SDL_Rect area = cata_tiles::vehicle_preview_selection_rect( first, second,
                          point_rel_ms::zero, point( 100, 200 ), point( 32, 24 ) );
    // Mount x points upward in the fixed preview, and mount y points right.
    CHECK( area.x == 100 );
    CHECK( area.y == 152 );
    CHECK( area.w == 64 );
    CHECK( area.h == 72 );
}

TEST_CASE( "vehicle_preview_selection_follows_the_cursor", "[tiles][vehicle_preview]" )
{
    const SDL_Rect area = cata_tiles::vehicle_preview_selection_rect( point_rel_ms::zero,
                          point_rel_ms( 2, 1 ), point_rel_ms( -2, -1 ), point( 100, 200 ), point( 32, 24 ) );
    CHECK( area.x == 68 );
    CHECK( area.y == 200 );
    CHECK( area.w == 64 );
    CHECK( area.h == 72 );
}

TEST_CASE( "vehicle_preview_selection_starts_with_one_cell", "[tiles][vehicle_preview]" )
{
    const point_rel_ms mount( 3, -2 );
    const SDL_Rect area = cata_tiles::vehicle_preview_selection_rect( mount, mount, -mount,
                          point( 100, 200 ), point( 32, 24 ) );
    CHECK( area.x == 100 );
    CHECK( area.y == 200 );
    CHECK( area.w == 32 );
    CHECK( area.h == 24 );
}
#endif
