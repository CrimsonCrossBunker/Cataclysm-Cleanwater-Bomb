#include "lua_platform_runtime_internal.h"

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <filesystem>
#include <limits>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

#include "calendar.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "creature_tracker.h"
#include "debug.h"
#include "field_type.h"
#include "filesystem.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_hordes.h"
#include "lua_platform_overmap.h"
#include "lua_platform_trade.h"
#include "lua_platform_world.h"
#include "map.h"
#include "messages.h"
#include "monster.h"
#include "path_info.h"
#include "vehicle.h"
#include "worldfactory.h"

namespace cata::lua_platform
{

namespace
{

using persistent_state = script_persistent_state;
using persistent_value = script_persistent_value;

struct persistent_scope_record {
    persistent_state values;
    std::vector<persistent_task> tasks;
};

constexpr std::uintmax_t maximum_platform_state_file_bytes =
    16U * 1024U * 1024U;

std::map<std::string, persistent_scope_record> orphan_character_records;
std::map<std::string, persistent_scope_record> orphan_world_records;

std::map<std::string, persistent_scope_record> &orphan_records(
    const std::string &scope )
{
    return scope == "character" ? orphan_character_records :
           orphan_world_records;
}

std::string_view persistent_task_participant_kind_name(
    const persistent_task_participant_kind kind )
{
    switch( kind ) {
        case persistent_task_participant_kind::character:
            return "character";
        case persistent_task_participant_kind::item:
            return "item";
        case persistent_task_participant_kind::monster:
            return "monster";
        case persistent_task_participant_kind::vehicle:
            return "vehicle";
    }
    return "";
}

std::optional<persistent_task_participant_kind> persistent_task_participant_kind_from_string(
    const std::string_view value )
{
    if( value == "character" ) {
        return persistent_task_participant_kind::character;
    }
    if( value == "item" ) {
        return persistent_task_participant_kind::item;
    }
    if( value == "monster" ) {
        return persistent_task_participant_kind::monster;
    }
    if( value == "vehicle" ) {
        return persistent_task_participant_kind::vehicle;
    }
    return std::nullopt;
}

bool valid_persistent_task_participant_role( const std::string_view role )
{
    if( role.empty() || role.size() > 32 ||
        !( std::isalpha( static_cast<unsigned char>( role.front() ) ) ||
           role.front() == '_' ) ) {
        return false;
    }
    return std::all_of( role.begin() + 1, role.end(), []( const char entry ) {
        return std::isalnum( static_cast<unsigned char>( entry ) ) || entry == '_';
    } );
}

std::int64_t nonnegative_turn_difference( const std::int64_t later,
        const std::int64_t earlier )
{
    if( earlier > later ) {
        return 0;
    }
    if( earlier < 0 && later > std::numeric_limits<std::int64_t>::max() + earlier ) {
        return std::numeric_limits<std::int64_t>::max();
    }
    return later - earlier;
}

persistent_value persistent_from_lua( const sol::object &value,
                                      const std::string &api_name )
{
    switch( value.get_type() ) {
        case sol::type::boolean:
            return value.as<bool>();
        case sol::type::number:
            if( value.is<lua_Integer>() ) {
                return static_cast<std::int64_t>( value.as<lua_Integer>() );
            }
            if( const double number = value.as<double>(); std::isfinite( number ) ) {
                return number;
            }
            throw std::runtime_error( api_name + " only accepts finite numbers" );
        case sol::type::string:
            return value.as<std::string>();
        default:
            throw std::runtime_error( api_name +
                                      " only accepts boolean, number, or string values" );
    }
}

void set_persistent_value( persistent_state &store, const std::string &key,
                           const sol::object &value, const std::string &api_name )
{
    if( value.get_type() == sol::type::nil ) {
        store.erase( key );
        return;
    }
    cata::lua_platform::assign_persistent_value(
        store, key, persistent_from_lua( value, api_name ) );
}

sol::object get_persistent_value( const persistent_state &store,
                                  sol::this_state lua,
                                  const std::string &key,
                                  const sol::optional<sol::object> &fallback )
{
    const auto found = store.find( key );
    if( found == store.end() ) {
        if( fallback && fallback->get_type() != sol::type::nil ) {
            static_cast<void>( persistent_from_lua( *fallback, "state.get fallback" ) );
        }
        return fallback.value_or( sol::make_object( lua, sol::lua_nil ) );
    }
    return std::visit( [lua]( const auto & entry ) {
        return sol::make_object( lua, entry );
    }, found->second );
}

sol::table persistent_table( sol::state &lua, const persistent_state &values )
{
    sol::table result = lua.create_table();
    for( const auto &[key, value] : values ) {
        const std::string persistent_key = key;
        std::visit( [&result, &persistent_key]( const auto & entry ) {
            result[persistent_key] = entry;
        }, value );
    }
    return result;
}

persistent_state persistent_table_from_lua( const sol::table &table,
        const std::string &api_name )
{
    persistent_state result;
    for( const auto &entry : table ) {
        const sol::object key = entry.first;
        if( !key.is<std::string>() ) {
            throw std::runtime_error( api_name + " payload keys must be strings" );
        }
        const std::string key_string = key.as<std::string>();
        cata::lua_platform::assign_persistent_value(
            result, key_string,
            persistent_from_lua( entry.second, api_name ) );
    }
    return result;
}

persistent_state persistent_table_from_lua( const sol::optional<sol::table> &table,
        const std::string &api_name )
{
    return table ? persistent_table_from_lua( *table, api_name ) : persistent_state{};
}

void write_typed_values( JsonOut &json, const persistent_state &values )
{
    std::vector<std::string> keys;
    keys.reserve( values.size() );
    for( const auto &[key, value] : values ) {
        static_cast<void>( value );
        keys.push_back( key );
    }
    std::sort( keys.begin(), keys.end() );
    json.start_object();
    for( const std::string &key : keys ) {
        json.member( key );
        json.start_object();
        std::visit( [&json]( const auto & value ) {
            using value_type = std::decay_t<decltype( value )>;
            if constexpr( std::is_same_v<value_type, bool> ) {
                json.member( "type", "boolean" );
            } else if constexpr( std::is_same_v<value_type, std::int64_t> ) {
                json.member( "type", "integer" );
            } else if constexpr( std::is_same_v<value_type, double> ) {
                json.member( "type", "float" );
            } else {
                json.member( "type", "string" );
            }
            json.member( "value", value );
        }, values.at( key ) );
        json.end_object();
    }
    json.end_object();
}

persistent_state read_typed_values( const JsonObject &values )
{
    persistent_state result;
    for( const JsonMember member : values ) {
        const std::string key = member.name();
        const JsonObject entry = member.get_object();
        const std::string type = entry.get_string( "type" );
        if( type == "boolean" ) {
            cata::lua_platform::assign_persistent_value( result, key,
                    entry.get_bool( "value" ) );
        } else if( type == "integer" ) {
            cata::lua_platform::assign_persistent_value( result, key,
                    entry.get_int64( "value" ) );
        } else if( type == "float" ) {
            cata::lua_platform::assign_persistent_value( result, key,
                    entry.get_float( "value" ) );
        } else if( type == "string" ) {
            cata::lua_platform::assign_persistent_value( result, key,
                    entry.get_string( "value" ) );
        } else {
            throw std::runtime_error( "unknown Platform state value type '" + type + "'" );
        }
        entry.allow_omitted_members();
    }
    values.allow_omitted_members();
    return result;
}

cata_path character_state_path()
{
    return PATH_INFO::player_base_save_path() + ".lua_platform.json";
}

std::optional<cata_path> world_state_path()
{
    if( !world_generator || world_generator->active_world == nullptr ) {
        return std::nullopt;
    }
    return world_generator->active_world->folder_path() / "lua_platform_world.json";
}

void clear_scope( const std::string &scope )
{
    orphan_records( scope ).clear();
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner ) {
            continue;
        }
        if( scope == "character" ) {
            owner->character_state.clear();
        } else {
            owner->world_state.clear();
        }
        owner->tasks.erase( std::remove_if( owner->tasks.begin(), owner->tasks.end(),
        [&scope]( const persistent_task & task ) {
            return task.owner == scope;
        } ), owner->tasks.end() );
    }
}

