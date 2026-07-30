#include "catalua_ui_vehicles.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "veh_type.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_prototype_parts = 256;

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
            "game.vehicles.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.vehicles.definitions limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.vehicles.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_vehicle_prototype_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "vehicle_prototype" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<vehicle_prototype>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<vehicle_prototype>" );
    }
}

sol::table snapshot_prototype_parts(
    sol::state_view lua,
    const std::vector<vehicle_prototype::part_def> &parts )
{
    const std::size_t returned = std::min(
                                     parts.size(),
                                     maximum_prototype_parts );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const vehicle_prototype::part_def &part =
            parts[index];
        sol::table value = lua.create_table();
        value["id"] = script_game_id(
                          "vehicle_part", part.part.str() );
        sol::table mount = lua.create_table();
        mount["x"] = part.pos.x();
        mount["y"] = part.pos.y();
        value["mount"] = std::move( mount );
        value["variant"] = part.variant;
        value["with_ammo"] = part.with_ammo;
        if( part.fuel.is_null() ) {
            value["fuel"] = sol::nil;
        } else {
            value["fuel"] = script_game_id(
                                "item", part.fuel.str() );
        }
        items[index + 1] = std::move( value );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = parts.size();
    result["returned"] = returned;
    result["truncated"] = returned < parts.size();
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const vehicle_prototype &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "vehicle_prototype",
                       definition.id.str() );
    result["name"] = definition.name.translated();
    result["parts"] =
        snapshot_prototype_parts(
            lua, definition.parts );
    result["item_spawn_count"] =
        definition.item_spawns.size();
    result["zone_count"] =
        definition.zone_defs.size();
    result["has_blueprint"] =
        static_cast<bool>( definition.blueprint );
    if( definition.color_palette.is_null() ) {
        result["color_palette"] = sol::nil;
    } else {
        result["color_palette"] = script_game_id(
                                      "vehicle_palette",
                                      definition.color_palette.str() );
    }
    return result;
}

std::vector<const vehicle_prototype *> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<vehicle_prototype> &all =
        vehicles::get_all_prototypes();
    std::vector<const vehicle_prototype *> result;
    result.reserve( all.size() );
    for( const vehicle_prototype &definition : all ) {
        if( query.empty() ||
            lowercase_ascii(
                definition.id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                definition.name.translated() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const vehicle_prototype * lhs,
        const vehicle_prototype * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const vehicle_prototype *> definitions =
        matching_definitions( options.query );
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
            snapshot_definition(
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

sol::table get_definition(
    sol::this_state lua, const script_game_id &id )
{
    require_vehicle_prototype_id(
        id, "game.vehicles.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               vproto_id( id.value() ).obj() );
}

} // namespace

void install_vehicle_api(
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
    sol::table vehicles_api = lua.create_table();
    vehicles_api.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    vehicles_api.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    game["vehicles"] = std::move( vehicles_api );
}

} // namespace cata::lua_ui
