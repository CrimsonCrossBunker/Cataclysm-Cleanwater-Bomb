#if CATA_ENABLE_LUA_UI

#include "catalua_ui_npcs.h"
#include "catalua_ui_npc_services.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "auto_pickup.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "catalua_ui_missions.h"
#include "coordinates.h"
#include "effect.h"
#include "enum_conversions.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_location.h"
#include "line.h"
#include "map.h"
#include "mission.h"
#include "mission_companion.h"
#include "npc.h"
#include "npc_class.h"
#include "npctalk.h"
#include "npctalk_rules.h"
#include "overmapbuffer.h"
#include "talker_npc.h"

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
constexpr std::size_t maximum_npc_topic_bytes = 256;
constexpr std::size_t maximum_npc_role_bytes = 256;
constexpr int maximum_opinion_delta = 1000000;
constexpr int maximum_npc_role_radius = 1000;

const faction_id faction_no_faction( "no_faction" );
const faction_id faction_your_followers( "your_followers" );
const efftype_id effect_asked_for_item( "asked_for_item" );
const efftype_id effect_asked_personal_info( "asked_personal_info" );
const efftype_id effect_asked_to_follow( "asked_to_follow" );
const efftype_id effect_asked_to_lead( "asked_to_lead" );
const efftype_id effect_asked_to_train( "asked_to_train" );

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
    npc &entry, const game_handle_runtime &runtime_generation,
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
    const game_handle &handle, const game_handle_runtime &runtime_generation,
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

template<typename Mapping, typename Value>
std::string reverse_string_lookup( const Mapping &mapping, const Value &value )
{
    for( const auto &entry : mapping ) {
        if( entry.second == value ) {
            return entry.first;
        }
    }
    return std::string();
}

sol::table snapshot_ai_rules( sol::state_view lua, const npc &entry )
{
    const npc_follower_rules &rules = entry.rules;
    sol::table result = lua.create_table();
    result["aim"] = reverse_string_lookup( aim_rule_strs, rules.aim );
    result["engagement"] =
        reverse_string_lookup( combat_engagement_strs, rules.engagement );
    result["cbm_recharge"] =
        reverse_string_lookup( cbm_recharge_strs, rules.cbm_recharge );
    result["cbm_reserve"] =
        reverse_string_lookup( cbm_reserve_strs, rules.cbm_reserve );
    sol::table allies = lua.create_table();
    sol::table base_allies = lua.create_table();
    sol::table overrides = lua.create_table();
    std::size_t effective_index = 0;
    std::size_t base_index = 0;
    for( const auto &rule_entry : ally_rule_strs ) {
        if( rules.has_flag( rule_entry.second.rule ) ) {
            allies[++effective_index] = rule_entry.first;
        }
        if( rules.has_flag( rule_entry.second.rule, false ) ) {
            base_allies[++base_index] = rule_entry.first;
        }
        if( rules.has_override_enable( rule_entry.second.rule ) ) {
            overrides[rule_entry.first] =
                rules.has_override( rule_entry.second.rule );
        }
    }
    result["allies"] = std::move( allies );
    result["base_allies"] = std::move( base_allies );
    result["overrides"] = std::move( overrides );
    result["pickup_whitelist"] = !rules.pickup_whitelist->empty();
    return result;
}

template<typename Mapping>
sol::table npc_rule_names( sol::state_view lua, const Mapping &mapping )
{
    std::vector<std::string> names;
    names.reserve( mapping.size() );
    for( const auto &rule : mapping ) {
        names.push_back( rule.first );
    }
    std::sort( names.begin(), names.end() );
    sol::table result = lua.create_table(
                            static_cast<int>( names.size() ), 0 );
    for( std::size_t index = 0; index < names.size(); ++index ) {
        result[index + 1] = names[index];
    }
    return result;
}

sol::table npc_ai_rule_catalog( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["aim"] = npc_rule_names( state, aim_rule_strs );
    result["engagement"] = npc_rule_names(
                               state, combat_engagement_strs );
    result["cbm_recharge"] = npc_rule_names(
                                 state, cbm_recharge_strs );
    result["cbm_reserve"] = npc_rule_names(
                                state, cbm_reserve_strs );
    result["allies"] = npc_rule_names( state, ally_rule_strs );
    return result;
}

sol::table snapshot_companion_assignment(
    sol::state_view lua, const npc &entry )
{
    const npc_companion_mission companion =
        entry.get_companion_mission();
    sol::table result = lua.create_table();
    result["assigned"] = entry.has_companion_mission();
    result["source_role"] =
        entry.companion_mission_role_id;
    result["role"] = companion.role_id;
    result["kind"] =
        io::enum_to_string( companion.miss_id.id );
    result["parameters"] =
        companion.miss_id.parameters;
    if( companion.position == tripoint_abs_omt::invalid ) {
        result["position"] = sol::nil;
    } else {
        result["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::overmap_terrain,
                companion.position.raw() );
    }
    if( companion.destination ) {
        result["destination"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::overmap_terrain,
                companion.destination->raw() );
    } else {
        result["destination"] = sol::nil;
    }
    result["departure_time"] =
        script_time_point::from_native(
            entry.companion_mission_time );
    result["return_time"] =
        script_time_point::from_native(
            entry.companion_mission_time_ret );
    result["return_due"] =
        entry.has_companion_mission() &&
        entry.companion_mission_time_ret !=
        calendar::before_time_starts &&
        entry.companion_mission_time_ret <= calendar::turn;
    result["exertion"] =
        entry.companion_mission_exertion;
    result["travel_time"] =
        script_time_duration::from_native(
            entry.companion_mission_travel_time );
    result["point_count"] =
        entry.companion_mission_points.size();
    result["inventory_stacks"] =
        entry.companion_mission_inv.size();
    return result;
}

