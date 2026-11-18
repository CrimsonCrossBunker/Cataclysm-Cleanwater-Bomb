#include "effect_on_condition.h"

#include <dialogue.h>
#include <dialogue_helpers.h>
#include <global_vars.h>
#include <algorithm>
#include <array>
#include <chrono>
#include <cstddef>
#include <cstdint>
#include <iterator>
#include <list>
#include <memory>
#include <ostream>
#include <queue>
#include <sstream>
#include <unordered_map>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "cata_variant.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_id.h"
#include "condition.h"
#include "creature.h"
#include "debug.h"
#include "debug_capture.h"
#include "event.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "generic_factory.h"
#include "json.h"
#include "lua_platform_runtime.h"
#include "lua_platform_character_tasks.h"
#include "lua_platform_state.h"
#include "math_parser_diag_value.h"
#include "mod_tracker.h"
#include "npc.h"
#include "output.h"
#include "profession.h"
#include "scenario.h"
#include "string_formatter.h"
#include "talker.h"
#include "translations.h"
#include "type_id.h"

namespace io
{
    // *INDENT-OFF*
    template<>
    std::string enum_to_string<eoc_type>( eoc_type data )
    {
        switch ( data ) {
        case eoc_type::ACTIVATION: return "ACTIVATION";
        case eoc_type::RECURRING: return "RECURRING";
        case eoc_type::AVATAR_DEATH: return "AVATAR_DEATH";
        case eoc_type::NPC_DEATH: return "NPC_DEATH";
        case eoc_type::PREVENT_DEATH: return "PREVENT_DEATH";
        case eoc_type::EVENT: return "EVENT";
        case eoc_type::NUM_EOC_TYPES: break;
        }
        cata_fatal( "Invalid eoc_type" );
    }    
    // *INDENT-ON*
} // namespace io

namespace
{
generic_factory<effect_on_condition>
effect_on_condition_factory( "effect_on_condition" );
} // namespace

template<>
const effect_on_condition &effect_on_condition_id::obj() const
{
    return effect_on_condition_factory.obj( *this );
}

/** @relates string_id */
template<>
bool string_id<effect_on_condition>::is_valid() const
{
    return effect_on_condition_factory.is_valid( *this );
}

static std::vector<std::pair<std::string, std::string>> pending_eoc_refs;

void effect_on_conditions::check_consistency()
{
    for( const auto &[eoc_str, context] : pending_eoc_refs ) {
        effect_on_condition_id eid( eoc_str );
        if( !eid.is_valid() ) {
            debugmsg( "EOC reference \"%s\" (loaded from %s) does not exist", eoc_str, context );
        }
    }
    pending_eoc_refs.clear();
}

void effect_on_condition::load( const JsonObject &jo, std::string_view src )
{
    mandatory( jo, was_loaded, "id", id );
    optional( jo, was_loaded, "eoc_type", type, eoc_type::NUM_EOC_TYPES );
    if( jo.has_member( "recurrence" ) ) {
        if( type != eoc_type::NUM_EOC_TYPES && type != eoc_type::RECURRING ) {
            jo.throw_error( "A recurring effect_on_condition must be of type RECURRING." );
        }
        type = eoc_type::RECURRING;
        optional( jo, was_loaded, "recurrence", recurrence );
    }
    if( type == eoc_type::NUM_EOC_TYPES ) {
        type = eoc_type::ACTIVATION;
    }

    if( jo.has_member( "deactivate_condition" ) ) {
        read_condition( jo, "deactivate_condition", deactivate_condition, false );
        has_deactivate_condition = true;
    }
    if( jo.has_member( "condition" ) ) {
        read_condition( jo, "condition", condition, false );
        has_condition = true;
    }
    true_effect.load_effect( jo, "effect", std::string( src ) );

    if( jo.has_member( "false_effect" ) ) {
        false_effect.load_effect( jo, "false_effect", std::string( src ) );
        has_false_effect = true;
    }

    optional( jo, was_loaded, "run_for_npcs", run_for_npcs, false );
    optional( jo, was_loaded, "global", global, false );
    if( !global && run_for_npcs ) {
        jo.throw_error( "run_for_npcs should only be true for global effect_on_conditions." );
    }

    if( type == eoc_type::EVENT ) {
        mandatory( jo, was_loaded, "required_event", required_event );
    }
}

effect_on_condition_id effect_on_conditions::load_inline_eoc( const JsonValue &jv,
        std::string_view src )
{
    if( jv.test_string() ) {
        std::string context = string_format( "%s (%s)", src, jv.get_root_source_path() );
        pending_eoc_refs.emplace_back( jv.get_string(), std::move( context ) );
        return effect_on_condition_id( jv.get_string() );
    } else if( jv.test_object() ) {
        effect_on_condition inline_eoc;
        inline_eoc.load( jv.get_object(), src );
        mod_tracker::assign_src( inline_eoc, src );
        effect_on_condition_factory.insert( inline_eoc );
        return inline_eoc.id;
    } else {
        jv.throw_error( "effect_on_condition needs to be either a string or an effect_on_condition object." );
    }
}

static time_duration next_recurrence( const effect_on_condition_id &eoc, dialogue &d )
{
    return eoc->recurrence.evaluate( d );
}

