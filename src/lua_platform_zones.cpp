#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_zones.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <tuple>
#include <utility>
#include <vector>

#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "clzones.h"
#include "coordinates.h"

namespace cata::lua_platform
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
constexpr std::size_t maximum_zone_name_bytes = 55;
constexpr std::int64_t maximum_zone_axis_length = 256;
constexpr std::int64_t maximum_zone_volume = 65536;

std::string zone_kind( const bool personal, const bool vehicle )
{
    if( vehicle ) {
        return "vehicle";
    }
    if( personal ) {
        return "personal";
    }
    return "global";
}

bool valid_zone_kind( const std::string &kind )
{
    return kind == "global" || kind == "personal" || kind == "vehicle";
}

bool invalid_native_zone_state( const bool personal, const bool vehicle )
{
    return personal && vehicle;
}

struct script_zone_token {
    game_handle_runtime runtime;
    std::size_t world_generation = 0;
    std::string faction;
    std::string type;
    std::string name;
    tripoint_abs_ms start = tripoint_abs_ms::zero;
    tripoint_abs_ms end = tripoint_abs_ms::zero;
    tripoint_rel_ms personal_start = tripoint_rel_ms::zero;
    tripoint_rel_ms personal_end = tripoint_rel_ms::zero;
    bool personal = false;
    bool vehicle = false;
    std::weak_ptr<const void> lifetime_identity;
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

tripoint_rel_ms require_relative_ms(
    const script_tripoint_coord &position,
    const std::string &api_name )
{
    if( position.native_origin() !=
        coords::origin::relative ||
        position.native_scale() !=
        coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name +
            " requires a relative map-square Tripoint for personal zones" );
    }
    return tripoint_rel_ms(
               position.to_native() );
}

void validate_zone_name(
    const std::string &name,
    const std::string &api_name )
{
    if( name.empty() ) {
        throw std::invalid_argument(
            api_name +
            " name cannot be empty" );
    }
    if( name.size() >
        maximum_zone_name_bytes ) {
        throw std::invalid_argument(
            api_name +
            " name exceeds 55 bytes" );
    }
}

template<typename Point>
std::pair<Point, Point> normalize_zone_bounds(
    const Point &first, const Point &second,
    const std::string &api_name )
{
    if( first.z() != second.z() ) {
        throw std::invalid_argument(
            api_name +
            " zone corners must use the same z-level" );
    }
    const Point start(
        std::min( first.x(), second.x() ),
        std::min( first.y(), second.y() ),
        first.z() );
    const Point end(
        std::max( first.x(), second.x() ),
        std::max( first.y(), second.y() ),
        first.z() );
    const std::int64_t width =
        static_cast<std::int64_t>(
            end.x() ) -
        static_cast<std::int64_t>(
            start.x() ) + 1;
    const std::int64_t height =
        static_cast<std::int64_t>(
            end.y() ) -
        static_cast<std::int64_t>(
            start.y() ) + 1;
    if( width > maximum_zone_axis_length ||
        height > maximum_zone_axis_length ) {
        throw std::invalid_argument(
            api_name +
            " zone axes cannot exceed 256 map squares" );
    }
    if( width > maximum_zone_volume /
        height ) {
        throw std::invalid_argument(
            api_name +
            " zone cannot exceed 65536 map squares" );
    }
    return { start, end };
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
    if( invalid_native_zone_state(
            token.personal, token.vehicle ) ||
        invalid_native_zone_state(
            entry.get_is_personal(), entry.get_is_vehicle() ) ) {
        return false;
    }
    if( entry.get_faction().str() !=
        token.faction ||
        entry.get_type().str() !=
        token.type ||
        entry.get_name() != token.name ||
        entry.get_is_personal() !=
        token.personal ||
        entry.get_is_vehicle() !=
        token.vehicle ) {
        return false;
    }
    if( token.personal ) {
        return entry.get_personal_start_point() ==
               token.personal_start &&
               entry.get_personal_end_point() ==
               token.personal_end;
    }
    return entry.get_start_point() ==
           token.start &&
           entry.get_end_point() ==
           token.end;
}

