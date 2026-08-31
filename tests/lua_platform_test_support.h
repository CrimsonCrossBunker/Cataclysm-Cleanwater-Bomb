#pragma once
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


struct platform_lua_test_directory {
    platform_lua_test_directory() {
        const std::filesystem::path temporary_root = std::filesystem::temp_directory_path();
        for( std::size_t attempt = 0; attempt < 100; ++attempt ) {
            const std::filesystem::path candidate = temporary_root /
                                                    ( "cata-lua-platform-loader-" + std::to_string( attempt ) );
            std::error_code filesystem_error;
            if( std::filesystem::create_directory( candidate, filesystem_error ) ) {
                root = candidate;
                return;
            }
            if( filesystem_error && filesystem_error != std::errc::file_exists ) {
                throw std::runtime_error( "Cannot create Lua Platform test directory: " +
                                          filesystem_error.message() );
            }
        }
        throw std::runtime_error( "Cannot reserve a Lua Platform test directory" );
    }

    ~platform_lua_test_directory() {
        if( root.empty() ) {
            return;
        }
        std::error_code filesystem_error;
        std::filesystem::remove_all( root, filesystem_error );
    }

    void write( const std::filesystem::path &relative, const std::string &contents ) const {
        const std::filesystem::path destination = root / relative;
        std::error_code filesystem_error;
        if( !destination.parent_path().empty() &&
            !std::filesystem::create_directories( destination.parent_path(), filesystem_error ) &&
            filesystem_error ) {
            throw std::runtime_error( "Cannot create Lua Platform test file directory: " +
                                      filesystem_error.message() );
        }
        std::ofstream output( destination, std::ios::binary );
        if( !output ) {
            throw std::runtime_error( "Cannot write Lua Platform test file '" +
                                      destination.generic_u8string() + "'" );
        }
        output << contents;
    }

    std::filesystem::path root;
};

const char *const platform_loader_policy_probe = R"lua(
local ccb = require("ccb")

for _, name in ipairs({ "assert", "error", "pcall", "pairs", "require" }) do
    if type(_G[name]) ~= "function" then
        error("missing allowed base function " .. name)
    end
end
for _, name in ipairs({ "math", "string", "table", "utf8", "coroutine" }) do
    if type(_G[name]) ~= "table" then
        error("missing allowed library " .. name)
    end
end
for _, name in ipairs({ "io", "os", "debug", "dofile", "loadfile", "load", "loadstring", "collectgarbage" }) do
    if _G[name] ~= nil then
        error("forbidden global is exposed: " .. name)
    end
end

if type(package) ~= "table" or type(package.loaded) ~= "table" then
    error("controlled package.loaded state is missing")
end
if package.loaded["ccb"] ~= ccb then
    error("package.loaded[ccb] does not contain the Platform root")
end
package.loaded["../outside"] = { value = "spoofed" }
local unsafe_ok = pcall(require, "../outside")
if unsafe_ok then
    error("unsafe module name bypassed validation through package.loaded")
end
package.loaded["../outside"] = nil
package.loaded["ccb"] = { value = "spoofed" }
if require("ccb") ~= ccb then
    error("require[ccb] did not return the original Platform root")
end
package.loaded["ccb"] = ccb
for _, name in ipairs({ "config", "cpath", "loadlib", "path", "preload", "searchers", "searchpath" }) do
    if package[name] ~= nil then
        error("forbidden package field is exposed: " .. name)
    end
end
for name in pairs(package) do
    if name ~= "loaded" then
        error("unexpected package field is exposed: " .. name)
    end
end

local foo = require("foo")
if foo.value ~= "foo" or require("foo") ~= foo then
    error("root-local foo.lua require was not cached")
end
local nested = require("nested")
if nested.value ~= "nested" then
    error("root-local nested/init.lua require failed")
end
local first_ok = pcall(require, "broken")
if first_ok or package.loaded["broken"] ~= nil then
    error("failed module was not rolled back")
end
local second_ok = pcall(require, "broken")
if second_ok or package.loaded["broken"] ~= nil then
    error("failed module was not retryable after rollback")
end
)lua";

