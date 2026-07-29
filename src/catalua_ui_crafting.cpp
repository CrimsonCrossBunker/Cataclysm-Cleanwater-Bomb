#include "catalua_ui_crafting.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <iterator>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

#include "avatar.h"
#include "catalua_bindings_values.h"
#include "catalua_ui_actions_internal.h"
#include "inventory.h"
#include "item.h"
#include "itype.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "requirements.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_recipe_limit = 64;
constexpr int maximum_recipe_limit = 256;
constexpr std::size_t maximum_recipe_offset = 1000000;
constexpr int maximum_recipe_batch = 1000;
constexpr std::size_t maximum_recipe_relations = 128;
constexpr std::size_t maximum_filter_bytes = 128;
constexpr int default_requirement_limit = 64;
constexpr int maximum_requirement_limit = 256;
constexpr std::size_t maximum_requirement_offset = 1000000;
constexpr std::size_t maximum_requirement_groups = 128;
constexpr std::size_t maximum_requirement_alternatives = 64;
constexpr std::size_t maximum_requirement_text_bytes = 32768;

struct recipe_options {
    std::size_t offset = 0;
    int limit = default_recipe_limit;
    int batch = 1;
    bool include_obsolete = false;
    std::optional<bool> known;
    std::optional<bool> craftable;
    std::optional<script_game_id> skill;
    std::optional<script_game_id> result;
    std::optional<std::string> flag;
};

void require_id(
    const script_game_id &id, const std::string &kind,
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

int require_integer(
    const sol::object &value, const std::string &api_name,
    const std::string &key )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' must be an integer" );
    }
    const lua_Integer number = value.as<lua_Integer>();
    if( number < 0 ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' cannot be negative" );
    }
    return static_cast<int>(
               std::min<lua_Integer>(
                   number, std::numeric_limits<int>::max() ) );
}

bool require_boolean(
    const sol::object &value, const std::string &api_name,
    const std::string &key )
{
    if( value.get_type() != sol::type::boolean ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' must be a boolean" );
    }
    return value.as<bool>();
}

std::string require_bounded_string(
    const sol::object &value, const std::string &api_name,
    const std::string &key )
{
    if( value.get_type() != sol::type::string ) {
        throw std::invalid_argument(
            api_name + " option '" + key + "' must be a string" );
    }
    const std::string result = value.as<std::string>();
    if( result.empty() || result.size() > maximum_filter_bytes ||
        result.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' must contain 1 to 128 non-NUL bytes" );
    }
    return result;
}

script_game_id require_typed_option(
    const sol::object &value, const std::string &kind,
    const std::string &api_name, const std::string &key )
{
    if( !value.is<script_game_id>() ) {
        throw std::invalid_argument(
            api_name + " option '" + key +
            "' requires GameId<" + kind + ">" );
    }
    const script_game_id result = value.as<script_game_id>();
    require_id( result, kind, api_name + " option '" + key + "'" );
    return result;
}

recipe_options read_recipe_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    recipe_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    require_integer( value, api_name, key ),
                                    static_cast<int>(
                                        maximum_recipe_offset ) ) );
        } else if( key == "limit" ) {
            result.limit = std::min(
                               require_integer( value, api_name, key ),
                               maximum_recipe_limit );
        } else if( key == "batch" ) {
            result.batch = require_integer( value, api_name, key );
            if( result.batch < 1 || result.batch > maximum_recipe_batch ) {
                throw std::invalid_argument(
                    api_name + " option 'batch' must be within 1..1000" );
            }
        } else if( key == "include_obsolete" ) {
            result.include_obsolete =
                require_boolean( value, api_name, key );
        } else if( key == "known" ) {
            result.known = require_boolean( value, api_name, key );
        } else if( key == "craftable" ) {
            result.craftable =
                require_boolean( value, api_name, key );
        } else if( key == "skill" ) {
            result.skill = require_typed_option(
                               value, "skill", api_name, key );
        } else if( key == "result" ) {
            result.result = require_typed_option(
                                value, "item", api_name, key );
        } else if( key == "flag" ) {
            result.flag = require_bounded_string(
                              value, api_name, key );
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" + key + "'" );
        }
    }
    return result;
}

