#include "catalua_ui_npcs.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "npc_class.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_nested_ids = 128;

struct definition_options {
    int offset = 0;
    int limit = default_definition_limit;
    std::string query;
};

std::string lowercase_ascii( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    return value;
}

definition_options read_definition_options(
    const sol::optional<sol::table> &requested )
{
    definition_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.query = requested->get_or(
                           "query", result.query );
    }
    if( result.offset < 0 ||
        result.offset > maximum_definition_offset ) {
        throw std::invalid_argument(
            "game.npcs.classes offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.npcs.classes limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.npcs.classes query exceeds 128 bytes" );
    }
    return result;
}

void require_npc_class_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "npc_class" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<npc_class>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<npc_class>" );
    }
}

template<typename Map>
sol::table leveled_id_page(
    sol::state_view lua, const std::string_view kind,
    const Map &ids )
{
    const std::size_t returned = std::min(
                                     ids.size(),
                                     maximum_nested_ids );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &entry : ids ) {
        if( index >= returned ) {
            break;
        }
        sol::table value = lua.create_table();
        value["id"] = script_game_id(
                          std::string( kind ),
                          entry.first.str() );
        value["level"] = entry.second;
        items[index + 1] = std::move( value );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ids.size();
    result["returned"] = returned;
    result["truncated"] = returned < ids.size();
    return result;
}

template<typename Container>
sol::table plain_id_page(
    sol::state_view lua, const std::string_view kind,
    const Container &ids )
{
    const std::size_t returned = std::min(
                                     ids.size(),
                                     maximum_nested_ids );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &id : ids ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] = script_game_id(
                               std::string( kind ),
                               id.str() );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ids.size();
    result["returned"] = returned;
    result["truncated"] = returned < ids.size();
    return result;
}

sol::table snapshot_class(
    sol::state_view lua, const npc_class &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "npc_class", definition.id.str() );
    result["name"] = definition.get_name();
    result["job_description"] =
        definition.get_job_description();
    result["common"] = definition.is_common();
    result["sells_belongings"] =
        definition.sells_belongings;
    result["restock_interval"] =
        script_time_duration::from_native(
            definition.get_shop_restock_interval() );
    const std::pair<int, int> work_hours =
        definition.get_work_hours();
    sol::table work = lua.create_table();
    work["start_hour"] = work_hours.first;
    work["end_hour"] = work_hours.second;
    result["work_hours"] = std::move( work );
    result["shop_item_group_count"] =
        definition.get_shopkeeper_items().size();
    result["starting_spells"] =
        leveled_id_page(
            lua, "spell",
            definition._starting_spells );
    result["starting_bionics"] =
        leveled_id_page(
            lua, "bionic",
            definition.bionic_list );
    result["starting_proficiencies"] =
        plain_id_page(
            lua, "proficiency",
            definition._starting_proficiencies );
    return result;
}

std::vector<const npc_class *> matching_classes(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<npc_class> &all =
        npc_class::get_all();
    std::vector<const npc_class *> result;
    result.reserve( all.size() );
    for( const npc_class &definition : all ) {
        if( query.empty() ||
            lowercase_ascii(
                definition.id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                definition.get_name() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const npc_class * lhs, const npc_class * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    return result;
}

sol::table list_classes(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const npc_class *> definitions =
        matching_classes( options.query );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, definitions.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit,
                                 definitions.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_class(
                state, *definitions[index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = definitions.size();
    result["returned"] = last - first;
    result["has_more"] = last < definitions.size();
    return result;
}

sol::table get_class(
    sol::this_state lua, const script_game_id &id )
{
    require_npc_class_id(
        id, "game.npcs.class" );
    return snapshot_class(
               sol::state_view( lua ),
               npc_class_id( id.value() ).obj() );
}

} // namespace

void install_npc_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    static_cast<void>( current_runtime_generation );
    static_cast<void>( current_world_generation );
    static_cast<void>( require_write );
    sol::state_view lua( game.lua_state() );
    sol::table npcs = lua.create_table();
    npcs.set_function(
        "classes",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_classes( lua_state, options );
    } );
    npcs.set_function(
        "class",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_class( lua_state, id );
    } );
    game["npcs"] = std::move( npcs );
}

} // namespace cata::lua_ui