void load_scope( const cata_path &path, const std::string &scope,
                 std::string &error )
{
    clear_scope( scope );
    if( !file_exist( path ) ) {
        error.clear();
        return;
    }
    try {
        std::error_code size_error;
        const std::uintmax_t file_size = std::filesystem::file_size(
                                             path.get_unrelative_path(), size_error );
        if( size_error ) {
            throw std::runtime_error( "unable to inspect Platform state file: " +
                                      size_error.message() );
        }
        if( file_size > maximum_platform_state_file_bytes ) {
            throw std::runtime_error( "Platform state file exceeds 16 MiB" );
        }
        const JsonObject root = json_loader::from_path( path ).get_object();
        if( root.get_int( "version" ) != 1 ) {
            throw std::runtime_error( "unsupported Platform state version" );
        }
        if( root.get_string( "scope" ) != scope ) {
            throw std::runtime_error( "Platform state scope mismatch" );
        }
        const JsonObject mods = root.get_object( "mods" );
        for( const JsonMember member : mods ) {
            const std::shared_ptr<runtime> owner = detail::find_active_runtime( member.name() );
            const JsonObject stored = member.get_object();
            persistent_scope_record record;
            record.values = read_typed_values( stored.get_object( "values" ) );
            std::set<std::uint64_t> stored_task_ids;
            if( stored.has_array( "tasks" ) ) {
                const JsonArray stored_tasks = stored.get_array( "tasks" );
                if( stored_tasks.size() > maximum_tasks_per_mod ) {
                    throw std::runtime_error( "Platform state exceeds 1024 persistent tasks per Mod" );
                }
                for( const JsonObject task_json : stored_tasks ) {
                    persistent_task task;
                    const std::int64_t stored_id = task_json.get_int64( "id" );
                    if( stored_id <= 0 ) {
                        throw std::runtime_error( "Platform task id must be positive" );
                    }
                    task.id = static_cast<std::uint64_t>( stored_id );
                    if( !stored_task_ids.insert( task.id ).second ) {
                        throw std::runtime_error( "Platform state repeats a persistent task id" );
                    }
                    task.handler_id = task_json.get_string( "handler" );
                    if( task.handler_id.empty() ) {
                        throw std::runtime_error( "Platform task handler id cannot be empty" );
                    }
                    task.due_turn = task_json.get_int64( "due_turn" );
                    task.interval_turns = task_json.has_member( "interval_turns" ) ?
                                          task_json.get_int64( "interval_turns" ) : 0;
                    if( task.interval_turns < 0 ) {
                        throw std::runtime_error(
                            "Platform task interval cannot be negative" );
                    }
                    task.owner = scope;
                    task.owner_mod_id = task_json.has_member( "owner_mod_id" ) ?
                                        task_json.get_string( "owner_mod_id" ) : member.name();
                    if( task.owner_mod_id != member.name() ) {
                        throw std::runtime_error(
                            "Platform task owner Mod does not match its state record" );
                    }
                    if( task_json.has_member( "actor_character_id" ) ) {
                        const std::int64_t stored_actor_id =
                            task_json.get_int64( "actor_character_id" );
                        if( stored_actor_id <= 0 ||
                            stored_actor_id > std::numeric_limits<int>::max() ) {
                            throw std::runtime_error(
                                "Platform task actor character id is outside the native range" );
                        }
                        task.actor_character_id = character_id(
                                                      static_cast<int>( stored_actor_id ) );
                    }
                    if( task_json.has_member( "actor_item_uid" ) ) {
                        const std::int64_t stored_item_uid =
                            task_json.get_int64( "actor_item_uid" );
                        if( stored_item_uid <= 0 ) {
                            throw std::runtime_error(
                                "Platform task actor item uid must be positive" );
                        }
                        if( task.actor_character_id ) {
                            throw std::runtime_error(
                                "Platform task cannot have Character and Item actors together" );
                        }
                        task.actor_item_uid = stored_item_uid;
                        const bool has_scope = task_json.has_member( "actor_item_hint_scope" );
                        const bool has_x = task_json.has_member( "actor_item_hint_x" );
                        const bool has_y = task_json.has_member( "actor_item_hint_y" );
                        const bool has_z = task_json.has_member( "actor_item_hint_z" );
                        if( has_scope || has_x || has_y || has_z ) {
                            if( !has_scope || !has_x || !has_y || !has_z ) {
                                throw std::runtime_error(
                                    "Platform task actor item hint is incomplete" );
                            }
                            cata::lua_platform::game_handle_locator hint;
                            hint.scope = task_json.get_string( "actor_item_hint_scope" );
                            if( hint.scope.size() > 64 ||
                                hint.scope.find( '\0' ) != std::string::npos ) {
                                throw std::runtime_error(
                                    "Platform task actor item hint scope is invalid" );
                            }
                            hint.stable_id = stored_item_uid;
                            hint.x = task_json.get_int( "actor_item_hint_x" );
                            hint.y = task_json.get_int( "actor_item_hint_y" );
                            hint.z = task_json.get_int( "actor_item_hint_z" );
                            task.actor_item_hint = std::move( hint );
                        }
                        task.actor_item_pending =
                            task_json.has_member( "actor_item_pending" ) &&
                            task_json.get_bool( "actor_item_pending" );
                    } else if( task_json.has_member( "actor_item_pending" ) ||
                               task_json.has_member( "actor_item_hint_scope" ) ||
                               task_json.has_member( "actor_item_hint_x" ) ||
                               task_json.has_member( "actor_item_hint_y" ) ||
                               task_json.has_member( "actor_item_hint_z" ) ) {
                        throw std::runtime_error(
                            "Platform task item metadata requires actor_item_uid" );
                    }
                    if( task_json.has_member( "actor_monster_uid" ) ) {
                        const std::int64_t stored_monster_uid =
                            task_json.get_int64( "actor_monster_uid" );
                        if( stored_monster_uid <= 0 ) {
                            throw std::runtime_error(
                                "Platform task actor Monster uid must be positive" );
                        }
                        if( task.actor_character_id || task.actor_item_uid ) {
                            throw std::runtime_error(
                                "Platform task cannot have multiple actor identities" );
                        }
                        task.actor_monster_uid = stored_monster_uid;
                        const bool has_scope = task_json.has_member( "actor_monster_hint_scope" );
                        const bool has_x = task_json.has_member( "actor_monster_hint_x" );
                        const bool has_y = task_json.has_member( "actor_monster_hint_y" );
                        const bool has_z = task_json.has_member( "actor_monster_hint_z" );
                        if( has_scope || has_x || has_y || has_z ) {
                            if( !has_scope || !has_x || !has_y || !has_z ) {
                                throw std::runtime_error(
                                    "Platform task actor Monster hint is incomplete" );
                            }
                            cata::lua_platform::game_handle_locator hint;
                            hint.scope = task_json.get_string( "actor_monster_hint_scope" );
                            if( hint.scope.size() > 64 ||
                                hint.scope.find( '\0' ) != std::string::npos ) {
                                throw std::runtime_error(
                                    "Platform task actor Monster hint scope is invalid" );
                            }
                            hint.stable_id = stored_monster_uid;
                            hint.x = task_json.get_int( "actor_monster_hint_x" );
                            hint.y = task_json.get_int( "actor_monster_hint_y" );
                            hint.z = task_json.get_int( "actor_monster_hint_z" );
                            task.actor_monster_hint = std::move( hint );
                        }
                        task.actor_monster_pending =
                            task_json.has_member( "actor_monster_pending" ) &&
                            task_json.get_bool( "actor_monster_pending" );
                    } else if( task_json.has_member( "actor_monster_pending" ) ||
                               task_json.has_member( "actor_monster_hint_scope" ) ||
                               task_json.has_member( "actor_monster_hint_x" ) ||
                               task_json.has_member( "actor_monster_hint_y" ) ||
                               task_json.has_member( "actor_monster_hint_z" ) ) {
                        throw std::runtime_error(
                            "Platform task Monster metadata requires actor_monster_uid" );
                    }
                    if( task_json.has_member( "actor_vehicle_uid" ) ) {
                        const std::int64_t stored_vehicle_uid =
                            task_json.get_int64( "actor_vehicle_uid" );
                        if( stored_vehicle_uid <= 0 ) {
                            throw std::runtime_error(
                                "Platform task actor Vehicle uid must be positive" );
                        }
                        if( task.actor_character_id || task.actor_item_uid ||
                            task.actor_monster_uid ) {
                            throw std::runtime_error(
                                "Platform task cannot have multiple actor identities" );
                        }
                        task.actor_vehicle_uid = stored_vehicle_uid;
                        const bool has_scope = task_json.has_member( "actor_vehicle_hint_scope" );
                        const bool has_x = task_json.has_member( "actor_vehicle_hint_x" );
                        const bool has_y = task_json.has_member( "actor_vehicle_hint_y" );
                        const bool has_z = task_json.has_member( "actor_vehicle_hint_z" );
                        if( has_scope || has_x || has_y || has_z ) {
                            if( !has_scope || !has_x || !has_y || !has_z ) {
                                throw std::runtime_error(
                                    "Platform task actor Vehicle hint is incomplete" );
                            }
                            cata::lua_platform::game_handle_locator hint;
                            hint.scope = task_json.get_string( "actor_vehicle_hint_scope" );
                            if( hint.scope.size() > 64 ||
                                hint.scope.find( '\0' ) != std::string::npos ) {
                                throw std::runtime_error(
                                    "Platform task actor Vehicle hint scope is invalid" );
                            }
                            hint.stable_id = stored_vehicle_uid;
                            hint.x = task_json.get_int( "actor_vehicle_hint_x" );
                            hint.y = task_json.get_int( "actor_vehicle_hint_y" );
                            hint.z = task_json.get_int( "actor_vehicle_hint_z" );
                            task.actor_vehicle_hint = std::move( hint );
                        }
                        task.actor_vehicle_pending =
                            task_json.has_member( "actor_vehicle_pending" ) &&
                            task_json.get_bool( "actor_vehicle_pending" );
                    } else if( task_json.has_member( "actor_vehicle_pending" ) ||
                               task_json.has_member( "actor_vehicle_hint_scope" ) ||
                               task_json.has_member( "actor_vehicle_hint_x" ) ||
                               task_json.has_member( "actor_vehicle_hint_y" ) ||
                               task_json.has_member( "actor_vehicle_hint_z" ) ) {
                        throw std::runtime_error(
                            "Platform task Vehicle metadata requires actor_vehicle_uid" );
                    }
                    if( task_json.has_member( "participants" ) ) {
                        const JsonArray stored_participants =
                            task_json.get_array( "participants" );
                        if( stored_participants.size() > maximum_task_participants ) {
                            throw std::runtime_error(
                                "Platform task exceeds the participant limit" );
                        }
                        std::set<std::string> roles;
                        for( const JsonObject participant_json : stored_participants ) {
                            persistent_task_participant participant;
                            participant.role = participant_json.get_string( "role" );
                            if( !valid_persistent_task_participant_role( participant.role ) ||
                                !roles.insert( participant.role ).second ) {
                                throw std::runtime_error(
                                    "Platform task participant role is invalid or repeated" );
                            }
                            const std::optional<persistent_task_participant_kind> kind =
                                persistent_task_participant_kind_from_string(
                                    participant_json.get_string( "kind" ) );
                            if( !kind ) {
                                throw std::runtime_error(
                                    "Platform task participant kind is invalid" );
                            }
                            participant.kind = *kind;
                            participant.stable_id = participant_json.get_int64( "stable_id" );
                            if( participant.stable_id <= 0 ||
                                ( participant.kind == persistent_task_participant_kind::character &&
                                  participant.stable_id > std::numeric_limits<int>::max() ) ) {
                                throw std::runtime_error(
                                    "Platform task participant stable id is outside the native range" );
                            }
                            participant.hint.scope = participant_json.get_string( "hint_scope" );
                            if( participant.hint.scope.size() > 64 ||
                                participant.hint.scope.find( '\0' ) != std::string::npos ) {
                                throw std::runtime_error(
                                    "Platform task participant hint scope is invalid" );
                            }
                            participant.hint.stable_id = participant.stable_id;
                            participant.hint.x = participant_json.get_int( "hint_x" );
                            participant.hint.y = participant_json.get_int( "hint_y" );
                            participant.hint.z = participant_json.get_int( "hint_z" );
                            participant.pending =
                                participant_json.has_member( "pending" ) &&
                                participant_json.get_bool( "pending" );
                            task.participants.push_back( std::move( participant ) );
                            participant_json.allow_omitted_members();
                        }
                        std::sort( task.participants.begin(), task.participants.end(),
                                   []( const persistent_task_participant & lhs,
                        const persistent_task_participant & rhs ) {
                            return lhs.role < rhs.role;
                        } );
                    }
                    task.payload_version = task_json.get_int( "payload_version" );
                    if( task.payload_version <= 0 ) {
                        throw std::runtime_error( "Platform task payload version must be positive" );
                    }
                    task.payload = read_typed_values( task_json.get_object( "payload" ) );
                    record.tasks.push_back( std::move( task ) );
                    task_json.allow_omitted_members();
                }
            }
            if( owner ) {
                if( owner->tasks.size() + record.tasks.size() > maximum_tasks_per_mod ) {
                    throw std::runtime_error( "Platform state exceeds 1024 persistent tasks per Mod" );
                }
                std::set<std::uint64_t> task_ids;
                for( const persistent_task &task : owner->tasks ) {
                    task_ids.insert( task.id );
                }
                for( const persistent_task &task : record.tasks ) {
                    if( !task_ids.insert( task.id ).second ) {
                        throw std::runtime_error( "Platform state repeats a persistent task id" );
                    }
                }
                persistent_state &state = scope == "character" ?
                                          owner->character_state : owner->world_state;
                state = std::move( record.values );
                for( persistent_task &task : record.tasks ) {
                    owner->next_task_id = std::max( owner->next_task_id, task.id + 1 );
                    owner->tasks.push_back( std::move( task ) );
                }
            } else {
                orphan_records( scope )[member.name()] = std::move( record );
            }
            stored.allow_omitted_members();
        }
        mods.allow_omitted_members();
        root.allow_omitted_members();
        error.clear();
    } catch( const std::exception &exception ) {
        clear_scope( scope );
        error = path.get_unrelative_path().string() + ": " + exception.what();
    }
}