sol::table snapshot_npc(
    sol::state_view lua, npc &entry,
    const game_handle_runtime &runtime_generation,
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
    result["restock_turn"] =
        to_turn<std::int64_t>( entry.restock_time() );
    result["faction_representative"] =
        entry.faction_representative;
    result["first_topic"] =
        entry.chatbin.first_topic;
    result["companion_role"] =
        entry.companion_mission_role_id;
    result["companion_assignment"] =
        snapshot_companion_assignment( lua, entry );
    result["has_assigned_camp"] =
        entry.assigned_camp.has_value();
    if( entry.assigned_camp ) {
        result["assigned_camp"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::overmap_terrain,
                entry.assigned_camp->raw() );
    } else {
        result["assigned_camp"] = sol::nil;
    }
    sol::table dialogue_missions = lua.create_table();
    dialogue_missions["available_count"] =
        entry.chatbin.missions.size();
    dialogue_missions["assigned_count"] =
        entry.chatbin.missions_assigned.size();
    mission *selected_mission =
        entry.chatbin.mission_selected;
    if( selected_mission == nullptr ) {
        dialogue_missions["selected"] = sol::nil;
    } else {
        sol::table selected = lua.create_table();
        selected["token"] = mission_token(
                                selected_mission->get_id(),
                                runtime_generation,
                                world_generation );
        selected["uid"] = selected_mission->get_id();
        selected["id"] = script_game_id(
                              "mission",
                              selected_mission->mission_id().str() );
        selected["assigned"] =
            selected_mission->is_assigned();
        selected["in_progress"] =
            selected_mission->in_progress();
        selected["failed"] =
            selected_mission->has_failed();
        selected["has_generic_rewards"] =
            selected_mission->has_generic_rewards();
        dialogue_missions["selected"] =
            std::move( selected );
    }
    result["dialogue_missions"] =
        std::move( dialogue_missions );
    result["travelling"] =
        !entry.omt_path.empty();
    result["ai_rules"] =
        snapshot_ai_rules( lua, entry );
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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

sol::table find_unique_npc(
    sol::this_state lua,
    const std::string &unique_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.npcs.find_unique";
    if( unique_id.empty() ||
        unique_id.size() > maximum_npc_name_bytes ||
        unique_id.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a unique id containing 1..256 bytes" );
    }
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    if( !g->unique_npc_exists( unique_id ) ) {
        return make_game_error_result(
        state, {
            "not_found", "No unique NPC with that id exists"
        } );
    }
    npc *entry =
        g->find_npc_by_unique_id( unique_id );
    if( entry == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The unique NPC registry entry no longer references a living NPC"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_npc(
                       state, *entry,
                       runtime_generation,
                       world_generation ) ) );
}

std::size_t count_npc_allies( const bool global )
{
    if( !global ) {
        return g == nullptr ? 0 : g->allies().size();
    }
    const auto all_npcs = overmap_buffer.get_overmap_npcs();
    return static_cast<std::size_t>( std::count_if(
                                        all_npcs.begin(), all_npcs.end(),
    []( const auto & entry ) {
        return entry && entry->is_player_ally() &&
               !entry->hallucination && !entry->is_dead();
    } ) );
}

sol::table has_npc_role_nearby(
    sol::this_state lua, const game_handle &origin_handle,
    const std::string &role,
    const sol::optional<int> &requested_radius,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.npcs.has_role_nearby";
    if( role.size() > maximum_npc_role_bytes ||
        role.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " role must be a bounded string" );
    }
    const int radius = requested_radius.value_or( 48 );
    if( radius < 0 || radius > maximum_npc_role_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " radius must be within 0..1000" );
    }
    sol::state_view state( lua );
    const native_handle_result<Creature> resolved =
        origin_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    const Creature &origin = *resolved.value;
    const std::vector<npc *> matches = g->get_npcs_if(
    [&]( const npc & candidate ) {
        return candidate.posz() == origin.posz() &&
               candidate.companion_mission_role_id == role &&
               rl_dist( origin.pos_abs(), candidate.pos_abs() ) <= radius;
    } );
    return make_game_value_result(
               state, sol::make_object(
                   state, !matches.empty() ) );
}

sol::table has_npc_follower_nearby(
    sol::this_state lua, const game_handle &origin_handle,
    const script_game_id &requested_class,
    const sol::optional<int> &requested_radius,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.npcs.has_follower_nearby";
    require_npc_class_id( requested_class, api_name );
    const int radius = requested_radius.value_or( 4 );
    if( radius < 0 || radius > maximum_npc_role_radius ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " radius must be within 0..1000" );
    }
    sol::state_view state( lua );
    const native_handle_result<Creature> resolved =
        origin_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    const Creature &origin = *resolved.value;
    const npc_class_id class_id( requested_class.value() );
    const std::set<character_id> followers =
        g->get_follower_list();
    map &here = get_map();
    const std::vector<npc *> matches = g->get_npcs_if(
    [&]( const npc & candidate ) {
        return candidate.myclass == class_id &&
               followers.count( candidate.getID() ) > 0 &&
               candidate.is_following() &&
               candidate.posz() == origin.posz() &&
               rl_dist( candidate.pos_abs(), origin.pos_abs() ) <= radius &&
               here.clear_path(
                   candidate.pos_bub(), origin.pos_bub(),
                   radius + 1, 0, 100 );
    } );
    return make_game_value_result(
               state, sol::make_object(
                   state, !matches.empty() ) );
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
    const game_handle_runtime &runtime_generation,
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
        { "null", NPCATT_NULL },
        { "NPCATT_TALK", NPCATT_TALK },
        { "talk", NPCATT_TALK },
        { "NPCATT_FOLLOW", NPCATT_FOLLOW },
        { "follow", NPCATT_FOLLOW },
        { "NPCATT_LEAD", NPCATT_LEAD },
        { "lead", NPCATT_LEAD },
        { "NPCATT_WAIT", NPCATT_WAIT },
        { "wait", NPCATT_WAIT },
        { "NPCATT_MUG", NPCATT_MUG },
        { "mug", NPCATT_MUG },
        { "NPCATT_WAIT_FOR_LEAVE", NPCATT_WAIT_FOR_LEAVE },
        { "wait_for_leave", NPCATT_WAIT_FOR_LEAVE },
        { "NPCATT_KILL", NPCATT_KILL },
        { "kill", NPCATT_KILL },
        { "NPCATT_FLEE", NPCATT_FLEE },
        { "flee", NPCATT_FLEE },
        { "NPCATT_HEAL", NPCATT_HEAL },
        { "heal", NPCATT_HEAL },
        { "NPCATT_ACTIVITY", NPCATT_ACTIVITY },
        { "activity", NPCATT_ACTIVITY },
        { "NPCATT_FLEE_TEMP", NPCATT_FLEE_TEMP },
        { "flee_temp", NPCATT_FLEE_TEMP },
        { "NPCATT_RECOVER_GOODS", NPCATT_RECOVER_GOODS },
        { "recover_goods", NPCATT_RECOVER_GOODS }
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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

