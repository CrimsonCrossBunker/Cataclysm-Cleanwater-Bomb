#include <array>
#include <cstddef>
#include <future>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "rng.h"
#include "tile_preparation.h"

namespace
{
tile_preparation::input fixture_input( std::size_t i )
{
    tile_preparation::input v;
    v.sprite = i % 11 != 0;
    v.invisible = i % 7 == 0;
    v.graffiti = i % 3 == 0;
    v.graffiti_override = i % 17 == 0;
    v.trap = i % 5 == 0;
    v.trap_override_active = i % 19 == 0;
    v.construction = i % 13 == 0;
    v.field = i % 23 == 0;
    v.visible_items = i % 2 == 0;
    v.field_override = i % 29 == 0;
    v.item_override = i % 31 == 0;
    v.vehicle = i % 37 == 0;
    v.vehicle_override = i % 41 == 0;
    v.creature = i % 43 == 0;
    v.shadow = i % 47 == 0;
    v.creature_override = i % 53 == 0;
    v.tint_eligible = i % 3 != 0;
    v.light = {{ 0.2f + static_cast<float>( i % 8 ), 0.4f, 0.1f }};
    v.scalar_light = 0.1f + static_cast<float>( i % 16 );
    return v;
}

void fill_frame( tile_preparation::frame &frame, std::size_t size )
{
    auto &input = frame.capture();
    input.reserve( size );
    for( std::size_t i = 0; i < size; ++i ) {
        input.push_back( fixture_input( i ) );
    }
}
} // namespace

TEST_CASE( "tile_preparation_preserves_memory_overrides_and_revival",
           "[tiles][preparation]" )
{
    using namespace tile_preparation;
    input v;
    v.sprite = true;
    CHECK( prepare( v ).layers == 0 );
    v.invisible = true;
    CHECK( prepare( v ).layers == layer_trap );
    v.visible_items = true;
    CHECK( prepare( v ).layers == ( layer_trap | layer_field_item ) );
    v.invisible = false;
    CHECK( prepare( v ).layers == ( layer_field_item | layer_revival ) );
    v.item_override = true;
    CHECK( prepare( v ).layers == layer_field_item );
    v.visible_items = false;
    v.graffiti_override = true;
    v.trap_override_active = true;
    v.construction = true;
    v.vehicle_override = true;
    v.shadow = true;
    CHECK( prepare( v ).layers == ( layer_graffiti | layer_trap | layer_part_con |
                                    layer_field_item | layer_vpart | layer_critter ) );
    v.sprite = false;
    CHECK( prepare( v ).layers == 0 );
}

TEST_CASE( "tile_preparation_preserves_light_tint_thresholds", "[tiles][preparation]" )
{
    tile_preparation::input v;
    v.sprite = true;
    v.tint_eligible = true;
    v.light = {{ 2.0f, 1.0f, 1.0f }};
    v.scalar_light = 1.0f;
    const std::array<std::uint8_t, 4> red = {{ 255, 0, 0, 80 }};
    const std::array<std::uint8_t, 4> empty = {};
    CHECK( tile_preparation::prepare( v ).tint == red );
    v.scalar_light = 2.0f;
    CHECK( tile_preparation::prepare( v ).tint[3] == 40 );
    v.scalar_light = 0.1f;
    CHECK( tile_preparation::prepare( v ).tint == empty );
    v.scalar_light = 1000.0f;
    CHECK( tile_preparation::prepare( v ).tint == empty );
    v.scalar_light = 1.0f;
    v.light = {{ 1.0f, 1.0f, 1.0f }};
    CHECK( tile_preparation::prepare( v ).tint == empty );
    v.light = {{ 0.009f, 0.0f, 0.0f }};
    CHECK( tile_preparation::prepare( v ).tint == empty );
    v.light = {{ 2.0f, 1.0f, 1.0f }};
    v.tint_eligible = false;
    CHECK( tile_preparation::prepare( v ).tint == empty );
}

