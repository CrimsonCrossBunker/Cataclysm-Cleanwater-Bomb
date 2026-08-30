#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_npc_services.h"

#include <character_id.h>
#include <dialogue_chatbin.h>
extern "C" {
#include <lua.h>
}
#include <npc_opinion.h>
#include <pimpl.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <iterator>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "auto_pickup.h"
#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "character.h"
#include "character_martial_arts.h"
#include "creature.h"
#include "faction.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_missions.h"
#include "mission.h"
#include "npc.h"
#include "npctalk.h"
#include "npctrade.h"
#include "player_activity.h"
#include "type_id.h"

namespace cata::lua_platform
{

namespace
{

const efftype_id effect_bite( "bite" );
const efftype_id effect_bleed( "bleed" );
const efftype_id effect_currently_busy( "currently_busy" );
const efftype_id effect_infected( "infected" );
constexpr std::size_t maximum_npc_mission_results = 256;
constexpr std::size_t maximum_training_students = 64;

bool integer_addition_fits( const int current, const int delta ) noexcept
{
    const std::int64_t result =
        static_cast<std::int64_t>( current ) +
        static_cast<std::int64_t>( delta );
    return result >= std::numeric_limits<int>::min() &&
           result <= std::numeric_limits<int>::max();
}

void commit_generic_mission_reward(
    mission &entry, npc &provider, const int owed_after ) noexcept
{
    provider.op_of_u.owed = owed_after;
    entry.commit_generic_reward_claim();
}

sol::table character_service_state(
    sol::state_view lua, Character &character )
{
    std::int64_t hp = 0;
    std::int64_t maximum_hp = 0;
    for( const bodypart_id &part : character.get_all_body_parts(
             get_body_part_flags::only_main ) ) {
        hp += character.get_part_hp_cur( part );
        maximum_hp += character.get_part_hp_max( part );
    }
    sol::table result = lua.create_table();
    result["id"] = character.getID().get_value();
    result["name"] = character.get_name();
    result["avatar"] = character.is_avatar();
    result["hp"] = hp;
    result["maximum_hp"] = maximum_hp;
    result["bionics"] = character.num_bionics();
    result["mutations"] = character.get_mutations().size();
    result["mounted"] = character.is_mounted();
    result["bleeding"] = character.has_effect( effect_bleed );
    result["bitten"] = character.has_effect( effect_bite );
    result["infected"] = character.has_effect( effect_infected );
    result["inventory_stacks"] = character.inv_dump().size();
    if( character.activity ) {
        result["activity"] = script_game_id(
                                 "activity",
                                 character.activity.id().str() );
    } else {
        result["activity"] = sol::nil;
    }
    return result;
}

sol::table provider_service_state(
    sol::state_view lua, npc &provider )
{
    sol::table result = character_service_state(
                            lua, provider );
    result["owed"] = provider.op_of_u.owed;
    result["attitude"] = static_cast<int>(
                             provider.get_attitude() );
    result["busy_turns"] = to_turns<std::int64_t>(
                               provider.get_effect_dur(
                                   effect_currently_busy ) );
    result["current_activity"] =
        provider.get_current_activity();
    return result;
}

Character *resolve_npc_service_character(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const bool avatar_only,
    std::optional<game_handle_error> &error )
{
    if( avatar_only ) {
        return resolve_exact_avatar(
                   handle, runtime_generation, world_generation, error );
    }
    Character *result = resolve_exact_character(
                            handle, runtime_generation,
                            world_generation, error );
    if( result == nullptr ) {
        return nullptr;
    }
    error.reset();
    return result;
}

sol::table provide_medical_aid(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle &patient_handle,
    const std::string &level, const bool include_allies,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( level != "basic" && level != "advanced" ) {
        throw std::invalid_argument(
            "services.npcs.medical.provide_aid level must be basic or advanced" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *patient_target = resolve_npc_service_character(
                                    patient_handle, runtime_generation,
                                    world_generation, true, error );
    if( patient_target == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &patient = *patient_target->as_avatar();
    sol::table patient_before = character_service_state(
                                    state, patient );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    if( level == "advanced" ) {
        if( include_allies ) {
            talk_function::give_all_aid( *provider );
        } else {
            talk_function::give_aid( *provider );
        }
    } else if( include_allies ) {
        talk_function::lesser_give_all_aid( *provider );
    } else {
        talk_function::lesser_give_aid( *provider );
    }
    sol::table value = state.create_table();
    value["level"] = level;
    value["include_allies"] = include_allies;
    value["patient_before"] = std::move( patient_before );
    value["patient_after"] = character_service_state(
                                 state, patient );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_bionic_service(
    sol::this_state lua, const game_handle &provider_handle,
    const std::string &operation,
    const game_handle &patient_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( operation != "install" && operation != "remove" ) {
        throw std::invalid_argument(
            "services.npcs.medical.open_bionic_service operation must be install or remove" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *patient = resolve_exact_character(
                             patient_handle, runtime_generation,
                             world_generation, error );
    if( patient == nullptr ) {
        return make_game_error_result( state, *error );
    }
    npc *patient_npc = patient->as_npc();
    if( !patient->is_avatar() &&
        ( patient_npc == nullptr || !patient_npc->is_player_ally() ) ) {
        return make_game_error_result( state, {
            "invalid_patient",
            "Bionic service patients must be the avatar or an allied NPC"
        } );
    }
    if( patient == provider ) {
        return make_game_error_result( state, {
            "invalid_patient",
            "A bionic service provider cannot operate on themselves"
        } );
    }
    sol::table patient_before = character_service_state(
                                    state, *patient );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    const int bionics_before = patient->num_bionics();
    if( operation == "install" ) {
        talk_function::bionic_install( *provider, *patient );
    } else {
        talk_function::bionic_remove( *provider, *patient );
    }
    sol::table value = state.create_table();
    value["operation"] = operation;
    value["changed"] =
        bionics_before != patient->num_bionics();
    value["patient_before"] = std::move( patient_before );
    value["patient_after"] = character_service_state(
                                 state, *patient );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table repair_bionic_limbs_with_provider(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle &patient_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *patient_target = resolve_npc_service_character(
                                    patient_handle, runtime_generation,
                                    world_generation, true, error );
    if( patient_target == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &patient = *patient_target->as_avatar();
    sol::table patient_before = character_service_state(
                                    state, patient );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    talk_function::repair_bionic_limbs( *provider );
    sol::table value = state.create_table();
    value["patient_before"] = std::move( patient_before );
    value["patient_after"] = character_service_state(
                                 state, patient );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_grooming_style(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle &client_handle,
    const std::string &area,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( area != "hair" && area != "beard" ) {
        throw std::invalid_argument(
            "services.npcs.grooming.open_style area must be hair or beard" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *client_target = resolve_npc_service_character(
                                   client_handle, runtime_generation,
                                   world_generation, true, error );
    if( client_target == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &client = *client_target->as_avatar();
    const std::size_t mutations_before =
        client.get_mutations().size();
    if( area == "hair" ) {
        talk_function::barber_hair( *provider );
    } else {
        talk_function::barber_beard( *provider );
    }
    sol::table value = state.create_table();
    value["area"] = area;
    value["completed"] = true;
    value["mutation_count_before"] = mutations_before;
    value["mutation_count_after"] =
        client.get_mutations().size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table provide_grooming(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle &client_handle,
    const std::string &service,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( service != "haircut" && service != "shave" ) {
        throw std::invalid_argument(
            "services.npcs.grooming.provide service must be haircut or shave" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *client_target = resolve_npc_service_character(
                                   client_handle, runtime_generation,
                                   world_generation, true, error );
    if( client_target == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar &client = *client_target->as_avatar();
    sol::table before = character_service_state(
                            state, client );
    if( service == "haircut" ) {
        talk_function::buy_haircut( *provider );
    } else {
        talk_function::buy_shave( *provider );
    }
    sol::table value = state.create_table();
    value["service"] = service;
    value["before"] = std::move( before );
    value["after"] = character_service_state(
                         state, client );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

bool contains_mission(
    const std::vector<mission *> &missions,
    const mission *candidate )
{
    return std::find(
               missions.begin(), missions.end(), candidate ) !=
           missions.end();
}

bool live_mission_pointer( const mission *candidate )
{
    if( candidate == nullptr ) {
        return false;
    }
    const std::vector<mission *> live = mission::get_all_active();
    return contains_mission( live, candidate );
}

mission *first_live_mission(
    const std::vector<mission *> &missions,
    const character_id &provider_id )
{
    for( mission *entry : missions ) {
        if( live_mission_pointer( entry ) &&
            entry->get_npc_id() == provider_id ) {
            return entry;
        }
    }
    return nullptr;
}

bool rollback_new_assigned_mission( mission *entry, avatar &owner )
{
    if( entry == nullptr || !entry->is_assigned() ) {
        return true;
    }
    if( entry->get_assigned_player_id() != owner.getID() ||
        !entry->in_progress() ||
        !contains_mission( owner.get_active_missions(), entry ) ) {
        return false;
    }
    const int uid = entry->get_id();
    owner.remove_active_mission( *entry );
    return mission::find( uid, true ) == nullptr;
}

std::string mission_service_status( const mission &entry )
{
    if( entry.has_failed() ) {
        return "failure";
    }
    if( entry.in_progress() ) {
        return "active";
    }
    if( !entry.is_assigned() ) {
        return "available";
    }
    return "success";
}

sol::table npc_mission_state(
    sol::state_view lua, const mission &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["token"] = mission_token(
                          entry.get_id(), entry.identity_generation(),
                          runtime_generation,
                          world_generation );
    result["uid"] = entry.get_id();
    result["id"] = script_game_id(
                       "mission", entry.mission_id().str() );
    result["name"] = entry.name();
    result["status"] = mission_service_status( entry );
    result["assigned"] = entry.is_assigned();
    result["in_progress"] = entry.in_progress();
    result["failed"] = entry.has_failed();
    result["has_generic_rewards"] =
        entry.has_generic_rewards();
    result["generic_reward_claimed"] =
        entry.generic_reward_claimed();
    if( entry.has_follow_up() ) {
        result["follow_up"] = script_game_id(
                                  "mission",
                                  entry.get_follow_up().str() );
    } else {
        result["follow_up"] = sol::nil;
    }
    return result;
}

sol::table npc_mission_collection(
    sol::state_view lua, const std::vector<mission *> &source,
    const character_id &provider_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::size_t capacity = std::min(
                                     source.size(), maximum_npc_mission_results );
    sol::table items = lua.create_table(
                           static_cast<int>( capacity ), 0 );
    std::size_t total = 0;
    std::size_t output = 0;
    for( mission *entry : source ) {
        if( !live_mission_pointer( entry ) ||
            entry->get_npc_id() != provider_id ) {
            continue;
        }
        ++total;
        if( output >= maximum_npc_mission_results ) {
            continue;
        }
        items[output + 1] = npc_mission_state(
                                lua, *entry,
                                runtime_generation,
                                world_generation );
        ++output;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = output;
    result["truncated"] = output < total;
    return result;
}

sol::table npc_mission_provider_state(
    sol::state_view lua, const npc &provider,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["provider_id"] = provider.getID().get_value();
    result["available"] = npc_mission_collection(
                              lua, provider.chatbin.missions,
                              provider.getID(),
                              runtime_generation,
                              world_generation );
    result["assigned"] = npc_mission_collection(
                             lua, provider.chatbin.missions_assigned,
                             provider.getID(),
                             runtime_generation,
                             world_generation );
    const std::size_t selected_available_count = static_cast<std::size_t>(
                std::count( provider.chatbin.missions.begin(),
                            provider.chatbin.missions.end(),
                            provider.chatbin.mission_selected ) );
    const std::size_t selected_assigned_count = static_cast<std::size_t>(
                std::count( provider.chatbin.missions_assigned.begin(),
                            provider.chatbin.missions_assigned.end(),
                            provider.chatbin.mission_selected ) );
    if( !live_mission_pointer( provider.chatbin.mission_selected ) ) {
        result["selected"] = sol::nil;
        result["selected_stale"] =
            provider.chatbin.mission_selected != nullptr;
    } else if(
        provider.chatbin.mission_selected->get_npc_id() != provider.getID() ||
        selected_available_count + selected_assigned_count != 1 ) {
        result["selected"] = sol::nil;
        result["selected_invalid"] = true;
    } else {
        result["selected"] = npc_mission_state(
                                 lua,
                                 *provider.chatbin.mission_selected,
                                 runtime_generation,
                                 world_generation );
    }
    return result;
}

mission *resolve_mission_token(
    const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( !token.belongs_to( runtime_generation ) ) {
        error = game_handle_error{
            "stale_runtime",
            "MissionToken belongs to an inactive or different Lua runtime"
        };
        return nullptr;
    }
    if( token.world_generation() != world_generation ) {
        error = game_handle_error{
            "stale_world",
            "MissionToken belongs to a different world generation"
        };
        return nullptr;
    }
    mission *entry = mission::find( token.uid(), true );
    if( entry == nullptr ) {
        error = game_handle_error{
            "missing_mission",
            "The mission referenced by this MissionToken no longer exists"
        };
        return nullptr;
    }
    if( entry->identity_generation() != token.identity_generation() ) {
        error = game_handle_error{
            "stale_mission",
            "The MissionToken refers to a retired mission instance"
        };
        return nullptr;
    }
    error.reset();
    return entry;
}

sol::table get_npc_mission_provider_state(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, npc_mission_provider_state(
                       state, *provider,
                       runtime_generation,
                       world_generation ) ) );
}

sol::table select_npc_mission(
    sol::this_state lua, const game_handle &provider_handle,
    const mission_token &token,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    mission *selected = resolve_mission_token(
                            token, runtime_generation,
                            world_generation, error );
    if( selected == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::size_t available_count = static_cast<std::size_t>(
                                            std::count(
                                                    provider->chatbin.missions.begin(),
                                                    provider->chatbin.missions.end(),
                                                    selected ) );
    const std::size_t assigned_count = static_cast<std::size_t>(
                                           std::count(
                                                   provider->chatbin.missions_assigned.begin(),
                                                   provider->chatbin.missions_assigned.end(),
                                                   selected ) );
    const bool selected_belongs_to_provider =
        selected->get_npc_id() == provider->getID();
    if( !selected_belongs_to_provider ||
        available_count + assigned_count != 1 ) {
        return make_game_error_result( state, {
            !selected_belongs_to_provider ? "not_provided_here" :
            "invalid_selection",
            !selected_belongs_to_provider ?
            "The mission is not available or assigned through this NPC" :
            "The mission has ambiguous collection membership for this NPC"
        } );
    }
    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    provider->chatbin.mission_selected = selected;
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table offer_npc_mission(
    sol::this_state lua, const game_handle &provider_handle,
    const script_game_id &requested_mission,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_mission.kind() != "mission" ||
        !requested_mission.is_valid() ) {
        throw std::invalid_argument(
            "services.npcs.missions.offer requires a valid GameId<mission>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    mission *created = mission::reserve_new(
                           mission_type_id(
                               requested_mission.value() ),
                           provider->getID() );
    if( created == nullptr ) {
        return make_game_error_result( state, {
            "rejected",
            "The engine rejected the NPC mission offer"
        } );
    }
    std::vector<mission *> available_after =
        provider->chatbin.missions;
    try {
        available_after.push_back( created );
    } catch( const std::exception & ) {
        const bool rolled_back = mission::remove_unassigned( created->get_id() );
        return make_game_error_result( state, {
            rolled_back ? "rejected" : "rollback_failed",
            rolled_back ? "The NPC mission offer could not be staged" :
            "The NPC mission offer could not be staged and rollback failed"
        } );
    }
    provider->chatbin.missions.swap( available_after );
    sol::table value = state.create_table();
    value["mission"] = npc_mission_state(
                           state, *created,
                           runtime_generation,
                           world_generation );
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table run_selected_npc_mission_action(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle &owner_handle,
    const std::string &action, const bool force,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar *owner = resolve_exact_avatar(
                        owner_handle, runtime_generation,
                        world_generation, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( action != "assign" && action != "success" &&
        action != "failure" && action != "clear" &&
        action != "reward" ) {
        throw std::invalid_argument(
            "Unknown NPC mission action" );
    }
    mission *selected = provider->chatbin.mission_selected;
    if( !live_mission_pointer( selected ) ) {
        return make_game_error_result( state, {
            selected == nullptr ? "no_selected_mission" : "stale_mission",
            selected == nullptr ?
            "The NPC has no selected dialogue mission" :
            "The NPC selected mission no longer exists"
        } );
    }
    const bool available = contains_mission(
                               provider->chatbin.missions, selected );
    const bool assigned = contains_mission(
                              provider->chatbin.missions_assigned,
                              selected );
    const std::size_t available_count = static_cast<std::size_t>(
                                            std::count(
                                                    provider->chatbin.missions.begin(),
                                                    provider->chatbin.missions.end(),
                                                    selected ) );
    const std::size_t assigned_count = static_cast<std::size_t>(
                                           std::count(
                                                   provider->chatbin.missions_assigned.begin(),
                                                   provider->chatbin.missions_assigned.end(),
                                                   selected ) );
    if( selected->get_npc_id() != provider->getID() ) {
        return make_game_error_result( state, {
            "not_provided_here",
            "The selected mission is not provided by this NPC"
        } );
    }
    if( ( !available && !assigned ) ||
        available_count > 1 || assigned_count > 1 ||
        ( available && assigned ) ) {
        return make_game_error_result( state, {
            "invalid_selection",
            "The NPC selected mission has invalid or ambiguous collection membership"
        } );
    }
    if( action == "assign" ) {
        if( !available || selected->is_assigned() ) {
            return make_game_error_result( state, {
                "not_available",
                "Only an available unassigned mission can be assigned"
            } );
        }
    } else {
        if( !assigned || !selected->is_assigned() ) {
            return make_game_error_result( state, {
                "not_assigned",
                "The selected mission is not assigned through this NPC"
            } );
        }
        if( selected->get_assigned_player_id() !=
            owner->getID() ) {
            return make_game_error_result( state, {
                "wrong_assignee",
                "The selected mission is assigned to another character"
            } );
        }
    }
    bool goal_complete = false;
    if( action == "success" ) {
        if( !selected->in_progress() ) {
            return make_game_error_result( state, {
                "not_active",
                "Only an active selected mission can succeed"
            } );
        }
        goal_complete = selected->is_complete(
                            provider->getID(), *owner );
        if( !goal_complete && !force ) {
            return make_game_error_result( state, {
                "goal_incomplete",
                "The selected mission goal is incomplete; pass force=true for an explicit override"
            } );
        }
    } else if( action == "failure" ) {
        if( !selected->in_progress() ) {
            return make_game_error_result( state, {
                "not_active",
                "Only an active selected mission can fail"
            } );
        }
    } else if( action == "reward" ) {
        if( selected->in_progress() || selected->has_failed() ) {
            return make_game_error_result( state, {
                "not_successful",
                "Only a successful selected mission can grant its generic reward"
            } );
        }
        if( !selected->has_generic_rewards() ) {
            return make_game_error_result( state, {
                "no_generic_reward",
                "The selected mission does not provide a generic NPC reward"
            } );
        }
        if( selected->generic_reward_claimed() ) {
            return make_game_error_result( state, {
                "already_claimed",
                "The selected mission generic reward was already claimed"
            } );
        }
    }

    // The selected mission finalizers below are native void operations.  Do
    // every validation which can fail before entering one of them.  Success
    // and failure publish only non-throwing scalar opinion changes after the
    // finalizer commits.
    const int reward_value = selected->get_value();
    int reward_owed_after = provider->op_of_u.owed;
    if( action == "reward" ) {
        const std::int64_t owed_after =
            static_cast<std::int64_t>( provider->op_of_u.owed ) +
            static_cast<std::int64_t>( reward_value );
        if( owed_after < std::numeric_limits<int>::min() ||
            owed_after > std::numeric_limits<int>::max() ) {
            return make_game_error_result( state, {
                "reward_overflow",
                "The NPC reward would overflow its owed-value state"
            } );
        }
        reward_owed_after = static_cast<int>( owed_after );
    }

    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    sol::table provider_before = provider_service_state(
                                     state, *provider );
    const int owed_before = provider->op_of_u.owed;
    if( action == "assign" ) {
        std::vector<mission *> available_after;
        std::vector<mission *> assigned_after;
        try {
            available_after = provider->chatbin.missions;
            const auto available = std::find(
                                       available_after.begin(),
                                       available_after.end(), selected );
            if( available == available_after.end() ) {
                return make_game_error_result( state, {
                    "invalid_selection",
                    "The selected mission disappeared before assignment"
                } );
            }
            available_after.erase( available );
            assigned_after = provider->chatbin.missions_assigned;
            assigned_after.push_back( selected );
        } catch( const std::exception & ) {
            return make_game_error_result( state, {
                "rejected", "The NPC mission assignment could not be staged"
            } );
        }

        // Assignment is the only potentially rejecting native operation.  It
        // runs before the no-throw vector publication, so a rejected or
        // throwing assignment leaves the provider collections unchanged.
        try {
            selected->assign( *owner );
        } catch( ... ) {
            // This mission already belongs to the provider's available
            // collection.  Removing it from the global mission table would
            // leave that collection dangling, and mission::assign has no
            // inverse for its start callback.  Report the boundary honestly
            // if the native finalizer ever throws after changing state.
            const bool rolled_back = !selected->is_assigned();
            return make_game_error_result( state, {
                rolled_back ? "rejected" : "rollback_failed",
                rolled_back ? "The engine rejected NPC mission assignment" :
                "NPC mission assignment failed and rollback failed"
            } );
        }
        if( !selected->is_assigned() ||
            selected->get_assigned_player_id() != owner->getID() ) {
            const bool rolled_back = !selected->is_assigned();
            return make_game_error_result( state, {
                rolled_back ? "rejected" : "rollback_failed",
                rolled_back ? "The engine rejected NPC mission assignment" :
                "NPC mission assignment failed and rollback failed"
            } );
        }
        // Vector swaps use the native default allocator and are non-throwing.
        provider->chatbin.missions.swap( available_after );
        provider->chatbin.missions_assigned.swap( assigned_after );
    } else if( action == "success" ) {
        const int mission_value = npc_trading::cash_to_favor(
                                      *provider, selected->get_value() );
        npc_opinion opinion;
        opinion.value = 1 + mission_value / 5;
        opinion.anger = -1;
        faction *provider_faction = provider->get_faction();
        const int faction_value = std::min(
                                      1 + mission_value / 10, 10 );

        if( !integer_addition_fits( provider->op_of_u.value, opinion.value ) ||
            !integer_addition_fits( provider->op_of_u.anger, opinion.anger ) ||
            ( provider_faction != nullptr && (
                  !integer_addition_fits( provider_faction->likes_u, faction_value ) ||
                  !integer_addition_fits( provider_faction->respects_u, faction_value ) ||
                  !integer_addition_fits( provider_faction->trusts_u, faction_value ) ||
                  !integer_addition_fits( provider_faction->power, faction_value ) ) ) ) {
            return make_game_error_result( state, {
                "rejected",
                "The NPC mission success state cannot be committed without overflow"
            } );
        }

        // The native finalizer is the single irreversible commit for mission
        // completion.  All checks which can reject have happened above; the
        // scalar opinion/faction publication below is non-throwing.
        selected->wrap_up( *owner );
        provider->op_of_u += opinion;
        if( provider_faction != nullptr ) {
            provider_faction->likes_u += faction_value;
            provider_faction->respects_u += faction_value;
            provider_faction->trusts_u += faction_value;
            provider_faction->power += faction_value;
        }
    } else if( action == "failure" ) {
        npc_opinion opinion;
        opinion.trust = -1;
        opinion.value = -1;
        opinion.anger = 1;
        if( !integer_addition_fits( provider->op_of_u.trust, opinion.trust ) ||
            !integer_addition_fits( provider->op_of_u.value, opinion.value ) ||
            !integer_addition_fits( provider->op_of_u.anger, opinion.anger ) ) {
            return make_game_error_result( state, {
                "rejected",
                "The NPC mission failure state cannot be committed without overflow"
            } );
        }
        selected->fail( *owner );
        provider->op_of_u += opinion;
    } else if( action == "clear" ) {
        if( selected->in_progress() ) {
            return make_game_error_result( state, {
                "not_finished",
                "Only a finished selected mission can be cleared"
            } );
        }
        const auto assigned_iterator = std::find(
                                           provider->chatbin.missions_assigned.begin(),
                                           provider->chatbin.missions_assigned.end(), selected );
        if( assigned_iterator == provider->chatbin.missions_assigned.end() ) {
            return make_game_error_result( state, {
                "invalid_selection",
                "The selected mission is not in the assigned collection"
            } );
        }
        mission *follow_up = nullptr;
        if( selected->has_follow_up() ) {
            follow_up = mission::reserve_new(
                            selected->get_follow_up(), provider->getID() );
            if( follow_up == nullptr ) {
                return make_game_error_result( state, {
                    "rejected", "The engine rejected the follow-up mission"
                } );
            }
        }
        std::vector<mission *> assigned_after;
        std::vector<mission *> available_after;
        try {
            assigned_after = provider->chatbin.missions_assigned;
            assigned_after.erase(
                assigned_after.begin() +
                std::distance( provider->chatbin.missions_assigned.begin(),
                               assigned_iterator ) );
            available_after = provider->chatbin.missions;
            if( follow_up != nullptr ) {
                available_after.push_back( follow_up );
            }
        } catch( const std::exception & ) {
            const bool rolled_back = follow_up == nullptr ||
                                     mission::remove_unassigned( follow_up->get_id() );
            return make_game_error_result( state, {
                rolled_back ? "rejected" : "rollback_failed",
                rolled_back ? "The selected mission clear could not be staged" :
                "The selected mission clear could not be staged and rollback failed"
            } );
        }
        provider->chatbin.missions_assigned.swap( assigned_after );
        provider->chatbin.missions.swap( available_after );
        if( provider->chatbin.missions_assigned.empty() ) {
            provider->chatbin.mission_selected = first_live_mission(
                    provider->chatbin.missions, provider->getID() );
        } else {
            provider->chatbin.mission_selected = first_live_mission(
                    provider->chatbin.missions_assigned, provider->getID() );
        }
    } else {
        commit_generic_mission_reward(
            *selected, *provider, reward_owed_after );
    }

    // This section only materializes detached Lua result data.  In
    // particular, it must not perform a recovery write after assign/success/
    // failure has reached its native terminal finalizer.
    sol::table value = state.create_table();
    value["action"] = action;
    value["owner"] = owner_handle;
    value["forced"] = action == "success" && force &&
                      !goal_complete;
    value["owed_delta"] = provider->op_of_u.owed - owed_before;
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    value["provider_before"] = std::move( provider_before );
    value["provider_after"] = provider_service_state(
                                  state, *provider );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table finish_npc_dialogue(
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
    const std::string topic_before =
        entry->chatbin.first_topic;
    const npc_attitude attitude_before =
        entry->get_attitude();
    talk_function::end_conversation( *entry );
    sol::table value = state.create_table();
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["attitude_before"] = static_cast<int>( attitude_before );
    value["attitude_after"] = static_cast<int>(
                                  entry->get_attitude() );
    value["changed"] = topic_before != entry->chatbin.first_topic;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table provoke_npc_combat(
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
    const std::string topic_before =
        entry->chatbin.first_topic;
    const npc_attitude attitude_before =
        entry->get_attitude();
    talk_function::insult_combat( *entry );
    sol::table value = state.create_table();
    value["topic_before"] = topic_before;
    value["topic_after"] = entry->chatbin.first_topic;
    value["attitude_before"] = static_cast<int>( attitude_before );
    value["attitude_after"] = static_cast<int>(
                                  entry->get_attitude() );
    value["hostile"] = entry->get_attitude() == NPCATT_KILL;
    value["changed"] = topic_before != entry->chatbin.first_topic ||
                       attitude_before != entry->get_attitude();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table run_npc_order(
    sol::this_state lua, const game_handle &handle,
    const std::string &order,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    static const std::set<std::string> known_orders = {
        "dismount", "drop_carried_items", "drop_weapon",
        "wake", "clear_temporary_rules", "lead_to_safety"
    };
    if( known_orders.count( order ) == 0 ) {
        throw std::invalid_argument(
            "services.npcs.orders.run received an unknown order" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_exact_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = provider_service_state(
                            state, *entry );
    const bool mounted_before = entry->is_mounted();
    const bool armed_before = entry->has_weapon();
    if( order == "drop_weapon" && !armed_before ) {
        return make_game_error_result( state, {
            "unarmed", "The NPC has no wielded weapon to drop"
        } );
    }
    if( order == "dismount" ) {
        talk_function::dismount( *entry );
    } else if( order == "drop_carried_items" ) {
        talk_function::drop_items_in_place( *entry );
    } else if( order == "drop_weapon" ) {
        talk_function::drop_weapon( *entry );
    } else if( order == "wake" ) {
        talk_function::wake_up( *entry );
    } else if( order == "clear_temporary_rules" ) {
        talk_function::clear_overrides( *entry );
    } else {
        talk_function::lead_to_safety( *entry );
    }
    sol::table value = state.create_table();
    value["order"] = order;
    value["mounted_before"] = mounted_before;
    value["mounted_after"] = entry->is_mounted();
    value["armed_before"] = armed_before;
    value["armed_after"] = entry->has_weapon();
    value["before"] = std::move( before );
    value["after"] = provider_service_state(
                         state, *entry );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_pickup_rules(
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
    if( !entry->is_player_ally() ) {
        return make_game_error_result( state, {
            "not_an_ally",
            "services.npcs.orders.open_pickup_rules requires an allied NPC"
        } );
    }
    const bool before = !entry->rules.pickup_whitelist->empty();
    talk_function::set_npc_pickup( *entry );
    sol::table value = state.create_table();
    value["had_rules_before"] = before;
    value["has_rules_after"] =
        !entry->rules.pickup_whitelist->empty();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table choose_npc_combat_style(
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
    const matype_id before =
        entry->martial_arts_data->selected_style();
    talk_function::pick_style( *entry );
    const matype_id after =
        entry->martial_arts_data->selected_style();
    sol::table value = state.create_table();
    value["changed"] = before != after;
    value["before"] = script_game_id(
                          "martial_art", before.str() );
    value["after"] = script_game_id(
                         "martial_art", after.str() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table open_npc_character_sheet(
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
    talk_function::reveal_stats( *entry );
    sol::table value = state.create_table();
    value["completed"] = true;
    value["npc_id"] = entry->getID().get_value();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

template<typename Id>
sol::table training_ids(
    sol::state_view lua, const std::vector<Id> &ids,
    const std::string &kind )
{
    sol::table result = lua.create_table(
                            static_cast<int>( ids.size() ), 0 );
    for( std::size_t index = 0;
         index < ids.size(); ++index ) {
        result[index + 1] =
            script_game_id(
                kind, ids[index].str() );
    }
    return result;
}

sol::table npc_training_offerings(
    sol::this_state lua,
    const game_handle &teacher_handle,
    const game_handle &student_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *teacher = resolve_exact_character(
                             teacher_handle,
                             runtime_generation,
                             world_generation, error );
    if( teacher == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    Character *student = resolve_exact_character(
                             student_handle,
                             runtime_generation,
                             world_generation, error );
    if( student == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }

    const std::vector<skill_id> skills =
        teacher->skills_offered_to( student );
    const std::vector<proficiency_id> proficiencies =
        teacher->proficiencies_offered_to( student );
    const std::vector<matype_id> styles =
        teacher->styles_offered_to( student );
    const std::vector<spell_id> spells =
        teacher->spells_offered_to( student );
    sol::table value = state.create_table();
    value["teacher"] = teacher_handle;
    value["student"] = student_handle;
    value["skills"] = training_ids(
                          state, skills, "skill" );
    value["proficiencies"] = training_ids(
                                 state, proficiencies,
                                 "proficiency" );
    value["styles"] = training_ids(
                          state, styles, "martial_art" );
    value["spells"] = training_ids(
                          state, spells, "spell" );
    value["skill_count"] = skills.size();
    value["proficiency_count"] =
        proficiencies.size();
    value["style_count"] = styles.size();
    value["spell_count"] = spells.size();
    value["has_any"] =
        !skills.empty() ||
        !proficiencies.empty() ||
        !styles.empty() ||
        !spells.empty();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table add_assigned_npc_mission(
    sol::this_state lua, const game_handle &provider_handle,
    const game_handle &owner_handle,
    const script_game_id &requested_mission,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_mission.kind() != "mission" ||
        !requested_mission.is_valid() ) {
        throw std::invalid_argument(
            "services.npcs.missions.add_assigned requires a valid GameId<mission>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle, runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result( state, *error );
    }
    avatar *owner = resolve_exact_avatar(
                        owner_handle, runtime_generation,
                        world_generation, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = npc_mission_provider_state(
                            state, *provider,
                            runtime_generation,
                            world_generation );
    mission *created = mission::reserve_new(
                           mission_type_id( requested_mission.value() ),
                           provider->getID() );
    if( created == nullptr ) {
        return make_game_error_result( state, {
            "rejected",
            "The engine rejected the NPC mission assignment"
        } );
    }
    std::vector<mission *> assigned_after;
    try {
        assigned_after = provider->chatbin.missions_assigned;
        assigned_after.push_back( created );
    } catch( const std::exception & ) {
        const bool rolled_back = mission::remove_unassigned( created->get_id() );
        return make_game_error_result( state, {
            rolled_back ? "rejected" : "rollback_failed",
            rolled_back ? "The NPC mission assignment could not be staged" :
            "The NPC mission assignment could not be staged and rollback failed"
        } );
    }
    const int created_uid = created->get_id();
    try {
        created->assign( *owner );
    } catch( ... ) {
        const bool rolled_back = created->is_assigned() ?
                                 rollback_new_assigned_mission( created, *owner ) :
                                 mission::remove_unassigned( created_uid );
        return make_game_error_result( state, {
            rolled_back ? "rejected" : "rollback_failed",
            rolled_back ? "The engine rejected explicit NPC mission assignment" :
            "The engine rejected explicit NPC mission assignment and rollback failed"
        } );
    }
    if( !created->is_assigned() ||
        created->get_assigned_player_id() != owner->getID() ) {
        const bool rolled_back = created->is_assigned() ?
                                 rollback_new_assigned_mission( created, *owner ) :
                                 mission::remove_unassigned( created_uid );
        return make_game_error_result( state, {
            rolled_back ? "rejected" : "rollback_failed",
            rolled_back ? "The engine rejected explicit NPC mission assignment" :
            "The engine rejected explicit NPC mission assignment and rollback failed"
        } );
    }
    provider->chatbin.missions_assigned.swap( assigned_after );
    sol::table value = state.create_table();
    value["mission"] = npc_mission_state(
                           state, *created,
                           runtime_generation,
                           world_generation );
    value["owner"] = owner_handle;
    value["before"] = std::move( before );
    value["after"] = npc_mission_provider_state(
                         state, *provider,
                         runtime_generation,
                         world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

template<typename Id>
bool contains_training_id(
    const std::vector<Id> &ids, const Id &requested )
{
    return std::find(
               ids.begin(), ids.end(),
               requested ) != ids.end();
}

bool configure_training_domain(
    Character &teacher, Character &student,
    const script_game_id &subject,
    talk_function::teach_domain &domain )
{
    if( subject.kind() == "skill" ) {
        const skill_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.skills_offered_to( &student ), id ) ) {
            return false;
        }
        domain.skill = id;
        return true;
    }
    if( subject.kind() == "proficiency" ) {
        const proficiency_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.proficiencies_offered_to( &student ), id ) ) {
            return false;
        }
        domain.prof = id;
        return true;
    }
    if( subject.kind() == "martial_art" ) {
        const matype_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.styles_offered_to( &student ), id ) ) {
            return false;
        }
        domain.style = id;
        return true;
    }
    if( subject.kind() == "spell" ) {
        const spell_id id( subject.value() );
        if( !id.is_valid() ||
            !contains_training_id(
                teacher.spells_offered_to( &student ), id ) ) {
            return false;
        }
        domain.spell = id;
        return true;
    }
    throw std::invalid_argument(
        "services.npcs.training.start subject must be a skill, proficiency, martial_art, or spell GameId" );
}

sol::table start_npc_training(
    sol::this_state lua,
    const game_handle &teacher_handle,
    const sol::table &requested_students,
    const script_game_id &subject,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *teacher = resolve_exact_character(
                             teacher_handle,
                             runtime_generation,
                             world_generation, error );
    if( teacher == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }

    std::map<std::size_t, Character *> indexed_students;
    std::set<character_id> student_ids;
    for( const auto &entry : requested_students ) {
        if( !entry.first.is<lua_Integer>() ||
            !entry.second.is<game_handle>() ) {
            throw std::invalid_argument(
                "services.npcs.training.start students must be a dense GameHandle array" );
        }
        const lua_Integer raw_index =
            entry.first.as<lua_Integer>();
        if( raw_index <= 0 ||
            static_cast<std::uint64_t>( raw_index ) >
            maximum_training_students ) {
            throw std::invalid_argument(
                "services.npcs.training.start student index must be within 1..64" );
        }
        const game_handle handle =
            entry.second.as<game_handle>();
        Character *student = resolve_exact_character(
                                 handle, runtime_generation,
                                 world_generation, error );
        if( student == nullptr ) {
            return make_game_error_result(
                       state, *error );
        }
        if( student == teacher ||
            !student_ids.insert(
                student->getID() ).second ) {
            throw std::invalid_argument(
                "services.npcs.training.start students must be unique and cannot include the teacher" );
        }
        indexed_students.emplace(
            static_cast<std::size_t>( raw_index ),
            student );
    }
    if( indexed_students.empty() ||
        indexed_students.rbegin()->first !=
        indexed_students.size() ) {
        throw std::invalid_argument(
            "services.npcs.training.start requires a non-empty dense student array" );
    }

    std::vector<Character *> students;
    students.reserve( indexed_students.size() );
    talk_function::teach_domain domain;
    bool configured = false;
    for( const auto &[index, student] :
         indexed_students ) {
        static_cast<void>( index );
        talk_function::teach_domain candidate;
        if( !configure_training_domain(
                *teacher, *student,
                subject, candidate ) ) {
            return make_game_error_result(
            state, {
                "not_offered",
                "The requested training subject is not offered to every student"
            } );
        }
        if( !configured ) {
            domain = candidate;
            configured = true;
        }
        students.push_back( student );
    }

    const std::string activity_before =
        teacher->activity ?
        teacher->activity.id().str() :
        std::string();
    talk_function::start_training_gen(
        *teacher, students, domain );
    const std::string activity_after =
        teacher->activity ?
        teacher->activity.id().str() :
        std::string();
    static const activity_id training_activity(
        "ACT_TRAIN" );
    sol::table value = state.create_table();
    value["started"] =
        teacher->activity &&
        teacher->activity.id() == training_activity;
    value["teacher"] = teacher_handle;
    value["subject"] = subject;
    value["student_count"] = students.size();
    value["teacher_activity_before"] =
        activity_before.empty() ?
        sol::make_object( state, sol::nil ) :
        sol::make_object(
            state, script_game_id(
                "activity", activity_before ) );
    value["teacher_activity_after"] =
        activity_after.empty() ?
        sol::make_object( state, sol::nil ) :
        sol::make_object(
            state, script_game_id(
                "activity", activity_after ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table start_selected_npc_training(
    sol::this_state lua,
    const game_handle &provider_handle,
    const game_handle &student_handle,
    const std::string &mode,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *provider = resolve_exact_npc(
                        provider_handle,
                        runtime_generation,
                        world_generation, error );
    if( provider == nullptr ) {
        return make_game_error_result(
                   state, *error );
    }
    if( mode != "player" ) {
        return make_game_error_result( state, {
            "unsupported_target",
            "services.npcs.training.start_selected only supports explicit player training"
        } );
    }
    avatar *student_avatar = resolve_exact_avatar(
                                 student_handle, runtime_generation,
                                 world_generation, error );
    if( student_avatar == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *student = student_avatar;
    talk_function::start_training( *provider );
    static const activity_id training_activity(
        "ACT_TRAIN" );
    sol::table value = state.create_table();
    value["mode"] = mode;
    value["provider"] = provider_handle;
    value["student"] = student_handle;
    value["provider_training"] =
        provider->activity &&
        provider->activity.id() ==
        training_activity;
    value["player_training"] =
        student->activity &&
        student->activity.id() ==
        training_activity;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void install_npc_domain_services(
    sol::table &npcs,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( npcs.lua_state() );

    sol::table medical = lua.create_table();
    medical.set_function(
        "provide_aid",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
            const game_handle & patient,
            const sol::optional<std::string> &level,
    const sol::optional<bool> &include_allies ) {
        require_write();
        return provide_medical_aid(
                   state, provider, patient, level.value_or( "basic" ),
                   include_allies.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    medical.set_function(
        "open_bionic_service",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
            const std::string & operation,
    const game_handle & patient ) {
        require_write();
        return open_bionic_service(
                   state, provider, operation, patient,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    medical.set_function(
        "repair_bionic_limbs",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const game_handle & patient ) {
        require_write();
        return repair_bionic_limbs_with_provider(
                   state, provider, patient,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["medical"] = std::move( medical );

    sol::table grooming = lua.create_table();
    grooming.set_function(
        "open_style",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
            const game_handle & client,
    const std::string & area ) {
        require_write();
        return open_grooming_style(
                   state, provider, client, area,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    grooming.set_function(
        "provide",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
            const game_handle & client,
    const std::string & service ) {
        require_write();
        return provide_grooming(
                   state, provider, client, service,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["grooming"] = std::move( grooming );

    sol::table training = lua.create_table();
    training.set_function(
        "offerings",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state state,
            const game_handle & teacher,
    const game_handle & student ) {
        require_read();
        return npc_training_offerings(
                   state, teacher, student,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    training.set_function(
        "start",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state,
            const game_handle & teacher,
            const sol::table & students,
    const script_game_id & subject ) {
        require_write();
        return start_npc_training(
                   state, teacher, students, subject,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    training.set_function(
        "start_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state,
            const game_handle & provider,
            const game_handle & student,
    const std::string & mode ) {
        require_write();
        return start_selected_npc_training(
                   state, provider, student, mode,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["training"] = std::move( training );

    sol::table missions = lua.create_table();
    missions.set_function(
        "state",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state state, const game_handle & provider ) {
        require_read();
        return get_npc_mission_provider_state(
                   state, provider,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "select",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const mission_token & token ) {
        require_write();
        return select_npc_mission(
                   state, provider, token,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "offer",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const script_game_id & mission ) {
        require_write();
        return offer_npc_mission(
                   state, provider, mission,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "add_assigned",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
            const game_handle & owner,
    const script_game_id & mission ) {
        require_write();
        return add_assigned_npc_mission(
                   state, provider, owner, mission,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "assign_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const game_handle & owner ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, owner, "assign", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "succeed_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
            const game_handle & owner,
    const sol::optional<bool> &force ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, owner, "success",
                   force.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "fail_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const game_handle & owner ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, owner, "failure", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "clear_selected",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const game_handle & owner ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, owner, "clear", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    missions.set_function(
        "claim_selected_reward",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & provider,
    const game_handle & owner ) {
        require_write();
        return run_selected_npc_mission_action(
                   state, provider, owner, "reward", false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["missions"] = std::move( missions );

    sol::table dialogue = lua.create_table();
    dialogue.set_function(
        "finish",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state state, const game_handle & handle ) {
        require_write();
        return finish_npc_dialogue(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    dialogue.set_function(
        "provoke_combat",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state state, const game_handle & handle ) {
        require_write();
        return provoke_npc_combat(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["dialogue"] = std::move( dialogue );

    sol::table orders = lua.create_table();
    orders.set_function(
        "run",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state state, const game_handle & handle,
    const std::string & order ) {
        require_write();
        return run_npc_order(
                   state, handle, order,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    orders.set_function(
        "open_pickup_rules",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state state, const game_handle & handle ) {
        require_write();
        return open_npc_pickup_rules(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    orders.set_function(
        "choose_combat_style",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state state, const game_handle & handle ) {
        require_write();
        return choose_npc_combat_style(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    orders.set_function(
        "open_character_sheet",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state state, const game_handle & handle ) {
        require_read();
        return open_npc_character_sheet(
                   state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    npcs["orders"] = std::move( orders );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
