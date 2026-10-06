#include <chrono>
#include <stddef.h>
#include <units.h>
#include <initializer_list>
#include <random>
#include <optional>
#include <string>

#include "cata_catch.h"
#include "melee_sound_queue.h"
#include "rng.h"

using sound_clock = sfx::melee_sound_queue::clock;
using milliseconds = std::chrono::milliseconds;

static sfx::melee_sound_sequence sequence( int volume, bool monster )
{
    sfx::melee_sound_sequence result;
    result.swing = { "melee_swing", "big_bash", "winter", true, true, 75, 90_degrees };
    result.hit = sfx::queued_sound{ "melee_hit_metal", "big_bash", "winter", true, true, 65,
                                    180_degrees };
    result.weapon_volume = volume;
    result.target_monster = monster;
    return result;
}

TEST_CASE( "melee_sound_timing_is_nonblocking_and_preserves_swing_hit_delay",
           "[melee_sound_queue]" )
{
    const sound_clock::time_point now{};
    for( const bool monster : {
             false, true
         } ) {
        sfx::melee_sound_queue queue;
        REQUIRE( queue.enqueue( sequence( 10, monster ), now ) );
        CHECK_FALSE( queue.pop_due( now ) );
        const std::optional<sfx::queued_sound> swing = queue.pop_due( now + milliseconds( 2 ) );
        REQUIRE( swing );
        CHECK( swing->id == "melee_swing" );
        CHECK_FALSE( queue.pop_due( now + milliseconds( monster ? 120 : 90 ) ) );
        const std::optional<sfx::queued_sound> hit = queue.pop_due( now + milliseconds( 162 ) );
        REQUIRE( hit );
        CHECK( hit->id == "melee_hit_metal" );
        CHECK( queue.empty() );
    }
}

TEST_CASE( "melee_sound_zero_volume_preserves_swing_before_hit_and_misses_have_no_hit",
           "[melee_sound_queue]" )
{
    const sound_clock::time_point now{};
    sfx::melee_sound_queue queue;
    REQUIRE( queue.enqueue( sequence( 0, false ), now ) );
    REQUIRE( queue.size() == 2 );
    const std::optional<sfx::queued_sound> swing = queue.pop_due( now + milliseconds( 2 ) );
    const std::optional<sfx::queued_sound> hit = queue.pop_due( now + milliseconds( 2 ) );
    REQUIRE( swing );
    REQUIRE( hit );
    CHECK( swing->id == "melee_swing" );
    CHECK( hit->id == "melee_hit_metal" );
    sfx::melee_sound_sequence miss = sequence( 10, true );
    miss.hit.reset();
    REQUIRE( queue.enqueue( miss, now ) );
    CHECK( queue.size() == 1 );
    REQUIRE( queue.pop_due( now + milliseconds( 2 ) ) );
    CHECK( queue.empty() );
}

TEST_CASE( "melee_sound_requests_own_context_and_are_ordered_by_due_time",
           "[melee_sound_queue]" )
{
    const sound_clock::time_point now{};
    sfx::melee_sound_queue queue;
    sfx::melee_sound_sequence original = sequence( 100, true );
    REQUIRE( queue.enqueue( original, now ) );
    original.swing.variant = "changed weapon";
    original.swing.season = "summer";
    original.hit->id = "changed target";
    original.hit->volume = 0;
    const std::optional<sfx::queued_sound> swing = queue.pop_due( now + milliseconds( 2 ) );
    REQUIRE( swing );
    CHECK( swing->variant == "big_bash" );
    CHECK( swing->season == "winter" );
    CHECK( swing->indoors );
    CHECK( swing->night );
    CHECK( swing->volume == 75 );
    CHECK( swing->angle == 90_degrees );

    REQUIRE( queue.enqueue( sequence( 0, false ), now + milliseconds( 10 ) ) );
    const std::optional<sfx::queued_sound> newer_swing = queue.pop_due( now + milliseconds( 12 ) );
    REQUIRE( newer_swing );
    CHECK( newer_swing->id == "melee_swing" );
    REQUIRE( queue.pop_due( now + milliseconds( 12 ) ) );
    const std::optional<sfx::queued_sound> old_hit = queue.pop_due( now + milliseconds( 1602 ) );
    REQUIRE( old_hit );
    CHECK( old_hit->id == "melee_hit_metal" );
    CHECK( old_hit->volume == 65 );
    CHECK( old_hit->angle == 180_degrees );
    CHECK( queue.empty() );
}

