#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_items.h"

#include <character_attire.h>
#include <character_id.h>
#include <enums.h>
#include <flat_set.h>
#include <game.h>
#include <inventory_ui.h>
#include <item_uid.h>
extern "C" {
#include <lua.h>
}
#include <map_selector.h>
#include <pimpl.h>
#include <pocket_type.h>
#include <point.h>
#include <ret_val.h>
#include <stomach.h>
#include <translation.h>
#include <value_ptr.h>
#include <veh_type.h>
#include <visitable.h>
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <functional>
#include <iterator>
#include <limits>
#include <list>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_traits>
#include <unordered_map>
#include <utility>
#include <vector>

#include "basecamp.h"
#include "calendar.h"
#include "cata_utility.h"
#include "catacharset.h"
#include "character.h"
#include "coordinates.h"
#include "damage.h"
#include "faction.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "game_inventory.h"
#include "inventory.h"
#include "item.h"
#include "item_category.h"
#include "item_contents.h"
#include "item_group.h"
#include "item_location.h"
#include "item_pocket.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_world.h"
#include "map.h"
#include "math_parser_diag_value.h"
#include "requirements.h"
#include "string_formatter.h"
#include "translations.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

struct bionic;

namespace cata::lua_platform
{

namespace
{

constexpr int default_item_relation_limit = 64;
constexpr int maximum_item_relation_limit = 256;
constexpr int maximum_item_text_width = 8192;
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
constexpr int default_item_page_size = 64;
constexpr int maximum_item_page_size = 256;
constexpr int default_item_page_depth = 8;
constexpr int maximum_item_page_depth = 64;
constexpr std::size_t maximum_item_page_nodes = 1024;
constexpr std::size_t maximum_item_page_cursors = 1024;
static const flag_id json_flag_ONE_PER_LAYER( "ONE_PER_LAYER" );

enum class item_holder_kind : std::uint8_t {
    character,
    map_tile,
    container_pocket,
    vehicle_cargo,
};

struct item_holder_descriptor {
    item_holder_kind kind = item_holder_kind::character;
    std::string slot;
    std::optional<game_handle> character;
    std::optional<game_handle> container;
    std::optional<game_handle> vehicle;
    std::optional<game_handle> part;
    std::optional<map_tile_token> tile;
    int pocket_index = -1;
    int part_index = -1;
};

struct resolved_item_holder {
    item_holder_descriptor descriptor;
    Character *character = nullptr;
    item *container = nullptr;
    item_pocket *pocket = nullptr;
    ::vehicle *vehicle = nullptr;
    vehicle_part *part = nullptr;
    item *target = nullptr;
    std::optional<item_location> location;
};

struct item_page_options {
    int page_size = default_item_page_size;
    int max_depth = default_item_page_depth;
    bool recursive = true;
};

struct item_query_entry {
    item *value = nullptr;
    item *parent = nullptr;
    int pocket_index = -1;
    int depth = 0;
    std::vector<int> path;
};

struct item_query_root {
    resolved_item_holder holder;
    std::vector<item *> roots;
};

struct item_query_cursor_state {
    item_holder_descriptor holder;
    item_page_options options;
    game_handle_runtime runtime;
    std::size_t world_generation = 0;
    std::uint64_t mutation_epoch = 0;
    std::vector<int> next_path;
    std::optional<game_handle> next_item;
    std::set<std::int64_t> seen_item_uids;
    bool depth_limited = false;
};

std::uint64_t item_query_mutation_epoch = 1;
std::uint64_t next_item_query_cursor_id = 1;
std::unordered_map<std::uint64_t, item_query_cursor_state> item_query_cursors;

sol::table snapshot_item(
    sol::state_view lua, const item &entry, int relation_limit );

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

game_handle make_character_holder_handle(
    Character &character, const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position = character.pos_abs();
    game_handle_locator locator;
    locator.scope = character.is_avatar() ? "avatar" :
                    character.is_npc() ? "npc" : "character";
    locator.stable_id = character.getID().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_creature(
               character, std::move( locator ),
               runtime_generation, world_generation );
}

game_handle make_character_item_handle(
    Character &character, item &entry, const std::string_view scope,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    const tripoint_abs_ms position = character.pos_abs();
    game_handle_locator locator;
    locator.scope = std::string( scope );
    locator.stable_id = entry.uid().get_value();
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    return game_handle::from_item(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

game_handle_locator map_item_locator( const map_tile_token &tile )
{
    const tripoint_abs_ms position = tile.native_position();
    game_handle_locator locator;
    locator.scope = "map";
    locator.x = position.x();
    locator.y = position.y();
    locator.z = position.z();
    locator.owner_generation = tile.owner_generation();
    return locator;
}

std::string_view item_holder_kind_name( const item_holder_kind kind )
{
    switch( kind ) {
        case item_holder_kind::character:
            return "character";
        case item_holder_kind::map_tile:
            return "map_tile";
        case item_holder_kind::container_pocket:
            return "container_pocket";
        case item_holder_kind::vehicle_cargo:
            return "vehicle_cargo";
    }
    return "unknown";
}

item_holder_descriptor character_item_holder_descriptor(
    Character &character, item &entry, item *known_parent,
    const int known_pocket_index,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    item_holder_descriptor result;
    result.character = make_character_holder_handle(
                           character, runtime_generation, world_generation );
    if( character.is_wielding( entry ) ) {
        result.slot = "wielded";
        return result;
    }
    if( character.is_worn( entry ) ) {
        result.slot = "worn";
        return result;
    }

    item *parent = known_parent;
    int pocket_index = known_pocket_index;
    if( parent == nullptr ) {
        const std::vector<item *> parents = character.parents( entry );
        if( !parents.empty() ) {
            parent = parents.front();
        }
    }
    if( parent != nullptr && pocket_index < 0 ) {
        const std::vector<item_pocket *> pockets =
            parent->get_contents().get_pockets(
        []( const item_pocket & ) {
            return true;
        } );
        for( std::size_t index = 0; index < pockets.size(); ++index ) {
            if( pockets[index] != nullptr && pockets[index]->has_item( entry ) ) {
                pocket_index = static_cast<int>( index );
                break;
            }
        }
    }
    if( parent != nullptr && pocket_index >= 0 ) {
        result.kind = item_holder_kind::container_pocket;
        result.container = make_character_item_handle(
                               character, *parent, "character_container",
                               runtime_generation, world_generation );
        result.pocket_index = pocket_index;
        return result;
    }

    result.slot = "inventory";
    return result;
}

sol::table item_holder_to_lua(
    sol::state_view lua, const item_holder_descriptor &holder )
{
    sol::table result = lua.create_table();
    result["kind"] = std::string( item_holder_kind_name( holder.kind ) );
    if( holder.kind == item_holder_kind::character ) {
        result["character"] = *holder.character;
        result["slot"] = holder.slot;
    } else if( holder.kind == item_holder_kind::map_tile ) {
        result["tile"] = *holder.tile;
    } else if( holder.kind == item_holder_kind::container_pocket ) {
        result["container"] = *holder.container;
        result["pocket_index"] = holder.pocket_index;
    } else if( holder.kind == item_holder_kind::vehicle_cargo ) {
        result["vehicle"] = *holder.vehicle;
        result["part"] = *holder.part;
    }
    return result;
}

item_holder_descriptor read_item_holder_descriptor(
    const sol::table &requested, const std::string_view api_name )
{
    const sol::object raw_kind = requested.raw_get<sol::object>( "kind" );
    if( !raw_kind.is<std::string>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " holder.kind must be a string" );
    }
    const std::string kind = raw_kind.as<std::string>();
    item_holder_descriptor result;
    if( kind == "character" ) {
        result.kind = item_holder_kind::character;
    } else if( kind == "map_tile" ) {
        result.kind = item_holder_kind::map_tile;
    } else if( kind == "container_pocket" ) {
        result.kind = item_holder_kind::container_pocket;
    } else if( kind == "vehicle_cargo" ) {
        result.kind = item_holder_kind::vehicle_cargo;
    } else {
        throw std::invalid_argument(
            std::string( api_name ) + " holder.kind is not supported" );
    }

    const auto require_handle = [&]( const char *field ) {
        const sol::object value = requested.raw_get<sol::object>( field );
        if( !value.is<game_handle>() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " holder." + field +
                " must be a GameHandle" );
        }
        return value.as<game_handle>();
    };
    const auto require_index = [&]( const char *field, const int maximum ) {
        const std::int64_t value = integer_option(
                                       requested.raw_get<sol::object>( field ),
                                       field, std::string( api_name ) );
        if( value < 0 || value > maximum ) {
            throw std::invalid_argument(
                std::string( api_name ) + " holder." + field +
                " is outside its native range" );
        }
        return static_cast<int>( value );
    };

    for( const auto &field : requested ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " holder keys must be strings" );
        }
        const std::string name = field.first.as<std::string>();
        const bool allowed =
            name == "kind" ||
            ( result.kind == item_holder_kind::character &&
              ( name == "character" || name == "slot" ) ) ||
            ( result.kind == item_holder_kind::map_tile &&
              name == "tile" ) ||
            ( result.kind == item_holder_kind::container_pocket &&
              ( name == "container" || name == "pocket_index" ) ) ||
            ( result.kind == item_holder_kind::vehicle_cargo &&
              ( name == "vehicle" || name == "part" ) );
        if( !allowed ) {
            throw std::invalid_argument(
                std::string( api_name ) + " holder received unknown field '" +
                name + "'" );
        }
    }

    if( result.kind == item_holder_kind::character ) {
        result.character = require_handle( "character" );
        const sol::object raw_slot = requested.raw_get<sol::object>( "slot" );
        if( !raw_slot.is<std::string>() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " character holder.slot must be a string" );
        }
        result.slot = raw_slot.as<std::string>();
        if( result.slot != "inventory" && result.slot != "worn" &&
            result.slot != "wielded" ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " character holder.slot must be inventory, worn, or wielded" );
        }
    } else if( result.kind == item_holder_kind::map_tile ) {
        const sol::object raw_tile =
            requested.raw_get<sol::object>( "tile" );
        if( !raw_tile.is<map_tile_token>() ) {
            throw std::invalid_argument(
                std::string( api_name ) +
                " map_tile holder.tile must be a MapTileToken" );
        }
        result.tile = raw_tile.as<map_tile_token>();
    } else if( result.kind == item_holder_kind::container_pocket ) {
        result.container = require_handle( "container" );
        result.pocket_index = require_index( "pocket_index", 256 );
    } else {
        result.vehicle = require_handle( "vehicle" );
        result.part = require_handle( "part" );
    }
    return result;
}

