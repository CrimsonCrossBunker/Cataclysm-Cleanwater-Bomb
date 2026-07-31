#if CATA_ENABLE_LUA_UI

#include "catalua_ui_world_services.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

#include "avatar.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "game.h"
#include "game_constants.h"
#include "map.h"
#include "monster.h"
#include "mp_gamestate.h"
#include "mtype.h"
#include "npc.h"
#include "point.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr int maximum_monster_spawn_radius = 60;
constexpr std::size_t maximum_follower_results = 128;
constexpr time_duration maximum_hallucination_lifespan = 365_days;

void require_active_callback(
    const std::function<bool()> &has_active_callback,
    const std::string_view api_name )
{
    if( !has_active_callback() ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " is only available from an active callback" );
    }
}

void require_game_id(
    const script_game_id &id, const std::string_view kind,
    const std::string_view api_name )
{
    if( id.kind() != kind ) {
        throw std::invalid_argument(
            std::string( api_name ) + " requires GameId<" +
            std::string( kind ) + ">" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " requires a valid GameId<" +
            std::string( kind ) + ">" );
    }
}

map &require_active_map( const std::string_view api_name )
{
    if( g == nullptr ) {
        throw std::runtime_error(
            std::string( api_name ) +
            " requires an active game" );
    }
    return get_map();
}

tripoint_abs_ms require_absolute_ms(
    const script_tripoint_coord &position,
    const std::string_view api_name )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms( position.to_native() );
}

tripoint_bub_ms require_loaded_position(
    map &here, const script_tripoint_coord &position,
    const std::string_view api_name )
{
    const tripoint_abs_ms absolute =
        require_absolute_ms( position, api_name );
    if( !here.inbounds( absolute ) ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " position is outside the active map" );
    }
    return here.get_bub( absolute );
}

std::string creature_scope( const Creature &creature )
{
    if( creature.is_avatar() ) {
        return "avatar";
    }
    if( creature.is_npc() ) {
        return "npc";
    }
    if( creature.is_monster() ) {
        return "monster";
    }
    return "creature";
}

game_handle make_creature_handle(
    Creature &creature,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position = creature.pos_abs();
    game_handle_locator locator;
    locator.scope = creature_scope( creature );
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    if( Character *character = creature.as_character() ) {
        locator.stable_id = character->getID().get_value();
    } else if( monster *mon = creature.as_monster() ) {
        locator.stable_id =
            get_creature_tracker().temporary_id( *mon );
    }
    return game_handle::from_creature(
               creature, std::move( locator ),
               runtime_generation, world_generation );
}

script_tripoint_coord absolute_position( const Creature &creature )
{
    return script_tripoint_coord::from_native(
               coords::origin::abs, coords::scale::map_square,
               creature.pos_abs().raw() );
}

sol::table spawn_monster(
    sol::this_state lua, const script_game_id &requested_type,
    const script_tripoint_coord &requested_position,
    const sol::optional<int> &requested_radius,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.spawns.monster";
    require_game_id( requested_type, "monster", api_name );
    const int radius = requested_radius.value_or( 0 );
    if( radius < 0 || radius > maximum_monster_spawn_radius ) {
        throw std::invalid_argument(
            "game.spawns.monster radius must be within 0..60" );
    }
    map &here = require_active_map( api_name );
    const tripoint_bub_ms position = require_loaded_position(
                                         here, requested_position, api_name );
    monster *placed = g->place_critter_around(
                          mtype_id( requested_type.value() ),
                          position, radius );

    sol::state_view state( lua );
    if( placed == nullptr ) {
        return make_game_error_result(
        state, {
            "blocked",
            "No valid monster spawn position was available"
        } );
    }
    placed->try_upgrade( true );

    sol::table value = state.create_table();
    value["handle"] = make_creature_handle(
                          *placed, runtime_generation, world_generation );
    value["monster"] = script_game_id(
                           "monster", placed->type->id.str() );
    value["position"] = absolute_position( *placed );
    value["hallucination"] = placed->is_hallucination();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct hallucination_options {
    std::optional<mtype_id> monster_type;
    std::optional<time_duration> lifespan;
};

hallucination_options read_hallucination_options(
    const sol::optional<sol::table> &requested )
{
    hallucination_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.spawns.hallucination option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "monster" ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "game.spawns.hallucination option 'monster' "
                    "must be a GameId" );
            }
            const script_game_id id =
                entry.second.as<script_game_id>();
            require_game_id(
                id, "monster", "game.spawns.hallucination" );
            result.monster_type = mtype_id( id.value() );
        } else if( key == "lifespan" ) {
            if( !entry.second.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "game.spawns.hallucination option 'lifespan' "
                    "must be a TimeDuration" );
            }
            const time_duration lifespan =
                entry.second.as<script_time_duration>().to_native();
            if( lifespan <= 0_turns ||
                lifespan > maximum_hallucination_lifespan ) {
                throw std::invalid_argument(
                    "game.spawns.hallucination lifespan must be "
                    "within 1 turn..365 days" );
            }
            result.lifespan = lifespan;
        } else {
            throw std::invalid_argument(
                "game.spawns.hallucination received unknown option '" +
                key + "'" );
        }
    }
    if( result.lifespan && !result.monster_type ) {
        throw std::invalid_argument(
            "game.spawns.hallucination lifespan requires a monster id" );
    }
    return result;
}

