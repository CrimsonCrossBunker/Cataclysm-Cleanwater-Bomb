#include <memory>
#include <sstream>
#include <string>
#include <utility>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "damage.h"
#include "effect_on_condition.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "magic.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_helpers.h"
#include "messages.h"
#include "npc.h"
#include "npctalk.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "rng.h"
#include "talker.h"
#include "type_id.h"
#include "weather.h"
#include "wound.h"

static const bodypart_str_id body_part_test_alt_arm_l( "test_alt_arm_l" );
static const bodypart_str_id body_part_torso_slime( "torso_slime" );
static const damage_type_id damage_heat( "heat" );
static const efftype_id effect_bleed( "bleed" );
static const effect_on_condition_id effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL(
    "EOC_XEDRA_DAMAGE_REVERSAL" );
static const effect_on_condition_id effect_on_condition_EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE(
    "EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE" );
static const efftype_id effect_onfire( "onfire" );
static const efftype_id effect_lucid_dream( "effect_lucid_dream" );
static const efftype_id effect_xedra_chronomancer_stable_timeloop(
    "effect_xedra_chronomancer_stable_timeloop" );
static const efftype_id effect_xedra_time_loop( "effect_xedra_time_loop" );
static const efftype_id effect_xedra_time_freeze( "effect_xedra_time_freeze" );
static const enchantment_id enchantment_ENCH_TEST_ALT_ARMS( "ENCH_TEST_ALT_ARMS" );
static const spell_id spell_xedra_chronomancer_revert_wound( "xedra_chronomancer_revert_wound" );
static const trait_id trait_XEDRA_CHRONOMANCER_LOOPING_WOUND( "XEDRA_CHRONOMANCER_LOOPING_WOUND" );
static const wound_type_id wound_thermal_blister( "thermal_blister" );
static const wound_type_id wound_thermal_burn( "thermal_burn" );

static void set_legacy_last_damage( Character &who )
{
    who.set_value( "xedra_last_damage_taken", diag_value( 10 ) );
    who.set_value( "xedra_last_pain_taken", diag_value( 30 ) );
    who.set_value( "xedra_last_damage_taken_bodypart", diag_value( body_part_torso.str() ) );
}

static dealt_damage_instance deal_one_heat_hit( Character &who, const bodypart_id &part, int heat )
{
    // A deferred fire can be extended by an ignition roll without dealing a second hit.
    who.add_effect( effect_onfire, 1_turns, part, false, 1, false, true );
    const dealt_damage_instance dealt = who.deal_damage( nullptr, part,
                                        damage_instance( damage_heat, heat ) );
    who.remove_effect( effect_onfire );
    return dealt;
}

class thermal_exposure_npc : public standard_npc
{
    public:
        using standard_npc::standard_npc;
        using Character::update_thermal_exposure;
};

static void earn_environmental_burn( thermal_exposure_npc &who, bool severe )
{
    who.set_all_parts_temp_cur( BODYTEMP_NORM );
    who.set_part_temp_cur( body_part_hand_l, BODYTEMP_SCORCHING +
                           ( severe ? 6_C_delta : 2_C_delta ) );
    const int turns = to_turns<int>( severe ? 1_minutes : 30_seconds );
    for( int i = 0; i < turns; ++i ) {
        calendar::turn += 1_turns;
        who.update_thermal_exposure();
    }
}

TEST_CASE( "xedra_time_loop_rewinds_heat_damage_without_retaining_new_burns",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_time_loop.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_queue( std::move( u.queued_effect_on_conditions ) );
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    const override_option always_wound( "WOUND_CHANCE", "1" );

    u.apply_thermal_burn( body_part_arm_l, false );
    u.update_wounds( 2_minutes );
    const bodypart &injured_arm = *u.get_part( body_part_arm_l );
    const bodypart &other_arm = *u.get_part( body_part_arm_r );
    REQUIRE( injured_arm.has_wound( wound_thermal_blister ) );
    u.set_part_hp_cur( body_part_arm_l, injured_arm.get_hp_cur() - 10 );
    const int hp_left = injured_arm.get_hp_cur();
    const int hp_right = other_arm.get_hp_cur();
    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    u.set_pain( 7 );
    u.set_thirst( 15 );
    const int original_total_pain = u.get_pain();
    REQUIRE( original_total_pain > 7 );

    u.add_effect( effect_xedra_time_loop, 20_seconds );
    REQUIRE( u.has_effect( effect_xedra_time_loop ) );
    for( int rewind = 0; rewind < 2; ++rewind ) {
        CAPTURE( rewind );
        const dealt_damage_instance left = deal_one_heat_hit( u, body_part_hand_l, 15 );
        const dealt_damage_instance right = deal_one_heat_hit( u, body_part_hand_r, 15 );
        REQUIRE( left.type_damage( damage_heat ) == 15 );
        REQUIRE( right.type_damage( damage_heat ) == 15 );
        CHECK( injured_arm.get_hp_cur() == hp_left - 15 );
        CHECK( other_arm.get_hp_cur() == hp_right - 15 );
        CHECK( u.get_part_temp_cur( body_part_hand_r ) == BODYTEMP_NORM );
        u.set_pain( 21 );
        u.set_thirst( 40 );

        for( int turn = 0; turn < 5; ++turn ) {
            calendar::turn += 1_turns;
            u.process_turn();
        }
        effect_on_conditions::process_effect_on_conditions( u );

        CHECK( injured_arm.get_hp_cur() == hp_left );
        CHECK( other_arm.get_hp_cur() == hp_right );
        CHECK( u.Creature::get_pain() == 7 );
        CHECK( u.get_pain() == original_total_pain );
        CHECK( u.get_thirst() == 15 );
        CHECK_FALSE( other_arm.has_wounds() );
        REQUIRE( injured_arm.get_wounds().size() == 1 );
        CHECK( injured_arm.has_wound( wound_thermal_blister ) );
        CHECK( injured_arm.get_wounds().front().get_healing_progress() == 2_minutes );
    }

    u.set_pain( 25 );
    REQUIRE( u.remove_effect( effect_xedra_time_loop ) );
    CHECK( u.Creature::get_pain() == 7 );
    calendar::turn += 1_turns;
    u.process_turn();
    REQUIRE( injured_arm.has_wound( wound_thermal_blister ) );
    CHECK( injured_arm.get_wounds().front().get_healing_progress() == 2_minutes + 1_turns );
    u.apply_thermal_burn( body_part_arm_r, true );
    CHECK( other_arm.has_wound( wound_thermal_burn ) );

    calendar::turn += 1_turns;
    u.add_effect( effect_xedra_time_loop, 20_seconds );
    REQUIRE( u.has_effect( effect_xedra_time_loop ) );
    u.set_pain( 25 );
    calendar::turn += 3_turns;
    effect_on_conditions::process_effect_on_conditions( u );
    CHECK( u.Creature::get_pain() == 25 ); // Pending tick from the previous loop.
    calendar::turn += 2_turns;
    effect_on_conditions::process_effect_on_conditions( u );
    CHECK( u.Creature::get_pain() == 7 );
    REQUIRE( u.remove_effect( effect_xedra_time_loop ) );
}

