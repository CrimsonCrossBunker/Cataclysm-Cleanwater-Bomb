#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_camps.h"

#include <character.h>
#include <character_id.h>
extern "C" {
#include <lua.h>
}
#include <map_scale_constants.h>
#include <mapgendata.h>
#include <overmap.h>
#include <pimpl.h>
#include <point.h>
#include <type_id.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <limits>
#include <map>
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <tuple>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "basecamp.h"
#include "calendar.h"
#include "cata_variant.h"
#include "coordinates.h"
#include "faction.h"
#include "game.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_items.h"
#include "lua_platform_world.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "stomach.h"

namespace cata::lua_platform
{

namespace
{

constexpr int default_radius_omt = 0;
constexpr int maximum_radius_omt = 360;
constexpr int default_limit = 64;
constexpr int maximum_limit = 256;
constexpr std::size_t maximum_name_bytes = 25;
constexpr int default_resource_limit = 128;
constexpr int maximum_resource_limit = 512;
constexpr int default_storage_tile_limit = 64;
constexpr int maximum_storage_tile_limit = 256;
constexpr std::size_t maximum_resource_changes = 64;
constexpr std::int64_t maximum_platform_food_kcal = 1000000000;
constexpr int default_task_limit = 64;
constexpr int maximum_task_limit = 256;
constexpr std::size_t maximum_task_kind_bytes = 64;
constexpr std::int64_t maximum_task_duration_turns = 1000000;

tripoint_abs_omt require_omt( const script_tripoint_coord &value,
                              const std::string &api_name )
{
    if( value.native_origin() != coords::origin::abs ||
        value.native_scale() != coords::scale::overmap_terrain ) {
        throw std::invalid_argument( api_name +
                                     " requires an absolute overmap-terrain Tripoint" );
    }
    const tripoint_abs_omt result( value.to_native() );
    if( result.z() < -OVERMAP_DEPTH || result.z() > OVERMAP_HEIGHT ) {
        throw std::invalid_argument( api_name + " z-level is outside the overmap bounds" );
    }
    return result;
}

tripoint_abs_ms require_map_square( const script_tripoint_coord &value,
                                    const std::string &api_name )
{
    if( value.native_origin() != coords::origin::abs ||
        value.native_scale() != coords::scale::map_square ) {
        throw std::invalid_argument( api_name +
                                     " requires an absolute map-square Tripoint" );
    }
    return tripoint_abs_ms( value.to_native() );
}

game_handle make_camp_handle( basecamp &camp,
                              const game_handle_runtime &runtime,
                              const std::size_t world_generation )
{
    return game_handle::from_camp( camp, {}, runtime, world_generation );
}

sol::table snapshot_camp( sol::state_view lua, basecamp &camp,
                          const game_handle &handle )
{
    sol::table value = lua.create_table();
    value["handle"] = handle;
    value["stable_id"] = camp.platform_id();
    value["identity_generation"] = handle.identity_generation();
    value["name"] = camp.camp_name();
    value["board_name"] = camp.board_name();
    value["valid"] = camp.is_valid();
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs,
                            coords::scale::overmap_terrain,
                            camp.camp_omt_pos().raw() );
    value["board_position"] = script_tripoint_coord::from_native(
                                  coords::origin::abs,
                                  coords::scale::map_square,
                                  camp.get_bb_pos_abs().raw() );
    value["assigned_worker_count"] = camp.exact_worker_count();
    const faction_id owner = camp.get_owner();
    if( owner.is_null() ) {
        value["owner"] = sol::nil;
    } else {
        value["owner"] = script_game_id( "faction", owner.str() );
    }
    return value;
}

struct camp_query_options {
    int radius_omt = default_radius_omt;
    int limit = default_limit;
};

camp_query_options read_options( const sol::optional<sol::table> &requested )
{
    camp_query_options result;
    if( requested ) {
        result.radius_omt = requested->get_or( "radius_omt", result.radius_omt );
        result.limit = requested->get_or( "limit", result.limit );
    }
    if( result.radius_omt < 0 || result.radius_omt > maximum_radius_omt ) {
        throw std::invalid_argument( "services.camps.list radius_omt must be within 0..360" );
    }
    if( result.limit < 0 || result.limit > maximum_limit ) {
        throw std::invalid_argument( "services.camps.list limit must be within 0..256" );
    }
    return result;
}

sol::table list_camps( sol::this_state lua,
                       const script_tripoint_coord &center,
                       const sol::optional<sol::table> &requested,
                       const game_handle_runtime &runtime,
                       const std::size_t world_generation )
{
    const tripoint_abs_omt native_center = require_omt( center, "services.camps.list" );
    const camp_query_options options = read_options( requested );
    const std::vector<camp_reference> references = overmap_buffer.get_camps_near(
                project_to<coords::sm>( native_center ), options.radius_omt * 2 );
    sol::state_view state( lua );
    sol::table items = state.create_table();
    int returned = 0;
    for( const camp_reference &reference : references ) {
        if( returned >= options.limit || reference.camp == nullptr ||
            !reference.camp->is_valid() ) {
            continue;
        }
        basecamp &camp = *reference.camp;
        const game_handle handle = make_camp_handle( camp, runtime, world_generation );
        items[++returned] = snapshot_camp( state, camp, handle );
    }
    sol::table result = state.create_table();
    result["items"] = std::move( items );
    result["center"] = script_tripoint_coord::from_native(
                           coords::origin::abs,
                           coords::scale::overmap_terrain,
                           native_center.raw() );
    result["radius_omt"] = options.radius_omt;
    result["returned"] = returned;
    result["limit"] = options.limit;
    result["complete"] = returned < options.limit;
    return make_game_value_result( state, sol::make_object( state, std::move( result ) ) );
}

basecamp *resolve_camp( const game_handle &handle,
                        const game_handle_runtime &runtime,
                        const std::size_t world_generation,
                        std::optional<game_handle_error> &error )
{
    const native_handle_result<basecamp> resolved = handle.resolve_camp(
                runtime, world_generation );
    if( !resolved ) {
        error = resolved.error;
        return nullptr;
    }
    error.reset();
    return resolved.value;
}

Character *resolve_manager( basecamp &camp, const game_handle &handle,
                            const game_handle_runtime &runtime,
                            const std::size_t world_generation,
                            std::optional<game_handle_error> &error )
{
    Character *manager = resolve_exact_character(
                             handle, runtime, world_generation, error );
    if( manager == nullptr ) {
        return nullptr;
    }
    if( !manager->is_avatar() && manager->as_npc() == nullptr ) {
        error = game_handle_error{
            "wrong_subtype", "The camp manager must be an avatar or NPC Character"
        };
        return nullptr;
    }
    if( g == nullptr ||
        camp.get_owner().is_null() ||
        g->faction_manager_ptr->get( camp.get_owner(), false ) == nullptr ) {
        error = game_handle_error{
            "invalid_owner", "The camp has no live owner faction"
        };
        return nullptr;
    }
    if( manager->get_faction() == nullptr || !camp.allowed_access_by( *manager ) ) {
        error = game_handle_error{
            "not_authorized", "The exact manager does not have access to this camp"
        };
        return nullptr;
    }
    return manager;
}

npc_ptr resolve_worker( basecamp &camp, const game_handle &handle,
                        const game_handle_runtime &runtime,
                        const std::size_t world_generation,
                        std::optional<game_handle_error> &error )
{
    npc *worker = resolve_exact_npc( handle, runtime, world_generation, error );
    if( worker == nullptr ) {
        return nullptr;
    }
    if( camp.get_owner().is_null() || worker->get_faction() == nullptr ||
        worker->get_faction()->id != camp.get_owner() ) {
        error = game_handle_error{
            "wrong_owner", "The exact NPC worker does not belong to the camp owner"
        };
        return nullptr;
    }
    npc_ptr exact = overmap_buffer.find_npc( worker->getID() );
    if( !exact || exact.get() != worker ) {
        error = game_handle_error{
            "stale_identity", "The exact NPC worker is not the live overmap instance"
        };
        return nullptr;
    }
    return exact;
}

bool same_game_handle_identity( const game_handle &lhs,
                                const game_handle &rhs ) noexcept
{
    const game_handle_locator &left = lhs.locator();
    const game_handle_locator &right = rhs.locator();
    return lhs.kind() == rhs.kind() &&
           lhs.runtime_generation() == rhs.runtime_generation() &&
           lhs.world_generation() == rhs.world_generation() &&
           lhs.identity_generation() == rhs.identity_generation() &&
           left.scope == right.scope && left.stable_id == right.stable_id &&
           left.x == right.x && left.y == right.y && left.z == right.z &&
           left.path == right.path &&
           left.owner_generation == right.owner_generation;
}

std::uint64_t persistent_character_identity_generation( const Character &value )
{
    const npc *entry = value.as_npc();
    return entry == nullptr ? 0 : entry->platform_identity_generation();
}

faction *resolve_camp_owner( basecamp &camp,
                             std::optional<game_handle_error> &error )
{
    if( g == nullptr ) {
        error = game_handle_error{ "unavailable", "No faction manager is available" };
        return nullptr;
    }
    const faction_id owner_id = camp.get_owner();
    if( owner_id.is_null() ) {
        error = game_handle_error{ "invalid_owner", "The camp has no owner faction" };
        return nullptr;
    }
    faction *owner = g->faction_manager_ptr->get( owner_id, false );
    if( owner == nullptr ) {
        error = game_handle_error{ "invalid_owner", "The camp owner faction is not live" };
        return nullptr;
    }
    error.reset();
    return owner;
}

struct camp_page_options {
    std::size_t offset = 0;
    int limit = default_resource_limit;
};

camp_page_options read_camp_page_options(
    const sol::optional<sol::table> &requested,
    const std::string &api_name, const int default_limit_value,
    const int maximum_limit_value )
{
    camp_page_options result;
    result.limit = default_limit_value;
    if( requested ) {
        const lua_Integer offset = requested->get_or( "offset", lua_Integer( 0 ) );
        const lua_Integer limit = requested->get_or(
                                      "limit", lua_Integer( default_limit_value ) );
        if( offset < 0 || static_cast<std::uint64_t>( offset ) > 1000000U ) {
            throw std::invalid_argument( api_name + " offset must be within 0..1000000" );
        }
        if( limit < 0 || limit > maximum_limit_value ) {
            throw std::invalid_argument( api_name + " limit is outside its bound" );
        }
        result.offset = static_cast<std::size_t>( offset );
        result.limit = static_cast<int>( limit );
    }
    return result;
}

sol::table make_map_tile_holder( sol::state_view lua,
                                 const tripoint_abs_ms &position,
                                 const game_handle_runtime &runtime,
                                 const std::size_t world_generation )
{
    sol::table holder = lua.create_table();
    holder["kind"] = "map_tile";
    holder["tile"] = map_tile_token( position, runtime, world_generation );
    return holder;
}

void validate_name( const std::string &name )
{
    if( name.empty() || name.size() > maximum_name_bytes ) {
        throw std::invalid_argument( "services.camps.rename name must contain 1..25 bytes" );
    }
    if( std::any_of( name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument( "services.camps.rename name contains a control character" );
    }
}

std::optional<basecamp *> find_exact_loaded_camp( const tripoint_abs_omt &position )
{
    const overmap_with_local_coords located =
        overmap_buffer.get_existing_om_global( position );
    if( located.om == nullptr ) {
        return std::nullopt;
    }
    return located.om->find_camp( position.xy() );
}

struct camp_create_options {
    std::string type;
};

camp_create_options read_camp_create_options(
    const sol::optional<sol::table> &requested )
{
    if( !requested ) {
        throw std::invalid_argument(
            "services.camps.create requires options.type" );
    }
    camp_create_options result;
    for( const auto &entry : *requested ) {
        if( !entry.first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.camps.create options keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "type" ) {
            throw std::invalid_argument(
                "services.camps.create options contains an unknown field '" + key + "'" );
        }
    }
    const sol::object raw_type = ( *requested )["type"];
    if( !raw_type.is<std::string>() ) {
        throw std::invalid_argument(
            "services.camps.create options.type must be a string" );
    }
    result.type = raw_type.as<std::string>();
    if( result.type.size() < base_camps::prefix_len ||
        result.type.rfind( base_camps::prefix, 0 ) != 0 ||
        ( !oter_str_id( result.type ).is_valid() &&
          !oter_type_str_id( result.type ).is_valid() &&
          !recipe_id( result.type ).is_valid() ) ) {
        throw std::invalid_argument(
            "services.camps.create options.type must be a valid Platform camp type" );
    }
    return result;
}

Character *resolve_create_manager( const game_handle &handle,
                                   const game_handle_runtime &runtime,
                                   const std::size_t world_generation,
                                   const faction_id &owner,
                                   std::optional<game_handle_error> &error )
{
    Character *manager = resolve_exact_character(
                             handle, runtime, world_generation, error );
    if( manager == nullptr ) {
        return nullptr;
    }
    if( !manager->is_avatar() && manager->as_npc() == nullptr ) {
        error = game_handle_error{
            "wrong_subtype", "The camp manager must be an avatar or NPC Character"
        };
        return nullptr;
    }
    if( manager->is_dead_state() || manager->get_faction() == nullptr ) {
        error = game_handle_error{
            "stale_identity", "The camp manager is not a live Character"
        };
        return nullptr;
    }
    if( manager->get_faction()->id != owner ) {
        error = game_handle_error{
            "wrong_owner", "The exact manager does not belong to the requested camp owner"
        };
        return nullptr;
    }
    return manager;
}

bool validate_camp_create_terrain( const tripoint_abs_omt &position,
                                   std::string &error )
{
    if( position == tripoint_abs_omt() ||
        position.z() < -OVERMAP_DEPTH || position.z() > OVERMAP_HEIGHT ) {
        error = "camp position is outside the world overmap bounds";
        return false;
    }
    const oter_id &terrain = overmap_buffer.ter( position );
    if( !terrain.id().is_valid() ) {
        error = "camp position has no valid overmap terrain";
        return false;
    }
    return true;
}

sol::table create_camp( sol::this_state lua,
                        const script_game_id &owner_value,
                        const game_handle &manager_handle,
                        const script_tripoint_coord &position_value,
                        const std::string &name,
                        const sol::optional<sol::table> &options,
                        const game_handle_runtime &runtime,
                        const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( owner_value.kind() != "faction" || !owner_value.is_valid() ) {
        throw std::invalid_argument(
            "services.camps.create owner_faction must be GameId<faction>" );
    }
    validate_name( name );
    const tripoint_abs_omt position = require_omt(
                                          position_value, "services.camps.create" );
    const camp_create_options create_options = read_camp_create_options( options );
    const faction_id owner( owner_value.value() );
    std::optional<game_handle_error> error;
    Character *manager = resolve_create_manager(
                             manager_handle, runtime, world_generation, owner, error );
    if( manager == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( g == nullptr ||
        g->faction_manager_ptr->get( owner, false ) == nullptr ) {
        return make_game_error_result( state, {
            "owner_not_found", "The requested camp owner faction is not live"
        } );
    }
    std::string rejection;
    if( !validate_camp_create_terrain( position, rejection ) ) {
        return make_game_error_result( state, {
            "invalid_terrain", rejection
        } );
    }
    if( const std::optional<basecamp *> existing = find_exact_loaded_camp( position );
        existing && *existing != nullptr ) {
        return make_game_error_result( state, {
            "camp_conflict", "A camp already occupies the explicit OMT position"
        } );
    }

    // Construct and fully initialize the detached candidate before publishing
    // it to the overmap.  No caller-visible camp identity exists until the
    // final add, so an exception or failed postcondition leaves no partial
    // Platform camp record behind.
    basecamp candidate( name, position );
    candidate.set_owner( owner );
    candidate.define_camp( position, create_options.type, false );
    const std::uint64_t candidate_id = candidate.platform_id();
    try {
        overmap_buffer.add_camp( candidate );
    } catch( const std::exception &exception ) {
        if( const std::optional<basecamp *> published =
                find_exact_loaded_camp( position );
            published && *published != nullptr &&
            ( *published )->platform_id() == candidate_id ) {
            // `add_camp` is normally all-or-nothing.  Keep the postcondition
            // defensive in case a lower layer published before throwing.
            overmap_buffer.remove_camp( position.xy() );
        }
        return make_game_error_result( state, {
            "create_failed", std::string( "Camp creation was rolled back: " ) +
            exception.what()
        } );
    } catch( ... ) {
        if( const std::optional<basecamp *> published =
                find_exact_loaded_camp( position );
            published && *published != nullptr &&
            ( *published )->platform_id() == candidate_id ) {
            overmap_buffer.remove_camp( position.xy() );
        }
        return make_game_error_result( state, {
            "create_failed", "Camp creation was rolled back after an unknown failure"
        } );
    }
    const std::optional<basecamp *> created = find_exact_loaded_camp( position );
    if( !created || *created == nullptr || ( *created )->platform_id() != candidate_id ) {
        return make_game_error_result( state, {
            "create_failed", "The camp publish postcondition failed"
        } );
    }
    basecamp &camp = **created;
    const game_handle camp_handle = make_camp_handle( camp, runtime, world_generation );
    sol::table value = snapshot_camp( state, camp, camp_handle );
    value["created"] = true;
    value["manager"] = manager_handle;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table remove_camp( sol::this_state lua, const game_handle &camp_handle,
                        const game_handle &manager_handle,
                        const game_handle_runtime &runtime,
                        const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::string rejection;
    if( !camp->platform_can_remove( rejection ) ) {
        return make_game_error_result( state, {
            "removal_rejected", rejection
        } );
    }
    const tripoint_abs_omt position = camp->camp_omt_pos();
    const std::uint64_t stable_id = camp->platform_id();
    const std::size_t old_generation = camp_handle.identity_generation();
    overmap_buffer.remove_camp( position.xy() );
    if( const std::optional<basecamp *> still_present =
            find_exact_loaded_camp( position ); still_present ) {
        return make_game_error_result( state, {
            "remove_failed", "The camp removal postcondition failed"
        } );
    }
    sol::table value = state.create_table();
    value["removed"] = true;
    value["stable_id"] = stable_id;
    value["identity_generation"] = old_generation;
    value["camp"] = camp_handle;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table camp_result( sol::state_view lua, basecamp &camp,
                        const game_handle_runtime &runtime,
                        const std::size_t world_generation,
                        const std::optional<game_handle> &worker,
                        const bool assigned )
{
    const game_handle camp_handle = make_camp_handle( camp, runtime, world_generation );
    sol::table value = lua.create_table();
    value["camp"] = camp_handle;
    value["assigned"] = assigned;
    value["assigned_worker_count"] = camp.exact_worker_count();
    if( worker ) {
        value["worker"] = *worker;
    } else {
        value["worker"] = sol::nil;
    }
    return make_game_value_result( lua, sol::make_object( lua, std::move( value ) ) );
}

sol::table camp_resource_value( sol::state_view lua, faction &owner,
                                const std::vector<basecamp_resource> &resources,
                                const camp_page_options &options )
{
    const std::size_t begin = std::min( options.offset, resources.size() );
    const std::size_t end = std::min(
                                resources.size(), begin + static_cast<std::size_t>( options.limit ) );
    sol::table entries = lua.create_table();
    int returned = 0;
    for( std::size_t index = begin; index < end; ++index ) {
        const basecamp_resource &resource = resources[index];
        sol::table value = lua.create_table();
        if( resource.fake_id.is_valid() ) {
            value["id"] = script_game_id( "item", resource.fake_id.str() );
        } else {
            value["id"] = sol::nil;
        }
        if( resource.ammo_id.is_valid() ) {
            value["ammo_id"] = script_game_id( "item", resource.ammo_id.str() );
        } else {
            value["ammo_id"] = sol::nil;
        }
        value["available"] = resource.available;
        value["consumed"] = resource.consumed;
        entries[++returned] = std::move( value );
    }

    const nutrients food_supply = owner.food_supply();
    sol::table food = lua.create_table();
    food["kcal"] = food_supply.calories / 1000;
    food["consumes_food"] = owner.consumes_food;

    sol::table result = lua.create_table();
    result["resources"] = std::move( entries );
    result["total"] = static_cast<std::int64_t>( resources.size() );
    result["offset"] = static_cast<std::int64_t>( options.offset );
    result["limit"] = options.limit;
    result["returned"] = returned;
    result["complete"] = end == resources.size();
    result["truncated"] = end < resources.size();
    result["food"] = std::move( food );
    return result;
}

sol::table camp_resources_snapshot(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const camp_page_options options = read_camp_page_options(
                                          requested, "services.camps.resources.snapshot",
                                          default_resource_limit, maximum_resource_limit );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    faction *owner = resolve_camp_owner( *camp, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::vector<basecamp_resource> resources;
    std::string rejection;
    if( !camp->platform_resource_snapshot( resources, rejection ) ) {
        return make_game_error_result( state, {
            "ambiguous_resource", "Camp resources cannot use fake_id as a unique key: " +
            rejection
        } );
    }
    sol::table value = camp_resource_value( state, *owner, resources, options );
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

std::vector<basecamp_platform_resource_change> read_resource_changes(
    const sol::table &requested )
{
    std::vector<basecamp_platform_resource_change> changes;
    for( const auto &entry : requested ) {
        if( !entry.first.is<lua_Integer>() ||
            entry.first.as<lua_Integer>() !=
            static_cast<lua_Integer>( changes.size() + 1 ) ) {
            throw std::invalid_argument(
                "services.camps.resources.adjust changes must be a dense array" );
        }
        if( !entry.second.is<sol::table>() ) {
            throw std::invalid_argument(
                "services.camps.resources.adjust changes must contain typed descriptors" );
        }
        const sol::table descriptor = entry.second.as<sol::table>();
        const sol::object raw_id = descriptor["id"];
        const sol::object raw_delta = descriptor["delta"];
        if( !raw_id.is<script_game_id>() || !raw_delta.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "services.camps.resources.adjust change requires item id and integer delta" );
        }
        const script_game_id resource_id = raw_id.as<script_game_id>();
        if( resource_id.kind() != "item" || !resource_id.is_valid() ) {
            throw std::invalid_argument(
                "services.camps.resources.adjust change id must be GameId<item>" );
        }
        const lua_Integer raw_amount = raw_delta.as<lua_Integer>();
        if( raw_amount == 0 || raw_amount < -maximum_platform_food_kcal ||
            raw_amount > maximum_platform_food_kcal ) {
            throw std::invalid_argument(
                "services.camps.resources.adjust delta is outside its bound" );
        }
        changes.push_back( { itype_id( resource_id.value() ),
                             static_cast<std::int64_t>( raw_amount ) } );
    }
    if( changes.empty() || changes.size() > maximum_resource_changes ) {
        throw std::invalid_argument(
            "services.camps.resources.adjust requires 1..64 changes" );
    }
    return changes;
}

basecamp_platform_resource_work read_resource_work_descriptor(
    const sol::table &descriptor )
{
    basecamp_platform_resource_work work;
    for( const auto &entry : descriptor ) {
        if( !entry.first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.camps.tasks.create resource_work descriptor keys must be named" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "resource_inputs" && key != "resource_outputs" &&
            key != "food_input_kcal" && key != "food_output_kcal" &&
            key != "duration_turns" ) {
            throw std::invalid_argument(
                "services.camps.tasks.create resource_work descriptor contains an unknown field" );
        }
    }

    const auto read_amounts = []( const sol::object & raw, const char *field ) {
        std::vector<basecamp_platform_resource_change> result;
        if( !raw.valid() || raw.get_type() == sol::type::nil ) {
            return result;
        }
        if( !raw.is<sol::table>() ) {
            throw std::invalid_argument(
                std::string( "services.camps.tasks.create " ) + field +
                " must be a dense typed array" );
        }
        const sol::table values = raw.as<sol::table>();
        for( const auto &entry : values ) {
            if( !entry.first.is<lua_Integer>() ||
                entry.first.as<lua_Integer>() !=
                static_cast<lua_Integer>( result.size() + 1 ) ) {
                throw std::invalid_argument(
                    std::string( "services.camps.tasks.create " ) + field +
                    " must be a dense array" );
            }
            if( !entry.second.is<sol::table>() ) {
                throw std::invalid_argument(
                    std::string( "services.camps.tasks.create " ) + field +
                    " entries must be typed descriptors" );
            }
            const sol::table change = entry.second.as<sol::table>();
            const sol::object raw_id = change["id"];
            const sol::object raw_amount = change["amount"];
            if( !raw_id.is<script_game_id>() || !raw_amount.is<lua_Integer>() ) {
                throw std::invalid_argument(
                    std::string( "services.camps.tasks.create " ) + field +
                    " entries require GameId<item> id and integer amount" );
            }
            const script_game_id id = raw_id.as<script_game_id>();
            const lua_Integer amount = raw_amount.as<lua_Integer>();
            if( id.kind() != "item" || !id.is_valid() || amount <= 0 ||
                amount > 1000000000 ) {
                throw std::invalid_argument(
                    std::string( "services.camps.tasks.create " ) + field +
                    " contains an invalid or out-of-bound entry" );
            }
            result.push_back( { itype_id( id.value() ), static_cast<std::int64_t>( amount ) } );
        }
        if( result.size() > maximum_resource_changes ) {
            throw std::invalid_argument(
                std::string( "services.camps.tasks.create " ) + field +
                " is limited to 64 entries" );
        }
        return result;
    };

    work.resource_inputs = read_amounts(
                               descriptor["resource_inputs"], "resource_inputs" );
    work.resource_outputs = read_amounts(
                                descriptor["resource_outputs"], "resource_outputs" );

    const auto read_food = [&descriptor]( const char *field ) -> std::optional<std::int64_t> {
        const sol::object raw = descriptor[field];
        if( !raw.valid() || raw.get_type() == sol::type::nil )
        {
            return std::nullopt;
        }
        if( !raw.is<lua_Integer>() )
        {
            throw std::invalid_argument(
                std::string( "services.camps.tasks.create " ) + field +
                " must be an integer" );
        }
        const lua_Integer value = raw.as<lua_Integer>();
        if( value <= 0 || value > 1000000000 )
        {
            throw std::invalid_argument(
                std::string( "services.camps.tasks.create " ) + field +
                " must be positive and bounded" );
        }
        return static_cast<std::int64_t>( value );
    };
    work.food_input_kcal = read_food( "food_input_kcal" );
    work.food_output_kcal = read_food( "food_output_kcal" );

    const sol::object raw_duration = descriptor["duration_turns"];
    if( !raw_duration.is<lua_Integer>() ) {
        throw std::invalid_argument(
            "services.camps.tasks.create resource_work requires duration_turns" );
    }
    const lua_Integer duration = raw_duration.as<lua_Integer>();
    if( duration <= 0 || duration > maximum_task_duration_turns ) {
        throw std::invalid_argument(
            "services.camps.tasks.create resource_work duration is outside its bound" );
    }
    work.duration_turns = static_cast<std::int64_t>( duration );
    std::string error;
    if( !validate_basecamp_platform_resource_work( work, error ) ) {
        throw std::invalid_argument( error );
    }
    return work;
}

bool recipe_holder_equals( const basecamp_platform_recipe_holder &lhs,
                           const basecamp_platform_recipe_holder &rhs )
{
    return lhs.kind == rhs.kind && lhs.character == rhs.character &&
           lhs.identity_generation == rhs.identity_generation &&
           lhs.slot == rhs.slot;
}

basecamp_platform_recipe_holder read_recipe_holder_descriptor(
    const sol::table &requested, const std::string_view api_name,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    for( const auto &field : requested ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " holder keys must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key != "kind" && key != "character" && key != "slot" ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " holder has an unknown field '" + key + "'" );
        }
    }
    const sol::object raw_kind = requested["kind"];
    const sol::object raw_character = requested["character"];
    const sol::object raw_slot = requested["slot"];
    if( !raw_kind.is<std::string>() || raw_kind.as<std::string>() != "character" ||
        !raw_character.is<game_handle>() || !raw_slot.is<std::string>() ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " requires a character GameHandle and slot" );
    }
    const game_handle character_handle = raw_character.as<game_handle>();
    const std::string slot = raw_slot.as<std::string>();
    if( slot != "inventory" && slot != "worn" && slot != "wielded" ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " holder.slot must be inventory, worn, or wielded" );
    }
    if( character_handle.identity_generation() == 0 ||
        ( character_handle.subtype_name() != "avatar" &&
          character_handle.subtype_name() != "npc" ) ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " holder.character must be an exact avatar or NPC handle" );
    }
    std::optional<game_handle_error> error;
    Character *character = resolve_exact_character(
                               character_handle, runtime, world_generation, error );
    if( character == nullptr ) {
        throw std::invalid_argument( std::string( api_name ) + " holder.character: " +
                                     ( error ? error->message : "handle is not live" ) );
    }
    if( !character->is_avatar() && character->as_npc() == nullptr ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " holder.character has an unsupported subtype" );
    }
    basecamp_platform_recipe_holder result;
    result.character = character->getID();
    result.identity_generation = character_handle.identity_generation();
    result.slot = slot;
    return result;
}

basecamp_platform_recipe_work read_recipe_work_descriptor(
    const sol::table &descriptor, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.camps.tasks.create";
    for( const auto &field : descriptor ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument( "services.camps.tasks.create recipe_work descriptor keys must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key != "recipe_id" && key != "batch" && key != "duration_turns" &&
            key != "source_holders" && key != "destination_holder" ) {
            throw std::invalid_argument( "services.camps.tasks.create recipe_work descriptor has an unknown field '"
                                         +
                                         key + "'" );
        }
    }
    const sol::object raw_recipe = descriptor["recipe_id"];
    if( !raw_recipe.is<script_game_id>() ||
        raw_recipe.as<script_game_id>().kind() != "recipe" ||
        !raw_recipe.as<script_game_id>().is_valid() ) {
        throw std::invalid_argument( "services.camps.tasks.create recipe_work requires GameId<recipe> recipe_id" );
    }
    const sol::object raw_batch = descriptor["batch"];
    const sol::object raw_duration = descriptor["duration_turns"];
    if( !raw_batch.is<lua_Integer>() || !raw_duration.is<lua_Integer>() ) {
        throw std::invalid_argument( "services.camps.tasks.create recipe_work requires integer batch and duration_turns" );
    }
    const lua_Integer batch = raw_batch.as<lua_Integer>();
    const lua_Integer duration = raw_duration.as<lua_Integer>();
    if( batch <= 0 || batch > 1000 || duration <= 0 || duration > maximum_task_duration_turns ) {
        throw std::invalid_argument( "services.camps.tasks.create recipe_work batch or duration is outside its bound" );
    }
    const sol::object raw_sources = descriptor["source_holders"];
    if( !raw_sources.is<sol::table>() ) {
        throw std::invalid_argument( "services.camps.tasks.create recipe_work requires source_holders" );
    }
    const sol::table source_tables = raw_sources.as<sol::table>();
    basecamp_platform_recipe_work result;
    result.recipe_id = raw_recipe.as<script_game_id>().value();
    result.batch = static_cast<int>( batch );
    result.duration_turns = static_cast<std::int64_t>( duration );
    for( const auto &entry : source_tables ) {
        if( !entry.first.is<lua_Integer>() ||
            entry.first.as<lua_Integer>() !=
            static_cast<lua_Integer>( result.source_holders.size() + 1 ) ||
            !entry.second.is<sol::table>() ) {
            throw std::invalid_argument( "services.camps.tasks.create recipe_work source_holders must be a dense typed array" );
        }
        result.source_holders.push_back( read_recipe_holder_descriptor(
                                             entry.second.as<sol::table>(), api_name,
                                             runtime, world_generation ) );
    }
    if( result.source_holders.empty() ) {
        throw std::invalid_argument( "services.camps.tasks.create recipe_work requires at least one source holder" );
    }
    const sol::object raw_destination = descriptor["destination_holder"];
    if( !raw_destination.is<sol::table>() ) {
        throw std::invalid_argument( "services.camps.tasks.create recipe_work requires destination_holder" );
    }
    result.destination_holder = read_recipe_holder_descriptor(
                                    raw_destination.as<sol::table>(), api_name,
                                    runtime, world_generation );
    std::string error;
    if( !validate_basecamp_platform_recipe_work( result, error ) ) {
        throw std::invalid_argument( error );
    }
    return result;
}

mapgen_arguments read_upgrade_mapgen_arguments( const sol::object &requested )
{
    constexpr std::string_view api_name = "services.camps.tasks.create upgrade_work";
    if( !requested.is<sol::table>() ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " requires a typed mapgen_args table" );
    }
    const sol::table values = requested.as<sol::table>();
    if( values.size() > 64 ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " mapgen_args is limited to 64 named values" );
    }
    mapgen_arguments result;
    for( const auto &entry : values ) {
        if( !entry.first.is<std::string>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " mapgen_args keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key.empty() || key.size() > 64 || key.find( '\0' ) != std::string::npos ||
            !entry.second.is<sol::table>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " mapgen_args values must be bounded typed values" );
        }
        const sol::table typed = entry.second.as<sol::table>();
        for( const auto &field : typed ) {
            if( !field.first.is<std::string>() ||
                ( field.first.as<std::string>() != "type" &&
                  field.first.as<std::string>() != "value" ) ) {
                throw std::invalid_argument( std::string( api_name ) +
                                             " mapgen_args values have an unknown field" );
            }
        }
        const sol::object raw_type = typed["type"];
        const sol::object raw_value = typed["value"];
        if( !raw_type.is<std::string>() || !raw_value.valid() ||
            raw_value.get_type() == sol::type::nil ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " mapgen_args values require type and value" );
        }
        const std::string type = raw_type.as<std::string>();
        if( type == "int" ) {
            if( !raw_value.is<lua_Integer>() ||
                raw_value.as<lua_Integer>() < std::numeric_limits<int>::min() ||
                raw_value.as<lua_Integer>() > std::numeric_limits<int>::max() ) {
                throw std::invalid_argument( std::string( api_name ) +
                                             " int mapgen_args values are out of bounds" );
            }
            result.add( key, cata_variant::make<cata_variant_type::int_>(
                            static_cast<int>( raw_value.as<lua_Integer>() ) ) );
        } else if( type == "bool" ) {
            if( !raw_value.is<bool>() ) {
                throw std::invalid_argument( std::string( api_name ) +
                                             " bool mapgen_args values require booleans" );
            }
            result.add( key, cata_variant::make<cata_variant_type::bool_>(
                            raw_value.as<bool>() ) );
        } else if( type == "string" ) {
            if( !raw_value.is<std::string>() || raw_value.as<std::string>().size() > 256 ) {
                throw std::invalid_argument( std::string( api_name ) +
                                             " string mapgen_args values are out of bounds" );
            }
            result.add( key, cata_variant::make<cata_variant_type::string>(
                            raw_value.as<std::string>() ) );
        } else {
            throw std::invalid_argument( std::string( api_name ) +
                                         " supports only int, bool, and string values" );
        }
    }
    return result;
}