void effect_on_conditions::load_new_character( Character &you )
{
    bool is_avatar = you.is_avatar();

    // npcs do not have scenario, so check for that
    const scenario *scen = get_scenario();
    if( scen ) {
        you.queue_effects( scen->eoc() );
        if( scen->has_platform_start_handler() ) {
            cata::lua_platform::invoke_character_start_handler(
                "scenario", scen->ident().str(), scen->platform_start_mod(),
                scen->platform_start_handler(), you );
        }
    }

    const profession *prof = you.get_profession();
    if( prof ) {
        you.queue_effects( prof->get_eocs() );
        if( prof->has_platform_start_handler() ) {
            cata::lua_platform::invoke_character_start_handler(
                "profession", prof->ident().str(), prof->platform_start_mod(),
                prof->platform_start_handler(), you );
        }
    }

    for( const effect_on_condition &eoc : get_all() ) {
        if( eoc.type == eoc_type::RECURRING && ( ( is_avatar && eoc.global ) || !eoc.global ) ) {
            dialogue d( get_talker_for( you ), nullptr );
            queue_effect_on_condition( next_recurrence( eoc.id, d ), eoc.id, you, {} );
        }
    }

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    const character_action_guard lifetime( you );
    cata::lua_platform::notify_character_ready( you, true );
    if( !lifetime ) {
        return;
    }
#endif
    process_effect_on_conditions( you );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
namespace
{
// Lua callbacks share the saved character-turn queue with EOCs to keep their
// due turn and ordering across an upgrade.
const effect_on_condition_id lua_task_record( "ccb:character_task" );
struct active_turn_queue {
    queued_eocs *queue;
    std::vector<queued_eocs::storage_iter> *pending;
};
thread_local std::vector<active_turn_queue> active_turn_queues;
struct character_task_migration {
    effect_on_condition_id eoc;
    const char *handler;
    const char *timer_key;
    bool global = false;
    const char *mod = "xedra_evolved";
    const char *payload_key = nullptr;
    cata::lua_platform::script_persistent_value payload_value = cata::lua_platform::script_null_value{};
};

character_task_migration psychic_learning_migration( const char *id, const char *spell )
{
    return { effect_on_condition_id( id ), "psychic_contemplation_learn", nullptr,
             false, "mindovermatter", "spell", std::string( spell ) };
}

character_task_migration matrix_crystal_migration( const char *id, const char *crystal )
{
    return { effect_on_condition_id( id ), "drain_matrix_crystal", nullptr,
             false, "mindovermatter", "crystal", std::string( crystal ) };
}

// These IDs are read from saves. The authored callbacks use their Lua names.
const std::array<character_task_migration, 275> migrated_character_tasks = {{
        { effect_on_condition_id( "eoc_update_moabosaurus" ),
          "sauropod_update_moabosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_haplocanthosaurus" ),
          "sauropod_update_haplocanthosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_amargasaurus" ),
          "sauropod_update_amargasaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_apatosaurus" ),
          "sauropod_update_apatosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_brontosaurus" ),
          "sauropod_update_brontosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_diplodocus" ),
          "sauropod_update_diplodocus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_barosaurus" ),
          "sauropod_update_barosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_camarasaurus" ),
          "sauropod_update_camarasaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_brachiosaurus" ),
          "sauropod_update_brachiosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_astrodon" ),
          "sauropod_update_astrodon", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_alamosaurus" ),
          "sauropod_update_alamosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "eoc_update_zapatosaurus" ),
          "sauropod_update_zapatosaurus", nullptr, true, "DinoMod" },
        { effect_on_condition_id( "EOC_unvitrified_return" ),
          "return_from_vitrification_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PERK_insight" ),
          "martial_perks_insight_due", nullptr, false, "perk_melee_system" },
        { effect_on_condition_id( "EOC_LIXA_unfold_spawn_goodbye_cards" ),
          "lixa_leave_goodbye_cards", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_0" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 0 } },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_1" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 1 } },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_2" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 2 } },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_3" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 3 } },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_4" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 4 } },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_5" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 5 } },
        { effect_on_condition_id( "EOC_LIXA_unfold_shift_6" ),
          "lixa_unfold_hallway", nullptr, false, "ccb", "stage", std::int64_t{ 6 } },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_FOCUS_DRAIN" ),
          "hedge_tome_focus_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_FARM" ),
          "research_spellbook_hedge_farm_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_WARD_DEMONS" ),
          "research_spellbook_hedge_ward_demons_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_DOCTOR_BOOK" ),
          "research_spellbook_hedge_doctor_book_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_BLOOD_BOOK" ),
          "research_spellbook_hedge_blood_book_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_WARD_DREAMS" ),
          "research_spellbook_hedge_ward_dreams_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_SNARE_CHANGELINGS" ),
          "research_spellbook_hedge_snare_changelings_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_BATHHOUSE_AT_MIDNIGHT" ),
          "research_spellbook_hedge_bathhouse_midnight_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_ABRAMELIN_THE_MAGE" ),
          "research_spellbook_hedge_abramelin_the_mage_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_PSYCHIC_DEFENSE" ),
          "research_spellbook_hedge_psychic_defense_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_BOOK_OF_RAZIEL" ),
          "research_spellbook_hedge_book_of_raziel_due", nullptr },
        { effect_on_condition_id( "EOC_HEDGE_RESEARCH_PROGRESS_AVODAH_ZARAH" ),
          "research_spellbook_hedge_avodah_zarah_due", nullptr },
        { effect_on_condition_id( "EOC_APPLY_REGEN_SERUM_CRASH_2" ),
          "serum_regen_crash", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_APPLY_SUPER_SOLDIER_SERUM_CRASH_2" ),
          "serum_super_soldier_crash", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_APPLY_RESILIENCE_SERUM_CRASH_2" ),
          "serum_resilience_crash", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_APPLY_LEARNING_SERUM_CRASH_2" ),
          "serum_learning_crash", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_APPLY_SPEED_SERUM_CRASH_2" ),
          "serum_speed_crash", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_APPLY_NIGHT_OPS_SERUM_CRASH_2" ),
          "serum_night_ops_crash", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_REGEN_SERUM_PAIN_SPIKE" ),
          "serum_regen_pain", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_REGEN_SERUM_MUT_REJECTION" ),
          "serum_regen_rejection", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_SERUM_RESILIENCE_PERIODIC_SIDE_EFFECTS" ),
          "serum_resilience_side_effects", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_RESILIENCE_SERUM_CRASH_RANDOM_PARALYSIS" ),
          "serum_resilience_paralysis", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_SERUM_LEARNING_HALLUCINATION_CHANCE" ),
          "serum_learning_hallucinations", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_SERUM_SPEED_PERIODIC_SIDE_EFFECTS" ),
          "serum_speed_side_effects", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_NIGHT_OPS_SERUM_CRASH_RANDOM_NYCTOPHOBIA" ),
          "serum_night_ops_phobia", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_VAMPIRE_DRINK_FROM_HUMAN_IN_COMBAT" ),
          "finish_combat_blood_feeding", nullptr },
        { effect_on_condition_id( "EOC_INVENTOR_RECIPE_GAIN" ),
          "inventor_recipe_due", "inventor_recipe_timer" },
        { effect_on_condition_id( "EOC_DREAMSMITHS_SCORE_TIMER" ),
          "dreamsmith_score_due", "dreamsmith_score_timer" },
        { effect_on_condition_id( "DREAMSMITH_CASINGS_LOW_CALIBER_RECIPE" ),
          "dreamsmith_pistol_cases_due", "dreamsmith_pistol_cases_timer" },
        { effect_on_condition_id( "DREAMSMITH_CASINGS_LARGE_CALIBER_RECIPE" ),
          "dreamsmith_rifle_cases_due", "dreamsmith_rifle_cases_timer" },
        { effect_on_condition_id( "EOC_XE_ALLOW_MAGIC_SEQUENCE" ),
          "xedra_allow_dream_class_due", "xedra_dream_class_timer" },
        { effect_on_condition_id( "EOC_DREAM_CRAFTS" ),
          "xedra_dream_craft_due", nullptr },
        { effect_on_condition_id( "EOC_DREAMSMITHS_SCORE_TRAIN" ),
          "xedra_dreamsmith_training_due", nullptr },
        { effect_on_condition_id( "EOC_VAMPIRE_BLOOD_NUMBER_UI" ),
          "vampire_blood_display_due", "vampire_blood_display_timer" },
        { effect_on_condition_id( "EOC_VAMPIRE_ANATHEMA_BURN_IN_SUNLIGHT_CONTINUAL" ),
          "anathema_sun_burn_due", nullptr },
        { effect_on_condition_id( "EOC_XE_VAMPIRE_WEAKNESS_RESHUFFLE_SWITCHER" ),
          "vampire_weakness_reshuffle_due", nullptr },
        { effect_on_condition_id( "EOC_XE_VAMPIRE_BLOOD_RESEARCH_SWITCHER" ),
          "vampire_blood_research_due", nullptr },
        { effect_on_condition_id( "EOC_XE_VAMPIRE_BLOOD_REFINEMENT_RESEARCH_SWITCHER" ),
          "vampire_blood_refinement_due", nullptr },
        { effect_on_condition_id( "EOC_VAMPIRE_GAIN_BLOOD_GIFTS" ),
          "vampire_passive_blood_gift_due", "vampire_blood_gift_timer" },
        { effect_on_condition_id( "EOC_VAMPIRE_ANATHEMA_GAIN_POWERS" ),
          "anathema_progression_due", "anathema_progression_timer" },
        { effect_on_condition_id( "EOC_vampire_virus_escalation" ),
          "vampire_infection_due", "vampire_infection_timer" },
        { effect_on_condition_id( "EOC_vampire_virus_blood_needs" ),
          "vampire_hunger_due", "vampire_hunger_timer" },
        { effect_on_condition_id( "EOC_ADD_VAMPIRUS_INTENSITY1" ),
          "vampire_intensity_two_due", nullptr },
        { effect_on_condition_id( "EOC_ADD_VAMPIRUS_INTENSITY2" ),
          "vampire_intensity_three_due", nullptr },
        { effect_on_condition_id( "EOC_XE_VAMPIRE_ANATHEMA_BURN_IN_SUNLIGHT_AT_SUNRISE" ),
          "anathema_sunrise_due", nullptr, true },
        { effect_on_condition_id( "EOC_VAMPIRES" ),
          "avatar_vampire_infection_due", nullptr, true },
        { effect_on_condition_id( "scenario_strong_portal_storm_base" ),
          "portal_scenario_strength_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "scenario_strong_portal_storm" ),
          "portal_scenario_strong_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "scenario_quick_portal_storm" ),
          "portal_scenario_frequency_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "scenario_portal_dependent" ),
          "portal_scenario_dependent_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_CHECK" ),
          "portal_weather_check_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_MOVE_PORTAL_STORM" ),
          "portal_weather_move_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_WARN_OR_CAUSE_RECURRING" ),
          "portal_storm_cycle_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_SKY_ISLAND_CLIMATE_CONTROL" ),
          "sky_island_climate_due", "sky_island_climate_timer", false, "skyisland" },
        { effect_on_condition_id( "EOC_constantticking" ),
          "sky_raid_sickness_due", "sky_raid_sickness_timer", false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_horde_chase_warning" ),
          "sky_raid_horde_warning", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_megacity_dimension_warning" ),
          "sky_raid_city_warning", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_hot_dimension_warning" ),
          "sky_raid_hot_warning", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_cold_dimension_warning" ),
          "sky_raid_cold_warning", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_reduced_pulselength_warning" ),
          "sky_raid_short_warning", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_slow_effect_warning" ),
          "sky_raid_slow_warning", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_SI_START_PORTAL_STORM" ),
          "sky_raid_storm_due", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_horde_chase_recurrence" ),
          "sky_raid_horde_due", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_raid_challenge_mode_horde_chase_action" ),
          "sky_raid_horde_signal", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_return_OM_teleport" ),
          "sky_return_home_due", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_VOID_SPIDER_KILLED" ),
          "void_spider_killed_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_DISSOLVE_VOID_SPIDER_LAIR" ),
          "void_spider_lair_exit_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_SCARLET_SEA_RETURN" ),
          "portal_scarlet_return_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_OUBLIETTE_RETURN" ),
          "mom_oubliette_return_due", nullptr, false, "mindovermatter" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_PSION_AWAKENING_DISTANT" ),
          "portal_awakening_distant_due", "portal_awakening_distant", true, "mindovermatter" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_PSION_AWAKENING_MEDIUM" ),
          "portal_awakening_medium_due", "portal_awakening_medium", true, "mindovermatter" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_PSION_AWAKENING_CLOSE" ),
          "portal_awakening_close_due", "portal_awakening_close", true, "mindovermatter" },
        { effect_on_condition_id( "EOC_MOM_SCEN_HEART_OF_FIRE_INITIATE" ),
          "heart_of_fire_start_due", nullptr, false, "mindovermatter" },
        { effect_on_condition_id( "EOC_MOM_SCEN_HEART_OF_FIRE_RECURRING" ),
          "heart_of_fire_pressure_due", nullptr, false, "mindovermatter" },
        matrix_crystal_migration( "EOC_BIOKIN_CRYSTAL_DRAINING", "matrix_crystal_biokinesis" ),
        matrix_crystal_migration( "EOC_CLAIR_CRYSTAL_DRAINING", "matrix_crystal_clairsentience" ),
        matrix_crystal_migration( "EOC_ELECTRO_CRYSTAL_DRAINING", "matrix_crystal_electrokinesis" ),
        matrix_crystal_migration( "EOC_PHOTOKIN_CRYSTAL_DRAINING", "matrix_crystal_photokinesis" ),
        matrix_crystal_migration( "EOC_PYROKIN_CRYSTAL_DRAINING", "matrix_crystal_pyrokinesis" ),
        matrix_crystal_migration( "EOC_TELEKIN_CRYSTAL_DRAINING", "matrix_crystal_telekinesis" ),
        matrix_crystal_migration( "EOC_TELEPATH_CRYSTAL_DRAINING", "matrix_crystal_telepathy" ),
        matrix_crystal_migration( "EOC_TELEPORT_CRYSTAL_DRAINING", "matrix_crystal_teleportation" ),
        matrix_crystal_migration( "EOC_VITAKIN_CRYSTAL_DRAINING", "matrix_crystal_vitakinesis" ),
        matrix_crystal_migration( "EOC_CORUSCATING_CRYSTAL_DRAINING", "matrix_crystal_coruscating" ),
        { effect_on_condition_id( "EOC_PORTAL_EFFECTS_ACTIVE" ),
          "portal_active_effects_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_HIGHLANDS_RETURN" ),
          "portal_highlands_return_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_RADIOSPHERE_RETURN" ),
          "portal_radiosphere_return_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_CABINS_RETURN" ),
          "portal_cabins_return_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_STRING_DIMENSION_RETURN" ),
          "portal_string_dimension_return_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_REVERBERATION_ENTER" ),
          "portal_reverberation_enter_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_CABIN_DAY_CYCLE_OR_KILL_CYCLE" ),
          "portal_cabin_light_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_YRAX_WARP_IN" ),
          "portal_yrax_visit_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_EFFECTS_PASSIVE" ),
          "portal_passive_effects_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_EFFECTS_IRE" ),
          "portal_ire_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_EARLY_MESSAGES" ),
          "portal_early_messages_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "record_portal_storm_data" ),
          "nre_storm_record_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_EFFECTS_CENTER" ),
          "portal_center_dialogue_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_DUNGEON_CRAWLING_TRACKER" ),
          "portal_dungeon_crawl_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_STORM_DUNGEON_SHIFT" ),
          "portal_dungeon_shift_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_PORTAL_DUNGEON_REWARD_ITEM" ),
          "portal_dungeon_reward_item_due", nullptr, false, "ccb" },
        { effect_on_condition_id( "EOC_CAUSE_PORTAL_STORM" ),
          "portal_storm_start_due", nullptr, true, "ccb" },
        { effect_on_condition_id( "EOC_CAUSE_EARLY_PORTAL_STORM_ACTUAL" ),
          "mom_portal_warning_due", nullptr, false, "mindovermatter" },
        { effect_on_condition_id( "scenario_warp_begins" ),
          "sky_island_start_due", nullptr, false, "skyisland" },
        { effect_on_condition_id( "EOC_MAGICLYSM_GAME_START_HUMANS_ARE_HUMAN" ),
          "magiclysm_human_build_due", "magiclysm_human_build_timer", false, "magiclysm" },
        { effect_on_condition_id( "EOC_XE_MAGICLYSM_GAME_START_CHRONOMANCERS_ARE_HUMAN" ),
          "magiclysm_chronomancer_build_due", "magiclysm_chronomancer_build_timer", false, "magiclysm" },
        { effect_on_condition_id( "EOC_AFS_ESPER_STUDYING_POWER_METAPHYSICS_GAIN" ),
          "esper_metaphysics_due", nullptr, false, "aftershock_exoplanet" },
        { effect_on_condition_id( "EOC_AFS_ESPER_STUDYING_POWER_FOCUS_REDUCTION" ),
          "esper_study_focus_due", nullptr, false, "aftershock_exoplanet" },
        { effect_on_condition_id( "EOC_PSI_STUDYING_POWER_METAPHYSICS_GAIN" ),
          "psychic_contemplation_metaphysics", nullptr, false, "mindovermatter" },
        { effect_on_condition_id( "EOC_PSI_STUDYING_POWER_FOCUS_REDUCTION" ),
          "psychic_contemplation_focus", nullptr, false, "mindovermatter" },
        { effect_on_condition_id( "EOC_PSI_STUDYING_POWER_ADD_PROFICIENCY" ),
          "psychic_contemplation_proficiency", nullptr, false, "mindovermatter" },
        { effect_on_condition_id( "EOC_PSI_STUDYING_POWER_NETHER_ATTUNEMENT" ),
          "psychic_contemplation_attunement", nullptr, false, "mindovermatter" },
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_ADRENALINE_LEARNING", "biokin_adrenaline" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_ARMOR_SKIN_LEARNING", "biokin_armor_skin" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_BREATHE_SKIN_LEARNING", "biokin_breathe_skin" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_CLIMATE_CONTROL_LEARNING", "biokin_climate_control" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_COMBAT_DANCE_LEARNING", "biokin_combat_dance" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_DASH_LEARNING", "biokin_dash" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_ENHANCE_MOBILITY_LEARNING", "biokin_enhance_mobility" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_FLEXIBILITY_LEARNING", "biokin_flexibility" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_GUIDED_EVOLUTION_LEARNING", "biokin_guided_evolution" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_HAMMERHAND_LEARNING", "biokin_hammerhand" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_HURRICANE_BLOWS_LEARNING", "biokin_hurricane_blows" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_METABOLISM_ENHANCE_LEARNING", "biokin_metabolism_enhance" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_PERFECTED_MOTION_LEARNING", "biokin_perfected_motion" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_REFLEX_ENHANCE_LEARNING", "biokin_reflex_enhance" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_SEALED_SYSTEM_LEARNING", "biokin_sealed_system" ),
        psychic_learning_migration( "EOC_PRACTICE_BIOKIN_VITAMINOSIS_LEARNING", "biokin_vitaminosis" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_ASTRAL_PROJECTION_LEARNING", "clair_astral_projection" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_CLEAR_SIGHT_LEARNING", "clair_clear_sight" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_COMBAT_SENSE_LEARNING", "clair_dodge_power" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_CRAFT_BONUS_LEARNING", "clair_craft_bonus" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_DANGER_SENSE_LEARNING", "clair_danger_sense" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_EXAMINE_ITEM_LEARNING", "clair_examine_item" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_GROUP_TACTICS_LEARNING", "clair_group_tactics" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_NIGHT_VISION_LEARNING", "clair_night_vision" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_OMNISCENCE_LEARNING", "clair_omniscience" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_PERFECT_SHOT_LEARNING", "clair_perfect_shot" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_RANGED_ENHANCE_LEARNING", "clair_ranged_enhance" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_SEE_AURAS_LEARNING", "clair_see_auras" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_SEE_MAP_LEARNING", "clair_see_map" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_SENSE_HOSTILE_CREATURES_LEARNING", "clair_sense_hostile_creatures" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_SPOT_WEAKNESS_LEARNING", "clair_spot_weakness" ),
        psychic_learning_migration( "EOC_PRACTICE_CLAIR_VOYANCE_LEARNING", "clair_voyance" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_HACKING_INTERFACE_LEARNING", "electrokinetic_hacking_interface" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_KILL_ROBOT_LEARNING", "electrokinetic_kill_robot" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_LIGHTNING_AURA_LEARNING", "electrokinetic_lightning_aura" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_LIGHTNING_BLAST_LEARNING", "electrokinetic_lightning_blast" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_LIGHTNING_BOLT_LEARNING", "electrokinetic_lightning_bolt" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_MELEE_ATTACKS_LEARNING", "electrokinetic_melee_attacks" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_PAIN_IMMUNE_LEARNING", "electrokinetic_pain_immune" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_PARALYSIS_LEARNING", "electrokinetic_paralysis" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_RECHARGE_VEHICLE_LEARNING", "electrokinetic_recharge_vehicle" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_REDUCE_PAIN_LEARNING", "electrokinetic_reduce_pain" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_REVIVE_LEARNING", "electrokinetic_revive" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_ROBOT_INTERFACE_LEARNING", "electrokinetic_robot_interface" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_SPEED_BOOST_LEARNING", "electrokinetic_speed_boost" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTROKIN_ZAP_ENEMIES_LEARNING", "electrokinetic_zap_enemies" ),
        psychic_learning_migration( "EOC_PRACTICE_ELECTRO_PERSONAL_BATTERY_LEARNING", "electrokinetic_personal_battery" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_BLINDING_GLARE_LEARNING", "photokinetic_blinding_glare" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_CAMOUFLAGE_LEARNING", "photokinetic_camouflage" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_FLASH_BANG_LEARNING", "photokinetic_flash_bang" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_HIDE_UGLY_LEARNING", "photokinetic_hide_ugly" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_INVISIBILITY_LEARNING", "photokinetic_invisibility" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_ARMS_LEARNING", "photokinetic_light_arms" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_ARMY_LEARNING", "photokinetic_light_army" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_BEAM_LEARNING", "photokinetic_light_beam" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_DISINTEGRATE_LEARNING", "photokinetic_light_disintegrate" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_DODGE_LEARNING", "photokinetic_light_dodge" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_FLASH_LEARNING", "photokinetic_light_flash" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_IMAGE_LEARNING", "photokinetic_light_image" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_LIGHT_UP_ENEMY_LEARNING", "photokinetic_light_up_enemy" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_RADIO_LEARNING", "photokinetic_radio" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_RAD_IMMUNITY_LEARNING", "photokinetic_rad_immunity" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_SNUFF_LIGHT_LEARNING", "photokinetic_snuff_light" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_STERILIZE_FOOD_LEARNING", "photokinetic_sterilize_food" ),
        psychic_learning_migration( "EOC_PRACTICE_PHOTOKIN_STUN_ROBOTS_LEARNING", "photokinetic_stun_robots" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_AOE_BLAST_LEARNING", "pyrokinetic_aoe_blast" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_AURA_LEARNING", "pyrokinetic_aura" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_BLAST_LEARNING", "pyrokinetic_blast" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_CALL_FLAMES_LEARNING", "pyrokinetic_call_flames" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_CAUTERIZE_LEARNING", "pyrokinetic_cauterize" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_CLOAK_LEARNING", "pyrokinetic_cloak" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_FLAMETHROWER_LEARNING", "pyrokinetic_flamethrower" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_FLAME_IMMUNITY_LEARNING", "pyrokinetic_flame_immunity" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_FOUNTAIN_FLAMES_LEARNING", "pyrokinetic_eruption" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_INCINERATION_LEARNING", "pyrokinetic_incineration" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_LANCE_LEARNING", "pyrokinetic_lance" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_QUELL_FIRE_LEARNING", "pyrokinetic_quell_flames" ),
        psychic_learning_migration( "EOC_PRACTICE_PYROKIN_THERMOGENESIS_LEARNING", "pyrokinetic_thermogenesis" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_AEGIS_LEARNING", "telekinetic_aegis" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_BARRIER_LEARNING", "telekinetic_shield" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_BLAST_LEARNING", "telekinetic_explosion" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_EARTHSHAKER_LEARNING", "telekinetic_earthshaker" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_ENHANCE_STRENGTH_LEARNING", "telekinetic_strength" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_FORCE_WAVE_LEARNING", "telekinetic_wave" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_LEVITATION_LEARNING", "telekinetic_levitation" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_LIFTING_FIELD_LEARNING", "telekinetic_lifting_field" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_MINDHAMMER_LEARNING", "telekinetic_hammer" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_MOMENTUM_LEARNING", "telekinetic_momentum" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_MOVE_LARGE_WEIGHT_LEARNING", "telekinetic_move_large_weight" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_NOISEMAKER_LEARNING", "telekinetic_noise" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_SLAM_DOWN_LEARNING", "telekinetic_slam_down" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_SLOWFALL_LEARNING", "telekinetic_slowfall" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_VEHICLE_LIFT_LEARNING", "telekinetic_vehicle_lift" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEKIN_WATER_WALKING_LEARNING", "telekinetic_water_walk" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_ANIMAL_MIND_CONTROL_LEARNING", "telepathic_animal_mind_control" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_BEAST_TAMING_LEARNING", "telepathic_beast_taming" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_BLAST_LEARNING", "telepathic_blast" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_CONFUSION_LEARNING", "telepathic_confusion" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_MESMERIZE_LEARNING", "telepathic_mesmerize" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_MIND_CONTROL_LEARNING", "telepathic_mind_control" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_MORALE_LEARNING", "telepathic_morale" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_NETWORK_EFFECT_LEARNING", "telepathic_network" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_OBSCURITY_LEARNING", "telepathic_invisibility" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_PRIMAL_FEAR_LEARNING", "telepathic_fear" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_SCREAM_RADIUS_LEARNING", "telepathic_blast_radius" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPATH_SHIELD_LEARNING", "telepathic_shield" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_BANISH_LEARNING", "teleport_banish" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_BREACH_LEARNING", "teleport_summon" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_COLLAPSE_LEARNING", "teleport_collapse" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_DILATED_GATEWAY_LEARNING", "teleport_dilated_gateway" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_DISPLACEMENT_LEARNING", "teleport_displacement" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_EPHEMERAL_WALK_LEARNING", "teleport_ephemeral_walk" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_FARSTEP_LEARNING", "teleport_farstep" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_GATEWAY_LEARNING", "teleport_gateway" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_ITEM_APPORT_LEARNING", "teleport_item_apport" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_LOCI_ESTABLISHMENT_LEARNING", "teleport_loci_establishment" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_PHASE_LEARNING", "teleport_phase" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_REACTIVE_DISPLACEMENT_LEARNING", "teleport_reactive_displacement" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_REALITY_TEAR_LEARNING", "teleport_reality_tear" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_RELOCATION_LEARNING", "teleport_relocation" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_STRIDE_LEARNING", "teleport_stride" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_TRANSPOSE_LEARNING", "teleport_transpose" ),
        psychic_learning_migration( "EOC_PRACTICE_TELEPORT_WARPED_STRIKES_LEARNING", "teleport_warped_strikes" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_ATTACK_TOUCH_LEARNING", "vita_attack_touch" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_BANISH_ILLNESS_LEARNING", "vita_banish_illness" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_CONCENTRATED_HEALING_LEARNING", "vita_concentrated_healing" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_CURE_DISEASE_LEARNING", "vita_cure_disease" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_DEGENERATING_TOUCH_LEARNING", "vita_degenerating_touch" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_HEALING_TRANCE_LEARNING", "vita_healing_trance" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_HEAL_TOUCH_ALLY_LEARNING", "vita_health_power_ally" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_HURT_LEARNING", "vita_hurt_touch" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_INCREASED_HP_LEARNING", "vita_increased_hp" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_NO_NEED_FOR_SLEEP_LEARNING", "vita_no_need_for_sleep" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_PURGE_LEARNING", "vita_blood_purge" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_REMOVE_POISON_LEARNING", "vita_remove_poison" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_RETURN_FROM_DEATH_LEARNING", "vita_return_from_death" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_SLEEP_LEARNING", "vita_sleeping_trance" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_STAUNCHING_LEARNING", "vita_stop_bleeding" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_STOP_INFECTION_LEARNING", "vita_stop_infection" ),
        psychic_learning_migration( "EOC_PRACTICE_VITAKIN_SUPER_HEAL_LEARNING", "vita_super_heal" ),
        { effect_on_condition_id( "EOC_SPAWN_ANATHEMA" ),
          "anathema_encounter_due", nullptr, true },
        { effect_on_condition_id( "EOC_ANATHEMA_SPAWN_MESSAGE" ),
          "anathema_encounter_message", nullptr }
    }
};