void write_scope_record( JsonOut &json, const persistent_state &state,
                         const std::vector<persistent_task> &tasks,
                         const std::string &scope, const std::string &mod_id )
{
    json.start_object();
    json.member( "values" );
    write_typed_values( json, state );
    json.member( "tasks" );
    json.start_array();
    for( const persistent_task &task : tasks ) {
        if( task.owner != scope ) {
            continue;
        }
        if( !task.owner_mod_id.empty() && task.owner_mod_id != mod_id ) {
            throw std::runtime_error(
                "Platform task owner Mod does not match its runtime" );
        }
        json.start_object();
        json.member( "id", static_cast<std::int64_t>( task.id ) );
        json.member( "handler", task.handler_id );
        json.member( "due_turn", task.due_turn );
        json.member( "interval_turns", task.interval_turns );
        json.member( "owner_mod_id", mod_id );
        if( task.actor_character_id ) {
            json.member( "actor_character_id",
                         task.actor_character_id->get_value() );
        }
        if( task.actor_item_uid ) {
            if( task.actor_character_id ) {
                throw std::runtime_error(
                    "Platform task cannot have Character and Item actors together" );
            }
            json.member( "actor_item_uid", *task.actor_item_uid );
            if( task.actor_item_hint ) {
                json.member( "actor_item_hint_scope", task.actor_item_hint->scope );
                json.member( "actor_item_hint_x", task.actor_item_hint->x );
                json.member( "actor_item_hint_y", task.actor_item_hint->y );
                json.member( "actor_item_hint_z", task.actor_item_hint->z );
            }
            json.member( "actor_item_pending", task.actor_item_pending );
        }
        if( task.actor_monster_uid ) {
            if( task.actor_character_id || task.actor_item_uid ) {
                throw std::runtime_error(
                    "Platform task cannot have multiple actor identities" );
            }
            json.member( "actor_monster_uid", *task.actor_monster_uid );
            if( task.actor_monster_hint ) {
                json.member( "actor_monster_hint_scope", task.actor_monster_hint->scope );
                json.member( "actor_monster_hint_x", task.actor_monster_hint->x );
                json.member( "actor_monster_hint_y", task.actor_monster_hint->y );
                json.member( "actor_monster_hint_z", task.actor_monster_hint->z );
            }
            json.member( "actor_monster_pending", task.actor_monster_pending );
        }
        if( task.actor_vehicle_uid ) {
            if( task.actor_character_id || task.actor_item_uid ||
                task.actor_monster_uid ) {
                throw std::runtime_error(
                    "Platform task cannot have multiple actor identities" );
            }
            json.member( "actor_vehicle_uid", *task.actor_vehicle_uid );
            if( task.actor_vehicle_hint ) {
                json.member( "actor_vehicle_hint_scope", task.actor_vehicle_hint->scope );
                json.member( "actor_vehicle_hint_x", task.actor_vehicle_hint->x );
                json.member( "actor_vehicle_hint_y", task.actor_vehicle_hint->y );
                json.member( "actor_vehicle_hint_z", task.actor_vehicle_hint->z );
            }
            json.member( "actor_vehicle_pending", task.actor_vehicle_pending );
        }
        if( !task.participants.empty() ) {
            if( task.participants.size() > maximum_task_participants ) {
                throw std::runtime_error(
                    "Platform task exceeds the participant limit" );
            }
            json.member( "participants" );
            json.start_array();
            std::set<std::string> roles;
            for( const persistent_task_participant &participant : task.participants ) {
                if( !valid_persistent_task_participant_role( participant.role ) ||
                    !roles.insert( participant.role ).second ||
                    participant.stable_id <= 0 ) {
                    throw std::runtime_error(
                        "Platform task participant identity is invalid" );
                }
                json.start_object();
                json.member( "role", participant.role );
                json.member( "kind",
                             persistent_task_participant_kind_name( participant.kind ) );
                json.member( "stable_id", participant.stable_id );
                json.member( "hint_scope", participant.hint.scope );
                json.member( "hint_x", participant.hint.x );
                json.member( "hint_y", participant.hint.y );
                json.member( "hint_z", participant.hint.z );
                json.member( "pending", participant.pending );
                json.end_object();
            }
            json.end_array();
        }
        json.member( "payload_version", task.payload_version );
        json.member( "payload" );
        write_typed_values( json, task.payload );
        json.end_object();
    }
    json.end_array();
    json.end_object();
}

void write_scope( const cata_path &path, const std::string &scope )
{
    std::ostringstream buffer;
    JsonOut json( buffer, true );
    json.start_object();
    json.member( "version", 1 );
    json.member( "scope", scope );
    json.member( "mods" );
    json.start_object();
    std::set<std::string> active_ids;
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( owner ) {
            active_ids.insert( owner->mod_id );
        }
    }
    for( const auto &[mod_id, record] : orphan_records( scope ) ) {
        if( active_ids.count( mod_id ) != 0 ) {
            continue;
        }
        json.member( mod_id );
        write_scope_record( json, record.values, record.tasks, scope, mod_id );
    }
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner ) {
            continue;
        }
        const persistent_state &state = scope == "character" ?
                                        owner->character_state : owner->world_state;
        json.member( owner->mod_id );
        write_scope_record( json, state, owner->tasks, scope, owner->mod_id );
    }
    json.end_object();
    json.end_object();
    const std::string serialized = buffer.str();
    if( serialized.size() > maximum_platform_state_file_bytes ) {
        throw std::runtime_error( "Platform state file exceeds 16 MiB" );
    }
    write_to_file( path, [&serialized]( std::ostream & output ) {
        output << serialized;
    } );
}

} // namespace

