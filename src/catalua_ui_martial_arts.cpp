#include "catalua_ui_martial_arts.h"

#include <algorithm>
#include <cctype>
#include <cstddef>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "character_martial_arts.h"
#include "creature.h"
#include "martialarts.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_definition_limit = 64;
constexpr int maximum_definition_limit = 256;
constexpr int maximum_definition_offset = 1000000;
constexpr std::size_t maximum_query_bytes = 128;
constexpr std::size_t maximum_nested_ids = 256;
constexpr int default_state_limit = 64;
constexpr int maximum_state_limit = 256;
constexpr int maximum_state_offset = 1000000;

struct definition_options {
    int offset = 0;
    int limit = default_definition_limit;
    std::string query;
};

std::string lowercase_ascii( std::string value )
{
    std::transform( value.begin(), value.end(), value.begin(),
    []( const unsigned char ch ) {
        return static_cast<char>( std::tolower( ch ) );
    } );
    return value;
}

definition_options read_definition_options(
    const sol::optional<sol::table> &requested )
{
    definition_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.query = requested->get_or(
                           "query", result.query );
    }
    if( result.offset < 0 ||
        result.offset > maximum_definition_offset ) {
        throw std::invalid_argument(
            "game.martial_arts.definitions offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.martial_arts.definitions limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_definition_limit );
    if( result.query.size() > maximum_query_bytes ) {
        throw std::invalid_argument(
            "game.martial_arts.definitions query exceeds 128 bytes" );
    }
    return result;
}

void require_style_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "martial_art" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<martial_art>" );
    }
    if( !id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<martial_art>" );
    }
}

template<typename Id>
sol::table id_page(
    sol::state_view lua, const std::string_view kind,
    const std::set<Id> &ids )
{
    const std::size_t returned = std::min(
                                     ids.size(), maximum_nested_ids );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    std::size_t index = 0;
    for( const Id &id : ids ) {
        if( index >= returned ) {
            break;
        }
        items[index + 1] =
            script_game_id( std::string( kind ), id.str() );
        ++index;
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ids.size();
    result["returned"] = returned;
    result["truncated"] = returned < ids.size();
    return result;
}

sol::table snapshot_definition(
    sol::state_view lua, const martialart &definition )
{
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "martial_art", definition.id.str() );
    result["name"] = definition.name.translated();
    result["description"] =
        definition.description.translated();
    result["priority"] = definition.priority;
    result["teachable"] = definition.teachable;
    result["learn_difficulty"] =
        definition.learn_difficulty;
    result["arm_block"] = definition.arm_block;
    result["leg_block"] = definition.leg_block;
    result["nonstandard_block"] =
        definition.nonstandard_block;
    if( definition.primary_skill.is_null() ) {
        result["primary_skill"] = sol::nil;
    } else {
        result["primary_skill"] = script_game_id(
                                      "skill",
                                      definition.primary_skill.str() );
    }
    result["strictly_unarmed"] =
        definition.strictly_unarmed;
    result["strictly_melee"] =
        definition.strictly_melee;
    result["allow_all_weapons"] =
        definition.allow_all_weapons;
    result["force_unarmed"] =
        definition.force_unarmed;
    result["prevent_weapon_blocking"] =
        definition.prevent_weapon_blocking;
    result["techniques"] = id_page(
                               lua, "martial_art_technique",
                               definition.techniques );
    result["weapons"] = id_page(
                            lua, "item", definition.weapons );
    result["weapon_categories"] = id_page(
                                      lua, "weapon_category",
                                      definition.weapon_category );
    return result;
}

std::vector<matype_id> matching_definitions(
    const std::string &requested_query )
{
    const std::string query = lowercase_ascii( requested_query );
    const std::vector<matype_id> all =
        all_martialart_types();
    std::vector<matype_id> result;
    result.reserve( all.size() );
    for( const matype_id &id : all ) {
        const martialart &definition = id.obj();
        if( query.empty() ||
            lowercase_ascii( id.str() ).find( query ) !=
            std::string::npos ||
            lowercase_ascii(
                definition.name.translated() ).find( query ) !=
            std::string::npos ) {
            result.push_back( id );
        }
    }
    std::sort(
        result.begin(), result.end(),
    []( const matype_id & lhs, const matype_id & rhs ) {
        return lhs.str() < rhs.str();
    } );
    return result;
}

sol::table list_definitions(
    sol::this_state lua,
    const sol::optional<sol::table> &requested )
{
    const definition_options options =
        read_definition_options( requested );
    const std::vector<matype_id> definitions =
        matching_definitions( options.query );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, definitions.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, definitions.size() );
    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_definition(
                state, definitions[index].obj() );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["total"] = definitions.size();
    result["returned"] = last - first;
    result["has_more"] = last < definitions.size();
    return result;
}

