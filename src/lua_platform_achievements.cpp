#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_achievements.h"

extern "C" {
#include <lua.h>
}
#include <translation.h>
#include <type_id.h>
#include <algorithm>
#include <cctype>
#include <cstddef>
#include <optional>
#include <stdexcept>
#include <string>
#include <unordered_set>
#include <utility>
#include <vector>

#include "achievement.h"
#include "enum_conversions.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_achievement_limit = 64;
constexpr int maximum_achievement_limit = 256;
constexpr int maximum_achievement_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_nested_values = 128;

std::string lowercase_ascii( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    return value;
}

void require_achievement_id(
    const script_game_id &id,
    const std::string &api_name )
{
    if( id.kind() != "achievement" ) {
        throw std::invalid_argument(
            api_name +
            " requires GameId<achievement>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name +
            " requires a valid GameId<achievement>" );
    }
}

const achievement &resolve_achievement(
    const script_game_id &id,
    const std::string &api_name )
{
    require_achievement_id( id, api_name );
    return achievement_id( id.value() ).obj();
}

sol::table snapshot_achievement_definition(
    sol::state_view lua,
    const achievement &entry )
{
    sol::table result = lua.create_table();
    result["id"] =
        script_game_id(
            "achievement", entry.id.str() );
    result["name"] =
        entry.name().translated();
    result["description"] =
        entry.description().translated();
    result["conduct"] =
        entry.is_conduct();
    result["manually_given"] =
        entry.is_manually_given();
    result["requirements"] =
        entry.requirement_count();
    result["loaded"] =
        entry.was_loaded;

    const std::size_t hidden_returned =
        std::min<std::size_t>(
            entry.hidden_by().size(),
            maximum_nested_values );
    sol::table hidden_items =
        lua.create_table(
            static_cast<int>(
                hidden_returned ), 0 );
    for( std::size_t index = 0;
         index < hidden_returned;
         ++index ) {
        hidden_items[index + 1] =
            script_game_id(
                "achievement",
                entry.hidden_by()[index].str() );
    }
    sol::table hidden = lua.create_table();
    hidden["items"] =
        std::move( hidden_items );
    hidden["total"] =
        entry.hidden_by().size();
    hidden["returned"] =
        hidden_returned;
    hidden["truncated"] =
        hidden_returned <
        entry.hidden_by().size();
    result["hidden_by"] =
        std::move( hidden );

    const std::size_t source_returned =
        std::min<std::size_t>(
            entry.src.size(),
            maximum_nested_values );
    sol::table source_items =
        lua.create_table(
            static_cast<int>(
                source_returned ), 0 );
    for( std::size_t index = 0;
         index < source_returned;
         ++index ) {
        sol::table source =
            lua.create_table();
        source["achievement"] =
            script_game_id(
                "achievement",
                entry.src[index].first.str() );
        source["mod"] =
            entry.src[index].second.str();
        source_items[index + 1] =
            std::move( source );
    }
    sol::table sources =
        lua.create_table();
    sources["items"] =
        std::move( source_items );
    sources["total"] =
        entry.src.size();
    sources["returned"] =
        source_returned;
    sources["truncated"] =
        source_returned <
        entry.src.size();
    result["sources"] =
        std::move( sources );

    if( entry.time_constraint() ) {
        sol::table constraint =
            lua.create_table();
        constraint["target"] =
            script_time_point::from_native(
                entry.time_constraint()->
                target() );
        constraint["completion"] =
            io::enum_to_string(
                entry.time_constraint()->
                completed() );
        constraint["becomes_false"] =
            entry.time_constraint()->
            becomes_false();
        constraint["text"] =
            entry.time_constraint()->
            ui_text(
                entry.is_conduct() );
        result["time_constraint"] =
            std::move( constraint );
    } else {
        result["time_constraint"] =
            sol::nil;
    }
    return result;
}

