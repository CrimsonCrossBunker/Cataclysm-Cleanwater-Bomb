#include "catalua_ui_factions.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "faction.h"
#include "game.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_faction_limit = 64;
constexpr int maximum_faction_limit = 256;
constexpr int maximum_faction_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;

struct faction_options {
    int offset = 0;
    int limit = default_faction_limit;
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

faction_options read_faction_options(
    const sol::optional<sol::table> &requested )
{
    faction_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.query = requested->get_or(
                           "query", result.query );
    }
    if( result.offset < 0 ||
        result.offset > maximum_faction_offset ) {
        throw std::invalid_argument(
            "game.factions.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.factions.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_faction_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.factions.list query exceeds 128 bytes" );
    }
    return result;
}

void require_faction_id( const script_game_id &id )
{
    if( id.kind() != "faction" ) {
        throw std::invalid_argument(
            "game.factions.get requires GameId<faction>" );
    }
}

std::string steal_policy( const faction &entry )
{
    if( !entry.steal_persist ) {
        return "ask";
    }
    return *entry.steal_persist ? "always" : "never";
}

sol::table snapshot_faction(
    sol::state_view lua, const faction &entry )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "faction", entry.id.str() );
    result["name"] = entry.get_name();
    result["description"] =
        entry.desc.translated();
    result["known_by_player"] =
        entry.known_by_u;
    sol::table reputation = lua.create_table();
    reputation["likes"] = entry.likes_u;
    reputation["respects"] = entry.respects_u;
    reputation["trusts"] = entry.trusts_u;
    result["reputation"] =
        std::move( reputation );
    sol::table resources = lua.create_table();
    resources["size"] = entry.size;
    resources["power"] = entry.power;
    resources["wealth"] = entry.wealth;
    resources["food_kcal"] =
        entry.food_supply().kcal();
    result["resources"] =
        std::move( resources );
    sol::table policy = lua.create_table();
    policy["consumes_food"] =
        entry.consumes_food;
    policy["lone_wolf"] =
        entry.lone_wolf_faction;
    policy["limited_area_claim"] =
        entry.limited_area_claim;
    policy["stealing"] =
        steal_policy( entry );
    result["policy"] = std::move( policy );
    if( entry.currency.is_empty() ) {
        result["currency"] = sol::nil;
    } else {
        result["currency"] = script_game_id(
                                 "item",
                                 entry.currency.str() );
    }
    if( entry.mon_faction.is_null() ) {
        result["monster_faction"] = sol::nil;
    } else {
        result["monster_faction"] =
            script_game_id(
                "monster_faction",
                entry.mon_faction.str() );
    }
    result["members"] = entry.members.size();
    result["relationship_targets"] =
        entry.relations.size();
    return result;
}

std::vector<const faction *> matching_factions(
    const std::string &requested_query )
{
    std::vector<const faction *> result;
    if( g == nullptr ) {
        return result;
    }
    const std::string query =
        lowercase_ascii( requested_query );
    for( const auto &pair :
         g->faction_manager_ptr->all() ) {
        const faction &entry = pair.second;
        if( query.empty() ||
            lowercase_ascii(
                entry.id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                entry.get_name() ).find( query ) !=
            std::string::npos ) {
            result.push_back( &entry );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const faction * lhs, const faction * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    return result;
}

sol::table list_factions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const faction_options options =
        read_faction_options( requested );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    const std::vector<const faction *> entries =
        matching_factions( options.query );
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, entries.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit, entries.size() );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    for( std::size_t index = first;
         index < last; ++index ) {
        items[index - first + 1] =
            snapshot_faction(
                state, *entries[index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = entries.size();
    value["returned"] = last - first;
    value["has_more"] =
        last < entries.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table get_faction(
    sol::this_state lua, const script_game_id &id )
{
    require_faction_id( id );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry =
        g->faction_manager_ptr->get(
            faction_id( id.value() ), false );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The requested faction does not exist"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_faction(
                       state, *entry ) ) );
}

sol::table player_faction( sol::this_state lua )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry = get_avatar().get_faction();
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The player has no active faction"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_faction(
                       state, *entry ) ) );
}

} // namespace

void install_faction_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    static_cast<void>( require_write );
    sol::state_view lua( game.lua_state() );
    sol::table factions = lua.create_table();
    factions.set_function(
        "list",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_factions(
                   lua_state, options );
    } );
    factions.set_function(
        "get",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_faction(
                   lua_state, id );
    } );
    factions.set_function(
        "player",
        [require_read]( sol::this_state lua_state ) {
        require_read();
        return player_faction( lua_state );
    } );
    game["factions"] = std::move( factions );
}

} // namespace cata::lua_ui
