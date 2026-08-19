#if CATA_ENABLE_LUA_UI

#include "catalua_ui_creatures.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <initializer_list>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "damage.h"
#include "enum_conversions.h"
#include "explosion.h"
#include "faction.h"
#include "game.h"
#include "gun_mode.h"
#include "line.h"
#include "map.h"
#include "magic.h"
#include "martialarts.h"
#include "monster.h"
#include "move_mode.h"
#include "mtype.h"
#include "npc.h"
#include "item.h"
#include "itype.h"
#include "magic_enchantment.h"
#include "mongroup.h"
#include "overmapbuffer.h"
#include "profession.h"
#include "rng.h"
#include "translation.h"
#include "uilist.h"
#include "units.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "weather.h"
#include "widget.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_creature_query_radius = 20;
constexpr int maximum_creature_query_radius = 1000;
constexpr int maximum_creature_count_radius = 1000;
constexpr int default_creature_query_limit = 64;
constexpr int maximum_creature_query_limit = 256;
constexpr int maximum_creature_query_offset = 1000000;
constexpr int default_body_part_snapshot_limit = 32;
constexpr int maximum_body_part_snapshot_limit = 64;
constexpr int maximum_character_adjustment = 1000000;
constexpr int maximum_character_attribute = 1000000;
constexpr int maximum_character_healing = 10000;
constexpr double maximum_character_damage = 1000000.0;
constexpr double maximum_character_damage_multiplier = 1000.0;
constexpr int maximum_character_hit_option = 1000000;
constexpr double maximum_character_part_temperature = 1000000.0;
constexpr std::int64_t maximum_faction_trust_adjustment = 1000000;
constexpr double maximum_combat_number = 1000000.0;
constexpr double maximum_combat_multiplier = 1000.0;
constexpr int maximum_combat_radius = 1000;
constexpr int maximum_combat_noise = 1000000000;
constexpr int maximum_combat_string_bytes = 4096;
constexpr std::size_t maximum_training_offers = 256;
constexpr std::size_t maximum_enchantment_value_key_bytes = 256;
constexpr double maximum_enchantment_value_base = 1.0e15;

// Sentinel flag mirrored from conditional_t::f_has_flag (src/condition.cpp):
// u_has_flag checks threshold-crossing state rather than literal flag presence.
const json_character_flag json_flag_MUTATION_THRESHOLD( "MUTATION_THRESHOLD" );
const json_character_flag json_flag_SEESLEEP( "SEESLEEP" );

struct creature_query_options {
    int radius = default_creature_query_radius;
    int limit = default_creature_query_limit;
    int offset = 0;
    bool visible_only = true;
    bool include_avatar = false;
    bool include_hallucinations = false;
    std::string kind = "any";
    std::optional<tripoint_abs_ms> origin;
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
    result.offset = bounded_nonnegative_option(
                        *requested, "offset", result.offset,
                        maximum_creature_query_offset );
    result.visible_only = requested->get_or(
                              "visible_only", result.visible_only );
    result.include_avatar = requested->get_or(
                                "include_avatar", result.include_avatar );
    result.include_hallucinations = requested->get_or(
                                        "include_hallucinations",
                                        result.include_hallucinations );
    result.kind = requested->get_or(
                      "kind", result.kind );
    if( result.kind != "any" && result.kind != "character" &&
        result.kind != "avatar" && result.kind != "npc" &&
        result.kind != "monster" ) {
        throw std::invalid_argument(
            "game.creatures query option 'kind' must be any, character, "
            "avatar, npc, or monster" );
    }
    const sol::object requested_origin =
        requested->raw_get<sol::object>( "origin" );
    if( requested_origin.valid() &&
        requested_origin.get_type() != sol::type::nil ) {
        if( !requested_origin.is<script_tripoint_coord>() ) {
            throw std::invalid_argument(
                "game.creatures query option 'origin' must be a Tripoint" );
        }
        const script_tripoint_coord origin =
            requested_origin.as<script_tripoint_coord>();
        if( origin.native_origin() != coords::origin::abs ||
            origin.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "game.creatures query option 'origin' must be an absolute "
                "map-square coordinate" );
        }
        result.origin = tripoint_abs_ms( origin.to_native() );
    }
    return result;
}

bool query_kind_matches(
    const Creature &candidate, const std::string &kind )
{
    if( kind == "any" ) {
        return true;
    }
    if( kind == "character" ) {
        return candidate.as_character() != nullptr;
    }
    if( kind == "avatar" ) {
        return candidate.is_avatar();
    }
    if( kind == "npc" ) {
        return candidate.is_npc();
    }
    return candidate.is_monster();
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
    Creature &creature, const game_handle_runtime &runtime_generation,
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
        result["friendly_value"] = mon->friendly;
        result["anger"] = mon->anger;
        result["morale"] = mon->morale;
        result["difficulty"] =
            mon->type->get_total_difficulty();
        result["grab_strength"] =
            mon->get_grab_strength();
        result["size_index"] = static_cast<int>(
                                   mon->get_size() );
        result["vision_range"] = mon->sight_range(
                                     here.ambient_light_at(
                                         mon->pos_bub( here ) ) );
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
    const game_handle_runtime &runtime_generation,
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

sol::table creature_has_species(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested.kind() != "species" || !requested.is_valid() ) {
        throw std::invalid_argument(
            "game.creatures.has_species requires a valid GameId<species>" );
    }
    sol::state_view state( lua );
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, resolved.value->in_species(
                       species_id( requested.value() ) ) ) );
}

sol::table creature_has_body_type(
    sol::this_state lua, const game_handle &handle,
    const std::string &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested.empty() || requested.size() > 128 ||
        std::any_of( requested.begin(), requested.end(),
    []( const unsigned char ch ) {
        return ch < 0x20U || ch == 0x7fU;
    } ) ) {
        throw std::invalid_argument(
            "game.creatures.has_body_type requires 1 to 128 non-control bytes" );
    }
    sol::state_view state( lua );
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    bool matches = false;
    if( const monster *entry = resolved.value->as_monster() ) {
        matches = entry->type->bodytype == requested;
    } else if( resolved.value->as_character() != nullptr ) {
        // This mirrors talker_character_const::bodytype until Characters
        // gain a native body-type property.
        matches = requested == "human";
    }
    return make_game_value_result(
               state, sol::make_object( state, matches ) );
}

sol::table creature_line_of_sight(
    sol::this_state lua, const game_handle &observer_handle,
    const game_handle &target_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const native_handle_result<Creature> observer =
        observer_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !observer ) {
        return make_game_error_result( state, *observer.error );
    }
    const native_handle_result<Creature> target =
        target_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !target ) {
        return make_game_error_result( state, *target.error );
    }
    const bool visible = get_map().sees(
                             observer.value->pos_bub(),
                             target.value->pos_bub(),
                             MAX_VIEW_DISTANCE );
    return make_game_value_result(
               state, sol::make_object( state, visible ) );
}

std::optional<cardinal_direction> parse_cardinal_direction(
    const std::string_view requested )
{
    static const std::vector<std::pair<std::string_view, cardinal_direction>>
    directions = {
        { "N", cardinal_direction::NORTH },
        { "NE", cardinal_direction::NORTHEAST },
        { "E", cardinal_direction::EAST },
        { "SE", cardinal_direction::SOUTHEAST },
        { "S", cardinal_direction::SOUTH },
        { "SW", cardinal_direction::SOUTHWEST },
        { "W", cardinal_direction::WEST },
        { "NW", cardinal_direction::NORTHWEST },
        { "L", cardinal_direction::LOCAL }
    };
    for( const auto &entry : directions ) {
        if( entry.first == requested ) {
            return entry.second;
        }
    }
    return std::nullopt;
}

sol::table visible_monsters_by_direction(
    sol::this_state lua, const std::string &requested_direction )
{
    const std::optional<cardinal_direction> parsed =
        parse_cardinal_direction( requested_direction );
    if( !parsed ) {
        throw std::invalid_argument(
            "game.creatures.visible_monsters direction must be one of "
            "N, NE, E, SE, S, SW, W, NW, or L" );
    }
    const std::size_t index = static_cast<std::size_t>( *parsed );
    const monster_visible_info &visible =
        get_avatar().get_mon_visible();
    int total = 0;
    for( const auto &entry : visible.unique_mons[index] ) {
        total += std::max( entry.second, 0 );
    }
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["direction"] = requested_direction;
    result["count"] = total;
    result["type_count"] = visible.unique_mons[index].size();
    result["present"] = !visible.unique_mons[index].empty();
    result["dangerous"] = index < visible.dangerous.size() &&
                            visible.dangerous[index];
    return result;
}

sol::table nearby_creatures(
    sol::this_state lua, const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const creature_query_options options = read_query_options( requested );
    avatar &player = get_avatar();
    map &here = get_map();
    const tripoint_abs_ms origin =
        options.origin.value_or( player.pos_abs() );
    std::vector<Creature *> creatures;
    if( g != nullptr ) {
        creatures = g->get_creatures_if(
        [&]( const Creature & candidate ) {
            if( candidate.is_dead_state() ||
                ( !options.include_avatar && candidate.is_avatar() ) ||
                ( !options.include_hallucinations &&
                  candidate.is_hallucination() ) ||
                !query_kind_matches( candidate, options.kind ) ) {
                return false;
            }
            if( rl_dist( origin, candidate.pos_abs() ) >
                options.radius ) {
                return false;
            }
            return !options.visible_only || player.sees( here, candidate );
        } );
    } else if( options.include_avatar ) {
        if( query_kind_matches( player, options.kind ) &&
            rl_dist( origin, player.pos_abs() ) <= options.radius ) {
            creatures.push_back( &player );
        }
    }
    std::sort(
        creatures.begin(), creatures.end(),
    [&]( const Creature * lhs, const Creature * rhs ) {
        const int lhs_distance =
            rl_dist( origin, lhs->pos_abs() );
        const int rhs_distance =
            rl_dist( origin, rhs->pos_abs() );
        if( lhs_distance != rhs_distance ) {
            return lhs_distance < rhs_distance;
        }
        return creature_kind( *lhs ) < creature_kind( *rhs );
    } );

    const std::size_t offset = std::min(
                                   creatures.size(),
                                   static_cast<std::size_t>( options.offset ) );
    const std::size_t returned = std::min(
                                     creatures.size() - offset,
                                     static_cast<std::size_t>( options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        Creature &creature = *creatures[offset + index];
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
    result["offset"] = offset;
    result["radius"] = options.radius;
    result["limit"] = options.limit;
    result["kind"] = options.kind;
    result["origin"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::map_square,
                           origin.raw() );
    result["visible_only"] = options.visible_only;
    result["include_avatar"] = options.include_avatar;
    result["include_hallucinations"] = options.include_hallucinations;
    result["has_more"] = offset + returned < creatures.size();
    result["truncated"] = offset != 0 ||
                            returned < creatures.size();
    return result;
}

sol::table creature_at(
    sol::this_state lua, const script_tripoint_coord &position,
    const game_handle_runtime &runtime_generation,
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

const Character *character_from_handle(
    const game_handle &handle, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature( runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    const Character *character = resolved.value->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not a character"
        };
    }
    return character;
}

Character *mutable_character_from_handle(
    const game_handle &handle, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature( runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    Character *character = resolved.value->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not a character"
        };
    }
    return character;
}

enum class nearby_character_attitude {
    any,
    allies,
    not_allies,
    hostile
};

struct nearby_character_count_options {
    int radius = maximum_creature_count_radius;
    nearby_character_attitude attitude = nearby_character_attitude::any;
    bool allow_hallucinations = false;
};

nearby_character_count_options read_nearby_character_count_options(
    const sol::optional<sol::table> &requested )
{
    nearby_character_count_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.characters.count_nearby option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "radius" ) {
            if( !entry.second.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "game.characters.count_nearby radius must be an integer" );
            }
            const lua_Integer radius = entry.second.as<lua_Integer>();
            if( radius < 0 || radius > maximum_creature_count_radius ) {
                throw std::invalid_argument(
                    "game.characters.count_nearby radius must be within 0..1000" );
            }
            result.radius = static_cast<int>( radius );
        } else if( key == "attitude" ) {
            if( !entry.second.is<std::string>() ) {
                throw std::invalid_argument(
                    "game.characters.count_nearby attitude must be a string" );
            }
            const std::string attitude = entry.second.as<std::string>();
            if( attitude == "any" ) {
                result.attitude = nearby_character_attitude::any;
            } else if( attitude == "allies" ) {
                result.attitude = nearby_character_attitude::allies;
            } else if( attitude == "not_allies" ) {
                result.attitude = nearby_character_attitude::not_allies;
            } else if( attitude == "hostile" ) {
                result.attitude = nearby_character_attitude::hostile;
            } else {
                throw std::invalid_argument(
                    "game.characters.count_nearby attitude must be any, allies, "
                    "not_allies, or hostile" );
            }
        } else if( key == "allow_hallucinations" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    "game.characters.count_nearby allow_hallucinations must be a boolean" );
            }
            result.allow_hallucinations = entry.second.as<bool>();
        } else {
            throw std::invalid_argument(
                "game.characters.count_nearby received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

bool nearby_character_attitude_matches(
    const Character &observer, const Character &candidate,
    const nearby_character_attitude attitude )
{
    switch( attitude ) {
        case nearby_character_attitude::any:
            return true;
        case nearby_character_attitude::allies:
            return candidate.is_ally( observer );
        case nearby_character_attitude::not_allies:
            return !candidate.is_ally( observer );
        case nearby_character_attitude::hostile:
            return candidate.attitude_to( observer ) ==
                   Creature::Attitude::HOSTILE ||
                   ( observer.is_avatar() && candidate.is_npc() &&
                     candidate.as_npc()->guaranteed_hostile() );
    }
    return false;
}

tripoint_abs_ms nearby_count_origin(
    const script_tripoint_coord &origin,
    const std::string &api_name )
{
    if( origin.native_origin() != coords::origin::abs ||
        origin.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name +
            " origin must be an absolute map-square coordinate" );
    }
    return tripoint_abs_ms( origin.to_native() );
}

sol::table count_nearby_characters(
    sol::this_state lua, const script_tripoint_coord &origin,
    const sol::optional<game_handle> &requested_observer,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.characters.count_nearby";
    const nearby_character_count_options options =
        read_nearby_character_count_options( requested_options );
    const tripoint_abs_ms native_origin = nearby_count_origin(
            origin, std::string( api_name ) );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }

    const Character *observer = nullptr;
    if( requested_observer ) {
        std::optional<game_handle_error> error;
        observer = character_from_handle(
                       *requested_observer, runtime_generation,
                       world_generation, error );
        if( observer == nullptr ) {
            return make_game_error_result( state, *error );
        }
    } else if( options.attitude != nearby_character_attitude::any ) {
        throw std::invalid_argument(
            "game.characters.count_nearby requires an observer for attitude filtering" );
    }

    const std::vector<Character *> matches = g->get_characters_if(
    [&]( const Character & candidate ) {
        if( candidate.is_hallucination() &&
            !options.allow_hallucinations ) {
            return false;
        }
        if( observer != nullptr &&
            candidate.getID() == observer->getID() ) {
            return false;
        }
        if( rl_dist( candidate.pos_abs(), native_origin ) >
            options.radius ) {
            return false;
        }
        return observer == nullptr ||
               nearby_character_attitude_matches(
                   *observer, candidate, options.attitude );
    } );
    return make_game_value_result(
               state, sol::make_object(
                   state, static_cast<std::int64_t>( matches.size() ) ) );
}

