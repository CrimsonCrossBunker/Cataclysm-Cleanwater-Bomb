#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_npcs.h"

#include <character.h>
#include <character_id.h>
#include <creature.h>
#include <dialogue_chatbin.h>
#include <inventory.h>
#include <item_uid.h>
#include <map_scale_constants.h>
#include <npc_opinion.h>
#include <overmap.h>
#include <pimpl.h>
#include <point.h>
#include <simple_pathfinding.h>
#include <translation.h>
#include <type_id.h>
#include <visitable.h>
#include <algorithm>
#include <cctype>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "auto_pickup.h"
#include "avatar.h"
#include "basecamp.h"
#include "calendar.h"
#include "coordinates.h"
#include "event.h"
#include "event_bus.h"
#include "faction.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_location.h"
#include "line.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_missions.h"
#include "lua_platform_npc_services.h"
#include "lua_platform_runtime.h"
#include "map.h"
#include "mission.h"
#include "mission_companion.h"
#include "npc.h"
#include "npc_class.h"
#include "npctalk.h"
#include "messages.h"
#include "translations.h"
#include "npctalk_rules.h"
#include "overmapbuffer.h"
#include "talker_npc.h"
#include "viewer.h"

namespace cata::lua_platform
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
            "services.npcs.classes offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "services.npcs.classes limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "services.npcs.classes query exceeds 128 bytes" );
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

// These operations have two live participants.  Resolve both from the
// handles captured by the caller before touching either native object; in
// particular, never recover the avatar through get_avatar() or a player
// singleton after the NPC handle has been accepted.
bool resolve_exact_npc_with_avatar_owner(
    const game_handle &npc_handle, const game_handle &avatar_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation, npc *&npc_value,
    avatar *&avatar_value, std::optional<game_handle_error> &error )
{
    npc_value = resolve_exact_npc(
                    npc_handle, runtime_generation, world_generation, error );
    if( npc_value == nullptr ) {
        avatar_value = nullptr;
        return false;
    }
    avatar_value = resolve_exact_avatar(
                       avatar_handle, runtime_generation,
                       world_generation, error );
    return avatar_value != nullptr;
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
        id, "services.npcs.class" );
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

bool live_mission_pointer( const mission *candidate )
{
    if( candidate == nullptr ) {
        return false;
    }
    const std::vector<mission *> live = mission::get_all_active();
    return std::find( live.begin(), live.end(), candidate ) != live.end();
}

