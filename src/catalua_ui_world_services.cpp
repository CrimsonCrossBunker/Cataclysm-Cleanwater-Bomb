#if CATA_ENABLE_LUA_PLATFORM

#include "catalua_ui_world_services.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "cata_path.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "current_map.h"
#include "creature.h"
#include "creature_tracker.h"
#include "game.h"
#include "game_constants.h"
#include "item_location.h"
#include "item_wakeup.h"
#include "line.h"
#include "item.h"
#include "map.h"
#include "monster.h"
#include "mp_gamestate.h"
#include "mongroup.h"
#include "mtype.h"
#include "npc.h"
#include "path_info.h"
#include "point.h"
#include "teleport.h"
#include "type_id.h"
#include "visitable.h"
#include "vehicle.h"

namespace cata::lua
{

namespace
{

constexpr int maximum_monster_spawn_radius = 60;
constexpr int maximum_npc_spawn_radius = 60;
constexpr std::size_t maximum_follower_results = 128;
constexpr time_duration maximum_hallucination_lifespan = 10000_days;
constexpr std::size_t maximum_npc_spawn_traits = 128;
constexpr std::size_t maximum_npc_unique_id_bytes = 256;
constexpr std::size_t maximum_monster_unique_name_bytes = 256;

const efftype_id effect_pacified( "pacified" );
const efftype_id effect_pet( "pet" );

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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.spawns.monster";
    require_game_id( requested_type, "monster", api_name );
    const int radius = requested_radius.value_or( 0 );
    if( radius < 0 || radius > maximum_monster_spawn_radius ) {
        throw std::invalid_argument(
            "services.spawns.monster radius must be within 0..60" );
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

struct monster_spawn_options {
    int min_radius = 0;
    int max_radius = 0;
    bool outdoor_only = false;
    bool indoor_only = false;
    bool open_air_allowed = false;
    bool friendly = false;
    bool pet = false;
    bool pacified = false;
    bool hallucination = false;
    bool temporary_drop_items = false;
    bool upgrade = true;
    std::string unique_name;
    std::optional<time_duration> lifespan;
    std::optional<game_handle> summoner;
};

monster_spawn_options read_monster_spawn_options(
    const sol::optional<sol::table> &requested )
{
    monster_spawn_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.spawns.monster_configured option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "min_radius" || key == "max_radius" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured radii must be integers" );
            }
            const int radius = value.as<int>();
            if( radius < 0 || radius > maximum_monster_spawn_radius ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured radii must be within 0..60" );
            }
            if( key == "min_radius" ) {
                result.min_radius = radius;
            } else {
                result.max_radius = radius;
            }
        } else if( key == "outdoor_only" || key == "indoor_only" ||
                   key == "open_air_allowed" || key == "friendly" ||
                   key == "pet" || key == "pacified" ||
                   key == "hallucination" ||
                   key == "temporary_drop_items" || key == "upgrade" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured boolean options must be booleans" );
            }
            const bool enabled = value.as<bool>();
            if( key == "outdoor_only" ) {
                result.outdoor_only = enabled;
            } else if( key == "indoor_only" ) {
                result.indoor_only = enabled;
            } else if( key == "open_air_allowed" ) {
                result.open_air_allowed = enabled;
            } else if( key == "friendly" ) {
                result.friendly = enabled;
            } else if( key == "pet" ) {
                result.pet = enabled;
            } else if( key == "pacified" ) {
                result.pacified = enabled;
            } else if( key == "hallucination" ) {
                result.hallucination = enabled;
            } else if( key == "temporary_drop_items" ) {
                result.temporary_drop_items = enabled;
            } else {
                result.upgrade = enabled;
            }
        } else if( key == "lifespan" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured lifespan must be a TimeDuration" );
            }
            const time_duration lifespan =
                value.as<script_time_duration>().to_native();
            if( lifespan <= 0_turns ||
                lifespan > maximum_hallucination_lifespan ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured lifespan must be within 1 turn..10000 days" );
            }
            result.lifespan = lifespan;
        } else if( key == "summoner" ) {
            if( !value.is<game_handle>() ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured summoner must be a GameHandle" );
            }
            result.summoner = value.as<game_handle>();
        } else if( key == "name" ) {
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured name must be a string" );
            }
            result.unique_name = value.as<std::string>();
            if( result.unique_name.size() >
                maximum_monster_unique_name_bytes ) {
                throw std::invalid_argument(
                    "services.spawns.monster_configured name exceeds 256 bytes" );
            }
        } else {
            throw std::invalid_argument(
                "services.spawns.monster_configured received unknown option '" +
                key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            "services.spawns.monster_configured min_radius cannot exceed max_radius" );
    }
    if( result.indoor_only && result.outdoor_only ) {
        throw std::invalid_argument(
            "services.spawns.monster_configured cannot require both indoor and outdoor tiles" );
    }
    return result;
}