template<typename Range>
sol::table typed_id_page(
    sol::state_view lua, const Range &values,
    const std::string &kind )
{
    const std::size_t total = values.size();
    const std::size_t returned = std::min(
                                     total, maximum_recipe_relations );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &value : values ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] =
            script_game_id( kind, value.str() );
        ++index;
    }
    sol::table page = lua.create_table();
    page["items"] = std::move( items );
    page["total"] = total;
    page["returned"] = returned;
    page["truncated"] = returned < total;
    return page;
}

sol::table skill_requirements(
    sol::state_view lua, const std::map<skill_id, int> &values )
{
    const std::size_t total = values.size();
    const std::size_t returned = std::min(
                                     total, maximum_recipe_relations );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &[id, level] : values ) {
        if( index >= returned ) {
            break;
        }
        sol::table entry = lua.create_table();
        entry["id"] = script_game_id( "skill", id.str() );
        entry["level"] = level;
        items[index + 1] = std::move( entry );
        ++index;
    }
    sol::table page = lua.create_table();
    page["items"] = std::move( items );
    page["total"] = total;
    page["returned"] = returned;
    page["truncated"] = returned < total;
    return page;
}

sol::table recipe_books(
    sol::state_view lua,
    const std::map<itype_id, book_recipe_data> &values )
{
    const std::size_t total = values.size();
    const std::size_t returned = std::min(
                                     total, maximum_recipe_relations );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const auto &[id, book] : values ) {
        if( index >= returned ) {
            break;
        }
        sol::table entry = lua.create_table();
        entry["id"] = script_game_id( "item", id.str() );
        entry["skill_level"] = book.skill_req;
        entry["hidden"] = book.hidden;
        if( book.alt_name ) {
            entry["name"] = book.alt_name->translated();
        } else {
            entry["name"] = sol::nil;
        }
        items[index + 1] = std::move( entry );
        ++index;
    }
    sol::table page = lua.create_table();
    page["items"] = std::move( items );
    page["total"] = total;
    page["returned"] = returned;
    page["truncated"] = returned < total;
    return page;
}

sol::table recipe_proficiencies(
    sol::state_view lua,
    const std::vector<recipe_proficiency> &values )
{
    const std::size_t total = values.size();
    const std::size_t returned = std::min(
                                     total, maximum_recipe_relations );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const recipe_proficiency &value = values[index];
        sol::table entry = lua.create_table();
        entry["id"] = value.id.str();
        entry["required"] = value.required;
        entry["time_multiplier"] = value.time_multiplier;
        entry["skill_penalty"] = value.skill_penalty;
        entry["learning_time_multiplier"] =
            value.learning_time_mult;
        if( value.max_experience ) {
            entry["maximum_experience"] =
                script_time_duration::from_native(
                    *value.max_experience );
        } else {
            entry["maximum_experience"] = sol::nil;
        }
        items[index + 1] = std::move( entry );
    }
    sol::table page = lua.create_table();
    page["items"] = std::move( items );
    page["total"] = total;
    page["returned"] = returned;
    page["truncated"] = returned < total;
    return page;
}

struct recipe_availability {
    bool known = false;
    bool required_skills = false;
    bool required_proficiencies = false;
    bool materials = false;
    bool start_materials = false;
    bool morale = false;
    bool craftable = false;
    bool startable = false;
};

recipe_availability availability_for(
    avatar &player, const inventory &crafting_inventory,
    const recipe &value, const int batch )
{
    recipe_availability result;
    result.known = player.has_recipe( &value );
    result.required_skills =
        player.has_recipe_requirements( value );
    result.required_proficiencies =
        value.character_has_required_proficiencies( player );
    result.morale = player.has_morale_to_craft();
    const std::function<bool( const item & )> filter =
        value.get_component_filter();
    result.materials =
        value.deduped_requirements().can_make_with_inventory(
            crafting_inventory, filter, batch );
    result.start_materials =
        value.deduped_requirements().can_make_with_inventory(
            crafting_inventory, filter, batch,
            craft_flags::start_only );
    result.craftable =
        result.known && result.required_skills &&
        result.required_proficiencies && result.materials &&
        result.morale;
    result.startable =
        result.known && result.required_skills &&
        result.required_proficiencies &&
        result.start_materials && result.morale;
    return result;
}

