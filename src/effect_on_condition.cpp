#include "effect_on_condition.h"

#include <dialogue.h>
#include <dialogue_helpers.h>
#include <global_vars.h>
#include <algorithm>
#include <array>
#include <chrono>
#include <cstddef>
#include <iterator>
#include <list>
#include <memory>
#include <ostream>
#include <queue>
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
};

// These IDs are read from saves. The authored callbacks use their Lua names.
const std::array<character_task_migration, 31> migrated_character_tasks = {{
        { effect_on_condition_id( "EOC_VAMPIRE_DRINK_FROM_HUMAN_IN_COMBAT" ),
          "finish_combat_blood_feeding", nullptr },
        { effect_on_condition_id( "EOC_INVENTOR_RECIPE_GAIN" ),
          "inventor_recipe_due", "inventor_recipe_timer" },
        { effect_on_condition_id( "EOC_VAMPIRE_BLOOD_NUMBER_UI" ),
          "vampire_blood_display_due", "vampire_blood_display_timer" },
        { effect_on_condition_id( "EOC_VAMPIRE_ANATHEMA_BURN_IN_SUNLIGHT_CONTINUAL" ),
          "anathema_sun_burn_due", nullptr },
        { effect_on_condition_id( "EOC_XE_VAMPIRE_WEAKNESS_RESHUFFLE_SWITCHER" ),
          "vampire_weakness_reshuffle_due", nullptr },
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
          "void_spider_lair_exit_due", nullptr, true, "ccb" }
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

queued_eoc character_task_record( time_point due, std::string_view mod, std::string_view handler )
{
    return { lua_task_record, due, {
            { "mod", diag_value( std::string( mod ) ) },
            { "handler", diag_value( std::string( handler ) ) }
        }
    };
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
        std::string_view mod, std::string_view handler )
{
    queue_turn_task( actor.queued_effect_on_conditions, character_task_record( due, mod, handler ) );
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
                              std::map<effect_on_condition_id, bool> &new_eocs, Character *actor )
{
    const bool global_queue = actor == nullptr;
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
            temp_queued_eocs.push( character_task_record( entry.time, migration->mod,
                                   migration->handler ) );
            if( actor && migration->timer_key ) {
                cata::lua_platform::assign_persistent_value(
                    actor->lua_character_state.for_mod( migration->mod ), migration->timer_key,
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
        if( actor ) {
            if( const character_task_migration *migration = find_migrated_task( *eoc, false );
                migration && migration->timer_key ) {
                auto &state = actor->lua_character_state.for_mod( migration->mod );
                if( state.count( migration->timer_key ) == 0 ) {
                    cata::lua_platform::assign_persistent_value(
                        state, migration->timer_key, std::string( "dormant" ) );
                }
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
                      new_eocs, &you );
    if( is_avatar ) {
        process_new_eocs( g->queued_global_effect_on_conditions,
                          g->inactive_global_effect_on_condition_vector, new_eocs, nullptr );
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
            eoc_queue.list.erase( it );
            if( !mod_id.empty() && !handler_id.empty() ) {
                const character_action_guard lifetime( actor );
                cata::lua_platform::invoke_character_task( actor, due, mod_id, handler_id );
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