TEST_CASE( "tile_preparation_workers_match_serial_in_original_order",
           "[tiles][preparation]" )
{
    tile_preparation::frame serial( 0 );
    const auto rng_before = rng_get_engine();
    for( unsigned workers : {
             1u, 2u, 4u
         } ) {
        tile_preparation::frame parallel( workers );
        REQUIRE( parallel.worker_count() == workers );
        for( std::size_t size : {
                 0u, 1u, 63u, 4095u, 16383u, 16384u, 16385u, 32803u
             } ) {
            CAPTURE( workers, size );
            fill_frame( serial, size );
            fill_frame( parallel, size );
            serial.prepare();
            parallel.prepare();
            REQUIRE( serial.results().size() == size );
            REQUIRE( parallel.results().size() == size );
            CHECK_FALSE( serial.can_parallelize( size ) );
            CHECK( parallel.can_parallelize( size ) == ( size >= 16384 ) );
            CHECK_FALSE( serial.used_workers() );
            CHECK( parallel.used_workers() == ( size >= 16384 ) );
            for( std::size_t i = 0; i < size; ++i ) {
                REQUIRE( parallel.results()[i].layers == serial.results()[i].layers );
                REQUIRE( parallel.results()[i].tint == serial.results()[i].tint );
            }
        }
    }
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "tile_preparation_frame_owns_results_and_drains_on_teardown",
           "[tiles][preparation]" )
{
    const auto run = []() {
        tile_preparation::frame frame( 2 );
        bool stable = true;
        for( unsigned iteration = 0; iteration < 8; ++iteration ) {
            fill_frame( frame, 32803 );
            frame.prepare();
            const auto copied = frame.results();
            frame.capture().push_back( tile_preparation::input{} );
            stable = stable && frame.results().size() == copied.size() &&
                     frame.results().back().layers == copied.back().layers;
        }
        return std::make_pair( frame.results().size(), stable );
    };
    auto first = std::async( std::launch::async, run );
    auto second = std::async( std::launch::async, run );
    const auto first_result = first.get();
    const auto second_result = second.get();
    CHECK( first_result.first == 32803 );
    CHECK( second_result.first == 32803 );
    CHECK( first_result.second );
    CHECK( second_result.second );
    tile_preparation::frame bounded( 64 );
    CHECK( bounded.worker_count() == 4 );
}

TEST_CASE( "tile_preparation_lease_preserves_parent_and_releases_after_exception",
           "[tiles][preparation]" )
{
    tile_preparation::frame frame( 2 );
    CHECK_FALSE( frame.try_acquire( 4095 ) );
    try {
        auto outer = frame.try_acquire( 16384 );
        REQUIRE( outer );
        auto moved = std::move( outer );
        CHECK_FALSE( outer );
        REQUIRE( moved );
        fill_frame( frame, 16384 );
        frame.prepare();
        const auto *parent_data = frame.results().data();
        const auto parent = frame.results()[8192];
        auto nested = frame.try_acquire( 32803 );
        CHECK_FALSE( nested );
        // The renderer uses the direct kernel when the parent holds the lease.
        const auto direct = tile_preparation::prepare( fixture_input( 7 ) );
        CHECK( direct.layers != 0 );
        CHECK( frame.results().data() == parent_data );
        CHECK( frame.results()[8192].layers == parent.layers );
        CHECK( frame.results()[8192].tint == parent.tint );
        throw 1;
    } catch( int ) {
        // Both successful and exceptional owner exits release the buffer.
    }
    auto next = frame.try_acquire( 16384 );
    REQUIRE( next );
}

TEST_CASE( "tile_preparation_fixed_frame_benchmark", "[benchmark][tiles][preparation]" )
{
    tile_preparation::frame serial( 0 );
    tile_preparation::frame parallel( 2 );
    fill_frame( serial, 16384 );
    fill_frame( parallel, 16384 );
    BENCHMARK( "16384 mixed tiles, serial value preparation" ) {
        serial.prepare();
        return serial.results()[8192].layers;
    };
    BENCHMARK( "16384 mixed tiles, two worker value preparation" ) {
        parallel.prepare();
        return parallel.results()[8192].layers;
    };
}