sol::table spawn_hallucination(
    sol::this_state lua,
    const script_tripoint_coord &requested_position,
    const sol::optional<sol::table> &requested_options,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.spawns.hallucination";
    map &here = require_active_map( api_name );
    const tripoint_bub_ms position = require_loaded_position(
                                         here, requested_position, api_name );
    const hallucination_options options =
        read_hallucination_options( requested_options );
    const bool spawned = options.monster_type ?
                         g->spawn_hallucination(
                             position, *options.monster_type,
                             options.lifespan ) :
                         g->spawn_hallucination( position );

    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["spawned"] = spawned;
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs,
                            coords::scale::map_square,
                            here.get_abs( position ).raw() );
    if( spawned ) {
        Creature *creature =
            get_creature_tracker().creature_at<Creature>(
                position, true );
        if( creature != nullptr ) {
            value["handle"] = make_creature_handle(
                                  *creature, runtime_generation,
                                  world_generation );
            value["kind"] = creature_scope( *creature );
        }
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

npc *resolve_npc(
    const game_handle &handle,
    const std::size_t runtime_generation,
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
    npc *result = resolved.value->as_npc();
    if( result == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not an NPC"
        };
    }
    return result;
}

sol::table follower_mutation(
    sol::this_state lua, const game_handle &handle,
    const bool add,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    std::optional<game_handle_error> error;
    npc *follower = resolve_npc(
                        handle, runtime_generation,
                        world_generation, error );
    if( follower == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const character_id id = follower->getID();
    const std::set<character_id> before =
        g->get_follower_list();
    const bool was_follower = before.count( id ) != 0;
    if( add ) {
        g->add_npc_follower( id );
    } else {
        g->remove_npc_follower( id );
    }
    const bool is_follower =
        g->get_follower_list().count( id ) != 0;

    sol::table value = state.create_table();
    value["id"] = id.get_value();
    value["name"] = follower->get_name();
    value["before"] = was_follower;
    value["after"] = is_follower;
    value["changed"] = was_follower != is_follower;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table follower_list(
    sol::this_state lua,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
        state, {
            "unavailable", "No active game is available"
        } );
    }
    const std::set<character_id> followers =
        g->get_follower_list();
    const std::size_t returned = std::min(
                                     followers.size(),
                                     maximum_follower_results );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const character_id &id : followers ) {
        if( index >= returned ) {
            break;
        }
        sol::table entry = state.create_table();
        entry["id"] = id.get_value();
        npc *follower = g->find_npc( id );
        entry["available"] = follower != nullptr;
        if( follower != nullptr ) {
            entry["name"] = follower->get_name();
            entry["handle"] = make_creature_handle(
                                  *follower, runtime_generation,
                                  world_generation );
            entry["position"] = absolute_position( *follower );
        } else {
            entry["name"] = std::string();
        }
        items[++index] = std::move( entry );
    }

    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = followers.size();
    value["returned"] = returned;
    value["limit"] = maximum_follower_results;
    value["truncated"] = returned < followers.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table relocation_snapshot(
    sol::state_view state, const bool changed )
{
    const avatar &player = get_avatar();
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs,
                            coords::scale::map_square,
                            player.pos_abs().raw() );
    value["overmap_terrain"] =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            player.pos_abs_omt().raw() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table relocate_local(
    sol::this_state lua,
    const script_tripoint_coord &requested_position )
{
    constexpr std::string_view api_name =
        "game.relocation.local_at";
    map &here = require_active_map( api_name );
    const tripoint_bub_ms destination = require_loaded_position(
                                            here, requested_position, api_name );
    avatar &player = get_avatar();
    sol::state_view state( lua );
    if( destination == player.pos_bub( here ) ) {
        return relocation_snapshot( state, false );
    }
    if( cata_mp::is_mp_mode() ) {
        return make_game_error_result(
        state, {
            "multiplayer",
            "Lua player relocation is unavailable in multiplayer"
        } );
    }
    if( player.in_vehicle || player.is_mounted() ||
        player.is_hauling() ) {
        return make_game_error_result(
        state, {
            "unsafe_state",
            "The avatar cannot be relocated while mounted, "
            "in a vehicle, or hauling"
        } );
    }
    if( !here.passable( destination ) ) {
        return make_game_error_result(
        state, {
            "blocked", "The relocation destination is impassable"
        } );
    }
    if( g->is_dangerous_tile( destination ) ) {
        return make_game_error_result(
        state, {
            "dangerous",
            "The relocation destination is currently dangerous"
        } );
    }
    Creature *occupant =
        get_creature_tracker().creature_at<Creature>(
            destination, true );
    if( occupant != nullptr ) {
        return make_game_error_result(
        state, {
            "occupied",
            "The relocation destination contains another creature"
        } );
    }
    g->place_player( destination, true );
    return relocation_snapshot( state, true );
}