const character_task_migration *find_migrated_task( const effect_on_condition_id &id, bool global )
{
    const auto found = std::find_if( migrated_character_tasks.begin(), migrated_character_tasks.end(),
    [&]( const character_task_migration & entry ) {
        return entry.global == global && entry.eoc == id;
    } );
    return found != migrated_character_tasks.end() && !id.is_valid() ? &*found : nullptr;
}

queued_eoc character_task_record( time_point due, std::string_view mod, std::string_view handler,
                                 const global_variables::impl_t &data = {} )
{
    queued_eoc record{ lua_task_record, due, {
            { "mod", diag_value( std::string( mod ) ) },
            { "handler", diag_value( std::string( handler ) ) }
        }
    };
    for( const auto &[key, value] : data ) {
        record.context.emplace( std::string( cata::lua_platform::character_task_data_prefix ) + key, value );
    }
    return record;
}

void queue_turn_task( queued_eocs &queue, const queued_eoc &entry )
{
    const auto active = std::find_if( active_turn_queues.begin(), active_turn_queues.end(),
    [&]( const active_turn_queue & scope ) { return scope.queue == &queue; } );
    if( active != active_turn_queues.end() ) {
        // Wait for the outermost pass even when a callback reenters this same queue.
        active->pending->push_back( queue.list.insert( queue.list.end(), entry ) );
    } else {
        queue.push( entry );
    }
}
} // namespace

