#if CATA_ENABLE_LUA_UI

#include "catalua_ui_items.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <list>
#include <limits>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "activity_handlers.h"
#include "avatar.h"
#include "bionics.h"
#include "bodypart.h"
#include "calendar.h"
#include "catalua_bindings_coords.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "damage.h"
#include "dialogue.h"
#include "faction.h"
#include "game_inventory.h"
#include "inventory.h"
#include "item.h"
#include "item_category.h"
#include "item_contents.h"
#include "item_group.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "map.h"
#include "math_parser.h"
#include "math_parser_type.h"
#include "math_parser_diag_value.h"
#include "requirements.h"
#include "string_formatter.h"
#include "translations.h"
#include "type_id.h"
#include "units.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_inventory_limit = 128;
constexpr int maximum_inventory_limit = 512;
constexpr int default_item_relation_limit = 64;
constexpr int maximum_item_relation_limit = 256;
constexpr int maximum_item_text_width = 8192;
constexpr int default_pocket_limit = 64;
constexpr int maximum_pocket_limit = 256;
constexpr int default_contents_limit = 128;
constexpr int maximum_contents_limit = 512;
constexpr std::size_t maximum_contents_offset = 1000000;
constexpr int maximum_item_charges = 1000000000;
constexpr int maximum_item_burnt = 1000000000;
constexpr double maximum_item_relative_rot = 1000000.0;
constexpr std::size_t maximum_item_method_bytes = 256;
constexpr std::size_t maximum_item_var_key_bytes = 128;
constexpr std::size_t maximum_item_var_string_bytes = 4096;
constexpr double maximum_item_var_number = 1.0e15;
constexpr int maximum_inventory_give_instances = 100;
constexpr int maximum_inventory_resource_quantity = 1000000000;
constexpr std::size_t maximum_inventory_sum_entries = 128;
constexpr std::size_t maximum_spawn_rate_updates = 256;
constexpr double maximum_item_category_spawn_rate = 1000000.0;
constexpr std::size_t maximum_inventory_spawn_flags = 128;
constexpr std::size_t maximum_inventory_group_items = 256;
constexpr std::size_t maximum_inventory_selection_items = 512;
constexpr std::size_t maximum_inventory_selection_title_bytes = 512;

struct inventory_query_options {
    std::size_t offset = 0;
    int limit = default_inventory_limit;
    std::optional<int> max_depth;
    bool recursive = true;
    bool include_wielded = true;
    bool include_worn = true;
    bool include_carried = true;
    std::optional<sol::table> context;
};

struct inventory_item_entry {
    item *value = nullptr;
    std::string location;
    int depth = 0;
    std::int64_t parent_uid = 0;
    std::vector<int> path;
};

std::int64_t integer_option(
    const sol::object &value, const std::string &name,
    const std::string &api_name )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            api_name + " option '" + name +
            "' must be an integer" );
    }
    return value.as<lua_Integer>();
}

bool boolean_option(
    const sol::object &value, const std::string &name,
    const std::string &api_name )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " option '" + name +
            "' must be a boolean" );
    }
    return value.as<bool>();
}

std::size_t require_dense_lua_array(
    const sol::table &values, const std::string &description,
    const std::size_t minimum, const std::size_t maximum )
{
    const std::size_t count = values.size();
    if( count < minimum || count > maximum ) {
        throw std::invalid_argument( description + " has an invalid length" );
    }
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object value = values.raw_get<sol::object>( index );
        if( !value.valid() || value.get_type() == sol::type::nil ) {
            throw std::invalid_argument( description + " must be a dense array" );
        }
    }
    return count;
}

inventory_query_options read_inventory_options(
    const sol::optional<sol::table> &requested )
{
    inventory_query_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.inventory.list option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "offset" ) {
            const std::int64_t offset = integer_option(
                                            value, key,
                                            "game.inventory.list" );
            if( offset < 0 ||
                static_cast<std::uint64_t>( offset ) >
                std::numeric_limits<std::size_t>::max() ) {
                throw std::invalid_argument(
                    "game.inventory.list offset is outside its limit" );
            }
            result.offset = static_cast<std::size_t>( offset );
        } else if( key == "limit" ) {
            const std::int64_t limit = integer_option(
                                           value, key,
                                           "game.inventory.list" );
            if( limit < 0 ) {
                throw std::invalid_argument(
                    "game.inventory.list limit cannot be negative" );
            }
            result.limit = static_cast<int>(
                               std::min<std::int64_t>(
                                   limit, maximum_inventory_limit ) );
        } else if( key == "max_depth" ) {
            const std::int64_t depth = integer_option(
                                           value, key,
                                           "game.inventory.list" );
            if( depth < 0 ||
                depth > std::numeric_limits<int>::max() ) {
                throw std::invalid_argument(
                    "game.inventory.list max_depth is outside its native range" );
            }
            result.max_depth = static_cast<int>( depth );
        } else if( key == "recursive" ) {
            result.recursive = boolean_option(
                                   value, key,
                                   "game.inventory.list" );
        } else if( key == "include_wielded" ) {
            result.include_wielded = boolean_option(
                                         value, key,
                                         "game.inventory.list" );
        } else if( key == "include_worn" ) {
            result.include_worn = boolean_option(
                                      value, key,
                                      "game.inventory.list" );
        } else if( key == "include_carried" ) {
            result.include_carried = boolean_option(
                                         value, key,
                                         "game.inventory.list" );
        } else if( key == "context" ) {
            if( value.get_type() != sol::type::table ) {
                throw std::invalid_argument(
                    "game.inventory.list option 'context' must be a table" );
            }
            result.context = value.as<sol::table>();
        } else {
            throw std::invalid_argument(
                "game.inventory.list received unknown option '" +
                key + "'" );
        }
    }
    return result;
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

bool includes_location(
    const inventory_query_options &options,
    const std::string &location )
{
    if( location == "wielded" ) {
        return options.include_wielded;
    }
    if( location == "worn" ) {
        return options.include_worn;
    }
    return options.include_carried;
}

bool has_direct_contents( const item &entry )
{
    const std::vector<const item_pocket *> pockets =
        entry.get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    return std::any_of(
               pockets.begin(), pockets.end(),
    []( const item_pocket * pocket ) {
        return pocket != nullptr && !pocket->empty();
    } );
}

void append_inventory_children(
    const inventory_item_entry &parent,
    std::vector<inventory_item_entry> &children )
{
    const std::vector<item_pocket *> pockets =
        parent.value->get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    for( std::size_t pocket_index = 0;
         pocket_index < pockets.size(); ++pocket_index ) {
        item_pocket *pocket = pockets[pocket_index];
        if( pocket == nullptr ) {
            continue;
        }
        const std::list<item *> pocket_items =
            pocket->all_items_top();
        std::size_t child_index = 0;
        for( item *child : pocket_items ) {
            if( child != nullptr ) {
                std::vector<int> child_path = parent.path;
                child_path.push_back(
                    static_cast<int>( pocket_index ) );
                child_path.push_back(
                    static_cast<int>( child_index ) );
                children.push_back( {
                    child, "contained", parent.depth + 1,
                    parent.value->uid().get_value(),
                    std::move( child_path )
                } );
            }
            ++child_index;
        }
    }
}

template<typename Callback>
bool visit_inventory(
    Character &character, const inventory_query_options &options,
    Callback &&callback, bool &depth_truncated )
{
    std::vector<inventory_item_entry> roots;
    std::size_t root_index = 0;
    const auto append_root = [&]( item & root, const std::string & location ) {
        const std::size_t index = root_index++;
        if( !includes_location( options, location ) ) {
            return;
        }
        roots.push_back( {
            &root, location, 0, 0,
            { static_cast<int>( index ) }
        } );
    };

    item_location wielded = character.get_wielded_item();
    if( wielded ) {
        append_root( *wielded, "wielded" );
    }
    for( item_location worn :
        character.worn.top_items_loc( character ) ) {
        if( worn ) {
            append_root( *worn, "worn" );
        }
    }
    for( std::list<item> *stack : character.inv->slice() ) {
        if( stack == nullptr ) {
            continue;
        }
        for( item &carried : *stack ) {
            append_root( carried, "carried" );
        }
    }

    std::vector<inventory_item_entry> pending;
    pending.reserve( roots.size() );
    for( auto root = roots.rbegin(); root != roots.rend(); ++root ) {
        pending.push_back( std::move( *root ) );
    }
    while( !pending.empty() ) {
        inventory_item_entry current = std::move( pending.back() );
        pending.pop_back();
        if( !callback( current ) ) {
            return false;
        }
        if( !options.recursive ) {
            continue;
        }
        if( options.max_depth && current.depth >= *options.max_depth ) {
            depth_truncated = depth_truncated ||
                              has_direct_contents( *current.value );
            continue;
        }
        std::vector<inventory_item_entry> children;
        append_inventory_children( current, children );
        for( auto child = children.rbegin(); child != children.rend(); ++child ) {
            pending.push_back( std::move( *child ) );
        }
    }
    return true;
}

game_handle make_item_handle(
    Character &character, const inventory_item_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position = character.pos_abs();
    game_handle_locator locator;
    locator.scope = "character_" + entry.location;
    locator.stable_id = entry.value->uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    locator.path = entry.path;
    return game_handle::from_item(
               *entry.value, std::move( locator ),
               runtime_generation, world_generation );
}

sol::table inventory_entry_to_lua(
    sol::state_view lua, Character &character,
    const inventory_item_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["handle"] = make_item_handle(
                           character, entry, runtime_generation,
                           world_generation );
    result["uid"] = entry.value->uid().get_value();
    result["id"] = script_game_id(
                       "item", entry.value->typeId().str() );
    result["name"] = entry.value->display_name();
    result["location"] = entry.location;
    result["depth"] = entry.depth;
    if( entry.parent_uid > 0 ) {
        result["parent_uid"] = entry.parent_uid;
    }
    return result;
}

sol::table list_inventory(
    sol::this_state lua, const game_handle &character_handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const inventory_query_options options =
        read_inventory_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    bool depth_truncated = false;
    std::vector<inventory_item_entry> entries;
    entries.reserve( static_cast<std::size_t>( options.limit ) );
    std::size_t visited = 0;
    const bool traversal_complete = visit_inventory(
    *character, options, [&]( const inventory_item_entry & entry ) {
        const std::size_t index = visited++;
        if( index < options.offset ) {
            return true;
        }
        if( entries.size() >= static_cast<std::size_t>( options.limit ) ) {
            return false;
        }
        entries.push_back( entry );
        return true;
    }, depth_truncated );
    const std::size_t returned = entries.size();
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = inventory_entry_to_lua(
                               state, *character,
                               entries[index],
                               runtime_generation,
                               world_generation );
    }

    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = visited;
    value["total_exact"] =
        traversal_complete && !depth_truncated;
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    if( options.max_depth ) {
        value["max_depth"] = *options.max_depth;
    }
    value["recursive"] = options.recursive;
    value["returned"] = returned;
    value["has_more"] = !traversal_complete;
    value["node_truncated"] = false;
    value["depth_truncated"] = depth_truncated;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

std::vector<std::string> filter_string_values(
    const sol::table &descriptor, const std::string &key,
    const std::string &api_name )
{
    const sol::object raw = descriptor.raw_get<sol::object>( key );
    if( !raw.valid() || raw.get_type() == sol::type::nil ) {
        return {};
    }
    std::vector<std::string> result;
    const auto append = [&]( const sol::object &value ) {
        if( !value.is<std::string>() ) {
            throw std::invalid_argument( api_name + " filter '" + key +
                                         "' values must be strings" );
        }
        const std::string entry = value.as<std::string>();
        if( entry.empty() || entry.size() > 256 || entry.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument( api_name + " filter '" + key +
                                         "' values must be bounded non-empty strings" );
        }
        result.push_back( entry );
    };
    if( raw.is<std::string>() ) {
        append( raw );
    } else if( raw.get_type() == sol::type::table ) {
        const sol::table values = raw.as<sol::table>();
        const std::size_t count = require_dense_lua_array( values,
                                    api_name + " filter '" + key + "'", 0, 128 );
        for( std::size_t index = 1; index <= count; ++index ) {
            append( values.raw_get<sol::object>( index ) );
        }
    } else {
        throw std::invalid_argument( api_name + " filter '" + key +
                                     "' must be a string or dense string array" );
    }
    return result;
}

enum class inventory_condition_kind : std::uint8_t {
    has_ammo,
    math,
    all,
    any,
    negate,
};

struct inventory_condition {
    inventory_condition_kind kind = inventory_condition_kind::math;
    math_exp expression;
    std::vector<inventory_condition> children;

    bool evaluate( const const_dialogue &conversation ) const
    {
        switch( kind ) {
            case inventory_condition_kind::has_ammo: {
                const item_location *location =
                    conversation.const_actor( true )->get_const_item();
                const Character *character =
                    conversation.const_actor( false )->get_const_character();
                return location != nullptr && character != nullptr &&
                       ( *location )->ammo_sufficient( character );
            }
            case inventory_condition_kind::math:
                try {
                    return expression.eval( conversation ) != 0.0;
                } catch( const math::exception & ) {
                    return false;
                }
            case inventory_condition_kind::all:
                return std::all_of( children.begin(), children.end(),
                [&conversation]( const inventory_condition &child ) {
                    return child.evaluate( conversation );
                } );
            case inventory_condition_kind::any:
                return std::any_of( children.begin(), children.end(),
                [&conversation]( const inventory_condition &child ) {
                    return child.evaluate( conversation );
                } );
            case inventory_condition_kind::negate:
                return children.size() == 1 && !children.front().evaluate( conversation );
        }
        return false;
    }
};

constexpr std::size_t maximum_inventory_condition_depth = 8;
constexpr std::size_t maximum_inventory_condition_children = 16;
constexpr std::size_t maximum_inventory_condition_expression_bytes = 8192;
constexpr std::size_t maximum_inventory_context_entries = 128;
constexpr std::size_t maximum_inventory_context_string_bytes = 8192;

std::string inventory_condition_expression(
    const sol::object &value, const std::string &api_name )
{
    if( value.is<std::string>() ) {
        const std::string expression = value.as<std::string>();
        if( expression.empty() || expression.size() >
            maximum_inventory_condition_expression_bytes ||
            expression.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                api_name + " condition math expression is outside its limit" );
        }
        return expression;
    }
    if( value.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            api_name + " condition 'math' must be a string or string array" );
    }
    const sol::table parts = value.as<sol::table>();
    const std::size_t count = require_dense_lua_array(
                                  parts, api_name + " condition math", 1,
                                  maximum_inventory_condition_children );
    std::string expression;
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object part = parts.raw_get<sol::object>( index );
        if( !part.is<std::string>() ) {
            throw std::invalid_argument(
                api_name + " condition math parts must be strings" );
        }
        expression += part.as<std::string>();
        if( expression.size() > maximum_inventory_condition_expression_bytes ) {
            throw std::invalid_argument(
                api_name + " condition math expression is outside its limit" );
        }
    }
    return expression;
}

inventory_condition parse_inventory_condition(
    const sol::object &value, const std::string &api_name,
    const std::size_t depth = 0 )
{
    if( depth > maximum_inventory_condition_depth ) {
        throw std::invalid_argument(
            api_name + " condition nesting exceeds its limit" );
    }
    if( value.is<std::string>() ) {
        if( value.as<std::string>() != "has_ammo" ) {
            throw std::invalid_argument(
                api_name + " condition string must be 'has_ammo'" );
        }
        return { inventory_condition_kind::has_ammo, {}, {} };
    }
    if( value.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            api_name + " condition must be a string or table" );
    }
    const sol::table table = value.as<sol::table>();
    std::string key;
    sol::object payload;
    std::size_t fields = 0;
    for( const auto &entry : table ) {
        if( !entry.first.is<std::string>() ) {
            throw std::invalid_argument(
                api_name + " condition keys must be strings" );
        }
        key = entry.first.as<std::string>();
        payload = entry.second;
        ++fields;
    }
    if( fields != 1 ) {
        throw std::invalid_argument(
            api_name + " condition must contain exactly one operator" );
    }
    if( key == "math" ) {
        const std::string expression = inventory_condition_expression( payload, api_name );
        math_exp parsed;
        try {
            if( !parsed.parse( expression, true ) ) {
                throw std::invalid_argument(
                    api_name + " condition math expression could not be parsed" );
            }
        } catch( const math::exception &error ) {
            throw std::invalid_argument(
                api_name + " condition math expression is invalid: " +
                std::string( error.what() ) );
        }
        return { inventory_condition_kind::math, std::move( parsed ), {} };
    }
    inventory_condition_kind kind;
    if( key == "all" ) {
        kind = inventory_condition_kind::all;
    } else if( key == "any" ) {
        kind = inventory_condition_kind::any;
    } else if( key == "not" ) {
        inventory_condition child = parse_inventory_condition(
                                        payload, api_name, depth + 1 );
        return { inventory_condition_kind::negate, {}, { std::move( child ) } };
    } else {
        throw std::invalid_argument(
            api_name + " condition operator must be math, all, any, or not" );
    }
    if( payload.get_type() != sol::type::table ) {
        throw std::invalid_argument(
            api_name + " condition operator requires an array" );
    }
    const sol::table children = payload.as<sol::table>();
    const std::size_t count = require_dense_lua_array(
                                  children, api_name + " condition children", 1,
                                  maximum_inventory_condition_children );
    std::vector<inventory_condition> parsed;
    parsed.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        parsed.push_back( parse_inventory_condition(
                              children.raw_get<sol::object>( index ), api_name,
                              depth + 1 ) );
    }
    return { kind, {}, std::move( parsed ) };
}

