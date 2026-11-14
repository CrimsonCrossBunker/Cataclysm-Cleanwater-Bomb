#include <initializer_list>
#include <limits>
#include <string>

#include "cata_catch.h"
#include "liquid_transfer.h"

TEST_CASE( "bulk_keg_capacity_matches_incremental_transfer", "[liquid][keg]" )
{
    // Rounded volume models include sub-millilitre charges and partial kegs.
    for( int existing : {
             0, 1, 7, 35
         } ) {
        for( int available : {
                 0, 1, 2, 8, 31, 1000
             } ) {
            for( int capacity : {
                     1, 3, 20, 100, 3000
                 } ) {
                for( int denominator : {
                         1, 3, 100
                     } ) {
                    CAPTURE( existing, available, capacity, denominator );
                    const auto full = [&]( int added ) {
                        return ( ( existing + added ) * 7 + denominator - 1 ) / denominator >= capacity;
                    };
                    int expected = 0;
                    while( expected < available && !full( expected ) ) {
                        ++expected;
                    }
                    CHECK( liquid_handler::charges_until_full( available, full ) == expected );
                }
            }
        }
    }
}

TEST_CASE( "bulk_keg_capacity_keeps_legacy_rounding", "[liquid][keg]" )
{
    // Do not change to a floor division: the old loop includes the crossing charge.
    CHECK( liquid_handler::charges_until_full( 100, []( int added ) {
        return added * 3 >= 10;
    } ) == 4 );
    CHECK( liquid_handler::charges_until_full( -1, []( int ) {
        FAIL( "Nonpositive quantities must not query volume" );
        return false;
    } ) == 0 );
}

TEST_CASE( "bulk_keg_capacity_uses_logarithmic_volume_queries", "[liquid][keg]" )
{
    int calls = 0;
    CHECK( liquid_handler::charges_until_full( std::numeric_limits<int>::max(), [&]( int added ) {
        ++calls;
        return added >= 200000;
    } ) == 200000 );
    CHECK( calls <= 33 );
    calls = 0;
    CHECK( liquid_handler::charges_until_full( 200000, [&]( int ) {
        ++calls;
        return false;
    } ) == 200000 );
    CHECK( calls == 2 );
}

BENCHMARK_TEST_CASE( "bulk_keg_capacity_benchmark", "[liquid][keg]" )
{
    // Volatile models an opaque volume query; no inventory/game-world fixture.
    volatile int capacity = 200000;
    BENCHMARK( "incremental_200000_charges" ) {
        int transferred = 0;
        while( transferred < 1000000 && transferred < capacity ) {
            ++transferred;
        }
        return transferred;
    };
    BENCHMARK( "binary_200000_charges" ) {
        return liquid_handler::charges_until_full( 1000000, [&]( int added ) {
            return added >= capacity;
        } );
    };
}
