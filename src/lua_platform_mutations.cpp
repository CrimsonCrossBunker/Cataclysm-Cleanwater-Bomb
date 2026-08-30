#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_mutations.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <map>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "character.h"
#include "creature.h"
#include "event.h"
#include "event_bus.h"
#include "mutation.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr std::size_t maximum_definition_offset = 1000000;
constexpr std::size_t maximum_relation_values = 128;
constexpr int default_state_limit = 128;
constexpr int maximum_state_limit = 256;
constexpr int maximum_random_mutation_chance = 1000000;

void require_mutation_id(
    const script_game_id &id, const std::string &api_name )
{
    if( id.kind() != "mutation" ) {
        throw std::invalid_argument(
            api_name + " requires GameId<mutation>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<mutation>" );
    }
}

mutation_category_id resolve_mutation_category(
    const sol::optional<script_game_id> &requested,
    const std::string &api_name )
{
    // The native mutation API uses the private ANY sentinel for an omitted
    // category.  Lua represents that sentinel as nil (and accepts the
    // explicit string ID only for migration ergonomics).
    if( !requested || requested->is_null() ) {
        return mutation_category_id( "ANY" );
    }
    if( requested->kind() != "mutation_category" ) {
        throw std::invalid_argument(
            api_name + " requires GameId<mutation_category> or nil" );
    }
    if( requested->value() == "ANY" ) {
        return mutation_category_id( "ANY" );
    }
    if( !requested->is_valid() ) {
        throw std::invalid_argument(
            api_name + " requires a valid GameId<mutation_category>" );
    }
    return mutation_category_id( requested->value() );
}

std::vector<trait_and_var> mutation_state( const Character &character )
{
    std::vector<trait_and_var> result = character.get_mutations_variants(
                                            true, false );
    std::sort(
        result.begin(), result.end(),
    []( const trait_and_var & lhs, const trait_and_var & rhs ) {
        if( lhs.trait.str() != rhs.trait.str() ) {
            return lhs.trait.str() < rhs.trait.str();
        }
        return lhs.variant < rhs.variant;
    } );
    return result;
}

