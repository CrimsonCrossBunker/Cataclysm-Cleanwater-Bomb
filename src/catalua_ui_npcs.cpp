#if CATA_ENABLE_LUA_UI

#include "catalua_ui_npcs.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "coordinates.h"
#include "enum_conversions.h"
#include "game.h"
#include "npc.h"
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
constexpr int default_state_limit = 64;
constexpr int maximum_state_limit = 256;
constexpr int maximum_state_offset = 1000000;
constexpr std::size_t maximum_npc_name_bytes = 256;
constexpr int maximum_opinion_delta = 1000000;

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

game_handle make_npc_handle(
    npc &entry, const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position =
        entry.pos_abs();
    return game_handle::from_creature(
    entry, {
        "npc", entry.getID().get_value(),
        position.x(), position.y(), position.z(), {}
    },
    runtime_generation, world_generation );
}

npc *resolve_npc(
    const game_handle &handle, const std::size_t runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    npc *entry = resolved.value->as_npc();
    if( entry == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not an NPC"
        };
    }
    return entry;
}

sol::table snapshot_opinion(
    sol::state_view lua, const npc_opinion &opinion )
{
    sol::table result = lua.create_table();
    result["trust"] = opinion.trust;
    result["fear"] = opinion.fear;
    result["value"] = opinion.value;
    result["anger"] = opinion.anger;
    result["owed"] = opinion.owed;
    result["sold"] = opinion.sold;
    return result;
}

sol::table snapshot_npc(
    sol::state_view lua, npc &entry,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position =
        entry.pos_abs();
    sol::table result = lua.create_table();
    result["handle"] = make_npc_handle(
                           entry, runtime_generation,
                           world_generation );
    result["id"] = entry.getID().get_value();
    result["unique_id"] = entry.get_unique_id();
    result["name"] = entry.get_name();
    result["display_name"] =
        entry.display_name();
    result["position"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            position.raw() );
    result["class"] = script_game_id(
                          "npc_class",
                          entry.myclass.str() );
    if( entry.idz.is_null() ) {
        result["template"] = sol::nil;
    } else {
        result["template"] = script_game_id(
                                 "npc_template",
                                 entry.idz.str() );
    }
    const faction_id faction = entry.get_fac_id();
    if( faction.is_null() ) {
        result["faction"] = sol::nil;
    } else {
        result["faction"] = script_game_id(
                                "faction",
                                faction.str() );
    }
    result["attitude"] =
        npc_attitude_id(
            entry.get_attitude() );
    result["attitude_name"] =
        npc_attitude_name(
            entry.get_attitude() );
    result["mission"] =
        io::enum_to_string( entry.mission );
    result["status"] =
        entry.get_current_status();
    result["activity"] =
        entry.get_current_activity();
    result["male"] = entry.male;
    result["dead"] = entry.is_dead();
    result["hallucination"] =
        entry.is_hallucination();
    result["enemy"] = entry.is_enemy();
    result["following"] = entry.is_following();
    result["player_ally"] =
        entry.is_player_ally();
    result["leader"] = entry.is_leader();
    result["guarding"] = entry.is_guarding();
    result["patrolling"] = entry.is_patrolling();
    result["shopkeeper"] =
        entry.is_shopkeeper();
    result["faction_representative"] =
        entry.faction_representative;
    result["opinion"] =
        snapshot_opinion(
            lua, entry.get_opinion_values(
                get_avatar() ) );
    sol::table personality = lua.create_table();
    personality["aggression"] =
        entry.personality.aggression;
    personality["bravery"] =
        entry.personality.bravery;
    personality["collector"] =
        entry.personality.collector;
    personality["altruism"] =
        entry.personality.altruism;
    result["personality"] =
        std::move( personality );
    return result;
}

struct state_options {
    int offset = 0;
    int limit = default_state_limit;
    std::string query;
};

