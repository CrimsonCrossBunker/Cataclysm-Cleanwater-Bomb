#include "catalua_ui_factions.h"

#include <algorithm>
#include <bitset>
#include <cctype>
#include <cstddef>
#include <cstdint>
#include <iterator>
#include <limits>
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
constexpr std::size_t maximum_faction_name_bytes =
    MAX_FAC_NAME_SIZE;
constexpr int maximum_reputation_delta = 1000000;
constexpr int maximum_resource_delta = 1000000000;
constexpr int maximum_food_delta_kcal = 1000000000;

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

sol::table snapshot_reputation(
    sol::state_view lua, const faction &entry )
{
    sol::table result = lua.create_table();
    result["likes"] = entry.likes_u;
    result["respects"] = entry.respects_u;
    result["trusts"] = entry.trusts_u;
    result["ranking"] =
        fac_ranking_text( entry.likes_u );
    result["respect"] =
        fac_respect_text( entry.respects_u );
    return result;
}

sol::table snapshot_resources(
    sol::state_view lua, const faction &entry )
{
    sol::table result = lua.create_table();
    result["size"] = entry.size;
    result["power"] = entry.power;
    result["wealth"] = entry.wealth;
    result["food_kcal"] =
        entry.food_supply().kcal();
    result["wealth_description"] =
        entry.size > 0 ?
        fac_wealth_text(
            entry.wealth, entry.size ) :
        std::string();
    result["combat_ability"] =
        fac_combat_ability_text(
            entry.power );
    return result;
}

