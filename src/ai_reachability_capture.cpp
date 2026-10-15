#include "ai_reachability.h"

#include "map.h"
#include "mapdata.h"
#include "level_cache.h"
#include "submap.h"
#include "type_id.h"

namespace ai_reachability
{
bool capture_geometry( const map &here, snapshot &values )
{
    if( here.getmapsize() != MAPSIZE ) {
        return false;
    }
    values.terrain.resize( ter_t::count() );
    for( std::size_t i = 0; i < values.terrain.size(); ++i ) {
        const ter_id id( static_cast<int>( i ) );
        const ter_t &ter = id.obj();
        values.terrain[i] = ( ter.id.is_null() ? 0 : ai_reachability::present ) |
                            ( ter.movecost != 0 ? ai_reachability::movable : 0 ) |
                            ( ter.has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) ||
                              ter.has_flag( ter_furn_flag::TFLAG_GOES_DOWN ) ? ai_reachability::vertical : 0 );
    }
    values.furniture_nonblocking.resize( furn_t::count() );
    for( std::size_t i = 0; i < values.furniture_nonblocking.size(); ++i ) {
        values.furniture_nonblocking[i] = furn_id( static_cast<int>( i ) ).obj().movecost >= 0;
    }
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        const int layer = z + OVERMAP_DEPTH;
        values.transparent[layer] = here.get_cache_ref( z ).transparent_cache_wo_fields;
        for( int sx = 0; sx < MAPSIZE; ++sx ) {
            for( int sy = 0; sy < MAPSIZE; ++sy ) {
                auto &block = values.blocks[( layer * MAPSIZE + sx ) * MAPSIZE + sy];
                const submap *sm = here.maptile_at( tripoint_bub_ms{ sx * SEEX, sy * SEEY, z } ).wrapped_submap();
                block.uniform = !sm || sm->is_uniform();
                if( !sm ) {
                    block.cells[0] = {};
                } else if( block.uniform ) {
                    const point_sm_ms p{ 0, 0 };
                    block.cells[0] = { sm->get_ter( p ).to_i(), sm->get_furn( p ).to_i() };
                } else {
                    for( int x = 0; x < SEEX; ++x ) {
                        for( int y = 0; y < SEEY; ++y ) {
                            const point_sm_ms p{ x, y };
                            block.cells[x * SEEY + y] = { sm->get_ter( p ).to_i(), sm->get_furn( p ).to_i() };
                        }
                    }
                }
            }
        }
    }
    return true;
}
} // namespace ai_reachability