sol::table mutation_operation_result(
    sol::state_view lua, const std::vector<trait_and_var> &before,
    const std::vector<trait_and_var> &after,
    const std::optional<bool> &accepted = std::nullopt )
{
    sol::table value = lua.create_table();
    value["changed"] = before != after;
    value["before_count"] = before.size();
    value["after_count"] = after.size();
    if( accepted ) {
        value["accepted"] = *accepted;
    }
    return value;
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
        items[index + 1] = script_game_id( kind, id.str() );
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
sol::table string_page( sol::state_view lua, const Range &values )
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

template<typename Range>
sol::table string_id_page( sol::state_view lua, const Range &ids )
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

sol::table variant_page(
    sol::state_view lua,
    const std::map<std::string, mutation_variant> &variants )
{
    const std::size_t total = variants.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &entry : variants ) {
        if( index >= returned ) {
            break;
        }
        const mutation_variant &variant = entry.second;
        sol::table item = lua.create_table();
        item["id"] = variant.id;
        item["name"] = variant.alt_name.translated();
        item["description"] =
            variant.alt_description.translated();
        item["append_description"] = variant.append_desc;
        item["weight"] = variant.weight;
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

sol::table learned_spell_page(
    sol::state_view lua,
    const std::map<spell_id, int> &spells )
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
                         "spell", entry.first.str() );
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

sol::table quality_page(
    sol::state_view lua,
    const std::map<quality_id, int> &qualities )
{
    const std::size_t total = qualities.size();
    const std::size_t returned = std::min(
                                     total, maximum_relation_values );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &entry : qualities ) {
        if( index >= returned ) {
            break;
        }
        sol::table item = lua.create_table();
        item["id"] = script_game_id(
                         "quality", entry.first.str() );
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

sol::table snapshot_definition(
    sol::state_view lua, const mutation_branch &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "mutation", definition.id.str() );
    result["name"] = definition.name();
    result["description"] = definition.desc();

    sol::table availability = lua.create_table();
    availability["valid"] = definition.valid;
    availability["purifiable"] = definition.purifiable;
    availability["threshold"] = definition.threshold;
    availability["strict_threshold_requirement"] =
        definition.strict_threshreq;
    availability["profession"] = definition.profession;
    availability["debug"] = definition.debug;
    availability["player_display"] = definition.player_display;
    availability["vanity"] = definition.vanity;
    availability["dummy"] = definition.dummy;
    availability["mixed_effect"] = definition.mixed_effect;
    availability["starting_trait"] = definition.startingtrait;
    availability["chargen_allows_npc"] =
        definition.chargen_allow_npc;
    availability["random_start_allowed"] =
        definition.random_start_allowed;
    result["availability"] = std::move( availability );

    sol::table activation = lua.create_table();
    activation["activated"] = definition.activated;
    activation["starts_active"] = definition.starts_active;
    activation["cost"] = definition.cost;
    activation["cooldown"] =
        script_time_duration::from_native(
            definition.cooldown );
    activation["uses_sleepiness"] = definition.sleepiness;
    activation["uses_hunger"] = definition.hunger;
    activation["uses_thirst"] = definition.thirst;
    activation["uses_mana"] = definition.mana;
    activation["uses_stamina"] = definition.stamina;
    result["activation"] = std::move( activation );

    sol::table statistics = lua.create_table();
    statistics["points"] = definition.points;
    statistics["vitamin_cost"] = definition.vitamin_cost;
    statistics["visibility"] = definition.visibility;
    statistics["ugliness"] = definition.ugliness;
    statistics["body_temperature_minimum_celsius_delta"] =
        units::to_celsius_delta( definition.bodytemp_min );
    statistics["body_temperature_maximum_celsius_delta"] =
        units::to_celsius_delta( definition.bodytemp_max );
    if( definition.scent_intensity ) {
        statistics["scent_intensity"] =
            *definition.scent_intensity;
    } else {
        statistics["scent_intensity"] = sol::nil;
    }
    result["statistics"] = std::move( statistics );

    sol::table equipment = lua.create_table();
    equipment["destroys_gear"] = definition.destroys_gear;
    equipment["allows_soft_gear"] =
        definition.allow_soft_gear;
    equipment["restricted_body_parts"] = typed_id_page(
            lua, definition.restricts_gear, "body_part" );
    equipment["integrated_armor"] = typed_id_page(
                                        lua,
                                        definition.integrated_armor,
                                        "item" );
    equipment["provided_qualities"] = quality_page(
                                          lua,
                                          definition.provided_qualities );
    result["equipment"] = std::move( equipment );

    set_optional_id(
        result, "spawn_item", definition.spawn_item, "item" );
    set_optional_id(
        result, "ranged_mutation_item",
        definition.ranged_mutation, "item" );

    sol::table relations = lua.create_table();
    relations["prerequisites"] = typed_id_page(
                                     lua, definition.prereqs,
                                     "mutation" );
    relations["other_prerequisites"] = typed_id_page(
                                           lua, definition.prereqs2,
                                           "mutation" );
    relations["threshold_requirements"] = typed_id_page(
            lua, definition.threshreq, "mutation" );
    relations["threshold_substitutes"] = typed_id_page(
            lua, definition.threshold_substitutes, "mutation" );
    relations["conflicts_with"] = typed_id_page(
                                      lua, definition.cancels,
                                      "mutation" );
    relations["replaced_by"] = typed_id_page(
                                   lua, definition.replacements,
                                   "mutation" );
    relations["addition_mutations"] = typed_id_page(
                                          lua, definition.additions, "mutation" );
    relations["categories"] = typed_id_page(
                                  lua, definition.category,
                                  "mutation_category" );
    relations["types"] = string_page( lua, definition.types );
    relations["flags"] = typed_id_page(
                             lua, definition.flags,
                             "trait_flag" );
    relations["active_flags"] = typed_id_page(
                                    lua, definition.active_flags,
                                    "trait_flag" );
    relations["inactive_flags"] = typed_id_page(
                                      lua, definition.inactive_flags,
                                      "trait_flag" );
    result["relations"] = std::move( relations );

    result["variants"] = variant_page(
                             lua, definition.variants );
    result["learned_spells"] = learned_spell_page(
                                   lua, definition.spells_learned );
    result["enchantments"] = string_id_page(
                                 lua, definition.enchantments );
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
                "services.mutations.definitions option keys must be strings" );
        }
        const sol::object value = entry.second;
        if( !value.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "services.mutations.definitions options must be integers" );
        }
        const lua_Integer number = value.as<lua_Integer>();
        if( number < 0 ) {
            throw std::invalid_argument(
                "services.mutations.definitions options cannot be negative" );
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
                                   number,
                                   maximum_definition_limit ) );
        } else {
            throw std::invalid_argument(
                "services.mutations.definitions received unknown option '" +
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
    std::vector<const mutation_branch *> definitions;
    const std::vector<mutation_branch> &all =
        mutation_branch::get_all();
    definitions.reserve( all.size() );
    for( const mutation_branch &definition : all ) {
        definitions.push_back( &definition );
    }
    std::sort(
        definitions.begin(), definitions.end(),
        []( const mutation_branch * lhs,
    const mutation_branch * rhs ) {
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
    require_mutation_id(
        requested_id, "services.mutations.definition" );
    sol::state_view state( lua );
    return snapshot_definition(
               state, trait_id( requested_id.value() ).obj() );
}

struct state_options {
    std::size_t offset = 0;
    int limit = default_state_limit;
    bool include_hidden = true;
    bool include_enchantment = true;
};

state_options read_state_options(
    const sol::optional<sol::table> &requested )
{
    state_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "services.mutations.list option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "offset" || key == "limit" ) {
            if( !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.mutations.list pagination options must be integers" );
            }
            const lua_Integer number = value.as<lua_Integer>();
            if( number < 0 ) {
                throw std::invalid_argument(
                    "services.mutations.list pagination options cannot be negative" );
            }
            if( key == "offset" ) {
                result.offset = static_cast<std::size_t>(
                                    std::min<lua_Integer>(
                                        number,
                                        maximum_definition_offset ) );
            } else {
                result.limit = static_cast<int>(
                                   std::min<lua_Integer>(
                                       number,
                                       maximum_state_limit ) );
            }
        } else if( key == "include_hidden" ||
                   key == "include_enchantment" ) {
            if( value.get_type() != sol::type::boolean ) {
                throw std::invalid_argument(
                    "services.mutations.list filter options must be booleans" );
            }
            if( key == "include_hidden" ) {
                result.include_hidden = value.as<bool>();
            } else {
                result.include_enchantment = value.as<bool>();
            }
        } else {
            throw std::invalid_argument(
                "services.mutations.list received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

std::string mutation_variant_id(
    const Character &character, const trait_id &id,
    const bool include_enchantment )
{
    const std::vector<trait_and_var> mutations =
        character.get_mutations_variants(
            true, !include_enchantment );
    const auto found = std::find_if(
                           mutations.begin(), mutations.end(),
    [&id]( const trait_and_var & entry ) {
        return entry.trait == id;
    } );
    return found == mutations.end() ?
           std::string() : found->variant;
}

sol::table snapshot_state(
    sol::state_view lua, const Character &character,
    const trait_id &id, const std::string &variant )
{
    const mutation_branch &definition = id.obj();
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "mutation", id.str() );
    result["name"] = definition.name( variant );
    result["description"] =
        character.mutation_desc( id );
    result["functioning"] = character.has_trait( id );
    result["permanent"] =
        character.has_permanent_trait( id );
    result["base_trait"] = character.has_base_trait( id );
    result["activatable"] = definition.activated;
    result["active"] =
        character.has_active_mutation( id );
    result["can_activate"] =
        definition.activated &&
        character.can_power_mutation( id );
    result["cost_timer"] =
        script_time_duration::from_native(
            character.get_cost_timer( id ) );
    if( variant.empty() ) {
        result["variant"] = sol::nil;
    } else {
        result["variant"] = variant;
    }
    return result;
}

sol::table list_states(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const state_options options =
        read_state_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::vector<trait_and_var> mutations =
        character->get_mutations_variants(
            options.include_hidden,
            !options.include_enchantment );
    std::sort(
        mutations.begin(), mutations.end(),
        []( const trait_and_var & lhs,
    const trait_and_var & rhs ) {
        return lhs.trait.str() < rhs.trait.str();
    } );
    const std::size_t offset = std::min(
                                   options.offset,
                                   mutations.size() );
    const std::size_t returned = std::min(
                                     mutations.size() - offset,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const trait_and_var &entry =
            mutations[offset + index];
        items[index + 1] = snapshot_state(
                               state, *character,
                               entry.trait, entry.variant );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = mutations.size();
    value["offset"] = offset;
    value["limit"] = options.limit;
    value["returned"] = returned;
    value["has_more"] =
        offset + returned < mutations.size();
    value["include_hidden"] = options.include_hidden;
    value["include_enchantment"] =
        options.include_enchantment;
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table has_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.has" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const bool present = character->has_trait(
                             trait_id( requested_id.value() ) );
    return make_game_value_result(
               state, sol::make_object( state, present ) );
}

mut_count_type mutation_count_type(
    const sol::optional<std::string> &requested,
    const std::string &api_name )
{
    const std::string value = requested.value_or( "ALL" );
    if( value == "POSITIVE" ) {
        return mut_count_type::POSITIVE;
    }
    if( value == "NEGATIVE" ) {
        return mut_count_type::NEGATIVE;
    }
    if( value == "ALL" ) {
        return mut_count_type::ALL;
    }
    throw std::invalid_argument(
        api_name + " type must be POSITIVE, NEGATIVE, or ALL" );
}

sol::table category_count(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_category,
    const sol::optional<std::string> &requested_type,
    const sol::optional<bool> &requested_permanent_only,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_category.kind() != "mutation_category" ||
        !requested_category.is_valid() ) {
        throw std::invalid_argument(
            "services.mutations.category_count requires a valid GameId<mutation_category>" );
    }
    const mut_count_type count_type = mutation_count_type(
                                          requested_type,
                                          "services.mutations.category_count" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const mutation_category_id category(
        requested_category.value() );
    const bool permanent_only =
        requested_permanent_only.value_or( false );
    const int count = permanent_only ?
                      character->get_total_in_category_char_has(
                          category, count_type ) :
                      character->get_total_in_category(
                          category, count_type );
    return make_game_value_result(
               state, sol::make_object( state, count ) );
}

sol::table is_visible_to(
    sol::this_state lua, const game_handle &observed_handle,
    const game_handle &observer_handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.is_visible_to" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *observed = resolve_exact_character(
                              observed_handle, runtime_generation,
                              world_generation, error );
    if( observed == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *observer = resolve_exact_character(
                              observer_handle, runtime_generation,
                              world_generation, error );
    if( observer == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    const mutation_branch &definition = id.obj();
    const int visibility_cap =
        observer->get_mutation_visibility_cap( observed );
    const bool visible = observed->has_trait( id ) &&
                         definition.visibility > 0 &&
                         definition.visibility >= visibility_cap;
    return make_game_value_result(
               state, sol::make_object( state, visible ) );
}

sol::table is_purifiable(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.is_purifiable" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, character->purifiable(
                       trait_id( requested_id.value() ) ) ) );
}

sol::table set_purifiable(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const bool purifiable,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.set_purifiable" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    const bool before = character->purifiable( id );
    if( character->has_trait( id ) ) {
        if( purifiable ) {
            character->my_intrinsic_mutations.erase( id );
        } else {
            character->my_intrinsic_mutations.insert( id );
        }
    }
    const bool after = character->purifiable( id );
    sol::table value = state.create_table();
    value["present"] = character->has_trait( id );
    value["before"] = before;
    value["after"] = after;
    value["changed"] = before != after;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_category(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_category,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested_category.kind() != "mutation_category" ||
        !requested_category.is_valid() ) {
        throw std::invalid_argument(
            "services.mutations.remove_category requires a valid "
            "GameId<mutation_category>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const mutation_category_id category(
        requested_category.value() );
    std::vector<trait_id> to_remove;
    for( const trait_id &id : character->get_mutations() ) {
        const std::vector<mutation_category_id> &categories =
            id.obj().category;
        if( std::find(
                categories.begin(), categories.end(), category ) !=
            categories.end() ) {
            to_remove.push_back( id );
        }
    }
    sol::table removed = state.create_table(
                             static_cast<int>( to_remove.size() ), 0 );
    for( std::size_t index = 0; index < to_remove.size(); ++index ) {
        removed[index + 1] = script_game_id(
                                 "mutation", to_remove[index].str() );
        character->unset_mutation( to_remove[index] );
    }
    sol::table value = state.create_table();
    value["category"] = requested_category;
    value["removed"] = std::move( removed );
    value["removed_count"] = to_remove.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table get_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.get" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    if( !character->has_trait( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_found",
            "The character does not have a functioning mutation '" +
            id.str() + "'"
        } );
    }
    const std::string variant = mutation_variant_id(
                                    *character, id, true );
    sol::table value = snapshot_state(
                           state, *character, id, variant );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table mutate_state(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<double> &requested_chance,
    const sol::optional<bool> &requested_use_vitamins,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const double raw_chance = requested_chance.value_or( 0.0 );
    if( !std::isfinite( raw_chance ) ||
        std::trunc( raw_chance ) != raw_chance ||
        raw_chance < 0 || raw_chance > maximum_random_mutation_chance ) {
        throw std::invalid_argument(
            "services.mutations.mutate true_random_chance must be within 0..1000000" );
    }
    const int chance = static_cast<int>( raw_chance );
    const bool use_vitamins = requested_use_vitamins.value_or( true );
    const std::vector<trait_and_var> before = mutation_state( *character );
    character->mutate( chance, use_vitamins );
    const std::vector<trait_and_var> after = mutation_state( *character );
    return make_game_value_result(
               state,
               sol::make_object( state,
                                 mutation_operation_result( state, before, after ) ) );
}

sol::table mutate_category_state(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<script_game_id> &requested_category,
    const sol::optional<bool> &requested_use_vitamins,
    const sol::optional<bool> &requested_true_random,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const mutation_category_id category = resolve_mutation_category(
            requested_category,
            "services.mutations.mutate_category" );
    const bool use_vitamins = requested_use_vitamins.value_or( true );
    const bool true_random = requested_true_random.value_or( false );
    const std::vector<trait_and_var> before = mutation_state( *character );
    character->mutate_category( category, use_vitamins, true_random );
    const std::vector<trait_and_var> after = mutation_state( *character );
    return make_game_value_result(
               state,
               sol::make_object( state,
                                 mutation_operation_result( state, before, after ) ) );
}

sol::table mutate_towards_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_mutation,
    const sol::optional<script_game_id> &requested_category,
    const sol::optional<bool> &requested_use_vitamins,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_mutation, "services.mutations.mutate_towards" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const mutation_category_id category = resolve_mutation_category(
            requested_category,
            "services.mutations.mutate_towards" );
    const bool use_vitamins = requested_use_vitamins.value_or( true );
    const std::vector<trait_and_var> before = mutation_state( *character );
    const bool accepted = character->mutate_towards(
                              trait_id( requested_mutation.value() ),
                              category, nullptr, use_vitamins );
    const std::vector<trait_and_var> after = mutation_state( *character );
    return make_game_value_result(
               state,
               sol::make_object( state,
                                 mutation_operation_result(
                                     state, before, after, accepted ) ) );
}