TEST_CASE( "melee_sound_overload_rejects_whole_sequence_and_clear_discards_old_world",
           "[melee_sound_queue]" )
{
    const sound_clock::time_point now{};
    sfx::melee_sound_queue queue;
    sfx::melee_sound_sequence miss = sequence( 100, true );
    miss.hit.reset();
    for( size_t i = 0; i < sfx::melee_sound_queue::capacity - 1; ++i ) {
        REQUIRE( queue.enqueue( miss, now ) );
    }
    CHECK_FALSE( queue.enqueue( sequence( 100, true ), now ) );
    CHECK( queue.size() == sfx::melee_sound_queue::capacity - 1 );
    REQUIRE( queue.enqueue( miss, now ) );
    CHECK_FALSE( queue.enqueue( miss, now ) );
    CHECK( queue.size() == sfx::melee_sound_queue::capacity );
    queue.clear();
    CHECK( queue.empty() );
    CHECK_FALSE( queue.pop_due( now + milliseconds( 10000 ) ) );
    REQUIRE( queue.enqueue( sequence( 0, true ), now ) );
    CHECK( queue.size() == 2 );
}

TEST_CASE( "melee_sound_schedule_is_independent_of_simulation_rng_and_pump_cadence",
           "[melee_sound_queue][rng]" )
{
    const sound_clock::time_point now{};
    const cata_default_random_engine gameplay_before = rng_get_engine();
    sfx::melee_sound_queue eager;
    sfx::melee_sound_queue delayed;
    for( int i = 0; i < 100; ++i ) {
        const sound_clock::time_point action_time = now + milliseconds( 1000 * i );
        REQUIRE( eager.enqueue( sequence( 1, true ), action_time ) );
        REQUIRE( delayed.enqueue( sequence( 1, true ), action_time ) );
        const std::optional<sfx::queued_sound> first = eager.pop_due( action_time + milliseconds( 2 ) );
        const std::optional<sfx::queued_sound> second = eager.pop_due( action_time + milliseconds( 20 ) );
        REQUIRE( first );
        REQUIRE( second );
        const std::optional<sfx::queued_sound> late_first = delayed.pop_due( action_time + milliseconds(
                    100 ) );
        const std::optional<sfx::queued_sound> late_second = delayed.pop_due( action_time + milliseconds(
                    100 ) );
        REQUIRE( late_first );
        REQUIRE( late_second );
        CHECK( first->id == late_first->id );
        CHECK( first->random_seed == late_first->random_seed );
        CHECK( second->id == late_second->id );
        CHECK( second->random_seed == late_second->random_seed );
    }
    CHECK( rng_get_engine() == gameplay_before );
}

#if defined(SDL_SOUND)
#include <thread>

#include "avatar.h"
#include "cached_options.h"
#include "cata_scope_helpers.h"
#include "item.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "sdlsound.h"
#include "sounds.h"

TEST_CASE( "melee_sound_generation_and_variant_playback_leave_simulation_rng_untouched",
           "[melee_sound_queue][sound_backend][integration]" )
{
    clear_map();
    clear_avatar();
    restore_on_out_of_scope<bool> restore_test( test_mode );
    restore_on_out_of_scope<bool> restore_enabled( sounds::sound_enabled );
    restore_on_out_of_scope<bool> restore_init( sound_init_success );
    REQUIRE( init_sound() );
    const sfx::sound_effect_key swing{ "melee_swing", "unarmed", "", {}, {} };
    const sfx::sound_effect_key hit{ "melee_hit_flesh", "unarmed", "", {}, {} };
    // Missing files use the backend's valid silent fallback, exercising selection
    // and pitch without depending on an installed soundpack or audible output.
    sfx::register_sound_effect( swing, 100, { "queue-test-one.wav", "queue-test-two.wav" } );
    sfx::register_sound_effect( hit, 100, { "queue-test-one.wav", "queue-test-two.wav" } );
    on_out_of_scope cleanup( [&swing, &hit]() {
        sfx::clear_melee_sounds();
        sfx::erase_sound_effect( swing );
        sfx::erase_sound_effect( hit );
        shutdown_sound();
    } );
    sounds::sound_enabled = true;
    test_mode = false;
    // Constructing even a null item picks a variant using the gameplay RNG.
    const item weapon;
    const tripoint_bub_ms pos = get_avatar().pos_bub();
    const cata_default_random_engine gameplay_before = rng_get_engine();
    sfx::generate_melee_sound( weapon, pos, pos, true );
    CHECK( rng_get_engine() == gameplay_before );
    // Both unarmed events are due within 2ms; no timing equality is asserted.
    std::this_thread::sleep_for( milliseconds( 20 ) );
    sfx::process_melee_sounds();
    CHECK( rng_get_engine() == gameplay_before );
}
#endif // SDL_SOUND
