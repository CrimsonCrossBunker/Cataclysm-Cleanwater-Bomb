#if CATA_ENABLE_LUA_UI

#include "catalua_ui_creatures.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "creature_tracker.h"
#include "game.h"
#include "line.h"
#include "map.h"
#include "monster.h"
#include "move_mode.h"
#include "mtype.h"
#include "npc.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_creature_query_radius = 20;
constexpr int maximum_creature_query_radius = 60;
constexpr int default_creature_query_limit = 64;
constexpr int maximum_creature_query_limit = 256;
constexpr int default_body_part_snapshot_limit = 32;
constexpr int maximum_body_part_snapshot_limit = 64;
constexpr int maximum_character_adjustment = 1000000;
constexpr int maximum_character_healing = 10000;

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

const Character *character_from_handle(
    const game_handle &handle, const std::size_t runtime_generation,
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
    const game_handle &handle, const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

sol::table set_character_movement_mode(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_mode,
    const std::size_t runtime_generation,
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
    result["faction_id"] = character.get_faction_id().str();

    sol::table stats = lua.create_table();
    stats["strength"] = character.get_str();
    stats["dexterity"] = character.get_dex();
    stats["perception"] = character.get_per();
    stats["intelligence"] = character.get_int();
    stats["strength_base"] = character.get_str_base();
    stats["dexterity_base"] = character.get_dex_base();
    stats["perception_base"] = character.get_per_base();
    stats["intelligence_base"] = character.get_int_base();
    stats["strength_bonus"] = character.get_str_bonus();
    stats["dexterity_bonus"] = character.get_dex_bonus();
    stats["perception_bonus"] = character.get_per_bonus();
    stats["intelligence_bonus"] = character.get_int_bonus();
    result["stats"] = std::move( stats );

    sol::table needs = lua.create_table();
    needs["stamina"] = character.get_stamina();
    needs["stamina_max"] = character.get_stamina_max();
    needs["hunger"] = character.get_hunger();
    needs["thirst"] = character.get_thirst();
    needs["sleepiness"] = character.get_sleepiness();
    needs["sleep_deprivation"] = character.get_sleep_deprivation();
    needs["stored_kcal"] = character.get_stored_kcal();
    needs["healthy_kcal"] = character.get_healthy_kcal();
    needs["kcal_percent"] = character.get_kcal_percent();
    needs["focus"] = character.get_focus();
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
    senses["has_watch"] = character.has_watch();
    senses["has_alarm_clock"] = character.has_alarm_clock();
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
    result["movement"] = std::move( movement );

    sol::table npc_state = lua.create_table();
    if( const npc *person = character.as_npc() ) {
        npc_state["present"] = true;
        npc_state["enemy"] = person->is_enemy();
        npc_state["following"] = person->is_following();
        npc_state["player_ally"] = person->is_player_ally();
        npc_state["marked_for_death"] = person->marked_for_death;
    } else {
        npc_state["present"] = false;
    }
    result["npc_state"] = std::move( npc_state );
    result["body_parts"] = character_body_parts(
                               lua, character, requested_body_part_limit );
    return result;
}

sol::table character_snapshot_result(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_body_part_limit,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

sol::table nearby_characters(
    sol::this_state lua, const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
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
