#include <array>
#include <vector>

#include "cata_catch.h"
#include "monster_local_cache.h"

TEST_CASE( "monster_local_cache_preserves_scent_weights", "[monster][local_cache]" )
{
    monster_local_cache<bool, 2, 1> cache;
    std::vector<std::array<int, 3>> original;
    std::vector<std::array<int, 3>> cached;
    int queries = 0;
    int original_queries = 0;
    for( int z = -1; z <= 1; ++z ) {
        for( int dx = -1; dx <= 1; ++dx ) {
            for( int dy = -1; dy <= 1; ++dy ) {
                for( int x = dx - 1; x <= dx + 1; ++x ) {
                    for( int y = dy - 1; y <= dy + 1; ++y ) {
                        const bool valid = ( x + y + z ) % 2 == 0;
                        ++original_queries;
                        if( valid ) {
                            original.push_back( {x, y, z} );
                        }
                        if( cache.get( x, y, z, [&]() {
                            ++queries;
                            return valid;
                        } ) ) {
                            cached.push_back( {x, y, z} );
                        }
                    }
                }
            }
        }
    }
    CHECK( original == cached );
    CHECK( queries == 75 );
    CHECK( original_queries == 243 );
    CHECK( cached.size() > 75 );
}

TEST_CASE( "monster_local_cache_caches_missing_helpers_and_has_local_lifetime",
           "[monster][local_cache]" )
{
    int helper = 1;
    int queries = 0;
    monster_local_cache<int *, 1, 0> cache;
    for( int i = 0; i < 3; ++i ) {
        CHECK( cache.get( -1, 1, 0, [&]() -> int * {
            ++queries;
            return nullptr;
        } ) == nullptr );
    }
    CHECK( queries == 1 );
    // Out-of-window queries are never aliased into a valid entry.
    for( const auto &offset : std::vector<std::array<int, 3>>{
             {2, 0, 0}, {-2, 0, 0}, {0, 2, 0}, {0, -2, 0}, {0, 0, 1}, {0, 0, -1}
         } ) {
        CHECK( cache.get( offset[0], offset[1], offset[2], [&]() {
        ++queries;
            return &helper;
        } ) == &helper );
    }
    CHECK( queries == 7 );
    monster_local_cache<int *, 1, 0> next_action;
    CHECK( next_action.get( -1, 1, 0, [&]() {
        return &helper;
    } ) == &helper );
}
