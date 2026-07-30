#include "catalua_ui_zones.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "clzones.h"
#include "coordinates.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr int default_zone_limit = 64;
constexpr int maximum_zone_limit = 256;
constexpr int maximum_zone_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_nested_values = 128;

struct script_zone_token {
    std::size_t runtime_generation = 0;
    std::size_t world_generation = 0;
    std::string faction;
    std::string type;
    std::string name;
    tripoint_abs_ms start = tripoint_abs_ms::zero;
    tripoint_abs_ms end = tripoint_abs_ms::zero;
    bool personal = false;
    std::size_t ordinal = 0;
};

std::string lowercase_ascii( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    return value;
}

tripoint_abs_ms require_absolute_ms(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() !=
        coords::origin::abs ||
        position.native_scale() !=
        coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms(
               position.to_native() );
}

void require_id_kind(
    const script_game_id &id,
    const std::string &kind,
    const std::string &api_name )
{
    if( id.kind() != kind ) {
        throw std::invalid_argument(
            api_name + " requires GameId<" +
            kind + ">" );
    }
}

bool token_matches_zone(
    const script_zone_token &token,
    const zone_data &entry )
{
    return entry.get_faction().str() ==
           token.faction &&
           entry.get_type().str() ==
           token.type &&
           entry.get_name() == token.name &&
           entry.get_start_point() ==
           token.start &&
           entry.get_end_point() ==
           token.end &&
           entry.get_is_personal() ==
           token.personal;
}

zone_data *resolve_zone(
    const script_zone_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( token.runtime_generation !=
        runtime_generation ) {
        error = game_handle_error{
            "stale_runtime",
            "The ZoneToken belongs to a previous Lua runtime"
        };
        return nullptr;
    }
    if( token.world_generation !=
        world_generation ) {
        error = game_handle_error{
            "stale_world",
            "The ZoneToken belongs to a previous world"
        };
        return nullptr;
    }
    std::vector<zone_manager::ref_zone_data> zones =
        zone_manager::get_manager().get_zones(
            faction_id( token.faction ) );
    std::size_t ordinal = 0;
    for( zone_data &entry : zones ) {
        if( !token_matches_zone(
                token, entry ) ) {
            continue;
        }
        if( ordinal == token.ordinal ) {
            return &entry;
        }
        ++ordinal;
    }
    error = game_handle_error{
        "not_found",
        "The native zone referenced by this ZoneToken no longer exists or changed identity"
    };
    return nullptr;
}

script_zone_token make_zone_token(
    zone_data &entry,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    script_zone_token result;
    result.runtime_generation =
        runtime_generation;
    result.world_generation =
        world_generation;
    result.faction =
        entry.get_faction().str();
    result.type =
        entry.get_type().str();
    result.name =
        entry.get_name();
    result.start =
        entry.get_start_point();
    result.end =
        entry.get_end_point();
    result.personal =
        entry.get_is_personal();
    std::vector<zone_manager::ref_zone_data> zones =
        zone_manager::get_manager().get_zones(
            entry.get_faction() );
    for( zone_data &candidate : zones ) {
        if( &candidate == &entry ) {
            break;
        }
        if( token_matches_zone(
                result, candidate ) ) {
            ++result.ordinal;
        }
    }
    return result;
}

struct definition_options {
    int offset = 0;
    int limit = default_definition_limit;
    std::string query;
};

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
        result.offset >
        maximum_definition_offset ) {
        throw std::invalid_argument(
            "game.zones.types offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.zones.types limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit,
                       maximum_definition_limit );
    if( result.query.size() >
        maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.zones.types query exceeds 128 bytes" );
    }
    return result;
}