void cata::lua_platform::queue_character_task( Character &actor, time_point due,
        std::string_view mod, std::string_view handler, const global_variables::impl_t &data )
{
    queue_turn_task( actor.queued_effect_on_conditions, character_task_record( due, mod, handler, data ) );
}

namespace
{
bool has_turn_task( const queued_eocs &queue, std::string_view mod, std::string_view handler )
{
    const auto &entries = queue.list;
    return std::any_of( entries.begin(), entries.end(), [&]( const queued_eoc & entry ) {
        if( entry.eoc != lua_task_record ) {
            return false;
        }
        const auto owner = entry.context.find( "mod" );
        const auto callback = entry.context.find( "handler" );
        return owner != entry.context.end() && owner->second.to_string() == mod &&
               callback != entry.context.end() && callback->second.to_string() == handler;
    } );
}
} // namespace

bool cata::lua_platform::has_character_turn_task( const Character &actor,
        std::string_view mod, std::string_view handler )
{
    return has_turn_task( actor.queued_effect_on_conditions, mod, handler );
}

bool cata::lua_platform::has_avatar_turn_task( std::string_view mod, std::string_view handler )
{
    return has_turn_task( g->queued_global_effect_on_conditions, mod, handler );
}

void cata::lua_platform::queue_avatar_turn_task( time_point due, std::string_view mod,
        std::string_view handler )
{
    queue_turn_task( g->queued_global_effect_on_conditions, character_task_record( due, mod, handler ) );
}