sol::table snapshot_recipe(
    sol::state_view lua, avatar &player,
    const recipe &value, const int batch,
    const crafting_cost_context &cost_context,
    const recipe_availability &availability )
{
    sol::table result = lua.create_table();
    result["id"] =
        script_game_id( "recipe", value.ident().str() );
    if( value.result().is_null() ) {
        result["result"] = sol::nil;
    } else {
        result["result"] =
            script_game_id( "item", value.result().str() );
    }
    result["result_name"] = value.result_name();
    result["result_amount"] = value.makes_amount();
    result["category"] = value.category.str();
    result["subcategory"] = value.subcategory;
    result["description"] = value.get_description( player );
    result["difficulty"] = value.get_difficulty( player );
    result["base_difficulty"] = value.difficulty;
    if( value.skill_used.is_null() ) {
        result["primary_skill"] = sol::nil;
    } else {
        result["primary_skill"] =
            script_game_id( "skill", value.skill_used.str() );
    }
    result["time"] =
        script_time_duration::from_native(
            value.batch_duration(
                player, cost_context, batch ) );
    result["batch"] = batch;
    result["reversible"] = value.is_reversible();
    result["practice"] = value.is_practice();
    result["nested"] = value.is_nested();
    result["blueprint"] = value.is_blueprint();
    result["obsolete"] = value.obsolete;
    result["blacklisted"] = value.is_blacklisted();
    result["never_learn"] = value.never_learn;
    result["hot_result"] = value.hot_result();
    result["removes_raw"] = value.removes_raw();
    result["has_steps"] = value.has_steps();
    result["has_attention_steps"] =
        value.has_attention_steps();
    result["required_skills"] =
        skill_requirements( lua, value.required_skills );
    result["learn_by_disassembly"] =
        skill_requirements(
            lua, value.learn_by_disassembly );
    result["books"] = recipe_books( lua, value.booksets );
    result["proficiencies"] =
        recipe_proficiencies(
            lua, value.get_proficiencies() );

    sol::table state = lua.create_table();
    state["known"] = availability.known;
    state["has_required_skills"] =
        availability.required_skills;
    state["has_required_proficiencies"] =
        availability.required_proficiencies;
    state["has_materials"] = availability.materials;
    state["has_start_materials"] =
        availability.start_materials;
    state["has_morale"] = availability.morale;
    state["craftable"] = availability.craftable;
    state["startable"] = availability.startable;
    result["availability"] = std::move( state );
    return result;
}

bool recipe_matches_metadata(
    const recipe &value, const recipe_options &options )
{
    if( !options.include_obsolete && value.obsolete ) {
        return false;
    }
    if( options.skill &&
        value.skill_used.str() != options.skill->value() ) {
        return false;
    }
    if( options.result &&
        value.result().str() != options.result->value() ) {
        return false;
    }
    if( options.flag && !value.has_flag( *options.flag ) ) {
        return false;
    }
    return true;
}

sol::table recipe_page(
    sol::this_state lua, const recipe_options &options )
{
    sol::state_view state( lua );
    avatar &player = get_avatar();
    const inventory &crafting_inventory =
        player.crafting_inventory();
    const crafting_cost_context cost_context =
        crafting_cost_context::for_proficiencies( player );
    sol::table items = state.create_table();
    std::size_t matched = 0;
    std::size_t returned = 0;
    for( const auto &[id, value] : recipe_dict ) {
        static_cast<void>( id );
        if( !recipe_matches_metadata( value, options ) ) {
            continue;
        }
        std::optional<recipe_availability> availability;
        if( options.known || options.craftable ) {
            availability = availability_for(
                               player, crafting_inventory, value,
                               options.batch );
            if( options.known &&
                availability->known != *options.known ) {
                continue;
            }
            if( options.craftable &&
                availability->craftable !=
                *options.craftable ) {
                continue;
            }
        }
        if( matched >= options.offset &&
            returned <
            static_cast<std::size_t>( options.limit ) ) {
            if( !availability ) {
                availability = availability_for(
                                   player, crafting_inventory, value,
                                   options.batch );
            }
            items[returned + 1] = snapshot_recipe(
                                      state, player, value,
                                      options.batch, cost_context,
                                      *availability );
            ++returned;
        }
        ++matched;
    }

    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = matched;
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] =
        options.offset + returned < matched;
    result["batch"] = options.batch;
    return result;
}