sol::table snapshot_opinion(
    sol::state_view lua, const npc_opinion snapshot )
{
    sol::table result = lua.create_table();
    result["trust"] = snapshot.trust;
    result["fear"] = snapshot.fear;
    result["value"] = snapshot.value;
    result["anger"] = snapshot.anger;
    result["owed"] = snapshot.owed;
    result["sold"] = snapshot.sold;
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

struct npc_ai_rules_snapshot {
    std::string aim;
    std::string engagement;
    std::string cbm_recharge;
    std::string cbm_reserve;
    std::vector<std::string> allies;
    std::vector<std::string> base_allies;
    std::vector<std::pair<std::string, bool>> overrides;
    bool pickup_whitelist = false;
};

npc_ai_rules_snapshot capture_ai_rules( const npc &entry )
{
    const npc_follower_rules &rules = entry.rules;
    npc_ai_rules_snapshot snapshot;
    snapshot.aim = reverse_string_lookup( aim_rule_strs, rules.aim );
    snapshot.engagement = reverse_string_lookup(
                              combat_engagement_strs, rules.engagement );
    snapshot.cbm_recharge = reverse_string_lookup(
                                cbm_recharge_strs, rules.cbm_recharge );
    snapshot.cbm_reserve = reverse_string_lookup(
                               cbm_reserve_strs, rules.cbm_reserve );
    snapshot.allies.reserve( ally_rule_strs.size() );
    snapshot.base_allies.reserve( ally_rule_strs.size() );
    snapshot.overrides.reserve( ally_rule_strs.size() );
    for( const auto &rule_entry : ally_rule_strs ) {
        if( rules.has_flag( rule_entry.second.rule ) ) {
            snapshot.allies.push_back( rule_entry.first );
        }
        if( rules.has_flag( rule_entry.second.rule, false ) ) {
            snapshot.base_allies.push_back( rule_entry.first );
        }
        if( rules.has_override_enable( rule_entry.second.rule ) ) {
            snapshot.overrides.emplace_back(
                rule_entry.first, rules.has_override( rule_entry.second.rule ) );
        }
    }
    snapshot.pickup_whitelist = !rules.pickup_whitelist->empty();
    return snapshot;
}

sol::table snapshot_ai_rules(
    sol::state_view lua, const npc_ai_rules_snapshot &snapshot )
{
    sol::table result = lua.create_table();
    result["aim"] = snapshot.aim;
    result["engagement"] = snapshot.engagement;
    result["cbm_recharge"] = snapshot.cbm_recharge;
    result["cbm_reserve"] = snapshot.cbm_reserve;
    sol::table allies = lua.create_table();
    sol::table base_allies = lua.create_table();
    sol::table overrides = lua.create_table();
    for( std::size_t index = 0; index < snapshot.allies.size(); ++index ) {
        allies[index + 1] = snapshot.allies[index];
    }
    for( std::size_t index = 0; index < snapshot.base_allies.size(); ++index ) {
        base_allies[index + 1] = snapshot.base_allies[index];
    }
    for( const auto &entry : snapshot.overrides ) {
        overrides[entry.first] = entry.second;
    }
    result["allies"] = std::move( allies );
    result["base_allies"] = std::move( base_allies );
    result["overrides"] = std::move( overrides );
    result["pickup_whitelist"] = snapshot.pickup_whitelist;
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

struct companion_assignment_snapshot_data {
    npc_companion_mission companion;
    bool assigned = false;
    std::string source_role;
    time_point departure_time;
    time_point return_time;
    bool return_due = false;
    float exertion = 1.0f;
    time_duration travel_time;
    std::size_t point_count = 0;
    std::size_t inventory_stacks = 0;
};

companion_assignment_snapshot_data capture_companion_assignment(
    const npc &entry )
{
    companion_assignment_snapshot_data snapshot;
    snapshot.companion = entry.get_companion_mission();
    snapshot.assigned = entry.has_companion_mission();
    snapshot.source_role = entry.companion_mission_role_id;
    snapshot.departure_time = entry.companion_mission_time;
    snapshot.return_time = entry.companion_mission_time_ret;
    snapshot.return_due = snapshot.assigned &&
                          snapshot.return_time != calendar::before_time_starts &&
                          snapshot.return_time <= calendar::turn;
    snapshot.exertion = entry.companion_mission_exertion;
    snapshot.travel_time = entry.companion_mission_travel_time;
    snapshot.point_count = entry.companion_mission_points.size();
    snapshot.inventory_stacks = entry.companion_mission_inv.size();
    return snapshot;
}

sol::table snapshot_companion_assignment(
    sol::state_view lua, const companion_assignment_snapshot_data &snapshot )
{
    sol::table result = lua.create_table();
    result["assigned"] = snapshot.assigned;
    result["source_role"] = snapshot.source_role;
    result["role"] = snapshot.companion.role_id;
    result["kind"] =
        io::enum_to_string( snapshot.companion.miss_id.id );
    result["parameters"] =
        snapshot.companion.miss_id.parameters;
    if( snapshot.companion.position == tripoint_abs_omt::invalid ) {
        result["position"] = sol::nil;
    } else {
        result["position"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::overmap_terrain,
                snapshot.companion.position.raw() );
    }
    if( snapshot.companion.destination ) {
        result["destination"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::overmap_terrain,
                snapshot.companion.destination->raw() );
    } else {
        result["destination"] = sol::nil;
    }
    result["departure_time"] =
        script_time_point::from_native(
            snapshot.departure_time );
    result["return_time"] =
        script_time_point::from_native(
            snapshot.return_time );
    result["return_due"] = snapshot.return_due;
    result["exertion"] = snapshot.exertion;
    result["travel_time"] =
        script_time_duration::from_native(
            snapshot.travel_time );
    result["point_count"] = snapshot.point_count;
    result["inventory_stacks"] = snapshot.inventory_stacks;
    return result;
}

struct selected_mission_snapshot_data {
    int uid = 0;
    std::size_t identity_generation = 0;
    std::string id;
    bool assigned = false;
    bool in_progress = false;
    bool failed = false;
    bool has_generic_rewards = false;
};

struct npc_snapshot_data {
    explicit npc_snapshot_data( game_handle native_handle ) : handle( std::move( native_handle ) ) {}

    game_handle handle;
    std::int64_t id = 0;
    std::string unique_id;
    int assigned_missions_value = 0;
    std::string name;
    std::string display_name;
    tripoint_abs_ms position;
    std::string class_id;
    std::optional<std::string> template_id;
    std::optional<std::string> faction_id;
    std::string attitude;
    std::string attitude_name;
    std::string mission;
    std::string status;
    std::string activity;
    bool male = false;
    bool dead = false;
    bool hallucination = false;
    bool enemy = false;
    bool friendly = false;
    bool following = false;
    bool player_ally = false;
    bool leader = false;
    bool guarding = false;
    bool patrolling = false;
    bool shopkeeper = false;
    std::int64_t restock_turn = 0;
    bool faction_representative = false;
    std::string first_topic;
    std::string companion_role;
    companion_assignment_snapshot_data companion_assignment;
    std::optional<tripoint_abs_omt> assigned_camp;
    std::size_t available_missions = 0;
    std::size_t assigned_missions = 0;
    bool selected_mission_stale = false;
    std::optional<selected_mission_snapshot_data> selected_mission;
    bool travelling = false;
    npc_ai_rules_snapshot ai_rules;
    npc_opinion opinion;
    int aggression = 0;
    int bravery = 0;
    int collector = 0;
    int altruism = 0;
};

npc_snapshot_data capture_npc_snapshot(
    npc &entry, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    npc_snapshot_data snapshot( make_npc_handle(
                                    entry, runtime_generation, world_generation ) );
    snapshot.id = entry.getID().get_value();
    snapshot.unique_id = entry.get_unique_id();
    snapshot.assigned_missions_value = entry.assigned_missions_value();
    snapshot.name = entry.get_name();
    snapshot.display_name = entry.display_name();
    snapshot.position = entry.pos_abs();
    snapshot.class_id = entry.myclass.str();
    if( !entry.idz.is_null() ) {
        snapshot.template_id = entry.idz.str();
    }
    const faction_id faction = entry.get_fac_id();
    if( !faction.is_null() ) {
        snapshot.faction_id = faction.str();
    }
    const npc_attitude attitude = entry.get_attitude();
    snapshot.attitude = npc_attitude_id( attitude );
    snapshot.attitude_name = npc_attitude_name( attitude );
    snapshot.mission = io::enum_to_string( entry.mission );
    snapshot.status = entry.get_current_status();
    snapshot.activity = entry.get_current_activity();
    snapshot.male = entry.male;
    snapshot.dead = entry.is_dead();
    snapshot.hallucination = entry.is_hallucination();
    snapshot.enemy = entry.is_enemy();
    snapshot.friendly = entry.is_friendly( get_avatar() );
    snapshot.following = entry.is_following();
    snapshot.player_ally = entry.is_player_ally();
    snapshot.leader = entry.is_leader();
    snapshot.guarding = entry.is_guarding();
    snapshot.patrolling = entry.is_patrolling();
    snapshot.shopkeeper = entry.is_shopkeeper();
    snapshot.restock_turn = to_turn<std::int64_t>( entry.restock_time() );
    snapshot.faction_representative = entry.faction_representative;
    snapshot.first_topic = entry.chatbin.first_topic;
    snapshot.companion_role = entry.companion_mission_role_id;
    snapshot.companion_assignment = capture_companion_assignment( entry );
    snapshot.assigned_camp = entry.assigned_camp;
    snapshot.available_missions = entry.chatbin.missions.size();
    snapshot.assigned_missions = entry.chatbin.missions_assigned.size();
    const mission *selected_mission = entry.chatbin.mission_selected;
    const bool selected_live = live_mission_pointer( selected_mission );
    snapshot.selected_mission_stale = selected_mission != nullptr && !selected_live;
    if( selected_live ) {
        snapshot.selected_mission = selected_mission_snapshot_data {
            selected_mission->get_id(),
            selected_mission->identity_generation(),
            selected_mission->mission_id().str(),
            selected_mission->is_assigned(),
            selected_mission->in_progress(),
            selected_mission->has_failed(),
            selected_mission->has_generic_rewards()
        };
    }
    snapshot.travelling = !entry.omt_path.empty();
    snapshot.ai_rules = capture_ai_rules( entry );
    snapshot.opinion = entry.op_of_u;
    snapshot.aggression = entry.personality.aggression;
    snapshot.bravery = entry.personality.bravery;
    snapshot.collector = entry.personality.collector;
    snapshot.altruism = entry.personality.altruism;
    return snapshot;
}

sol::table snapshot_npc(
    sol::state_view lua, const npc_snapshot_data &snapshot,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["handle"] = snapshot.handle;
    result["id"] = snapshot.id;
    result["unique_id"] = snapshot.unique_id;
    result["assigned_missions_value"] = snapshot.assigned_missions_value;
    result["name"] = snapshot.name;
    result["display_name"] = snapshot.display_name;
    result["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs, coords::scale::map_square,
                             snapshot.position.raw() );
    result["class"] = script_game_id( "npc_class", snapshot.class_id );
    if( snapshot.template_id ) {
        result["template"] = script_game_id( "npc_template", *snapshot.template_id );
    } else {
        result["template"] = sol::nil;
    }
    if( snapshot.faction_id ) {
        result["faction"] = script_game_id( "faction", *snapshot.faction_id );
    } else {
        result["faction"] = sol::nil;
    }
    result["attitude"] = snapshot.attitude;
    result["attitude_name"] = snapshot.attitude_name;
    result["mission"] = snapshot.mission;
    result["status"] = snapshot.status;
    result["activity"] = snapshot.activity;
    result["male"] = snapshot.male;
    result["dead"] = snapshot.dead;
    result["hallucination"] = snapshot.hallucination;
    result["enemy"] = snapshot.enemy;
    result["friendly"] = snapshot.friendly;
    result["following"] = snapshot.following;
    result["player_ally"] = snapshot.player_ally;
    result["leader"] = snapshot.leader;
    result["guarding"] = snapshot.guarding;
    result["patrolling"] = snapshot.patrolling;
    result["shopkeeper"] = snapshot.shopkeeper;
    result["restock_turn"] = snapshot.restock_turn;
    result["faction_representative"] = snapshot.faction_representative;
    result["first_topic"] = snapshot.first_topic;
    result["companion_role"] = snapshot.companion_role;
    result["companion_assignment"] = snapshot_companion_assignment(
                                         lua, snapshot.companion_assignment );
    result["has_assigned_camp"] = snapshot.assigned_camp.has_value();
    if( snapshot.assigned_camp ) {
        result["assigned_camp"] = script_tripoint_coord::from_native(
                                      coords::origin::abs,
                                      coords::scale::overmap_terrain,
                                      snapshot.assigned_camp->raw() );
    } else {
        result["assigned_camp"] = sol::nil;
    }
    sol::table dialogue_missions = lua.create_table();
    dialogue_missions["available_count"] = snapshot.available_missions;
    dialogue_missions["assigned_count"] = snapshot.assigned_missions;
    dialogue_missions["selected_stale"] = snapshot.selected_mission_stale;
    if( !snapshot.selected_mission ) {
        dialogue_missions["selected"] = sol::nil;
    } else {
        sol::table selected = lua.create_table();
        selected["token"] = mission_token(
                                snapshot.selected_mission->uid,
                                snapshot.selected_mission->identity_generation,
                                runtime_generation, world_generation );
        selected["uid"] = snapshot.selected_mission->uid;
        selected["id"] = script_game_id( "mission", snapshot.selected_mission->id );
        selected["assigned"] = snapshot.selected_mission->assigned;
        selected["in_progress"] = snapshot.selected_mission->in_progress;
        selected["failed"] = snapshot.selected_mission->failed;
        selected["has_generic_rewards"] = snapshot.selected_mission->has_generic_rewards;
        dialogue_missions["selected"] = std::move( selected );
    }
    result["dialogue_missions"] = std::move( dialogue_missions );
    result["travelling"] = snapshot.travelling;
    result["ai_rules"] = snapshot_ai_rules( lua, snapshot.ai_rules );
    result["opinion"] = snapshot_opinion( lua, snapshot.opinion );
    sol::table personality = lua.create_table();
    personality["aggression"] = snapshot.aggression;
    personality["bravery"] = snapshot.bravery;
    personality["collector"] = snapshot.collector;
    personality["altruism"] = snapshot.altruism;
    result["personality"] = std::move( personality );
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
            "services.npcs.list offset must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "services.npcs.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_state_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "services.npcs.list query exceeds 128 bytes" );
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

// Keep the scene order: presentation choices must not silently become the
// ID-sorted persistent follower roster (which includes off-screen NPCs).
sol::table visible_player_allies(
    sol::this_state lua,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    std::vector<npc_snapshot_data> snapshots;
    {
        const map &here = get_map();
        for( npc &entry : g->all_npcs() ) {
            if( entry.is_player_ally() && get_player_view().sees( here, entry ) ) {
                snapshots.push_back( capture_npc_snapshot(
                                         entry, runtime_generation, world_generation ) );
            }
        }
    }
    sol::table items = state.create_table();
    for( std::size_t index = 0; index < snapshots.size(); ++index ) {
        items[index + 1] = snapshot_npc(
                               state, snapshots[index], runtime_generation,
                               world_generation );
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( items ) ) );
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
    std::size_t total = 0;
    std::size_t first = 0;
    std::size_t last = 0;
    std::vector<npc_snapshot_data> snapshots;
    {
        const std::vector<npc *> entries = matching_npcs( options.query );
        total = entries.size();
        first = std::min<std::size_t>( options.offset, total );
        last = std::min<std::size_t>(
                   first + options.limit, total );
        snapshots.reserve( last - first );
        for( std::size_t index = first; index < last; ++index ) {
            snapshots.push_back( capture_npc_snapshot(
                                     *entries[index], runtime_generation,
                                     world_generation ) );
        }
    }
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = 0; index < snapshots.size(); ++index ) {
        items[index + 1] = snapshot_npc(
                               state, snapshots[index], runtime_generation,
                               world_generation );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = total;
    value["returned"] = last - first;
    value["has_more"] = last < total;
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
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data snapshot = capture_npc_snapshot(
                                           *entry, runtime_generation, world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_npc(
                       state, snapshot, runtime_generation, world_generation ) ) );
}

