#if CATA_ENABLE_LUA_PLATFORM

#include "catalua_ui_statistics.h"

#include <algorithm>
#include <cctype>
#include <chrono>
#include <cstddef>
#include <optional>
#include <stdexcept>
#include <string>
#include <unordered_set>
#include <utility>
#include <vector>

#include "cata_variant.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "enum_conversions.h"
#include "enums.h"
#include "event.h"
#include "event_statistics.h"
#include "point.h"
#include "stats_tracker.h"

namespace cata::lua
{

namespace
{

constexpr int default_catalog_limit = 64;
constexpr int maximum_catalog_limit = 256;
constexpr int maximum_catalog_offset = 1000000;
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

std::string monotonicity_name(
    const monotonically value )
{
    switch( value ) {
        case monotonically::constant:
            return "constant";
        case monotonically::increasing:
            return "increasing";
        case monotonically::decreasing:
            return "decreasing";
        case monotonically::unknown:
            return "unknown";
    }
    throw std::invalid_argument(
        "Unknown native statistic monotonicity" );
}

struct page_options {
    int offset = 0;
    int limit = default_catalog_limit;
    std::string query;
};

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
        maximum_catalog_offset ) {
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

page_options read_page_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    page_options result;
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
                    maximum_catalog_limit );
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
        } else {
            throw std::invalid_argument(
                api_name +
                " received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table snapshot_variant(
    sol::state_view lua,
    const cata_variant &value )
{
    sol::table result =
        lua.create_table();
    result["type"] =
        io::enum_to_string(
            value.type() );
    result["raw"] =
        value.get_string();
    result["valid"] =
        value.is_valid();
    switch( value.type() ) {
        case cata_variant_type::void_:
            result["value"] =
                sol::nil;
            break;
        case cata_variant_type::bool_:
            result["value"] =
                value.get<bool>();
            break;
        case cata_variant_type::int_:
            result["value"] =
                value.get<int>();
            break;
        case cata_variant_type::string:
            result["value"] =
                value.get<std::string>();
            break;
        case cata_variant_type::chrono_seconds:
            result["value"] =
                value.get <
                std::chrono::seconds > ().
                count();
            break;
        case cata_variant_type::character_id:
            result["value"] =
                value.get<character_id>().
                get_value();
            break;
        case cata_variant_type::point: {
            const point coordinate =
                value.get<point>();
            sol::table point_value =
                lua.create_table();
            point_value["x"] =
                coordinate.x;
            point_value["y"] =
                coordinate.y;
            result["value"] =
                std::move( point_value );
            break;
        }
        case cata_variant_type::tripoint: {
            const tripoint coordinate =
                value.get<tripoint>();
            sol::table point_value =
                lua.create_table();
            point_value["x"] =
                coordinate.x;
            point_value["y"] =
                coordinate.y;
            point_value["z"] =
                coordinate.z;
            result["value"] =
                std::move( point_value );
            break;
        }
        default:
            result["value"] =
                value.get_string();
            break;
    }
    return result;
}

sol::table snapshot_sources(
    sol::state_view lua,
    const std::vector<std::pair<
    string_id<event_statistic>,
    mod_id>> &sources )
{
    const std::size_t returned =
        std::min<std::size_t>(
            sources.size(),
            maximum_nested_values );
    sol::table items =
        lua.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        sol::table source =
            lua.create_table();
        source["statistic"] =
            script_game_id(
                "event_statistic",
                sources[index].first.str() );
        source["mod"] =
            sources[index].second.str();
        items[index + 1] =
            std::move( source );
    }
    sol::table result =
        lua.create_table();
    result["items"] =
        std::move( items );
    result["total"] =
        sources.size();
    result["returned"] =
        returned;
    result["truncated"] =
        returned < sources.size();
    return result;
}

sol::table snapshot_sources(
    sol::state_view lua,
    const std::vector<std::pair<
    string_id<event_transformation>,
    mod_id>> &sources )
{
    const std::size_t returned =
        std::min<std::size_t>(
            sources.size(),
            maximum_nested_values );
    sol::table items =
        lua.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        sol::table source =
            lua.create_table();
        source["transformation"] =
            script_game_id(
                "event_transformation",
                sources[index].first.str() );
        source["mod"] =
            sources[index].second.str();
        items[index + 1] =
            std::move( source );
    }
    sol::table result =
        lua.create_table();
    result["items"] =
        std::move( items );
    result["total"] =
        sources.size();
    result["returned"] =
        returned;
    result["truncated"] =
        returned < sources.size();
    return result;
}