state_options read_state_options(
    const sol::optional<sol::table> &requested )
{
    state_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.query = requested->get_or(
                           "query", result.query );
    }
    if( result.offset < 0 ||
        result.offset > maximum_state_offset ) {
        throw std::invalid_argument(
            "game.npcs.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.npcs.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_state_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.npcs.list query exceeds 128 bytes" );
    }
    return result;
}

std::vector<npc *> matching_npcs(
    const std::string &requested_query )
{
    std::vector<npc *> result;
    if( g == nullptr ) {
        return result;
    }
    const std::string query =
        lowercase_ascii( requested_query );
    for( npc &entry : g->all_npcs() ) {
        if( query.empty() ||
            lowercase_ascii(
                entry.get_name() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                entry.get_unique_id() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                entry.myclass.str() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &entry );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const npc * lhs, const npc * rhs ) {
        return lhs->getID().get_value() <
               rhs->getID().get_value();
    } );
    return result;
}

sol::table list_npcs(
    sol::this_state lua,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const state_options options =
        read_state_options( requested );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    const std::vector<npc *> entries =
        matching_npcs( options.query );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, entries.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit,
                                 entries.size() );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_npc(
                state, *entries[index],
                runtime_generation,
                world_generation );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = entries.size();
    value["returned"] = last - first;
    value["has_more"] = last < entries.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table get_npc(
    sol::this_state lua, const game_handle &handle,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_npc(
                       state, *entry,
                       runtime_generation,
                       world_generation ) ) );
}

void validate_npc_name( const std::string &name )
{
    if( name.empty() ) {
        throw std::invalid_argument(
            "game.npcs.rename name cannot be empty" );
    }
    if( name.size() > maximum_npc_name_bytes ) {
        throw std::invalid_argument(
            "game.npcs.rename name exceeds 256 bytes" );
    }
    if( std::any_of(
    name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "game.npcs.rename name cannot contain control characters" );
    }
}

