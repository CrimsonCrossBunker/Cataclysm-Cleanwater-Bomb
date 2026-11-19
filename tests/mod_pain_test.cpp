#include <algorithm>
#include <functional>
#include <memory>
#include <optional>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bionics.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "dialogue.h"
#include "effect.h"
#include "effect_on_condition.h"
#include "enums.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_content.h"
#include "map.h"
#include "map_helpers.h"
#include "math_parser.h"
#include "monster.h"
#include "npc.h"
#include "npctalk.h"
#include "player_helpers.h"
#include "rng.h"
#include "talker.h"
#include "type_id.h"
#include "uistate.h"
#include "units.h"
#include "wound.h"

static const efftype_id effect_electrokinetic_pain_immune( "effect_electrokinetic_pain_immune" );
static const efftype_id effect_electrokinetic_speed_boost( "effect_electrokinetic_speed_boost" );
static const efftype_id effect_lucid_dream( "effect_lucid_dream" );
static const efftype_id effect_pain_relief( "pain_relief" );
static const efftype_id effect_sleep( "sleep" );
static const wound_type_id wound_thermal_burn( "thermal_burn" );
static const efftype_id effect_wet( "wet" );

namespace
{
void run_pain_test_effect( dialogue &d, const char *source )
{
    talk_effect_t action;
    action.parse_sub_effect( json_loader::from_string( source ).get_object(), "TEST_DATA" );
    for( const talk_effect_fun_t &operation : action.effects ) {
        operation( d );
    }
}

struct pain_test_loss_observer : event_subscriber {
    using event_subscriber::notify;

    explicit pain_test_loss_observer( const Character &target, const efftype_id &id = effect_wet ) :
        who( target.getID() ), watched( id ) {
        get_event_bus().subscribe( this );
    }

    void notify( const cata::event &event ) override {
        if( event.type() == event_type::character_loses_effect &&
            event.get<character_id>( "character" ) == who &&
            event.get<efftype_id>( "effect" ) == watched ) {
            parts.push_back( event.get<bodypart_id>( "bodypart" ) );
            if( on_loss ) {
                on_loss();
            }
        }
    }

    character_id who;
    efftype_id watched;
    std::vector<bodypart_id> parts;
    std::function<void()> on_loss;
};
} // namespace

TEST_CASE( "pain_delta_uses_native_effect_loss_targeting", "[eoc][mod_pain][pain_transition]" )
{
    npc target;
    target.normalize();
    target.setID( character_id( 18001 ), true );
    target.set_sensitive( 100 );
    dialogue d( nullptr, get_talker_for( target ) );
    pain_test_loss_observer observer( target );

    SECTION( "ALL issues the same part events as an ordinary talker removal" ) {
        const auto add_effects = [&target]() {
            for( bodypart_id bp : { bodypart_id(), body_part_arm_l.id(), body_part_arm_r.id() } ) {
                target.add_effect( effect_wet, 5_minutes, bp, false, 1, true );
            }
        };
        add_effects();
        run_pain_test_effect( d, R"({"npc_lose_effect":"wet","target_part":"ALL"})" );
        const std::vector<bodypart_id> expected = observer.parts;
        observer.parts.clear();
        REQUIRE( expected.size() == 3 );
        CHECK( expected.back() == bodypart_id() );
        add_effects();

        run_pain_test_effect( d, R"({"npc_lose_effect":"wet","target_part":"ALL","pain_delta":7})" );
        CHECK( observer.parts == expected );
        CHECK_FALSE( target.has_effect( effect_wet ) );
        CHECK( target.Creature::get_pain() == 7 );
    }
    SECTION( "RANDOM draws one normal main body part, not one of the affected parts" ) {
        const bool matches = GENERATE( false, true );
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        rng_get_engine().seed( 18001 );
        const auto seed = rng_get_engine();
        const bodypart_id selected = target.random_body_part( true );
        const bodypart_id affected = matches ? selected :
                                     selected == body_part_arm_l.id() ? body_part_arm_r.id() : body_part_arm_l.id();
        target.add_effect( effect_wet, 5_minutes, affected, false, 1, true );
        target.add_effect( effect_wet, 5_minutes, bodypart_id(), false, 1, true );
        rng_get_engine() = seed;

        run_pain_test_effect( d, R"({"npc_lose_effect":"wet","target_part":"RANDOM","pain_delta":7})" );
        CHECK( observer.parts.size() == ( matches ? 1 : 0 ) );
        if( matches ) {
            REQUIRE_FALSE( observer.parts.empty() );
            CHECK( observer.parts.front() == selected );
        }
        CHECK( target.has_effect( effect_wet, affected ) == !matches );
        CHECK_FALSE( target.get_effect( effect_wet ).is_null() );
        CHECK( target.Creature::get_pain() == ( matches ? 7 : 0 ) );
    }
}

TEST_CASE( "pain_delta_is_not_reapplied_after_reentrant_loss", "[eoc][mod_pain][pain_transition]" )
{
    npc target;
    target.normalize();
    target.setID( character_id( 18002 ), true );
    target.set_sensitive( 100 );
    target.add_effect( effect_sleep, 1_hours );
    target.add_effect( effect_wet, 5_minutes, body_part_arm_l, false, 1, true );
    dialogue d( nullptr, get_talker_for( target ) );
    pain_test_loss_observer observer( target );
    const bool nested_delta = GENERATE( false, true );
    constexpr const char *loss = R"({"npc_lose_effect":"wet","target_part":"arm_l","pain_delta":1})";
    observer.on_loss = [&d, &observer, nested_delta, loss]() {
        if( observer.parts.size() == 1 ) {
            run_pain_test_effect( d, nested_delta ? loss : R"({"npc_lose_effect":"wet","target_part":"arm_l"})" );
        }
    };
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto before = rng_get_engine();
    if( nested_delta ) {
        rng( 3, 5 );
    }
    const auto expected_rng = rng_get_engine();
    rng_get_engine() = before;

    run_pain_test_effect( d, loss );
    CHECK_FALSE( target.has_effect( effect_wet ) );
    CHECK( target.Creature::get_pain() == ( nested_delta ? 1 : 0 ) );
    CHECK( rng_get_engine() == expected_rng );
    CHECK( target.get_effect_dur( effect_sleep ) == 1_hours );
}

TEST_CASE( "pain_delta_ALL_stops_if_a_loss_callback_destroys_the_character",
           "[eoc][mod_pain][pain_transition]" )
{
    auto target = std::make_unique<npc>();
    target->normalize();
    target->setID( character_id( 18003 ), true );
    target->add_effect( effect_wet, 5_minutes, body_part_arm_l, false, 1, true );
    target->add_effect( effect_wet, 5_minutes, body_part_arm_r, false, 1, true );
    dialogue d( nullptr, get_talker_for( *target ) );
    pain_test_loss_observer observer( *target );
    observer.on_loss = [&target]() {
        target.reset();
    };

    run_pain_test_effect( d, R"({"npc_lose_effect":"wet","target_part":"ALL","pain_delta":7})" );
    CHECK_FALSE( target );
    CHECK( observer.parts == std::vector<bodypart_id> { body_part_arm_l.id() } );
}