sol::table spawn_configured_monster(
    sol::this_state lua, const script_game_id &requested_type,
    const script_tripoint_coord &requested_position,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.spawns.monster_configured";
    require_game_id( requested_type, "monster", api_name );
    const monster_spawn_options options =
        read_monster_spawn_options( requested_options );
    map &here = require_active_map( api_name );
    const tripoint_bub_ms target = require_loaded_position(
                                       here, requested_position, api_name );
    Creature *summoner = nullptr;
    sol::state_view state( lua );
    if( options.summoner ) {
        const native_handle_result<Creature> resolved =
            options.summoner->resolve_creature(
                runtime_generation, world_generation );
        if( !resolved ) {
            return make_game_error_result(
                       state, *resolved.error );
        }
        summoner = resolved.value;
    }
    const mtype_id type( requested_type.value() );
    tripoint_bub_ms spawn_point;
    if( !g->find_nearby_spawn_point(
            target, type, options.min_radius,
            options.max_radius, spawn_point,
            options.outdoor_only, options.indoor_only,
            options.open_air_allowed ) ) {
        return make_game_error_result( state, {
            "blocked",
            "No valid monster spawn position was available"
        } );
    }
    monster *placed = nullptr;
    if( options.hallucination ) {
        if( !g->spawn_hallucination(
                spawn_point, type, options.lifespan ) ) {
            return make_game_error_result( state, {
                "spawn_rejected",
                "Native hallucination spawning rejected the request"
            } );
        }
        placed = get_creature_tracker().creature_at<monster>(
                     spawn_point, true );
    } else {
        placed = g->place_critter_at( type, spawn_point );
    }
    if( placed == nullptr ) {
        return make_game_error_result( state, {
            "spawn_unavailable",
            "The spawned monster was not available in the creature tracker"
        } );
    }
    if( options.upgrade ) {
        placed->try_upgrade( true );
    }
    placed->friendly = options.friendly || options.pet ? -1 : 0;
    if( options.pet ) {
        placed->add_effect( effect_pet, 1_turns, true );
    }
    if( options.pacified ) {
        placed->add_effect( effect_pacified, 1_turns, true );
    }
    placed->unique_name = options.unique_name;
    placed->set_summoner( summoner );
    if( options.lifespan && !options.hallucination ) {
        placed->set_summon_time( *options.lifespan );
    }
    if( options.lifespan ) {
        placed->no_extra_death_drops =
            !options.temporary_drop_items;
        placed->no_corpse_quiet =
            !options.temporary_drop_items;
    }
    sol::table value = state.create_table();
    value["handle"] = make_creature_handle(
                          *placed, runtime_generation,
                          world_generation );
    value["monster"] = script_game_id(
                           "monster", placed->type->id.str() );
    value["position"] = absolute_position( *placed );
    value["hallucination"] = placed->is_hallucination();
    value["friendly"] = placed->friendly != 0;
    value["pet"] = placed->has_effect( effect_pet );
    value["pacified"] = placed->has_effect( effect_pacified );
    value["temporary"] = static_cast<bool>( options.lifespan );
    value["has_summoner"] = summoner != nullptr;
    value["name"] = placed->unique_name;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

script_game_id random_monster_from_group(
    const script_game_id &requested_group )
{
    constexpr std::string_view api_name =
        "services.spawns.monster_from_group";
    require_game_id(
        requested_group, "monster_group", api_name );
    const mtype_id type =
        MonsterGroupManager::GetRandomMonsterFromGroup(
            mongroup_id( requested_group.value() ) );
    if( type.is_null() || !type.is_valid() ) {
        throw std::runtime_error(
            "services.spawns.monster_from_group could not select a valid monster" );
    }
    return script_game_id( "monster", type.str() );
}

sol::table monsters_from_group(
    sol::this_state lua, const script_game_id &requested_group )
{
    constexpr std::string_view api_name =
        "services.spawns.group_members";
    require_game_id(
        requested_group, "monster_group", api_name );
    std::vector<std::string> ids;
    for( const mtype_id &entry :
         MonsterGroupManager::GetMonstersFromGroup(
             mongroup_id( requested_group.value() ), true ) ) {
        if( !entry.is_null() && entry.is_valid() ) {
            ids.push_back( entry.str() );
        }
    }
    std::sort( ids.begin(), ids.end() );
    ids.erase( std::unique( ids.begin(), ids.end() ), ids.end() );

    sol::state_view state( lua );
    sol::table monsters = state.create_table(
                              static_cast<int>( ids.size() ), 0 );
    for( std::size_t index = 0; index < ids.size(); ++index ) {
        monsters[index + 1] = script_game_id(
                                  "monster", ids[index] );
    }
    sol::table value = state.create_table();
    value["group"] = requested_group;
    value["monsters"] = std::move( monsters );
    value["total"] = ids.size();
    return value;
}

struct npc_spawn_options {
    int min_radius = 0;
    int max_radius = 0;
    bool outdoor_only = false;
    bool indoor_only = false;
    bool open_air_allowed = false;
    bool hallucination = false;
    std::string unique_id;
    std::vector<trait_id> traits;
    std::optional<time_duration> lifespan;
};

npc_spawn_options read_npc_spawn_options(
    const sol::optional<sol::table> &requested )
{
    npc_spawn_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.spawns.npc option keys must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        const sol::object value = entry.second;
        if( key == "min_radius" || key == "max_radius" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.spawns.npc radius options must be integers" );
            }
            const lua_Integer radius = value.as<lua_Integer>();
            if( radius < 0 || radius > maximum_npc_spawn_radius ) {
                throw std::invalid_argument(
                    "services.spawns.npc radii must be within 0..60" );
            }
            if( key == "min_radius" ) {
                result.min_radius = static_cast<int>( radius );
            } else {
                result.max_radius = static_cast<int>( radius );
            }
        } else if( key == "outdoor_only" ||
                   key == "indoor_only" ||
                   key == "open_air_allowed" ||
                   key == "hallucination" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "services.spawns.npc boolean options must be booleans" );
            }
            const bool enabled = value.as<bool>();
            if( key == "outdoor_only" ) {
                result.outdoor_only = enabled;
            } else if( key == "indoor_only" ) {
                result.indoor_only = enabled;
            } else if( key == "open_air_allowed" ) {
                result.open_air_allowed = enabled;
            } else {
                result.hallucination = enabled;
            }
        } else if( key == "unique_id" ) {
            if( !value.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.spawns.npc unique_id must be a string" );
            }
            result.unique_id = value.as<std::string>();
            if( result.unique_id.size() > maximum_npc_unique_id_bytes ||
                result.unique_id.find( '\0' ) != std::string::npos ) {
                throw std::invalid_argument(
                    "services.spawns.npc unique_id exceeds its bounded string contract" );
            }
        } else if( key == "lifespan" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.spawns.npc lifespan must be a TimeDuration" );
            }
            const time_duration lifespan =
                value.as<script_time_duration>().to_native();
            if( lifespan <= 0_turns ||
                lifespan > maximum_hallucination_lifespan ) {
                throw std::invalid_argument(
                    "services.spawns.npc lifespan must be within 1 turn..10000 days" );
            }
            result.lifespan = lifespan;
        } else if( key == "traits" ) {
            if( !value.is<sol::table>() ) {
                throw std::invalid_argument(
                    "services.spawns.npc traits must be a dense GameId array" );
            }
            const sol::table traits = value.as<sol::table>();
            if( traits.size() > maximum_npc_spawn_traits ) {
                throw std::invalid_argument(
                    "services.spawns.npc accepts at most 128 traits" );
            }
            for( std::size_t index = 1;
                 index <= traits.size(); ++index ) {
                const sol::object trait_object = traits[index];
                if( !trait_object.is<script_game_id>() ) {
                    throw std::invalid_argument(
                        "services.spawns.npc traits must be a dense GameId array" );
                }
                const script_game_id trait =
                    trait_object.as<script_game_id>();
                require_game_id(
                    trait, "mutation", "services.spawns.npc" );
                result.traits.emplace_back( trait.value() );
            }
        } else {
            throw std::invalid_argument(
                "services.spawns.npc received unknown option '" +
                key + "'" );
        }
    }
    if( result.min_radius > result.max_radius ) {
        throw std::invalid_argument(
            "services.spawns.npc min_radius cannot exceed max_radius" );
    }
    if( result.indoor_only && result.outdoor_only ) {
        throw std::invalid_argument(
            "services.spawns.npc cannot be both indoor_only and outdoor_only" );
    }
    if( result.hallucination ) {
        const trait_id hallucination( "HALLUCINATION" );
        if( std::find(
                result.traits.begin(), result.traits.end(),
                hallucination ) == result.traits.end() ) {
            result.traits.push_back( hallucination );
        }
        result.unique_id.clear();
    }
    return result;
}