TEST_CASE( "xedra_overlapping_time_loops_restore_separate_latest_hits",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_time_loop.is_valid() );
    REQUIRE( effect_xedra_chronomancer_stable_timeloop.is_valid() );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_queue( std::move( u.queued_effect_on_conditions ) );
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const bodypart &left = *u.get_part( body_part_arm_l );
    const bodypart &right = *u.get_part( body_part_arm_r );
    const int left_hp = left.get_hp_cur();
    const int right_hp = right.get_hp_cur();

    REQUIRE( u.apply_thermal_burn( body_part_hand_l, false ) );
    u.update_wounds( 2_minutes );
    REQUIRE( deal_one_heat_hit( u, body_part_hand_l, 15 ).type_damage( damage_heat ) == 15 );
    u.add_effect( effect_xedra_chronomancer_stable_timeloop, 1_hours );
    REQUIRE( u.has_effect( effect_xedra_chronomancer_stable_timeloop ) );

    REQUIRE( deal_one_heat_hit( u, body_part_hand_r, 8 ).type_damage( damage_heat ) == 8 );
    u.add_effect( effect_xedra_time_loop, 20_seconds );
    REQUIRE( u.has_effect( effect_xedra_time_loop ) );
    REQUIRE( u.remove_effect( effect_xedra_chronomancer_stable_timeloop ) );
    CHECK_FALSE( right.has_wounds() );
    CHECK( right.get_hp_cur() == right_hp );

    dialogue d( get_talker_for( u ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    REQUIRE( left.has_wound( wound_thermal_blister ) );
    CHECK( left.get_wounds().front().get_healing_progress() == 2_minutes );
    CHECK( left.get_hp_cur() == left_hp );

    calendar::turn += 5_seconds;
    effect_on_conditions::process_effect_on_conditions( u );
    REQUIRE( u.maybe_get_value( "thermal_snapshot:xedra_time_loop" ) );
    CHECK( left.has_wound( wound_thermal_burn ) );
    CHECK( left.get_hp_cur() == left_hp - 15 );
    CHECK( right.has_wound( wound_thermal_blister ) );
    CHECK( right.get_hp_cur() == right_hp - 8 );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( left.has_wound( wound_thermal_burn ) );
    CHECK( left.get_hp_cur() == left_hp - 15 );
    CHECK_FALSE( right.has_wounds() );
    CHECK( right.get_hp_cur() == right_hp );

    REQUIRE( u.remove_effect( effect_xedra_time_loop ) );
    CHECK_FALSE( u.maybe_get_value( "thermal_snapshot:xedra_time_loop" ) );
    CHECK_FALSE( u.maybe_get_value( "thermal_snapshot:xedra_stable_timeloop" ) );
    CHECK( right.has_wound( wound_thermal_blister ) );
    CHECK( right.get_hp_cur() == right_hp - 8 );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK_FALSE( right.has_wounds() );
    CHECK( right.get_hp_cur() == right_hp );
}

TEST_CASE( "xedra_time_loop_does_not_heal_rewound_damage_again",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_time_loop.is_valid() );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_queue( std::move( u.queued_effect_on_conditions ) );
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    u.forget_recent_damage();
    const bodypart &torso = *u.get_part( body_part_torso );
    const bodypart &arm = *u.get_part( body_part_arm_l );
    const int hp = torso.get_hp_cur() - 20;
    u.set_part_hp_cur( body_part_torso, hp );
    u.set_pain( 7 );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, false ) );

    u.add_effect( effect_xedra_time_loop, 20_seconds );
    REQUIRE( u.has_effect( effect_xedra_time_loop ) );
    const bool old_save = GENERATE( false, true );
    if( old_save ) {
        u.remove_value( "thermal_snapshot:xedra_time_loop" );
        u.remove_value( "xedra_time_loop_next_rewind" );
    }
    u.get_part( body_part_arm_l )->update_wounds( 1_minutes );
    u.set_part_hp_cur( body_part_torso, hp - 10 );
    u.set_pain( 37 );
    u.record_scripted_damage( body_part_torso, 10, 30 );
    set_legacy_last_damage( u );

    calendar::turn += 5_seconds;
    effect_on_conditions::process_effect_on_conditions( u );
    CHECK( torso.get_hp_cur() == hp );
    CHECK( u.Creature::get_pain() == 7 );
    REQUIRE( arm.has_wound( wound_thermal_blister ) );
    CHECK( arm.get_wounds().front().get_healing_progress() == ( old_save ? 1_minutes : 0_turns ) );

    dialogue d( get_talker_for( u ), nullptr );
    d.set_value( "last_damage", diag_value( 10 ) );
    d.set_value( "last_damage_pain", diag_value( 30 ) );
    d.set_value( "last_damage_bodypart", diag_value( body_part_torso.str() ) );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( torso.get_hp_cur() == hp );
    CHECK( u.Creature::get_pain() == 7 );
    CHECK_FALSE( u.maybe_get_value( "xedra_last_damage_taken" ) );
    REQUIRE( u.remove_effect( effect_xedra_time_loop ) );
}

