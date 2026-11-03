#include <algorithm>
#include <thread>
#include <vector>

#include "cata_catch.h"
#include "monster_friendliness.h"
#include "monster_target_index.h"

TEST_CASE( "target_cells_floor_negative_coordinates", "[monster][target_index]" )
{
    CHECK( ( monster_target_index::cell( { -1, -16, -2 } ) == tripoint( -1, -1, -2 ) ) );
    CHECK( ( monster_target_index::cell( { -17, 16, 3 } ) == tripoint( -2, 1, 3 ) ) );
}

TEST_CASE( "target_index_preserves_order_and_never_excludes_visible_range",
           "[monster][target_index]" )
{
    monster_target_index index;
    std::vector<tripoint> positions;
    for( int x = -100; x <= 100; x += 7 ) {
        for( int y = -100; y <= 100; y += 11 ) {
            positions.emplace_back( x, y, x % 13 );
        }
    }
    for( std::size_t i = positions.size(); i > 0; --i ) {
        index.insert( i - 1, positions[i - 1] );
    }
    for( int x : { -33, -17, -1, 0, 15, 16, 31 } ) {
        const tripoint observer{ x, -1, 0 };
        const auto found = index.candidates( monster_target_index::cell( observer ) );
        CHECK( std::is_sorted( found.begin(), found.end() ) );
        for( std::size_t i = 0; i < positions.size(); ++i ) {
            const tripoint &p = positions[i];
            if( std::abs( p.x - observer.x ) <= MAX_VIEW_DISTANCE &&
                std::abs( p.y - observer.y ) <= MAX_VIEW_DISTANCE &&
                std::abs( p.z - observer.z ) <= fov_3d_z_range ) {
                CHECK( std::binary_search( found.begin(), found.end(), i ) );
            }
        }
    }
}

TEST_CASE( "readonly_target_windows_can_be_prepared_concurrently", "[monster][target_index]" )
{
    monster_target_index index;
    for( std::size_t i = 0; i < 4096; ++i ) {
        index.insert( i, tripoint{ static_cast<int>( i % 128 ), static_cast<int>( i / 128 ), 0 } );
    }
    std::vector<std::vector<std::size_t>> expected( 16 );
    std::vector<std::vector<std::size_t>> actual( 16 );
    for( int i = 0; i < 16; ++i ) {
        expected[i] = index.candidates( { i - 8, 0, 0 } );
    }
    std::vector<std::thread> workers;
    for( int worker = 0; worker < 4; ++worker ) {
        workers.emplace_back( [&, worker]() {
            for( int i = worker; i < 16; i += 4 ) {
                actual[i] = index.candidates( { i - 8, 0, 0 } );
            }
        } );
    }
    for( auto &worker : workers ) {
        worker.join();
    }
    CHECK( actual == expected );
}

TEST_CASE( "target_index_tracks_movement_and_removal", "[monster][target_index]" )
{
    monster_target_index index;
    const tripoint origin{ 0, 0, 0 };
    const tripoint far{ 1000, 1000, 0 };
    index.insert( 5, far );
    CHECK( index.candidates( origin ).empty() );
    index.erase( 5, far );
    index.insert( 5, origin );
    CHECK( index.candidates( origin ) == std::vector<std::size_t>{ 5 } );
    index.erase( 5, origin );
    CHECK( index.candidates( origin ).empty() );
}

TEST_CASE( "friendliness_revision_tracks_membership_without_countdown_churn",
           "[monster][target_index]" )
{
    monster_friendliness value = 10;
    const auto before = monster_friendliness::revision();
    CHECK( value-- == 10 );
    CHECK( static_cast<int>( --value ) == 8 );
    value = -1;
    CHECK( monster_friendliness::revision() == before );
    ++value;
    CHECK( static_cast<int>( value ) == 0 );
    CHECK( monster_friendliness::revision() == before + 1 );
    value += 2;
    CHECK( monster_friendliness::revision() == before + 2 );
    value -= 2;
    CHECK( monster_friendliness::revision() == before + 3 );
    monster_friendliness copied;
    copied = value;
    CHECK( monster_friendliness::revision() > before + 3 );
}
