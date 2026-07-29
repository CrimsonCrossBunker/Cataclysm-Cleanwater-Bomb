#include "catalua_ui_creatures.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "catalua_bindings_coords.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "game.h"
#include "line.h"
#include "map.h"
#include "monster.h"
#include "mtype.h"
#include "npc.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_creature_query_radius = 20;
constexpr int maximum_creature_query_radius = 60;
constexpr int default_creature_query_limit = 64;
constexpr int maximum_creature_query_limit = 256;

struct creature_query_options {
    int radius = default_creature_query_radius;
    int limit = default_creature_query_limit;
    bool visible_only = true;
    bool include_avatar = false;
    bool include_hallucinations = false;
};

int bounded_nonnegative_option(
    const sol::table &options, const std::string &name,
    const int fallback, const int maximum )
{
    const int value = options.get_or( name, fallback );
    if( value < 0 ) {
        throw std::invalid_argument(
            "game.creatures query option '" + name + "' cannot be negative" );
    }
    return std::min( value, maximum );
}

creature_query_options read_query_options(
    const sol::optional<sol::table> &requested )
{
    creature_query_options result;
    if( !requested ) {
        return result;
    }
    result.radius = bounded_nonnegative_option(
                        *requested, "radius", result.radius,
                        maximum_creature_query_radius );
    result.limit = bounded_nonnegative_option(
                       *requested, "limit", result.limit,
                       maximum_creature_query_limit );
    result.visible_only = requested->get_or(
                              "visible_only", result.visible_only );
    result.include_avatar = requested->get_or(
                                "include_avatar", result.include_avatar );
    result.include_hallucinations = requested->get_or(
                                        "include_hallucinations",
                                        result.include_hallucinations );
    return result;
}

std::string creature_kind( const Creature &creature )
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

std::string creature_size_name( const creature_size size )
{
    switch( size ) {
        case creature_size::tiny:
            return "tiny";
        case creature_size::small:
            return "small";
        case creature_size::medium:
            return "medium";
        case creature_size::large:
            return "large";
        case creature_size::huge:
            return "huge";
        case creature_size::num_sizes:
            return "unknown";
    }
    return "unknown";
}

game_handle_locator creature_locator( Creature &creature )
{
    const tripoint_abs_ms position = creature.pos_abs();
    game_handle_locator locator;
    locator.scope = creature_kind( creature );
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    if( Character *character = creature.as_character() ) {
        locator.stable_id = character->getID().get_value();
    } else if( monster *mon = creature.as_monster() ) {
        locator.stable_id = get_creature_tracker().temporary_id( *mon );
    }
    return locator;
}

game_handle make_creature_handle(
    Creature &creature, const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    return game_handle::from_creature(
               creature, creature_locator( creature ),
               runtime_generation, world_generation );
}

sol::table snapshot_creature(
    sol::state_view lua, const Creature &creature )
{
    const avatar &player = get_avatar();
    map &here = get_map();
    const tripoint_abs_ms position = creature.pos_abs();
    sol::table result = lua.create_table();
    result["kind"] = creature_kind( creature );
    result["name"] = creature.get_name();
    result["display_name"] = creature.disp_name();
    result["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs, coords::scale::map_square,
                             position.raw() );
    result["visible"] = player.sees( here, creature );
    result["distance"] = rl_dist(
                             player.pos_bub(), creature.pos_bub( here ) );
    result["attitude"] = Creature::attitude_raw_string(
                             creature.attitude_to( player ) );
    result["dead"] = creature.is_dead_state();
    result["hallucination"] = creature.is_hallucination();
    result["hp"] = creature.get_hp();
    result["hp_max"] = creature.get_hp_max();
    result["hp_percent"] = creature.hp_percentage();
    result["moves"] = creature.get_moves();
    result["pain"] = creature.get_pain();
    result["perceived_pain"] = creature.get_perceived_pain();
    result["speed"] = creature.get_speed();
    result["size"] = creature_size_name( creature.get_size() );
    result["power_rating"] = creature.power_rating();
    result["speed_rating"] = creature.speed_rating();
    result["ranged_target_size"] = creature.ranged_target_size();
    result["underwater"] = creature.is_underwater();
    result["on_ground"] = creature.is_on_ground();
    result["digging"] = creature.digging();
    result["warm"] = creature.is_warm();
    result["has_weapon"] = creature.has_weapon();
    result["effect_count"] = creature.get_effects().size();

    if( const monster *mon = creature.as_monster() ) {
        result["type_id"] = mon->type->id.str();
        result["friendly"] = mon->friendly != 0;
    } else {
        result["type_id"] = std::string();
        result["friendly"] = !creature.is_npc() ||
                             creature.attitude_to( player ) ==
                             Creature::Attitude::FRIENDLY;
    }
    return result;
}

