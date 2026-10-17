#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <new>
#include <string>

#include "coordinates.h"
#include "lightmap.h"
#include "tile_layer_view.h"

static bool count_allocations = false;
static unsigned allocations = 0;
void *operator new( std::size_t size )
{
    if( count_allocations ) {
        ++allocations;
    }
    if( void *p = std::malloc( size ? size : 1 ) ) {
        return p;
    }
    throw std::bad_alloc();
}
void operator delete( void *p ) noexcept
{
    std::free( p );
}
void operator delete( void *p, std::size_t ) noexcept
{
    std::free( p );
}

int main()
{
    // Both strings exceed SSO. The comparison uses the actual old value
    // construction and new assignment, with assertions enabled in Release.
    const std::string id( 80, 't' );
    const std::string subcategory( 48, 'c' );
    const tripoint_bub_ms position( 1, 2, 3 );
    const tripoint_abs_ms absolute( 101, 102, 3 );
    tile_layer_view reused{ id, TILE_CATEGORY::TERRAIN, subcategory, position,
                            3, 1, lit_level::LOW, true, absolute };
    const tile_layer_view retained = reused;
    count_allocations = true;
    for( int i = 0; i < 1000; ++i ) {
        tile_layer_view fresh{ id, TILE_CATEGORY::FURNITURE, subcategory, position,
                               i, 2, lit_level::LIT, false, absolute };
        assert( fresh.id == id );
    }
    count_allocations = false;
    const unsigned construction_allocations = allocations;
    assert( construction_allocations >= 2000 );
    allocations = 0;
    count_allocations = true;
    for( int i = 0; i < 1000; ++i ) {
        reused.assign( id, TILE_CATEGORY::FURNITURE, subcategory, position,
                       i, 2, lit_level::LIT, false, absolute );
        assert( reused.id == id && reused.subcategory == subcategory );
        assert( reused.category == TILE_CATEGORY::FURNITURE && reused.subtile == i );
        assert( reused.rotation == 2 && reused.position == position );
        assert( reused.absolute_position == absolute && reused.light == lit_level::LIT );
        assert( !reused.night_vision );
    }
    count_allocations = false;
    assert( allocations == 0 );
    assert( retained.category == TILE_CATEGORY::TERRAIN && retained.subtile == 3 );
    assert( retained.rotation == 1 && retained.night_vision );
    reused.id.assign( "changed" );
    assert( retained.id == id );
    std::printf( "constructions=%u warm_reuse=%u owned_copy=passed\n",
                 construction_allocations, allocations );
}