sol::table relocate_overmap(
    sol::this_state lua,
    const script_tripoint_coord &requested_position )
{
    constexpr std::string_view api_name =
        "game.relocation.overmap_at";
    require_active_map( api_name );
    if( requested_position.native_origin() != coords::origin::abs ||
        requested_position.native_scale() !=
        coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            "game.relocation.overmap_at requires an absolute "
            "overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt destination(
        requested_position.to_native() );
    if( destination.z() < -OVERMAP_DEPTH ||
        destination.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            "game.relocation.overmap_at z level is outside "
            "the world bounds" );
    }

    sol::state_view state( lua );
    if( destination == get_avatar().pos_abs_omt() ) {
        return relocation_snapshot( state, false );
    }
    if( cata_mp::is_mp_mode() ) {
        return make_game_error_result(
        state, {
            "multiplayer",
            "Lua player relocation is unavailable in multiplayer"
        } );
    }
    g->place_player_overmap( destination );
    return relocation_snapshot( state, true );
}

} // namespace

void install_game_world_service_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<void()> require_dangerous_relocation,
    std::function<bool()> has_active_callback )
{
    sol::state_view state( game.lua_state() );

    sol::table spawns = state.create_table();
    spawns.set_function(
        "monster",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
            const script_game_id & monster_type,
            const script_tripoint_coord & position,
    const sol::optional<int> &radius ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.spawns.monster" );
        return spawn_monster(
                   lua, monster_type, position, radius,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spawns.set_function(
        "hallucination",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
            const script_tripoint_coord & position,
    const sol::optional<sol::table> &options ) {
        require_write();
        require_active_callback(
            has_active_callback,
            "game.spawns.hallucination" );
        return spawn_hallucination(
                   lua, position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["spawns"] = std::move( spawns );

    sol::table followers = state.create_table();
    followers.set_function(
        "list",
        [current_runtime_generation,
         current_world_generation,
    require_read]( sol::this_state lua ) {
        require_read();
        return follower_list(
                   lua, current_runtime_generation(),
                   current_world_generation() );
    } );
    followers.set_function(
        "add",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
    const game_handle & handle ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.followers.add" );
        return follower_mutation(
                   lua, handle, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    followers.set_function(
        "remove",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
    const game_handle & handle ) {
        require_write();
        require_active_callback(
            has_active_callback, "game.followers.remove" );
        return follower_mutation(
                   lua, handle, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["followers"] = std::move( followers );

    const auto authorize_relocation = [
                                          require_dangerous_relocation,
                                          has_active_callback
    ]( const std::string_view api_name ) {
        require_dangerous_relocation();
        require_active_callback(
            has_active_callback, api_name );
    };
    sol::table relocation = state.create_table();
    relocation.set_function(
        "local_at",
        [authorize_relocation](
            sol::this_state lua,
    const script_tripoint_coord & position ) {
        authorize_relocation(
            "game.relocation.local_at" );
        return relocate_local( lua, position );
    } );
    relocation.set_function(
        "overmap_at",
        [authorize_relocation](
            sol::this_state lua,
    const script_tripoint_coord & position ) {
        authorize_relocation(
            "game.relocation.overmap_at" );
        return relocate_overmap( lua, position );
    } );
    game["relocation"] = std::move( relocation );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
