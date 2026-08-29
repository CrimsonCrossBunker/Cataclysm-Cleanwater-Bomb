#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_effects.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "bodypart.h"
#include "calendar.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "creature.h"
#include "effect.h"
#include "type_id.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_effect_limit = 64;
constexpr int maximum_effect_limit = 256;
constexpr std::size_t maximum_effect_relation_ids = 64;
constexpr int maximum_effect_assignment_intensity = 1000000;
constexpr int maximum_effect_intensity_delta = 1000;

void require_id_kind( const script_game_id &id, const std::string &kind,
                      const std::string &api_name )
{
    if( id.kind() != kind ) {
        throw std::invalid_argument(
            api_name + " requires GameId<" + kind + ">" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<" + kind + ">" );
    }
}

int effect_limit( const sol::optional<int> &requested,
                  const std::string &api_name )
{
    const int result = requested.value_or( default_effect_limit );
    if( result < 0 ) {
        throw std::invalid_argument(
            api_name + " limit cannot be negative" );
    }
    return std::min( result, maximum_effect_limit );
}

std::optional<bodypart_id> effect_body_part(
    const Creature &creature,
    const std::optional<script_game_id> &requested,
    const std::string &api_name )
{
    if( !requested ) {
        return std::nullopt;
    }
    require_id_kind( *requested, "body_part", api_name );
    const bodypart_id result =
        bodypart_str_id( requested->value() ).id();
    const std::vector<bodypart_id> available =
        creature.get_all_body_parts();
    if( std::find( available.begin(), available.end(), result ) ==
        available.end() ) {
        throw std::invalid_argument(
            api_name + " body part is not present on this creature" );
    }
    return result;
}

template<typename Id>
sol::table typed_id_page(
    sol::state_view lua, const std::vector<Id> &ids,
    const std::string &kind )
{
    const std::size_t returned = std::min(
                                     ids.size(),
                                     maximum_effect_relation_ids );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] =
            script_game_id( kind, ids[index].str() );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ids.size();
    result["returned"] = returned;
    result["truncated"] = returned < ids.size();
    return result;
}

sol::table snapshot_effect(
    sol::state_view lua, const effect &entry )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "effect", entry.get_id().str() );
    result["name"] = entry.disp_name();
    result["description"] = entry.disp_desc();
    result["short_description"] = entry.disp_short_desc();
    result["mod_source"] = entry.disp_mod_source_info();
    result["uses_body_part_description"] =
        entry.use_part_descs();
    result["duration"] = script_time_duration::from_native(
                             entry.get_duration() );
    result["maximum_duration"] =
        script_time_duration::from_native(
            entry.get_max_duration() );
    result["start_time"] = script_time_point::from_native(
                               entry.get_start_time() );
    result["intensity"] = entry.get_intensity();
    result["maximum_intensity"] = entry.get_max_intensity();
    result["maximum_effective_intensity"] =
        entry.get_max_effective_intensity();
    result["effective_intensity"] =
        entry.get_effective_intensity();
    result["permanent"] = entry.is_permanent();
    result["impairs_movement"] = entry.impairs_movement();
    result["harmful_cough"] = entry.get_harmful_cough();
    result["duration_add_percent"] =
        entry.get_dur_add_perc();
    result["intensity_add"] = entry.get_int_add_val();
    result["intensity_duration"] =
        script_time_duration::from_native(
            entry.get_int_dur_factor() );

    const bodypart_str_id body_part = entry.get_bp().id();
    if( body_part.is_null() ) {
        result["body_part"] = sol::nil;
    } else {
        result["body_part"] = script_game_id(
                                  "body_part", body_part.str() );
    }

    sol::table resisted_by = lua.create_table();
    resisted_by["mutations"] = typed_id_page(
                                   lua, entry.get_resist_traits(),
                                   "mutation" );
    resisted_by["effects"] = typed_id_page(
                                 lua, entry.get_resist_effects(),
                                 "effect" );
    result["resisted_by"] = std::move( resisted_by );
    result["removes_effects"] = typed_id_page(
                                    lua, entry.get_removes_effects(),
                                    "effect" );
    result["blocks_effects"] = typed_id_page(
                                   lua, entry.get_blocks_effects(),
                                   "effect" );
    return result;
}

const effect *find_effect(
    const Creature &creature, const efftype_id &id,
    const std::optional<bodypart_id> &body_part )
{
    const std::vector<std::reference_wrapper<const effect>> effects =
                creature.get_effects();
    const auto found = std::find_if(
                           effects.begin(), effects.end(),
    [&id, &body_part]( const std::reference_wrapper<const effect> &candidate ) {
        return candidate.get().get_id() == id &&
               ( !body_part ||
                 candidate.get().get_bp() == *body_part );
    } );
    return found == effects.end() ? nullptr : &found->get();
}