enum class nearby_monster_filter_kind {
    type,
    species,
    group
};

struct nearby_monster_count_options {
    int radius = maximum_creature_count_radius;
    std::string attitude = "hostile";
};

nearby_monster_count_options read_nearby_monster_count_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    nearby_monster_count_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "radius" ) {
            if( !entry.second.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    api_name + " radius must be an integer" );
            }
            const lua_Integer radius = entry.second.as<lua_Integer>();
            if( radius < 0 || radius > maximum_creature_count_radius ) {
                throw std::invalid_argument(
                    api_name + " radius must be within 0..1000" );
            }
            result.radius = static_cast<int>( radius );
        } else if( key == "attitude" ) {
            if( !entry.second.is<std::string>() ) {
                throw std::invalid_argument(
                    api_name + " attitude must be a string" );
            }
            result.attitude = entry.second.as<std::string>();
            if( result.attitude != "hostile" &&
                result.attitude != "friendly" &&
                result.attitude != "both" ) {
                throw std::invalid_argument(
                    api_name +
                    " attitude must be hostile, friendly, or both" );
            }
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" + key + "'" );
        }
    }
    return result;
}

std::string nearby_monster_filter_name(
    const nearby_monster_filter_kind kind )
{
    switch( kind ) {
        case nearby_monster_filter_kind::type:
            return "monster";
        case nearby_monster_filter_kind::species:
            return "species";
        case nearby_monster_filter_kind::group:
            return "monster_group";
    }
    return std::string();
}

std::vector<std::string> read_nearby_monster_ids(
    const sol::optional<sol::table> &requested,
    const nearby_monster_filter_kind kind,
    const std::string &api_name )
{
    std::vector<std::string> result;
    if( !requested ) {
        return result;
    }
    const std::size_t count = requested->size();
    if( count > maximum_creature_query_limit ) {
        throw std::invalid_argument(
            api_name + " accepts at most 256 ids" );
    }
    std::size_t entries = 0;
    for( const auto &entry : *requested ) {
        ++entries;
        if( !entry.first.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " ids must be a dense GameId array" );
        }
        const lua_Integer index = entry.first.as<lua_Integer>();
        if( index < 1 ||
            static_cast<std::size_t>( index ) > count ) {
            throw std::invalid_argument(
                api_name + " ids must be a dense GameId array" );
        }
    }
    if( entries != count ) {
        throw std::invalid_argument(
            api_name + " ids must be a dense GameId array" );
    }
    const std::string expected_kind =
        nearby_monster_filter_name( kind );
    result.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = requested->raw_get<sol::object>( index );
        if( !value.is<script_game_id>() ) {
            throw std::invalid_argument(
                api_name + " ids must contain GameId<" +
                expected_kind + "> values" );
        }
        const script_game_id id = value.as<script_game_id>();
        if( id.kind() != expected_kind || !id.is_valid() ) {
            throw std::invalid_argument(
                api_name + " ids must contain valid GameId<" +
                expected_kind + "> values" );
        }
        result.push_back( id.value() );
    }
    return result;
}

bool nearby_monster_id_matches(
    const monster &candidate,
    const std::vector<std::string> &ids,
    const nearby_monster_filter_kind kind )
{
    if( ids.empty() ) {
        return true;
    }
    return std::any_of(
               ids.begin(), ids.end(),
    [&]( const std::string & id ) {
        switch( kind ) {
            case nearby_monster_filter_kind::type:
                return candidate.type->id == mtype_id( id );
            case nearby_monster_filter_kind::species:
                return candidate.in_species( species_id( id ) );
            case nearby_monster_filter_kind::group:
                return MonsterGroupManager::IsMonsterInGroup(
                           mongroup_id( id ), candidate.type->id );
        }
        return false;
    } );
}

sol::table count_nearby_monsters(
    sol::this_state lua, const script_tripoint_coord &origin,
    const sol::optional<sol::table> &requested_ids,
    const sol::optional<sol::table> &requested_options,
    const nearby_monster_filter_kind kind )
{
    const std::string api_name = kind == nearby_monster_filter_kind::type ?
                                 "game.monsters.count_nearby" :
                                 kind == nearby_monster_filter_kind::species ?
                                 "game.monsters.count_species_nearby" :
                                 "game.monsters.count_groups_nearby";
    const nearby_monster_count_options options =
        read_nearby_monster_count_options(
            requested_options, api_name );
    const std::vector<std::string> ids =
        read_nearby_monster_ids(
            requested_ids, kind, api_name );
    const tripoint_abs_ms native_origin =
        nearby_count_origin( origin, api_name );
    sol::state_view state( lua );
    if( g == nullptr ) {
        return make_game_error_result(
                   state, { "unavailable", "No active game is available" } );
    }
    const std::vector<Creature *> matches = g->get_creatures_if(
    [&]( const Creature & creature ) {
        const monster *candidate = creature.as_monster();
        if( candidate == nullptr ||
            rl_dist( candidate->pos_abs(), native_origin ) >
            options.radius ||
            !nearby_monster_id_matches( *candidate, ids, kind ) ) {
            return false;
        }
        if( options.attitude == "both" ) {
            return true;
        }
        return options.attitude == "friendly" ?
               candidate->friendly != 0 :
               candidate->friendly == 0;
    } );
    return make_game_value_result(
               state, sol::make_object(
                   state, static_cast<std::int64_t>( matches.size() ) ) );
}

// Mirrors conditional_t::f_has_profession (src/condition.cpp): true when the
// character's current profession matches, or when the id names a held hobby.
// Unknown ids are guarded by is_valid() so they never dereference a dummy.
bool character_has_profession(
    const Character &character, const profession_id &requested )
{
    const profession *current = character.prof;
    if( current != nullptr && current->get_profession_id() == requested ) {
        return true;
    }
    if( requested.is_valid() && requested->is_hobby() ) {
        for( const profession *hobby : character.get_hobbies() ) {
            if( hobby->get_profession_id() == requested ) {
                return true;
            }
        }
    }
    return false;
}

bool character_is_alive_value( const Character &character )
{
    return !character.is_dead_state();
}

bool character_is_underwater_value( const Character &character )
{
    const map &here = get_map();
    // This intentionally mirrors conditional_t::f_is_underwater: the
    // legacy predicate asks whether the actor's current tile is divable,
    // rather than whether Creature::underwater is already set.
    return here.is_divable( character.pos_bub( here ) );
}

sol::table character_boolean_query(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    bool ( *predicate )( const Character & ) )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object( state, predicate( *character ) ) );
}