sol::table spawn_npc(
    sol::this_state lua,
    const script_game_id &requested_template,
    const script_tripoint_coord &requested_position,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.spawns.npc";
    require_game_id(
        requested_template, "npc_template", api_name );
    const npc_spawn_options options =
        read_npc_spawn_options( requested_options );
    map &here = require_active_map( api_name );
    const tripoint_bub_ms target = require_loaded_position(
                                       here, requested_position, api_name );
    tripoint_bub_ms spawn_point;
    const bool found = g->find_nearby_spawn_point(
                           target, options.min_radius,
                           options.max_radius, spawn_point,
                           options.outdoor_only,
                           options.indoor_only,
                           options.open_air_allowed );
    sol::state_view state( lua );
    if( !found ) {
        return make_game_error_result( state, {
            "blocked",
            "No valid NPC spawn position was available"
        } );
    }
    std::string unique_id = options.unique_id;
    std::vector<trait_id> traits = options.traits;
    if( !g->spawn_npc(
            spawn_point,
            npc_template_id( requested_template.value() ),
            unique_id, traits, options.lifespan ) ) {
        return make_game_error_result( state, {
            "spawn_rejected",
            "Native NPC spawning rejected the request"
        } );
    }
    npc *spawned = get_creature_tracker().creature_at<npc>(
                       spawn_point, true );
    if( spawned == nullptr ) {
        return make_game_error_result( state, {
            "spawn_unavailable",
            "The spawned NPC was not loaded into the active creature tracker"
        } );
    }
    sol::table value = state.create_table();
    value["handle"] = make_creature_handle(
                          *spawned, runtime_generation,
                          world_generation );
    value["template"] = requested_template;
    value["id"] = spawned->getID().get_value();
    value["unique_id"] = spawned->get_unique_id();
    value["position"] = absolute_position( *spawned );
    value["hallucination"] = spawned->is_hallucination();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
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
                "services.spawns.hallucination option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "monster" ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "services.spawns.hallucination option 'monster' "
                    "must be a GameId" );
            }
            const script_game_id id =
                entry.second.as<script_game_id>();
            require_game_id(
                id, "monster", "services.spawns.hallucination" );
            result.monster_type = mtype_id( id.value() );
        } else if( key == "lifespan" ) {
            if( !entry.second.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.spawns.hallucination option 'lifespan' "
                    "must be a TimeDuration" );
            }
            const time_duration lifespan =
                entry.second.as<script_time_duration>().to_native();
            if( lifespan <= 0_turns ||
                lifespan > maximum_hallucination_lifespan ) {
                throw std::invalid_argument(
                    "services.spawns.hallucination lifespan must be "
                    "within 1 turn..10000 days" );
            }
            result.lifespan = lifespan;
        } else {
            throw std::invalid_argument(
                "services.spawns.hallucination received unknown option '" +
                key + "'" );
        }
    }
    if( result.lifespan && !result.monster_type ) {
        throw std::invalid_argument(
            "services.spawns.hallucination lifespan requires a monster id" );
    }
    return result;
}

