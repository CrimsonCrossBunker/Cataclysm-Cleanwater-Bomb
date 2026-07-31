#if CATA_ENABLE_LUA_UI

#include "catalua_ui_items.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <list>
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
#include "catacharset.h"
#include "character.h"
#include "coordinates.h"
#include "creature.h"
#include "inventory.h"
#include "item.h"
#include "item_category.h"
#include "item_contents.h"
#include "item_pocket.h"
#include "itype.h"
#include "math_parser_diag_value.h"
#include "units.h"

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
constexpr int default_item_relation_limit = 64;
constexpr int maximum_item_relation_limit = 256;
constexpr int maximum_item_text_width = 8192;
constexpr int default_pocket_limit = 64;
constexpr int maximum_pocket_limit = 256;
constexpr int default_contents_limit = 128;
constexpr int maximum_contents_limit = 512;
constexpr int default_contents_depth = 8;
constexpr int maximum_contents_depth = 16;
constexpr std::size_t maximum_contents_nodes = 4096;
constexpr std::size_t maximum_contents_offset = 1000000;
constexpr int maximum_item_charges = 1000000000;
constexpr std::size_t maximum_item_var_key_bytes = 128;
constexpr std::size_t maximum_item_var_string_bytes = 4096;
constexpr double maximum_item_var_number = 1.0e15;
constexpr int maximum_inventory_give_instances = 100;
constexpr int maximum_inventory_resource_quantity = 1000000000;

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
                maximum_inventory_offset ) {
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
            if( depth < 0 ) {
                throw std::invalid_argument(
                    "game.inventory.list max_depth cannot be negative" );
            }
            result.max_depth = static_cast<int>(
                                   std::min<std::int64_t>(
                                       depth, maximum_inventory_depth ) );
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
    std::size_t root_index = 0;
    const auto collect_root = [&]( item & root, const std::string & location ) {
        const std::size_t index = root_index++;
        if( node_truncated || !includes_location( options, location ) ) {
            return;
        }
        collect_item_branch(
            root, location, 0, 0,
        { static_cast<int>( index ) }, options, result,
        node_truncated, depth_truncated );
    };

    item_location wielded = character.get_wielded_item();
    if( wielded ) {
        collect_root( *wielded, "wielded" );
    }
    for( item_location worn :
         character.worn.top_items_loc( character ) ) {
        if( worn ) {
            collect_root( *worn, "worn" );
        }
    }
    for( std::list<item> *stack : character.inv->slice() ) {
        if( stack == nullptr ) {
            continue;
        }
        for( item &carried : *stack ) {
            collect_root( carried, "carried" );
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
    result["goes_bad"] = entry.goes_bad();
    result["fresh"] = entry.is_fresh();
    result["going_bad"] = entry.is_going_bad();
    result["rotten"] = entry.rotten();
    result["conductive"] = entry.conductive();

    sol::table condition = lua.create_table();
    condition["damage"] = entry.damage();
    condition["degradation"] = entry.degradation();
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
    return result;
}

sol::table item_snapshot_result(
    sol::this_state lua, const game_handle &handle,
    const sol::optional<int> &requested_relation_limit,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    int max_depth = default_contents_depth;
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
                maximum_contents_offset ) {
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
            if( depth < 0 ) {
                throw std::invalid_argument(
                    "game.items.contents max_depth cannot be negative" );
            }
            result.max_depth = static_cast<int>(
                                   std::min<std::int64_t>(
                                       depth, maximum_contents_depth ) );
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

void collect_item_contents(
    item &parent, const std::vector<int> &parent_path,
    const int parent_depth,
    const contents_query_options &options,
    std::vector<contained_item_entry> &result,
    bool &node_truncated, bool &depth_truncated )
{
    const std::vector<item_pocket *> pockets =
        parent.get_contents().get_pockets(
    []( const item_pocket & ) {
        return true;
    } );
    if( parent_depth >= options.max_depth ) {
        depth_truncated = depth_truncated ||
                          std::any_of(
                              pockets.begin(), pockets.end(),
        []( const item_pocket * pocket ) {
            return pocket != nullptr && !pocket->empty();
        } );
        return;
    }
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
            if( result.size() >= maximum_contents_nodes ) {
                node_truncated = true;
                return;
            }
            if( child == nullptr ) {
                ++child_index;
                continue;
            }
            std::vector<int> child_path = parent_path;
            child_path.push_back(
                static_cast<int>( pocket_index ) );
            child_path.push_back(
                static_cast<int>( child_index ) );
            const int depth = parent_depth + 1;
            result.push_back( {
                child, depth, parent.uid().get_value(),
                pocket_index,
                pocket_type_name(
                    native_pocket_type( *pocket ) ),
                child_path
            } );
            if( options.recursive ) {
                collect_item_contents(
                    *child, child_path, depth, options,
                    result, node_truncated,
                    depth_truncated );
                if( node_truncated ) {
                    return;
                }
            }
            ++child_index;
        }
    }
}

game_handle make_contained_item_handle(
    const game_handle &root,
    const contained_item_entry &entry,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

    bool node_truncated = false;
    bool depth_truncated = false;
    std::vector<contained_item_entry> contents;
    collect_item_contents(
        *resolved.value, handle.locator().path, 0,
        options, contents, node_truncated,
        depth_truncated );
    const std::size_t start =
        std::min( options.offset, contents.size() );
    const std::size_t returned = std::min(
                                     contents.size() - start,
                                     static_cast<std::size_t>(
                                         options.limit ) );
    sol::table items = state.create_table(
                           static_cast<int>( returned ), 0 );
    for( std::size_t index = 0; index < returned; ++index ) {
        items[index + 1] = contained_item_to_lua(
                               state, handle,
                               contents[start + index],
                               runtime_generation,
                               world_generation );
    }
    sol::table value = state.create_table();
    value["items"] = std::move( items );
    value["total"] = contents.size();
    value["total_exact"] =
        !node_truncated && !depth_truncated;
    value["offset"] = options.offset;
    value["limit"] = options.limit;
    value["max_depth"] = options.max_depth;
    value["recursive"] = options.recursive;
    value["returned"] = returned;
    value["has_more"] =
        start + returned < contents.size() ||
        node_truncated;
    value["node_truncated"] = node_truncated;
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

struct item_updates {
    std::optional<int> charges;
    std::optional<int> damage;
    std::optional<bool> favorite;
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
        } else if( key == "favorite" ) {
            result.favorite = boolean_option(
                                  value, key,
                                  "game.items.update" );
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
    result["damage_level"] = entry.damage_level();
    result["max_damage"] = entry.max_damage();
    result["favorite"] = entry.is_favorite;
    result["active"] = entry.is_active();
    return result;
}

sol::table update_item(
    sol::this_state lua, const game_handle &handle,
    const sol::table &requested,
    const std::size_t runtime_generation,
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
    if( updates.damage ) {
        entry.set_damage( *updates.damage );
    }
    if( updates.favorite ) {
        entry.set_favorite( *updates.favorite );
    }
    value["after"] =
        mutable_item_state( state, entry );
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

sol::table set_item_flag(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &flag, const bool enabled,
    const std::size_t runtime_generation,
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
    value["own_before"] =
        resolved.value->has_own_flag( native );
    if( enabled ) {
        resolved.value->set_flag( native );
    } else {
        resolved.value->unset_flag( native );
    }
    value["effective_after"] =
        resolved.value->has_flag( native );
    value["own_after"] =
        resolved.value->has_own_flag( native );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table item_has_technique(
    sol::this_state lua, const game_handle &handle,
    const script_game_id &technique,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

struct inventory_give_options {
    bool allow_wield = false;
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
        } else {
            throw std::invalid_argument(
                "game.inventory.give received unknown option '" +
                key + "'" );
        }
    }
    return result;
}

sol::table character_item_to_lua(
    sol::state_view lua, Character &character, item &entry,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

sol::table inventory_resources(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &type, const std::int64_t quantity,
    const std::size_t runtime_generation,
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

sol::table give_inventory_items(
    sol::this_state lua, const game_handle &character_handle,
    const script_game_id &type, const std::int64_t quantity,
    const sol::optional<sol::table> &requested,
    const std::size_t runtime_generation,
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
    if( !counted_by_charges &&
        quantity > maximum_inventory_give_instances ) {
        throw std::invalid_argument(
            "game.inventory.give cannot create more than 100 item instances at once" );
    }

    const int attempts = counted_by_charges ? 1 :
                         static_cast<int>( quantity );
    sol::table items = state.create_table( attempts, 0 );
    int returned = 0;
    std::int64_t added_quantity = 0;
    for( int index = 0; index < attempts; ++index ) {
        item created(
            native, calendar::turn,
            counted_by_charges ?
            static_cast<int>( quantity ) : -1 );
        item_location added = character->i_add(
                                  created, true, nullptr, nullptr,
                                  false, options.allow_wield );
        if( !added || !added.held_by( *character ) ) {
            break;
        }
        ++returned;
        added_quantity += counted_by_charges ?
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
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table remove_inventory_item(
    sol::this_state lua, const game_handle &character_handle,
    const game_handle &item_handle,
    const sol::optional<std::int64_t> &requested_quantity,
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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
    const std::size_t runtime_generation,
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

} // namespace

void install_item_api(
    sol::table &game,
    std::function<std::size_t()> current_runtime_generation,
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
    game["items"] = std::move( items );

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
    game["inventory"] = std::move( inventory );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