std::unordered_set<achievement_id>
valid_achievement_ids()
{
    std::unordered_set<achievement_id> result;
    for( const achievement *entry :
         get_achievements().
         valid_achievements() ) {
        if( entry != nullptr ) {
            result.insert( entry->id );
        }
    }
    return result;
}

sol::table snapshot_achievement_state(
    sol::state_view lua,
    const achievement &entry,
    const std::unordered_set <
    achievement_id > &valid_ids )
{
    sol::table result =
        snapshot_achievement_definition(
            lua, entry );
    achievements_tracker &tracker =
        get_achievements();
    const bool valid =
        valid_ids.count( entry.id ) != 0;
    const achievement_completion completion =
        tracker.is_completed(
            entry.id );
    result["valid"] = valid;
    result["completion"] =
        io::enum_to_string(
            completion );
    result["pending"] =
        completion ==
        achievement_completion::pending;
    result["completed"] =
        completion ==
        achievement_completion::completed;
    result["failed"] =
        completion ==
        achievement_completion::failed;
    result["hidden"] =
        tracker.is_hidden( &entry );
    if( valid ) {
        result["ui_text"] =
            tracker.ui_text_for(
                &entry );
    } else {
        result["ui_text"] =
            sol::nil;
    }
    return result;
}

struct achievement_list_options {
    int offset = 0;
    int limit = default_achievement_limit;
    std::string query;
    std::optional<std::string> completion;
    std::optional<bool> conduct;
    std::optional<bool> manually_given;
    std::optional<bool> valid;
};

bool require_boolean(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be a boolean" );
    }
    return value.as<bool>();
}

int require_integer(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be an integer" );
    }
    const lua_Integer number =
        value.as<lua_Integer>();
    if( number < 0 ||
        number >
        maximum_achievement_offset ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be within 0..1000000" );
    }
    return static_cast<int>( number );
}

std::string require_string(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<std::string>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must be a string" );
    }
    return value.as<std::string>();
}