sol::table spawn_hallucination(
    sol::this_state lua,
    const script_tripoint_coord &requested_position,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.spawns.hallucination";
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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
    const game_handle_runtime &runtime_generation,
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

struct creature_relocation_options {
    bool safe = true;
    bool add_teleglow = false;
    bool force = false;
    bool force_safe = false;
};

struct dimension_travel_options {
    int npc_travel_radius = 0;
    std::string npc_travel_filter = "all";
    int item_travel_radius = -1;
    bool take_vehicle = false;
};

dimension_travel_options read_dimension_travel_options(
    const sol::optional<sol::table> &requested )
{
    dimension_travel_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &field : *requested ) {
        if( field.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.relocation.travel_to_dimension option names must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key == "npc_travel_radius" || key == "item_travel_radius" ) {
            if( !field.second.is<int>() ) {
                throw std::invalid_argument(
                    "services.relocation.travel_to_dimension radius options must be integers" );
            }
            const int radius = field.second.as<int>();
            if( key == "npc_travel_radius" ) {
                if( radius < 0 || radius > maximum_monster_spawn_radius ) {
                    throw std::invalid_argument(
                        "services.relocation.travel_to_dimension npc_travel_radius must be within 0..60" );
                }
                result.npc_travel_radius = radius;
            } else {
                if( radius < -1 || radius > maximum_monster_spawn_radius ) {
                    throw std::invalid_argument(
                        "services.relocation.travel_to_dimension item_travel_radius must be within -1..60" );
                }
                result.item_travel_radius = radius;
            }
        } else if( key == "npc_travel_filter" ) {
            if( !field.second.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.relocation.travel_to_dimension npc_travel_filter must be a string" );
            }
            result.npc_travel_filter = field.second.as<std::string>();
            if( result.npc_travel_filter != "all" &&
                result.npc_travel_filter != "follower" &&
                result.npc_travel_filter != "enemy" &&
                result.npc_travel_filter != "none" ) {
                throw std::invalid_argument(
                    "services.relocation.travel_to_dimension npc_travel_filter must be all, follower, enemy, or none" );
            }
        } else if( key == "take_vehicle" ) {
            if( !field.second.is<bool>() ) {
                throw std::invalid_argument(
                    "services.relocation.travel_to_dimension take_vehicle must be boolean" );
            }
            result.take_vehicle = field.second.as<bool>();
        } else {
            throw std::invalid_argument(
                "services.relocation.travel_to_dimension received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

bool relocation_boolean_option(
    const sol::object &value, const std::string_view key )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            "services.relocation option '" + std::string( key ) +
            "' must be a boolean" );
    }
    return value.as<bool>();
}

creature_relocation_options read_creature_relocation_options(
    const sol::optional<sol::table> &requested )
{
    creature_relocation_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &field : *requested ) {
        if( field.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.relocation option names must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key == "safe" ) {
            result.safe = relocation_boolean_option( field.second, key );
        } else if( key == "add_teleglow" ) {
            result.add_teleglow = relocation_boolean_option( field.second, key );
        } else if( key == "force" ) {
            result.force = relocation_boolean_option( field.second, key );
        } else if( key == "force_safe" ) {
            result.force_safe = relocation_boolean_option( field.second, key );
        } else {
            throw std::invalid_argument(
                "services.relocation.creature_at received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

void translate_relocated_linked_items(
    visitable &items, const tripoint_rel_ms &offset )
{
    static constexpr std::string_view cable_turn_key =
        "eoc_cable_relocation_turn";
    items.visit_items( [&]( item *entry, item * ) {
        if( entry->has_link_data() && !entry->has_no_links() &&
            entry->link().t_abs_pos != tripoint_abs_ms::invalid ) {
            entry->link().t_abs_pos += offset;
            entry->link().s_bub_pos = tripoint_bub_ms::invalid;
            entry->set_var( std::string( cable_turn_key ), -1 );
        }
        return VisitResponse::NEXT;
    } );
}

sol::table creature_relocation_snapshot(
    sol::state_view state, Creature &creature, const bool changed,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table value = state.create_table();
    value["changed"] = changed;
    value["scope"] = creature_scope( creature );
    value["handle"] = make_creature_handle(
                           creature, runtime_generation,
                           world_generation );
    value["position"] = absolute_position( creature );
    value["overmap_terrain"] = script_tripoint_coord::from_native(
                                    coords::origin::abs,
                                    coords::scale::overmap_terrain,
                                    project_to<coords::omt>(
                                        creature.pos_abs() ).raw() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

game_handle make_relocated_vehicle_handle(
    vehicle &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position = entry.pos_abs();
    game_handle_locator locator;
    locator.scope = "map_vehicle";
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_vehicle(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

game_handle make_relocated_item_handle(
    item &entry, const tripoint_abs_ms &position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    locator.scope = "map";
    locator.stable_id = entry.uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_item(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

item_locator_hint relocation_item_hint( const game_handle &handle )
{
    item_locator_hint hint;
    const game_handle_locator &locator = handle.locator();
    if( locator.scope == "map" ) {
        hint.where = item_locator_hint::place::map;
        hint.location = tripoint_abs_ms(
                            locator.x, locator.y, locator.z );
    }
    return hint;
}

std::optional<item_location> locate_relocation_item(
    const game_handle &handle, item &resolved )
{
    item_location location = find_item_by_uid(
                                 resolved.uid().get_value(),
                                 relocation_item_hint( handle ) );
    if( !location || location.get_item() != &resolved ) {
        return std::nullopt;
    }
    return location;
}

void translate_vehicle_item_links(
    vehicle &entry, const tripoint_rel_ms &offset )
{
    for( const vpart_reference &part : entry.get_all_parts() ) {
        for( item &cargo :
             entry.get_items(
                 entry.part( part.part_index() ) ) ) {
            translate_relocated_linked_items(
                cargo, offset );
        }
    }
    for( const rider_data &rider : entry.get_riders() ) {
        if( rider.psg == nullptr ) {
            continue;
        }
        if( Character *character =
                rider.psg->as_character() ) {
            translate_relocated_linked_items(
                *character, offset );
        }
    }
}

sol::table relocate_creature(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_position,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.relocation.creature_at";
    map &here = require_active_map( api_name );
    const tripoint_abs_ms destination = require_absolute_ms(
                                            requested_position, api_name );
    const creature_relocation_options options =
        read_creature_relocation_options( requested_options );
    const native_handle_result<Creature> resolved = handle.resolve_creature(
            runtime_generation, world_generation );
    sol::state_view state( lua );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    Creature *creature = resolved.value;
    const tripoint_abs_ms before = creature->pos_abs();
    if( before == destination ) {
        return creature_relocation_snapshot(
                   state, *creature, false, runtime_generation,
                   world_generation );
    }
    const tripoint_bub_ms target = here.get_bub( destination );
    if( !teleport::teleport_to_point(
            *creature, target, options.safe, options.add_teleglow,
            false, options.force, options.force_safe ) ) {
        sol::table value = state.create_table();
        value["changed"] = false;
        value["scope"] = creature_scope( *creature );
        value["position"] = absolute_position( *creature );
        value["reason"] = "blocked";
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    if( Character *character = creature->as_character() ) {
        translate_relocated_linked_items(
            *character, character->pos_abs() - before );
    }
    return creature_relocation_snapshot(
               state, *creature, true, runtime_generation,
               world_generation );
}

sol::table relocate_vehicle(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_position,
    const sol::optional<bool> &requested_force,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.relocation.vehicle_at";
    require_active_map( api_name );
    const tripoint_abs_ms destination = require_absolute_ms(
                                            requested_position,
                                            api_name );
    const native_handle_result<vehicle> resolved =
        handle.resolve_vehicle(
            runtime_generation, world_generation );
    sol::state_view state( lua );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    vehicle &entry = *resolved.value;
    const tripoint_abs_ms before = entry.pos_abs();
    const bool force = requested_force.value_or( false );
    sol::table value = state.create_table();
    value["before"] = script_tripoint_coord::from_native(
                          coords::origin::abs,
                          coords::scale::map_square,
                          before.raw() );
    value["requested"] = requested_position;
    value["force"] = force;
    if( before == destination ) {
        value["accepted"] = true;
        value["changed"] = false;
        value["after"] = requested_position;
        value["handle"] = make_relocated_vehicle_handle(
                              entry, runtime_generation,
                              world_generation );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    if( !teleport::teleport_vehicle(
            entry, destination, force ) ) {
        value["accepted"] = false;
        value["changed"] = false;
        value["reason"] = "blocked";
        value["after"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::map_square,
                             entry.pos_abs().raw() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    translate_vehicle_item_links(
        entry, entry.pos_abs() - before );
    value["accepted"] = true;
    value["changed"] = entry.pos_abs() != before;
    value["reason"] = sol::nil;
    value["after"] = script_tripoint_coord::from_native(
                         coords::origin::abs,
                         coords::scale::map_square,
                         entry.pos_abs().raw() );
    value["handle"] = make_relocated_vehicle_handle(
                          entry, runtime_generation,
                          world_generation );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table relocate_item(
    sol::this_state lua, const game_handle &handle,
    const script_tripoint_coord &requested_position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "services.relocation.item_at";
    map &here = require_active_map( api_name );
    const tripoint_abs_ms destination = require_absolute_ms(
                                            requested_position,
                                            api_name );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    sol::state_view state( lua );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    std::optional<item_location> source =
        locate_relocation_item( handle, *resolved.value );
    if( !source ) {
        return make_game_error_result( state, {
            "wrong_location",
            "The referenced item is not in a relocatable loaded location"
        } );
    }

    const tripoint_abs_ms before = source->pos_abs();
    item moved = **source;
    translate_relocated_linked_items(
        moved, destination - before );

    sol::table value = state.create_table();
    const script_tripoint_coord before_value =
        script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::map_square,
            before.raw() );
    value["before"] = before_value;
    value["requested"] = requested_position;

    if( here.inbounds( destination ) ) {
        item &placed = here.add_item(
                           here.get_bub( destination ),
                           std::move( moved ) );
        if( placed.is_null() ) {
            value["accepted"] = false;
            value["changed"] = false;
            value["reason"] = "blocked";
            value["after"] = before_value;
            return make_game_value_result(
                       state, sol::make_object(
                           state, std::move( value ) ) );
        }
        source->remove_item();
        value["accepted"] = true;
        value["changed"] = true;
        value["remote"] = false;
        value["reason"] = sol::nil;
        value["after"] = requested_position;
        value["handle"] = make_relocated_item_handle(
                              placed, destination,
                              runtime_generation,
                              world_generation );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    bool placed = false;
    {
        tinymap target_bay;
        target_bay.load(
            project_to<coords::omt>( destination ), false );
        swap_map swap( *target_bay.cast_to_map() );
        item &remote_item = target_bay.add_item(
                                target_bay.get_omt( destination ),
                                std::move( moved ) );
        placed = !remote_item.is_null();
    }
    if( !placed ) {
        value["accepted"] = false;
        value["changed"] = false;
        value["reason"] = "blocked";
        value["after"] = before_value;
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    source->remove_item();
    value["accepted"] = true;
    value["changed"] = true;
    value["remote"] = true;
    value["reason"] = sol::nil;
    value["after"] = requested_position;
    value["handle"] = sol::nil;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table travel_to_dimension(
    sol::this_state lua, const std::string &requested_dimension,
    const sol::optional<sol::table> &requested_options )
{
    constexpr std::string_view api_name =
        "services.relocation.travel_to_dimension";
    map &here = require_active_map( api_name );
    const dimension_travel_options options =
        read_dimension_travel_options( requested_options );
    const dimension_id destination( requested_dimension );
    sol::state_view state( lua );
    if( !destination.is_valid() ) {
        return make_game_error_result( state, {
            "invalid_dimension",
            "services.relocation.travel_to_dimension requires a valid dimension id"
        } );
    }
    const dimension_id before = g->get_dimension_prefix();
    if( destination == before ) {
        sol::table value = state.create_table();
        value["accepted"] = false;
        value["changed"] = false;
        value["before"] = before.str();
        value["after"] = before.str();
        value["reason"] = "already_there";
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }

    std::vector<npc *> travellers;
    if( options.npc_travel_radius > 0 &&
        options.npc_travel_filter != "none" ) {
        avatar &player = get_avatar();
        const int radius = options.npc_travel_radius;
        const std::string filter = options.npc_travel_filter;
        travellers = g->get_npcs_if( [&player, radius, filter]( const npc &candidate ) {
            if( rl_dist( candidate.pos_abs(), player.pos_abs() ) > radius ) {
                return false;
            }
            if( filter == "all" ) {
                return true;
            }
            if( filter == "follower" ) {
                return candidate.is_following();
            }
            return candidate.is_enemy();
        } );
    }

    std::vector<item_location> items;
    std::optional<tripoint_bub_ms> item_center;
    if( options.item_travel_radius >= 0 ) {
        item_center = get_avatar().pos_bub( here );
        for( const tripoint_bub_ms &position : here.points_in_radius(
                 *item_center, options.item_travel_radius ) ) {
            for( item &entry : here.i_at( position ) ) {
                items.emplace_back( map_cursor( position ), &entry );
            }
        }
    }

    vehicle *vehicle_to_take = nullptr;
    if( options.take_vehicle ) {
        const optional_vpart_position vehicle_position = here.veh_at(
                get_avatar().pos_bub( here ) );
        if( !vehicle_position ) {
            return make_game_error_result( state, {
                "no_vehicle",
                "services.relocation.travel_to_dimension take_vehicle requires a vehicle"
            } );
        }
        vehicle_to_take = &vehicle_position->vehicle();
    }

    const bool accepted = g->travel_to_dimension(
                              destination, travellers, items, item_center,
                              vehicle_to_take );
    const dimension_id after = g->get_dimension_prefix();
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["changed"] = before != after;
    value["before"] = before.str();
    value["after"] = after.str();
    value["npc_travellers"] = travellers.size();
    value["items"] = items.size();
    value["vehicle"] = vehicle_to_take != nullptr;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table clear_saved_dimension(
    sol::this_state lua, const std::string &requested_dimension )
{
    constexpr std::string_view api_name =
        "services.relocation.clear_dimension";
    if( requested_dimension.empty() || requested_dimension.size() > 256 ||
        requested_dimension == "." || requested_dimension == ".." ||
        requested_dimension.find( '/' ) != std::string::npos ||
        requested_dimension.find( '\\' ) != std::string::npos ||
        requested_dimension.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a safe dimension id path component" );
    }
    const dimension_id dimension( requested_dimension );
    sol::state_view state( lua );
    if( !dimension.is_valid() ) {
        return make_game_error_result( state, {
            "invalid_dimension",
            "services.relocation.clear_dimension requires a valid dimension id"
        } );
    }
    if( g == nullptr ) {
        return make_game_error_result( state, {
            "world_unavailable",
            "services.relocation.clear_dimension requires an active world"
        } );
    }
    if( dimension == g->get_dimension_prefix() ) {
        return make_game_error_result( state, {
            "active_dimension",
            "The active dimension cannot be cleared"
        } );
    }

    const cata_path path =
        PATH_INFO::dimensions_save_path() / requested_dimension;
    const std::filesystem::path native = path.get_unrelative_path();
    std::error_code error;
    const bool existed = std::filesystem::is_directory( native, error );
    if( error ) {
        return make_game_error_result( state, {
            "filesystem_error", error.message()
        } );
    }
    std::uintmax_t removed = 0;
    if( existed ) {
        removed = std::filesystem::remove_all( native, error );
        if( error ) {
            return make_game_error_result( state, {
                "filesystem_error", error.message()
            } );
        }
    }
    sol::table value = state.create_table();
    value["dimension"] = requested_dimension;
    value["existed"] = existed;
    value["cleared"] = existed && removed > 0;
    value["removed_entries"] = removed;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table relocate_local(
    sol::this_state lua,
    const script_tripoint_coord &requested_position )
{
    constexpr std::string_view api_name =
        "services.relocation.local_at";
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
        "services.relocation.overmap_at";
    require_active_map( api_name );
    if( requested_position.native_origin() != coords::origin::abs ||
        requested_position.native_scale() !=
        coords::scale::overmap_terrain ) {
        throw std::invalid_argument(
            "services.relocation.overmap_at requires an absolute "
            "overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt destination(
        requested_position.to_native() );
    if( destination.z() < -OVERMAP_DEPTH ||
        destination.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument(
            "services.relocation.overmap_at z level is outside "
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
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<void()> require_dangerous_relocation,
    std::function<bool()> has_active_callback )
{
    sol::state_view state( game.lua_state() );

    sol::table spawns = state.create_table();
    spawns.set_function(
        "group_members",
        [require_read]( sol::this_state lua,
    const script_game_id &monster_group ) {
        require_read();
        return monsters_from_group(
                   lua, monster_group );
    } );
    spawns.set_function(
        "choose_monster_from_group",
        [require_read]( const script_game_id &monster_group ) {
        require_read();
        return random_monster_from_group( monster_group );
    } );
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
            has_active_callback, "services.spawns.monster" );
        return spawn_monster(
                   lua, monster_type, position, radius,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spawns.set_function(
        "monster_configured",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
            const script_game_id &monster_type,
            const script_tripoint_coord &position,
    const sol::optional<sol::table> &options ) {
        require_write();
        require_active_callback(
            has_active_callback,
            "services.spawns.monster_configured" );
        return spawn_configured_monster(
                   lua, monster_type, position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spawns.set_function(
        "monster_from_group",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
            const script_game_id &monster_group,
            const script_tripoint_coord &position,
    const sol::optional<sol::table> &options ) {
        require_write();
        require_active_callback(
            has_active_callback,
            "services.spawns.monster_from_group" );
        return spawn_configured_monster(
                   lua,
                   random_monster_from_group( monster_group ),
                   position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spawns.set_function(
        "npc",
        [current_runtime_generation,
         current_world_generation,
         require_write,
         has_active_callback](
            sol::this_state lua,
            const script_game_id &npc_template,
            const script_tripoint_coord &position,
            const sol::optional<sol::table> &options ) {
        require_write();
        require_active_callback(
            has_active_callback, "services.spawns.npc" );
        return spawn_npc(
                   lua, npc_template, position, options,
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
            "services.spawns.hallucination" );
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
            has_active_callback, "services.followers.add" );
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
            has_active_callback, "services.followers.remove" );
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
            "services.relocation.local_at" );
        return relocate_local( lua, position );
    } );
    relocation.set_function(
        "overmap_at",
        [authorize_relocation](
            sol::this_state lua,
    const script_tripoint_coord & position ) {
        authorize_relocation(
            "services.relocation.overmap_at" );
        return relocate_overmap( lua, position );
    } );
    relocation.set_function(
        "creature_at",
        [authorize_relocation, current_runtime_generation,
         current_world_generation, require_write](
            sol::this_state lua, const game_handle &handle,
            const script_tripoint_coord &position,
            const sol::optional<sol::table> &options ) {
        require_write();
        authorize_relocation( "services.relocation.creature_at" );
        return relocate_creature(
                   lua, handle, position, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    relocation.set_function(
        "vehicle_at",
        [authorize_relocation, current_runtime_generation,
         current_world_generation, require_write](
            sol::this_state lua, const game_handle &handle,
            const script_tripoint_coord &position,
            const sol::optional<bool> &force ) {
        require_write();
        authorize_relocation(
            "services.relocation.vehicle_at" );
        return relocate_vehicle(
                   lua, handle, position, force,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    relocation.set_function(
        "item_at",
        [authorize_relocation, current_runtime_generation,
         current_world_generation, require_write](
            sol::this_state lua, const game_handle &handle,
            const script_tripoint_coord &position ) {
        require_write();
        authorize_relocation(
            "services.relocation.item_at" );
        return relocate_item(
                   lua, handle, position,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    relocation.set_function(
        "travel_to_dimension",
        [authorize_relocation, require_write](
            sol::this_state lua, const std::string &dimension,
            const sol::optional<sol::table> &options ) {
        require_write();
        authorize_relocation(
            "services.relocation.travel_to_dimension" );
        return travel_to_dimension( lua, dimension, options );
    } );
    relocation.set_function(
        "clear_dimension",
        [authorize_relocation, require_write](
            sol::this_state lua, const std::string &dimension ) {
        require_write();
        authorize_relocation(
            "services.relocation.clear_dimension" );
        return clear_saved_dimension( lua, dimension );
    } );
    game["relocation"] = std::move( relocation );
}

} // namespace cata::lua

#endif // CATA_ENABLE_LUA_PLATFORM
