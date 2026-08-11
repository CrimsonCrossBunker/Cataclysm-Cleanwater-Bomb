#if CATA_ENABLE_LUA_UI

#include "catalua_ui_bionics.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "bionics.h"
#include "bodypart.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"
#include "damage.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int default_instance_limit = 128;
constexpr int maximum_instance_limit = 256;
constexpr std::size_t maximum_relation_values = 128;
constexpr std::size_t maximum_body_part_values = 64;
constexpr std::size_t maximum_protection_values = 128;
constexpr std::size_t maximum_definition_offset = 1000000;
constexpr std::int64_t maximum_power_millijoule =
    1000000000000000LL;

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

Character *resolve_character(
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

script_unit_value energy_value( const units::energy &value )
{
    return script_unit_value::from_canonical_integer(
               "energy", "millijoule", value.value() );
}

units::energy native_energy(
    const script_unit_value &value, const std::string &api_name )
{
    if( value.kind() != "energy" ) {
        throw std::invalid_argument(
            api_name + " requires an energy UnitValue" );
    }
    const std::int64_t millijoule = value.canonical_integer();
    if( millijoule < 0 ||
        millijoule > maximum_power_millijoule ) {
        throw std::invalid_argument(
            api_name + " energy is outside its limit" );
    }
    return units::energy(
               millijoule, units::energy::unit_type{} );
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
        items[index + 1] =
            script_game_id( kind, id.str() );
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
sol::table string_id_page(
    sol::state_view lua, const Range &ids )
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
        items[index + 1] = id.str();
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

template<typename Value>
sol::table body_part_value_page(
    sol::state_view lua,
    const std::map<bodypart_str_id, Value> &values )
{
    const std::size_t returned = std::min(
                                     values.size(),
                                     maximum_body_part_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &entry : values ) {
        if( index >= returned ) {
            break;
        }
        sol::table item = lua.create_table();
        item["body_part"] = script_game_id(
                                "body_part", entry.first.str() );
        item["value"] = entry.second;
        items[index + 1] = std::move( item );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = values.size();
    result["returned"] = returned;
    result["truncated"] = returned < values.size();
    return result;
}

sol::table protection_page(
    sol::state_view lua,
    const std::map<bodypart_str_id, resistances> &values )
{
    std::size_t total = 0;
    for( const auto &body_part : values ) {
        total += body_part.second.resist_vals.size();
    }
    const std::size_t returned = std::min(
                                     total, maximum_protection_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &body_part : values ) {
        for( const auto &resistance : body_part.second.resist_vals ) {
            if( index >= returned ) {
                break;
            }
            sol::table item = lua.create_table();
            item["body_part"] = script_game_id(
                                    "body_part",
                                    body_part.first.str() );
            item["damage_type"] = script_game_id(
                                      "damage_type",
                                      resistance.first.str() );
            item["resistance"] = resistance.second;
            items[index + 1] = std::move( item );
            ++index;
        }
        if( index >= returned ) {
            break;
        }
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["returned"] = returned;
    result["truncated"] = returned < total;
    return result;
}

template<typename Id>
void set_optional_id(
    sol::table &table, const std::string &field,
    const Id &id, const std::string &kind )
{
    if( id.is_null() ) {
        table[field] = sol::nil;
    } else {
        table[field] = script_game_id( kind, id.str() );
    }
}

sol::table snapshot_definition(
    sol::state_view lua, const bionic_data &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "bionic", definition.id.str() );
    result["name"] = definition.name.translated();
    result["description"] =
        definition.description.translated();

    sol::table power = lua.create_table();
    power["activation"] =
        energy_value( definition.power_activate );
    power["deactivation"] =
        energy_value( definition.power_deactivate );
    power["over_time"] =
        energy_value( definition.power_over_time );
    power["trigger"] =
        energy_value( definition.power_trigger );
    power["capacity"] = energy_value( definition.capacity );
    power["charge_time"] =
        script_time_duration::from_native(
            definition.charge_time );
    result["power"] = std::move( power );

    result["activated"] = definition.activated;
    result["activated_on_install"] =
        definition.activated_on_install;
    result["included"] = definition.included;
    result["duplicates_allowed"] =
        definition.dupes_allowed;
    result["removes_on_activation"] =
        definition.activate_remove_cbm;
    result["remote_fueled"] =
        definition.is_remote_fueled;
    result["exothermic_power_generation"] =
        definition.exothermic_power_gen;
    result["fuel_efficiency"] =
        definition.fuel_efficiency;
    result["passive_fuel_efficiency"] =
        definition.passive_fuel_efficiency;
    if( definition.coverage_power_gen_penalty ) {
        result["coverage_power_generation_penalty"] =
            *definition.coverage_power_gen_penalty;
    } else {
        result["coverage_power_generation_penalty"] = sol::nil;
    }

    result["flags"] = typed_id_page(
                          lua, definition.flags, "json_flag" );
    result["active_flags"] = typed_id_page(
                                 lua, definition.active_flags,
                                 "json_flag" );
    result["inactive_flags"] = typed_id_page(
                                   lua, definition.inactive_flags,
                                   "json_flag" );
    result["fuel_options"] = typed_id_page(
                                 lua, definition.fuel_opts,
                                 "material" );
    result["included_bionics"] = typed_id_page(
                                     lua,
                                     definition.included_bionics,
                                     "bionic" );
    result["auto_deactivated_bionics"] = typed_id_page(
            lua, definition.autodeactivated_bionics,
            "bionic" );
    result["available_upgrades"] = typed_id_page(
                                       lua,
                                       definition.available_upgrades,
                                       "bionic" );
    result["canceled_mutations"] = typed_id_page(
                                       lua,
                                       definition.canceled_mutations,
                                       "mutation" );
    result["mutation_conflicts"] = typed_id_page(
                                       lua,
                                       definition.mutation_conflicts,
                                       "mutation" );
    result["mutations_on_removal"] = typed_id_page(
                                         lua,
                                         definition.give_mut_on_removal,
                                         "mutation" );
    result["martial_arts"] = typed_id_page(
                                 lua, definition.ma_styles,
                                 "martial_art" );
    result["passive_pseudo_items"] = typed_id_page(
                                         lua,
                                         definition.passive_pseudo_items,
                                         "item" );
    result["toggled_pseudo_items"] = typed_id_page(
                                         lua,
                                         definition.toggled_pseudo_items,
                                         "item" );
    result["enchantments"] = string_id_page(
                                 lua, definition.enchantments );
    result["proficiencies"] = string_id_page(
                                  lua, definition.proficiencies );
    result["activation_eocs"] = string_id_page(
                                    lua, definition.activated_eocs );
    result["processing_eocs"] = string_id_page(
                                    lua, definition.processed_eocs );
    result["deactivation_eocs"] = string_id_page(
                                      lua, definition.deactivated_eocs );

    set_optional_id(
        result, "upgraded_bionic",
        definition.upgraded_bionic, "bionic" );
    set_optional_id(
        result, "required_bionic",
        definition.required_bionic, "bionic" );
    set_optional_id(
        result, "fake_weapon",
        definition.fake_weapon, "item" );
    set_optional_id(
        result, "power_generation_emission",
        definition.power_gen_emission, "emit" );
    result["installation_requirement"] =
        definition.installation_requirement.str();
    if( definition.cant_remove_reason ) {
        result["cannot_remove_reason"] =
            definition.cant_remove_reason->translated();
    } else {
        result["cannot_remove_reason"] = sol::nil;
    }
    result["environmental_protection"] =
        body_part_value_page( lua, definition.env_protec );
    result["occupied_body_parts"] =
        body_part_value_page(
            lua, definition.occupied_bodyparts );
    result["encumbrance"] =
        body_part_value_page(
            lua, definition.encumbrance );
    result["damage_protection"] =
        protection_page( lua, definition.protec );

    const std::size_t spell_count = std::min(
                                        definition.learned_spells.size(),
                                        maximum_relation_values );
    sol::table spell_items = lua.create_table(
                                 static_cast<int>( spell_count ), 0 );
    std::size_t spell_index = 0;
    for( const auto &spell : definition.learned_spells ) {
        if( spell_index >= spell_count ) {
            break;
        }
        sol::table item = lua.create_table();
        item["id"] = script_game_id(
                         "spell", spell.first.str() );
        item["level"] = spell.second;
        spell_items[spell_index + 1] = std::move( item );
        ++spell_index;
    }
    sol::table learned_spells = lua.create_table();
    learned_spells["items"] = std::move( spell_items );
    learned_spells["total"] =
        definition.learned_spells.size();
    learned_spells["returned"] = spell_count;
    learned_spells["truncated"] =
        spell_count < definition.learned_spells.size();
    result["learned_spells"] = std::move( learned_spells );
    return result;
}

struct definition_options {
    std::size_t offset = 0;
    int limit = default_definition_limit;
};

definition_options read_definition_options(
    const sol::optional<sol::table> &requested )
{
    definition_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.bionics.definitions option keys must be strings" );
        }
        const sol::object value = entry.second;
        if( !value.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "game.bionics.definitions options must be integers" );
        }
        const lua_Integer number = value.as<lua_Integer>();
        if( number < 0 ) {
            throw std::invalid_argument(
                "game.bionics.definitions options cannot be negative" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min<lua_Integer>(
                                    number,
                                    maximum_definition_offset ) );
        } else if( key == "limit" ) {
            result.limit = static_cast<int>(
                               std::min<lua_Integer>(
                                   number, maximum_definition_limit ) );
        } else {
            throw std::invalid_argument(
                "game.bionics.definitions received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested_options )
{
    const definition_options options =
        read_definition_options( requested_options );
    std::vector<const bionic_data *> definitions;
    const std::vector<bionic_data> &all =
        bionic_data::get_all();
    definitions.reserve( all.size() );
    for( const bionic_data &definition : all ) {
        definitions.push_back( &definition );
    }
    std::sort(
        definitions.begin(), definitions.end(),
    []( const bionic_data * lhs, const bionic_data * rhs ) {
        return lhs->id.str() < rhs->id.str();
    } );
    const std::size_t offset = std::min(
                                   options.offset,
                                   definitions.size() );
    const std::size_t returned = std::min(
                                     definitions.size() - offset,
                                     static_cast<std::size_t>( options.limit ) );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_definition(
                               state, *definitions[offset + index] );
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
    require_id_kind(
        requested_id, "bionic", "game.bionics.definition" );
    sol::state_view state( lua );
    return snapshot_definition(
               state, bionic_id( requested_id.value() ).obj() );
}

sol::table snapshot_instance(
    sol::state_view lua, const bionic &installed )
{
    sol::table result = lua.create_table();
    result["uid"] = installed.get_uid();
    result["parent_uid"] = installed.get_parent_uid();
    result["id"] = script_game_id(
                       "bionic", installed.id.str() );
    result["name"] = installed.info().name.translated();
    result["description"] =
        installed.info().description.translated();
    result["invlet"] = std::string( 1, installed.invlet );
    result["powered"] = installed.powered;
    result["active"] = installed.powered &&
                       installed.incapacitated_time <= 0_turns;
    result["activatable"] = installed.info().activated;
    result["included"] = installed.is_included();
    result["show_sprite"] = installed.show_sprite;
    result["auto_shutdown"] = installed.auto_shutdown;
    result["charge_timer"] =
        script_time_duration::from_native(
            installed.charge_timer );
    result["incapacitated_time"] =
        script_time_duration::from_native(
            installed.incapacitated_time );
    result["safe_fuel_threshold"] =
        installed.get_safe_fuel_thresh();
    result["safe_fuel_enabled"] =
        installed.is_safe_fuel_on();
    result["has_weapon"] = installed.has_weapon();
    return result;
}

int instance_limit( const sol::optional<int> &requested )
{
    const int value = requested.value_or(
                          default_instance_limit );
    if( value < 0 ) {
        throw std::invalid_argument(
            "game.bionics.list limit cannot be negative" );
    }
    return std::min( value, maximum_instance_limit );
}

sol::table list_instances(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_limit,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const int limit = instance_limit( requested_limit );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bionic_collection &installed =
        *character->my_bionics;
    const std::size_t returned = std::min(
                                     installed.size(),
                                     static_cast<std::size_t>( limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = snapshot_instance(
                               state, installed[index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = installed.size();
    value["returned"] = returned;
    value["limit"] = limit;
    value["truncated"] = returned < installed.size();
    value["power"] = energy_value(
                         character->get_power_level() );
    value["maximum_power"] = energy_value(
                                 character->get_max_power_level() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

std::optional<bionic *> find_instance(
    Character &character, const std::uint64_t requested_uid )
{
    if( requested_uid == 0 ||
        requested_uid >
        std::numeric_limits<bionic_uid>::max() ) {
        return std::nullopt;
    }
    return character.find_bionic_by_uid(
               static_cast<bionic_uid>( requested_uid ) );
}

sol::table get_instance(
    sol::this_state lua, const game_handle &handle,
    const std::uint64_t uid,
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
    const std::optional<bionic *> installed =
        find_instance( *character, uid );
    if( !installed ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The character does not have a bionic with that uid"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_instance( state, **installed ) ) );
}

sol::table has_instance(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "bionic", "game.bionics.has" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, character->has_bionic(
                       bionic_id( requested_id.value() ) ) ) );
}

sol::table install_instance(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_id, "bionic", "game.bionics.install" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( character->num_bionics() >= maximum_instance_limit ) {
        return make_game_error_result(
        state, {
            "limit_reached",
            "The character has reached the script bionic limit"
        } );
    }
    const bionic_id id( requested_id.value() );
    if( character->has_bionic( id ) &&
        !id->dupes_allowed ) {
        return make_game_error_result(
        state, {
            "duplicate",
            "The bionic does not allow duplicate installations"
        } );
    }
    const bionic_uid uid =
        character->add_bionic( id, 0, true );
    const std::optional<bionic *> installed =
        character->find_bionic_by_uid( uid );
    if( uid == 0 || !installed ) {
        return make_game_error_result(
        state, {
            "rejected",
            "The character rejected the bionic installation"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_instance( state, **installed ) ) );
}

sol::table remove_instance(
    sol::this_state lua, const game_handle &handle,
    const std::uint64_t uid,
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
    const std::optional<bionic *> installed =
        find_instance( *character, uid );
    if( !installed ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The character does not have a bionic with that uid"
        } );
    }
    if( ( *installed )->is_included() ) {
        return make_game_error_result(
        state, {
            "included_bionic",
            "Included bionics cannot be removed directly; remove their parent bionic instead"
        } );
    }
    sol::table removed = snapshot_instance(
                             state, **installed );
    character->remove_bionic( **installed );
    sol::table value = state.create_table();
    value["removed"] = std::move( removed );
    value["remaining"] = character->num_bionics();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_power(
    sol::this_state lua, const game_handle &handle,
    const script_unit_value &requested_power,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const units::energy power = native_energy(
                                    requested_power,
                                    "game.bionics.set_power" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const units::energy before =
        character->get_power_level();
    character->set_power_level( power );
    sol::table value = state.create_table();
    value["before"] = energy_value( before );
    value["after"] = energy_value(
                         character->get_power_level() );
    value["maximum"] = energy_value(
                           character->get_max_power_level() );
    value["clamped"] =
        character->get_power_level() != power;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_activation(
    sol::this_state lua, const game_handle &handle,
    const std::uint64_t uid, const bool active,
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
    const std::optional<bionic *> installed =
        find_instance( *character, uid );
    if( !installed ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The character does not have a bionic with that uid"
        } );
    }
    if( active && !( **installed ).info().activated ) {
        return make_game_error_result(
        state, {
            "not_activatable",
            "The requested bionic is passive"
        } );
    }
    if( active &&
        ( **installed ).info().activate_remove_cbm ) {
        return make_game_error_result(
        state, {
            "unsafe_activation",
            "Self-removing bionics cannot be activated through Lua"
        } );
    }
    sol::table before = snapshot_instance(
                            state, **installed );
    const units::energy power_before =
        character->get_power_level();
    const bool accepted = active ?
                          character->activate_bionic( **installed ) :
                          character->deactivate_bionic( **installed );
    const std::optional<bionic *> after_instance =
        character->find_bionic_by_uid(
            static_cast<bionic_uid>( uid ) );

    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["before"] = std::move( before );
    if( after_instance ) {
        value["after"] = snapshot_instance(
                             state, **after_instance );
    } else {
        value["after"] = sol::nil;
    }
    value["power_before"] = energy_value( power_before );
    value["power_after"] = energy_value(
                               character->get_power_level() );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct configuration {
    std::optional<bool> auto_shutdown;
    std::optional<bool> show_sprite;
    std::optional<float> safe_fuel_threshold;
};

configuration read_configuration( const sol::table &requested )
{
    configuration result;
    for( const auto &entry : requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.bionics.configure option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "auto_shutdown" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "game.bionics.configure auto_shutdown must be a boolean" );
            }
            result.auto_shutdown = value.as<bool>();
        } else if( key == "show_sprite" ) {
            if( !value.is<bool>() ) {
                throw std::invalid_argument(
                    "game.bionics.configure show_sprite must be a boolean" );
            }
            result.show_sprite = value.as<bool>();
        } else if( key == "safe_fuel_threshold" ) {
            if( !value.is<double>() ) {
                throw std::invalid_argument(
                    "game.bionics.configure safe_fuel_threshold must be a number" );
            }
            const double threshold = value.as<double>();
            if( !std::isfinite( threshold ) ||
                threshold < -1.0 || threshold > 1.0 ) {
                throw std::invalid_argument(
                    "game.bionics.configure safe_fuel_threshold is outside [-1, 1]" );
            }
            result.safe_fuel_threshold =
                static_cast<float>( threshold );
        } else {
            throw std::invalid_argument(
                "game.bionics.configure received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table configure_instance(
    sol::this_state lua, const game_handle &handle,
    const std::uint64_t uid, const sol::table &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const configuration options =
        read_configuration( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<bionic *> installed =
        find_instance( *character, uid );
    if( !installed ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The character does not have a bionic with that uid"
        } );
    }
    sol::table before = snapshot_instance(
                            state, **installed );
    if( options.auto_shutdown ) {
        ( **installed ).auto_shutdown =
            *options.auto_shutdown;
    }
    if( options.show_sprite ) {
        ( **installed ).show_sprite =
            *options.show_sprite;
    }
    if( options.safe_fuel_threshold ) {
        ( **installed ).set_safe_fuel_thresh(
            *options.safe_fuel_threshold );
    }
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_instance(
                         state, **installed );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_bionic_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table bionics = lua.create_table();
    bionics.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    bionics.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    bionics.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<int> &limit ) {
        require_read();
        return list_instances(
                   lua_state, handle, limit,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const std::uint64_t uid ) {
        require_read();
        return get_instance(
                   lua_state, handle, uid,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "has",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return has_instance(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "install",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_write();
        return install_instance(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "remove",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::uint64_t uid ) {
        require_write();
        return remove_instance(
                   lua_state, handle, uid,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "set_power",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_unit_value & power ) {
        require_write();
        return set_power(
                   lua_state, handle, power,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "activate",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::uint64_t uid ) {
        require_write();
        return set_activation(
                   lua_state, handle, uid, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "deactivate",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::uint64_t uid ) {
        require_write();
        return set_activation(
                   lua_state, handle, uid, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    bionics.set_function(
        "configure",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const std::uint64_t uid,
    const sol::table & options ) {
        require_write();
        return configure_instance(
                   lua_state, handle, uid, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["bionics"] = std::move( bionics );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
