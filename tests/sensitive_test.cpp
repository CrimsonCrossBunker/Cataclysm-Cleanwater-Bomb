#include <climits>
#include <string>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character.h"
#include "effect.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "skill.h"
#include "trap.h"
#include "type_id.h"

static const efftype_id effect_dulled_senses( "dulled_senses" );
static const efftype_id effect_heightened_senses( "heightened_senses" );
static const efftype_id effect_sleep( "sleep" );

static const skill_id skill_fabrication( "fabrication" );
static const skill_id skill_dodge( "dodge" );

static const trap_id tr_glass( "tr_glass" );

// The equilibrium reads live stim, painkiller, and sleep deprivation values,
// and focus recovery is capped by sleepiness; clear whatever other tests have
// left behind on the shared avatar.
static void reset_sensitivity_sources( Character &dude )
{
    dude.set_stim( 0 );
    dude.set_painkiller( 0 );
    dude.set_sleep_deprivation( 0 );
    dude.set_sleepiness( 0 );
}

TEST_CASE( "sensitive_values_are_clamped_to_their_ranges", "[sensitive][character]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    dummy.mod_sensitive( -500 );
    CHECK( dummy.get_sensitive() == 0 );

    // Extreme modifiers must be clamped, not overflow, before being applied.
    dummy.mod_sensitive( INT_MAX );
    CHECK( dummy.get_sensitive() == INT_MAX );

    dummy.mod_sensitive_mod( INT_MAX );
    CHECK( dummy.get_sensitive_mod() == 500 );

    dummy.set_sensitive_mod( 250 );
    dummy.mod_sensitive_mod( INT_MIN );
    CHECK( dummy.get_sensitive_mod() == 0 );
}

TEST_CASE( "sensitive_mod_total_reflects_its_sources", "[sensitive][character]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    reset_sensitivity_sources( dummy );
    // Neutral baseline with no active sources.
    CHECK( dummy.get_sensitive_mod_total() == 100 );

    // Stimulants raise and depressants lower the equilibrium: 25 * ln(2) = ~17.3.
    dummy.set_stim( 25 );
    CHECK( dummy.get_sensitive_mod_total() == 117 );
    dummy.set_stim( -25 );
    CHECK( dummy.get_sensitive_mod_total() == 83 );
    dummy.set_stim( 0 );

    // Painkillers saturate at -15 around 200 pkill.
    dummy.set_painkiller( 200 );
    CHECK( dummy.get_sensitive_mod_total() == 85 );

    // When stim and painkillers both dull sensitivity only half of the
    // weaker effect stacks: -15 + (-17.3 / 2).
    dummy.set_stim( -25 );
    CHECK( dummy.get_sensitive_mod_total() == 76 );
    dummy.set_stim( 0 );
    dummy.set_painkiller( 0 );

    // Sleep deprivation saturates at -10.
    dummy.set_sleep_deprivation( static_cast<int>( SLEEP_DEPRIVATION_MASSIVE ) );
    CHECK( dummy.get_sensitive_mod_total() == 90 );
    dummy.set_sleep_deprivation( 0 );
    CHECK( dummy.get_sensitive_mod_total() == 100 );
}

TEST_CASE( "sensitive_drifts_towards_its_equilibrium", "[sensitive][character]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    reset_sensitivity_sources( dummy );
    // Rising towards the equilibrium, never overshooting it.
    dummy.set_sensitive( 50 );
    for( int i = 0; i < 200 && dummy.get_sensitive() != 100; ++i ) {
        const int before = dummy.get_sensitive();
        dummy.update_sensitive();
        INFO( "step " << i << ": " << before << " -> " << dummy.get_sensitive() );
        REQUIRE( dummy.get_sensitive() > before );
        REQUIRE( dummy.get_sensitive() <= 100 );
    }
    REQUIRE( dummy.get_sensitive() == 100 );

    // Falling towards a lower equilibrium.
    dummy.set_sensitive_mod( 40 );
    for( int i = 0; i < 200 && dummy.get_sensitive() != 40; ++i ) {
        const int before = dummy.get_sensitive();
        dummy.update_sensitive();
        INFO( "step " << i << ": " << before << " -> " << dummy.get_sensitive() );
        REQUIRE( dummy.get_sensitive() < before );
        REQUIRE( dummy.get_sensitive() >= 40 );
    }
    REQUIRE( dummy.get_sensitive() == 40 );

    // No oscillation once the equilibrium is reached.
    dummy.update_sensitive();
    CHECK( dummy.get_sensitive() == 40 );
}