void cata::lua_platform::ensure_avatar_turn_task( time_point due, std::string_view mod,
        std::string_view handler )
{
    if( !has_avatar_turn_task( mod, handler ) ) {
        queue_avatar_turn_task( due, mod, handler );
    }
}
#endif

static void process_new_eocs( queued_eocs &eoc_queue,
                              std::vector<effect_on_condition_id> &eoc_vector,
                              std::map<effect_on_condition_id, bool> &new_eocs,
                              [[maybe_unused]] Character &actor, bool global_queue )
{
    queued_eocs temp_queued_eocs;
    while( !eoc_queue.empty() ) {
        const queued_eoc &entry = eoc_queue.top();
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        if( entry.eoc == lua_task_record ) {
            temp_queued_eocs.push( entry );
            eoc_queue.pop();
            continue;
        }
        if( const character_task_migration *migration = find_migrated_task( entry.eoc, global_queue ) ) {
            global_variables::impl_t task_data;
            if( entry.eoc == effect_on_condition_id( "EOC_YRAX_WARP_IN" ) ) {
                // A later failed location search retains this delayed visit's previous target.
                const auto target = entry.context.find( "tar" );
                if( target != entry.context.end() ) {
                    std::ostringstream serialized;
                    JsonOut json( serialized );
                    json.start_object();
                    cata::lua_platform::detail::write_persistent_value( json,
                            cata::lua_platform::script_persistent_tripoint{ target->second.tripoint().raw() } );
                    json.end_object();
                    task_data.emplace( "target", diag_value( serialized.str() ) );
                }
            } else if( entry.eoc == effect_on_condition_id( "EOC_unvitrified_return" ) ) {
                const auto item_id = entry.context.find( "id" );
                if( item_id != entry.context.end() ) {
                    std::ostringstream serialized;
                    JsonOut json( serialized );
                    json.start_object();
                    cata::lua_platform::detail::write_persistent_value( json, item_id->second.to_string() );
                    json.end_object();
                    task_data.emplace( "item_id", diag_value( serialized.str() ) );
                }
            }
            if( migration->payload_key ) {
                std::ostringstream serialized;
                JsonOut json( serialized );
                json.start_object();
                cata::lua_platform::detail::write_persistent_value( json, migration->payload_value );
                json.end_object();
                task_data.emplace( migration->payload_key, diag_value( serialized.str() ) );
            }
            temp_queued_eocs.push( character_task_record( entry.time, migration->mod,
                                   migration->handler, task_data ) );
            if( migration->timer_key ) {
                cata::lua_platform::assign_persistent_value(
                    actor.lua_character_state.for_mod( migration->mod ), migration->timer_key,
                    std::string( "scheduled" ) );
            }
            eoc_queue.pop();
            continue;
        }
#endif
        // Check if EoC is moved from global to local, or vice versa
        if( entry.eoc.is_valid() && global_queue == entry.eoc->global ) {
            temp_queued_eocs.push( entry );
            new_eocs[entry.eoc] = false;
        }
        eoc_queue.pop();
    }
    eoc_queue = std::move( temp_queued_eocs );
    for( auto eoc = eoc_vector.begin();
         eoc != eoc_vector.end(); ) {
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        if( const character_task_migration *migration = find_migrated_task( *eoc, global_queue );
            migration && migration->timer_key ) {
            auto &state = actor.lua_character_state.for_mod( migration->mod );
            if( state.count( migration->timer_key ) == 0 ) {
                cata::lua_platform::assign_persistent_value(
                    state, migration->timer_key, std::string( "dormant" ) );
            }
        }
#endif
        // Check if EoC is moved from global to local, or vice versa
        if( !eoc->is_valid() || global_queue != ( *eoc )->global ) {
            eoc = eoc_vector.erase( eoc );
        } else {
            new_eocs[*eoc] = false;
            eoc++;
        }
    }
}

