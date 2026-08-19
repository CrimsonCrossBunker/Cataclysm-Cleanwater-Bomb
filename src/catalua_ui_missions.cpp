#if CATA_ENABLE_LUA_UI

#include "catalua_ui_missions.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_enums.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character_id.h"
#include "dialogue_helpers.h"
#include "enum_conversions.h"
#include "mission.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int default_instance_limit = 64;
constexpr int maximum_instance_limit = 256;
constexpr std::size_t maximum_offset = 1000000;
constexpr std::size_t maximum_relation_values = 128;
constexpr int maximum_mission_step = 1000000;

void require_mission_id(
    const script_game_id &id, const std::string &api_name )
{
    if( id.kind() != "mission" ) {
        throw std::invalid_argument(
            api_name + " requires GameId<mission>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<mission>" );
    }
}

std::optional<game_handle_error> mission_token_error(
    const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( !token.belongs_to( runtime_generation ) ) {
        return game_handle_error{
            "stale_runtime",
            "MissionToken belongs to an inactive or different Lua runtime"
        };
    }
    if( token.world_generation() != world_generation ) {
        return game_handle_error{
            "stale_world",
            "MissionToken belongs to a different world generation"
        };
    }
    if( mission::find( token.uid(), true ) == nullptr ) {
        return game_handle_error{
            "missing_mission",
            "The mission referenced by this MissionToken no longer exists"
        };
    }
    return std::nullopt;
}

mission *resolve_mission(
    const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    error = mission_token_error(
                token, runtime_generation, world_generation );
    return error ? nullptr :
           mission::find( token.uid(), true );
}

template<typename Id>
void set_optional_typed_id(
    sol::table &table, const std::string &field,
    const Id &id, const std::string &kind )
{
    if( id.is_null() ) {
        table[field] = sol::nil;
    } else {
        table[field] = script_game_id( kind, id.str() );
    }
}

template<typename Id>
void set_optional_string_id(
    sol::table &table, const std::string &field,
    const Id &id )
{
    if( id.is_null() ) {
        table[field] = sol::nil;
    } else {
        table[field] = id.str();
    }
}

sol::table duration_formula(
    sol::state_view lua, const duration_or_var &formula )
{
    sol::table result = lua.create_table();
    const bool minimum_constant =
        formula.min.is_constant();
    const bool has_maximum = formula.max.has_value();
    const bool maximum_constant =
        !has_maximum || formula.max->is_constant();
    if( minimum_constant ) {
        result["minimum"] =
            script_time_duration::from_native(
                formula.min.constant() );
    } else {
        result["minimum"] = sol::nil;
    }
    if( has_maximum ) {
        if( maximum_constant ) {
            result["maximum"] =
                script_time_duration::from_native(
                    formula.max->constant() );
        } else {
            result["maximum"] = sol::nil;
        }
    } else if( minimum_constant ) {
        result["maximum"] =
            script_time_duration::from_native(
                formula.min.constant() );
    } else {
        result["maximum"] = sol::nil;
    }
    result["random_range"] = has_maximum;
    result["dynamic"] =
        !minimum_constant || !maximum_constant;
    return result;
}

sol::table numeric_formula(
    sol::state_view lua, const dbl_or_var &formula )
{
    sol::table result = lua.create_table();
    const bool minimum_constant =
        formula.min.is_constant();
    const bool has_maximum = formula.max.has_value();
    const bool maximum_constant =
        !has_maximum || formula.max->is_constant();
    if( minimum_constant ) {
        result["minimum"] = formula.min.constant();
    } else {
        result["minimum"] = sol::nil;
    }
    if( has_maximum ) {
        if( maximum_constant ) {
            result["maximum"] =
                formula.max->constant();
        } else {
            result["maximum"] = sol::nil;
        }
    } else if( minimum_constant ) {
        result["maximum"] = formula.min.constant();
    } else {
        result["maximum"] = sol::nil;
    }
    result["random_range"] = has_maximum;
    result["dynamic"] =
        !minimum_constant || !maximum_constant;
    return result;
}