struct platform_test_camp_scope {
    explicit platform_test_camp_scope( const std::string &name,
                                       const tripoint_abs_omt &position,
                                       const faction_id &owner ) : position( position ) {
        basecamp seed( name, position );
        seed.set_owner( owner );
        overmap_buffer.add_camp( seed );
        if( const std::optional<basecamp *> found = overmap_buffer.find_camp( position.xy() ) ) {
            camp = *found;
        }
    }

    ~platform_test_camp_scope() {
        if( camp != nullptr ) {
            overmap_buffer.get( project_to<coords::om>( position.xy() ) ).remove_camp( position.xy() );
        }
    }

    tripoint_abs_omt position;
    basecamp *camp = nullptr;
};

npc_ptr make_platform_test_npc( const character_id id, const faction_id &owner,
                                const tripoint_abs_omt &position )
{
    npc_ptr result = make_shared_fast<npc>();
    result->normalize();
    result->setID( id, true );
    result->set_fac( owner );
    result->spawn_at_omt( position );
    return result;
}

struct platform_npc_dialogue_fixture {
    platform_npc_dialogue_fixture() :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        other_runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, 71 ),
        other_runtime( other_runtime_owner, 71 ),
        newer_runtime( runtime_owner, 72 ),
        active_runtime( runtime ),
        services( lua.create_table() ) {
        target.normalize();
        target.setID( character_id( 1271 ), true );
        speaker.normalize();
        speaker.setID( character_id( 1272 ), true );
        target_handle = cata::lua_platform::game_handle::from_creature(
                            target, { "npc", 1271, 0, 0, 0, {} },
                            runtime, active_world );
        speaker_handle = cata::lua_platform::game_handle::from_creature(
                             speaker, { "avatar", 1272, 0, 0, 0, {} },
                             runtime, active_world );
        cata::lua_platform::install_game_handle_api(
            lua, services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world;
        }, []() {} );
        cata::lua_platform::install_npc_api(
            services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world;
        }, []() {},
        [this]() {
            write_called = true;
        },
        [this]() {
            handles_invalidated = true;
        } );
    }

    sol::protected_function open_dialogue() const {
        const sol::table npcs = services["npcs"];
        return npcs["open_dialogue"];
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner>
    runtime_owner;
    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner>
    other_runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime other_runtime;
    cata::lua_platform::game_handle_runtime newer_runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world = 17;
    npc target;
    avatar speaker;
    sol::state lua;
    sol::table services;
    cata::lua_platform::game_handle target_handle;
    cata::lua_platform::game_handle speaker_handle;
    bool write_called = false;
    bool handles_invalidated = false;
};

struct platform_registered_dialogue_call_fixture {
    platform_registered_dialogue_call_fixture(
        const cata::lua_platform::game_handle_runtime &runtime_identity,
        const std::size_t world_generation,
        const int first_character_id ) :
        runtime( runtime_identity ), active_runtime( runtime_identity ),
        active_world( world_generation ), services( lua.create_table() ) {
        target.normalize();
        target.setID( character_id( first_character_id ), true );
        target.set_attitude( NPCATT_KILL );
        speaker.normalize();
        speaker.setID( character_id( first_character_id + 1 ), true );
        target_handle = cata::lua_platform::game_handle::from_creature(
                            target, { "npc", first_character_id, 0, 0, 0, {} },
                            runtime, active_world );
        speaker_handle = cata::lua_platform::game_handle::from_creature(
                             speaker, {
            "avatar", first_character_id + 1, 0, 0, 0, {}
        }, runtime, active_world );
        cata::lua_platform::install_game_handle_api(
            lua, services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world;
        }, []() {} );
        cata::lua_platform::install_npc_api(
            services,
        [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world;
        }, []() {}, []() {}, []() {} );
    }

    sol::protected_function open_dialogue() const {
        const sol::table npcs = services["npcs"];
        return npcs["open_dialogue"];
    }

    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world;
    npc target;
    avatar speaker;
    sol::state lua;
    sol::table services;
    cata::lua_platform::game_handle target_handle;
    cata::lua_platform::game_handle speaker_handle;
};