void effect_on_conditions::load_existing_character( Character &you )
{
    bool is_avatar = you.is_avatar();
    std::map<effect_on_condition_id, bool> new_eocs;
    for( const effect_on_condition &eoc : get_all() ) {
        if( eoc.type == eoc_type::RECURRING && ( is_avatar || !eoc.global ) ) {
            new_eocs[eoc.id] = true;
        }
    }
    process_new_eocs( you.queued_effect_on_conditions, you.inactive_effect_on_condition_vector,
                      new_eocs, you, false );
    if( is_avatar ) {
        process_new_eocs( g->queued_global_effect_on_conditions,
                          g->inactive_global_effect_on_condition_vector, new_eocs, you, true );
    }

    for( const std::pair<const effect_on_condition_id, bool> &eoc_pair : new_eocs ) {
        if( eoc_pair.second ) {
            dialogue d( get_talker_for( you ), nullptr );
            queue_effect_on_condition( next_recurrence( eoc_pair.first, d ),
                                       eoc_pair.first, you, {} );
        }
    }
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    cata::lua_platform::notify_character_ready( you, false );
#endif
}

void effect_on_conditions::queue_effect_on_condition( time_duration duration,
        effect_on_condition_id eoc, Character &you,
        global_variables::impl_t const &context )
{
    queued_eoc new_eoc = queued_eoc{ eoc, calendar::turn + duration, context };
    if( eoc->global ) {
        g->queued_global_effect_on_conditions.push( new_eoc );
    } else if( eoc->type == eoc_type::ACTIVATION || eoc->type == eoc_type::RECURRING ) {
        you.queued_effect_on_conditions.push( new_eoc );
    } else {
        debugmsg( "Invalid effect_on_condition and/or target.  EOC: %s", eoc->id.c_str() );
    }
}