effect *find_effect(
    Creature &creature, const efftype_id &id,
    const std::optional<bodypart_id> &body_part )
{
    const effect *selected = find_effect(
                                 static_cast<const Creature &>( creature ),
                                 id, body_part );
    return selected == nullptr ? nullptr :
           &creature.get_effect( id, selected->get_bp() );
}

sol::table list_effects(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_limit,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const int limit = effect_limit(
                          requested_limit, "services.effects.list" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::vector<std::reference_wrapper<const effect>> effects =
                creature->get_effects();
    const std::size_t returned = std::min(
                                     effects.size(),
                                     static_cast<std::size_t>( limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] =
            snapshot_effect( state, effects[index].get() );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = effects.size();
    value["returned"] = returned;
    value["limit"] = limit;
    value["truncated"] = returned < effects.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table has_effect(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::optional<script_game_id> &requested_body_part,
    const std::optional<double> &requested_intensity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "effect", "services.effects.has" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bodypart_id> body_part =
        effect_body_part(
            *creature, requested_body_part,
            "services.effects.has" );
    if( requested_intensity &&
        ( !std::isfinite( *requested_intensity ) ||
          *requested_intensity < -1000000.0 ||
          *requested_intensity > 1000000.0 ) ) {
        throw std::invalid_argument(
            "services.effects.has intensity must be finite and within -1000000..1000000" );
    }
    const efftype_id id( requested_id.value() );
    const effect *entry = find_effect( *creature, id, body_part );
    const bool present = entry != nullptr &&
                         ( !requested_intensity ||
                           entry->get_intensity() >= *requested_intensity );
    return make_game_value_result(
               state, sol::make_object( state, present ) );
}

sol::table get_effect(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::optional<script_game_id> &requested_body_part,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "effect", "services.effects.get" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bodypart_id> body_part =
        effect_body_part(
            *creature, requested_body_part,
            "services.effects.get" );
    const effect *entry = find_effect(
                              *creature,
                              efftype_id( requested_id.value() ),
                              body_part );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The creature does not have the requested effect"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_effect( state, *entry ) ) );
}

struct effect_add_options {
    std::optional<script_game_id> body_part;
    bool permanent = false;
    int intensity = 0;
    bool force = false;
};

effect_add_options read_add_options(
    const sol::optional<sol::table> &requested )
{
    effect_add_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.effects.add option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "body_part" ) {
            if( !value.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "services.effects.add body_part must be a GameId" );
            }
            result.body_part = value.as<script_game_id>();
        } else if( key == "permanent" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "services.effects.add permanent must be a boolean" );
            }
            result.permanent = value.as<bool>();
        } else if( key == "intensity" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.effects.add intensity must be an integer" );
            }
            const lua_Integer intensity = value.as<lua_Integer>();
            if( intensity < 0 ||
                intensity > maximum_effect_assignment_intensity ) {
                throw std::invalid_argument(
                    "services.effects.add intensity is outside its limit" );
            }
            result.intensity = static_cast<int>( intensity );
        } else if( key == "force" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "services.effects.add force must be a boolean" );
            }
            result.force = value.as<bool>();
        } else {
            throw std::invalid_argument(
                "services.effects.add received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

void validate_effect_duration(
    const script_time_duration &duration,
    const std::string &api_name )
{
    const std::int64_t maximum =
        to_turns<std::int64_t>( 365_days );
    if( duration.turns() <= 0 ||
        duration.turns() > maximum ) {
        throw std::invalid_argument(
            api_name +
            " duration must be between one turn and 365 days" );
    }
}

sol::table add_effect(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const script_time_duration &duration,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "effect", "services.effects.add" );
    validate_effect_duration( duration, "services.effects.add" );
    const effect_add_options options =
        read_add_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bodypart_id> body_part =
        effect_body_part(
            *creature, options.body_part,
            "services.effects.add" );
    const efftype_id id( requested_id.value() );
    if( body_part ) {
        creature->add_effect(
            id, duration.to_native(), *body_part,
            options.permanent, options.intensity,
            options.force );
    } else {
        creature->add_effect(
            id, duration.to_native(), options.permanent,
            options.intensity, options.force );
    }
    const effect *entry = find_effect(
                              *creature, id, body_part );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "rejected",
            "The creature rejected the requested effect"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_effect( state, *entry ) ) );
}

sol::table remove_effect(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::optional<script_game_id> &requested_body_part,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "effect", "services.effects.remove" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bodypart_id> body_part =
        effect_body_part(
            *creature, requested_body_part,
            "services.effects.remove" );
    const efftype_id id( requested_id.value() );
    const bool removed = body_part ?
                         creature->remove_effect( id, *body_part ) :
                         creature->remove_effect( id );
    return make_game_value_result(
               state, sol::make_object( state, removed ) );
}

