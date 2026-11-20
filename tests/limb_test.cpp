#include <initializer_list>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "body_part_set.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "coordinates.h"
#include "damage.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "flag.h"
#include "generic_factory.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_content.h"
#include "magic_enchantment.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "npc.h"
#include "npc_opinion.h"
#include "options_helpers.h"
#include "pimpl.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"
#include "weather.h"
#include "weather_gen.h"
#include "weather_type.h"
#include "wound.h"

static const bodypart_str_id body_part_test_alt_arm_l( "test_alt_arm_l" );
static const bodypart_str_id body_part_test_bird_foot_l( "test_bird_foot_l" );
static const bodypart_str_id body_part_test_bird_foot_r( "test_bird_foot_r" );
static const bodypart_str_id body_part_test_bird_wing_l( "test_bird_wing_l" );
static const bodypart_str_id body_part_test_bird_wing_r( "test_bird_wing_r" );
static const bodypart_str_id body_part_test_corvid_beak( "test_corvid_beak" );
static const bodypart_str_id body_part_test_lizard_tail( "test_lizard_tail" );
static const bodypart_str_id body_part_test_partial_wing_l( "test_partial_wing_l" );

static const character_modifier_id character_modifier_liquid_consume_mod( "liquid_consume_mod" );
static const character_modifier_id character_modifier_solid_consume_mod( "solid_consume_mod" );

static const damage_type_id damage_cold( "cold" );
static const damage_type_id damage_heat( "heat" );

static const efftype_id effect_cold( "cold" );
static const efftype_id effect_hot( "hot" );
static const efftype_id effect_hot_speed( "hot_speed" );
static const efftype_id effect_incorporeal( "incorporeal" );
static const efftype_id effect_mending( "mending" );
static const efftype_id effect_onfire( "onfire" );
static const efftype_id effect_winded_arm( "winded_arm" );

static const enchantment_id enchantment_ENCH_TEST_ALT_ARMS( "ENCH_TEST_ALT_ARMS" );
static const enchantment_id enchantment_ENCH_TEST_BIRD_PARTS( "ENCH_TEST_BIRD_PARTS" );
static const enchantment_id enchantment_ENCH_TEST_LIZARD_TAIL( "ENCH_TEST_LIZARD_TAIL" );

static const itype_id itype_test_bird_boots( "test_bird_boots" );
static const itype_id itype_test_jumpsuit_cotton( "test_jumpsuit_cotton" );
static const itype_id itype_test_liquid( "test_liquid" );
static const itype_id itype_test_longshirt( "test_longshirt" );
static const itype_id itype_test_pine_nuts( "test_pine_nuts" );
static const itype_id itype_test_protective_clothing( "test_protective_clothing" );
static const itype_id itype_test_shackles( "test_shackles" );
static const itype_id itype_test_winglets( "test_winglets" );
static const itype_id itype_test_winglets_left( "test_winglets_left" );

static const json_character_flag json_flag_WALL_CLING( "WALL_CLING" );

static const sub_bodypart_str_id
sub_body_part_sub_limb_test_bird_foot_l( "sub_limb_test_bird_foot_l" );
static const sub_bodypart_str_id
sub_body_part_sub_limb_test_bird_foot_r( "sub_limb_test_bird_foot_r" );

static const ter_str_id ter_t_grass( "t_grass" );
static const trait_id trait_DEBUG_BIG_HEAD( "DEBUG_BIG_HEAD" );
static const trait_id trait_DEBUG_ONLY_HEAD( "DEBUG_ONLY_HEAD" );
static const trait_id trait_DEBUG_TAIL( "DEBUG_TAIL" );

static const wound_type_id wound_thermal_blister( "thermal_blister" );
static const wound_type_id wound_thermal_burn( "thermal_burn" );

static void create_bird_char( Character &dude )
{
    clear_character( dude, true );

    dude.enchantment_cache->force_add( *enchantment_ENCH_TEST_BIRD_PARTS, dude );
    dude.recalculate_bodyparts();
    REQUIRE( dude.has_part( body_part_test_corvid_beak ) );
    REQUIRE( dude.has_part( body_part_test_bird_wing_l ) );
    REQUIRE( dude.has_part( body_part_test_bird_wing_r ) );
    REQUIRE( dude.has_part( body_part_test_bird_foot_l ) );
    REQUIRE( dude.has_part( body_part_test_bird_foot_r ) );
    REQUIRE( !dude.has_part( body_part_mouth ) );
    REQUIRE( !dude.has_part( body_part_hand_l ) );
    REQUIRE( !dude.has_part( body_part_hand_r ) );
    REQUIRE( !dude.has_part( body_part_foot_l ) );
    REQUIRE( !dude.has_part( body_part_foot_r ) );
}

TEST_CASE( "replacement_hands_match_the_struck_side", "[limb][thermal_burn]" )
{
    standard_npc dude( "Test NPC" );
    create_bird_char( dude );
    CHECK( dude.get_part_id( body_part_hand_l )->part_side == body_part_hand_l->part_side );
    CHECK( dude.get_part_id( body_part_hand_r )->part_side == body_part_hand_r->part_side );
}