sol::table creature_snapshot_result(
    sol::this_state lua, const game_handle &handle,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const native_handle_result<Creature> resolved =
        handle.resolve_creature( runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_creature( state, *resolved.value ) ) );
}

sol::table nearby_creatures(
    sol::this_state lua, const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const creature_query_options options = read_query_options( requested );
    avatar &player = get_avatar();
    map &here = get_map();
    std::vector<Creature *> creatures;
    if( g != nullptr ) {
        creatures = g->get_creatures_if(
        [&]( const Creature & candidate ) {
            if( candidate.is_dead_state() ||
                ( !options.include_avatar && candidate.is_avatar() ) ||
                ( !options.include_hallucinations &&
                  candidate.is_hallucination() ) ) {
                return false;
            }
            if( rl_dist( player.pos_bub(), candidate.pos_bub( here ) ) >
                options.radius ) {
                return false;
            }
            return !options.visible_only || player.sees( here, candidate );
        } );
    } else if( options.include_avatar ) {
        creatures.push_back( &player );
    }
    std::sort(
        creatures.begin(), creatures.end(),
    [&]( const Creature * lhs, const Creature * rhs ) {
        const int lhs_distance =
            rl_dist( player.pos_bub(), lhs->pos_bub( here ) );
        const int rhs_distance =
            rl_dist( player.pos_bub(), rhs->pos_bub( here ) );
        if( lhs_distance != rhs_distance ) {
            return lhs_distance < rhs_distance;
        }
        return creature_kind( *lhs ) < creature_kind( *rhs );
    } );

    const std::size_t returned = std::min(
                                     creatures.size(),
                                     static_cast<std::size_t>( options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        Creature &creature = *creatures[index];
        sol::table entry = state.create_table();
        entry["handle"] = make_creature_handle(
                              creature, runtime_generation, world_generation );
        entry["snapshot"] = snapshot_creature( state, creature );
        items[index + 1] = std::move( entry );
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = creatures.size();
    result["returned"] = returned;
    result["radius"] = options.radius;
    result["limit"] = options.limit;
    result["visible_only"] = options.visible_only;
    result["include_avatar"] = options.include_avatar;
    result["include_hallucinations"] = options.include_hallucinations;
    result["truncated"] = returned < creatures.size();
    return result;
}

sol::table creature_at(
    sol::this_state lua, const script_tripoint_coord &position,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    if( position.native_origin() != coords::origin::abs ||
        position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            "game.creatures.at requires an absolute map-square coordinate" );
    }
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    Creature *creature = get_creature_tracker().creature_at<Creature>(
                             tripoint_abs_ms( position.to_native() ), true );
    if( creature == nullptr || creature->is_dead_state() ) {
        return make_game_error_result(
                   state, { "not_found", "No active creature exists at that position" } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, make_creature_handle(
                       *creature, runtime_generation, world_generation ) ) );
}

} // namespace

void install_creature_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table creatures = lua.create_table();
    creatures.set_function(
        "avatar",
        [current_runtime_generation, current_world_generation,
                                require_read]() {
        require_read();
        return make_creature_handle(
                   get_avatar(), current_runtime_generation(),
                   current_world_generation() );
    } );
    creatures.set_function(
        "snapshot",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return creature_snapshot_result(
                   lua_state, handle, current_runtime_generation(),
                   current_world_generation() );
    } );
    creatures.set_function(
        "nearby",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return nearby_creatures(
                   lua_state, options, current_runtime_generation(),
                   current_world_generation() );
    } );
    creatures.set_function(
        "at",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const script_tripoint_coord & position ) {
        require_read();
        return creature_at(
                   lua_state, position, current_runtime_generation(),
                   current_world_generation() );
    } );
    game["creatures"] = std::move( creatures );

    // Kept in the installer signature so later capability-gated creature
    // mutations use the same immutable authorization closure.
    ( void )require_write;
}

} // namespace cata::lua_ui