basecamp_platform_task make_platform_test_task( const basecamp &camp,
        const faction_id &owner, const character_id manager, const npc &worker )
{
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner;
    task.manager = manager;
    task.manager_identity_generation = 0;
    task.worker = worker.getID();
    task.worker_identity_generation = worker.platform_identity_generation();
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    return task;
}

[[maybe_unused]] basecamp_platform_task make_platform_resource_work_test_task(
    const basecamp &camp, const faction_id &owner, const character_id manager,
    const npc &worker, const basecamp_platform_resource_work &work )
{
    basecamp_platform_task task = make_platform_test_task( camp, owner, manager, worker );
    task.kind = std::string( basecamp_platform_resource_work_kind );
    task.parameters = std::string( basecamp_platform_resource_work_parameter_schema );
    task.resource_work = work;
    return task;
}

basecamp_platform_recipe_holder make_platform_recipe_holder(
    const character_id character, const std::uint64_t generation,
    const std::string &slot = "inventory" )
{
    basecamp_platform_recipe_holder holder;
    holder.kind = basecamp_platform_recipe_holder_kind::character;
    holder.character = character;
    holder.identity_generation = generation;
    holder.slot = slot;
    return holder;
}

std::string serialize_platform_recipe_test_item( const item &value )
{
    std::ostringstream serialized;
    JsonOut json( serialized );
    value.serialize( json );
    return serialized.str();
}

basecamp_platform_recipe_escrow_item make_platform_recipe_escrow_test_item(
    const item &value, const basecamp_platform_recipe_holder &source_holder,
    const bool tool = false )
{
    basecamp_platform_recipe_escrow_item result;
    result.stable_uid = value.uid().get_value();
    result.identity_generation = 1;
    result.charges = value.count_by_charges() ? value.charges : 1;
    result.tool = tool;
    result.serialized_item = serialize_platform_recipe_test_item( value );
    result.source_holder = source_holder;
    return result;
}

basecamp_platform_task make_platform_recipe_work_test_task(
    const basecamp &camp, const faction_id &owner, const character_id manager,
    const npc &worker, const std::string &recipe_name = "tinder",
    const std::int64_t duration_turns = 1 )
{
    basecamp_platform_task task = make_platform_test_task( camp, owner, manager, worker );
    task.kind = std::string( basecamp_platform_recipe_work_kind );
    task.parameters = std::string( basecamp_platform_recipe_work_parameter_schema );
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                worker.getID(), worker.platform_identity_generation() );
    basecamp_platform_recipe_work work;
    work.recipe_id = recipe_name;
    work.batch = 1;
    work.duration_turns = duration_turns;
    work.source_holders = { holder };
    work.destination_holder = holder;
    task.recipe_work = work;
    return task;
}

[[maybe_unused]] sol::table make_platform_recipe_holder_table( sol::state &lua,
        const cata::lua_platform::game_handle &character,
        const std::string &slot = "inventory" )
{
    sol::table holder = lua.create_table();
    holder["kind"] = "character";
    holder["character"] = character;
    holder["slot"] = slot;
    return holder;
}

struct platform_recipe_task_fixture {
    explicit platform_recipe_task_fixture( const std::string &name,
                                           const tripoint_abs_omt &position,
                                           const character_id worker_id ) :
        owner( "your_followers" ),
        camp( name, position ),
        worker( make_platform_test_npc( worker_id, owner, position ) ) {
        camp.set_owner( owner );
        worker->set_skill_level( skill_id( "survival" ), 10 );
        const recipe &making = recipe_id( "tinder" ).obj();
        worker->learn_recipe( &making, true );
        holder = make_platform_recipe_holder(
                     worker->getID(), worker->platform_identity_generation() );
        work.recipe_id = "tinder";
        work.batch = 1;
        work.duration_turns = to_turns<std::int64_t>(
                                  making.batch_duration( *worker,
                                          crafting_cost_context::for_recipe( *worker, making ), 1 ) );
        work.source_holders = { holder };
        work.destination_holder = holder;
        task = make_platform_recipe_work_test_task(
                   camp, owner, get_avatar().getID(), *worker, work.recipe_id,
                   work.duration_turns );
        item component( itype_id( "stick" ), calendar::turn_zero );
        escrow.push_back( make_platform_recipe_escrow_test_item( component, holder ) );
        item tool( itype_id( "knife_combat" ), calendar::turn_zero );
        escrow.push_back( make_platform_recipe_escrow_test_item( tool, holder, true ) );
    }