sol::table rename_npc(
    sol::this_state lua, const game_handle &handle,
    const std::string &requested_name,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    validate_npc_name( requested_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before = entry->name;
    entry->name = requested_name;
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->name;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

std::optional<npc_attitude> parse_attitude(
    const std::string_view requested )
{
    static const std::vector<std::pair<std::string_view, npc_attitude>>
    values = {
        { "NPCATT_NULL", NPCATT_NULL },
        { "NPCATT_TALK", NPCATT_TALK },
        { "NPCATT_FOLLOW", NPCATT_FOLLOW },
        { "NPCATT_LEAD", NPCATT_LEAD },
        { "NPCATT_WAIT", NPCATT_WAIT },
        { "NPCATT_MUG", NPCATT_MUG },
        { "NPCATT_WAIT_FOR_LEAVE", NPCATT_WAIT_FOR_LEAVE },
        { "NPCATT_KILL", NPCATT_KILL },
        { "NPCATT_FLEE", NPCATT_FLEE },
        { "NPCATT_HEAL", NPCATT_HEAL },
        { "NPCATT_ACTIVITY", NPCATT_ACTIVITY },
        { "NPCATT_FLEE_TEMP", NPCATT_FLEE_TEMP },
        { "NPCATT_RECOVER_GOODS", NPCATT_RECOVER_GOODS }
    };
    const auto found = std::find_if(
                           values.begin(), values.end(),
    [requested]( const auto & entry ) {
        return entry.first == requested;
    } );
    if( found == values.end() ) {
        return std::nullopt;
    }
    return found->second;
}

sol::table set_npc_attitude(
    sol::this_state lua, const game_handle &handle,
    const std::string &requested_attitude,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const std::optional<npc_attitude> attitude =
        parse_attitude( requested_attitude );
    if( !attitude ) {
        throw std::invalid_argument(
            "game.npcs.set_attitude received an unknown attitude" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_attitude before =
        entry->get_attitude();
    entry->set_attitude( *attitude );
    sol::table value = state.create_table();
    value["before"] = npc_attitude_id( before );
    value["after"] =
        npc_attitude_id(
            entry->get_attitude() );
    value["changed"] =
        before != entry->get_attitude();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct opinion_deltas {
    std::optional<int> trust;
    std::optional<int> fear;
    std::optional<int> value;
    std::optional<int> anger;
    std::optional<int> owed;
    std::optional<int> sold;
};

opinion_deltas read_opinion_deltas(
    const sol::table &requested )
{
    opinion_deltas result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.npcs.modify_opinion option keys must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        if( key != "trust" && key != "fear" &&
            key != "value" && key != "anger" &&
            key != "owed" && key != "sold" ) {
            throw std::invalid_argument(
                "game.npcs.modify_opinion received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "game.npcs.modify_opinion option '" + key +
                "' must be an integer" );
        }
        const int delta = entry.second.as<int>();
        if( delta < -maximum_opinion_delta ||
            delta > maximum_opinion_delta ) {
            throw std::invalid_argument(
                "game.npcs.modify_opinion option '" + key +
                "' must be within -1000000..1000000" );
        }
        if( key == "trust" ) {
            result.trust = delta;
        } else if( key == "fear" ) {
            result.fear = delta;
        } else if( key == "value" ) {
            result.value = delta;
        } else if( key == "anger" ) {
            result.anger = delta;
        } else if( key == "owed" ) {
            result.owed = delta;
        } else {
            result.sold = delta;
        }
    }
    if( !result.trust && !result.fear &&
        !result.value && !result.anger &&
        !result.owed && !result.sold ) {
        throw std::invalid_argument(
            "game.npcs.modify_opinion requires at least one delta" );
    }
    return result;
}

int adjusted_opinion_value(
    const int current, const int delta,
    const bool nonnegative )
{
    const std::int64_t adjusted =
        static_cast<std::int64_t>( current ) +
        static_cast<std::int64_t>( delta );
    const std::int64_t minimum =
        nonnegative ? 0 :
        std::numeric_limits<int>::min();
    return static_cast<int>(
               std::clamp<std::int64_t>(
                   adjusted, minimum,
                   std::numeric_limits<int>::max() ) );
}

sol::table modify_npc_opinion(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const opinion_deltas deltas =
        read_opinion_deltas( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before =
        snapshot_opinion(
            state, entry->op_of_u );
    if( deltas.trust ) {
        entry->op_of_u.trust =
            adjusted_opinion_value(
                entry->op_of_u.trust,
                *deltas.trust, false );
    }
    if( deltas.fear ) {
        entry->op_of_u.fear =
            adjusted_opinion_value(
                entry->op_of_u.fear,
                *deltas.fear, false );
    }
    if( deltas.value ) {
        entry->op_of_u.value =
            adjusted_opinion_value(
                entry->op_of_u.value,
                *deltas.value, false );
    }
    if( deltas.anger ) {
        entry->op_of_u.anger =
            adjusted_opinion_value(
                entry->op_of_u.anger,
                *deltas.anger, false );
    }
    if( deltas.owed ) {
        entry->op_of_u.owed =
            adjusted_opinion_value(
                entry->op_of_u.owed,
                *deltas.owed, false );
    }
    if( deltas.sold ) {
        entry->op_of_u.sold =
            adjusted_opinion_value(
                entry->op_of_u.sold,
                *deltas.sold, true );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_opinion(
            state, entry->op_of_u );
    value["effective"] =
        snapshot_opinion(
            state, entry->get_opinion_values(
                get_avatar() ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
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
    npcs.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_npcs(
                   lua_state, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_npc(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "rename",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & name ) {
        require_write();
        return rename_npc(
                   lua_state, handle, name,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_attitude",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & attitude ) {
        require_write();
        return set_npc_attitude(
                   lua_state, handle, attitude,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "modify_opinion",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & deltas ) {
        require_write();
        return modify_npc_opinion(
                   lua_state, handle, deltas,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["npcs"] = std::move( npcs );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