sol::table snapshot_sources(
    sol::state_view lua,
    const std::vector<std::pair<
    string_id<score>,
    mod_id>> &sources )
{
    const std::size_t returned =
        std::min<std::size_t>(
            sources.size(),
            maximum_nested_values );
    sol::table items =
        lua.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        sol::table source =
            lua.create_table();
        source["score"] =
            script_game_id(
                "score",
                sources[index].first.str() );
        source["mod"] =
            sources[index].second.str();
        items[index + 1] =
            std::move( source );
    }
    sol::table result =
        lua.create_table();
    result["items"] =
        std::move( items );
    result["total"] =
        sources.size();
    result["returned"] =
        returned;
    result["truncated"] =
        returned < sources.size();
    return result;
}

sol::table snapshot_statistic_definition(
    sol::state_view lua,
    const event_statistic &entry )
{
    sol::table result =
        lua.create_table();
    result["id"] =
        script_game_id(
            "event_statistic",
            entry.id.str() );
    result["description"] =
        entry.description().
        translated();
    result["type"] =
        io::enum_to_string(
            entry.type() );
    result["monotonicity"] =
        monotonicity_name(
            entry.monotonicity() );
    result["loaded"] =
        entry.was_loaded;
    result["sources"] =
        snapshot_sources(
            lua, entry.src );
    return result;
}

std::vector<const event_statistic *>
matching_statistics(
    const std::string &requested_query )
{
    const std::string query =
        lowercase_ascii(
            requested_query );
    std::vector <
    const event_statistic * > result;
    for( const event_statistic &entry :
         event_statistic::get_all() ) {
        if( query.empty() ||
            lowercase_ascii(
                entry.id.str() ).find(
                query ) !=
            std::string::npos ||
            lowercase_ascii(
                entry.description().
                translated() ).find(
                query ) !=
            std::string::npos ) {
            result.push_back( &entry );
        }
    }
    std::sort(
        result.begin(), result.end(),
        []( const event_statistic * lhs,
    const event_statistic * rhs ) {
        return lhs->id.str() <
               rhs->id.str();
    } );
    return result;
}

void require_statistic_id(
    const script_game_id &id,
    const std::string &api_name )
{
    if( id.kind() !=
        "event_statistic" ||
        !id.is_valid() ) {
        throw std::invalid_argument(
            api_name +
            " requires a valid GameId<event_statistic>" );
    }
}

const event_statistic &resolve_statistic(
    const script_game_id &id,
    const std::string &api_name )
{
    require_statistic_id(
        id, api_name );
    return string_id<event_statistic>(
               id.value() ).obj();
}