bool detail::migrate_task_payload( runtime &owner, persistent_task &task,
                                   std::string &error )
{
    const auto handler = owner.handlers.find( task.handler_id );
    if( handler == owner.handlers.end() ) {
        error = "missing handler '" + task.handler_id + "'";
        return false;
    }
    const int target_version = handler->second.payload_version;
    persistent_task candidate = task;
    std::set<int> visited;
    while( candidate.payload_version != target_version ) {
        if( !visited.insert( candidate.payload_version ).second ) {
            error = "payload migration cycle at version " +
                    std::to_string( candidate.payload_version );
            return false;
        }
        const auto by_handler = owner.task_migrations.find( task.handler_id );
        if( by_handler == owner.task_migrations.end() ) {
            error = "no payload migration registered from version " +
                    std::to_string( candidate.payload_version );
            return false;
        }
        const auto transition = by_handler->second.find( candidate.payload_version );
        if( transition == by_handler->second.end() ) {
            error = "no payload migration registered from version " +
                    std::to_string( candidate.payload_version );
            return false;
        }

        sol::table metadata = owner.lua->create_table();
        metadata["task_id"] = static_cast<std::int64_t>( candidate.id );
        metadata["handler_id"] = candidate.handler_id;
        metadata["owner"] = candidate.owner;
        metadata["interval_turns"] = candidate.interval_turns;
        metadata["from_version"] = candidate.payload_version;
        metadata["to_version"] = transition->second.target_version;
        sol::protected_function callback = transition->second.callback;
        const sol::protected_function_result result = [&]() {
            restore_on_out_of_scope restore_task_migration_active(
                owner.task_migration_active );
            owner.task_migration_active = true;
            return callback(
                       persistent_table( *owner.lua, candidate.payload ), metadata );
        }
        ();
        if( !result.valid() ) {
            const sol::error callback_error = result;
            error = callback_error.what();
            return false;
        }
        if( result.return_count() == 0 || result.get_type() != sol::type::table ) {
            error = "payload migration must return a state table";
            return false;
        }
        try {
            candidate.payload = persistent_table_from_lua(
                                    result.get<sol::table>(), "runtime.migrate_task_payload" );
        } catch( const std::exception &exception ) {
            error = exception.what();
            return false;
        }
        candidate.payload_version = transition->second.target_version;
    }
    task = std::move( candidate );
    error.clear();
    return true;
}

void detail::clear_orphan_runtime_records()
{
    orphan_character_records.clear();
    orphan_world_records.clear();
}

