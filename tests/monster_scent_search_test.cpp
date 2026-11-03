#include <algorithm>
#include <vector>

#include "cata_catch.h"
#include "map_iterator.h"
#include "monster_scent_search.h"

TEST_CASE( "monster_scent_ranking_preserves_live_direction_order", "[monster][threading][scent]" )
{
    monster_scent_snapshot snapshot;
    snapshot.width = 5;
    snapshot.height = 5;
    snapshot.z = 0;
    snapshot.values.resize( 25 );
    for( int seed = 0; seed < 40; ++seed ) {
        for( int i = 0; i < 25; ++i ) {
            snapshot.values[i] = ( i * 7 + seed * 11 ) % 6 * 10;
        }
        for( int x : { 0, 2, 4 } ) {
            const tripoint_bub_ms min( std::max( 0, x - 1 ), 1, -1 );
            const tripoint_bub_ms max( std::min( 4, x + 1 ), 3, 1 );
            const auto ranking = rank_monster_scent( snapshot, min, max );
            REQUIRE( ranking.count <= 27 );
            for( int minimum : { 1, 10, 40, 100 } ) {
                for( int blocked_z : { -2, -1, 0, 1 } ) {
                    const auto eligible = [&]( const tripoint_bub_ms &p ) {
                        return p.z() != blocked_z;
                    };
                    std::vector<tripoint_bub_ms> expected;
                    int best = minimum;
                    for( const auto &p : tripoint_range<tripoint_bub_ms>( min, max ) ) {
                        const int raw = snapshot.values[p.x() * snapshot.height + p.y()];
                        const int strength = eligible( p ) && raw > 0 ? raw - std::abs( p.z() ) : 0;
                        if( strength > best ) {
                            expected.clear();
                            best = strength;
                        }
                        if( strength == best ) {
                            expected.push_back( p );
                        }
                    }
                    CHECK( ( select_monster_scent( ranking, minimum, eligible ) == expected ) );
                }
            }
        }
    }
}
