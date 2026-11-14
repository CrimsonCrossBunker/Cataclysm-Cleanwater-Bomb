#include <chrono>

#include "cata_catch.h"
#include "sound_effect_queue.h"

TEST_CASE( "gunshot_sounds_use_each_burst_start_and_rpm", "[gunshot_sound]" )
{
    using namespace std::chrono_literals;
    sfx::sound_effect_queue queue;
    const sfx::sound_effect_queue::clock::time_point start{};
    const sfx::queued_sound slow{ "fire_gun", "slow", "" };
    const sfx::queued_sound fast{ "fire_gun", "fast", "" };

    REQUIRE( queue.enqueue_gunshot( slow, start, 750, 0 ) );
    REQUIRE( queue.enqueue_gunshot( slow, start, 750, 1 ) );
    const auto other_start = start + 10ms;
    REQUIRE( queue.enqueue_gunshot( fast, other_start, 900, 0 ) );
    REQUIRE( queue.enqueue_gunshot( fast, other_start, 900, 1 ) );
    REQUIRE( queue.enqueue_gunshot( fast, other_start, 900, 2 ) );
    REQUIRE( queue.enqueue_gunshot( fast, other_start, 900, 3 ) );

    const auto check_next = [&]( auto due, const char *variant ) {
        CHECK_FALSE( queue.pop_due( due - 1us ) );
        CHECK( queue.wait_ms( due - 1us ) == 1u );
        CHECK( queue.wait_ms( due ) == 0u );
        const auto shot = queue.pop_due( due );
        REQUIRE( shot );
        CHECK( shot->variant == variant );
    };

    check_next( start, "slow" );
    check_next( other_start, "fast" );
    check_next( other_start + 66666us, "fast" );
    check_next( start + 80ms, "slow" );
    check_next( other_start + 133333us, "fast" );
    check_next( other_start + 200ms, "fast" );
    CHECK_FALSE( queue.wait_ms( start + 1s ) );
    CHECK_FALSE( queue.pop_due( start + 1s ) );
}