void require_id_kind( const script_game_id &id, const std::string &kind,
                      const std::string &api_name )
{
    if( id.kind() != kind ) {
        throw std::invalid_argument(
            api_name + " requires GameId<" + kind + ">" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<" + kind + ">" );
    }
}

bodypart_id character_body_part(
    const Character &character, const script_game_id &requested,
    const std::string &api_name )
{
    require_id_kind( requested, "body_part", api_name );
    const bodypart_id result =
        bodypart_str_id( requested.value() ).id();
    const std::vector<bodypart_id> available =
        character.get_all_body_parts();
    if( std::find( available.begin(), available.end(), result ) ==
        available.end() ) {
        throw std::invalid_argument(
            api_name + " body part is not present on this character" );
    }
    return result;
}

sol::table character_has_part_temperature(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &body_part, const double minimum,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( !std::isfinite( minimum ) ||
        minimum < -maximum_character_part_temperature ||
        minimum > maximum_character_part_temperature ) {
        throw std::invalid_argument(
            "services.characters.has_part_temp minimum must be finite and within "
            "-1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bodypart_id part = character_body_part(
                                 *character, body_part,
                                 "services.characters.has_part_temp" );
    const int actual = units::to_legacy_bodypart_temp(
                           character->get_part_temp_conv( part ) );
    return make_game_value_result(
               state, sol::make_object( state,
                   static_cast<double>( actual ) >= minimum ) );
}

sol::table character_armor(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_damage_type,
    const script_game_id &requested_body_part,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_damage_type, "damage_type",
        "game.characters.armor" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bodypart_id part = character_body_part(
                                 *character, requested_body_part,
                                 "game.characters.armor" );
    const damage_type_id damage_type(
        requested_damage_type.value() );
    const double value = character->worn.damage_resist(
                             damage_type, part );
    return make_game_value_result(
               state, sol::make_object( state, value ) );
}

sol::table character_coverage(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_body_part,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bodypart_id part = character_body_part(
                                 *character, requested_body_part,
                                 "game.characters.coverage" );
    return make_game_value_result(
               state, sol::make_object(
                   state, character->worn.get_coverage( part ) ) );
}

sol::table character_limb_score(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_score,
    const sol::optional<std::string> &requested_body_part_type,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_score, "limb_score",
        "game.characters.limb_score" );
    bp_type body_part_type = bp_type::num_types;
    if( requested_body_part_type ) {
        if( requested_body_part_type->empty() ||
            requested_body_part_type->size() > 64 ) {
            throw std::invalid_argument(
                "game.characters.limb_score body part type is invalid" );
        }
        body_part_type = io::string_to_enum<bp_type>(
                             *requested_body_part_type );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const double value = character->get_limb_score(
                             limb_score_id( requested_score.value() ),
                             body_part_type );
    return make_game_value_result(
               state, sol::make_object( state, value ) );
}

itype_id canonical_consumption_id( const itype_id &id )
{
    if( id->comestible && !id->comestible->eats_like.is_empty() ) {
        return id->comestible->eats_like;
    }
    return id;
}

sol::table character_consumption_count(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<script_game_id> &requested_item,
    const sol::optional<script_time_duration> &requested_window,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    std::optional<itype_id> item_type;
    if( requested_item ) {
        require_id_kind(
            *requested_item, "item",
            "game.characters.consumption_count" );
        item_type = canonical_consumption_id(
                        itype_id( requested_item->value() ) );
    }
    const time_duration window = requested_window ?
                                 requested_window->to_native() : 48_hours;
    if( window < 0_turns || window > 10000_days ) {
        throw std::invalid_argument(
            "game.characters.consumption_count window must be within 0 turns and 10000 days" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    int count = 0;
    for( const consumption_event &event :
         character->consumption_history ) {
        if( event.time > calendar::turn - window &&
            ( !item_type ||
              canonical_consumption_id( event.type_id ) == *item_type ) ) {
            ++count;
        }
    }
    return make_game_value_result(
               state, sol::make_object( state, count ) );
}

sol::table character_enchantment_value(
    sol::this_state lua, const game_handle &handle,
    const std::string &key, const sol::optional<double> &requested_base,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const double base = requested_base.value_or( 0.0 );
    if( key.empty() ||
        key.size() > maximum_enchantment_value_key_bytes ||
        key.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "game.characters.enchantment_value key is invalid" );
    }
    if( !std::isfinite( base ) ||
        std::abs( base ) > maximum_enchantment_value_base ) {
        throw std::invalid_argument(
            "game.characters.enchantment_value base must be finite and within its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const double value =
        character->enchantment_cache->modify_value( key, base );
    return make_game_value_result(
               state, sol::make_object( state, value ) );
}

sol::table set_character_hp(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_body_part, const int requested_hp,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_hp < -maximum_character_healing ||
        requested_hp > maximum_character_healing ) {
        throw std::invalid_argument(
            "game.characters.set_hp value must be within -10000..10000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bodypart_id part = character_body_part(
                                 *character, requested_body_part,
                                 "game.characters.set_hp" );
    const int before = character->get_part_hp_cur( part );
    character->set_part_hp_cur( part, requested_hp );
    const int after = character->get_part_hp_cur( part );
    sol::table value = state.create_table();
    value["body_part"] = requested_body_part;
    value["before"] = before;
    value["after"] = after;
    value["maximum"] = character->get_part_hp_max( part );
    value["changed"] = before != after;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

get_body_part_flags hp_group_flags(
    const std::string &group, const std::string &api_name )
{
    if( group == "ALL" ) {
        return get_body_part_flags::none;
    }
    if( group == "ALL_MAJOR" ) {
        return get_body_part_flags::only_main;
    }
    if( group == "ALL_MINOR" ) {
        return get_body_part_flags::only_minor;
    }
    throw std::invalid_argument(
        api_name + " group must be ALL, ALL_MAJOR, or ALL_MINOR" );
}

sol::table character_hp_group(
    sol::this_state lua, const game_handle &handle,
    const std::string &group,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const get_body_part_flags flags = hp_group_flags(
                                          group,
                                          "game.characters.hp_group" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::int64_t total = 0;
    for( const bodypart_id &part :
         character->get_all_body_parts( flags ) ) {
        total += character->get_part_hp_cur( part );
    }
    return make_game_value_result(
               state, sol::make_object( state, total ) );
}

sol::table set_character_hp_group(
    sol::this_state lua, const game_handle &handle,
    const std::string &group, const int requested_hp,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name = "game.characters.set_hp_group";
    const get_body_part_flags flags = hp_group_flags(
                                          group, api_name );
    if( requested_hp < -maximum_character_healing ||
        requested_hp > maximum_character_healing ) {
        throw std::invalid_argument(
            api_name + " value must be within -10000..10000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::int64_t before = 0;
    std::int64_t after = 0;
    const std::vector<bodypart_id> parts =
        character->get_all_body_parts( flags );
    for( const bodypart_id &part : parts ) {
        before += character->get_part_hp_cur( part );
        character->set_part_hp_cur( part, requested_hp );
        after += character->get_part_hp_cur( part );
    }
    sol::table value = state.create_table();
    value["group"] = group;
    value["value_per_part"] = requested_hp;
    value["parts"] = parts.size();
    value["before"] = before;
    value["after"] = after;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

struct character_adjustments {
    int moves = 0;
    int pain = 0;
    int stamina = 0;
    int hunger = 0;
    int thirst = 0;
    int sleepiness = 0;
    int focus = 0;
    int radiation = 0;
    int painkiller = 0;
    int stored_kcal = 0;
};

int bounded_adjustment( const sol::object &value,
                        const std::string &field )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            "game.characters.adjust field '" + field +
            "' must be an integer" );
    }
    const lua_Integer requested = value.as<lua_Integer>();
    if( requested < -maximum_character_adjustment ||
        requested > maximum_character_adjustment ) {
        throw std::invalid_argument(
            "game.characters.adjust field '" + field +
            "' exceeds the per-call limit" );
    }
    return static_cast<int>( requested );
}

character_adjustments read_character_adjustments(
    const sol::table &requested )
{
    character_adjustments result;
    for( const auto &entry : requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.characters.adjust keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const int value = bounded_adjustment( entry.second, key );
        if( key == "moves" ) {
            result.moves = value;
        } else if( key == "pain" ) {
            result.pain = value;
        } else if( key == "stamina" ) {
            result.stamina = value;
        } else if( key == "hunger" ) {
            result.hunger = value;
        } else if( key == "thirst" ) {
            result.thirst = value;
        } else if( key == "sleepiness" ) {
            result.sleepiness = value;
        } else if( key == "focus" ) {
            result.focus = value;
        } else if( key == "radiation" ) {
            result.radiation = value;
        } else if( key == "painkiller" ) {
            result.painkiller = value;
        } else if( key == "stored_kcal" ) {
            result.stored_kcal = value;
        } else {
            throw std::invalid_argument(
                "game.characters.adjust received unknown field '" +
                key + "'" );
        }
    }
    return result;
}

sol::table character_mutable_state(
    sol::state_view lua, const Character &character )
{
    sol::table result = lua.create_table();
    result["moves"] = character.get_moves();
    result["pain"] = character.get_pain();
    result["stamina"] = character.get_stamina();
    result["hunger"] = character.get_hunger();
    result["thirst"] = character.get_thirst();
    result["sleepiness"] = character.get_sleepiness();
    result["focus"] = character.get_focus();
    result["radiation"] = character.get_rad();
    result["painkiller"] = character.get_painkiller();
    result["stored_kcal"] = character.get_stored_kcal();
    return result;
}

sol::table adjust_character(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const character_adjustments adjustments =
        read_character_adjustments( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table before = character_mutable_state( state, *character );
    if( adjustments.moves != 0 ) {
        character->mod_moves( adjustments.moves );
    }
    if( adjustments.pain != 0 ) {
        character->mod_pain( adjustments.pain );
    }
    if( adjustments.stamina != 0 ) {
        character->mod_stamina( adjustments.stamina );
    }
    if( adjustments.hunger != 0 ) {
        character->mod_hunger( adjustments.hunger );
    }
    if( adjustments.thirst != 0 ) {
        character->mod_thirst( adjustments.thirst );
    }
    if( adjustments.sleepiness != 0 ) {
        character->mod_sleepiness( adjustments.sleepiness );
    }
    if( adjustments.focus != 0 ) {
        character->mod_focus( adjustments.focus );
    }
    if( adjustments.radiation != 0 ) {
        character->mod_rad( adjustments.radiation );
    }
    if( adjustments.painkiller != 0 ) {
        character->mod_painkiller( adjustments.painkiller );
    }
    if( adjustments.stored_kcal != 0 ) {
        character->mod_stored_kcal( adjustments.stored_kcal, true );
    }

    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = character_mutable_state( state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table heal_character(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &body_part, const int amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( amount <= 0 || amount > maximum_character_healing ) {
        throw std::invalid_argument(
            "game.characters.heal amount must be between 1 and 10000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bodypart_id part = character_body_part(
                                 *character, body_part,
                                 "game.characters.heal" );
    const int before = character->get_part_hp_cur( part );
    character->heal( part, amount );
    const int after = character->get_part_hp_cur( part );

    sol::table value = state.create_table();
    value["body_part"] = body_part;
    value["requested"] = amount;
    value["before"] = before;
    value["after"] = after;
    value["maximum"] = character->get_part_hp_max( part );
    value["healed"] = after - before;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_body_part_picker_options {
    std::optional<bool> wounded;
    std::vector<bp_type> types;
    std::vector<bp_type> excluded_types;
    std::vector<json_character_flag> flags;
    std::vector<json_character_flag> excluded_flags;
    std::string title = "Select a body part.";
    bool allow_cancel = true;
};

std::vector<std::string> body_part_picker_string_array(
    const sol::object &value, const std::string &name )
{
    if( !value.is<sol::table>() ) {
        throw std::invalid_argument(
            "game.characters body part picker option '" + name +
            "' must be an array of strings" );
    }
    const sol::table table = value.as<sol::table>();
    if( table.size() > maximum_body_part_snapshot_limit ) {
        throw std::invalid_argument(
            "game.characters body part picker option '" + name +
            "' exceeds the native body part limit" );
    }
    std::vector<std::string> result;
    result.reserve( table.size() );
    for( std::size_t index = 1; index <= table.size(); ++index ) {
        const sol::object entry = table.raw_get<sol::object>( index );
        if( !entry.valid() || entry.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.characters body part picker option '" + name +
                "' must be a dense array of strings" );
        }
        const std::string text = entry.as<std::string>();
        if( text.empty() || text.size() > 128 ||
            text.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "game.characters body part picker option '" + name +
                "' contains an invalid value" );
        }
        result.push_back( text );
    }
    return result;
}

character_body_part_picker_options read_body_part_picker_options(
    const sol::optional<sol::table> &requested )
{
    character_body_part_picker_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.characters.pick_body_part option names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "wounded" && key != "types" &&
            key != "exclude_types" && key != "flags" &&
            key != "exclude_flags" && key != "title" &&
            key != "allow_cancel" ) {
            throw std::invalid_argument(
                "game.characters.pick_body_part received unknown option '" +
                key + "'" );
        }
        if( key == "wounded" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    "game.characters.pick_body_part option 'wounded' must be boolean" );
            }
            result.wounded = entry.second.as<bool>();
        } else if( key == "types" || key == "exclude_types" ) {
            const std::vector<std::string> values =
                body_part_picker_string_array( entry.second, key );
            std::vector<bp_type> &destination = key == "types" ?
                                                result.types :
                                                result.excluded_types;
            destination.reserve( values.size() );
            for( const std::string &value : values ) {
                destination.push_back(
                    io::string_to_enum<bp_type>( value ) );
            }
        } else if( key == "flags" || key == "exclude_flags" ) {
            const std::vector<std::string> values =
                body_part_picker_string_array( entry.second, key );
            std::vector<json_character_flag> &destination =
                key == "flags" ? result.flags : result.excluded_flags;
            destination.reserve( values.size() );
            for( const std::string &value : values ) {
                destination.emplace_back( value );
            }
        } else if( key == "title" ) {
            if( !entry.second.is<std::string>() ) {
                throw std::invalid_argument(
                    "game.characters.pick_body_part option 'title' must be a string" );
            }
            result.title = entry.second.as<std::string>();
            if( result.title.empty() || result.title.size() > 512 ||
                result.title.find( '\0' ) != std::string::npos ) {
                throw std::invalid_argument(
                    "game.characters.pick_body_part option 'title' must contain 1..512 bytes" );
            }
        } else if( !entry.second.is<bool>() ) {
            throw std::invalid_argument(
                "game.characters.pick_body_part option 'allow_cancel' must be boolean" );
        } else {
            result.allow_cancel = entry.second.as<bool>();
        }
    }
    return result;
}

sol::table pick_character_body_part(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const bool interactive )
{
    const character_body_part_picker_options options =
        read_body_part_picker_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( interactive && !character->is_avatar() ) {
        return make_game_error_result( state, {
            "wrong_target",
            "game.characters.choose_body_part requires the avatar"
        } );
    }

    std::vector<bodypart_id> candidates;
    for( const bodypart_id &part : character->get_all_body_parts(
             get_body_part_flags::only_main | get_body_part_flags::sorted ) ) {
        if( options.wounded &&
            character->get_part( part )->has_wounds() != *options.wounded ) {
            continue;
        }
        if( !options.types.empty() &&
            std::none_of(
                options.types.begin(), options.types.end(),
        [&part]( const bp_type type ) {
        return part->has_type( type );
    } ) ) {
            continue;
        }
        if( std::any_of(
                options.excluded_types.begin(),
                options.excluded_types.end(),
        [&part]( const bp_type type ) {
        return part->has_type( type );
    } ) ) {
            continue;
        }
        if( !std::all_of(
                options.flags.begin(), options.flags.end(),
        [&part]( const json_character_flag & flag ) {
        return part->has_flag( flag );
    } ) ) {
            continue;
        }
        if( std::any_of(
                options.excluded_flags.begin(),
                options.excluded_flags.end(),
        [&part]( const json_character_flag & flag ) {
        return part->has_flag( flag );
    } ) ) {
            continue;
        }
        candidates.push_back( part );
    }
    if( candidates.empty() ) {
        return make_game_error_result( state, {
            "no_match",
            "game.characters.pick_body_part found no matching body part"
        } );
    }
    std::optional<bodypart_id> picked;
    if( interactive && candidates.size() > 1 ) {
        uilist menu;
        menu.allow_cancel = options.allow_cancel;
        menu.title = options.title;
        for( const bodypart_id &part : candidates ) {
            menu.addentry(
                MENU_AUTOASSIGN, true,
                MENU_AUTOASSIGN, body_part_name( part ) );
        }
        menu.query();
        if( menu.ret >= 0 &&
            menu.ret < static_cast<int>( candidates.size() ) ) {
            picked = candidates[static_cast<std::size_t>( menu.ret )];
        }
    } else {
        picked = candidates.at(
                     static_cast<std::size_t>(
                         rng( 0, static_cast<int>( candidates.size() - 1 ) ) ) );
    }
    sol::table value = state.create_table();
    value["accepted"] = picked.has_value();
    value["cancelled"] = !picked.has_value();
    if( picked ) {
        value["body_part"] = script_game_id(
                                  "body_part", picked->id().str() );
    } else {
        value["body_part"] = sol::nil;
    }
    value["candidates"] = candidates.size();
    value["interactive"] = interactive;
    if( options.wounded ) {
        value["wounded"] = *options.wounded;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_damage_options {
    std::optional<script_game_id> body_part;
    double armor_penetration = 0.0;
    double armor_penetration_multiplier = 1.0;
    double damage_multiplier = 1.0;
    int min_hit = -1;
    int max_hit = -1;
    int hit_roll = 0;
    bool can_attack_high = true;
};

double bounded_damage_number( const sol::object &value,
                              const std::string &field,
                              const double fallback,
                              const double minimum,
                              const double maximum )
{
    if( !value.valid() || value.get_type() == sol::type::lua_nil ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument(
            "game.characters.damage option '" + field +
            "' must be a finite number" );
    }
    const double requested = value.as<double>();
    if( !std::isfinite( requested ) || requested < minimum ||
        requested > maximum ) {
        throw std::invalid_argument(
            "game.characters.damage option '" + field +
            "' is outside its bounded range" );
    }
    return requested;
}

int bounded_damage_hit_option( const sol::object &value,
                               const std::string &field,
                               const int fallback,
                               const int minimum )
{
    const double requested = bounded_damage_number(
                                 value, field, fallback, minimum,
                                 maximum_character_hit_option );
    if( std::trunc( requested ) != requested ) {
        throw std::invalid_argument(
            "game.characters.damage option '" + field +
            "' must be an integer" );
    }
    return static_cast<int>( requested );
}

character_damage_options read_character_damage_options(
    const sol::optional<sol::table> &requested )
{
    character_damage_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.characters.damage option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "body_part" && key != "armor_penetration" &&
            key != "armor_penetration_multiplier" &&
            key != "damage_multiplier" && key != "min_hit" &&
            key != "max_hit" && key != "hit_roll" &&
            key != "can_attack_high" ) {
            throw std::invalid_argument(
                "game.characters.damage received unknown option '" + key + "'" );
        }
    }
    const sol::object body_part = ( *requested )["body_part"];
    if( body_part.valid() && body_part.get_type() != sol::type::lua_nil ) {
        if( !body_part.is<script_game_id>() ) {
            throw std::invalid_argument(
                "game.characters.damage option 'body_part' must be GameId<body_part>" );
        }
        result.body_part = body_part.as<script_game_id>();
    }
    result.armor_penetration = bounded_damage_number(
                                   ( *requested )["armor_penetration"],
                                   "armor_penetration", result.armor_penetration,
                                   -maximum_character_damage,
                                   maximum_character_damage );
    result.armor_penetration_multiplier = bounded_damage_number(
            ( *requested )["armor_penetration_multiplier"],
            "armor_penetration_multiplier",
            result.armor_penetration_multiplier,
            -maximum_character_damage_multiplier,
            maximum_character_damage_multiplier );
    result.damage_multiplier = bounded_damage_number(
                                   ( *requested )["damage_multiplier"],
                                   "damage_multiplier", result.damage_multiplier,
                                   -maximum_character_damage_multiplier,
                                   maximum_character_damage_multiplier );
    result.min_hit = bounded_damage_hit_option(
                         ( *requested )["min_hit"], "min_hit", result.min_hit, -1 );
    result.max_hit = bounded_damage_hit_option(
                         ( *requested )["max_hit"], "max_hit", result.max_hit, -1 );
    result.hit_roll = bounded_damage_hit_option(
                          ( *requested )["hit_roll"], "hit_roll", result.hit_roll,
                          -maximum_character_hit_option );
    const sol::object can_attack_high = ( *requested )["can_attack_high"];
    if( can_attack_high.valid() &&
        can_attack_high.get_type() != sol::type::lua_nil ) {
        if( !can_attack_high.is<bool>() ) {
            throw std::invalid_argument(
                "game.characters.damage option 'can_attack_high' must be boolean" );
        }
        result.can_attack_high = can_attack_high.as<bool>();
    }
    if( result.max_hit != -1 && result.max_hit < result.min_hit ) {
        throw std::invalid_argument(
            "game.characters.damage options require max_hit >= min_hit" );
    }
    return result;
}

sol::table damage_character(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_damage_type, const double amount,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_damage_type.kind() != "damage_type" ) {
        throw std::invalid_argument(
            "game.characters.damage requires GameId<damage_type>" );
    }
    if( !requested_damage_type.is_valid() ) {
        throw std::invalid_argument(
            "game.characters.damage requires a valid GameId<damage_type>" );
    }
    if( !std::isfinite( amount ) || amount < -maximum_character_damage ||
        amount > maximum_character_damage ) {
        throw std::invalid_argument(
            "game.characters.damage amount must be finite and within -1000000..1000000" );
    }
    const character_damage_options options = read_character_damage_options(
            requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    bodypart_id selected_body_part;
    if( options.body_part ) {
        selected_body_part = character_body_part(
                                 *character, *options.body_part,
                                 "game.characters.damage" );
    } else {
        selected_body_part = character->select_body_part(
                                 options.min_hit, options.max_hit,
                                 options.can_attack_high, options.hit_roll );
        if( selected_body_part == bodypart_str_id::NULL_ID() ) {
            return make_game_error_result( state, {
                "unavailable",
                "No body part satisfies the requested damage hit constraints"
            } );
        }
    }

    const damage_type_id damage_type( requested_damage_type.value() );
    const int before = character->get_part_hp_cur( selected_body_part );
    damage_instance damage;
    damage.add_damage( damage_type,
                       static_cast<float>( amount ),
                       static_cast<float>( options.armor_penetration ),
                       static_cast<float>( options.armor_penetration_multiplier ),
                       static_cast<float>( options.damage_multiplier ), 1.0f, 1.0f );
    const dealt_damage_instance dealt = character->deal_damage(
            character, selected_body_part, damage );
    const int after = character->get_part_hp_cur( selected_body_part );

    sol::table value = state.create_table();
    value["damage_type"] = requested_damage_type;
    value["body_part"] = script_game_id(
                              "body_part", selected_body_part.id().str() );
    value["requested"] = amount;
    value["before"] = before;
    value["after"] = after;
    value["dealt"] = dealt.type_damage( damage_type );
    value["total_dealt"] = dealt.total_damage();
    value["changed"] = before != after;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table add_character_faction_trust(
    sol::this_state lua, const game_handle &handle,
    const std::int64_t amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( amount < -maximum_faction_trust_adjustment ||
        amount > maximum_faction_trust_adjustment ) {
        throw std::invalid_argument(
            "services.characters.add_faction_trust amount must be within "
            "-1000000..1000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    faction *character_faction = character->get_faction();
    if( character_faction == nullptr ) {
        return make_game_error_result( state, {
            "unavailable",
            "services.characters.add_faction_trust requires a character faction"
        } );
    }
    const std::int64_t before = character_faction->trusts_u;
    const std::int64_t after = before + amount;
    if( after < std::numeric_limits<int>::min() ||
        after > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            "services.characters.add_faction_trust would exceed native integer bounds" );
    }
    character_faction->trusts_u = static_cast<int>( after );

    sol::table value = state.create_table();
    value["faction_id"] = character_faction->id.str();
    value["before"] = before;
    value["after"] = after;
    value["applied"] = amount;
    value["changed"] = before != after;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

std::optional<npc_factions::relationship> character_relationship_from_name(
    const std::string_view name )
{
    const auto found = npc_factions::relation_strs.find( std::string( name ) );
    if( found == npc_factions::relation_strs.end() ) {
        return std::nullopt;
    }
    return found->second;
}

sol::table set_character_faction_relationship(
    sol::this_state lua, const game_handle &source_handle,
    const game_handle &target_handle, const std::string &relationship,
    const bool enabled, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::optional<npc_factions::relationship> relation =
        character_relationship_from_name( relationship );
    if( !relation ) {
        throw std::invalid_argument(
            "services.characters.set_faction_relationship received an "
            "unknown relationship '" + relationship + "'" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> source_error;
    const Character *source = character_from_handle(
                                  source_handle, runtime_generation,
                                  world_generation, source_error );
    if( source == nullptr ) {
        return make_game_error_result( state, *source_error );
    }
    std::optional<game_handle_error> target_error;
    Character *target = mutable_character_from_handle(
                            target_handle, runtime_generation,
                            world_generation, target_error );
    if( target == nullptr ) {
        return make_game_error_result( state, *target_error );
    }
    faction *source_faction = source->get_faction();
    faction *target_faction = target->get_faction();
    if( source_faction == nullptr || target_faction == nullptr ) {
        return make_game_error_result( state, {
            "unavailable",
            "services.characters.set_faction_relationship requires both "
            "characters to have factions"
        } );
    }
    const std::string source_id = source_faction->id.str();
    const std::string target_id = target_faction->id.str();
    auto &relation_bits = target_faction->relations[source_id];
    const std::size_t relation_index = static_cast<std::size_t>( *relation );
    const bool before = relation_bits.test( relation_index );
    relation_bits.set( relation_index, enabled );

    sol::table value = state.create_table();
    value["source_faction"] = source_id;
    value["target_faction"] = target_id;
    value["relationship"] = relationship;
    value["before"] = before;
    value["after"] = enabled;
    value["changed"] = before != enabled;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_character_movement_mode(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_mode,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_mode, "move_mode",
        "game.characters.set_movement_mode" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const move_mode_id mode( requested_mode.value() );
    if( !character->can_switch_to( mode ) ) {
        return make_game_error_result(
        state, {
            "unavailable",
            "The requested movement mode is unavailable to this character"
        } );
    }
    const move_mode_id before = character->current_movement_mode();
    character->set_movement_mode( mode );

    sol::table value = state.create_table();
    value["before"] = script_game_id( "move_mode", before.str() );
    value["after"] = script_game_id(
                         "move_mode",
                         character->current_movement_mode().str() );
    value["changed"] = before != character->current_movement_mode();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

bool combat_option_present( const sol::object &value )
{
    return value.valid() && value.get_type() != sol::type::lua_nil;
}

sol::object combat_option( const sol::table &options, const std::string_view name )
{
    return options.raw_get<sol::object>( std::string( name ) );
}

void reject_unknown_combat_options(
    const sol::table &options, const std::string_view api_name,
    const std::initializer_list<std::string_view> allowed )
{
    for( const auto &entry : options ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                std::string( api_name ) + " option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( std::find( allowed.begin(), allowed.end(), key ) == allowed.end() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " received unknown option '" + key + "'" );
        }
    }
}

double combat_number_option(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field, const double fallback,
    const double minimum, const double maximum )
{
    if( !combat_option_present( value ) ) {
        return fallback;
    }
    if( value.get_type() != sol::type::number ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' must be a finite number" );
    }
    const double result = value.as<double>();
    if( !std::isfinite( result ) || result < minimum || result > maximum ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' is outside its bounded range" );
    }
    return result;
}

int combat_integer_option(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field, const int fallback,
    const int minimum, const int maximum )
{
    const double number = combat_number_option(
                              value, api_name, field, fallback, minimum, maximum );
    if( std::trunc( number ) != number ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' must be an integer" );
    }
    return static_cast<int>( number );
}

bool combat_boolean_option(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field, const bool fallback )
{
    if( !combat_option_present( value ) ) {
        return fallback;
    }
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' must be boolean" );
    }
    return value.as<bool>();
}

script_tripoint_coord combat_coordinate_option(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field )
{
    if( !combat_option_present( value ) ||
        !value.is<script_tripoint_coord>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' must be an absolute map-square TripointCoord" );
    }
    const script_tripoint_coord coordinate = value.as<script_tripoint_coord>();
    if( coordinate.native_origin() != coords::origin::abs ||
        coordinate.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' must be an absolute map-square TripointCoord" );
    }
    return coordinate;
}

tripoint_bub_ms combat_bub_position( const script_tripoint_coord &coordinate )
{
    return get_map().get_bub( tripoint_abs_ms( coordinate.to_native() ) );
}

struct character_attack_options {
    bool allow_special = true;
    bool allow_unarmed = true;
    int forced_movecost = -1;
};

struct character_technique_options {
    bool critical = false;
    bool dodge_counter = false;
    bool block_counter = false;
    std::vector<matec_id> blacklist;
};

std::vector<matec_id> read_technique_blacklist( const sol::object &value )
{
    if( !combat_option_present( value ) ) {
        return {};
    }
    if( !value.is<sol::table>() ) {
        throw std::invalid_argument(
            "game.characters.choose_technique option 'blacklist' must be an array" );
    }
    const sol::table entries = value.as<sol::table>();
    if( entries.size() > 256 ) {
        throw std::invalid_argument(
            "game.characters.choose_technique option 'blacklist' exceeds 256 entries" );
    }
    std::vector<matec_id> result;
    result.reserve( entries.size() );
    for( std::size_t index = 1; index <= entries.size(); ++index ) {
        const sol::object entry = entries.raw_get<sol::object>( index );
        std::string id;
        if( entry.get_type() == sol::type::string ) {
            id = entry.as<std::string>();
        } else if( entry.is<script_game_id>() ) {
            const script_game_id typed_id = entry.as<script_game_id>();
            if( typed_id.kind() != "martial_art_technique" ) {
                throw std::invalid_argument(
                    "game.characters.choose_technique blacklist GameIds must have "
                    "kind 'martial_art_technique'" );
            }
            id = typed_id.value();
        } else {
            throw std::invalid_argument(
                "game.characters.choose_technique option 'blacklist' must be a "
                "dense array of technique ids" );
        }
        if( id.empty() || id.size() > maximum_combat_string_bytes ||
            id.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "game.characters.choose_technique blacklist contains an invalid id" );
        }
        result.emplace_back( id );
    }
    return result;
}

character_technique_options read_character_technique_options(
    const sol::optional<sol::table> &requested )
{
    character_technique_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "game.characters.choose_technique";
    reject_unknown_combat_options(
        *requested, api_name,
    { "critical", "dodge_counter", "block_counter", "blacklist" } );
    result.critical = combat_boolean_option(
                          combat_option( *requested, "critical" ),
                          api_name, "critical", result.critical );
    result.dodge_counter = combat_boolean_option(
                               combat_option( *requested, "dodge_counter" ),
                               api_name, "dodge_counter", result.dodge_counter );
    result.block_counter = combat_boolean_option(
                               combat_option( *requested, "block_counter" ),
                               api_name, "block_counter", result.block_counter );
    result.blacklist = read_technique_blacklist(
                           combat_option( *requested, "blacklist" ) );
    return result;
}

character_attack_options read_character_attack_options(
    const sol::optional<sol::table> &requested )
{
    character_attack_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.characters.attack";
    reject_unknown_combat_options(
        *requested, api_name,
    { "allow_special", "allow_unarmed", "forced_movecost" } );
    result.allow_special = combat_boolean_option(
                               combat_option( *requested, "allow_special" ),
                               api_name, "allow_special", result.allow_special );
    result.allow_unarmed = combat_boolean_option(
                               combat_option( *requested, "allow_unarmed" ),
                               api_name, "allow_unarmed", result.allow_unarmed );
    result.forced_movecost = combat_integer_option(
                                 combat_option( *requested, "forced_movecost" ),
                                 api_name, "forced_movecost", result.forced_movecost,
                                 -1, maximum_combat_number );
    return result;
}

sol::table attack_character(
    sol::this_state lua, const game_handle &attacker_handle,
    const game_handle &target_handle, const std::string &technique,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( technique.size() > maximum_combat_string_bytes ||
        technique.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.characters.attack technique is too long or contains NUL" );
    }
    if( !technique.empty() && !matec_id( technique ).is_valid() ) {
        throw std::invalid_argument(
            "services.characters.attack requires a valid martial-art technique id" );
    }
    const character_attack_options options = read_character_attack_options(
            requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> attacker_error;
    Character *attacker = mutable_character_from_handle(
                              attacker_handle, runtime_generation,
                              world_generation, attacker_error );
    if( attacker == nullptr ) {
        return make_game_error_result( state, *attacker_error );
    }
    const native_handle_result<Creature> target = target_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !target ) {
        return make_game_error_result( state, *target.error );
    }
    const bool accepted = attacker->melee_attack(
                              *target.value, options.allow_special,
                              matec_id( technique ), options.allow_unarmed,
                              options.forced_movecost );
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["technique"] = technique;
    value["attacker"] = attacker_handle;
    value["target"] = target_handle;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table choose_character_technique(
    sol::this_state lua, const game_handle &attacker_handle,
    const game_handle &target_handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const character_technique_options options =
        read_character_technique_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> attacker_error;
    const Character *attacker = character_from_handle(
                                    attacker_handle, runtime_generation,
                                    world_generation, attacker_error );
    if( attacker == nullptr ) {
        return make_game_error_result( state, *attacker_error );
    }
    const native_handle_result<Creature> target = target_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !target ) {
        return make_game_error_result( state, *target.error );
    }
    const auto [technique, attack_vector, contact_area] =
        attacker->pick_technique(
            *target.value, attacker->used_weapon(), options.critical,
            options.dodge_counter, options.block_counter, options.blacklist );

    sol::table value = state.create_table();
    value["found"] = !technique.is_empty();
    value["accepted"] = !technique.is_empty();
    value["technique"] = script_game_id(
                              "martial_art_technique", technique.str() );
    value["attack_vector"] = script_game_id(
                                  "attack_vector", attack_vector.str() );
    value["contact_area"] = script_game_id(
                                 "sub_body_part", contact_area.str() );
    value["attacker"] = attacker_handle;
    value["target"] = target_handle;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table ranged_attack_character(
    sol::this_state lua, const game_handle &attacker_handle,
    const game_handle &target_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> attacker_error;
    Character *attacker = mutable_character_from_handle(
                              attacker_handle, runtime_generation,
                              world_generation, attacker_error );
    if( attacker == nullptr ) {
        return make_game_error_result( state, *attacker_error );
    }
    const native_handle_result<Creature> target = target_handle.resolve_creature(
            runtime_generation, world_generation );
    if( !target ) {
        return make_game_error_result( state, *target.error );
    }

    int shots = 0;
    bool attempted = false;
    item_location wielded = attacker->get_wielded_item();
    if( wielded && wielded->is_gun() ) {
        const gun_mode mode = wielded->gun_current_mode();
        if( mode.qty > 0 && wielded->ammo_sufficient(
                attacker, mode.qty * 2 ) ) {
            attempted = true;
            shots = attacker->fire_gun( target.value->pos_bub() , mode.qty );
        }
    }
    sol::table value = state.create_table();
    value["attempted"] = attempted;
    value["fired"] = shots;
    value["attacker"] = attacker_handle;
    value["target"] = target_handle;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_knockback_options {
    int force = 0;
    int stun = 0;
    int dam_mult = 0;
    std::optional<script_tripoint_coord> target;
    std::optional<script_tripoint_coord> direction;
};

character_knockback_options read_character_knockback_options(
    const sol::optional<sol::table> &requested )
{
    character_knockback_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.characters.knockback";
    reject_unknown_combat_options(
        *requested, api_name,
    { "force", "stun", "dam_mult", "target", "direction" } );
    result.force = combat_integer_option(
                       combat_option( *requested, "force" ), api_name, "force",
                       result.force, -maximum_combat_radius, maximum_combat_radius );
    result.stun = combat_integer_option(
                      combat_option( *requested, "stun" ), api_name, "stun",
                      result.stun, -maximum_combat_radius, maximum_combat_radius );
    result.dam_mult = combat_integer_option(
                          combat_option( *requested, "dam_mult" ), api_name, "dam_mult",
                          result.dam_mult, -maximum_combat_radius,
                          maximum_combat_radius );
    if( combat_option_present( combat_option( *requested, "target" ) ) ) {
        result.target = combat_coordinate_option(
                            combat_option( *requested, "target" ), api_name, "target" );
    }
    if( combat_option_present( combat_option( *requested, "direction" ) ) ) {
        result.direction = combat_coordinate_option(
                               combat_option( *requested, "direction" ),
                               api_name, "direction" );
    }
    return result;
}

sol::table knockback_character(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const character_knockback_options options =
        read_character_knockback_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( g == nullptr ) {
        return make_game_error_result( state, {
            "unavailable", "services.characters.knockback requires an active game"
        } );
    }
    map &here = get_map();
    const tripoint_bub_ms actor_position = character->pos_bub( here );
    const tripoint_bub_ms target = options.target ?
                                   combat_bub_position( *options.target ) : actor_position;
    tripoint_bub_ms direction = options.direction ?
                                 combat_bub_position( *options.direction ) : actor_position;
    if( direction == target ) {
        point random_direction( rng( -1, 1 ), rng( -1, 1 ) );
        while( random_direction == point::zero ) {
            random_direction = point( rng( -1, 1 ), rng( -1, 1 ) );
        }
        direction += random_direction;
    }
    g->knockback( direction, target, options.force, options.stun,
                  options.dam_mult );
    sol::table value = state.create_table();
    value["target"] = script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           here.get_abs( target ).raw() );
    value["direction"] = script_tripoint_coord::from_native(
                              coords::origin::abs, coords::scale::map_square,
                              here.get_abs( direction ).raw() );
    value["force"] = options.force;
    value["stun"] = options.stun;
    value["dam_mult"] = options.dam_mult;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_explosion_options {
    double power = 0.0;
    double distance_factor = 0.75;
    int max_noise = 90000000;
    bool fire = false;
    int casing_mass = 0;
    double fragment_mass = 0.005;
    int recovery = 0;
    std::string drop = "null";
    bool emp_blast = false;
    bool scrambler_blast = false;
    bool flashbang = false;
    bool flashbang_avatar_is_immune = false;
    int flashbang_radius = 8;
    std::optional<script_tripoint_coord> target;
};

void read_character_shrapnel_options(
    const sol::object &requested, character_explosion_options &result )
{
    if( !combat_option_present( requested ) ) {
        return;
    }
    constexpr std::string_view api_name = "services.characters.explosion";
    if( requested.get_type() == sol::type::number ) {
        result.casing_mass = combat_integer_option(
                                 requested, api_name, "shrapnel", result.casing_mass,
                                 0, maximum_combat_noise );
        return;
    }
    if( !requested.is<sol::table>() ) {
        throw std::invalid_argument(
            "services.characters.explosion option 'shrapnel' must be a table" );
    }
    const sol::table shrapnel = requested.as<sol::table>();
    reject_unknown_combat_options(
        shrapnel, api_name,
    { "casing_mass", "fragment_mass", "recovery", "drop" } );
    result.casing_mass = combat_integer_option(
                             combat_option( shrapnel, "casing_mass" ), api_name,
                             "casing_mass", result.casing_mass, 0,
                             maximum_combat_noise );
    result.fragment_mass = combat_number_option(
                               combat_option( shrapnel, "fragment_mass" ), api_name,
                               "fragment_mass", result.fragment_mass, 0.0,
                               maximum_combat_multiplier );
    result.recovery = combat_integer_option(
                          combat_option( shrapnel, "recovery" ), api_name,
                          "recovery", result.recovery, 0, 100 );
    const sol::object drop = combat_option( shrapnel, "drop" );
    if( combat_option_present( drop ) ) {
        if( drop.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.characters.explosion option 'drop' must be a string" );
        }
        result.drop = drop.as<std::string>();
        if( result.drop.size() > maximum_combat_string_bytes ||
            result.drop.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.characters.explosion option 'drop' is too long" );
        }
    }
}

character_explosion_options read_character_explosion_options(
    const sol::optional<sol::table> &requested )
{
    character_explosion_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.characters.explosion";
    reject_unknown_combat_options(
        *requested, api_name,
    { "power", "distance_factor", "max_noise", "fire", "target", "shrapnel",
      "emp_blast", "scrambler_blast", "flashbang",
      "flashbang_avatar_is_immune", "flashbang_radius" } );
    result.power = combat_number_option(
                       combat_option( *requested, "power" ), api_name, "power",
                       result.power, -maximum_combat_number, maximum_combat_number );
    result.distance_factor = combat_number_option(
                                 combat_option( *requested, "distance_factor" ),
                                 api_name, "distance_factor", result.distance_factor,
                                 0.0, maximum_combat_multiplier );
    result.max_noise = combat_integer_option(
                           combat_option( *requested, "max_noise" ), api_name,
                           "max_noise", result.max_noise, 0, maximum_combat_noise );
    result.fire = combat_boolean_option(
                      combat_option( *requested, "fire" ), api_name, "fire", result.fire );
    if( combat_option_present( combat_option( *requested, "target" ) ) ) {
        result.target = combat_coordinate_option(
                            combat_option( *requested, "target" ), api_name, "target" );
    }
    read_character_shrapnel_options(
        combat_option( *requested, "shrapnel" ), result );
    result.emp_blast = combat_boolean_option(
                           combat_option( *requested, "emp_blast" ), api_name,
                           "emp_blast", result.emp_blast );
    result.scrambler_blast = combat_boolean_option(
                                 combat_option( *requested, "scrambler_blast" ),
                                 api_name, "scrambler_blast", result.scrambler_blast );
    result.flashbang = combat_boolean_option(
                           combat_option( *requested, "flashbang" ), api_name,
                           "flashbang", result.flashbang );
    result.flashbang_avatar_is_immune = combat_boolean_option(
            combat_option( *requested, "flashbang_avatar_is_immune" ), api_name,
            "flashbang_avatar_is_immune", result.flashbang_avatar_is_immune );
    result.flashbang_radius = combat_integer_option(
                                  combat_option( *requested, "flashbang_radius" ),
                                  api_name, "flashbang_radius", result.flashbang_radius,
                                  0, maximum_combat_radius );
    return result;
}

sol::table explosion_character(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const character_explosion_options options =
        read_character_explosion_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const itype_id drop( options.drop );
    if( options.drop != "null" && !drop.is_valid() ) {
        throw std::invalid_argument(
            "services.characters.explosion shrapnel drop must be a valid item id or null" );
    }
    map &here = get_map();
    const tripoint_bub_ms target = options.target ?
                                   combat_bub_position( *options.target ) :
                                   character->pos_bub( here );
    explosion_data data;
    data.power = static_cast<float>( options.power );
    data.distance_factor = static_cast<float>( options.distance_factor );
    data.max_noise = options.max_noise;
    data.fire = options.fire;
    data.shrapnel = shrapnel_data(
                        options.casing_mass,
                        static_cast<float>( options.fragment_mass ),
                        options.recovery, drop );
    explosion_handler::explosion( character, target, data );
    if( options.emp_blast ) {
        explosion_handler::emp_blast( target );
    }
    if( options.scrambler_blast ) {
        explosion_handler::scrambler_blast( target );
    }
    if( options.flashbang ) {
        explosion_handler::flashbang(
            target, options.flashbang_avatar_is_immune, options.flashbang_radius );
    }
    sol::table value = state.create_table();
    value["queued"] = true;
    value["target"] = script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           here.get_abs( target ).raw() );
    value["power"] = options.power;
    value["distance_factor"] = options.distance_factor;
    value["fire"] = options.fire;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table emit_character(
    sol::this_state lua, const game_handle &handle,
    const std::string &emission, const sol::optional<double> &requested_chance,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( emission.empty() || emission.size() > maximum_combat_string_bytes ||
        emission.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "services.characters.emit emission must be a bounded string" );
    }
    const double chance = requested_chance.value_or( 1.0 );
    if( !std::isfinite( chance ) || chance < 0.0 ||
        chance > maximum_combat_multiplier ) {
        throw std::invalid_argument(
            "services.characters.emit chance must be finite and within 0..1000" );
    }
    const emit_id requested( emission );
    if( !requested.is_valid() ) {
        throw std::invalid_argument(
            "services.characters.emit requires a valid emission id" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    get_map().emit_field( character->pos_bub( get_map() ), requested,
                          static_cast<float>( chance ) );
    sol::table value = state.create_table();
    value["emission"] = emission;
    value["chance"] = chance;
    value["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs, coords::scale::map_square,
                             character->pos_abs().raw() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_cast_spell_options {
    bool hit_self = false;
    bool targeted = false;
    int min_level = 0;
    std::optional<int> max_level;
    std::optional<std::string> message;
    std::optional<std::string> npc_message;
    std::optional<script_tripoint_coord> target;
};

std::optional<std::string> combat_message_option(
    const sol::object &value, const std::string_view api_name,
    const std::string_view field )
{
    if( !combat_option_present( value ) ) {
        return std::nullopt;
    }
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' must be a string" );
    }
    const std::string result = value.as<std::string>();
    if( result.size() > maximum_combat_string_bytes ||
        result.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            std::string( api_name ) + " option '" + std::string( field ) +
            "' is too long or contains NUL" );
    }
    return result;
}

character_cast_spell_options read_character_cast_spell_options(
    const sol::optional<sol::table> &requested )
{
    character_cast_spell_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.characters.cast_spell";
    reject_unknown_combat_options(
        *requested, api_name,
    { "hit_self", "min_level", "max_level", "message", "npc_message",
      "target", "targeted" } );
    result.hit_self = combat_boolean_option(
                          combat_option( *requested, "hit_self" ), api_name,
                          "hit_self", result.hit_self );
    result.min_level = combat_integer_option(
                           combat_option( *requested, "min_level" ), api_name,
                           "min_level", result.min_level, 0, maximum_combat_radius );
    const sol::object max_level = combat_option( *requested, "max_level" );
    if( combat_option_present( max_level ) ) {
        const int value = combat_integer_option(
                              max_level, api_name, "max_level", -1, -1,
                              maximum_combat_radius );
        if( value >= 0 ) {
            result.max_level = value;
        }
    }
    result.message = combat_message_option(
                         combat_option( *requested, "message" ), api_name, "message" );
    result.npc_message = combat_message_option(
            combat_option( *requested, "npc_message" ), api_name, "npc_message" );
    result.targeted = combat_boolean_option(
                          combat_option( *requested, "targeted" ), api_name,
                          "targeted", result.targeted );
    if( combat_option_present( combat_option( *requested, "target" ) ) ) {
        result.target = combat_coordinate_option(
                            combat_option( *requested, "target" ), api_name, "target" );
    }
    if( result.targeted && result.target ) {
        throw std::invalid_argument(
            "services.characters.cast_spell cannot combine target with targeted=true" );
    }
    if( result.max_level && *result.max_level < result.min_level ) {
        throw std::invalid_argument(
            "services.characters.cast_spell max_level cannot be below min_level" );
    }
    return result;
}

sol::table cast_spell_character(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_spell,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind( requested_spell, "spell", "services.characters.cast_spell" );
    const character_cast_spell_options options =
        read_character_cast_spell_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    fake_spell fake( spell_id( requested_spell.value() ), options.hit_self,
                     options.max_level );
    fake.level = options.min_level;
    if( options.message ) {
        fake.trigger_message = no_translation( *options.message );
    }
    if( options.npc_message ) {
        fake.npc_trigger_message = no_translation( *options.npc_message );
    }
    if( !fake.is_valid() ) {
        throw std::invalid_argument(
            "services.characters.cast_spell requires a valid spell id" );
    }
    spell native_spell = fake.get_spell( *character, 0 );
    std::optional<tripoint_bub_ms> target;
    if( options.targeted ) {
        target = native_spell.select_target( character );
    } else {
        target = options.target ?
                 combat_bub_position( *options.target ) :
                 character->pos_bub( get_map() );
    }
    sol::table value = state.create_table();
    value["spell"] = requested_spell;
    value["accepted"] = target.has_value();
    value["cancelled"] = options.targeted && !target;
    value["targeted"] = options.targeted;
    value["hit_self"] = options.hit_self;
    value["min_level"] = options.min_level;
    if( !target ) {
        value["target"] = sol::nil;
        if( options.max_level ) {
            value["max_level"] = *options.max_level;
        }
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }
    native_spell.cast_all_effects( *character, *target );
    character->add_msg_player_or_npc(
        fake.trigger_message, fake.npc_trigger_message );
    value["target"] = script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           get_map().get_abs( *target ).raw() );
    if( options.max_level ) {
        value["max_level"] = *options.max_level;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_die_options {
    std::optional<bool> remove_corpse;
    std::optional<bool> suppress_message;
};

character_die_options read_character_die_options(
    const sol::optional<sol::table> &requested )
{
    character_die_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.characters.die";
    reject_unknown_combat_options(
        *requested, api_name,
    { "remove_corpse", "suppress_message", "supress_message" } );
    const sol::object remove_corpse = combat_option( *requested, "remove_corpse" );
    if( combat_option_present( remove_corpse ) ) {
        result.remove_corpse = combat_boolean_option(
                                   remove_corpse, api_name, "remove_corpse", false );
    }
    const sol::object suppress = combat_option( *requested, "suppress_message" );
    const sol::object legacy_suppress = combat_option( *requested, "supress_message" );
    if( combat_option_present( suppress ) &&
        combat_option_present( legacy_suppress ) &&
        combat_boolean_option( suppress, api_name, "suppress_message", false ) !=
        combat_boolean_option( legacy_suppress, api_name, "supress_message", false ) ) {
        throw std::invalid_argument(
            "services.characters.die received conflicting suppress_message options" );
    }
    if( combat_option_present( suppress ) ) {
        result.suppress_message = combat_boolean_option(
                                      suppress, api_name, "suppress_message", false );
    } else if( combat_option_present( legacy_suppress ) ) {
        result.suppress_message = combat_boolean_option(
                                      legacy_suppress, api_name, "supress_message", false );
    }
    return result;
}

sol::table die_character(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const character_die_options options = read_character_die_options(
            requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( npc *const character_npc = character->as_npc() ) {
        if( options.remove_corpse ) {
            character_npc->spawn_corpse = !*options.remove_corpse;
        }
        if( options.suppress_message ) {
            character_npc->quiet_death = *options.suppress_message;
        }
    }
    const bool was_dead = character->is_dead_state();
    character->die( &get_map(), nullptr );
    sol::table value = state.create_table();
    value["dead"] = character->is_dead_state();
    value["changed"] = !was_dead && character->is_dead_state();
    if( options.remove_corpse ) {
        value["remove_corpse"] = *options.remove_corpse;
    }
    if( options.suppress_message ) {
        value["suppress_message"] = *options.suppress_message;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table prevent_death_character(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool was_dead = character->is_dead_state();
    character->prevent_death();
    sol::table value = state.create_table();
    value["prevented"] = true;
    value["was_dead"] = was_dead;
    value["alive"] = !character->is_dead_state();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table recalculate_character_enchantments(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    character->recalculate_enchantment_cache();
    sol::table value = state.create_table();
    value["refreshed"] = true;
    value["character"] = handle;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct character_demographic_updates {
    std::optional<int> age;
    std::optional<int> height_cm;
};

character_demographic_updates read_character_demographic_updates(
    const sol::table &requested )
{
    character_demographic_updates result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.characters.set_demographics field names must be strings" );
        }
        const std::string key =
            entry.first.as<std::string>();
        if( key != "age" && key != "height_cm" ) {
            throw std::invalid_argument(
                "game.characters.set_demographics received unknown field '" +
                key + "'" );
        }
        if( !entry.second.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "game.characters.set_demographics field '" + key +
                "' must be an integer" );
        }
        const lua_Integer value =
            entry.second.as<lua_Integer>();
        if( key == "age" ) {
            if( value < 0 || value > 10000 ) {
                throw std::invalid_argument(
                    "game.characters.set_demographics age must be within 0..10000" );
            }
            result.age = static_cast<int>( value );
        } else {
            if( value <= 0 || value > 10000 ) {
                throw std::invalid_argument(
                    "game.characters.set_demographics height_cm must be within 1..10000" );
            }
            result.height_cm = static_cast<int>( value );
        }
    }
    if( !result.age && !result.height_cm ) {
        throw std::invalid_argument(
            "game.characters.set_demographics requires age or height_cm" );
    }
    return result;
}

sol::table character_demographic_state(
    sol::state_view lua, const Character &character )
{
    sol::table result = lua.create_table();
    result["age"] = character.age();
    result["base_age"] = character.base_age();
    result["height_cm"] = character.height();
    result["base_height_cm"] = character.base_height();
    result["bmi"] = character.get_bmi();
    result["fat_bmi"] = character.get_bmi_fat();
    result["lean_bmi"] = character.get_bmi_lean();
    result["bmi_permil"] = static_cast<int>(
                                      std::round(
                                          character.get_bmi_fat() * 1000.0f ) );
    result["size_index"] = static_cast<int>(
                                character.get_size() );
    return result;
}

sol::table set_character_demographics(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const character_demographic_updates updates =
        read_character_demographic_updates( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table before = character_demographic_state(
                            state, *character );
    if( updates.age ) {
        character->mod_base_age(
            *updates.age - character->age() );
    }
    if( updates.height_cm ) {
        // Mirrors talker_character::set_height and therefore the legacy
        // assignment semantic: the supplied value becomes base height.
        character->set_base_height( *updates.height_cm );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = character_demographic_state(
                         state, *character );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table character_attribute_state(
    sol::state_view lua, const Character &character )
{
    sol::table result = lua.create_table();
    result["strength"] = character.get_str();
    result["dexterity"] = character.get_dex();
    result["perception"] = character.get_per();
    result["intelligence"] = character.get_int();
    result["strength_base"] = character.get_str_base();
    result["dexterity_base"] = character.get_dex_base();
    result["perception_base"] = character.get_per_base();
    result["intelligence_base"] = character.get_int_base();
    result["strength_bonus"] = character.get_str_bonus();
    result["dexterity_bonus"] = character.get_dex_bonus();
    result["perception_bonus"] = character.get_per_bonus();
    result["intelligence_bonus"] = character.get_int_bonus();
    return result;
}

struct character_attribute_updates {
    std::optional<int> strength_base;
    std::optional<int> dexterity_base;
    std::optional<int> perception_base;
    std::optional<int> intelligence_base;
    std::optional<int> strength_bonus;
    std::optional<int> dexterity_bonus;
    std::optional<int> perception_bonus;
    std::optional<int> intelligence_bonus;
};

character_attribute_updates read_character_attribute_updates(
    const sol::table &requested, const std::string &api_name )
{
    character_attribute_updates result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " field names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "strength_base" && key != "dexterity_base" &&
            key != "perception_base" && key != "intelligence_base" &&
            key != "strength_bonus" && key != "dexterity_bonus" &&
            key != "perception_bonus" && key != "intelligence_bonus" ) {
            throw std::invalid_argument(
                api_name + " received unknown field '" + key + "'" );
        }
        if( !entry.second.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " field '" + key + "' must be an integer" );
        }
        const lua_Integer value = entry.second.as<lua_Integer>();
        if( value < -maximum_character_attribute ||
            value > maximum_character_attribute ) {
            throw std::invalid_argument(
                api_name + " field '" + key +
                "' must be within -1000000..1000000" );
        }
        const int native_value = static_cast<int>( value );
        if( key == "strength_base" ) {
            result.strength_base = native_value;
        } else if( key == "dexterity_base" ) {
            result.dexterity_base = native_value;
        } else if( key == "perception_base" ) {
            result.perception_base = native_value;
        } else if( key == "intelligence_base" ) {
            result.intelligence_base = native_value;
        } else if( key == "strength_bonus" ) {
            result.strength_bonus = native_value;
        } else if( key == "dexterity_bonus" ) {
            result.dexterity_bonus = native_value;
        } else if( key == "perception_bonus" ) {
            result.perception_bonus = native_value;
        } else {
            result.intelligence_bonus = native_value;
        }
    }
    if( !result.strength_base && !result.dexterity_base &&
        !result.perception_base && !result.intelligence_base &&
        !result.strength_bonus && !result.dexterity_bonus &&
        !result.perception_bonus && !result.intelligence_bonus ) {
        throw std::invalid_argument(
            api_name + " requires at least one attribute field" );
    }
    return result;
}

std::optional<int> adjusted_character_attribute(
    const int current, const int delta )
{
    const std::int64_t adjusted =
        static_cast<std::int64_t>( current ) + delta;
    if( adjusted < -maximum_character_attribute ||
        adjusted > maximum_character_attribute ) {
        return std::nullopt;
    }
    return static_cast<int>( adjusted );
}

sol::table change_character_attributes(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested, const bool relative,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name = relative ?
                                 "game.characters.modify_attributes" :
                                 "game.characters.set_attributes";
    const character_attribute_updates updates =
        read_character_attribute_updates( requested, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    character_attribute_updates assigned = updates;
    if( relative ) {
        if( updates.strength_base ) {
            assigned.strength_base = adjusted_character_attribute(
                                         character->get_str_base(),
                                         *updates.strength_base );
        }
        if( updates.dexterity_base ) {
            assigned.dexterity_base = adjusted_character_attribute(
                                          character->get_dex_base(),
                                          *updates.dexterity_base );
        }
        if( updates.perception_base ) {
            assigned.perception_base = adjusted_character_attribute(
                                           character->get_per_base(),
                                           *updates.perception_base );
        }
        if( updates.intelligence_base ) {
            assigned.intelligence_base = adjusted_character_attribute(
                                             character->get_int_base(),
                                             *updates.intelligence_base );
        }
        if( updates.strength_bonus ) {
            assigned.strength_bonus = adjusted_character_attribute(
                                          character->get_str_bonus(),
                                          *updates.strength_bonus );
        }
        if( updates.dexterity_bonus ) {
            assigned.dexterity_bonus = adjusted_character_attribute(
                                           character->get_dex_bonus(),
                                           *updates.dexterity_bonus );
        }
        if( updates.perception_bonus ) {
            assigned.perception_bonus = adjusted_character_attribute(
                                            character->get_per_bonus(),
                                            *updates.perception_bonus );
        }
        if( updates.intelligence_bonus ) {
            assigned.intelligence_bonus = adjusted_character_attribute(
                                              character->get_int_bonus(),
                                              *updates.intelligence_bonus );
        }
        if( ( updates.strength_base && !assigned.strength_base ) ||
            ( updates.dexterity_base && !assigned.dexterity_base ) ||
            ( updates.perception_base && !assigned.perception_base ) ||
            ( updates.intelligence_base && !assigned.intelligence_base ) ||
            ( updates.strength_bonus && !assigned.strength_bonus ) ||
            ( updates.dexterity_bonus && !assigned.dexterity_bonus ) ||
            ( updates.perception_bonus && !assigned.perception_bonus ) ||
            ( updates.intelligence_bonus && !assigned.intelligence_bonus ) ) {
            return make_game_error_result( state, {
                "numeric_overflow",
                api_name + " would exceed the supported attribute range"
            } );
        }
    }

    sol::table before = character_attribute_state(
                            state, *character );
    if( assigned.strength_base ) {
        character->set_str_base( *assigned.strength_base );
    }
    if( assigned.dexterity_base ) {
        character->set_dex_base( *assigned.dexterity_base );
    }
    if( assigned.perception_base ) {
        character->set_per_base( *assigned.perception_base );
    }
    if( assigned.intelligence_base ) {
        character->set_int_base( *assigned.intelligence_base );
    }
    if( assigned.strength_bonus ) {
        character->set_str_bonus( *assigned.strength_bonus );
    }
    if( assigned.dexterity_bonus ) {
        character->set_dex_bonus( *assigned.dexterity_bonus );
    }
    if( assigned.perception_bonus ) {
        character->set_per_bonus( *assigned.perception_bonus );
    }
    if( assigned.intelligence_bonus ) {
        character->set_int_bonus( *assigned.intelligence_bonus );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = character_attribute_state(
                         state, *character );
    value["relative"] = relative;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table change_character_kill_xp(
    sol::this_state lua, const game_handle &handle,
    const std::int64_t requested, const bool relative,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name = relative ?
                                 "game.characters.modify_kill_xp" :
                                 "game.characters.set_kill_xp";
    if( requested < std::numeric_limits<int>::min() ||
        requested > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            api_name + " value is outside native integer bounds" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = mutable_character_from_handle(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = character->kill_xp;
    const std::int64_t assigned = relative ?
                                  static_cast<std::int64_t>( before ) + requested :
                                  requested;
    if( assigned < std::numeric_limits<int>::min() ||
        assigned > std::numeric_limits<int>::max() ) {
        return make_game_error_result( state, {
            "numeric_overflow",
            api_name + " would overflow native kill experience"
        } );
    }
    character->kill_xp = static_cast<int>( assigned );
    sol::table value = state.create_table();
    value["before"] = before;
    value["requested"] = requested;
    value["after"] = character->kill_xp;
    value["relative"] = relative;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table character_temperature_state(
    sol::state_view lua, const Character &character )
{
    sol::table result = lua.create_table();
    const std::vector<bodypart_id> parts =
        character.get_all_body_parts();
    if( parts.empty() ) {
        result["available"] = false;
        return result;
    }
    bodypart_id current_extreme = parts.front();
    bodypart_id convergent_extreme = parts.front();
    for( const bodypart_id &part : parts ) {
        if( units::abs(
                character.get_part_temp_cur( part ) - BODYTEMP_NORM ) >
            units::abs(
                character.get_part_temp_cur( current_extreme ) - BODYTEMP_NORM ) ) {
            current_extreme = part;
        }
        if( units::abs(
                character.get_part_temp_conv( part ) - BODYTEMP_NORM ) >
            units::abs(
                character.get_part_temp_conv( convergent_extreme ) - BODYTEMP_NORM ) ) {
            convergent_extreme = part;
        }
    }
    const units::temperature current =
        character.get_part_temp_cur( current_extreme );
    const units::temperature convergent =
        character.get_part_temp_conv( convergent_extreme );
    const units::temperature_delta legacy_delta =
        convergent - current;
    result["available"] = true;
    result["current_extreme_body_part"] = script_game_id(
            "body_part", current_extreme.id().str() );
    result["convergent_extreme_body_part"] = script_game_id(
            "body_part", convergent_extreme.id().str() );
    result["current_celsius"] = units::to_celsius( current );
    result["convergent_celsius"] = units::to_celsius( convergent );
    result["legacy_current"] =
        units::to_legacy_bodypart_temp( current );
    result["legacy_delta"] =
        units::to_legacy_bodypart_temp_delta( legacy_delta );
    result["delta_celsius"] =
        units::to_celsius_delta( legacy_delta );
    return result;
}

int body_part_limit( const sol::optional<int> &requested )
{
    const int value = requested.value_or( default_body_part_snapshot_limit );
    if( value < 0 ) {
        throw std::invalid_argument(
            "game.characters.snapshot body_part_limit cannot be negative" );
    }
    return std::min( value, maximum_body_part_snapshot_limit );
}

sol::table character_body_parts(
    sol::state_view lua, const Character &character, const int limit )
{
    const std::vector<bodypart_id> body_parts =
        character.get_all_body_parts();
    const std::size_t returned = std::min(
                                     body_parts.size(),
                                     static_cast<std::size_t>( limit ) );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const bodypart_id &part = body_parts[index];
        const int hp_max = character.get_part_hp_max( part );
        const int hp = character.get_part_hp_cur( part );
        sol::table entry = lua.create_table();
        entry["id"] = part.id().str();
        entry["name"] = body_part_name( part );
        entry["hp"] = hp;
        entry["hp_max"] = hp_max;
        entry["hp_percent"] = hp_max > 0 ?
                              static_cast<double>( hp ) / hp_max : 0.0;
        entry["encumbrance"] =
            character.get_part_encumbrance( part );
        entry["wetness"] = character.get_part_wetness( part );
        entry["wetness_percent"] =
            character.get_part_wetness_percentage( part );
        entry["temperature_c"] = units::to_celsius(
                                     character.get_part_temp_cur( part ) );
        entry["legacy_temperature"] =
            units::to_legacy_bodypart_temp(
                character.get_part_temp_conv( part ) );
        entry["main"] = part->main_part == part.id();
        entry["frostbite_timer"] =
            character.get_part_frostbite_timer( part );
        entry["broken"] = character.is_limb_broken( part );
        items[index + 1] = std::move( entry );
    }

    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = body_parts.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < body_parts.size();
    return result;
}

sol::table snapshot_character(
    sol::state_view lua, const Character &character,
    const int requested_body_part_limit )
{
    sol::table result = lua.create_table();
    result["creature"] = snapshot_creature( lua, character );
    result["id"] = character.getID().get_value();
    result["name"] = character.get_name();
    result["avatar"] = character.is_avatar();
    result["npc"] = character.is_npc();
    result["male"] = character.male;
    result["cash"] = character.cash;
    result["faction_id"] = character.get_faction_id().str();

    result["demographics"] =
        character_demographic_state( lua, character );

    result["stats"] = character_attribute_state(
                          lua, character );

    sol::table progression = lua.create_table();
    progression["kill_xp"] = character.kill_xp;
    result["progression"] = std::move( progression );

    sol::table needs = lua.create_table();
    needs["stamina"] = character.get_stamina();
    needs["stamina_max"] = character.get_stamina_max();
    needs["hunger"] = character.get_hunger();
    needs["thirst"] = character.get_thirst();
    needs["sleepiness"] = character.get_sleepiness();
    needs["sleep_deprivation"] = character.get_sleep_deprivation();
    needs["instant_thirst"] = character.get_instant_thirst();
    needs["oxygen"] = character.oxygen;
    needs["oxygen_max"] = character.get_oxygen_max();
    needs["stimulant"] = character.get_stim();
    needs["stored_kcal"] = character.get_stored_kcal();
    needs["healthy_kcal"] = character.get_healthy_kcal();
    needs["kcal_percent"] = character.get_kcal_percent();
    needs["focus"] = character.get_focus();
    needs["effective_focus"] = character.get_effective_focus();
    needs["morale"] = character.get_morale_level();
    needs["radiation"] = character.get_rad();
    needs["painkiller"] = character.get_painkiller();
    needs["lifestyle"] = character.get_lifestyle();
    needs["daily_health"] = character.get_daily_health();
    needs["health_tally"] = character.get_health_tally();
    result["needs"] = std::move( needs );

    sol::table senses = lua.create_table();
    senses["blind"] = character.is_blind();
    senses["deaf"] = character.is_deaf();
    senses["invisible"] = character.is_invisible();
    senses["quiet"] = character.is_quiet();
    senses["stealthy"] = character.is_stealthy();
    senses["can_see"] = !character.is_blind() &&
                         ( !character.in_sleep_state() ||
                           character.has_flag( json_flag_SEESLEEP ) );
    senses["has_watch"] = character.has_watch();
    senses["has_alarm_clock"] = character.has_alarm_clock();
    senses["fine_detail_vision_modifier"] =
        character.fine_detail_vision_mod();
    senses["fine_detail_vision_legacy"] = static_cast<int>(
            std::ceil( character.fine_detail_vision_mod() ) );
    result["senses"] = std::move( senses );

    sol::table combat = lua.create_table();
    combat["dodge"] = character.get_dodge();
    combat["dodge_base"] = character.get_dodge_base();
    combat["hit"] = character.get_hit();
    combat["hit_base"] = character.get_hit_base();
    combat["melee"] = character.get_melee();
    combat["blocks_left"] = character.get_num_blocks();
    combat["dodges_left"] = character.get_dodges_left();
    combat["working_arms"] = character.get_working_arm_count();
    combat["working_legs"] = character.get_working_leg_count();
    const item_location weapon_location =
        character.used_weapon();
    const item current_weapon = weapon_location ?
                                *weapon_location : null_item_reference();
    combat["attack_speed"] =
        character.attack_speed( current_weapon );
    combat["artifact_resonance"] =
        character.enchantment_cache->get_value_add(
            enchant_vals::mod::ARTIFACT_RESONANCE );
    combat["ugliness"] = character.ugliness();
    combat["vision_range"] = character.unimpaired_range();
    result["combat"] = std::move( combat );

    sol::table carrying = lua.create_table();
    carrying["weight_grams"] =
        units::to_gram( character.weight_carried() );
    carrying["weight_capacity_grams"] =
        units::to_gram( character.weight_capacity() );
    carrying["free_weight_capacity_grams"] =
        units::to_gram( character.free_weight_capacity() );
    carrying["volume_ml"] =
        units::to_milliliter( character.volume_carried() );
    result["carrying"] = std::move( carrying );

    const move_mode_id movement_mode =
        character.current_movement_mode();
    sol::table movement = lua.create_table();
    movement["id"] = movement_mode.str();
    movement["name"] = movement_mode.is_valid() ?
                       movement_mode->name() : movement_mode.str();
    movement["speed"] = character.get_speed();
    movement["speed_base"] = character.get_speed_base();
    movement["speed_bonus"] = character.get_speed_bonus();
    movement["mounted"] = character.is_mounted();
    movement["driving"] = character.is_driving();
    movement["in_vehicle"] = character.in_vehicle;
    const optional_vpart_position vehicle_position =
        get_map().veh_at( character.pos_bub() );
    movement["controlling_vehicle"] = vehicle_position &&
                                        vehicle_position->vehicle().player_in_control(
                                            get_map(), character );
    result["movement"] = std::move( movement );

    sol::table activity = lua.create_table();
    activity["active"] = !character.activity.is_null();
    activity["level_index"] = character.activity_level_index();
    if( !character.activity.is_null() ) {
        activity["id"] = script_game_id(
                              "activity", character.activity.id().str() );
    }
    result["activity"] = std::move( activity );

    sol::table environment = lua.create_table();
    environment["outside"] = is_creature_outside( character );
    const npc *person = character.as_npc();
    environment["safe_space"] =
        overmap_buffer.is_safe( character.pos_abs_omt() ) &&
        ( person == nullptr || person->is_safe() );
    const std::pair<int, int> climate_control =
        character.climate_control_strength();
    environment["climate_control_heat"] =
        climate_control.first;
    environment["climate_control_chill"] =
        climate_control.second;
    result["environment"] = std::move( environment );

    result["temperature"] = character_temperature_state(
                                lua, character );

    sol::table npc_state = lua.create_table();
    if( person != nullptr ) {
        npc_state["present"] = true;
        npc_state["enemy"] = person->is_enemy();
        npc_state["following"] = person->is_following();
        npc_state["player_ally"] = person->is_player_ally();
        npc_state["marked_for_death"] = person->marked_for_death;
    } else {
        npc_state["present"] = false;
    }
    result["npc_state"] = std::move( npc_state );

    sol::table travel = lua.create_table();
    travel["has_path"] = !character.omt_path.empty();
    result["travel"] = std::move( travel );

    result["body_parts"] = character_body_parts(
                               lua, character, requested_body_part_limit );
    return result;
}

sol::table character_snapshot_result(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_body_part_limit,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *character = character_from_handle(
                                     handle, runtime_generation,
                                     world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_character(
                       state, *character,
                       body_part_limit( requested_body_part_limit ) ) ) );
}

sol::table character_by_id(
    sol::this_state lua, const std::int64_t id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    Character *match = nullptr;
    if( g != nullptr ) {
        const std::vector<Character *> matches =
        g->get_characters_if( [id]( const Character & candidate ) {
            return candidate.getID().get_value() == id &&
                   !candidate.is_dead_state();
        } );
        if( !matches.empty() ) {
            match = matches.front();
        }
    } else if( get_avatar().getID().get_value() == id ) {
        match = &get_avatar();
    }
    if( match == nullptr ) {
        return make_game_error_result(
                   state, { "not_found", "No active character has that id" } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, make_creature_handle(
                       *match, runtime_generation, world_generation ) ) );
}

template<typename Id>
sol::table training_id_list(
    sol::state_view lua, const std::vector<Id> &ids,
    const std::string &kind )
{
    const std::size_t returned = std::min(
                                     ids.size(), maximum_training_offers );
    sol::table result = lua.create_table(
                            static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        result[index + 1] = script_game_id(
                                kind, ids[index].str() );
    }
    return result;
}

sol::table character_training_offers(
    sol::this_state lua, const game_handle &trainer_handle,
    const game_handle &student_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *trainer = character_from_handle(
                                   trainer_handle, runtime_generation,
                                   world_generation, error );
    if( trainer == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const Character *student = character_from_handle(
                                   student_handle, runtime_generation,
                                   world_generation, error );
    if( student == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::vector<skill_id> skills =
        trainer->skills_offered_to( student );
    const std::vector<proficiency_id> proficiencies =
        trainer->proficiencies_offered_to( student );
    const std::vector<matype_id> styles =
        trainer->styles_offered_to( student );
    const std::vector<spell_id> spells =
        trainer->spells_offered_to( student );
    sol::table value = state.create_table();
    value["skills"] = training_id_list(
                          state, skills, "skill" );
    value["proficiencies"] = training_id_list(
                                 state, proficiencies, "proficiency" );
    value["styles"] = training_id_list(
                          state, styles, "martial_art" );
    value["spells"] = training_id_list(
                          state, spells, "spell" );
    value["skill_count"] = skills.size();
    value["proficiency_count"] = proficiencies.size();
    value["style_count"] = styles.size();
    value["spell_count"] = spells.size();
    value["truncated"] = skills.size() > maximum_training_offers ||
                           proficiencies.size() > maximum_training_offers ||
                           styles.size() > maximum_training_offers ||
                           spells.size() > maximum_training_offers;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

monster *monster_from_handle(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = *resolved.error;
        return nullptr;
    }
    monster *result = resolved.value->as_monster();
    if( result == nullptr ) {
        error = game_handle_error{
            "wrong_target", "The handle does not reference a monster"
        };
    }
    return result;
}

sol::table monster_disposition_state(
    sol::state_view lua, const monster &entry )
{
    sol::table result = lua.create_table();
    result["anger"] = entry.anger;
    result["morale"] = entry.morale;
    result["friendly"] = entry.friendly;
    result["friendly_active"] = entry.friendly != 0;
    return result;
}

struct monster_disposition_updates {
    std::optional<int> anger;
    std::optional<int> morale;
    std::optional<int> friendly;
};

monster_disposition_updates read_monster_disposition_updates(
    const sol::table &requested, const std::string &api_name )
{
    monster_disposition_updates result;
    for( const auto &entry : requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " field names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "anger" && key != "morale" &&
            key != "friendly" ) {
            throw std::invalid_argument(
                api_name + " received unknown field '" + key + "'" );
        }
        if( !entry.second.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " field '" + key + "' must be an integer" );
        }
        const lua_Integer value = entry.second.as<lua_Integer>();
        if( value < std::numeric_limits<int>::min() ||
            value > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                api_name + " field '" + key +
                "' is outside native integer bounds" );
        }
        if( key == "anger" ) {
            result.anger = static_cast<int>( value );
        } else if( key == "morale" ) {
            result.morale = static_cast<int>( value );
        } else {
            result.friendly = static_cast<int>( value );
        }
    }
    if( !result.anger && !result.morale && !result.friendly ) {
        throw std::invalid_argument(
            api_name + " requires anger, morale, or friendly" );
    }
    return result;
}

std::optional<int> adjusted_monster_disposition(
    const int current, const int delta )
{
    const std::int64_t adjusted =
        static_cast<std::int64_t>( current ) + delta;
    if( adjusted < std::numeric_limits<int>::min() ||
        adjusted > std::numeric_limits<int>::max() ) {
        return std::nullopt;
    }
    return static_cast<int>( adjusted );
}

sol::table change_monster_disposition(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested, const bool relative,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name = relative ?
                                 "game.monsters.modify_disposition" :
                                 "game.monsters.set_disposition";
    const monster_disposition_updates updates =
        read_monster_disposition_updates( requested, api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    monster *entry = monster_from_handle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }

    std::optional<int> anger = updates.anger;
    std::optional<int> morale = updates.morale;
    std::optional<int> friendly = updates.friendly;
    if( relative ) {
        if( updates.anger ) {
            anger = adjusted_monster_disposition(
                        entry->anger, *updates.anger );
        }
        if( updates.morale ) {
            morale = adjusted_monster_disposition(
                         entry->morale, *updates.morale );
        }
        if( updates.friendly ) {
            friendly = adjusted_monster_disposition(
                           entry->friendly, *updates.friendly );
        }
        if( ( updates.anger && !anger ) ||
            ( updates.morale && !morale ) ||
            ( updates.friendly && !friendly ) ) {
            return make_game_error_result( state, {
                "numeric_overflow",
                api_name + " would overflow native monster state"
            } );
        }
    }

    sol::table before = monster_disposition_state(
                            state, *entry );
    if( anger ) {
        entry->anger = *anger;
    }
    if( morale ) {
        entry->morale = *morale;
    }
    if( friendly ) {
        entry->friendly = *friendly;
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = monster_disposition_state(
                         state, *entry );
    value["relative"] = relative;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_monster_friendly(
    sol::this_state lua, const game_handle &handle,
    const bool friendly,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    monster *entry = monster_from_handle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = entry->friendly;
    entry->friendly = friendly ? -1 : 0;
    sol::table value = state.create_table();
    value["before"] = before != 0;
    value["after"] = entry->friendly != 0;
    value["changed"] = before != entry->friendly;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table configure_monster_summon(
    sol::this_state lua, const game_handle &handle,
    const script_time_duration &lifespan,
    const sol::optional<game_handle> &summoner_handle,
    const sol::optional<bool> &temporary_drop_items,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const time_duration native_lifespan = lifespan.to_native();
    if( native_lifespan <= 0_turns ||
        native_lifespan > 10000_days ) {
        throw std::invalid_argument(
            "game.monsters.set_summon lifespan must be within 1 turn..10000 days" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    monster *entry = monster_from_handle(
                         handle, runtime_generation,
                         world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Creature *summoner = nullptr;
    if( summoner_handle ) {
        const native_handle_result<Creature> resolved_summoner =
            summoner_handle->resolve_creature(
                runtime_generation, world_generation );
        if( !resolved_summoner ) {
            return make_game_error_result(
                       state, *resolved_summoner.error );
        }
        if( resolved_summoner.value == entry ) {
            throw std::invalid_argument(
                "game.monsters.set_summon summoner cannot be the summoned monster" );
        }
        summoner = resolved_summoner.value;
    }
    entry->set_summon_time( native_lifespan );
    entry->set_summoner( summoner );
    const bool drop_items =
        temporary_drop_items.value_or( false );
    entry->no_extra_death_drops = !drop_items;
    entry->no_corpse_quiet = !drop_items;
    sol::table value = state.create_table();
    value["lifespan"] = lifespan;
    value["has_summoner"] = summoner != nullptr;
    value["temporary_drop_items"] = drop_items;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table character_can_see_location(
    sol::this_state lua, const game_handle &observer_handle,
    const script_tripoint_coord &requested_position,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.characters.can_see_location";
    if( requested_position.native_origin() != coords::origin::abs ||
        requested_position.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires an absolute map-square Tripoint" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    const Character *observer = character_from_handle(
                                    observer_handle, runtime_generation,
                                    world_generation, error );
    if( observer == nullptr ) {
        return make_game_error_result( state, *error );
    }
    map &here = get_map();
    const tripoint_abs_ms absolute(
        requested_position.to_native() );
    if( !here.inbounds( absolute ) ) {
        return make_game_value_result(
                   state, sol::make_object( state, false ) );
    }
    const bool visible = observer->sees(
                             here, here.get_bub( absolute ) );
    return make_game_value_result(
               state, sol::make_object( state, visible ) );
}

sol::table nearby_characters(
    sol::this_state lua, const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const creature_query_options options = read_query_options( requested );
    avatar &player = get_avatar();
    map &here = get_map();
    std::vector<Character *> characters;
    if( g != nullptr ) {
        characters = g->get_characters_if(
        [&]( const Character & candidate ) {
            if( candidate.is_dead_state() ||
                ( !options.include_avatar && candidate.is_avatar() ) ||
                ( !options.include_hallucinations &&
                  candidate.is_hallucination() ) ||
                rl_dist( player.pos_bub(), candidate.pos_bub( here ) ) >
                options.radius ) {
                return false;
            }
            return !options.visible_only || player.sees( here, candidate );
        } );
    } else if( options.include_avatar ) {
        characters.push_back( &player );
    }
    std::sort(
        characters.begin(), characters.end(),
    [&]( const Character * lhs, const Character * rhs ) {
        return rl_dist( player.pos_bub(), lhs->pos_bub( here ) ) <
               rl_dist( player.pos_bub(), rhs->pos_bub( here ) );
    } );

    const std::size_t returned = std::min(
                                     characters.size(),
                                     static_cast<std::size_t>( options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        Character &character = *characters[index];
        sol::table entry = state.create_table();
        entry["handle"] = make_creature_handle(
                              character, runtime_generation,
                              world_generation );
        entry["id"] = character.getID().get_value();
        entry["name"] = character.get_name();
        entry["kind"] = creature_kind( character );
        entry["distance"] = rl_dist(
                                player.pos_bub(), character.pos_bub( here ) );
        items[index + 1] = std::move( entry );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = characters.size();
    result["returned"] = returned;
    result["radius"] = options.radius;
    result["limit"] = options.limit;
    result["truncated"] = returned < characters.size();
    return result;
}

} // namespace

void install_creature_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
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
    creatures.set_function(
        "can_see",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & observer,
    const game_handle & target ) {
        require_read();
        sol::state_view state( lua_state );
        const native_handle_result<Creature> resolved_observer =
            observer.resolve_creature(
                current_runtime_generation(), current_world_generation() );
        if( !resolved_observer ) {
            return make_game_error_result( state, *resolved_observer.error );
        }
        const native_handle_result<Creature> resolved_target =
            target.resolve_creature(
                current_runtime_generation(), current_world_generation() );
        if( !resolved_target ) {
            return make_game_error_result( state, *resolved_target.error );
        }
        return make_game_value_result(
                   state, sol::make_object(
                       state, resolved_observer.value->sees(
                           get_map(), *resolved_target.value ) ) );
    } );
    creatures.set_function(
        "has_line_of_sight",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &observer,
            const game_handle &target ) {
        require_read();
        return creature_line_of_sight(
                   lua_state, observer, target,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    creatures.set_function(
        "visible_monsters",
        [require_read]( sol::this_state lua_state,
    const std::string & direction ) {
        require_read();
        return visible_monsters_by_direction(
                   lua_state, direction );
    } );
    creatures.set_function(
        "has_species",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const script_game_id &species ) {
        require_read();
        return creature_has_species(
                   lua_state, handle, species,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    creatures.set_function(
        "has_body_type",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const std::string &body_type ) {
        require_read();
        return creature_has_body_type(
                   lua_state, handle, body_type,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["creatures"] = std::move( creatures );

    sol::table monsters = lua.create_table();
    monsters.set_function(
        "set_disposition",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::table &values ) {
        require_write();
        return change_monster_disposition(
                   lua_state, handle, values, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    monsters.set_function(
        "modify_disposition",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::table &deltas ) {
        require_write();
        return change_monster_disposition(
                   lua_state, handle, deltas, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    monsters.set_function(
        "set_friendly",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
    const bool friendly ) {
        require_write();
        return set_monster_friendly(
                   lua_state, handle, friendly,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    monsters.set_function(
        "set_summon",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_time_duration &lifespan,
            const sol::optional<game_handle> &summoner,
    const sol::optional<bool> &temporary_drop_items ) {
        require_write();
        return configure_monster_summon(
                   lua_state, handle, lifespan, summoner,
                   temporary_drop_items,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    monsters.set_function(
        "count_nearby",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord &origin,
            const sol::optional<sol::table> &ids,
            const sol::optional<sol::table> &options ) {
        require_read();
        return count_nearby_monsters(
                   lua_state, origin, ids, options,
                   nearby_monster_filter_kind::type );
    } );
    monsters.set_function(
        "count_species_nearby",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord &origin,
            const sol::optional<sol::table> &species,
            const sol::optional<sol::table> &options ) {
        require_read();
        return count_nearby_monsters(
                   lua_state, origin, species, options,
                   nearby_monster_filter_kind::species );
    } );
    monsters.set_function(
        "count_groups_nearby",
        [require_read](
            sol::this_state lua_state,
            const script_tripoint_coord &origin,
            const sol::optional<sol::table> &groups,
            const sol::optional<sol::table> &options ) {
        require_read();
        return count_nearby_monsters(
                   lua_state, origin, groups, options,
                   nearby_monster_filter_kind::group );
    } );
    game["monsters"] = std::move( monsters );

    sol::table characters = lua.create_table();
    characters.set_function(
        "avatar",
        [current_runtime_generation, current_world_generation,
                                require_read]() {
        require_read();
        return make_creature_handle(
                   get_avatar(), current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "snapshot",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<int> &body_part_limit ) {
        require_read();
        return character_snapshot_result(
                   lua_state, handle, body_part_limit,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "by_id",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const std::int64_t id ) {
        require_read();
        return character_by_id(
                   lua_state, id, current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "nearby",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return nearby_characters(
                   lua_state, options, current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "count_nearby",
        [current_runtime_generation,
         current_world_generation,
         require_read](
            sol::this_state lua_state,
            const script_tripoint_coord &origin,
            const sol::optional<game_handle> &observer,
            const sol::optional<sol::table> &options ) {
        require_read();
        return count_nearby_characters(
                   lua_state, origin, observer, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "training_offers",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &trainer,
            const game_handle &student ) {
        require_read();
        return character_training_offers(
                   lua_state, trainer, student,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "can_see_location",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &observer,
            const script_tripoint_coord &position ) {
        require_read();
        return character_can_see_location(
                   lua_state, observer, position,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "armor",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &damage_type,
    const script_game_id &body_part ) {
        require_read();
        return character_armor(
                   lua_state, handle, damage_type, body_part,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "coverage",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const script_game_id &body_part ) {
        require_read();
        return character_coverage(
                   lua_state, handle, body_part,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "limb_score",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &score,
    const sol::optional<std::string> &body_part_type ) {
        require_read();
        return character_limb_score(
                   lua_state, handle, score, body_part_type,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "consumption_count",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<script_game_id> &item,
    const sol::optional<script_time_duration> &window ) {
        require_read();
        return character_consumption_count(
                   lua_state, handle, item, window,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "enchantment_value",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &key,
    const sol::optional<double> &base ) {
        require_read();
        return character_enchantment_value(
                   lua_state, handle, key, base,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "adjust",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & adjustments ) {
        require_write();
        return adjust_character(
                   lua_state, handle, adjustments,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "set_demographics",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::table &updates ) {
        require_write();
        return set_character_demographics(
                   lua_state, handle, updates,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "set_attributes",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::table &values ) {
        require_write();
        return change_character_attributes(
                   lua_state, handle, values, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "modify_attributes",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::table &deltas ) {
        require_write();
        return change_character_attributes(
                   lua_state, handle, deltas, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "set_kill_xp",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::int64_t value ) {
        require_write();
        return change_character_kill_xp(
                   lua_state, handle, value, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "modify_kill_xp",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::int64_t delta ) {
        require_write();
        return change_character_kill_xp(
                   lua_state, handle, delta, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "heal",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & body_part, const int amount ) {
        require_write();
        return heal_character(
                   lua_state, handle, body_part, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "set_hp",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &body_part, const int hp ) {
        require_write();
        return set_character_hp(
                   lua_state, handle, body_part, hp,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "hp_group",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const std::string &group ) {
        require_read();
        return character_hp_group(
                   lua_state, handle, group,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "set_hp_group",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &group, const int hp ) {
        require_write();
        return set_character_hp_group(
                   lua_state, handle, group, hp,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    characters.set_function(
        "attack",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &attacker,
            const game_handle &target, const std::string &technique,
            const sol::optional<sol::table> &options ) {
        require_write();
        return attack_character(
                   lua_state, attacker, target, technique, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "choose_technique",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &attacker,
            const game_handle &target,
            const sol::optional<sol::table> &options ) {
        require_write();
        return choose_character_technique(
                   lua_state, attacker, target, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "ranged_attack",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &attacker,
            const game_handle &target ) {
        require_write();
        return ranged_attack_character(
                   lua_state, attacker, target,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "knockback",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<sol::table> &options ) {
        require_write();
        return knockback_character(
                   lua_state, handle, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "explosion",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<sol::table> &options ) {
        require_write();
        return explosion_character(
                   lua_state, handle, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "emit",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::string &emission,
            const sol::optional<double> &chance ) {
        require_write();
        return emit_character(
                   lua_state, handle, emission, chance,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "cast_spell",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &spell, const sol::optional<sol::table> &options ) {
        require_write();
        return cast_spell_character(
                   lua_state, handle, spell, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "die",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<sol::table> &options ) {
        require_write();
        return die_character(
                   lua_state, handle, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "prevent_death",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return prevent_death_character(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "recalculate_enchantments",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle ) {
        require_write();
        return recalculate_character_enchantments(
                   lua_state, handle,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "pick_body_part",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<sol::table> &options ) {
        require_read();
        return pick_character_body_part(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation(), false );
    } );
    characters.set_function(
        "choose_body_part",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<sol::table> &options ) {
        require_write();
        return pick_character_body_part(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation(), true );
    } );
    characters.set_function(
        "damage",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & damage_type, const double amount,
    const sol::optional<sol::table> &options ) {
        require_write();
        return damage_character(
                   lua_state, handle, damage_type, amount, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "add_faction_trust",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &handle,
            const std::int64_t amount ) {
        require_write();
        return add_character_faction_trust(
                   lua_state, handle, amount,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "set_faction_relationship",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &source,
            const game_handle &target, const std::string &relationship,
            const bool enabled ) {
        require_write();
        return set_character_faction_relationship(
                   lua_state, source, target, relationship, enabled,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "is_safe",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        const Character *character = character_from_handle(
                                         handle, current_runtime_generation(),
                                         current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const bool safe = character->is_npc() ?
                          character->as_npc()->is_safe() : true;
        return make_game_value_result(
                   state, sol::make_object( state, safe ) );
    } );
    characters.set_function(
        "is_alive",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return character_boolean_query(
                   lua_state, handle, current_runtime_generation(),
                   current_world_generation(), character_is_alive_value );
    } );
    characters.set_function(
        "is_underwater",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return character_boolean_query(
                   lua_state, handle, current_runtime_generation(),
                   current_world_generation(), character_is_underwater_value );
    } );
    characters.set_function(
        "has_part_temp",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle,
    const script_game_id & body_part, const double minimum ) {
        require_read();
        return character_has_part_temperature(
                   lua_state, handle, body_part, minimum,
                   current_runtime_generation(), current_world_generation() );
    } );
    characters.set_function(
        "has_flag",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle,
    const script_game_id & flag ) {
        require_read();
        if( flag.kind() != "json_flag" ) {
            throw std::invalid_argument(
                "services.characters.has_flag requires GameId<json_flag>" );
        }
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        const Character *character = character_from_handle(
                                         handle, current_runtime_generation(),
                                         current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const json_character_flag requested( flag.value() );
        const bool present = requested == json_flag_MUTATION_THRESHOLD ?
                             character->crossed_threshold() :
                             character->has_flag( requested );
        return make_game_value_result(
                   state, sol::make_object( state, present ) );
    } );
    characters.set_function(
        "has_profession",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle,
    const std::string & profession_id_string ) {
        require_read();
        sol::state_view state( lua_state );
        std::optional<game_handle_error> error;
        const Character *character = character_from_handle(
                                         handle, current_runtime_generation(),
                                         current_world_generation(), error );
        if( character == nullptr ) {
            return make_game_error_result( state, *error );
        }
        const profession_id requested( profession_id_string );
        const bool present = character_has_profession( *character, requested );
        return make_game_value_result(
                   state, sol::make_object( state, present ) );
    } );
    characters.set_function(
        "add_wet",
        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state lua_state, const game_handle & handle,
    const std::int64_t amount ) {
        require_write();
        if( amount < -1000000 || amount > 1000000 ) {
            throw std::invalid_argument(
                "services.characters.add_wet amount must be within -1000000..1000000" );
        }
        sol::state_view state( lua_state );
        const native_handle_result<Creature> resolved =
            handle.resolve_creature(
                current_runtime_generation(), current_world_generation() );
        if( !resolved ) {
            return make_game_error_result( state, *resolved.error );
        }
        Character *character = dynamic_cast<Character *>( resolved.value );
        if( character == nullptr ) {
            return make_game_error_result( state, {
                "wrong_target",
                "services.characters.add_wet requires a character handle"
            } );
        }
        wet_character( *character, static_cast<int>( amount ) );
        return make_game_value_result(
                   state, sol::make_object( state, true ) );
    } );
    characters.set_function(
        "set_movement_mode",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & mode ) {
        require_write();
        return set_character_movement_mode(
                   lua_state, handle, mode,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["characters"] = std::move( characters );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