TEST_CASE( "pain_delta_combines_relief_loss_with_the_base_change",
           "[eoc][mod_pain][pain_transition]" )
{
    npc target;
    target.normalize();
    target.set_sensitive( 100 );
    target.set_pain( 10 );
    target.add_effect( effect_pain_relief, 5_minutes, false, 10 );
    target.add_effect( effect_sleep, 1_hours );
    REQUIRE( target.get_perceived_pain() == 0 );
    dialogue d( nullptr, get_talker_for( target ) );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto before = rng_get_engine();
    rng( 3, 5 );
    const auto after_one_wake_check = rng_get_engine();
    rng_get_engine() = before;

    run_pain_test_effect( d, R"({"npc_lose_effect":"pain_relief","pain_delta":-8})" );
    CHECK_FALSE( target.has_effect( effect_pain_relief ) );
    CHECK( target.Creature::get_pain() == 2 );
    CHECK( target.get_perceived_pain() == 2 );
    CHECK( target.get_effect_dur( effect_sleep ) == 1_hours );
    CHECK( rng_get_engine() == after_one_wake_check );
}

TEST_CASE( "pain_delta_preserves_a_same_key_replacement",
           "[eoc][mod_pain][pain_transition]" )
{
    npc target;
    target.normalize();
    target.setID( character_id( 18004 ), true );
    target.set_sensitive( 100 );
    target.add_effect( effect_wet, 5_minutes, body_part_arm_l, false, 1, true );
    target.add_effect( effect_sleep, 1_hours );
    dialogue d( nullptr, get_talker_for( target ) );
    pain_test_loss_observer observer( target );
    observer.on_loss = [&target, &d, &observer]() {
        if( observer.parts.size() == 1 ) {
            run_pain_test_effect( d, R"({"npc_lose_effect":"wet","target_part":"arm_l","pain_delta":1})" );
            target.add_effect( effect_wet, 2_minutes, body_part_arm_l, false, 2, true );
        }
    };
    const char *loss = GENERATE( R"({"npc_lose_effect":"wet","target_part":"arm_l","pain_delta":10})",
                                R"({"npc_lose_effect":"wet","target_part":"ALL","pain_delta":10})",
                                R"({"npc_lose_effect":"wet","pain_delta":10})" );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto before = rng_get_engine();
    rng( 3, 5 );
    const auto after_one_wake_check = rng_get_engine();
    rng_get_engine() = before;

    run_pain_test_effect( d, loss );
    CHECK( observer.parts.size() == 2 );
    CHECK( target.get_effect_dur( effect_wet, body_part_arm_l ) == 2_minutes );
    CHECK( target.get_effect_int( effect_wet, body_part_arm_l ) == 2 );
    CHECK( target.Creature::get_pain() == 1 );
    CHECK( target.get_effect_dur( effect_sleep ) == 1_hours );
    CHECK( rng_get_engine() == after_one_wake_check );
}