void detail::install_runtime_state_task_api(
    const std::shared_ptr<runtime> &value, sol::state &lua, sol::table &ccb )
{
    const std::weak_ptr<runtime> weak = value;
    auto install_state_scope = [&lua, weak]( persistent_state runtime::*member,
    const std::string & name ) {
        sol::table scope = lua.create_table();
        scope.set_function( "get", [weak, member, name]( sol::this_state state,
        const std::string & key, const sol::optional<sol::object> &fallback ) {
            const std::shared_ptr<runtime> owner = weak.lock();
            if( !owner || !owner->world_is_ready ) {
                throw std::runtime_error( "state." + name + " is only available after world_ready" );
            }
            return get_persistent_value( owner.get()->*member, state, key, fallback );
        } );
        scope.set_function( "set", [weak, member, name]( const std::string & key,
        const sol::object & entry ) {
            const std::shared_ptr<runtime> owner = weak.lock();
            if( !owner || !owner->world_is_ready ) {
                throw std::runtime_error( "state." + name + " is only available after world_ready" );
            }
            set_persistent_value( owner.get()->*member, key, entry,
                                  "state." + name + ".set" );
        } );
        return scope;
    };
    sol::table state_api = lua.create_table();
    state_api["character"] = install_state_scope( &runtime::character_state, "character" );
    state_api["world"] = install_state_scope( &runtime::world_state, "world" );
    ccb["state"] = std::move( state_api );

    const auto schedule_persistent_task = [weak](
            const std::int64_t delay_turns,
            const std::int64_t interval_turns,
            const std::string & handler_id,
            const sol::optional<sol::table> &payload,
            const sol::optional<std::int64_t> &payload_version,
            const sol::optional<std::string> &scope,
            const sol::optional<cata::lua_platform::game_handle> &actor,
            const sol::optional<sol::table> &participants,
    const std::string & api_name ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( owner->task_migration_active ) {
            throw std::runtime_error(
                "persistent tasks cannot be modified during payload migration" );
        }
        if( delay_turns < 0 ) {
            throw std::runtime_error( "task delay cannot be negative" );
        }
        if( interval_turns < 0 ) {
            throw std::runtime_error( "task interval cannot be negative" );
        }
        if( owner->tasks.size() >= maximum_tasks_per_mod ) {
            throw std::runtime_error( "persistent task limit of 1024 per Mod reached" );
        }
        const auto handler = owner->handlers.find( handler_id );
        if( handler == owner->handlers.end() ) {
            throw std::runtime_error( "task references missing handler '" + handler_id + "'" );
        }
        const std::string owner_scope = scope.value_or( "world" );
        if( owner_scope != "world" && owner_scope != "character" ) {
            throw std::runtime_error( "task owner must be 'world' or 'character'" );
        }
        if( owner->next_task_id > static_cast<std::uint64_t>(
                std::numeric_limits<std::int64_t>::max() ) ) {
            throw std::runtime_error( "persistent task id space exhausted" );
        }
        const std::int64_t now = to_turn<std::int64_t>( calendar::turn );
        if( delay_turns > 0 &&
            now > std::numeric_limits<std::int64_t>::max() - delay_turns ) {
            throw std::runtime_error( "persistent task due turn overflows" );
        }
        persistent_task task;
        task.handler_id = handler_id;
        task.due_turn = now + delay_turns;
        task.interval_turns = interval_turns;
        task.owner = owner_scope;
        task.owner_mod_id = owner->mod_id;
        if( actor ) {
            if( actor->kind() == cata::lua_platform::game_handle_kind::creature ) {
                std::optional<cata::lua_platform::game_handle_error> handle_error;
                if( actor->subtype_name() == "monster" ) {
                    monster *actor_monster = cata::lua_platform::resolve_exact_monster(
                                                 *actor, owner->handle_runtime(),
                                                 detail::runtime_world_generation_storage(), handle_error );
                    if( actor_monster == nullptr ) {
                        throw std::invalid_argument(
                            handle_error ? handle_error->message :
                            "persistent task actor is not an exact live Monster" );
                    }
                    const std::int64_t uid = actor_monster->uid().get_value();
                    if( uid <= 0 ) {
                        throw std::invalid_argument(
                            "persistent task Monster actor has no stable uid" );
                    }
                    const shared_ptr_fast<monster> tracked_actor =
                        get_creature_tracker().find_by_uid( uid );
                    if( !tracked_actor || tracked_actor.get() != actor_monster ) {
                        throw std::invalid_argument(
                            "persistent task Monster actor is not the exact loaded tracker occupant" );
                    }
                    cata::lua_platform::game_handle_locator hint = actor->locator();
                    if( hint.scope.size() > 64 ||
                        hint.scope.find( '\0' ) != std::string::npos ) {
                        throw std::invalid_argument(
                            "persistent task Monster actor hint scope is invalid" );
                    }
                    hint.stable_id = uid;
                    hint.path.clear();
                    hint.owner_generation = 0;
                    task.actor_monster_uid = uid;
                    task.actor_monster_hint = std::move( hint );
                } else {
                    Character *actor_character = cata::lua_platform::resolve_exact_character(
                                                     *actor, owner->handle_runtime(),
                                                     detail::runtime_world_generation_storage(), handle_error );
                    if( actor_character == nullptr ) {
                        throw std::invalid_argument(
                            handle_error ? handle_error->message :
                            "persistent task actor is not an exact live Character" );
                    }
                    task.actor_character_id = actor_character->getID();
                }
            } else if( actor->kind() == cata::lua_platform::game_handle_kind::item ) {
                const cata::lua_platform::native_handle_result<item> resolved =
                    actor->resolve_item( owner->handle_runtime(),
                                         detail::runtime_world_generation_storage() );
                if( !resolved ) {
                    throw std::invalid_argument(
                        resolved.error ? resolved.error->message :
                        "persistent task actor is not an exact live Item" );
                }
                const std::int64_t uid = resolved.value->uid().get_value();
                if( uid <= 0 ) {
                    throw std::invalid_argument(
                        "persistent task Item actor has no stable uid" );
                }
                cata::lua_platform::game_handle_locator hint = actor->locator();
                if( hint.scope.size() > 64 ||
                    hint.scope.find( '\0' ) != std::string::npos ) {
                    throw std::invalid_argument(
                        "persistent task Item actor hint scope is invalid" );
                }
                hint.stable_id = uid;
                hint.path.clear();
                hint.owner_generation = 0;
                task.actor_item_uid = uid;
                task.actor_item_hint = std::move( hint );
            } else if( actor->kind() == cata::lua_platform::game_handle_kind::vehicle ) {
                const cata::lua_platform::native_handle_result<vehicle> resolved =
                    actor->resolve_vehicle( owner->handle_runtime(),
                                            detail::runtime_world_generation_storage() );
                if( !resolved ) {
                    throw std::invalid_argument(
                        resolved.error ? resolved.error->message :
                        "persistent task actor is not an exact live Vehicle" );
                }
                const std::int64_t uid = resolved.value->uid().get_value();
                if( uid <= 0 || actor->locator().stable_id != uid ) {
                    throw std::invalid_argument(
                        "persistent task Vehicle actor has no matching stable uid" );
                }
                vehicle *loaded_actor = vehicle::find_vehicle_by_uid( get_map(), uid );
                if( loaded_actor == nullptr || loaded_actor != resolved.value ) {
                    throw std::invalid_argument(
                        "persistent task Vehicle actor is not the exact loaded map occupant" );
                }
                cata::lua_platform::game_handle_locator hint = actor->locator();
                if( hint.scope.size() > 64 ||
                    hint.scope.find( '\0' ) != std::string::npos ) {
                    throw std::invalid_argument(
                        "persistent task Vehicle actor hint scope is invalid" );
                }
                hint.stable_id = uid;
                hint.path.clear();
                hint.owner_generation = 0;
                task.actor_vehicle_uid = uid;
                task.actor_vehicle_hint = std::move( hint );
            } else {
                throw std::invalid_argument(
                    "persistent task actor must be an exact live Character, Item, Monster, or Vehicle" );
            }
        }
        if( participants ) {
            std::set<std::string> roles;
            for( const auto &entry : *participants ) {
                if( task.participants.size() >= maximum_task_participants ) {
                    throw std::invalid_argument(
                        "persistent task participant limit of 4 reached" );
                }
                const sol::object raw_role = entry.first;
                const sol::object raw_handle = entry.second;
                if( !raw_role.is<std::string>() ||
                    !raw_handle.is<cata::lua_platform::game_handle>() ) {
                    throw std::invalid_argument(
                        "persistent task participants must map string roles to GameHandle values" );
                }
                persistent_task_participant participant;
                participant.role = raw_role.as<std::string>();
                if( !valid_persistent_task_participant_role( participant.role ) ||
                    !roles.insert( participant.role ).second ) {
                    throw std::invalid_argument(
                        "persistent task participant role is invalid or repeated" );
                }
                const cata::lua_platform::game_handle handle =
                    raw_handle.as<cata::lua_platform::game_handle>();
                participant.hint = handle.locator();
                if( participant.hint.scope.size() > 64 ||
                    participant.hint.scope.find( '\0' ) != std::string::npos ) {
                    throw std::invalid_argument(
                        "persistent task participant hint scope is invalid" );
                }
                participant.hint.path.clear();
                participant.hint.owner_generation = 0;
                if( handle.kind() == cata::lua_platform::game_handle_kind::creature ) {
                    std::optional<cata::lua_platform::game_handle_error> handle_error;
                    if( handle.subtype_name() == "monster" ) {
                        monster *value = cata::lua_platform::resolve_exact_monster(
                                             handle, owner->handle_runtime(),
                                             detail::runtime_world_generation_storage(), handle_error );
                        if( value == nullptr || !value->uid().is_valid() ||
                            get_creature_tracker().find_by_uid(
                                value->uid().get_value() ).get() != value ) {
                            throw std::invalid_argument(
                                handle_error ? handle_error->message :
                                "persistent task participant is not an exact loaded Monster" );
                        }
                        participant.kind = persistent_task_participant_kind::monster;
                        participant.stable_id = value->uid().get_value();
                    } else {
                        Character *value = cata::lua_platform::resolve_exact_character(
                                               handle, owner->handle_runtime(),
                                               detail::runtime_world_generation_storage(), handle_error );
                        if( value == nullptr || !value->getID().is_valid() ) {
                            throw std::invalid_argument(
                                handle_error ? handle_error->message :
                                "persistent task participant is not an exact Character" );
                        }
                        participant.kind = persistent_task_participant_kind::character;
                        participant.stable_id = value->getID().get_value();
                    }
                } else if( handle.kind() == cata::lua_platform::game_handle_kind::item ) {
                    const cata::lua_platform::native_handle_result<item> value =
                        handle.resolve_item( owner->handle_runtime(),
                                             detail::runtime_world_generation_storage() );
                    if( !value || !value.value->uid().is_valid() ) {
                        throw std::invalid_argument(
                            value.error ? value.error->message :
                            "persistent task participant is not an exact Item" );
                    }
                    participant.kind = persistent_task_participant_kind::item;
                    participant.stable_id = value.value->uid().get_value();
                } else if( handle.kind() == cata::lua_platform::game_handle_kind::vehicle ) {
                    const cata::lua_platform::native_handle_result<vehicle> value =
                        handle.resolve_vehicle( owner->handle_runtime(),
                                                detail::runtime_world_generation_storage() );
                    if( !value || !value.value->uid().is_valid() ||
                        vehicle::find_vehicle_by_uid(
                            get_map(), value.value->uid().get_value() ) != value.value ) {
                        throw std::invalid_argument(
                            value.error ? value.error->message :
                            "persistent task participant is not an exact loaded Vehicle" );
                    }
                    participant.kind = persistent_task_participant_kind::vehicle;
                    participant.stable_id = value.value->uid().get_value();
                } else {
                    throw std::invalid_argument(
                        "persistent task participant must be a Character, Item, Monster, or Vehicle" );
                }
                participant.hint.stable_id = participant.stable_id;
                task.participants.push_back( std::move( participant ) );
            }
            std::sort( task.participants.begin(), task.participants.end(),
                       []( const persistent_task_participant & lhs,
            const persistent_task_participant & rhs ) {
                return lhs.role < rhs.role;
            } );
        }
        const std::int64_t requested_version = payload_version.value_or(
                handler->second.payload_version );
        if( requested_version <= 0 || requested_version > std::numeric_limits<int>::max() ) {
            throw std::runtime_error( "task payload version is outside the native range" );
        }
        if( requested_version != handler->second.payload_version ) {
            throw std::runtime_error(
                "new tasks must use the registered handler payload version" );
        }
        task.payload_version = static_cast<int>( requested_version );
        task.payload = persistent_table_from_lua( payload, api_name );
        task.id = owner->next_task_id++;
        owner->tasks.push_back( task );
        return static_cast<std::int64_t>( task.id );
    };

    sol::table tasks = lua.create_table();
    const auto task_snapshot = []( runtime & owner,
    const persistent_task & task ) {
        sol::table result = owner.lua->create_table();
        const std::int64_t now =
            to_turn<std::int64_t>( calendar::turn );
        const auto handler = owner.handlers.find( task.handler_id );
        result["id"] = static_cast<std::int64_t>( task.id );
        result["handler"] = task.handler_id;
        result["due_turn"] = task.due_turn;
        result["remaining_turns"] =
            nonnegative_turn_difference( task.due_turn, now );
        result["overdue_turns"] =
            nonnegative_turn_difference( now, task.due_turn );
        result["recurring"] = task.interval_turns > 0;
        result["interval_turns"] = task.interval_turns;
        result["owner"] = task.owner;
        result["owner_mod_id"] = task.owner_mod_id;
        if( task.actor_character_id ) {
            result["actor_kind"] = "character";
            result["actor_character_id"] = task.actor_character_id->get_value();
            result["actor_item_uid"] = sol::nil;
            result["actor_item_pending"] = false;
            result["actor_monster_uid"] = sol::nil;
            result["actor_monster_pending"] = false;
            result["actor_vehicle_uid"] = sol::nil;
            result["actor_vehicle_pending"] = false;
        } else if( task.actor_item_uid ) {
            result["actor_kind"] = "item";
            result["actor_character_id"] = sol::nil;
            result["actor_item_uid"] = *task.actor_item_uid;
            result["actor_item_pending"] = task.actor_item_pending;
            result["actor_monster_uid"] = sol::nil;
            result["actor_monster_pending"] = false;
            result["actor_vehicle_uid"] = sol::nil;
            result["actor_vehicle_pending"] = false;
        } else if( task.actor_monster_uid ) {
            result["actor_kind"] = "monster";
            result["actor_character_id"] = sol::nil;
            result["actor_item_uid"] = sol::nil;
            result["actor_item_pending"] = false;
            result["actor_monster_uid"] = *task.actor_monster_uid;
            result["actor_monster_pending"] = task.actor_monster_pending;
            result["actor_vehicle_uid"] = sol::nil;
            result["actor_vehicle_pending"] = false;
        } else if( task.actor_vehicle_uid ) {
            result["actor_kind"] = "vehicle";
            result["actor_character_id"] = sol::nil;
            result["actor_item_uid"] = sol::nil;
            result["actor_item_pending"] = false;
            result["actor_monster_uid"] = sol::nil;
            result["actor_monster_pending"] = false;
            result["actor_vehicle_uid"] = *task.actor_vehicle_uid;
            result["actor_vehicle_pending"] = task.actor_vehicle_pending;
        } else {
            result["actor_kind"] = sol::nil;
            result["actor_character_id"] = sol::nil;
            result["actor_item_uid"] = sol::nil;
            result["actor_item_pending"] = false;
            result["actor_monster_uid"] = sol::nil;
            result["actor_monster_pending"] = false;
            result["actor_vehicle_uid"] = sol::nil;
            result["actor_vehicle_pending"] = false;
        }
        sol::table participant_snapshots = owner.lua->create_table();
        for( const persistent_task_participant &participant : task.participants ) {
            sol::table descriptor = owner.lua->create_table();
            descriptor["kind"] =
                persistent_task_participant_kind_name( participant.kind );
            descriptor["pending"] = participant.pending;
            descriptor["character_id"] = sol::nil;
            descriptor["item_uid"] = sol::nil;
            descriptor["monster_uid"] = sol::nil;
            descriptor["vehicle_uid"] = sol::nil;
            switch( participant.kind ) {
                case persistent_task_participant_kind::character:
                    descriptor["character_id"] = participant.stable_id;
                    break;
                case persistent_task_participant_kind::item:
                    descriptor["item_uid"] = participant.stable_id;
                    break;
                case persistent_task_participant_kind::monster:
                    descriptor["monster_uid"] = participant.stable_id;
                    break;
                case persistent_task_participant_kind::vehicle:
                    descriptor["vehicle_uid"] = participant.stable_id;
                    break;
            }
            participant_snapshots[participant.role] = std::move( descriptor );
        }
        result["participants"] = std::move( participant_snapshots );
        result["payload_version"] = task.payload_version;
        result["handler_available"] = handler != owner.handlers.end();
        result["payload_current"] =
            handler != owner.handlers.end() &&
            handler->second.payload_version == task.payload_version;
        result["payload"] = persistent_table( *owner.lua, task.payload );
        return result;
    };
    tasks.set_function( "after", [schedule_persistent_task](
                            const std::int64_t turns,
                            const std::string & handler_id,
                            const sol::optional<sol::table> &payload,
                            const sol::optional<std::int64_t> &payload_version,
                            const sol::optional<std::string> &scope,
                            const sol::optional<cata::lua_platform::game_handle> &actor,
    const sol::optional<sol::table> &participants ) {
        return schedule_persistent_task(
                   turns, 0, handler_id, payload,
                   payload_version, scope, actor, participants, "tasks.after" );
    } );
    tasks.set_function( "every", [schedule_persistent_task](
                            const std::int64_t interval_turns,
                            const std::string & handler_id,
                            const sol::optional<sol::table> &payload,
                            const sol::optional<std::int64_t> &payload_version,
                            const sol::optional<std::string> &scope,
                            const sol::optional<cata::lua_platform::game_handle> &actor,
    const sol::optional<sol::table> &participants ) {
        if( interval_turns <= 0 ) {
            throw std::runtime_error( "task interval must be positive" );
        }
        return schedule_persistent_task(
                   interval_turns, interval_turns,
                   handler_id, payload, payload_version,
                   scope, actor, participants, "tasks.every" );
    } );
    tasks.set_function( "cancel", [weak]( std::int64_t id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( owner->task_migration_active ) {
            throw std::runtime_error(
                "persistent tasks cannot be modified during payload migration" );
        }
        if( id <= 0 ) {
            throw std::runtime_error( "persistent task id must be positive" );
        }
        const std::uint64_t task_id = static_cast<std::uint64_t>( id );
        const std::size_t old_size = owner->tasks.size();
        owner->tasks.erase( std::remove_if( owner->tasks.begin(), owner->tasks.end(),
        [task_id]( const persistent_task & task ) {
            return task.id == task_id;
        } ), owner->tasks.end() );
        owner->reported_task_migration_failures.erase( task_id );
        return owner->tasks.size() != old_size;
    } );
    tasks.set_function( "get", [weak, task_snapshot](
    sol::this_state state, const std::int64_t id ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( id <= 0 ) {
            throw std::runtime_error( "persistent task id must be positive" );
        }
        const std::uint64_t task_id = static_cast<std::uint64_t>( id );
        const auto found = std::find_if(
                               owner->tasks.begin(), owner->tasks.end(),
        [task_id]( const persistent_task & task ) {
            return task.id == task_id;
        } );
        sol::state_view lua_state( state );
        if( found == owner->tasks.end() ) {
            return sol::make_object( lua_state, sol::nil );
        }
        return sol::make_object(
                   lua_state, task_snapshot( *owner, *found ) );
    } );
    tasks.set_function( "next", [weak, task_snapshot](
                            sol::this_state state, const std::string & handler_id,
    const sol::optional<std::string> &scope ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( handler_id.empty() || handler_id.size() > 256 ) {
            throw std::runtime_error( "persistent task handler id must be a bounded non-empty string" );
        }
        if( scope && *scope != "world" && *scope != "character" ) {
            throw std::runtime_error( "task owner must be 'world' or 'character'" );
        }
        const persistent_task *next = nullptr;
        for( const persistent_task &task : owner->tasks ) {
            if( task.handler_id != handler_id ||
                ( scope && task.owner != *scope ) ) {
                continue;
            }
            if( next == nullptr ||
                std::tie( task.due_turn, task.id ) <
                std::tie( next->due_turn, next->id ) ) {
                next = &task;
            }
        }
        sol::state_view lua_state( state );
        if( next == nullptr ) {
            return sol::make_object( lua_state, sol::nil );
        }
        return sol::make_object(
                   lua_state, task_snapshot( *owner, *next ) );
    } );
    tasks.set_function( "list", [weak, task_snapshot](
                            sol::this_state state,
                            const sol::optional<std::string> &handler_id,
                            const sol::optional<std::string> &scope,
    const sol::optional<std::int64_t> &requested_limit ) {
        const std::shared_ptr<runtime> owner = weak.lock();
        if( !owner || !owner->world_is_ready ) {
            throw std::runtime_error( "persistent tasks are only available after world_ready" );
        }
        if( handler_id && ( handler_id->empty() || handler_id->size() > 256 ) ) {
            throw std::runtime_error( "persistent task handler id must be a bounded non-empty string" );
        }
        if( scope && *scope != "world" && *scope != "character" ) {
            throw std::runtime_error( "task owner must be 'world' or 'character'" );
        }
        const std::int64_t limit = requested_limit.value_or( 128 );
        if( limit < 0 || limit > static_cast<std::int64_t>( maximum_tasks_per_mod ) ) {
            throw std::runtime_error( "persistent task list limit must be within 0..1024" );
        }
        std::vector<const persistent_task *> matches;
        matches.reserve( owner->tasks.size() );
        for( const persistent_task &task : owner->tasks ) {
            if( ( !handler_id || task.handler_id == *handler_id ) &&
                ( !scope || task.owner == *scope ) ) {
                matches.push_back( &task );
            }
        }
        std::sort( matches.begin(), matches.end(),
        []( const persistent_task * lhs, const persistent_task * rhs ) {
            return std::tie( lhs->due_turn, lhs->id ) <
                   std::tie( rhs->due_turn, rhs->id );
        } );
        const std::size_t returned = std::min(
                                         matches.size(),
                                         static_cast<std::size_t>( limit ) );
        sol::state_view lua_state( state );
        sol::table entries = lua_state.create_table(
                                 static_cast<int>( returned ), 0 );
        for( std::size_t index = 0; index < returned; ++index ) {
            entries[index + 1] =
                task_snapshot( *owner, *matches[index] );
        }
        sol::table result = lua_state.create_table();
        result["items"] = std::move( entries );
        result["total"] = matches.size();
        result["returned"] = returned;
        result["limit"] = limit;
        result["truncated"] = returned < matches.size();
        return result;
    } );
    ccb["tasks"] = std::move( tasks );

}