bool token_owns_zone(
    const script_zone_token &token,
    const zone_data &entry )
{
    const std::weak_ptr<const void> identity =
        entry.get_lifetime_identity();
    return !token.lifetime_identity.owner_before(
               identity ) &&
           !identity.owner_before(
               token.lifetime_identity );
}

zone_data *resolve_zone(
    const script_zone_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( !token.runtime.is_active_match(
            runtime_generation ) ) {
        error = game_handle_error{
            "stale_runtime",
            "The ZoneToken belongs to an inactive or different Lua runtime"
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
    for( zone_data &entry : zones ) {
        if( !token_matches_zone(
                token, entry ) ) {
            continue;
        }
        if( token_owns_zone(
                token, entry ) ) {
            return &entry;
        }
    }
    error = game_handle_error{
        "not_found",
        "The native zone referenced by this ZoneToken no longer exists or changed identity"
    };
    return nullptr;
}

script_zone_token make_zone_token(
    zone_data &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( invalid_native_zone_state(
            entry.get_is_personal(), entry.get_is_vehicle() ) ) {
        throw std::runtime_error(
            "Cannot create a ZoneToken for a zone that is both personal and vehicle" );
    }
    script_zone_token result;
    result.runtime = runtime_generation;
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
    result.vehicle =
        entry.get_is_vehicle();
    result.lifetime_identity =
        entry.get_lifetime_identity();
    if( result.personal ) {
        result.personal_start =
            entry.get_personal_start_point();
        result.personal_end =
            entry.get_personal_end_point();
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
            "services.zones.types offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "services.zones.types limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit,
                       maximum_definition_limit );
    if( result.query.size() >
        maximum_query_bytes ) {
        throw std::invalid_argument(
            "services.zones.types query exceeds 128 bytes" );
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
        id, "zone", "services.zones.type" );
    const zone_type_id native_id(
        id.value() );
    if( !native_id.is_valid() ) {
        throw std::invalid_argument(
            "services.zones.type requires a valid GameId<zone>" );
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
    std::optional<std::string> kind;
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
            if( !faction.is_valid() ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'faction' requires a valid GameId<faction>" );
            }
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
        const sol::object kind_value =
            ( *requested )["kind"];
        if( kind_value.valid() &&
            kind_value.get_type() !=
            sol::type::nil ) {
            if( !kind_value.is<std::string>() ) {
                throw std::invalid_argument(
                    api_name + " option 'kind' must be a string" );
            }
            result.kind = kind_value.as<std::string>();
            if( !valid_zone_kind( *result.kind ) ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'kind' must be one of 'global', 'personal', or 'vehicle'" );
            }
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

bool require_boolean_option(
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

std::string require_string_option(
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

script_game_id require_id_option(
    const sol::object &value,
    const std::string &kind,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<script_game_id>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' requires GameId<" + kind + ">" );
    }
    const script_game_id result =
        value.as<script_game_id>();
    require_id_kind(
        result, kind,
        api_name + " option '" + key + "'" );
    if( !result.is_valid() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' requires a valid GameId<" +
            kind + ">" );
    }
    return result;
}

script_tripoint_coord require_coord_option(
    const sol::object &value,
    const std::string &api_name,
    const std::string &key )
{
    if( !value.is<script_tripoint_coord>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' requires a Tripoint" );
    }
    return value.as<script_tripoint_coord>();
}

struct zone_create_options {
    std::string name;
    std::optional<zone_type_id> type;
    faction_id faction =
        faction_id( "your_followers" );
    std::optional<script_tripoint_coord> start;
    std::optional<script_tripoint_coord> end;
    bool invert = false;
    bool enabled = true;
    std::string kind;
};

zone_create_options read_zone_create_options(
    const sol::table &requested )
{
    const std::string api_name =
        "services.zones.create";
    zone_create_options result;
    bool kind_seen = false;
    for( const auto &entry : requested ) {
        const sol::object key_object =
            entry.first;
        if( key_object.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                api_name +
                " option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        const sol::object value =
            entry.second;
        if( key == "name" ) {
            result.name =
                require_string_option(
                    value, api_name, key );
        } else if( key == "type" ) {
            result.type =
                zone_type_id(
                    require_id_option(
                        value, "zone",
                        api_name, key ).value() );
        } else if( key == "faction" ) {
            result.faction =
                faction_id(
                    require_id_option(
                        value, "faction",
                        api_name, key ).value() );
        } else if( key == "start" ) {
            result.start =
                require_coord_option(
                    value, api_name, key );
        } else if( key == "end" ) {
            result.end =
                require_coord_option(
                    value, api_name, key );
        } else if( key == "invert" ) {
            result.invert =
                require_boolean_option(
                    value, api_name, key );
        } else if( key == "enabled" ) {
            result.enabled =
                require_boolean_option(
                    value, api_name, key );
        } else if( key == "kind" ) {
            result.kind =
                require_string_option(
                    value, api_name, key );
            kind_seen = true;
            if( !valid_zone_kind( result.kind ) ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'kind' must be one of 'global', 'personal', or 'vehicle'" );
            }
        } else if( key == "personal" ) {
            throw std::invalid_argument(
                api_name +
                " option 'personal' is no longer supported; use 'kind'" );
        } else {
            throw std::invalid_argument(
            api_name +
            " received unknown option '" +
            key + "'" );
        }
    }
    if( !kind_seen ) {
        throw std::invalid_argument(
            api_name +
            " requires option 'kind'" );
    }
    validate_zone_name(
        result.name, api_name );
    if( !result.type ) {
        throw std::invalid_argument(
            api_name +
            " requires option 'type'" );
    }
    if( !result.start || !result.end ) {
        throw std::invalid_argument(
            api_name +
            " requires options 'start' and 'end'" );
    }
    if( result.kind == "personal" &&
        !result.type->obj().can_be_personal ) {
        throw std::invalid_argument(
            api_name +
            " type does not support personal zones" );
    }
    return result;
}

sol::table snapshot_option_descriptions(
    sol::state_view lua, const zone_data &entry )
{
    const std::vector <
    std::pair<std::string, std::string >> descriptions =
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
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( invalid_native_zone_state(
            entry.get_is_personal(), entry.get_is_vehicle() ) ) {
        throw std::runtime_error(
            "Cannot snapshot a zone that is both personal and vehicle" );
    }
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
    if( entry.get_is_personal() ) {
        result["relative_start"] =
            script_tripoint_coord::from_native(
                coords::origin::relative,
                coords::scale::map_square,
                entry.get_personal_start_point().raw() );
        result["relative_end"] =
            script_tripoint_coord::from_native(
                coords::origin::relative,
                coords::scale::map_square,
                entry.get_personal_end_point().raw() );
    } else {
        result["relative_start"] = sol::nil;
        result["relative_end"] = sol::nil;
    }
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
    result["kind"] =
        zone_kind(
            entry.get_is_personal(),
            entry.get_is_vehicle() );
    result["has_options"] =
        entry.has_options();
    result["options"] =
        snapshot_option_descriptions(
            lua, entry );
    return result;
}

sol::table create_zone(
    sol::this_state lua,
    const sol::table &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const zone_create_options options =
        read_zone_create_options( requested );
    if( options.kind == "vehicle" ) {
        return make_game_error_result(
                   state, {
                       "unsupported_vehicle_mutation",
                       "Vehicle-bound zones cannot be created through services.zones.create"
                   } );
    }
    script_zone_token identity;
    identity.runtime = runtime_generation;
    identity.world_generation =
        world_generation;
    identity.faction =
        options.faction.str();
    identity.type =
        options.type->str();
    identity.name =
        options.name;
    identity.personal =
        options.kind == "personal";
    identity.vehicle =
        options.kind == "vehicle";

    std::optional<std::pair<
    tripoint_abs_ms, tripoint_abs_ms>>
                                    absolute_bounds;
    std::optional<std::pair<
    tripoint_rel_ms, tripoint_rel_ms>>
                                    relative_bounds;
    if( options.kind == "personal" ) {
        relative_bounds =
            normalize_zone_bounds(
                require_relative_ms(
                    *options.start,
                    "services.zones.create" ),
                require_relative_ms(
                    *options.end,
                    "services.zones.create" ),
                "services.zones.create" );
        identity.personal_start =
            relative_bounds->first;
        identity.personal_end =
            relative_bounds->second;
    } else {
        absolute_bounds =
            normalize_zone_bounds(
                require_absolute_ms(
                    *options.start,
                    "services.zones.create" ),
                require_absolute_ms(
                    *options.end,
                    "services.zones.create" ),
                "services.zones.create" );
        identity.start =
            absolute_bounds->first;
        identity.end =
            absolute_bounds->second;
    }

    zone_manager &manager =
        zone_manager::get_manager();
    for( zone_data &entry :
         manager.get_zones(
             options.faction ) ) {
        if( token_matches_zone(
                identity, entry ) ) {
            return make_game_error_result(
            sol::state_view( lua ), {
                "duplicate_zone",
                "An identical native zone already exists"
            } );
        }
    }

    zone_data *created = nullptr;
    if( relative_bounds ) {
        created = manager.add(
            options.name, *options.type,
            options.faction, options.invert,
            options.enabled,
            relative_bounds->first,
            relative_bounds->second );
    } else {
        created = manager.add(
            options.name, *options.type,
            options.faction, options.invert,
            options.enabled,
            absolute_bounds->first,
            absolute_bounds->second,
            nullptr, true, nullptr, false );
    }

    if( created == nullptr ) {
        return make_game_error_result(
        state, {
            "creation_failed",
            "The native zone could not be created"
        } );
    }
    const script_zone_token created_token =
        make_zone_token(
            *created, runtime_generation,
            world_generation );
    if( !token_matches_zone(
            identity, *created ) ||
        created_token.lifetime_identity.expired() ||
        !token_owns_zone(
            created_token, *created ) ) {
        const bool vehicle =
            created->get_is_vehicle();
        const bool removed =
            manager.remove( *created );
        if( !removed ) {
            return make_game_error_result(
            state, {
                "rollback_failed",
                "The native zone could not be rolled back after creation failed"
            } );
        }
        if( !vehicle ) {
            manager.cache_data();
        }
        return make_game_error_result(
        state, {
            "creation_failed",
            "The native zone did not retain the requested identity after creation"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_zone(
                       state, *created,
                       runtime_generation,
                       world_generation ) ) );
}

bool duplicate_zone_exists(
    const script_zone_token &identity,
    const zone_data *excluded )
{
    for( zone_data &candidate :
         zone_manager::get_manager().get_zones(
             faction_id(
                 identity.faction ) ) ) {
        if( &candidate != excluded &&
            token_matches_zone(
                identity, candidate ) ) {
            return true;
        }
    }
    return false;
}

void recache_zone_state(
    const bool vehicle )
{
    zone_manager &manager =
        zone_manager::get_manager();
    if( vehicle ) {
        manager.cache_vzones();
    } else {
        manager.cache_data();
    }
}

sol::table rename_zone(
    sol::this_state lua,
    const script_zone_token &token,
    const std::string &requested_name,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_zone_name(
        requested_name,
        "services.zones.rename" );
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
    if( entry->get_is_vehicle() ) {
        return make_game_error_result(
        state, {
            "unsupported_vehicle_mutation",
            "Vehicle zones are read-only and cannot be mutated through services.zones"
        } );
    }
    script_zone_token future = token;
    future.name = requested_name;
    if( duplicate_zone_exists(
            future, entry ) ) {
        return make_game_error_result(
        state, {
            "duplicate_zone",
            "Renaming would duplicate another native zone"
        } );
    }
    const std::string before =
        entry->get_name();
    const bool changed =
        entry->set_name(
            requested_name );
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] =
        entry->get_name();
    value["changed"] = changed;
    value["zone"] =
        snapshot_zone(
            state, *entry,
            runtime_generation,
            world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_zone_enabled(
    sol::this_state lua,
    const script_zone_token &token,
    const bool enabled,
    const game_handle_runtime &runtime_generation,
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
    if( entry->get_is_vehicle() ) {
        return make_game_error_result(
        state, {
            "unsupported_vehicle_mutation",
            "Vehicle zones are read-only and cannot be mutated through services.zones"
        } );
    }
    const bool before_enabled =
        entry->get_enabled();
    const bool before_temporary =
        entry->get_temporarily_disabled();
    entry->set_enabled( enabled );
    entry->set_temporary_disabled( false );
    recache_zone_state(
        entry->get_is_vehicle() );

    sol::table value = state.create_table();
    value["before"] = before_enabled;
    value["after"] =
        entry->get_enabled();
    value["temporary_before"] =
        before_temporary;
    value["temporary_after"] =
        entry->get_temporarily_disabled();
    value["changed"] =
        before_enabled !=
        entry->get_enabled() ||
        before_temporary !=
        entry->get_temporarily_disabled();
    value["zone"] =
        snapshot_zone(
            state, *entry,
            runtime_generation,
            world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_zone_temporary_disabled(
    sol::this_state lua,
    const script_zone_token &token,
    const bool disabled,
    const game_handle_runtime &runtime_generation,
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
    if( entry->get_is_vehicle() ) {
        return make_game_error_result(
        state, {
            "unsupported_vehicle_mutation",
            "Vehicle zones are read-only and cannot be mutated through services.zones"
        } );
    }
    const bool before_enabled =
        entry->get_enabled();
    const bool before_temporary =
        entry->get_temporarily_disabled();
    entry->set_enabled( !disabled );
    entry->set_temporary_disabled(
        disabled );
    recache_zone_state(
        entry->get_is_vehicle() );

    sol::table value = state.create_table();
    value["before"] =
        before_temporary;
    value["after"] =
        entry->get_temporarily_disabled();
    value["enabled_before"] =
        before_enabled;
    value["enabled_after"] =
        entry->get_enabled();
    value["changed"] =
        before_enabled !=
        entry->get_enabled() ||
        before_temporary !=
        entry->get_temporarily_disabled();
    value["zone"] =
        snapshot_zone(
            state, *entry,
            runtime_generation,
            world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_zone_position(
    sol::this_state lua,
    const script_zone_token &token,
    const script_tripoint_coord &requested_start,
    const script_tripoint_coord &requested_end,
    const game_handle_runtime &runtime_generation,
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
    if( entry->get_is_vehicle() ) {
        return make_game_error_result(
        state, {
            "unsupported_vehicle_mutation",
            "Vehicle zones are read-only and cannot be mutated through services.zones"
        } );
    }

    sol::table value = state.create_table();
    script_zone_token future = token;
    bool changed = false;
    if( entry->get_is_personal() ) {
        const std::pair <
        tripoint_rel_ms, tripoint_rel_ms > bounds =
            normalize_zone_bounds(
                require_relative_ms(
                    requested_start,
                    "services.zones.set_position" ),
                require_relative_ms(
                    requested_end,
                    "services.zones.set_position" ),
                "services.zones.set_position" );
        future.personal_start =
            bounds.first;
        future.personal_end =
            bounds.second;
        if( duplicate_zone_exists(
                future, entry ) ) {
            return make_game_error_result(
            state, {
                "duplicate_zone",
                "Moving would duplicate another native zone"
            } );
        }
        const tripoint_rel_ms before_start =
            entry->get_personal_start_point();
        const tripoint_rel_ms before_end =
            entry->get_personal_end_point();
        changed =
            before_start != bounds.first ||
            before_end != bounds.second;
        entry->set_position(
            bounds );
        value["before_start"] =
            script_tripoint_coord::from_native(
                coords::origin::relative,
                coords::scale::map_square,
                before_start.raw() );
        value["before_end"] =
            script_tripoint_coord::from_native(
                coords::origin::relative,
                coords::scale::map_square,
                before_end.raw() );
        value["after_start"] =
            script_tripoint_coord::from_native(
                coords::origin::relative,
                coords::scale::map_square,
                entry->get_personal_start_point().raw() );
        value["after_end"] =
            script_tripoint_coord::from_native(
                coords::origin::relative,
                coords::scale::map_square,
                entry->get_personal_end_point().raw() );
    } else {
        const std::pair <
        tripoint_abs_ms, tripoint_abs_ms > bounds =
            normalize_zone_bounds(
                require_absolute_ms(
                    requested_start,
                    "services.zones.set_position" ),
                require_absolute_ms(
                    requested_end,
                    "services.zones.set_position" ),
                "services.zones.set_position" );
        future.start =
            bounds.first;
        future.end =
            bounds.second;
        if( duplicate_zone_exists(
                future, entry ) ) {
            return make_game_error_result(
            state, {
                "duplicate_zone",
                "Moving would duplicate another native zone"
            } );
        }
        const tripoint_abs_ms before_start =
            entry->get_start_point();
        const tripoint_abs_ms before_end =
            entry->get_end_point();
        changed =
            before_start != bounds.first ||
            before_end != bounds.second;
        entry->set_position(
            bounds );
        value["before_start"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                before_start.raw() );
        value["before_end"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                before_end.raw() );
        value["after_start"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                entry->get_start_point().raw() );
        value["after_end"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                entry->get_end_point().raw() );
    }
    value["changed"] = changed;
    value["zone"] =
        snapshot_zone(
            state, *entry,
            runtime_generation,
            world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_zone(
    sol::this_state lua,
    const script_zone_token &token,
    const game_handle_runtime &runtime_generation,
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
    if( entry->get_is_vehicle() ) {
        return make_game_error_result(
        state, {
            "unsupported_vehicle_mutation",
            "Vehicle zones are read-only and cannot be mutated through services.zones"
        } );
    }
    sol::table removed =
        snapshot_zone(
            state, *entry,
            runtime_generation,
            world_generation );
    const bool vehicle =
        entry->get_is_vehicle();
    if( !zone_manager::get_manager().remove(
            *entry ) ) {
        return make_game_error_result(
        state, {
            "remove_failed",
            "The native zone could not be removed"
        } );
    }
    if( !vehicle ) {
        zone_manager::get_manager().
        cache_data();
    }
    sol::table value = state.create_table();
    value["removed"] = true;
    value["zone"] =
        std::move( removed );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
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
        if( invalid_native_zone_state(
                entry.get_is_personal(), entry.get_is_vehicle() ) ) {
            continue;
        }
        if( options.type &&
            entry.get_type() !=
            *options.type ) {
            continue;
        }
        if( options.kind &&
            zone_kind(
                entry.get_is_personal(),
                entry.get_is_vehicle() ) != *options.kind ) {
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
    std::stable_sort(
        result.begin(), result.end(),
        []( const zone_match &lhs, const zone_match &rhs ) {
            const zone_data &lhs_zone = *lhs.zone;
            const zone_data &rhs_zone = *rhs.zone;
            const tripoint_abs_ms lhs_start =
                lhs_zone.get_start_point();
            const tripoint_abs_ms lhs_end =
                lhs_zone.get_end_point();
            const tripoint_abs_ms rhs_start =
                rhs_zone.get_start_point();
            const tripoint_abs_ms rhs_end =
                rhs_zone.get_end_point();
            return std::make_tuple(
                       zone_kind(
                           lhs_zone.get_is_personal(),
                           lhs_zone.get_is_vehicle() ),
                       lhs_zone.get_faction().str(),
                       lhs_zone.get_type().str(),
                       lhs_zone.get_name(),
                       lhs_start.x(),
                       lhs_start.y(),
                       lhs_start.z(),
                       lhs_end.x(),
                       lhs_end.y(),
                       lhs_end.z() ) <
                   std::make_tuple(
                       zone_kind(
                           rhs_zone.get_is_personal(),
                           rhs_zone.get_is_vehicle() ),
                       rhs_zone.get_faction().str(),
                       rhs_zone.get_type().str(),
                       rhs_zone.get_name(),
                       rhs_start.x(),
                       rhs_start.y(),
                       rhs_start.z(),
                       rhs_end.x(),
                       rhs_end.y(),
                       rhs_end.z() );
        } );
    return result;
}

sol::table list_zone_matches(
    sol::this_state lua,
    const zone_list_options &options,
    const std::optional<tripoint_abs_ms> &position,
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    return list_zone_matches(
               lua,
               read_zone_list_options(
                   requested, "services.zones.list" ),
               std::nullopt,
               runtime_generation,
               world_generation );
}

sol::table zones_at(
    sol::this_state lua,
    const script_tripoint_coord &position,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    return list_zone_matches(
               lua,
               read_zone_list_options(
                   requested, "services.zones.at" ),
               require_absolute_ms(
                   position, "services.zones.at" ),
               runtime_generation,
               world_generation );
}

sol::table get_zone(
    sol::this_state lua,
    const script_zone_token &token,
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms native_position =
        require_absolute_ms(
            position, "services.zones.contains" );
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
    sol::state &lua, sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
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
    "relative_start", sol::property(
    []( const script_zone_token & self )
        -> sol::optional<script_tripoint_coord> {
        if( !self.personal ) {
            return sol::nullopt;
        }
        return script_tripoint_coord::from_native(
                   coords::origin::relative,
                   coords::scale::map_square,
                   self.personal_start.raw() );
    } ),
    "relative_end", sol::property(
    []( const script_zone_token & self )
        -> sol::optional<script_tripoint_coord> {
        if( !self.personal ) {
            return sol::nullopt;
        }
        return script_tripoint_coord::from_native(
                   coords::origin::relative,
                   coords::scale::map_square,
                   self.personal_end.raw() );
    } ),
    "personal", sol::property(
    []( const script_zone_token & self ) {
        return self.personal;
    } ),
    "vehicle", sol::property(
    []( const script_zone_token & self ) {
        return self.vehicle;
    } ),
    "kind", sol::property(
    []( const script_zone_token & self ) {
        return zone_kind(
                   self.personal, self.vehicle );
    } ),
    "is_valid",
    [current_runtime_generation, current_world_generation, require_read](
        const script_zone_token & self ) {
        require_read();
        std::optional<game_handle_error> error;
        return resolve_zone(
                   self,
                   current_runtime_generation(),
                   current_world_generation(),
                   error ) != nullptr;
    },
    "status",
    [current_runtime_generation, current_world_generation, require_read](
        sol::this_state lua_state,
        const script_zone_token & self ) {
        require_read();
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
        value["vehicle"] = self.vehicle;
        value["kind"] =
            zone_kind(
                self.personal, self.vehicle );
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
    zones.set_function(
        "create",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
    const sol::table & options ) {
        require_write();
        return create_zone(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "rename",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const script_zone_token & token,
    const std::string & name ) {
        require_write();
        return rename_zone(
                   lua_state, token, name,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "set_enabled",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const script_zone_token & token,
    const bool enabled ) {
        require_write();
        return set_zone_enabled(
                   lua_state, token, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "set_temporary_disabled",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const script_zone_token & token,
    const bool disabled ) {
        require_write();
        return set_zone_temporary_disabled(
                   lua_state, token, disabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "set_position",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const script_zone_token & token,
            const script_tripoint_coord & start,
    const script_tripoint_coord & end ) {
        require_write();
        return set_zone_position(
                   lua_state, token, start, end,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    zones.set_function(
        "remove",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
    const script_zone_token & token ) {
        require_write();
        return remove_zone(
                   lua_state, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["zones"] = std::move( zones );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
