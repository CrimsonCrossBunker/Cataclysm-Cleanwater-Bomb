#include "ai_reachability_owner.h"

#include <ai_reachability.h>
#include <ai_reachability_fwd.h>
#include <coordinates.h>
#include <map_scale_constants.h>
#include <point.h>
#include <array>
#include <bitset>
#include <cstddef>
#include <cstdint>
#include <thread>
#include <utility>
#include <vector>

#include "cata_assert.h"
#include "thread_pool.h"

#include "map.h"
#include "mapdata.h"
#include "level_cache.h"
#include "submap.h"
#include "type_id.h"

namespace ai_reachability
{
namespace
{
bool matches_block( const submap *sm, const block &captured )
{
    if( !sm ) {
        return captured.version.first == 0;
    }
    const std::pair<std::uint64_t, std::uint64_t> stamp = sm->geometry_stamp();
    return stamp.first != 0 && stamp == captured.version && sm->is_uniform() == captured.uniform;
}
} // namespace

bool capture_geometry( const map &here, snapshot &values )
{
    if( here.getmapsize() != MAPSIZE ) {
        return false;
    }
    values.opaque_passable = {};
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
                ai_reachability::block &block = values.blocks[( layer * MAPSIZE + sx ) * MAPSIZE + sy];
                const submap *sm = here.get_submap_at_grid( tripoint_rel_sm{ sx, sy, z } );
                block.version = sm ? sm->geometry_stamp() : std::pair<std::uint64_t, std::uint64_t> {};
                if( sm && block.version.first == 0 ) {
                    return false;
                }
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
                // Resolve fields and vehicle parts on the owner. A zero terrain
                // cost is an unconditional rejection in move_cost_internal, so
                // uniform rock/wall blocks need no per-cell world queries.
                // All remaining opaque cells use the complete original rule.
                if( block.uniform && !( values.terrain.at( block.cells[0].terrain ) & movable ) ) {
                    continue;
                }
                for( int x = sx * SEEX; x < ( sx + 1 ) * SEEX; ++x ) {
                    for( int y = sy * SEEY; y < ( sy + 1 ) * SEEY; ++y ) {
                        if( !values.transparent[layer][x][y] &&
                            ( values.terrain.at( block.at( x % SEEX, y % SEEY ).terrain ) & movable ) ) {
                            values.opaque_passable[layer][x][y] = here.passable( tripoint_bub_ms{ x, y, z } );
                        }
                    }
                }
            }
        }
    }
    return true;
}
bool geometry_matches( const map &here, const snapshot &values )
{
    if( here.getmapsize() != MAPSIZE || values.terrain.size() != ter_t::count() ||
        values.furniture_nonblocking.size() != furn_t::count() ) {
        return false;
    }
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        const int layer = z + OVERMAP_DEPTH;
        if( values.transparent[layer] != here.get_cache_ref( z ).transparent_cache_wo_fields ) {
            return false;
        }
        for( int sx = 0; sx < MAPSIZE; ++sx ) {
            for( int sy = 0; sy < MAPSIZE; ++sy ) {
                const ai_reachability::block &block = values.blocks[( layer * MAPSIZE + sx ) * MAPSIZE + sy];
                const submap *sm = here.get_submap_at_grid( tripoint_rel_sm{ sx, sy, z } );
                if( !matches_block( sm, block ) ) {
                    return false;
                }
            }
        }
    }
    return true;
}
geometry_view::geometry_view( const map &world, const snapshot &values ) :
    owner_thread_( std::this_thread::get_id() ), world_( world ), values_( values )
{
    if( is_pool_worker_thread() ) {
        return;
    }
    catalogs_match_ = world.getmapsize() == MAPSIZE && values.terrain.size() == ter_t::count() &&
                      values.furniture_nonblocking.size() == furn_t::count();
}
bool geometry_view::matches_block( int layer, const point_bub_ms &position )
{
    const int sx = position.x() / SEEX;
    const int sy = position.y() / SEEY;
    const int index = ( layer * MAPSIZE + sx ) * MAPSIZE + sy;
    unsigned char &checked = checked_[index];
    if( checked == 0 ) {
        const submap *sm = world_.get_submap_at_grid( tripoint_rel_sm{ sx, sy, layer - OVERMAP_DEPTH } );
        checked = ai_reachability::matches_block( sm, values_.blocks[index] ) ? 1 : 2;
    }
    if( checked == 2 ) {
        stale_ = true;
    }
    return checked == 1;
}
bool geometry_view::matches_at( const tripoint_bub_ms &position, int direction )
{
    if( owner_thread_ != std::this_thread::get_id() || is_pool_worker_thread() ) {
        return false;
    }
    if( !catalogs_match_ ) {
        stale_ = true;
        return false;
    }
    const int z = position.z() + OVERMAP_DEPTH;
    const int x = position.x();
    const int y = position.y();
    if( z < 0 || z >= OVERMAP_LAYERS || x < 0 || x >= MAPSIZE_X || y < 0 || y >= MAPSIZE_Y ||
        ( direction != 1 && direction != -1 ) || ( direction == -1 && z + 1 >= OVERMAP_LAYERS ) ) {
        return false;
    }
    if( !matches_block( z, position.xy() ) ||
        ( direction == -1 && !matches_block( z + 1, position.xy() ) ) ) {
        return false;
    }
    unsigned char &transparency = transparency_checked_[z];
    if( transparency == 0 ) {
        // This view belongs to one mutation-free owner flood. A matching layer
        // needs no more world-cache queries during that flood. If any bit differs,
        // retain the original cell checks so unrelated cells can still be reused.
        transparency = values_.transparent[z] ==
                       world_.get_cache_ref( position.z() ).transparent_cache_wo_fields ? 1 : 2;
    }
    if( transparency == 2 && values_.transparent[z][x][y] !=
        world_.get_cache_ref( position.z() ).transparent_cache_wo_fields[x][y] ) {
        stale_ = true;
        return false;
    }
    return true;
}
bool geometry_view::stale() const
{
    cata_assert( owner_thread_ == std::this_thread::get_id() );
    return stale_;
}
} // namespace ai_reachability