TEST_CASE( "threshold_perception_effects_track_sensitivity", "[sensitive][character][effect]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    dummy.update_sensitive_per_effects();
    CHECK_FALSE( dummy.has_effect( effect_dulled_senses ) );
    CHECK_FALSE( dummy.has_effect( effect_heightened_senses ) );

    // Mild numbness grants one tier of dulled senses.
    dummy.set_sensitive( 60 );
    dummy.update_sensitive_per_effects();
    REQUIRE( dummy.has_effect( effect_dulled_senses ) );
    CHECK( dummy.get_effect_int( effect_dulled_senses ) == 1 );
    CHECK_FALSE( dummy.has_effect( effect_heightened_senses ) );

    // Deepening numbness escalates to the second tier.
    dummy.set_sensitive( 30 );
    dummy.update_sensitive_per_effects();
    REQUIRE( dummy.has_effect( effect_dulled_senses ) );
    CHECK( dummy.get_effect_int( effect_dulled_senses ) == 2 );

    // Sharpening swaps dulled for heightened senses tier by tier.
    dummy.set_sensitive( 300 );
    dummy.update_sensitive_per_effects();
    CHECK_FALSE( dummy.has_effect( effect_dulled_senses ) );
    REQUIRE( dummy.has_effect( effect_heightened_senses ) );
    CHECK( dummy.get_effect_int( effect_heightened_senses ) == 1 );

    dummy.set_sensitive( 450 );
    dummy.update_sensitive_per_effects();
    CHECK( dummy.get_effect_int( effect_heightened_senses ) == 2 );

    // Returning to the neutral band clears both effects.
    dummy.set_sensitive( 100 );
    dummy.update_sensitive_per_effects();
    CHECK_FALSE( dummy.has_effect( effect_dulled_senses ) );
    CHECK_FALSE( dummy.has_effect( effect_heightened_senses ) );
}

TEST_CASE( "gained_pain_scales_with_sensitivity", "[sensitive][character][pain]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    // Exact anchors of the multiplier curve.
    dummy.set_sensitive( 0 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 0.25 ) );
    dummy.set_sensitive( 50 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 0.75 ) );
    dummy.set_sensitive( 80 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 0.95 ) );
    dummy.set_sensitive( 95 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 1.0 ) );
    dummy.set_sensitive( 120 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 1.0 ) );
    dummy.set_sensitive( 200 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 1.5 ) );
    dummy.set_sensitive( 500 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 2.5 ).epsilon( 0.0001 ) );
    dummy.set_sensitive( 1000 );
    CHECK( dummy.sensitive_pain_multiplier() == Approx( 2.5 ).epsilon( 0.0001 ) );

    // Numb characters gain proportionally less pain from the same source.
    dummy.set_sensitive( 100 );
    dummy.set_pain( 0 );
    const int neutral_gain = dummy.mod_pain( 20, body_part_torso );
    dummy.set_pain( 0 );
    dummy.set_sensitive( 50 );
    const int numb_gain = dummy.mod_pain( 20, body_part_torso );
    INFO( "neutral gain: " << neutral_gain << ", numb gain: " << numb_gain );
    CHECK( numb_gain > 0 );
    CHECK( numb_gain * 4 == Approx( neutral_gain * 3 ).epsilon( 0.01 ) );
}