static bool process_eocs( queued_eocs &eoc_queue, std::vector<effect_on_condition_id> &eoc_vector,
                          dialogue &d, [[maybe_unused]] Character &actor )
{
    static int reentrancy_depth = 0;
    ++reentrancy_depth;

    // Have to use a typedef because astyle does not settle on the spacing for the & when inline.
    using queue_t = std::vector<queued_eocs::storage_iter> &;
    queue_t eocs_to_queue = []() -> queue_t {
        static std::list<std::vector<queued_eocs::storage_iter>> cached_queues;
        if( reentrancy_depth < 0 )
        {
            debugmsg( "How can we unrecurse more than we recurse?" );
        }
        while( cached_queues.size() < static_cast<size_t>( reentrancy_depth ) )
        {
            cached_queues.emplace_back();
        }
        auto it = cached_queues.begin();
        std::advance( it, reentrancy_depth - 1 );
        return *it;
    }();

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    const bool avatar_queue = g && &eoc_queue == &g->queued_global_effect_on_conditions;
    active_turn_queues.push_back( { &eoc_queue, &eocs_to_queue } );
    on_out_of_scope restore_turn_queue{ [] { active_turn_queues.pop_back(); } };
#endif
    const auto restore_pending_entries = [&] {
        for( queued_eocs::storage_iter &entry : eocs_to_queue ) {
            eoc_queue.queue.emplace( entry );
        }
    };
    on_out_of_scope cleanup{ [&] {
            --reentrancy_depth;
            eocs_to_queue.clear();
        } };

    while( !eoc_queue.empty() &&
           eoc_queue.top().time <= calendar::turn ) {
        queued_eocs::storage_iter it = eoc_queue.queue.top();
        queued_eoc &top = *it;
        eoc_queue.queue.pop();

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        if( top.eoc == lua_task_record ) {
            const time_point due = top.time;
            const auto mod = top.context.find( "mod" );
            const auto handler = top.context.find( "handler" );
            const std::string mod_id = mod == top.context.end() ? "" : mod->second.to_string();
            const std::string handler_id = handler == top.context.end() ? "" : handler->second.to_string();
            const global_variables::impl_t context = std::move( top.context );
            eoc_queue.list.erase( it );
            if( !mod_id.empty() && !handler_id.empty() ) {
                const character_action_guard lifetime( actor );
                cata::lua_platform::invoke_character_task( actor, due, mod_id, handler_id, context );
                if( !lifetime ) {
                    if( avatar_queue ) {
                        restore_pending_entries();
                    }
                    return false;
                }
            }
            continue;
        }
#endif
        dialogue nested_d{ d };
        for( const auto &val : top.context ) {
            nested_d.set_value( val.first, val.second );
        }
        bool activated = top.eoc->activate( nested_d );
        if( top.eoc->type == eoc_type::RECURRING ) {
            if( activated ) { // It worked so add it back
                it->time = calendar::turn + next_recurrence( top.eoc, d );
                eocs_to_queue.emplace_back( it );
            } else {
                if( !top.eoc->check_deactivate(
                        nested_d ) ) { // It failed but shouldn't be deactivated so add it back
                    it->time = calendar::turn + next_recurrence( top.eoc, d );
                    eocs_to_queue.emplace_back( it );
                } else { // It failed and should be deactivated for now
                    eoc_vector.push_back( top.eoc );
                    eoc_queue.list.erase( it );
                }
            }
        } else {
            eoc_queue.list.erase( it );
        }
    }
    restore_pending_entries();
    return true;
}

void effect_on_conditions::process_effect_on_conditions( Character &you )
{
    dialogue d( get_talker_for( you ), nullptr );
    const bool actor_alive = process_eocs( you.queued_effect_on_conditions,
                                          you.inactive_effect_on_condition_vector, d, you );
    //only handle global eocs on the avatars turn
    if( actor_alive && you.is_avatar() ) {
        process_eocs( g->queued_global_effect_on_conditions, g->inactive_global_effect_on_condition_vector,
                      d, you );
    }
}

static void process_reactivation( std::vector<effect_on_condition_id>
                                  &inactive_effect_on_condition_vector,
                                  queued_eocs &queued_effect_on_conditions, dialogue &d )
{
    std::vector<effect_on_condition_id> ids_to_reactivate;
    for( const effect_on_condition_id &eoc : inactive_effect_on_condition_vector ) {
        if( !eoc->check_deactivate( d ) ) {
            ids_to_reactivate.push_back( eoc );
        }
    }
    for( const effect_on_condition_id &eoc : ids_to_reactivate ) {
        queued_effect_on_conditions.push( queued_eoc{ eoc, calendar::turn + next_recurrence( eoc, d ), d.get_context() } );
        inactive_effect_on_condition_vector.erase( std::remove(
                    inactive_effect_on_condition_vector.begin(), inactive_effect_on_condition_vector.end(),
                    eoc ), inactive_effect_on_condition_vector.end() );
    }
}

void effect_on_conditions::process_reactivate( Character &you )
{
    dialogue d( get_talker_for( you ), nullptr );
    process_reactivation( you.inactive_effect_on_condition_vector, you.queued_effect_on_conditions, d );
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    cata::lua_platform::notify_character_conditions_changed( you );
#endif
}

void effect_on_conditions::process_reactivate()
{
    dialogue d( get_talker_for( get_avatar() ), nullptr );
    process_reactivation( g->inactive_global_effect_on_condition_vector,
                          g->queued_global_effect_on_conditions, d );
}

bool effect_on_condition::activate( dialogue &d, bool require_callstack_check ) const
{
    const bool tracing = debug_menu::debug_capture::is_eoc_tracing();
    std::chrono::steady_clock::time_point trace_start;
    if( tracing ) {
        trace_start = std::chrono::steady_clock::now();
    }
    bool retval = false;
    if( require_callstack_check ) {
        d.amend_callstack( "EOC: " + id.str() );
        if( d.get_callstack().size() > 5000 ) {
            if( query_yn( string_format( _( "Possible infinite loop in EOC %s.  Stop execution?" ),
                                         id.str() ) ) ) {
                return false;
            }
        }
    }
    // each version needs a copy of the dialogue to pass down
    dialogue d_eoc( d );
    if( !has_condition || condition( d_eoc ) ) {
        true_effect.apply( d_eoc );
        retval = true;
    } else if( has_false_effect ) {
        false_effect.apply( d_eoc );
    }
    // This works because if global is true then this is recurring and thus should only ever be passed containing the player
    // Thus we just need to run the npcs.
    if( global && run_for_npcs ) {
        for( npc &guy : g->all_npcs() ) {
            dialogue d_npc( get_talker_for( guy ), nullptr, d.get_conditionals(), d.get_context() );
            if( !has_condition || condition( d_npc ) ) {
                true_effect.apply( d_npc );
            } else if( has_false_effect ) {
                false_effect.apply( d_npc );
            }
        }
    }
    if( tracing ) {
        // Read callstack depth at trace time regardless of require_callstack_check
        // (recursive EOC fires pass false but we still want depth > 0).
        const int trace_depth = static_cast<int>( d.get_callstack().size() );
        debug_menu::debug_capture::instance().push_eoc_trace(
            id.str(), retval,
            std::chrono::duration_cast<std::chrono::microseconds>(
                std::chrono::steady_clock::now() - trace_start ),
            trace_depth );
    }
    return retval;
}

bool effect_on_condition::activate_activation_only( dialogue &d, const std::string &text1,
        const std::string &text2, const std::string &text3, bool require_callstack_check ) const
{
    if( type == eoc_type::ACTIVATION ) {
        return activate( d, require_callstack_check );
    }
    debugmsg(
        "Must use an activation eoc for %s%s%s%s.  Otherwise, create a non-recurring effect_on_condition for this %s%swith its condition and effects, then have a recurring one queue it.",
        text1,
        text2.empty() ? "" :
        ".  If you don't want the effect_on_condition to happen on its own (without the ",
        text2,
        text2.empty() ? "" : "), remove the recurrence min and max.",
        text3,
        text3.empty() ? "" : " " );
    return false;
}

