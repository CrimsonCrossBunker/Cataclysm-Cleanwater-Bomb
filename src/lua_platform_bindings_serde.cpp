#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_bindings_serde.h"

extern "C" {
#include <lua.h>
}
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_enums.h"
#include "lua_platform_bindings_values.h"

namespace cata::lua_platform
{

namespace
{

constexpr int serde_format_version = 1;
constexpr std::size_t maximum_serialized_bytes = 1024U * 1024U;
constexpr std::size_t maximum_string_bytes = 64U * 1024U;
constexpr std::size_t maximum_total_string_bytes = 512U * 1024U;
constexpr std::size_t maximum_table_entries = 4096;
constexpr std::size_t maximum_value_nodes = 16384;
constexpr std::size_t maximum_value_depth = 16;
constexpr std::size_t maximum_json_nesting = 64;

struct encode_context {
    std::size_t nodes = 0;
    std::size_t string_bytes = 0;
    std::vector<sol::table> table_stack;
};

struct decode_context {
    std::size_t nodes = 0;
    std::size_t string_bytes = 0;
};

void count_node( std::size_t &nodes )
{
    ++nodes;
    if( nodes > maximum_value_nodes ) {
        throw std::invalid_argument(
            "services.serde value exceeds the 16384-node limit" );
    }
}

void count_string( std::size_t &total, const std::string &value )
{
    if( value.size() > maximum_string_bytes ) {
        throw std::invalid_argument(
            "services.serde string exceeds the 64 KiB limit" );
    }
    total += value.size();
    if( total > maximum_total_string_bytes ) {
        throw std::invalid_argument(
            "services.serde strings exceed the 512 KiB aggregate limit" );
    }
}

void check_depth( const std::size_t depth )
{
    if( depth > maximum_value_depth ) {
        throw std::invalid_argument(
            "services.serde value exceeds the 16-level depth limit" );
    }
}

void write_type( JsonOut &json, const std::string &type )
{
    json.member( "type", type );
}

struct sorted_table_entry {
    sol::object key;
    sol::object value;
    std::string order_key;
};

std::vector<sorted_table_entry> sorted_table_entries( const sol::table &table )
{
    std::vector<sorted_table_entry> result;
    for( const auto &entry : table ) {
        const sol::object key = entry.first;
        std::string order_key;
        if( key.get_type() == sol::type::string ) {
            order_key = "s:" + key.as<std::string>();
        } else if( key.get_type() == sol::type::number &&
                   key.is<lua_Integer>() ) {
            order_key = "i:" +
                        std::to_string( key.as<lua_Integer>() );
        } else {
            throw std::invalid_argument(
                "services.serde table keys must be strings or integers" );
        }
        result.push_back( {
            key, entry.second, std::move( order_key )
        } );
        if( result.size() > maximum_table_entries ) {
            throw std::invalid_argument(
                "services.serde table exceeds the 4096-entry limit" );
        }
    }
    std::sort( result.begin(), result.end(),
    []( const sorted_table_entry & lhs, const sorted_table_entry & rhs ) {
        return lhs.order_key < rhs.order_key;
    } );
    return result;
}

void write_value(
    JsonOut &json, const sol::object &value,
    encode_context &context, const std::size_t depth )
{
    check_depth( depth );
    count_node( context.nodes );

    json.start_object();
    switch( value.get_type() ) {
        case sol::type::none:
        case sol::type::lua_nil:
            write_type( json, "nil" );
            break;
        case sol::type::boolean:
            write_type( json, "boolean" );
            json.member( "value", value.as<bool>() );
            break;
        case sol::type::number:
            if( value.is<lua_Integer>() ) {
                write_type( json, "integer" );
                json.member(
                    "value", static_cast<std::int64_t>(
                        value.as<lua_Integer>() ) );
            } else {
                const double number = value.as<double>();
                if( !std::isfinite( number ) ) {
                    throw std::invalid_argument(
                        "services.serde floating-point values must be finite" );
                }
                write_type( json, "float" );
                json.member( "value", number );
            }
            break;
        case sol::type::string: {
            const std::string text = value.as<std::string>();
            count_string( context.string_bytes, text );
            write_type( json, "string" );
            json.member( "value", text );
            break;
        }
        case sol::type::table: {
            const sol::table table = value.as<sol::table>();
            if( std::find(
                    context.table_stack.begin(), context.table_stack.end(),
                    table ) != context.table_stack.end() ) {
                throw std::invalid_argument(
                    "services.serde cannot encode a recursive table" );
            }
            const std::vector<sorted_table_entry> entries =
                sorted_table_entries( table );
            context.table_stack.push_back( table );
            write_type( json, "table" );
            json.member( "entries" );
            json.start_array();
            for( const sorted_table_entry &entry : entries ) {
                json.start_object();
                json.member( "key" );
                write_value( json, entry.key, context, depth + 1 );
                json.member( "value" );
                write_value( json, entry.value, context, depth + 1 );
                json.end_object();
            }
            json.end_array();
            context.table_stack.pop_back();
            break;
        }
        case sol::type::userdata:
            if( value.is<script_game_id>() ) {
                const script_game_id id = value.as<script_game_id>();
                count_string( context.string_bytes, id.kind() );
                count_string( context.string_bytes, id.value() );
                write_type( json, "game_id" );
                json.member( "kind", id.kind() );
                json.member( "value", id.value() );
            } else if( value.is<script_enum_value>() ) {
                const script_enum_value enumeration =
                    value.as<script_enum_value>();
                count_string( context.string_bytes, enumeration.kind() );
                count_string( context.string_bytes, enumeration.name() );
                write_type( json, "enum" );
                json.member( "kind", enumeration.kind() );
                json.member( "name", enumeration.name() );
            } else if( value.is<script_unit_value>() ) {
                const script_unit_value unit =
                    value.as<script_unit_value>();
                count_string( context.string_bytes, unit.kind() );
                count_string(
                    context.string_bytes, unit.canonical_unit() );
                write_type( json, "unit" );
                json.member( "kind", unit.kind() );
                json.member( "unit", unit.canonical_unit() );
                json.member( "integral", unit.is_integral() );
                if( unit.is_integral() ) {
                    json.member( "value", unit.canonical_integer() );
                } else {
                    json.member( "value", unit.canonical_number() );
                }
            } else if( value.is<script_time_duration>() ) {
                write_type( json, "duration" );
                json.member(
                    "turns",
                    value.as<script_time_duration>().turns() );
            } else if( value.is<script_time_point>() ) {
                write_type( json, "time_point" );
                json.member(
                    "turn", value.as<script_time_point>().turn() );
            } else if( value.is<script_point_coord>() ) {
                const script_point_coord point =
                    value.as<script_point_coord>();
                write_type( json, "point_coord" );
                json.member( "origin", point.origin() );
                json.member( "scale", point.scale() );
                json.member( "x", point.x() );
                json.member( "y", point.y() );
            } else if( value.is<script_tripoint_coord>() ) {
                const script_tripoint_coord point =
                    value.as<script_tripoint_coord>();
                write_type( json, "tripoint_coord" );
                json.member( "origin", point.origin() );
                json.member( "scale", point.scale() );
                json.member( "x", point.x() );
                json.member( "y", point.y() );
                json.member( "z", point.z() );
            } else {
                throw std::invalid_argument(
                    "services.serde received unsupported userdata" );
            }
            break;
        default:
            throw std::invalid_argument(
                "services.serde received an unsupported Lua value type" );
    }
    json.end_object();
}

std::string encode_value( const sol::object &value )
{
    encode_context context;
    std::ostringstream buffer;
    {
        JsonOut json( buffer, false );
        json.start_object();
        json.member( "format", "ccb_lua_value" );
        json.member( "version", serde_format_version );
        json.member( "value" );
        write_value( json, value, context, 0 );
        json.end_object();
    }
    std::string result = buffer.str();
    if( result.size() > maximum_serialized_bytes ) {
        throw std::invalid_argument(
            "services.serde output exceeds the 1 MiB limit" );
    }
    return result;
}

void validate_json_nesting( const std::string &input )
{
    bool in_string = false;
    bool escaped = false;
    std::size_t depth = 0;
    for( const char ch : input ) {
        if( in_string ) {
            if( escaped ) {
                escaped = false;
            } else if( ch == '\\' ) {
                escaped = true;
            } else if( ch == '"' ) {
                in_string = false;
            }
            continue;
        }
        if( ch == '"' ) {
            in_string = true;
        } else if( ch == '{' || ch == '[' ) {
            ++depth;
            if( depth > maximum_json_nesting ) {
                throw std::invalid_argument(
                    "services.serde input exceeds the JSON nesting limit" );
            }
        } else if( ( ch == '}' || ch == ']' ) && depth > 0 ) {
            --depth;
        }
    }
}

std::string decoded_string(
    const JsonObject &object, const std::string &member,
    decode_context &context )
{
    const std::string result = object.get_string( member );
    count_string( context.string_bytes, result );
    return result;
}

sol::object decode_value(
    sol::state_view lua, const JsonValue &encoded,
    decode_context &context, const std::size_t depth )
{
    check_depth( depth );
    count_node( context.nodes );
    if( !encoded.test_object() ) {
        throw std::invalid_argument(
            "services.serde encoded values must be objects" );
    }
    const JsonObject object = encoded.get_object();
    const std::string type = object.get_string( "type" );

    sol::object result;
    if( type == "nil" ) {
        result = sol::make_object( lua, sol::nil );
    } else if( type == "boolean" ) {
        result = sol::make_object( lua, object.get_bool( "value" ) );
    } else if( type == "integer" ) {
        result = sol::make_object(
                     lua, static_cast<lua_Integer>(
                         object.get_int64( "value" ) ) );
    } else if( type == "float" ) {
        const double number = object.get_float( "value" );
        if( !std::isfinite( number ) ) {
            throw std::invalid_argument(
                "services.serde decoded a non-finite number" );
        }
        result = sol::make_object( lua, number );
    } else if( type == "string" ) {
        result = sol::make_object(
                     lua, decoded_string(
                         object, "value", context ) );
    } else if( type == "table" ) {
        const JsonArray entries = object.get_array( "entries" );
        if( entries.size() > maximum_table_entries ) {
            throw std::invalid_argument(
                "services.serde table exceeds the 4096-entry limit" );
        }
        sol::table table = lua.create_table();
        std::set<std::string> seen_keys;
        for( std::size_t index = 0; index < entries.size(); ++index ) {
            const JsonObject entry = entries.get_object( index );
            const sol::object key = decode_value(
                                        lua, entry.get_member( "key" ),
                                        context, depth + 1 );
            std::string fingerprint;
            if( key.get_type() == sol::type::string ) {
                fingerprint = "s:" + key.as<std::string>();
            } else if( key.get_type() == sol::type::number &&
                       key.is<lua_Integer>() ) {
                fingerprint = "i:" +
                              std::to_string( key.as<lua_Integer>() );
            } else {
                throw std::invalid_argument(
                    "services.serde decoded an invalid table key" );
            }
            if( !seen_keys.insert( fingerprint ).second ) {
                throw std::invalid_argument(
                    "services.serde decoded duplicate table keys" );
            }
            const sol::object value = decode_value(
                                          lua, entry.get_member( "value" ),
                                          context, depth + 1 );
            table.set( key, value );
            entry.allow_omitted_members();
        }
        result = sol::make_object( lua, std::move( table ) );
    } else if( type == "game_id" ) {
        result = sol::make_object(
                     lua, script_game_id(
                         decoded_string( object, "kind", context ),
                         decoded_string( object, "value", context ) ) );
    } else if( type == "enum" ) {
        result = sol::make_object(
                     lua, script_enum_value::from(
                         decoded_string( object, "kind", context ),
                         decoded_string( object, "name", context ) ) );
    } else if( type == "unit" ) {
        const std::string kind =
            decoded_string( object, "kind", context );
        const std::string unit =
            decoded_string( object, "unit", context );
        if( object.get_bool( "integral" ) ) {
            result = sol::make_object(
                         lua, script_unit_value::from_canonical_integer(
                             kind, unit, object.get_int64( "value" ) ) );
        } else {
            result = sol::make_object(
                         lua, script_unit_value::from_canonical_number(
                             kind, unit, object.get_float( "value" ) ) );
        }
    } else if( type == "duration" ) {
        result = sol::make_object(
                     lua, script_time_duration::from(
                         object.get_int64( "turns" ), "turn" ) );
    } else if( type == "time_point" ) {
        result = sol::make_object(
                     lua, script_time_point::from_turn(
                         object.get_int64( "turn" ) ) );
    } else if( type == "point_coord" ) {
        result = sol::make_object(
                     lua, script_point_coord::from(
                         decoded_string( object, "origin", context ),
                         decoded_string( object, "scale", context ),
                         object.get_int64( "x" ),
                         object.get_int64( "y" ) ) );
    } else if( type == "tripoint_coord" ) {
        result = sol::make_object(
                     lua, script_tripoint_coord::from(
                         decoded_string( object, "origin", context ),
                         decoded_string( object, "scale", context ),
                         object.get_int64( "x" ),
                         object.get_int64( "y" ),
                         object.get_int64( "z" ) ) );
    } else {
        throw std::invalid_argument(
            "services.serde received an unknown encoded type: " + type );
    }
    object.allow_omitted_members();
    return result;
}

sol::object decode_document(
    sol::state_view lua, const std::string &input )
{
    if( input.size() > maximum_serialized_bytes ) {
        throw std::invalid_argument(
            "services.serde input exceeds the 1 MiB limit" );
    }
    validate_json_nesting( input );
    const JsonValue parsed = json_loader::from_string( input );
    if( !parsed.test_object() ) {
        throw std::invalid_argument(
            "services.serde document root must be an object" );
    }
    const JsonObject root = parsed.get_object();
    if( root.get_string( "format" ) != "ccb_lua_value" ) {
        throw std::invalid_argument(
            "services.serde document has an unknown format" );
    }
    if( root.get_int( "version" ) != serde_format_version ) {
        throw std::invalid_argument(
            "services.serde document has an unsupported version" );
    }
    decode_context context;
    sol::object result = decode_value(
                             lua, root.get_member( "value" ), context, 0 );
    root.allow_omitted_members();
    return result;
}

sol::table supported_type_table( sol::state_view lua )
{
    static const std::vector<std::string> types = {
        "boolean", "duration", "enum", "float", "game_id", "integer", "nil",
        "point_coord", "string", "table", "time_point", "tripoint_coord", "unit"
    };
    sol::table result = lua.create_table(
                            static_cast<int>( types.size() ), 0 );
    for( std::size_t index = 0; index < types.size(); ++index ) {
        result[index + 1] = types[index];
    }
    return result;
}

} // namespace

void install_serde_api(
    sol::state &lua, sol::table &services, std::function<void()> require_values )
{
    sol::table serde = lua.create_table();
    serde.set_function(
        "encode",
    [require_values]( const sol::object & value ) {
        require_values();
        return encode_value( value );
    } );
    serde.set_function(
        "decode",
        [require_values](
    sol::this_state lua_state, const std::string & input ) {
        require_values();
        return decode_document(
                   sol::state_view( lua_state ), input );
    } );
    serde.set_function(
        "types",
    [require_values]( sol::this_state lua_state ) {
        require_values();
        return supported_type_table( sol::state_view( lua_state ) );
    } );
    serde["format"] = "ccb_lua_value";
    serde["version"] = serde_format_version;
    serde["max_bytes"] = maximum_serialized_bytes;
    serde["max_depth"] = maximum_value_depth;
    serde["max_nodes"] = maximum_value_nodes;
    serde["max_table_entries"] = maximum_table_entries;
    services["serde"] = std::move( serde );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