TEST_CASE( "xedra_new_timelines_rewind_to_their_own_legacy_hit",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_chronomancer_stable_timeloop.is_valid() );
    REQUIRE( effect_xedra_time_loop.is_valid() );
    REQUIRE( effect_lucid_dream.is_valid() );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_queue( std::move( u.queued_effect_on_conditions ) );
    const restore_on_out_of_scope restore_version( savegame_loading_version );
    savegame_loading_version = savegame_version;
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    u.forget_recent_damage();
    u.set_all_parts_hp_cur( 24 );
    u.set_pain( 35 );
    set_legacy_last_damage( u );
    std::ostringstream saved;
    JsonOut out( saved );
    u.serialize( out );
    u.clear_values();
    u.setID( character_id(), true );
    u.deserialize( json_loader::from_string( saved.str() ).get_object() );
    REQUIRE_FALSE( u.take_recent_damage() );
    REQUIRE( u.maybe_get_value( "xedra_last_damage_taken" ) );

    const int hp = u.get_part_hp_cur( body_part_torso );
    u.add_effect( effect_xedra_chronomancer_stable_timeloop, 1_hours );
    REQUIRE( u.has_effect( effect_xedra_chronomancer_stable_timeloop ) );
    dialogue d( get_talker_for( u ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    REQUIRE( u.get_part_hp_cur( body_part_torso ) == hp + 10 );
    REQUIRE( u.Creature::get_pain() == 5 );

    u.set_part_hp_cur( body_part_arm_l, hp - 2 );
    u.set_pain( 12 );
    u.set_value( "xedra_last_damage_taken", diag_value( 6 ) );
    u.set_value( "xedra_last_pain_taken", diag_value( 7 ) );
    u.set_value( "xedra_last_damage_taken_bodypart", diag_value( body_part_arm_l.str() ) );
    const efftype_id inner( GENERATE( effect_xedra_time_loop, effect_lucid_dream ) );
    const int rewound_hp = hp - 2;
    u.add_effect( inner, 20_seconds );
    REQUIRE( u.has_effect( inner ) );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    REQUIRE( u.get_part_hp_cur( body_part_arm_l ) == hp + 4 );

    REQUIRE( u.remove_effect( effect_xedra_chronomancer_stable_timeloop ) );
    CHECK( u.get_part_hp_cur( body_part_torso ) == hp );
    CHECK( u.Creature::get_pain() == 35 );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( u.get_part_hp_cur( body_part_torso ) == hp + 10 );
    CHECK( u.Creature::get_pain() == 5 );

    if( inner == effect_xedra_time_loop ) {
        calendar::turn += 5_seconds;
        effect_on_conditions::process_effect_on_conditions( u );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == hp - 2 );
        CHECK( u.Creature::get_pain() == 12 );
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == hp + 4 );
        CHECK( u.Creature::get_pain() == 5 );
    }

    REQUIRE( u.remove_effect( inner ) );
    CHECK( u.get_part_hp_cur( body_part_arm_l ) == rewound_hp );
    CHECK( u.Creature::get_pain() == 12 );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( u.get_part_hp_cur( body_part_arm_l ) == rewound_hp + 6 );
    CHECK( u.Creature::get_pain() == 5 );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( u.get_part_hp_cur( body_part_arm_l ) == rewound_hp + 6 );
    CHECK( u.Creature::get_pain() == 5 );
}

TEST_CASE( "xedra_lucid_dream_restores_per_limb_hp_with_an_old_save_fallback",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_lucid_dream.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    u.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    u.set_part_hp_cur( body_part_torso, 43 );
    u.set_part_hp_cur( body_part_arm_l, 21 );
    u.set_part_hp_cur( body_part_hand_l, 32 );
    u.set_value( "hp_before_lucid", diag_value( 26 ) );
    u.add_effect( effect_lucid_dream, 5_minutes );
    REQUIRE( u.has_effect( effect_lucid_dream ) );
    CHECK_FALSE( u.maybe_get_value( "hp_before_lucid" ) );
    u.set_all_parts_hp_cur( 12 );

    SECTION( "a dream started in this version uses the native baseline" ) {
        u.set_value( "hp_before_lucid", diag_value( 26 ) );
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        CHECK( u.get_part_hp_cur( body_part_torso ) == 43 );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == 21 );
        CHECK( u.get_part_hp_cur( body_part_hand_l ) == 32 );
    }
    SECTION( "a preexisting dream can still restore its saved aggregate HP" ) {
        if( GENERATE( false, true ) ) {
            // This older format has no limb identity and cannot safely restore any wound.
            u.set_value( "thermal_snapshot:xedra_lucid_dream",
                         diag_value( std::string( R"({"thermal_parts":{}})" ) ) );
        } else {
            u.remove_value( "thermal_snapshot:xedra_lucid_dream" );
        }
        REQUIRE( u.apply_thermal_burn( body_part_arm_r, false ) );
        u.set_value( "hp_before_lucid", diag_value( 26 ) );
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        CHECK( u.get_part_hp_cur( body_part_torso ) == 26 );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == 26 );
        CHECK( u.get_part_hp_cur( body_part_hand_l ) == 26 );
        CHECK( u.get_part( body_part_arm_r )->has_wound( wound_thermal_blister ) );
    }
}

