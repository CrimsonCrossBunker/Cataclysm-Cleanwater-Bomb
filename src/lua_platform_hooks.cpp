#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_hooks.h"

#include <character_id.h>
#include <coordinates.h>
#include <creature.h>
#include <dialogue.h>
#include <item_uid.h>
#include <safe_reference.h>
#include <algorithm>
#include <exception>
#include <ostream>
#include <stdexcept>

#include "character.h"
#include "debug.h"
#include "item.h"
#include "item_location.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_runtime.h"
#include "talker.h"
#include "thread_pool.h"
#include "vehicle.h"

class npc;

namespace cata::lua_platform
{

native_callback_entity native_callback_entity::from_creature( Creature &value )
{
    native_callback_entity result;
    result.kind_ = native_callback_entity_kind::creature;
    result.creature_ = value.get_safe_reference();
    return result;
}

native_callback_entity native_callback_entity::from_item( item &value )
{
    native_callback_entity result;
    result.kind_ = native_callback_entity_kind::item;
    result.item_ = value.get_safe_reference();
    return result;
}

native_callback_entity native_callback_entity::from_vehicle( vehicle &value )
{
    native_callback_entity result;
    result.kind_ = native_callback_entity_kind::vehicle;
    result.vehicle_ = value.get_safe_reference();
    return result;
}

native_callback_entity::native_callback_entity( const Character *value ) :
    native_callback_entity( value == nullptr ? nullptr :
                            static_cast<const Creature *>( value ) )
{
}

native_callback_entity::native_callback_entity( const Creature *value ) :
    native_callback_entity()
{
    if( value != nullptr ) {
        *this = from_creature( const_cast<Creature &>( *value ) );
    }
}

native_callback_entity::native_callback_entity( const item *value ) :
    native_callback_entity()
{
    if( value != nullptr ) {
        *this = from_item( const_cast<item &>( *value ) );
    }
}

native_callback_entity::native_callback_entity( const vehicle *value ) :
    native_callback_entity()
{
    if( value != nullptr ) {
        *this = from_vehicle( const_cast<vehicle &>( *value ) );
    }
}

native_callback_entity_kind native_callback_entity::kind() const noexcept
{
    return kind_;
}

bool native_callback_entity::valid() const noexcept
{
    switch( kind_ ) {
        case native_callback_entity_kind::creature:
            return static_cast<bool>( creature_ );
        case native_callback_entity_kind::item:
            return static_cast<bool>( item_ );
        case native_callback_entity_kind::vehicle:
            return static_cast<bool>( vehicle_ );
        case native_callback_entity_kind::none:
            return false;
    }
    return false;
}

safe_reference<Creature> native_callback_entity::creature_reference() const noexcept
{
    return creature_;
}

safe_reference<item> native_callback_entity::item_reference() const noexcept
{
    return item_;
}

safe_reference<vehicle> native_callback_entity::vehicle_reference() const noexcept
{
    return vehicle_;
}

native_callback_talker snapshot_native_callback_talker( const const_talker &value )
{
    native_callback_talker result;
    result.present = true;
    result.name = value.disp_name();
    result.pos = value.pos_abs();
    if( const Creature *creature = value.get_const_creature() ) {
        result.entity = native_callback_entity( creature );
        result.kind = creature->is_avatar() ? "avatar" :
                      creature->is_npc() ? "npc" :
                      creature->is_monster() ? "monster" : "creature";
        if( const Character *character = creature->as_character() ) {
            result.stable_id = character->getID().get_value();
        }
    } else if( const item_location *location = value.get_const_item() ) {
        result.kind = "item";
        if( const item *item_value = location->get_item() ) {
            result.entity = native_callback_entity( item_value );
            result.stable_id = item_value->uid().get_value();
        } else {
            // Keep an explicitly invalid entity marker so a session cannot
            // turn a removed item talker into a detached snapshot.
            result.entity = native_callback_entity();
        }
    } else if( value.get_const_vehicle() != nullptr ) {
        result.entity = native_callback_entity( value.get_const_vehicle() );
        result.kind = "vehicle";
    } else if( value.get_const_computer() != nullptr ) {
        result.kind = "computer";
    } else if( value.get_const_zone() != nullptr ) {
        result.kind = "zone";
    } else if( result.name.empty() ) {
        result.kind = "topic";
    } else {
        result.kind = "talker";
    }
    return result;
}

native_callback_value::native_callback_value( const Character *value ) :
    value_( native_callback_entity( value ) )
{
}

native_callback_value::native_callback_value( const Creature *value ) :
    value_( native_callback_entity( value ) )
{
}

native_callback_value::native_callback_value( const item *value ) :
    value_( native_callback_entity( value ) )
{
}

native_callback_value::native_callback_value( const vehicle *value ) :
    value_( native_callback_entity( value ) )
{
}

native_callback_value::native_callback_value( const const_talker *value ) :
    value_( value == nullptr ? native_callback_talker{} :
            snapshot_native_callback_talker( *value ) )
{
}

native_callback_value &native_callback_value::operator=( const Character *value )
{
    value_ = native_callback_entity( value );
    return *this;
}

native_callback_value &native_callback_value::operator=( const Creature *value )
{
    value_ = native_callback_entity( value );
    return *this;
}

native_callback_value &native_callback_value::operator=( const item *value )
{
    value_ = native_callback_entity( value );
    return *this;
}

native_callback_value &native_callback_value::operator=( const vehicle *value )
{
    value_ = native_callback_entity( value );
    return *this;
}

native_callback_value &native_callback_value::operator=( const const_talker *value )
{
    value_ = value == nullptr ? native_callback_talker{} :
             snapshot_native_callback_talker( *value );
    return *this;
}

bool native_hook_supports_result_field( const std::string_view name,
                                        const std::string_view field )
{
    const script_hook_spec *spec = find_script_hook_spec( name );
    return spec != nullptr && script_hook_supports_result( *spec, field );
}

bool native_hook_contract_exists( const std::string_view name )
{
    return find_script_hook_spec( name ) != nullptr;
}

native_hook_result dispatch_native_hook_result(
    const std::string_view name,
    const native_callback_arguments &arguments )
{
    if( is_pool_worker_thread() ) {
        return {};
    }
    try {
        return dispatch_runtime_hook( name, arguments, {} );
    } catch( const std::exception &exception ) {
        DebugLog( D_ERROR, D_MAIN ) << "Lua-first Platform native hook '"
                                    << name << "' failed: " << exception.what();
        return {};
    }
}

bool dispatch_native_hook(
    const std::string_view name,
    const native_callback_arguments &arguments )
{
    return dispatch_native_hook_result( name, arguments ).allowed;
}

namespace
{

bool dispatch_character_fatal( const std::string_view hook,
                               Character &character, const Creature *killer )
{
    const bool allowed = dispatch_native_hook( hook, {
        { "character", static_cast<const Character *>( &character ) },
        { "killer", killer }
    } );
    if( !allowed ) {
        character.prevent_death();
    }
    return allowed;
}

} // namespace

bool dispatch_avatar_fatal( Character &character, const Creature *killer )
{
    return dispatch_character_fatal( "on_avatar_fatal", character, killer );
}

bool dispatch_npc_fatal( Character &character, const Creature *killer )
{
    const npc *npc_value = character.as_npc();
    if( !character.is_npc() || npc_value == nullptr ) {
        return false;
    }
    // npc::die() calls this at the synchronous fatal boundary before its
    // logical dead flag is committed.  A fatal Character may already report
    // zero vital HP, so do not reject the boundary on is_dead_state(); reject
    // only an unpublishable stable identity and let native death proceed.
    if( !character.getID().is_valid() ) {
        return true;
    }
    return dispatch_character_fatal( "on_npc_fatal", character, killer );
}

bool has_native_hook( const std::string_view name )
{
    return !is_pool_worker_thread() && has_runtime_hook( name );
}

std::vector<std::string> collect_native_mapgen_factory_usages(
    const std::vector<std::string> &candidates )
{
    if( is_pool_worker_thread() ) {
        return {};
    }
    return dispatch_native_hook_result(
    "on_make_mapgen_factory_list", {
        { "candidates", candidates }
    } ).results;
}

void dispatch_native_monster_spawn(
    const Creature &monster, const std::string_view source )
{
    const bool has_creature_spawn = has_native_hook( "on_creature_spawn" );
    const bool has_monster_spawn = has_native_hook( "on_monster_spawn" );
    if( !has_creature_spawn && !has_monster_spawn ) {
        return;
    }
    native_callback_arguments payload = {
        { "creature", &monster },
        { "source", std::string( source ) }
    };
    if( has_creature_spawn ) {
        dispatch_native_hook( "on_creature_spawn", payload );
    }
    if( has_monster_spawn ) {
        payload.front().name = "monster";
        dispatch_native_hook( "on_monster_spawn", payload );
    }
}

void dispatch_native_npc_spawn(
    const Character &npc, const std::string_view source )
{
    // A spawn producer must prove the concrete NPC subtype and identity
    // before a safe-reference payload is published.  An invalid or already
    // dead Character is not a recoverable NPC event.
    if( !npc.is_npc() || !npc.getID().is_valid() || npc.is_dead_state() ) {
        return;
    }
    const bool has_creature_spawn = has_native_hook( "on_creature_spawn" );
    const bool has_npc_spawn = has_native_hook( "on_npc_spawn" );
    if( !has_creature_spawn && !has_npc_spawn ) {
        return;
    }
    native_callback_arguments payload = {
        { "creature", static_cast<const Creature *>( &npc ) },
        { "source", std::string( source ) }
    };
    if( has_creature_spawn ) {
        dispatch_native_hook( "on_creature_spawn", payload );
    }
    if( has_npc_spawn ) {
        payload.front().name = "npc";
        payload.front().value = &npc;
        dispatch_native_hook( "on_npc_spawn", payload );
    }
}

std::string dispatch_character_display_skill_info(
    const Character &character, const std::string_view skill )
{
    if( !has_native_hook( "on_character_display_skill_info" ) ) {
        return {};
    }
    return dispatch_native_hook_result( "on_character_display_skill_info", {
        { "character", &character },
        { "skill", native_callback_id { "skill", std::string( skill ) } }
    } ).text;
}

bool dispatch_character_display_skill_action(
    const Character &character, const std::string_view skill,
    const std::string_view action )
{
    if( !has_native_hook( "on_character_display_skill_action" ) ) {
        return false;
    }
    return dispatch_native_hook_result( "on_character_display_skill_action", {
        { "character", &character },
        { "skill", native_callback_id { "skill", std::string( skill ) } },
        { "action", std::string( action ) }
    } ).handled;
}

native_hook_result dispatch_native_dialogue_hook(
    const std::string_view name, const const_talker &speaker,
    const const_talker &interlocutor, const std::string_view topic,
    const std::optional<std::string_view> option,
    const bool by_radio, const std::optional<std::string_view> reason )
{
    const char *topic_field = name == "on_dialogue_start" ? "initial_topic" :
                              name == "on_dialogue_end" ? "last_topic" :
                              "current_topic";
    const char *option_field = "selected_topic";
    native_callback_arguments payload = {
        { "speaker", snapshot_native_callback_talker( speaker ) },
        { "interlocutor", snapshot_native_callback_talker( interlocutor ) },
        { "by_radio", by_radio },
        { "reason", reason ? std::string( *reason ) : std::string() }
    };
    payload.push_back( { topic_field, std::string( topic ) } );
    if( option ) {
        payload.push_back( {
            option_field, std::string( *option )
        } );
    }
    return dispatch_native_hook_result( name, payload );
}

void clear_dialogue_response_callbacks()
{
    cata::lua_platform::dialogue::clear_response_callbacks(
        cata::lua_platform::dialogue::response_callback_origin::platform );
}

void begin_dialogue_session( ::dialogue &d )
{
    cata::lua_platform::dialogue::begin_dialogue( d );
}

void end_dialogue_session( ::dialogue &d ) noexcept
{
    cata::lua_platform::dialogue::end_session( d );
}

std::optional<std::string> dialogue_dynamic_line(
    ::dialogue &d, const talk_topic &topic )
{
    return platform_dialogue_dynamic_line( d, topic );
}

void apply_lua_dialogue_speaker_effects(
    ::dialogue &d, const talk_topic &topic )
{
    apply_platform_dialogue_speaker_effects( d, topic );
}

bool gen_lua_dialogue_responses(
    ::dialogue &d, const talk_topic &topic )
{
    return gen_platform_dialogue_responses( d, topic );
}

void extend_lua_dialogue_responses(
    ::dialogue &d, const talk_topic &topic )
{
    extend_platform_dialogue_responses( d, topic );
}

talk_topic apply_lua_dialogue_response(
    ::dialogue &d, const std::uint64_t response_id,
    const talk_topic &fallback, const bool trial_success )
{
    return cata::lua_platform::dialogue::apply_response_callback(
               d, response_id, fallback, trial_success );
}

bool begin_native_npc_interaction(
    const Character &avatar, const Character &npc )
{
    const native_callback_arguments payload = {
        { "avatar", &avatar },
        { "npc", &npc }
    };
    if( !dispatch_native_hook( "on_try_npc_interaction", payload ) ) {
        return false;
    }
    dispatch_native_hook( "on_npc_interaction", payload );
    return true;
}

bool allow_native_monster_interaction(
    const Character &avatar, const Creature &monster )
{
    return dispatch_native_hook( "on_try_monster_interaction", {
        { "avatar", &avatar },
        { "monster", &monster }
    } );
}

bool allow_native_elevator_use(
    const Character &character,
    const native_callback_point &position,
    const native_callback_point &destination )
{
    return dispatch_native_hook( "on_elevator_try_use", {
        { "character", &character },
        { "position", position },
        { "destination", destination }
    } );
}

std::vector<native_menu_entry> collect_native_hook_menu_entries(
    const std::string_view name,
    const native_callback_arguments &arguments )
{
    return dispatch_native_hook_result( name, arguments ).menu_entries;
}

const std::vector<script_hook_spec> &script_hook_specs()
{
    static const std::vector<script_hook_spec> specs = {
        {
            "on_character_death", script_hook_mode::observe,
            { "character", "killer" }
        },
        {
            "on_avatar_fatal", script_hook_mode::intercept,
            { "character", "killer" }, { "allow" }
        },
        {
            "on_bionic_activated", script_hook_mode::observe,
            {
                "character", "bionic", "bionic_uid",
                "activation_cost_millijoules"
            }
        },
        {
            "on_bionic_deactivated", script_hook_mode::observe,
            {
                "character", "bionic", "bionic_uid",
                "deactivation_cost_millijoules"
            }
        },
        {
            "on_bionic_processed", script_hook_mode::observe,
            {
                "character", "bionic", "bionic_uid",
                "over_time_energy_millijoules"
            }
        },
        {
            "on_mutation_activated", script_hook_mode::observe,
            { "character", "mutation" }
        },
        {
            "on_mutation_deactivated", script_hook_mode::observe,
            { "character", "mutation" }
        },
        {
            "on_mutation_processed", script_hook_mode::observe,
            { "character", "mutation", "activation_cost", "cooldown_turns" }
        },
        {
            "on_npc_fatal", script_hook_mode::intercept,
            { "character", "killer" }, { "allow" }
        },
        {
            "on_character_display_skill_action", script_hook_mode::intercept,
            { "character", "skill", "action" }, { "handled" }
        },
        {
            "on_character_display_skill_info", script_hook_mode::intercept,
            { "character", "skill" }, { "text" }
        },
        {
            "on_character_effect", script_hook_mode::observe,
            { "character", "effect", "body_part", "intensity" }
        },
        {
            "on_character_effect_added", script_hook_mode::observe,
            { "character", "effect", "body_part", "intensity" }
        },
        {
            "on_character_effect_removed", script_hook_mode::observe,
            { "character", "effect", "body_part" }
        },
        {
            "on_character_reset_stats", script_hook_mode::observe,
            { "character" }
        },
        {
            "on_character_try_move", script_hook_mode::intercept,
            {
                "character", "from", "to", "movement_mode",
                "via_ramp", "mounted", "mount"
            }, { "allow" }
        },
        {
            "on_control_npc", script_hook_mode::observe,
            { "avatar", "npc", "debug" }
        },
        {
            "on_craft_result", script_hook_mode::observe,
            { "character", "recipe", "result", "batch" }
        },
        {
            "on_creature_blocked", script_hook_mode::observe,
            { "creature", "source", "damage_blocked" }
        },
        {
            "on_creature_do_turn", script_hook_mode::observe,
            { "creature" }
        },
        {
            "on_creature_dodged", script_hook_mode::observe,
            { "creature", "source" }
        },
        {
            "on_creature_loaded", script_hook_mode::observe,
            { "creature" }
        },
        {
            "on_creature_melee_attacked", script_hook_mode::observe,
            { "attacker", "target", "weapon" }
        },
        {
            "on_creature_performed_technique", script_hook_mode::observe,
            { "creature", "target", "technique" }
        },
        {
            "on_creature_spawn", script_hook_mode::observe,
            { "creature", "source" }
        },
        {
            "on_dialogue_end", script_hook_mode::observe,
            { "speaker", "interlocutor", "last_topic", "by_radio", "reason" }
        },
        {
            "on_dialogue_option", script_hook_mode::intercept,
            { "speaker", "interlocutor", "current_topic", "selected_topic", "by_radio", "reason" },
            { "result" }
        },
        {
            "on_dialogue_start", script_hook_mode::intercept,
            { "speaker", "interlocutor", "initial_topic", "by_radio", "reason" },
            { "result" }
        },
        {
            "on_elevator_try_use", script_hook_mode::intercept,
            { "character", "position", "destination" }, { "allow" }
        },
        {
            "on_explosion_start", script_hook_mode::observe,
            { "position", "power", "source" }
        },
        { "on_game_load", script_hook_mode::observe, {} },
        { "on_game_save", script_hook_mode::observe, {} },
        { "on_game_started", script_hook_mode::observe, {} },
        {
            "on_make_mapgen_factory_list", script_hook_mode::intercept,
            { "candidates" }, { "results" }
        },
        {
            "on_mapgen_postprocess", script_hook_mode::observe,
            { "context" }
        },
        {
            "on_mission_end", script_hook_mode::observe,
            { "mission", "success" }
        },
        {
            "on_mission_start", script_hook_mode::observe,
            { "mission" }
        },
        {
            "on_mon_death", script_hook_mode::observe,
            { "monster", "killer" }
        },
        {
            "on_mon_effect", script_hook_mode::observe,
            { "monster", "effect", "body_part", "intensity" }
        },
        {
            "on_mon_effect_added", script_hook_mode::observe,
            { "monster", "effect", "body_part", "intensity" }
        },
        {
            "on_mon_effect_removed", script_hook_mode::observe,
            { "monster", "effect", "body_part" }
        },
        {
            "on_monster_do_turn", script_hook_mode::observe,
            { "monster" }
        },
        {
            "on_monster_examine_menu_entry", script_hook_mode::observe,
            { "character", "monster", "entry" }
        },
        {
            "on_monster_get_examine_menu_entries", script_hook_mode::intercept,
            { "character", "monster" }, { "entries" }
        },
        {
            "on_monster_loaded", script_hook_mode::observe,
            { "monster" }
        },
        {
            "on_monster_spawn", script_hook_mode::observe,
            { "monster", "source" }
        },
        {
            "on_monster_tame", script_hook_mode::observe,
            { "character", "monster" }
        },
        {
            "on_monster_try_move", script_hook_mode::intercept,
            { "monster", "from", "to", "force" }, { "allow" }
        },
        {
            "on_mortar_fired", script_hook_mode::observe,
            { "character", "source", "target", "furniture", "ammunition" }
        },
        {
            "on_npc_do_turn", script_hook_mode::observe,
            { "npc" }
        },
        {
            "on_npc_interaction", script_hook_mode::observe,
            { "avatar", "npc" }
        },
        {
            "on_npc_loaded", script_hook_mode::observe,
            { "npc" }
        },
        {
            "on_npc_spawn", script_hook_mode::observe,
            { "npc", "source" }
        },
        {
            "on_npc_try_move", script_hook_mode::intercept,
            {
                "npc", "from", "to", "movement_mode",
                "via_ramp", "mounted", "mount"
            }, { "allow" }
        },
        {
            "on_player_try_move", script_hook_mode::intercept,
            {
                "player", "from", "to", "movement_mode",
                "via_ramp", "mounted", "mount"
            }, { "allow" }
        },
        {
            "on_shoot", script_hook_mode::observe,
            { "character", "weapon", "target", "shots" }
        },
        {
            "on_throw", script_hook_mode::observe,
            { "character", "item", "target" }
        },
        {
            "on_try_monster_interaction", script_hook_mode::intercept,
            { "avatar", "monster" }, { "allow" }
        },
        {
            "on_try_npc_interaction", script_hook_mode::intercept,
            { "avatar", "npc" }, { "allow" }
        },
        {
            "on_weather_changed", script_hook_mode::observe,
            { "before", "after" }
        },
        {
            "on_weather_updated", script_hook_mode::observe,
            { "weather", "temperature", "windpower" }
        }
    };
    return specs;
}

const script_hook_spec *find_script_hook_spec( const std::string_view name )
{
    const std::vector<script_hook_spec> &specs = script_hook_specs();
    const auto found = std::find_if(
                           specs.begin(), specs.end(),
    [name]( const script_hook_spec & spec ) {
        return spec.name == name;
    } );
    return found == specs.end() ? nullptr : &*found;
}

bool script_hook_supports_result(
    const script_hook_spec &spec, const std::string_view field )
{
    return std::find(
               spec.result_fields.begin(), spec.result_fields.end(),
               field ) != spec.result_fields.end();
}

std::string_view script_hook_mode_name( const script_hook_mode mode )
{
    switch( mode ) {
        case script_hook_mode::observe:
            return "observe";
        case script_hook_mode::intercept:
            return "intercept";
    }
    throw std::invalid_argument( "unknown Lua hook mode" );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