basecamp_platform_upgrade_work read_upgrade_work_descriptor(
    const sol::table &descriptor, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    constexpr std::string_view api_name = "services.camps.tasks.create upgrade_work";
    for( const auto &field : descriptor ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " descriptor keys must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key != "upgrade_id" && key != "blueprint_id" && key != "target" &&
            key != "duration_turns" && key != "source_holders" &&
            key != "destination_holder" ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " descriptor has an unknown field '" + key + "'" );
        }
    }
    const sol::object raw_upgrade = descriptor["upgrade_id"];
    const sol::object raw_blueprint = descriptor["blueprint_id"];
    const sol::object raw_duration = descriptor["duration_turns"];
    const sol::object raw_sources = descriptor["source_holders"];
    const sol::object raw_destination = descriptor["destination_holder"];
    const sol::object raw_target = descriptor["target"];
    if( !raw_upgrade.is<script_game_id>() ||
        raw_upgrade.as<script_game_id>().kind() != "recipe" ||
        !raw_upgrade.as<script_game_id>().is_valid() ||
        !raw_blueprint.is<std::string>() || !raw_duration.is<lua_Integer>() ||
        !raw_sources.is<sol::table>() || !raw_destination.is<sol::table>() ||
        !raw_target.is<sol::table>() ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " requires upgrade_id, blueprint_id, target, duration_turns, source_holders, and destination_holder" );
    }
    const lua_Integer duration = raw_duration.as<lua_Integer>();
    if( duration <= 0 || duration > maximum_task_duration_turns ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " duration_turns is outside its bound" );
    }

    basecamp_platform_upgrade_work result;
    result.upgrade_id = raw_upgrade.as<script_game_id>().value();
    result.blueprint_id = raw_blueprint.as<std::string>();
    result.duration_turns = static_cast<std::int64_t>( duration );

    const sol::table target = raw_target.as<sol::table>();
    for( const auto &field : target ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " target keys must be strings" );
        }
        const std::string key = field.first.as<std::string>();
        if( key != "kind" && key != "expansion" && key != "generation" &&
            key != "position" && key != "terrain" && key != "mapgen_args" ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " target has an unknown field '" + key + "'" );
        }
    }
    const sol::object raw_target_kind = target["kind"];
    const sol::object raw_generation = target["generation"];
    const sol::object raw_position = target["position"];
    const sol::object raw_terrain = target["terrain"];
    const sol::object raw_mapgen_args = target["mapgen_args"];
    if( !raw_target_kind.is<std::string>() || !raw_position.is<script_tripoint_coord>() ||
        !raw_terrain.is<std::string>() || !raw_mapgen_args.is<sol::table>() ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " target requires kind, position, terrain, and mapgen_args" );
    }
    const std::string target_kind = raw_target_kind.as<std::string>();
    if( target_kind == "camp_core" ) {
        result.target_kind = basecamp_platform_upgrade_target_kind::camp_core;
        if( !raw_generation.is<lua_Integer>() || raw_generation.as<lua_Integer>() <= 0 ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " camp_core target requires a positive generation" );
        }
        result.target_core_generation = static_cast<std::uint64_t>(
                                            raw_generation.as<lua_Integer>() );
        if( target["expansion"].valid() &&
            target["expansion"].get_type() != sol::type::nil ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " camp_core target cannot include expansion" );
        }
    } else if( target_kind == "expansion" ) {
        const sol::object raw_expansion = target["expansion"];
        if( !raw_expansion.is<camp_expansion_token>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " expansion target requires CampExpansionToken" );
        }
        const camp_expansion_token token = raw_expansion.as<camp_expansion_token>();
        if( !token.belongs_to( runtime ) || token.world_generation() != world_generation ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " target expansion token is stale" );
        }
        result.target_kind = basecamp_platform_upgrade_target_kind::expansion;
        if( raw_generation.valid() && raw_generation.get_type() != sol::type::nil ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " expansion target cannot include core generation" );
        }
        result.target_expansion_id = token.expansion_id();
        result.target_expansion_generation = token.identity_generation();
    } else {
        throw std::invalid_argument( std::string( api_name ) +
                                     " target.kind must be camp_core or expansion" );
    }
    result.target_position = require_omt(
                                 raw_position.as<script_tripoint_coord>(),
                                 "services.camps.tasks.create upgrade_work target.position" );
    result.target_terrain = raw_terrain.as<std::string>();
    result.mapgen_args = read_upgrade_mapgen_arguments( raw_mapgen_args );

    const sol::table source_tables = raw_sources.as<sol::table>();
    for( const auto &entry : source_tables ) {
        if( !entry.first.is<lua_Integer>() ||
            entry.first.as<lua_Integer>() !=
            static_cast<lua_Integer>( result.source_holders.size() + 1 ) ||
            !entry.second.is<sol::table>() ) {
            throw std::invalid_argument( std::string( api_name ) +
                                         " source_holders must be a dense typed array" );
        }
        result.source_holders.push_back( read_recipe_holder_descriptor(
                                             entry.second.as<sol::table>(), api_name,
                                             runtime, world_generation ) );
    }
    if( result.source_holders.empty() ) {
        throw std::invalid_argument( std::string( api_name ) +
                                     " requires at least one source holder" );
    }
    result.destination_holder = read_recipe_holder_descriptor(
                                    raw_destination.as<sol::table>(), api_name,
                                    runtime, world_generation );
    std::string error;
    if( !validate_basecamp_platform_upgrade_work( result, error ) ) {
        throw std::invalid_argument( error );
    }
    return result;
}