sol::table add_npc_debt(
    sol::this_state lua, const game_handle &handle, const int amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.npcs.add_debt";
    if( amount < -maximum_opinion_delta ||
        amount > maximum_opinion_delta ) {
        throw std::invalid_argument(
            "game.npcs.add_debt amount must be within -1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = entry->op_of_u.owed;
    const std::int64_t adjusted =
        static_cast<std::int64_t>( before ) + amount;
    if( adjusted < std::numeric_limits<int>::min() ||
        adjusted > std::numeric_limits<int>::max() ) {
        return make_game_error_result( state, {
            "numeric_overflow",
            std::string( api_name ) + " would overflow native debt"
        } );
    }
    entry->op_of_u.owed = static_cast<int>( adjusted );
    sol::table value = state.create_table();
    value["amount"] = amount;
    value["before"] = before;
    value["after"] = entry->op_of_u.owed;
    value["changed"] = before != entry->op_of_u.owed;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void require_npc_domain_id(
    const script_game_id &id, const std::string_view kind,
    const std::string_view api_name )
{
    if( id.kind() != kind || !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " requires a valid GameId<" +
            std::string( kind ) + ">" );
    }
}

sol::table set_npc_class(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_class,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.npcs.set_class";
    require_npc_domain_id( requested_class, "npc_class", api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_class_id before = entry->myclass;
    entry->myclass = npc_class_id( requested_class.value() );
    sol::table value = state.create_table();
    value["before"] = script_game_id( "npc_class", before.str() );
    value["after"] = script_game_id( "npc_class", entry->myclass.str() );
    value["changed"] = before != entry->myclass;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_faction(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_faction,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.npcs.set_faction";
    require_npc_domain_id( requested_faction, "faction", api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const faction_id before = entry->get_fac_id();
    entry->set_fac( faction_id( requested_faction.value() ) );
    const faction_id after = entry->get_fac_id();
    sol::table value = state.create_table();
    value["before"] = script_game_id( "faction", before.str() );
    value["after"] = script_game_id( "faction", after.str() );
    value["changed"] = before != after;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

void validate_npc_topic( const std::string &topic )
{
    if( topic.empty() || topic.size() > maximum_npc_topic_bytes ||
        std::any_of( topic.begin(), topic.end(), []( const unsigned char ch ) {
        return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            "game.npcs.set_first_topic requires 1 to 256 non-control bytes" );
    }
}

void validate_dialogue_topic( const std::string &topic )
{
    if( topic.empty() || topic.size() > maximum_npc_topic_bytes ||
        std::any_of( topic.begin(), topic.end(), []( const unsigned char ch ) {
        return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            "game.npcs.open_dialogue topic requires 1 to 256 non-control bytes" );
    }
    if( get_talk_topic( topic ) == nullptr ) {
        throw std::invalid_argument(
            "game.npcs.open_dialogue received an unknown dialogue topic" );
    }
}

sol::table set_npc_first_topic(
    sol::this_state lua, const game_handle &handle,
    const std::string &requested_topic,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_npc_topic( requested_topic );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before = entry->chatbin.first_topic;
    entry->chatbin.first_topic = requested_topic;
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->chatbin.first_topic;
    value["changed"] = before != entry->chatbin.first_topic;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_radio_representative(
    sol::this_state lua, const game_handle &handle, const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool before = entry->faction_representative;
    entry->faction_representative = enabled;
    if( enabled ) {
        get_avatar().faction_representatives.insert( entry->getID() );
    } else {
        get_avatar().faction_representatives.erase( entry->getID() );
    }
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->faction_representative;
    value["changed"] = before != entry->faction_representative;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_ai_policy(
    sol::this_state lua, const game_handle &handle,
    const std::string &family, const std::string &rule,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = snapshot_ai_rules( state, *entry );
    if( family == "aim" ) {
        const auto found = aim_rule_strs.find( rule );
        if( found == aim_rule_strs.end() ) {
            throw std::invalid_argument(
                "game.npcs.set_ai_policy received an unknown aim rule" );
        }
        entry->rules.aim = found->second;
        entry->invalidate_range_cache();
    } else if( family == "engagement" ) {
        const auto found = combat_engagement_strs.find( rule );
        if( found == combat_engagement_strs.end() ) {
            throw std::invalid_argument(
                "game.npcs.set_ai_policy received an unknown engagement rule" );
        }
        entry->rules.engagement = found->second;
        entry->invalidate_range_cache();
        entry->wield_better_weapon();
    } else if( family == "cbm_recharge" ) {
        const auto found = cbm_recharge_strs.find( rule );
        if( found == cbm_recharge_strs.end() ) {
            throw std::invalid_argument(
                "game.npcs.set_ai_policy received an unknown CBM recharge rule" );
        }
        entry->rules.cbm_recharge = found->second;
    } else if( family == "cbm_reserve" ) {
        const auto found = cbm_reserve_strs.find( rule );
        if( found == cbm_reserve_strs.end() ) {
            throw std::invalid_argument(
                "game.npcs.set_ai_policy received an unknown CBM reserve rule" );
        }
        entry->rules.cbm_reserve = found->second;
    } else {
        throw std::invalid_argument(
            "game.npcs.set_ai_policy family must be aim, engagement, "
            "cbm_recharge, or cbm_reserve" );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_ally_rule(
    sol::this_state lua, const game_handle &handle,
    const std::string &rule, const sol::optional<bool> &requested_enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const auto found = ally_rule_strs.find( rule );
    if( found == ally_rule_strs.end() ) {
        throw std::invalid_argument(
            "game.npcs.set_ally_rule received an unknown ally rule" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const ally_rule native_rule = found->second.rule;
    const bool before = entry->rules.has_flag( native_rule, false );
    const bool enabled = requested_enabled.value_or( !before );
    if( enabled ) {
        entry->rules.set_flag( native_rule );
    } else {
        entry->rules.clear_flag( native_rule );
    }
    entry->invalidate_range_cache();
    entry->wield_better_weapon();
    sol::table value = state.create_table();
    value["rule"] = rule;
    value["before"] = before;
    value["after"] = enabled;
    value["changed"] = before != enabled;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_ally_override(
    sol::this_state lua, const game_handle &handle,
    const std::string &rule, const std::string &state_name,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const auto found = ally_rule_strs.find( rule );
    if( found == ally_rule_strs.end() ) {
        throw std::invalid_argument(
            "game.npcs.set_ally_override received an unknown ally rule" );
    }
    if( state_name != "inherit" && state_name != "allow" &&
        state_name != "deny" ) {
        throw std::invalid_argument(
            "game.npcs.set_ally_override state must be inherit, allow, or deny" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = snapshot_ai_rules( state, *entry );
    const ally_rule native_rule = found->second.rule;
    if( state_name == "inherit" ) {
        entry->rules.disable_override( native_rule );
        entry->rules.clear_override( native_rule );
    } else {
        entry->rules.set_specific_override_state(
            native_rule, state_name == "allow" );
    }
    entry->invalidate_range_cache();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table copy_npc_ai_rules(
    sol::this_state lua, const game_handle &target_handle,
    const game_handle &source_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> target_error;
    npc *target = resolve_npc(
                      target_handle, runtime_generation,
                      world_generation, target_error );
    if( target == nullptr ) {
        return make_game_error_result( state, *target_error );
    }
    std::optional<game_handle_error> source_error;
    npc *source = resolve_npc(
                      source_handle, runtime_generation,
                      world_generation, source_error );
    if( source == nullptr ) {
        return make_game_error_result( state, *source_error );
    }
    sol::table before = snapshot_ai_rules( state, *target );
    target->rules = source->rules;
    target->invalidate_range_cache();
    target->wield_better_weapon();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, *target );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table make_npc_thankful(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_attitude attitude_before = entry->get_attitude();
    const std::string topic_before = entry->chatbin.first_topic;
    const int aggression_before = entry->personality.aggression;
    if( attitude_before == NPCATT_MUG ||
        attitude_before == NPCATT_WAIT_FOR_LEAVE ||
        attitude_before == NPCATT_FLEE || attitude_before == NPCATT_KILL ||
        attitude_before == NPCATT_FLEE_TEMP ) {
        entry->set_attitude( NPCATT_NULL );
    }
    if( entry->chatbin.first_topic != entry->chatbin.talk_friend ) {
        entry->chatbin.first_topic = entry->chatbin.talk_stranger_friendly;
    }
    entry->personality.aggression = std::clamp<int8_t>(
                                        entry->personality.aggression - 1,
                                        NPC_PERSONALITY_MIN,
                                        NPC_PERSONALITY_MAX );
    sol::table value = state.create_table();
    value["attitude_before"] = npc_attitude_id( attitude_before );
    value["attitude_after"] = npc_attitude_id( entry->get_attitude() );
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["aggression_before"] = aggression_before;
    value["aggression_after"] = entry->personality.aggression;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct npc_refusal {
    efftype_id effect;
    time_duration duration;
};

npc_refusal npc_refusal_for( const std::string_view request )
{
    if( request == "follow" ) {
        return { effect_asked_to_follow, 6_hours };
    }
    if( request == "lead" ) {
        return { effect_asked_to_lead, 6_hours };
    }
    if( request == "equipment" ) {
        return { effect_asked_for_item, 1_hours };
    }
    if( request == "training" ) {
        return { effect_asked_to_train, 6_hours };
    }
    if( request == "personal_info" ) {
        return { effect_asked_personal_info, 3_hours };
    }
    throw std::invalid_argument(
        "game.npcs.record_refusal request must be follow, lead, equipment, training, or personal_info" );
}

sol::table record_npc_refusal(
    sol::this_state lua, const game_handle &handle,
    const std::string &request,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const npc_refusal refusal = npc_refusal_for( request );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool already_active = entry->has_effect( refusal.effect );
    entry->add_effect( refusal.effect, refusal.duration );
    sol::table value = state.create_table();
    value["request"] = request;
    value["effect"] = script_game_id(
                          "effect", refusal.effect.str() );
    value["duration"] = script_time_duration::from_native(
                            refusal.duration );
    value["already_active"] = already_active;
    value["active"] = entry->has_effect( refusal.effect );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_npc_relationship_state(
    sol::this_state lua, const game_handle &handle,
    const npc_attitude attitude, const bool reset_stranger_topic,
    const bool non_ally_only,
    const game_handle_runtime &runtime_generation,
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
    const npc_attitude attitude_before = entry->get_attitude();
    const std::string topic_before = entry->chatbin.first_topic;
    const bool blocked_by_ally = non_ally_only && entry->is_player_ally();
    if( !blocked_by_ally ) {
        entry->set_attitude( attitude );
        if( reset_stranger_topic ) {
            entry->chatbin.first_topic =
                entry->chatbin.talk_stranger_neutral;
        }
    }
    sol::table value = state.create_table();
    value["attitude_before"] = npc_attitude_id( attitude_before );
    value["attitude_after"] = npc_attitude_id(
                                  entry->get_attitude() );
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["changed"] =
        attitude_before != entry->get_attitude() ||
        topic_before != entry->chatbin.first_topic;
    value["blocked_by_ally"] = blocked_by_ally;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table join_npc_to_player(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = snapshot_npc(
                            state, *entry, runtime_generation,
                            world_generation );
    const int transferred_cash = entry->cash;
    g->add_npc_follower( entry->getID() );
    entry->set_attitude( NPCATT_FOLLOW );
    entry->set_fac( faction_your_followers );
    get_player_character().cash += transferred_cash;
    entry->cash = 0;
    entry->custom_profession.clear();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_npc(
                         state, *entry, runtime_generation,
                         world_generation );
    value["transferred_cash"] = transferred_cash;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table leave_npc_player(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( g == nullptr || g->faction_manager_ptr == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = snapshot_npc(
                            state, *entry, runtime_generation,
                            world_generation );
    g->remove_npc_follower( entry->getID() );
    const faction_id solo_faction(
        "solo_" + entry->name +
        std::to_string( entry->getID().get_value() ) );
    entry->job.clear_all_priorities();
    faction *created = g->faction_manager_ptr->add_new_faction(
                           entry->name, solo_faction,
                           faction_no_faction );
    entry->set_fac(
        created == nullptr ? faction_no_faction : created->id );
    if( created != nullptr ) {
        created->known_by_u = true;
    }
    entry->chatbin.first_topic =
        entry->chatbin.talk_stranger_neutral;
    entry->set_attitude( NPCATT_NULL );
    entry->set_mission( NPC_MISSION_NULL );
    entry->long_term_goal_action();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_npc(
                         state, *entry, runtime_generation,
                         world_generation );
    value["created_faction"] = created != nullptr;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_guarding(
    sol::this_state lua, const game_handle &handle,
    const bool enabled,
    const game_handle_runtime &runtime_generation,
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
    sol::table before = snapshot_npc(
                            state, *entry, runtime_generation,
                            world_generation );
    if( enabled ) {
        if( !entry->is_player_ally() ) {
            entry->set_mission( NPC_MISSION_GUARD );
            entry->set_omt_destination();
        } else {
            if( entry->has_player_activity() ) {
                entry->revert_after_activity();
            }
            entry->set_attitude( NPCATT_NULL );
            entry->set_mission( NPC_MISSION_GUARD_ALLY );
            entry->chatbin.first_topic = entry->assigned_camp ?
                                         "TALK_FRIEND_GUARD_CAMP" :
                                         entry->chatbin.talk_friend_guard;
            entry->clear_committed_goal();
            entry->set_omt_destination();
        }
    } else if( !entry->is_player_ally() ) {
        entry->set_attitude( NPCATT_NULL );
        entry->set_mission( NPC_MISSION_NULL );
    } else {
        entry->set_attitude( NPCATT_FOLLOW );
        entry->set_mission( NPC_MISSION_NULL );
        if( entry->has_companion_mission() ) {
            entry->reset_companion_mission();
        }
        entry->chatbin.first_topic = entry->chatbin.talk_friend;
        entry->goal = npc::no_goal_point;
        entry->guard_pos = std::nullopt;
        entry->clear_ai_guard_pos();
        entry->clear_committed_goal();
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_npc(
                         state, *entry, runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table make_npc_hostile(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
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
    const npc_attitude before = entry->get_attitude();
    const bool changed = before != NPCATT_KILL;
    if( changed ) {
        get_event_bus().send<event_type::npc_becomes_hostile>(
            entry->getID(), entry->name );
        entry->set_attitude( NPCATT_KILL );
    }
    sol::table value = state.create_table();
    value["before"] = npc_attitude_id( before );
    value["after"] = npc_attitude_id( entry->get_attitude() );
    value["changed"] = changed;
    value["event_emitted"] = changed;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_departure_warning(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
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
    const int before = entry->patience;
    entry->set_attitude( NPCATT_WAIT_FOR_LEAVE );
    entry->patience = 15 - entry->personality.aggression;
    sol::table value = state.create_table();
    value["patience_before"] = before;
    value["patience_after"] = entry->patience;
    value["attitude"] = npc_attitude_id(
                            entry->get_attitude() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table clear_npc_stolen_item_claim(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
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
    const bool had_claim = entry->known_stolen_item != nullptr;
    entry->known_stolen_item = nullptr;
    entry->set_attitude( NPCATT_NULL );
    sol::table value = state.create_table();
    value["cleared"] = had_claim;
    value["attitude"] = npc_attitude_id(
                            entry->get_attitude() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

tripoint_abs_omt require_npc_goal_position(
    const script_tripoint_coord &requested,
    const std::string_view api_name )
{
    if( requested.native_origin() != coords::origin::abs ||
        requested.native_scale() != coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt result( requested.to_native() );
    if( result.z() < -OVERMAP_DEPTH || result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            std::string( api_name ) + " z level is outside world bounds" );
    }
    return result;
}

tripoint_abs_ms require_npc_guard_position(
    const script_tripoint_coord &requested,
    const std::string_view api_name )
{
    if( requested.native_origin() != coords::origin::abs ||
        requested.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    const tripoint_abs_ms result( requested.to_native() );
    if( result.z() < -OVERMAP_DEPTH || result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            std::string( api_name ) + " z level is outside world bounds" );
    }
    return result;
}

sol::table plan_npc_travel(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_goal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.npcs.plan_travel";
    const tripoint_abs_omt destination = require_npc_goal_position(
            requested_goal, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const npc *entry = resolve_npc(
                           handle, runtime_generation,
                           world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = state.create_table();
    value["origin"] = script_tripoint_coord::from_native(
                          coords::origin::abs,
                          coords::scale::overmap_terrain,
                          entry->pos_abs_omt().raw() );
    value["destination"] = requested_goal;
    if( destination == tripoint_abs_omt::zero || destination.is_invalid() ) {
        value["reachable"] = false;
        value["reason"] = "invalid_target";
        value["path_length"] = 0;
        value["eta"] = script_time_duration::from_native( 0_turns );
        value["eta_min"] = script_time_duration::from_native( 0_turns );
        value["eta_max"] = script_time_duration::from_native( 0_turns );
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    const auto path = overmap_buffer.get_travel_path(
                          entry->pos_abs_omt(), destination,
                          overmap_path_params::for_npc() ).points;
    if( path.empty() ) {
        value["reachable"] = false;
        value["reason"] = "unreachable";
        value["path_length"] = 0;
        value["eta"] = script_time_duration::from_native( 0_turns );
        value["eta_min"] = script_time_duration::from_native( 0_turns );
        value["eta_max"] = script_time_duration::from_native( 0_turns );
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    const int tiles = static_cast<int>(
                          std::min<std::size_t>(
                              path.size(),
                              static_cast<std::size_t>(
                                  std::numeric_limits<int>::max() ) ) );
    const time_duration eta = time_between_npc_OM_moves * tiles;
    value["reachable"] = true;
    value["reason"] = sol::nil;
    value["path_length"] = path.size();
    value["eta"] = script_time_duration::from_native( eta );
    value["eta_min"] = script_time_duration::from_native( eta * 0.8 );
    value["eta_max"] = script_time_duration::from_native( eta * 1.2 );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_goal(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_goal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.npcs.set_goal";
    const tripoint_abs_omt destination = require_npc_goal_position(
            requested_goal, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const auto path = overmap_buffer.get_travel_path(
                          entry->pos_abs_omt(), destination,
                          overmap_path_params::for_npc() ).points;
    const bool invalid = destination == tripoint_abs_omt() ||
                         destination.is_invalid() || path.empty();
    if( invalid ) {
        entry->goal = npc::no_goal_point;
        entry->omt_path.clear();
        sol::table value = state.create_table();
        value["accepted"] = false;
        value["changed"] = false;
        value["reason"] = path.empty() ? "unreachable" : "invalid_target";
        value["path_length"] = 0;
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    const bool changed = entry->goal != destination ||
                         entry->mission != NPC_MISSION_TRAVELLING;
    entry->goal = destination;
    entry->omt_path = path;
    entry->set_mission( NPC_MISSION_TRAVELLING );
    entry->guard_pos = std::nullopt;
    entry->set_attitude( NPCATT_NULL );
    sol::table value = state.create_table();
    value["accepted"] = true;
    value["changed"] = changed;
    value["goal"] = script_tripoint_coord::from_native(
                         coords::origin::abs,
                         coords::scale::overmap_terrain,
                         entry->goal.raw() );
    value["path_length"] = entry->omt_path.size();
    value["mission"] = io::enum_to_string( entry->mission );
    value["attitude"] = npc_attitude_id( entry->get_attitude() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_leading_goal(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_goal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.npcs.lead_to";
    const tripoint_abs_omt destination =
        require_npc_goal_position( requested_goal, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const tripoint_abs_omt before = entry->goal;
    entry->goal = destination;
    entry->set_attitude( NPCATT_LEAD );
    sol::table value = state.create_table();
    value["changed"] = before != destination;
    value["goal"] = requested_goal;
    value["attitude"] = npc_attitude_id(
                            entry->get_attitude() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_guard_position(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.npcs.set_guard_position";
    const tripoint_abs_ms destination = require_npc_guard_position(
                                            requested_position, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<tripoint_abs_ms> before = entry->get_guard_post();
    entry->set_guard_pos( destination );
    sol::table value = state.create_table();
    value["changed"] = !before || *before != destination;
    value["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::map_square,
                             destination.raw() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

void require_companion_role(
    const std::string &role, const std::string_view api_name,
    const bool allow_empty )
{
    if( ( role.empty() && !allow_empty ) ||
        role.size() > maximum_npc_role_bytes ||
        role.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " role must be a bounded non-NUL string" );
    }
}

bool is_native_companion_menu_role( const std::string &role )
{
    static const std::set<std::string> roles = {
        "SCAVENGER",
        "COMMUNE CROPS",
        "FOREMAN",
        "REFUGEE MERCHANT",
        "PLANT FIELD",
        "HARVEST FIELD"
    };
    return roles.count( role ) > 0;
}

sol::table get_npc_companion_state(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const npc *entry = resolve_npc(
                           handle, runtime_generation,
                           world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   snapshot_companion_assignment(
                       state, *entry ) ) );
}

sol::table set_npc_companion_role(
    sol::this_state lua, const game_handle &handle,
    const std::string &role,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.npcs.set_companion_role";
    require_companion_role( role, api_name, true );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before =
        entry->companion_mission_role_id;
    entry->companion_mission_role_id = role;
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = role;
    value["changed"] = before != role;
    value["native_menu_role"] =
        is_native_companion_menu_role( role );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_companion_missions(
    sol::this_state lua, const game_handle &handle,
    const std::string &role,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.npcs.open_companion_missions";
    require_companion_role( role, api_name, false );
    if( !is_native_companion_menu_role( role ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " role is not supported by the native companion mission menu" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before_role =
        entry->companion_mission_role_id;
    entry->companion_mission_role_id = role;
    talk_function::companion_mission( *entry );
    sol::table value = state.create_table();
    value["role_before"] = before_role;
    value["role_after"] =
        entry->companion_mission_role_id;
    value["state"] =
        snapshot_companion_assignment( state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

item *find_character_item_by_uid(
    Character &character, const std::int64_t uid )
{
    item *found = nullptr;
    character.visit_items(
    [&]( item *entry, item * ) {
        if( entry->uid().get_value() == uid ) {
            found = entry;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    return found;
}

sol::table offer_item_to_npc(
    sol::this_state lua, const game_handle &npc_handle,
    const game_handle &item_handle, const bool use_item,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *recipient = resolve_npc(
                         npc_handle, runtime_generation,
                         world_generation, error );
    if( recipient == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const native_handle_result<item> resolved_item =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved_item ) {
        return make_game_error_result(
                   state, *resolved_item.error );
    }
    avatar &giver = get_avatar();
    item *offered = resolved_item.value;
    if( !giver.has_item( *offered ) ) {
        return make_game_error_result( state, {
            "not_owned",
            "game.npcs.offer_item requires an item carried by the avatar"
        } );
    }
    const std::int64_t uid = offered->uid().get_value();
    const int charges_before = offered->charges;
    const int damage_before = offered->damage();
    const int moves_before = giver.get_moves();
    talker_npc recipient_talker( recipient );
    const std::string reason = recipient_talker.give_item_to(
                                   item_location( giver, offered ),
                                   use_item );
    item *recipient_item = find_character_item_by_uid(
                               *recipient, uid );
    item *giver_item = find_character_item_by_uid(
                           giver, uid );

    std::string outcome = "retained";
    if( recipient_item != nullptr ) {
        outcome = "transferred";
    } else if( giver_item == nullptr ) {
        outcome = use_item ? "consumed" : "removed";
    } else if( giver_item->charges != charges_before ||
               giver_item->damage() != damage_before ) {
        outcome = "used_partial";
    }
    sol::table value = state.create_table();
    value["accepted"] = outcome != "retained";
    value["outcome"] = outcome;
    value["reason"] = reason;
    value["uid"] = uid;
    value["requested_use"] = use_item;
    value["avatar_moves_spent"] =
        moves_before - giver.get_moves();
    value["recipient_has_item"] =
        recipient_item != nullptr;
    value["avatar_has_item"] =
        giver_item != nullptr;
    if( giver_item != nullptr ) {
        value["remaining_charges"] =
            giver_item->charges;
    } else if( recipient_item != nullptr ) {
        value["remaining_charges"] =
            recipient_item->charges;
    } else {
        value["remaining_charges"] = 0;
    }
    recipient->invalidate_crafting_inventory();
    giver.invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_dialogue(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<std::string> &topic,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &invalidate_handles )
{
    sol::state_view state( lua );
    if( topic ) {
        validate_dialogue_topic( *topic );
    }
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &player = get_avatar();
    const std::int64_t avatar_id_before =
        player.getID().get_value();
    const std::int64_t npc_id =
        entry->getID().get_value();
    const std::string npc_name = entry->get_name();
    player.talk_to(
        get_talker_for( entry ), false, false, false,
        topic.value_or( std::string() ) );
    const std::int64_t avatar_id_after =
        get_avatar().getID().get_value();
    const bool handles_invalidated =
        avatar_id_before != avatar_id_after;
    if( handles_invalidated ) {
        invalidate_handles();
    }
    sol::table value = state.create_table();
    value["completed"] = true;
    value["npc_id"] = npc_id;
    value["npc_name"] = npc_name;
    value["topic"] = topic ?
                       sol::make_object( state, *topic ) :
                       sol::make_object( state, sol::nil );
    value["avatar_id_before"] = avatar_id_before;
    value["avatar_id_after"] = avatar_id_after;
    value["handles_invalidated"] = handles_invalidated;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_rules(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
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
    if( !entry->is_player_ally() ) {
        return make_game_error_result( state, {
            "not_an_ally",
            "game.npcs.open_rules requires an allied NPC"
        } );
    }
    sol::table before = snapshot_ai_rules( state, *entry );
    follower_rules_ui rules_ui;
    rules_ui.draw_follower_rules_ui( entry );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_control_menu(
    sol::this_state lua,
    const std::function<void()> &invalidate_handles )
{
    sol::state_view state( lua );
    avatar &player = get_avatar();
    const std::int64_t avatar_id_before =
        player.getID().get_value();
    player.control_npc_menu();
    const std::int64_t avatar_id_after =
        get_avatar().getID().get_value();
    const bool changed = avatar_id_before != avatar_id_after;
    if( changed ) {
        invalidate_handles();
    }
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["avatar_id_before"] = avatar_id_before;
    value["avatar_id_after"] = avatar_id_after;
    value["handles_invalidated"] = changed;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table take_control_of_npc(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &invalidate_handles,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( !entry->is_player_ally() ) {
        return make_game_error_result( state, {
            "not_an_ally",
            "game.npcs.take_control requires an allied NPC"
        } );
    }
    if( g == nullptr ) {
        return make_game_error_result( state, {
            "world_unavailable",
            "game.npcs.take_control requires an active game world"
        } );
    }
    const std::int64_t controlled_id =
        entry->getID().get_value();
    const std::string controlled_name = entry->get_name();
    get_avatar().control_npc( *entry );

    // control_npc swaps native Character storage and logical identities.
    // Invalidate every pre-swap handle instead of allowing a safe_reference
    // to silently resolve to a different logical character.
    invalidate_handles();
    avatar &player = get_avatar();
    const tripoint_abs_ms position = player.pos_abs();
    const game_handle avatar_handle = game_handle::from_creature(
                                          player, {
        "avatar", player.getID().get_value(),
        position.x(), position.y(), position.z(), {}
    }, current_runtime_generation(), current_world_generation() );
    sol::table value = state.create_table();
    value["avatar"] = avatar_handle;
    value["controlled_id"] = controlled_id;
    value["controlled_name"] = controlled_name;
    value["handles_invalidated"] = true;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_npc_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<void()> invalidate_handles )
{
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
        "find_unique",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const std::string &unique_id ) {
        require_read();
        return find_unique_npc(
                   lua_state, unique_id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "count_allies",
        [require_read]( const sol::optional<bool> &global ) {
        require_read();
        return count_npc_allies( global.value_or( false ) );
    } );
    npcs.set_function(
        "has_role_nearby",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &origin,
            const std::string &role,
            const sol::optional<int> &radius ) {
        require_read();
        return has_npc_role_nearby(
                   lua_state, origin, role, radius,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "has_follower_nearby",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &origin,
            const script_game_id &npc_class,
            const sol::optional<int> &radius ) {
        require_read();
        return has_npc_follower_nearby(
                   lua_state, origin, npc_class, radius,
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
    npcs.set_function(
        "add_debt",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const int amount ) {
        require_write();
        return add_npc_debt(
                   lua_state, handle, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_class",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &npc_class ) {
        require_write();
        return set_npc_class(
                   lua_state, handle, npc_class,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_faction",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &faction ) {
        require_write();
        return set_npc_faction(
                   lua_state, handle, faction,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_first_topic",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &topic ) {
        require_write();
        return set_npc_first_topic(
                   lua_state, handle, topic,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_radio_representative",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const bool enabled ) {
        require_write();
        return set_npc_radio_representative(
                   lua_state, handle, enabled,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "ai_rule_catalog",
        [require_read]( sol::this_state lua_state ) {
        require_read();
        return npc_ai_rule_catalog( lua_state );
    } );
    npcs.set_function(
        "set_ai_policy",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &family, const std::string &rule ) {
        require_write();
        return set_npc_ai_policy(
                   lua_state, handle, family, rule,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_ally_rule",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &rule, const sol::optional<bool> &enabled ) {
        require_write();
        return set_npc_ally_rule(
                   lua_state, handle, rule, enabled,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_ally_override",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &rule, const std::string &state ) {
        require_write();
        return set_npc_ally_override(
                   lua_state, handle, rule, state,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "copy_ai_rules",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &target,
            const game_handle &source ) {
        require_write();
        return copy_npc_ai_rules(
                   lua_state, target, source,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "make_thankful",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return make_npc_thankful(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "record_refusal",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
    const std::string &request ) {
        require_write();
        return record_npc_refusal(
                   lua_state, handle, request,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "follow_temporarily",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_FOLLOW, false, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "stop_temporary_following",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_NULL, false, true,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "make_neutral",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_NULL, true, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "start_fleeing",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_FLEE, false, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "start_mugging",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_MUG, false, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "join_player",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return join_npc_to_player(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "leave_player",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return leave_npc_player(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_guarding",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const bool enabled ) {
        require_write();
        return set_npc_guarding(
                   lua_state, handle, enabled,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "become_hostile",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return make_npc_hostile(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "warn_player_departure",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return set_npc_departure_warning(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "clear_stolen_item_claim",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return clear_npc_stolen_item_claim(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "plan_travel",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const script_tripoint_coord &goal ) {
        require_read();
        return plan_npc_travel(
                   lua_state, handle, goal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_goal",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_tripoint_coord &goal ) {
        require_write();
        return set_npc_goal(
                   lua_state, handle, goal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "lead_to",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_tripoint_coord &goal ) {
        require_write();
        return set_npc_leading_goal(
                   lua_state, handle, goal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_guard_position",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_tripoint_coord &position ) {
        require_write();
        return set_npc_guard_position(
                   lua_state, handle, position,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "companion_state",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle ) {
        require_read();
        return get_npc_companion_state(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_companion_role",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
    const std::string &role ) {
        require_write();
        return set_npc_companion_role(
                   lua_state, handle, role,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "open_companion_missions",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
    const std::string &role ) {
        require_write();
        return open_npc_companion_missions(
                   lua_state, handle, role,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "offer_item",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &recipient,
            const game_handle &item,
    const sol::optional<bool> &use_item ) {
        require_write();
        return offer_item_to_npc(
                   lua_state, recipient, item,
                   use_item.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "open_dialogue",
        [current_runtime_generation, current_world_generation,
         require_write, invalidate_handles](
            sol::this_state lua_state, const game_handle &handle,
    const sol::optional<std::string> &topic ) {
        require_write();
        return open_npc_dialogue(
                   lua_state, handle, topic,
                   current_runtime_generation(),
                   current_world_generation(),
                   invalidate_handles );
    } );
    npcs.set_function(
        "open_rules",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return open_npc_rules(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "open_control_menu",
        [require_write, invalidate_handles]( sol::this_state lua_state ) {
        require_write();
        return open_npc_control_menu(
                   lua_state, invalidate_handles );
    } );
    npcs.set_function(
        "take_control",
        [current_runtime_generation, current_world_generation,
         require_write, invalidate_handles](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return take_control_of_npc(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation(),
                   invalidate_handles,
                   current_runtime_generation,
                   current_world_generation );
    } );
    npcs.set_function(
        "ai_rules",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        std::optional<game_handle_error> error;
        const npc *entry = resolve_npc(
                               handle, current_runtime_generation(),
                               current_world_generation(), error );
        if( entry == nullptr ) {
            return make_game_error_result( lua_state, *error );
        }
        sol::state_view state( lua_state );
        return make_game_value_result(
                   state, sol::make_object(
                       state, snapshot_ai_rules( state, *entry ) ) );
    } );
    install_npc_domain_services(
        npcs, current_runtime_generation,
        current_world_generation,
        require_read, require_write );
    game["npcs"] = std::move( npcs );

}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
