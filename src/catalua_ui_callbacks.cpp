#if CATA_ENABLE_LUA_UI

#include "catalua_ui_callbacks.h"

#include <algorithm>
#include <stdexcept>
#include <utility>

namespace cata::lua_ui
{

const std::vector<script_hook_spec> &script_hook_specs()
{
    static const std::vector<script_hook_spec> specs = {
        {
            "on_character_death", script_hook_mode::observe,
            { "character", "killer" }
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
            { "alpha", "beta", "topic" }
        },
        {
            "on_dialogue_option", script_hook_mode::intercept,
            { "alpha", "beta", "topic", "option" }, { "result" }
        },
        {
            "on_dialogue_start", script_hook_mode::intercept,
            { "alpha", "beta", "topic" }, { "result" }
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

const std::vector<script_callback_kind_spec> &script_callback_kind_specs()
{
    static const std::vector<script_callback_kind_spec> specs = {
        {
            "iuse", "item", {
                { "can_use", true }, { "on_use", true }
            }
        },
        {
            "iwieldable", "item", {
                { "can_unwield", true }, { "can_wield", true },
                { "on_unwield", false }, { "on_wield", false }
            }
        },
        {
            "iwearable", "item", {
                { "can_takeoff", true }, { "can_wear", true },
                { "on_takeoff", false }, { "on_wear", false }
            }
        },
        {
            "iequippable", "item", {
                { "on_break", false }, { "on_durability_change", false },
                { "on_repair", false }
            }
        },
        {
            "istate", "item", {
                { "on_drop", true, true }, { "on_pickup", false },
                { "on_tick", false }
            }
        },
        {
            "imelee", "item", {
                { "on_block", false }, { "on_hit", false },
                { "on_melee_attack", true }, { "on_miss", false }
            }
        },
        {
            "iranged", "item", {
                { "can_fire", true }, { "can_reload", true },
                { "on_fire", true }, { "on_reload", false }
            }
        },
        {
            "bionic", "bionic", {
                { "on_activate", false }, { "on_deactivate", false },
                { "on_installed", false }, { "on_removed", false }
            }
        },
        {
            "mutation", "mutation", {
                { "on_activate", false }, { "on_deactivate", false },
                { "on_gain", false }, { "on_loss", false }
            }
        },
        {
            "trap", "trap", {
                { "can_trigger", true }, { "on_trigger", false },
                { "on_trigger_aftermath", false }
            }
        },
        {
            "monster", "monster", {
                { "get_examine_menu_entries", true },
                { "on_examine_menu_entry", false },
                { "on_tame", false }
            }
        }
    };
    return specs;
}

const script_callback_kind_spec *find_script_callback_kind_spec(
    const std::string_view kind )
{
    const std::vector<script_callback_kind_spec> &specs =
        script_callback_kind_specs();
    const auto found = std::find_if(
                           specs.begin(), specs.end(),
    [kind]( const script_callback_kind_spec & spec ) {
        return spec.kind == kind;
    } );
    return found == specs.end() ? nullptr : &*found;
}

const script_callback_method_spec *find_script_callback_method_spec(
    const script_callback_kind_spec &kind, const std::string_view method )
{
    const auto found = std::find_if(
                           kind.methods.begin(), kind.methods.end(),
    [method]( const script_callback_method_spec & spec ) {
        return spec.name == method;
    } );
    return found == kind.methods.end() ? nullptr : &*found;
}

std::uint64_t script_callback_registry::subscribe(
    std::string kind, std::string target, std::vector<std::string> methods,
    const int priority, const std::size_t source_index, const bool once )
{
    const script_callback_kind_spec *kind_spec =
        find_script_callback_kind_spec( kind );
    if( kind_spec == nullptr ) {
        throw std::invalid_argument( "unknown Lua callback actor kind: " + kind );
    }
    if( target.empty() || target.size() > 256 ) {
        throw std::invalid_argument(
            "Lua callback target must contain 1 to 256 bytes" );
    }
    if( methods.empty() ) {
        throw std::invalid_argument(
            "Lua callback registration requires at least one method" );
    }
    std::sort( methods.begin(), methods.end() );
    if( std::adjacent_find( methods.begin(), methods.end() ) != methods.end() ) {
        throw std::invalid_argument(
            "Lua callback registration repeats a method" );
    }
    for( const std::string &method : methods ) {
        if( find_script_callback_method_spec( *kind_spec, method ) == nullptr ) {
            throw std::invalid_argument(
                "unknown method '" + method + "' for Lua callback kind '" +
                kind + "'" );
        }
    }
    if( priority < minimum_priority || priority > maximum_priority ) {
        throw std::invalid_argument(
            "Lua callback priority must be within -10000..10000" );
    }
    if( registrations_.size() >= maximum_registrations ) {
        throw std::runtime_error( "Lua callback registration limit reached" );
    }
    const std::size_t target_count = static_cast<std::size_t>( std::count_if(
                                         registrations_.begin(), registrations_.end(),
    [&kind, &target]( const script_callback_registration & entry ) {
        return entry.kind == kind && entry.target == target;
    } ) );
    if( target_count >= maximum_registrations_per_target ) {
        throw std::runtime_error(
            "Lua callback per-target registration limit reached" );
    }

    const std::uint64_t id = next_id_++;
    registrations_.push_back( {
        id, std::move( kind ), std::move( target ), std::move( methods ),
        priority, source_index, next_sequence_++, once
    } );
    return id;
}

bool script_callback_registry::unsubscribe(
    const std::uint64_t id, const std::size_t source_index )
{
    const auto found = std::find_if(
                           registrations_.begin(), registrations_.end(),
    [id, source_index]( const script_callback_registration & entry ) {
        return entry.id == id && entry.source_index == source_index;
    } );
    if( found == registrations_.end() ) {
        return false;
    }
    registrations_.erase( found );
    return true;
}

bool script_callback_registry::unsubscribe_unchecked( const std::uint64_t id )
{
    const auto found = std::find_if(
                           registrations_.begin(), registrations_.end(),
    [id]( const script_callback_registration & entry ) {
        return entry.id == id;
    } );
    if( found == registrations_.end() ) {
        return false;
    }
    registrations_.erase( found );
    return true;
}

std::vector<script_callback_registration> script_callback_registry::matching(
    const std::string_view kind, const std::string_view target,
    const std::string_view method ) const
{
    std::vector<script_callback_registration> result;
    for( const script_callback_registration &entry : registrations_ ) {
        if( entry.kind == kind && entry.target == target &&
            std::find( entry.methods.begin(), entry.methods.end(), method ) !=
            entry.methods.end() ) {
            result.push_back( entry );
        }
    }
    std::stable_sort(
        result.begin(), result.end(),
        []( const script_callback_registration & left,
    const script_callback_registration & right ) {
        if( left.priority != right.priority ) {
            return left.priority > right.priority;
        }
        return left.sequence < right.sequence;
    } );
    return result;
}

bool script_callback_registry::contains( const std::uint64_t id ) const
{
    return std::any_of(
               registrations_.begin(), registrations_.end(),
    [id]( const script_callback_registration & entry ) {
        return entry.id == id;
    } );
}

std::size_t script_callback_registry::size() const
{
    return registrations_.size();
}

const std::vector<script_callback_registration> &
script_callback_registry::all() const
{
    return registrations_;
}

void script_callback_registry::clear()
{
    registrations_.clear();
    next_id_ = 1;
    next_sequence_ = 1;
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