sol::table snapshot_zone_type(
    sol::state_view lua,
    const zone_type &definition )
{
    sol::table result = lua.create_table();
    result["id"] =
        script_game_id(
            "zone", definition.id.str() );
    result["name"] = definition.name();
    result["description"] =
        definition.desc();
    result["can_be_personal"] =
        definition.can_be_personal;
    result["hidden"] =
        definition.hidden;
    result["loaded"] =
        definition.was_loaded;
    const field_type_str_id field =
        definition.get_field();
    if( field.is_null() ) {
        result["field"] = sol::nil;
    } else {
        result["field"] =
            script_game_id(
                "field", field.str() );
    }
    const std::size_t returned =
        std::min<std::size_t>(
            definition.src.size(),
            maximum_nested_values );
    sol::table sources = lua.create_table(
                             static_cast<int>(
                                 returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        sol::table source = lua.create_table();
        source["zone"] =
            script_game_id(
                "zone",
                definition.src[index].first.str() );
        source["mod"] =
            definition.src[index].second.str();
        sources[index + 1] =
            std::move( source );
    }
    sol::table source_page =
        lua.create_table();
    source_page["items"] =
        std::move( sources );
    source_page["total"] =
        definition.src.size();
    source_page["returned"] = returned;
    source_page["truncated"] =
        returned < definition.src.size();
    result["sources"] =
        std::move( source_page );
    return result;
}

std::vector<const zone_type *>
matching_zone_types(
    const std::string &requested_query )
{
    const std::string query =
        lowercase_ascii( requested_query );
    std::vector<const zone_type *> result;
    for( const zone_type &definition :
         zone_type::get_all() ) {
        if( query.empty() ||
            lowercase_ascii(
                definition.id.str() ).find(
                    query ) != std::string::npos ||
            lowercase_ascii(
                definition.name() ).find(
                    query ) != std::string::npos ) {
            result.push_back( &definition );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const zone_type * lhs,
    const zone_type * rhs ) {
        return lhs->id.str() <
               rhs->id.str();
    } );
    return result;
}

sol::table list_zone_types(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<const zone_type *> definitions =
        matching_zone_types( options.query );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, definitions.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            definitions.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_zone_type(
                state, *definitions[index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = definitions.size();
    result["returned"] = last - first;
    result["has_more"] =
        last < definitions.size();
    return result;
}

sol::table get_zone_type(
    sol::this_state lua,
    const script_game_id &id )
{
    require_id_kind(
        id, "zone", "game.zones.type" );
    const zone_type_id native_id(
        id.value() );
    if( !native_id.is_valid() ) {
        throw std::invalid_argument(
            "game.zones.type requires a valid GameId<zone>" );
    }
    return snapshot_zone_type(
               sol::state_view( lua ),
               native_id.obj() );
}

struct zone_list_options {
    int offset = 0;
    int limit = default_zone_limit;
    std::string query;
    faction_id faction =
        faction_id( "your_followers" );
    std::optional<zone_type_id> type;
};

script_game_id read_table_id(
    const sol::table &table,
    const std::string &key,
    const std::string &kind,
    const std::string &api_name )
{
    const sol::object value = table[key];
    if( !value.is<script_game_id>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' requires GameId<" + kind + ">" );
    }
    const script_game_id result =
        value.as<script_game_id>();
    require_id_kind(
        result, kind, api_name +
        " option '" + key + "'" );
    return result;
}

zone_list_options read_zone_list_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    zone_list_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.query = requested->get_or(
                           "query", result.query );
        const sol::object faction_value =
            ( *requested )["faction"];
        if( faction_value.valid() &&
            faction_value.get_type() !=
            sol::type::nil ) {
            const script_game_id faction =
                read_table_id(
                    *requested, "faction",
                    "faction", api_name );
            result.faction =
                faction_id( faction.value() );
        }
        const sol::object type_value =
            ( *requested )["type"];
        if( type_value.valid() &&
            type_value.get_type() !=
            sol::type::nil ) {
            const script_game_id type =
                read_table_id(
                    *requested, "type",
                    "zone", api_name );
            const zone_type_id native_type(
                type.value() );
            if( !native_type.is_valid() ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'type' requires a valid GameId<zone>" );
            }
            result.type = native_type;
        }
    }
    if( result.offset < 0 ||
        result.offset > maximum_zone_offset ) {
        throw std::invalid_argument(
            api_name +
            " offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            api_name +
            " limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit,
                       maximum_zone_limit );
    if( result.query.size() >
        maximum_query_bytes ) {
        throw std::invalid_argument(
            api_name +
            " query exceeds 128 bytes" );
    }
    return result;
}

sol::table snapshot_option_descriptions(
    sol::state_view lua, const zone_data &entry )
{
    const std::vector<
    std::pair<std::string, std::string>> descriptions =
        entry.get_options().get_descriptions();
    const std::size_t returned =
        std::min<std::size_t>(
            descriptions.size(),
            maximum_nested_values );
    sol::table items = lua.create_table(
                           static_cast<int>(
                               returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        sol::table description =
            lua.create_table();
        description["label"] =
            descriptions[index].first;
        description["value"] =
            descriptions[index].second;
        items[index + 1] =
            std::move( description );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = descriptions.size();
    result["returned"] = returned;
    result["truncated"] =
        returned < descriptions.size();
    return result;
}

sol::table snapshot_zone(
    sol::state_view lua, zone_data &entry,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["token"] =
        make_zone_token(
            entry, runtime_generation,
            world_generation );
    result["name"] = entry.get_name();
    result["type"] =
        script_game_id(
            "zone", entry.get_type().str() );
    result["type_name"] =
        zone_manager::get_manager().
        get_name_from_type(
            entry.get_type() );
    result["faction"] =
        script_game_id(
            "faction",
            entry.get_faction().str() );
    result["start"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry.get_start_point().raw() );
    result["end"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry.get_end_point().raw() );
    result["center"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            entry.get_center_point().raw() );
    result["invert"] = entry.get_invert();
    result["enabled"] =
        entry.get_enabled();
    result["temporarily_disabled"] =
        entry.get_temporarily_disabled();
    result["displayed"] =
        entry.get_is_displayed();
    result["vehicle"] =
        entry.get_is_vehicle();
    result["personal"] =
        entry.get_is_personal();
    result["has_options"] =
        entry.has_options();
    result["options"] =
        snapshot_option_descriptions(
            lua, entry );
    return result;
}

struct zone_match {
    zone_data *zone = nullptr;
};

std::vector<zone_match> matching_zones(
    const zone_list_options &options,
    const std::optional<tripoint_abs_ms> &position )
{
    const std::string query =
        lowercase_ascii( options.query );
    std::vector<zone_manager::ref_zone_data> zones =
        zone_manager::get_manager().get_zones(
            options.faction );
    std::vector<zone_match> result;
    result.reserve( zones.size() );
    for( zone_data &entry : zones ) {
        if( options.type &&
            entry.get_type() !=
            *options.type ) {
            continue;
        }
        if( position &&
            !entry.has_inside( *position ) ) {
            continue;
        }
        if( !query.empty() &&
            lowercase_ascii(
                entry.get_name() ).find(
                    query ) == std::string::npos &&
            lowercase_ascii(
                entry.get_type().str() ).find(
                    query ) == std::string::npos ) {
            continue;
        }
        result.push_back( { &entry } );
    }
    return result;
}

sol::table list_zone_matches(
    sol::this_state lua,
    const zone_list_options &options,
    const std::optional<tripoint_abs_ms> &position,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const std::vector<zone_match> matches =
        matching_zones( options, position );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, matches.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            matches.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_zone(
                state, *matches[index].zone,
                runtime_generation,
                world_generation );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["faction"] =
        script_game_id(
            "faction",
            options.faction.str() );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = matches.size();
    value["returned"] = last - first;
    value["has_more"] =
        last < matches.size();
    if( position ) {
        value["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                position->raw() );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table list_zones(
    sol::this_state lua,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    return list_zone_matches(
               lua,
               read_zone_list_options(
                   requested, "game.zones.list" ),
               std::nullopt,
               runtime_generation,
               world_generation );
}

sol::table zones_at(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    return list_zone_matches(
               lua,
               read_zone_list_options(
                   requested, "game.zones.at" ),
               require_absolute_ms(
                   position, "game.zones.at" ),
               runtime_generation,
               world_generation );
}

sol::table get_zone(
    sol::this_state lua,
    const script_zone_token &token,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    zone_data *entry = resolve_zone(
                           token,
                           runtime_generation,
                           world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_zone(
                       state, *entry,
                       runtime_generation,
                       world_generation ) ) );
}

sol::table zone_contains(
    sol::this_state lua,
    const script_zone_token &token,
    const script_tripoint_coord &position,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms native_position =
        require_absolute_ms(
            position, "game.zones.contains" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    zone_data *entry = resolve_zone(
                           token,
                           runtime_generation,
                           world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   entry->has_inside(
                       native_position ) ) );
}

} // namespace

void install_zone_api(
    sol::state &lua, sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    static_cast<void>( require_write );
    lua.new_usertype<script_zone_token>(
        "ZoneToken", sol::no_constructor,
        "faction",
        sol::property(
    []( const script_zone_token & self ) {
        return script_game_id(
                   "faction", self.faction );
    } ),
    "type", sol::property(
    []( const script_zone_token & self ) {
        return script_game_id(
                   "zone", self.type );
    } ),
    "name", sol::property(
    []( const script_zone_token & self ) {
        return self.name;
    } ),
    "start", sol::property(
    []( const script_zone_token & self ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   self.start.raw() );
    } ),
    "end", sol::property(
    []( const script_zone_token & self ) {
        return script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   self.end.raw() );
    } ),
    "personal", sol::property(
    []( const script_zone_token & self ) {
        return self.personal;
    } ),
    "is_valid",
    [current_runtime_generation, current_world_generation](
        const script_zone_token & self ) {
        std::optional<game_handle_error> error;
        return resolve_zone(
                   self,
                   current_runtime_generation(),
                   current_world_generation(),
                   error ) != nullptr;
    },
    "status",
    [current_runtime_generation, current_world_generation](
        sol::this_state lua_state,
        const script_zone_token & self ) {
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        if( resolve_zone(
                self,
                current_runtime_generation(),
                current_world_generation(),
                error ) == nullptr ) {
            return make_game_error_result(
                       state, *error );
        }
        sol::table value = state.create_table();
        value["faction"] =
            script_game_id(
                "faction", self.faction );
        value["type"] =
            script_game_id(
                "zone", self.type );
        value["name"] = self.name;
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    } );

    sol::table zones = lua.create_table();
    zones.set_function(
        "types",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_zone_types(
                   lua_state, options );
    } );
    zones.set_function(
        "type",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_zone_type(
                   lua_state, id );
    } );
    zones.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_zones(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "at",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const script_tripoint_coord & position,
    const sol::optional<sol::table> &options ) {
        require_read();
        return zones_at(
                   lua_state, position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const script_zone_token & token ) {
        require_read();
        return get_zone(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "contains",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const script_zone_token & token,
    const script_tripoint_coord & position ) {
        require_read();
        return zone_contains(
                   lua_state, token, position,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["zones"] = std::move( zones );
}

} // namespace cata::lua_ui
