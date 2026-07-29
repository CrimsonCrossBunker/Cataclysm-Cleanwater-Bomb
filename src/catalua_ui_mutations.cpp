#include "catalua_ui_mutations.h"

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

#include "catalua_bindings_values.h"
#include "mutation.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr std::size_t maximum_definition_offset = 1000000;
constexpr std::size_t maximum_relation_values = 128;

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
                "game.mutations.definitions option keys must be strings" );
        }
        const sol::object value = entry.second;
        if( !value.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "game.mutations.definitions options must be integers" );
        }
        const lua_Integer number = value.as<lua_Integer>();
        if( number < 0 ) {
            throw std::invalid_argument(
                "game.mutations.definitions options cannot be negative" );
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
                "game.mutations.definitions received unknown option '" +
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
        requested_id, "game.mutations.definition" );
    sol::state_view state( lua );
    return snapshot_definition(
               state, trait_id( requested_id.value() ).obj() );
}

} // namespace

void install_mutation_api(
    sol::table &game,
    std::function<void()> require_read )
{
    sol::state_view lua( game.lua_state() );
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
    game["mutations"] = std::move( mutations );
}

} // namespace cata::lua_ui