TEST_CASE( "sensitivity_shifts_pain_wake_threshold", "[sensitive][character][sleep][pain]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    auto lay_asleep = [&dummy]() {
        dummy.remove_effect( effect_sleep );
        dummy.add_effect( effect_sleep, 1_hours );
        REQUIRE( dummy.get_effect( effect_sleep ).get_duration() > 0_turns );
    };

    // Extremely numb characters sleep through small pain bursts. The shifted
    // threshold (rng(3..5) plus at least 4) stays above an intensity of 1.
    dummy.set_sensitive( 0 );
    lay_asleep();
    dummy.react_to_felt_pain( 1 );
    CHECK( dummy.get_effect( effect_sleep ).get_duration() > 0_turns );

    // Extremely sensitive characters wake from any pain burst: even the base
    // threshold minus its maximum shift cannot exceed an intensity of 1.
    dummy.set_sensitive( 300 );
    lay_asleep();
    dummy.react_to_felt_pain( 1 );
    CHECK( dummy.get_effect( effect_sleep ).get_duration() == 0_turns );

    // Neutral characters still wake from a large pain burst.
    dummy.set_sensitive( 100 );
    lay_asleep();
    dummy.react_to_felt_pain( 9 );
    CHECK( dummy.get_effect( effect_sleep ).get_duration() == 0_turns );
}

TEST_CASE( "trap_avoidance_shifts_with_sensitivity", "[sensitive][character][trap]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    dummy.set_dex_base( 8 );
    dummy.set_skill_level( skill_dodge, 8 );

    const trap &glass = *tr_glass;
    const tripoint_bub_ms pos( HALF_MAPSIZE_X, HALF_MAPSIZE_Y, 0 );

    constexpr int iters = 20000;
    auto avoided_count = [&dummy, &glass, &pos]() {
        int avoided = 0;
        for( int i = 0; i < iters; ++i ) {
            if( dummy.avoid_trap( pos, glass ) ) {
                ++avoided;
            }
        }
        return avoided;
    };

    // Both roll sequences are random, but with 20k samples the expected shift
    // of roughly +10% avoidance dwarfs the sampling noise (~0.35%).
    dummy.set_sensitive( 0 );
    const int numb = avoided_count();
    dummy.set_sensitive( 400 );
    const int sharp = avoided_count();

    INFO( "numb avoided " << numb << "/" << iters << ", sharp avoided " << sharp <<
          "/" << iters );
    CHECK( sharp > numb );
    CHECK( sharp - numb > iters / 25 );
}

TEST_CASE( "focus_recovery_scales_with_sensitivity", "[sensitive][character][focus]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    reset_sensitivity_sources( dummy );
    // With neutral morale the focus equilibrium is 100. Starting from focus 1
    // leaves a change of 99 points per tick, which survives the pool/1000
    // rounding when read back through get_focus().
    dummy.set_sensitive( 100 );
    dummy.set_focus( 1 );
    dummy.update_mental_focus();
    CHECK( dummy.get_focus() == 10 );

    // Fully numb characters recover at most 75% as fast: 99 * 0.75 = 74.
    dummy.set_sensitive( 0 );
    dummy.set_focus( 1 );
    dummy.update_mental_focus();
    CHECK( dummy.get_focus() == 1 );

    // Highly sensitive characters recover up to 25% faster: 99 * 1.25 = 123.
    dummy.set_sensitive( 500 );
    dummy.set_focus( 1 );
    dummy.update_mental_focus();
    CHECK( dummy.get_focus() == 2 );
}

TEST_CASE( "focus_drain_while_practicing_scales_with_sensitivity",
           "[sensitive][character][focus]" )
{
    avatar &dummy = get_avatar();
    clear_character( dummy );
    dummy.set_skill_level( skill_fabrication, 0 );

    // Large pools keep the drain on its linear branch (>= 1000), so the
    // resulting focus values are exact integers.
    auto drain_to = [&]( int sens ) {
        dummy.set_sensitive( sens );
        dummy.set_focus( 200 ); // pool = 200000, base drain = max(2000, 1000)
        dummy.practice( skill_fabrication, 1000 );
        return dummy.get_focus();
    };

    CHECK( drain_to( 50 ) == 198 );
    // One point below 50 speeds burnout by exactly 1%: 2000 * 1.25 = 2500.
    CHECK( drain_to( 25 ) == 197 );
    CHECK( drain_to( 0 ) == 197 );
    // Every 10 points above 200 slow it by 1%, capped at -50%: 1000 drained.
    CHECK( drain_to( 700 ) == 199 );
}
