#include "monster_scent_search.h"

#include <algorithm>
#include <cstdlib>

#include "map_iterator.h"

monster_scent_ranking rank_monster_scent( const monster_scent_snapshot &snapshot,
                                        const tripoint_bub_ms &min, const tripoint_bub_ms &max )
{
    monster_scent_ranking result;
    for( const tripoint_bub_ms &position : tripoint_range<tripoint_bub_ms>( min, max ) ) {
        if( position.x() < 0 || position.x() >= snapshot.width ||
            position.y() < 0 || position.y() >= snapshot.height ) {
            continue;
        }
        const int raw = snapshot.values[position.x() * snapshot.height + position.y()];
        const int strength = raw > 0 ? raw - std::abs( snapshot.z - position.z() ) : 0;
        const unsigned order = static_cast<unsigned>( result.count );
        result.neighbors[result.count++] = { position, strength, order };
    }
    std::sort( result.neighbors.begin(), result.neighbors.begin() + result.count,
    []( const monster_scent_neighbor &lhs, const monster_scent_neighbor &rhs ) {
        return lhs.strength != rhs.strength ? lhs.strength > rhs.strength : lhs.order < rhs.order;
    } );
    return result;
}