TEST_CASE( "zero_weight_stub_does_not_replace_a_missing_foot", "[limb][thermal_burn]" )
{
    standard_npc dude( "Test NPC" );
    clear_character( dude, true );
    enchantment stubs;
    stubs.load( json_loader::from_string( R"({
        "modified_bodyparts": [
            { "lose": "foot_l" }, { "lose": "foot_r" }, { "gain": "leg_stub_l" }
        ]
    })" ).get_object() );
    dude.enchantment_cache->force_add( stubs, dude );
    dude.recalculate_bodyparts();

    REQUIRE( dude.has_part( bodypart_id( "leg_stub_l" ) ) );
    REQUIRE_FALSE( dude.has_part( body_part_foot_l ) );
    CHECK_FALSE( dude.has_part( body_part_foot_l, body_part_filter::next_best ) );
}

TEST_CASE( "alias_fracture_preserves_its_payload_and_nested_damage_record",
           "[limb][thermal_burn]" )
{
    avatar &u = get_avatar();
    clear_character( u );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    u.enchantment_cache->force_add( *enchantment_ENCH_TEST_ALT_ARMS, u );
    u.recalculate_bodyparts();

    const bodypart_id outer_main = body_part_test_alt_arm_l.id();
    const bodypart_id nested_main( "test_alt_arm_r" );
    REQUIRE_FALSE( u.has_part( body_part_arm_l ) );
    REQUIRE( u.get_part_id( body_part_arm_l ) == outer_main );
    REQUIRE( u.thermal_wound_part( body_part_hand_l ) == outer_main );
    REQUIRE( u.thermal_wound_part( body_part_hand_r ) == nested_main );
    u.set_part_hp_cur( outer_main, 1 );
    const int nested_hp = u.get_part_hp_cur( nested_main );
    REQUIRE( nested_hp > 5 );
    u.set_all_parts_temp_cur( BODYTEMP_NORM );
    // Extending an existing fire cannot introduce another HP hit.
    u.add_effect( effect_onfire, 1_turns, body_part_hand_l, false, 1, false, true );
    u.add_effect( effect_onfire, 1_turns, body_part_hand_r, false, 1, false, true );

    struct fracture_observer : event_subscriber {
        explicit fracture_observer( avatar &who ) : who( who ) {}
        using event_subscriber::notify;
        void notify( const cata::event &event ) override {
            if( event.type() != event_type::broken_bone ||
                event.get<character_id>( "character" ) != who.getID() ) {
                return;
            }
            if( ++fractures == 1 ) {
                part = event.get<bodypart_id>( "part" );
                who.deal_damage( nullptr, body_part_hand_r, damage_instance( damage_heat, 5 ) );
            }
        }
        avatar &who;
        bodypart_id part;
        int fractures = 0;
    } observer( u );
    get_event_bus().subscribe( &observer );

    const auto dealt = u.deal_damage( nullptr, body_part_hand_l, damage_instance( damage_heat, 8 ) );
    CHECK( dealt.type_damage( damage_heat ) == 8 );
    CHECK( observer.fractures == 1 );
    CHECK( observer.part == body_part_arm_l );
    CHECK( u.get_part_hp_cur( outer_main ) == 0 );
    CHECK( u.get_part_hp_cur( nested_main ) == nested_hp - 5 );
    CHECK( u.get_part_temp_cur( body_part_hand_l ) == BODYTEMP_NORM + 2_C_delta );
    CHECK( u.get_part_temp_cur( body_part_hand_r ) == BODYTEMP_NORM + 1.25_C_delta );
    REQUIRE( u.get_part( outer_main )->has_wound( wound_thermal_blister ) );
    REQUIRE( u.get_part( nested_main )->has_wound( wound_thermal_blister ) );

    const auto recent = u.take_recent_damage();
    REQUIRE( recent );
    CHECK( recent->part == nested_main.id() );
    CHECK( recent->amount == 5 );
    CHECK( recent->burn_reverted );
    CHECK( u.get_part( outer_main )->has_wound( wound_thermal_blister ) );
    CHECK_FALSE( u.get_part( nested_main )->has_wound( wound_thermal_blister ) );
}

