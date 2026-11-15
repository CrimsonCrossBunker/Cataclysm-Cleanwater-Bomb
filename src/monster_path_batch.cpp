#include "monster_path_batch.h"

#include <algorithm>
#include <iterator>
#include <new>
#include <system_error>
#include <tuple>
#include <utility>

#include "creature.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"
#include "thread_pool.h"

namespace
{
thread_local monster_path_batch *current_paths = nullptr;

// Bound retained snapshots independently of creature count. Cost sharing is
// temporary: it is discarded before workers start and never spans world changes.
constexpr std::size_t max_snapshot_cells = 256 * 1024;
constexpr std::size_t max_cached_cost_cells = 65536;

bool same_settings( const pathfinding_settings &a, const pathfinding_settings &b )
{
    return std::tie( a.bash_strength, a.max_dist, a.max_length, a.climb_cost,
                     a.allow_open_doors, a.allow_unlock_doors, a.avoid_traps, a.allow_climb_stairs,
                     a.avoid_rough_terrain, a.avoid_sharp, a.avoid_dangerous_fields, a.size ) ==
           std::tie( b.bash_strength, b.max_dist, b.max_length, b.climb_cost,
                     b.allow_open_doors, b.allow_unlock_doors, b.avoid_traps, b.allow_climb_stairs,
                     b.avoid_rough_terrain, b.avoid_sharp, b.avoid_dangerous_fields, b.size );
}
}

monster_path_batch::~monster_path_batch()
{
    for( auto **link = &current_paths; *link; link = &( *link )->previous_ ) {
        if( *link == this ) {
            *link = previous_;
            break;
        }
    }
}

void monster_path_batch::add( const Creature &who, const tripoint_bub_ms &target )
{
    if( !published_ ) {
        candidates_.push_back( { &who, target } );
    }
}

bool monster_path_batch::simple_route( const map &here, const Creature &who,
                                      const tripoint_bub_ms &target )
{
    const auto path = here.straight_route( who.pos_bub(), target );
    if( path.empty() ) {
        return false;
    }
    const auto &cache = here.get_pathfinding_cache_ref( target.z() );
    const auto avoid = who.get_path_avoid();
    return std::none_of( path.begin(), path.end(), [&]( const tripoint_bub_ms &p ) {
        PathfindingFlags special = cache.special[p.xy()];
        special.set_clear( PathfindingFlag::Ground );
        return special.is_any_set() || avoid( p );
    } );
}

std::optional<route_snapshot> monster_path_batch::capture( const map &here,
        const Creature &who, const tripoint_bub_ms &target, std::vector<cost_group> &costs,
        std::size_t &cached_cells, std::size_t remaining_cells )
{
    const tripoint_bub_ms start = who.pos_bub();
    const pathfinding_settings &settings = who.get_pathfinding_settings();
    if( start == target || start.z() != target.z() || !here.inbounds( start ) ||
        !here.inbounds( target ) || settings.max_length <= 0 ||
        rl_dist( start, target ) > settings.max_dist || simple_route( here, who, target ) ) {
        return std::nullopt;
    }
    route_snapshot snapshot;
    snapshot.start = start;
    snapshot.target = target;
    snapshot.min = tripoint_bub_ms( std::min( start.x(), target.x() ) - 16,
                                   std::min( start.y(), target.y() ) - 16, start.z() );
    snapshot.max = tripoint_bub_ms( std::max( start.x(), target.x() ) + 16,
                                   std::max( start.y(), target.y() ) + 16, start.z() );
    here.clip_to_bounds( snapshot.min );
    here.clip_to_bounds( snapshot.max );
    snapshot.max_length = settings.max_length;
    snapshot.euclidean = trigdist;
    const std::size_t count = static_cast<std::size_t>( snapshot.max.x() - snapshot.min.x() + 1 ) *
                              ( snapshot.max.y() - snapshot.min.y() + 1 );
    if( count > 8192 || count > remaining_cells ) {
        return std::nullopt;
    }
    auto group = std::find_if( costs.begin(), costs.end(), [&]( const cost_group &value ) {
        return same_settings( value.settings, settings );
    } );
    if( group == costs.end() ) {
        costs.push_back( { settings, {} } );
        group = std::prev( costs.end() );
    }
    snapshot.cells.resize( count );
    const auto &cache = here.get_pathfinding_cache_ref( start.z() );
    const auto avoid = who.get_path_avoid();
    for( int x = snapshot.min.x(); x <= snapshot.max.x(); ++x ) {
        for( int y = snapshot.min.y(); y <= snapshot.max.y(); ++y ) {
            const tripoint_bub_ms p( x, y, start.z() );
            const PathfindingFlags special = cache.special[p.xy()];
            // Ledge descent can create an extra z-level search node. It stays
            // on the original route implementation rather than being flattened.
            if( settings.avoid_traps && ( special & ( PathfindingFlag::Air | PathfindingFlag::DangerousTrap ) ) ) {
                return std::nullopt;
            }
            auto &cell = snapshot.cells[snapshot.index( p )];
            cell.avoid = p != target && avoid( p );
            if( cell.avoid ) {
                continue;
            }
            const auto cached = group->cells.find( p );
            if( cached != group->cells.end() ) {
                cell.entering_cost = cached->second;
                continue;
            }
            // Only vehicles and inside-only doors inspect the incoming tile.
            // Ordinary terrain needs one cost query, not eight identical ones.
            const bool directional = ( special & PathfindingFlag::Vehicle ) ||
                                     here.has_flag( ter_furn_flag::TFLAG_OPENCLOSE_INSIDE, p );
            if( !directional ) {
                cell.entering_cost.fill( here.extra_cost( p, p, settings, special ) );
            } else {
                for( std::size_t direction = 0; direction < 8; ++direction ) {
                    const tripoint_bub_ms from( x - route_x_offset[direction],
                                                y - route_y_offset[direction], start.z() );
                    cell.entering_cost[direction] = here.inbounds( from ) ?
                                                   here.extra_cost( from, p, settings, special ) : -1;
                }
            }
            if( cached_cells < max_cached_cost_cells ) {
                group->cells.emplace( p, cell.entering_cost );
                ++cached_cells;
            }
        }
    }
    return snapshot;
}