sol::table adjust_effect_intensity(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const std::int64_t requested_delta,
    const std::optional<script_game_id> &requested_body_part,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "effect", "services.effects.adjust_intensity" );
    if( requested_delta < -maximum_effect_intensity_delta ||
        requested_delta > maximum_effect_intensity_delta ) {
        throw std::invalid_argument(
            "services.effects.adjust_intensity delta must be within -1000..1000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bodypart_id> body_part =
        effect_body_part(
            *creature, requested_body_part,
            "services.effects.adjust_intensity" );
    const efftype_id id( requested_id.value() );
    effect *entry = find_effect( *creature, id, body_part );

    sol::table value = state.create_table();
    value["before"] = 0;
    value["after"] = 0;
    value["changed"] = false;
    value["removed"] = false;
    if( entry == nullptr ) {
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }

    const int before = entry->get_intensity();
    const std::int64_t requested_after =
        static_cast<std::int64_t>( before ) + requested_delta;
    value["before"] = before;
    if( requested_after <= 0 ) {
        const bodypart_id selected_body_part = entry->get_bp();
        const bool removed = creature->remove_effect(
                                 id, selected_body_part );
        value["changed"] = removed;
        value["removed"] = removed;
    } else {
        entry->set_intensity( static_cast<int>( requested_after ) );
        const int after = entry->get_intensity();
        value["after"] = after;
        value["changed"] = after != before;
        if( after != before ) {
            creature->notify_effect_int_change(
                entry->get_id(), after, entry->get_bp() );
        }
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct effect_update_options {
    std::optional<script_game_id> body_part;
    std::optional<script_time_duration> duration;
    std::optional<int> intensity;
    std::optional<bool> permanent;
};

effect_update_options read_update_options(
    const sol::table &requested )
{
    effect_update_options result;
    for( const auto &entry : requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.effects.update option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "body_part" ) {
            if( !value.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "services.effects.update body_part must be a GameId" );
            }
            result.body_part = value.as<script_game_id>();
        } else if( key == "duration" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.effects.update duration must be a TimeDuration" );
            }
            const script_time_duration duration =
                value.as<script_time_duration>();
            validate_effect_duration(
                duration, "services.effects.update" );
            result.duration = duration;
        } else if( key == "intensity" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.effects.update intensity must be an integer" );
            }
            const lua_Integer intensity = value.as<lua_Integer>();
            if( intensity < 1 ||
                intensity > maximum_effect_assignment_intensity ) {
                throw std::invalid_argument(
                    "services.effects.update intensity is outside its limit" );
            }
            result.intensity = static_cast<int>( intensity );
        } else if( key == "permanent" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "services.effects.update permanent must be a boolean" );
            }
            result.permanent = value.as<bool>();
        } else {
            throw std::invalid_argument(
                "services.effects.update received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table update_effect(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const sol::table &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "effect", "services.effects.update" );
    const effect_update_options options =
        read_update_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Creature *creature = resolve_exact_creature(
                             handle, runtime_generation,
                             world_generation, error );
    if( creature == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bodypart_id> body_part =
        effect_body_part(
            *creature, options.body_part,
            "services.effects.update" );
    effect *entry = find_effect(
                        *creature,
                        efftype_id( requested_id.value() ),
                        body_part );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The creature does not have the requested effect"
        } );
    }
    sol::table before = snapshot_effect( state, *entry );
    const int previous_intensity = entry->get_intensity();
    if( options.duration ) {
        entry->set_duration( options.duration->to_native() );
    }
    if( options.intensity ) {
        entry->set_intensity( *options.intensity );
    }
    if( options.permanent ) {
        if( *options.permanent ) {
            entry->pause_effect();
        } else {
            entry->unpause_effect();
        }
    }
    if( entry->get_intensity() != previous_intensity ) {
        creature->notify_effect_int_change(
            entry->get_id(), entry->get_intensity(), entry->get_bp() );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_effect( state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_effect_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    sol::table effects = lua.create_table();
    effects.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<int> &limit ) {
        require_read();
        return list_effects(
                   lua_state, handle, limit,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    effects.set_function(
        "has",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const std::optional<script_game_id> &body_part,
    const std::optional<double> &intensity ) {
        require_read();
        return has_effect(
                   lua_state, handle, id, body_part, intensity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    effects.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const std::optional<script_game_id> &body_part ) {
        require_read();
        return get_effect(
                   lua_state, handle, id, body_part,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    effects.set_function(
        "add",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
            const script_time_duration & duration,
    const sol::optional<sol::table> &options ) {
        require_write();
        return add_effect(
                   lua_state, handle, id, duration, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    effects.set_function(
        "remove",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const std::optional<script_game_id> &body_part ) {
        require_write();
        return remove_effect(
                   lua_state, handle, id, body_part,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    effects.set_function(
        "adjust_intensity",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id, const std::int64_t delta,
    const std::optional<script_game_id> &body_part ) {
        require_write();
        return adjust_effect_intensity(
                   lua_state, handle, id, delta, body_part,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    effects.set_function(
        "update",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const sol::table & options ) {
        require_write();
        return update_effect(
                   lua_state, handle, id, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["effects"] = std::move( effects );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