TEST_CASE( "xedra_lucid_rebirth_prevents_death_without_hurting_a_limb_gained_in_the_dream",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_lucid_dream.is_valid() );
    REQUIRE( enchantment_ENCH_TEST_ALT_ARMS.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    u.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    u.set_part_hp_cur( body_part_torso, 43 );
    u.add_effect( effect_lucid_dream, 5_minutes );
    REQUIRE( u.has_effect( effect_lucid_dream ) );
    REQUIRE_FALSE( u.has_part( body_part_test_alt_arm_l ) );
    u.enchantment_cache->force_add( *enchantment_ENCH_TEST_ALT_ARMS, u );
    u.recalculate_bodyparts();
    REQUIRE( u.has_part( body_part_test_alt_arm_l ) );
    u.set_part_hp_cur( body_part_test_alt_arm_l, 31 );
    u.set_part_hp_cur( body_part_torso, 0 );
    REQUIRE( u.is_dead_state() );

    effect_on_conditions::prevent_death();

    CHECK_FALSE( u.is_dead_state() );
    CHECK_FALSE( u.has_effect( effect_lucid_dream ) );
    CHECK( u.get_part_hp_cur( body_part_torso ) == 43 );
    REQUIRE( u.has_part( body_part_test_alt_arm_l ) );
    CHECK( u.get_part_hp_cur( body_part_test_alt_arm_l ) == 31 );
}

TEST_CASE( "xedra_named_legacy_hit_requires_the_original_limb",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_lucid_dream.is_valid() );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    u.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    u.forget_recent_damage();
    u.set_pain( 33 );
    u.set_all_parts_hp_cur( 5 );
    set_legacy_last_damage( u );
    dialogue d( get_talker_for( u ), nullptr );

    SECTION( "a same-ID replacement cannot receive a legacy hit, even after successful rewind" ) {
        REQUIRE( enchantment_ENCH_TEST_ALT_ARMS.is_valid() );
        u.set_value( "xedra_last_damage_taken_bodypart", diag_value( body_part_arm_l.str() ) );
        u.add_effect( effect_lucid_dream, 5_minutes );
        REQUIRE( u.has_effect( effect_lucid_dream ) );
        const bool replace_after_rewind = GENERATE( false, true );
        if( replace_after_rewind ) {
            REQUIRE( u.remove_effect( effect_lucid_dream ) );
            CHECK_FALSE( u.maybe_get_value( "xedra_last_damage_taken" ) );
        }
        u.enchantment_cache->force_add( *enchantment_ENCH_TEST_ALT_ARMS, u );
        u.recalculate_bodyparts();
        REQUIRE_FALSE( u.has_part( body_part_arm_l ) );
        u.enchantment_cache->clear();
        u.recalculate_bodyparts();
        REQUIRE( u.has_part( body_part_arm_l ) );
        u.recalc_hp();
        u.set_part_hp_cur( body_part_arm_l, 41 );
        if( GENERATE( false, true ) ) {
            const restore_on_out_of_scope restore_version( savegame_loading_version );
            savegame_loading_version = savegame_version;
            std::ostringstream saved;
            JsonOut out( saved );
            u.serialize( out );
            u.clear_values();
            u.setID( character_id(), true );
            u.deserialize( json_loader::from_string( saved.str() ).get_object() );
            REQUIRE( u.has_effect( effect_lucid_dream ) == !replace_after_rewind );
        }

        if( !replace_after_rewind ) {
            REQUIRE( u.remove_effect( effect_lucid_dream ) );
        }
        CHECK_FALSE( u.maybe_get_value( "xedra_last_damage_taken" ) );
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == 41 );
        CHECK( u.Creature::get_pain() == 33 );
    }
    SECTION( "the captured native hit takes precedence over the legacy hit" ) {
        u.record_scripted_damage( body_part_arm_r, 3, 2 );
        u.add_effect( effect_lucid_dream, 5_minutes );
        REQUIRE( u.has_effect( effect_lucid_dream ) );
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        CHECK_FALSE( u.maybe_get_value( "xedra_last_damage_taken" ) );
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        CHECK( u.get_part_hp_cur( body_part_arm_r ) == 8 );
        CHECK( u.get_part_hp_cur( body_part_torso ) == 5 );
        CHECK( u.Creature::get_pain() == 31 );
    }
    SECTION( "the original whole-body sentinel still works without a limb identity" ) {
        u.set_value( "xedra_last_damage_taken_bodypart", diag_value( bodypart_str_id::NULL_ID().str() ) );
        u.add_effect( effect_lucid_dream, 5_minutes );
        REQUIRE( u.has_effect( effect_lucid_dream ) );
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        const int legacy_hp = u.get_hp() + 10;
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        CHECK( u.get_part_hp_cur( body_part_torso ) == legacy_hp );
        CHECK( u.get_part_hp_cur( body_part_arm_l ) == legacy_hp );
        CHECK( u.Creature::get_pain() == 33 );
    }
}

TEST_CASE( "xedra_stable_time_loop_restores_thermal_injuries_by_part",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_chronomancer_stable_timeloop.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    const override_option always_wound( "WOUND_CHANCE", "1" );

    const bodypart &left = *u.get_part( body_part_arm_l );
    const bodypart &right = *u.get_part( body_part_arm_r );
    REQUIRE( u.apply_thermal_burn( body_part_hand_l, false ) );
    u.update_wounds( 2_minutes );
    REQUIRE( left.has_wound( wound_thermal_blister ) );
    const wound original = left.get_wounds().front();
    u.set_pain( 7 );
    u.set_thirst( 15 );
    u.add_effect( effect_xedra_chronomancer_stable_timeloop, 1_hours );
    REQUIRE( u.has_effect( effect_xedra_chronomancer_stable_timeloop ) );

    REQUIRE( u.apply_thermal_burn( body_part_hand_l, true ) );
    REQUIRE( deal_one_heat_hit( u, body_part_hand_r, 15 ).type_damage( damage_heat ) == 15 );
    REQUIRE( left.has_wound( wound_thermal_burn ) );
    REQUIRE( right.has_wound( wound_thermal_burn ) );
    u.set_pain( 21 );
    u.set_thirst( 40 );
    SECTION( "rewind restores the saved tier and healing state" ) {
        REQUIRE( u.remove_effect( effect_xedra_chronomancer_stable_timeloop ) );
        CHECK_FALSE( right.has_wounds() );
        REQUIRE( left.get_wounds().size() == 1 );
        const wound &restored = left.get_wounds().front();
        CHECK( restored.type == original.type );
        CHECK( restored.get_healing_progress() == original.get_healing_progress() );
        CHECK( restored.get_healing_time() == original.get_healing_time() );
        CHECK( restored.get_base_pain() == original.get_base_pain() );
        CHECK( u.get_pain() == 7 + original.get_pain() );
    }
    SECTION( "an effect started on an old save has no thermal baseline" ) {
        u.remove_value( "thermal_snapshot:xedra_stable_timeloop" );
        REQUIRE( u.remove_effect( effect_xedra_chronomancer_stable_timeloop ) );
        CHECK( left.has_wound( wound_thermal_burn ) );
        CHECK( right.has_wound( wound_thermal_burn ) );
        CHECK_FALSE( u.take_recent_damage() );
    }
    CHECK( u.Creature::get_pain() == 7 );
    CHECK( u.get_thirst() == 15 );
}