sol::table reward_page(
    sol::state_view lua,
    const talk_effect_fun_t::likely_rewards_t &rewards )
{
    const std::size_t total = rewards.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const auto &entry = rewards[index];
        sol::table item = lua.create_table();
        item["chance"] = numeric_formula(
                             lua, entry.first );
        item["dynamic_item"] =
            !entry.second.is_constant();
        if( entry.second.is_constant() ) {
            const std::string value =
                entry.second.constant();
            const script_game_id candidate(
                "item", value );
            if( candidate.is_valid() ) {
                item["item"] = candidate;
            } else {
                item["item"] = sol::nil;
            }
            item["item_value"] = value;
        } else {
            item["item"] = sol::nil;
            item["item_value"] = sol::nil;
        }
        items[index + 1] = std::move( item );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table origin_page(
    sol::state_view lua,
    const std::vector<mission_origin> &origins )
{
    const std::size_t total = origins.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = script_enum_value::from(
                               "MissionOrigin",
                               io::enum_to_string(
                                   origins[index] ) );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table dialogue_page(
    sol::state_view lua,
    const std::map<std::string, translation> &dialogue )
{
    const std::size_t total = dialogue.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &entry : dialogue ) {
        if( index >= returned ) {
            break;
        }
        sol::table item = lua.create_table();
        item["topic"] = entry.first;
        item["text"] = entry.second.translated();
        items[index + 1] = std::move( item );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table source_page(
    sol::state_view lua,
    const std::vector<std::pair<mission_type_id, mod_id>> &sources )
{
    const std::size_t total = sources.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        sol::table item = lua.create_table();
        item["mission"] = script_game_id(
                              "mission",
                              sources[index].first.str() );
        item["mod"] = script_game_id(
                          "mod",
                          sources[index].second.str() );
        items[index + 1] = std::move( item );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const mission_type &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "mission", definition.id.str() );
    result["name"] = definition.tname();
    result["description"] =
        definition.description.translated();
    result["goal"] = script_enum_value::from(
                         "MissionGoal",
                         io::enum_to_string(
                             definition.goal ) );
    result["difficulty"] = definition.difficulty;
    result["value"] = definition.value;
    result["deadline"] = duration_formula(
                             lua, definition.deadline );
    result["urgent"] = definition.urgent;
    result["has_generic_rewards"] =
        definition.has_generic_rewards;
    result["likely_rewards"] = reward_page(
                                   lua,
                                   definition.likely_rewards );
    result["origins"] = origin_page(
                            lua, definition.origins );

    set_optional_typed_id(
        result, "item", definition.item_id, "item" );
    set_optional_string_id(
        result, "item_group", definition.group_id );
    set_optional_typed_id(
        result, "container",
        definition.container_id, "item" );
    set_optional_typed_id(
        result, "empty_container",
        definition.empty_container, "item" );
    result["remove_container"] =
        definition.remove_container;
    result["invisible_on_complete"] =
        definition.invisible_on_complete;
    result["item_count"] = definition.item_count;
    set_optional_string_id(
        result, "recruit_class",
        definition.recruit_class );
    if( definition.target_npc_id.is_valid() ) {
        result["target_npc_id"] =
            definition.target_npc_id.get_value();
    } else {
        result["target_npc_id"] = sol::nil;
    }
    set_optional_typed_id(
        result, "monster",
        definition.monster_type, "monster" );
    set_optional_typed_id(
        result, "monster_species",
        definition.monster_species, "species" );
    result["monster_kill_goal"] =
        definition.monster_kill_goal;
    set_optional_string_id(
        result, "target_overmap_terrain",
        definition.target_id );
    set_optional_typed_id(
        result, "follow_up",
        definition.follow_up, "mission" );
    result["dialogue"] = dialogue_page(
                             lua, definition.dialogue );
    result["sources"] = source_page(
                            lua, definition.src );
    return result;
}

struct page_options {
    std::size_t offset = 0;
    int limit = 0;
};

page_options read_definition_options(
    const sol::optional<sol::table> &requested )
{
    page_options result;
    result.limit = default_definition_limit;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.missions.definitions option keys must be strings" );
        }
        const sol::object value = entry.second;
        if( !value.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "game.missions.definitions options must be integers" );
        }
        const lua_Integer number = value.as<lua_Integer>();
        if( number < 0 ) {
            throw std::invalid_argument(
                "game.missions.definitions options cannot be negative" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min<lua_Integer>(
                                    number, maximum_offset ) );
        } else if( key == "limit" ) {
            result.limit = static_cast<int>(
                               std::min<lua_Integer>(
                                   number,
                                   maximum_definition_limit ) );
        } else {
            throw std::invalid_argument(
                "game.missions.definitions received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options )
{
    const page_options options =
        read_definition_options( requested_options );
    std::vector<const mission_type *> definitions;
    const std::vector<mission_type> &all =
        mission_type::get_all();
    definitions.reserve( all.size() );
    for( const mission_type &definition : all ) {
        definitions.push_back( &definition );
    }
    std::sort(
        definitions.begin(), definitions.end(),
    []( const mission_type * lhs, const mission_type * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    const std::size_t offset = std::min(
                                   options.offset,
                                   definitions.size() );
    const std::size_t returned = std::min(
                                     definitions.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_definition(
                               state,
                               *definitions[offset + index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = definitions.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < definitions.size();
    return result;
}

sol::table get_definition(
    sol::this_state lua, const script_game_id &requested_id )
{
    require_mission_id(
        requested_id, "game.missions.definition" );
    sol::state_view state( lua );
    return snapshot_definition(
               state,
               mission_type_id(
                   requested_id.value() ).obj() );
}

std::string mission_status_name( const mission &entry )
{
    if( entry.has_failed() ) {
        return "failure";
    }
    if( entry.in_progress() ) {
        return "active";
    }
    if( !entry.is_assigned() ) {
        return "reserved";
    }
    return "success";
}

sol::table snapshot_instance(
    sol::state_view lua, const mission &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const avatar &player = get_avatar();
    sol::table result = lua.create_table();
    result["token"] = mission_token(
                          entry.get_id(),
                          runtime_generation,
                          world_generation );
    result["uid"] = entry.get_id();
    result["id"] = script_game_id(
                       "mission",
                       entry.mission_id().str() );
    result["name"] = entry.name();
    result["description"] =
        entry.get_description();
    result["status"] = mission_status_name( entry );
    result["assigned"] = entry.is_assigned();
    result["in_progress"] = entry.in_progress();
    result["failed"] = entry.has_failed();
    result["selected"] =
        player.get_active_mission() == &entry;
    result["has_deadline"] = entry.has_deadline();
    if( entry.has_deadline() ) {
        result["deadline"] =
            script_time_point::from_native(
                entry.get_deadline() );
    } else {
        result["deadline"] = sol::nil;
    }
    result["has_target"] = entry.has_target();
    if( entry.has_target() ) {
        result["target"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::overmap_terrain,
                entry.get_target().raw() );
    } else {
        result["target"] = sol::nil;
    }
    if( entry.has_follow_up() ) {
        result["follow_up"] = script_game_id(
                                  "mission",
                                  entry.get_follow_up().str() );
    } else {
        result["follow_up"] = sol::nil;
    }
    result["value"] = entry.get_value();
    set_optional_typed_id(
        result, "item",
        entry.get_item_id(), "item" );
    if( entry.get_npc_id().is_valid() ) {
        result["npc_id"] =
            entry.get_npc_id().get_value();
    } else {
        result["npc_id"] = sol::nil;
    }
    const character_id assigned =
        entry.get_assigned_player_id();
    if( assigned.is_valid() ) {
        result["assigned_player_id"] =
            assigned.get_value();
    } else {
        result["assigned_player_id"] = sol::nil;
    }
    result["likely_rewards"] = reward_page(
                                   lua,
                                   entry.get_likely_rewards() );
    result["has_generic_rewards"] =
        entry.has_generic_rewards();
    return result;
}

struct instance_options {
    std::size_t offset = 0;
    int limit = default_instance_limit;
    std::string scope = "all";
    std::string status = "all";
};

bool valid_scope( const std::string &scope )
{
    return scope == "all" || scope == "avatar";
}

bool valid_status( const std::string &status )
{
    return status == "all" ||
           status == "reserved" ||
           status == "active" ||
           status == "success" ||
           status == "failure";
}

instance_options read_instance_options(
    const sol::optional<sol::table> &requested )
{
    instance_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.missions.list option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "offset" || key == "limit" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "game.missions.list pagination options must be integers" );
            }
            const lua_Integer number =
                value.as<lua_Integer>();
            if( number < 0 ) {
                throw std::invalid_argument(
                    "game.missions.list pagination options cannot be negative" );
            }
            if( key == "offset" ) {
                result.offset = static_cast<std::size_t>(
                                    std::min<lua_Integer>(
                                        number, maximum_offset ) );
            } else {
                result.limit = static_cast<int>(
                                   std::min<lua_Integer>(
                                       number,
                                       maximum_instance_limit ) );
            }
        } else if( key == "scope" || key == "status" ) {
            if( value.get_type() != sol::type::string ) {
                throw std::invalid_argument(
                    "game.missions.list filters must be strings" );
            }
            if( key == "scope" ) {
                result.scope = value.as<std::string>();
                if( !valid_scope( result.scope ) ) {
                    throw std::invalid_argument(
                        "game.missions.list received an unknown scope" );
                }
            } else {
                result.status = value.as<std::string>();
                if( !valid_status( result.status ) ) {
                    throw std::invalid_argument(
                        "game.missions.list received an unknown status" );
                }
            }
        } else {
            throw std::invalid_argument(
                "game.missions.list received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table list_instances(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const instance_options options =
        read_instance_options( requested_options );
    const avatar &player = get_avatar();
    std::vector<mission *> entries =
        mission::get_all_active();
    entries.erase(
        std::remove_if(
            entries.begin(), entries.end(),
    [&options, &player]( const mission * entry ) {
        if( entry == nullptr ) {
            return true;
        }
        if( options.scope == "avatar" &&
            entry->get_assigned_player_id() !=
            player.getID() ) {
            return true;
        }
        return options.status != "all" &&
               mission_status_name( *entry ) !=
               options.status;
    } ),
    entries.end() );
    std::sort(
        entries.begin(), entries.end(),
    []( const mission * lhs, const mission * rhs ) {
        return lhs->get_id() < rhs->get_id();
    } );
    const std::size_t offset = std::min(
                                   options.offset, entries.size() );
    const std::size_t returned = std::min(
                                     entries.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_instance(
                               state,
                               *entries[offset + index],
                               runtime_generation,
                               world_generation );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = entries.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < entries.size();
    result["scope"] = options.scope;
    result["status"] = options.status;
    return result;
}

sol::table get_instance(
    sol::this_state lua, const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = snapshot_instance(
                           state, *entry,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table current_instance(
    sol::this_state lua,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    mission *entry = get_avatar().get_active_mission();
    if( entry == nullptr ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "The avatar has no selected mission"
        } );
    }
    sol::table value = snapshot_instance(
                           state, *entry,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table avatar_has_active(
    sol::this_state lua, const script_game_id &requested_id )
{
    require_mission_id(
        requested_id, "game.missions.avatar_has_active" );
    const mission_type_id requested_type(
        requested_id.value() );
    sol::state_view state( lua );
    for( mission *entry : get_avatar().get_active_missions() ) {
        if( entry->mission_id() == requested_type ) {
            return make_game_value_result(
                       state,
                       sol::make_object( state, true ) );
        }
    }
    return make_game_value_result(
               state,
               sol::make_object( state, false ) );
}

mission_origin require_origin(
    const script_enum_value &origin,
    const std::string &api_name )
{
    if( origin.kind() != "MissionOrigin" ||
        origin.ordinal() >=
        static_cast<std::size_t>( mission_origin::NUM_ORIGIN ) ) {
        throw std::invalid_argument(
            api_name + " requires GameEnum<MissionOrigin>" );
    }
    return static_cast<mission_origin>(
               origin.ordinal() );
}

tripoint_abs_omt require_absolute_omt(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() !=
        coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute overmap-terrain Tripoint" );
    }
    return tripoint_abs_omt( position.to_native() );
}

sol::table random_definition(
    sol::this_state lua, const script_enum_value &origin,
    const script_tripoint_coord &position )
{
    const mission_origin native_origin =
        require_origin(
            origin, "game.missions.random_definition" );
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "game.missions.random_definition" );
    sol::state_view state( lua );
    const mission_type_id id =
        mission_type::get_random_id(
            native_origin, native_position );
    if( id.is_null() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "No mission definition matched the requested origin and position"
        } );
    }
    return make_game_value_result(
               state,
               sol::make_object(
                   state,
                   script_game_id(
                       "mission", id.str() ) ) );
}

character_id requested_npc_id(
    const sol::optional<int> &requested )
{
    if( !requested ) {
        return character_id();
    }
    if( *requested < -1 ) {
        throw std::invalid_argument(
            "mission npc_id cannot be less than -1" );
    }
    return character_id( *requested );
}

sol::table reserve_instance(
    sol::this_state lua, const script_game_id &requested_id,
    const sol::optional<int> &npc_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mission_id(
        requested_id, "game.missions.reserve" );
    sol::state_view state( lua );
    mission *entry = mission::reserve_new(
                         mission_type_id(
                             requested_id.value() ),
                         requested_npc_id( npc_id ) );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, game_handle_error{
            "rejected",
            "The engine rejected the mission reservation"
        } );
    }
    sol::table value = snapshot_instance(
                           state, *entry,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table reserve_random_instance(
    sol::this_state lua, const script_enum_value &origin,
    const script_tripoint_coord &position,
    const sol::optional<int> &npc_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const mission_origin native_origin =
        require_origin(
            origin, "game.missions.reserve_random" );
    const tripoint_abs_omt native_position =
        require_absolute_omt(
            position, "game.missions.reserve_random" );
    sol::state_view state( lua );
    mission *entry = mission::reserve_random(
                         native_origin, native_position,
                         requested_npc_id( npc_id ) );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "No mission could be reserved for the requested origin and position"
        } );
    }
    sol::table value = snapshot_instance(
                           state, *entry,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table assign_instance(
    sol::this_state lua, const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( entry->is_assigned() ) {
        return make_game_error_result(
        state, game_handle_error{
            "already_assigned",
            "The mission is already assigned"
        } );
    }
    entry->assign( get_avatar() );
    if( !entry->is_assigned() ) {
        return make_game_error_result(
        state, game_handle_error{
            "rejected",
            "The engine rejected mission assignment"
        } );
    }
    sol::table value = snapshot_instance(
                           state, *entry,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_instance_deadline(
    sol::this_state lua, const mission_token &token,
    const sol::optional<script_time_point> &deadline,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = snapshot_instance(
                            state, *entry,
                            runtime_generation,
                            world_generation );
    entry->set_deadline(
        deadline ? deadline->to_native() : calendar::turn_zero );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_instance(
                         state, *entry,
                         runtime_generation,
                         world_generation );
    value["cleared"] = !deadline.has_value();
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

bool assigned_to_avatar( const mission &entry )
{
    return entry.get_assigned_player_id() ==
           get_avatar().getID();
}

sol::table select_instance(
    sol::this_state lua, const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !assigned_to_avatar( *entry ) ||
        !entry->in_progress() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_active",
            "Only an active avatar mission can be selected"
        } );
    }
    get_avatar().set_active_mission( *entry );
    sol::table value = snapshot_instance(
                           state, *entry,
                           runtime_generation,
                           world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table is_complete_instance(
    sol::this_state lua, const mission_token &token,
    const sol::optional<int> &npc_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool complete = entry->is_complete(
                              requested_npc_id( npc_id ) );
    return make_game_value_result(
               state,
               sol::make_object( state, complete ) );
}

sol::table step_instance(
    sol::this_state lua, const mission_token &token,
    const int step,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( step < 0 || step > maximum_mission_step ) {
        throw std::invalid_argument(
            "game.missions.step_complete step is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !assigned_to_avatar( *entry ) ||
        !entry->in_progress() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_active",
            "Only an active avatar mission can advance"
        } );
    }
    sol::table before = snapshot_instance(
                            state, *entry,
                            runtime_generation,
                            world_generation );
    entry->step_complete( step );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_instance(
                         state, *entry,
                         runtime_generation,
                         world_generation );
    value["step"] = step;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table fail_instance(
    sol::this_state lua, const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !assigned_to_avatar( *entry ) ||
        !entry->in_progress() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_active",
            "Only an active avatar mission can fail"
        } );
    }
    sol::table before = snapshot_instance(
                            state, *entry,
                            runtime_generation,
                            world_generation );
    entry->fail();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_instance(
                         state, *entry,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table complete_instance(
    sol::this_state lua, const mission_token &token,
    const sol::optional<bool> &force,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !assigned_to_avatar( *entry ) ||
        !entry->in_progress() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_active",
            "Only an active avatar mission can complete"
        } );
    }
    const bool goal_complete =
        entry->is_complete( entry->get_npc_id() );
    if( !goal_complete && !force.value_or( false ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "goal_incomplete",
            "The mission goal is incomplete; use force=true "
            "for an explicit override"
        } );
    }
    sol::table before = snapshot_instance(
                            state, *entry,
                            runtime_generation,
                            world_generation );
    entry->wrap_up();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_instance(
                         state, *entry,
                         runtime_generation,
                         world_generation );
    value["forced"] =
        force.value_or( false ) && !goal_complete;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table cancel_reserved_instance(
    sol::this_state lua, const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( entry->is_assigned() ) {
        return make_game_error_result(
        state, game_handle_error{
            "assigned",
            "Assigned missions must be abandoned instead of cancelled"
        } );
    }
    sol::table before = snapshot_instance(
                            state, *entry,
                            runtime_generation,
                            world_generation );
    const bool removed =
        mission::remove_unassigned( token.uid() );
    sol::table value = state.create_table();
    value["cancelled"] = std::move( before );
    value["removed"] = removed;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table abandon_instance(
    sol::this_state lua, const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    mission *entry = resolve_mission(
                         token, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !assigned_to_avatar( *entry ) ||
        !entry->in_progress() ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_active",
            "Only an active avatar mission can be abandoned"
        } );
    }
    sol::table before = snapshot_instance(
                            state, *entry,
                            runtime_generation,
                            world_generation );
    get_avatar().remove_active_mission( *entry );
    sol::table value = state.create_table();
    value["abandoned"] = std::move( before );
    value["removed"] =
        mission::find( token.uid(), true ) == nullptr;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

} // namespace

mission_token::mission_token(
    const int uid, const game_handle_runtime &runtime,
    const std::size_t world_generation )
    : uid_( uid ),
      runtime_( runtime ),
      world_generation_( world_generation )
{
}

int mission_token::uid() const noexcept
{
    return uid_;
}

std::size_t mission_token::runtime_generation() const noexcept
{
    return runtime_.generation();
}

std::size_t mission_token::world_generation() const noexcept
{
    return world_generation_;
}

bool mission_token::belongs_to(
    const game_handle_runtime &runtime ) const noexcept
{
    return runtime_.is_active_match( runtime );
}

std::string mission_token::to_string() const
{
    return "MissionToken<" + std::to_string( uid_ ) + ">";
}

void install_mission_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    lua.new_usertype<mission_token>(
        "MissionToken", sol::no_constructor,
        "uid", sol::property( &mission_token::uid ),
        "runtime_generation",
        sol::property(
            &mission_token::runtime_generation ),
        "world_generation",
        sol::property(
            &mission_token::world_generation ),
        "is_valid",
        [current_runtime_generation, current_world_generation, require_read](
    const mission_token & token ) {
        require_read();
        return !mission_token_error(
                   token, current_runtime_generation(),
                   current_world_generation() );
    },
    sol::meta_function::to_string,
    &mission_token::to_string,
    sol::meta_function::equal_to,
    []( const mission_token & lhs, const mission_token & rhs ) {
        return lhs == rhs;
    } );

    sol::table missions = lua.create_table();
    missions.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    missions.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    missions.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_instances(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const mission_token & token ) {
        require_read();
        return get_instance(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "current",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state ) {
        require_read();
        return current_instance(
                   lua_state,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "avatar_has_active",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return avatar_has_active( lua_state, id );
    } );
    missions.set_function(
        "random_definition",
        [require_read](
            sol::this_state lua_state,
            const script_enum_value & origin,
    const script_tripoint_coord & position ) {
        require_read();
        return random_definition(
                   lua_state, origin, position );
    } );
    missions.set_function(
        "is_complete",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const mission_token & token,
    const sol::optional<int> &npc_id ) {
        require_read();
        return is_complete_instance(
                   lua_state, token, npc_id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "reserve",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const script_game_id & id,
    const sol::optional<int> &npc_id ) {
        require_write();
        return reserve_instance(
                   lua_state, id, npc_id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "reserve_random",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const script_enum_value & origin,
            const script_tripoint_coord & position,
    const sol::optional<int> &npc_id ) {
        require_write();
        return reserve_random_instance(
                   lua_state, origin, position, npc_id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "assign",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const mission_token & token ) {
        require_write();
        return assign_instance(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "set_deadline",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const mission_token & token,
    const sol::optional<script_time_point> &deadline ) {
        require_write();
        return set_instance_deadline(
                   lua_state, token, deadline,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "select",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const mission_token & token ) {
        require_write();
        return select_instance(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "step_complete",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const mission_token & token,
    const int step ) {
        require_write();
        return step_instance(
                   lua_state, token, step,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "fail",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const mission_token & token ) {
        require_write();
        return fail_instance(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "complete",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const mission_token & token,
    const sol::optional<bool> &force ) {
        require_write();
        return complete_instance(
                   lua_state, token, force,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "cancel",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const mission_token & token ) {
        require_write();
        return cancel_reserved_instance(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "abandon",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const mission_token & token ) {
        require_write();
        return abandon_instance(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["missions"] = std::move( missions );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
