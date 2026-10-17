#include <array>
#include <cstdint>
#include <future>
#include <stdexcept>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "rng.h"
#include "sprite_variation.h"

TEST_CASE( "sprite_seed_capture_skips_unused_live_queries", "[tiles][sprite_variation]" )
{
    CHECK( sprite_variation::capture_seed( { false, false }, []() -> unsigned int {
        throw std::runtime_error( "Unused live query must not run" );
    } ) == 0 );
    unsigned calls = 0;
    const auto resolve = [&]() {
        ++calls;
        return 42u;
    };
    CHECK( sprite_variation::capture_seed( { true, false }, resolve ) == 42 );
    CHECK( sprite_variation::capture_seed( { false, true }, resolve ) == 42 );
    CHECK( sprite_variation::capture_seed( { true, true }, resolve ) == 42 );
    CHECK( calls == 3 );
}

TEST_CASE( "sprite_seed_capture_preserves_weather_rng_even_without_choices",
           "[tiles][sprite_variation]" )
{
    restore_on_out_of_scope restore_rng( rng_get_engine() );
    rng_get_engine().seed( 20261012 );
    const auto before = rng_get_engine();
    const unsigned first = rng_bits();
    const unsigned second = rng_bits();
    const auto expected_after = rng_get_engine();
    rng_get_engine() = before;

    CHECK( sprite_variation::capture_seed( { false, false }, []() {
        return rng_bits();
    } ) == 0 );
    CHECK( rng_get_engine() == before );
    CHECK( sprite_variation::capture_seed( { false, true }, []() {
        return rng_bits();
    } ) == first );
    CHECK( sprite_variation::capture_seed( { true, false }, []() {
        return 17u;
    } ) == 17 );
    CHECK( sprite_variation::capture_seed( { true, true }, []() {
        return rng_bits();
    } ) == second );
    CHECK( rng_get_engine() == expected_after );
}

TEST_CASE( "sprite_variation_keeps_legacy_mix_and_owns_parallel_values",
           "[tiles][sprite_variation]" )
{
    const std::array<std::pair<std::uint32_t, std::uint32_t>, 8> golden = {{
            { 0u, 0u },
            { 1u, 808612721u },
            { 2u, 76603527u },
            { 42u, 2840086566u },
            { 123456789u, 1028836975u },
            { 2147483648u, 1389937790u },
            { 4294967295u, 1631742177u },
            { 4026531841u, 3008387880u }
        }
    };
    for( const auto &pair : golden ) {
        CAPTURE( pair.first );
        CHECK( sprite_variation::mix_seed( pair.first ) == pair.second );
    }
    const auto rng_before = rng_get_engine();
    std::vector<std::uint32_t> inputs;
    std::vector<std::uint32_t> expected;
    for( std::uint32_t i = 0; i < 1025; ++i ) {
        inputs.push_back( i * 7919u );
        expected.push_back( sprite_variation::mix_seed( inputs.back() ) );
    }
    auto first = std::async( std::launch::async, [owned = inputs]() {
        std::vector<std::uint32_t> output;
        for( std::uint32_t seed : owned ) {
            output.push_back( sprite_variation::mix_seed( seed ) );
        }
        return output;
    } );
    auto second = std::async( std::launch::async, [owned = inputs]() {
        std::vector<std::uint32_t> output;
        for( std::uint32_t seed : owned ) {
            output.push_back( sprite_variation::mix_seed( seed ) );
        }
        return output;
    } );
    inputs.clear();
    CHECK( first.get() == expected );
    CHECK( second.get() == expected );
    CHECK( rng_get_engine() == rng_before );
}