void monster_path_batch::prepare( const map &here )
try {
    if( published_ || candidates_.size() < 4 || is_pool_worker_thread() ||
        get_thread_pool().num_workers() == 0 ) {
        return;
    }
    origin_ = here.get_abs_sub();
    map_ = &here;
    std::size_t cells = 0;
    {
        std::vector<cost_group> costs;
        std::size_t cached_cells = 0;
        for( const candidate &pending : candidates_ ) {
            if( indices_.count( pending.owner ) != 0 ) {
                continue;
            }
            auto snapshot = capture( here, *pending.owner, pending.target, costs, cached_cells,
                                     max_snapshot_cells - cells );
            if( !snapshot ) {
                continue;
            }
            cells += snapshot->cells.size();
            indices_.emplace( pending.owner, entries_.size() );
            entries_.push_back( { pending.owner, pending.owner->get_pathfinding_settings(),
                                 std::move( *snapshot ), {}, false } );
        }
    }
    if( entries_.size() < 4 ) {
        entries_.clear();
        indices_.clear();
        return;
    }
    parallel_for( 0, static_cast<int>( entries_.size() ), [this]( int i ) {
        entries_[i].result = search_route_snapshot( entries_[i].snapshot );
    } );
    previous_ = current_paths;
    current_paths = this;
    published_ = true;
}
catch( const std::bad_alloc & ) {
    entries_.clear();
    indices_.clear();
}
catch( const std::system_error & ) {
    entries_.clear();
    indices_.clear();
}

std::optional<std::vector<tripoint_bub_ms>> monster_path_batch::take(
    const map &here, const Creature &who, const pathfinding_target &target )
{
    monster_path_batch *batch = current_paths;
    while( batch && batch->map_ != &here ) {
        batch = batch->previous_;
    }
    if( !batch ||
        batch->origin_ != here.get_abs_sub() || target.r != 0 ) {
        return std::nullopt;
    }
    const auto found = batch->indices_.find( &who );
    if( found == batch->indices_.end() ) {
        return std::nullopt;
    }
    entry &prepared = batch->entries_[found->second];
    const auto &snapshot = prepared.snapshot;
    const auto &settings = who.get_pathfinding_settings();
    if( prepared.used || who.pos_bub() != snapshot.start || target.center != snapshot.target ||
        !here.inbounds( snapshot.min ) || !here.inbounds( snapshot.max ) ||
        snapshot.euclidean != trigdist || !same_settings( prepared.settings, settings ) ) {
        return std::nullopt;
    }
    prepared.used = true;
    if( simple_route( here, who, target.center ) ) {
        return std::nullopt;
    }
    const auto &cache = here.get_pathfinding_cache_ref( snapshot.start.z() );
    const auto avoid = who.get_path_avoid();
    const std::size_t height = snapshot.max.y() - snapshot.min.y() + 1;
    for( const std::size_t index : prepared.result.checked_cells ) {
        const tripoint_bub_ms p( snapshot.min.x() + static_cast<int>( index / height ),
                                 snapshot.min.y() + static_cast<int>( index % height ), snapshot.start.z() );
        const auto &cell = snapshot.cells[index];
        if( prepared.result.checked_avoid[index] && cell.avoid != avoid( p ) ) {
            return std::nullopt;
        }
        const uint8_t mask = prepared.result.checked_cost[index];
        if( mask == 0 ) {
            continue;
        }
        const PathfindingFlags special = cache.special[p.xy()];
        if( settings.avoid_traps && ( special & ( PathfindingFlag::Air | PathfindingFlag::DangerousTrap ) ) ) {
            return std::nullopt;
        }
        for( std::size_t direction = 0; direction < 8; ++direction ) {
            if( mask & ( uint8_t{ 1 } << direction ) ) {
                const tripoint_bub_ms from( p.x() - route_x_offset[direction],
                                            p.y() - route_y_offset[direction], p.z() );
                if( cell.entering_cost[direction] != here.extra_cost( from, p, settings, special ) ) {
                    return std::nullopt;
                }
            }
        }
    }
    ++batch->used_count_;
    return std::move( prepared.result.path );
}
