#include <build_reqs.h>
#include <character_id.h>
#include <debug.h>
#include <dialogue.h>
#include <dialogue_chatbin.h>
#include <enums.h>
#include <item_location.h>
#include <item_uid.h>
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
extern "C" {
#include <lua.h>
}
#endif
#include <map_iterator.h>
#include <memory_fast.h>
#include <monster_uid.h>
#include <npc_opinion.h>
#include <overmap.h>
#include <overmap_ui.h>
#include <pimpl.h>
#include <player_activity.h>
#include <plf/list.h>
#include <pocket_type.h>
#include <point.h>
#include <recipe.h>
#include <ret_val.h>
#include <stomach.h>
#include <type_id.h>
#include <units.h>
#include <vehicle_uid.h>
#include <visitable.h>
#include <vpart_position.h>
#include <weather.h>
#include <weather_gen.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <functional>
#include <initializer_list>
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
#include <system_error>
#include <type_traits>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "basecamp.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "clzones.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "faction.h"
#include "field_type.h"
// IWYU pragma: no_include <flexbuffer_json.h>
#include "flexbuffer_json.h"
#include "game.h"
#include "inventory.h"
#include "item.h"
#include "item_category.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_bindings_enums.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_camps.h"
#include "lua_platform_content.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_factions.h"
#include "lua_platform_handle.h"
#include "lua_platform_hooks.h"
#include "lua_platform_hordes.h"
#include "lua_platform_identity.h"
#include "lua_platform_items.h"
#include "lua_platform_loader.h"
#include "lua_platform_mapgen.h"
#include "lua_platform_missions.h"
#include "lua_platform_npcs.h"
#include "lua_platform_overmap.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "lua_platform_trade.h"
#include "lua_platform_vehicles.h"
#include "lua_platform_weather.h"
#include "lua_platform_world.h"
#include "lua_platform_world_content.h"
#include "lua_platform_world_services.h"
#include "lua_platform_zones.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "mapbuffer.h"
#include "mapgen_functions.h"
#include "mapgendata.h"
#include "mission.h"
#include "monster.h"
#include "npc.h"
#include "npctalk.h"
#include "npctrade.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "submap.h"
#include "talker.h"
#include "talker_monster.h"
#include "talker_npc.h"
#include "talker_topic.h"
#include "veh_type.h"
#include "vehicle.h"

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform

namespace
{

static const vproto_id vehicle_prototype_test_shopping_cart( "test_shopping_cart" );

struct registrar_graph_entry {
    std::string id;
    std::string copy_from;
};

template<typename Type, typename = void>
struct has_legacy_dialogue_quote_trade_item : std::false_type {
};

template<typename Type>
struct has_legacy_dialogue_quote_trade_item<Type, std::void_t<
decltype( &Type::quote_trade_item )>> : std::true_type {
};

template<typename Type, typename = void>
struct has_legacy_dialogue_buy_quoted_item : std::false_type {
};

template<typename Type>
struct has_legacy_dialogue_buy_quoted_item<Type, std::void_t<
decltype( &Type::buy_quoted_item )>> : std::true_type {
};

} // namespace

TEST_CASE( "lua_platform_exposes_one_runtime_contract", "[lua][platform]" )
{
    CHECK( cata::lua_platform::platform_version == 1 );
    CHECK( cata::lua_platform::loaded_mod_ids().empty() );
}
TEST_CASE( "lua_platform_shutdown_is_idempotent", "[lua][platform]" )
{
    cata::lua_platform::shutdown();
    cata::lua_platform::shutdown();
    CHECK( cata::lua_platform::loaded_mod_ids().empty() );
}

TEST_CASE( "lua_platform_registrar_orders_forward_inheritance_deterministically",
           "[lua][platform][content]" )
{
    const std::vector<registrar_graph_entry> entries = {
        { "child", "parent" },
        { "sibling", "" },
        { "parent", "native_parent" },
    };
    std::vector<std::size_t> order;
    std::string error;
    const bool resolved = cata::lua_platform::detail::resolve_platform_inheritance_order(
                              entries,
    []( const registrar_graph_entry & entry ) {
        return entry.id;
    },
    []( const registrar_graph_entry & entry ) {
        return entry.copy_from;
    },
    []( const std::string & id ) {
        return id == "native_parent";
    },
    order, error, "test definition" );

    REQUIRE( resolved );
    CHECK( error.empty() );
    REQUIRE( order.size() == entries.size() );
    CHECK( order[0] == 2 );
    CHECK( order[1] == 0 );
    CHECK( order[2] == 1 );
}

TEST_CASE( "lua_platform_registrar_rejects_inheritance_cycles",
           "[lua][platform][content]" )
{
    const std::vector<registrar_graph_entry> entries = {
        { "first", "second" },
        { "second", "first" },
    };
    std::vector<std::size_t> order;
    std::string error;

    CHECK_FALSE( cata::lua_platform::detail::resolve_platform_inheritance_order(
                     entries,
    []( const registrar_graph_entry & entry ) {
        return entry.id;
    },
    []( const registrar_graph_entry & entry ) {
        return entry.copy_from;
    },
    []( const std::string & ) {
        return false;
    },
    order, error, "test definition" ) );
    CHECK( order.empty() );
    CHECK( error.find( "cycle" ) != std::string::npos );
}

TEST_CASE( "lua_platform_registrar_applies_typed_extend_delete_atomically",
           "[lua][platform][content]" )
{
    std::set<std::string> target = { "base" };
    const std::set<std::string> extend = { "added" };
    const std::set<std::string> remove = { "base" };
    std::string error;

    REQUIRE( cata::lua_platform::detail::apply_platform_collection_patch(
                 target, &extend, &remove,
    []( const std::string & value ) {
        return value;
    },
    "test flags", error ) );
    CHECK( target == std::set<std::string> { "added" } );

    const std::set<std::string> conflicting = { "added" };
    CHECK_FALSE( cata::lua_platform::detail::apply_platform_collection_patch(
                     target, &conflicting,
                     static_cast<const std::set<std::string> *>( nullptr ),
    []( const std::string & value ) {
        return value;
    },
    "test flags", error ) );
    CHECK( error.find( "conflicts" ) != std::string::npos );
}
