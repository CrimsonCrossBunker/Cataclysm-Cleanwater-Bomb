#include "route_snapshot.h"

#include <algorithm>
#include <cmath>
#include <queue>
#include <utility>

std::size_t route_snapshot::index( const tripoint_bub_ms &p ) const
{
    return static_cast<std::size_t>( p.x() - min.x() ) * ( max.y() - min.y() + 1 ) +
           p.y() - min.y();
}

route_snapshot_result search_route_snapshot( const route_snapshot &snapshot )
{
    // Same neighbor order, queue tie policy, diagonal penalty and stopping rule
    // as map::route. Only its live-map queries are replaced with captured values.
    struct greater_score {
        bool operator()( const std::pair<int, tripoint_bub_ms> &a,
                         const std::pair<int, tripoint_bub_ms> &b ) const {
            return a.first > b.first;
        }
    };
    route_snapshot_result result;
    const std::size_t size = snapshot.cells.size();
    result.checked_avoid.resize( size );
    result.checked_cost.resize( size );
    std::vector<uint8_t> closed( size );
    std::vector<uint8_t> open( size );
    std::vector<int> score( size );
    std::vector<tripoint_bub_ms> parent( size );
    std::priority_queue<std::pair<int, tripoint_bub_ms>,
        std::vector<std::pair<int, tripoint_bub_ms>>, greater_score> pending;
    const auto distance = [&]( const tripoint_bub_ms &p ) {
        const int dx = p.x() - snapshot.target.x();
        const int dy = p.y() - snapshot.target.y();
        return snapshot.euclidean ? static_cast<int>( static_cast<float>(
                   std::sqrt( static_cast<double>( dx * dx ) + dy * dy ) ) ) :
               std::max( std::abs( dx ), std::abs( dy ) );
    };
    const auto add = [&]( int cost, int estimate, const tripoint_bub_ms &from,
    const tripoint_bub_ms &to ) {
        const std::size_t index = snapshot.index( to );
        if( closed[index] || ( open[index] && cost >= score[index] ) ) {
            return;
        }
        open[index] = true;
        score[index] = cost;
        parent[index] = from;
        pending.emplace( estimate, to );
    };
    add( 0, 0, snapshot.start, snapshot.start );
    while( !pending.empty() ) {
        const tripoint_bub_ms cur = pending.top().second;
        pending.pop();
        const std::size_t current = snapshot.index( cur );
        if( closed[current] ) {
            continue;
        }
        if( score[current] > snapshot.max_length ) {
            return result;
        }
        if( cur == snapshot.target ) {
            tripoint_bub_ms p = cur;
            for( int remaining = snapshot.max_length; remaining != 0; --remaining ) {
                if( p == snapshot.start ) {
                    break;
                }
                result.path.push_back( p );
                p = parent[snapshot.index( p )];
            }
            std::reverse( result.path.begin(), result.path.end() );
            return result;
        }
        closed[current] = true;
        for( std::size_t direction = 0; direction < 8; ++direction ) {
            const tripoint_bub_ms p( cur.x() + route_x_offset[direction],
                                     cur.y() + route_y_offset[direction], cur.z() );
            if( p.x() < snapshot.min.x() || p.x() >= snapshot.max.x() ||
                p.y() < snapshot.min.y() || p.y() >= snapshot.max.y() ) {
                continue;
            }
            const std::size_t next = snapshot.index( p );
            if( p != snapshot.target ) {
                if( !result.checked_avoid[next] && result.checked_cost[next] == 0 ) {
                    result.checked_cells.push_back( next );
                }
                result.checked_avoid[next] = true;
                if( snapshot.cells[next].avoid ) {
                    closed[next] = true;
                    continue;
                }
            }
            if( closed[next] ) {
                continue;
            }
            if( !result.checked_avoid[next] && result.checked_cost[next] == 0 ) {
                result.checked_cells.push_back( next );
            }
            result.checked_cost[next] |= uint8_t{ 1 } << direction;
            const int cost = snapshot.cells[next].entering_cost[direction];
            if( cost < 0 ) {
                if( cost == -1 ) {
                    closed[next] = true;
                }
                continue;
            }
            const int next_score = score[current] + ( direction >= 4 ? 1 : 0 ) + cost;
            add( next_score, next_score + 2 * distance( p ), cur, p );
        }
    }
    return result;
}