TEST_CASE( "temperature_refresh_clears_penalties_from_the_opposite_zone",
           "[character][thermal_burn]" )
{
    clear_map_without_vision();
    const override_option no_contact_wounds( "WOUND_CHANCE", "0" );
    const restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    get_weather().forced_temperature = 19_C;
    standard_npc dude( "Temperature test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( dude, true );
    const bodypart_id torso = body_part_torso;

    SECTION( "cold to hot" ) {
        dude.set_part_temp_cur( torso, BODYTEMP_COLD - 0.25_C_delta );
        dude.update_bodytemp();
        REQUIRE( dude.has_effect( effect_cold, torso ) );

        dude.deal_damage( nullptr, torso, damage_instance( damage_heat, 16 ) );
        dude.deal_damage( nullptr, torso, damage_instance( damage_heat, 16 ) );
        REQUIRE( dude.get_part_temp_cur( torso ) > BODYTEMP_HOT + BODYTEMP_THRESHOLD );
        CHECK( dude.has_effect( effect_cold, torso ) );
        CHECK_FALSE( dude.has_effect( effect_hot, torso ) );

        dude.update_bodytemp();
        CHECK_FALSE( dude.has_effect( effect_cold, torso ) );
        CHECK( dude.has_effect( effect_hot, torso ) );
        CHECK( dude.has_effect( effect_hot_speed, torso ) );
    }

    SECTION( "hot to cold" ) {
        dude.set_part_temp_cur( torso, BODYTEMP_HOT + 1.5_C_delta );
        dude.update_bodytemp();
        REQUIRE( dude.has_effect( effect_hot, torso ) );
        REQUIRE( dude.has_effect( effect_hot_speed, torso ) );

        dude.deal_damage( nullptr, torso, damage_instance( damage_cold, 16 ) );
        dude.deal_damage( nullptr, torso, damage_instance( damage_cold, 16 ) );
        REQUIRE( dude.get_part_temp_cur( torso ) < BODYTEMP_COLD );
        CHECK( dude.has_effect( effect_hot, torso ) );
        CHECK( dude.has_effect( effect_hot_speed, torso ) );
        CHECK_FALSE( dude.has_effect( effect_cold, torso ) );

        dude.update_bodytemp();
        CHECK_FALSE( dude.has_effect( effect_hot, torso ) );
        CHECK_FALSE( dude.has_effect( effect_hot_speed, torso ) );
        CHECK( dude.has_effect( effect_cold, torso ) );
    }
}

static void sample_heat( Character &dude, int seconds,
                         std::initializer_list<bodypart_id> contacts )
{
    for( int i = 0; i < seconds; ++i ) {
        calendar::turn += 1_turns;
        dude.set_all_parts_temp_cur( BODYTEMP_NORM );
        for( const bodypart_id &contact : contacts ) {
            dude.set_part_temp_cur( contact, BODYTEMP_SCORCHING + 2_C_delta );
        }
        dude.update_bodytemp( true );
    }
}

static void reload_bodypart( bodypart &part )
{
    std::ostringstream save;
    JsonOut out( save );
    part.serialize( out );
    part.deserialize( json_loader::from_string( save.str() ).get_object() );
}

TEST_CASE( "thermal_exposure_restarts_after_cure_on_an_actual_main_part",
           "[character][limb][thermal_burn]" )
{
    clear_map_without_vision();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const restore_on_out_of_scope restore_temperature( get_weather().forced_temperature );
    calendar::turn = calendar::turn_zero;
    get_weather().forced_temperature = 19_C;
    standard_npc dude( "Thermal exposure test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( dude, true );

    SECTION( "curing a replacement arm's blister discards dose at every contact" ) {
        dude.enchantment_cache->force_add( *enchantment_ENCH_TEST_ALT_ARMS, dude );
        dude.recalculate_bodyparts();
        REQUIRE( dude.has_part( body_part_hand_l, body_part_filter::strict ) );
        REQUIRE_FALSE( dude.has_part( body_part_arm_l, body_part_filter::strict ) );
        REQUIRE( dude.has_part( body_part_test_alt_arm_l, body_part_filter::strict ) );
        bodypart &hand = *dude.get_part( body_part_hand_l );
        bodypart &arm = *dude.get_part( body_part_test_alt_arm_l );
        // The hand's own dose crosses first; the replacement arm has 29 seconds banked.
        sample_heat( dude, 1, { body_part_hand_l } );
        sample_heat( dude, 28, { body_part_hand_l, body_part_test_alt_arm_l } );
        REQUIRE_FALSE( arm.has_wounds() );
        sample_heat( dude, 1, { body_part_hand_l, body_part_test_alt_arm_l } );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        CHECK_FALSE( hand.has_wounds() );

        const bool cool_before_cure = GENERATE( false, true );
        CAPTURE( cool_before_cure );
        if( cool_before_cure ) {
            sample_heat( dude, 30, {} );
        }

        arm.remove_all_wounds_of_type( wound_thermal_blister );
        reload_bodypart( arm );
        reload_bodypart( hand );
        dude.update_bodytemp( true ); // A refresh on the same turn cannot bank a new sample.
        sample_heat( dude, 29, { body_part_hand_l, body_part_test_alt_arm_l } );
        REQUIRE_FALSE( arm.has_wounds() );
        sample_heat( dude, 1, { body_part_hand_l, body_part_test_alt_arm_l } );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        CHECK( arm.get_wounds().size() == 1 );
        CHECK( arm.get_wounds().front().get_healing_progress() == 0_turns );
        CHECK_FALSE( hand.has_wounds() );
    }

    SECTION( "reinjury between samples does not inherit dose from the cured wound" ) {
        bodypart &arm = *dude.get_part( body_part_arm_l );
        bodypart &other_arm = *dude.get_part( body_part_arm_r );
        sample_heat( dude, 119, { body_part_hand_l, body_part_hand_r } );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        REQUIRE( other_arm.has_wound( wound_thermal_blister ) );

        const bool natural_healing = GENERATE( false, true );
        if( natural_healing ) {
            arm.update_wounds( arm.get_wounds().front().get_healing_time() );
        } else {
            arm.remove_all_wounds_of_type( wound_thermal_blister );
        }
        REQUIRE_FALSE( arm.has_wounds() );
        dude.apply_thermal_burn( body_part_hand_l, false );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );

        const bool save_before_next_sample = GENERATE( false, true );
        CAPTURE( natural_healing, save_before_next_sample );
        if( save_before_next_sample ) {
            reload_bodypart( arm );
            reload_bodypart( *dude.get_part( body_part_hand_l ) );
        }
        sample_heat( dude, 1, { body_part_hand_l, body_part_hand_r } );
        CHECK( other_arm.has_wound( wound_thermal_burn ) );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        REQUIRE_FALSE( arm.has_wound( wound_thermal_burn ) );

        sample_heat( dude, 118, { body_part_hand_l } );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        sample_heat( dude, 1, { body_part_hand_l } );
        CHECK( arm.has_wound( wound_thermal_burn ) );
        CHECK_FALSE( arm.has_wound( wound_thermal_blister ) );
    }

    SECTION( "replacing the main part before the next sample clears a retained contact's dose" ) {
        sample_heat( dude, 119, { body_part_hand_l, body_part_foot_r } );
        bodypart &old_arm = *dude.get_part( body_part_arm_l );
        const bodypart &right_leg = *dude.get_part( body_part_leg_r );
        REQUIRE( old_arm.has_wound( wound_thermal_blister ) );
        REQUIRE( right_leg.has_wound( wound_thermal_blister ) );

        const bool cure_before_replacement = GENERATE( true, false );
        CAPTURE( cure_before_replacement );
        if( cure_before_replacement ) {
            old_arm.remove_all_wounds_of_type( wound_thermal_blister );
            REQUIRE_FALSE( old_arm.has_wounds() );
        }
        dude.enchantment_cache->force_add( *enchantment_ENCH_TEST_ALT_ARMS, dude );
        dude.recalculate_bodyparts();
        REQUIRE( dude.has_part( body_part_hand_l, body_part_filter::strict ) );
        REQUIRE_FALSE( dude.has_part( body_part_arm_l, body_part_filter::strict ) );
        REQUIRE( dude.thermal_wound_part( body_part_hand_l ) == body_part_test_alt_arm_l );
        const bodypart &new_arm = *dude.get_part( body_part_test_alt_arm_l );

        dude.update_bodytemp( true ); // A retained contact still cannot sample the same turn twice.
        sample_heat( dude, 1, { body_part_hand_l, body_part_foot_r } );
        CHECK( right_leg.has_wound( wound_thermal_burn ) );
        REQUIRE_FALSE( new_arm.has_wounds() );
        sample_heat( dude, 28, { body_part_hand_l } );
        REQUIRE_FALSE( new_arm.has_wounds() );
        sample_heat( dude, 1, { body_part_hand_l } );
        CHECK( new_arm.has_wound( wound_thermal_blister ) );
        CHECK_FALSE( new_arm.has_wound( wound_thermal_burn ) );
    }

    SECTION( "a saturated burn can heal and be followed by a fresh blister" ) {
        bodypart &hand = *dude.get_part( body_part_hand_l );
        bodypart &arm = *dude.get_part( body_part_arm_l );
        sample_heat( dude, 30, { body_part_hand_l } );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        dude.update_wounds( 1_minutes );
        sample_heat( dude, 1, {} );
        sample_heat( dude, 1, { body_part_hand_l } ); // Cross the blister threshold again.
        REQUIRE( arm.get_wounds().size() == 1 );
        CHECK( arm.get_wounds().front().get_healing_progress() == 1_minutes );

        sample_heat( dude, 89, { body_part_hand_l } );
        reload_bodypart( arm );
        reload_bodypart( hand );
        dude.update_bodytemp( true );
        REQUIRE( arm.has_wound( wound_thermal_blister ) );
        sample_heat( dude, 1, { body_part_hand_l } );
        REQUIRE( arm.has_wound( wound_thermal_burn ) );
        REQUIRE( arm.get_wounds().size() == 1 );
        CHECK_FALSE( arm.needs_heat_exposure_reset() );
        const time_duration healing_time = arm.get_wounds().front().get_healing_time();
        dude.update_wounds( healing_time );
        REQUIRE_FALSE( arm.has_wounds() );

        sample_heat( dude, 29, { body_part_hand_l } );
        REQUIRE_FALSE( arm.has_wounds() );
        sample_heat( dude, 1, { body_part_hand_l } );
        CHECK( arm.has_wound( wound_thermal_blister ) );
        CHECK_FALSE( arm.has_wound( wound_thermal_burn ) );
    }
}

TEST_CASE( "data_driven_wound_writes_use_thermal_policy", "[character][limb][thermal_burn]" )
{
    const wound_type_id ordinary( "test_thermal_progression_source" );
    wound_type::load_wounds( json_loader::from_string( R"({
        "id": "test_thermal_progression_source",
        "name": "test ordinary wound",
        "description": "An ordinary wound with a thermal progression.",
        "damage_types": [],
        "damage_required": [ 0, 0 ],
        "healing_time": [ "10 minutes", "10 minutes" ],
        "weight": 0,
        "wound_progression": [ { "id": "thermal_burn", "chance": 100 } ]
    })" ).get_object(), "limb_test" );
    const on_out_of_scope remove_wound_type( [&ordinary]() {
        cata::lua_platform::detail::wound_type_registry().erase( ordinary );
    } );
    REQUIRE( ordinary.is_valid() );

    clear_map_without_vision();
    standard_npc dude( "Thermal policy test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( dude, true );
    bodypart &hand = *dude.get_part( body_part_hand_l );
    const bodypart &arm = *dude.get_part( body_part_arm_l );
    hand.add_wound( ordinary );

    const bool block_thermal = GENERATE( false, true );
    CAPTURE( block_thermal );
    if( block_thermal ) {
        dude.add_effect( effect_incorporeal, 1_minutes );
        REQUIRE( dude.has_effect( effect_incorporeal ) );
    } else {
        REQUIRE( dude.apply_thermal_burn( body_part_hand_l, false ) );
    }

    SECTION( "treatment appends ordinary wounds and applies thermal additions to the main part" ) {
        const wound_fix_id fix( "test_thermal_addition" );
        wound_fix::load_wound_fixes( json_loader::from_string( R"({
            "id": "test_thermal_addition",
            "name": "test treatment",
            "description": "A treatment with ordinary and thermal side effects.",
            "success_msg": "Test treatment finished.",
            "wounds_added": [ "test_thermal_progression_source", "thermal_burn" ]
        })" ).get_object(), "limb_test" );
        const on_out_of_scope remove_fix( [&fix]() {
            cata::lua_platform::detail::wound_fix_registry().erase( fix );
        } );
        REQUIRE( fix.is_valid() );
        const_cast<wound_fix &>( *fix ).finalize();
        fix_wound_activity_actor treatment( 1_turns, body_part_hand_l, ordinary, fix );
        player_activity activity( treatment );
        treatment.finish( activity, dude );
        REQUIRE( hand.get_wounds().size() == 2 );
        CHECK( hand.get_wounds()[0].type == ordinary );
        CHECK( hand.get_wounds()[1].type == ordinary );
    }

    SECTION( "progression only consumes the ordinary wound if a thermal injury occurs" ) {
        const bool direct_part_write = GENERATE( false, true );
        constexpr unsigned int seed = 409971;
        CAPTURE( seed, direct_part_write );
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        rng_set_engine_seed( seed );
        for( int attempt = 0; attempt < 32 && !arm.has_wound( wound_thermal_burn ); ++attempt ) {
            if( direct_part_write ) {
                hand.add_or_worsen_wound( dude, ordinary );
            } else {
                dude.apply_wound( body_part_hand_l, ordinary );
            }
        }
        CHECK_FALSE( hand.has_wound( wound_thermal_burn ) );
        CHECK( hand.has_wound( ordinary ) == block_thermal );
    }

    CHECK_FALSE( arm.has_wound( wound_thermal_blister ) );
    CHECK( arm.has_wound( wound_thermal_burn ) == !block_thermal );
    CHECK( arm.get_wounds().size() == ( block_thermal ? 0 : 1 ) );
}

TEST_CASE( "random_wound_progression_cannot_bypass_heat_mitigation",
           "[character][limb][thermal_burn]" )
{
    const wound_type_id ordinary( "test_raw_heat_wound" );
    const wound_type_id alternate( "test_raw_heat_wound_progressed" );
    wound_type::load_wounds( json_loader::from_string( R"({
        "id": "test_raw_heat_wound_progressed",
        "name": "progressed test wound",
        "description": "An ordinary progression of the test wound.",
        "damage_types": [],
        "damage_required": [ 0, 0 ],
        "healing_time": [ "20 minutes", "20 minutes" ],
        "weight": 0
    })" ).get_object(), "limb_test" );
    wound_type::load_wounds( json_loader::from_string( R"({
        "id": "test_raw_heat_wound",
        "name": "ordinary test wound",
        "description": "A raw-damage candidate with thermal and ordinary progressions.",
        "damage_types": [ "heat" ],
        "damage_required": [ 12, 12 ],
        "healing_time": [ "10 minutes", "10 minutes" ],
        "wound_progression": [
            { "id": "thermal_burn", "chance": 100 },
            { "id": "test_raw_heat_wound_progressed", "chance": 100 }
        ]
    })" ).get_object(), "limb_test" );
    const on_out_of_scope remove_wound_types( [&ordinary, &alternate]() {
        cata::lua_platform::detail::wound_type_registry().erase( ordinary );
        cata::lua_platform::detail::wound_type_registry().erase( alternate );
        cata::lua_platform::detail::refresh_body_part_wound_cache();
    } );
    cata::lua_platform::detail::refresh_body_part_wound_cache();
    REQUIRE( ordinary.is_valid() );
    REQUIRE( alternate.is_valid() );

    clear_map_without_vision();
    standard_npc dude( "Wound progression test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( dude, true );
    const override_option always_wound( "WOUND_CHANCE", "1" );
    const bodypart_id bp = body_part_torso;
    bodypart &part = *dude.get_part( bp );
    const item armor( itype_test_protective_clothing );
    constexpr int raw_heat = 12;
    const int penetrating_heat = GENERATE( 0, 2, 6 );
    const float heat_resist = armor.resist( damage_heat, false, bp );
    REQUIRE( heat_resist >= raw_heat );
    const float penetration = penetrating_heat == 0 ? 0.0f :
                              heat_resist - ( raw_heat - penetrating_heat );
    const damage_instance hit( damage_heat, raw_heat, penetration );

    constexpr unsigned int seed = 465891;
    CAPTURE( seed, penetrating_heat );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    rng_set_engine_seed( seed );
    // Avoid a nested ignition tick and retry the ordinary progression's one-in-two roll.
    dude.add_effect( effect_onfire, 1_turns, bp, false, 0, false, true );
    for( int attempt = 0; attempt < 32 && !part.has_wound( alternate ); ++attempt ) {
        CAPTURE( attempt );
        dude.clear_worn();
        REQUIRE( dude.wear_item( armor, false ).has_value() );
        part.set_hp_to_max();
        part.remove_all_wounds_of_type( ordinary );
        part.add_wound( ordinary );

        const dealt_damage_instance dealt = dude.deal_damage( nullptr, bp, hit );
        REQUIRE( dealt.type_damage( damage_heat ) == penetrating_heat );
        REQUIRE_FALSE( part.has_wound( wound_thermal_burn ) );
        CHECK( part.has_wound( wound_thermal_blister ) == ( penetrating_heat >= 4 ) );
    }
    REQUIRE( part.has_wound( alternate ) );
    CHECK_FALSE( part.has_wound( ordinary ) );
    CHECK( part.get_wound( alternate )->get_healing_time() == 30_minutes );
}

TEST_CASE( "Gaining_losing_limbs", "[limb]" )
{
    standard_npc dude( "Test NPC" );
    clear_character( dude, true );
    static std::vector<bodypart_id> base_parts = dude.get_all_body_parts();
    REQUIRE( base_parts.size() == 12 );
    // Gain a tail and re-check
    dude.toggle_trait( trait_DEBUG_TAIL );
    REQUIRE( dude.has_trait( trait_DEBUG_TAIL ) );
    CHECK( dude.get_all_body_parts().size() == 13 );

    // Lose trait and lose the tail
    dude.toggle_trait( trait_DEBUG_TAIL );
    REQUIRE( !dude.has_trait( trait_DEBUG_TAIL ) );
    CHECK( dude.get_all_body_parts().size() == 12 );

    // Lose every limb aside from the head
    dude.toggle_trait( trait_DEBUG_ONLY_HEAD );
    REQUIRE( dude.has_trait( trait_DEBUG_ONLY_HEAD ) );
    CHECK( dude.get_all_body_parts().size() == 3 );
    REQUIRE( dude.has_part( body_part_head ) );

    // Turn our head into a big head
    dude.toggle_trait( trait_DEBUG_BIG_HEAD );
    CHECK( dude.get_all_body_parts().size() == 3 );
    REQUIRE( !dude.has_part( body_part_head ) );
}

TEST_CASE( "limb_conditional_flags", "[character][encumbrance][limb]" )
{
    standard_npc dude( "Test NPC" );
    item wing_cover_left( itype_test_winglets_left );
    create_bird_char( dude );
    // Flags are recognized and counted correctly
    REQUIRE( dude.has_bodypart_with_flag( json_flag_WALL_CLING ) );
    REQUIRE( dude.count_flag( json_flag_WALL_CLING ) == 2 );

    // Damage the right wing below its health limit, disabling one instance of the flag
    dude.set_part_hp_cur( body_part_test_bird_wing_r, 10 );
    CHECK( dude.has_bodypart_with_flag( json_flag_WALL_CLING ) );
    CHECK( dude.count_flag( json_flag_WALL_CLING ) == 1 );

    // Encumber the left wing above its enc limit, disabling all flags
    dude.wear_item( wing_cover_left, false );
    REQUIRE( dude.get_part_encumbrance( body_part_test_bird_wing_l ) >= 15 );
    CHECK( !dude.has_bodypart_with_flag( json_flag_WALL_CLING ) );
    CHECK( dude.count_flag( json_flag_WALL_CLING ) == 0 );

    // Reset our right wing, flag still is enabled again
    dude.set_part_hp_cur( body_part_test_bird_wing_r, 100 );
    CHECK( dude.count_flag( json_flag_WALL_CLING ) == 1 );
    // Disable it with a windage effect
    dude.add_effect( effect_winded_arm, 1_hours, body_part_test_bird_wing_r, false, 1, true );
    REQUIRE( dude.get_effects_with_flag( flag_EFFECT_LIMB_DISABLE_CONDITIONAL_FLAGS ).size() == 1 );
    CHECK( dude.count_flag( json_flag_WALL_CLING ) == 0 );

}

TEST_CASE( "Limb_ugliness_calculations", "[character][npc][limb]" )
{
    standard_npc dude( "Test NPC" );
    standard_npc beholder( "Beholder" );
    item wing_covers( itype_test_winglets );
    // We start at +/- 3 because of being unarmed
    REQUIRE( beholder.get_opinion_values( dude ).fear == -3 );
    REQUIRE( beholder.get_opinion_values( dude ).trust == 3 );

    //Fear gets increased by half of ugliness total, trust decreased by a third
    // But there are knock-on effects from +fear leading to -trust
    create_bird_char( dude );
    CHECK( beholder.get_opinion_values( dude ).fear == 39 );
    CHECK( beholder.get_opinion_values( dude ).trust == -25 );

    // TODO: fix covered ugliness and test it...
}

TEST_CASE( "Healing/mending_bonuses", "[character][limb]" )
{
    standard_npc dude( "Test NPC" );
    clear_character( dude, true );
    dude.enchantment_cache->force_add( *enchantment_ENCH_TEST_LIZARD_TAIL, dude );
    dude.recalculate_bodyparts();
    REQUIRE( dude.has_part( body_part_test_lizard_tail ) );
    SECTION( "Heal override and heal bonus" ) {
        dude.set_part_hp_cur( body_part_test_lizard_tail, 10 );
        REQUIRE( dude.get_part_hp_cur( body_part_test_lizard_tail ) < dude.get_part_hp_max(
                     body_part_test_lizard_tail ) );
        dude.regen( to_turns<int>( 5_minutes ) );
        CHECK( dude.get_part_hp_cur( body_part_test_lizard_tail ) == 11 );
    }
    SECTION( "Mend override" ) {
        dude.set_part_hp_cur( body_part_test_lizard_tail, 0 );
        dude.set_part_hp_cur( body_part_arm_l, 0 );
        REQUIRE( dude.is_limb_broken( body_part_test_lizard_tail ) );
        REQUIRE( dude.is_limb_broken( body_part_arm_l ) );
        dude.mend( to_turns<int>( 5_minutes ) );
        CHECK( dude.has_effect( effect_mending, body_part_test_lizard_tail ) );
        CHECK( !dude.has_effect( effect_mending, body_part_arm_l ) );
    }
}

TEST_CASE( "drying_rate", "[character][limb]" )
{
    clear_map_without_vision();
    map &here = get_map();
    standard_npc dude( "Test NPC" );
    clear_character( dude, true );

    set_time_to_day();
    const weather_manager &weather = get_weather();
    w_point &weather_point = *weather.weather_precise;
    scoped_weather_override weather_clear( WEATHER_CLEAR );
    restore_on_out_of_scope restore_temp( weather_point.temperature );
    weather_point.temperature = units::from_fahrenheit( 65 );
    restore_on_out_of_scope restore_humidity( weather_point.humidity );
    weather_point.humidity = 66.0f;

    CAPTURE( weather.weather_id.c_str() );
    CAPTURE( units::to_fahrenheit( weather_point.temperature ) );
    CAPTURE( weather_point.humidity );

    REQUIRE( here.ter( dude.pos_bub() ).id() == ter_t_grass );
    REQUIRE( here.furn( dude.pos_bub() ).id() == furn_str_id::NULL_ID() );

    REQUIRE( body_part_arm_l->drying_rate == 1.0f );
    dude.drench( 100, dude.get_drenching_body_parts(), false );
    REQUIRE( dude.get_part_wetness( body_part_arm_l ) == 200 );

    // Baseline arm dries in 450ish turns
    int base_dry = 0;
    while( dude.get_part_wetness( body_part_arm_l ) > 0 ) {
        dude.update_body_wetness( weather_point );
        base_dry++;
    }
    // 200 wetness / (1000 drench cap / ~1800 turns ) = 360
    REQUIRE( base_dry == Approx( 360 ).margin( 120 ) );

    // Birdify, clear water
    clear_character( dude, true );
    create_bird_char( dude );
    REQUIRE( here.ter( dude.pos_bub() ).id() == ter_t_grass );
    REQUIRE( here.furn( dude.pos_bub() ).id() == furn_str_id::NULL_ID() );
    REQUIRE( body_part_test_bird_wing_l->drying_rate == 2.0f );
    REQUIRE( body_part_test_bird_wing_r->drying_rate == 0.5f );
    REQUIRE( dude.get_part_wetness( body_part_test_bird_wing_l ) == 0 );
    REQUIRE( dude.get_part_wetness( body_part_test_bird_wing_r ) == 0 );
    dude.drench( 100, dude.get_drenching_body_parts(), false );
    REQUIRE( dude.get_part_wetness( body_part_test_bird_wing_l ) == 200 );
    REQUIRE( dude.get_part_wetness( body_part_test_bird_wing_r ) == 200 );

    int high_dry = 0;
    int low_dry = 0;
    // Filter on the slower drying limb
    while( dude.get_part_wetness( body_part_test_bird_wing_r ) > 0 ) {
        dude.update_body_wetness( weather_point );
        if( dude.get_part_wetness( body_part_test_bird_wing_l ) > 0 ) {
            high_dry++;
        }
        low_dry++;
    }

    // A drying rate of 2 should halve the drying time
    // Higher margin for the lower rate to account for the randomness
    // 200 wetness / (1000 drench cap / ~(1800/2) turns) = 180
    CHECK( high_dry == Approx( 180 ).margin( 60 ) );
    // 200 wetness / (1000 drench cap / ~(1800*2) turns) = 720
    CHECK( low_dry == Approx( 720 ).margin( 240 ) );
}

TEST_CASE( "Limb_consumption", "[limb]" )
{
    standard_npc dude( "Test NPC" );
    const item solid( itype_test_pine_nuts );
    const item liquid( itype_test_liquid );
    clear_character( dude, true );
    // Normal chars are normal
    REQUIRE( dude.get_modifier( character_modifier_liquid_consume_mod ) == 1.0f );
    REQUIRE( dude.get_modifier( character_modifier_solid_consume_mod ) == 1.0f );
    const time_duration base_solid = dude.get_consume_time( solid );
    const time_duration base_liquid = dude.get_consume_time( liquid );
    create_bird_char( dude );
    // Testbird chars are birdy
    REQUIRE( dude.get_modifier( character_modifier_liquid_consume_mod ) == 2.0f );
    REQUIRE( dude.get_modifier( character_modifier_solid_consume_mod ) == 0.5f );
    CHECK( dude.get_consume_time( liquid ) == base_liquid * 2 );
    CHECK( dude.get_consume_time( solid ) == base_solid / 2 );
}
TEST_CASE( "Limb_armor_coverage", "[character][limb][armor]" )
{
    standard_npc dude( "Test NPC" );
    item test_shackles( itype_test_shackles );
    item test_jumpsuit_cotton( itype_test_jumpsuit_cotton );
    item wing_covers( itype_test_winglets );
    item bird_boots( itype_test_bird_boots );

    REQUIRE( test_jumpsuit_cotton.covers( body_part_arm_l ) );
    REQUIRE( test_jumpsuit_cotton.portion_for_bodypart( body_part_arm_l )->coverage == 95 );

    clear_character( dude, true );
    create_bird_char( dude );
    REQUIRE( dude.has_part( body_part_test_bird_wing_l ) );
    REQUIRE( dude.has_part( body_part_test_bird_wing_r ) );
    REQUIRE( body_part_test_bird_wing_l->similar_bodypart.has_value() );
    REQUIRE( body_part_test_bird_wing_r->similar_bodypart.has_value() );

    // Explicitly-defined armor covers custom limbs
    CHECK( wing_covers.covers( body_part_test_bird_wing_l ) );
    CHECK( wing_covers.portion_for_bodypart( body_part_test_bird_wing_l )->coverage == 100 );

    // Armor covering a base BP covers derived bodyparts, but not non-derived ones
    CHECK( test_shackles.covers( body_part_test_bird_wing_l ) );
    CHECK( test_shackles.covers( body_part_test_bird_wing_r ) );
    CHECK( test_shackles.portion_for_bodypart( body_part_test_bird_wing_l )->coverage == 100 );
    CHECK( test_shackles.portion_for_bodypart( body_part_test_bird_wing_r )->coverage == 100 );
    CHECK( !test_jumpsuit_cotton.covers( body_part_test_bird_wing_l ) );

    // Sublimb substitution works the same
    CHECK( bird_boots.covers( sub_body_part_sub_limb_test_bird_foot_l ) );
    CHECK( bird_boots.covers( sub_body_part_sub_limb_test_bird_foot_r ) );
    CHECK( bird_boots.portion_for_bodypart( sub_body_part_sub_limb_test_bird_foot_l )->coverage ==
           100 );
    CHECK( bird_boots.portion_for_bodypart( sub_body_part_sub_limb_test_bird_foot_r )->coverage ==
           100 );
    // Backwards population of coverage works as well
    CHECK( bird_boots.covers( body_part_test_bird_foot_l ) );
    CHECK( bird_boots.covers( body_part_test_bird_foot_r ) );
}

TEST_CASE( "get_avg_coverage_filters_phantom_limbs", "[character][limb][armor]" )
{
    item test_shackles( itype_test_shackles );

    SECTION( "fixture wiring" ) {
        // Partial wing picked up via similar_bodypart with scaled coverage
        REQUIRE( test_shackles.covers( body_part_test_partial_wing_l ) );
        REQUIRE( test_shackles.portion_for_bodypart( body_part_test_partial_wing_l ) );
        REQUIRE( test_shackles.portion_for_bodypart(
                     body_part_test_partial_wing_l )->coverage == 25 );
    }

    SECTION( "default human sees only own body parts" ) {
        clear_avatar();
        // Default filters by player character (human) - only arm_l/r match
        CHECK( test_shackles.get_avg_coverage() == 100 );

        item longshirt( itype_test_longshirt );
        CHECK( longshirt.get_avg_coverage() == 90 );
    }

    SECTION( "bird character with explicit body_part_set" ) {
        standard_npc dude( "Test NPC" );
        create_bird_char( dude );
        body_part_set bird_parts;
        bird_parts.fill( dude.get_all_body_parts() );

        // Bird has arm_l/r(100) and test_bird_wing_l/r(100) from this item
        CHECK( test_shackles.get_avg_coverage( bird_parts ) == 100 );
    }

    SECTION( "alt-arm character" ) {
        clear_avatar();
        Character &viewer = get_player_character();
        viewer.enchantment_cache->force_add( *enchantment_ENCH_TEST_ALT_ARMS, viewer );
        viewer.recalculate_bodyparts();
        REQUIRE( viewer.has_part( body_part_test_alt_arm_l ) );

        item longshirt( itype_test_longshirt );
        // Default uses player character which now has alt arms
        CHECK( longshirt.get_avg_coverage() == 90 );
    }
}
