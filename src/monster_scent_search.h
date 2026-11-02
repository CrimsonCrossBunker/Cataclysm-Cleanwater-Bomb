#pragma once
#ifndef CATA_SRC_MONSTER_SCENT_SEARCH_H
#define CATA_SRC_MONSTER_SCENT_SEARCH_H

#include <array>
#include <cstddef>
#include <vector>

#include "coordinates.h"

struct monster_scent_snapshot {
    int width = 0;
    int height = 0;
    int z = 0;
    std::vector<int> values;
};

struct monster_scent_neighbor {
    tripoint_bub_ms position;
    int strength = 0;
    unsigned order = 0;
};

struct monster_scent_ranking {
    std::array<monster_scent_neighbor, 27> neighbors;
    std::size_t count = 0;
};

monster_scent_ranking rank_monster_scent( const monster_scent_snapshot &snapshot,
                                        const tripoint_bub_ms &min, const tripoint_bub_ms &max );

// Check vertical reachability on the owner, after earlier monsters' actions.
// Equal-strength directions keep radius-iteration order, including RNG weights.
template<typename Eligible>
std::vector<tripoint_bub_ms> select_monster_scent( const monster_scent_ranking &ranking,
        int minimum, const Eligible &eligible )
{
    std::vector<tripoint_bub_ms> result;
    for( std::size_t i = 0; i < ranking.count; ++i ) {
        const auto &neighbor = ranking.neighbors[i];
        if( neighbor.strength < minimum ) {
            break;
        }
        if( eligible( neighbor.position ) ) {
            minimum = neighbor.strength;
            result.push_back( neighbor.position );
        }
    }
    return result;
}

#endif // CATA_SRC_MONSTER_SCENT_SEARCH_H