sol::table snapshot_policy(
    sol::state_view lua, const faction &entry )
{
    sol::table result = lua.create_table();
    result["consumes_food"] =
        entry.consumes_food;
    result["lone_wolf"] =
        entry.lone_wolf_faction;
    result["limited_area_claim"] =
        entry.limited_area_claim;
    result["stealing"] =
        steal_policy( entry );
    return result;
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
    result["reputation"] =
        snapshot_reputation( lua, entry );
    result["resources"] =
        snapshot_resources( lua, entry );
    result["policy"] =
        snapshot_policy( lua, entry );
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

void validate_faction_name(
    const std::string &name )
{
    if( name.empty() ) {
        throw std::invalid_argument(
            "game.factions.rename name cannot be empty" );
    }
    if( name.size() >
        maximum_faction_name_bytes ) {
        throw std::invalid_argument(
            "game.factions.rename name exceeds 40 bytes" );
    }
    if( std::any_of(
    name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            "game.factions.rename name cannot contain control characters" );
    }
}

sol::table rename_faction(
    sol::this_state lua, const script_game_id &id,
    const std::string &requested_name )
{
    validate_faction_name( requested_name );
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
    const std::string before =
        entry->get_name();
    entry->set_name( requested_name );
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->get_name();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_faction_known(
    sol::this_state lua, const script_game_id &id,
    const bool known )
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
    const bool before = entry->known_by_u;
    entry->known_by_u = known;
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->known_by_u;
    value["changed"] =
        before != entry->known_by_u;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct reputation_deltas {
    std::optional<int> likes;
    std::optional<int> respects;
    std::optional<int> trusts;
};

reputation_deltas read_reputation_deltas(
    const sol::table &requested )
{
    reputation_deltas result;
    for( const auto &pair : requested ) {
        if( pair.first.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "game.factions.modify_reputation option keys must be strings" );
        }
        const std::string key =
            pair.first.as<std::string>();
        if( key != "likes" &&
            key != "respects" &&
            key != "trusts" ) {
            throw std::invalid_argument(
                "game.factions.modify_reputation received unknown option '" +
                key + "'" );
        }
        if( !pair.second.is<int>() ) {
            throw std::invalid_argument(
                "game.factions.modify_reputation option '" +
                key + "' must be an integer" );
        }
        const int delta =
            pair.second.as<int>();
        if( delta < -maximum_reputation_delta ||
            delta > maximum_reputation_delta ) {
            throw std::invalid_argument(
                "game.factions.modify_reputation option '" +
                key +
                "' must be within -1000000..1000000" );
        }
        if( key == "likes" ) {
            result.likes = delta;
        } else if( key == "respects" ) {
            result.respects = delta;
        } else {
            result.trusts = delta;
        }
    }
    if( !result.likes &&
        !result.respects &&
        !result.trusts ) {
        throw std::invalid_argument(
            "game.factions.modify_reputation requires at least one delta" );
    }
    return result;
}

int adjusted_integer(
    const int current, const int delta,
    const int minimum =
        std::numeric_limits<int>::min() )
{
    const std::int64_t adjusted =
        static_cast<std::int64_t>( current ) +
        static_cast<std::int64_t>( delta );
    return static_cast<int>(
               std::clamp<std::int64_t>(
                   adjusted, minimum,
                   std::numeric_limits<int>::max() ) );
}

sol::table modify_faction_reputation(
    sol::this_state lua, const script_game_id &id,
    const sol::table &requested )
{
    const reputation_deltas deltas =
        read_reputation_deltas( requested );
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
    sol::table before =
        snapshot_reputation(
            state, *entry );
    if( deltas.likes ) {
        entry->likes_u =
            adjusted_integer(
                entry->likes_u,
                *deltas.likes );
    }
    if( deltas.respects ) {
        entry->respects_u =
            adjusted_integer(
                entry->respects_u,
                *deltas.respects );
    }
    if( deltas.trusts ) {
        entry->trusts_u =
            adjusted_integer(
                entry->trusts_u,
                *deltas.trusts );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_reputation(
            state, *entry );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct resource_deltas {
    std::optional<int> size;
    std::optional<int> power;
    std::optional<int> wealth;
};

resource_deltas read_resource_deltas(
    const sol::table &requested )
{
    resource_deltas result;
    for( const auto &pair : requested ) {
        if( pair.first.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "game.factions.modify_resources option keys must be strings" );
        }
        const std::string key =
            pair.first.as<std::string>();
        if( key != "size" &&
            key != "power" &&
            key != "wealth" ) {
            throw std::invalid_argument(
                "game.factions.modify_resources received unknown option '" +
                key + "'" );
        }
        if( !pair.second.is<int>() ) {
            throw std::invalid_argument(
                "game.factions.modify_resources option '" +
                key + "' must be an integer" );
        }
        const int delta =
            pair.second.as<int>();
        if( delta < -maximum_resource_delta ||
            delta > maximum_resource_delta ) {
            throw std::invalid_argument(
                "game.factions.modify_resources option '" +
                key +
                "' must be within -1000000000..1000000000" );
        }
        if( key == "size" ) {
            result.size = delta;
        } else if( key == "power" ) {
            result.power = delta;
        } else {
            result.wealth = delta;
        }
    }
    if( !result.size &&
        !result.power &&
        !result.wealth ) {
        throw std::invalid_argument(
            "game.factions.modify_resources requires at least one delta" );
    }
    return result;
}

sol::table modify_faction_resources(
    sol::this_state lua, const script_game_id &id,
    const sol::table &requested )
{
    const resource_deltas deltas =
        read_resource_deltas( requested );
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
    sol::table before =
        snapshot_resources(
            state, *entry );
    if( deltas.size ) {
        entry->size =
            adjusted_integer(
                entry->size,
                *deltas.size, 0 );
    }
    if( deltas.power ) {
        entry->power =
            adjusted_integer(
                entry->power,
                *deltas.power, 0 );
    }
    if( deltas.wealth ) {
        entry->wealth =
            adjusted_integer(
                entry->wealth,
                *deltas.wealth, 0 );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_resources(
            state, *entry );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table modify_faction_food(
    sol::this_state lua, const script_game_id &id,
    const int requested_kcal )
{
    if( requested_kcal <
        -maximum_food_delta_kcal ||
        requested_kcal >
        maximum_food_delta_kcal ) {
        throw std::invalid_argument(
            "game.factions.modify_food kcal must be within "
            "-1000000000..1000000000" );
    }
    if( requested_kcal == 0 ) {
        throw std::invalid_argument(
            "game.factions.modify_food kcal cannot be zero" );
    }
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
    const int before =
        entry->food_supply().kcal();
    if( requested_kcal > 0 ) {
        nutrients added;
        added.calories =
            static_cast<std::int64_t>(
                requested_kcal ) * 1000;
        entry->add_to_food_supply( {
            { calendar::turn_zero, added }
        } );
    } else {
        const int removable =
            std::min(
                before, -requested_kcal );
        if( removable > 0 ) {
            nutrients consumed;
            consumed.calories =
                static_cast<std::int64_t>(
                    removable ) * 1000;
            entry->consume_food_supply(
                consumed );
        }
    }
    const int after =
        entry->food_supply().kcal();
    sol::table value = state.create_table();
    value["requested"] = requested_kcal;
    value["applied"] = after - before;
    value["before"] = before;
    value["after"] = after;
    value["clamped"] =
        after - before != requested_kcal;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct policy_update {
    std::optional<bool> consumes_food;
    std::optional<std::string> stealing;
};

policy_update read_policy_update(
    const sol::table &requested )
{
    policy_update result;
    for( const auto &pair : requested ) {
        if( pair.first.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "game.factions.set_policy option keys must be strings" );
        }
        const std::string key =
            pair.first.as<std::string>();
        if( key == "consumes_food" ) {
            if( !pair.second.is<bool>() ) {
                throw std::invalid_argument(
                    "game.factions.set_policy option "
                    "'consumes_food' must be a boolean" );
            }
            result.consumes_food =
                pair.second.as<bool>();
        } else if( key == "stealing" ) {
            if( !pair.second.is<std::string>() ) {
                throw std::invalid_argument(
                    "game.factions.set_policy option "
                    "'stealing' must be a string" );
            }
            const std::string value =
                pair.second.as<std::string>();
            if( value != "ask" &&
                value != "always" &&
                value != "never" ) {
                throw std::invalid_argument(
                    "game.factions.set_policy option "
                    "'stealing' must be ask, always, or never" );
            }
            result.stealing = value;
        } else {
            throw std::invalid_argument(
                "game.factions.set_policy received unknown option '" +
                key + "'" );
        }
    }
    if( !result.consumes_food &&
        !result.stealing ) {
        throw std::invalid_argument(
            "game.factions.set_policy requires at least one option" );
    }
    return result;
}

sol::table set_faction_policy(
    sol::this_state lua, const script_game_id &id,
    const sol::table &requested )
{
    const policy_update update =
        read_policy_update( requested );
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
    sol::table before =
        snapshot_policy( state, *entry );
    if( update.consumes_food ) {
        entry->consumes_food =
            *update.consumes_food;
    }
    if( update.stealing ) {
        if( *update.stealing == "ask" ) {
            entry->steal_persist =
                std::nullopt;
        } else {
            entry->steal_persist =
                *update.stealing == "always";
        }
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] =
        snapshot_policy( state, *entry );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

std::optional<npc_factions::relationship>
parse_relationship_flag( const std::string &key )
{
    if( key == "kill_on_sight" ) {
        return npc_factions::relationship::kill_on_sight;
    }
    if( key == "watch_your_back" ) {
        return npc_factions::relationship::watch_your_back;
    }
    if( key == "share_my_stuff" ) {
        return npc_factions::relationship::share_my_stuff;
    }
    if( key == "share_public_goods" ) {
        return npc_factions::relationship::share_public_goods;
    }
    if( key == "guard_your_stuff" ) {
        return npc_factions::relationship::guard_your_stuff;
    }
    if( key == "lets_you_in" ) {
        return npc_factions::relationship::lets_you_in;
    }
    if( key == "defend_your_space" ) {
        return npc_factions::relationship::defend_your_space;
    }
    if( key == "knows_your_voice" ) {
        return npc_factions::relationship::knows_your_voice;
    }
    return std::nullopt;
}

using relationship_updates =
    std::vector<std::pair<
        npc_factions::relationship, bool>>;

relationship_updates read_relationship_updates(
    const sol::table &requested )
{
    relationship_updates result;
    for( const auto &pair : requested ) {
        if( pair.first.get_type() !=
            sol::type::string ) {
            throw std::invalid_argument(
                "game.factions.set_relationship option keys must be strings" );
        }
        const std::string key =
            pair.first.as<std::string>();
        const std::optional<
        npc_factions::relationship> flag =
            parse_relationship_flag( key );
        if( !flag ) {
            throw std::invalid_argument(
                "game.factions.set_relationship received unknown option '" +
                key + "'" );
        }
        if( !pair.second.is<bool>() ) {
            throw std::invalid_argument(
                "game.factions.set_relationship option '" +
                key + "' must be a boolean" );
        }
        result.emplace_back(
            *flag, pair.second.as<bool>() );
    }
    if( result.empty() ) {
        throw std::invalid_argument(
            "game.factions.set_relationship requires at least one option" );
    }
    return result;
}

sol::table set_faction_relationship(
    sol::this_state lua, const script_game_id &id,
    const script_game_id &target,
    const sol::table &requested )
{
    require_faction_id( target );
    const relationship_updates updates =
        read_relationship_updates( requested );
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
    if( resolve_faction( target ) == nullptr ) {
        return make_game_error_result(
        state, {
            "target_not_found",
            "The target faction does not exist"
        } );
    }
    const auto found =
        entry->relations.find( target.value() );
    const bool was_defined =
        found != entry->relations.end();
    relationship_bits before;
    if( was_defined ) {
        before = found->second;
    }
    relationship_bits after = before;
    for( const auto &update : updates ) {
        after.set(
            static_cast<std::size_t>(
                update.first ),
            update.second );
    }
    entry->relations[target.value()] = after;
    sol::table before_value =
        snapshot_relationship(
            state, target.value(), before );
    before_value["defined"] = was_defined;
    sol::table after_value =
        snapshot_relationship(
            state, target.value(), after );
    after_value["defined"] = true;
    sol::table value = state.create_table();
    value["before"] =
        std::move( before_value );
    value["after"] =
        std::move( after_value );
    value["changed"] =
        !was_defined || before != after;
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
    factions.set_function(
        "rename",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id,
    const std::string &name ) {
        require_write();
        return rename_faction(
                   lua_state, id, name );
    } );
    factions.set_function(
        "set_known",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id, const bool known ) {
        require_write();
        return set_faction_known(
                   lua_state, id, known );
    } );
    factions.set_function(
        "modify_reputation",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id,
    const sol::table &deltas ) {
        require_write();
        return modify_faction_reputation(
                   lua_state, id, deltas );
    } );
    factions.set_function(
        "modify_resources",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id,
    const sol::table &deltas ) {
        require_write();
        return modify_faction_resources(
                   lua_state, id, deltas );
    } );
    factions.set_function(
        "modify_food",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id, const int kcal ) {
        require_write();
        return modify_faction_food(
                   lua_state, id, kcal );
    } );
    factions.set_function(
        "set_policy",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id,
    const sol::table &options ) {
        require_write();
        return set_faction_policy(
                   lua_state, id, options );
    } );
    factions.set_function(
        "set_relationship",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id,
    const script_game_id & target,
    const sol::table &options ) {
        require_write();
        return set_faction_relationship(
                   lua_state, id, target, options );
    } );
    game["factions"] = std::move( factions );
}

} // namespace cata::lua_ui