achievement_list_options read_list_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    achievement_list_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &option : *requested ) {
        const sol::object key_object =
            option.first;
        if( key_object.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                api_name +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const sol::object value =
            option.second;
        if( key == "offset" ) {
            result.offset =
                require_integer(
                    value, api_name, key );
        } else if( key == "limit" ) {
            result.limit =
                std::min(
                    require_integer(
                        value, api_name, key ),
                    maximum_achievement_limit );
        } else if( key == "query" ) {
            result.query =
                require_string(
                    value, api_name, key );
            if( result.query.size() >
                maximum_query_bytes ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'query' exceeds 128 bytes" );
            }
        } else if( key == "completion" ) {
            result.completion =
                require_string(
                    value, api_name, key );
            if( *result.completion != "pending" &&
                *result.completion != "completed" &&
                *result.completion != "failed" ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'completion' must be pending, completed, or failed" );
            }
        } else if( key == "conduct" ) {
            result.conduct =
                require_boolean(
                    value, api_name, key );
        } else if( key == "manually_given" ) {
            result.manually_given =
                require_boolean(
                    value, api_name, key );
        } else if( key == "valid" ) {
            result.valid =
                require_boolean(
                    value, api_name, key );
        } else {
            throw std::invalid_argument(
                api_name +
                " received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

std::vector<const achievement *>
matching_achievements(
    const achievement_list_options &options,
    const bool include_live_filters,
    const std::unordered_set <
    achievement_id > &valid_ids )
{
    const std::string query =
        lowercase_ascii(
            options.query );
    std::vector<const achievement *> result;
    for( const achievement &entry :
         achievement::get_all() ) {
        if( !query.empty() &&
            lowercase_ascii(
                entry.id.str() ).find(
                query ) ==
            std::string::npos &&
            lowercase_ascii(
                entry.name().translated() ).find(
                query ) ==
            std::string::npos ) {
            continue;
        }
        if( options.conduct &&
            entry.is_conduct() !=
            *options.conduct ) {
            continue;
        }
        if( options.manually_given &&
            entry.is_manually_given() !=
            *options.manually_given ) {
            continue;
        }
        if( include_live_filters ) {
            const bool valid =
                valid_ids.count(
                    entry.id ) != 0;
            if( options.valid &&
                valid != *options.valid ) {
                continue;
            }
            if( options.completion &&
                io::enum_to_string(
                    get_achievements().
                    is_completed(
                        entry.id ) ) !=
                *options.completion ) {
                continue;
            }
        }
        result.push_back( &entry );
    }
    std::sort(
        result.begin(), result.end(),
        []( const achievement * lhs,
    const achievement * rhs ) {
        return lhs->id.str() <
               rhs->id.str();
    } );
    return result;
}

sol::table list_achievement_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const achievement_list_options options =
        read_list_options(
            requested,
            "services.achievements.definitions" );
    if( options.completion ||
        options.valid ) {
        throw std::invalid_argument(
            "services.achievements.definitions does not accept live-state filters" );
    }
    const std::unordered_set <
    achievement_id > empty_valid;
    const std::vector <
    const achievement * > matches =
        matching_achievements(
            options, false,
            empty_valid );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset,
            matches.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            matches.size() );
    sol::state_view state( lua );
    sol::table items =
        state.create_table(
            static_cast<int>(
                last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_achievement_definition(
                state, *matches[index] );
    }
    sol::table result =
        state.create_table();
    result["items"] =
        std::move( items );
    result["offset"] =
        options.offset;
    result["limit"] =
        options.limit;
    result["total"] =
        matches.size();
    result["returned"] =
        last - first;
    result["has_more"] =
        last < matches.size();
    return result;
}

sol::table get_achievement_definition(
    sol::this_state lua,
    const script_game_id &id )
{
    return snapshot_achievement_definition(
               sol::state_view( lua ),
               resolve_achievement(
                   id,
                   "services.achievements.definition" ) );
}

sol::table list_achievement_states(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const achievement_list_options options =
        read_list_options(
            requested,
            "services.achievements.list" );
    const std::unordered_set <
    achievement_id > valid_ids =
        valid_achievement_ids();
    const std::vector <
    const achievement * > matches =
        matching_achievements(
            options, true,
            valid_ids );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset,
            matches.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            matches.size() );
    sol::state_view state( lua );
    sol::table items =
        state.create_table(
            static_cast<int>(
                last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_achievement_state(
                state, *matches[index],
                valid_ids );
    }
    sol::table value =
        state.create_table();
    value["items"] =
        std::move( items );
    value["offset"] =
        options.offset;
    value["limit"] =
        options.limit;
    value["total"] =
        matches.size();
    value["returned"] =
        last - first;
    value["has_more"] =
        last < matches.size();
    value["enabled"] =
        get_achievements().
        is_enabled();
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

sol::table get_achievement_state(
    sol::this_state lua,
    const script_game_id &id )
{
    const achievement &entry =
        resolve_achievement(
            id,
            "services.achievements.get" );
    const std::unordered_set <
    achievement_id > valid_ids =
        valid_achievement_ids();
    sol::state_view state( lua );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   snapshot_achievement_state(
                       state, entry,
                       valid_ids ) ) );
}

sol::table set_achievements_enabled(
    sol::this_state lua,
    const bool enabled )
{
    achievements_tracker &tracker =
        get_achievements();
    const bool before =
        tracker.is_enabled();
    tracker.set_enabled( enabled );
    sol::state_view state( lua );
    sol::table value =
        state.create_table();
    value["before"] = before;
    value["after"] =
        tracker.is_enabled();
    value["changed"] =
        before !=
        tracker.is_enabled();
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

achievement_completion read_completion(
    const std::string &completion,
    const std::string &api_name )
{
    if( completion == "completed" ) {
        return achievement_completion::completed;
    }
    if( completion == "failed" ) {
        return achievement_completion::failed;
    }
    throw std::invalid_argument(
        api_name +
        " completion must be completed or failed" );
}

sol::table report_manual_achievement(
    sol::this_state lua,
    const script_game_id &id,
    const std::string &requested_completion )
{
    const achievement &entry =
        resolve_achievement(
            id,
            "services.achievements.report" );
    const achievement_completion completion =
        read_completion(
            requested_completion,
            "services.achievements.report" );
    sol::state_view state( lua );
    if( !entry.is_manually_given() ) {
        return make_game_error_result(
        state, {
            "not_manual",
            "Only manually-given achievements can be reported by Lua"
        } );
    }
    const std::unordered_set <
    achievement_id > valid_ids =
        valid_achievement_ids();
    if( !valid_ids.count(
            entry.id ) ) {
        return make_game_error_result(
        state, {
            "not_active",
            "The achievement was not present when this game started"
        } );
    }
    achievements_tracker &tracker =
        get_achievements();
    if( tracker.is_completed(
            entry.id ) !=
        achievement_completion::pending ) {
        return make_game_error_result(
        state, {
            "not_pending",
            "The achievement is no longer pending"
        } );
    }
    if( !tracker.report_manual_achievement(
            entry, completion ) ) {
        return make_game_error_result(
        state, {
            "report_failed",
            "The achievement tracker rejected the requested completion"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   snapshot_achievement_state(
                       state, entry,
                       valid_ids ) ) );
}

sol::table reset_manual_achievement(
    sol::this_state lua,
    const script_game_id &id )
{
    const achievement &entry =
        resolve_achievement(
            id,
            "services.achievements.reset" );
    sol::state_view state( lua );
    if( !entry.is_manually_given() ) {
        return make_game_error_result(
        state, {
            "not_manual",
            "Only manually-given achievements can be reset by Lua"
        } );
    }
    const achievement_completion before =
        get_achievements().
        is_completed(
            entry.id );
    if( !get_achievements().
        reset_manual_achievement(
            entry ) ) {
        return make_game_error_result(
        state, {
            "reset_failed",
            "The achievement is not active in this game"
        } );
    }
    const std::unordered_set <
    achievement_id > valid_ids =
        valid_achievement_ids();
    sol::table value =
        state.create_table();
    value["before"] =
        io::enum_to_string(
            before );
    value["after"] =
        io::enum_to_string(
            get_achievements().
            is_completed(
                entry.id ) );
    value["changed"] =
        before !=
        get_achievements().
        is_completed(
            entry.id );
    value["achievement"] =
        snapshot_achievement_state(
            state, entry,
            valid_ids );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

} // namespace

void install_achievement_api(
    sol::table &services,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua(
        services.lua_state() );
    sol::table achievements =
        lua.create_table();
    achievements.set_function(
        "definitions",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_achievement_definitions(
                   state, options );
    } );
    achievements.set_function(
        "definition",
        [require_read]( sol::this_state state,
    const script_game_id & id ) {
        require_read();
        return get_achievement_definition(
                   state, id );
    } );
    achievements.set_function(
        "list",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_achievement_states(
                   state, options );
    } );
    achievements.set_function(
        "get",
        [require_read]( sol::this_state state,
    const script_game_id & id ) {
        require_read();
        return get_achievement_state(
                   state, id );
    } );
    achievements.set_function(
        "set_enabled",
        [require_write]( sol::this_state state,
    const bool enabled ) {
        require_write();
        return set_achievements_enabled(
                   state, enabled );
    } );
    achievements.set_function(
        "report",
        [require_write]( sol::this_state state,
                         const script_game_id & id,
    const std::string & completion ) {
        require_write();
        return report_manual_achievement(
                   state, id,
                   completion );
    } );
    achievements.set_function(
        "reset",
        [require_write]( sol::this_state state,
    const script_game_id & id ) {
        require_write();
        return reset_manual_achievement(
                   state, id );
    } );
    services["achievements"] =
        std::move( achievements );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