bool effect_on_condition::check_deactivate( const_dialogue const &d ) const
{
    if( !has_deactivate_condition || has_false_effect ) {
        return false;
    }
    return deactivate_condition( d );
}

bool effect_on_condition::test_condition( const_dialogue const &d ) const
{
    return !has_condition || condition( d );
}

void effect_on_condition::apply_true_effects( dialogue &d )  const
{
    true_effect.apply( d );
}

void effect_on_conditions::clear( Character &you )
{
    while( !you.queued_effect_on_conditions.empty() ) {
        you.queued_effect_on_conditions.pop();
    }
    you.inactive_effect_on_condition_vector.clear();
    while( !g->queued_global_effect_on_conditions.empty() ) {
        g->queued_global_effect_on_conditions.pop();
    }
    g->inactive_global_effect_on_condition_vector.clear();
}

void effect_on_conditions::write_eocs_to_file( Character &you )
{
    write_to_file( "eocs.output", [&you]( std::ostream & testfile ) {
        testfile << "Character Name: " + you.get_name() << std::endl;
        testfile << "id;timepoint;recurring" << std::endl;

        testfile << "queued eocs:" << std::endl;
        std::vector<queued_eoc> temp_queue;
        while( !you.queued_effect_on_conditions.empty() ) {
            temp_queue.push_back( you.queued_effect_on_conditions.top() );
            you.queued_effect_on_conditions.pop();
        }

        for( const queued_eoc &queue_entry : temp_queue ) {
            time_duration temp = queue_entry.time - calendar::turn;
            testfile << queue_entry.eoc.c_str() << ";" << to_string( temp ) << std::endl;
        }

        for( const queued_eoc &queued : temp_queue ) {
            you.queued_effect_on_conditions.push( queued );
        }

        testfile << "inactive eocs:" << std::endl;
        for( const effect_on_condition_id &eoc : you.inactive_effect_on_condition_vector ) {
            testfile << eoc.c_str() << std::endl;
        }

    }, "eocs test file" );
}

void effect_on_conditions::write_global_eocs_to_file( )
{
    write_to_file( "eocs.output", [&]( std::ostream & testfile ) {
        testfile << "global" << std::endl;
        testfile << "id;timepoint;recurring" << std::endl;

        testfile << "queued eocs:" << std::endl;
        std::vector<queued_eoc> temp_queue;
        while( !g->queued_global_effect_on_conditions.empty() ) {
            temp_queue.push_back( g->queued_global_effect_on_conditions.top() );
            g->queued_global_effect_on_conditions.pop();
        }

        for( const queued_eoc &queue_entry : temp_queue ) {
            time_duration temp = queue_entry.time - calendar::turn;
            testfile << queue_entry.eoc.c_str() << ";" << to_string( temp ) << std::endl;
        }

        for( const queued_eoc &queued : temp_queue ) {
            g->queued_global_effect_on_conditions.push( queued );
        }

        testfile << "inactive eocs:" << std::endl;
        for( const effect_on_condition_id &eoc : g->inactive_global_effect_on_condition_vector ) {
            testfile << eoc.c_str() << std::endl;
        }

    }, "eocs test file" );
}

void effect_on_conditions::prevent_death()
{
    avatar &player_character = get_avatar();
    dialogue d( get_talker_for( player_character ), nullptr );
    for( const effect_on_condition &eoc : get_all() ) {
        if( eoc.type == eoc_type::PREVENT_DEATH ) {
            eoc.activate( d );
        }
        if( !player_character.is_dead_state() ) {
            player_character.clear_killer();
            break;
        }
    }
}

void effect_on_conditions::avatar_death()
{
    avatar &player_character = get_avatar();
    Creature *klr = player_character.get_killer();
    // Make sure the creature still exists in game
    klr = !klr ? klr : g->get_creature_if( [klr]( const Creature & c ) {
        return klr == &c;
    } );
    dialogue d( get_talker_for( get_avatar() ), klr == nullptr ? nullptr : get_talker_for( klr ) );
    for( const effect_on_condition &eoc : get_all() ) {
        if( eoc.type == eoc_type::AVATAR_DEATH ) {
            eoc.activate( d );
        }
    }
}

void effect_on_condition::finalize()
{
}

void effect_on_conditions::finalize_all()
{
    effect_on_condition_factory.finalize();
}

void effect_on_condition::check() const
{
}

const std::vector<effect_on_condition> &effect_on_conditions::get_all()
{
    return effect_on_condition_factory.get_all();
}

void effect_on_conditions::reset()
{
    effect_on_condition_factory.reset();
    pending_eoc_refs.clear();
}

void effect_on_conditions::load( const JsonObject &jo, const std::string &src )
{
    effect_on_condition_factory.load( jo, src );
}

void eoc_events::clear()
{
    has_cached = false;
    event_EOCs.clear();
}

void eoc_events::notify( const cata::event &e )
{
    notify( e, nullptr, nullptr );
}

void eoc_events::notify( const cata::event &e, std::unique_ptr<talker> alpha,
                         std::unique_ptr<talker> beta )
{
    if( !has_cached ) {

        // initialize all events to an empty vector
        for( event_type et = static_cast<event_type>( 0 ); et < event_type::num_event_types;
             et = static_cast<event_type>( static_cast<size_t>( et ) + 1 ) ) {

            event_EOCs[et] = std::vector<effect_on_condition>();
        }

        //create a cache for the specific types of EOC's so they aren't constantly all itterated through
        for( const effect_on_condition &eoc : effect_on_conditions::get_all() ) {
            if( eoc.type == eoc_type::EVENT ) {
                event_EOCs[eoc.required_event].emplace_back( eoc );
            }
        }

        has_cached = true;
    }

    for( const effect_on_condition &eoc : event_EOCs[e.type()] ) {
        if( !alpha ) {
            // try to assign a character for the EOC
            // TODO: refactor event_spec to take consistent inputs
            npc *alpha_talker = nullptr;
            const std::vector<std::string> potential_alphas = { "avatar_id", "character", "attacker", "killer", "npc" };
            for( const std::string &potential_key : potential_alphas ) {
                cata_variant cv = e.get_variant_or_void( potential_key );
                if( cv != cata_variant() ) {
                    character_id potential_id = cv.get<cata_variant_type::character_id>();
                    if( potential_id.is_valid() ) {
                        alpha_talker = g->find_npc( potential_id );
                        // if we find a successful entry exit early
                        break;
                    }
                }
            }
            if( alpha_talker ) {
                alpha = get_talker_for( alpha_talker );
            } else {
                alpha = get_talker_for( get_avatar() );
            }
        }
        dialogue d;
        global_variables::impl_t context;
        for( const auto &val : e.data() ) {
            context[val.first] = diag_value{ val.second };
        }

        // if we have an NPC to trigger this event for, do so,
        // otherwise fallback to having it effect the player
        d = dialogue( alpha->clone(), beta ? beta->clone() : nullptr, {}, context );

        eoc.activate( d );
    }
}