const mutation_variant *requested_variant(
    const mutation_branch &definition,
    const sol::optional<std::string> &requested,
    const std::string &api_name )
{
    if( definition.variants.empty() ) {
        if( requested ) {
            throw std::invalid_argument(
                api_name + " received a variant for a mutation without variants" );
        }
        return nullptr;
    }
    if( !requested || requested->empty() ) {
        throw std::invalid_argument(
            api_name + " requires an explicit variant for deterministic mutation changes" );
    }
    const mutation_variant *variant =
        definition.variant( *requested );
    if( variant == nullptr ) {
        throw std::invalid_argument(
            api_name + " received an unknown mutation variant '" +
            *requested + "'" );
    }
    return variant;
}

sol::table grant_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const sol::optional<std::string> &requested_variant_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.grant" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    if( character->has_trait( id ) ||
        character->has_permanent_trait( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "already_present",
            "The character already has mutation '" +
            id.str() + "'"
        } );
    }
    const mutation_variant *variant = requested_variant(
                                          id.obj(), requested_variant_id,
                                          "services.mutations.grant" );
    character->set_mutation( id, variant );
    if( !character->has_permanent_trait( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "rejected",
            "The engine rejected mutation '" + id.str() + "'"
        } );
    }
    get_event_bus().send<event_type::gains_mutation>(
        character->getID(), id );
    const std::string variant_id =
        variant == nullptr ? std::string() : variant->id;
    sol::table value = snapshot_state(
                           state, *character, id, variant_id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table remove_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.remove" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    if( !character->has_permanent_trait( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_permanent",
            "The character does not own permanent mutation '" +
            id.str() + "'"
        } );
    }
    const std::string variant =
        mutation_variant_id( *character, id, false );
    sol::table before = snapshot_state(
                            state, *character, id, variant );
    if( character->has_base_trait( id ) ) {
        character->toggle_trait( id, variant );
    } else {
        get_event_bus().send<event_type::loses_mutation>(
            character->getID(), id );
        character->unset_mutation( id );
    }
    sol::table value = state.create_table();
    value["removed"] = std::move( before );
    value["present"] =
        character->has_permanent_trait( id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_active_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id, const bool desired,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.set_active" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    if( !character->has_permanent_trait( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_permanent",
            "Only permanent character mutations can be activated"
        } );
    }
    if( !id->activated ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_activatable",
            "Mutation '" + id.str() + "' is not activatable"
        } );
    }
    const std::string variant =
        mutation_variant_id( *character, id, false );
    sol::table before = snapshot_state(
                            state, *character, id, variant );
    if( desired ) {
        if( !character->has_active_mutation( id ) ) {
            character->activate_mutation( id );
        }
    } else if( character->has_active_mutation( id ) ) {
        character->deactivate_mutation( id );
    }
    const bool present =
        character->has_permanent_trait( id );
    const bool active = present &&
                        character->has_active_mutation( id );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["requested"] = desired;
    value["accepted"] = active == desired;
    value["present"] = present;
    if( present ) {
        value["after"] = snapshot_state(
                             state, *character, id,
                             mutation_variant_id(
                                 *character, id, false ) );
    } else {
        value["after"] = sol::nil;
    }
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

