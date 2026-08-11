#if CATA_ENABLE_LUA_UI

#include "catalua_ui_magic.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"
#include "enum_conversions.h"
#include "magic.h"
#include "magic_enchantment.h"
#include "map.h"
#include "player_activity.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int default_known_limit = 64;
constexpr int maximum_known_limit = 256;
constexpr std::size_t maximum_offset = 1000000;
constexpr std::size_t maximum_relation_values = 128;
constexpr int maximum_spell_experience = 1000000000;
constexpr int maximum_spell_level = 10000;
constexpr int maximum_spell_gain = 1000000;
constexpr int maximum_mana_value = 1000000000;
const trait_id trait_none( "NONE" );

void require_spell_id(
    const script_game_id &id, const std::string &api_name )
{
    if( id.kind() != "spell" ) {
        throw std::invalid_argument(
            api_name + " requires GameId<spell>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<spell>" );
    }
}

Character *resolve_character(
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
    Character *character = resolved.value->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_subtype",
            "The creature referenced by this GameHandle is not a character"
        };
    }
    return character;
}

template<typename Range>
sol::table typed_id_page(
    sol::state_view lua, const Range &ids,
    const std::string &kind )
{
    const std::size_t total = ids.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &id : ids ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] = script_game_id(
                               kind, id.str() );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

template<typename Range>
sol::table string_page(
    sol::state_view lua, const Range &values )
{
    const std::size_t total = values.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &value : values ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] = value;
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

template<typename Id>
void set_optional_typed_id(
    sol::table &table, const std::string &field,
    const Id &id, const std::string &kind )
{
    if( id.is_null() ) {
        table[field] = sol::nil;
    } else {
        table[field] = script_game_id( kind, id.str() );
    }
}

template<typename Id>
void set_optional_string_id(
    sol::table &table, const std::string &field,
    const Id &id )
{
    if( id.is_empty() ) {
        table[field] = sol::nil;
    } else {
        table[field] = id.str();
    }
}

sol::table numeric_formula(
    sol::state_view lua, const dbl_or_var &formula )
{
    sol::table result = lua.create_table();
    const bool minimum_constant =
        formula.min.is_constant();
    const bool has_maximum = formula.max.has_value();
    const bool maximum_constant =
        !has_maximum || formula.max->is_constant();
    if( minimum_constant ) {
        result["minimum"] = formula.min.constant();
    } else {
        result["minimum"] = sol::nil;
    }
    if( has_maximum ) {
        if( maximum_constant ) {
            result["maximum"] =
                formula.max->constant();
        } else {
            result["maximum"] = sol::nil;
        }
    } else if( minimum_constant ) {
        result["maximum"] = formula.min.constant();
    } else {
        result["maximum"] = sol::nil;
    }
    result["random_range"] = has_maximum;
    result["dynamic"] =
        !minimum_constant || !maximum_constant;
    return result;
}