std::optional<item_location> exact_character_item_location(
    Character &character, item *target )
{
    if( target == nullptr || target->is_null() ) {
        return std::nullopt;
    }
    std::optional<item_location> result;
    character.visit_items( [&character, target, &result]( item * candidate, item * ) {
        if( candidate == target ) {
            result.emplace( character, target );
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    return result;
}

std::optional<game_handle_error> resolve_item_holder(
    const item_holder_descriptor &descriptor,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    item *target, resolved_item_holder &result )
{
    result = {};
    result.descriptor = descriptor;
    result.target = target;
    if( descriptor.kind == item_holder_kind::character ) {
        std::optional<game_handle_error> error;
        result.character = resolve_exact_character(
                               *descriptor.character, runtime_generation,
                               world_generation, error );
        if( result.character == nullptr ) {
            return error;
        }
        if( target != nullptr ) {
            result.location = exact_character_item_location(
                                  *result.character, target );
            if( !result.location ) {
                return game_handle_error{
                    "wrong_holder",
                    "The Character holder does not contain the exact Item handle"
                };
            }
            const bool slot_matches =
                ( descriptor.slot == "wielded" &&
                  result.character->is_wielding( *target ) ) ||
                ( descriptor.slot == "worn" &&
                  result.character->is_worn( *target ) ) ||
                ( descriptor.slot == "inventory" &&
                  !result.character->is_wielding( *target ) &&
                  !result.character->is_worn( *target ) &&
                  result.character->parents( *target ).empty() );
            if( !slot_matches ) {
                return game_handle_error{
                    "wrong_holder",
                    "The exact Item handle is not in the requested Character slot"
                };
            }
        }
        return std::nullopt;
    }

    if( descriptor.kind == item_holder_kind::map_tile ) {
        if( const std::optional<game_handle_error> error =
                validate_map_tile_token( *descriptor.tile, runtime_generation,
                                         world_generation ) ) {
            return error;
        }
        map &here = get_map();
        const tripoint_abs_ms absolute = descriptor.tile->native_position();
        const tripoint_bub_ms local = here.get_bub( absolute );
        if( target != nullptr ) {
            map_stack stack = here.i_at( local );
            for( item &candidate : stack ) {
                if( &candidate == target ) {
                    result.location.emplace(
                        map_cursor( absolute ), target );
                    return std::nullopt;
                }
            }
            return game_handle_error{
                "wrong_holder",
                "The map tile holder does not contain the exact Item handle"
            };
        }
        return std::nullopt;
    }

    if( descriptor.kind == item_holder_kind::container_pocket ) {
        const native_handle_result<item> resolved =
            descriptor.container->resolve_item(
                runtime_generation, world_generation );
        if( !resolved ) {
            return resolved.error;
        }
        result.container = resolved.value;
        const std::vector<item_pocket *> pockets =
            result.container->get_contents().get_pockets(
        []( const item_pocket & ) {
            return true;
        } );
        if( descriptor.pocket_index < 0 ||
            static_cast<std::size_t>( descriptor.pocket_index ) >= pockets.size() ||
            pockets[descriptor.pocket_index] == nullptr ) {
            return game_handle_error{
                "wrong_holder", "The requested container pocket does not exist"
            };
        }
        result.pocket = pockets[descriptor.pocket_index];
        bool direct_member = false;
        if( target != nullptr ) {
            for( item *candidate : result.pocket->all_items_top() ) {
                if( candidate == target ) {
                    direct_member = true;
                    break;
                }
            }
        }
        if( target != nullptr && !direct_member ) {
            return game_handle_error{
                "wrong_holder",
                "The container pocket does not contain the exact Item handle"
            };
        }
        return std::nullopt;
    }

    const native_handle_result<vehicle> resolved =
        descriptor.vehicle->resolve_vehicle(
            runtime_generation, world_generation );
    if( !resolved ) {
        return resolved.error;
    }
    result.vehicle = resolved.value;
    const native_handle_result<vehicle_part> resolved_part =
        descriptor.part->resolve_vehicle_part_for_vehicle(
            *descriptor.vehicle, runtime_generation, world_generation );
    if( !resolved_part ) {
        return resolved_part.error;
    }
    result.part = resolved_part.value;
    result.descriptor.part_index = result.vehicle->index_of_part(
                                       result.part, true );
    if( result.descriptor.part_index < 0 ) {
        return game_handle_error{
            "stale_vehicle_part",
            "The exact VehiclePart is no longer owned by this Vehicle"
        };
    }
    if( !result.part->info().has_flag( VPFLAG_CARGO ) ) {
        return game_handle_error{
            "wrong_holder", "The requested vehicle part is not cargo"
        };
    }
    if( target != nullptr ) {
        vehicle_stack stack = result.vehicle->get_items( *result.part );
        for( item &candidate : stack ) {
            if( &candidate == target ) {
                return std::nullopt;
            }
        }
        return game_handle_error{
            "wrong_holder",
            "The vehicle cargo part does not contain the exact Item handle"
        };
    }
    return std::nullopt;
}

item_page_options read_item_page_options(
    const sol::optional<sol::table> &requested )
{
    item_page_options result;
    if( !requested ) {
        return result;
    }
    constexpr std::string_view api_name = "services.items.page";
    for( const auto &field : *requested ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " option keys must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key == "page_size" ) {
            const std::int64_t value = integer_option(
                                           field.second, key,
                                           std::string( api_name ) );
            if( value <= 0 ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " page_size must be positive" );
            }
            result.page_size = static_cast<int>( std::min<std::int64_t>(
                    value, maximum_item_page_size ) );
        } else if( key == "max_depth" ) {
            const std::int64_t value = integer_option(
                                           field.second, key,
                                           std::string( api_name ) );
            if( value < 0 ) {
                throw std::invalid_argument(
                    std::string( api_name ) + " max_depth cannot be negative" );
            }
            result.max_depth = static_cast<int>( std::min<std::int64_t>(
                    value, maximum_item_page_depth ) );
        } else if( key == "recursive" ) {
            result.recursive = boolean_option(
                                   field.second, key,
                                   std::string( api_name ) );
        } else {
            throw std::invalid_argument(
                std::string( api_name ) + " received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

std::optional<game_handle_error> build_item_query_root(
    const item_holder_descriptor &descriptor,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    item_query_root &result )
{
    resolved_item_holder resolved;
    if( const std::optional<game_handle_error> error = resolve_item_holder(
                descriptor, runtime_generation, world_generation,
                nullptr, resolved ) ) {
        return error;
    }
    result = {};
    result.holder = std::move( resolved );

    if( descriptor.kind == item_holder_kind::character ) {
        Character &character = *result.holder.character;
        if( descriptor.slot == "wielded" ) {
            if( item_location location = character.get_wielded_item() ) {
                if( location->is_null() ) {
                    return std::nullopt;
                }
                result.roots.push_back( location.get_item() );
            }
        } else if( descriptor.slot == "worn" ) {
            for( item_location location : character.worn.top_items_loc( character ) ) {
                if( location && !location->is_null() ) {
                    result.roots.push_back( location.get_item() );
                }
            }
        } else {
            for( std::list<item> *stack : character.inv->slice() ) {
                if( stack == nullptr ) {
                    return game_handle_error{
                        "traversal_invalid",
                        "Character inventory returned a null item stack"
                    };
                }
                for( item &entry : *stack ) {
                    if( entry.is_null() ) {
                        return game_handle_error{
                            "traversal_invalid",
                            "Character inventory returned a null Item"
                        };
                    }
                    result.roots.push_back( &entry );
                }
            }
        }
    } else if( descriptor.kind == item_holder_kind::map_tile ) {
        if( const std::optional<game_handle_error> error =
                validate_map_tile_token( *descriptor.tile, runtime_generation,
                                         world_generation ) ) {
            return error;
        }
        map &here = get_map();
        const tripoint_bub_ms local = here.get_bub(
                                          descriptor.tile->native_position() );
        map_stack stack = here.i_at( local );
        for( item &entry : stack ) {
            if( entry.is_null() ) {
                return game_handle_error{
                    "traversal_invalid", "Map tile returned a null Item"
                };
            }
            result.roots.push_back( &entry );
        }
    } else if( descriptor.kind == item_holder_kind::container_pocket ) {
        for( item *entry : result.holder.pocket->all_items_top() ) {
            if( entry == nullptr || entry->is_null() ) {
                return game_handle_error{
                    "traversal_invalid", "Container pocket returned a null Item"
                };
            }
            result.roots.push_back( entry );
        }
    } else {
        vehicle_stack stack = result.holder.vehicle->get_items( *result.holder.part );
        for( item &entry : stack ) {
            if( entry.is_null() ) {
                return game_handle_error{
                    "traversal_invalid", "Vehicle cargo returned a null Item"
                };
            }
            result.roots.push_back( &entry );
        }
    }
    return std::nullopt;
}

bool resolve_query_path(
    const item_query_root &root, const std::vector<int> &path,
    item_query_entry &result, bool &invalid );

bool query_path_contains_item(
    const item_query_root &root, const std::vector<int> &path,
    const item *wanted )
{
    if( path.empty() ) {
        return false;
    }
    for( std::size_t length = 1; length <= path.size(); length += 2 ) {
        item_query_entry entry;
        bool invalid = false;
        const std::vector<int> prefix( path.begin(), path.begin() + length );
        if( !resolve_query_path( root, prefix, entry, invalid ) ) {
            return false;
        }
        if( entry.value == wanted ) {
            return true;
        }
    }
    return false;
}

bool query_path_contains_pocket(
    const item_query_root &root, const std::vector<int> &path,
    const item_pocket *wanted )
{
    if( wanted == nullptr || path.size() < 3 ) {
        return false;
    }
    for( std::size_t index = 1; index + 1 < path.size(); index += 2 ) {
        item_query_entry parent;
        bool invalid = false;
        const std::vector<int> parent_path( path.begin(), path.begin() + index );
        if( !resolve_query_path( root, parent_path, parent, invalid ) ) {
            return false;
        }
        const std::vector<item_pocket *> pockets =
            parent.value->get_contents().get_pockets(
        []( const item_pocket & ) {
            return true;
        } );
        const int pocket_index = path[index];
        if( pocket_index < 0 ||
            static_cast<std::size_t>( pocket_index ) >= pockets.size() ||
            pockets[pocket_index] == nullptr ) {
            return false;
        }
        if( pockets[pocket_index] == wanted ) {
            return true;
        }
    }
    return false;
}

bool resolve_query_path(
    const item_query_root &root, const std::vector<int> &path,
    item_query_entry &result, bool &invalid )
{
    invalid = false;
    result = {};
    if( path.empty() || path.front() < 0 ||
        static_cast<std::size_t>( path.front() ) >= root.roots.size() ) {
        return false;
    }
    item *current = root.roots[path.front()];
    if( current == nullptr || current->is_null() ) {
        invalid = true;
        return false;
    }
    result.value = current;
    result.depth = 0;
    result.path = path;
    for( std::size_t index = 1; index + 1 < path.size(); index += 2 ) {
        const int pocket_index = path[index];
        const int child_index = path[index + 1];
        const std::vector<item_pocket *> pockets =
            current->get_contents().get_pockets(
        []( const item_pocket & ) {
            return true;
        } );
        if( pocket_index < 0 ||
            static_cast<std::size_t>( pocket_index ) >= pockets.size() ||
            pockets[pocket_index] == nullptr || child_index < 0 ) {
            invalid = true;
            return false;
        }
        std::vector<item *> children;
        for( item *child : pockets[pocket_index]->all_items_top() ) {
            if( child == nullptr || child->is_null() ) {
                invalid = true;
                return false;
            }
            children.push_back( child );
        }
        if( static_cast<std::size_t>( child_index ) >= children.size() ||
            children[child_index] == nullptr || children[child_index]->is_null() ) {
            invalid = true;
            return false;
        }
        result.parent = current;
        result.pocket_index = pocket_index;
        current = children[child_index];
        result.value = current;
        ++result.depth;
    }
    return true;
}

bool first_query_child_path(
    const item_query_root &root, const std::vector<int> &path,
    const item_page_options &options, std::vector<int> &child_path,
    bool &depth_limited, std::string &diagnostic )
{
    item_query_entry current;
    bool invalid = false;
    if( !resolve_query_path( root, path, current, invalid ) ) {
        diagnostic = invalid ? "invalid_pocket" : "complete";
        return false;
    }
    if( !options.recursive ) {
        return false;
    }
    if( current.depth >= options.max_depth ) {
        bool has_children = false;
        const std::vector<item_pocket *> pockets =
            current.value->get_contents().get_pockets(
        []( const item_pocket & ) {
            return true;
        } );
        for( const item_pocket *pocket : pockets ) {
            if( pocket == nullptr ) {
                diagnostic = "invalid_pocket";
                return false;
            }
            for( const item *child : pocket->all_items_top() ) {
                if( child == nullptr || child->is_null() ) {
                    diagnostic = "invalid_pocket";
                    return false;
                }
                has_children = true;
            }
        }
        if( has_children ) {
            depth_limited = true;
        }
        return false;
    }

    const std::vector<item_pocket *> pockets =
        current.value->get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    for( std::size_t pocket_index = 0; pocket_index < pockets.size(); ++pocket_index ) {
        if( pockets[pocket_index] == nullptr ) {
            diagnostic = "invalid_pocket";
            return false;
        }
        std::size_t child_index = 0;
        for( item *child : pockets[pocket_index]->all_items_top() ) {
            if( child == nullptr || child->is_null() ) {
                diagnostic = "invalid_pocket";
                return false;
            }
            child_path = path;
            child_path.push_back( static_cast<int>( pocket_index ) );
            child_path.push_back( static_cast<int>( child_index ) );
            if( query_path_contains_item( root, path, child ) ) {
                diagnostic = "cycle";
                return false;
            }
            if( query_path_contains_pocket(
                    root, path, pockets[pocket_index] ) ) {
                diagnostic = "cycle";
                return false;
            }
            return true;
        }
    }
    return false;
}

bool next_query_path(
    const item_query_root &root, const std::vector<int> &current_path,
    const item_page_options &options, std::vector<int> &next_path,
    bool &depth_limited, std::string &diagnostic )
{
    if( first_query_child_path( root, current_path, options, next_path,
                                depth_limited, diagnostic ) ) {
        return true;
    }
    if( diagnostic == "cycle" || diagnostic == "invalid_pocket" ) {
        return false;
    }

    std::vector<int> candidate = current_path;
    while( true ) {
        if( candidate.size() == 1 ) {
            const int next_root = candidate.front() + 1;
            if( next_root < 0 ||
                static_cast<std::size_t>( next_root ) >= root.roots.size() ) {
                return false;
            }
            next_path = { next_root };
            return true;
        }
        const int pocket_index = candidate[candidate.size() - 2];
        const int child_index = candidate.back();
        const std::vector<int> parent_path(
            candidate.begin(), candidate.end() - 2 );
        item_query_entry parent;
        bool invalid = false;
        if( !resolve_query_path( root, parent_path, parent, invalid ) ) {
            diagnostic = invalid ? "invalid_pocket" : "complete";
            return false;
        }
        const std::vector<item_pocket *> pockets =
            parent.value->get_contents().get_pockets(
        []( const item_pocket & ) {
            return true;
        } );
        if( pocket_index < 0 ||
            static_cast<std::size_t>( pocket_index ) >= pockets.size() ||
            pockets[pocket_index] == nullptr ) {
            diagnostic = "invalid_pocket";
            return false;
        }
        std::size_t sibling_index = static_cast<std::size_t>( child_index + 1 );
        for( item *sibling : pockets[pocket_index]->all_items_top() ) {
            if( sibling_index == 0 ) {
                if( sibling == nullptr || sibling->is_null() ) {
                    diagnostic = "invalid_pocket";
                    return false;
                }
                next_path = parent_path;
                next_path.push_back( pocket_index );
                next_path.push_back( child_index + 1 );
                if( query_path_contains_item( root, parent_path, sibling ) ) {
                    diagnostic = "cycle";
                    return false;
                }
                return true;
            }
            --sibling_index;
        }
        for( std::size_t next_pocket = static_cast<std::size_t>( pocket_index + 1 );
             next_pocket < pockets.size(); ++next_pocket ) {
            if( pockets[next_pocket] == nullptr ) {
                diagnostic = "invalid_pocket";
                return false;
            }
            const std::list<item *> children = pockets[next_pocket]->all_items_top();
            if( children.empty() ) {
                continue;
            }
            item *first = children.front();
            if( first == nullptr || first->is_null() ) {
                diagnostic = "invalid_pocket";
                return false;
            }
            next_path = parent_path;
            next_path.push_back( static_cast<int>( next_pocket ) );
            next_path.push_back( 0 );
            if( query_path_contains_item( root, parent_path, first ) ) {
                diagnostic = "cycle";
                return false;
            }
            if( query_path_contains_pocket(
                    root, parent_path, pockets[next_pocket] ) ) {
                diagnostic = "cycle";
                return false;
            }
            return true;
        }
        candidate = parent_path;
    }
}

game_handle make_query_item_handle(
    const item_query_root &root, const item_query_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    switch( root.holder.descriptor.kind ) {
        case item_holder_kind::character: {
            locator.scope = entry.depth == 0 ?
                            "character_" + root.holder.descriptor.slot :
                            "character_contained";
            const tripoint_abs_ms position = root.holder.character->pos_abs();
            locator.x = position.x();
            locator.y = position.y();
            locator.z = position.z();
            break;
        }
        case item_holder_kind::map_tile: {
            locator = map_item_locator( *root.holder.descriptor.tile );
            break;
        }
        case item_holder_kind::container_pocket:
            locator.scope = "container_pocket";
            locator.path.push_back( root.holder.descriptor.pocket_index );
            locator.x = root.holder.descriptor.container->locator().x;
            locator.y = root.holder.descriptor.container->locator().y;
            locator.z = root.holder.descriptor.container->locator().z;
            break;
        case item_holder_kind::vehicle_cargo: {
            locator.scope = "vehicle_cargo";
            locator.path.push_back( root.holder.descriptor.part_index );
            const tripoint_abs_ms position = root.holder.vehicle->pos_abs();
            locator.x = position.x();
            locator.y = position.y();
            locator.z = position.z();
            break;
        }
    }
    locator.path.insert( locator.path.end(), entry.path.begin(), entry.path.end() );
    locator.stable_id = entry.value->uid().get_value();
    return game_handle::from_item(
               *entry.value, std::move( locator ),
               runtime_generation, world_generation );
}

item_holder_descriptor query_entry_holder(
    const item_query_root &root, const item_query_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( entry.depth == 0 ) {
        return root.holder.descriptor;
    }
    item_holder_descriptor result;
    result.kind = item_holder_kind::container_pocket;
    const std::vector<int> parent_path(
        entry.path.begin(), entry.path.end() - 2 );
    item_query_entry parent_entry;
    parent_entry.value = entry.parent;
    parent_entry.path = parent_path;
    parent_entry.depth = entry.depth - 1;
    result.container = make_query_item_handle(
                           root, parent_entry,
                           runtime_generation, world_generation );
    result.pocket_index = entry.pocket_index;
    return result;
}

sol::table item_query_entry_to_lua(
    sol::state_view lua, const item_query_root &root,
    const item_query_entry &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table result = lua.create_table();
    result["handle"] = make_query_item_handle(
                           root, entry, runtime_generation, world_generation );
    result["snapshot"] = snapshot_item(
                             lua, *entry.value, default_item_relation_limit );
    result["holder"] = item_holder_to_lua(
                           lua, query_entry_holder(
                               root, entry, runtime_generation,
                               world_generation ) );
    result["depth"] = entry.depth;
    result["uid"] = entry.value->uid().get_value();
    if( entry.parent != nullptr ) {
        result["parent_uid"] = entry.parent->uid().get_value();
    }
    return result;
}

bool same_item_page_options(
    const item_page_options &lhs, const item_page_options &rhs )
{
    return lhs.page_size == rhs.page_size &&
           lhs.max_depth == rhs.max_depth &&
           lhs.recursive == rhs.recursive;
}

bool same_query_holder_descriptor(
    const item_holder_descriptor &lhs,
    const item_holder_descriptor &rhs )
{
    if( lhs.kind != rhs.kind || lhs.slot != rhs.slot ||
        lhs.pocket_index != rhs.pocket_index ) {
        return false;
    }
    if( lhs.tile.has_value() != rhs.tile.has_value() ) {
        return false;
    }
    if( lhs.tile && !( *lhs.tile == *rhs.tile ) ) {
        return false;
    }
    const auto same_handle = []( const std::optional<game_handle> &left,
    const std::optional<game_handle> &right ) {
        if( left.has_value() != right.has_value() ) {
            return false;
        }
        if( !left ) {
            return true;
        }
        return left->kind() == right->kind() &&
               left->runtime_generation() == right->runtime_generation() &&
               left->world_generation() == right->world_generation() &&
               left->locator().scope == right->locator().scope &&
               left->locator().stable_id == right->locator().stable_id &&
               left->locator().x == right->locator().x &&
               left->locator().y == right->locator().y &&
               left->locator().z == right->locator().z &&
               left->locator().path == right->locator().path &&
               left->locator().owner_generation ==
               right->locator().owner_generation;
    };
    return same_handle( lhs.character, rhs.character ) &&
           same_handle( lhs.container, rhs.container ) &&
           same_handle( lhs.vehicle, rhs.vehicle ) &&
           same_handle( lhs.part, rhs.part );
}

sol::table item_page(
    sol::this_state lua, const sol::table &holder_table,
    const sol::optional<sol::table> &requested_options,
    const sol::optional<sol::table> &requested_continuation,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.items.page";
    const item_holder_descriptor descriptor =
        read_item_holder_descriptor( holder_table, api_name );
    const item_page_options options =
        read_item_page_options( requested_options );
    sol::state_view state( lua );

    std::optional<item_query_cursor_state> prior;
    if( requested_continuation ) {
        const sol::object raw_id = requested_continuation->raw_get<sol::object>(
                                       "continuation_id" );
        if( !raw_id.is<lua_Integer>() || raw_id.as<lua_Integer>() <= 0 ) {
            return make_game_error_result( state, {
                "stale_continuation",
                "The item page continuation id is invalid"
            } );
        }
        const std::uint64_t id = static_cast<std::uint64_t>(
                                     raw_id.as<lua_Integer>() );
        const auto found = item_query_cursors.find( id );
        if( found == item_query_cursors.end() ) {
            return make_game_error_result( state, {
                "stale_continuation",
                "The item page continuation is unknown or already consumed"
            } );
        }
        prior = std::move( found->second );
        item_query_cursors.erase( found );
        if( !prior->runtime.is_active_match( runtime_generation ) ||
            prior->world_generation != world_generation ||
            prior->mutation_epoch != item_query_mutation_epoch ) {
            return make_game_error_result( state, {
                "stale_continuation",
                "The item page continuation belongs to an old runtime, world, or holder mutation"
            } );
        }
        if( !same_item_page_options( prior->options, options ) ||
            !same_query_holder_descriptor( prior->holder, descriptor ) ) {
            return make_game_error_result( state, {
                "continuation_mismatch",
                "The item page continuation does not match its holder or query options"
            } );
        }
    }

    item_query_root root;
    if( const std::optional<game_handle_error> error = build_item_query_root(
                descriptor, runtime_generation, world_generation, root ) ) {
        return make_game_error_result( state, *error );
    }

    std::vector<int> path;
    std::set<std::int64_t> seen_item_uids;
    bool depth_limited = false;
    if( prior ) {
        path = prior->next_path;
        seen_item_uids = prior->seen_item_uids;
        depth_limited = prior->depth_limited;
        if( !prior->next_item || path.empty() ) {
            return make_game_error_result( state, {
                "stale_continuation",
                "The item page continuation has no resumable cursor"
            } );
        }
        const native_handle_result<item> next_item =
            prior->next_item->resolve_item(
                runtime_generation, world_generation );
        item_query_entry next_entry;
        bool invalid = false;
        if( !next_item || !resolve_query_path(
                root, path, next_entry, invalid ) ||
            next_entry.value != next_item.value ) {
            return make_game_error_result( state, {
                "stale_continuation",
                invalid ?
                "The item page continuation points into an invalid pocket" :
                "The item page continuation no longer points to the same Item"
            } );
        }
    } else if( !root.roots.empty() ) {
        path = { 0 };
    }

    std::vector<item_query_entry> entries;
    entries.reserve( static_cast<std::size_t>( options.page_size ) );
    std::vector<int> next_path;
    std::string stop_reason = root.roots.empty() ? "empty" : "complete";
    bool has_next = false;
    bool fatal = false;
    std::size_t scanned = 0;
    while( !path.empty() ) {
        if( scanned >= maximum_item_page_nodes ) {
            stop_reason = "node_budget";
            next_path = path;
            has_next = true;
            break;
        }
        item_query_entry current;
        bool invalid = false;
        if( !resolve_query_path( root, path, current, invalid ) ) {
            stop_reason = invalid ? "invalid_pocket" : "stale_cursor";
            fatal = true;
            break;
        }
        if( !seen_item_uids.insert( current.value->uid().get_value() ).second ) {
            stop_reason = "repeated_item";
            fatal = true;
            break;
        }
        ++scanned;
        entries.push_back( current );

        std::vector<int> candidate;
        std::string diagnostic;
        if( !next_query_path( root, path, options, candidate,
                              depth_limited, diagnostic ) ) {
            if( diagnostic == "cycle" || diagnostic == "invalid_pocket" ) {
                stop_reason = diagnostic;
                fatal = true;
            } else if( depth_limited ) {
                stop_reason = "max_depth";
            } else {
                stop_reason = "complete";
            }
            break;
        }
        if( entries.size() >= static_cast<std::size_t>( options.page_size ) ) {
            next_path = std::move( candidate );
            has_next = true;
            stop_reason = "page";
            break;
        }
        path = std::move( candidate );
    }

    sol::table items = state.create_table(
                           static_cast<int>( entries.size() ), 0 );
    for( std::size_t index = 0; index < entries.size(); ++index ) {
        items[index + 1] = item_query_entry_to_lua(
                               state, root, entries[index],
                               runtime_generation, world_generation );
    }

    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["holder"] = item_holder_to_lua( state, descriptor );
    value["page_size"] = options.page_size;
    value["returned"] = entries.size();
    const bool complete = !fatal && !has_next &&
                          ( stop_reason == "complete" ||
                            stop_reason == "empty" );
    value["complete"] = complete;
    value["truncated"] = !complete;
    value["stop_reason"] = stop_reason;
    value["max_depth"] = options.max_depth;
    value["recursive"] = options.recursive;

    if( has_next && !fatal ) {
        item_query_entry next_entry;
        bool invalid = false;
        if( !resolve_query_path( root, next_path, next_entry, invalid ) ) {
            value["complete"] = false;
            value["truncated"] = true;
            value["stop_reason"] = invalid ? "invalid_pocket" : "stale_cursor";
            value["continuation"] = sol::nil;
            value["next"] = sol::nil;
        } else {
            item_query_cursor_state cursor;
            cursor.holder = descriptor;
            cursor.options = options;
            cursor.runtime = runtime_generation;
            cursor.world_generation = world_generation;
            cursor.mutation_epoch = item_query_mutation_epoch;
            cursor.next_path = next_path;
            cursor.next_item = make_query_item_handle(
                                   root, next_entry, runtime_generation,
                                   world_generation );
            cursor.seen_item_uids = std::move( seen_item_uids );
            cursor.depth_limited = depth_limited;
            if( item_query_cursors.size() >= maximum_item_page_cursors ) {
                return make_game_error_result( state, {
                    "cursor_limit",
                    "The bounded item-page continuation registry is full"
                } );
            }
            const std::uint64_t id = next_item_query_cursor_id++;
            item_query_cursors.emplace( id, std::move( cursor ) );
            sol::table continuation = state.create_table();
            continuation["continuation_id"] = static_cast<lua_Integer>( id );
            continuation["holder"] = item_holder_to_lua( state, descriptor );
            continuation["page_size"] = options.page_size;
            continuation["max_depth"] = options.max_depth;
            continuation["recursive"] = options.recursive;
            continuation["same_runtime_world_holder"] = true;
            continuation["reason"] = stop_reason;
            value["continuation"] = continuation;
            value["next"] = continuation;
        }
    } else {
        value["continuation"] = sol::nil;
        value["next"] = sol::nil;
    }
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

int item_relation_limit(
    const sol::optional<int> &requested )
{
    const int result =
        requested.value_or( default_item_relation_limit );
    if( result < 0 ) {
        throw std::invalid_argument(
            "services.items.snapshot relation_limit cannot be negative" );
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
        requested_id, "item", "services.items.food_fun" );
    const itype_id id( requested_id.value() );
    return id->comestible ? id->comestible->get_fun() : 0;
}

sol::table possible_items_from_group(
    sol::this_state lua, const script_game_id &requested_group )
{
    constexpr std::string_view api_name =
        "services.items.possible_from_group";
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
                "services.items.update field names must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = field.second;
        if( key == "charges" ) {
            const std::int64_t charges = integer_option(
                                             value, key,
                                             "services.items.update" );
            if( charges < 0 ||
                charges > maximum_item_charges ) {
                throw std::invalid_argument(
                    "services.items.update charges is outside its limit" );
            }
            if( !entry.type->can_have_charges() ) {
                throw std::invalid_argument(
                    "services.items.update cannot set charges on this item type" );
            }
            result.charges = static_cast<int>( charges );
        } else if( key == "damage" ) {
            const std::int64_t damage = integer_option(
                                            value, key,
                                            "services.items.update" );
            if( damage < 0 ||
                damage > entry.max_damage() ) {
                throw std::invalid_argument(
                    "services.items.update damage is outside this item's range" );
            }
            result.damage = static_cast<int>( damage );
        } else if( key == "degradation" ) {
            const std::int64_t degradation = integer_option(
                                                 value, key, "services.items.update" );
            if( degradation < 0 ||
                degradation > entry.max_damage() ) {
                throw std::invalid_argument(
                    "services.items.update degradation is outside this item's range" );
            }
            result.degradation = static_cast<int>( degradation );
        } else if( key == "burnt" ) {
            const std::int64_t burnt = integer_option(
                                           value, key,
                                           "services.items.update" );
            if( burnt < 0 || burnt > maximum_item_burnt ) {
                throw std::invalid_argument(
                    "services.items.update burnt is outside its limit" );
            }
            if( entry.base_volume() <= 0_ml ) {
                throw std::invalid_argument(
                    "services.items.update cannot set burnt on a zero-volume item" );
            }
            result.burnt = static_cast<int>( burnt );
        } else if( key == "favorite" ) {
            result.favorite = boolean_option(
                                  value, key,
                                  "services.items.update" );
        } else if( key == "active" ) {
            result.active = boolean_option(
                                value, key,
                                "services.items.update" );
        } else if( key == "browsed" ) {
            result.browsed = boolean_option(
                                 value, key,
                                 "services.items.update" );
        } else if( key == "relative_rot" ) {
            if( !value.is<double>() && !value.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    "services.items.update relative_rot must be numeric" );
            }
            const double relative_rot = value.as<double>();
            if( !std::isfinite( relative_rot ) ||
                relative_rot < -maximum_item_relative_rot ||
                relative_rot > maximum_item_relative_rot ) {
                throw std::invalid_argument(
                    "services.items.update relative_rot must be finite and within its limit" );
            }
            if( !entry.goes_bad() ) {
                throw std::invalid_argument(
                    "services.items.update cannot set relative_rot on an item that does not rot" );
            }
            result.relative_rot = relative_rot;
        } else if( key == "rot" ) {
            if( !value.is<script_time_duration>() ) {
                throw std::invalid_argument(
                    "services.items.update rot must be a TimeDuration" );
            }
            if( !entry.goes_bad() ) {
                throw std::invalid_argument(
                    "services.items.update cannot set rot on an item that does not rot" );
            }
            result.rot = value.as<script_time_duration>().to_native();
        } else {
            throw std::invalid_argument(
                "services.items.update received unknown field '" +
                key + "'" );
        }
        found = true;
    }
    if( !found ) {
        throw std::invalid_argument(
            "services.items.update requires at least one field" );
    }
    if( result.rot && result.relative_rot ) {
        throw std::invalid_argument(
            "services.items.update cannot set rot and relative_rot together" );
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
            requested_damage_type, "services.items.melee_damage" );
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
            requested_damage_type, "services.items.gun_damage" );
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
        requested_quality, "quality", "services.items.quality" );
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
                "services.items.transform option names must be strings" );
        }
        const std::string key = key_object.as<std::string>();
        const sol::object value = field.second;
        if( key == "carrier" ) {
            if( !value.is<game_handle>() ) {
                throw std::invalid_argument(
                    "services.items.transform option 'carrier' must be a GameHandle" );
            }
            result.carrier = value.as<game_handle>();
        } else if( key == "active" ) {
            result.active = boolean_option(
                                value, key,
                                "services.items.transform" );
        } else if( key == "browsed" ) {
            result.browsed = boolean_option(
                                 value, key,
                                 "services.items.transform" );
        } else {
            throw std::invalid_argument(
                "services.items.transform received unknown option '" +
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
        target, "item", "services.items.transform" );
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
        item *owned_item = nullptr;
        std::optional<game_handle_error> carrier_error;
        if( !resolve_exact_item_for_character(
                *options.carrier, handle, runtime_generation,
                world_generation, carrier, owned_item, carrier_error ) ) {
            return make_game_error_result( state, *carrier_error );
        }
        if( owned_item != resolved.value ) {
            return make_game_error_result( state, {
                "stale_item",
                "The transform item identity changed while resolving its carrier"
            } );
        }
    }

    item &entry = *resolved.value;
    sol::table value = state.create_table();
    value["before"] = mutable_item_state( state, entry );
    retire_item_handle_identity( entry );
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
    value["old_handle_stale"] = true;
    game_handle_locator replacement_locator = handle.locator();
    value["handle"] = game_handle::from_item(
                          entry, std::move( replacement_locator ),
                          runtime_generation, world_generation );
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
    validate_item_var_key( key, "services.items.get_var" );
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
                "services.items.set_var string exceeds 4096 bytes" );
        }
        if( value.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "services.items.set_var string cannot contain NUL bytes" );
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
                "services.items.set_var coordinate must use absolute map squares" );
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
                "services.items.set_var number is outside its limit" );
        }
        entry.set_var( key, value );
        return;
    }
    throw std::invalid_argument(
        "services.items.set_var value must be a string, number, or absolute map-square coordinate" );
}

