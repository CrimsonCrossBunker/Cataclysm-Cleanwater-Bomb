#include <algorithm>

#include "cata_catch.h"
#include "route_snapshot.h"

static route_snapshot open_snapshot()
{
    route_snapshot snapshot;
    snapshot.min = tripoint_bub_ms( 10, 10, 0 );
    snapshot.max = tripoint_bub_ms( 18, 18, 0 );
    snapshot.start = tripoint_bub_ms( 11, 14, 0 );
    snapshot.target = tripoint_bub_ms( 17, 14, 0 );
    snapshot.max_length = 100;
    snapshot.cells.resize( 81 );
    for( auto &cell : snapshot.cells ) {
        cell.entering_cost.fill( 2 );
    }
    return snapshot;
}

TEST_CASE( "snapshot_astar_retains_neighbor_order_and_length_limit", "[pathfinding][threading]" )
{
    auto snapshot = open_snapshot();
    SECTION( "straight corridor" ) {
        const auto result = search_route_snapshot( snapshot );
        REQUIRE( result.path.size() == 6 );
        for( int i = 0; i < 6; ++i ) {
            CHECK( ( result.path[i] == tripoint_bub_ms( 12 + i, 14, 0 ) ) );
        }
    }
    SECTION( "cost over budget has no route" ) {
        snapshot.max_length = 11;
        CHECK( search_route_snapshot( snapshot ).path.empty() );
    }
    SECTION( "target is exempt from avoidance" ) {
        snapshot.cells[snapshot.index( snapshot.target )].avoid = true;
        const auto result = search_route_snapshot( snapshot );
        REQUIRE_FALSE( result.path.empty() );
        CHECK( ( result.path.back() == snapshot.target ) );
        CHECK_FALSE( result.checked_avoid[snapshot.index( snapshot.target )] );
    }
}

TEST_CASE( "snapshot_astar_records_rejected_alternatives", "[pathfinding][threading]" )
{
    auto snapshot = open_snapshot();
    const tripoint_bub_ms wall( 14, 14, 0 );
    snapshot.cells[snapshot.index( wall )].entering_cost.fill( -1 );
    const auto result = search_route_snapshot( snapshot );
    REQUIRE_FALSE( result.path.empty() );
    CHECK( std::find( result.path.begin(), result.path.end(), wall ) == result.path.end() );
    CHECK( result.checked_cost[snapshot.index( wall )] != 0 );

    snapshot.cells[snapshot.index( wall )].avoid = true;
    const auto avoided = search_route_snapshot( snapshot );
    REQUIRE_FALSE( avoided.path.empty() );
    CHECK( avoided.checked_avoid[snapshot.index( wall )] != 0 );
    CHECK( avoided.checked_cost[snapshot.index( wall )] == 0 );
}

TEST_CASE( "snapshot_astar_distinguishes_directional_obstacles", "[pathfinding][threading]" )
{
    auto snapshot = open_snapshot();
    auto &target = snapshot.cells[snapshot.index( snapshot.target )];
    target.entering_cost.fill( -2 );
    // Only entry from the tile immediately below is allowed.
    target.entering_cost[2] = 2;
    const auto result = search_route_snapshot( snapshot );
    REQUIRE( result.path.size() >= 2 );
    CHECK( ( result.path.back() == snapshot.target ) );
    CHECK( ( result.path[result.path.size() - 2] == tripoint_bub_ms( 17, 15, 0 ) ) );
    CHECK( result.checked_cost[snapshot.index( snapshot.target )] & 2 );

    target.entering_cost.fill( -1 );
    CHECK( search_route_snapshot( snapshot ).path.empty() );
}

TEST_CASE( "snapshot_astar_sparse_checks_cover_exactly_the_read_cells", "[pathfinding][threading]" )
{
    auto snapshot = open_snapshot();
    SECTION( "open terrain" ) {}
    SECTION( "avoided alternative" ) {
        snapshot.cells[snapshot.index( tripoint_bub_ms( 14, 14, 0 ) )].avoid = true;
    }
    SECTION( "unreachable target" ) {
        snapshot.cells[snapshot.index( snapshot.target )].entering_cost.fill( -1 );
    }
    SECTION( "length limit" ) {
        snapshot.max_length = 3;
    }
    const auto result = search_route_snapshot( snapshot );
    std::vector<unsigned> visits( snapshot.cells.size() );
    for( const std::size_t index : result.checked_cells ) {
        REQUIRE( index < visits.size() );
        ++visits[index];
    }
    for( std::size_t index = 0; index < visits.size(); ++index ) {
        const bool checked = result.checked_avoid[index] || result.checked_cost[index] != 0;
        CHECK( visits[index] == ( checked ? 1u : 0u ) );
    }
    CHECK( result.checked_cells.size() < snapshot.cells.size() );
}