sol::table set_variant_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::string &requested_variant_id,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_mutation_id(
        requested_id, "services.mutations.set_variant" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const trait_id id( requested_id.value() );
    if( !character->has_permanent_trait( id ) ) {
        return make_game_error_result(
        state, game_handle_error{
            "not_permanent",
            "Only permanent character mutations can change variants"
        } );
    }
    const mutation_variant *variant = requested_variant(
                                          id.obj(),
                                          sol::optional<std::string>(
                                                  requested_variant_id ),
                                          "services.mutations.set_variant" );
    const std::string before_id =
        mutation_variant_id( *character, id, false );
    sol::table before = snapshot_state(
                            state, *character, id, before_id );
    character->set_mut_variant( id, variant );
    sol::table value = state.create_table();
    value["before"] = std::move( before );
    value["after"] = snapshot_state(
                         state, *character, id, variant->id );
    return make_game_value_result(
               state,
               sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_mutation_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    sol::table mutations = lua.create_table();
    mutations.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    mutations.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    mutations.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_states(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "has",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return has_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "category_count",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & category,
            const sol::optional<std::string> &type,
    const sol::optional<bool> &permanent_only ) {
        require_read();
        return category_count(
                   lua_state, handle, category, type, permanent_only,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "is_visible_to",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle & observed,
            const game_handle & observer,
    const script_game_id & id ) {
        require_read();
        return is_visible_to(
                   lua_state, observed, observer, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "is_purifiable",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return is_purifiable(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "get",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_read();
        return get_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "mutate",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const sol::optional<double> &chance,
    const sol::optional<bool> &use_vitamins ) {
        require_write();
        return mutate_state(
                   lua_state, handle, chance, use_vitamins,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "mutate_category",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const sol::optional<script_game_id> &category,
            const sol::optional<bool> &use_vitamins,
    const sol::optional<bool> &true_random ) {
        require_write();
        return mutate_category_state(
                   lua_state, handle, category, use_vitamins, true_random,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "mutate_towards",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
            const sol::optional<script_game_id> &category,
    const sol::optional<bool> &use_vitamins ) {
        require_write();
        return mutate_towards_state(
                   lua_state, handle, id, category, use_vitamins,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "grant",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const sol::optional<std::string> &variant ) {
        require_write();
        return grant_state(
                   lua_state, handle, id, variant,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "remove",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_write();
        return remove_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "set_purifiable",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const bool purifiable ) {
        require_write();
        return set_purifiable(
                   lua_state, handle, id, purifiable,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "remove_category",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & category ) {
        require_write();
        return remove_category(
                   lua_state, handle, category,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "set_active",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id, const bool active ) {
        require_write();
        return set_active_state(
                   lua_state, handle, id, active,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    mutations.set_function(
        "set_variant",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & id,
    const std::string & variant ) {
        require_write();
        return set_variant_state(
                   lua_state, handle, id, variant,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["mutations"] = std::move( mutations );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