TEST_CASE( "losing_whole_body_analgesia_reveals_felt_pain",
           "[character][mod_pain][pain_transition]" )
{
    const efftype_id thermal_relief( "test_thermal_pain_transition" );
    const efftype_id thermal_ceiling( "test_thermal_pain_ceiling_transition" );
    const efftype_id ceiling( "pain_ceiling" );
    load_effect_type( json_loader::from_string( R"({
        "id": "test_thermal_pain_transition",
        "name": [ "" ],
        "desc": [ "" ],
        "flags": [ "THERMAL_PAIN_RELIEF" ],
        "max_intensity": 10,
        "int_decay_tick": 1,
        "int_decay_step": -8
    })" ).get_object(), "TEST_DATA" );
    load_effect_type( json_loader::from_string( R"({
        "id": "test_thermal_pain_ceiling_transition",
        "name": [ "" ],
        "desc": [ "" ],
        "flags": [ "THERMAL_PAIN_CEILING" ],
        "max_intensity": 10
    })" ).get_object(), "TEST_DATA" );
    const on_out_of_scope cleanup( [&]() {
        cata::lua_platform::detail::effect_type_registry_erase( thermal_relief.str() );
        cata::lua_platform::detail::effect_type_registry_erase( thermal_ceiling.str() );
    } );

    enum class modifier_source : int { relief, ceiling, thermal_relief, thermal_ceiling };
    const modifier_source source = GENERATE( modifier_source::relief, modifier_source::ceiling,
                                   modifier_source::thermal_relief, modifier_source::thermal_ceiling );
    const bool limited_by_ceiling = source == modifier_source::ceiling ||
                                    source == modifier_source::thermal_ceiling;
    const bool thermal_only = source == modifier_source::thermal_relief ||
                              source == modifier_source::thermal_ceiling;
    const efftype_id &modifier = source == modifier_source::thermal_ceiling ? thermal_ceiling :
                                 source == modifier_source::thermal_relief ? thermal_relief :
                                 limited_by_ceiling ? ceiling : effect_pain_relief;
    const int masked_pain = limited_by_ceiling ? 1 : 0;
    CAPTURE( modifier.str() );
    standard_npc target( "Pain modifier test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( target, true );
    const trait_id masochist( "MASOCHIST" );
    const morale_type masochist_morale( "morale_perm_masochist" );
    target.toggle_trait( masochist );
    target.set_sensitive( 100 );
    REQUIRE( target.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( target.has_morale( masochist_morale ) == 10 );
    target.add_effect( modifier, 1_turns, false, limited_by_ceiling ? 1 : 10 );
    target.add_effect( effect_sleep, 1_hours );
    REQUIRE( target.get_perceived_pain() == masked_pain );
    REQUIRE( target.has_morale( masochist_morale ) == target.get_perceived_pain() );
    REQUIRE( target.get_effect_dur( effect_sleep ) == 1_hours );

    SECTION( "normal effect expiry updates morale and wakes the sleeper" ) {
        // Expiry names the exact whole-body record, not a bulk type removal.
        const bodypart_id sibling = body_part_arm_r;
        target.add_effect( modifier, 5_minutes, sibling, true, 1, true );
        effect &sibling_effect = target.get_effect( modifier, sibling );
        // A permanent, max-duration sibling cannot independently decay to zero.
        sibling_effect.set_duration( sibling_effect.get_max_duration() );
        target.Creature::process_effects();
        // Thermal analgesia stops at zero duration; the two general modifiers
        // remain active until their record is erased on the next decay pass.
        CHECK( target.get_perceived_pain() == ( thermal_only ? 10 : masked_pain ) );
        CHECK( target.has_morale( masochist_morale ) == target.get_perceived_pain() );
        CHECK( target.get_effect_dur( effect_sleep ) == ( thermal_only ? 0_turns :
                1_hours - 1_turns ) );
        target.Creature::process_effects();
        CHECK( target.get_effect( modifier ).is_null() );
        CHECK( target.has_effect( modifier, sibling ) );
        CHECK( target.get_perceived_pain() == 10 );
        CHECK( target.has_morale( masochist_morale ) == 10 );
        CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
    }
    SECTION( "reducing potency on refresh reacts to the felt increase" ) {
        target.add_effect( modifier, 5_minutes, false, limited_by_ceiling ? 8 : 2 );
        CHECK( target.get_perceived_pain() == 8 );
        CHECK( target.has_morale( masochist_morale ) == 8 );
        CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
    }
    SECTION( "explicit removal also reveals the remaining pain" ) {
        REQUIRE( target.remove_effect( modifier ) );
        CHECK( target.get_perceived_pain() == 10 );
        CHECK( target.has_morale( masochist_morale ) == 10 );
        CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
    }
    if( source == modifier_source::thermal_relief ) {
        SECTION( "intensity can decay while the relief remains active" ) {
            target.get_effect( modifier ).set_duration( 2_turns );
            target.Creature::process_effects();
            CHECK( target.get_effect_dur( modifier ) == 1_turns );
            CHECK( target.get_perceived_pain() == 8 );
            CHECK( target.has_morale( masochist_morale ) == 8 );
            CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
        }
    }
    CHECK( target.get_pain() == 10 );
    CHECK( target.Creature::get_pain() == 0 );
}

TEST_CASE( "only_losing_the_last_pain_immunity_effect_reveals_thermal_pain",
           "[character][mod_pain][pain_transition]" )
{
    const efftype_id immunity( "test_pain_immunity_transition" );
    load_effect_type( json_loader::from_string( R"({
        "id": "test_pain_immunity_transition",
        "name": [ "" ],
        "desc": [ "" ],
        "flags": [ "PAIN_IMMUNE" ]
    })" ).get_object(), "TEST_DATA" );
    const on_out_of_scope cleanup( [&immunity]() {
        cata::lua_platform::detail::effect_type_registry_erase( immunity.str() );
    } );

    standard_npc target( "Pain immunity test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( target, true );
    const morale_type masochist_morale( "morale_perm_masochist" );
    target.toggle_trait( trait_id( "MASOCHIST" ) );
    target.set_sensitive( 100 );
    REQUIRE( target.apply_thermal_burn( body_part_arm_l, true ) );
    target.add_effect( immunity, 1_turns );
    target.add_effect( immunity, 5_minutes, body_part_arm_r );
    target.add_effect( effect_sleep, 1_hours );
    REQUIRE( target.get_perceived_pain() == 0 );
    REQUIRE( target.has_morale( masochist_morale ) == 0 );

    SECTION( "removing one source leaves the other until its exact expiry" ) {
        REQUIRE( target.remove_effect( immunity, body_part_arm_r ) );
        REQUIRE( target.get_perceived_pain() == 0 );
        REQUIRE( target.get_effect_dur( effect_sleep ) == 1_hours );
        REQUIRE( target.Creature::process_effects() );
        REQUIRE( target.get_perceived_pain() == 0 );
        REQUIRE( target.Creature::process_effects() );
    }
    SECTION( "expiry of the whole-body source leaves the localized source" ) {
        REQUIRE( target.Creature::process_effects() );
        REQUIRE( target.Creature::process_effects() );
        REQUIRE( target.get_effect( immunity ).is_null() );
        REQUIRE( target.get_perceived_pain() == 0 );
        REQUIRE( target.get_effect_dur( effect_sleep ) == 1_hours - 2_turns );
        REQUIRE( target.remove_effect( immunity, body_part_arm_r ) );
    }
    CHECK_FALSE( target.has_effect( immunity ) );
    CHECK( target.get_perceived_pain() == 10 );
    CHECK( target.has_morale( masochist_morale ) == 10 );
    CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
    CHECK( target.Creature::get_pain() == 0 );
}

TEST_CASE( "stale_analgesia_expiry_preserves_the_live_effect",
           "[character][mod_pain][pain_transition]" )
{
    npc target;
    target.normalize();
    target.setID( character_id( 18005 ), true );
    target.set_sensitive( 100 );
    target.set_pain( 10 );
    target.add_effect( effect_pain_relief, 1_turns, false, 10 );
    target.add_effect( effect_sleep, 1_hours );

    // Cold expires first in the ordered effect map and dispatches a loss event.
    const efftype_id cold( "cold" );
    const bodypart_id part = body_part_arm_l;
    target.add_effect( cold, 1_turns, part, false, 1, true );
    target.Creature::process_effects();
    REQUIRE( target.get_effect_dur( cold, part ) == 0_turns );
    REQUIRE( target.get_effect_dur( effect_pain_relief ) == 0_turns );
    REQUIRE( target.get_perceived_pain() == 0 );

    const bool replace = GENERATE( false, true );
    pain_test_loss_observer observer( target, cold );
    observer.on_loss = [&target, replace]() {
        if( replace ) {
            REQUIRE( target.remove_effect( effect_pain_relief ) );
        }
        target.add_effect( effect_pain_relief, 5_minutes, false, 10 );
    };
    target.Creature::process_effects();

    CHECK( observer.parts == std::vector<bodypart_id>{ part } );
    CHECK_FALSE( target.has_effect( cold, part ) );
    CHECK( target.get_effect_dur( effect_pain_relief ) == 5_minutes );
    CHECK( target.get_perceived_pain() == 0 );
    CHECK( target.get_effect_dur( effect_sleep ) == 1_hours - 2_turns );
}

TEST_CASE( "analgesia_expiry_can_invalidate_an_npc_during_a_native_turn",
           "[character][mod_pain][pain_transition]" )
{
    clear_map_without_vision();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_turns;
    auto target = std::make_unique<standard_npc>( "Analgesia expiry test NPC",
                  tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( *target, true );
    target->set_sleepiness( 100 );
    target->set_sensitive( 100 );
    target->set_pain( 10 );
    target->add_effect( effect_pain_relief, 1_turns, false, 10 );
    target->add_effect( effect_sleep, 1_hours );
    REQUIRE( target->Creature::process_effects() );
    REQUIRE( target->get_effect_dur( effect_pain_relief ) == 0_turns );
    REQUIRE( target->get_perceived_pain() == 0 );
    REQUIRE( target->get_effect_dur( effect_sleep ) > 1_turns );

    struct wake_observer : event_subscriber {
        using event_subscriber::notify;

        std::unique_ptr<standard_npc> &target;
        character_id id;

        explicit wake_observer( std::unique_ptr<standard_npc> &value ) :
            target( value ), id( value->getID() ) {
            get_event_bus().subscribe( this );
        }

        void notify( const cata::event &e ) override {
            if( e.type() == event_type::character_wakes_up && e.get<character_id>( "character" ) == id ) {
                target.reset();
            }
        }
    } observer( target );
    CHECK_FALSE( target->process_turn() );
    CHECK_FALSE( target );
}

TEST_CASE( "character_pain_modifiers_do_not_change_monster_pain",
           "[monster][mod_pain][pain_transition]" )
{
    monster target( mtype_id( "mon_zombie" ) );
    target.set_pain( 20 );
    const efftype_id ceiling( "pain_ceiling" );
    target.add_effect( ceiling, 5_minutes, false, 5 );
    target.add_effect( effect_pain_relief, 5_minutes, false, 10 );
    REQUIRE( target.has_effect( ceiling ) );
    REQUIRE( target.has_effect( effect_pain_relief ) );
    CHECK( target.get_perceived_pain() == 20 );

    dialogue d( nullptr, get_talker_for( target ) );
    run_pain_test_effect( d, R"({"npc_lose_effect":"pain_relief","pain_delta":7})" );
    CHECK( target.has_effect( effect_pain_relief ) );
    CHECK( target.get_pain() == 20 );
}

TEST_CASE( "xedra_lucid_dream_restores_base_pain_and_thermal_injuries",
           "[.][mods][mod_pain][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    REQUIRE( effect_lucid_dream.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    u.setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    u.update_wounds( 2_minutes );
    u.set_pain( 17 );
    const bodypart &left = *u.get_part( body_part_arm_l );
    REQUIRE( left.has_wound( wound_thermal_burn ) );
    const int original_pain = u.get_pain();
    REQUIRE( original_pain > 17 );

    u.add_effect( effect_lucid_dream, 5_minutes );
    REQUIRE( u.has_effect( effect_lucid_dream ) );
    REQUIRE( u.apply_thermal_burn( body_part_hand_r, true ) );
    u.set_pain( 57 );
    u.update_wounds( 1_days );
    const bodypart &right = *u.get_part( body_part_arm_r );

    SECTION( "waking reverses both the dream injury and dream healing" ) {
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        CHECK( u.get_pain() == original_pain );
        REQUIRE( left.has_wound( wound_thermal_burn ) );
        CHECK( left.get_wounds().front().get_healing_progress() == 2_minutes );
        CHECK_FALSE( right.has_wounds() );
    }
    SECTION( "old saves lack a thermal baseline" ) {
        u.remove_value( "thermal_snapshot:xedra_lucid_dream" );
        REQUIRE( u.remove_effect( effect_lucid_dream ) );
        REQUIRE( left.has_wound( wound_thermal_burn ) );
        CHECK( left.get_wounds().front().get_healing_progress() == 1_days + 2_minutes );
        CHECK( right.has_wound( wound_thermal_burn ) );
    }
    CHECK( u.Creature::get_pain() == 17 );
}

TEST_CASE( "xedra_verdant_vitality_spends_leftover_relief_on_burns",
           "[.][mods][mod_pain][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    const effect_on_condition_id verdant( "EOC_CHANGELING_SPRING_MINOR_RESTORE_STAMINA_AND_PAIN" );
    const efftype_id relief( "effect_changeling_spring_verdant_vitality_relief" );
    REQUIRE( verdant.is_valid() );
    REQUIRE( relief.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    avatar &u = get_avatar();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    u.setpos( here, pos );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    const int initial_base = GENERATE( 0, 5 );
    u.set_pain( initial_base );
    u.set_stamina( 0 );
    dialogue d( get_talker_for( u ), nullptr );

    here.ter_set( pos, ter_id( "t_concrete" ) );
    CHECK_FALSE( verdant->activate( d ) );
    CHECK_FALSE( u.has_effect( relief ) );
    CHECK( u.get_pain() == initial_base + 10 );
    CHECK( u.get_stamina() == 0 );

    here.ter_set( pos, ter_id( "t_forestfloor" ) );
    rng_get_engine().seed( 1 );
    const auto before_roll = rng_get_engine();
    const int budget = rng( 0, 2 ) + 1;
    rng_get_engine() = before_roll;
    REQUIRE( verdant->activate( d ) );
    CHECK( u.get_perceived_pain() == initial_base + 10 - budget );
    CHECK( u.Creature::get_pain() == std::max( 0, initial_base - budget ) );
    CHECK( u.get_pain() == u.Creature::get_pain() + 10 );
    CHECK( u.get_effect_int( relief ) == std::max( 0, budget - initial_base ) );
    CHECK( u.get_stamina() == 1000 );
    CHECK( here.ter( pos ) != ter_id( "t_forestfloor" ) );
    if( u.has_effect( relief ) ) {
        u.get_effect( relief ).set_duration( 0_turns );
        u.Creature::process_effects();
    }
    CHECK( u.get_perceived_pain() == u.Creature::get_pain() + 10 );
    CHECK( u.get_part( body_part_arm_l )->has_wound( wound_thermal_burn ) );
}

TEST_CASE( "xedra_wildfire_soul_rebounds_base_pain_and_only_a_surcharge_on_suppressed_burns",
           "[.][mods][mod_pain][xedra_evolved]" )
{
    INFO( "Requires --mods xedra_evolved" );
    const effect_on_condition_id activate( "EOC_SALAMANDER_BERSERK_STANCE_ON" );
    const effect_on_condition_id deactivate( "EOC_SALAMANDER_BERSERK_STANCE_OFF" );
    const efftype_id soul( "effect_salamander_berserk_stance" );
    REQUIRE( activate.is_valid() );
    REQUIRE( deactivate.is_valid() );
    REQUIRE( soul.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    dialogue d( get_talker_for( u ), nullptr );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_r, true ) );
    u.set_pain( 20 );
    REQUIRE( u.get_pain() == 40 );

    SECTION( "burns are unmasked once when the stance ends" ) {
        REQUIRE( activate->activate( d ) );
        CHECK( u.get_perceived_pain() == 0 );
        REQUIRE( deactivate->activate( d ) );
        CHECK( u.Creature::get_pain() == 26 );
        CHECK( u.get_pain() == 46 );
    }
    SECTION( "a healed burn adds only its activation-time surcharge" ) {
        REQUIRE( activate->activate( d ) );
        u.get_part( body_part_arm_l )->remove_wound( wound_thermal_burn );
        REQUIRE( deactivate->activate( d ) );
        CHECK( u.Creature::get_pain() == 26 );
        CHECK( u.get_pain() == 36 );
    }
    SECTION( "old saves restore the stored base pain without assuming a burn snapshot" ) {
        math_exp stored_base;
        REQUIRE( stored_base.parse( "u_salamander_pain_value = 20" ) );
        stored_base.eval( d );
        u.set_pain( 0 );
        u.add_effect( soul, 24_hours );
        REQUIRE( deactivate->activate( d ) );
        CHECK( u.Creature::get_pain() == 23 );
        CHECK( u.get_pain() == 43 );
    }
    CHECK_FALSE( u.has_effect( soul ) );
    CHECK( u.get_part( body_part_arm_r )->has_wound( wound_thermal_burn ) );
}

TEST_CASE( "xedra_wildfire_soul_reacts_to_combined_rebound_on_its_target",
           "[.][mods][mod_pain][xedra_evolved]" )
{
    const effect_on_condition_id activate( "EOC_SALAMANDER_BERSERK_STANCE_ON" );
    const effect_on_condition_id deactivate( "EOC_SALAMANDER_BERSERK_STANCE_OFF" );
    REQUIRE( activate.is_valid() );
    REQUIRE( deactivate.is_valid() );
    npc target;
    target.normalize();
    target.setID( character_id( 18005 ), true );
    target.set_sensitive( 0 );
    dialogue d( get_talker_for( target ), nullptr );
    REQUIRE( target.apply_thermal_burn( body_part_arm_l, true ) );
    target.set_pain( 4 );

    REQUIRE( activate->activate( d ) );
    target.update_wounds( 1_days );
    REQUIRE( target.get_perceived_pain() == 0 );
    target.add_effect( effect_sleep, 1_hours );
    REQUIRE( target.get_effect_dur( effect_sleep ) == 1_hours );

    // At sensitivity zero the wake threshold is 7–9: neither the six stored
    // pain nor the five remaining wound pain would wake the NPC on its own.
    REQUIRE( deactivate->activate( d ) );
    CHECK( target.Creature::get_pain() == 6 );
    CHECK( target.get_perceived_pain() == 11 );
    CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
}

TEST_CASE( "bombastic_grit_your_teeth_relieves_wound_pain_without_storing_it",
           "[.][mods][mod_pain][bombastic_perks]" )
{
    INFO( "Requires --mods bombastic_perks" );
    const effect_on_condition_id grit( "EOC_PERK_GRIT_YOUR_TEETH" );
    REQUIRE( grit.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_r, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_leg_l, true ) );
    REQUIRE( u.Creature::get_pain() == 0 );
    REQUIRE( u.get_perceived_pain() == 30 );

    dialogue d( get_talker_for( u ), nullptr );
    REQUIRE( grit->activate( d ) );
    REQUIRE( u.get_effect( effect_pain_relief ).get_duration() == 3_minutes );
    CHECK( u.get_perceived_pain() == 0 );
    CHECK( u.get_pain() == 30 );
    CHECK( u.get_painkiller() == 0 );

    SECTION( "remaining injuries hurt again at expiry" ) {
        u.get_effect( effect_pain_relief ).set_duration( 0_turns );
        u.Creature::process_effects();
        CHECK( u.get_perceived_pain() == 30 );
    }
    SECTION( "treatment during relief does not bring back pain from a healed wound" ) {
        u.get_part( body_part_arm_l )->remove_wound( wound_thermal_burn );
        CHECK( u.get_perceived_pain() == 0 );
        u.get_effect( effect_pain_relief ).set_duration( 0_turns );
        u.Creature::process_effects();
        CHECK( u.get_perceived_pain() == 20 );
    }
    CHECK( u.Creature::get_pain() == 0 );
    CHECK( u.get_painkiller() == 0 );
}

TEST_CASE( "bombastic_grit_expiry_reacts_only_to_current_felt_pain",
           "[.][mods][mod_pain][bombastic_perks][pain_transition]" )
{
    const effect_on_condition_id grit( "EOC_PERK_GRIT_YOUR_TEETH" );
    REQUIRE( grit.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    const restore_on_out_of_scope restore_pain_distraction( uistate.distraction_pain );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    uistate.distraction_pain = false;
    avatar &u = get_avatar();
    u.set_sensitive( 100 );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    dialogue d( get_talker_for( u ), nullptr );
    REQUIRE( grit->activate( d ) );
    REQUIRE( u.get_perceived_pain() == 0 );
    u.add_effect( effect_sleep, 1_hours );

    SECTION( "ordinary countdown wakes on actual removal, not on the last duration tick" ) {
        u.get_effect( effect_pain_relief ).set_duration( 1_turns );
        u.Creature::process_effects();
        REQUIRE( u.has_effect( effect_pain_relief ) );
        CHECK( u.get_effect_dur( effect_pain_relief ) == 0_turns );
        CHECK( u.get_perceived_pain() == 0 );
        CHECK( u.get_effect_dur( effect_sleep ) == 1_hours - 1_turns );
        u.Creature::process_effects();
        CHECK_FALSE( u.has_effect( effect_pain_relief ) );
        CHECK( u.get_perceived_pain() == 10 );
        CHECK( u.get_effect_dur( effect_sleep ) == 0_turns );
    }
    SECTION( "other analgesia controls whether and how much pain returns" ) {
        const int painkiller = GENERATE( 8, 10 );
        u.set_painkiller( painkiller );
        u.get_effect( effect_pain_relief ).set_duration( 0_turns );
        const auto before = rng_get_engine();
        if( painkiller == 8 ) {
            rng( 3, 5 );
        }
        const auto expected_rng = rng_get_engine();
        rng_get_engine() = before;
        u.Creature::process_effects();
        CHECK( rng_get_engine() == expected_rng );
        CHECK_FALSE( u.has_effect( effect_pain_relief ) );
        CHECK( u.get_perceived_pain() == 10 - painkiller );
        CHECK( u.get_effect_dur( effect_sleep ) == 1_hours - 1_turns );
    }
    SECTION( "reloading a pending expiration needs no stored felt-pain baseline" ) {
        u.set_painkiller( 8 );
        u.get_effect( effect_pain_relief ).set_duration( 0_turns );
        const restore_on_out_of_scope restore_version( savegame_loading_version );
        savegame_loading_version = savegame_version;
        std::ostringstream save;
        JsonOut out( save );
        u.serialize( out );
        avatar restored;
        restored.deserialize( json_loader::from_string( save.str() ).get_object() );
        REQUIRE( restored.has_effect( effect_pain_relief ) );
        REQUIRE( restored.get_effect_dur( effect_pain_relief ) == 0_turns );
        REQUIRE( restored.get_perceived_pain() == 0 );
        REQUIRE( restored.get_effect_dur( effect_sleep ) == 1_hours );
        const auto before = rng_get_engine();
        rng( 3, 5 );
        const auto expected_rng = rng_get_engine();
        rng_get_engine() = before;
        restored.Creature::process_effects();
        CHECK( rng_get_engine() == expected_rng );
        CHECK_FALSE( restored.has_effect( effect_pain_relief ) );
        CHECK( restored.get_perceived_pain() == 2 );
        CHECK( restored.Creature::get_pain() == 0 );
    }
    CHECK( u.Creature::get_pain() == 0 );
}

TEST_CASE( "isolation_protocol_caps_felt_pain_without_removing_burns",
           "[.][mods][mod_pain][Isolation_Protocol]" )
{
    INFO( "Requires --mods Isolation_Protocol" );
    const effect_on_condition_id maintain( "ISO_MAINTAIN_PAIN_CEILING" );
    REQUIRE( maintain.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_r, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_leg_l, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_leg_r, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_torso, true ) );
    REQUIRE( u.get_perceived_pain() == 50 );
    u.set_pain( 20 );

    SECTION( "a hit applies the ceiling immediately" ) {
        u.apply_damage( nullptr, body_part_torso, 1 );
    }
    SECTION( "maintenance applies the ceiling without a hit" ) {
        dialogue d( get_talker_for( u ), nullptr );
        REQUIRE( maintain->activate( d ) );
    }
    CHECK( u.get_perceived_pain() == 40 );
    CHECK( u.get_pain() == 70 );
    CHECK( u.Creature::get_pain() == 20 );
    CHECK( u.get_painkiller() == 0 );
    CHECK( u.get_part( body_part_torso )->has_wound( wound_thermal_burn ) );
    u.set_pain( 60 );
    CHECK( u.get_perceived_pain() == 60 );
    u.set_pain( 0 );
    u.update_wounds( 1_days );
    CHECK( u.get_perceived_pain() == 25 );
}

TEST_CASE( "isolation_protocol_nonthermal_ceiling_still_only_applies_on_a_hit",
           "[.][mods][mod_pain][Isolation_Protocol]" )
{
    const effect_on_condition_id maintain( "ISO_MAINTAIN_PAIN_CEILING" );
    REQUIRE( maintain.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    dialogue d( get_talker_for( u ), nullptr );
    u.set_pain( 65 );
    REQUIRE( maintain->activate( d ) );
    CHECK( u.get_perceived_pain() == 65 );

    npc target;
    target.normalize();
    target.setID( character_id( 18004 ), true );
    target.set_pain( 60 );
    target.apply_damage( nullptr, body_part_torso, 1 );
    CHECK( target.Creature::get_pain() == 40 );
    CHECK( u.Creature::get_pain() == 65 );
    CHECK( u.get_perceived_pain() == 65 );

    u.apply_damage( nullptr, body_part_torso, 1 );
    CHECK( u.Creature::get_pain() == 40 );
    CHECK( u.get_perceived_pain() == 40 );
    u.set_pain( 55 );
    CHECK( u.get_perceived_pain() == 55 );
}

TEST_CASE( "mom_analgesic_block_rebounds_only_base_and_ten_percent_of_suppressed_pain",
           "[.][mods][mod_pain][mindovermatter]" )
{
    INFO( "Requires --mods mindovermatter" );
    const effect_on_condition_id analgesic_block( "EOC_ELECTROKIN_PAIN_IMMUNE_ON" );
    const effect_on_condition_id rebound( "EOC_ELECTROKIN_PAIN_IMMUNE_OFF" );
    REQUIRE( analgesic_block.is_valid() );
    REQUIRE( rebound.is_valid() );
    clear_avatar();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_queue( std::move( u.queued_effect_on_conditions ) );
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_r, true ) );
    REQUIRE( u.apply_thermal_burn( body_part_leg_l, true ) );
    const int initial_base = GENERATE( 0, 20 );
    u.set_pain( initial_base );
    REQUIRE( u.get_pain() == initial_base + 30 );
    const int expected_base = initial_base + ( initial_base + 30 ) / 10;

    dialogue d( get_talker_for( u ), nullptr );
    math_exp scaling;
    REQUIRE( scaling.parse( "u_nether_attunement_power_scaling = 1" ) );
    scaling.eval( d );

    SECTION( "an incompatible effect blocks the cast without taking away pain" ) {
        u.add_effect( effect_electrokinetic_speed_boost, 5_minutes );
        analgesic_block->activate( d );
        CHECK_FALSE( u.has_effect( effect_electrokinetic_pain_immune ) );
        CHECK( u.get_pain() == initial_base + 30 );
        return;
    }

    REQUIRE( analgesic_block->activate( d ) );
    REQUIRE( u.get_effect( effect_electrokinetic_pain_immune ).get_duration() > 0_turns );
    CHECK( u.get_perceived_pain() == 0 );

    SECTION( "the scheduled rebound unmasks burns without adding their pain to base" ) {
        REQUIRE( rebound->activate( d ) );
        CHECK( u.get_pain() == expected_base + 30 );
    }
    SECTION( "the scheduled rebound does not bring back wound pain removed by treatment" ) {
        u.get_part( body_part_arm_l )->remove_wound( wound_thermal_burn );
        REQUIRE( rebound->activate( d ) );
        CHECK( u.get_pain() == expected_base + 20 );
    }
    CHECK_FALSE( u.has_effect( effect_electrokinetic_pain_immune ) );
    CHECK( u.Creature::get_pain() == expected_base );
    CHECK( u.get_painkiller() == 0 );
    CHECK( u.get_part( body_part_leg_l )->has_wound( wound_thermal_burn ) );
}

TEST_CASE( "aftershock_combat_stim_spends_only_its_remaining_budget_on_burns",
           "[.][mods][mod_pain][aftershock_exoplanet]" )
{
    INFO( "Requires --mods aftershock_exoplanet" );
    const itype_id stimpack( "afs_stimpack" );
    const efftype_id relief( "afs_stimpack_thermal_relief" );
    const efftype_id pkill3( "pkill3" );
    const efftype_id combat_stims( "afs_combat_stims" );
    REQUIRE( stimpack.is_valid() );
    REQUIRE( relief.is_valid() );
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    u.update_wounds( 2_minutes );
    const int wound_pain = u.get_pain();
    u.set_pain( 75 );
    u.set_stamina( 0 );

    item dose( stimpack, calendar::turn, 1 );
    REQUIRE( u.consume( dose, true, true ) != trinary::NONE );
    CHECK( u.Creature::get_pain() == 0 );
    CHECK( u.get_pain() == wound_pain );
    CHECK( u.get_effect_int( relief ) == 5 );
    CHECK( u.get_effect_dur( relief ) == 40_minutes );
    CHECK( u.get_effect_dur( pkill3 ) == 40_minutes );
    CHECK( u.get_effect_dur( combat_stims ) == 40_minutes );
    CHECK( u.get_stamina() == 2500 );
    CHECK( u.get_perceived_pain() == std::max( 0, wound_pain - 5 - u.get_painkiller() ) );
    const auto &wounds = u.get_part( body_part_arm_l )->get_wounds();
    REQUIRE( wounds.size() == 1 );
    CHECK( wounds.front().type == wound_thermal_burn );
    CHECK( wounds.front().get_healing_progress() == 2_minutes );
}

TEST_CASE( "aftershock_pain_suppression_injector_only_masks_burns_while_powered",
           "[.][mods][mod_pain][aftershock_exoplanet]" )
{
    INFO( "Requires --mods aftershock_exoplanet" );
    const bionic_id injector( "afs_healing_injection" );
    const efftype_id relief( "afs_chemhealing_thermal_relief" );
    REQUIRE( injector.is_valid() );
    REQUIRE( relief.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    const restore_on_out_of_scope restore_pain_distraction( uistate.distraction_pain );
    uistate.distraction_pain = false;
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    avatar &u = get_avatar();
    u.add_bionic( injector );
    u.set_max_power_level( 10_kJ );
    u.set_power_level( 10_kJ );
    const std::optional<bionic *> installed = u.find_bionic_by_type( injector );
    REQUIRE( installed );
    bionic &bio = **installed;
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    u.set_pain( 1 );

    // Use the engine state just before a successful roll, independently of the
    // standard library's mapping of random bits to the 1-in-40 distribution.
    rng_get_engine().seed( 1 );
    auto triggering_draw = rng_get_engine();
    while( !one_in( 40 ) ) {
        triggering_draw = rng_get_engine();
    }
    const auto process_with_relief_roll = [&u, &bio, &triggering_draw] {
        rng_get_engine() = triggering_draw;
        u.process_bionic( bio );
    };
    process_with_relief_roll();
    CHECK( u.get_perceived_pain() == 11 );
    REQUIRE( u.activate_bionic( bio ) );
    process_with_relief_roll();
    CHECK( u.Creature::get_pain() == 0 );
    CHECK_FALSE( u.has_effect( relief ) );
    CHECK( u.get_perceived_pain() == 10 );
    process_with_relief_roll();
    CHECK( u.get_perceived_pain() == 9 );
    for( int i = 0; i < 6; ++i ) {
        process_with_relief_roll();
    }
    CHECK( u.get_effect_int( relief ) == 5 );
    CHECK( u.get_effect_dur( relief ) == 2_minutes );
    CHECK( u.get_perceived_pain() == 5 );
    bio.incapacitated_time = 1_turns;
    CHECK( u.get_perceived_pain() == 10 );
    u.set_pain( 1 );
    process_with_relief_roll();
    CHECK( u.Creature::get_pain() == 1 );
    u.set_pain( 0 );
    bio.incapacitated_time = 0_turns;
    SECTION( "switching off removes relief immediately" ) {
        u.add_effect( effect_sleep, 1_hours );
        REQUIRE( u.get_effect_dur( effect_sleep ) == 1_hours );
        REQUIRE( u.deactivate_bionic( bio ) );
        CHECK( u.get_effect_dur( effect_sleep ) == 0_turns );
    }
    SECTION( "running out of power removes relief immediately" ) {
        u.add_effect( effect_sleep, 1_hours );
        REQUIRE( u.get_effect_dur( effect_sleep ) == 1_hours );
        u.set_power_level( 0_kJ );
        bio.charge_timer = 1_turns;
        u.process_bionic( bio );
        CHECK_FALSE( u.has_active_bionic( injector ) );
        CHECK( u.get_effect_dur( effect_sleep ) == 0_turns );
    }
    SECTION( "reactivation discards stale relief from a shutdown that skipped its callback" ) {
        bio.powered = false;
        CHECK( u.has_effect( relief ) );
        CHECK( u.get_perceived_pain() == 10 );
        REQUIRE( u.activate_bionic( bio ) );
    }
    CHECK_FALSE( u.has_effect( relief ) );
    CHECK( u.get_perceived_pain() == 10 );
    CHECK( u.get_pain() == 10 );
    CHECK( u.get_part( body_part_arm_l )->has_wound( wound_thermal_burn ) );
}

TEST_CASE( "aftershock_injector_removal_and_recharge_settle_pain_on_the_live_character",
           "[.][mods][mod_pain][aftershock_exoplanet]" )
{
    const bionic_id rig( "afs_bio_chemical_enhancement_rig" );
    const bionic_id injector( "afs_healing_injection" );
    const efftype_id relief( "afs_chemhealing_thermal_relief" );
    REQUIRE( rig.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    const restore_on_out_of_scope distraction( uistate.distraction_pain );
    const restore_on_out_of_scope restore_turn( calendar::turn );
    calendar::turn = calendar::turn_zero + 1_turns; // Skip periodic environmental wake checks.
    uistate.distraction_pain = false;
    avatar &u = get_avatar();
    u.set_sensitive( 100 );
    u.toggle_trait( trait_id( "MASOCHIST" ) );
    const morale_type pain_morale( "morale_perm_masochist" );
    u.set_max_power_level( 10_kJ );
    u.set_power_level( 10_kJ );
    const bionic_uid rig_uid = u.add_bionic( rig );
    REQUIRE( rig_uid != 0 );
    const auto installed = u.find_bionic_by_type( injector );
    REQUIRE( installed );
    REQUIRE( ( *installed )->get_parent_uid() == rig_uid );
    REQUIRE( u.activate_bionic( **installed ) );
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    u.add_effect( relief, 2_minutes, false, 5 );
    REQUIRE( u.get_perceived_pain() == 5 );
    u.add_effect( effect_sleep, 1_hours );

    SECTION( "removing the rig also removes the running injector" ) {
        dialogue d( get_talker_for( u ), nullptr );
        REQUIRE( u.get_effect_dur( effect_sleep ) > 0_turns );
        run_pain_test_effect( d, R"({"u_lose_bionic":"afs_bio_chemical_enhancement_rig"})" );
        CHECK_FALSE( u.has_bionic( rig ) );
        CHECK_FALSE( u.has_bionic( injector ) );
        CHECK( u.get_effect_dur( effect_sleep ) == 0_turns );
        CHECK( u.get_perceived_pain() == 10 );
        CHECK( u.has_morale( pain_morale ) == 10 );
    }
    SECTION( "a recharge wake can replace the bionic collection in the middle of the turn" ) {
        ( **u.find_bionic_by_uid( rig_uid ) ).charge_timer = 10_turns;
        ( *installed )->charge_timer = 1_turns;
        const bionic_uid survivor = u.add_bionic( bionic_id( "bio_night_vision" ) );
        REQUIRE( survivor != 0 );
        REQUIRE( u.activate_bionic( **u.find_bionic_by_uid( survivor ) ) );
        ( **u.find_bionic_by_uid( survivor ) ).charge_timer = 3_turns;
        u.set_power_level( 0_kJ );

        struct replace_on_wake : event_subscriber {
            using event_subscriber::notify;
            avatar &target;
            bionic_uid replacement = 0;
            explicit replace_on_wake( avatar &target ) : target( target ) {}
            void notify( const cata::event &e ) override {
                if( e.type() == event_type::character_wakes_up &&
                    e.get<character_id>( "character" ) == target.getID() ) {
                    dialogue d( get_talker_for( target ), nullptr );
                    run_pain_test_effect( d, R"({"u_lose_bionic":"afs_bio_chemical_enhancement_rig"})" );
                    replacement = target.add_bionic( bionic_id( "afs_healing_injection" ) );
                    REQUIRE( replacement != 0 );
                    bionic &new_injector = **target.find_bionic_by_uid( replacement );
                    new_injector.powered = true;
                    new_injector.charge_timer = 4_turns;
                }
            }
        } observer( u );
        get_event_bus().subscribe( &observer );
        REQUIRE( u.get_effect_dur( effect_sleep ) > 0_turns );
        REQUIRE( u.suffer() );
        REQUIRE_FALSE( u.find_bionic_by_uid( rig_uid ) );
        REQUIRE( u.find_bionic_by_uid( survivor ) );
        REQUIRE( u.find_bionic_by_uid( observer.replacement ) );
        CHECK( ( **u.find_bionic_by_uid( survivor ) ).charge_timer == 2_turns );
        CHECK( ( **u.find_bionic_by_uid( observer.replacement ) ).charge_timer == 4_turns );
    }
}

TEST_CASE( "magiclysm_raspberry_relief_stacks_to_its_own_cap_and_expires",
           "[.][mods][mod_pain][magiclysm]" )
{
    INFO( "Requires --mods magiclysm" );
    const effect_on_condition_id raspberry( "EOC_POTION_FRUIT_RASPBERRY" );
    const efftype_id relief( "effect_pfruit_raspberry_relief" );
    REQUIRE( raspberry.is_valid() );
    REQUIRE( relief.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    u.set_pain( 2 );
    dialogue d( get_talker_for( u ), nullptr );

    REQUIRE( raspberry->activate( d ) );
    CHECK( u.Creature::get_pain() == 0 );
    CHECK( u.get_pain() == 10 );
    CHECK( u.get_perceived_pain() == 9 );
    CHECK( u.get_effect_dur( relief ) == 5_minutes );
    for( int i = 0; i < 4; ++i ) {
        REQUIRE( raspberry->activate( d ) );
    }
    CHECK( u.get_effect_int( relief ) == 9 );
    CHECK( u.get_perceived_pain() == 1 );

    SECTION( "expiration restores only current burn pain" ) {
        u.update_wounds( 1_days );
        CHECK( u.get_perceived_pain() == 0 );
        u.get_effect( relief ).set_duration( 0_turns );
        u.Creature::process_effects();
        CHECK( u.get_perceived_pain() == 5 );
        CHECK( u.Creature::get_pain() == 0 );
    }
    SECTION( "excess relief does not mask new base pain" ) {
        u.get_part( body_part_arm_l )->remove_wound( wound_thermal_burn );
        u.set_pain( 6 );
        CHECK( u.get_perceived_pain() == 6 );
    }
    SECTION( "other analgesia still applies to the remaining pain" ) {
        u.set_pain( 6 );
        u.set_painkiller( 3 );
        u.add_effect( effect_pain_relief, 3_minutes, bodypart_id(), false, 2 );
        CHECK( u.get_perceived_pain() == 2 );
        CHECK( u.Creature::get_pain() == 6 );
        CHECK( u.get_pain() == 16 );
    }
}

TEST_CASE( "bombastic_blood_drinking_spends_its_own_analgesia_budget",
           "[.][mods][mod_pain][bombastic_perks]" )
{
    INFO( "Requires --mods bombastic_perks" );
    const trait_id blood_healing( "perk_blood_drinking_heal" );
    const efftype_id relief( "effect_perk_blood_drinking_thermal_relief" );
    REQUIRE( blood_healing.is_valid() );
    REQUIRE( relief.is_valid() );
    clear_avatar();
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    avatar &u = get_avatar();
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    for( const bodypart_id &bp : u.get_all_body_parts( get_body_part_flags::only_main ) ) {
        u.set_part_hp_cur( bp, u.get_part_hp_max( bp ) - 2 );
    }
    const int injured_hp = u.get_hp();
    u.set_pain( 1 );
    const auto drink = [&u]( const itype_id &id ) {
        get_event_bus().send<event_type::character_eats_item>( u.getID(), id );
    };
    drink( itype_id( "blood" ) );
    CHECK( u.get_perceived_pain() == 11 );
    u.set_mutation( blood_healing );
    drink( itype_id( "water" ) );
    CHECK( u.get_perceived_pain() == 11 );
    CHECK( u.get_hp() == injured_hp );
    drink( itype_id( "blood" ) );
    CHECK( u.get_hp() == injured_hp + 2 );
    u.set_all_parts_hp_to_max();
    CHECK( u.Creature::get_pain() == 0 );
    CHECK( u.get_pain() == 10 );
    CHECK( u.get_perceived_pain() == 9 );
    CHECK( u.get_effect_dur( relief ) == 2_minutes );
    for( int i = 0; i < 4; ++i ) {
        drink( itype_id( "animal_blood" ) );
    }
    CHECK( u.get_effect_int( relief ) == 6 );
    CHECK( u.get_perceived_pain() == 4 );
    u.get_effect( relief ).set_duration( 0_turns );
    u.Creature::process_effects();
    CHECK( u.get_perceived_pain() == 10 );
    CHECK( u.get_part( body_part_arm_l )->has_wound( wound_thermal_burn ) );
}

TEST_CASE( "mom_neutralized_reveals_thermal_pain_without_explicit_rebound",
           "[.][mods][mod_pain][mindovermatter]" )
{
    INFO( "Requires --mods mindovermatter" );
    const efftype_id neutralized( "effect_psi_neutralized" );
    REQUIRE( neutralized.is_valid() );
    REQUIRE( effect_electrokinetic_pain_immune.is_valid() );
    standard_npc target( "Analgesic Block test NPC", tripoint_bub_ms( 50, 50, 0 ) );
    clear_character( target, true );
    target.set_sensitive( 100 );
    REQUIRE( target.apply_thermal_burn( body_part_arm_l, true ) );
    target.add_effect( effect_electrokinetic_pain_immune, 20_minutes );
    target.add_effect( effect_sleep, 1_hours );
    REQUIRE( target.get_perceived_pain() == 0 );
    target.add_effect( neutralized, 5_turns );
    REQUIRE( target.has_effect( effect_electrokinetic_pain_immune ) );

    // Neutralized's removes_effects, not the manual-off EOC, ends Analgesic Block.
    REQUIRE( target.Creature::process_effects() );
    CHECK_FALSE( target.has_effect( effect_electrokinetic_pain_immune ) );
    CHECK( target.Creature::get_pain() == 0 );
    CHECK( target.get_perceived_pain() == 10 );
    CHECK( target.get_effect_dur( effect_sleep ) == 0_turns );
}

TEST_CASE( "mom_analgesic_unblock_reacts_to_the_combined_felt_pain_once",
           "[.][mods][mod_pain][mindovermatter]" )
{
    INFO( "Requires --mods mindovermatter" );
    const effect_on_condition_id analgesic_block( "EOC_ELECTROKIN_PAIN_IMMUNE_ON" );
    const effect_on_condition_id rebound( "EOC_ELECTROKIN_PAIN_IMMUNE_OFF" );
    REQUIRE( analgesic_block.is_valid() );
    REQUIRE( rebound.is_valid() );
    clear_avatar();
    avatar &u = get_avatar();
    const restore_on_out_of_scope restore_queue( std::move( u.queued_effect_on_conditions ) );
    const on_out_of_scope cleanup( [] { clear_avatar(); } );
    const restore_on_out_of_scope restore_pain_distraction( uistate.distraction_pain );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    uistate.distraction_pain = false;
    REQUIRE( u.apply_thermal_burn( body_part_arm_l, true ) );
    REQUIRE( u.get_pain() == 10 );
    dialogue d( get_talker_for( u ), nullptr );
    math_exp scaling;
    REQUIRE( scaling.parse( "u_nether_attunement_power_scaling = 1" ) );
    scaling.eval( d );
    REQUIRE( analgesic_block->activate( d ) );
    REQUIRE( u.get_pain() == 0 );
    u.add_effect( effect_sleep, 1_hours );

    SECTION( "combined rise of five wakes despite a one-point base rebound" ) {
        u.set_painkiller( 6 );
        REQUIRE( rebound->activate( d ) );
        CHECK( u.get_effect_dur( effect_sleep ) == 0_turns );
        CHECK( u.get_perceived_pain() == 5 );
    }
    SECTION( "a sub-threshold rise makes exactly one wake check" ) {
        u.set_painkiller( 9 );
        const auto before = rng_get_engine();
        rng( 3, 5 );
        const auto after_one_wake_check = rng_get_engine();
        rng_get_engine() = before;
        REQUIRE( rebound->activate( d ) );
        CHECK( rng_get_engine() == after_one_wake_check );
        CHECK( u.get_effect_dur( effect_sleep ) == 1_hours );
        CHECK( u.get_perceived_pain() == 2 );
    }
    SECTION( "a fully masked rise makes no wake check" ) {
        u.set_painkiller( 11 );
        const auto before = rng_get_engine();
        REQUIRE( rebound->activate( d ) );
        CHECK( rng_get_engine() == before );
        CHECK( u.get_effect_dur( effect_sleep ) == 1_hours );
        CHECK( u.get_perceived_pain() == 0 );
    }
    CHECK( u.Creature::get_pain() == 1 );
    CHECK( u.get_pain() == 11 );
}