sol::table get_definition(
    sol::this_state lua, const script_game_id &id )
{
    require_style_id(
        id, "game.martial_arts.definition" );
    return snapshot_definition(
               sol::state_view( lua ),
               matype_id( id.value() ).obj() );
}

Character *resolve_character(
    const game_handle &handle, const std::size_t runtime_generation,
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

sol::table snapshot_state(
    sol::state_view lua, const Character &character,
    const matype_id &id )
{
    const martialart &definition = id.obj();
    sol::table result = lua.create_table();
    result["id"] = script_game_id(
                       "martial_art", id.str() );
    result["name"] = definition.name.translated();
    result["known"] = character.has_martialart( id );
    result["selected"] =
        character.martial_arts_data->selected_style() == id;
    result["teachable"] = definition.teachable;
    result["strictly_unarmed"] =
        definition.strictly_unarmed;
    result["strictly_melee"] =
        definition.strictly_melee;
    result["allow_all_weapons"] =
        definition.allow_all_weapons;
    result["force_unarmed"] =
        definition.force_unarmed;
    return result;
}

struct state_list_options {
    int offset = 0;
    int limit = default_state_limit;
    bool teachable_only = false;
};

state_list_options read_state_list_options(
    const sol::optional<sol::table> &requested )
{
    state_list_options result;
    if( requested ) {
        result.offset = requested->get_or(
                            "offset", result.offset );
        result.limit = requested->get_or(
                           "limit", result.limit );
        result.teachable_only = requested->get_or(
                                    "teachable_only",
                                    result.teachable_only );
    }
    if( result.offset < 0 || result.offset > maximum_state_offset ) {
        throw std::invalid_argument(
            "game.martial_arts.list offset "
            "must be within 0..1000000" );
    }
    if( result.limit < 0 ) {
        throw std::invalid_argument(
            "game.martial_arts.list limit cannot be negative" );
    }
    result.limit = std::min(
                       result.limit, maximum_state_limit );
    return result;
}

sol::table list_states(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    const state_list_options options =
        read_state_list_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    std::vector<matype_id> styles =
        character->known_styles( options.teachable_only );
    std::sort(
        styles.begin(), styles.end(),
    []( const matype_id & lhs, const matype_id & rhs ) {
        return lhs.str() < rhs.str();
    } );
    const std::size_t first = std::min<std::size_t>(
                                  options.offset, styles.size() );
    const std::size_t last = std::min<std::size_t>(
                                 first + options.limit, styles.size() );
    sol::table items = state.create_table(
                           static_cast<int>( last - first ), 0 );
    for( std::size_t index = first; index < last; ++index ) {
        items[index - first + 1] =
            snapshot_state(
                state, *character, styles[index] );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["total"] = styles.size();
    value["returned"] = last - first;
    value["has_more"] = last < styles.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_style_id(
        requested_id, "game.martial_arts.get" );
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
                   state, snapshot_state(
                       state, *character,
                       matype_id(
                           requested_id.value() ) ) ) );
}

sol::table get_current_state(
    sol::this_state lua, const game_handle &handle,
    const std::size_t runtime_generation,
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
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_state(
                       state, *character,
                       character->martial_arts_data->
                       selected_style() ) ) );
}

sol::table learn_state(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_id,
    const std::size_t runtime_generation,
    const std::size_t world_generation )
{
    require_style_id(
        requested_id, "game.martial_arts.learn" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const matype_id id( requested_id.value() );
    const bool known_before =
        character->has_martialart( id );
    sol::table before =
        snapshot_state( state, *character, id );
    if( !known_before ) {
        character->martial_arts_data->learn_style(
            id, character->is_avatar() );
    }
    sol::table value = state.create_table();
    value["changed"] =
        !known_before && character->has_martialart( id );
    value["before"] = std::move( before );
    value["after"] =
        snapshot_state( state, *character, id );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_martial_art_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table martial_arts = lua.create_table();
    martial_arts.set_function(
        "definitions",
        [require_read]( sol::this_state lua_state,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_definitions( lua_state, options );
    } );
    martial_arts.set_function(
        "definition",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_definition( lua_state, id );
    } );
    martial_arts.set_function(
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
    martial_arts.set_function(
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
    martial_arts.set_function(
        "current",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle ) {
        require_read();
        return get_current_state(
                   lua_state, handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    martial_arts.set_function(
        "learn",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & id ) {
        require_write();
        return learn_state(
                   lua_state, handle, id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["martial_arts"] = std::move( martial_arts );
}

} // namespace cata::lua_ui
