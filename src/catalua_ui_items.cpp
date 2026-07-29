#include "catalua_ui_items.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <list>
#include <optional>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "item.h"
#include "item_contents.h"
#include "item_pocket.h"

namespace cata::lua_ui
{

namespace
{

constexpr int default_inventory_limit = 128;
constexpr int maximum_inventory_limit = 512;
constexpr int default_inventory_depth = 8;
constexpr int maximum_inventory_depth = 16;
constexpr std::size_t maximum_inventory_nodes = 4096;
constexpr std::size_t maximum_inventory_offset = 1000000;

struct inventory_query_options {
    std::size_t offset = 0;
    int limit = default_inventory_limit;
    int max_depth = default_inventory_depth;
    bool recursive = true;
    bool include_wielded = true;
    bool include_worn = true;
    bool include_carried = true;
};

struct inventory_item_entry {
    item *value = nullptr;
    std::string location;
    int depth = 0;
    std::int64_t parent_uid = 0;
    std::vector<int> path;
};

std::int64_t integer_option(
    const sol::object &value, const std::string &name )
{
    if( !value.is<lua_Integer>() ) {
        throw std::invalid_argument(
            "game.inventory.list option '" + name +
            "' must be an integer" );
    }
    return value.as<lua_Integer>();
}

bool boolean_option(
    const sol::object &value, const std::string &name )
{
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            "game.inventory.list option '" + name +
            "' must be a boolean" );
    }
    return value.as<bool>();
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
            const std::int64_t offset = integer_option( value, key );
            if( offset < 0 ||
                static_cast<std::uint64_t>( offset ) >
                maximum_inventory_offset ) {
                throw std::invalid_argument(
                    "game.inventory.list offset is outside its limit" );
            }
            result.offset = static_cast<std::size_t>( offset );
        } else if( key == "limit" ) {
            const std::int64_t limit = integer_option( value, key );
            if( limit < 0 ) {
                throw std::invalid_argument(
                    "game.inventory.list limit cannot be negative" );
            }
            result.limit = static_cast<int>(
                               std::min<std::int64_t>(
                                   limit, maximum_inventory_limit ) );
        } else if( key == "max_depth" ) {
            const std::int64_t depth = integer_option( value, key );
            if( depth < 0 ) {
                throw std::invalid_argument(
                    "game.inventory.list max_depth cannot be negative" );
            }
            result.max_depth = static_cast<int>(
                                   std::min<std::int64_t>(
                                       depth, maximum_inventory_depth ) );
        } else if( key == "recursive" ) {
            result.recursive = boolean_option( value, key );
        } else if( key == "include_wielded" ) {
            result.include_wielded = boolean_option( value, key );
        } else if( key == "include_worn" ) {
            result.include_worn = boolean_option( value, key );
        } else if( key == "include_carried" ) {
            result.include_carried = boolean_option( value, key );
        } else {
            throw std::invalid_argument(
                "game.inventory.list received unknown option '" +
                key + "'" );
        }
    }
    return result;
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

std::string root_location(
    const Character &character, const item &entry )
{
    if( character.is_wielding( entry ) ) {
        return "wielded";
    }
    if( character.is_worn( entry ) ) {
        return "worn";
    }
    return "carried";
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

void collect_item_branch(
    item &entry, const std::string &location, const int depth,
    const std::int64_t parent_uid, std::vector<int> path,
    const inventory_query_options &options,
    std::vector<inventory_item_entry> &result,
    bool &node_truncated, bool &depth_truncated )
{
    if( result.size() >= maximum_inventory_nodes ) {
        node_truncated = true;
        return;
    }
    result.push_back( {
        &entry, location, depth, parent_uid, path
    } );
    if( !options.recursive ) {
        return;
    }
    if( depth >= options.max_depth ) {
        depth_truncated = depth_truncated ||
                          has_direct_contents( entry );
        return;
    }

    const std::vector<item_pocket *> pockets =
        entry.get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    for( std::size_t pocket_index = 0;
         pocket_index < pockets.size(); ++pocket_index ) {
        item_pocket *pocket = pockets[pocket_index];
        if( pocket == nullptr ) {
            continue;
        }
        const std::list<item *> children =
            pocket->all_items_top();
        std::size_t child_index = 0;
        for( item *child : children ) {
            if( result.size() >= maximum_inventory_nodes ) {
                node_truncated = true;
                return;
            }
            if( child == nullptr ) {
                ++child_index;
                continue;
            }
            std::vector<int> child_path = path;
            child_path.push_back(
                static_cast<int>( pocket_index ) );
            child_path.push_back(
                static_cast<int>( child_index ) );
            collect_item_branch(
                *child, "contained", depth + 1,
                entry.uid().get_value(), std::move( child_path ),
                options, result, node_truncated,
                depth_truncated );
            if( node_truncated ) {
                return;
            }
            ++child_index;
        }
    }
}

std::vector<inventory_item_entry> collect_inventory(
    Character &character, const inventory_query_options &options,
    bool &node_truncated, bool &depth_truncated )
{
    std::vector<inventory_item_entry> result;
    const std::vector<item *> roots = character.inv_dump();
    for( std::size_t index = 0; index < roots.size(); ++index ) {
        item *root = roots[index];
        if( root == nullptr ) {
            continue;
        }
        const std::string location =
            root_location( character, *root );
        if( !includes_location( options, location ) ) {
            continue;
        }
        collect_item_branch(
            *root, location, 0, 0,
        { static_cast<int>( index ) }, options, result,
        node_truncated, depth_truncated );
        if( node_truncated ) {
            break;
        }
    }
    return result;
}

game_handle make_item_handle(
    Character &character, const inventory_item_entry &entry,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

    bool node_truncated = false;
    bool depth_truncated = false;
    const std::vector<inventory_item_entry> entries =
        collect_inventory(
            *character, options, node_truncated,
            depth_truncated );
    const std::size_t start =
        std::min( options.offset, entries.size() );
    const std::size_t returned = std::min(
                                     entries.size() - start,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = inventory_entry_to_lua(
                               state, *character,
                               entries[start + index],
                               runtime_generation,
                               world_generation );
    }

    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = entries.size();
    value["total_exact"] =
        !node_truncated && !depth_truncated;
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["max_depth"] = options.max_depth;
    value["recursive"] = options.recursive;
    value["returned"] = returned;
    value["has_more"] =
        start + returned < entries.size() || node_truncated;
    value["node_truncated"] = node_truncated;
    value["depth_truncated"] = depth_truncated;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table find_inventory_item(
    sol::this_state lua, const game_handle &character_handle,
    const std::int64_t uid,
    const std::size_t runtime_generation,
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
    options.max_depth = maximum_inventory_depth;
    bool node_truncated = false;
    bool depth_truncated = false;
    const std::vector<inventory_item_entry> entries =
        collect_inventory(
            *character, options, node_truncated,
            depth_truncated );
    const auto found = std::find_if(
                           entries.begin(), entries.end(),
    [uid]( const inventory_item_entry & entry ) {
        return entry.value->uid().get_value() == uid;
    } );
    if( found == entries.end() ) {
        const bool truncated =
            node_truncated || depth_truncated;
        return make_game_error_result(
        state, {
            truncated ? "search_truncated" : "not_found",
            truncated ?
            "The bounded inventory search ended before finding that item" :
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

} // namespace

void install_item_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> )
{
    sol::state_view lua( game.lua_state() );
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
    game["inventory"] = std::move( inventory );
}

} // namespace cata::lua_ui
