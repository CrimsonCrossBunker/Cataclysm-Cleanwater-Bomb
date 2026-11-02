#include "monster_path_batch.h"

#include <algorithm>
#include <tuple>
#include <utility>

#include "cpu_scheduler.h"
#include "creature.h"
#include "line.h"
#include "map.h"
#include "mapdata.h"

namespace
{
thread_local monster_path_batch *current_paths = nullptr;

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
    if( published_ ) {
        current_paths = previous_;
    }
}

void monster_path_batch::add( const Creature &who, const tripoint_bub_ms &target )
{
    if( !published_ && candidates_.size() < 64 ) {
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
        const Creature &who, const tripoint_bub_ms &target )
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
    if( count > 8192 ) {
        return std::nullopt;
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
            if( settings.avoid_traps && ( special & PathfindingFlag::Air ) ) {
                return std::nullopt;
            }
            auto &cell = snapshot.cells[snapshot.index( p )];
            cell.avoid = p != target && avoid( p );
            if( cell.avoid ) {
                continue;
            }
            // Only vehicles and inside-only doors inspect the incoming tile.
            // Ordinary terrain needs one cost query, not eight identical ones.
            const bool directional = ( special & PathfindingFlag::Vehicle ) ||
                                     here.has_flag( ter_furn_flag::TFLAG_OPENCLOSE_INSIDE, p );
            if( !directional ) {
                cell.entering_cost.fill( here.extra_cost( p, p, settings, special ) );
                continue;
            }
            for( std::size_t direction = 0; direction < 8; ++direction ) {
                const tripoint_bub_ms from( x - route_x_offset[direction],
                                            y - route_y_offset[direction], start.z() );
                cell.entering_cost[direction] = here.inbounds( from ) ?
                                               here.extra_cost( from, p, settings, special ) : -1;
            }
        }
    }
    return snapshot;
}

void monster_path_batch::prepare( const map &here )
{
    if( published_ || candidates_.size() < 4 || !cpu_parallel_enabled() ) {
        return;
    }
    origin_ = here.get_abs_sub();
    map_ = &here;
    std::size_t cells = 0;
    for( const candidate &pending : candidates_ ) {
        auto snapshot = capture( here, *pending.owner, pending.target );
        if( !snapshot || cells + snapshot->cells.size() > 65536 ) {
            continue;
        }
        cells += snapshot->cells.size();
        const auto inserted = indices_.emplace( pending.owner, entries_.size() );
        if( inserted.second ) {
            entries_.push_back( { pending.owner, pending.owner->get_pathfinding_settings(),
                                 std::move( *snapshot ), {}, false } );
        }
        if( entries_.size() >= 32 ) {
            break;
        }
    }
    if( entries_.size() < 4 ) {
        return;
    }
    cpu_parallel_for( cpu_task_kind::monster_paths, entries_.size(), 1,
    [this]( std::size_t begin, std::size_t end ) {
        for( std::size_t i = begin; i < end; ++i ) {
            entries_[i].result = search_route_snapshot( entries_[i].snapshot );
        }
    } );
    previous_ = current_paths;
    current_paths = this;
    published_ = true;
}

std::optional<std::vector<tripoint_bub_ms>> monster_path_batch::take(
    const map &here, const Creature &who, const pathfinding_target &target )
{
    if( !current_paths || current_paths->map_ != &here ||
        current_paths->origin_ != here.get_abs_sub() || target.r != 0 ) {
        return std::nullopt;
    }
    const auto found = current_paths->indices_.find( &who );
    if( found == current_paths->indices_.end() ) {
        return std::nullopt;
    }
    entry &prepared = current_paths->entries_[found->second];
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
    for( int x = snapshot.min.x(); x <= snapshot.max.x(); ++x ) {
        for( int y = snapshot.min.y(); y <= snapshot.max.y(); ++y ) {
            const tripoint_bub_ms p( x, y, snapshot.start.z() );
            const std::size_t index = snapshot.index( p );
            const auto &cell = snapshot.cells[index];
            if( prepared.result.checked_avoid[index] && cell.avoid != avoid( p ) ) {
                return std::nullopt;
            }
            const uint8_t mask = prepared.result.checked_cost[index];
            if( mask == 0 ) {
                continue;
            }
            const PathfindingFlags special = cache.special[p.xy()];
            if( settings.avoid_traps && ( special & PathfindingFlag::Air ) ) {
                return std::nullopt;
            }
            for( std::size_t direction = 0; direction < 8; ++direction ) {
                if( mask & ( uint8_t{ 1 } << direction ) ) {
                    const tripoint_bub_ms from( x - route_x_offset[direction],
                                                y - route_y_offset[direction], p.z() );
                    if( cell.entering_cost[direction] != here.extra_cost( from, p, settings, special ) ) {
                        return std::nullopt;
                    }
                }
            }
        }
    }
    return std::move( prepared.result.path );
}