sol::table get_recipe(
    sol::this_state lua, const script_game_id &id,
    const int batch )
{
    require_id( id, "recipe", "game.recipes.get" );
    if( batch < 1 || batch > maximum_recipe_batch ) {
        throw std::invalid_argument(
            "game.recipes.get batch must be within 1..1000" );
    }
    const recipe &value = recipe_id( id.value() ).obj();
    avatar &player = get_avatar();
    const inventory &crafting_inventory =
        player.crafting_inventory();
    return snapshot_recipe(
               sol::state_view( lua ), player, value, batch,
               crafting_cost_context::for_recipe(
                   player, value ),
               availability_for(
                   player, crafting_inventory, value,
                   batch ) );
}

sol::table recipe_limits( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["default_limit"] = default_recipe_limit;
    result["maximum_limit"] = maximum_recipe_limit;
    result["maximum_offset"] = maximum_recipe_offset;
    result["maximum_batch"] = maximum_recipe_batch;
    result["maximum_relation_values"] =
        maximum_recipe_relations;
    return result;
}

struct requirement_options {
    std::size_t offset = 0;
    int limit = default_requirement_limit;
    int batch = 1;
};

requirement_options read_requirement_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name )
{
    requirement_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "offset" ) {
            result.offset = static_cast<std::size_t>(
                                std::min(
                                    require_integer(
                                        entry.second,
                                        api_name, key ),
                                    static_cast<int>(
                                        maximum_requirement_offset ) ) );
        } else if( key == "limit" ) {
            result.limit = std::min(
                               require_integer(
                                   entry.second, api_name, key ),
                               maximum_requirement_limit );
        } else if( key == "batch" ) {
            result.batch = require_integer(
                               entry.second, api_name, key );
            if( result.batch < 1 ||
                result.batch > maximum_recipe_batch ) {
                throw std::invalid_argument(
                    api_name +
                    " option 'batch' must be within 1..1000" );
            }
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

std::string bounded_requirement_text( std::string value )
{
    if( value.size() <= maximum_requirement_text_bytes ) {
        return value;
    }
    value.resize( maximum_requirement_text_bytes );
    return value;
}

std::int64_t item_count_for_batch(
    const int count, const int batch )
{
    return static_cast<std::int64_t>( std::abs( count ) ) *
           static_cast<std::int64_t>( batch );
}

std::int64_t tool_count_for_batch(
    const tool_comp &value, const int batch )
{
    if( !value.by_charges() ) {
        return std::abs( value.count );
    }
    return static_cast<std::int64_t>( value.count ) *
           static_cast<std::int64_t>( batch ) *
           static_cast<std::int64_t>(
               item::find_type( value.type )->charge_factor() );
}

template<typename Group>
sol::table requirement_group_page(
    sol::state_view lua, const Group &groups,
    const std::function<sol::table(
        const typename Group::value_type::value_type & )> &snapshot )
{
    const std::size_t total = groups.size();
    const std::size_t returned = std::min(
                                     total, maximum_requirement_groups );
    sol::table group_items = lua.create_table(
                                 static_cast<int>( returned ), 0 );
    for( std::size_t group_index = 0;
         group_index < returned; ++group_index ) {
        const auto &group = groups[group_index];
        const std::size_t alternative_count = group.size();
        const std::size_t alternative_returned = std::min(
                    alternative_count,
                    maximum_requirement_alternatives );
        sol::table alternatives = lua.create_table(
                                      static_cast<int>(
                                          alternative_returned ), 0 );
        bool satisfied = false;
        for( std::size_t alternative_index = 0;
             alternative_index < alternative_returned;
             ++alternative_index ) {
            sol::table entry = snapshot(
                                   group[alternative_index] );
            satisfied =
                satisfied ||
                entry.get_or( "available", false );
            alternatives[alternative_index + 1] =
                std::move( entry );
        }
        sol::table group_result = lua.create_table();
        group_result["items"] = std::move( alternatives );
        group_result["total"] = alternative_count;
        group_result["returned"] = alternative_returned;
        group_result["truncated"] =
            alternative_returned < alternative_count;
        group_result["satisfied"] = satisfied;
        group_items[group_index + 1] =
            std::move( group_result );
    }
    sol::table page = lua.create_table();
    page["items"] = std::move( group_items );
    page["total"] = total;
    page["returned"] = returned;
    page["truncated"] = returned < total;
    return page;
}

sol::table snapshot_requirement(
    sol::state_view lua, const requirement_data &value,
    const int batch,
    const read_only_visitable &crafting_inventory,
    const std::function<bool( const item & )> &filter )
{
    const bool can_make = value.can_make_with_inventory(
                              crafting_inventory, filter, batch );
    sol::table result = lua.create_table();
    result["id"] = value.id().is_null() ?
                   std::string() : value.id().str();
    result["name"] = value.display_name();
    result["null"] = value.is_null();
    result["empty"] = value.is_empty();
    result["blacklisted"] = value.is_blacklisted();
    result["batch"] = batch;
    result["can_make"] = can_make;
    result["all_text"] = bounded_requirement_text(
                             value.list_all() );
    result["missing_text"] = bounded_requirement_text(
                                 value.list_missing() );

    result["tools"] = requirement_group_page <
                      requirement_data::alter_tool_comp_vector > (
                          lua, value.get_tools(),
                          [&lua, &crafting_inventory, &filter, batch](
    const tool_comp & entry ) {
        sol::table item_result = lua.create_table();
        item_result["id"] =
            script_game_id( "item", entry.type.str() );
        item_result["name"] =
            item::nname( entry.type );
        item_result["count"] = entry.count;
        item_result["count_for_batch"] =
            tool_count_for_batch( entry, batch );
        item_result["by_charges"] =
            entry.by_charges();
        item_result["recoverable"] = entry.recoverable;
        item_result["nested_requirement"] =
            entry.requirement;
        item_result["available"] = entry.has(
                                       crafting_inventory,
                                       filter, batch );
        return item_result;
    } );

    result["qualities"] = requirement_group_page <
                          requirement_data::alter_quali_req_vector > (
                              lua, value.get_qualities(),
                              [&lua, &crafting_inventory, &filter](
    const quality_requirement & entry ) {
        sol::table item_result = lua.create_table();
        item_result["id"] =
            script_game_id( "quality", entry.type.str() );
        item_result["name"] =
            entry.type->name.translated();
        item_result["count"] = entry.count;
        item_result["level"] = entry.level;
        item_result["nested_requirement"] =
            entry.requirement;
        item_result["available"] = entry.has(
                                       crafting_inventory,
                                       filter );
        return item_result;
    } );

    result["components"] = requirement_group_page <
                           requirement_data::alter_item_comp_vector > (
                               lua, value.get_components(),
                               [&lua, &crafting_inventory, &filter, batch](
    const item_comp & entry ) {
        sol::table item_result = lua.create_table();
        item_result["id"] =
            script_game_id( "item", entry.type.str() );
        item_result["name"] =
            item::nname( entry.type );
        item_result["count"] = entry.count;
        item_result["count_for_batch"] =
            item_count_for_batch(
                entry.count, batch );
        item_result["by_charges"] =
            item::count_by_charges( entry.type );
        item_result["recoverable"] = entry.recoverable;
        item_result["nested_requirement"] =
            entry.requirement;
        item_result["available"] = entry.has(
                                       crafting_inventory,
                                       filter, batch );
        return item_result;
    } );
    return result;
}

sol::object get_requirement(
    sol::this_state lua, const std::string &id_text,
    const int batch )
{
    if( id_text.empty() || id_text.size() > 256 ||
        id_text.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "game.requirements.get id must contain "
            "1 to 256 non-NUL bytes" );
    }
    if( batch < 1 || batch > maximum_recipe_batch ) {
        throw std::invalid_argument(
            "game.requirements.get batch must be within 1..1000" );
    }
    sol::state_view state( lua );
    const requirement_id id( id_text );
    if( !id.is_valid() ) {
        return sol::make_object( state, sol::nil );
    }
    const inventory &crafting_inventory =
        get_avatar().crafting_inventory();
    const std::function<bool( const item & )> filter =
    []( const item & ) {
        return true;
    };
    return sol::make_object(
               state,
               snapshot_requirement(
                   state, id.obj(), batch,
                   crafting_inventory, filter ) );
}