struct inventory_filter_descriptor {
    std::vector<std::string> ids;
    std::vector<std::string> excluded_ids;
    std::vector<std::string> categories;
    std::vector<std::string> materials;
    std::vector<std::string> flags;
    std::vector<std::string> excluded_flags;
    std::optional<bool> uses_energy;
    std::optional<bool> is_chargeable;
    bool worn_only = false;
    bool wielded_only = false;
    bool held_only = false;
    std::optional<inventory_condition> condition;
};

std::optional<bool> optional_inventory_filter_bool(
    const sol::table &descriptor, const std::string &key,
    const std::string &api_name )
{
    const sol::object raw = descriptor.raw_get<sol::object>( key );
    if( !raw.valid() || raw.get_type() == sol::type::nil ) {
        return std::nullopt;
    }
    if( !raw.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " filter '" + key + "' must be boolean" );
    }
    return raw.as<bool>();
}

inventory_filter_descriptor parse_inventory_filter(
    const sol::table &descriptor, const std::string &api_name )
{
    inventory_filter_descriptor result;
    result.ids = filter_string_values( descriptor, "id", api_name );
    result.excluded_ids = filter_string_values( descriptor, "id_blacklist", api_name );
    result.categories = filter_string_values( descriptor, "category", api_name );
    result.materials = filter_string_values( descriptor, "material", api_name );
    result.flags = filter_string_values( descriptor, "flags", api_name );
    result.excluded_flags = filter_string_values( descriptor, "excluded_flags", api_name );
    result.uses_energy = optional_inventory_filter_bool( descriptor, "uses_energy", api_name );
    result.is_chargeable = optional_inventory_filter_bool( descriptor, "is_chargeable", api_name );
    const sol::object worn = descriptor.raw_get<sol::object>( "worn_only" );
    const sol::object wielded = descriptor.raw_get<sol::object>( "wielded_only" );
    const sol::object held = descriptor.raw_get<sol::object>( "held_only" );
    if( worn.valid() && worn.get_type() != sol::type::nil ) {
        if( !worn.is<bool>() ) {
            throw std::invalid_argument( api_name + " filter 'worn_only' must be boolean" );
        }
        result.worn_only = worn.as<bool>();
    }
    if( wielded.valid() && wielded.get_type() != sol::type::nil ) {
        if( !wielded.is<bool>() ) {
            throw std::invalid_argument( api_name + " filter 'wielded_only' must be boolean" );
        }
        result.wielded_only = wielded.as<bool>();
    }
    if( held.valid() && held.get_type() != sol::type::nil ) {
        if( !held.is<bool>() ) {
            throw std::invalid_argument( api_name + " filter 'held_only' must be boolean" );
        }
        result.held_only = held.as<bool>();
    }
    const sol::object condition = descriptor.raw_get<sol::object>( "condition" );
    if( condition.valid() && condition.get_type() != sol::type::nil ) {
        result.condition = parse_inventory_condition( condition, api_name );
    }
    for( const auto &member : descriptor ) {
        if( !member.first.is<std::string>() ) {
            throw std::invalid_argument( api_name + " filter keys must be strings" );
        }
        const std::string key = member.first.as<std::string>();
        if( key != "id" && key != "id_blacklist" && key != "category" &&
            key != "material" && key != "flags" && key != "excluded_flags" &&
            key != "uses_energy" && key != "is_chargeable" && key != "worn_only" &&
            key != "wielded_only" && key != "held_only" && key != "condition" ) {
            throw std::invalid_argument( api_name + " received unknown filter field '" + key + "'" );
        }
    }
    return result;
}