    bool start() {
        if( !camp.platform_create_task( task, error ) ) {
            return false;
        }
        return camp.platform_start_task(
                   task.task_id, task.identity_generation, worker,
                   calendar::turn_zero,
                   time_duration::from_turns( work.duration_turns ), escrow, error );
    }

    faction_id owner;
    basecamp camp;
    npc_ptr worker;
    basecamp_platform_recipe_holder holder;
    basecamp_platform_recipe_work work;
    basecamp_platform_task task;
    std::vector<basecamp_platform_recipe_escrow_item> escrow;
    std::string error;
};

using platform_food_storage = std::remove_reference_t<
    decltype( std::declval<faction &>().debug_food_supply() )>;

struct platform_food_state_scope {
    explicit platform_food_state_scope( faction &owner ) : owner( owner ),
        saved( owner.debug_food_supply() ), consumes_food( owner.consumes_food ) {}

    ~platform_food_state_scope() {
        owner.debug_food_supply() = saved;
        owner.consumes_food = consumes_food;
    }

    faction &owner;
    platform_food_storage saved;
    bool consumes_food;
};

struct platform_trade_quote_fixture {
    platform_trade_quote_fixture( const std::size_t runtime_number,
                                  const std::size_t world_number,
                                  const int seller_number,
                                  const int buyer_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ),
        buyer( make_platform_test_npc(
                   character_id( buyer_number ), faction_id( "your_followers" ),
                   tripoint_abs_omt{ 220, 220, 0 } ) ) {
        seller.normalize();
        seller.setID( character_id( seller_number ), true );
        buyer->cash = std::numeric_limits<int>::max();
        cata::lua_platform::register_npc_handle_identity( *buyer );

        item charge_stack( itype_id( "9mm" ), calendar::turn_zero );
        charge_stack.charges = 8;
        live_item = &seller.inv->add_item(
                         std::move( charge_stack ), false, false, false );

        seller_handle = cata::lua_platform::game_handle::from_creature(
                            seller,
                            { "avatar", seller.getID().get_value(), 0, 0, 0, {} },
                            runtime, active_world_generation );
        buyer_handle = cata::lua_platform::game_handle::from_creature(
                           *buyer,
                           { "npc", buyer->getID().get_value(), 0, 0, 0, {} },
                           runtime, active_world_generation );
        item_handle = cata::lua_platform::game_handle::from_item(
                          *live_item,
                          { "character_inventory", live_item->uid().get_value(), 0, 0, 0, {} },
                          runtime, active_world_generation );

        services = lua.create_table();
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_trade_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {}, []() {} );
    }

    ~platform_trade_quote_fixture() {
        cata::lua_platform::retire_trade_quote_registry();
        if( buyer ) {
            cata::lua_platform::retire_npc_handle_identity( *buyer );
        }
    }

    bool ready() const {
        return live_item != nullptr && services.valid();
    }

    sol::table holder( const cata::lua_platform::game_handle &character,
                       const std::string &slot = "inventory" ) {
        sol::table result = lua.create_table();
        result["kind"] = "character";
        result["character"] = character;
        result["slot"] = slot;
        return result;
    }

    sol::table line( const std::string &direction, const std::int64_t quantity,
                     const cata::lua_platform::game_handle &item_value,
                     const cata::lua_platform::game_handle &source,
                     const cata::lua_platform::game_handle &destination ) {
        sol::table result = lua.create_table();
        result["direction"] = direction;
        result["item"] = item_value;
        result["quantity"] = quantity;
        result["source_holder"] = holder( source );
        result["destination_holder"] = holder( destination );
        return result;
    }

    sol::table lines( const std::int64_t quantity,
                      const std::string &direction = "seller_to_buyer",
                      const cata::lua_platform::game_handle &item_value =
                          cata::lua_platform::game_handle{} ) {
        sol::table result = lua.create_table();
        result[1] = line( direction, quantity,
                          item_value.kind() == cata::lua_platform::game_handle_kind::none ?
                          item_handle : item_value,
                          direction == "seller_to_buyer" ? seller_handle : buyer_handle,
                          direction == "seller_to_buyer" ? buyer_handle : seller_handle );
        return result;
    }

    sol::table options( const std::optional<std::int64_t> &expiry = std::nullopt ) {
        sol::table result = lua.create_table();
        sol::table settlement = lua.create_table();
        settlement["strategy"] = "cash";
        settlement["currency"] = "cash";
        result["settlement"] = std::move( settlement );
        if( expiry ) {
            result["expiry_turns"] = *expiry;
        }
        return result;
    }

    sol::protected_function_result quote( const sol::table &requested_lines,
                                          const sol::table &requested_options ) {
        return quote_participants( seller_handle, buyer_handle, requested_lines,
                                   requested_options );
    }

    sol::protected_function_result quote_participants(
        const cata::lua_platform::game_handle &seller_value,
        const cata::lua_platform::game_handle &buyer_value,
        const sol::table &requested_lines,
        const sol::table &requested_options ) {
        const sol::table trade = services["trade"];
        const sol::protected_function quote_function = trade["quote"];
        return quote_function( seller_value, buyer_value, requested_lines,
                               requested_options );
    }

    sol::protected_function_result quote( const std::int64_t quantity,
                                          const std::optional<std::int64_t> &expiry =
                                              std::nullopt ) {
        return quote( lines( quantity ), options( expiry ) );
    }

    sol::protected_function_result get(
        const cata::lua_platform::trade_quote_token &token ) {
        const sol::table trade = services["trade"];
        const sol::protected_function get_function = trade["get"];
        return get_function( token );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    avatar seller;
    npc_ptr buyer;
    item *live_item = nullptr;
    cata::lua_platform::game_handle seller_handle;
    cata::lua_platform::game_handle buyer_handle;
    cata::lua_platform::game_handle item_handle;
    sol::state lua;
    sol::table services;
};