sol::table requirements_for_recipe(
    sol::this_state lua, const script_game_id &id,
    const int batch )
{
    require_id(
        id, "recipe", "game.requirements.for_recipe" );
    if( batch < 1 || batch > maximum_recipe_batch ) {
        throw std::invalid_argument(
            "game.requirements.for_recipe batch must be "
            "within 1..1000" );
    }
    sol::state_view state( lua );
    const recipe &value = recipe_id( id.value() ).obj();
    avatar &player = get_avatar();
    const inventory &crafting_inventory =
        player.crafting_inventory();
    sol::table result = snapshot_requirement(
                            state, value.simple_requirements(),
                            batch, crafting_inventory,
                            value.get_component_filter() );
    result["recipe"] = id;
    result["deduped_alternative_count"] =
        value.deduped_requirements().alternatives().size();
    result["deduped_too_complex"] =
        value.deduped_requirements().is_too_complex();
    result["has_required_skills"] =
        player.has_recipe_requirements( value );
    result["has_required_proficiencies"] =
        value.character_has_required_proficiencies(
            player );
    return result;
}

sol::table requirement_page(
    sol::this_state lua, const requirement_options &options )
{
    sol::state_view state( lua );
    const auto &all = requirement_data::all();
    const inventory &crafting_inventory =
        get_avatar().crafting_inventory();
    const std::function<bool( const item & )> filter =
    []( const item & ) {
        return true;
    };
    const std::size_t total = all.size();
    const std::size_t first = std::min(
                                  options.offset, total );
    const std::size_t returned = std::min(
                                     total - first,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    auto iterator = all.begin();
    std::advance(
        iterator,
        static_cast<std::ptrdiff_t>( first ) );
    for( std::size_t index = 0;
         index < returned; ++index, ++iterator ) {
        items[index + 1] = snapshot_requirement(
                               state, iterator->second,
                               options.batch,
                               crafting_inventory, filter );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = total;
    result["offset"] = first;
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["has_more"] = first + returned < total;
    result["batch"] = options.batch;
    return result;
}

sol::table requirement_limits( sol::this_state lua )
{
    sol::state_view state( lua );
    sol::table result = state.create_table();
    result["default_limit"] = default_requirement_limit;
    result["maximum_limit"] = maximum_requirement_limit;
    result["maximum_offset"] = maximum_requirement_offset;
    result["maximum_batch"] = maximum_recipe_batch;
    result["maximum_groups"] =
        maximum_requirement_groups;
    result["maximum_alternatives_per_group"] =
        maximum_requirement_alternatives;
    result["maximum_text_bytes"] =
        maximum_requirement_text_bytes;
    return result;
}

struct craft_action_options {
    int batch = 1;
    bool long_craft = false;
};

craft_action_options read_craft_action_options(
    const sol::optional<sol::table> &requested )
{
    craft_action_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.crafting.queue_start option keys "
                "must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        if( key == "batch" ) {
            result.batch = require_integer(
                               entry.second,
                               "game.crafting.queue_start", key );
            if( result.batch < 1 ||
                result.batch > maximum_recipe_batch ) {
                throw std::invalid_argument(
                    "game.crafting.queue_start option 'batch' "
                    "must be within 1..1000" );
            }
        } else if( key == "long" ) {
            result.long_craft = require_boolean(
                                    entry.second,
                                    "game.crafting.queue_start", key );
        } else {
            throw std::invalid_argument(
                "game.crafting.queue_start received unknown "
                "option '" + key + "'" );
        }
    }
    return result;
}

} // namespace