sol::table additional_spell_page(
    sol::state_view lua,
    const std::vector<fake_spell> &spells )
{
    const std::size_t total = spells.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const fake_spell &entry = spells[index];
        sol::table item = lua.create_table();
        item["id"] = script_game_id(
                         "spell", entry.id.str() );
        item["level"] = entry.level;
        item["force_target_source"] = entry.self;
        item["trigger_once_in"] =
            entry.trigger_once_in;
        if( entry.max_level ) {
            item["maximum_level"] = *entry.max_level;
        } else {
            item["maximum_level"] = sol::nil;
        }
        items[index + 1] = std::move( item );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table learned_spell_page(
    sol::state_view lua,
    const std::map<std::string, int> &spells )
{
    const std::size_t total = spells.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &entry : spells ) {
        if( index >= returned ) {
            break;
        }
        sol::table item = lua.create_table();
        item["id"] = script_game_id(
                         "spell", entry.first );
        item["level"] = entry.second;
        items[index + 1] = std::move( item );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table valid_target_page(
    sol::state_view lua,
    const enum_bitset<spell_target> &targets )
{
    std::vector<std::string> values;
    for( int raw = 0;
         raw < static_cast<int>(
             spell_target::num_spell_targets ); ++raw ) {
        const spell_target target =
            static_cast<spell_target>( raw );
        if( targets.test( target ) ) {
            values.push_back(
                io::enum_to_string( target ) );
        }
    }
    return string_page( lua, values );
}

sol::table source_page(
    sol::state_view lua,
    const std::vector<std::pair<spell_id, mod_id>> &sources )
{
    const std::size_t total = sources.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        sol::table item = lua.create_table();
        item["spell"] = script_game_id(
                            "spell",
                            sources[index].first.str() );
        item["mod"] = script_game_id(
                          "mod",
                          sources[index].second.str() );
        items[index + 1] = std::move( item );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const spell_type &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "spell", definition.id.str() );
    result["name"] = definition.name.translated();
    result["description"] =
        definition.description.translated();
    result["message"] = definition.message.translated();
    result["teachable"] = definition.teachable;
    result["effect"] = definition.effect_name;
    result["effect_data"] = definition.effect_str;
    result["shape"] =
        io::enum_to_string( definition.spell_area );
    result["energy_source"] =
        io::enum_to_string(
            definition.get_energy_source() );

    set_optional_typed_id(
        result, "skill", definition.skill, "skill" );
    set_optional_typed_id(
        result, "spell_class",
        definition.spell_class, "mutation" );
    set_optional_typed_id(
        result, "damage_type",
        definition.dmg_type, "damage_type" );
    if( definition.field ) {
        result["field"] = script_game_id(
                              "field",
                              definition.field->id().str() );
    } else {
        result["field"] = sol::nil;
    }
    if( definition.magic_type ) {
        result["magic_type"] =
            definition.magic_type->str();
    } else {
        result["magic_type"] = sol::nil;
    }
    set_optional_string_id(
        result, "components",
        definition.spell_components );
    set_optional_string_id(
        result, "explosion_light",
        definition.explosion_light );
    if( definition.get_energy_source() ==
        magic_energy_type::vitamin ) {
        result["vitamin_energy_source"] =
            script_game_id(
                "vitamin",
                definition.vitamin_energy_source().str() );
    } else {
        result["vitamin_energy_source"] = sol::nil;
    }

    sol::table formulas = lua.create_table();
    formulas["field_chance"] = numeric_formula(
                                   lua,
                                   definition.field_chance );
    formulas["minimum_field_intensity"] = numeric_formula(
            lua, definition.min_field_intensity );
    formulas["field_intensity_increment"] = numeric_formula(
            lua, definition.field_intensity_increment );
    formulas["maximum_field_intensity"] = numeric_formula(
            lua, definition.max_field_intensity );
    formulas["field_intensity_variance"] = numeric_formula(
            lua, definition.field_intensity_variance );
    formulas["minimum_accuracy"] = numeric_formula(
                                       lua,
                                       definition.min_accuracy );
    formulas["accuracy_increment"] = numeric_formula(
                                         lua,
                                         definition.accuracy_increment );
    formulas["maximum_accuracy"] = numeric_formula(
                                       lua,
                                       definition.max_accuracy );
    formulas["minimum_damage"] = numeric_formula(
                                     lua,
                                     definition.min_damage );
    formulas["damage_increment"] = numeric_formula(
                                       lua,
                                       definition.damage_increment );
    formulas["maximum_damage"] = numeric_formula(
                                     lua,
                                     definition.max_damage );
    formulas["minimum_range"] = numeric_formula(
                                    lua,
                                    definition.min_range );
    formulas["range_increment"] = numeric_formula(
                                      lua,
                                      definition.range_increment );
    formulas["maximum_range"] = numeric_formula(
                                    lua,
                                    definition.max_range );
    formulas["minimum_area"] = numeric_formula(
                                   lua, definition.min_aoe );
    formulas["area_increment"] = numeric_formula(
                                     lua, definition.aoe_increment );
    formulas["maximum_area"] = numeric_formula(
                                   lua, definition.max_aoe );
    formulas["minimum_damage_over_time"] = numeric_formula(
            lua, definition.min_dot );
    formulas["damage_over_time_increment"] = numeric_formula(
                lua, definition.dot_increment );
    formulas["maximum_damage_over_time"] = numeric_formula(
            lua, definition.max_dot );
    formulas["minimum_duration_moves"] = numeric_formula(
            lua, definition.min_duration );
    formulas["duration_increment_moves"] = numeric_formula(
            lua, definition.duration_increment );
    formulas["maximum_duration_moves"] = numeric_formula(
            lua, definition.max_duration );
    formulas["minimum_pierce"] = numeric_formula(
                                     lua,
                                     definition.min_pierce );
    formulas["pierce_increment"] = numeric_formula(
                                       lua,
                                       definition.pierce_increment );
    formulas["maximum_pierce"] = numeric_formula(
                                     lua,
                                     definition.max_pierce );
    formulas["minimum_bash_scaling"] = numeric_formula(
                                           lua, definition.min_bash_scaling );
    formulas["bash_scaling_increment"] = numeric_formula(
            lua, definition.bash_scaling_increment );
    formulas["maximum_bash_scaling"] = numeric_formula(
                                           lua, definition.max_bash_scaling );
    formulas["base_energy_cost"] = numeric_formula(
                                       lua,
                                       definition.base_energy_cost );
    formulas["energy_increment"] = numeric_formula(
                                       lua,
                                       definition.energy_increment );
    formulas["final_energy_cost"] = numeric_formula(
                                        lua,
                                        definition.final_energy_cost );
    formulas["difficulty"] = numeric_formula(
                                 lua, definition.difficulty );
    formulas["projectiles"] = numeric_formula(
                                  lua,
                                  definition.multiple_projectiles );
    formulas["maximum_level"] = numeric_formula(
                                    lua,
                                    definition.max_level );
    formulas["base_casting_time_moves"] = numeric_formula(
            lua, definition.base_casting_time );
    formulas["casting_time_increment_moves"] = numeric_formula(
                lua, definition.casting_time_increment );
    formulas["final_casting_time_moves"] = numeric_formula(
            lua, definition.final_casting_time );
    result["formulas"] = std::move( formulas );

    sol::table channel = lua.create_table();
    channel["turns"] = definition.channelling_turns;
    channel["spell"] = definition.channel_spell;
    channel["end_spell"] = definition.channel_end_spell;
    channel["interrupt_spell"] =
        definition.channel_interrupt_spell;
    channel["uses_energy"] =
        definition.channel_uses_energy;
    result["channel"] = std::move( channel );

    sol::table sound = lua.create_table();
    sound["description"] =
        definition.sound_description.translated();
    sound["ambient"] = definition.sound_ambient;
    sound["id"] = definition.sound_id;
    sound["variant"] = definition.sound_variant;
    result["sound"] = std::move( sound );

    result["valid_targets"] = valid_target_page(
                                  lua,
                                  definition.valid_targets );
    result["flags"] = string_page(
                          lua, definition.flags );
    result["targeted_monsters"] = typed_id_page(
                                      lua,
                                      definition.targeted_monster_ids,
                                      "monster" );
    result["targeted_species"] = typed_id_page(
                                     lua,
                                     definition.targeted_species_ids,
                                     "species" );
    result["ignored_species"] = typed_id_page(
                                    lua,
                                    definition.ignored_species_ids,
                                    "species" );
    result["additional_spells"] = additional_spell_page(
                                      lua,
                                      definition.additional_spells );
    result["learned_spells"] = learned_spell_page(
                                   lua,
                                   definition.learn_spells );
    result["sources"] = source_page(
                            lua, definition.src );
    return result;
}

struct page_options {
    std::size_t offset = 0;
    int limit = 0;
};

page_options read_page_options(
    const sol::optional<sol::table> &requested,
    const int default_limit, const int maximum_limit,
    const std::string &api_name )
{
    page_options result;
    result.limit = default_limit;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const sol::object value = entry.second;
        if( !value.is<lua_Integer>() ) {
            throw std::invalid_argument(
                api_name + " options must be integers" );
        }
        const lua_Integer number = value.as<lua_Integer>();
        if( number < 0 ) {
            throw std::invalid_argument(
                api_name + " options cannot be negative" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min<lua_Integer>(
                                    number, maximum_offset ) );
        } else if( key == "limit" ) {
            result.limit = static_cast<int>(
                               std::min<lua_Integer>(
                                   number, maximum_limit ) );
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options )
{
    const page_options options = read_page_options(
                                     requested_options,
                                     default_definition_limit,
                                     maximum_definition_limit,
                                     "game.spells.definitions" );
    std::vector<const spell_type *> definitions;
    const std::vector<spell_type> &all =
        spell_type::get_all();
    definitions.reserve( all.size() );
    for( const spell_type &definition : all ) {
        definitions.push_back( &definition );
    }
    std::sort(
        definitions.begin(), definitions.end(),
    []( const spell_type * lhs, const spell_type * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    const std::size_t offset = std::min(
                                   options.offset,
                                   definitions.size() );
    const std::size_t returned = std::min(
                                     definitions.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_definition(
                               state,
                               *definitions[offset + index] );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = definitions.size();
    result["offset"] = offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        offset + returned < definitions.size();
    return result;
}

sol::table get_definition(
    sol::this_state lua, const script_game_id &requested_id )
{
    require_spell_id(
        requested_id, "game.spells.definition" );
    sol::state_view state( lua );
    return snapshot_definition(
               state, spell_id( requested_id.value() ).obj() );
}

sol::table snapshot_known_spell(
    sol::state_view lua, Character &character,
    const spell_id &id )
{
    known_magic &magic = *character.magic;
    spell &known = magic.get_spell( id );
    sol::table result = lua.create_table();
    result["id"] = script_game_id( "spell", id.str() );
    result["name"] = known.name();
    result["description"] = known.description();
    result["experience"] = known.xp();
    result["level"] = known.get_level();
    result["effective_level"] =
        known.get_effective_level();
    result["maximum_level"] =
        known.get_max_level( character );
    result["experience_to_next_level"] =
        known.exp_to_next_level();
    result["experience_progress"] =
        known.exp_progress();
    result["maximum_book_level"] =
        known.max_book_level().value_or( 0 );
    result["favorite"] = magic.is_favorite( id );
    result["can_cast"] = known.can_cast( character );
    result["has_enough_energy"] =
        magic.has_enough_energy( character, known );
    result["energy_source"] =
        io::enum_to_string( known.energy_source() );
    result["energy_cost"] =
        known.energy_cost( character );
    result["failure_probability"] =
        known.spell_fail( character );
    result["casting_time_moves"] =
        known.casting_time( character );
    result["damage"] = known.damage( character );
    result["range"] = known.range( character );
    result["area"] = known.aoe( character );
    result["duration_moves"] =
        known.duration( character );
    result["duration"] =
        script_time_duration::from_native(
            known.duration_turns( character ) );
    set_optional_typed_id(
        result, "spell_class",
        known.spell_class(), "mutation" );
    set_optional_typed_id(
        result, "skill", known.skill(), "skill" );
    set_optional_typed_id(
        result, "damage_type",
        known.id()->dmg_type, "damage_type" );
    return result;
}

sol::table list_known(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const page_options options = read_page_options(
                                     requested_options,
                                     default_known_limit,
                                     maximum_known_limit,
                                     "game.spells.list" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::vector<spell_id> spells =
        character->magic->spells();
    std::sort(
        spells.begin(), spells.end(),
    []( const spell_id & lhs, const spell_id & rhs ) {
        return lhs.str() < rhs.str();
    } );
    const std::size_t offset = std::min(
                                   options.offset, spells.size() );
    const std::size_t returned = std::min(
                                     spells.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_known_spell(
                               state, *character,
                               spells[offset + index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = spells.size();
    value["offset"] = offset;
    value["limit"] = options.limit;
    value["returned"] = returned;
    value["has_more"] =
        offset + returned < spells.size();
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table knows_spell(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.knows" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool known = character->magic->knows_spell(
                           spell_id( requested_id.value() ) );
    return make_game_value_result(
               state, sol::make_object( state, known ) );
}

sol::table get_known(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.get" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    if( !character->magic->knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_known",
            "The character does not know spell '" +
            id.str() + "'"
        } );
    }
    sol::table value = snapshot_known_spell(
                           state, *character, id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table can_learn_spell(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.can_learn" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    sol::table value = state.create_table();
    value["known"] =
        character->magic->knows_spell( id );
    value["can_learn"] =
        character->magic->can_learn_spell(
            *character, id );
    value["time"] =
        script_time_duration::from_native(
            character->magic->time_to_learn_spell(
                *character, id ) );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

struct learn_options {
    bool force = false;
    std::optional<int> level;
    std::optional<int> experience;
};

learn_options read_learn_options(
    const sol::optional<sol::table> &requested )
{
    learn_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.spells.learn option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "force" ) {
            if( value.get_type() != sol::type::boolean ) {
                throw std::invalid_argument(
                    "game.spells.learn force must be a boolean" );
            }
            result.force = value.as<bool>();
        } else if( key == "level" ||
                   key == "experience" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "game.spells.learn level and experience must be integers" );
            }
            const lua_Integer number =
                value.as<lua_Integer>();
            const int maximum = key == "level" ?
                                maximum_spell_level :
                                maximum_spell_experience;
            if( number < 0 || number > maximum ) {
                throw std::invalid_argument(
                    "game.spells.learn " + key +
                    " is outside its limit" );
            }
            if( key == "level" ) {
                result.level = static_cast<int>( number );
            } else {
                result.experience =
                    static_cast<int>( number );
            }
        } else {
            throw std::invalid_argument(
                "game.spells.learn received unknown option '" +
                key + "'" );
        }
    }
    if( result.level && result.experience ) {
        throw std::invalid_argument(
            "game.spells.learn accepts either level or experience, not both" );
    }
    return result;
}

sol::table learn_spell(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.learn" );
    const learn_options options =
        read_learn_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    known_magic &magic = *character->magic;
    if( magic.knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "already_known",
            "The character already knows spell '" +
            id.str() + "'"
        } );
    }
    const trait_id spell_class = id->spell_class;
    if( !options.force && spell_class != trait_none &&
        !character->has_trait( spell_class ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "confirmation_required",
            "Learning this spell can change the character's spell class; "
            "use force=true for a non-interactive decision"
        } );
    }
    magic.learn_spell( id, *character, options.force );
    if( !magic.knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "rejected",
            "The engine rejected learning spell '" +
            id.str() + "'"
        } );
    }
    if( options.level ) {
        magic.set_spell_level(
            id, *options.level, character );
    } else if( options.experience ) {
        magic.set_spell_exp(
            id, *options.experience, character );
    }
    sol::table value = snapshot_known_spell(
                           state, *character, id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table forget_spell(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.forget" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    known_magic &magic = *character->magic;
    if( !magic.knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_known",
            "The character does not know spell '" +
            id.str() + "'"
        } );
    }
    sol::table before = snapshot_known_spell(
                            state, *character, id );
    magic.set_spell_level( id, -1, character );
    sol::table value = state.create_table();
    value["forgotten"] = std::move( before );
    value["known"] = magic.knows_spell( id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

enum class spell_adjustment : int {
    set_experience,
    gain_experience,
    set_level,
    gain_levels
};

sol::table adjust_spell(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const int amount,
    const spell_adjustment adjustment,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name =
        adjustment == spell_adjustment::set_experience ?
        "game.spells.set_experience" :
        adjustment == spell_adjustment::gain_experience ?
        "game.spells.gain_experience" :
        adjustment == spell_adjustment::set_level ?
        "game.spells.set_level" :
        "game.spells.gain_levels";
    require_spell_id( requested_id, api_name );
    const bool setting_experience =
        adjustment == spell_adjustment::set_experience;
    const bool setting_level =
        adjustment == spell_adjustment::set_level;
    const int maximum =
        setting_experience ? maximum_spell_experience :
        setting_level ? maximum_spell_level :
        maximum_spell_gain;
    const int minimum =
        setting_experience || setting_level ? 0 : 1;
    if( amount < minimum || amount > maximum ) {
        throw std::invalid_argument(
            api_name + " amount is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    known_magic &magic = *character->magic;
    if( !magic.knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_known",
            "The character does not know spell '" +
            id.str() + "'"
        } );
    }
    sol::table before = snapshot_known_spell(
                            state, *character, id );
    spell &known = magic.get_spell( id );
    switch( adjustment ) {
        case spell_adjustment::set_experience:
            magic.set_spell_exp( id, amount, character );
            break;
        case spell_adjustment::gain_experience:
            known.gain_exp( *character, amount );
            break;
        case spell_adjustment::set_level:
            magic.set_spell_level( id, amount, character );
            break;
        case spell_adjustment::gain_levels:
            known.gain_levels( *character, amount );
            break;
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_known_spell(
                         state, *character, id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table mana_snapshot(
    sol::state_view state, Character &character )
{
    known_magic &magic = *character.magic;
    const int maximum = magic.max_mana( character );
    const double regenerated_pool =
        std::max(
            0.0,
            character.calculate_by_enchantment(
                static_cast<double>( maximum ),
                enchant_vals::mod::REGEN_MANA ) );
    sol::table value = state.create_table();
    value["current"] = magic.available_mana();
    value["maximum"] = maximum;
    value["regeneration_per_turn"] =
        regenerated_pool /
        to_turns<double>( 8_hours );
    value["casting_ignore"] = magic.casting_ignore;
    if( magic.last_spell.is_null() ) {
        value["last_spell"] = sol::nil;
    } else {
        value["last_spell"] = script_game_id(
                                  "spell",
                                  magic.last_spell.str() );
    }
    return value;
}

sol::table get_mana(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = mana_snapshot(
                           state, *character );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table change_mana(
    sol::this_state lua, const game_handle &handle,
    const int amount, const bool relative,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name = relative ?
                                 "game.spells.modify_mana" :
                                 "game.spells.set_mana";
    if( amount < ( relative ? -maximum_mana_value : 0 ) ||
        amount > maximum_mana_value ) {
        throw std::invalid_argument(
            api_name + " amount is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    known_magic &magic = *character->magic;
    sol::table before = mana_snapshot(
                            state, *character );
    if( relative ) {
        magic.mod_mana( *character, amount );
    } else {
        magic.set_mana(
            std::clamp(
                amount, 0, magic.max_mana( *character ) ) );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = mana_snapshot(
                         state, *character );
    value["requested"] = amount;
    value["relative"] = relative;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_casting_ignore(
    sol::this_state lua, const game_handle &handle,
    const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool before =
        character->magic->casting_ignore;
    character->magic->casting_ignore = enabled;
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] =
        character->magic->casting_ignore;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_favorite(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const bool favorite,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.set_favorite" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    known_magic &magic = *character->magic;
    if( !magic.knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_known",
            "The character does not know spell '" +
            id.str() + "'"
        } );
    }
    const bool before = magic.is_favorite( id );
    if( before != favorite ) {
        magic.toggle_favorite( id );
    }
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = magic.is_favorite( id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

void require_absolute_map_square(
    const script_tripoint_coord &target,
    const std::string &api_name )
{
    if( target.native_origin() != coords::origin::abs ||
        target.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument(
            api_name +
            " requires an absolute map-square Tripoint" );
    }
}

sol::table queue_cast(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const script_tripoint_coord &requested_target,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_spell_id(
        requested_id, "game.spells.queue_cast" );
    require_absolute_map_square(
        requested_target, "game.spells.queue_cast" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const spell_id id( requested_id.value() );
    known_magic &magic = *character->magic;
    if( !magic.knows_spell( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_known",
            "The character does not know spell '" +
            id.str() + "'"
        } );
    }
    if( !character->activity.is_null() ) {
        return make_game_error_result(
        state, game_handle_error{
            "busy",
            "The character already has an activity"
        } );
    }
    spell &known = magic.get_spell( id );
    if( known.energy_source() == magic_energy_type::hp ) {
        return make_game_error_result(
        state, game_handle_error{
            "interactive_energy_source",
            "Blood magic requires an interactive body-part choice "
            "and cannot be queued by this API"
        } );
    }
    map &here = get_map();
    const tripoint_bub_ms target = here.get_bub(
                                       tripoint_abs_ms(
                                           requested_target.to_native() ) );
    if( !here.inbounds( target ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "outside_active_map",
            "The requested spell target is outside the active map"
        } );
    }
    if( !known.is_target_in_range( *character, target ) ||
        !known.is_valid_target( *character, target ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "invalid_target",
            "The requested point is not a valid target for this spell"
        } );
    }
    if( !known.can_cast( *character ) ||
        !magic.has_enough_energy( *character, known ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "cannot_cast",
            "The character cannot currently cast this spell"
        } );
    }
    const bool accepted = character->cast_spell(
                              known, false, target );
    if( accepted ) {
        magic.last_spell = id;
    }
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["spell"] = snapshot_known_spell(
                         state, *character, id );
    value["target"] = requested_target;
    if( accepted ) {
        value["activity"] = script_game_id(
                                "activity",
                                character->activity.id().str() );
    } else {
        value["activity"] = sol::nil;
    }
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_magic_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table spells = lua.create_table();
    spells.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    spells.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    spells.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_known(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "knows",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return knows_spell(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return get_known(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "can_learn",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return can_learn_spell(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "learn",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_write();
        return learn_spell(
                   lua_state, handle, id, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "forget",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_write();
        return forget_spell(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "set_experience",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const int amount ) {
        require_write();
        return adjust_spell(
                   lua_state, handle, id, amount,
                   spell_adjustment::set_experience,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "gain_experience",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const int amount ) {
        require_write();
        return adjust_spell(
                   lua_state, handle, id, amount,
                   spell_adjustment::gain_experience,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "set_level",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const int amount ) {
        require_write();
        return adjust_spell(
                   lua_state, handle, id, amount,
                   spell_adjustment::set_level,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "gain_levels",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const int amount ) {
        require_write();
        return adjust_spell(
                   lua_state, handle, id, amount,
                   spell_adjustment::gain_levels,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "mana",
        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_mana(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "set_mana",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const int amount ) {
        require_write();
        return change_mana(
                   lua_state, handle, amount, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "modify_mana",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const int amount ) {
        require_write();
        return change_mana(
                   lua_state, handle, amount, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "set_casting_ignore",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const bool enabled ) {
        require_write();
        return set_casting_ignore(
                   lua_state, handle, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "set_favorite",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const bool favorite ) {
        require_write();
        return set_favorite(
                   lua_state, handle, id, favorite,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    spells.set_function(
        "queue_cast",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const script_tripoint_coord & target ) {
        require_write();
        return queue_cast(
                   lua_state, handle, id, target,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["spells"] = std::move( spells );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
