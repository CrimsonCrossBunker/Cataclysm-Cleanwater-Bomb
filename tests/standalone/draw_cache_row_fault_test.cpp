#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <new>
#include "coordinates.h"
#include "lightmap.h"
#include "view_snapshot.h"

static int fail_after = -1;
static unsigned attempts = 0;
void *operator new( std::size_t size )
{
    if( fail_after >= 0 ) {
        ++attempts;
        if( fail_after-- == 0 ) {
            fail_after = -1;
            throw std::bad_alloc();
        }
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

static void effect( draw_points_cache_t::row_vec &row )
{
    row.emplace_back( tile_render_info::tile_view_data{ tripoint_bub_ms( 0, 0, 0 ) },
                      tile_render_info::tile_render_scratch{},
                      tile_render_info::vision_effect{ visibility_type::HIDDEN } );
}
static void sprite( draw_points_cache_t::row_vec &row )
{
    row.emplace_back( tile_render_info::tile_view_data{ tripoint_bub_ms( 1, 0, 0 ) },
                      tile_render_info::tile_render_scratch{},
                      tile_render_info::sprite{ lit_level::LIT, {} } );
}
int main()
{
    draw_points_cache_t::row_vec warm;
    sprite( warm );
    warm.clear();
    // This uses the actual production row implementation. The allocator is
    // armed only around one append, after every fixture value is initialized.
    // First failure is entry-vector growth; second is index-vector publication.
    for( int fail = 0; fail < 2; ++fail ) {
        draw_points_cache_t::row_vec row;
        effect( row );
        attempts = 0;
        fail_after = fail;
        bool caught = false;
        try {
            sprite( row );
        } catch( const std::bad_alloc & ) {
            caught = true;
        }
        fail_after = -1;
        assert( caught );
        assert( attempts == static_cast<unsigned>( fail + 1 ) );
        assert( row.size() == 1 );
        assert( row.sprite_indices().empty() );
        assert( std::holds_alternative<tile_render_info::vision_effect>( row[0].var ) );
        sprite( row );
        assert( row.size() == 2 );
        assert( row.sprite_indices().size() == 1 && row.sprite_indices()[0] == 1 );
        assert( std::holds_alternative<tile_render_info::sprite>( row[1].var ) );
        for( int i = 0; i < 40; ++i ) {
            effect( row );
        }
        assert( row.sprite_indices()[0] == 1 );
        row.clear();
        assert( row.size() == 0 && row.sprite_indices().empty() );
        effect( row );
        sprite( row );
        assert( row.sprite_indices().size() == 1 && row.sprite_indices()[0] == 1 );
        std::printf( "allocation failure %d: rollback, reuse, relocation and clear passed\n", fail );
    }
}