using detail::callback_scope;
using detail::dispatch_lifecycle;
using detail::migrate_task_payload;
using detail::persistent_item_hint;
using detail::persistent_task_item_hint;
using detail::platform_creature_handle;
using detail::platform_event_character;
using detail::platform_item_handle;
using detail::platform_vehicle_handle;
using detail::report_callback_error;

void runtime_world_ready( bool new_game )
{
    cata::lua_platform::reset_map_tile_tokens();
    cata::lua_platform::reset_overmap_tile_tokens();
    cata::lua_platform::reset_horde_tokens();
    cata::lua_platform::retire_trade_quote_registry();
    if( detail::active_runtime_values().empty() ) {
        return;
    }
    const std::size_t previous_world_generation = detail::runtime_world_generation_storage();
    if( detail::runtime_world_generation_storage() != std::numeric_limits<std::size_t>::max() ) {
        ++detail::runtime_world_generation_storage();
    }
    cata::lua_platform::dialogue::retire_sessions_for_world(
        previous_world_generation );
    std::string character_error;
    load_scope( character_state_path(), "character", character_error );
    std::string world_error;
    if( const std::optional<cata_path> path = world_state_path() ) {
        load_scope( *path, "world", world_error );
    }
    detail::start_runtime_event_bridge();
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( owner ) {
            owner->world_is_ready = true;
        }
    }
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner ) {
            continue;
        }
        sol::table payload = owner->lua->create_table();
        payload["new_game"] = new_game;
        dispatch_lifecycle( *owner, "world_ready", payload );
    }
    if( !character_error.empty() ) {
        ::add_msg( m_warning, "Lua-first character state was not loaded: " + character_error );
    }
    if( !world_error.empty() ) {
        ::add_msg( m_warning, "Lua-first world state was not loaded: " + world_error );
    }
    runtime_process_tasks();
}

void runtime_before_save()
{
    cata::lua_platform::retire_trade_quote_registry();
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( owner && owner->world_is_ready ) {
            dispatch_lifecycle( *owner, "before_save" );
        }
    }
}

bool runtime_save( std::string &error )
{
    cata::lua_platform::retire_trade_quote_registry();
    if( detail::active_runtime_values().empty() ) {
        error.clear();
        return true;
    }
    try {
        write_scope( character_state_path(), "character" );
        if( const std::optional<cata_path> path = world_state_path() ) {
            write_scope( *path, "world" );
        }
        error.clear();
        return true;
    } catch( const std::exception &exception ) {
        error = exception.what();
        return false;
    }
}