TEST_CASE( "xedra_stable_time_loop_and_lucid_dream_keep_independent_thermal_snapshots",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_chronomancer_stable_timeloop.is_valid() );
    REQUIRE( effect_lucid_dream.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    u.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    const bodypart &left = *u.get_part( body_part_arm_l );
    const bodypart &right = *u.get_part( body_part_arm_r );

    REQUIRE( u.apply_thermal_burn( body_part_arm_l, false ) );
    u.update_wounds( 2_minutes );
    u.add_effect( effect_xedra_chronomancer_stable_timeloop, 1_hours );
    REQUIRE( u.has_effect( effect_xedra_chronomancer_stable_timeloop ) );

    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_r, false ) );
    u.update_wounds( 4_minutes );
    u.add_effect( effect_lucid_dream, 5_minutes );
    REQUIRE( u.has_effect( effect_lucid_dream ) );

    REQUIRE( u.apply_thermal_burn( body_part_arm_r, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_leg_l, false ) );
    u.update_wounds( 1_minutes );

    const auto restore_loop = [&u, &left, &right]() {
        REQUIRE( u.remove_effect( effect_xedra_chronomancer_stable_timeloop ) );
        REQUIRE( left.has_wound( wound_thermal_blister ) );
        CHECK( left.get_wounds().front().get_healing_progress() == 2_minutes );
        CHECK_FALSE( right.has_wounds() );
        CHECK_FALSE( u.get_part( body_part_leg_l )->has_wounds() );
    };
    const auto restore_dream = [&u, &left, &right]() {
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        REQUIRE( left.has_wound( wound_thermal_burn ) );
        REQUIRE( right.has_wound( wound_thermal_blister ) );
        CHECK( left.get_wounds().front().get_healing_progress() == 4_minutes );
        CHECK( right.get_wounds().front().get_healing_progress() == 4_minutes );
        CHECK_FALSE( u.get_part( body_part_leg_l )->has_wounds() );
    };
    SECTION( "the dream ends before the loop" ) {
        restore_dream();
        restore_loop();
    }
    SECTION( "the loop ends while still dreaming" ) {
        restore_loop();
        restore_dream();
    }
}

TEST_CASE( "xedra_thermal_protection_blocks_burns_but_does_not_cure_them",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    const efftype_id protection( GENERATE( "effect_flame_immunity", "effect_hidden_flame_immunity",
                                          "effect_hedge_extinguish_fire_spell_self_resistance",
                                          "effect_changeling_summer_ring_of_flames" ) );
    CAPTURE( protection );
    REQUIRE( protection.is_valid() );
    clear_avatar();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );

    u.apply_thermal_burn( body_part_arm_l, false );
    u.update_wounds( 2_minutes );
    u.add_effect( protection, 1_minutes );
    u.apply_thermal_burn( body_part_arm_l, true );
    u.apply_thermal_burn( body_part_arm_r, true );

    const bodypart &injured_arm = *u.get_part( body_part_arm_l );
    REQUIRE( injured_arm.get_wounds().size() == 1 );
    CHECK( injured_arm.has_wound( wound_thermal_blister ) );
    CHECK( injured_arm.get_wounds().front().get_healing_progress() == 2_minutes );
    CHECK_FALSE( u.get_part( body_part_arm_r )->has_wounds() );
}

TEST_CASE( "xedra_time_freeze_pauses_thermal_healing_on_real_turns",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_xedra_time_freeze.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );

    u.apply_thermal_burn( body_part_arm_l, true );
    u.update_wounds( 2_minutes );
    const bodypart &arm = *u.get_part( body_part_arm_l );
    REQUIRE( arm.has_wound( wound_thermal_burn ) );
    u.add_effect( effect_xedra_time_freeze, 10_turns );
    REQUIRE( u.has_effect( effect_xedra_time_freeze ) );
    calendar::turn += 1_turns;
    u.process_turn();
    CHECK( arm.get_wounds().front().get_healing_progress() == 2_minutes );

    REQUIRE( u.remove_effect( effect_xedra_time_freeze ) );
    calendar::turn += 1_turns;
    u.process_turn();
    CHECK( arm.get_wounds().front().get_healing_progress() == 2_minutes + 1_turns );
}