sol::table list_statistic_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.definitions" );
    const std::vector <
    const event_statistic * > matches =
        matching_statistics(
            options.query );
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
            snapshot_statistic_definition(
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

sol::table get_statistic_definition(
    sol::this_state lua,
    const script_game_id &id )
{
    return snapshot_statistic_definition(
               sol::state_view( lua ),
               resolve_statistic(
                   id,
                   "services.statistics.definition" ) );
}

sol::table list_statistic_values(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.values" );
    const std::vector <
    const event_statistic * > matches =
        matching_statistics(
            options.query );
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
        sol::table entry =
            snapshot_statistic_definition(
                state, *matches[index] );
        entry["value"] =
            snapshot_variant(
                state,
                get_stats().value_of(
                    matches[index]->id ) );
        items[index - first + 1] =
            std::move( entry );
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
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

sol::table get_statistic_value(
    sol::this_state lua,
    const script_game_id &id )
{
    const event_statistic &entry =
        resolve_statistic(
            id,
            "services.statistics.value" );
    sol::state_view state( lua );
    sol::table value =
        snapshot_statistic_definition(
            state, entry );
    value["value"] =
        snapshot_variant(
            state,
            get_stats().value_of(
                entry.id ) );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

sol::table snapshot_transformation_definition(
    sol::state_view lua,
    const event_transformation &entry )
{
    sol::table result =
        lua.create_table();
    result["id"] =
        script_game_id(
            "event_transformation",
            entry.id.str() );
    result["monotonicity"] =
        monotonicity_name(
            entry.monotonicity() );
    result["loaded"] =
        entry.was_loaded;
    result["sources"] =
        snapshot_sources(
            lua, entry.src );

    const event_fields_type fields =
        entry.fields();
    std::vector<std::pair<
    std::string, cata_variant_type>>
                                  ordered_fields(
                                      fields.begin(), fields.end() );
    std::sort(
        ordered_fields.begin(),
        ordered_fields.end(),
        []( const auto & lhs,
    const auto & rhs ) {
        return lhs.first <
               rhs.first;
    } );
    const std::size_t returned =
        std::min<std::size_t>(
            ordered_fields.size(),
            maximum_nested_values );
    sol::table field_items =
        lua.create_table(
            static_cast<int>(
                returned ), 0 );
    for( std::size_t index = 0;
         index < returned; ++index ) {
        sol::table field =
            lua.create_table();
        field["name"] =
            ordered_fields[index].first;
        field["type"] =
            io::enum_to_string(
                ordered_fields[index].
                second );
        field_items[index + 1] =
            std::move( field );
    }
    sol::table field_page =
        lua.create_table();
    field_page["items"] =
        std::move( field_items );
    field_page["total"] =
        ordered_fields.size();
    field_page["returned"] =
        returned;
    field_page["truncated"] =
        returned <
        ordered_fields.size();
    result["fields"] =
        std::move( field_page );
    return result;
}

std::vector<const event_transformation *>
matching_transformations(
    const std::string &requested_query )
{
    const std::string query =
        lowercase_ascii(
            requested_query );
    std::vector <
    const event_transformation * > result;
    for( const event_transformation &entry :
         event_transformation::get_all() ) {
        if( query.empty() ||
            lowercase_ascii(
                entry.id.str() ).find(
                query ) !=
            std::string::npos ) {
            result.push_back( &entry );
        }
    }
    std::sort(
        result.begin(), result.end(),
        []( const event_transformation * lhs,
    const event_transformation * rhs ) {
        return lhs->id.str() <
               rhs->id.str();
    } );
    return result;
}

void require_transformation_id(
    const script_game_id &id,
    const std::string &api_name )
{
    if( id.kind() !=
        "event_transformation" ||
        !id.is_valid() ) {
        throw std::invalid_argument(
            api_name +
            " requires a valid GameId<event_transformation>" );
    }
}

const event_transformation &
resolve_transformation(
    const script_game_id &id,
    const std::string &api_name )
{
    require_transformation_id(
        id, api_name );
    return string_id <
           event_transformation > (
               id.value() ).obj();
}

sol::table list_transformations(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.transformations" );
    const std::vector <
    const event_transformation * > matches =
        matching_transformations(
            options.query );
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
            snapshot_transformation_definition(
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

std::string event_partition_key(
    const event_multiset::summaries_type::
    value_type &entry )
{
    std::string result;
    for( const auto &field :
         entry.first ) {
        result += field.first;
        result += '\x1f';
        result +=
            io::enum_to_string(
                field.second.type() );
        result += '\x1f';
        result +=
            field.second.get_string();
        result += '\x1e';
    }
    return result;
}

sol::table snapshot_event_partition(
    sol::state_view lua,
    const event_multiset::summaries_type::
    value_type &entry )
{
    sol::table result =
        lua.create_table();
    result["count"] =
        entry.second.count;
    result["first"] =
        script_time_point::from_native(
            entry.second.first );
    result["last"] =
        script_time_point::from_native(
            entry.second.last );
    sol::table data =
        lua.create_table();
    for( const auto &field :
         entry.first ) {
        data[field.first] =
            snapshot_variant(
                lua, field.second );
    }
    result["data"] =
        std::move( data );
    return result;
}

sol::table snapshot_event_multiset(
    sol::state_view lua,
    const event_multiset &events,
    const page_options &options )
{
    using summary_entry =
        event_multiset::summaries_type::
        value_type;
    std::vector<const summary_entry *>
    partitions;
    partitions.reserve(
        events.counts().size() );
    for( const summary_entry &entry :
         events.counts() ) {
        partitions.push_back( &entry );
    }
    std::sort(
        partitions.begin(),
        partitions.end(),
        []( const summary_entry * lhs,
    const summary_entry * rhs ) {
        return event_partition_key(
                   *lhs ) <
               event_partition_key(
                   *rhs );
    } );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset,
            partitions.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            partitions.size() );
    sol::table items =
        lua.create_table(
            static_cast<int>(
                last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_event_partition(
                lua, *partitions[index] );
    }
    sol::table result =
        lua.create_table();
    result["items"] =
        std::move( items );
    result["offset"] =
        options.offset;
    result["limit"] =
        options.limit;
    result["total"] =
        partitions.size();
    result["returned"] =
        last - first;
    result["has_more"] =
        last < partitions.size();
    result["event_count"] =
        events.count();
    return result;
}

sol::table get_transformation(
    sol::this_state lua,
    const script_game_id &id,
    const sol::optional<sol::table> &requested )
{
    const event_transformation &entry =
        resolve_transformation(
            id,
            "services.statistics.transformation" );
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.transformation" );
    event_multiset events =
        get_stats().get_events(
            entry.id );
    sol::state_view state( lua );
    sol::table value =
        snapshot_transformation_definition(
            state, entry );
    value["events"] =
        snapshot_event_multiset(
            state, events,
            options );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

event_type resolve_event_type(
    const std::string &name,
    const std::string &api_name )
{
    if( !io::enum_is_valid <
        event_type > ( name ) ) {
        throw std::invalid_argument(
            api_name +
            " received an unknown native event type" );
    }
    return io::string_to_enum <
           event_type > ( name );
}

sol::table snapshot_event_type(
    sol::state_view lua,
    const event_type type )
{
    sol::table result =
        lua.create_table();
    result["name"] =
        io::enum_to_string(
            type );
    const cata::event::fields_type fields =
        cata::event::get_fields(
            type );
    std::vector<std::pair<
    std::string, cata_variant_type>>
                                  ordered_fields(
                                      fields.begin(), fields.end() );
    std::sort(
        ordered_fields.begin(),
        ordered_fields.end(),
        []( const auto & lhs,
    const auto & rhs ) {
        return lhs.first <
               rhs.first;
    } );
    sol::table field_items =
        lua.create_table(
            static_cast<int>(
                ordered_fields.size() ), 0 );
    for( std::size_t index = 0;
         index < ordered_fields.size();
         ++index ) {
        sol::table field =
            lua.create_table();
        field["name"] =
            ordered_fields[index].first;
        field["type"] =
            io::enum_to_string(
                ordered_fields[index].
                second );
        field_items[index + 1] =
            std::move( field );
    }
    result["fields"] =
        std::move( field_items );
    result["count"] =
        get_stats().get_events(
            type ).count();
    return result;
}

sol::table list_event_types(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.event_types" );
    const std::string query =
        lowercase_ascii(
            options.query );
    std::vector<event_type> matches;
    for( int raw = 0;
         raw < static_cast<int>(
             event_type::
             num_event_types );
         ++raw ) {
        const event_type type =
            static_cast<event_type>(
                raw );
        if( query.empty() ||
            lowercase_ascii(
                io::enum_to_string(
                    type ) ).find(
                query ) !=
            std::string::npos ) {
            matches.push_back( type );
        }
    }
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
            snapshot_event_type(
                state, matches[index] );
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

sol::table get_event_history(
    sol::this_state lua,
    const std::string &name,
    const sol::optional<sol::table> &requested )
{
    const event_type type =
        resolve_event_type(
            name,
            "services.statistics.event" );
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.event" );
    if( !options.query.empty() ) {
        throw std::invalid_argument(
            "services.statistics.event does not accept option 'query'" );
    }
    sol::state_view state( lua );
    sol::table value =
        snapshot_event_type(
            state, type );
    value["events"] =
        snapshot_event_multiset(
            state,
            get_stats().get_events(
                type ),
            options );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

std::unordered_set<string_id<score>>
                                  valid_score_ids()
{
    std::unordered_set <
    string_id<score >> result;
    for( const score *entry :
         get_stats().valid_scores() ) {
        if( entry != nullptr ) {
            result.insert( entry->id );
        }
    }
    return result;
}

sol::table snapshot_score(
    sol::state_view lua,
    const score &entry,
    const std::unordered_set <
    string_id<score >> &valid_ids )
{
    sol::table result =
        lua.create_table();
    result["id"] =
        script_game_id(
            "score", entry.id.str() );
    result["description"] =
        entry.description(
            get_stats() );
    result["value"] =
        snapshot_variant(
            lua, entry.value(
                get_stats() ) );
    result["valid"] =
        valid_ids.count(
            entry.id ) != 0;
    result["loaded"] =
        entry.was_loaded;
    result["sources"] =
        snapshot_sources(
            lua, entry.src );
    return result;
}

std::vector<const score *> matching_scores(
    const std::string &requested_query )
{
    const std::string query =
        lowercase_ascii(
            requested_query );
    std::vector<const score *> result;
    for( const score &entry :
         score::get_all() ) {
        if( query.empty() ||
            lowercase_ascii(
                entry.id.str() ).find(
                query ) !=
            std::string::npos ) {
            result.push_back( &entry );
        }
    }
    std::sort(
        result.begin(), result.end(),
        []( const score * lhs,
    const score * rhs ) {
        return lhs->id.str() <
               rhs->id.str();
    } );
    return result;
}

sol::table list_scores(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const page_options options =
        read_page_options(
            requested,
            "services.statistics.scores" );
    const std::vector <
    const score * > matches =
        matching_scores(
            options.query );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset,
            matches.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            matches.size() );
    const std::unordered_set <
    string_id<score >> valid_ids =
                        valid_score_ids();
    sol::state_view state( lua );
    sol::table items =
        state.create_table(
            static_cast<int>(
                last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_score(
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
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   std::move( value ) ) );
}

sol::table get_score(
    sol::this_state lua,
    const script_game_id &id )
{
    if( id.kind() != "score" ||
        !id.is_valid() ) {
        throw std::invalid_argument(
            "services.statistics.score requires a valid GameId<score>" );
    }
    const score &entry =
        string_id<score>(
            id.value() ).obj();
    const std::unordered_set <
    string_id<score >> valid_ids =
                        valid_score_ids();
    sol::state_view state( lua );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   snapshot_score(
                       state, entry,
                       valid_ids ) ) );
}

} // namespace

void install_statistics_api(
    sol::table &game,
    std::function<void()> require_read )
{
    sol::state_view lua(
        game.lua_state() );
    sol::table statistics =
        lua.create_table();
    statistics.set_function(
        "definitions",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_statistic_definitions(
                   state, options );
    } );
    statistics.set_function(
        "definition",
        [require_read]( sol::this_state state,
    const script_game_id & id ) {
        require_read();
        return get_statistic_definition(
                   state, id );
    } );
    statistics.set_function(
        "values",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_statistic_values(
                   state, options );
    } );
    statistics.set_function(
        "value",
        [require_read]( sol::this_state state,
    const script_game_id & id ) {
        require_read();
        return get_statistic_value(
                   state, id );
    } );
    statistics.set_function(
        "transformations",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_transformations(
                   state, options );
    } );
    statistics.set_function(
        "transformation",
        [require_read]( sol::this_state state,
                        const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_read();
        return get_transformation(
                   state, id, options );
    } );
    statistics.set_function(
        "event_types",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_event_types(
                   state, options );
    } );
    statistics.set_function(
        "event",
        [require_read]( sol::this_state state,
                        const std::string & name,
    const sol::optional<sol::table> &options ) {
        require_read();
        return get_event_history(
                   state, name, options );
    } );
    statistics.set_function(
        "scores",
        [require_read]( sol::this_state state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_scores(
                   state, options );
    } );
    statistics.set_function(
        "score",
        [require_read]( sol::this_state state,
    const script_game_id & id ) {
        require_read();
        return get_score(
                   state, id );
    } );
    game["statistics"] =
        std::move( statistics );
}

} // namespace cata::lua

#endif // CATA_ENABLE_LUA_PLATFORM