void runtime_after_save( bool success, std::string_view error )
{
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        sol::table payload = owner->lua->create_table();
        payload["success"] = success;
        payload["error"] = std::string( error );
        dispatch_lifecycle( *owner, "after_save", payload );
    }
}

void runtime_process_character_recurring( Character &character )
{
    const std::int64_t now = to_turn<std::int64_t>( calendar::turn );
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        for( const runtime::character_recurring_registration &registration :
             owner->character_recurring_handlers ) {
            const std::string failure_key = registration.due_variable + ':' +
                                            std::to_string( character.getID().get_value() );
            std::optional<std::int64_t> due;
            if( const diag_value *stored = character.maybe_get_value(
                                               registration.due_variable ) ) {
                const double raw = stored->dbl();
                if( std::isfinite( raw ) && raw >= 0.0 &&
                    raw <= static_cast<double>( std::numeric_limits<std::int64_t>::max() ) &&
                    std::trunc( raw ) == raw ) {
                    due = static_cast<std::int64_t>( raw );
                }
            }
            const bool first_schedule = !due.has_value();
            if( due && *due > now ) {
                continue;
            }
            if( owner->callback_depth >= 16 ) {
                continue;
            }
            sol::table payload = owner->lua->create_table();
            payload["character"] = platform_creature_handle( *owner, character );
            payload["first_schedule"] = first_schedule;
            if( due ) {
                payload["due_turn"] = *due;
                payload["overdue_turns"] = nonnegative_turn_difference( now, *due );
            } else {
                payload["due_turn"] = sol::nil;
                payload["overdue_turns"] = 0;
            }
            if( !first_schedule ) {
                const auto effect = owner->handlers.find(
                                        registration.effect_handler );
                if( effect == owner->handlers.end() ) {
                    continue;
                }
                sol::protected_function callback = effect->second.callback;
                callback_scope scope( *owner );
                const sol::protected_function_result result = callback( payload );
                if( !result.valid() ) {
                    report_callback_error(
                        *owner, registration.effect_handler, result );
                }
            }
            const auto interval = owner->handlers.find(
                                      registration.interval_handler );
            if( interval == owner->handlers.end() ) {
                continue;
            }
            sol::protected_function interval_callback = interval->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result interval_result =
                interval_callback( payload );
            std::optional<std::int64_t> interval_turns;
            if( interval_result.valid() && interval_result.return_count() == 1 &&
                interval_result.get_type() == sol::type::number ) {
                const double raw = interval_result.get<double>();
                if( std::isfinite( raw ) && raw >= 1.0 &&
                    raw <= static_cast<double>( maximum_character_recurrence_turns ) &&
                    std::trunc( raw ) == raw ) {
                    interval_turns = static_cast<std::int64_t>( raw );
                }
            } else if( !interval_result.valid() ) {
                report_callback_error(
                    *owner, registration.interval_handler, interval_result );
            }
            if( !interval_turns ) {
                if( owner->reported_character_recurring_failures.insert(
                        failure_key ).second ) {
                    DebugLog( D_ERROR, D_MAIN )
                            << "Lua-first character recurrence '" << owner->mod_id
                            << ':' << registration.interval_handler
                            << "' must return one integral interval from 1 through "
                            << maximum_character_recurrence_turns;
                }
                character.set_value(
                    registration.due_variable,
                    static_cast<double>(
                        now > std::numeric_limits<std::int64_t>::max() -
                        maximum_character_recurrence_turns ?
                        std::numeric_limits<std::int64_t>::max() :
                        now + maximum_character_recurrence_turns ) );
                continue;
            }
            owner->reported_character_recurring_failures.erase( failure_key );
            if( now > std::numeric_limits<std::int64_t>::max() -
                *interval_turns ) {
                character.set_value(
                    registration.due_variable,
                    static_cast<double>( std::numeric_limits<std::int64_t>::max() ) );
            } else {
                character.set_value(
                    registration.due_variable,
                    static_cast<double>( now + *interval_turns ) );
            }
        }
    }
}

