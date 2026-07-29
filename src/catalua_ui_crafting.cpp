#include "catalua_ui_crafting.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

#include "avatar.h"
#include "catalua_bindings_values.h"
#include "inventory.h"
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

} // namespace

void install_crafting_api(
    sol::table &game,
    std::function<void()> require_read,
    std::function<void()> require_write,
    std::function<bool()> can_mutate,
    std::function<std::string()> source_id )
{
    static_cast<void>( require_write );
    static_cast<void>( can_mutate );
    static_cast<void>( source_id );
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
}

} // namespace cata::lua_ui
