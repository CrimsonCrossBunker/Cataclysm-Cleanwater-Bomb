#include "catalua_ui_factions.h"

#include <algorithm>
#include <bitset>
#include <cctype>
#include <cstddef>
#include <iterator>
#include <map>
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
constexpr int default_detail_limit = 64;
constexpr int maximum_detail_limit = 256;
constexpr int maximum_detail_offset = 1000000;

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

struct detail_options {
    int offset = 0;
    int limit = default_detail_limit;
};

detail_options read_detail_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    detail_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
    }
    if( result.offset < 0 ||
        result.offset > maximum_detail_offset ) {
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
                       maximum_detail_limit );
    return result;
}

faction *resolve_faction( const script_game_id &id )
{
    require_faction_id( id );
    if( g == nullptr ) {
        return nullptr;
    }
    return g->faction_manager_ptr->get(
               faction_id( id.value() ), false );
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
    result["summary"] =
        entry.describe();
    result["known_by_player"] =
        entry.known_by_u;
    sol::table reputation = lua.create_table();
    reputation["likes"] = entry.likes_u;
    reputation["respects"] = entry.respects_u;
    reputation["trusts"] = entry.trusts_u;
    reputation["ranking"] =
        fac_ranking_text( entry.likes_u );
    reputation["respect"] =
        fac_respect_text( entry.respects_u );
    result["reputation"] =
        std::move( reputation );
    sol::table resources = lua.create_table();
    resources["size"] = entry.size;
    resources["power"] = entry.power;
    resources["wealth"] = entry.wealth;
    resources["food_kcal"] =
        entry.food_supply().kcal();
    resources["wealth_description"] =
        fac_wealth_text(
            entry.wealth, entry.size );
    resources["combat_ability"] =
        fac_combat_ability_text(
            entry.power );
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
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry = resolve_faction( id );
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

sol::table faction_members(
    sol::this_state lua, const script_game_id &id,
    const sol::optional<sol::table> &requested )
{
    const detail_options options =
        read_detail_options(
            requested, "game.factions.members" );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry = resolve_faction( id );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The requested faction does not exist"
        } );
    }
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, entry->members.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            entry->members.size() );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    auto iterator = entry->members.cbegin();
    std::advance(
        iterator,
        static_cast<std::ptrdiff_t>( first ) );
    for( std::size_t index = first;
         index < last; ++index, ++iterator ) {
        sol::table member = state.create_table();
        member["id"] =
            iterator->first.get_value();
        member["name"] =
            iterator->second.first;
        member["known_by_player"] =
            iterator->second.second;
        items[index - first + 1] =
            std::move( member );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = entry->members.size();
    value["returned"] = last - first;
    value["has_more"] =
        last < entry->members.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

using relationship_bits =
    std::bitset<static_cast<std::size_t>(
        npc_factions::relationship::rel_types )>;

sol::table snapshot_relationship(
    sol::state_view lua, const std::string &target,
    const relationship_bits &bits )
{
    sol::table result = lua.create_table();
    result["target"] =
        script_game_id( "faction", target );
    result["kill_on_sight"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::kill_on_sight ) );
    result["watch_your_back"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::watch_your_back ) );
    result["share_my_stuff"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::share_my_stuff ) );
    result["share_public_goods"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::share_public_goods ) );
    result["guard_your_stuff"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::guard_your_stuff ) );
    result["lets_you_in"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::lets_you_in ) );
    result["defend_your_space"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::defend_your_space ) );
    result["knows_your_voice"] =
        bits.test( static_cast<std::size_t>(
                       npc_factions::relationship::knows_your_voice ) );
    return result;
}

sol::table faction_relationships(
    sol::this_state lua, const script_game_id &id,
    const sol::optional<sol::table> &requested )
{
    const detail_options options =
        read_detail_options(
            requested, "game.factions.relationships" );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry = resolve_faction( id );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The requested faction does not exist"
        } );
    }
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, entry->relations.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            entry->relations.size() );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    auto iterator = entry->relations.cbegin();
    std::advance(
        iterator,
        static_cast<std::ptrdiff_t>( first ) );
    for( std::size_t index = first;
         index < last; ++index, ++iterator ) {
        items[index - first + 1] =
            snapshot_relationship(
                state, iterator->first,
                iterator->second );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = entry->relations.size();
    value["returned"] = last - first;
    value["has_more"] =
        last < entry->relations.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table faction_relationship(
    sol::this_state lua, const script_game_id &id,
    const script_game_id &target )
{
    require_faction_id( target );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry = resolve_faction( id );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The requested faction does not exist"
        } );
    }
    const auto found =
        entry->relations.find( target.value() );
    const relationship_bits empty;
    sol::table value = snapshot_relationship(
                           state, target.value(),
                           found == entry->relations.end() ?
                           empty : found->second );
    value["defined"] =
        found != entry->relations.end();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table faction_food(
    sol::this_state lua, const script_game_id &id,
    const sol::optional<sol::table> &requested )
{
    const detail_options options =
        read_detail_options(
            requested, "game.factions.food" );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    faction *entry = resolve_faction( id );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The requested faction does not exist"
        } );
    }
    const nutrients supply =
        entry->food_supply();
    const std::map<vitamin_id, int> vitamins =
        supply.vitamins();
    const std::size_t first =
        std::min<std::size_t>(
            options.offset, vitamins.size() );
    const std::size_t last =
        std::min<std::size_t>(
            first + options.limit,
            vitamins.size() );
    sol::table items = state.create_table(
                           static_cast<int>(
                               last - first ), 0 );
    auto iterator = vitamins.cbegin();
    std::advance(
        iterator,
        static_cast<std::ptrdiff_t>( first ) );
    for( std::size_t index = first;
         index < last; ++index, ++iterator ) {
        sol::table vitamin = state.create_table();
        vitamin["id"] = script_game_id(
                            "vitamin",
                            iterator->first.str() );
        vitamin["amount"] =
            iterator->second;
        items[index - first + 1] =
            std::move( vitamin );
    }
    sol::table page = state.create_table();
    page["items"] = std::move( items );
    page["offset"] = options.offset;
    page["limit"] = options.limit;
    page["total"] = vitamins.size();
    page["returned"] = last - first;
    page["has_more"] =
        last < vitamins.size();
    sol::table value = state.create_table();
    value["kcal"] = supply.kcal();
    value["vitamins"] = std::move( page );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
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
    factions.set_function(
        "members",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_read();
        return faction_members(
                   lua_state, id, options );
    } );
    factions.set_function(
        "relationships",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_read();
        return faction_relationships(
                   lua_state, id, options );
    } );
    factions.set_function(
        "relationship",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id,
    const script_game_id & target ) {
        require_read();
        return faction_relationship(
                   lua_state, id, target );
    } );
    factions.set_function(
        "food",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_read();
        return faction_food(
                   lua_state, id, options );
    } );
    game["factions"] = std::move( factions );
}

} // namespace cata::lua_ui