std::vector<platform_recipe_item_request> read_recipe_item_requests(
    const sol::object &requested )
{
    constexpr std::string_view api_name = "services.camps.tasks.start";
    if( !requested.is<sol::table>() ) {
        throw std::invalid_argument( "services.camps.tasks.start recipe_work requires typed item requests" );
    }
    const sol::table values = requested.as<sol::table>();
    std::vector<platform_recipe_item_request> result;
    result.reserve( values.size() );
    for( const auto &entry : values ) {
        if( !entry.first.is<lua_Integer>() ||
            entry.first.as<lua_Integer>() !=
            static_cast<lua_Integer>( result.size() + 1 ) ||
            !entry.second.is<sol::table>() ) {
            throw std::invalid_argument( "services.camps.tasks.start item requests must be a dense typed array" );
        }
        const sol::table request = entry.second.as<sol::table>();
        for( const auto &field : request ) {
            if( !field.first.is<std::string>() ) {
                throw std::invalid_argument( "services.camps.tasks.start item request keys must be strings" );
            }
            const std::string key = field.first.as<std::string>();
            if( key != "item" && key != "source_holder" && key != "quantity" && key != "tool" ) {
                throw std::invalid_argument( "services.camps.tasks.start item request has an unknown field '" +
                                             key + "'" );
            }
        }
        const sol::object raw_item = request["item"];
        const sol::object raw_holder = request["source_holder"];
        const sol::object raw_quantity = request["quantity"];
        const sol::object raw_tool = request["tool"];
        if( !raw_item.is<game_handle>() || !raw_holder.is<sol::table>() ||
            !raw_quantity.is<lua_Integer>() || !raw_tool.is<bool>() ) {
            throw std::invalid_argument( "services.camps.tasks.start item request requires item, source_holder, quantity, and tool" );
        }
        result.push_back( {
            raw_item.as<game_handle>(), raw_holder.as<sol::table>(),
            static_cast<std::int64_t>( raw_quantity.as<lua_Integer>() ),
            raw_tool.as<bool>()
        } );
    }
    if( result.empty() || result.size() > 256 ) {
        throw std::invalid_argument( "services.camps.tasks.start requires 1..256 item requests" );
    }
    static_cast<void>( api_name );
    return result;
}