TEST_CASE( "xedra_looping_wound_replaces_the_latest_hit_with_native_scripted_damage",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( trait_XEDRA_CHRONOMANCER_LOOPING_WOUND.is_valid() );
    REQUIRE( effect_on_condition_EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE.is_valid() );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const override_option always_wound( "WOUND_CHANCE", "1" );
    struct torso_test_npc : standard_npc {
        using standard_npc::standard_npc;
        using Creature::body;
    };
    torso_test_npc injured( "Injured chronomancer", tripoint_bub_ms( 50, 50, 0 ) );
    injured.toggle_trait( trait_XEDRA_CHRONOMANCER_LOOPING_WOUND );
    const bodypart_str_id recipient = GENERATE( body_part_torso, body_part_torso_slime );
    if( recipient != body_part_torso ) {
        REQUIRE( recipient.is_valid() );
        injured.body.erase( body_part_torso );
        injured.body.emplace( recipient, bodypart( recipient ) );
    }
    REQUIRE( injured.get_part_id( body_part_torso ) == recipient );
    const bodypart &torso = *injured.get_part( recipient );
    const bodypart &arm = *injured.get_part( body_part_arm_l );
    const int hp = torso.get_hp_cur();
    const int arm_hp = arm.get_hp_cur();
    REQUIRE( deal_one_heat_hit( injured, body_part_hand_l, 6 ).type_damage( damage_heat ) == 6 );
    REQUIRE( arm.has_wound( wound_thermal_blister ) );
    const int pain = injured.Creature::get_pain();
    set_legacy_last_damage( injured );

    dialogue d( get_talker_for( injured ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_CHRONOMANCER_LOOPING_WOUND_DAMAGE->activate( d ) );
    CHECK( torso.get_hp_cur() == hp - 10 );
    CHECK( injured.Creature::get_pain() == pain + 30 );
    CHECK( injured.has_effect( effect_bleed, recipient ) );
    if( recipient != body_part_torso ) {
        CHECK_FALSE( injured.has_effect( effect_bleed, body_part_torso ) );
    }
    CHECK_FALSE( injured.maybe_get_value( "xedra_last_damage_taken" ) );
    SECTION( "the scripted wound is reversible without curing the previous burn" ) {
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        CHECK( torso.get_hp_cur() == hp );
        CHECK( injured.Creature::get_pain() == pain );
        CHECK_FALSE( injured.has_effect( effect_bleed, recipient ) );
    }
    SECTION( "the scripted wound does not reappear after a newer native hit" ) {
        const int leg_hp = injured.get_part_hp_cur( body_part_leg_r );
        injured.apply_damage( nullptr, body_part_leg_r, 5 );
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        CHECK( injured.get_part_hp_cur( body_part_leg_r ) == leg_hp );
        CHECK( torso.get_hp_cur() == hp - 10 );
    }

    const int remaining_hp = torso.get_hp_cur();
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( torso.get_hp_cur() == remaining_hp );
    CHECK( arm.get_hp_cur() == arm_hp - 6 );
    CHECK( arm.has_wound( wound_thermal_blister ) );
}

TEST_CASE( "xedra_revert_wound_uses_legacy_damage_only_without_a_native_record",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_map_without_vision();
    standard_npc injured( "Injured chronomancer", tripoint_bub_ms( 50, 50, 0 ) );
    const bodypart &torso = *injured.get_part( body_part_torso );
    const int hp = torso.get_hp_cur();
    injured.set_part_hp_cur( body_part_torso, hp - 20 );
    injured.set_pain( 35 );
    set_legacy_last_damage( injured );
    const bool spent = GENERATE( false, true );
    if( spent ) {
        injured.record_scripted_damage( body_part_torso, 5, 0 );
        REQUIRE( injured.take_recent_damage() );
    }

    dialogue d( get_talker_for( injured ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    const int remaining_hp = spent ? hp - 20 : hp - 10;
    const int remaining_pain = spent ? 35 : 5;
    CHECK( torso.get_hp_cur() == remaining_hp );
    CHECK( injured.Creature::get_pain() == remaining_pain );
    CHECK_FALSE( injured.maybe_get_value( "xedra_last_damage_taken" ) );
    injured.forget_recent_damage();
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( torso.get_hp_cur() == remaining_hp );
    CHECK( injured.Creature::get_pain() == remaining_pain );
}

TEST_CASE( "xedra_revert_wound_removes_only_the_latest_contact_blister",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( spell_xedra_chronomancer_revert_wound.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    constexpr unsigned int seed = 421672;
    rng_set_engine_seed( seed );
    CAPTURE( seed );

    const bodypart &left = *u.get_part( body_part_arm_l );
    bodypart &right = *u.get_part( body_part_arm_r );
    const int left_hp = left.get_hp_cur();
    const int right_hp = right.get_hp_cur();
    REQUIRE( deal_one_heat_hit( u, body_part_hand_l, 6 ).type_damage( damage_heat ) == 6 );
    u.update_wounds( 2_minutes );
    REQUIRE( deal_one_heat_hit( u, body_part_hand_r, 8 ).type_damage( damage_heat ) == 8 );
    REQUIRE( left.has_wound( wound_thermal_blister ) );
    REQUIRE( right.has_wound( wound_thermal_blister ) );
    REQUIRE( right.get_hp_cur() == right_hp - 8 );

    const spell revert( spell_xedra_chronomancer_revert_wound );
    SECTION( "new contact blister disappears once" ) {
        revert.cast_all_effects( u, u.pos_bub() );
        CHECK_FALSE( right.has_wounds() );
        CHECK( right.get_hp_cur() == right_hp );
        revert.cast_all_effects( u, u.pos_bub() );
        CHECK( right.get_hp_cur() == right_hp );
    }
    SECTION( "a treated and recreated blister does not belong to the hit" ) {
        right.remove_wound( wound_thermal_blister );
        u.apply_thermal_burn( body_part_hand_r, false );
        revert.cast_all_effects( u, u.pos_bub() );
        CHECK( right.has_wound( wound_thermal_blister ) );
        CHECK( right.get_hp_cur() == right_hp );
    }
    SECTION( "a same-tier hit did not create the older blister" ) {
        right.update_wounds( 30_seconds );
        deal_one_heat_hit( u, body_part_hand_r, 6 );
        revert.cast_all_effects( u, u.pos_bub() );
        REQUIRE( right.has_wound( wound_thermal_blister ) );
        CHECK( right.get_wounds().front().get_healing_progress() == 30_seconds );
        CHECK( right.get_hp_cur() == right_hp - 8 );
    }
    SECTION( "newer untyped damage supersedes the burn" ) {
        const int leg_hp = u.get_part_hp_cur( body_part_leg_r );
        u.apply_damage( nullptr, body_part_leg_r, 5 );
        revert.cast_all_effects( u, u.pos_bub() );
        CHECK( u.get_part_hp_cur( body_part_leg_r ) == leg_hp );
        CHECK( right.has_wound( wound_thermal_blister ) );
        CHECK( right.get_hp_cur() == right_hp - 8 );
    }
    CHECK( left.get_hp_cur() == left_hp - 6 );
    REQUIRE( left.has_wound( wound_thermal_blister ) );
    CHECK( left.get_wounds().front().get_healing_progress() == 2_minutes );
}

TEST_CASE( "xedra_revert_wound_succeeds_without_hp_loss",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    u.set_part_hp_cur( body_part_arm_l, 0 );
    REQUIRE_FALSE( u.is_dead_state() );
    u.add_effect( effect_onfire, 10_turns, body_part_hand_l, false, 1, false, true );
    u.add_effect( effect_bleed, 1_minutes, body_part_arm_l, false, 1, false, true );
    const bodypart &arm = *u.get_part( body_part_arm_l );
    REQUIRE( u.deal_damage( nullptr, body_part_hand_l,
                            damage_instance( damage_heat, 8 ) ).type_damage( damage_heat ) == 8 );
    REQUIRE( arm.has_wound( wound_thermal_blister ) );
    REQUIRE( arm.get_hp_cur() == 0 );
    const int pain = u.Creature::get_pain();

    dialogue d( get_talker_for( u ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK_FALSE( arm.has_wounds() );
    CHECK( arm.get_hp_cur() == 0 );
    CHECK( u.Creature::get_pain() == pain );
    CHECK( u.has_effect( effect_bleed, body_part_arm_l ) );
    const auto first_message = Messages::recent_messages( 1 );
    REQUIRE_FALSE( first_message.empty() );
    CHECK( first_message.back().second == "Your wound heals!" );

    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    const auto second_message = Messages::recent_messages( 1 );
    REQUIRE_FALSE( second_message.empty() );
    CHECK( second_message.back().second == "You don't have a previous wound to heal." );
}

TEST_CASE( "xedra_revert_wound_preserves_independently_earned_environmental_tiers",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const bool severe_contact = GENERATE( false, true );
    const bool severe_exposure = GENERATE( false, true );
    CAPTURE( severe_contact, severe_exposure );
    const int heat = severe_contact ? 15 : 8;
    thermal_exposure_npc injured( "Exposed chronomancer", tripoint_bub_ms( 50, 50, 0 ) );
    injured.add_effect( effect_onfire, 10_turns, body_part_hand_l, false, 1, false, true );
    const bodypart &arm = *injured.get_part( body_part_arm_l );
    const int hp = arm.get_hp_cur();
    REQUIRE( injured.deal_damage( nullptr, body_part_hand_l,
                                  damage_instance( damage_heat, heat ) ).type_damage( damage_heat ) == heat );
    injured.remove_effect( effect_onfire );
    REQUIRE( arm.has_wound( severe_contact ? wound_thermal_burn : wound_thermal_blister ) );
    injured.update_wounds( 2_minutes );
    earn_environmental_burn( injured, severe_exposure );
    injured.update_wounds( 1_turns );

    // A blister earned under the contact burn must retain its own healing clock after loading.
    std::ostringstream saved;
    JsonOut out( saved );
    injured.serialize( out );
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    dialogue d( get_talker_for( restored ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );

    const bodypart &restored_arm = *restored.get_part( body_part_arm_l );
    CHECK( restored_arm.get_hp_cur() == hp );
    REQUIRE( restored_arm.get_wounds().size() == 1 );
    const wound &remaining = restored_arm.get_wounds().front();
    CHECK( remaining.type == ( severe_exposure ? wound_thermal_burn : wound_thermal_blister ) );
    CHECK( remaining.get_healing_progress() ==
           ( severe_contact == severe_exposure ? 2_minutes + 1_turns : 1_turns ) );
}

TEST_CASE( "xedra_thermal_rewinds_preserve_partial_environmental_dose",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    thermal_exposure_npc injured( "Exposed chronomancer", tripoint_bub_ms( 50, 50, 0 ) );
    const bodypart_str_id contact = GENERATE( body_part_arm_l, body_part_hand_l );
    const bodypart &exposed = *injured.get_part( contact );
    const bodypart &arm = *injured.get_part( body_part_arm_l );
    injured.set_all_parts_temp_cur( BODYTEMP_NORM );
    injured.set_part_temp_cur( contact, BODYTEMP_SCORCHING + 2_C_delta );
    for( int i = 0; i < to_turns<int>( 29_seconds ); ++i ) {
        calendar::turn += 1_turns;
        injured.update_thermal_exposure();
    }
    REQUIRE( exposed.has_heat_exposure() );
    REQUIRE_FALSE( arm.has_wounds() );
    SECTION( "reverting a contact hit does not cure the exposed part" ) {
        REQUIRE( deal_one_heat_hit( injured, body_part_hand_l, 6 ).type_damage( damage_heat ) == 6 );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        dialogue d( get_talker_for( injured ), nullptr );
        REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
        injured.set_part_temp_cur( contact, BODYTEMP_SCORCHING + 2_C_delta );
    }
    SECTION( "a timeline rewind restores dose without adding a new sample" ) {
        injured.save_thermal_wounds( "before_blister" );
        calendar::turn += 1_turns;
        injured.update_thermal_exposure();
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        injured.restore_thermal_wounds( "before_blister" );
        injured.update_thermal_exposure();
    }
    CHECK_FALSE( arm.has_wounds() );
    CHECK_FALSE( arm.needs_heat_exposure_reset() );
    CHECK( exposed.has_heat_exposure() );
    calendar::turn += 1_turns;
    injured.update_thermal_exposure();
    CHECK( arm.has_wound( wound_thermal_blister ) );
}

TEST_CASE( "xedra_thermal_snapshot_persists_contact_provenance_across_load",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const override_option always_wound( "WOUND_CHANCE", "1" );
    standard_npc injured( "Injured chronomancer", tripoint_bub_ms( 50, 50, 0 ) );
    REQUIRE( injured.apply_thermal_burn( body_part_hand_l, false ) );
    injured.update_wounds( 2_minutes );
    const int original_hp = injured.get_part_hp_cur( body_part_arm_l );
    REQUIRE( deal_one_heat_hit( injured, body_part_hand_l, 15 ).type_damage( damage_heat ) == 15 );
    injured.update_wounds( 1_minutes );
    injured.save_thermal_wounds( "before_loop" );
    injured.forget_recent_damage();
    injured.update_wounds( 3_minutes );

    std::ostringstream saved;
    JsonOut out( saved );
    injured.serialize( out );
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    REQUIRE( restored.restore_thermal_wounds( "before_loop" ) );
    const bodypart &arm = *restored.get_part( body_part_arm_l );
    REQUIRE( arm.has_wound( wound_thermal_burn ) );
    CHECK( arm.get_wounds().front().get_healing_progress() == 1_minutes );
    dialogue d( get_talker_for( restored ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( arm.get_hp_cur() == original_hp );
    REQUIRE( arm.has_wound( wound_thermal_blister ) );
    CHECK( arm.get_wounds().front().get_healing_progress() == 3_minutes );
    CHECK_FALSE( restored.restore_thermal_wounds( "before_loop" ) );
    CHECK( arm.has_wound( wound_thermal_blister ) );
}

TEST_CASE( "xedra_revert_contact_burn_restores_an_older_blister_after_load",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    constexpr unsigned int seed = 785874;
    rng_set_engine_seed( seed );
    CAPTURE( seed );

    thermal_exposure_npc injured( "Injured chronomancer", tripoint_bub_ms( 50, 50, 0 ) );
    injured.apply_thermal_burn( body_part_hand_l, false );
    injured.update_wounds( 2_minutes );
    const bodypart &arm = *injured.get_part( body_part_arm_l );
    REQUIRE( arm.has_wound( wound_thermal_blister ) );
    const wound original = arm.get_wounds().front();
    const int hp = arm.get_hp_cur();
    REQUIRE( deal_one_heat_hit( injured, body_part_hand_l, 15 ).type_damage( damage_heat ) == 15 );
    REQUIRE( arm.has_wound( wound_thermal_burn ) );
    CHECK_FALSE( arm.has_wound( wound_thermal_blister ) );
    calendar::turn += 1_turns;
    injured.process_turn();
    if( GENERATE( false, true ) ) {
        earn_environmental_burn( injured, false );
    }

    std::ostringstream saved;
    JsonOut out( saved );
    injured.serialize( out );
    npc restored;
    restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    const bodypart &restored_arm = *restored.get_part( body_part_arm_l );
    REQUIRE( restored_arm.has_wound( wound_thermal_burn ) );

    dialogue d( get_talker_for( restored ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK( restored_arm.get_hp_cur() == hp );
    REQUIRE( restored_arm.get_wounds().size() == 1 );
    const wound &blister = restored_arm.get_wounds().front();
    CHECK( blister.type == wound_thermal_blister );
    CHECK( blister.get_healing_progress() == 2_minutes + 1_turns );
    CHECK( blister.get_healing_time() == original.get_healing_time() );
    CHECK( blister.get_base_pain() == original.get_base_pain() );
}

TEST_CASE( "xedra_revert_wound_tracks_actor_bound_nested_damage",
           "[.][mods][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    avatar &u = get_avatar();
    const on_out_of_scope cleanup( [&u] { u.clear_effects(); } );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    constexpr unsigned int seed = 423675;
    rng_set_engine_seed( seed );
    CAPTURE( seed );
    standard_npc other( "Nested target", tripoint_bub_ms( 50, 50, 0 ) );

    class nested_hit : public event_subscriber
    {
        public:
            nested_hit( Character &first, Character &second ) : first( first ), second( second ) {}

            void notify( const cata::event &e ) override {
                if( e.type() == event_type::character_takes_damage ) {
                    FAIL( "Damage notifications must identify the actor even with no source." );
                }
            }

            void notify( const cata::event &e, std::unique_ptr<talker> alpha,
                         std::unique_ptr<talker> ) override {
                if( e.type() != event_type::character_takes_damage ) {
                    return;
                }
                REQUIRE( alpha );
                Character &actor = nested ? second : first;
                CHECK( alpha->get_character() == &actor );
                if( !nested ) {
                    nested = true;
                    second.deal_damage( nullptr, body_part_hand_r, damage_instance( damage_heat, 15 ) );
                }
            }

        private:
            Character &first;
            Character &second;
            bool nested = false;
    };

    const bool same_actor = GENERATE( true, false );
    Character &second = same_actor ? static_cast<Character &>( u ) : static_cast<Character &>( other );
    {
        nested_hit listener( u, second );
        get_event_bus().subscribe( &listener );
        u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 6 ) );
    }
    const bodypart &left = *u.get_part( body_part_arm_l );
    const bodypart &right = *second.get_part( body_part_arm_r );
    REQUIRE( left.has_wound( wound_thermal_blister ) );
    REQUIRE( right.has_wound( wound_thermal_burn ) );
    dialogue d( get_talker_for( &second ), nullptr );
    REQUIRE( effect_on_condition_EOC_XEDRA_DAMAGE_REVERSAL->activate( d ) );
    CHECK_FALSE( right.has_wounds() );
    CHECK( left.has_wound( wound_thermal_blister ) );
}