void runtime_process_tasks()
{
    const std::int64_t now = to_turn<std::int64_t>( calendar::turn );
    for( const std::shared_ptr<runtime> &owner : detail::active_runtime_values() ) {
        if( !owner || !owner->world_is_ready ) {
            continue;
        }
        std::set<std::uint64_t> retired_task_ids;
        for( persistent_task &task : owner->tasks ) {
            if( task.owner_mod_id.empty() ) {
                task.owner_mod_id = owner->mod_id;
            }
            if( task.owner_mod_id != owner->mod_id ) {
                DebugLog( D_ERROR, D_MAIN ) << "Discarding Lua-first task " << task.id
                                            << " because its owner Mod does not match runtime '"
                                            << owner->mod_id << "'";
                retired_task_ids.insert( task.id );
                continue;
            }
            const int actor_identity_count =
                static_cast<int>( task.actor_character_id.has_value() ) +
                static_cast<int>( task.actor_item_uid.has_value() ) +
                static_cast<int>( task.actor_monster_uid.has_value() ) +
                static_cast<int>( task.actor_vehicle_uid.has_value() );
            if( actor_identity_count > 1 ) {
                DebugLog( D_ERROR, D_MAIN ) << "Discarding Lua-first task " << task.id
                                            << " because it has multiple actor identities";
                retired_task_ids.insert( task.id );
                continue;
            }
            const auto handler = owner->handlers.find( task.handler_id );
            if( handler == owner->handlers.end() ) {
                DebugLog( D_WARNING, D_MAIN ) << "Discarding Lua-first task " << task.id
                                              << " for missing handler '" << owner->mod_id
                                              << ':' << task.handler_id << "'";
                retired_task_ids.insert( task.id );
                continue;
            }
            if( handler->second.payload_version == task.payload_version ) {
                owner->reported_task_migration_failures.erase( task.id );
                continue;
            }
            std::string migration_error;
            if( !migrate_task_payload( *owner, task, migration_error ) ) {
                DebugLog( D_WARNING, D_MAIN ) << "Discarding Lua-first task " << task.id
                                              << " with unmigrated payload for '"
                                              << owner->mod_id << ':' << task.handler_id
                                              << "': " << migration_error;
                retired_task_ids.insert( task.id );
            } else {
                owner->reported_task_migration_failures.erase( task.id );
            }
        }
        if( !retired_task_ids.empty() ) {
            owner->tasks.erase( std::remove_if(
                                    owner->tasks.begin(), owner->tasks.end(),
            [&retired_task_ids]( const persistent_task & task ) {
                return retired_task_ids.count( task.id ) != 0;
            } ), owner->tasks.end() );
            for( const std::uint64_t task_id : retired_task_ids ) {
                owner->reported_task_migration_failures.erase( task_id );
            }
        }
        std::vector<persistent_task> due;
        owner->tasks.erase( std::remove_if( owner->tasks.begin(), owner->tasks.end(),
        [&due, &owner, now]( const persistent_task & task ) {
            const auto handler = owner->handlers.find( task.handler_id );
            if( task.due_turn <= now && handler != owner->handlers.end() &&
                handler->second.payload_version == task.payload_version ) {
                due.push_back( task );
                return true;
            }
            return false;
        } ), owner->tasks.end() );
        for( const persistent_task &task : due ) {
            owner->reported_task_migration_failures.erase( task.id );
        }
        std::sort( due.begin(), due.end(), []( const persistent_task & lhs,
        const persistent_task & rhs ) {
            return std::tie( lhs.due_turn, lhs.id ) < std::tie( rhs.due_turn, rhs.id );
        } );
        for( const persistent_task &task : due ) {
            const auto handler = owner->handlers.find( task.handler_id );
            if( handler == owner->handlers.end() ) {
                DebugLog( D_ERROR, D_MAIN ) << "Discarding Lua-first task " << task.id
                                            << " for missing handler '" << owner->mod_id
                                            << ":" << task.handler_id << "'";
                continue;
            }
            if( handler->second.payload_version != task.payload_version ) {
                // Invalid tasks are retired before due extraction.  Keep this
                // guard for corrupted in-memory input copied into the due list.
                DebugLog( D_ERROR, D_MAIN ) << "Discarding Lua-first task " << task.id
                                            << " because payload version "
                                            << task.payload_version << " does not match handler version "
                                            << handler->second.payload_version;
                continue;
            }
            std::optional<cata::lua_platform::game_handle> actor_handle;
            if( task.actor_character_id ) {
                Character *actor_character = platform_event_character(
                                                 *task.actor_character_id );
                if( actor_character == nullptr ) {
                    DebugLog( D_WARNING, D_MAIN )
                            << "Discarding Lua-first task " << task.id
                            << " because Character "
                            << task.actor_character_id->get_value()
                            << " is no longer available";
                    continue;
                }
                actor_handle = platform_creature_handle( *owner, *actor_character );
            } else if( task.actor_item_uid ) {
                item_location actor_item = find_item_by_uid(
                                               *task.actor_item_uid,
                                               persistent_task_item_hint( task ) );
                if( !actor_item ) {
                    if( now > std::numeric_limits<std::int64_t>::max() -
                        persistent_item_task_retry_turns ) {
                        DebugLog( D_ERROR, D_MAIN )
                                << "Stopping Lua-first Item task " << task.id
                                << " because its retry due turn would overflow";
                    } else {
                        persistent_task retry = task;
                        retry.due_turn = now + persistent_item_task_retry_turns;
                        retry.actor_item_pending = true;
                        owner->tasks.push_back( std::move( retry ) );
                    }
                    continue;
                }
                const cata::lua_platform::game_handle_locator stored_hint =
                    task.actor_item_hint.value_or(
                        cata::lua_platform::game_handle_locator{} );
                actor_handle = platform_item_handle( *owner, actor_item, stored_hint );
            } else if( task.actor_monster_uid ) {
                const shared_ptr_fast<monster> actor_monster =
                    get_creature_tracker().find_by_uid( *task.actor_monster_uid );
                if( !actor_monster ) {
                    if( now > std::numeric_limits<std::int64_t>::max() -
                        persistent_monster_task_retry_turns ) {
                        DebugLog( D_ERROR, D_MAIN )
                                << "Stopping Lua-first Monster task " << task.id
                                << " because its retry due turn would overflow";
                    } else {
                        persistent_task retry = task;
                        retry.due_turn = now + persistent_monster_task_retry_turns;
                        retry.actor_monster_pending = true;
                        owner->tasks.push_back( std::move( retry ) );
                    }
                    continue;
                }
                actor_handle = platform_creature_handle( *owner, *actor_monster );
            } else if( task.actor_vehicle_uid ) {
                vehicle *actor_vehicle = vehicle::find_vehicle_by_uid(
                                             get_map(), *task.actor_vehicle_uid );
                if( actor_vehicle == nullptr ) {
                    if( now > std::numeric_limits<std::int64_t>::max() -
                        persistent_vehicle_task_retry_turns ) {
                        DebugLog( D_ERROR, D_MAIN )
                                << "Stopping Lua-first Vehicle task " << task.id
                                << " because its retry due turn would overflow";
                    } else {
                        persistent_task retry = task;
                        retry.due_turn = now + persistent_vehicle_task_retry_turns;
                        retry.actor_vehicle_pending = true;
                        owner->tasks.push_back( std::move( retry ) );
                    }
                    continue;
                }
                actor_handle = platform_vehicle_handle( *owner, *actor_vehicle );
            }
            persistent_task dispatch_task = task;
            if( actor_handle ) {
                if( dispatch_task.actor_item_uid ) {
                    dispatch_task.actor_item_pending = false;
                    dispatch_task.actor_item_hint = actor_handle->locator();
                } else if( dispatch_task.actor_monster_uid ) {
                    dispatch_task.actor_monster_pending = false;
                    dispatch_task.actor_monster_hint = actor_handle->locator();
                } else if( dispatch_task.actor_vehicle_uid ) {
                    dispatch_task.actor_vehicle_pending = false;
                    dispatch_task.actor_vehicle_hint = actor_handle->locator();
                }
            }
            sol::table participant_handles = owner->lua->create_table();
            bool participant_missing = false;
            for( persistent_task_participant &participant : dispatch_task.participants ) {
                std::optional<cata::lua_platform::game_handle> participant_handle;
                switch( participant.kind ) {
                    case persistent_task_participant_kind::character: {
                        if( participant.stable_id <= 0 ||
                            participant.stable_id > std::numeric_limits<int>::max() ) {
                            participant_missing = true;
                            participant.pending = true;
                            break;
                        }
                        Character *value = platform_event_character(
                                               character_id( static_cast<int>(
                                                       participant.stable_id ) ) );
                        if( value != nullptr ) {
                            participant_handle = platform_creature_handle( *owner, *value );
                        }
                        break;
                    }
                    case persistent_task_participant_kind::item: {
                        item_location value = find_item_by_uid(
                                                  participant.stable_id,
                                                  persistent_item_hint( participant.hint ) );
                        if( value ) {
                            participant_handle = platform_item_handle(
                                                     *owner, value, participant.hint );
                        }
                        break;
                    }
                    case persistent_task_participant_kind::monster: {
                        const shared_ptr_fast<monster> value =
                            get_creature_tracker().find_by_uid( participant.stable_id );
                        if( value ) {
                            participant_handle = platform_creature_handle( *owner, *value );
                        }
                        break;
                    }
                    case persistent_task_participant_kind::vehicle: {
                        vehicle *value = vehicle::find_vehicle_by_uid(
                                             get_map(), participant.stable_id );
                        if( value != nullptr ) {
                            participant_handle = platform_vehicle_handle( *owner, *value );
                        }
                        break;
                    }
                }
                if( !participant_handle ) {
                    participant.pending = true;
                    participant_missing = true;
                    continue;
                }
                participant.pending = false;
                participant.hint = participant_handle->locator();
                participant_handles[participant.role] = *participant_handle;
            }
            if( participant_missing ) {
                if( now > std::numeric_limits<std::int64_t>::max() -
                    persistent_participant_task_retry_turns ) {
                    DebugLog( D_ERROR, D_MAIN )
                            << "Stopping Lua-first participant task " << task.id
                            << " because its retry due turn would overflow";
                } else {
                    dispatch_task.due_turn =
                        now + persistent_participant_task_retry_turns;
                    owner->tasks.push_back( std::move( dispatch_task ) );
                }
                continue;
            }
            std::optional<std::int64_t> next_due_turn;
            if( task.interval_turns > 0 ) {
                if( now > std::numeric_limits<std::int64_t>::max() -
                    task.interval_turns ) {
                    DebugLog( D_ERROR, D_MAIN )
                            << "Stopping Lua-first recurring task " << task.id
                            << " because its next due turn would overflow";
                } else {
                    persistent_task next = dispatch_task;
                    next.due_turn = now + task.interval_turns;
                    next.actor_item_pending = false;
                    if( task.actor_item_uid && actor_handle ) {
                        next.actor_item_hint = actor_handle->locator();
                    }
                    next.actor_monster_pending = false;
                    if( task.actor_monster_uid && actor_handle ) {
                        next.actor_monster_hint = actor_handle->locator();
                    }
                    next.actor_vehicle_pending = false;
                    if( task.actor_vehicle_uid && actor_handle ) {
                        next.actor_vehicle_hint = actor_handle->locator();
                    }
                    next_due_turn = next.due_turn;
                    owner->tasks.push_back( std::move( next ) );
                }
            }
            sol::table payload = owner->lua->create_table();
            payload["id"] = static_cast<std::int64_t>( task.id );
            payload["due_turn"] = task.due_turn;
            payload["overdue_turns"] = nonnegative_turn_difference( now, task.due_turn );
            payload["recurring"] = task.interval_turns > 0;
            payload["interval_turns"] = task.interval_turns;
            if( next_due_turn ) {
                payload["next_due_turn"] = *next_due_turn;
            } else {
                payload["next_due_turn"] = sol::nil;
            }
            payload["owner"] = task.owner;
            payload["owner_mod_id"] = task.owner_mod_id;
            payload["participants"] = std::move( participant_handles );
            if( actor_handle ) {
                payload["actor"] = *actor_handle;
                if( task.actor_character_id ) {
                    payload["actor_kind"] = "character";
                    payload["actor_character_id"] =
                        task.actor_character_id->get_value();
                    payload["actor_item_uid"] = sol::nil;
                    payload["actor_monster_uid"] = sol::nil;
                    payload["actor_vehicle_uid"] = sol::nil;
                } else if( task.actor_item_uid ) {
                    payload["actor_kind"] = "item";
                    payload["actor_character_id"] = sol::nil;
                    payload["actor_item_uid"] = *task.actor_item_uid;
                    payload["actor_monster_uid"] = sol::nil;
                    payload["actor_vehicle_uid"] = sol::nil;
                } else if( task.actor_monster_uid ) {
                    payload["actor_kind"] = "monster";
                    payload["actor_character_id"] = sol::nil;
                    payload["actor_item_uid"] = sol::nil;
                    payload["actor_monster_uid"] = *task.actor_monster_uid;
                    payload["actor_vehicle_uid"] = sol::nil;
                } else {
                    payload["actor_kind"] = "vehicle";
                    payload["actor_character_id"] = sol::nil;
                    payload["actor_item_uid"] = sol::nil;
                    payload["actor_monster_uid"] = sol::nil;
                    payload["actor_vehicle_uid"] = *task.actor_vehicle_uid;
                }
            } else {
                payload["actor"] = sol::nil;
                payload["actor_kind"] = sol::nil;
                payload["actor_character_id"] = sol::nil;
                payload["actor_item_uid"] = sol::nil;
                payload["actor_monster_uid"] = sol::nil;
                payload["actor_vehicle_uid"] = sol::nil;
            }
            payload["payload_version"] = task.payload_version;
            payload["payload"] = persistent_table( *owner->lua, task.payload );
            sol::protected_function callback = handler->second.callback;
            callback_scope scope( *owner );
            const sol::protected_function_result result = callback( payload );
            if( !result.valid() ) {
                report_callback_error( *owner, task.handler_id, result );
            } else if( next_due_turn && result.return_count() > 0 &&
                       result.get_type() == sol::type::boolean &&
                       !result.get<bool>() ) {
                owner->tasks.erase( std::remove_if(
                                        owner->tasks.begin(), owner->tasks.end(),
                [&task]( const persistent_task & candidate ) {
                    return candidate.id == task.id;
                } ), owner->tasks.end() );
            }
        }
    }
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