struct platform_trade_commit_fixture {
    platform_trade_commit_fixture( const std::size_t runtime_number,
                                   const std::size_t world_number,
                                   const int seller_number,
                                   const int buyer_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ),
        buyer( make_platform_test_npc(
                   character_id( buyer_number ), faction_id( "no_faction" ),
                   tripoint_abs_omt{ 230, 230, 0 } ) ) {
        seller.normalize();
        seller.setID( character_id( seller_number ), true );
        buyer->cash = std::numeric_limits<int>::max();
        cata::lua_platform::register_npc_handle_identity( *buyer );

        item seller_stack( itype_id( "9mm" ), calendar::turn_zero );
        seller_stack.charges = 8;
        live_item = &seller.inv->add_item(
                         std::move( seller_stack ), false, false, false );

        item buyer_value( itype_id( "2x4" ), calendar::turn_zero );
        buyer_item = &buyer->inv->add_item(
                          std::move( buyer_value ), false, false, false );

        seller_handle = cata::lua_platform::game_handle::from_creature(
                            seller,
                            { "avatar", seller.getID().get_value(), 0, 0, 0, {} },
                            runtime, active_world_generation );
        buyer_handle = cata::lua_platform::game_handle::from_creature(
                           *buyer,
                           { "npc", buyer->getID().get_value(), 0, 0, 0, {} },
                           runtime, active_world_generation );
        seller_item_handle = cata::lua_platform::game_handle::from_item(
                                 *live_item,
                                 { "avatar_inventory", live_item->uid().get_value(),
                                   0, 0, 0, {} },
                                 runtime, active_world_generation );
        buyer_item_handle = cata::lua_platform::game_handle::from_item(
                                *buyer_item,
                                { "npc_inventory", buyer_item->uid().get_value(),
                                  0, 0, 0, {} },
                                runtime, active_world_generation );

        services = lua.create_table();
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_trade_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {}, []() {} );
    }

    ~platform_trade_commit_fixture() {
        cata::lua_platform::retire_trade_quote_registry();
        if( buyer ) {
            cata::lua_platform::retire_npc_handle_identity( *buyer );
        }
    }

    bool ready() const {
        return live_item != nullptr && buyer_item != nullptr && services.valid();
    }

    sol::table holder( const cata::lua_platform::game_handle &character,
                       const std::string &slot = "inventory" ) {
        sol::table result = lua.create_table();
        result["kind"] = "character";
        result["character"] = character;
        result["slot"] = slot;
        return result;
    }

    sol::table line( const std::string &direction, const std::int64_t quantity,
                     const cata::lua_platform::game_handle &item_value,
                     const cata::lua_platform::game_handle &source,
                     const cata::lua_platform::game_handle &destination ) {
        sol::table result = lua.create_table();
        result["direction"] = direction;
        result["item"] = item_value;
        result["quantity"] = quantity;
        result["source_holder"] = holder( source );
        result["destination_holder"] = holder( destination );
        return result;
    }

    sol::table options() {
        sol::table result = lua.create_table();
        sol::table settlement = lua.create_table();
        settlement["strategy"] = "npc_debt";
        settlement["currency"] = "cash";
        result["settlement"] = std::move( settlement );
        return result;
    }

    sol::table settlement( const std::string &strategy = "npc_debt" ) {
        sol::table result = lua.create_table();
        result["strategy"] = strategy;
        result["currency"] = "cash";
        return result;
    }

    sol::protected_function_result quote( const sol::table &requested_lines ) {
        const sol::table trade = services["trade"];
        const sol::protected_function quote_function = trade["quote"];
        return quote_function( seller_handle, buyer_handle, requested_lines,
                               options() );
    }

    sol::protected_function_result get(
        const cata::lua_platform::trade_quote_token &token ) {
        const sol::table trade = services["trade"];
        const sol::protected_function get_function = trade["get"];
        return get_function( token );
    }

    sol::protected_function_result commit(
        const cata::lua_platform::trade_quote_token &token,
        const std::string &strategy = "npc_debt" ) {
        const sol::table trade = services["trade"];
        const sol::protected_function commit_function = trade["commit"];
        return commit_function( token, settlement( strategy ) );
    }

    item *add_buyer_item( const itype_id &id, const int charges = -1 ) {
        item value( id, calendar::turn_zero );
        if( charges > 0 && value.count_by_charges() ) {
            value.charges = charges;
        }
        return &buyer->inv->add_item(
                   std::move( value ), false, false, false );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    avatar seller;
    npc_ptr buyer;
    item *live_item = nullptr;
    item *buyer_item = nullptr;
    cata::lua_platform::game_handle seller_handle;
    cata::lua_platform::game_handle buyer_handle;
    cata::lua_platform::game_handle seller_item_handle;
    cata::lua_platform::game_handle buyer_item_handle;
    sol::state lua;
    sol::table services;
};