sol::table find_unique_npc(
    sol::this_state lua,
    const std::string &unique_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.npcs.find_unique";
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
    const npc_snapshot_data snapshot = capture_npc_snapshot(
                                           *entry, runtime_generation, world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_npc(
                       state, snapshot, runtime_generation, world_generation ) ) );
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
        "services.npcs.has_role_nearby";
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
        "services.npcs.has_follower_nearby";
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
            "services.npcs.rename name cannot be empty" );
    }
    if( name.size() > maximum_npc_name_bytes ) {
        throw std::invalid_argument(
            "services.npcs.rename name exceeds 256 bytes" );
    }
    if( std::any_of(
    name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "services.npcs.rename name cannot contain control characters" );
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
    npc *entry = resolve_exact_npc(
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
            "services.npcs.set_attitude received an unknown attitude" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
                "services.npcs.modify_opinion option keys must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        if( key != "trust" && key != "fear" &&
            key != "value" && key != "anger" &&
            key != "owed" && key != "sold" ) {
            throw std::invalid_argument(
                "services.npcs.modify_opinion received unknown option '" +
                key + "'" );
        }
        if( !entry.second.is<int>() ) {
            throw std::invalid_argument(
                "services.npcs.modify_opinion option '" + key +
                "' must be an integer" );
        }
        const int delta = entry.second.as<int>();
        if( delta < -maximum_opinion_delta ||
            delta > maximum_opinion_delta ) {
            throw std::invalid_argument(
                "services.npcs.modify_opinion option '" + key +
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
            "services.npcs.modify_opinion requires at least one delta" );
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
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before =
        snapshot_opinion(
            state, entry->op_of_u );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
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
    const npc_opinion after = entry->op_of_u;
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_opinion( state, after );
    value["effective"] = snapshot_opinion( state, after );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table add_npc_debt(
    sol::this_state lua, const game_handle &handle, const int amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.npcs.add_debt";
    if( amount < -maximum_opinion_delta ||
        amount > maximum_opinion_delta ) {
        throw std::invalid_argument(
            "services.npcs.add_debt amount must be within -1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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

sol::table add_npc_faction_rep(
    sol::this_state lua, const game_handle &handle, const int amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( amount < -maximum_opinion_delta ||
        amount > maximum_opinion_delta ) {
        throw std::invalid_argument(
            "services.npcs.add_faction_rep amount must be within -1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    faction *fac = entry->get_faction();
    if( fac == nullptr ) {
        return make_game_error_result( state, {
            "missing_faction", "The NPC has no faction"
        } );
    }
    auto checked_add = [amount]( const int before ) -> std::optional<int> {
        const std::int64_t after =
        static_cast<std::int64_t>( before ) + amount;
        if( after < std::numeric_limits<int>::min() ||
            after > std::numeric_limits<int>::max() )
        {
            return std::nullopt;
        }
        return static_cast<int>( after );
    };
    const std::optional<int> likes_after = checked_add( fac->likes_u );
    const std::optional<int> respects_after = checked_add( fac->respects_u );
    const std::optional<int> trusts_after = checked_add( fac->trusts_u );
    if( !likes_after || !respects_after || !trusts_after ) {
        return make_game_error_result( state, {
            "numeric_overflow", "The faction reputation update would overflow"
        } );
    }
    const int likes_before = fac->likes_u;
    const int respects_before = fac->respects_u;
    const int trusts_before = fac->trusts_u;
    if( !fac->lone_wolf_faction ) {
        fac->likes_u = *likes_after;
        fac->respects_u = *respects_after;
        fac->trusts_u = *trusts_after;
    }
    sol::table value = state.create_table();
    value["amount"] = amount;
    value["changed"] = !fac->lone_wolf_faction && amount != 0;
    value["before"] = state.create_table_with(
                          "likes", likes_before,
                          "respects", respects_before,
                          "trusts", trusts_before );
    value["after"] = state.create_table_with(
                         "likes", fac->likes_u,
                         "respects", fac->respects_u,
                         "trusts", fac->trusts_u );
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
    constexpr std::string_view api_name = "services.npcs.set_class";
    require_npc_domain_id( requested_class, "npc_class", api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
    constexpr std::string_view api_name = "services.npcs.set_faction";
    require_npc_domain_id( requested_faction, "faction", api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
            "services.npcs.set_first_topic requires 1 to 256 non-control bytes" );
    }
}

void validate_dialogue_topic(
    const std::string &topic,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( topic.empty() || topic.size() > maximum_npc_topic_bytes ||
    std::any_of( topic.begin(), topic.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "services.npcs.open_dialogue topic requires 1 to 256 non-control bytes" );
    }
    if( get_talk_topic( topic ) == nullptr &&
        !detail::runtime_has_dialogue_topic(
            topic, runtime_generation, world_generation ) ) {
        throw std::invalid_argument(
            "services.npcs.open_dialogue received an unknown dialogue topic" );
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
    npc *entry = resolve_exact_npc(
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
    sol::this_state lua, const game_handle &handle,
    const game_handle &avatar_handle, const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &require_write )
{
    require_write();
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = nullptr;
    avatar *owner = nullptr;
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    const bool before = entry->faction_representative;
    entry->faction_representative = enabled;
    if( enabled ) {
        owner->faction_representatives.insert( entry->getID() );
    } else {
        owner->faction_representatives.erase( entry->getID() );
    }
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = entry->faction_representative;
    value["changed"] = before != entry->faction_representative;
    value["avatar_id"] = owner->getID().get_value();
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
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_ai_rules_snapshot before_snapshot = capture_ai_rules( *entry );
    sol::table before = snapshot_ai_rules( state, before_snapshot );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( family == "aim" ) {
        const auto found = aim_rule_strs.find( rule );
        if( found == aim_rule_strs.end() ) {
            throw std::invalid_argument(
                "services.npcs.set_ai_policy received an unknown aim rule" );
        }
        entry->rules.aim = found->second;
        entry->invalidate_range_cache();
    } else if( family == "engagement" ) {
        const auto found = combat_engagement_strs.find( rule );
        if( found == combat_engagement_strs.end() ) {
            throw std::invalid_argument(
                "services.npcs.set_ai_policy received an unknown engagement rule" );
        }
        entry->rules.engagement = found->second;
        entry->invalidate_range_cache();
        entry->wield_better_weapon();
    } else if( family == "cbm_recharge" ) {
        const auto found = cbm_recharge_strs.find( rule );
        if( found == cbm_recharge_strs.end() ) {
            throw std::invalid_argument(
                "services.npcs.set_ai_policy received an unknown CBM recharge rule" );
        }
        entry->rules.cbm_recharge = found->second;
    } else if( family == "cbm_reserve" ) {
        const auto found = cbm_reserve_strs.find( rule );
        if( found == cbm_reserve_strs.end() ) {
            throw std::invalid_argument(
                "services.npcs.set_ai_policy received an unknown CBM reserve rule" );
        }
        entry->rules.cbm_reserve = found->second;
    } else {
        throw std::invalid_argument(
            "services.npcs.set_ai_policy family must be aim, engagement, "
            "cbm_recharge, or cbm_reserve" );
    }
    const npc_ai_rules_snapshot after = capture_ai_rules( *entry );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, after );
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
            "services.npcs.set_ally_rule received an unknown ally rule" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const ally_rule native_rule = found->second.rule;
    const bool before = entry->rules.has_flag( native_rule, false );
    // Native talker_npc::toggle_ai_rule uses toggle_flag(), which chooses the
    // new base flag from has_flag() including any active override.  Explicit
    // true/false requests still set or clear only the underlying base flag.
    const bool base_enabled = requested_enabled.value_or(
                                  !entry->rules.has_flag( native_rule ) );
    if( base_enabled ) {
        entry->rules.set_flag( native_rule );
    } else {
        entry->rules.clear_flag( native_rule );
    }
    const bool after = entry->rules.has_flag( native_rule, false );
    entry->invalidate_range_cache();
    entry->wield_better_weapon();
    sol::table value = state.create_table();
    value["rule"] = rule;
    value["before"] = before;
    value["after"] = after;
    value["changed"] = before != after;
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
            "services.npcs.set_ally_override received an unknown ally rule" );
    }
    if( state_name != "inherit" && state_name != "allow" &&
        state_name != "deny" ) {
        throw std::invalid_argument(
            "services.npcs.set_ally_override state must be inherit, allow, or deny" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_ai_rules_snapshot before_snapshot = capture_ai_rules( *entry );
    sol::table before = snapshot_ai_rules( state, before_snapshot );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const ally_rule native_rule = found->second.rule;
    if( state_name == "inherit" ) {
        entry->rules.disable_override( native_rule );
        entry->rules.clear_override( native_rule );
    } else {
        entry->rules.set_specific_override_state(
            native_rule, state_name == "allow" );
    }
    entry->invalidate_range_cache();
    const npc_ai_rules_snapshot after_rules = capture_ai_rules( *entry );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, after_rules );
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
    npc *target = resolve_exact_npc(
                      target_handle, runtime_generation,
                      world_generation, target_error );
    if( target == nullptr ) {
        return make_game_error_result( state, *target_error );
    }
    std::optional<game_handle_error> source_error;
    npc *source = resolve_exact_npc(
                      source_handle, runtime_generation,
                      world_generation, source_error );
    if( source == nullptr ) {
        return make_game_error_result( state, *source_error );
    }
    const npc_ai_rules_snapshot before_snapshot = capture_ai_rules( *target );
    sol::table before = snapshot_ai_rules( state, before_snapshot );
    target = resolve_exact_npc(
                 target_handle, runtime_generation,
                 world_generation, target_error );
    if( target == nullptr ) {
        return make_game_error_result( state, *target_error );
    }
    source = resolve_exact_npc(
                 source_handle, runtime_generation,
                 world_generation, source_error );
    if( source == nullptr ) {
        return make_game_error_result( state, *source_error );
    }
    if( target != source ) {
        target->rules = source->rules;
    }
    const npc_ai_rules_snapshot after = capture_ai_rules( *target );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, after );
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
    npc *entry = resolve_exact_npc(
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
        "services.npcs.record_refusal request must be follow, lead, equipment, training, or personal_info" );
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
    npc *entry = resolve_exact_npc(
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

void reset_npc_follow_destination( npc &entry )
{
    entry.set_mission( NPC_MISSION_NULL );
    entry.goal = npc::no_goal_point;
    entry.guard_pos = std::nullopt;
    entry.clear_ai_guard_pos();
    entry.clear_committed_goal();
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
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_attitude attitude_before = entry->get_attitude();
    const std::string topic_before = entry->chatbin.first_topic;
    const bool blocked_by_ally = non_ally_only && entry->is_player_ally();
    bool follow_state_changed = false;
    if( !blocked_by_ally ) {
        if( non_ally_only ) {
            talk_function::stop_following( *entry );
        } else if( reset_stranger_topic ) {
            talk_function::stranger_neutral( *entry );
        } else if( attitude == NPCATT_FLEE ) {
            talk_function::flee( *entry );
        } else if( attitude == NPCATT_MUG ) {
            talk_function::start_mugging( *entry );
        } else {
            entry->set_attitude( attitude );
        }
        if( attitude == NPCATT_FOLLOW ) {
            follow_state_changed = entry->mission != NPC_MISSION_NULL ||
                                   entry->goal != npc::no_goal_point || entry->guard_pos.has_value() ||
                                   entry->get_ai_guard_pos().has_value() || !entry->get_committed_goal().empty();
            reset_npc_follow_destination( *entry );
        }
    }
    sol::table value = state.create_table();
    value["attitude_before"] = npc_attitude_id( attitude_before );
    value["attitude_after"] = npc_attitude_id(
                                  entry->get_attitude() );
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["changed"] =
        follow_state_changed || attitude_before != entry->get_attitude() ||
        topic_before != entry->chatbin.first_topic;
    value["blocked_by_ally"] = blocked_by_ally;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table join_npc_to_player(
    sol::this_state lua, const game_handle &handle,
    const game_handle &avatar_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &require_write )
{
    require_write();
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    std::optional<game_handle_error> error;
    npc *entry = nullptr;
    avatar *owner = nullptr;
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data before_snapshot = capture_npc_snapshot(
                *entry, runtime_generation, world_generation );
    sol::table before = snapshot_npc(
                            state, before_snapshot, runtime_generation,
                            world_generation );
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    const int transferred_cash = entry->cash;
    owner->follower_ids.insert( entry->getID() );
    entry->set_attitude( NPCATT_FOLLOW );
    entry->set_fac( faction_your_followers );
    reset_npc_follow_destination( *entry );
    owner->cash += transferred_cash;
    entry->cash = 0;
    entry->custom_profession.clear();
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data after = capture_npc_snapshot(
                                        *entry, runtime_generation, world_generation );
    const std::int64_t avatar_id = owner->getID().get_value();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_npc(
                         state, after, runtime_generation, world_generation );
    value["transferred_cash"] = transferred_cash;
    value["avatar_id"] = avatar_id;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table leave_npc_player(
    sol::this_state lua, const game_handle &handle,
    const game_handle &avatar_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &require_write )
{
    require_write();
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    std::optional<game_handle_error> error;
    npc *entry = nullptr;
    avatar *owner = nullptr;
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data before_snapshot = capture_npc_snapshot(
                *entry, runtime_generation, world_generation );
    sol::table before = snapshot_npc(
                            state, before_snapshot, runtime_generation,
                            world_generation );
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    add_msg( _( "%s leaves." ), entry->get_name() );
    owner->follower_ids.erase( entry->getID() );
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
    entry->mission = NPC_MISSION_NULL;
    entry->long_term_goal_action();
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data after = capture_npc_snapshot(
                                        *entry, runtime_generation, world_generation );
    const bool created_faction = created != nullptr;
    const std::int64_t avatar_id = owner->getID().get_value();
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_npc(
                         state, after, runtime_generation, world_generation );
    value["created_faction"] = created_faction;
    value["avatar_id"] = avatar_id;
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
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data before_snapshot = capture_npc_snapshot(
                *entry, runtime_generation, world_generation );
    sol::table before = snapshot_npc(
                            state, before_snapshot, runtime_generation,
                            world_generation );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( enabled ) {
        talk_function::assign_guard( *entry );
    } else {
        talk_function::stop_guard( *entry );
    }
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_snapshot_data after = capture_npc_snapshot(
                                        *entry, runtime_generation, world_generation );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_npc(
                         state, after, runtime_generation, world_generation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table request_npc_talk(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc( handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool changed = entry->get_attitude() != NPCATT_TALK;
    if( changed ) {
        if( entry->sees( get_map(), get_player_character() ) ) {
            add_msg( _( "%s wants to talk to you." ), entry->get_name() );
        }
        entry->set_attitude( NPCATT_TALK );
    }
    sol::table value = state.create_table();
    value["changed"] = changed;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table make_npc_hostile(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_attitude before = entry->get_attitude();
    const bool changed = before != NPCATT_KILL;
    talk_function::hostile( *entry );
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
    npc *entry = resolve_exact_npc(
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
    npc *entry = resolve_exact_npc(
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
    constexpr std::string_view api_name = "services.npcs.plan_travel";
    const tripoint_abs_omt destination = require_npc_goal_position(
            requested_goal, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const npc *entry = resolve_exact_npc(
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

struct npc_destination_entry {
    std::string id;
    std::string kind;
    std::string label;
    tripoint_abs_omt position;
};

sol::table list_npc_destinations(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const npc *entry = resolve_exact_npc(
                           handle, runtime_generation,
                           world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const Character &player = get_player_character();
    const tripoint_abs_omt npc_position = entry->pos_abs_omt();
    std::vector<npc_destination_entry> destinations;
    destinations.reserve( player.camps.size() + 2 );

    for( const tripoint_abs_omt &camp_position : player.camps ) {
        if( camp_position == npc_position ||
            overmap_buffer.seen( camp_position ) == om_vision_level::unseen ) {
            continue;
        }
        const std::optional<basecamp *> camp =
            overmap_buffer.find_camp( camp_position.xy() );
        if( !camp || *camp == nullptr || !( *camp )->is_valid() ) {
            continue;
        }
        const std::string position_id = camp_position.to_string();
        destinations.push_back( {
            "camp:" + position_id,
            "camp",
            ( *camp )->camp_name(),
            ( *camp )->camp_omt_pos()
        } );
    }

    if( player.pos_abs_omt() != npc_position ) {
        destinations.push_back( {
            "player_current", "player",
            to_translation( "My current location" ).translated(),
            player.pos_abs_omt()
        } );
    }
    if( !player.omt_path.empty() ) {
        destinations.push_back( {
            "player_destination", "player",
            to_translation( "My destination" ).translated(),
            player.omt_path.front()
        } );
    }

    std::sort( destinations.begin(), destinations.end(),
               []( const npc_destination_entry & lhs,
    const npc_destination_entry & rhs ) {
        if( lhs.kind != rhs.kind ) {
            return lhs.kind < rhs.kind;
        }
        return lhs.id < rhs.id;
    } );

    const std::size_t returned = std::min(
                                     destinations.size(), maximum_nested_ids );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const npc_destination_entry &destination = destinations[index];
        sol::table value = state.create_table();
        value["id"] = destination.id;
        value["kind"] = destination.kind;
        value["label"] = destination.label;
        value["position"] = script_tripoint_coord::from_native(
                                coords::origin::abs,
                                coords::scale::overmap_terrain,
                                destination.position.raw() );
        items[index + 1] = std::move( value );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = destinations.size();
    value["returned"] = returned;
    value["truncated"] = returned < destinations.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_npc_goal(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_goal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.npcs.set_goal";
    const tripoint_abs_omt destination = require_npc_goal_position(
            requested_goal, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
        "services.npcs.lead_to";
    const tripoint_abs_omt destination =
        require_npc_goal_position( requested_goal, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
    constexpr std::string_view api_name = "services.npcs.set_guard_position";
    const tripoint_abs_ms destination = require_npc_guard_position(
                                            requested_position, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
    const npc *entry = resolve_exact_npc(
                           handle, runtime_generation,
                           world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const companion_assignment_snapshot_data snapshot =
        capture_companion_assignment( *entry );
    return make_game_value_result(
               state, sol::make_object(
                   state,
                   snapshot_companion_assignment(
                       state, snapshot ) ) );
}

sol::table set_npc_companion_role(
    sol::this_state lua, const game_handle &handle,
    const std::string &role,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.npcs.set_companion_role";
    require_companion_role( role, api_name, true );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
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
        "services.npcs.open_companion_missions";
    require_companion_role( role, api_name, false );
    if( !is_native_companion_menu_role( role ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " role is not supported by the native companion mission menu" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before_role =
        entry->companion_mission_role_id;
    entry->companion_mission_role_id = role;
    talk_function::companion_mission( *entry );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string after_role = entry->companion_mission_role_id;
    const companion_assignment_snapshot_data after_state =
        capture_companion_assignment( *entry );
    sol::table value = state.create_table();
    value["role_before"] = before_role;
    value["role_after"] = after_role;
    value["state"] = snapshot_companion_assignment( state, after_state );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

item *find_character_item_by_uid(
    Character &character, const std::int64_t uid )
{
    item *found = nullptr;
    character.visit_items(
    [&]( item * entry, item * ) {
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
    const game_handle &giver_handle,
    const game_handle &item_handle, const bool use_item,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *recipient = resolve_exact_npc(
                         npc_handle, runtime_generation,
                         world_generation, error );
    if( recipient == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *giver = resolve_exact_character(
                           giver_handle, runtime_generation,
                           world_generation, error );
    if( giver == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const native_handle_result<item> resolved_item =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved_item ) {
        return make_game_error_result(
                   state, *resolved_item.error );
    }
    item *offered = resolved_item.value;
    if( !giver->has_item( *offered ) ) {
        return make_game_error_result( state, {
            "not_owned",
            "services.npcs.offer_item requires the exact item to belong to giver"
        } );
    }
    const std::int64_t uid = offered->uid().get_value();
    const int charges_before = offered->charges;
    const int damage_before = offered->damage();
    const int moves_before = giver->get_moves();
    talker_npc recipient_talker( recipient );
    const std::string reason = recipient_talker.give_item_to(
                                   item_location( *giver, offered ),
                                   use_item );
    item *recipient_item = find_character_item_by_uid(
                               *recipient, uid );
    item *giver_item = find_character_item_by_uid(
                           *giver, uid );

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
    value["giver_moves_spent"] =
        moves_before - giver->get_moves();
    value["recipient_has_item"] =
        recipient_item != nullptr;
    value["giver_has_item"] =
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
    giver->invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_dialogue(
    sol::this_state lua, const game_handle &handle,
    const game_handle &speaker_handle,
    const std::string &topic,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &invalidate_handles )
{
    sol::state_view state( lua );
    validate_dialogue_topic(
        topic, runtime_generation, world_generation );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar *player = resolve_exact_avatar(
                         speaker_handle, runtime_generation,
                         world_generation, error );
    if( player == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::int64_t speaker_id_before =
        player->getID().get_value();
    const avatar_talk_to_result result = player->talk_to(
            get_talker_for( entry ), false, false, false,
            topic, std::string(), false );
    const std::int64_t speaker_id_after =
        player->getID().get_value();
    const bool handles_invalidated =
        speaker_id_before != speaker_id_after;
    if( handles_invalidated ) {
        invalidate_handles();
    }
    return detail::make_npc_dialogue_result( state, result );
}

sol::table open_npc_rules(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_ai_rules_snapshot before_snapshot = capture_ai_rules( *entry );
    sol::table before = snapshot_ai_rules( state, before_snapshot );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    follower_rules_ui rules_ui;
    rules_ui.draw_follower_rules_ui( entry );
    entry = resolve_exact_npc(
                handle, runtime_generation, world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const npc_ai_rules_snapshot after = capture_ai_rules( *entry );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_ai_rules( state, after );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_control_menu(
    sol::this_state lua,
    const game_handle &avatar_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &invalidate_handles )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    avatar *player = resolve_exact_avatar(
                         avatar_handle, runtime_generation,
                         world_generation, error );
    if( player == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::int64_t speaker_id_before =
        player->getID().get_value();
    player->control_npc_menu();
    const std::int64_t speaker_id_after =
        player->getID().get_value();
    const bool changed = speaker_id_before != speaker_id_after;
    if( changed ) {
        invalidate_handles();
    }
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["speaker_id_before"] = speaker_id_before;
    value["speaker_id_after"] = speaker_id_after;
    value["handles_invalidated"] = changed;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table take_control_of_npc(
    sol::this_state lua, const game_handle &handle,
    const game_handle &avatar_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::function<void()> &require_write,
    const std::function<void()> &invalidate_handles,
    const std::function<game_handle_runtime()> &current_runtime_generation,
    const std::function<std::size_t()> &current_world_generation )
{
    require_write();
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = nullptr;
    avatar *owner = nullptr;
    if( !resolve_exact_npc_with_avatar_owner(
            handle, avatar_handle, runtime_generation, world_generation,
            entry, owner, error ) ) {
        return make_game_error_result( state, *error );
    }
    if( !entry->is_player_ally() ) {
        return make_game_error_result( state, {
            "not_an_ally",
            "services.npcs.take_control requires an allied NPC"
        } );
    }
    if( g == nullptr ) {
        return make_game_error_result( state, {
            "world_unavailable",
            "services.npcs.take_control requires an active game world"
        } );
    }
    const std::int64_t controlled_id =
        entry->getID().get_value();
    const std::string controlled_name = entry->get_name();
    owner->control_npc( *entry );

    // control_npc swaps native Character storage and logical identities.
    // Invalidate every pre-swap handle instead of allowing a safe_reference
    // to silently resolve to a different logical character.
    invalidate_handles();
    const tripoint_abs_ms position = owner->pos_abs();
    const game_handle new_avatar_handle = game_handle::from_creature(
    *owner, {
        "avatar", owner->getID().get_value(),
        position.x(), position.y(), position.z(), {}
    }, current_runtime_generation(), current_world_generation() );
    sol::table value = state.create_table();
    value["avatar"] = new_avatar_handle;
    value["controlled_id"] = controlled_id;
    value["controlled_name"] = controlled_name;
    value["handles_invalidated"] = true;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

sol::table detail::make_npc_dialogue_result(
    sol::state_view state, const avatar_talk_to_result result )
{
    sol::table value = state.create_table();
    switch( result ) {
        case avatar_talk_to_result::completed:
            value["status"] = "completed";
            value["started"] = true;
            value["completed"] = true;
            break;
        case avatar_talk_to_result::rejected:
            value["status"] = "rejected";
            value["started"] = false;
            value["completed"] = false;
            break;
        case avatar_talk_to_result::not_started:
            value["status"] = "not_started";
            value["started"] = false;
            value["completed"] = false;
            break;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

void install_npc_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<void()> invalidate_handles )
{
    sol::state_view lua( services.lua_state() );
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
        "visible_allies",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state ) {
        require_read();
        return visible_player_allies(
                   lua_state, current_runtime_generation(), current_world_generation() );
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
    const std::string & unique_id ) {
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
            const game_handle & origin,
            const std::string & role,
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
            const game_handle & origin,
            const script_game_id & npc_class,
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
            sol::this_state lua_state, const game_handle & handle,
    const int amount ) {
        require_write();
        return add_npc_debt(
                   lua_state, handle, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "add_faction_rep",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const int amount ) {
        require_write();
        return add_npc_faction_rep(
                   lua_state, handle, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_class",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & npc_class ) {
        require_write();
        return set_npc_class(
                   lua_state, handle, npc_class,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_faction",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & faction ) {
        require_write();
        return set_npc_faction(
                   lua_state, handle, faction,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_first_topic",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & topic ) {
        require_write();
        return set_npc_first_topic(
                   lua_state, handle, topic,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_radio_representative",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const game_handle & avatar_handle,
    const bool enabled ) {
        return set_npc_radio_representative(
                   lua_state, handle, avatar_handle, enabled,
                   current_runtime_generation(), current_world_generation(),
                   require_write );
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
            sol::this_state lua_state, const game_handle & handle,
    const std::string & family, const std::string & rule ) {
        require_write();
        return set_npc_ai_policy(
                   lua_state, handle, family, rule,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_ally_rule",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & rule, const sol::optional<bool> &enabled ) {
        require_write();
        return set_npc_ally_rule(
                   lua_state, handle, rule, enabled,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "set_ally_override",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & rule, const std::string & state ) {
        require_write();
        return set_npc_ally_override(
                   lua_state, handle, rule, state,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "copy_ai_rules",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & target,
    const game_handle & source ) {
        require_write();
        return copy_npc_ai_rules(
                   lua_state, target, source,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "make_thankful",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return make_npc_thankful(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "record_refusal",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & request ) {
        require_write();
        return record_npc_refusal(
                   lua_state, handle, request,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "follow_temporarily",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_FOLLOW, false, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "stop_temporary_following",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_NULL, false, true,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "make_neutral",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_NULL, true, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "start_fleeing",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_FLEE, false, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "start_mugging",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return set_npc_relationship_state(
                   lua_state, handle, NPCATT_MUG, false, false,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "join_player",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const game_handle & avatar_handle ) {
        return join_npc_to_player(
                   lua_state, handle, avatar_handle,
                   current_runtime_generation(), current_world_generation(),
                   require_write );
    } );
    npcs.set_function(
        "leave_player",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const game_handle & avatar_handle ) {
        return leave_npc_player(
                   lua_state, handle, avatar_handle,
                   current_runtime_generation(), current_world_generation(),
                   require_write );
    } );
    npcs.set_function(
        "set_guarding",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const bool enabled ) {
        require_write();
        return set_npc_guarding(
                   lua_state, handle, enabled,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "request_talk",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return request_npc_talk( lua_state, handle,
                                 current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "become_hostile",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return make_npc_hostile(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "warn_player_departure",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return set_npc_departure_warning(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "clear_stolen_item_claim",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return clear_npc_stolen_item_claim(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    npcs.set_function(
        "destinations",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return list_npc_destinations(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "plan_travel",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_tripoint_coord & goal ) {
        require_read();
        return plan_npc_travel(
                   lua_state, handle, goal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_goal",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_tripoint_coord & goal ) {
        require_write();
        return set_npc_goal(
                   lua_state, handle, goal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "lead_to",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_tripoint_coord & goal ) {
        require_write();
        return set_npc_leading_goal(
                   lua_state, handle, goal,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_guard_position",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_tripoint_coord & position ) {
        require_write();
        return set_npc_guard_position(
                   lua_state, handle, position,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "companion_state",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_npc_companion_state(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "set_companion_role",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & role ) {
        require_write();
        return set_npc_companion_role(
                   lua_state, handle, role,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "open_companion_missions",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & role ) {
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
            const game_handle & recipient,
            const game_handle & giver,
            const game_handle & item,
    const sol::optional<bool> &use_item ) {
        require_write();
        return offer_item_to_npc(
                   lua_state, recipient, giver, item,
                   use_item.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "open_dialogue",
        [current_runtime_generation, current_world_generation,
                                     require_write, invalidate_handles](
            sol::this_state lua_state, const game_handle & handle,
            const game_handle & speaker,
    const std::string & topic ) {
        require_write();
        return open_npc_dialogue(
                   lua_state, handle, speaker, topic,
                   current_runtime_generation(),
                   current_world_generation(),
                   invalidate_handles );
    } );
    npcs.set_function(
        "open_rules",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle ) {
        require_write();
        return open_npc_rules(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs.set_function(
        "open_control_menu",
        [current_runtime_generation, current_world_generation,
                                     require_write, invalidate_handles](
    sol::this_state lua_state, const game_handle & avatar_handle ) {
        require_write();
        return open_npc_control_menu(
                   lua_state, avatar_handle,
                   current_runtime_generation(),
                   current_world_generation(), invalidate_handles );
    } );
    npcs.set_function(
        "take_control",
        [current_runtime_generation, current_world_generation,
                                     require_write, invalidate_handles](
            sol::this_state lua_state, const game_handle & handle,
    const game_handle & avatar_handle ) {
        return take_control_of_npc(
                   lua_state, handle, avatar_handle,
                   current_runtime_generation(),
                   current_world_generation(),
                   require_write,
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
        const npc *entry = resolve_exact_npc(
                               handle, current_runtime_generation(),
                               current_world_generation(), error );
        if( entry == nullptr ) {
            return make_game_error_result( lua_state, *error );
        }
        sol::state_view state( lua_state );
        const npc_ai_rules_snapshot snapshot = capture_ai_rules( *entry );
        return make_game_value_result(
                   state, sol::make_object(
                       state, snapshot_ai_rules( state, snapshot ) ) );
    } );
    install_npc_domain_services(
        npcs, current_runtime_generation,
        current_world_generation,
        require_read, require_write );
    services["npcs"] = std::move( npcs );

}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