sol::table set_item_var(
    sol::this_state lua, const game_handle &handle,
    const std::string &key, const sol::object &requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    validate_item_var_key( key, "services.items.set_var" );
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
    validate_item_var_key( key, "services.items.erase_var" );
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
        flag, "json_flag", "services.items.has_flag" );
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
    const game_handle &character_handle,
    const sol::optional<std::string> &method,
    const int quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( quantity <= 0 || quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "services.items.ammo_sufficient quantity must be within 1..1000000000" );
    }
    if( method && method->size() > maximum_item_method_bytes ) {
        throw std::invalid_argument(
            "services.items.ammo_sufficient method exceeds 256 bytes" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *carrier = nullptr;
    item *resolved_item = nullptr;
    if( !resolve_exact_item_for_character(
            character_handle, item_handle, runtime_generation,
            world_generation, carrier, resolved_item, error ) ) {
        return make_game_error_result( state, *error );
    }
    const bool sufficient = method ?
                            resolved_item->ammo_sufficient(
                                carrier, *method, quantity ) :
                            resolved_item->ammo_sufficient(
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
        flag, "json_flag", "services.items.set_flag" );
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
                "services.items fault option names must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key == "force" ) {
            result.force = boolean_option(
                               field.second, key,
                               "services.items.set_fault" );
        } else if( key == "message" ) {
            result.message = boolean_option(
                                 field.second, key,
                                 "services.items.set_fault" );
        } else if( key == "holder" ) {
            if( !field.second.is<game_handle>() ) {
                throw std::invalid_argument(
                    "services.items fault option 'holder' must be a GameHandle" );
            }
            result.holder = field.second.as<game_handle>();
        } else {
            throw std::invalid_argument(
                "services.items.set_fault received unknown option '" + key + "'" );
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
    Character *character = resolve_exact_character(
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
                "services.items.activate option names must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key != "target" ) {
            throw std::invalid_argument(
                "services.items.activate received unknown option '" + key + "'" );
        }
        if( !field.second.is<script_tripoint_coord>() ) {
            throw std::invalid_argument(
                "services.items.activate option 'target' must be a Tripoint" );
        }
        const script_tripoint_coord target =
            field.second.as<script_tripoint_coord>();
        if( target.native_origin() != coords::origin::abs ||
            target.native_scale() != coords::scale::map_square ) {
            throw std::invalid_argument(
                "services.items.activate option 'target' must be an absolute "
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
            "services.items.activate method must contain 1..256 bytes" );
    }
    for( const unsigned char character : method ) {
        if( character < 0x20U || character == 0x7fU ) {
            throw std::invalid_argument(
                "services.items.activate method cannot contain control characters" );
        }
    }
    const item_activation_options options =
        read_item_activation_options( requested );
    sol::state_view state( lua );
    if( !options.target ) {
        return make_game_error_result( state, {
            "missing_target",
            "services.items.activate requires an explicit absolute map-square target"
        } );
    }
    std::optional<game_handle_error> error;
    Character *character = nullptr;
    item *entry = nullptr;
    if( !resolve_exact_item_for_character(
            character_handle, item_handle, runtime_generation,
            world_generation, character, entry, error ) ) {
        return make_game_error_result( state, *error );
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
    if( !here.inbounds( *options.target ) ) {
        return make_game_error_result( state, {
            "target_out_of_bounds",
            "The activation target is outside the loaded map"
        } );
    }
    const tripoint_bub_ms target = here.get_bub( *options.target );

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
    value["stale"] = !after;
    value["method"] = method;
    if( after ) {
        value["item"] = snapshot_item( state, *after.value, 16 );
        game_handle_locator replacement_locator = item_handle.locator();
        value["handle"] = game_handle::from_item(
                              *after.value, std::move( replacement_locator ),
                              runtime_generation, world_generation );
    } else {
        value["item"] = sol::nil;
        value["handle"] = sol::nil;
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
    require_id_kind( fault, "fault", "services.items.set_fault" );
    if( !fault.is_valid() ) {
        throw std::invalid_argument(
            "services.items.set_fault requires a valid GameId<fault>" );
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
            "services.items.set_random_fault requires a bounded fault type" );
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
        "services.items.has_technique" );
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
        "services.items.set_technique" );
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
    Character *owner = resolve_exact_character(
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
                "services.inventory.give option keys must be strings" );
        }
        const std::string key =
            key_object.as<std::string>();
        if( key == "container" ) {
            if( !entry.second.is<script_game_id>() ) {
                throw std::invalid_argument(
                    "services.inventory.give container must be a GameId<item>" );
            }
            const script_game_id id =
                entry.second.as<script_game_id>();
            require_id_kind(
                id, "item", "services.inventory.give" );
            result.container = itype_id( id.value() );
        } else if( key == "flags" ) {
            if( !entry.second.is<sol::table>() ) {
                throw std::invalid_argument(
                    "services.inventory.give flags must be a dense GameId array" );
            }
            const sol::table flags =
                entry.second.as<sol::table>();
            std::map<std::size_t, flag_id> indexed;
            for( const auto &flag_entry : flags ) {
                if( !flag_entry.first.is<lua_Integer>() ||
                    !flag_entry.second.is<script_game_id>() ) {
                    throw std::invalid_argument(
                        "services.inventory.give flags must be a dense GameId array" );
                }
                const lua_Integer raw_index =
                    flag_entry.first.as<lua_Integer>();
                if( raw_index <= 0 ||
                    static_cast<std::uint64_t>( raw_index ) >
                    maximum_inventory_spawn_flags ) {
                    throw std::invalid_argument(
                        "services.inventory.give flag index must be within 1..128" );
                }
                const script_game_id id =
                    flag_entry.second.as<script_game_id>();
                require_id_kind(
                    id, "json_flag", "services.inventory.give" );
                indexed.emplace(
                    static_cast<std::size_t>( raw_index ),
                    flag_id( id.value() ) );
            }
            if( !indexed.empty() &&
                indexed.rbegin()->first != indexed.size() ) {
                throw std::invalid_argument(
                    "services.inventory.give flags must not contain holes" );
            }
            for( const auto &[index, flag] : indexed ) {
                static_cast<void>( index );
                result.flags.push_back( flag );
            }
        } else {
            throw std::invalid_argument(
                "services.inventory.give received unknown option '" +
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
    result["holder"] = item_holder_to_lua(
                           lua, character_item_holder_descriptor(
                               character, entry,
                               parents.empty() ? nullptr : parents.front(),
                               -1, runtime_generation, world_generation ) );
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
        "services.inventory.choose";
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        "services.inventory.choose_many";
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
                                 "services.inventory.choose_many_map" :
                                 "services.inventory.choose_map";
    const map_inventory_selection_options options =
        read_map_inventory_selection_options(
            requested_options,
            multiple ? "Select items." : "Select an item.",
            api_name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        type, "item", "services.inventory.resources" );
    if( quantity < 0 ||
        quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "services.inventory.resources quantity is outside its limit" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
    constexpr std::string_view api_name = "services.inventory.has_items_sum";
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
    Character *character = resolve_exact_character(
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
        "services.inventory.has_software";
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
    Character *character = resolve_exact_character(
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
        "services.inventory.has_worn_flag";
    require_id_kind(
        requested_flag, "json_flag", std::string( api_name ) );
    if( requested_body_part ) {
        require_id_kind(
            *requested_body_part, "body_part",
            std::string( api_name ) );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        requested_item, "item", "services.inventory.is_wearing" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        "services.inventory.has_item_flag" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        "services.inventory.category_count" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        "services.inventory.item_radiation" );
    const std::string aggregate_name =
        requested_aggregate.value_or( "min" );
    const std::optional<aggregate_type> aggregate_kind =
        item_radiation_aggregate( aggregate_name );
    if( !aggregate_kind ) {
        throw std::invalid_argument(
            "services.inventory.item_radiation aggregate must be first, last, min, max, sum, or average" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        "services.inventory.wielded_matches";
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
    Character *character = resolve_exact_character(
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
    Character *holder = resolve_exact_character(
                            holder_handle, runtime_generation,
                            world_generation, error );
    if( holder == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *owner = resolve_exact_character(
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
    Character *character = resolve_exact_character(
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
        type, "item", "services.inventory.give" );
    if( quantity <= 0 ||
        quantity > maximum_inventory_resource_quantity ) {
        throw std::invalid_argument(
            "services.inventory.give quantity is outside its limit" );
    }
    const inventory_give_options options =
        read_inventory_give_options( requested );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
            "services.inventory.give cannot create more than 100 item instances at once" );
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
                                  false, false );
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
        group, "item_group", "services.inventory.give_group" );
    const inventory_give_options options =
        read_inventory_give_options( requested );
    if( options.container ) {
        throw std::invalid_argument(
            "services.inventory.give_group does not support a container option because groups preserve their native containers" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
                                     false, false );
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
        type, "item", "services.inventory.consume" );
    if( requested_count < 0 ||
        requested_count > maximum_inventory_resource_quantity ||
        requested_charges < 0 ||
        requested_charges > maximum_inventory_resource_quantity ||
        ( requested_count == 0 && requested_charges == 0 ) ) {
        throw std::invalid_argument(
            "services.inventory.consume count and charges must be bounded nonnegative values with a positive total" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
            "services.inventory.consume request exceeds native integer bounds" );
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
    Character *recipient = resolve_exact_character(
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
            "services.inventory.hand_in received an invalid consumption result" );
    }
    sol::table value = raw_value.as<sol::table>();
    const itype_id native_type( type.value() );
    const int display_count = static_cast<int>( std::max<std::int64_t>(
                                  1, requested_count ) );
    if( display_count == 1 ) {
        value["notice"] = string_format(
                              to_translation( "You give %1$s a %2$s." ).translated(),
                              recipient->get_name(),
                              item::nname( native_type ) );
    } else {
        value["notice"] = string_format(
                              to_translation( "You give %1$s %2$d %3$s." ).translated(),
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
            "services.inventory.consume_sum requires 1..128 weighted item entries" );
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
                "services.inventory.consume_sum entries must be a dense table array" );
        }
        const sol::table row = row_object.as<sol::table>();
        const sol::object id_object = row["item"];
        const sol::object amount_object = row["amount"];
        if( !id_object.is<script_game_id>() ||
            amount_object.get_type() != sol::type::number ) {
            throw std::invalid_argument(
                "services.inventory.consume_sum entries require item and numeric amount fields" );
        }
        const script_game_id id =
            id_object.as<script_game_id>();
        require_id_kind(
            id, "item", "services.inventory.consume_sum" );
        const double desired = amount_object.as<double>();
        if( !std::isfinite( desired ) || desired <= 0.0 ||
            desired > maximum_inventory_resource_quantity ) {
            throw std::invalid_argument(
                "services.inventory.consume_sum amount must be finite and within 0..1000000000" );
        }
        entries.push_back( { id, desired, 0, 0 } );
    }

    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
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
        "services.item_categories.spawn_rate";
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
        "services.item_categories.set_spawn_rate";
    const item_category_id native_id =
        require_item_category_id( id, api_name );
    const float rate = require_item_category_spawn_rate(
                           requested_rate, api_name );
    const float before = native_id.obj().get_spawn_rate();
    const std::vector<std::pair<item_category_id, float>> native_updates = {
        { native_id, rate }
    };
    sol::state_view state( lua );
    sol::table value = state.create_table();
    value["id"] = id;
    value["before"] = before;
    value["after"] = rate;
    value["changed"] = before != rate;
    sol::table result = make_game_value_result(
                            state, sol::make_object( state, std::move( value ) ) );
    item_category_spawn_rates::get_item_category_spawn_rates().set_spawn_rates(
        native_updates );
    return result;
}

struct item_category_spawn_rate_update {
    script_game_id script_id;
    item_category_id native_id;
    float rate = 1.0F;
    float before = 1.0F;
};

std::vector<item_category_spawn_rate_update>
read_item_category_spawn_rate_updates( const sol::table &requested )
{
    constexpr std::string_view api_name =
        "services.item_categories.set_spawn_rates";
    if( requested.size() > maximum_spawn_rate_updates ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " requires at most 256 updates" );
    }
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
        const float rate = require_item_category_spawn_rate(
                               table.get<double>( "spawn_rate" ), api_name );
        updates.push_back( {
            id, native_id, rate, native_id.obj().get_spawn_rate()
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
    std::vector<std::pair<item_category_id, float>> native_updates;
    native_updates.reserve( updates.size() );
    for( std::size_t index = 0; index < updates.size(); ++index ) {
        const item_category_spawn_rate_update &update =
            updates[index];
        sol::table entry = state.create_table();
        entry["id"] = update.script_id;
        entry["before"] = update.before;
        entry["after"] = update.rate;
        entry["changed"] = update.before != update.rate;
        changed[index + 1] = std::move( entry );
        native_updates.emplace_back( update.native_id, update.rate );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( changed );
    value["count"] = updates.size();
    sol::table result = make_game_value_result(
                            state, sol::make_object( state, std::move( value ) ) );
    item_category_spawn_rates::get_item_category_spawn_rates().set_spawn_rates(
        native_updates );
    return result;
}

struct inserted_item {
    item *value = nullptr;
    std::function<bool()> rollback;
};

bool same_item_holder(
    const resolved_item_holder &lhs, const resolved_item_holder &rhs )
{
    if( lhs.descriptor.kind != rhs.descriptor.kind ) {
        return false;
    }
    switch( lhs.descriptor.kind ) {
        case item_holder_kind::character:
            return lhs.character == rhs.character &&
                   lhs.descriptor.slot == rhs.descriptor.slot;
        case item_holder_kind::map_tile:
            return *lhs.descriptor.tile == *rhs.descriptor.tile;
        case item_holder_kind::container_pocket:
            return lhs.container == rhs.container &&
                   lhs.descriptor.pocket_index == rhs.descriptor.pocket_index;
        case item_holder_kind::vehicle_cargo:
            return lhs.vehicle == rhs.vehicle &&
                   lhs.part == rhs.part;
    }
    return false;
}

std::optional<game_handle_error> insert_item_into_holder(
    const resolved_item_holder &destination, const item &source_copy,
    const item *source_original,
    inserted_item &inserted )
{
    inserted = {};
    if( destination.descriptor.kind == item_holder_kind::character ) {
        Character &character = *destination.character;
        if( destination.descriptor.slot == "inventory" ) {
            bool stack_conflict = false;
            character.visit_items( [&source_copy, &stack_conflict, source_original](
            item * candidate, item * ) {
                if( candidate != nullptr && candidate != source_original &&
                    candidate->stacks_with( source_copy ) ) {
                    stack_conflict = true;
                    return VisitResponse::ABORT;
                }
                return VisitResponse::NEXT;
            } );
            if( stack_conflict || !character.can_add(
                    source_copy, source_original, false, false ) ) {
                return game_handle_error{
                    "destination_rejected",
                    "The Character inventory rejected the exact Item transfer"
                };
            }
            item_location location = character.try_add(
                                         source_copy, source_original,
                                         source_original,
                                         false, false );
            if( !location ) {
                return game_handle_error{
                    "destination_rejected",
                    "The Character inventory rejected the exact Item transfer"
                };
            }
            inserted.value = location.get_item();
            inserted.rollback = [location]() mutable {
                location.remove_item();
                return location.get_item() == nullptr;
            };
            return std::nullopt;
        }
        if( destination.descriptor.slot == "wielded" ) {
            if( character.has_weapon() ||
                !character.can_wield( source_copy ).success() ) {
                return game_handle_error{
                    "destination_rejected",
                    "The Character cannot accept the Item as its explicit weapon"
                };
            }
            item copy = source_copy;
            if( !character.wield( copy ) ) {
                return game_handle_error{
                    "destination_rejected",
                    "The Character rejected the explicit wield destination"
                };
            }
            item_location location = character.get_wielded_item();
            if( !location ) {
                return game_handle_error{
                    "destination_rejected",
                    "The explicit wield destination did not produce an Item"
                };
            }
            inserted.value = location.get_item();
            inserted.rollback = [location]() mutable {
                location.remove_item();
                return location.get_item() == nullptr;
            };
            return std::nullopt;
        }
        if( !character.can_wear( source_copy ).success() ) {
            return game_handle_error{
                "destination_rejected",
                "The Character rejected the explicit worn destination"
            };
        }
        item copy = source_copy;
        const std::optional<std::list<item>::iterator> worn =
            character.wear_item( copy, false, true, true, true );
        if( !worn ) {
            return game_handle_error{
                "destination_rejected",
                "The Character rejected the explicit worn destination"
            };
        }
        item_location location( character, & **worn );
        inserted.value = location.get_item();
        inserted.rollback = [location]() mutable {
            location.remove_item();
            return location.get_item() == nullptr;
        };
        return std::nullopt;
    }

    if( destination.descriptor.kind == item_holder_kind::map_tile ) {
        map &here = get_map();
        const tripoint_abs_ms absolute = destination.descriptor.tile->native_position();
        const tripoint_bub_ms local = here.get_bub( absolute );
        map_stack stack = here.i_at( local );
        const int needed = source_copy.count_by_charges() ?
                           source_copy.charges : 1;
        if( !here.can_put_items( local ) ||
            stack.amount_can_fit( source_copy ) < needed ) {
            return game_handle_error{
                "destination_rejected",
                "The map tile cannot accept the complete Item transfer"
            };
        }
        item &placed = here.add_item( local, source_copy );
        if( placed.is_null() ) {
            return game_handle_error{
                "destination_rejected",
                "The map tile rejected the exact Item transfer"
            };
        }
        inserted.value = &placed;
        inserted.rollback = [absolute, &placed]() mutable {
            item_location location( map_cursor( absolute ), &placed );
            location.remove_item();
            return location.get_item() == nullptr;
        };
        return std::nullopt;
    }

    if( destination.descriptor.kind == item_holder_kind::container_pocket ) {
        if( destination.pocket->has_item_stacks_with( source_copy ) ) {
            return game_handle_error{
                "destination_rejected",
                "The Item cannot be inserted into this container pocket"
            };
        }
        const ret_val<item *> result = destination.pocket->insert_item(
                                           source_copy, false, false, false );
        if( !result.success() || result.value() == nullptr ) {
            return game_handle_error{
                "destination_rejected",
                "The container pocket rejected the exact Item transfer"
            };
        }
        destination.container->on_contents_changed();
        inserted.value = result.value();
        inserted.rollback = [pocket = destination.pocket,
                                    container = destination.container,
               value = result.value()]() mutable {
            const std::optional<item> removed = pocket->remove_item( *value );
            if( removed )
            {
                container->on_contents_changed();
            }
            return removed.has_value();
        };
        return std::nullopt;
    }

    if( destination.part->is_broken() ) {
        return game_handle_error{
            "destination_rejected",
            "The vehicle cargo part is broken"
        };
    }
    vehicle_stack stack = destination.vehicle->get_items( *destination.part );
    const int needed = source_copy.count_by_charges() ?
                       source_copy.charges : 1;
    if( stack.stacks_with( source_copy ) != nullptr ||
        stack.amount_can_fit( source_copy ) < needed ) {
        return game_handle_error{
            "destination_rejected",
            "The vehicle cargo part cannot accept the complete Item transfer"
        };
    }
    const std::optional<vehicle_stack::iterator> added =
        destination.vehicle->add_item( get_map(), *destination.part, source_copy );
    if( !added ) {
        return game_handle_error{
            "destination_rejected",
            "The vehicle cargo part rejected the exact Item transfer"
        };
    }
    inserted.value = & **added;
    inserted.rollback = [vehicle = destination.vehicle,
                                 part = destination.part,
            value = inserted.value]() mutable {
        return vehicle->remove_item( *part, value );
    };
    return std::nullopt;
}

bool remove_item_from_holder( resolved_item_holder &source )
{
    if( source.descriptor.kind == item_holder_kind::character ) {
        const item removed = source.character->i_rem( source.target );
        return !removed.is_null();
    }
    if( source.descriptor.kind == item_holder_kind::map_tile ) {
        if( !source.location ) {
            return false;
        }
        source.location->remove_item();
        return source.location->get_item() == nullptr;
    }
    if( source.descriptor.kind == item_holder_kind::container_pocket ) {
        const std::optional<item> removed =
            source.pocket->remove_item( *source.target );
        if( removed ) {
            source.container->on_contents_changed();
        }
        return removed.has_value();
    }
    return source.vehicle->remove_item( *source.part, source.target );
}

game_handle make_transferred_item_handle(
    const resolved_item_holder &destination, item &entry,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    game_handle_locator locator;
    switch( destination.descriptor.kind ) {
        case item_holder_kind::character: {
            const item_holder_descriptor actual =
                character_item_holder_descriptor(
                    *destination.character, entry, nullptr, -1,
                    runtime_generation, world_generation );
            if( actual.kind == item_holder_kind::container_pocket ) {
                locator.scope = "character_contained";
                locator.path.push_back( actual.pocket_index );
            } else {
                locator.scope = "character_" + actual.slot;
            }
            const tripoint_abs_ms position = destination.character->pos_abs();
            locator.x = position.x();
            locator.y = position.y();
            locator.z = position.z();
            break;
        }
        case item_holder_kind::map_tile: {
            locator = map_item_locator( *destination.descriptor.tile );
            break;
        }
        case item_holder_kind::container_pocket:
            locator.scope = "container_pocket";
            locator.path.push_back( destination.descriptor.pocket_index );
            locator.x = destination.descriptor.container->locator().x;
            locator.y = destination.descriptor.container->locator().y;
            locator.z = destination.descriptor.container->locator().z;
            break;
        case item_holder_kind::vehicle_cargo: {
            locator.scope = "vehicle_cargo";
            locator.path.push_back( destination.descriptor.part_index );
            const tripoint_abs_ms position = destination.vehicle->pos_abs();
            locator.x = position.x();
            locator.y = position.y();
            locator.z = position.z();
            break;
        }
    }
    locator.stable_id = entry.uid().get_value();
    return game_handle::from_item(
               entry, std::move( locator ),
               runtime_generation, world_generation );
}

sol::table transfer_item(
    sol::this_state lua, const game_handle &item_handle,
    const sol::table &source_holder_table,
    const sol::table &destination_holder_table,
    const sol::optional<std::int64_t> &requested_quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.items.transfer";
    const item_holder_descriptor source_descriptor =
        read_item_holder_descriptor( source_holder_table, api_name );
    const item_holder_descriptor destination_descriptor =
        read_item_holder_descriptor( destination_holder_table, api_name );
    sol::state_view state( lua );
    const native_handle_result<item> resolved = item_handle.resolve_item(
                runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }

    resolved_item_holder source;
    if( const std::optional<game_handle_error> error = resolve_item_holder(
                source_descriptor, runtime_generation, world_generation,
                resolved.value, source ) ) {
        return make_game_error_result( state, *error );
    }
    resolved_item_holder destination;
    if( const std::optional<game_handle_error> error = resolve_item_holder(
                destination_descriptor, runtime_generation, world_generation,
                nullptr, destination ) ) {
        return make_game_error_result( state, *error );
    }
    if( same_item_holder( source, destination ) ) {
        return make_game_error_result( state, {
            "same_holder", "The Item transfer source and destination are identical"
        } );
    }
    if( destination.container == resolved.value ||
        ( destination.container != nullptr &&
          resolved.value->has_item( *destination.container ) ) ) {
        return make_game_error_result( state, {
            "destination_rejected",
            "The Item cannot be inserted into itself or its descendant"
        } );
    }

    const int available = resolved.value->count_by_charges() ?
                          resolved.value->charges : 1;
    const std::int64_t quantity = requested_quantity.value_or( available );
    if( quantity <= 0 || quantity > available ||
        ( !resolved.value->count_by_charges() && quantity != 1 ) ) {
        return make_game_error_result( state, {
            "invalid_quantity",
            "The Item transfer quantity is outside the exact source bounds"
        } );
    }
    if( quantity < available && resolved.value->is_container() &&
        !resolved.value->container_type_pockets_empty() ) {
        return make_game_error_result( state, {
            "unsupported_transfer",
            "Partial transfer of a container stack with contents is unsupported"
        } );
    }

    item source_copy = *resolved.value;
    if( resolved.value->count_by_charges() ) {
        source_copy.charges = static_cast<int>( quantity );
    }
    inserted_item inserted;
    if( const std::optional<game_handle_error> error = insert_item_into_holder(
                destination, source_copy, resolved.value, inserted ) ) {
        return make_game_error_result( state, *error );
    }
    const native_handle_result<item> still_source = item_handle.resolve_item(
                runtime_generation, world_generation );
    if( !still_source || still_source.value != resolved.value ) {
        const bool rolled_back = inserted.rollback && inserted.rollback();
        if( !rolled_back ) {
            return make_game_error_result( state, {
                "rollback_failed",
                "The Item source changed while committing the destination"
            } );
        }
        return make_game_error_result( state, {
            "stale_item", "The exact Item source became stale before transfer"
        } );
    }

    const bool full_transfer = quantity == available;
    if( full_transfer ) {
        if( !remove_item_from_holder( source ) ) {
            const bool rolled_back = inserted.rollback && inserted.rollback();
            if( !rolled_back ) {
                return make_game_error_result( state, {
                    "rollback_failed",
                    "The Item source removal failed and destination rollback failed"
                } );
            }
            return make_game_error_result( state, {
                "source_changed", "The exact Item source could not be removed"
            } );
        }
    } else {
        resolved.value->charges -= static_cast<int>( quantity );
    }

    item_holder_descriptor actual_destination = destination.descriptor;
    if( destination.descriptor.kind == item_holder_kind::character ) {
        actual_destination = character_item_holder_descriptor(
                                 *destination.character, *inserted.value,
                                 nullptr, -1, runtime_generation,
                                 world_generation );
    }
    const game_handle new_handle = make_transferred_item_handle(
                                       destination, *inserted.value,
                                       runtime_generation, world_generation );
    const bool map_mutation =
        source.descriptor.kind == item_holder_kind::map_tile ||
        destination.descriptor.kind == item_holder_kind::map_tile;
    bump_item_query_mutation_epoch();
    if( map_mutation ) {
        bump_map_mutation_epoch();
    }
    sol::table value = state.create_table();
    value["accepted"] = true;
    value["changed"] = true;
    value["quantity"] = quantity;
    value["source_handle_stale"] = full_transfer;
    value["old_handle_stale"] = full_transfer;
    value["handle"] = new_handle;
    value["source_holder"] = item_holder_to_lua(
                                 state, source.descriptor );
    value["holder"] = item_holder_to_lua(
                          state, actual_destination );
    value["item"] = snapshot_item( state, *inserted.value, 16 );
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

enum class equipment_operation : std::uint8_t {
    wield,
    wear,
    unequip,
};

struct equipment_escrow_item {
    Character *source_character = nullptr;
    Character *destination_character = nullptr;
    item *source_item = nullptr;
    item *destination_item = nullptr;
    std::int64_t source_uid = 0;
    std::string source_slot;
    item value;
    bool extracted = false;
    bool inserted = false;
};

struct equipment_transaction_state {
    equipment_operation operation = equipment_operation::unequip;
    Character *actor = nullptr;
    item *equipped_item = nullptr;
    item_holder_descriptor source_holder;
    item_holder_descriptor destination_holder;
    resolved_item_holder destination;
    equipment_escrow_item requested;
    std::vector<equipment_escrow_item> displaced;
};

std::string_view equipment_operation_name( const equipment_operation operation )
{
    switch( operation ) {
        case equipment_operation::wield:
            return "wield";
        case equipment_operation::wear:
            return "wear";
        case equipment_operation::unequip:
            return "unequip";
    }
    return "unknown";
}

std::optional<game_handle_error> require_equipment_character_holder(
    const sol::table &requested, const std::string_view api_name,
    const bool allow_equipment_slots, item_holder_descriptor &descriptor )
{
    descriptor = read_item_holder_descriptor( requested, api_name );
    if( descriptor.kind != item_holder_kind::character ) {
        return game_handle_error{
            "unsupported_holder",
            std::string( api_name ) +
            " currently requires an explicit Character holder"
        };
    }
    if( !allow_equipment_slots && descriptor.slot != "inventory" ) {
        return game_handle_error{
            "unsupported_holder",
            std::string( api_name ) +
            " destination must be an explicit Character inventory holder"
        };
    }
    return std::nullopt;
}

std::optional<game_handle_error> require_equipment_character_identity(
    const game_handle &handle, const Character &character,
    const std::string_view description )
{
    const std::string subtype = handle.subtype_name();
    if( subtype != "avatar" && subtype != "npc" && subtype != "character" ) {
        return game_handle_error{
            "wrong_subtype",
            std::string( description ) +
            " must be an exact avatar, NPC, or Character handle"
        };
    }
    if( !character.getID().is_valid() ) {
        return game_handle_error{
            "invalid_identity",
            std::string( description ) + " lacks a stable Character identity"
        };
    }
    return std::nullopt;
}

std::optional<game_handle_error> equipment_item_charges_error(
    const item &value, const std::string_view description )
{
    if( value.is_null() || !value.uid().is_valid() ) {
        return game_handle_error{
            "invalid_item",
            std::string( description ) + " must reference a live Item"
        };
    }
    if( value.count_by_charges() && value.charges <= 0 ) {
        return game_handle_error{
            "invalid_charges",
            std::string( description ) +
            " has no complete positive charge stack to equip"
        };
    }
    return std::nullopt;
}

std::optional<game_handle_error> equipment_destination_preflight(
    const resolved_item_holder &destination, const item &value,
    const std::set<const item *> &ignored_items )
{
    if( destination.descriptor.kind != item_holder_kind::character ||
        destination.descriptor.slot != "inventory" ||
        destination.character == nullptr ) {
        return game_handle_error{
            "unsupported_holder",
            "Equipment displacement destinations must be explicit Character inventory holders"
        };
    }

    bool stack_conflict = false;
    destination.character->visit_items(
    [&value, &ignored_items, &stack_conflict]( item * candidate, item * ) {
        if( candidate != nullptr &&
            ignored_items.find( candidate ) == ignored_items.end() &&
            candidate->stacks_with( value ) ) {
            stack_conflict = true;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    if( stack_conflict ) {
        return game_handle_error{
            "destination_rejected",
            "The equipment destination already contains a compatible Item stack"
        };
    }

    return std::nullopt;
}

std::optional<game_handle_error> insert_equipment_item_into_inventory(
    Character &destination, item &value, item *&inserted )
{
    inserted = nullptr;
    if( value.is_null() || !value.uid().is_valid() ) {
        return game_handle_error{
            "destination_rejected",
            "The equipment destination cannot accept the complete Item"
        };
    }
    item &result = destination.inv->add_item(
                       std::move( value ), false, false, false );
    result.on_pickup( destination );
    inserted = &result;
    return std::nullopt;
}

bool remove_equipment_destination_item( equipment_escrow_item &entry )
{
    if( !entry.inserted ) {
        return true;
    }
    if( entry.destination_character == nullptr ||
        entry.destination_item == nullptr ) {
        return false;
    }
    item removed = entry.destination_character->i_rem(
                       entry.destination_item );
    if( removed.is_null() ) {
        return false;
    }
    entry.value = std::move( removed );
    entry.destination_item = nullptr;
    entry.inserted = false;
    return true;
}

bool restore_equipment_source( equipment_escrow_item &entry )
{
    if( !entry.extracted ) {
        return true;
    }
    if( entry.source_character == nullptr || entry.value.is_null() ) {
        return false;
    }
    if( entry.source_slot == "inventory" ) {
        item *restored = nullptr;
        if( insert_equipment_item_into_inventory(
                *entry.source_character, entry.value, restored ) ) {
            return false;
        }
        entry.value = item();
        entry.extracted = false;
        return restored != nullptr;
    }
    if( entry.source_slot == "wielded" ) {
        if( entry.source_character->has_weapon() ) {
            return false;
        }
        entry.source_character->set_wielded_item( entry.value );
        entry.value = item();
        entry.extracted = false;
        return entry.source_character->has_weapon();
    }
    if( entry.source_slot == "worn" ) {
        const std::optional<std::list<item>::iterator> restored =
            entry.source_character->wear_item(
                entry.value, false, false, true, true );
        if( !restored ) {
            return false;
        }
        entry.value = item();
        entry.extracted = false;
        return true;
    }
    return false;
}

bool rollback_equipment_transaction( equipment_transaction_state &state )
{
    bool restored = true;
    if( state.equipped_item != nullptr ) {
        if( state.actor == nullptr ) {
            restored = false;
        } else {
            item removed = state.actor->i_rem( state.equipped_item );
            if( removed.is_null() ) {
                restored = false;
            } else {
                state.requested.value = std::move( removed );
                state.equipped_item = nullptr;
            }
        }
    }

    restored = remove_equipment_destination_item( state.requested ) && restored;
    for( auto it = state.displaced.rbegin();
         it != state.displaced.rend(); ++it ) {
        restored = remove_equipment_destination_item( *it ) && restored;
    }

    restored = restore_equipment_source( state.requested ) && restored;
    for( equipment_escrow_item &entry : state.displaced ) {
        restored = restore_equipment_source( entry ) && restored;
    }
    return restored;
}

bool equipment_worn_item_conflicts(
    const Character &actor, const item &incoming, const item &existing )
{
    if( incoming.has_flag( flag_RESTRICT_HANDS ) &&
        existing.has_flag( flag_RESTRICT_HANDS ) ) {
        return true;
    }

    const bool overlaps = incoming.covers_overlaps( existing ).has_value();
    if( !overlaps ) {
        return false;
    }
    if( incoming.has_flag( json_flag_ONE_PER_LAYER ) ||
        existing.has_flag( json_flag_ONE_PER_LAYER ) ) {
        return true;
    }
    if( incoming.is_rigid() && existing.is_rigid() ) {
        return true;
    }
    if( incoming.is_power_armor() &&
        !existing.has_flag( flag_POWERARMOR_COMPATIBLE ) &&
        !existing.has_flag( flag_INTEGRATED ) &&
        !existing.has_flag( flag_AURA ) ) {
        return true;
    }
    if( !incoming.is_power_armor() && existing.is_power_armor() &&
        !incoming.has_flag( flag_POWERARMOR_COMPATIBLE ) &&
        !incoming.has_flag( flag_AURA ) ) {
        return true;
    }
    if( incoming.typeId() == existing.typeId() &&
        ( actor.amount_worn( incoming.typeId() ) >= incoming.max_worn() ||
          existing.max_worn() == 1 ) ) {
        return true;
    }
    return false;
}

std::optional<game_handle_error> prepare_equipment_transaction(
    const game_handle &actor_handle, const game_handle &item_handle,
    const sol::table *source_holder_table,
    const sol::table &destination_holder_table,
    const equipment_operation operation,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    equipment_transaction_state &state )
{
    state = {};
    state.operation = operation;
    const std::string api_name = "services.equipment." +
                                 std::string( equipment_operation_name( operation ) );

    std::optional<game_handle_error> error;
    Character *actor = resolve_exact_character(
                           actor_handle, runtime_generation,
                           world_generation, error );
    if( actor == nullptr ) {
        return error;
    }
    if( const std::optional<game_handle_error> identity_error =
            require_equipment_character_identity( actor_handle, *actor, "actor" ) ) {
        return identity_error;
    }

    const native_handle_result<item> resolved_item = item_handle.resolve_item(
                runtime_generation, world_generation );
    if( !resolved_item ) {
        return resolved_item.error;
    }
    if( const std::optional<game_handle_error> charges_error =
            equipment_item_charges_error( *resolved_item.value, "item" ) ) {
        return charges_error;
    }

    item_holder_descriptor source_descriptor;
    resolved_item_holder source;
    if( source_holder_table != nullptr ) {
        if( const std::optional<game_handle_error> holder_error =
                require_equipment_character_holder(
                    *source_holder_table, api_name + ".source_holder", true,
                    source_descriptor ) ) {
            return holder_error;
        }
        if( const std::optional<game_handle_error> holder_error =
                resolve_item_holder(
                    source_descriptor, runtime_generation, world_generation,
                    resolved_item.value, source ) ) {
            return holder_error;
        }
        if( source.character == nullptr ) {
            return game_handle_error{
                "wrong_holder", "The equipment source has no Character owner"
            };
        }
        if( const std::optional<game_handle_error> identity_error =
                require_equipment_character_identity(
                    *source_descriptor.character, *source.character,
                    "source_holder.character" ) ) {
            return identity_error;
        }
    } else {
        source.character = actor;
        source_descriptor.kind = item_holder_kind::character;
        source_descriptor.character = actor_handle;
        source_descriptor.slot = actor->is_wielding( *resolved_item.value ) ?
                                 "wielded" : "worn";
        if( !actor->is_wielding( *resolved_item.value ) &&
            !actor->is_worn( *resolved_item.value ) ) {
            return game_handle_error{
                "not_equipped",
                "unequip requires the exact Item to be currently wielded or worn"
            };
        }
    }

    item_holder_descriptor destination_descriptor;
    if( const std::optional<game_handle_error> holder_error =
            require_equipment_character_holder(
                destination_holder_table, api_name + ".destination_holder",
                false, destination_descriptor ) ) {
        return holder_error;
    }
    resolved_item_holder destination;
    if( const std::optional<game_handle_error> holder_error =
            resolve_item_holder(
                destination_descriptor, runtime_generation, world_generation,
                nullptr, destination ) ) {
        return holder_error;
    }
    if( destination.character == nullptr ) {
        return game_handle_error{
            "wrong_holder", "The equipment destination has no Character owner"
        };
    }
    if( const std::optional<game_handle_error> identity_error =
            require_equipment_character_identity(
                *destination_descriptor.character, *destination.character,
                "destination_holder.character" ) ) {
        return identity_error;
    }

    state.actor = actor;
    state.source_holder = source_descriptor;
    state.destination_holder = destination_descriptor;
    state.destination = destination;
    state.requested.source_character = source.character;
    state.requested.source_item = resolved_item.value;
    state.requested.source_uid = resolved_item.value->uid().get_value();
    state.requested.source_slot = source_descriptor.slot;
    state.requested.value = *resolved_item.value;
    state.displaced.reserve( actor->worn.size() + 1 );

    std::set<const item *> displaced_items;
    const auto stage_displaced = [&](
                                     Character * owner, item * candidate, const std::string_view slot )
    -> std::optional<game_handle_error> {
        if( owner == nullptr || candidate == nullptr || candidate->is_null() ||
            candidate == resolved_item.value )
        {
            return game_handle_error{
                "invalid_equipment",
                "The equipment transaction selected an invalid displaced Item"
            };
        }
        if( !displaced_items.insert( candidate ).second )
        {
            return std::nullopt;
        }
        if( slot == "wielded" )
        {
            if( const ret_val<void> permitted = owner->can_unwield( *candidate );
                !permitted.success() ) {
                return game_handle_error{
                    "cannot_unwield", permitted.str()
                };
            }
        } else if( slot == "worn" )
        {
            if( const ret_val<void> permitted = owner->can_takeoff( *candidate );
                !permitted.success() ) {
                return game_handle_error{
                    "cannot_takeoff", permitted.str()
                };
            }
        } else
        {
            return game_handle_error{
                "unsupported_holder", "Only wielded or worn equipment can be displaced"
            };
        }

        equipment_escrow_item staged;
        staged.source_character = owner;
        staged.source_item = candidate;
        staged.source_uid = candidate->uid().get_value();
        staged.source_slot = std::string( slot );
        staged.value = *candidate;
        state.displaced.push_back( std::move( staged ) );
        return std::nullopt;
    };

    std::set<const item *> ignored_destination_items;
    if( source.character == destination.character ) {
        ignored_destination_items.insert( resolved_item.value );
    }

    if( operation == equipment_operation::wield ) {
        if( actor->is_wielding( *resolved_item.value ) ) {
            return game_handle_error{
                "already_equipped", "The exact Item is already wielded by the actor"
            };
        }
        if( actor->has_weapon() ) {
            item_location old_weapon = actor->get_wielded_item();
            item *old_weapon_value = old_weapon.get_item();
            if( old_weapon_value == nullptr ) {
                return game_handle_error{
                    "source_changed", "The actor reported a weapon without a live Item"
                };
            }
            if( const std::optional<game_handle_error> displaced_error =
                    stage_displaced( actor, old_weapon_value, "wielded" ) ) {
                return displaced_error;
            }
        }
        const ret_val<void> permitted = actor->can_wield( *resolved_item.value );
        if( !permitted.success() ) {
            return game_handle_error{ "cannot_wield", permitted.str() };
        }
    } else if( operation == equipment_operation::wear ) {
        if( actor->is_worn( *resolved_item.value ) ) {
            return game_handle_error{
                "already_equipped", "The exact Item is already worn by the actor"
            };
        }
        const ret_val<void> equip_change_permitted = actor->can_wear(
                    *resolved_item.value, true );
        if( !equip_change_permitted.success() ) {
            return game_handle_error{
                "cannot_wear", equip_change_permitted.str()
            };
        }

        const bool source_is_actor_weapon =
            source.character == actor && source_descriptor.slot == "wielded" &&
            actor->is_wielding( *resolved_item.value );
        const ret_val<void> direct_permitted = actor->can_wear(
                *resolved_item.value );
        if( !direct_permitted.success() ) {
            actor->worn.visit_items(
            [&]( item * candidate, item * ) {
                if( candidate != nullptr &&
                    equipment_worn_item_conflicts(
                        *actor, *resolved_item.value, *candidate ) ) {
                    if( const std::optional<game_handle_error> displaced_error =
                            stage_displaced( actor, candidate, "worn" ) ) {
                        // The callback cannot return an error, so retain a
                        // sentinel in the preallocated conflict collection;
                        // the complete validation below reports the exact
                        // failure without mutating the actor.
                        displaced_items.clear();
                        state.displaced.clear();
                        return VisitResponse::ABORT;
                    }
                }
                return VisitResponse::NEXT;
            } );

            const bool weapon_is_solved_by_source =
                source_is_actor_weapon && resolved_item.value->has_flag(
                    flag_RESTRICT_HANDS );
            if( actor->has_weapon() && !source_is_actor_weapon &&
                resolved_item.value->has_flag( flag_RESTRICT_HANDS ) ) {
                item_location old_weapon = actor->get_wielded_item();
                item *old_weapon_value = old_weapon.get_item();
                if( old_weapon_value != nullptr &&
                    old_weapon_value->is_two_handed( *actor ) ) {
                    if( const std::optional<game_handle_error> displaced_error =
                            stage_displaced( actor, old_weapon_value, "wielded" ) ) {
                        return displaced_error;
                    }
                }
            }
            if( state.displaced.empty() && !weapon_is_solved_by_source ) {
                return game_handle_error{ "cannot_wear", direct_permitted.str() };
            }
        }
        if( const ret_val<void> permitted = actor->can_wear(
                                                *resolved_item.value, true ); !permitted.success() ) {
            return game_handle_error{ "cannot_wear", permitted.str() };
        }
    } else {
        if( source_descriptor.slot == "wielded" ) {
            if( const ret_val<void> permitted = actor->can_unwield(
                                                    *resolved_item.value ); !permitted.success() ) {
                return game_handle_error{ "cannot_unwield", permitted.str() };
            }
        } else {
            if( const ret_val<void> permitted = actor->can_takeoff(
                                                    *resolved_item.value ); !permitted.success() ) {
                return game_handle_error{ "cannot_takeoff", permitted.str() };
            }
        }
    }

    if( operation == equipment_operation::wield && state.displaced.empty() &&
        actor->has_weapon() ) {
        return game_handle_error{
            "invalid_equipment", "The wield transaction did not stage the existing weapon"
        };
    }

    for( const equipment_escrow_item &entry : state.displaced ) {
        if( entry.source_character == destination.character &&
            entry.source_item != nullptr ) {
            ignored_destination_items.insert( entry.source_item );
        }
    }

    for( const equipment_escrow_item &entry : state.displaced ) {
        if( const std::optional<game_handle_error> destination_error =
                equipment_destination_preflight(
                    state.destination, entry.value, ignored_destination_items ) ) {
            return destination_error;
        }
    }
    if( operation == equipment_operation::unequip ) {
        if( const std::optional<game_handle_error> destination_error =
                equipment_destination_preflight(
                    state.destination, state.requested.value,
                    ignored_destination_items ) ) {
            return destination_error;
        }
    }
    return std::nullopt;
}

sol::table equipment_success_result(
    sol::state_view lua, const equipment_transaction_state &state,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::table value = lua.create_table();
    value["accepted"] = true;
    value["changed"] = true;
    value["operation"] = std::string( equipment_operation_name( state.operation ) );
    value["source_handle_stale"] = true;
    value["old_handle_stale"] = true;
    value["source_uid"] = state.requested.source_uid;
    value["source_holder"] = item_holder_to_lua(
                                 lua, state.source_holder );
    value["destination_holder"] = item_holder_to_lua(
                                      lua, state.destination_holder );

    Character *result_character = state.actor;
    item *result_item = state.equipped_item;
    if( state.operation == equipment_operation::unequip ) {
        result_character = state.requested.destination_character;
        result_item = state.requested.destination_item;
    }
    if( result_character != nullptr && result_item != nullptr ) {
        sol::table moved = character_item_to_lua(
                               lua, *result_character, *result_item,
                               runtime_generation, world_generation );
        value["handle"] = moved["handle"];
        value["item"] = std::move( moved );
    }

    sol::table displaced = lua.create_table();
    std::size_t index = 1;
    for( const equipment_escrow_item &entry : state.displaced ) {
        if( entry.destination_character == nullptr ||
            entry.destination_item == nullptr ) {
            continue;
        }
        sol::table row = lua.create_table();
        row["source_uid"] = entry.source_uid;
        row["source_handle_stale"] = true;
        sol::table moved = character_item_to_lua(
                               lua, *entry.destination_character,
                               *entry.destination_item,
                               runtime_generation, world_generation );
        row["handle"] = moved["handle"];
        row["item"] = std::move( moved );
        displaced[index++] = std::move( row );
    }
    value["displaced"] = std::move( displaced );
    value["displaced_count"] = index - 1;
    return value;
}

sol::table perform_equipment_transaction(
    sol::this_state lua, const game_handle &actor_handle,
    const game_handle &item_handle, const sol::table *source_holder,
    const sol::table &destination_holder, const equipment_operation operation,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state_view( lua );
    equipment_transaction_state state;
    if( const std::optional<game_handle_error> error =
            prepare_equipment_transaction(
                actor_handle, item_handle, source_holder,
                destination_holder, operation, runtime_generation,
                world_generation, state ) ) {
        return make_game_error_result( state_view, *error );
    }

    platform_item_transaction transaction;
    transaction.rollback = [&state]() {
        return rollback_equipment_transaction( state );
    };

    const auto fail_after_mutation =
    [&transaction, &state_view]( const game_handle_error & failure ) {
        const bool restored = transaction.rollback_now();
        bump_item_query_mutation_epoch();
        if( !restored ) {
            return make_game_error_result( state_view, {
                "rollback_failed",
                "The equipment operation failed and could not restore every Item"
            } );
        }
        return make_game_error_result( state_view, failure );
    };
    const auto extract = []( equipment_escrow_item & entry ) {
        if( entry.source_character == nullptr || entry.source_item == nullptr ) {
            return false;
        }
        retire_item_handle_identity( *entry.source_item );
        item extracted = entry.source_character->i_rem( entry.source_item );
        if( extracted.is_null() ) {
            return false;
        }
        entry.value = std::move( extracted );
        entry.extracted = true;
        return true;
    };

    if( !extract( state.requested ) ) {
        return fail_after_mutation( {
            "source_changed", "The exact equipment Item could not be staged"
        } );
    }
    for( equipment_escrow_item &entry : state.displaced ) {
        if( !extract( entry ) ) {
            return fail_after_mutation( {
                "source_changed", "A displaced equipment Item could not be staged"
            } );
        }
    }

    for( equipment_escrow_item &entry : state.displaced ) {
        entry.destination_character = state.destination.character;
        if( const std::optional<game_handle_error> error =
                insert_equipment_item_into_inventory(
                    *state.destination.character, entry.value,
                    entry.destination_item ) ) {
            return fail_after_mutation( *error );
        }
        entry.inserted = entry.destination_item != nullptr;
        if( !entry.inserted ) {
            return fail_after_mutation( {
                "destination_rejected",
                "The displaced equipment Item was not inserted"
            } );
        }
    }

    if( state.operation == equipment_operation::wield ) {
        if( !state.actor->wield( state.requested.value, std::nullopt, false ) ) {
            return fail_after_mutation( {
                "operation_failed", "The actor rejected the explicit wield operation"
            } );
        }
        item_location equipped = state.actor->get_wielded_item();
        if( !equipped || equipped.get_item() == nullptr ) {
            return fail_after_mutation( {
                "operation_failed", "The wield operation produced no live Item"
            } );
        }
        state.equipped_item = equipped.get_item();
    } else if( state.operation == equipment_operation::wear ) {
        state.actor->worn.check_rigid_sidedness( state.requested.value );
        state.actor->worn.one_per_layer_sidedness( state.requested.value );
        const std::optional<std::list<item>::iterator> worn =
            state.actor->wear_item(
                state.requested.value, false, true, true, true );
        if( !worn ) {
            return fail_after_mutation( {
                "operation_failed", "The actor rejected the explicit wear operation"
            } );
        }
        state.equipped_item = & **worn;
    } else {
        state.requested.destination_character = state.destination.character;
        if( const std::optional<game_handle_error> error =
                insert_equipment_item_into_inventory(
                    *state.destination.character, state.requested.value,
                    state.requested.destination_item ) ) {
            return fail_after_mutation( *error );
        }
        state.requested.inserted = state.requested.destination_item != nullptr;
        if( !state.requested.inserted ) {
            return fail_after_mutation( {
                "destination_rejected", "The unequipped Item was not inserted"
            } );
        }
    }

    sol::table result;
    try {
        result = make_game_value_result(
                     state_view,
                     sol::make_object(
                         state_view, equipment_success_result(
                             state_view, state, runtime_generation,
                             world_generation ) ) );
    } catch( ... ) {
        const bool restored = transaction.rollback_now();
        bump_item_query_mutation_epoch();
        if( !restored ) {
            throw std::runtime_error(
                "equipment result construction failed and rollback failed" );
        }
        throw;
    }
    bump_item_query_mutation_epoch();
    transaction.commit();
    return result;
}

} // namespace

void bump_item_query_mutation_epoch()
{
    ++item_query_mutation_epoch;
    item_query_cursors.clear();
}

std::uint64_t item_holder_mutation_generation() noexcept
{
    return item_query_mutation_epoch;
}

namespace
{

struct trade_item_insertion {
    Character *character = nullptr;
    item *value = nullptr;
    item_location location;
};

struct prepared_trade_item {
    Character *source = nullptr;
    Character *destination = nullptr;
    item *source_item = nullptr;
    std::string source_slot;
    int quantity = 0;
    int available = 0;
    bool full_item = false;
    bool extracted = false;
    std::int64_t source_uid = 0;
    item escrow;
    item *destination_item = nullptr;
};

std::optional<game_handle_error> insert_owned_trade_item(
    const resolved_item_holder &destination, item &value,
    trade_item_insertion &inserted,
    const std::set<item *> *ignored_stack_items = nullptr )
{
    inserted = {};
    if( destination.descriptor.kind != item_holder_kind::character ||
        destination.descriptor.slot != "inventory" ||
        destination.character == nullptr ) {
        return game_handle_error{
            "unsupported_holder",
            "trade commit currently supports Character inventory holders only"
        };
    }

    Character &character = *destination.character;
    bool stack_conflict = false;
    character.visit_items( [&value, &stack_conflict,
            ignored_stack_items]( item * candidate, item * ) {
        if( candidate != nullptr &&
            ( ignored_stack_items == nullptr ||
              ignored_stack_items->find( candidate ) == ignored_stack_items->end() ) &&
            candidate->stacks_with( value ) ) {
            stack_conflict = true;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    if( stack_conflict ) {
        return game_handle_error{
            "destination_rejected",
            "The trade destination already contains a compatible Item stack"
        };
    }

    const std::int64_t expected_uid = value.uid().get_value();
    item &result = character.inv->add_item(
                       std::move( value ), false, false, false );
    item_location location( character, &result );
    if( !location || result.is_null() ||
        result.uid().get_value() != expected_uid ) {
        if( location ) {
            location.remove_item();
        }
        return game_handle_error{
            "destination_rejected",
            "The Character inventory rejected the exact trade Item"
        };
    }
    result.on_pickup( character );
    inserted.character = &character;
    inserted.value = &result;
    inserted.location = location;
    return std::nullopt;
}

bool release_trade_reservations( std::vector<trade_item_insertion> &reservations )
{
    bool released = true;
    for( auto it = reservations.rbegin(); it != reservations.rend(); ++it ) {
        if( it->location ) {
            it->location.remove_item();
            released = released && it->location.get_item() == nullptr;
        }
    }
    return released;
}

bool restore_trade_source_item( prepared_trade_item &entry, item &value )
{
    if( entry.source == nullptr ) {
        return false;
    }
    if( entry.source_slot == "inventory" ) {
        resolved_item_holder source_holder;
        source_holder.descriptor.kind = item_holder_kind::character;
        source_holder.descriptor.slot = entry.source_slot;
        source_holder.character = entry.source;
        trade_item_insertion restored;
        return !insert_owned_trade_item( source_holder, value, restored );
    }
    if( entry.source_slot == "worn" ) {
        return entry.source->wear_item( value, false, true, true, true ).has_value();
    }
    if( entry.source_slot == "wielded" ) {
        if( entry.source->has_weapon() ) {
            return false;
        }
        entry.source->set_wielded_item( value );
        return entry.source->has_weapon();
    }
    return false;
}

bool restore_prepared_trade_item( prepared_trade_item &entry )
{
    if( !entry.extracted ) {
        return true;
    }

    if( entry.destination_item != nullptr ) {
        if( entry.destination == nullptr ) {
            return false;
        }
        item returned = entry.destination->i_rem( entry.destination_item );
        if( returned.is_null() ) {
            return false;
        }
        entry.destination_item = nullptr;
        if( !entry.full_item ) {
            if( entry.source_item == nullptr || entry.source_item->is_null() ||
                entry.source_item->uid().get_value() != entry.source_uid ) {
                return false;
            }
            entry.source_item->charges += entry.quantity;
            return true;
        }
        if( !restore_trade_source_item( entry, returned ) ) {
            return false;
        }
        return true;
    }

    if( !entry.full_item ) {
        if( entry.source_item == nullptr || entry.source_item->is_null() ||
            entry.source_item->uid().get_value() != entry.source_uid ) {
            return false;
        }
        entry.source_item->charges += entry.quantity;
        return true;
    }

    if( entry.source == nullptr || entry.escrow.is_null() ||
        !entry.escrow.uid().is_valid() ) {
        return false;
    }
    if( !restore_trade_source_item( entry, entry.escrow ) ) {
        return false;
    }
    return true;
}

bool restore_prepared_trade_items( std::vector<prepared_trade_item> &prepared )
{
    bool restored = true;
    for( auto it = prepared.rbegin(); it != prepared.rend(); ++it ) {
        restored = restore_prepared_trade_item( *it ) && restored;
    }
    return restored;
}

std::optional<game_handle_error> recipe_character_holder(
    const sol::table &requested, const std::string_view api_name,
    item_holder_descriptor &descriptor )
{
    descriptor = read_item_holder_descriptor( requested, api_name );
    if( descriptor.kind != item_holder_kind::character ) {
        return game_handle_error{
            "unsupported_holder",
            "recipe_work currently requires an explicit Character holder"
        };
    }
    if( descriptor.slot != "inventory" && descriptor.slot != "worn" &&
        descriptor.slot != "wielded" ) {
        return game_handle_error{
            "unsupported_holder", "recipe_work received an unsupported Character slot"
        };
    }
    return std::nullopt;
}

bool serialize_recipe_item( const item &value, std::string &serialized,
                            std::string &error )
{
    if( value.is_null() || !value.uid().is_valid() ) {
        error = "recipe_work escrow requires a live item with a stable uid";
        return false;
    }
    std::ostringstream buffer;
    JsonOut json( buffer );
    value.serialize( json );
    serialized = buffer.str();
    if( serialized.empty() ) {
        error = "recipe_work escrow item serialization was empty";
        return false;
    }
    return true;
}

bool deserialize_recipe_item( const std::string &serialized, item &result,
                              std::string &error )
{
    try {
        const JsonValue parsed = json_loader::from_string( serialized );
        if( !parsed.test_object() ) {
            error = "recipe_work escrow item is not a native object value";
            return false;
        }
        result.deserialize( parsed.get_object() );
    } catch( const std::exception &exception ) {
        error = std::string( "recipe_work escrow item could not be restored: " ) +
                exception.what();
        return false;
    }
    if( result.is_null() || !result.uid().is_valid() ) {
        error = "recipe_work escrow item restored without a stable uid";
        return false;
    }
    return true;
}

std::optional<game_handle_error> require_recipe_inventory_destination(
    const sol::table &requested, item_holder_descriptor &descriptor )
{
    if( const std::optional<game_handle_error> error = recipe_character_holder(
                requested, "services.camps.tasks.recipe_work", descriptor ) ) {
        return error;
    }
    if( descriptor.slot != "inventory" ) {
        return game_handle_error{
            "unsupported_holder",
            "recipe_work output and refund destinations must be Character inventory"
        };
    }
    return std::nullopt;
}

} // namespace

std::optional<game_handle_error> stage_platform_trade_items(
    const std::vector<platform_trade_item_request> &requests,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    const std::uint64_t expected_holder_mutation_generation,
    std::vector<platform_trade_item_result> &result,
    platform_item_transaction &transaction )
{
    constexpr std::size_t maximum_trade_inputs = 256;
    transaction = {};
    result.clear();
    if( requests.empty() || requests.size() > maximum_trade_inputs ) {
        return game_handle_error{
            "invalid_transaction", "trade commit requires 1..256 exact Item lines"
        };
    }
    if( item_holder_mutation_generation() != expected_holder_mutation_generation ) {
        return game_handle_error{
            "stale_holder", "An Item holder mutation invalidated the trade transaction"
        };
    }

    std::vector<prepared_trade_item> prepared;
    prepared.reserve( requests.size() );
    result.reserve( requests.size() );
    std::set<item *> target_pointers;
    std::set<std::int64_t> target_uids;

    for( const platform_trade_item_request &request : requests ) {
        if( request.destination_holder.slot != "inventory" ||
            ( request.source_holder.slot != "inventory" &&
              request.source_holder.slot != "worn" &&
              request.source_holder.slot != "wielded" ) ) {
            return game_handle_error{
                "unsupported_holder",
                "trade commit currently supports Character inventory holders only"
            };
        }

        const std::string source_subtype =
            request.source_holder.character.subtype_name();
        const std::string destination_subtype =
            request.destination_holder.character.subtype_name();
        const bool source_is_avatar = source_subtype == "avatar";
        const bool source_is_npc = source_subtype == "npc";
        const bool destination_is_avatar = destination_subtype == "avatar";
        const bool destination_is_npc = destination_subtype == "npc";
        if( ( !source_is_avatar && !source_is_npc ) ||
            ( !destination_is_avatar && !destination_is_npc ) ||
            source_is_avatar == destination_is_avatar ) {
            return game_handle_error{
                "unsupported_participants",
                "trade commit requires an explicit avatar and NPC participant pair"
            };
        }

        item_holder_descriptor source_descriptor;
        source_descriptor.kind = item_holder_kind::character;
        source_descriptor.character = request.source_holder.character;
        source_descriptor.slot = request.source_holder.slot;
        item_holder_descriptor destination_descriptor;
        destination_descriptor.kind = item_holder_kind::character;
        destination_descriptor.character = request.destination_holder.character;
        destination_descriptor.slot = request.destination_holder.slot;

        const native_handle_result<item> resolved = request.item_handle.resolve_item(
                    current_runtime, current_world_generation );
        if( !resolved ) {
            return resolved.error;
        }
        if( resolved.value == nullptr || resolved.value->is_null() ||
            !resolved.value->uid().is_valid() ||
            request.item_handle.identity_generation() == 0 ) {
            return game_handle_error{
                "invalid_identity", "trade commit requires a live generation-safe Item"
            };
        }

        resolved_item_holder source;
        if( const std::optional<game_handle_error> error = resolve_item_holder(
                    source_descriptor, current_runtime, current_world_generation,
                    resolved.value, source ) ) {
            return error;
        }
        resolved_item_holder destination;
        if( const std::optional<game_handle_error> error = resolve_item_holder(
                    destination_descriptor, current_runtime, current_world_generation,
                    nullptr, destination ) ) {
            return error;
        }
        if( source.character == nullptr || destination.character == nullptr ||
            source.character == destination.character ) {
            return game_handle_error{
                "overlapping_holder", "trade source and destination Characters must differ"
            };
        }
        if( ( source_is_avatar && !source.character->is_avatar() ) ||
            ( source_is_npc && !source.character->is_npc() ) ||
            ( destination_is_avatar && !destination.character->is_avatar() ) ||
            ( destination_is_npc && !destination.character->is_npc() ) ) {
            return game_handle_error{
                "wrong_subtype", "trade holders must resolve to their exact avatar/NPC subtype"
            };
        }
        if( !target_pointers.insert( resolved.value ).second ||
            !target_uids.insert( resolved.value->uid().get_value() ).second ) {
            return game_handle_error{
                "duplicate_item", "trade commit cannot transfer the same Item twice"
            };
        }

        const int available = resolved.value->count_by_charges() ?
                              resolved.value->charges : 1;
        if( request.quantity <= 0 || request.quantity > available ||
            request.quantity > std::numeric_limits<int>::max() ||
            ( !resolved.value->count_by_charges() && request.quantity != 1 ) ) {
            return game_handle_error{
                "invalid_quantity", "trade commit quantity is outside the exact Item bounds"
            };
        }
        if( request.quantity < available && resolved.value->is_container() &&
            !resolved.value->container_type_pockets_empty() ) {
            return game_handle_error{
                "unsupported_item",
                "partial trade charges for containers with contents are unsupported"
            };
        }

        prepared_trade_item entry;
        entry.source = source.character;
        entry.destination = destination.character;
        entry.source_item = resolved.value;
        entry.source_slot = request.source_holder.slot;
        entry.quantity = static_cast<int>( request.quantity );
        entry.available = available;
        entry.full_item = request.quantity == available;
        entry.source_uid = resolved.value->uid().get_value();
        prepared.push_back( std::move( entry ) );
    }

    std::vector<trade_item_insertion> reservations;
    reservations.reserve( prepared.size() );
    for( prepared_trade_item &entry : prepared ) {
        resolved_item_holder destination;
        destination.descriptor.kind = item_holder_kind::character;
        destination.descriptor.slot = "inventory";
        destination.character = entry.destination;
        item probe = *entry.source_item;
        if( probe.count_by_charges() ) {
            probe.charges = entry.quantity;
        }
        trade_item_insertion reservation;
        if( const std::optional<game_handle_error> error = insert_owned_trade_item(
                    destination, probe, reservation, &target_pointers ) ) {
            const bool released = release_trade_reservations( reservations );
            if( !released ) {
                bump_item_query_mutation_epoch();
                return game_handle_error{
                    "rollback_failed",
                    "trade destination reservation failed and could not be released"
                };
            }
            return error;
        }
        reservations.push_back( std::move( reservation ) );
    }
    if( !release_trade_reservations( reservations ) ) {
        bump_item_query_mutation_epoch();
        return game_handle_error{
            "rollback_failed", "trade destination reservations could not be released"
        };
    }
    if( item_holder_mutation_generation() != expected_holder_mutation_generation ) {
        return game_handle_error{
            "stale_holder", "An Item holder mutation invalidated the trade transaction"
        };
    }

    for( const platform_trade_item_request &request : requests ) {
        const std::size_t index = &request - requests.data();
        prepared_trade_item &entry = prepared[index];
        const native_handle_result<item> resolved = request.item_handle.resolve_item(
                    current_runtime, current_world_generation );
        if( !resolved || resolved.value != entry.source_item ||
            resolved.value->uid().get_value() != entry.source_uid ||
            ( resolved.value->count_by_charges() ? resolved.value->charges : 1 ) !=
            entry.available ) {
            return game_handle_error{
                "stale_item", "The exact trade Item changed during destination preflight"
            };
        }
        item_holder_descriptor source_descriptor;
        source_descriptor.kind = item_holder_kind::character;
        source_descriptor.character = request.source_holder.character;
        source_descriptor.slot = request.source_holder.slot;
        resolved_item_holder source;
        if( const std::optional<game_handle_error> error = resolve_item_holder(
                    source_descriptor, current_runtime, current_world_generation,
                    resolved.value, source ) ) {
            return error;
        }
        if( source.character != entry.source ) {
            return game_handle_error{
                "stale_holder", "The exact trade source holder changed during preflight"
            };
        }
        item_holder_descriptor destination_descriptor;
        destination_descriptor.kind = item_holder_kind::character;
        destination_descriptor.character = request.destination_holder.character;
        destination_descriptor.slot = request.destination_holder.slot;
        resolved_item_holder destination;
        if( const std::optional<game_handle_error> error = resolve_item_holder(
                    destination_descriptor, current_runtime, current_world_generation,
                    nullptr, destination ) ) {
            return error;
        }
        if( destination.character != entry.destination ) {
            return game_handle_error{
                "stale_holder", "The exact trade destination holder changed during preflight"
            };
        }
    }

    // Install the rollback callback before the first source mutation.  The
    // vectors have already been sized and all callback storage is allocated
    // before extraction can make the transaction observable.
    const std::shared_ptr<std::vector<prepared_trade_item>> prepared_state =
                std::make_shared<std::vector<prepared_trade_item>>( std::move( prepared ) );
    transaction.rollback = [prepared_state]() mutable {
        const bool restored = restore_prepared_trade_items( *prepared_state );
        bump_item_query_mutation_epoch();
        return restored;
    };
    std::vector<prepared_trade_item> &staged = *prepared_state;

    const auto rollback_failure = [&result, &transaction](
    const std::string_view code, const std::string_view message ) {
        const bool restored = transaction.rollback_now();
        result.clear();
        return game_handle_error{
            restored ? std::string( code ) : "rollback_failed",
            restored ? std::string( message )
            : "trade Item staging failed and source rollback failed"
        };
    };

    for( prepared_trade_item &entry : staged ) {
        if( item_holder_mutation_generation() != expected_holder_mutation_generation ) {
            return rollback_failure(
                       "stale_holder",
                       "An Item holder mutation invalidated trade extraction" );
        }
        if( entry.full_item ) {
            entry.escrow = entry.source->i_rem( entry.source_item );
            if( entry.escrow.is_null() ) {
                return rollback_failure(
                           "source_changed", "The exact trade Item could not be extracted" );
            }
        } else {
            entry.escrow = entry.source_item->split( entry.quantity );
            if( entry.escrow.is_null() ) {
                return rollback_failure(
                           "source_changed", "The exact trade charge split failed" );
            }
        }
        entry.extracted = true;
        if( entry.escrow.uid().get_value() <= 0 ||
            ( entry.full_item &&
              entry.escrow.uid().get_value() != entry.source_uid ) ) {
            return rollback_failure(
                       "source_changed", "The extracted trade Item lost its stable identity" );
        }
        if( !entry.full_item &&
            entry.source_item->charges != entry.available - entry.quantity ) {
            return rollback_failure(
                       "source_changed", "The exact trade charge split changed its source" );
        }
    }

    for( prepared_trade_item &entry : staged ) {
        if( item_holder_mutation_generation() != expected_holder_mutation_generation ) {
            return rollback_failure(
                       "stale_holder",
                       "An Item holder mutation invalidated trade insertion" );
        }
        resolved_item_holder destination;
        destination.descriptor.kind = item_holder_kind::character;
        destination.descriptor.slot = "inventory";
        destination.character = entry.destination;
        const std::int64_t destination_uid = entry.escrow.uid().get_value();
        trade_item_insertion inserted;
        if( const std::optional<game_handle_error> error = insert_owned_trade_item(
                    destination, entry.escrow, inserted ) ) {
            return rollback_failure( error->code, error->message );
        }
        if( inserted.value == nullptr ||
            inserted.value->uid().get_value() != destination_uid ) {
            return rollback_failure(
                       "destination_rejected", "The trade destination changed Item identity" );
        }
        entry.destination_item = inserted.value;
    }

    for( const prepared_trade_item &entry : staged ) {
        if( entry.destination_item == nullptr ||
            entry.destination_item->uid().get_value() <= 0 ) {
            return rollback_failure(
                       "destination_rejected", "The trade destination lost the inserted Item" );
        }
        result.push_back( {
            entry.source_uid,
            entry.destination_item->uid().get_value(),
            entry.quantity
        } );
    }
    bump_item_query_mutation_epoch();
    return std::nullopt;
}

std::optional<game_handle_error> stage_platform_recipe_item(
    const game_handle &item_handle, const sol::table &source_holder,
    const std::int64_t quantity, const bool tool,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    basecamp_platform_recipe_escrow_item &result )
{
    const platform_recipe_item_request request = {
        item_handle, source_holder, quantity, tool
    };
    std::vector<basecamp_platform_recipe_escrow_item> staged;
    platform_recipe_item_transaction transaction;
    if( const std::optional<game_handle_error> error = stage_platform_recipe_items(
{ request }, current_runtime, current_world_generation, staged,
transaction ) ) {
        return error;
    }
    result = std::move( staged.front() );
    transaction.commit();
    return std::nullopt;
}

std::optional<game_handle_error> stage_platform_recipe_items(
    const std::vector<platform_recipe_item_request> &requests,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    std::vector<basecamp_platform_recipe_escrow_item> &result,
    platform_recipe_item_transaction &transaction )
{
    constexpr std::size_t maximum_recipe_inputs = 256;
    transaction = {};
    if( requests.empty() || requests.size() > maximum_recipe_inputs ) {
        return game_handle_error{
            "invalid_escrow", "recipe_work requires 1..256 exact Item inputs"
        };
    }

    // Reserve both vectors before resolving or mutating a source.  The
    // preparation vector owns every allocation needed by the commit pass.
    result.clear();
    result.reserve( requests.size() );

    struct prepared_item {
        Character *character = nullptr;
        item *target = nullptr;
        int quantity = 0;
        int available = 0;
        bool full_item = false;
        std::string slot;
        basecamp_platform_recipe_escrow_item escrow;
        item partial_value;
    };

    std::vector<prepared_item> prepared;
    prepared.reserve( requests.size() );
    std::set<item *> target_pointers;
    std::set<std::int64_t> target_uids;

    // Preflight is deliberately complete: exact runtime/world handle
    // resolution, exact holder membership, quantities, tool whole-item
    // policy, stable identity, escrow metadata, and serialization all happen
    // before the first source item is changed.
    for( const platform_recipe_item_request &request : requests ) {
        item_holder_descriptor descriptor;
        if( const std::optional<game_handle_error> error = recipe_character_holder(
                    request.source_holder, "services.camps.tasks.start", descriptor ) ) {
            return error;
        }
        const native_handle_result<item> resolved = request.item_handle.resolve_item(
                    current_runtime, current_world_generation );
        if( !resolved ) {
            return resolved.error;
        }
        resolved_item_holder holder;
        if( const std::optional<game_handle_error> error = resolve_item_holder(
                    descriptor, current_runtime, current_world_generation,
                    resolved.value, holder ) ) {
            return error;
        }
        if( holder.character == nullptr || resolved.value == nullptr ||
            !target_pointers.insert( resolved.value ).second ||
            !target_uids.insert( resolved.value->uid().get_value() ).second ) {
            return game_handle_error{
                "duplicate_item", "recipe_work cannot escrow the same Item twice"
            };
        }
        if( request.item_handle.identity_generation() == 0 ) {
            return game_handle_error{
                "invalid_identity", "recipe_work Item handle lacks an identity generation"
            };
        }
        const int available = resolved.value->count_by_charges() ?
                              resolved.value->charges : 1;
        if( request.quantity <= 0 || request.quantity > available ||
            ( !resolved.value->count_by_charges() && request.quantity != 1 ) ) {
            return game_handle_error{
                "invalid_quantity",
                "recipe_work escrow quantity is outside the exact Item bounds"
            };
        }
        if( request.tool && request.quantity != available ) {
            return game_handle_error{
                "invalid_tool_lease",
                "recipe_work tools must be escrowed as complete owning Items"
            };
        }
        if( request.quantity < available && resolved.value->is_container() &&
            !resolved.value->container_type_pockets_empty() ) {
            return game_handle_error{
                "unsupported_item",
                "recipe_work cannot escrow a partial container stack with contents"
            };
        }
        if( !resolved.value->uid().is_valid() || !holder.character->getID().is_valid() ) {
            return game_handle_error{
                "invalid_identity", "recipe_work source Item or Character lacks stable identity"
            };
        }

        prepared_item entry;
        entry.character = holder.character;
        entry.target = resolved.value;
        entry.quantity = static_cast<int>( request.quantity );
        entry.available = available;
        entry.full_item = request.quantity == available;
        entry.slot = descriptor.slot;
        entry.escrow.stable_uid = resolved.value->uid().get_value();
        entry.escrow.identity_generation = request.item_handle.identity_generation();
        entry.escrow.charges = request.quantity;
        entry.escrow.tool = request.tool;
        entry.escrow.source_holder.kind = basecamp_platform_recipe_holder_kind::character;
        entry.escrow.source_holder.character = holder.character->getID();
        entry.escrow.source_holder.identity_generation = descriptor.character->identity_generation();
        entry.escrow.source_holder.slot = descriptor.slot;

        std::string serialization_error;
        if( entry.full_item ) {
            // Full extraction preserves the source UID.  Serialize the exact
            // source value before i_rem so the persisted UID is identical to
            // the owning value returned by the native extraction primitive.
            if( !serialize_recipe_item( *resolved.value, entry.escrow.serialized_item,
                                        serialization_error ) ) {
                return game_handle_error{ "escrow_failed", serialization_error };
            }
        } else {
            // item copy construction allocates the new UID that the partial
            // charge extraction will own.  It is serialized before the source
            // charge count is changed, so no fallible work follows mutation.
            entry.partial_value = *resolved.value;
            entry.partial_value.charges = entry.quantity;
            entry.escrow.stable_uid = entry.partial_value.uid().get_value();
            entry.escrow.identity_generation = 1;
            if( !serialize_recipe_item( entry.partial_value,
                                        entry.escrow.serialized_item,
                                        serialization_error ) ) {
                return game_handle_error{ "escrow_failed", serialization_error };
            }
        }
        prepared.push_back( std::move( entry ) );
    }

    struct applied_item {
        Character *character = nullptr;
        item *target = nullptr;
        int quantity = 0;
        bool full_item = false;
        std::string slot;
        item extracted;
    };
    std::vector<applied_item> applied;
    applied.reserve( prepared.size() );

    const auto rollback = [&applied]() {
        bool restored = true;
        for( auto it = applied.rbegin(); it != applied.rend(); ++it ) {
            if( !it->full_item ) {
                if( it->target == nullptr || it->target->is_null() ) {
                    restored = false;
                } else {
                    it->target->charges += it->quantity;
                }
                continue;
            }
            if( it->extracted.is_null() || it->character == nullptr ) {
                restored = false;
                continue;
            }
            if( it->slot == "wielded" && !it->character->has_weapon() ) {
                it->character->set_wielded_item( it->extracted );
                continue;
            }
            if( it->slot == "worn" ) {
                if( !it->character->wear_item( it->extracted, false, false, true, true ) ) {
                    restored = false;
                }
                continue;
            }
            item &restored_item = it->character->inv->add_item(
                                      std::move( it->extracted ), false, false, false );
            restored = restored && !restored_item.is_null();
        }
        return restored;
    };

    for( prepared_item &entry : prepared ) {
        applied_item applied_entry;
        applied_entry.character = entry.character;
        applied_entry.target = entry.target;
        applied_entry.quantity = entry.quantity;
        applied_entry.full_item = entry.full_item;
        applied_entry.slot = entry.slot;
        if( entry.full_item ) {
            // This is the final owning extraction step.  With the exact
            // holder and pointer membership already proven, i_rem either
            // returns the owning value or leaves the source unchanged.
            applied_entry.extracted = entry.character->i_rem( entry.target );
            if( applied_entry.extracted.is_null() ) {
                const bool restored = rollback();
                result.clear();
                return game_handle_error{
                    restored ? "source_changed" : "rollback_failed",
                    restored ? "recipe_work exact Item extraction failed"
                    : "recipe_work extraction failed and earlier escrow could not be restored"
                };
            }
        } else {
            // The partial value and its serialized identity were prepared
            // above.  This arithmetic is the non-failing charge extraction
            // primitive after exact membership/quantity preflight.
            entry.target->charges -= entry.quantity;
        }
        applied.push_back( std::move( applied_entry ) );
        result.push_back( std::move( entry.escrow ) );
    }
    transaction.rollback = [applied = std::move( applied )]() mutable {
        bool restored = true;
        for( auto it = applied.rbegin(); it != applied.rend(); ++it )
        {
            if( !it->full_item ) {
                if( it->target == nullptr || it->target->is_null() ) {
                    restored = false;
                } else {
                    it->target->charges += it->quantity;
                }
                continue;
            }
            if( it->extracted.is_null() || it->character == nullptr ) {
                restored = false;
                continue;
            }
            if( it->slot == "wielded" && !it->character->has_weapon() ) {
                it->character->set_wielded_item( it->extracted );
                continue;
            }
            if( it->slot == "worn" ) {
                if( !it->character->wear_item( it->extracted, false, false, true, true ) ) {
                    restored = false;
                }
                continue;
            }
            item &restored_item = it->character->inv->add_item(
                                      std::move( it->extracted ), false, false, false );
            restored = restored && !restored_item.is_null();
        }
        bump_item_query_mutation_epoch();
        return restored;
    };
    bump_item_query_mutation_epoch();
    return std::nullopt;
}

std::optional<game_handle_error> restore_platform_recipe_item(
    const basecamp_platform_recipe_escrow_item &escrow,
    const sol::table &destination_holder,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    platform_recipe_item_transaction &transaction )
{
    transaction = {};
    item_holder_descriptor descriptor;
    if( const std::optional<game_handle_error> error =
            require_recipe_inventory_destination( destination_holder, descriptor ) ) {
        return error;
    }
    std::optional<game_handle_error> resolve_error;
    Character *character = resolve_exact_character(
                               *descriptor.character, current_runtime,
                               current_world_generation, resolve_error );
    if( character == nullptr ) {
        return resolve_error;
    }
    item restored;
    std::string restore_error;
    if( !deserialize_recipe_item( escrow.serialized_item, restored, restore_error ) ) {
        return game_handle_error{ "escrow_invalid", restore_error };
    }
    if( restored.uid().get_value() != escrow.stable_uid ||
        ( restored.count_by_charges() ? restored.charges : 1 ) != escrow.charges ) {
        return game_handle_error{
            "escrow_invalid", "recipe_work escrow uid or charge count is inconsistent"
        };
    }
    const std::int64_t expected_uid = restored.uid().get_value();
    item &inserted = character->inv->add_item(
                         std::move( restored ), false, false, false );
    item_location location( *character, &inserted );
    if( !location || location.get_item() == nullptr ||
        location.get_item()->uid().get_value() != expected_uid ) {
        if( location ) {
            location.remove_item();
        }
        return game_handle_error{
            "destination_rejected", "recipe_work refund insertion failed"
        };
    }
    transaction.rollback = [location]() mutable {
        location.remove_item();
        bump_item_query_mutation_epoch();
        return location.get_item() == nullptr;
    };
    bump_item_query_mutation_epoch();
    return std::nullopt;
}

std::optional<game_handle_error> restore_platform_recipe_items(
    const std::vector<basecamp_platform_recipe_escrow_item> &items,
    const sol::table &destination_holder,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    platform_recipe_item_transaction &transaction )
{
    transaction = {};
    if( items.empty() ) {
        return game_handle_error{
            "escrow_invalid", "recipe_work has no persisted Items to restore"
        };
    }
    std::vector<platform_recipe_item_transaction> inserted;
    inserted.reserve( items.size() );
    for( const basecamp_platform_recipe_escrow_item &entry : items ) {
        platform_recipe_item_transaction current;
        if( const std::optional<game_handle_error> error = restore_platform_recipe_item(
                    entry, destination_holder, current_runtime,
                    current_world_generation, current ) ) {
            bool rolled_back = true;
            for( auto it = inserted.rbegin(); it != inserted.rend(); ++it ) {
                if( it->rollback ) {
                    rolled_back = it->rollback() && rolled_back;
                }
            }
            if( !rolled_back ) {
                return game_handle_error{
                    "rollback_failed",
                    "recipe_work refund failed and an earlier Item insertion could not be rolled back"
                };
            }
            return error;
        }
        inserted.push_back( std::move( current ) );
    }
    transaction.rollback = [inserted = std::move( inserted )]() mutable {
        bool rolled_back = true;
        for( auto it = inserted.rbegin(); it != inserted.rend(); ++it )
        {
            if( it->rollback ) {
                rolled_back = it->rollback() && rolled_back;
            }
        }
        return rolled_back;
    };
    return std::nullopt;
}

std::optional<game_handle_error> insert_platform_recipe_outputs(
    const std::vector<std::string> &serialized_items,
    const sol::table &destination_holder,
    const game_handle_runtime &current_runtime,
    const std::size_t current_world_generation,
    platform_recipe_item_transaction &transaction )
{
    transaction = {};
    item_holder_descriptor descriptor;
    if( const std::optional<game_handle_error> error =
            require_recipe_inventory_destination( destination_holder, descriptor ) ) {
        return error;
    }
    std::optional<game_handle_error> resolve_error;
    Character *character = resolve_exact_character(
                               *descriptor.character, current_runtime,
                               current_world_generation, resolve_error );
    if( character == nullptr ) {
        return resolve_error;
    }
    if( serialized_items.empty() ) {
        return game_handle_error{
            "unsupported_recipe", "recipe_work requires at least one output item"
        };
    }

    std::vector<item> outputs;
    outputs.reserve( serialized_items.size() );
    for( const std::string &serialized : serialized_items ) {
        item output;
        std::string output_error;
        if( !deserialize_recipe_item( serialized, output, output_error ) ) {
            return game_handle_error{ "output_invalid", output_error };
        }
        outputs.push_back( std::move( output ) );
    }

    std::vector<item_location> locations;
    locations.reserve( outputs.size() );
    for( item &output : outputs ) {
        const std::int64_t expected_uid = output.uid().get_value();
        item &inserted = character->inv->add_item(
                             std::move( output ), false, false, false );
        item_location location( *character, &inserted );
        if( !location || location.get_item() == nullptr ||
            location.get_item()->uid().get_value() != expected_uid ) {
            if( location ) {
                location.remove_item();
            }
            for( auto it = locations.rbegin(); it != locations.rend(); ++it ) {
                if( *it ) {
                    it->remove_item();
                }
            }
            bump_item_query_mutation_epoch();
            return game_handle_error{
                "destination_rejected",
                "recipe_work output insertion failed and was rolled back"
            };
        }
        locations.push_back( location );
    }
    transaction.rollback = [locations = std::move( locations )]() mutable {
        bool rolled_back = true;
        for( auto it = locations.rbegin(); it != locations.rend(); ++it )
        {
            if( *it ) {
                it->remove_item();
                rolled_back = rolled_back && it->get_item() == nullptr;
            }
        }
        bump_item_query_mutation_epoch();
        return rolled_back;
    };
    bump_item_query_mutation_epoch();
    return std::nullopt;
}

sol::table recipe_escrow_item_snapshot(
    sol::state_view lua,
    const basecamp_platform_recipe_escrow_item &escrow )
{
    sol::table result = lua.create_table();
    result["uid"] = escrow.stable_uid;
    result["identity_generation"] = static_cast<lua_Integer>(
                                        escrow.identity_generation );
    result["charges"] = static_cast<lua_Integer>( escrow.charges );
    result["tool"] = escrow.tool;
    item value;
    std::string error;
    if( !deserialize_recipe_item( escrow.serialized_item, value, error ) ) {
        result["valid"] = false;
        result["error"] = error;
        result["item"] = sol::nil;
        return result;
    }
    result["valid"] = true;
    result["item"] = snapshot_item( lua, value, 16 );
    return result;
}

void install_item_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write_fn )
{
    sol::state_view lua( services.lua_state() );
    const auto require_item_write = [require_write_fn]() {
        require_write_fn();
    };
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
        "transfer",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & item_handle,
            const sol::table & source_holder,
            const sol::table & destination_holder,
    const sol::optional<std::int64_t> &quantity ) {
        require_item_write();
        return transfer_item(
                   lua_state, item_handle, source_holder,
                   destination_holder, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "page",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state,
            const sol::table & holder,
            const sol::optional<sol::table> &options,
    const sol::optional<sol::table> &continuation ) {
        require_read();
        return item_page(
                   lua_state, holder, options, continuation,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "food_fun",
    [require_read]( const script_game_id & id ) {
        require_read();
        return item_type_food_fun( id );
    } );
    items.set_function(
        "possible_from_group",
        [require_read]( sol::this_state lua_state,
    const script_game_id & group ) {
        require_read();
        return possible_items_from_group(
                   lua_state, group );
    } );
    items.set_function(
        "update",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
    const sol::table & updates ) {
        require_item_write();
        return update_item(
                   lua_state, handle, updates,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "melee_damage",
        [current_runtime_generation, current_world_generation, require_read](
            sol::this_state lua_state, const game_handle & handle,
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
            sol::this_state lua_state, const game_handle & handle,
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
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & quality,
    const sol::optional<bool> &strict ) {
        require_read();
        return item_quality(
                   lua_state, handle, quality, strict,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "transform",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & target,
    const sol::optional<sol::table> &options ) {
        require_item_write();
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
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
            const std::string & key,
    const sol::object & value ) {
        require_item_write();
        return set_item_var(
                   lua_state, handle, key, value,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "erase_var",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
    const std::string & key ) {
        require_item_write();
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
            sol::this_state lua_state, const game_handle & item_handle,
            const game_handle & character,
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
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & flag, const bool enabled ) {
        require_item_write();
        return set_item_flag(
                   lua_state, handle, flag, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "activate",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & item_handle,
            const game_handle & character_handle, const std::string & method,
    const sol::optional<sol::table> &options ) {
        require_item_write();
        return activate_item(
                   lua_state, item_handle, character_handle, method, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_fault",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
            const script_game_id & fault,
    const sol::optional<sol::table> &options ) {
        require_item_write();
        return set_item_fault(
                   lua_state, handle, fault, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_random_fault",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
            const std::string & fault_type,
    const sol::optional<sol::table> &options ) {
        require_item_write();
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
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state, const game_handle & handle,
    const script_game_id & technique, const bool enabled ) {
        require_item_write();
        return set_item_technique(
                   lua_state, handle, technique, enabled,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "set_owner",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & item_handle,
            const game_handle & owner,
    const sol::optional<bool> &remember_previous ) {
        require_item_write();
        return set_item_owner(
                   lua_state, item_handle, owner,
                   remember_previous.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "clear_owner",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & item_handle,
    const sol::optional<bool> &remember_previous ) {
        require_item_write();
        return clear_item_owner(
                   lua_state, item_handle,
                   remember_previous.value_or( false ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    items.set_function(
        "clear_old_owner",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
    const game_handle & item_handle ) {
        require_item_write();
        return clear_item_old_owner(
                   lua_state, item_handle,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["items"] = std::move( items );

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
        [require_item_write]( sol::this_state lua_state,
    const script_game_id & id, const double rate ) {
        require_item_write();
        return set_item_category_spawn_rate(
                   lua_state, id, rate );
    } );
    item_categories.set_function(
        "set_spawn_rates",
        [require_item_write]( sol::this_state lua_state,
    const sol::table & updates ) {
        require_item_write();
        return set_item_category_spawn_rates(
                   lua_state, updates );
    } );
    services["item_categories"] = std::move( item_categories );

    sol::table inventory = lua.create_table();
    inventory.set_function(
        "choose",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const sol::table & candidates,
    const sol::optional<std::string> &title ) {
        require_item_write();
        return choose_inventory_item(
                   lua_state, character, candidates, title,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose_many",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const sol::table & candidates,
    const sol::optional<std::string> &title ) {
        require_item_write();
        return choose_inventory_items(
                   lua_state, character, candidates, title,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose_map",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const sol::table & candidates,
    const sol::optional<sol::table> &options ) {
        require_item_write();
        return choose_map_inventory_items(
                   lua_state, character, candidates,
                   options, false,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "choose_many_map",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const sol::table & candidates,
    const sol::optional<sol::table> &options ) {
        require_item_write();
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
            const game_handle & character,
    const sol::table & entries ) {
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
            const game_handle & character,
            const script_game_id & software,
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
            const game_handle & character,
            const script_game_id & flag,
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
            const game_handle & character,
    const script_game_id & item_id ) {
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
            const game_handle & character,
    const script_game_id & flag ) {
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
            const game_handle & character,
    const script_game_id & category ) {
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
            const game_handle & character,
            const script_game_id & flag,
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
            const game_handle & character,
    const script_game_id & criterion ) {
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
            const game_handle & holder,
    const game_handle & owner ) {
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
    const game_handle & character ) {
        require_read();
        return inventory_weapon_state(
                   lua_state, character,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "give",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const script_game_id & type,
            const std::int64_t quantity,
    const sol::optional<sol::table> &options ) {
        require_item_write();
        return give_inventory_items(
                   lua_state, character, type, quantity, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "give_group",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const script_game_id & group,
    const sol::optional<sol::table> &options ) {
        require_item_write();
        return give_inventory_item_group(
                   lua_state, character, group, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "consume",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const script_game_id & type,
            const sol::optional<std::int64_t> &count,
    const sol::optional<std::int64_t> &charges ) {
        require_item_write();
        return consume_inventory_items(
                   lua_state, character, type,
                   count.value_or( 0 ), charges.value_or( 0 ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "hand_in",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
            const game_handle & recipient,
            const script_game_id & type,
            const sol::optional<std::int64_t> &count,
    const sol::optional<std::int64_t> &charges ) {
        require_item_write();
        return hand_in_inventory_items(
                   lua_state, character, recipient, type,
                   count.value_or( 0 ), charges.value_or( 0 ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    inventory.set_function(
        "consume_sum",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & character,
    const sol::table & entries ) {
        require_item_write();
        return consume_inventory_sum(
                   lua_state, character, entries,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["inventory"] = std::move( inventory );

    sol::table equipment = lua.create_table();
    equipment.set_function(
        "wield",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & actor,
            const game_handle & item_handle,
            const sol::table & source_holder,
    const sol::table & displaced_destination ) {
        require_item_write();
        return perform_equipment_transaction(
                   lua_state, actor, item_handle, &source_holder,
                   displaced_destination, equipment_operation::wield,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    equipment.set_function(
        "wear",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & actor,
            const game_handle & item_handle,
            const sol::table & source_holder,
    const sol::table & displaced_destination ) {
        require_item_write();
        return perform_equipment_transaction(
                   lua_state, actor, item_handle, &source_holder,
                   displaced_destination, equipment_operation::wear,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    equipment.set_function(
        "unequip",
        [current_runtime_generation, current_world_generation, require_item_write](
            sol::this_state lua_state,
            const game_handle & actor,
            const game_handle & item_handle,
    const sol::table & destination_holder ) {
        require_item_write();
        return perform_equipment_transaction(
                   lua_state, actor, item_handle, nullptr,
                   destination_holder, equipment_operation::unequip,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    services["equipment"] = std::move( equipment );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