[[maybe_unused]] item *find_platform_trade_item( Character &character,
        const std::int64_t uid )
{
    item *result = nullptr;
    character.visit_items( [&result, uid]( item *candidate, item * ) {
        if( candidate != nullptr && candidate->uid().get_value() == uid ) {
            result = candidate;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    return result;
}

[[maybe_unused]] int count_platform_trade_items( Character &character,
        const std::int64_t uid )
{
    int result = 0;
    character.visit_items( [&result, uid]( item *candidate, item * ) {
        if( candidate != nullptr && candidate->uid().get_value() == uid ) {
            ++result;
        }
        return VisitResponse::NEXT;
    } );
    return result;
}

struct platform_calendar_turn_scope {
    platform_calendar_turn_scope() : saved( calendar::turn ) {}

    ~platform_calendar_turn_scope() {
        calendar::turn = saved;
    }

    decltype( calendar::turn ) saved;
};

struct platform_weather_read_fixture {
    platform_weather_read_fixture() {
        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_weather_api(
            services,
        [this]() {
            ++read_gate_calls;
        },
        [this]() {
            ++write_gate_calls;
        } );
    }

    sol::state lua;
    sol::table services;
    int read_gate_calls = 0;
    int write_gate_calls = 0;
};

struct platform_zones_read_fixture {
    platform_zones_read_fixture() :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, 1 ),
        active_runtime( runtime ),
        active_world_generation( 1 ) {
        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_zone_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        [this]() {
            ++read_gate_calls;
        },
        [this]() {
            ++write_gate_calls;
        } );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    int read_gate_calls = 0;
    int write_gate_calls = 0;
};

} // namespace