void apply_inventory_condition_context(
    const sol::table &context, const std::string &api_name,
    const_dialogue &conversation )
{
    std::size_t count = 0;
    for( const auto &entry : context ) {
        if( ++count > maximum_inventory_context_entries ) {
            throw std::invalid_argument(
                api_name + " option 'context' exceeds 128 entries" );
        }
        if( !entry.first.is<std::string>() ) {
            throw std::invalid_argument(
                api_name + " option 'context' keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key.empty() || key.size() > 128 ||
            std::any_of( key.begin(), key.end(), []( const unsigned char ch ) {
            return ch == '\0' || ch < 0x20U || ch == 0x7fU;
        } ) ) {
            throw std::invalid_argument(
                api_name + " option 'context' keys are outside their limit" );
        }
        const sol::object value = entry.second;
        if( value.is<bool>() ) {
            conversation.set_value( key, value.as<bool>() ? 1.0 : 0.0 );
        } else if( value.get_type() == sol::type::number ) {
            const double number = value.as<double>();
            if( !std::isfinite( number ) ) {
                throw std::invalid_argument(
                    api_name + " option 'context' numbers must be finite" );
            }
            conversation.set_value( key, number );
        } else if( value.is<std::string>() ) {
            const std::string text = value.as<std::string>();
            if( text.size() > maximum_inventory_context_string_bytes ) {
                throw std::invalid_argument(
                    api_name + " option 'context' strings exceed their limit" );
            }
            conversation.set_value( key, text );
        } else if( value.is<script_tripoint_coord>() ) {
            const script_tripoint_coord position =
                value.as<script_tripoint_coord>();
            if( position.native_origin() != coords::origin::abs ||
                position.native_scale() != coords::scale::map_square ) {
                throw std::invalid_argument(
                    api_name + " option 'context' coordinates must be absolute map-square" );
            }
            conversation.set_value( key, tripoint_abs_ms( position.to_native() ) );
        } else {
            throw std::invalid_argument(
                api_name + " option 'context' values must be scalar or Tripoint" );
        }
    }
}

bool inventory_filter_matches(
    Character &character, item &entry,
    const inventory_filter_descriptor &descriptor,
    const std::optional<sol::table> &context,
    const std::string &api_name )
{
    const std::string id = entry.typeId().str();
    if( !descriptor.ids.empty() && std::find( descriptor.ids.begin(), descriptor.ids.end(), id ) ==
        descriptor.ids.end() ) {
        return false;
    }
    if( std::find( descriptor.excluded_ids.begin(), descriptor.excluded_ids.end(), id ) !=
        descriptor.excluded_ids.end() ) {
        return false;
    }
    const std::string category = entry.get_category_shallow().get_id().str();
    if( !descriptor.categories.empty() && std::find( descriptor.categories.begin(),
            descriptor.categories.end(), category ) == descriptor.categories.end() ) {
        return false;
    }
    if( !descriptor.materials.empty() ) {
        bool matches = false;
        for( const std::string &material : descriptor.materials ) {
            if( entry.made_of( material_id( material ) ) > 0 ) {
                matches = true;
                break;
            }
        }
        if( !matches ) {
            return false;
        }
    }
    if( !descriptor.flags.empty() ) {
        bool matches = false;
        for( const std::string &flag : descriptor.flags ) {
            if( entry.has_flag( flag_id( flag ) ) ) {
                matches = true;
                break;
            }
        }
        if( !matches ) {
            return false;
        }
    }
    for( const std::string &flag : descriptor.excluded_flags ) {
        if( entry.has_flag( flag_id( flag ) ) ) {
            return false;
        }
    }
    if( descriptor.uses_energy.has_value() &&
        descriptor.uses_energy.value() != entry.uses_energy() ) {
        return false;
    }
    if( descriptor.is_chargeable.has_value() &&
        descriptor.is_chargeable.value() != entry.is_chargeable() ) {
        return false;
    }
    if( descriptor.worn_only != character.is_worn( entry ) &&
        descriptor.worn_only ) {
        return false;
    }
    if( descriptor.wielded_only != character.is_wielding( entry ) &&
        descriptor.wielded_only ) {
        return false;
    }
    if( descriptor.held_only &&
        !( character.is_worn( entry ) || character.is_wielding( entry ) ) ) {
        return false;
    }
    if( descriptor.condition ) {
        item_location location( character, &entry );
        const_dialogue conversation(
            get_const_talker_for( character ),
            get_const_talker_for( location ) );
        if( context ) {
            apply_inventory_condition_context( *context, api_name, conversation );
        }
        if( !descriptor.condition->evaluate( conversation ) ) {
            return false;
        }
    }
    return true;
}

sol::table filter_inventory(
    sol::this_state lua, const game_handle &character_handle,
    const sol::table &descriptors, const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.inventory.filter";
    const inventory_query_options options = read_inventory_options( requested );
    const std::size_t descriptor_count = require_dense_lua_array(
            descriptors, "game.inventory.filter descriptors", 0, 128 );
    std::vector<inventory_filter_descriptor> filters;
    filters.reserve( descriptor_count );
    for( std::size_t index = 1; index <= descriptor_count; ++index ) {
        const sol::object value = descriptors.raw_get<sol::object>( index );
        if( !value.is<sol::table>() ) {
            throw std::invalid_argument( "game.inventory.filter descriptors must be tables" );
        }
        filters.push_back( parse_inventory_filter( value.as<sol::table>(),
                           std::string( api_name ) ) );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character( character_handle, runtime_generation,
                                              world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    bool depth_truncated = false;
    std::vector<inventory_item_entry> entries;
    std::size_t visited = 0;
    const bool complete = visit_inventory( *character, options,
    [&]( const inventory_item_entry &entry ) {
        bool matches = filters.empty();
        for( const inventory_filter_descriptor &filter : filters ) {
            if( inventory_filter_matches( *character, *entry.value, filter,
                                          options.context, std::string( api_name ) ) ) {
                matches = true;
                break;
            }
        }
        if( !matches ) {
            return true;
        }
        const std::size_t index = visited++;
        if( index < options.offset ) {
            return true;
        }
        if( entries.size() >= static_cast<std::size_t>( options.limit ) ) {
            return false;
        }
        entries.push_back( entry );
        return true;
    }, depth_truncated );
    sol::table items = state.create_table( static_cast<int>( entries.size() ), 0 );
    for( std::size_t index = 0; index < entries.size(); ++index ) {
        items[index + 1] = inventory_entry_to_lua( state, *character, entries[index],
                              runtime_generation, world_generation );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["total"] = visited;
    result["returned"] = entries.size();
    result["offset"] = options.offset;
    result["limit"] = options.limit;
    result["has_more"] = !complete;
    result["depth_truncated"] = depth_truncated;
    return make_game_value_result( state, sol::make_object( state, std::move( result ) ) );
}

sol::table find_inventory_item(
    sol::this_state lua, const game_handle &character_handle,
    const std::int64_t uid,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( uid <= 0 ) {
        throw std::invalid_argument(
            "game.inventory.find uid must be positive" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    inventory_query_options options;
    bool depth_truncated = false;
    std::optional<inventory_item_entry> found;
    visit_inventory(
    *character, options, [&]( const inventory_item_entry & entry ) {
        if( entry.value->uid().get_value() != uid ) {
            return true;
        }
        found = entry;
        return false;
    }, depth_truncated );
    if( !found ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The character does not carry an item with that uid"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, inventory_entry_to_lua(
                       state, *character, *found,
                       runtime_generation,
                       world_generation ) ) );
}

int item_relation_limit(
    const sol::optional<int> &requested )
{
    const int result =
        requested.value_or( default_item_relation_limit );
    if( result < 0 ) {
        throw std::invalid_argument(
            "game.items.snapshot relation_limit cannot be negative" );
    }
    return std::min( result, maximum_item_relation_limit );
}

std::string bounded_item_text( const std::string &text )
{
    if( utf8_width( text ) <= maximum_item_text_width ) {
        return text;
    }
    return utf8_truncate( text, maximum_item_text_width );
}

script_unit_value mass_value( const units::mass &value )
{
    return script_unit_value::from_canonical_integer(
               "mass", "milligram",
               units::to_milligram( value ) );
}

script_unit_value volume_value( const units::volume &value )
{
    return script_unit_value::from_canonical_integer(
               "volume", "milliliter",
               units::to_milliliter( value ) );
}

script_unit_value length_value( const units::length &value )
{
    return script_unit_value::from_canonical_integer(
               "length", "millimeter", value.value() );
}

script_unit_value money_value( const int cents )
{
    return script_unit_value::from_canonical_integer(
               "money", "cent", cents );
}

script_unit_value energy_value( const units::energy &value )
{
    return script_unit_value::from_canonical_integer(
               "energy", "millijoule", value.value() );
}

sol::table typed_string_id_page(
    sol::state_view lua, std::vector<std::string> ids,
    const std::string &kind, const int limit )
{
    std::sort( ids.begin(), ids.end() );
    ids.erase(
        std::unique( ids.begin(), ids.end() ), ids.end() );
    const std::size_t returned = std::min(
                                     ids.size(),
                                     static_cast<std::size_t>( limit ) );
    sol::table items = lua.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] =
            script_game_id( kind, ids[index] );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = ids.size();
    result["returned"] = returned;
    result["limit"] = limit;
    result["truncated"] = returned < ids.size();
    return result;
}

sol::table item_classification(
    sol::state_view lua, const item &entry )
{
    sol::table result = lua.create_table();
    result["null"] = entry.is_null();
    result["money"] = entry.is_money();
    result["gun"] = entry.is_gun();
    result["firearm"] = entry.is_firearm();
    result["gunmod"] = entry.is_gunmod();
    result["bionic"] = entry.is_bionic();
    result["ammo_belt"] = entry.is_ammo_belt();
    result["holster"] = entry.is_holster();
    result["ammo"] = entry.is_ammo();
    result["magazine"] = entry.is_magazine();
    result["comestible"] = entry.is_comestible();
    result["food"] = entry.is_food();
    result["medication"] = entry.is_medication();
    result["brewable"] = entry.is_brewable();
    result["food_container"] = entry.is_food_container();
    result["ammo_container"] = entry.is_ammo_container();
    result["corpse"] = entry.is_corpse();
    result["armor"] = entry.is_armor();
    result["book"] = entry.is_book();
    result["map"] = entry.is_map();
    result["container"] = entry.is_container();
    result["watertight_container"] =
        entry.is_watertight_container();
    result["container_empty"] =
        entry.is_container_empty();
    result["engine"] = entry.is_engine();
    result["wheel"] = entry.is_wheel();
    result["fuel"] = entry.is_fuel();
    result["toolmod"] = entry.is_toolmod();
    result["irremovable"] = entry.is_irremovable();
    result["salvageable"] = entry.is_salvageable();
    result["craft"] = entry.is_craft();
    result["emissive"] = entry.is_emissive();
    result["deployable"] = entry.is_deployable();
    result["tool"] = entry.is_tool();
    result["transformable"] = entry.is_transformable();
    result["relic"] = entry.is_relic();
    result["seed"] = entry.is_seed();
    result["dangerous"] = entry.is_dangerous();
    result["tainted"] = entry.is_tainted();
    result["soft"] = entry.is_soft();
    result["reloadable"] = entry.is_reloadable();
    result["sided"] = entry.is_sided();
    result["power_armor"] = entry.is_power_armor();
    result["upgrade"] = entry.is_upgrade();
    return result;
}

sol::table snapshot_item(
    sol::state_view lua, const item &entry,
    const int relation_limit )
{
    sol::table result = lua.create_table();
    result["uid"] = entry.uid().get_value();
    result["id"] = script_game_id(
                       "item", entry.typeId().str() );
    result["name"] = bounded_item_text( entry.tname() );
    result["display_name"] =
        bounded_item_text( entry.display_name() );
    result["type_name"] =
        bounded_item_text( entry.type_name() );
    result["description"] = bounded_item_text(
                                entry.type->description.translated( 1 ) );

    const item_category &category =
        entry.get_category_shallow();
    sol::table category_value = lua.create_table();
    category_value["id"] = category.get_id().str();
    category_value["name"] = category.name_header();
    result["category"] = std::move( category_value );

    result["charges"] = entry.charges;
    result["count_by_charges"] =
        entry.count_by_charges();
    result["stackable"] = entry.is_stackable();
    result["infinite_charges"] =
        entry.has_infinite_charges();
    result["active"] = entry.is_active();
    result["favorite"] = entry.is_favorite;
    result["weight"] = mass_value( entry.weight() );
    result["weight_without_contents"] =
        mass_value( entry.weight( false ) );
    result["volume"] = volume_value( entry.volume() );
    result["price_pre_cataclysm"] =
        money_value( entry.price( false ) );
    result["price_post_cataclysm"] =
        money_value( entry.price( true ) );
    result["birthday"] =
        script_time_point::from_native( entry.birthday() );
    result["rot"] =
        script_time_duration::from_native( entry.get_rot() );
    result["relative_rot"] = entry.get_relative_rot();
    result["goes_bad"] = entry.goes_bad();
    result["fresh"] = entry.is_fresh();
    result["going_bad"] = entry.is_going_bad();
    result["rotten"] = entry.rotten();
    result["conductive"] = entry.conductive();
    result["irradiation"] = entry.irradiation;

    if( entry.get_comestible() ) {
        const nutrients effective =
            default_character_compute_effective_nutrients( entry );
        sol::table nutrition = lua.create_table();
        nutrition["calories"] = effective.kcal();
        nutrition["fun"] = entry.get_comestible_fun();
        sol::table vitamins = lua.create_table();
        for( const auto &vitamin : effective.vitamins() ) {
            vitamins[vitamin.first.str()] = vitamin.second;
        }
        nutrition["vitamins"] = std::move( vitamins );
        result["nutrition"] = std::move( nutrition );
    } else {
        result["nutrition"] = sol::nil;
    }

    sol::table condition = lua.create_table();
    condition["damage"] = entry.damage();
    condition["degradation"] = entry.degradation();
    condition["burnt"] = entry.burnt;
    if( entry.base_volume() > 0_ml ) {
        const int volume_units = entry.base_volume() / 250_ml;
        const int threshold = std::max( volume_units * 3, 1 );
        condition["burnt_percent"] =
            static_cast<double>( entry.burnt ) * 100.0 /
            static_cast<double>( threshold );
    } else {
        condition["burnt_percent"] = sol::nil;
    }
    condition["damage_level"] = entry.damage_level();
    condition["max_damage"] = entry.max_damage();
    condition["relative_health"] =
        entry.get_relative_health();
    result["condition"] = std::move( condition );

    sol::table resources = lua.create_table();
    resources["ammo_remaining"] =
        entry.ammo_remaining();
    resources["ammo_capacity_remaining"] =
        entry.remaining_ammo_capacity();
    resources["ammo_required"] =
        entry.ammo_required();
    resources["chargeable"] =
        entry.is_chargeable();
    const itype_id current_ammo = entry.ammo_current();
    if( !current_ammo.is_null() ) {
        resources["ammo"] = script_game_id(
                                "item", current_ammo.str() );
    }
    resources["uses_energy"] = entry.uses_energy();
    if( entry.uses_energy() ) {
        resources["energy"] = energy_value(
                                  entry.energy_remaining(
                                      nullptr, true ) );
    }
    result["resources"] = std::move( resources );

    result["classification"] =
        item_classification( lua, entry );
    result["contents_count"] =
        entry.num_item_stacks();
    result["pocket_count"] =
        entry.get_contents().size();
    result["relation_limit"] = relation_limit;

    std::vector<std::string> materials;
    materials.reserve( entry.made_of().size() );
    for( const auto &material : entry.made_of() ) {
        materials.push_back( material.first.str() );
    }
    result["materials"] = typed_string_id_page(
                              lua, std::move( materials ),
                              "material", relation_limit );

    std::vector<std::string> type_flags;
    type_flags.reserve( entry.type->get_flags().size() );
    for( const flag_id &flag : entry.type->get_flags() ) {
        type_flags.push_back( flag.str() );
    }
    result["type_flags"] = typed_string_id_page(
                               lua, std::move( type_flags ),
                               "json_flag", relation_limit );

    std::vector<std::string> own_flags;
    own_flags.reserve( entry.get_flags().size() );
    for( const flag_id &flag : entry.get_flags() ) {
        own_flags.push_back( flag.str() );
    }
    result["own_flags"] = typed_string_id_page(
                              lua, std::move( own_flags ),
                              "json_flag", relation_limit );

    std::vector<std::string> faults;
    faults.reserve( entry.faults.size() );
    for( const fault_id &fault : entry.faults ) {
        faults.push_back( fault.str() );
    }
    result["faults"] = typed_string_id_page(
                           lua, std::move( faults ),
                           "fault", relation_limit );

    const std::set<matec_id> entry_techniques =
        entry.get_techniques();
    std::vector<std::string> techniques;
    techniques.reserve( entry_techniques.size() );
    for( const matec_id &technique : entry_techniques ) {
        techniques.push_back( technique.str() );
    }
    result["techniques"] = typed_string_id_page(
                               lua, std::move( techniques ),
                               "martial_art_technique",
                               relation_limit );

    const faction_id owner = entry.get_owner();
    if( !owner.is_null() ) {
        sol::table owner_value = lua.create_table();
        owner_value["id"] =
            script_game_id( "faction", owner.str() );
        owner_value["name"] =
            bounded_item_text( entry.get_owner_name() );
        result["owner"] = std::move( owner_value );
    }
    const faction_id old_owner = entry.get_old_owner();
    if( !old_owner.is_null() ) {
        sol::table owner_value = lua.create_table();
        owner_value["id"] =
            script_game_id( "faction", old_owner.str() );
        owner_value["name"] =
            bounded_item_text( entry.get_old_owner_name() );
        result["old_owner"] = std::move( owner_value );
    }
    return result;
}

sol::table item_snapshot_result(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_relation_limit,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const int relation_limit =
        item_relation_limit( requested_relation_limit );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, snapshot_item(
                       state, *resolved.value,
                       relation_limit ) ) );
}

std::string pocket_type_name( const pocket_type type )
{
    switch( type ) {
        case pocket_type::CONTAINER:
            return "container";
        case pocket_type::MAGAZINE:
            return "magazine";
        case pocket_type::MAGAZINE_WELL:
            return "magazine_well";
        case pocket_type::MOD:
            return "mod";
        case pocket_type::CORPSE:
            return "corpse";
        case pocket_type::SOFTWARE:
            return "software";
        case pocket_type::E_FILE_STORAGE:
            return "e_file_storage";
        case pocket_type::CABLE:
            return "cable";
        case pocket_type::MIGRATION:
            return "migration";
        case pocket_type::EBOOK:
            return "ebook";
        case pocket_type::LAST:
            return "unknown";
    }
    return "unknown";
}

pocket_type native_pocket_type( const item_pocket &pocket )
{
    const pocket_data *data = pocket.get_pocket_data();
    return data == nullptr ? pocket.saved_type() : data->type;
}

struct pocket_query_options {
    std::size_t offset = 0;
    int limit = default_pocket_limit;
};

pocket_query_options read_pocket_options(
    const sol::optional<sol::table> &requested )
{
    pocket_query_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.items.pockets option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "offset" ) {
            const std::int64_t offset = integer_option(
                                            value, key,
                                            "game.items.pockets" );
            if( offset < 0 ||
                static_cast<std::uint64_t>( offset ) >
                maximum_contents_offset ) {
                throw std::invalid_argument(
                    "game.items.pockets offset is outside its limit" );
            }
            result.offset = static_cast<std::size_t>( offset );
        } else if( key == "limit" ) {
            const std::int64_t limit = integer_option(
                                           value, key,
                                           "game.items.pockets" );
            if( limit < 0 ) {
                throw std::invalid_argument(
                    "game.items.pockets limit cannot be negative" );
            }
            result.limit = static_cast<int>(
                               std::min<std::int64_t>(
                                   limit, maximum_pocket_limit ) );
        } else {
            throw std::invalid_argument(
                "game.items.pockets received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table snapshot_pocket(
    sol::state_view lua, const item_pocket &pocket,
    const std::size_t index )
{
    sol::table result = lua.create_table();
    result["index"] = index;
    result["ordinal"] = index + 1;
    result["type"] =
        pocket_type_name( native_pocket_type( pocket ) );
    result["name"] = bounded_item_text(
                         pocket.get_name().translated() );
    result["description"] = bounded_item_text(
                                pocket.get_description().translated() );
    result["items"] = pocket.size();
    result["empty"] = pocket.empty();
    result["full"] = pocket.full( false );
    result["rigid"] = pocket.rigid();
    result["watertight"] = pocket.watertight();
    result["airtight"] = pocket.airtight();
    result["transparent"] = pocket.transparent();
    result["restricted"] = pocket.is_restricted();
    result["forbidden"] = pocket.is_forbidden();
    result["standard"] = pocket.is_standard_type();
    result["container_like"] =
        pocket.is_container_like_type();
    result["ablative"] = pocket.is_ablative();
    result["holster"] = pocket.is_holster();
    result["sealable"] = pocket.sealable();
    result["sealed"] = pocket.sealed();
    result["will_spill"] = pocket.will_spill();
    result["moves"] = pocket.moves();
    result["spoil_multiplier"] =
        pocket.spoil_multiplier();

    sol::table capacity = lua.create_table();
    capacity["volume"] =
        volume_value( pocket.volume_capacity() );
    capacity["volume_used"] =
        volume_value( pocket.contents_volume() );
    capacity["volume_remaining"] =
        volume_value( pocket.remaining_volume() );
    capacity["weight"] =
        mass_value( pocket.weight_capacity() );
    capacity["weight_used"] =
        mass_value( pocket.contains_weight() );
    capacity["weight_remaining"] =
        mass_value( pocket.remaining_weight() );
    capacity["length_max"] =
        length_value( pocket.max_containable_length() );
    capacity["length_min"] =
        length_value( pocket.min_containable_length() );
    result["capacity"] = std::move( capacity );
    return result;
}

sol::table item_pockets_result(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const pocket_query_options options =
        read_pocket_options( requested );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const std::vector<item_pocket *> pockets =
        resolved.value->get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    const std::size_t start =
        std::min( options.offset, pockets.size() );
    const std::size_t returned = std::min(
                                     pockets.size() - start,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        const item_pocket *pocket = pockets[start + index];
        if( pocket != nullptr ) {
            items[index + 1] = snapshot_pocket(
                                   state, *pocket,
                                   start + index );
        }
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = pockets.size();
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["returned"] = returned;
    value["has_more"] =
        start + returned < pockets.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct contents_query_options {
    std::size_t offset = 0;
    int limit = default_contents_limit;
    std::optional<int> max_depth;
    bool recursive = true;
};

struct contained_item_entry {
    item *value = nullptr;
    int depth = 0;
    std::int64_t parent_uid = 0;
    std::size_t pocket_index = 0;
    std::string pocket_type;
    std::vector<int> path;
};

contents_query_options read_contents_options(
    const sol::optional<sol::table> &requested )
{
    contents_query_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.items.contents option keys must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = entry.second;
        if( key == "offset" ) {
            const std::int64_t offset = integer_option(
                                            value, key,
                                            "game.items.contents" );
            if( offset < 0 ||
                static_cast<std::uint64_t>( offset ) >
                std::numeric_limits<std::size_t>::max() ) {
                throw std::invalid_argument(
                    "game.items.contents offset is outside its limit" );
            }
            result.offset = static_cast<std::size_t>( offset );
        } else if( key == "limit" ) {
            const std::int64_t limit = integer_option(
                                           value, key,
                                           "game.items.contents" );
            if( limit < 0 ) {
                throw std::invalid_argument(
                    "game.items.contents limit cannot be negative" );
            }
            result.limit = static_cast<int>(
                               std::min<std::int64_t>(
                                   limit, maximum_contents_limit ) );
        } else if( key == "max_depth" ) {
            const std::int64_t depth = integer_option(
                                           value, key,
                                           "game.items.contents" );
            if( depth < 0 ||
                depth > std::numeric_limits<int>::max() ) {
                throw std::invalid_argument(
                    "game.items.contents max_depth is outside its native range" );
            }
            result.max_depth = static_cast<int>( depth );
        } else if( key == "recursive" ) {
            result.recursive = boolean_option(
                                   value, key,
                                   "game.items.contents" );
        } else {
            throw std::invalid_argument(
                "game.items.contents received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

void append_contained_children(
    item &parent, const std::vector<int> &parent_path,
    const int child_depth,
    std::vector<contained_item_entry> &children )
{
    const std::vector<item_pocket *> pockets =
        parent.get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    for( std::size_t pocket_index = 0;
         pocket_index < pockets.size(); ++pocket_index ) {
        item_pocket *pocket = pockets[pocket_index];
        if( pocket == nullptr ) {
            continue;
        }
        const std::list<item *> pocket_items =
            pocket->all_items_top();
        std::size_t child_index = 0;
        for( item *child : pocket_items ) {
            if( child == nullptr ) {
                ++child_index;
                continue;
            }
            std::vector<int> child_path = parent_path;
            child_path.push_back(
                static_cast<int>( pocket_index ) );
            child_path.push_back(
                static_cast<int>( child_index ) );
            children.push_back( {
                child, child_depth, parent.uid().get_value(),
                pocket_index,
                pocket_type_name(
                    native_pocket_type( *pocket ) ),
                child_path
            } );
            ++child_index;
        }
    }
}

template<typename Callback>
bool visit_item_contents(
    item &root, const std::vector<int> &root_path,
    const contents_query_options &options,
    Callback &&callback, bool &depth_truncated )
{
    if( options.max_depth && *options.max_depth == 0 ) {
        depth_truncated = has_direct_contents( root );
        return true;
    }

    std::vector<contained_item_entry> roots;
    append_contained_children( root, root_path, 1, roots );
    std::vector<contained_item_entry> pending;
    pending.reserve( roots.size() );
    for( auto entry = roots.rbegin(); entry != roots.rend(); ++entry ) {
        pending.push_back( std::move( *entry ) );
    }
    while( !pending.empty() ) {
        contained_item_entry current = std::move( pending.back() );
        pending.pop_back();
        if( !callback( current ) ) {
            return false;
        }
        if( !options.recursive ) {
            continue;
        }
        if( options.max_depth && current.depth >= *options.max_depth ) {
            depth_truncated = depth_truncated ||
                              has_direct_contents( *current.value );
            continue;
        }
        std::vector<contained_item_entry> children;
        append_contained_children(
            *current.value, current.path,
            current.depth + 1, children );
        for( auto child = children.rbegin(); child != children.rend(); ++child ) {
            pending.push_back( std::move( *child ) );
        }
    }
    return true;
}

game_handle make_contained_item_handle(
    const game_handle &root,
    const contained_item_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator = root.locator();
    locator.scope = "item_contained";
    locator.stable_id =
        entry.value->uid().get_value();
    locator.path = entry.path;
    return game_handle::from_item(
               *entry.value, std::move( locator ),
               runtime_generation, world_generation );
}

sol::table contained_item_to_lua(
    sol::state_view lua, const game_handle &root,
    const contained_item_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["handle"] = make_contained_item_handle(
                           root, entry, runtime_generation,
                           world_generation );
    result["uid"] = entry.value->uid().get_value();
    result["id"] = script_game_id(
                       "item", entry.value->typeId().str() );
    result["name"] =
        bounded_item_text( entry.value->display_name() );
    result["depth"] = entry.depth;
    result["parent_uid"] = entry.parent_uid;
    result["pocket_index"] = entry.pocket_index;
    result["pocket_type"] = entry.pocket_type;
    return result;
}

sol::table item_contents_result(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const contents_query_options options =
        read_contents_options( requested );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }

    bool depth_truncated = false;
    std::vector<contained_item_entry> contents;
    contents.reserve( static_cast<std::size_t>( options.limit ) );
    std::size_t visited = 0;
    const bool traversal_complete = visit_item_contents(
    *resolved.value, handle.locator().path, options,
    [&]( const contained_item_entry & entry ) {
        const std::size_t index = visited++;
        if( index < options.offset ) {
            return true;
        }
        if( contents.size() >= static_cast<std::size_t>( options.limit ) ) {
            return false;
        }
        contents.push_back( entry );
        return true;
    }, depth_truncated );
    const std::size_t returned = contents.size();
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = contained_item_to_lua(
                               state, handle,
                               contents[index],
                               runtime_generation,
                               world_generation );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = visited;
    value["total_exact"] =
        traversal_complete && !depth_truncated;
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    if( options.max_depth ) {
        value["max_depth"] = *options.max_depth;
    }
    value["recursive"] = options.recursive;
    value["returned"] = returned;
    value["has_more"] = !traversal_complete;
    value["node_truncated"] = false;
    value["depth_truncated"] = depth_truncated;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void require_id_kind(
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

int item_type_food_fun( const script_game_id &requested_id )
{
    require_id_kind(
        requested_id, "item", "game.items.food_fun" );
    const itype_id id( requested_id.value() );
    return id->comestible ? id->comestible->get_fun() : 0;
}

sol::table possible_items_from_group(
    sol::this_state lua, const script_game_id &requested_group )
{
    constexpr std::string_view api_name =
        "game.items.possible_from_group";
    require_id_kind(
        requested_group, "item_group", std::string( api_name ) );
    std::vector<std::string> ids;
    for( const itype *entry : item_group::every_possible_item_from(
             item_group_id( requested_group.value() ) ) ) {
        if( entry != nullptr ) {
            ids.push_back( entry->get_id().str() );
        }
    }
    std::sort( ids.begin(), ids.end() );
    ids.erase( std::unique( ids.begin(), ids.end() ), ids.end() );

    sol::state_view state( lua );
    sol::table items = state.create_table(
                           static_cast<int>( ids.size() ), 0 );
    for( std::size_t index = 0; index < ids.size(); ++index ) {
        items[index + 1] = script_game_id( "item", ids[index] );
    }
    sol::table value = state.create_table();
    value["group"] = requested_group;
    value["items"] = std::move( items );
    value["total"] = ids.size();
    return value;
}

struct item_updates {
    std::optional<int> charges;
    std::optional<int> damage;
    std::optional<int> degradation;
    std::optional<int> burnt;
    std::optional<bool> favorite;
    std::optional<bool> active;
    std::optional<bool> browsed;
    std::optional<double> relative_rot;
    std::optional<time_duration> rot;
};

item_updates read_item_updates(
    const item &entry, const sol::table &requested )
{
    item_updates result;
    bool found = false;
    for( const auto &field : requested ) {
        const sol::object key_object = field.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.items.update field names must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = field.second;
        if( key == "charges" ) {
            const std::int64_t charges = integer_option(
                                             value, key,
                                             "game.items.update" );
            if( charges < 0 ||
                charges > maximum_item_charges ) {
                throw std::invalid_argument(
                    "game.items.update charges is outside its limit" );
            }
            if( !entry.type->can_have_charges() ) {
                throw std::invalid_argument(
                    "game.items.update cannot set charges on this item type" );
            }
            result.charges = static_cast<int>( charges );
        } else if( key == "damage" ) {
            const std::int64_t damage = integer_option(
                                            value, key,
                                            "game.items.update" );
            if( damage < 0 ||
                damage > entry.max_damage() ) {
                throw std::invalid_argument(
                    "game.items.update damage is outside this item's range" );
            }
            result.damage = static_cast<int>( damage );
        } else if( key == "degradation" ) {
            const std::int64_t degradation = integer_option(
                    value, key, "game.items.update" );
            if( degradation < 0 ||
                degradation > entry.max_damage() ) {
                throw std::invalid_argument(
                    "game.items.update degradation is outside this item's range" );
            }
            result.degradation = static_cast<int>( degradation );
        } else if( key == "burnt" ) {
            const std::int64_t burnt = integer_option(
                                           value, key,
                                           "game.items.update" );
            if( burnt < 0 || burnt > maximum_item_burnt ) {
                throw std::invalid_argument(
                    "game.items.update burnt is outside its limit" );
            }
            if( entry.base_volume() <= 0_ml ) {
                throw std::invalid_argument(
                    "game.items.update cannot set burnt on a zero-volume item" );
            }
            result.burnt = static_cast<int>( burnt );
        } else if( key == "favorite" ) {
            result.favorite = boolean_option(
                                  value, key,
                                  "game.items.update" );
        } else if( key == "active" ) {
            result.active = boolean_option(
                                value, key,
                                "game.items.update" );
        } else if( key == "browsed" ) {
            result.browsed = boolean_option(
                                 value, key,
                                 "game.items.update" );
        } else if( key == "relative_rot" ) {
            if( !value.is<double>() && !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "game.items.update relative_rot must be numeric" );
            }
            const double relative_rot = value.as<double>();
            if( !std::isfinite( relative_rot ) ||
                relative_rot < -maximum_item_relative_rot ||
                relative_rot > maximum_item_relative_rot ) {
                throw std::invalid_argument(
                    "game.items.update relative_rot must be finite and within its limit" );
            }
            if( !entry.goes_bad() ) {
                throw std::invalid_argument(
                    "game.items.update cannot set relative_rot on an item that does not rot" );
            }
            result.relative_rot = relative_rot;
        } else if( key == "rot" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "game.items.update rot must be a TimeDuration" );
            }
            if( !entry.goes_bad() ) {
                throw std::invalid_argument(
                    "game.items.update cannot set rot on an item that does not rot" );
            }
            result.rot = value.as<script_time_duration>().to_native();
        } else {
            throw std::invalid_argument(
                "game.items.update received unknown field '" +
                key + "'" );
        }
        found = true;
    }
    if( !found ) {
        throw std::invalid_argument(
            "game.items.update requires at least one field" );
    }
    if( result.rot && result.relative_rot ) {
        throw std::invalid_argument(
            "game.items.update cannot set rot and relative_rot together" );
    }
    return result;
}

sol::table mutable_item_state(
    sol::state_view lua, const item &entry )
{
    sol::table result = lua.create_table();
    result["uid"] = entry.uid().get_value();
    result["id"] = script_game_id(
                       "item", entry.typeId().str() );
    result["charges"] = entry.charges;
    result["damage"] = entry.damage();
    result["degradation"] = entry.degradation();
    result["damage_level"] = entry.damage_level();
    result["max_damage"] = entry.max_damage();
    result["burnt"] = entry.burnt;
    result["favorite"] = entry.is_favorite;
    result["active"] = entry.is_active();
    result["browsed"] = entry.is_browsed();
    result["temperature_tracked"] = entry.has_temperature();
    result["goes_bad"] = entry.goes_bad();
    result["rot"] =
        script_time_duration::from_native( entry.get_rot() );
    result["relative_rot"] = entry.get_relative_rot();
    return result;
}

sol::table update_item(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    item &entry = *resolved.value;
    const item_updates updates =
        read_item_updates( entry, requested );
    sol::table value = state.create_table();
    value["before"] =
        mutable_item_state( state, entry );
    if( updates.charges ) {
        entry.charges = *updates.charges;
    }
    if( updates.degradation ) {
        entry.set_degradation( *updates.degradation );
    }
    if( updates.damage ) {
        entry.set_damage( *updates.damage );
    }
    if( updates.burnt ) {
        entry.burnt = *updates.burnt;
    }
    if( updates.favorite ) {
        entry.set_favorite( *updates.favorite );
    }
    if( updates.active ) {
        // Temperature-tracked items must remain in the active-item queue.
        entry.active = *updates.active || entry.has_temperature();
    }
    if( updates.browsed ) {
        entry.set_browsed( *updates.browsed );
    }
    if( updates.rot ) {
        entry.set_rot( *updates.rot );
    } else if( updates.relative_rot ) {
        entry.set_relative_rot( *updates.relative_rot );
    }
    value["after"] =
        mutable_item_state( state, entry );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

std::optional<damage_type_id> optional_damage_type(
    const sol::optional<script_game_id> &requested,
    const std::string &api_name )
{
    if( !requested ) {
        return std::nullopt;
    }
    require_id_kind( *requested, "damage_type", api_name );
    return damage_type_id( requested->value() );
}

sol::table item_melee_damage(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<script_game_id> &requested_damage_type,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::optional<damage_type_id> selected_damage_type =
        optional_damage_type(
            requested_damage_type, "game.items.melee_damage" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    int value = 0;
    if( selected_damage_type ) {
        value = resolved.value->damage_melee( *selected_damage_type );
    } else {
        for( const damage_type &entry : damage_type::get_all() ) {
            value += resolved.value->damage_melee( entry.id );
        }
    }
    return make_game_value_result(
               state, sol::make_object( state, value ) );
}

sol::table item_gun_damage(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<script_game_id> &requested_damage_type,
    const sol::optional<bool> &requested_with_ammo,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::optional<damage_type_id> selected_damage_type =
        optional_damage_type(
            requested_damage_type, "game.items.gun_damage" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const damage_instance damage =
        resolved.value->gun_damage(
            requested_with_ammo.value_or( true ) );
    const double value = selected_damage_type ?
                         damage.type_damage( *selected_damage_type ) :
                         damage.total_damage();
    return make_game_value_result(
               state, sol::make_object( state, value ) );
}

sol::table item_quality(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &requested_quality,
    const sol::optional<bool> &requested_strict,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_quality, "quality", "game.items.quality" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const int value = resolved.value->get_quality(
                          quality_id( requested_quality.value() ),
                          requested_strict.value_or( false ) );
    return make_game_value_result(
               state, sol::make_object( state, value ) );
}

struct item_transform_options {
    std::optional<game_handle> carrier;
    std::optional<bool> active;
    std::optional<bool> browsed;
};

item_transform_options read_item_transform_options(
    const sol::optional<sol::table> &requested )
{
    item_transform_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &field : *requested ) {
        const sol::object key_object = field.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.items.transform option names must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = field.second;
        if( key == "carrier" ) {
            if( !value.is<game_handle>() ) {
                throw std::invalid_argument(
                    "game.items.transform option 'carrier' must be a GameHandle" );
            }
            result.carrier = value.as<game_handle>();
        } else if( key == "active" ) {
            result.active = boolean_option(
                                value, key,
                                "game.items.transform" );
        } else if( key == "browsed" ) {
            result.browsed = boolean_option(
                                 value, key,
                                 "game.items.transform" );
        } else {
            throw std::invalid_argument(
                "game.items.transform received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table transform_item(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &target,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        target, "item", "game.items.transform" );
    const item_transform_options options =
        read_item_transform_options( requested );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }

    Character *carrier = nullptr;
    if( options.carrier ) {
        std::optional<game_handle_error> carrier_error;
        carrier = resolve_character(
                      *options.carrier, runtime_generation,
                      world_generation, carrier_error );
        if( carrier == nullptr ) {
            return make_game_error_result(
                       state, *carrier_error );
        }
        if( !carrier->has_item( *resolved.value ) ) {
            return make_game_error_result(
            state, {
                "not_owned",
                "The transform carrier does not own the referenced item"
            } );
        }
    }

    item &entry = *resolved.value;
    sol::table value = state.create_table();
    value["before"] = mutable_item_state( state, entry );
    entry.convert( itype_id( target.value() ), carrier );
    if( options.active ) {
        // Match the native active-item invariant without exposing legacy EOC
        // fields: temperature-tracked items cannot be removed from processing.
        entry.active = *options.active || entry.has_temperature();
    }
    if( options.browsed ) {
        entry.set_browsed( *options.browsed );
    }
    value["after"] = mutable_item_state( state, entry );
    value["changed"] = true;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

void validate_item_var_key(
    const std::string &key, const std::string &api_name )
{
    if( key.empty() ||
        key.size() > maximum_item_var_key_bytes ) {
        throw std::invalid_argument(
            api_name + " key must contain 1 to 128 bytes" );
    }
    if( std::any_of(
            key.begin(), key.end(),
    []( const unsigned char ch ) {
    return ch == '\0' || ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            api_name + " key cannot contain control characters" );
    }
}

sol::table item_var_to_lua(
    sol::state_view lua, const diag_value &value )
{
    sol::table result = lua.create_table();
    if( value.is_dbl() ) {
        result["kind"] = "number";
        result["value"] = value.dbl();
    } else if( value.is_str() ) {
        result["kind"] = "string";
        result["value"] =
            bounded_item_text( value.str() );
    } else if( value.is_tripoint() ) {
        result["kind"] = "coordinate";
        result["value"] =
            script_tripoint_coord::from_native(
                coords::origin::abs,
                coords::scale::map_square,
                value.tripoint().raw() );
    } else if( value.is_empty() ) {
        result["kind"] = "empty";
    } else {
        result["kind"] = "unsupported";
        result["display"] =
            bounded_item_text( value.to_string() );
    }
    return result;
}

sol::table get_item_var(
    sol::this_state lua, const game_handle &handle,
    const std::string &key,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_item_var_key( key, "game.items.get_var" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const diag_value *value =
        resolved.value->maybe_get_value( key );
    if( value == nullptr ) {
        return make_game_error_result(
        state, {
            "not_found",
            "The item does not define that variable"
        } );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, item_var_to_lua(
                       state, *value ) ) );
}

void set_item_var_value(
    item &entry, const std::string &key,
    const sol::object &requested )
{
    if( requested.is<std::string>() ) {
        const std::string value =
            requested.as<std::string>();
        if( value.size() >
            maximum_item_var_string_bytes ) {
            throw std::invalid_argument(
                "game.items.set_var string exceeds 4096 bytes" );
        }
        if( value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "game.items.set_var string cannot contain NUL bytes" );
        }
        entry.set_var( key, value );
        return;
    }
    if( requested.is<script_tripoint_coord>() ) {
        const script_tripoint_coord value =
            requested.as<script_tripoint_coord>();
        if( value.native_origin() != coords::origin::abs ||
            value.native_scale() !=
            coords::scale::map_square ) {
            throw std::invalid_argument(
                "game.items.set_var coordinate must use absolute map squares" );
        }
        entry.set_var(
            key, tripoint_abs_ms( value.to_native() ) );
        return;
    }
    if( requested.is<double>() ) {
        const double value = requested.as<double>();
        if( !std::isfinite( value ) ||
            std::fabs( value ) >
            maximum_item_var_number ) {
            throw std::invalid_argument(
                "game.items.set_var number is outside its limit" );
        }
        entry.set_var( key, value );
        return;
    }
    throw std::invalid_argument(
        "game.items.set_var value must be a string, number, or absolute map-square coordinate" );
}

sol::table set_item_var(
    sol::this_state lua, const game_handle &handle,
    const std::string &key, const sol::object &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_item_var_key( key, "game.items.set_var" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    sol::table value = state.create_table();
    const diag_value *before =
        resolved.value->maybe_get_value( key );
    value["existed"] = before != nullptr;
    if( before != nullptr ) {
        value["before"] =
            item_var_to_lua( state, *before );
    }
    set_item_var_value(
        *resolved.value, key, requested );
    value["after"] = item_var_to_lua(
                         state,
                         resolved.value->get_value( key ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table erase_item_var(
    sol::this_state lua, const game_handle &handle,
    const std::string &key,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_item_var_key( key, "game.items.erase_var" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const bool existed =
        resolved.value->has_var( key );
    if( existed ) {
        resolved.value->erase_var( key );
    }
    return make_game_value_result(
               state, sol::make_object( state, existed ) );
}

sol::table item_has_flag(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &flag,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        flag, "json_flag", "game.items.has_flag" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, resolved.value->has_flag(
                       flag_id( flag.value() ) ) ) );
}

sol::table item_ammo_sufficient(
    sol::this_state lua, const game_handle &item_handle,
    const sol::optional<game_handle> &character_handle,
    const sol::optional<std::string> &method,
    const int quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( quantity <= 0 || quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "game.items.ammo_sufficient quantity must be within 1..1000000000" );
    }
    if( method && method->size() > maximum_item_method_bytes ) {
        throw std::invalid_argument(
            "game.items.ammo_sufficient method exceeds 256 bytes" );
    }
    sol::state_view state( lua );
    const native_handle_result<item> resolved_item =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved_item ) {
        return make_game_error_result(
                   state, *resolved_item.error );
    }

    Character *carrier = &get_avatar();
    if( character_handle ) {
        std::optional<game_handle_error> error;
        carrier = resolve_character(
                      *character_handle, runtime_generation,
                      world_generation, error );
        if( carrier == nullptr ) {
            return make_game_error_result( state, *error );
        }
    }
    const bool sufficient = method ?
                            resolved_item.value->ammo_sufficient(
                                carrier, *method, quantity ) :
                            resolved_item.value->ammo_sufficient(
                                carrier, quantity );
    return make_game_value_result(
               state, sol::make_object( state, sufficient ) );
}

sol::table set_item_flag(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &flag, const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        flag, "json_flag", "game.items.set_flag" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const flag_id native( flag.value() );
    sol::table value = state.create_table();
    value["effective_before"] =
        resolved.value->has_flag( native );
    const bool own_before = resolved.value->has_own_flag( native );
    value["own_before"] = own_before;
    if( enabled ) {
        resolved.value->set_flag( native );
    } else {
        resolved.value->unset_flag( native );
    }
    value["effective_after"] =
        resolved.value->has_flag( native );
    const bool own_after = resolved.value->has_own_flag( native );
    value["own_after"] = own_after;
    value["changed"] = own_before != own_after;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct item_fault_options {
    bool force = false;
    bool message = true;
    std::optional<game_handle> holder;
};

item_fault_options read_item_fault_options(
    const sol::optional<sol::table> &requested )
{
    item_fault_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &field : *requested ) {
        if( field.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.items fault option names must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key == "force" ) {
            result.force = boolean_option(
                               field.second, key,
                               "game.items.set_fault" );
        } else if( key == "message" ) {
            result.message = boolean_option(
                                 field.second, key,
                                 "game.items.set_fault" );
        } else if( key == "holder" ) {
            if( !field.second.is<game_handle>() ) {
                throw std::invalid_argument(
                    "game.items fault option 'holder' must be a GameHandle" );
            }
            result.holder = field.second.as<game_handle>();
        } else {
            throw std::invalid_argument(
                "game.items.set_fault received unknown option '" + key + "'" );
        }
    }
    return result;
}

Character *resolve_fault_holder(
    const std::optional<game_handle> &holder, item &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    if( !holder ) {
        return nullptr;
    }
    Character *character = resolve_character(
                               *holder, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return nullptr;
    }
    if( !character->has_item( entry ) ) {
        error = game_handle_error{
            "not_owned",
            "The fault holder does not own the referenced item"
        };
        return nullptr;
    }
    return character;
}

std::vector<std::string> item_fault_names(
    const item &entry )
{
    std::vector<std::string> result;
    result.reserve( entry.faults.size() );
    for( const fault_id &fault : entry.faults ) {
        result.push_back( fault.str() );
    }
    return result;
}

struct item_activation_options {
    std::optional<tripoint_abs_ms> target;
};

item_activation_options read_item_activation_options(
    const sol::optional<sol::table> &requested )
{
    item_activation_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &field : *requested ) {
        if( field.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.items.activate option names must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key != "target" ) {
            throw std::invalid_argument(
                "game.items.activate received unknown option '" + key + "'" );
        }
        if( !field.second.is<script_tripoint_coord>() ) {
            throw std::invalid_argument(
                "game.items.activate option 'target' must be a Tripoint" );
        }
        const script_tripoint_coord target =
            field.second.as<script_tripoint_coord>();
        if( target.native_origin() != coords::origin::abs ||
            target.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "game.items.activate option 'target' must be an absolute "
                "map-square Tripoint" );
        }
        result.target = tripoint_abs_ms( target.to_native() );
    }
    return result;
}

sol::table activate_item(
    sol::this_state lua, const game_handle &item_handle,
    const game_handle &character_handle, const std::string &method,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( method.empty() || method.size() > maximum_item_method_bytes ||
        method.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "game.items.activate method must contain 1..256 bytes" );
    }
    for( const unsigned char character : method ) {
        if( character < 0x20U || character == 0x7fU ) {
            throw std::invalid_argument(
                "game.items.activate method cannot contain control characters" );
        }
    }
    const item_activation_options options =
        read_item_activation_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const native_handle_result<item> resolved = item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    item *entry = resolved.value;
    if( !character->has_item( *entry ) ) {
        return make_game_error_result( state, {
            "not_owned",
            "The activation character does not own the referenced item"
        } );
    }
    if( entry->get_usable_item( method ) == nullptr ) {
        sol::table value = state.create_table();
        value["accepted"] = false;
        value["destroyed"] = false;
        value["reason"] = "unknown_method";
        return make_game_value_result(
                   state, sol::make_object( state, std::move( value ) ) );
    }

    map &here = get_map();
    tripoint_bub_ms target = character->pos_bub( here );
    if( options.target ) {
        if( !here.inbounds( *options.target ) ) {
            return make_game_error_result( state, {
                "target_out_of_bounds",
                "The activation target is outside the loaded map"
            } );
        }
        target = here.get_bub( *options.target );
    }

    item *actually_used = entry->get_usable_item( method );
    const int before_charges = actually_used->charges;
    const int before_damage = actually_used->damage();
    const bool before_active = actually_used->is_active();
    const bool destroyed = character->invoke_item( entry, method, target );
    const native_handle_result<item> after = item_handle.resolve_item(
            runtime_generation, world_generation );
    item *actually_used_after = after ? after.value->get_usable_item( method ) : nullptr;
    const bool changed = destroyed || ( actually_used_after != nullptr && (
                                           before_charges != actually_used_after->charges ||
                                           before_damage != actually_used_after->damage() ||
                                           before_active != actually_used_after->is_active() ) );
    sol::table value = state.create_table();
    value["accepted"] = changed;
    value["destroyed"] = destroyed || !after;
    value["method"] = method;
    if( after ) {
        value["item"] = snapshot_item( state, *after.value, 16 );
    } else {
        value["item"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_item_fault(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &fault, const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind( fault, "fault", "game.items.set_fault" );
    if( !fault.is_valid() ) {
        throw std::invalid_argument(
            "game.items.set_fault requires a valid GameId<fault>" );
    }
    const item_fault_options options =
        read_item_fault_options( requested );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item( runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    item &entry = *resolved.value;
    std::optional<game_handle_error> holder_error;
    Character *holder = resolve_fault_holder(
                           options.holder, entry,
                           runtime_generation, world_generation,
                           holder_error );
    if( holder_error ) {
        return make_game_error_result( state, *holder_error );
    }
    const fault_id native( fault.value() );
    const bool before = entry.has_fault( native );
    const bool accepted = entry.set_fault(
                               native, options.force,
                               options.message ? holder : nullptr );
    const bool after = entry.has_fault( native );
    sol::table value = state.create_table();
    value["fault"] = fault;
    value["accepted"] = accepted;
    value["before"] = before;
    value["after"] = after;
    value["changed"] = before != after;
    value["force"] = options.force;
    value["message"] = options.message;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_random_item_fault(
    sol::this_state lua, const game_handle &handle,
    const std::string &fault_type, const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( fault_type.empty() ||
        fault_type.size() > maximum_item_method_bytes ||
        fault_type.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "game.items.set_random_fault requires a bounded fault type" );
    }
    const item_fault_options options =
        read_item_fault_options( requested );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item( runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    item &entry = *resolved.value;
    std::optional<game_handle_error> holder_error;
    Character *holder = resolve_fault_holder(
                           options.holder, entry,
                           runtime_generation, world_generation,
                           holder_error );
    if( holder_error ) {
        return make_game_error_result( state, *holder_error );
    }
    const std::vector<std::string> before = item_fault_names( entry );
    entry.set_random_fault_of_type(
        fault_type, options.force,
        options.message ? holder : nullptr );
    const std::vector<std::string> after = item_fault_names( entry );
    sol::table value = state.create_table();
    value["fault_type"] = fault_type;
    value["changed"] = before != after;
    value["before_count"] = before.size();
    value["after_count"] = after.size();
    value["force"] = options.force;
    value["message"] = options.message;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table item_has_technique(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &technique,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        technique, "martial_art_technique",
        "game.items.has_technique" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, resolved.value->has_technique(
                       matec_id( technique.value() ) ) ) );
}

sol::table set_item_technique(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &technique, const bool enabled,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        technique, "martial_art_technique",
        "game.items.set_technique" );
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result(
                   state, *resolved.error );
    }
    const matec_id native( technique.value() );
    sol::table value = state.create_table();
    value["before"] =
        resolved.value->has_technique( native );
    if( enabled ) {
        resolved.value->add_technique( native );
    } else {
        resolved.value->remove_technique( native );
    }
    value["after"] =
        resolved.value->has_technique( native );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table set_item_owner(
    sol::this_state lua, const game_handle &item_handle,
    const game_handle &owner_handle, const bool remember_previous,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    std::optional<game_handle_error> error;
    Character *owner = resolve_character(
                           owner_handle, runtime_generation,
                           world_generation, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( owner->get_faction() == nullptr ) {
        return make_game_error_result( state, {
            "missing_faction",
            "The requested item owner does not have a faction"
        } );
    }
    item &entry = *resolved.value;
    const faction_id before = entry.get_owner();
    const faction_id old_before = entry.get_old_owner();
    if( remember_previous && !before.is_null() &&
        before != owner->get_faction()->id ) {
        entry.set_old_owner( before );
    }
    entry.set_owner( *owner );
    sol::table value = state.create_table();
    value["changed"] = before != entry.get_owner() ||
                       old_before != entry.get_old_owner();
    if( before.is_null() ) {
        value["before"] = sol::nil;
    } else {
        value["before"] = script_game_id(
                              "faction", before.str() );
    }
    value["after"] = script_game_id(
                         "faction", entry.get_owner().str() );
    if( entry.get_old_owner().is_null() ) {
        value["old_owner"] = sol::nil;
    } else {
        value["old_owner"] = script_game_id(
                                 "faction",
                                 entry.get_old_owner().str() );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table clear_item_owner(
    sol::this_state lua, const game_handle &item_handle,
    const bool remember_previous,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    item &entry = *resolved.value;
    const faction_id before = entry.get_owner();
    const faction_id old_before = entry.get_old_owner();
    if( remember_previous && !before.is_null() ) {
        entry.set_old_owner( before );
    }
    entry.remove_owner();
    sol::table value = state.create_table();
    value["changed"] = !before.is_null() ||
                       old_before != entry.get_old_owner();
    if( before.is_null() ) {
        value["before"] = sol::nil;
    } else {
        value["before"] = script_game_id(
                              "faction", before.str() );
    }
    if( entry.get_old_owner().is_null() ) {
        value["old_owner"] = sol::nil;
    } else {
        value["old_owner"] = script_game_id(
                                 "faction",
                                 entry.get_old_owner().str() );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table clear_item_old_owner(
    sol::this_state lua, const game_handle &item_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const native_handle_result<item> resolved =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    const faction_id before =
        resolved.value->get_old_owner();
    resolved.value->remove_old_owner();
    sol::table value = state.create_table();
    value["changed"] = !before.is_null();
    if( before.is_null() ) {
        value["before"] = sol::nil;
    } else {
        value["before"] = script_game_id(
                              "faction", before.str() );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

struct inventory_give_options {
    bool allow_wield = false;
    std::optional<itype_id> container;
    std::vector<flag_id> flags;
};

inventory_give_options read_inventory_give_options(
    const sol::optional<sol::table> &requested )
{
    inventory_give_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        const sol::object key_object = entry.first;
        if( key_object.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.inventory.give option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        if( key == "allow_wield" ) {
            result.allow_wield = boolean_option(
                                     entry.second, key,
                                     "game.inventory.give" );
        } else if( key == "container" ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "game.inventory.give container must be a GameId<item>" );
            }
            const script_game_id id =
                entry.second.as<script_game_id>();
            require_id_kind(
                id, "item", "game.inventory.give" );
            result.container = itype_id( id.value() );
        } else if( key == "flags" ) {
            if( !entry.second.is<sol::table>() ) {
                throw std::invalid_argument(
                    "game.inventory.give flags must be a dense GameId array" );
            }
            const sol::table flags =
                entry.second.as<sol::table>();
            std::map<std::size_t, flag_id> indexed;
            for( const auto &flag_entry : flags ) {
                if( !flag_entry.first.is<lua_Integer>() ||
                    !flag_entry.second.is<script_game_id>() ) {
                    throw std::invalid_argument(
                        "game.inventory.give flags must be a dense GameId array" );
                }
                const lua_Integer raw_index =
                    flag_entry.first.as<lua_Integer>();
                if( raw_index <= 0 ||
                    static_cast<std::uint64_t>( raw_index ) >
                    maximum_inventory_spawn_flags ) {
                    throw std::invalid_argument(
                        "game.inventory.give flag index must be within 1..128" );
                }
                const script_game_id id =
                    flag_entry.second.as<script_game_id>();
                require_id_kind(
                    id, "json_flag", "game.inventory.give" );
                indexed.emplace(
                    static_cast<std::size_t>( raw_index ),
                    flag_id( id.value() ) );
            }
            if( !indexed.empty() &&
                indexed.rbegin()->first != indexed.size() ) {
                throw std::invalid_argument(
                    "game.inventory.give flags must not contain holes" );
            }
            for( const auto &[index, flag] : indexed ) {
                static_cast<void>( index );
                result.flags.push_back( flag );
            }
        } else {
            throw std::invalid_argument(
                "game.inventory.give received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

void configure_spawned_inventory_item(
    item &entry, const inventory_give_options &options,
    const tripoint_abs_ms &position )
{
    for( const flag_id &flag : options.flags ) {
        entry.set_flag( flag );
    }
    if( entry.has_flag(
            flag_id( "PRESERVE_SPAWN_LOC" ) ) ) {
        entry.preserve_location( position );
    }
}

sol::table character_item_to_lua(
    sol::state_view lua, Character &character, item &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::vector<item *> parents =
        character.parents( entry );
    std::string location = "carried";
    if( character.is_wielding( entry ) ) {
        location = "wielded";
    } else if( character.is_worn( entry ) ) {
        location = "worn";
    } else if( !parents.empty() ) {
        location = "contained";
    }

    game_handle_locator locator;
    locator.scope = "character_" + location;
    locator.stable_id = entry.uid().get_value();
    const tripoint_abs_ms position = character.pos_abs();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();

    sol::table result = lua.create_table();
    result["handle"] = game_handle::from_item(
                           entry, std::move( locator ),
                           runtime_generation, world_generation );
    result["uid"] = entry.uid().get_value();
    result["id"] = script_game_id(
                       "item", entry.typeId().str() );
    result["name"] = bounded_item_text(
                         entry.display_name() );
    result["location"] = location;
    result["depth"] =
        static_cast<int>( parents.size() );
    if( !parents.empty() ) {
        result["parent_uid"] =
            parents.front()->uid().get_value();
    }
    return result;
}

bool resolve_owned_item(
    const game_handle &character_handle,
    const game_handle &item_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    Character *&character, item *&entry,
    std::optional<game_handle_error> &error )
{
    character = resolve_character(
                    character_handle, runtime_generation,
                    world_generation, error );
    if( character == nullptr ) {
        return false;
    }
    const native_handle_result<item> resolved =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return false;
    }
    if( !character->has_item( *resolved.value ) ) {
        error = game_handle_error{
            "not_owned",
            "The item referenced by this GameHandle is not carried by that character"
        };
        return false;
    }
    entry = resolved.value;
    return true;
}

struct inventory_selection_candidate {
    game_handle handle;
    item *value = nullptr;
};

struct map_inventory_selection_options {
    std::string title;
    bool accessible = true;
};

std::vector<inventory_selection_candidate> inventory_selection_candidates(
    const sol::table &requested,
    Character &character,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::string &api_name )
{
    if( requested.size() == 0 ||
        requested.size() > maximum_inventory_selection_items ) {
        throw std::invalid_argument(
            api_name + " requires 1..512 candidate item handles" );
    }
    std::vector<inventory_selection_candidate> result;
    result.reserve( requested.size() );
    std::set<item *> seen;
    for( std::size_t index = 1;
         index <= requested.size(); ++index ) {
        const sol::object requested_handle =
            requested.raw_get<sol::object>( index );
        if( !requested_handle.is<game_handle>() ) {
            throw std::invalid_argument(
                api_name + " candidates must be a dense array of GameHandle values" );
        }
        const game_handle handle =
            requested_handle.as<game_handle>();
        const native_handle_result<item> resolved =
            handle.resolve_item(
                runtime_generation, world_generation );
        if( !resolved ) {
            throw std::invalid_argument(
                api_name + " received a stale or invalid item handle" );
        }
        if( !character.has_item( *resolved.value ) ) {
            throw std::invalid_argument(
                api_name + " candidates must belong to the selected character" );
        }
        if( !seen.emplace( resolved.value ).second ) {
            throw std::invalid_argument(
                api_name + " candidate item handles must be unique" );
        }
        result.push_back( { handle, resolved.value } );
    }
    return result;
}

std::vector<inventory_selection_candidate> map_inventory_selection_candidates(
    const sol::table &requested,
    map &here,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    const std::string &api_name,
    std::vector<tripoint_bub_ms> &positions )
{
    if( requested.size() == 0 ||
        requested.size() > maximum_inventory_selection_items ) {
        throw std::invalid_argument(
            api_name + " requires 1..512 candidate item handles" );
    }
    std::vector<inventory_selection_candidate> result;
    result.reserve( requested.size() );
    std::set<item *> seen;
    for( std::size_t index = 1;
         index <= requested.size(); ++index ) {
        const sol::object requested_handle =
            requested.raw_get<sol::object>( index );
        if( !requested_handle.is<game_handle>() ) {
            throw std::invalid_argument(
                api_name + " candidates must be a dense array of GameHandle values" );
        }
        const game_handle handle =
            requested_handle.as<game_handle>();
        const game_handle_locator &locator = handle.locator();
        if( locator.scope != "map" || !locator.path.empty() ) {
            throw std::invalid_argument(
                api_name + " candidates must be top-level map item handles" );
        }
        const native_handle_result<item> resolved =
            handle.resolve_item(
                runtime_generation, world_generation );
        if( !resolved ) {
            throw std::invalid_argument(
                api_name + " received a stale or invalid item handle" );
        }
        const tripoint_abs_ms absolute(
            locator.x, locator.y, locator.z );
        if( !here.inbounds( absolute ) ) {
            throw std::invalid_argument(
                api_name + " candidate item is outside the active map" );
        }
        const tripoint_bub_ms local = here.get_bub( absolute );
        map_stack stack = here.i_at( local );
        const bool at_location = std::any_of(
                                     stack.begin(), stack.end(),
        [&resolved]( item & candidate ) {
            return &candidate == resolved.value;
        } );
        if( !at_location ) {
            throw std::invalid_argument(
                api_name + " candidate item moved from its map position" );
        }
        if( !seen.emplace( resolved.value ).second ) {
            throw std::invalid_argument(
                api_name + " candidate item handles must be unique" );
        }
        if( std::find( positions.begin(), positions.end(), local ) ==
            positions.end() ) {
            positions.push_back( local );
        }
        result.push_back( { handle, resolved.value } );
    }
    return result;
}

std::string inventory_selection_title(
    const sol::optional<std::string> &requested,
    const std::string &fallback,
    const std::string &api_name )
{
    const std::string result = requested.value_or( fallback );
    if( result.empty() ||
        result.size() > maximum_inventory_selection_title_bytes ||
        result.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            api_name + " title must contain 1..512 bytes without NUL" );
    }
    return result;
}

map_inventory_selection_options read_map_inventory_selection_options(
    const sol::optional<sol::table> &requested,
    const std::string &fallback,
    const std::string &api_name )
{
    map_inventory_selection_options result;
    result.title = fallback;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                api_name + " option names must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key == "title" ) {
            if( !entry.second.is<std::string>() ) {
                throw std::invalid_argument(
                    api_name + " option 'title' must be a string" );
            }
            result.title = inventory_selection_title(
                               sol::optional<std::string>(
                                   entry.second.as<std::string>() ),
                               fallback, api_name );
        } else if( key == "accessible" ) {
            if( !entry.second.is<bool>() ) {
                throw std::invalid_argument(
                    api_name + " option 'accessible' must be boolean" );
            }
            result.accessible = entry.second.as<bool>();
        } else {
            throw std::invalid_argument(
                api_name + " received unknown option '" + key + "'" );
        }
    }
    return result;
}

const inventory_selection_candidate *find_selection_candidate(
    const std::vector<inventory_selection_candidate> &candidates,
    const item *selected )
{
    const auto found = std::find_if(
                           candidates.begin(), candidates.end(),
    [selected]( const inventory_selection_candidate & candidate ) {
        return candidate.value == selected;
    } );
    return found == candidates.end() ? nullptr : &*found;
}

sol::table choose_inventory_item(
    sol::this_state lua,
    const game_handle &character_handle,
    const sol::table &requested_candidates,
    const sol::optional<std::string> &requested_title,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.inventory.choose";
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle,
                               runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::vector<inventory_selection_candidate> candidates =
        inventory_selection_candidates(
            requested_candidates, *character,
            runtime_generation, world_generation,
            std::string( api_name ) );
    std::set<const item *> allowed;
    for( const inventory_selection_candidate &candidate : candidates ) {
        allowed.emplace( candidate.value );
    }
    const item_location_filter filter =
    [&allowed]( const item_location & location ) {
        return location.get_item() != nullptr &&
               allowed.count( location.get_item() ) > 0;
    };
    const item_location selected =
        game_menus::inv::titled_filter_menu(
            filter, *character,
            inventory_selection_title(
                requested_title, "Select an item.",
                std::string( api_name ) ) );
    const inventory_selection_candidate *match =
        selected ? find_selection_candidate(
                       candidates, selected.get_item() ) : nullptr;
    sol::table value = state.create_table();
    value["accepted"] = match != nullptr;
    value["cancelled"] = match == nullptr;
    if( match == nullptr ) {
        value["item"] = sol::nil;
        value["quantity"] = 0;
    } else {
        value["item"] = match->handle;
        value["quantity"] = match->value->count_by_charges() ?
                            std::max( match->value->charges, 0 ) : 1;
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table choose_inventory_items(
    sol::this_state lua,
    const game_handle &character_handle,
    const sol::table &requested_candidates,
    const sol::optional<std::string> &requested_title,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.inventory.choose_many";
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle,
                               runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::vector<inventory_selection_candidate> candidates =
        inventory_selection_candidates(
            requested_candidates, *character,
            runtime_generation, world_generation,
            std::string( api_name ) );
    std::set<const item *> allowed;
    for( const inventory_selection_candidate &candidate : candidates ) {
        allowed.emplace( candidate.value );
    }
    const item_location_filter filter =
    [&allowed]( const item_location & location ) {
        return location.get_item() != nullptr &&
               allowed.count( location.get_item() ) > 0;
    };
    const drop_locations selected =
        game_menus::inv::titled_multi_filter_menu(
            filter, *character,
            inventory_selection_title(
                requested_title, "Select items.",
                std::string( api_name ) ) );
    sol::table items = state.create_table(
                           static_cast<int>( selected.size() ), 0 );
    std::size_t output_index = 0;
    for( const drop_location &selection : selected ) {
        const inventory_selection_candidate *match =
            find_selection_candidate(
                candidates, selection.first.get_item() );
        if( match == nullptr ) {
            continue;
        }
        sol::table row = state.create_table();
        row["item"] = match->handle;
        row["quantity"] = selection.second;
        items[++output_index] = std::move( row );
    }
    sol::table value = state.create_table();
    value["accepted"] = output_index > 0;
    value["cancelled"] = output_index == 0;
    value["items"] = std::move( items );
    value["count"] = output_index;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table choose_map_inventory_items(
    sol::this_state lua,
    const game_handle &character_handle,
    const sol::table &requested_candidates,
    const sol::optional<sol::table> &requested_options,
    const bool multiple,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::string api_name = multiple ?
                                 "game.inventory.choose_many_map" :
                                 "game.inventory.choose_map";
    const map_inventory_selection_options options =
        read_map_inventory_selection_options(
            requested_options,
            multiple ? "Select items." : "Select an item.",
            api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle,
                               runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    map &here = get_map();
    std::vector<tripoint_bub_ms> positions;
    const std::vector<inventory_selection_candidate> candidates =
        map_inventory_selection_candidates(
            requested_candidates, here,
            runtime_generation, world_generation,
            api_name, positions );
    std::set<const item *> allowed;
    for( const inventory_selection_candidate &candidate : candidates ) {
        allowed.emplace( candidate.value );
    }
    const item_location_filter filter =
    [&allowed]( const item_location & location ) {
        return location.get_item() != nullptr &&
               allowed.count( location.get_item() ) > 0;
    };
    inventory_filter_preset preset( filter );
    if( !multiple ) {
        inventory_pick_selector selector( *character, preset );
        selector.set_title( options.title );
        selector.set_display_stats( false );
        selector.clear_items();
        for( const tripoint_bub_ms &position : positions ) {
            if( options.accessible ) {
                selector.add_map_items( position );
            } else {
                selector.add_inaccessible_map_items( position );
            }
        }
        const item_location selected = selector.empty() ?
                                       item_location() : selector.execute();
        const inventory_selection_candidate *match =
            selected ? find_selection_candidate(
                           candidates, selected.get_item() ) : nullptr;
        sol::table value = state.create_table();
        value["accepted"] = match != nullptr;
        value["cancelled"] = match == nullptr;
        value["accessible"] = options.accessible;
        if( match == nullptr ) {
            value["item"] = sol::nil;
            value["quantity"] = 0;
        } else {
            value["item"] = match->handle;
            value["quantity"] = match->value->count_by_charges() ?
                                std::max( match->value->charges, 0 ) : 1;
        }
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    inventory_multiselector selector( *character, preset );
    selector.set_title( options.title );
    selector.set_display_stats( false );
    selector.clear_items();
    for( const tripoint_bub_ms &position : positions ) {
        if( options.accessible ) {
            selector.add_map_items( position );
        } else {
            selector.add_inaccessible_map_items( position );
        }
    }
    const drop_locations selected = selector.empty() ?
                                    drop_locations() : selector.execute();
    sol::table items = state.create_table(
                           static_cast<int>( selected.size() ), 0 );
    std::size_t output_index = 0;
    for( const drop_location &selection : selected ) {
        const inventory_selection_candidate *match =
            find_selection_candidate(
                candidates, selection.first.get_item() );
        if( match == nullptr ) {
            continue;
        }
        sol::table row = state.create_table();
        row["item"] = match->handle;
        row["quantity"] = selection.second;
        items[++output_index] = std::move( row );
    }
    sol::table value = state.create_table();
    value["accepted"] = output_index > 0;
    value["cancelled"] = output_index == 0;
    value["accessible"] = options.accessible;
    value["items"] = std::move( items );
    value["count"] = output_index;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table inventory_resources(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &type, const std::int64_t quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        type, "item", "game.inventory.resources" );
    if( quantity < 0 ||
        quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "game.inventory.resources quantity is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const itype_id native( type.value() );
    const int requested = static_cast<int>( quantity );
    sol::table value = state.create_table();
    value["id"] = type;
    value["quantity"] = requested;
    value["amount"] = character->amount_of(
                          native, false,
                          maximum_inventory_resource_quantity );
    value["charges"] = character->charges_of(
                           native,
                           maximum_inventory_resource_quantity );
    value["has_amount"] = character->has_amount(
                              native, requested, false );
    value["has_charges"] = character->has_charges(
                               native, requested );
    value["has_tools"] = character->has_tools(
                             native, requested );
    value["has_components"] =
        character->has_components(
            native, requested );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table inventory_has_items_sum(
    sol::this_state lua, const game_handle &character_handle,
    const sol::table &requested_entries,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "game.inventory.has_items_sum";
    const std::size_t entry_count = requested_entries.size();
    if( entry_count == 0 || entry_count > maximum_inventory_sum_entries ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires 1..128 weighted item entries" );
    }
    struct weighted_entry {
        script_game_id id;
        double desired = 0.0;
    };
    std::vector<weighted_entry> entries;
    entries.reserve( entry_count );
    for( std::size_t index = 1; index <= entry_count; ++index ) {
        const sol::object row_object = requested_entries[index];
        if( !row_object.is<sol::table>() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " entries must be a dense table array" );
        }
        const sol::table row = row_object.as<sol::table>();
        const sol::object id_object = row["item"];
        const sol::object amount_object = row["amount"];
        if( !id_object.is<script_game_id>() ||
            amount_object.get_type() != sol::type::number ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " entries require item and numeric amount fields" );
        }
        const script_game_id id = id_object.as<script_game_id>();
        require_id_kind( id, "item", std::string( api_name ) );
        const double desired = amount_object.as<double>();
        if( !std::isfinite( desired ) || desired <= 0.0 ||
            desired > maximum_inventory_resource_quantity ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " amount must be finite and within 0..1000000000" );
        }
        entries.push_back( { id, desired } );
    }

    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const inventory available_inventory = character->crafting_inventory();
    double coverage = 0.0;
    for( const weighted_entry &entry : entries ) {
        const itype_id native( entry.id.value() );
        const double count_present = available_inventory.amount_of( native );
        const double charges_present = available_inventory.charges_of( native );
        coverage += std::max( count_present, charges_present ) / entry.desired;
        if( coverage >= 1.0 ) {
            return make_game_value_result(
                       state, sol::make_object( state, true ) );
        }
    }
    return make_game_value_result(
               state, sol::make_object( state, false ) );
}

sol::table inventory_has_software(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &software,
    const sol::optional<std::int64_t> &requested_minimum_charges,
    const sol::optional<script_game_id> &requested_device,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.inventory.has_software";
    require_id_kind( software, "item", std::string( api_name ) );
    if( requested_device ) {
        require_id_kind(
            *requested_device, "item", std::string( api_name ) );
    }
    const std::int64_t minimum_charges =
        requested_minimum_charges.value_or( 0 );
    if( minimum_charges < 0 ||
        minimum_charges > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " minimum_charges must be within 0..INT_MAX" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const itype_id device = requested_device ?
                            itype_id( requested_device->value() ) :
                            itype_id::NULL_ID();
    const bool present = character->has_software(
                             itype_id( software.value() ),
                             static_cast<int>( minimum_charges ), device );
    return make_game_value_result(
               state, sol::make_object( state, present ) );
}

sol::table inventory_has_worn_flag(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &requested_flag,
    const sol::optional<script_game_id> &requested_body_part,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.inventory.has_worn_flag";
    require_id_kind(
        requested_flag, "json_flag", std::string( api_name ) );
    if( requested_body_part ) {
        require_id_kind(
            *requested_body_part, "body_part",
            std::string( api_name ) );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const flag_id flag( requested_flag.value() );
    const bool present = requested_body_part ?
                         character->worn_with_flag(
                             flag, bodypart_str_id(
                                 requested_body_part->value() ).id() ) :
                         character->worn_with_flag( flag );
    return make_game_value_result(
               state, sol::make_object( state, present ) );
}

sol::table inventory_is_wearing(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &requested_item,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_item, "item", "game.inventory.is_wearing" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, character->is_wearing(
                       itype_id( requested_item.value() ) ) ) );
}

sol::table inventory_has_item_flag(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &requested_flag,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_flag, "json_flag",
        "game.inventory.has_item_flag" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, character->has_item_with_flag(
                       flag_id( requested_flag.value() ) ) ) );
}

sol::table inventory_category_count(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &requested_category,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_category, "item_category",
        "game.inventory.category_count" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const item_category_id category(
        requested_category.value() );
    const std::vector<item *> matches = character->items_with(
    [&category]( const item & entry ) {
        return entry.get_category_shallow().get_id() == category;
    } );
    return make_game_value_result(
               state, sol::make_object(
                   state, matches.size() ) );
}

std::optional<aggregate_type> item_radiation_aggregate(
    const std::string_view requested )
{
    if( requested == "first" ) {
        return aggregate_type::FIRST;
    }
    if( requested == "last" ) {
        return aggregate_type::LAST;
    }
    if( requested == "min" ) {
        return aggregate_type::MIN;
    }
    if( requested == "max" ) {
        return aggregate_type::MAX;
    }
    if( requested == "sum" ) {
        return aggregate_type::SUM;
    }
    if( requested == "average" ) {
        return aggregate_type::AVERAGE;
    }
    return std::nullopt;
}

sol::table inventory_item_radiation(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &requested_flag,
    const sol::optional<std::string> &requested_aggregate,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        requested_flag, "json_flag",
        "game.inventory.item_radiation" );
    const std::string aggregate_name =
        requested_aggregate.value_or( "min" );
    const std::optional<aggregate_type> aggregate_kind =
        item_radiation_aggregate( aggregate_name );
    if( !aggregate_kind ) {
        throw std::invalid_argument(
            "game.inventory.item_radiation aggregate must be first, last, min, max, sum, or average" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const flag_id flag( requested_flag.value() );
    std::vector<int> values;
    for( item *entry : character->items_with(
    [&flag]( const item & candidate ) {
    return candidate.has_flag( flag );
} ) ) {
        if( entry != nullptr &&
            ( character->is_worn( *entry ) ||
              character->is_wielding( *entry ) ) ) {
            values.push_back( entry->irradiation );
        }
    }
    sol::table value = state.create_table();
    value["value"] = aggregate( values, *aggregate_kind );
    value["count"] = values.size();
    value["aggregate"] = aggregate_name;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table inventory_wielded_matches(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &criterion,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name =
        "game.inventory.wielded_matches";
    const std::string &kind = criterion.kind();
    if( kind != "json_flag" && kind != "weapon_category" &&
        kind != "skill" && kind != "ammunition" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<json_flag|weapon_category|skill|ammunition>" );
    }
    if( !criterion.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid criterion GameId" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const item_location wielded =
        character->get_wielded_item();
    bool matches = false;
    if( wielded ) {
        const item &entry = *wielded;
        if( kind == "json_flag" ) {
            matches = entry.has_flag(
                          flag_id( criterion.value() ) );
        } else if( kind == "weapon_category" ) {
            matches = entry.typeId()->weapon_category.count(
                          weapon_category_id( criterion.value() ) ) > 0;
        } else if( kind == "skill" ) {
            const skill_id used_skill = entry.is_gun() ?
                                        entry.gun_skill() :
                                        entry.melee_skill();
            matches = used_skill == skill_id( criterion.value() );
        } else {
            matches = entry.ammo_types().count(
                          ammotype( criterion.value() ) ) > 0;
        }
    }
    return make_game_value_result(
               state, sol::make_object( state, matches ) );
}

sol::table inventory_has_stolen_from(
    sol::this_state lua, const game_handle &holder_handle,
    const game_handle &owner_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *holder = resolve_character(
                            holder_handle, runtime_generation,
                            world_generation, error );
    if( holder == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *owner = resolve_character(
                           owner_handle, runtime_generation,
                           world_generation, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::vector<item *> items = holder->inv_dump();
    const bool present = std::any_of(
                             items.begin(), items.end(),
    [owner]( const item * entry ) {
        return entry != nullptr && entry->is_old_owner( *owner, true );
    } );
    return make_game_value_result(
               state, sol::make_object( state, present ) );
}

sol::table inventory_weapon_state(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const item_location wielded = character->get_wielded_item();
    const bool armed = !character->unarmed_attack() && wielded;
    bool can_stow = false;
    bool can_drop = false;
    if( armed ) {
        const std::optional<bionic *> bionic_weapon =
            character->find_bionic_by_uid(
                character->get_weapon_bionic_uid() );
        can_stow = bionic_weapon &&
                   character->can_deactivate_bionic(
                       **bionic_weapon ).success();
        if( !can_stow ) {
            can_stow = character->can_pickVolume( *wielded );
        }
        can_drop = !wielded->has_flag(
                       flag_id( "NO_UNWIELD" ) );
    }
    sol::table value = state.create_table();
    value["armed"] = armed;
    value["can_stow"] = can_stow;
    value["can_drop"] = can_drop;
    if( wielded ) {
        value["id"] = script_game_id(
                          "item", wielded->typeId().str() );
        value["uid"] = wielded->uid().get_value();
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table give_inventory_items(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &type, const std::int64_t quantity,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        type, "item", "game.inventory.give" );
    if( quantity <= 0 ||
        quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "game.inventory.give quantity is outside its limit" );
    }
    const inventory_give_options options =
        read_inventory_give_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    const itype_id native( type.value() );
    const item prototype( native, calendar::turn );
    const bool counted_by_charges =
        prototype.count_by_charges();
    if( !counted_by_charges && !options.container &&
        quantity > maximum_inventory_give_instances ) {
        throw std::invalid_argument(
            "game.inventory.give cannot create more than 100 item instances at once" );
    }

    const int attempts = options.container || counted_by_charges ? 1 :
                         static_cast<int>( quantity );
    sol::table items = state.create_table( attempts, 0 );
    int returned = 0;
    std::int64_t added_quantity = 0;
    for( int index = 0; index < attempts; ++index ) {
        item created;
        if( options.container ) {
            item contents( native, calendar::turn );
            contents.charges = static_cast<int>( quantity );
            configure_spawned_inventory_item(
                contents, options, character->pos_abs() );
            created = item( *options.container, calendar::turn );
            created.put_in(
                contents, pocket_type::CONTAINER );
        } else {
            created = item(
                          native, calendar::turn,
                          counted_by_charges ?
                          static_cast<int>( quantity ) : -1 );
            configure_spawned_inventory_item(
                created, options, character->pos_abs() );
        }
        item_location added = character->i_add(
                                  created, true, nullptr, nullptr,
                                  false, options.allow_wield );
        if( !added || !added.held_by( *character ) ) {
            break;
        }
        ++returned;
        added_quantity += options.container || counted_by_charges ?
                          quantity : 1;
        items[returned] = character_item_to_lua(
                              state, *character, *added,
                              runtime_generation,
                              world_generation );
    }
    character->invalidate_crafting_inventory();

    sol::table value = state.create_table();
    value["id"] = type;
    value["requested"] = quantity;
    value["added"] = added_quantity;
    value["rejected"] =
        quantity - added_quantity;
    value["count_by_charges"] =
        counted_by_charges;
    value["instances"] = returned;
    value["items"] = std::move( items );
    value["allow_wield"] = options.allow_wield;
    value["contained"] = static_cast<bool>( options.container );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table give_inventory_item_group(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &group,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        group, "item_group", "game.inventory.give_group" );
    const inventory_give_options options =
        read_inventory_give_options( requested );
    if( options.container ) {
        throw std::invalid_argument(
            "game.inventory.give_group does not support a container option because groups preserve their native containers" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    item_group::ItemList generated = item_group::items_from(
                                         item_group_id( group.value() ),
                                         calendar::turn );
    if( generated.size() > maximum_inventory_group_items ) {
        return make_game_error_result( state, {
            "result_limit",
            "The item group generated more than 256 top-level items"
        } );
    }
    sol::table items = state.create_table(
                           static_cast<int>( generated.size() ), 0 );
    std::size_t added = 0;
    for( item &created : generated ) {
        configure_spawned_inventory_item(
            created, options, character->pos_abs() );
        item_location location = character->i_add(
                                     created, true, nullptr, nullptr,
                                     false, options.allow_wield );
        if( !location || !location.held_by( *character ) ) {
            break;
        }
        ++added;
        items[added] = character_item_to_lua(
                           state, *character, *location,
                           runtime_generation, world_generation );
    }
    character->invalidate_crafting_inventory();
    sol::table value = state.create_table();
    value["group"] = group;
    value["generated"] = generated.size();
    value["added"] = added;
    value["rejected"] = generated.size() - added;
    value["items"] = std::move( items );
    value["allow_wield"] = options.allow_wield;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table consume_inventory_items(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &type, const std::int64_t requested_count,
    const std::int64_t requested_charges,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    require_id_kind(
        type, "item", "game.inventory.consume" );
    if( requested_count < 0 ||
        requested_count > maximum_inventory_resource_quantity ||
        requested_charges < 0 ||
        requested_charges > maximum_inventory_resource_quantity ||
        ( requested_count == 0 && requested_charges == 0 ) ) {
        throw std::invalid_argument(
            "game.inventory.consume count and charges must be bounded nonnegative values with a positive total" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const itype_id native_type( type.value() );
    std::int64_t count = requested_count;
    std::int64_t charges = requested_charges;
    if( charges == 0 && item::count_by_charges( native_type ) ) {
        charges = count;
        count = 0;
    }
    if( count > std::numeric_limits<int>::max() ||
        charges > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            "game.inventory.consume request exceeds native integer bounds" );
    }
    if( charges > 0 &&
        !character->has_charges(
            native_type, static_cast<int>( charges ) ) ) {
        return make_game_error_result( state, {
            "insufficient_charges",
            "The character does not have enough matching charges"
        } );
    }
    if( count > 0 &&
        !character->has_amount(
            native_type, static_cast<int>( count ) ) ) {
        return make_game_error_result( state, {
            "insufficient_items",
            "The character does not have enough matching item instances"
        } );
    }

    std::list<item> consumed_charges;
    std::list<item> consumed_items;
    if( charges > 0 ) {
        consumed_charges = character->use_charges(
                               native_type,
                               static_cast<int>( charges ) );
    }
    if( count > 0 ) {
        consumed_items = character->use_amount(
                             native_type,
                             static_cast<int>( count ) );
    }
    character->invalidate_crafting_inventory();
    sol::table value = state.create_table();
    value["id"] = type;
    value["count"] = count;
    value["charges"] = charges;
    value["item_fragments"] = consumed_items.size();
    value["charge_fragments"] = consumed_charges.size();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table hand_in_inventory_items(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle &recipient_handle,
    const script_game_id &type, const std::int64_t requested_count,
    const std::int64_t requested_charges,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *recipient = resolve_character(
                               recipient_handle, runtime_generation,
                               world_generation, error );
    if( recipient == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table result = consume_inventory_items(
                            lua, character_handle, type,
                            requested_count, requested_charges,
                            runtime_generation, world_generation );
    if( !result.get_or( "ok", false ) ) {
        return result;
    }
    const sol::object raw_value = result["value"];
    if( !raw_value.is<sol::table>() ) {
        throw std::runtime_error(
            "game.inventory.hand_in received an invalid consumption result" );
    }
    sol::table value = raw_value.as<sol::table>();
    const itype_id native_type( type.value() );
    const int display_count = static_cast<int>( std::max<std::int64_t>(
                                  1, requested_count ) );
    if( display_count == 1 ) {
        value["notice"] = string_format(
                              _( "You give %1$s a %2$s." ),
                              recipient->get_name(),
                              item::nname( native_type ) );
    } else {
        value["notice"] = string_format(
                              _( "You give %1$s %2$d %3$s." ),
                              recipient->get_name(), display_count,
                              item::nname( native_type, display_count ) );
    }
    return result;
}

sol::table consume_inventory_sum(
    sol::this_state lua, const game_handle &character_handle,
    const sol::table &requested_entries,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const std::size_t entry_count = requested_entries.size();
    if( entry_count == 0 ||
        entry_count > maximum_inventory_sum_entries ) {
        throw std::invalid_argument(
            "game.inventory.consume_sum requires 1..128 weighted item entries" );
    }
    struct weighted_entry {
        script_game_id id;
        double desired = 0.0;
        int available = 0;
        int consume = 0;
    };
    std::vector<weighted_entry> entries;
    entries.reserve( entry_count );
    for( std::size_t index = 1; index <= entry_count; ++index ) {
        const sol::object row_object = requested_entries[index];
        if( !row_object.is<sol::table>() ) {
            throw std::invalid_argument(
                "game.inventory.consume_sum entries must be a dense table array" );
        }
        const sol::table row = row_object.as<sol::table>();
        const sol::object id_object = row["item"];
        const sol::object amount_object = row["amount"];
        if( !id_object.is<script_game_id>() ||
            amount_object.get_type() != sol::type::number ) {
            throw std::invalid_argument(
                "game.inventory.consume_sum entries require item and numeric amount fields" );
        }
        const script_game_id id =
            id_object.as<script_game_id>();
        require_id_kind(
            id, "item", "game.inventory.consume_sum" );
        const double desired = amount_object.as<double>();
        if( !std::isfinite( desired ) || desired <= 0.0 ||
            desired > maximum_inventory_resource_quantity ) {
            throw std::invalid_argument(
                "game.inventory.consume_sum amount must be finite and within 0..1000000000" );
        }
        entries.push_back( { id, desired, 0, 0 } );
    }

    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const inventory &available_inventory =
        character->crafting_inventory();
    double coverage = 0.0;
    for( weighted_entry &entry : entries ) {
        entry.available = available_inventory.count_item(
                              itype_id( entry.id.value() ) );
        if( entry.available <= 0 || coverage >= 1.0 ) {
            continue;
        }
        const double remaining = 1.0 - coverage;
        const int needed = static_cast<int>( std::ceil(
                                                remaining * entry.desired -
                                                std::numeric_limits<double>::epsilon() ) );
        entry.consume = std::min(
                            entry.available, std::max( 0, needed ) );
        coverage += entry.consume / entry.desired;
    }

    sol::table consumed = state.create_table(
                              static_cast<int>( entries.size() ), 0 );
    std::size_t output_index = 0;
    for( const weighted_entry &entry : entries ) {
        if( entry.consume <= 0 ) {
            continue;
        }
        const std::vector<item_comp> components = {
            item_comp(
                itype_id( entry.id.value() ), entry.consume )
        };
        const std::list<item> removed =
            character->consume_items( components );
        sol::table row = state.create_table();
        row["item"] = entry.id;
        row["available"] = entry.available;
        row["consumed"] = entry.consume;
        row["fragments"] = removed.size();
        consumed[++output_index] = std::move( row );
    }
    character->invalidate_crafting_inventory();
    sol::table value = state.create_table();
    value["fulfilled"] = coverage >= 1.0;
    value["coverage"] = std::min( coverage, 1.0 );
    value["consumed"] = std::move( consumed );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_inventory_item(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle &item_handle,
    const sol::optional<std::int64_t> &requested_quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    Character *character = nullptr;
    item *entry = nullptr;
    std::optional<game_handle_error> error;
    if( !resolve_owned_item(
            character_handle, item_handle,
            runtime_generation, world_generation,
            character, entry, error ) ) {
        return make_game_error_result( state, *error );
    }

    const bool counted_by_charges =
        entry->count_by_charges();
    const std::int64_t available =
        counted_by_charges ? entry->charges : 1;
    const std::int64_t quantity =
        requested_quantity.value_or( available );
    if( quantity <= 0 ||
        quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "game.inventory.remove quantity is outside its limit" );
    }
    if( !counted_by_charges && quantity != 1 ) {
        throw std::invalid_argument(
            "game.inventory.remove quantity must be 1 for an item that is not counted by charges" );
    }
    if( quantity > available ) {
        throw std::invalid_argument(
            "game.inventory.remove quantity exceeds the available item amount" );
    }

    const std::int64_t uid =
        entry->uid().get_value();
    sol::table value = state.create_table();
    value["removed"] = quantity;
    value["fully_removed"] = quantity == available;
    value["before"] =
        mutable_item_state( state, *entry );
    if( quantity < available ) {
        entry->charges -= static_cast<int>( quantity );
        value["remaining"] = entry->charges;
        value["after"] =
            mutable_item_state( state, *entry );
        value["item"] = character_item_to_lua(
                            state, *character, *entry,
                            runtime_generation,
                            world_generation );
    } else {
        item removed;
        if( character->is_worn( *entry ) ) {
            const ret_val<void> can_takeoff =
                character->can_takeoff( *entry );
            if( !can_takeoff.success() ) {
                return make_game_error_result(
                state, {
                    "cannot_takeoff",
                    can_takeoff.str()
                } );
            }

            item removed_fallback = *entry;
            std::list<item> taken_off;
            if( !character->takeoff(
                    item_location( *character, entry ),
                    &taken_off ) ) {
                return make_game_error_result(
                state, {
                    "operation_failed",
                    "The character could not take off that item"
                } );
            }
            removed = taken_off.empty() ?
                      std::move( removed_fallback ) :
                      std::move( taken_off.front() );
        } else {
            removed = character->i_rem( entry );
        }
        if( removed.is_null() ) {
            return make_game_error_result(
            state, {
                "operation_failed",
                "The character could not remove that item"
            } );
        }
        value["remaining"] = 0;
        sol::table removed_state =
            mutable_item_state( state, removed );
        removed_state["uid"] = uid;
        value["removed_item"] =
            std::move( removed_state );
        value["uid"] = uid;
    }
    character->invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table wield_inventory_item(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle &item_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    Character *character = nullptr;
    item *entry = nullptr;
    std::optional<game_handle_error> error;
    if( !resolve_owned_item(
            character_handle, item_handle,
            runtime_generation, world_generation,
            character, entry, error ) ) {
        return make_game_error_result( state, *error );
    }

    sol::table value = state.create_table();
    value["accepted"] = false;
    const std::int64_t input_uid =
        entry->uid().get_value();
    value["uid"] = input_uid;
    if( character->is_wielding( *entry ) ) {
        value["reason"] = "already_wielded";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    if( character->has_weapon() ) {
        value["reason"] = "wielded_slot_occupied";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    const auto permitted = character->can_wield( *entry );
    if( !permitted.success() ) {
        value["reason"] = "cannot_wield";
        value["message"] = std::string( permitted.c_str() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    const bool accepted = character->wield(
                              item_location( *character, entry ),
                              false );
    value["accepted"] = accepted;
    if( !accepted ) {
        value["reason"] = "operation_failed";
    } else if( item_location after =
                   character->get_wielded_item() ) {
        value["uid"] = after->uid().get_value();
        if( after->uid().get_value() != input_uid ) {
            value["previous_uid"] = input_uid;
        }
        value["item"] = character_item_to_lua(
                            state, *character, *after,
                            runtime_generation,
                            world_generation );
    }
    character->invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table wear_inventory_item(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle &item_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    Character *character = nullptr;
    item *entry = nullptr;
    std::optional<game_handle_error> error;
    if( !resolve_owned_item(
            character_handle, item_handle,
            runtime_generation, world_generation,
            character, entry, error ) ) {
        return make_game_error_result( state, *error );
    }

    sol::table value = state.create_table();
    value["accepted"] = false;
    const std::int64_t input_uid =
        entry->uid().get_value();
    value["uid"] = input_uid;
    if( character->is_worn( *entry ) ) {
        value["reason"] = "already_worn";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    const auto permitted = character->can_wear( *entry );
    if( !permitted.success() ) {
        value["reason"] = "cannot_wear";
        value["message"] = std::string( permitted.c_str() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    const bool was_wielded =
        character->is_wielding( *entry );
    item moved = character->i_rem( entry );
    if( moved.is_null() ) {
        value["reason"] = "operation_failed";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    character->worn.check_rigid_sidedness( moved );
    character->worn.one_per_layer_sidedness( moved );
    const auto worn = character->wear_item(
                          moved, false );
    value["accepted"] = static_cast<bool>( worn );
    if( !worn ) {
        value["reason"] = "operation_failed";
        item_location restored;
        if( was_wielded && !character->has_weapon() ) {
            character->set_wielded_item( moved );
            restored = character->get_wielded_item();
        } else {
            restored = character->i_add(
                           moved, true, nullptr, nullptr,
                           false, false );
        }
        if( restored ) {
            value["rolled_back"] = true;
            value["uid"] =
                restored->uid().get_value();
            if( restored->uid().get_value() !=
                input_uid ) {
                value["previous_uid"] = input_uid;
            }
            value["item"] = character_item_to_lua(
                                state, *character, *restored,
                                runtime_generation,
                                world_generation );
        }
    } else {
        value["uid"] =
            ( **worn ).uid().get_value();
        if( ( **worn ).uid().get_value() !=
            input_uid ) {
            value["previous_uid"] = input_uid;
        }
        value["item"] = character_item_to_lua(
                            state, *character, **worn,
                            runtime_generation,
                            world_generation );
    }
    character->invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table stash_wielded_item(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }

    sol::table value = state.create_table();
    value["accepted"] = false;
    item_location wielded =
        character->get_wielded_item();
    if( !wielded ) {
        value["reason"] = "unarmed";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    const std::optional<bionic *> bionic_weapon =
        character->find_bionic_by_uid(
            character->get_weapon_bionic_uid() );
    if( bionic_weapon ) {
        const bool deactivated = character->deactivate_bionic(
                                     **bionic_weapon );
        value["accepted"] = deactivated;
        value["deactivated_bionic_weapon"] = deactivated;
        if( !deactivated ) {
            value["reason"] = "cannot_deactivate_bionic_weapon";
        }
        character->invalidate_crafting_inventory();
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    const auto permitted =
        character->can_unwield( *wielded );
    if( !permitted.success() ) {
        value["reason"] = "cannot_unwield";
        value["message"] = std::string( permitted.c_str() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    if( !character->can_add(
            *wielded, wielded.get_item(), false ) ) {
        value["reason"] = "no_storage";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    item moved = character->remove_weapon();
    item_location stored = character->i_add(
                               moved, true, nullptr, nullptr,
                               false, false );
    if( !stored || !stored.held_by( *character ) ) {
        character->set_wielded_item( moved );
        value["reason"] = "operation_failed";
        value["rolled_back"] = true;
        if( item_location restored =
                character->get_wielded_item() ) {
            value["item"] = character_item_to_lua(
                                state, *character, *restored,
                                runtime_generation,
                                world_generation );
        }
    } else {
        value["accepted"] = true;
        value["uid"] = stored->uid().get_value();
        value["item"] = character_item_to_lua(
                            state, *character, *stored,
                            runtime_generation,
                            world_generation );
    }
    character->invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table drop_wielded_item(
    sol::this_state lua, const game_handle &character_handle,
    const bool force,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               character_handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = state.create_table();
    value["accepted"] = false;
    value["forced"] = force;
    item_location wielded = character->get_wielded_item();
    if( !wielded ) {
        value["reason"] = "unarmed";
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }
    const auto permitted = character->can_unwield( *wielded );
    if( !permitted.success() && !force ) {
        value["reason"] = "cannot_unwield";
        value["message"] = std::string( permitted.c_str() );
        return make_game_value_result(
                   state, sol::make_object(
                       state, std::move( value ) ) );
    }

    const std::int64_t uid = wielded->uid().get_value();
    item moved = character->remove_weapon();
    map &here = get_map();
    const tripoint_bub_ms position = character->pos_bub( here );
    const std::vector<item_location> dropped = drop_on_map(
            *character, item_drop_reason::deliberate,
            { moved }, &here, position );
    value["accepted"] = true;
    value["uid"] = uid;
    value["locations"] = dropped.size();
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs,
                            coords::scale::map_square,
                            character->pos_abs().raw() );
    value["still_armed"] = character->has_weapon();
    character->invalidate_crafting_inventory();
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

item_category_id require_item_category_id(
    const script_game_id &id, const std::string_view api_name )
{
    if( id.kind() != "item_category" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires GameId<item_category>" );
    }
    const item_category_id native_id( id.value() );
    if( !native_id.is_valid() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a valid GameId<item_category>" );
    }
    return native_id;
}

float require_item_category_spawn_rate(
    const double rate, const std::string_view api_name )
{
    if( !std::isfinite( rate ) || rate < 0.0 ||
        rate > maximum_item_category_spawn_rate ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " spawn rate must be finite and within 0..1000000" );
    }
    return static_cast<float>( rate );
}

sol::table get_item_category_spawn_rate(
    sol::this_state lua, const script_game_id &id )
{
    constexpr std::string_view api_name =
        "game.item_categories.spawn_rate";
    const item_category_id native_id =
        require_item_category_id( id, api_name );
    sol::state_view state( lua );
    return make_game_value_result(
               state, sol::make_object(
                   state, native_id.obj().get_spawn_rate() ) );
}

sol::table set_item_category_spawn_rate(
    sol::this_state lua, const script_game_id &id,
    const double requested_rate )
{
    constexpr std::string_view api_name =
        "game.item_categories.set_spawn_rate";
    const item_category_id native_id =
        require_item_category_id( id, api_name );
    const float rate = require_item_category_spawn_rate(
                           requested_rate, api_name );
    const float before = native_id.obj().get_spawn_rate();
    native_id.obj().set_spawn_rate( rate );
    const float after = native_id.obj().get_spawn_rate();
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["id"] = id;
    value["before"] = before;
    value["after"] = after;
    value["changed"] = before != after;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

struct item_category_spawn_rate_update {
    script_game_id script_id;
    item_category_id native_id;
    float rate = 1.0F;
};

std::vector<item_category_spawn_rate_update>
read_item_category_spawn_rate_updates( const sol::table &requested )
{
    constexpr std::string_view api_name =
        "game.item_categories.set_spawn_rates";
    std::map<std::size_t, sol::table> indexed;
    for( const auto &entry : requested ) {
        if( !entry.first.is<lua_Integer>() ||
            !entry.second.is<sol::table>() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " requires a dense array of update tables" );
        }
        const lua_Integer raw_index =
            entry.first.as<lua_Integer>();
        if( raw_index <= 0 ||
            static_cast<std::uint64_t>( raw_index ) >
            maximum_spawn_rate_updates ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " update index is outside 1..256" );
        }
        if( !indexed.emplace(
                static_cast<std::size_t>( raw_index ),
                entry.second.as<sol::table>() ).second ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " update indexes cannot repeat" );
        }
    }
    if( indexed.empty() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires at least one update" );
    }
    if( indexed.rbegin()->first != indexed.size() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires a dense array without holes" );
    }
    std::set<item_category_id> seen;
    std::vector<item_category_spawn_rate_update> updates;
    updates.reserve( indexed.size() );
    for( const auto &[index, table] : indexed ) {
        static_cast<void>( index );
        const script_game_id id =
            table.get<script_game_id>( "id" );
        const item_category_id native_id =
            require_item_category_id( id, api_name );
        if( !seen.insert( native_id ).second ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " item categories cannot repeat" );
        }
        updates.push_back( {
            id, native_id,
            require_item_category_spawn_rate(
                table.get<double>( "spawn_rate" ), api_name )
        } );
    }
    return updates;
}

sol::table set_item_category_spawn_rates(
    sol::this_state lua, const sol::table &requested )
{
    const std::vector<item_category_spawn_rate_update> updates =
        read_item_category_spawn_rate_updates( requested );
    sol::state_view state( lua );
    sol::table changed = state.create_table(
                             static_cast<int>( updates.size() ), 0 );
    for( std::size_t index = 0; index < updates.size(); ++index ) {
        const item_category_spawn_rate_update &update =
            updates[index];
        const float before = update.native_id.obj().get_spawn_rate();
        update.native_id.obj().set_spawn_rate( update.rate );
        sol::table entry = state.create_table();
        entry["id"] = update.script_id;
        entry["before"] = before;
        entry["after"] = update.native_id.obj().get_spawn_rate();
        entry["changed"] = before != update.native_id.obj().get_spawn_rate();
        changed[index + 1] = std::move( entry );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( changed );
    value["count"] = updates.size();
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_item_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table items = lua.create_table();
    items.set_function(
        "snapshot",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<int> &relation_limit ) {
        require_read();
        return item_snapshot_result(
                   lua_state, handle, relation_limit,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "food_fun",
        [require_read]( const script_game_id &id ) {
        require_read();
        return item_type_food_fun( id );
    } );
    items.set_function(
        "possible_from_group",
        [require_read]( sol::this_state lua_state,
    const script_game_id &group ) {
        require_read();
        return possible_items_from_group(
                   lua_state, group );
    } );
    items.set_function(
        "pockets",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return item_pockets_result(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "contents",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const sol::optional<sol::table> &options ) {
        require_read();
        return item_contents_result(
                   lua_state, handle, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "update",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & updates ) {
        require_write();
        return update_item(
                   lua_state, handle, updates,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "melee_damage",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
    const sol::optional<script_game_id> &damage_type ) {
        require_read();
        return item_melee_damage(
                   lua_state, handle, damage_type,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "gun_damage",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const sol::optional<script_game_id> &damage_type,
    const sol::optional<bool> &with_ammo ) {
        require_read();
        return item_gun_damage(
                   lua_state, handle, damage_type, with_ammo,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "quality",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &handle,
            const script_game_id &quality,
    const sol::optional<bool> &strict ) {
        require_read();
        return item_quality(
                   lua_state, handle, quality, strict,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "transform",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & target,
    const sol::optional<sol::table> &options ) {
        require_write();
        return transform_item(
                   lua_state, handle, target, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "get_var",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & key ) {
        require_read();
        return get_item_var(
                   lua_state, handle, key,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_var",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const std::string & key,
    const sol::object & value ) {
        require_write();
        return set_item_var(
                   lua_state, handle, key, value,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "erase_var",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & key ) {
        require_write();
        return erase_item_var(
                   lua_state, handle, key,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "has_flag",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & flag ) {
        require_read();
        return item_has_flag(
                   lua_state, handle, flag,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "ammo_sufficient",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &item_handle,
            const sol::optional<game_handle> &character,
            const sol::optional<std::string> &method,
            const sol::optional<int> &quantity ) {
        require_read();
        return item_ammo_sufficient(
                   lua_state, item_handle, character, method,
                   quantity.value_or( 1 ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_flag",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & flag, const bool enabled ) {
        require_write();
        return set_item_flag(
                   lua_state, handle, flag, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "activate",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle &item_handle,
            const game_handle &character_handle, const std::string &method,
            const sol::optional<sol::table> &options ) {
        require_write();
        return activate_item(
                   lua_state, item_handle, character_handle, method, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_fault",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & fault,
    const sol::optional<sol::table> &options ) {
        require_write();
        return set_item_fault(
                   lua_state, handle, fault, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_random_fault",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
            const std::string &fault_type,
    const sol::optional<sol::table> &options ) {
        require_write();
        return set_random_item_fault(
                   lua_state, handle, fault_type, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "has_technique",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & technique ) {
        require_read();
        return item_has_technique(
                   lua_state, handle, technique,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_technique",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & technique, const bool enabled ) {
        require_write();
        return set_item_technique(
                   lua_state, handle, technique, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_owner",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &item_handle,
            const game_handle &owner,
            const sol::optional<bool> &remember_previous ) {
        require_write();
        return set_item_owner(
                   lua_state, item_handle, owner,
                   remember_previous.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "clear_owner",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &item_handle,
            const sol::optional<bool> &remember_previous ) {
        require_write();
        return clear_item_owner(
                   lua_state, item_handle,
                   remember_previous.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "clear_old_owner",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &item_handle ) {
        require_write();
        return clear_item_old_owner(
                   lua_state, item_handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["items"] = std::move( items );

    sol::table item_categories = lua.create_table();
    item_categories.set_function(
        "spawn_rate",
        [require_read]( sol::this_state lua_state,
    const script_game_id & id ) {
        require_read();
        return get_item_category_spawn_rate(
                   lua_state, id );
    } );
    item_categories.set_function(
        "set_spawn_rate",
        [require_write]( sol::this_state lua_state,
    const script_game_id & id, const double rate ) {
        require_write();
        return set_item_category_spawn_rate(
                   lua_state, id, rate );
    } );
    item_categories.set_function(
        "set_spawn_rates",
        [require_write]( sol::this_state lua_state,
    const sol::table & updates ) {
        require_write();
        return set_item_category_spawn_rates(
                   lua_state, updates );
    } );
    game["item_categories"] = std::move( item_categories );

    sol::table inventory = lua.create_table();
    inventory.set_function(
        "list",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle & character,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_inventory(
                   lua_state, character, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "filter",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle &character,
            const sol::table &descriptors, const sol::optional<sol::table> &options ) {
        require_read();
        return filter_inventory(
                   lua_state, character, descriptors, options,
                   current_runtime_generation(), current_world_generation() );
    } );
    inventory.set_function(
        "find",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
    const game_handle & character, const std::int64_t uid ) {
        require_read();
        return find_inventory_item(
                   lua_state, character, uid,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const sol::table &candidates,
            const sol::optional<std::string> &title ) {
        require_write();
        return choose_inventory_item(
                   lua_state, character, candidates, title,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose_many",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const sol::table &candidates,
            const sol::optional<std::string> &title ) {
        require_write();
        return choose_inventory_items(
                   lua_state, character, candidates, title,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose_map",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const sol::table &candidates,
            const sol::optional<sol::table> &options ) {
        require_write();
        return choose_map_inventory_items(
                   lua_state, character, candidates,
                   options, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose_many_map",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const sol::table &candidates,
            const sol::optional<sol::table> &options ) {
        require_write();
        return choose_map_inventory_items(
                   lua_state, character, candidates,
                   options, true,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "resources",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle & character,
            const script_game_id & type,
    const std::int64_t quantity ) {
        require_read();
        return inventory_resources(
                   lua_state, character, type, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "has_items_sum",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const sol::table &entries ) {
        require_read();
        return inventory_has_items_sum(
                   lua_state, character, entries,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "has_software",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &software,
            const sol::optional<std::int64_t> &minimum_charges,
            const sol::optional<script_game_id> &device ) {
        require_read();
        return inventory_has_software(
                   lua_state, character, software,
                   minimum_charges, device,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "has_worn_flag",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &flag,
            const sol::optional<script_game_id> &body_part ) {
        require_read();
        return inventory_has_worn_flag(
                   lua_state, character, flag, body_part,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "is_wearing",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &item_id ) {
        require_read();
        return inventory_is_wearing(
                   lua_state, character, item_id,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "has_item_flag",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &flag ) {
        require_read();
        return inventory_has_item_flag(
                   lua_state, character, flag,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "category_count",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &category ) {
        require_read();
        return inventory_category_count(
                   lua_state, character, category,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "item_radiation",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &flag,
    const sol::optional<std::string> &aggregate ) {
        require_read();
        return inventory_item_radiation(
                   lua_state, character, flag, aggregate,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "wielded_matches",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &criterion ) {
        require_read();
        return inventory_wielded_matches(
                   lua_state, character, criterion,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "has_stolen_from",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &holder,
            const game_handle &owner ) {
        require_read();
        return inventory_has_stolen_from(
                   lua_state, holder, owner,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "weapon_state",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const game_handle &character ) {
        require_read();
        return inventory_weapon_state(
                   lua_state, character,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "give",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle & character,
            const script_game_id & type,
            const std::int64_t quantity,
    const sol::optional<sol::table> &options ) {
        require_write();
        return give_inventory_items(
                   lua_state, character, type, quantity, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "give_group",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &group,
    const sol::optional<sol::table> &options ) {
        require_write();
        return give_inventory_item_group(
                   lua_state, character, group, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "remove",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle & character,
            const game_handle & item_handle,
    const sol::optional<std::int64_t> &quantity ) {
        require_write();
        return remove_inventory_item(
                   lua_state, character, item_handle, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "consume",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const script_game_id &type,
            const sol::optional<std::int64_t> &count,
            const sol::optional<std::int64_t> &charges ) {
        require_write();
        return consume_inventory_items(
                   lua_state, character, type,
                   count.value_or( 0 ), charges.value_or( 0 ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "hand_in",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const game_handle &recipient,
            const script_game_id &type,
            const sol::optional<std::int64_t> &count,
    const sol::optional<std::int64_t> &charges ) {
        require_write();
        return hand_in_inventory_items(
                   lua_state, character, recipient, type,
                   count.value_or( 0 ), charges.value_or( 0 ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "consume_sum",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
            const sol::table &entries ) {
        require_write();
        return consume_inventory_sum(
                   lua_state, character, entries,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "wield",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle & character,
    const game_handle & item_handle ) {
        require_write();
        return wield_inventory_item(
                   lua_state, character, item_handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "wear",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle & character,
    const game_handle & item_handle ) {
        require_write();
        return wear_inventory_item(
                   lua_state, character, item_handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "stash_wielded",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
    const game_handle & character ) {
        require_write();
        return stash_wielded_item(
                   lua_state, character,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "drop_wielded",
        [current_runtime_generation, current_world_generation, require_write](
            sol::this_state lua_state,
            const game_handle &character,
    const sol::optional<bool> &force ) {
        require_write();
        return drop_wielded_item(
                   lua_state, character,
                   force.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["inventory"] = std::move( inventory );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