void install_crafting_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> can_mutate,
    std::function<std::string()> source_id )
{
    sol::state_view state( game.lua_state() );
    sol::table recipes = state.create_table();
    recipes.set_function(
        "limits",
    [require_read]( sol::this_state lua ) {
        require_read();
        return recipe_limits( lua );
    } );
    recipes.set_function(
        "list",
        [require_read](
            sol::this_state lua,
    const sol::optional<sol::table> &options ) {
        require_read();
        return recipe_page(
                   lua, read_recipe_options(
                       options, "game.recipes.list" ) );
    } );
    recipes.set_function(
        "all",
        [require_read](
            sol::this_state lua,
    const sol::optional<sol::table> &options ) {
        require_read();
        return recipe_page(
                   lua, read_recipe_options(
                       options, "game.recipes.all" ) );
    } );
    recipes.set_function(
        "by_skill",
        [require_read](
            sol::this_state lua, const script_game_id & skill,
    const sol::optional<sol::table> &options ) {
        require_read();
        require_id(
            skill, "skill", "game.recipes.by_skill" );
        recipe_options parsed = read_recipe_options(
                                    options, "game.recipes.by_skill" );
        parsed.skill = skill;
        return recipe_page( lua, parsed );
    } );
    recipes.set_function(
        "by_flag",
        [require_read](
            sol::this_state lua, const std::string & flag,
    const sol::optional<sol::table> &options ) {
        require_read();
        if( flag.empty() ||
            flag.size() > maximum_filter_bytes ||
            flag.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "game.recipes.by_flag flag must contain "
                "1 to 128 non-NUL bytes" );
        }
        recipe_options parsed = read_recipe_options(
                                    options, "game.recipes.by_flag" );
        parsed.flag = flag;
        return recipe_page( lua, parsed );
    } );
    recipes.set_function(
        "get",
        [require_read](
            sol::this_state lua, const script_game_id & id,
    const sol::optional<int> &batch ) {
        require_read();
        return get_recipe(
                   lua, id, batch.value_or( 1 ) );
    } );
    recipes.set_function(
        "has_flag",
        [require_read](
            const script_game_id & id,
    const std::string & flag ) {
        require_read();
        require_id(
            id, "recipe", "game.recipes.has_flag" );
        if( flag.empty() ||
            flag.size() > maximum_filter_bytes ||
            flag.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "game.recipes.has_flag flag must contain "
                "1 to 128 non-NUL bytes" );
        }
        return recipe_id( id.value() )->has_flag( flag );
    } );
    game["recipes"] = std::move( recipes );

    sol::table requirements = state.create_table();
    requirements.set_function(
        "limits",
    [require_read]( sol::this_state lua ) {
        require_read();
        return requirement_limits( lua );
    } );
    requirements.set_function(
        "list",
        [require_read](
            sol::this_state lua,
    const sol::optional<sol::table> &options ) {
        require_read();
        return requirement_page(
                   lua, read_requirement_options(
                       options, "game.requirements.list" ) );
    } );
    requirements.set_function(
        "get",
        [require_read](
            sol::this_state lua, const std::string & id,
    const sol::optional<int> &batch ) {
        require_read();
        return get_requirement(
                   lua, id, batch.value_or( 1 ) );
    } );
    requirements.set_function(
        "for_recipe",
        [require_read](
            sol::this_state lua, const script_game_id & id,
    const sol::optional<int> &batch ) {
        require_read();
        return requirements_for_recipe(
                   lua, id, batch.value_or( 1 ) );
    } );
    game["requirements"] = std::move( requirements );

    sol::table crafting = state.create_table();
    crafting.set_function(
        "queue_start",
        [require_write, can_mutate, source_id](
            const script_game_id & id,
    const sol::optional<sol::table> &options ) {
        require_write();
        if( !can_mutate() ) {
            throw std::runtime_error(
                "game.crafting.queue_start is only available "
                "from an active callback" );
        }
        require_id(
            id, "recipe", "game.crafting.queue_start" );
        const craft_action_options parsed =
            read_craft_action_options( options );
        return enqueue_craft_action(
                   id.value(), parsed.batch,
                   parsed.long_craft, source_id() );
    } );
    game["crafting"] = std::move( crafting );
}

} // namespace cata::lua_ui