sol::table adjust_camp_resources(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle,
    const std::vector<basecamp_platform_resource_change> &changes,
    const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::string rejection;
    if( !camp->platform_adjust_resources( changes, rejection ) ) {
        return make_game_error_result( state, {
            "resource_rejected", "Camp resource adjustment was rejected: " + rejection
        } );
    }
    sol::table value = state.create_table();
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    value["changed"] = true;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table adjust_camp_food(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const std::int64_t kcal,
    const bool add, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( kcal <= 0 || kcal > maximum_platform_food_kcal ) {
        throw std::invalid_argument(
            "services.camps.food amount must be within 1..1000000000 kcal" );
    }
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    faction *owner = resolve_camp_owner( *camp, error );
    if( owner == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const nutrients before = owner->food_supply();
    if( before.calories < 0 ) {
        return make_game_error_result( state, {
            "invalid_food", "The camp owner has an invalid negative food supply"
        } );
    }
    const std::int64_t delta_calories = kcal * 1000;
    std::vector<basecamp_platform_resource_change> outstanding_resources;
    std::int64_t outstanding_food_kcal = 0;
    std::string liability_error;
    if( !camp->platform_reservation_liability(
            outstanding_resources, outstanding_food_kcal, liability_error ) ) {
        return make_game_error_result( state, {
            "invalid_reservation", "The camp has an invalid outstanding task reservation: " +
            liability_error
        } );
    }
    static_cast<void>( outstanding_resources );
    if( add ) {
        if( outstanding_food_kcal >
            std::numeric_limits<std::int64_t>::max() / 1000 ) {
            return make_game_error_result( state, {
                "overflow", "The camp food reservation liability would overflow"
            } );
        }
        const std::int64_t liability_calories = outstanding_food_kcal * 1000;
        if( liability_calories > std::numeric_limits<std::int64_t>::max() -
            before.calories ||
            delta_calories > std::numeric_limits<std::int64_t>::max() -
            before.calories - liability_calories ) {
            return make_game_error_result( state, {
                "overflow", "The camp food supply would overflow its reserved capacity"
            } );
        }
        nutrients added;
        added.calories = delta_calories;
        std::map<time_point, nutrients> additions;
        additions.emplace( calendar::turn_zero, added );
        owner->add_to_food_supply( additions );
    } else {
        if( !owner->consumes_food ) {
            return make_game_error_result( state, {
                "food_disabled", "The camp owner does not consume a finite food supply"
            } );
        }
        if( before.calories < delta_calories ) {
            return make_game_error_result( state, {
                "insufficient_food", "The camp food supply cannot satisfy this request"
            } );
        }
        nutrients consumed = before;
        const double fraction = static_cast<double>( delta_calories ) /
                                static_cast<double>( before.calories );
        consumed *= fraction;
        consumed.calories = delta_calories;
        owner->consume_food_supply( consumed );
    }
    const nutrients after = owner->food_supply();
    sol::table value = state.create_table();
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    value["before_kcal"] = before.calories / 1000;
    value["after_kcal"] = after.calories / 1000;
    value["amount_kcal"] = kcal;
    value["added"] = add;
    value["consumed"] = !add;
    value["changed"] = before.calories != after.calories;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table camp_storage_tiles(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    const camp_page_options options = read_camp_page_options(
                                          requested, "services.camps.inventory.storage_tiles",
                                          default_storage_tile_limit, maximum_storage_tile_limit );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    std::vector<tripoint_abs_ms> positions(
        camp->get_storage_tiles().begin(), camp->get_storage_tiles().end() );
    std::sort( positions.begin(), positions.end(), []( const tripoint_abs_ms & lhs,
    const tripoint_abs_ms & rhs ) {
        return std::make_tuple( lhs.x(), lhs.y(), lhs.z() ) <
               std::make_tuple( rhs.x(), rhs.y(), rhs.z() );
    } );
    const std::size_t begin = std::min( options.offset, positions.size() );
    const std::size_t end = std::min(
                                positions.size(), begin + static_cast<std::size_t>( options.limit ) );
    sol::table entries = state.create_table();
    int returned = 0;
    for( std::size_t index = begin; index < end; ++index ) {
        sol::table value = state.create_table();
        value["holder"] = make_map_tile_holder(
                              state, positions[index], runtime, world_generation );
        entries[++returned] = std::move( value );
    }
    sol::table value = state.create_table();
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    value["items"] = std::move( entries );
    value["total"] = static_cast<std::int64_t>( positions.size() );
    value["offset"] = static_cast<std::int64_t>( options.offset );
    value["limit"] = options.limit;
    value["returned"] = returned;
    value["complete"] = end == positions.size();
    value["truncated"] = end < positions.size();
    value["page_api"] = "services.items.page";
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_camp( sol::this_state lua, const game_handle &camp_handle,
                     const game_handle &manager_handle,
                     const game_handle_runtime &runtime,
                     const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const game_handle current = make_camp_handle( *camp, runtime, world_generation );
    return make_game_value_result( state,
                                   sol::make_object( state, snapshot_camp( state, *camp, current ) ) );
}

sol::table rename_camp( sol::this_state lua, const game_handle &camp_handle,
                        const game_handle &manager_handle, const std::string &name,
                        const game_handle_runtime &runtime,
                        const std::size_t world_generation )
{
    validate_name( name );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::string before = camp->camp_name();
    camp->set_name( name );
    sol::table value = state.create_table();
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    value["before"] = before;
    value["after"] = camp->camp_name();
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_owner( sol::this_state lua, const game_handle &camp_handle,
                      const game_handle &manager_handle, const script_game_id &owner,
                      const game_handle_runtime &runtime,
                      const std::size_t world_generation )
{
    if( owner.kind() != "faction" || !owner.is_valid() ) {
        throw std::invalid_argument( "services.camps.set_owner requires GameId<faction>" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( g == nullptr ||
        g->faction_manager_ptr->get( faction_id( owner.value() ), false ) == nullptr ) {
        return make_game_error_result( state, {
            "owner_not_found", "The requested owner faction does not exist"
        } );
    }
    const faction_id before = camp->get_owner();
    camp->set_owner( faction_id( owner.value() ) );
    sol::table value = state.create_table();
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    if( before.is_null() ) {
        value["before"] = sol::nil;
    } else {
        value["before"] = script_game_id( "faction", before.str() );
    }
    value["after"] = script_game_id( "faction", camp->get_owner().str() );
    value["changed"] = before != camp->get_owner();
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table set_board_position( sol::this_state lua, const game_handle &camp_handle,
                               const game_handle &manager_handle,
                               const script_tripoint_coord &position,
                               const game_handle_runtime &runtime,
                               const std::size_t world_generation )
{
    const tripoint_abs_ms board = require_map_square(
                                      position, "services.camps.set_board_position" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( project_to<coords::omt>( board ) != camp->camp_omt_pos() ) {
        return make_game_error_result( state, {
            "invalid_position", "The board must remain inside the camp overmap tile"
        } );
    }
    const tripoint_abs_ms before = camp->get_bb_pos_abs();
    camp->set_bb_pos( board );
    sol::table value = state.create_table();
    value["camp"] = make_camp_handle( *camp, runtime, world_generation );
    value["before"] = script_tripoint_coord::from_native(
                          coords::origin::abs, coords::scale::map_square, before.raw() );
    value["after"] = script_tripoint_coord::from_native(
                         coords::origin::abs, coords::scale::map_square,
                         camp->get_bb_pos_abs().raw() );
    value["changed"] = before != camp->get_bb_pos_abs();
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table mutate_worker( sol::this_state lua, const game_handle &camp_handle,
                          const game_handle &manager_handle,
                          const game_handle &worker_handle, const bool assign,
                          const game_handle_runtime &runtime,
                          const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    npc_ptr worker = resolve_worker( *camp, worker_handle, runtime, world_generation, error );
    if( !worker ) {
        return make_game_error_result( state, *error );
    }
    if( assign ) {
        if( camp->has_exact_worker( *worker ) || worker->assigned_camp ) {
            return make_game_error_result( state, {
                "already_assigned", "The exact NPC worker is already assigned"
            } );
        }
        if( !camp->assign_exact_worker( worker ) ) {
            return make_game_error_result( state, {
                "assignment_rejected", "The camp rejected the exact worker assignment"
            } );
        }
    } else {
        if( !camp->has_exact_worker( *worker ) || !camp->recall_exact_worker( worker ) ) {
            return make_game_error_result( state, {
                "recall_rejected", "The exact NPC worker is not assigned to this camp"
            } );
        }
    }
    return camp_result( state, *camp, runtime, world_generation, worker_handle, assign );
}

} // namespace

camp_task_token::camp_task_token(
    const std::uint64_t task_id, const std::uint64_t task_generation,
    const game_handle &camp, const game_handle &manager,
    const game_handle &worker, const std::uint64_t manager_identity_generation,
    const std::uint64_t worker_identity_generation,
    const game_handle_runtime &runtime, const std::size_t world_generation ) :
    task_id_( task_id ),
    task_generation_( task_generation ),
    runtime_( runtime ),
    world_generation_( world_generation ),
    camp_( camp ),
    manager_( manager ),
    worker_( worker ),
    manager_identity_generation_( manager_identity_generation ),
    worker_identity_generation_( worker_identity_generation )
{
}

std::uint64_t camp_task_token::task_id() const noexcept
{
    return task_id_;
}

std::uint64_t camp_task_token::identity_generation() const noexcept
{
    return task_generation_;
}

std::size_t camp_task_token::runtime_generation() const noexcept
{
    return runtime_.generation();
}

std::size_t camp_task_token::world_generation() const noexcept
{
    return world_generation_;
}

std::int64_t camp_task_token::camp_stable_id() const noexcept
{
    return camp_.locator().stable_id;
}

std::size_t camp_task_token::camp_identity_generation() const noexcept
{
    return camp_.identity_generation();
}

std::int64_t camp_task_token::manager_stable_id() const noexcept
{
    return manager_.locator().stable_id;
}

std::int64_t camp_task_token::worker_stable_id() const noexcept
{
    return worker_.locator().stable_id;
}

std::uint64_t camp_task_token::manager_identity_generation() const noexcept
{
    return manager_identity_generation_;
}

std::uint64_t camp_task_token::worker_identity_generation() const noexcept
{
    return worker_identity_generation_;
}

bool camp_task_token::belongs_to( const game_handle_runtime &runtime ) const noexcept
{
    return runtime_.is_active_match( runtime );
}

bool camp_task_token::matches_context( const game_handle &camp,
                                       const game_handle &manager,
                                       const game_handle &worker ) const noexcept
{
    return same_game_handle_identity( camp_, camp ) &&
           same_game_handle_identity( manager_, manager ) &&
           same_game_handle_identity( worker_, worker );
}

std::string camp_task_token::to_string() const
{
    return "CampTaskToken<" + std::to_string( task_id_ ) + ":" +
           std::to_string( task_generation_ ) + ">";
}

bool operator==( const camp_task_token &lhs, const camp_task_token &rhs ) noexcept
{
    return lhs.task_id_ == rhs.task_id_ &&
           lhs.task_generation_ == rhs.task_generation_ &&
           lhs.world_generation_ == rhs.world_generation_ &&
           lhs.runtime_.same_identity( rhs.runtime_ ) &&
           lhs.manager_identity_generation_ == rhs.manager_identity_generation_ &&
           lhs.worker_identity_generation_ == rhs.worker_identity_generation_ &&
           lhs.matches_context( rhs.camp_, rhs.manager_, rhs.worker_ );
}

camp_expansion_token::camp_expansion_token(
    const std::uint64_t expansion_id, const std::uint64_t expansion_generation,
    const game_handle &camp, std::string owner_faction,
    const game_handle_runtime &runtime, const std::size_t world_generation ) :
    expansion_id_( expansion_id ),
    expansion_generation_( expansion_generation ),
    runtime_( runtime ),
    world_generation_( world_generation ),
    camp_( camp ),
    owner_faction_( std::move( owner_faction ) )
{
}

std::uint64_t camp_expansion_token::expansion_id() const noexcept
{
    return expansion_id_;
}

std::uint64_t camp_expansion_token::identity_generation() const noexcept
{
    return expansion_generation_;
}

std::size_t camp_expansion_token::runtime_generation() const noexcept
{
    return runtime_.generation();
}

std::size_t camp_expansion_token::world_generation() const noexcept
{
    return world_generation_;
}

std::int64_t camp_expansion_token::camp_stable_id() const noexcept
{
    return camp_.locator().stable_id;
}

std::size_t camp_expansion_token::camp_identity_generation() const noexcept
{
    return camp_.identity_generation();
}

const std::string &camp_expansion_token::owner_faction() const noexcept
{
    return owner_faction_;
}

bool camp_expansion_token::belongs_to(
    const game_handle_runtime &runtime ) const noexcept
{
    return runtime_.is_active_match( runtime );
}

bool camp_expansion_token::matches_context( const game_handle &camp ) const noexcept
{
    return same_game_handle_identity( camp_, camp );
}

std::string camp_expansion_token::to_string() const
{
    return "CampExpansionToken<" + std::to_string( expansion_id_ ) + ":" +
           std::to_string( expansion_generation_ ) + ">";
}

bool operator==( const camp_expansion_token &lhs,
                 const camp_expansion_token &rhs ) noexcept
{
    return lhs.expansion_id_ == rhs.expansion_id_ &&
           lhs.expansion_generation_ == rhs.expansion_generation_ &&
           lhs.world_generation_ == rhs.world_generation_ &&
           lhs.runtime_.same_identity( rhs.runtime_ ) &&
           lhs.owner_faction_ == rhs.owner_faction_ &&
           lhs.matches_context( rhs.camp_ );
}

namespace
{

struct resolved_platform_task {
    basecamp *camp = nullptr;
    Character *manager = nullptr;
    npc_ptr worker;
    basecamp_platform_task task;
};

game_handle_error task_rejection( const std::string &message )
{
    if( message.find( "unsupported" ) != std::string::npos ) {
        return { "unsupported_kind", message };
    }
    if( message.find( "not found" ) != std::string::npos ) {
        return { "not_found", message };
    }
    if( message.find( "retired" ) != std::string::npos ||
        message.find( "identity" ) != std::string::npos ) {
        return { "stale_task", message };
    }
    if( message.find( "not due" ) != std::string::npos ) {
        return { "not_due", message };
    }
    return { "task_rejected", message };
}

std::optional<game_handle_error> resolve_platform_task(
    const camp_task_token &token, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const game_handle_runtime &runtime, const std::size_t world_generation,
    resolved_platform_task &resolved )
{
    if( !token.belongs_to( runtime ) ) {
        return game_handle_error{
            "stale_runtime", "CampTaskToken belongs to a different or inactive runtime"
        };
    }
    if( token.world_generation() != world_generation ) {
        return game_handle_error{
            "stale_world", "CampTaskToken belongs to a different world generation"
        };
    }
    if( !token.matches_context( camp_handle, manager_handle, worker_handle ) ) {
        return game_handle_error{
            "stale_task", "CampTaskToken is bound to different camp or actor handles"
        };
    }

    std::optional<game_handle_error> error;
    resolved.camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( resolved.camp == nullptr ) {
        return error;
    }
    resolved.manager = resolve_manager( *resolved.camp, manager_handle, runtime,
                                        world_generation, error );
    if( resolved.manager == nullptr ) {
        return error;
    }

    const std::vector<basecamp_platform_task> tasks =
        resolved.camp->platform_task_snapshot();
    const auto task_it = std::find_if( tasks.begin(), tasks.end(),
    [&token]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == token.task_id();
    } );
    if( task_it == tasks.end() ) {
        return game_handle_error{
            "not_found", "The CampTask record no longer exists"
        };
    }
    if( task_it->identity_generation != token.identity_generation() ) {
        return game_handle_error{
            "stale_task", "CampTaskToken refers to a retired task generation"
        };
    }
    const bool recoverable_item_escrow =
        ( task_it->kind == basecamp_platform_recipe_work_kind ||
          task_it->kind == basecamp_platform_upgrade_work_kind ) &&
        ( task_it->state == basecamp_platform_task_state::refund_pending ||
          task_it->state == basecamp_platform_task_state::completed_unclaimed );
    if( task_it->camp_id != resolved.camp->platform_id() ||
        task_it->owner_faction != resolved.camp->get_owner() ||
        task_it->manager != resolved.manager->getID() ||
        task_it->manager_identity_generation != token.manager_identity_generation() ||
        task_it->worker.get_value() != token.worker_stable_id() ||
        task_it->worker_identity_generation != token.worker_identity_generation() ) {
        return game_handle_error{
            "stale_identity", "CampTask record ownership no longer matches its token"
        };
    }
    resolved.task = *task_it;
    if( task_it->awaiting_reconciliation ) {
        return game_handle_error{
            "awaiting_reconciliation",
            "The CampTask is waiting for its exact actor lifetime to load"
        };
    }
    if( !recoverable_item_escrow ) {
        resolved.worker = resolve_worker( *resolved.camp, worker_handle, runtime,
                                          world_generation, error );
        if( !resolved.worker ) {
            return error;
        }
        if( persistent_character_identity_generation( *resolved.manager ) !=
            token.manager_identity_generation() ||
            persistent_character_identity_generation( *resolved.worker ) !=
            token.worker_identity_generation() ) {
            return game_handle_error{
                "stale_identity", "CampTaskToken refers to a replaced actor"
            };
        }
    }
    const bool isolated_recipe_recovery =
        resolved.task.recipe_recovery_required &&
        ( resolved.task.kind == basecamp_platform_recipe_work_kind ||
          resolved.task.kind == basecamp_platform_upgrade_work_kind ) &&
        resolved.task.state == basecamp_platform_task_state::refund_pending &&
        !resolved.task.recipe_escrow.empty();
    std::string kind_error;
    if( !isolated_recipe_recovery && !validate_basecamp_platform_task_kind(
            task_it->kind, task_it->parameters,
            basecamp_platform_task_operation::resolve, kind_error ) ) {
        return game_handle_error{ "task_rejected", kind_error };
    }
    if( resolved.task.recipe_recovery_required && !isolated_recipe_recovery ) {
        return game_handle_error{
            "invalid_reservation",
            "An item escrow recovery record has no recoverable escrow"
        };
    }
    basecamp_platform_task_execution_context executor_context;
    executor_context.camp = resolved.camp;
    executor_context.task = &resolved.task;
    if( !isolated_recipe_recovery ) {
        if( !dispatch_basecamp_platform_task(
                resolved.task.kind, basecamp_platform_task_operation::resolve,
                executor_context, kind_error ) ) {
            return game_handle_error{ "task_rejected", kind_error };
        }
    }
    if( task_it->state == basecamp_platform_task_state::completed ||
        task_it->state == basecamp_platform_task_state::cancelled ) {
        return game_handle_error{
            "stale_task", "The CampTask has already been retired"
        };
    }
    if( task_it->state == basecamp_platform_task_state::running &&
        ( !resolved.worker->assigned_camp ||
          *resolved.worker->assigned_camp != resolved.camp->camp_omt_pos() ||
          !resolved.camp->has_exact_worker( *resolved.worker ) ) ) {
        return game_handle_error{
            "reservation_missing", "The CampTask worker reservation is no longer live"
        };
    }
    return std::nullopt;
}

camp_task_token make_camp_task_token(
    const basecamp_platform_task &task, const game_handle &camp,
    const game_handle &manager, const game_handle &worker,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    return camp_task_token(
               task.task_id, task.identity_generation, camp, manager, worker,
               task.manager_identity_generation, task.worker_identity_generation,
               runtime, world_generation );
}

sol::table resource_work_value(
    sol::state_view lua, const basecamp_platform_resource_work &work )
{
    auto changes_value = [lua](
    const std::vector<basecamp_platform_resource_change> &changes ) mutable {
        sol::table values = lua.create_table();
        int index = 0;
        for( const basecamp_platform_resource_change &change : changes )
        {
            sol::table value = lua.create_table();
            value["id"] = script_game_id( "item", change.resource_id.str() );
            value["amount"] = static_cast<lua_Integer>( change.delta );
            values[++index] = std::move( value );
        }
        return values;
    };
    sol::table value = lua.create_table();
    value["resource_inputs"] = changes_value( work.resource_inputs );
    value["resource_outputs"] = changes_value( work.resource_outputs );
    if( work.food_input_kcal ) {
        value["food_input_kcal"] = *work.food_input_kcal;
    } else {
        value["food_input_kcal"] = sol::nil;
    }
    if( work.food_output_kcal ) {
        value["food_output_kcal"] = *work.food_output_kcal;
    } else {
        value["food_output_kcal"] = sol::nil;
    }
    value["duration_turns"] = static_cast<lua_Integer>( work.duration_turns );
    return value;
}

sol::table recipe_holder_value( sol::state_view lua,
                                const basecamp_platform_recipe_holder &holder )
{
    sol::table value = lua.create_table();
    value["kind"] = "character";
    value["character_id"] = holder.character.get_value();
    value["identity_generation"] = static_cast<lua_Integer>(
                                       holder.identity_generation );
    value["slot"] = holder.slot;
    return value;
}

sol::table recipe_work_value( sol::state_view lua,
                              const basecamp_platform_recipe_work &work )
{
    sol::table source_holders = lua.create_table();
    int index = 0;
    for( const basecamp_platform_recipe_holder &holder : work.source_holders ) {
        source_holders[++index] = recipe_holder_value( lua, holder );
    }
    sol::table value = lua.create_table();
    value["recipe_id"] = script_game_id( "recipe", work.recipe_id );
    value["batch"] = work.batch;
    value["duration_turns"] = static_cast<lua_Integer>( work.duration_turns );
    value["source_holders"] = std::move( source_holders );
    value["destination_holder"] = recipe_holder_value( lua, work.destination_holder );
    return value;
}

sol::table upgrade_mapgen_arguments_value( sol::state_view lua,
        const mapgen_arguments &arguments )
{
    sol::table result = lua.create_table();
    for( const auto &[key, value] : arguments.map ) {
        sol::table typed = lua.create_table();
        switch( value.type() ) {
            case cata_variant_type::int_:
                typed["type"] = "int";
                typed["value"] = value.get<int>();
                break;
            case cata_variant_type::bool_:
                typed["type"] = "bool";
                typed["value"] = value.get<bool>();
                break;
            case cata_variant_type::string:
                typed["type"] = "string";
                typed["value"] = value.get<std::string>();
                break;
            default:
                // The public parser accepts only these detached primitive
                // forms, but preserve an unexpected native value as a
                // diagnostic rather than exposing a pointer or JSON object.
                typed["type"] = "unsupported";
                typed["value"] = value.get_string();
                break;
        }
        result[key] = std::move( typed );
    }
    return result;
}

sol::table upgrade_work_value( sol::state_view lua,
                               const basecamp_platform_upgrade_work &work )
{
    sol::table source_holders = lua.create_table();
    int index = 0;
    for( const basecamp_platform_recipe_holder &holder : work.source_holders ) {
        source_holders[++index] = recipe_holder_value( lua, holder );
    }
    sol::table target = lua.create_table();
    target["kind"] = work.target_kind == basecamp_platform_upgrade_target_kind::camp_core ?
                     "camp_core" : "expansion";
    if( work.target_kind == basecamp_platform_upgrade_target_kind::expansion ) {
        target["expansion_id"] = static_cast<lua_Integer>( work.target_expansion_id );
        target["expansion_generation"] = static_cast<lua_Integer>(
                                             work.target_expansion_generation );
        target["generation"] = sol::nil;
    } else {
        target["expansion_id"] = sol::nil;
        target["expansion_generation"] = sol::nil;
        target["generation"] = static_cast<lua_Integer>( work.target_core_generation );
    }
    target["position"] = script_tripoint_coord::from_native(
                             coords::origin::abs,
                             coords::scale::overmap_terrain,
                             work.target_position.raw() );
    target["terrain"] = work.target_terrain;
    target["mapgen_args"] = upgrade_mapgen_arguments_value( lua, work.mapgen_args );

    sol::table value = lua.create_table();
    value["upgrade_id"] = script_game_id( "recipe", work.upgrade_id );
    value["blueprint_id"] = work.blueprint_id;
    value["target"] = std::move( target );
    value["duration_turns"] = static_cast<lua_Integer>( work.duration_turns );
    value["source_holders"] = std::move( source_holders );
    value["destination_holder"] = recipe_holder_value( lua, work.destination_holder );
    return value;
}

sol::table recipe_escrow_value( sol::state_view lua,
                                const std::vector<basecamp_platform_recipe_escrow_item> &escrow )
{
    sol::table items = lua.create_table();
    int index = 0;
    for( const basecamp_platform_recipe_escrow_item &entry : escrow ) {
        sol::table value = recipe_escrow_item_snapshot( lua, entry );
        value["source_holder"] = recipe_holder_value( lua, entry.source_holder );
        items[++index] = std::move( value );
    }
    sol::table result = lua.create_table();
    result["items"] = std::move( items );
    result["total"] = static_cast<lua_Integer>( escrow.size() );
    result["returned"] = static_cast<lua_Integer>( escrow.size() );
    result["limit"] = 256;
    result["complete"] = true;
    result["truncated"] = false;
    return result;
}

sol::table resource_reservation_value(
    sol::state_view lua, const basecamp_platform_task &task )
{
    sol::table resources = lua.create_table();
    int index = 0;
    for( const basecamp_platform_resource_change &change : task.reserved_resources ) {
        sol::table value = lua.create_table();
        value["id"] = script_game_id( "item", change.resource_id.str() );
        value["amount"] = static_cast<lua_Integer>( change.delta );
        resources[++index] = std::move( value );
    }
    sol::table result = lua.create_table();
    result["resources"] = std::move( resources );
    result["food_kcal"] = static_cast<lua_Integer>( task.reserved_food_kcal );
    result["active"] = task.state == basecamp_platform_task_state::running;
    result["discarded"] = task.reservation_discarded;
    return result;
}

sol::table snapshot_platform_task(
    sol::state_view lua, const basecamp_platform_task &task,
    const game_handle &camp, const game_handle &manager, const game_handle &worker,
    const game_handle_runtime &runtime, const std::size_t world_generation,
    const std::optional<camp_task_token> &token )
{
    sol::table value = lua.create_table();
    value["task_id"] = static_cast<lua_Integer>( task.task_id );
    value["identity_generation"] = static_cast<lua_Integer>( task.identity_generation );
    value["camp"] = camp;
    value["manager"] = manager;
    value["worker"] = worker;
    if( task.owner_faction.is_null() ) {
        value["owner"] = sol::nil;
    } else {
        value["owner"] = script_game_id( "faction", task.owner_faction.str() );
    }
    value["kind"] = task.kind;
    value["parameter_schema"] = task.parameters;
    if( task.resource_work ) {
        value["resource_work"] = resource_work_value( lua, *task.resource_work );
    } else {
        value["resource_work"] = sol::nil;
    }
    if( task.recipe_work ) {
        value["recipe_work"] = recipe_work_value( lua, *task.recipe_work );
    } else {
        value["recipe_work"] = sol::nil;
    }
    if( task.upgrade_work ) {
        value["upgrade_work"] = upgrade_work_value( lua, *task.upgrade_work );
    } else {
        value["upgrade_work"] = sol::nil;
    }
    if( !task.recipe_escrow.empty() ) {
        value["recipe_escrow"] = recipe_escrow_value( lua, task.recipe_escrow );
    } else {
        value["recipe_escrow"] = sol::nil;
    }
    value["recipe_commit_marker"] = static_cast<lua_Integer>(
                                        task.recipe_commit_marker );
    value["upgrade_commit_marker"] = static_cast<lua_Integer>(
                                         task.upgrade_commit_marker );
    value["upgrade_applying_marker"] = static_cast<lua_Integer>(
                                           task.upgrade_applying_marker );
    value["recipe_recovery_required"] = task.recipe_recovery_required;
    value["reservation"] = resource_reservation_value( lua, task );
    value["state"] = basecamp_platform_task_state_name( task.state );
    value["started_at"] = script_time_point::from_native( task.started_at );
    value["due_at"] = script_time_point::from_native( task.due_at );
    if( task.finished_at ) {
        value["finished_at"] = script_time_point::from_native( *task.finished_at );
    } else {
        value["finished_at"] = sol::nil;
    }
    value["reservation_active"] = task.state == basecamp_platform_task_state::running;
    if( token ) {
        value["token"] = *token;
    } else {
        value["token"] = sol::nil;
    }
    static_cast<void>( runtime );
    static_cast<void>( world_generation );
    return value;
}

sol::table create_platform_task(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const std::string &kind, const sol::optional<sol::table> &requested_descriptor,
    const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( kind.empty() || kind.size() > maximum_task_kind_bytes ) {
        return make_game_error_result( state, {
            "invalid_kind", "CampTask kind must contain 1..64 bytes"
        } );
    }
    std::string parameter_schema;
    std::optional<basecamp_platform_resource_work> resource_work;
    std::optional<basecamp_platform_recipe_work> recipe_work;
    std::optional<basecamp_platform_upgrade_work> upgrade_work;
    if( kind == basecamp_platform_resource_work_kind ) {
        if( !requested_descriptor ) {
            return make_game_error_result( state, {
                "invalid_parameters", "resource_work requires a typed descriptor"
            } );
        }
        resource_work = read_resource_work_descriptor( *requested_descriptor );
        parameter_schema = std::string( basecamp_platform_resource_work_parameter_schema );
    } else if( kind == basecamp_platform_recipe_work_kind ) {
        if( !requested_descriptor ) {
            return make_game_error_result( state, {
                "invalid_parameters", "recipe_work requires a typed descriptor"
            } );
        }
        recipe_work = read_recipe_work_descriptor(
                          *requested_descriptor, runtime, world_generation );
        parameter_schema = std::string( basecamp_platform_recipe_work_parameter_schema );
    } else if( kind == basecamp_platform_upgrade_work_kind ) {
        if( !requested_descriptor ) {
            return make_game_error_result( state, {
                "invalid_parameters", "upgrade_work requires a typed descriptor"
            } );
        }
        upgrade_work = read_upgrade_work_descriptor(
                           *requested_descriptor, runtime, world_generation );
        parameter_schema = std::string( basecamp_platform_upgrade_work_parameter_schema );
    } else if( requested_descriptor ) {
        return make_game_error_result( state, {
            "invalid_parameters", "this Platform task kind does not accept a descriptor"
        } );
    }
    std::string kind_error;
    if( !validate_basecamp_platform_task_kind(
            kind, parameter_schema, basecamp_platform_task_operation::preflight, kind_error ) ) {
        return make_game_error_result( state, {
            find_basecamp_platform_task_executor( kind ) == nullptr ?
            "unsupported_kind" : "invalid_parameters", kind_error
        } );
    }
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *manager = resolve_manager( *camp, manager_handle, runtime,
                                          world_generation, error );
    if( manager == nullptr ) {
        return make_game_error_result( state, *error );
    }
    npc_ptr worker = resolve_worker( *camp, worker_handle, runtime,
                                     world_generation, error );
    if( !worker ) {
        return make_game_error_result( state, *error );
    }
    if( worker->assigned_camp || camp->has_exact_worker( *worker ) ) {
        return make_game_error_result( state, {
            "worker_busy", "The exact worker is already assigned to a camp"
        } );
    }
    if( upgrade_work ) {
        std::string target_error;
        if( !camp->platform_validate_upgrade_target( *upgrade_work, target_error ) ) {
            return make_game_error_result( state, {
                "invalid_target", target_error
            } );
        }
    }

    basecamp_platform_task task;
    task.camp_id = camp->platform_id();
    task.owner_faction = camp->get_owner();
    task.manager = manager->getID();
    task.worker = worker->getID();
    task.manager_identity_generation = persistent_character_identity_generation( *manager );
    task.worker_identity_generation = persistent_character_identity_generation( *worker );
    task.kind = kind;
    task.parameters = parameter_schema;
    task.resource_work = std::move( resource_work );
    task.recipe_work = std::move( recipe_work );
    task.upgrade_work = std::move( upgrade_work );
    std::string rejection;
    if( !camp->platform_create_task( task, rejection ) ) {
        return make_game_error_result( state, task_rejection( rejection ) );
    }
    const camp_task_token token = make_camp_task_token(
                                      task, camp_handle, manager_handle, worker_handle,
                                      runtime, world_generation );
    return make_game_value_result( state, sol::make_object( state,
                                   snapshot_platform_task( state, task, camp_handle,
                                           manager_handle, worker_handle, runtime,
                                           world_generation, token ) ) );
}

sol::table get_platform_task(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const camp_task_token &token, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    resolved_platform_task resolved;
    if( const std::optional<game_handle_error> error = resolve_platform_task(
                token, camp_handle, manager_handle, worker_handle, runtime,
                world_generation, resolved ) ) {
        return make_game_error_result( state, *error );
    }
    const camp_task_token current = make_camp_task_token(
                                        resolved.task, camp_handle, manager_handle,
                                        worker_handle, runtime, world_generation );
    return make_game_value_result( state, sol::make_object( state,
                                   snapshot_platform_task( state, resolved.task,
                                           camp_handle, manager_handle, worker_handle,
                                           runtime, world_generation, current ) ) );
}

std::optional<camp_task_token> current_platform_task_token(
    const basecamp_platform_task &task, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    if( task.state != basecamp_platform_task_state::pending &&
        task.state != basecamp_platform_task_state::running &&
        task.state != basecamp_platform_task_state::refund_pending &&
        task.state != basecamp_platform_task_state::completed_unclaimed ) {
        return std::nullopt;
    }
    return make_camp_task_token( task, camp_handle, manager_handle, worker_handle,
                                 runtime, world_generation );
}

sol::table resolve_recipe_escrow(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const camp_task_token &token, const sol::optional<sol::table> &destination_holder,
    const bool require_destination, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    if( !destination_holder ) {
        if( require_destination ) {
            return make_game_error_result( state, {
                "invalid_destination",
                "recipe_work escrow resolution requires an explicit destination holder"
            } );
        }
        return get_platform_task( lua, camp_handle, manager_handle, worker_handle,
                                  token, runtime, world_generation );
    }

    resolved_platform_task resolved;
    if( const std::optional<game_handle_error> error = resolve_platform_task(
                token, camp_handle, manager_handle, worker_handle, runtime,
                world_generation, resolved ) ) {
        return make_game_error_result( state, *error );
    }
    const bool item_escrow_task =
        resolved.task.recipe_work || resolved.task.upgrade_work ||
        resolved.task.recipe_recovery_required;
    if( !item_escrow_task ||
        ( resolved.task.state != basecamp_platform_task_state::refund_pending &&
          resolved.task.state != basecamp_platform_task_state::completed_unclaimed ) ||
        resolved.task.recipe_escrow.empty() ) {
        return make_game_error_result( state, {
            "task_rejected",
            "Only refund_pending or completed_unclaimed item-escrow tasks retain recoverable escrow"
        } );
    }

    const std::vector<basecamp_platform_recipe_escrow_item> escrow =
        resolved.task.recipe_escrow;
    platform_recipe_item_transaction transaction;
    if( const std::optional<game_handle_error> error = restore_platform_recipe_items(
                escrow, *destination_holder, runtime, world_generation, transaction ) ) {
        return make_game_error_result( state, *error );
    }

    const bool completed =
        resolved.task.state == basecamp_platform_task_state::completed_unclaimed;
    std::string rejection;
    if( !resolved.camp->platform_claim_recipe_escrow(
            token.task_id(), token.identity_generation(), calendar::turn,
            completed, escrow, rejection ) ) {
        const bool rolled_back = transaction.rollback_now();
        if( !rolled_back ) {
            return make_game_error_result( state, {
                "rollback_failed",
                "recipe_work escrow claim failed and destination rollback failed"
            } );
        }
        return make_game_error_result( state, task_rejection( rejection ) );
    }
    transaction.commit();

    const std::vector<basecamp_platform_task> tasks =
        resolved.camp->platform_task_snapshot();
    const auto task_it = std::find_if( tasks.begin(), tasks.end(),
    [&token]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == token.task_id();
    } );
    if( task_it == tasks.end() ) {
        return make_game_error_result( state, {
            "not_found", "Claimed recipe_work task was not retained"
        } );
    }
    return make_game_value_result( state, sol::make_object( state,
                                   snapshot_platform_task( state, *task_it,
                                           camp_handle, manager_handle, worker_handle,
                                           runtime, world_generation,
                                           current_platform_task_token(
                                                   *task_it, camp_handle, manager_handle,
                                                   worker_handle, runtime, world_generation ) ) ) );
}

sol::table page_platform_tasks(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    const camp_page_options options = read_camp_page_options(
                                          requested, "services.camps.tasks.page",
                                          default_task_limit, maximum_task_limit );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *manager = resolve_manager( *camp, manager_handle, runtime,
                                          world_generation, error );
    if( manager == nullptr ) {
        return make_game_error_result( state, *error );
    }
    npc_ptr worker = resolve_worker( *camp, worker_handle, runtime,
                                     world_generation, error );
    const bool has_recovery_worker_reference =
        !worker && error &&
        ( error->code == "destroyed" || error->code == "dead" ||
          error->code == "stale_identity" ) &&
        worker_handle.kind() == game_handle_kind::creature &&
        worker_handle.subtype_name() == "npc" &&
        worker_handle.locator().stable_id > 0 &&
        worker_handle.identity_generation() > 0;
    if( !worker && !has_recovery_worker_reference ) {
        return make_game_error_result( state, *error );
    }
    const std::uint64_t manager_generation =
        persistent_character_identity_generation( *manager );
    const std::uint64_t worker_generation = worker ?
                                            persistent_character_identity_generation( *worker ) :
                                            worker_handle.identity_generation();
    const std::int64_t worker_stable_id = worker ? worker->getID().get_value() :
                                          worker_handle.locator().stable_id;
    std::vector<basecamp_platform_task> matching;
    for( const basecamp_platform_task &task : camp->platform_task_snapshot() ) {
        if( task.manager != manager->getID() ||
            task.worker.get_value() != worker_stable_id ) {
            continue;
        }
        const bool recoverable_item_escrow =
            ( task.kind == basecamp_platform_recipe_work_kind ||
              task.kind == basecamp_platform_upgrade_work_kind ) &&
            ( task.state == basecamp_platform_task_state::refund_pending ||
              task.state == basecamp_platform_task_state::completed_unclaimed );
        if( !worker && !recoverable_item_escrow ) {
            return make_game_error_result( state, *error );
        }
        if( task.awaiting_reconciliation ) {
            return make_game_error_result( state, {
                "awaiting_reconciliation",
                "A persisted CampTask is waiting for actor reconciliation"
            } );
        }
        basecamp_platform_task checked_task = task;
        basecamp_platform_task_execution_context executor_context;
        executor_context.camp = camp;
        executor_context.task = &checked_task;
        const bool isolated_item_recovery =
            checked_task.recipe_recovery_required &&
            ( checked_task.kind == basecamp_platform_recipe_work_kind ||
              checked_task.kind == basecamp_platform_upgrade_work_kind ) &&
            checked_task.state == basecamp_platform_task_state::refund_pending &&
            !checked_task.recipe_escrow.empty();
        std::string kind_error;
        if( !isolated_item_recovery && !validate_basecamp_platform_task_kind(
                task.kind, task.parameters, basecamp_platform_task_operation::resolve,
                kind_error ) ) {
            return make_game_error_result( state, {
                "task_rejected", kind_error
            } );
        }
        if( !isolated_item_recovery ) {
            if( !dispatch_basecamp_platform_task(
                    checked_task.kind, basecamp_platform_task_operation::resolve,
                    executor_context, kind_error ) ) {
                return make_game_error_result( state, {
                    "invalid_reservation", kind_error
                } );
            }
        }
        if( task.manager_identity_generation != manager_generation ||
            task.worker_identity_generation != worker_generation ) {
            return make_game_error_result( state, {
                "stale_identity", "A persisted CampTask refers to a replaced actor"
            } );
        }
        if( task.state == basecamp_platform_task_state::running && worker &&
            ( !worker->assigned_camp ||
              *worker->assigned_camp != camp->camp_omt_pos() ||
              !camp->has_exact_worker( *worker ) ) ) {
            return make_game_error_result( state, {
                "reservation_missing", "A running CampTask has no live worker reservation"
            } );
        }
        matching.push_back( task );
    }
    const std::size_t begin = std::min( options.offset, matching.size() );
    const std::size_t end = std::min(
                                matching.size(), begin + static_cast<std::size_t>( options.limit ) );
    sol::table entries = state.create_table();
    int returned = 0;
    for( std::size_t index = begin; index < end; ++index ) {
        const basecamp_platform_task &task = matching[index];
        std::optional<camp_task_token> token;
        if( task.state == basecamp_platform_task_state::pending ||
            task.state == basecamp_platform_task_state::running ||
            task.state == basecamp_platform_task_state::refund_pending ||
            task.state == basecamp_platform_task_state::completed_unclaimed ) {
            token = make_camp_task_token( task, camp_handle, manager_handle,
                                          worker_handle, runtime, world_generation );
        }
        entries[++returned] = snapshot_platform_task(
                                  state, task, camp_handle, manager_handle, worker_handle,
                                  runtime, world_generation, token );
    }
    sol::table value = state.create_table();
    value["camp"] = camp_handle;
    value["manager"] = manager_handle;
    value["worker"] = worker_handle;
    value["tasks"] = std::move( entries );
    value["total"] = static_cast<lua_Integer>( matching.size() );
    value["offset"] = static_cast<lua_Integer>( options.offset );
    value["limit"] = options.limit;
    value["returned"] = returned;
    value["complete"] = end == matching.size();
    value["truncated"] = end < matching.size();
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table start_platform_task(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const camp_task_token &token,
    const sol::optional<sol::object> &requested_items_or_duration,
    const sol::optional<std::int64_t> &requested_duration_turns,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    const sol::object requested_arg = requested_items_or_duration ?
                                      *requested_items_or_duration : sol::object();
    resolved_platform_task resolved;
    if( const std::optional<game_handle_error> error = resolve_platform_task(
                token, camp_handle, manager_handle, worker_handle, runtime,
                world_generation, resolved ) ) {
        return make_game_error_result( state, *error );
    }
    std::int64_t duration_turns = 0;
    if( resolved.task.recipe_work || resolved.task.upgrade_work ) {
        if( !requested_arg.is<sol::table>() ) {
            return make_game_error_result( state, {
                "invalid_parameters",
                "item-escrow task start requires explicit typed Item requests"
            } );
        }
        const std::int64_t descriptor_duration = resolved.task.recipe_work ?
                resolved.task.recipe_work->duration_turns :
                resolved.task.upgrade_work->duration_turns;
        if( requested_duration_turns && *requested_duration_turns != descriptor_duration ) {
            return make_game_error_result( state, {
                "invalid_duration",
                "item-escrow task start duration must match its typed descriptor"
            } );
        }
        duration_turns = descriptor_duration;
    } else if( resolved.task.resource_work ) {
        if( requested_arg.valid() &&
            requested_arg.get_type() != sol::type::nil ) {
            if( !requested_arg.is<lua_Integer>() ) {
                return make_game_error_result( state, {
                    "invalid_duration", "Platform task start expected a duration integer"
                } );
            }
            const std::int64_t inline_duration = static_cast<std::int64_t>(
                    requested_arg.as<lua_Integer>() );
            if( requested_duration_turns && *requested_duration_turns != inline_duration ) {
                return make_game_error_result( state, {
                    "invalid_duration", "Platform task received two different durations"
                } );
            }
            duration_turns = inline_duration;
        } else {
            duration_turns = resolved.task.resource_work->duration_turns;
        }
        if( requested_duration_turns &&
            *requested_duration_turns != duration_turns ) {
            return make_game_error_result( state, {
                "invalid_duration",
                "resource_work start duration must match its typed descriptor"
            } );
        }
    } else {
        if( requested_arg.valid() &&
            requested_arg.get_type() != sol::type::nil ) {
            if( !requested_arg.is<lua_Integer>() ) {
                return make_game_error_result( state, {
                    "invalid_duration", "Platform task start expected a duration integer"
                } );
            }
            duration_turns = static_cast<std::int64_t>(
                                 requested_arg.as<lua_Integer>() );
        } else if( requested_duration_turns ) {
            duration_turns = *requested_duration_turns;
        } else {
            duration_turns = -1;
        }
        if( duration_turns < 0 || duration_turns > maximum_task_duration_turns ) {
            return make_game_error_result( state, {
                "invalid_duration", "CampTask duration must be within 0..1000000 turns"
            } );
        }
    }
    if( resolved.task.state != basecamp_platform_task_state::pending ) {
        return make_game_error_result( state, {
            "task_rejected", "Only a pending CampTask can start"
        } );
    }
    std::string rejection;
    if( resolved.task.recipe_work || resolved.task.upgrade_work ) {
        const std::vector<platform_recipe_item_request> requests =
            read_recipe_item_requests( requested_arg );
        platform_recipe_item_transaction transaction;
        std::vector<basecamp_platform_recipe_escrow_item> escrow;
        if( const std::optional<game_handle_error> error = stage_platform_recipe_items(
                    requests, runtime, world_generation, escrow, transaction ) ) {
            return make_game_error_result( state, *error );
        }
        for( const basecamp_platform_recipe_escrow_item &entry : escrow ) {
            const std::vector<basecamp_platform_recipe_holder> &source_holders =
                resolved.task.recipe_work ? resolved.task.recipe_work->source_holders :
                resolved.task.upgrade_work->source_holders;
            const bool declared_holder = std::any_of(
                                             source_holders.begin(), source_holders.end(), [&entry](
            const basecamp_platform_recipe_holder & holder ) {
                return recipe_holder_equals( entry.source_holder, holder );
            } );
            if( !declared_holder ) {
                const bool restored = transaction.rollback_now();
                return make_game_error_result( state, {
                    restored ? "wrong_holder" : "rollback_failed",
                    restored ? "item-escrow request used an undeclared source holder" :
                    "item-escrow source rollback failed after holder validation"
                } );
            }
        }
        if( !resolved.camp->platform_start_task(
                token.task_id(), token.identity_generation(), resolved.worker,
                calendar::turn, time_duration::from_turns( duration_turns ), escrow,
                rejection ) ) {
            const bool restored = transaction.rollback_now();
            if( !restored ) {
                return make_game_error_result( state, {
                    "rollback_failed", "item-escrow start failed and Item escrow rollback failed"
                } );
            }
            return make_game_error_result( state, task_rejection( rejection ) );
        }
        transaction.commit();
    } else if( !resolved.camp->platform_start_task(
                   token.task_id(), token.identity_generation(), resolved.worker,
                   calendar::turn, time_duration::from_turns( duration_turns ), rejection ) ) {
        return make_game_error_result( state, task_rejection( rejection ) );
    }
    const std::vector<basecamp_platform_task> tasks =
        resolved.camp->platform_task_snapshot();
    const auto task_it = std::find_if( tasks.begin(), tasks.end(),
    [&token]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == token.task_id();
    } );
    if( task_it == tasks.end() ) {
        return make_game_error_result( state, {
            "not_found", "Started CampTask was not retained"
        } );
    }
    const camp_task_token current = make_camp_task_token(
                                        *task_it, camp_handle, manager_handle,
                                        worker_handle, runtime, world_generation );
    return make_game_value_result( state, sol::make_object( state,
                                   snapshot_platform_task( state, *task_it,
                                           camp_handle, manager_handle, worker_handle,
                                           runtime, world_generation, current ) ) );
}

sol::table finish_platform_task(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle &worker_handle,
    const camp_task_token &token, const bool complete,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    resolved_platform_task resolved;
    if( const std::optional<game_handle_error> error = resolve_platform_task(
                token, camp_handle, manager_handle, worker_handle, runtime,
                world_generation, resolved ) ) {
        return make_game_error_result( state, *error );
    }
    std::string rejection;
    if( resolved.task.recipe_work || resolved.task.upgrade_work ) {
        if( !resolved.worker ) {
            return make_game_error_result( state, {
                "stale_identity", "item-escrow finish requires the exact live worker"
            } );
        }
        if( !complete ) {
            if( resolved.task.state != basecamp_platform_task_state::running ) {
                return make_game_error_result( state, {
                    "task_rejected", "item-escrow cancel requires a running task"
                } );
            }
            if( !resolved.camp->platform_mark_recipe_refund_pending(
                    token.task_id(), token.identity_generation(), rejection ) ) {
                return make_game_error_result( state, task_rejection( rejection ) );
            }
        } else {
            if( resolved.task.state != basecamp_platform_task_state::running ) {
                return make_game_error_result( state, {
                    "task_rejected", "item-escrow complete requires a running task"
                } );
            }
            const std::vector<basecamp_platform_recipe_escrow_item> original_escrow =
                resolved.task.recipe_escrow;
            std::vector<basecamp_platform_recipe_escrow_item> remaining_escrow;
            if( resolved.task.recipe_work ) {
                if( !resolved.camp->platform_prepare_recipe_completion(
                        token.task_id(), token.identity_generation(), resolved.worker,
                        calendar::turn, remaining_escrow, rejection ) ) {
                    return make_game_error_result( state, task_rejection( rejection ) );
                }
                if( !resolved.camp->platform_complete_recipe_task(
                        token.task_id(), token.identity_generation(), resolved.worker,
                        calendar::turn, original_escrow, remaining_escrow, rejection ) ) {
                    return make_game_error_result( state, task_rejection( rejection ) );
                }
            } else {
                if( !resolved.camp->platform_prepare_upgrade_completion(
                        token.task_id(), token.identity_generation(), resolved.worker,
                        calendar::turn, remaining_escrow, rejection ) ) {
                    return make_game_error_result( state, task_rejection( rejection ) );
                }
                if( !resolved.camp->platform_complete_upgrade_task(
                        token.task_id(), token.identity_generation(), resolved.worker,
                        calendar::turn, original_escrow, remaining_escrow, rejection ) ) {
                    return make_game_error_result( state, task_rejection( rejection ) );
                }
            }
        }

        const std::vector<basecamp_platform_task> tasks =
            resolved.camp->platform_task_snapshot();
        const auto task_it = std::find_if( tasks.begin(), tasks.end(),
        [&token]( const basecamp_platform_task & candidate ) {
            return candidate.task_id == token.task_id();
        } );
        if( task_it == tasks.end() ) {
            return make_game_error_result( state, {
                "not_found", "Finished recipe_work task was not retained"
            } );
        }
        return make_game_value_result( state, sol::make_object( state,
                                       snapshot_platform_task( state, *task_it,
                                               camp_handle, manager_handle, worker_handle,
                                               runtime, world_generation,
                                               current_platform_task_token(
                                                       *task_it, camp_handle, manager_handle,
                                                       worker_handle, runtime,
                                                       world_generation ) ) ) );
    }
    if( !resolved.camp->platform_finish_task(
            token.task_id(), token.identity_generation(), resolved.worker,
            calendar::turn, complete, rejection ) ) {
        return make_game_error_result( state, task_rejection( rejection ) );
    }
    const std::vector<basecamp_platform_task> tasks =
        resolved.camp->platform_task_snapshot();
    const auto task_it = std::find_if( tasks.begin(), tasks.end(),
    [&token]( const basecamp_platform_task & candidate ) {
        return candidate.task_id == token.task_id();
    } );
    if( task_it == tasks.end() ) {
        return make_game_error_result( state, {
            "not_found", "Finished CampTask was not retained"
        } );
    }
    return make_game_value_result( state, sol::make_object( state,
                                   snapshot_platform_task( state, *task_it,
                                           camp_handle, manager_handle, worker_handle,
                                           runtime, world_generation, std::nullopt ) ) );
}

camp_expansion_token make_camp_expansion_token(
    const basecamp_platform_expansion &expansion, basecamp &camp,
    const game_handle &camp_handle, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    return camp_expansion_token(
               expansion.expansion_id, expansion.identity_generation, camp_handle,
               camp.get_owner().str(), runtime, world_generation );
}

sol::table snapshot_camp_expansion(
    sol::state_view lua, basecamp &camp,
    const basecamp_platform_expansion &expansion,
    const game_handle &camp_handle, const game_handle_runtime &runtime,
    const std::size_t world_generation )
{
    sol::table value = lua.create_table();
    value["token"] = make_camp_expansion_token(
                         expansion, camp, camp_handle, runtime, world_generation );
    value["expansion_id"] = expansion.expansion_id;
    value["identity_generation"] = expansion.identity_generation;
    value["camp"] = camp_handle;
    value["camp_stable_id"] = expansion.camp_id;
    sol::table direction = lua.create_table();
    direction["x"] = expansion.direction.x();
    direction["y"] = expansion.direction.y();
    value["direction"] = std::move( direction );
    value["position"] = script_tripoint_coord::from_native(
                            coords::origin::abs,
                            coords::scale::overmap_terrain,
                            expansion.position.raw() );
    value["type"] = expansion.type;
    value["name"] = expansion.name;
    value["work_in_progress"] = expansion.work_in_progress;
    const faction_id owner = camp.get_owner();
    if( owner.is_null() ) {
        value["owner"] = sol::nil;
    } else {
        value["owner"] = script_game_id( "faction", owner.str() );
    }
    return value;
}

std::optional<game_handle_error> resolve_camp_expansion(
    const camp_expansion_token &token, const game_handle &camp_handle,
    const game_handle &manager_handle, const game_handle_runtime &runtime,
    const std::size_t world_generation, basecamp *&camp,
    basecamp_platform_expansion &expansion )
{
    if( !token.belongs_to( runtime ) ) {
        return game_handle_error{
            "stale_runtime", "CampExpansionToken belongs to a different or inactive runtime"
        };
    }
    if( token.world_generation() != world_generation ) {
        return game_handle_error{
            "stale_world", "CampExpansionToken belongs to a different world generation"
        };
    }
    if( !token.matches_context( camp_handle ) ) {
        return game_handle_error{
            "stale_expansion", "CampExpansionToken is bound to a different camp handle"
        };
    }
    std::optional<game_handle_error> error;
    camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return error;
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return error;
    }
    if( token.owner_faction() != camp->get_owner().str() ) {
        return game_handle_error{
            "stale_owner", "CampExpansionToken belongs to a retired camp owner"
        };
    }
    std::string rejection;
    if( !camp->platform_get_expansion(
            token.expansion_id(), token.identity_generation(), expansion, rejection ) ) {
        return game_handle_error{
            rejection.find( "retired" ) != std::string::npos ?
            "stale_expansion" : "not_found", rejection
        };
    }
    if( expansion.camp_id != camp->platform_id() ) {
        return game_handle_error{
            "stale_expansion", "The expansion belongs to a different camp identity"
        };
    }
    return std::nullopt;
}

void validate_expansion_name( const std::string &name )
{
    if( name.empty() || name.size() > 64 ||
    std::any_of( name.begin(), name.end(), []( const unsigned char ch ) {
    return ch < 0x20U || ch == 0x7fU;
} ) ) {
        throw std::invalid_argument(
            "services.camps.expansions.create name must contain 1..64 printable bytes" );
    }
}

sol::table create_camp_expansion(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const script_tripoint_coord &position_value,
    const std::string &type, const std::string &name,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    validate_expansion_name( name );
    const tripoint_abs_omt position = require_omt(
                                          position_value, "services.camps.expansions.create" );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    basecamp_platform_expansion expansion;
    std::string rejection;
    if( !camp->platform_create_expansion( type, name, position, expansion, rejection ) ) {
        return make_game_error_result( state, {
            "expansion_rejected", rejection
        } );
    }
    const game_handle current_camp = make_camp_handle( *camp, runtime, world_generation );
    sol::table value = snapshot_camp_expansion(
                           state, *camp, expansion, current_camp, runtime, world_generation );
    value["created"] = true;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table list_camp_expansions(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const sol::optional<sol::table> &requested,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    const camp_page_options options = read_camp_page_options(
                                          requested, "services.camps.expansions.list",
                                          default_limit, maximum_limit );
    std::optional<game_handle_error> error;
    basecamp *camp = resolve_camp( camp_handle, runtime, world_generation, error );
    if( camp == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( resolve_manager( *camp, manager_handle, runtime, world_generation, error ) == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::vector<basecamp_platform_expansion> expansions =
        camp->platform_expansion_snapshot();
    const std::size_t begin = std::min( options.offset, expansions.size() );
    const std::size_t end = std::min(
                                expansions.size(), begin + static_cast<std::size_t>( options.limit ) );
    const game_handle current_camp = make_camp_handle( *camp, runtime, world_generation );
    sol::table entries = state.create_table();
    int returned = 0;
    for( std::size_t index = begin; index < end; ++index ) {
        entries[++returned] = snapshot_camp_expansion(
                                  state, *camp, expansions[index], current_camp,
                                  runtime, world_generation );
    }
    sol::table value = state.create_table();
    value["camp"] = current_camp;
    value["items"] = std::move( entries );
    value["total"] = static_cast<std::int64_t>( expansions.size() );
    value["offset"] = static_cast<std::int64_t>( options.offset );
    value["limit"] = options.limit;
    value["returned"] = returned;
    value["complete"] = end == expansions.size();
    value["truncated"] = end < expansions.size();
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

sol::table get_camp_expansion(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const camp_expansion_token &token,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    basecamp *camp = nullptr;
    basecamp_platform_expansion expansion;
    if( const std::optional<game_handle_error> error = resolve_camp_expansion(
                token, camp_handle, manager_handle, runtime, world_generation, camp, expansion ) ) {
        return make_game_error_result( state, *error );
    }
    const game_handle current_camp = make_camp_handle( *camp, runtime, world_generation );
    return make_game_value_result( state, sol::make_object( state,
                                   snapshot_camp_expansion( state, *camp, expansion,
                                           current_camp, runtime, world_generation ) ) );
}

sol::table remove_camp_expansion(
    sol::this_state lua, const game_handle &camp_handle,
    const game_handle &manager_handle, const camp_expansion_token &token,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    basecamp *camp = nullptr;
    basecamp_platform_expansion expansion;
    if( const std::optional<game_handle_error> error = resolve_camp_expansion(
                token, camp_handle, manager_handle, runtime, world_generation, camp, expansion ) ) {
        return make_game_error_result( state, *error );
    }
    std::string rejection;
    if( !camp->platform_remove_expansion(
            token.expansion_id(), token.identity_generation(), rejection ) ) {
        return make_game_error_result( state, {
            "expansion_rejected", rejection
        } );
    }
    sol::table value = state.create_table();
    value["removed"] = true;
    value["expansion_id"] = expansion.expansion_id;
    value["identity_generation"] = expansion.identity_generation;
    value["camp"] = camp_handle;
    return make_game_value_result( state, sol::make_object( state, std::move( value ) ) );
}

} // namespace

void install_camp_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    lua.new_usertype<camp_task_token>(
        "CampTaskToken", sol::no_constructor,
        "task_id", sol::property( &camp_task_token::task_id ),
        "identity_generation", sol::property( &camp_task_token::identity_generation ),
        "runtime_generation", sol::property( &camp_task_token::runtime_generation ),
        "world_generation", sol::property( &camp_task_token::world_generation ),
        "camp_stable_id", sol::property( &camp_task_token::camp_stable_id ),
        "camp_identity_generation",
        sol::property( &camp_task_token::camp_identity_generation ),
        "manager_stable_id", sol::property( &camp_task_token::manager_stable_id ),
        "worker_stable_id", sol::property( &camp_task_token::worker_stable_id ),
        "manager_identity_generation",
        sol::property( &camp_task_token::manager_identity_generation ),
        "worker_identity_generation",
        sol::property( &camp_task_token::worker_identity_generation ),
        "is_valid",
        [current_runtime_generation, current_world_generation, require_read](
    const camp_task_token & token ) {
        require_read();
        resolved_platform_task resolved;
        return !resolve_platform_task(
                   token, token.camp_handle(), token.manager_handle(),
                   token.worker_handle(), current_runtime_generation(),
                   current_world_generation(), resolved );
    },
    sol::meta_function::to_string,
    &camp_task_token::to_string,
    sol::meta_function::equal_to,
    []( const camp_task_token & lhs, const camp_task_token & rhs ) {
        return lhs == rhs;
    } );
    lua.new_usertype<camp_expansion_token>(
        "CampExpansionToken", sol::no_constructor,
        "expansion_id", sol::property( &camp_expansion_token::expansion_id ),
        "identity_generation",
        sol::property( &camp_expansion_token::identity_generation ),
        "runtime_generation",
        sol::property( &camp_expansion_token::runtime_generation ),
        "world_generation",
        sol::property( &camp_expansion_token::world_generation ),
        "camp_stable_id",
        sol::property( &camp_expansion_token::camp_stable_id ),
        "camp_identity_generation",
        sol::property( &camp_expansion_token::camp_identity_generation ),
        "owner_faction",
        sol::property( &camp_expansion_token::owner_faction ),
        "is_valid",
        [current_runtime_generation, current_world_generation, require_read](
    const camp_expansion_token & token ) {
        require_read();
        std::optional<game_handle_error> error;
        if( !token.belongs_to( current_runtime_generation() ) ||
            token.world_generation() != current_world_generation() ) {
            return false;
        }
        basecamp *camp = resolve_camp( token.camp_handle(),
                                       current_runtime_generation(),
                                       current_world_generation(), error );
        if( camp == nullptr || token.owner_faction() != camp->get_owner().str() ) {
            return false;
        }
        basecamp_platform_expansion expansion;
        std::string rejection;
        return camp->platform_get_expansion(
                   token.expansion_id(), token.identity_generation(), expansion, rejection );
    },
    sol::meta_function::to_string,
    &camp_expansion_token::to_string,
    sol::meta_function::equal_to,
    []( const camp_expansion_token & lhs, const camp_expansion_token & rhs ) {
        return lhs == rhs;
    } );
    sol::table camps = lua.create_table();
    camps.set_function( "create",
                        [current_runtime_generation, current_world_generation, require_write](
                            sol::this_state state, const script_game_id & owner,
                            const game_handle & manager, const script_tripoint_coord & position,
    const std::string & name, const sol::optional<sol::table> &options ) {
        require_write();
        return create_camp( state, owner, manager, position, name, options,
                            current_runtime_generation(), current_world_generation() );
    } );
    camps.set_function( "remove",
                        [current_runtime_generation, current_world_generation, require_write](
    sol::this_state state, const game_handle & camp, const game_handle & manager ) {
        require_write();
        return remove_camp( state, camp, manager, current_runtime_generation(),
                            current_world_generation() );
    } );
    camps.set_function( "list",
                        [current_runtime_generation, current_world_generation, require_read](
                            sol::this_state state, const script_tripoint_coord & center,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_camps( state, center, options, current_runtime_generation(),
                           current_world_generation() );
    } );
    camps.set_function( "get",
                        [current_runtime_generation, current_world_generation, require_read](
    sol::this_state state, const game_handle & camp, const game_handle & manager ) {
        require_read();
        return get_camp( state, camp, manager, current_runtime_generation(),
                         current_world_generation() );
    } );
    camps.set_function( "rename",
                        [current_runtime_generation, current_world_generation, require_write](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const std::string & name ) {
        require_write();
        return rename_camp( state, camp, manager, name, current_runtime_generation(),
                            current_world_generation() );
    } );
    camps.set_function( "set_owner",
                        [current_runtime_generation, current_world_generation, require_write](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const script_game_id & owner ) {
        require_write();
        return set_owner( state, camp, manager, owner, current_runtime_generation(),
                          current_world_generation() );
    } );
    camps.set_function( "set_board_position",
                        [current_runtime_generation, current_world_generation, require_write](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const script_tripoint_coord & position ) {
        require_write();
        return set_board_position( state, camp, manager, position,
                                   current_runtime_generation(), current_world_generation() );
    } );
    camps.set_function( "assign_worker",
                        [current_runtime_generation, current_world_generation, require_write](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker ) {
        require_write();
        return mutate_worker( state, camp, manager, worker, true,
                              current_runtime_generation(), current_world_generation() );
    } );
    camps.set_function( "recall_worker",
                        [current_runtime_generation, current_world_generation, require_write](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker ) {
        require_write();
        return mutate_worker( state, camp, manager, worker, false,
                              current_runtime_generation(), current_world_generation() );
    } );

    sol::table expansions = lua.create_table();
    expansions.set_function( "create",
                             [current_runtime_generation, current_world_generation, require_write](
                                 sol::this_state state, const game_handle & camp, const game_handle & manager,
                                 const script_tripoint_coord & position, const std::string & type,
    const std::string & name ) {
        require_write();
        return create_camp_expansion(
                   state, camp, manager, position, type, name,
                   current_runtime_generation(), current_world_generation() );
    } );
    expansions.set_function( "list",
                             [current_runtime_generation, current_world_generation, require_read](
                                 sol::this_state state, const game_handle & camp, const game_handle & manager,
    const sol::optional<sol::table> &options ) {
        require_read();
        return list_camp_expansions(
                   state, camp, manager, options, current_runtime_generation(),
                   current_world_generation() );
    } );
    expansions.set_function( "get",
                             [current_runtime_generation, current_world_generation, require_read](
                                 sol::this_state state, const game_handle & camp, const game_handle & manager,
    const camp_expansion_token & token ) {
        require_read();
        return get_camp_expansion(
                   state, camp, manager, token, current_runtime_generation(),
                   current_world_generation() );
    } );
    expansions.set_function( "remove",
                             [current_runtime_generation, current_world_generation, require_write](
                                 sol::this_state state, const game_handle & camp, const game_handle & manager,
    const camp_expansion_token & token ) {
        require_write();
        return remove_camp_expansion(
                   state, camp, manager, token, current_runtime_generation(),
                   current_world_generation() );
    } );

    struct camp_task_api_callbacks {
        std::function<game_handle_runtime()> runtime_generation;
        std::function<std::size_t()> world_generation;
        std::function<void()> read;
        std::function<void()> write;
    };
    const auto task_callbacks = std::make_shared<const camp_task_api_callbacks>(
    camp_task_api_callbacks{
        current_runtime_generation,
        current_world_generation,
        require_read,
        require_write
    } );

    sol::table tasks = lua.create_table();
    tasks.set_function( "create",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
                            const game_handle & worker, const std::string & kind,
    const sol::optional<sol::table> &descriptor ) {
        task_callbacks->write();
        return create_platform_task(
                   state, camp, manager, worker, kind, descriptor,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "page",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker, const sol::optional<sol::table> &options ) {
        task_callbacks->read();
        return page_platform_tasks(
                   state, camp, manager, worker, options,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "get",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker, const camp_task_token & token ) {
        task_callbacks->read();
        return get_platform_task(
                   state, camp, manager, worker, token,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "resolve",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
                            const game_handle & worker, const camp_task_token & token,
    const sol::optional<sol::table> &destination_holder ) {
        if( destination_holder ) {
            task_callbacks->write();
        } else {
            task_callbacks->read();
        }
        return resolve_recipe_escrow(
                   state, camp, manager, worker, token, destination_holder, false,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "claim",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
                            const game_handle & worker, const camp_task_token & token,
    const sol::optional<sol::table> &destination_holder ) {
        task_callbacks->write();
        return resolve_recipe_escrow(
                   state, camp, manager, worker, token, destination_holder, true,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "retry",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
                            const game_handle & worker, const camp_task_token & token,
    const sol::optional<sol::table> &destination_holder ) {
        task_callbacks->write();
        return resolve_recipe_escrow(
                   state, camp, manager, worker, token, destination_holder, true,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "start",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
                            const game_handle & worker, const camp_task_token & token,
                            const sol::optional<sol::object> &requested_items_or_duration,
    const sol::optional<std::int64_t> &duration_turns ) {
        task_callbacks->write();
        return start_platform_task(
                   state, camp, manager, worker, token,
                   requested_items_or_duration, duration_turns,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "cancel",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker, const camp_task_token & token ) {
        task_callbacks->write();
        return finish_platform_task(
                   state, camp, manager, worker, token, false,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "recall",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker, const camp_task_token & token ) {
        task_callbacks->write();
        return finish_platform_task(
                   state, camp, manager, worker, token, false,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );
    tasks.set_function( "complete",
                        [task_callbacks](
                            sol::this_state state, const game_handle & camp, const game_handle & manager,
    const game_handle & worker, const camp_task_token & token ) {
        task_callbacks->write();
        return finish_platform_task(
                   state, camp, manager, worker, token, true,
                   task_callbacks->runtime_generation(),
                   task_callbacks->world_generation() );
    } );

    sol::table resources = lua.create_table();
    resources.set_function( "snapshot",
                            [current_runtime_generation, current_world_generation, require_read](
                                sol::this_state state, const game_handle & camp, const game_handle & manager,
    const sol::optional<sol::table> &options ) {
        require_read();
        return camp_resources_snapshot( state, camp, manager, options,
                                        current_runtime_generation(),
                                        current_world_generation() );
    } );
    resources.set_function( "adjust",
                            [current_runtime_generation, current_world_generation, require_write](
                                sol::this_state state, const game_handle & camp, const game_handle & manager,
    const sol::table & requested ) {
        require_write();
        return adjust_camp_resources(
                   state, camp, manager, read_resource_changes( requested ),
                   current_runtime_generation(), current_world_generation() );
    } );
    resources.set_function( "add",
                            [current_runtime_generation, current_world_generation, require_write](
                                sol::this_state state, const game_handle & camp, const game_handle & manager,
    const script_game_id & resource_id, const std::int64_t amount ) {
        require_write();
        if( resource_id.kind() != "item" || !resource_id.is_valid() ) {
            throw std::invalid_argument(
                "services.camps.resources.add requires GameId<item>" );
        }
        if( amount <= 0 || amount > maximum_platform_food_kcal ) {
            throw std::invalid_argument(
                "services.camps.resources.add amount is outside its bound" );
        }
        return adjust_camp_resources(
                   state, camp, manager,
        { { itype_id( resource_id.value() ), amount } },
        current_runtime_generation(), current_world_generation() );
    } );
    resources.set_function( "consume",
                            [current_runtime_generation, current_world_generation, require_write](
                                sol::this_state state, const game_handle & camp, const game_handle & manager,
    const script_game_id & resource_id, const std::int64_t amount ) {
        require_write();
        if( resource_id.kind() != "item" || !resource_id.is_valid() ) {
            throw std::invalid_argument(
                "services.camps.resources.consume requires GameId<item>" );
        }
        if( amount <= 0 || amount > maximum_platform_food_kcal ) {
            throw std::invalid_argument(
                "services.camps.resources.consume amount is outside its bound" );
        }
        return adjust_camp_resources(
                   state, camp, manager,
        { { itype_id( resource_id.value() ), -amount } },
        current_runtime_generation(), current_world_generation() );
    } );

    sol::table food = lua.create_table();
    food.set_function( "add",
                       [current_runtime_generation, current_world_generation, require_write](
                           sol::this_state state, const game_handle & camp, const game_handle & manager,
    const std::int64_t kcal ) {
        require_write();
        return adjust_camp_food( state, camp, manager, kcal, true,
                                 current_runtime_generation(),
                                 current_world_generation() );
    } );
    food.set_function( "consume",
                       [current_runtime_generation, current_world_generation, require_write](
                           sol::this_state state, const game_handle & camp, const game_handle & manager,
    const std::int64_t kcal ) {
        require_write();
        return adjust_camp_food( state, camp, manager, kcal, false,
                                 current_runtime_generation(),
                                 current_world_generation() );
    } );

    sol::table inventory = lua.create_table();
    inventory.set_function( "storage_tiles",
                            [current_runtime_generation, current_world_generation, require_read](
                                sol::this_state state, const game_handle & camp, const game_handle & manager,
    const sol::optional<sol::table> &options ) {
        require_read();
        return camp_storage_tiles( state, camp, manager, options,
                                   current_runtime_generation(),
                                   current_world_generation() );
    } );

    camps["resources"] = std::move( resources );
    camps["food"] = std::move( food );
    camps["inventory"] = std::move( inventory );
    camps["tasks"] = std::move( tasks );
    camps["expansions"] = std::move( expansions );
    services["camps"] = std::move( camps );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
