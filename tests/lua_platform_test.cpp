#include "cata_catch.h"

#include <algorithm>
#include <cstdint>
#include <limits>
#include <memory>
#include <set>
#include <string>
#include <optional>
#include <sstream>
#include <type_traits>
#include <utility>
#include <vector>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "basecamp.h"
#include "bodypart.h"
#include "calendar.h"
#include "character.h"
#include "creature_tracker.h"
#include "cata_scope_helpers.h"
#include "clzones.h"
#include "coordinates.h"
#include "faction.h"
#include "field_type.h"
#include "game.h"
#include "item.h"
#include "item_category.h"
#include "item_pocket.h"
#include "inventory.h"
#include "json.h"
#include "json_loader.h"
#include "map_helpers.h"
#include "mapbuffer.h"
#include "mapgen_functions.h"
#include "map_scale_constants.h"
#include "lua_platform_content.h"
#include "lua_platform_camps.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_factions.h"
#include "lua_platform_handle.h"
#include "lua_platform_hooks.h"
#include "lua_platform_hordes.h"
#include "lua_platform_identity.h"
#include "lua_platform_loader.h"
#include "lua_platform_items.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_bindings_enums.h"
#include "lua_platform_mapgen.h"
#include "lua_platform_missions.h"
#include "lua_platform_npcs.h"
#include "lua_platform_overmap.h"
#include "lua_platform_runtime.h"
#include "lua_platform_trade.h"
#include "lua_platform_vehicles.h"
#include "lua_platform_weather.h"
#include "lua_platform_world.h"
#include "lua_platform_world_services.h"
#include "lua_platform_world_content.h"
#include "lua_platform_zones.h"
#include "lua_platform_bindings_coords.h"
#include "map.h"
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
    []( const registrar_graph_entry &entry ) {
        return entry.id;
    },
    []( const registrar_graph_entry &entry ) {
        return entry.copy_from;
    },
    []( const std::string &id ) {
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
    []( const registrar_graph_entry &entry ) {
        return entry.id;
    },
    []( const registrar_graph_entry &entry ) {
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
    []( const std::string &value ) {
        return value;
    },
    "test flags", error ) );
    CHECK( target == std::set<std::string>{ "added" } );

    const std::set<std::string> conflicting = { "added" };
    CHECK_FALSE( cata::lua_platform::detail::apply_platform_collection_patch(
                     target, &conflicting,
                     static_cast<const std::set<std::string> *>( nullptr ),
    []( const std::string &value ) {
        return value;
    },
    "test flags", error ) );
    CHECK( error.find( "conflicts" ) != std::string::npos );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

namespace
{

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

basecamp_platform_task make_platform_resource_work_test_task(
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

sol::table make_platform_recipe_holder_table( sol::state &lua,
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

struct platform_equipment_fixture {
    explicit platform_equipment_fixture( const std::size_t runtime_number,
                                         const std::size_t world_number,
                                         const int actor_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        actor.normalize();
        actor.setID( character_id( actor_number ), true );
        actor_handle = cata::lua_platform::game_handle::from_creature(
                           actor,
                           { "avatar", actor.getID().get_value(), 0, 0, 0, {} },
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
        cata::lua_platform::install_item_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
    }

    sol::table holder( const cata::lua_platform::game_handle &character,
                       const std::string &slot = "inventory" ) {
        sol::table result = lua.create_table();
        result["kind"] = "character";
        result["character"] = character;
        result["slot"] = slot;
        return result;
    }

    item *add_item( const itype_id &id ) {
        item value( id, calendar::turn_zero );
        return &actor.inv->add_item(
                   std::move( value ), false, false, false );
    }

    item *add_worn_item( const itype_id &id ) {
        item value( id, calendar::turn_zero );
        const auto worn = actor.wear_item(
                              value, false, false, true, true );
        return worn ? &**worn : nullptr;
    }

    cata::lua_platform::game_handle item_handle(
        item &value, const std::string &scope = "character_inventory" ) const {
        return cata::lua_platform::game_handle::from_item(
                   value,
                   { scope, value.uid().get_value(), 0, 0, 0, {} },
                   runtime, active_world_generation );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    avatar actor;
    cata::lua_platform::game_handle actor_handle;
    sol::state lua;
    sol::table services;
    bool write_called = false;
};

TEST_CASE( "lua_platform_equipment_wield_inventory_to_wield",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 201, 1, 6201 );
    item *source_item = fixture.add_item( itype_id( "rock" ) );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::protected_function_result result = wield(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    CHECK( envelope["value"].get<sol::table>()["operation"].get<std::string>() ==
           "wield" );
    CHECK( fixture.actor.has_weapon() );
    CHECK( source_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_wear_inventory_to_worn",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 202, 1, 6202 );
    item *source_item = fixture.add_item( itype_id( "backpack" ) );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wear =
        fixture.services["equipment"]["wear"];

    const sol::protected_function_result result = wear(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    const cata::lua_platform::game_handle worn_handle =
        value["handle"].get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> worn =
        worn_handle.resolve_item( fixture.active_runtime,
                                  fixture.active_world_generation );
    REQUIRE( static_cast<bool>( worn ) );
    CHECK( fixture.actor.is_worn( *worn.value ) );
    CHECK( source_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_takeoff_to_explicit_holder",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 203, 1, 6203 );
    item *worn_item = fixture.add_worn_item( itype_id( "backpack" ) );
    REQUIRE( worn_item != nullptr );
    const cata::lua_platform::game_handle worn_handle =
        fixture.item_handle( *worn_item, "character_worn" );
    const sol::protected_function unequip =
        fixture.services["equipment"]["unequip"];

    const sol::protected_function_result result = unequip(
            fixture.actor_handle, worn_handle,
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const cata::lua_platform::game_handle moved_handle =
        envelope["value"].get<sol::table>()["handle"]
        .get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> moved =
        moved_handle.resolve_item( fixture.active_runtime,
                                   fixture.active_world_generation );
    REQUIRE( static_cast<bool>( moved ) );
    CHECK( !fixture.actor.is_wearing( itype_id( "backpack" ) ) );
    CHECK( fixture.actor.has_item( *moved.value ) );
    CHECK( worn_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_unwield_to_explicit_holder",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 204, 1, 6204 );
    item wielded_value( itype_id( "rock" ), calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield( wielded_value, std::nullopt, false ) );
    item_location wielded_location = fixture.actor.get_wielded_item();
    REQUIRE( wielded_location );
    item *wielded_item = wielded_location.get_item();
    REQUIRE( wielded_item != nullptr );
    const cata::lua_platform::game_handle wielded_handle =
        fixture.item_handle( *wielded_item, "character_wielded" );
    const sol::protected_function unequip =
        fixture.services["equipment"]["unequip"];

    const sol::protected_function_result result = unequip(
            fixture.actor_handle, wielded_handle,
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const cata::lua_platform::game_handle moved_handle =
        envelope["value"].get<sol::table>()["handle"]
        .get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> moved =
        moved_handle.resolve_item( fixture.active_runtime,
                                   fixture.active_world_generation );
    REQUIRE( static_cast<bool>( moved ) );
    CHECK_FALSE( fixture.actor.has_weapon() );
    CHECK( fixture.actor.has_item( *moved.value ) );
    CHECK( wielded_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_atomic_swap",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 205, 1, 6205 );
    item old_value( itype_id( "rock" ), calendar::turn_zero );
    REQUIRE( fixture.actor.Character::wield( old_value, std::nullopt, false ) );
    item_location old_location = fixture.actor.get_wielded_item();
    REQUIRE( old_location );
    const std::int64_t old_uid = old_location->uid().get_value();
    item *next_item = fixture.add_item( itype_id( "stick" ) );
    REQUIRE( next_item != nullptr );
    const cata::lua_platform::game_handle next_handle =
        fixture.item_handle( *next_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::protected_function_result result = wield(
            fixture.actor_handle, next_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( fixture.actor.has_weapon() );
    CHECK( fixture.actor.get_wielded_item()->typeId() == itype_id( "stick" ) );
    CHECK( value["displaced_count"].get<std::size_t>() == 1 );
    const sol::table displaced = value["displaced"].get<sol::table>()[1];
    CHECK( displaced["source_uid"].get<std::int64_t>() == old_uid );
    const cata::lua_platform::game_handle displaced_handle =
        displaced["handle"].get<cata::lua_platform::game_handle>();
    const cata::lua_platform::native_handle_result<item> displaced_item =
        displaced_handle.resolve_item( fixture.active_runtime,
                                       fixture.active_world_generation );
    REQUIRE( static_cast<bool>( displaced_item ) );
    CHECK( displaced_item.value->typeId() == itype_id( "rock" ) );
    CHECK( fixture.actor.has_item( *displaced_item.value ) );
    CHECK( next_handle.validation_error(
               fixture.active_runtime, fixture.active_world_generation ) );
}

TEST_CASE( "lua_platform_equipment_conflict_destination_rollback",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 206, 1, 6206 );
    const itype_id single_worn_pack( "backpack_hiking" );
    item *existing = fixture.add_worn_item( single_worn_pack );
    REQUIRE( existing != nullptr );
    item *source_item = fixture.add_item( single_worn_pack );
    REQUIRE( source_item != nullptr );
    item *destination_blocker = fixture.add_item( single_worn_pack );
    REQUIRE( destination_blocker != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wear =
        fixture.services["equipment"]["wear"];

    const sol::protected_function_result result = wear(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "destination_rejected" );
    CHECK( fixture.actor.is_wearing( single_worn_pack ) );
    CHECK( fixture.actor.has_item( *source_item ) );
    CHECK( fixture.actor.has_item( *destination_blocker ) );
}

TEST_CASE( "lua_platform_equipment_stale_actor_item",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 207, 1, 6207 );
    item *source_item = fixture.add_item( itype_id( "rock" ) );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle source_handle =
        fixture.item_handle( *source_item );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];
    cata::lua_platform::retire_item_handle_identity( *source_item );

    const sol::protected_function_result stale_item_result = wield(
            fixture.actor_handle, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( stale_item_result.valid() );
    CHECK_FALSE( stale_item_result.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale_item_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_item" );

    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 207 );
    const cata::lua_platform::game_handle stale_actor =
        cata::lua_platform::game_handle::from_creature(
            fixture.actor, { "character", fixture.actor.getID().get_value(), 0, 0, 0, {} },
            other_runtime, fixture.active_world_generation );
    const sol::protected_function_result stale_actor_result = wield(
            stale_actor, source_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( stale_actor_result.valid() );
    CHECK_FALSE( stale_actor_result.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale_actor_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
}

TEST_CASE( "lua_platform_equipment_wrong_owner",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 208, 1, 6208 );
    avatar owner;
    owner.normalize();
    owner.setID( character_id( 7208 ), true );
    item *foreign_item = &owner.inv->add_item(
                             item( itype_id( "rock" ), calendar::turn_zero ),
                             false, false, false );
    REQUIRE( foreign_item != nullptr );
    const cata::lua_platform::game_handle foreign_handle =
        cata::lua_platform::game_handle::from_item(
            *foreign_item,
            { "character_inventory", foreign_item->uid().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];

    const sol::protected_function_result result = wield(
            fixture.actor_handle, foreign_handle,
            fixture.holder( fixture.actor_handle ),
            fixture.holder( fixture.actor_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_holder" );
    CHECK( owner.has_item( *foreign_item ) );
    CHECK_FALSE( fixture.actor.has_weapon() );
}

TEST_CASE( "lua_platform_equipment_participant_death",
           "[lua][platform][equipment]" )
{
    platform_equipment_fixture fixture( 209, 1, 6209 );
    npc dying;
    dying.normalize();
    dying.setID( character_id( 7209 ), true );
    cata::lua_platform::register_npc_handle_identity( dying );
    item *source_item = &dying.inv->add_item(
                            item( itype_id( "rock" ), calendar::turn_zero ),
                            false, false, false );
    REQUIRE( source_item != nullptr );
    const cata::lua_platform::game_handle dying_handle =
        cata::lua_platform::game_handle::from_creature(
            dying, { "npc", dying.getID().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const cata::lua_platform::game_handle source_handle =
        cata::lua_platform::game_handle::from_item(
            *source_item,
            { "character_inventory", source_item->uid().get_value(), 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const sol::protected_function wield =
        fixture.services["equipment"]["wield"];
    cata::lua_platform::retire_npc_handle_identity( dying );

    fixture.write_called = false;
    const sol::protected_function_result result = wield(
            dying_handle, source_handle,
            fixture.holder( dying_handle ), fixture.holder( dying_handle ) );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( fixture.write_called );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_identity" );
}

TEST_CASE( "lua_platform_equipment_public_surface_has_no_legacy_helpers",
           "[lua][platform][equipment][contract]" )
{
    platform_equipment_fixture fixture( 210, 1, 6210 );
    const sol::table equipment = fixture.services["equipment"];
    REQUIRE( equipment.valid() );
    const std::set<std::string> expected = { "unequip", "wear", "wield" };
    std::set<std::string> exposed;
    for( const auto &entry : equipment ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK( equipment["wield"].valid() );
    CHECK( equipment["wear"].valid() );
    CHECK( equipment["unequip"].valid() );

    const sol::table inventory = fixture.services["inventory"];
    CHECK_FALSE( inventory["remove"].valid() );
    CHECK_FALSE( inventory["wield"].valid() );
    CHECK_FALSE( inventory["wear"].valid() );

    cata::lua_platform::install_npc_api(
        fixture.services,
        [fixture_ptr = &fixture]() {
        return fixture_ptr->active_runtime;
    },
    [fixture_ptr = &fixture]() {
        return fixture_ptr->active_world_generation;
    },
    []() {}, []() {}, []() {} );
    const sol::table npcs = fixture.services["npcs"];
    REQUIRE( npcs.valid() );
    CHECK_FALSE( npcs["equipment"].valid() );
}

TEST_CASE( "lua_platform_dialogue_context_has_no_legacy_trade_helpers",
           "[lua][platform][dialogue][trade]" )
{
    using context = cata::lua_platform::dialogue::context;
    CHECK_FALSE( has_legacy_dialogue_quote_trade_item<context>::value );
    CHECK_FALSE( has_legacy_dialogue_buy_quoted_item<context>::value );
}

TEST_CASE( "lua_platform_trade_root_exposes_only_explicit_quote_get_commit",
           "[lua][platform][trade][contract]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_trade_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {},
    []() {} );

    const sol::table trade = services["trade"];
    REQUIRE( trade.valid() );
    const std::set<std::string> expected = { "commit", "get", "quote" };
    std::set<std::string> exposed;
    for( const auto &entry : trade ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK( trade["quote"].valid() );
    CHECK( trade["get"].valid() );
    CHECK( trade["commit"].valid() );
    CHECK_FALSE( trade["transfer"].valid() );
    CHECK_FALSE( trade["transfer_matching"].valid() );
    CHECK_FALSE( trade["open"].valid() );
    CHECK_FALSE( trade["pay"].valid() );
    CHECK_FALSE( trade["settle"].valid() );
    CHECK_FALSE( trade["settle_credit"].valid() );
    CHECK_FALSE( trade["buy_monsters"].valid() );
    CHECK_FALSE( trade["matching_stock"].valid() );
    CHECK_FALSE( trade["cash_to_favor"].valid() );
    CHECK_FALSE( trade["settle_faction_account"].valid() );
    CHECK_FALSE( trade["balance"].valid() );
    CHECK_FALSE( trade["set_balance"].valid() );
    CHECK_FALSE( trade["adjust_balance"].valid() );
}

item *find_platform_trade_item( Character &character, const std::int64_t uid )
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

int count_platform_trade_items( Character &character, const std::int64_t uid )
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

TEST_CASE( "lua_platform_persistent_task_actor_payload_uses_live_handle_only_at_dispatch",
           "[lua][platform][runtime][tasks][handles]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_actor_payload", 901, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_payload;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "task_callback", [&callback_payload, &callback_actor,
                                         &callback_called]( const sol::table &payload ) {
        callback_called = true;
        callback_payload = payload["payload"].get<sol::table>();
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"]( "task_callback", lua["task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    const character_id avatar_id = get_avatar().getID();
    const cata::lua_platform::game_handle avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", avatar_id.get_value(), 0, 0, 0, {} },
            runtime_identity, world_generation );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 42;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
            0, "task_callback", persistent_payload, 1, "world", avatar_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    REQUIRE( snapshot["actor_character_id"].valid() );
    CHECK( snapshot["actor_character_id"].get<std::int64_t>() == avatar_id.get_value() );
    CHECK_FALSE( snapshot["actor"].valid() );
    CHECK_FALSE( snapshot["live_handle"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_actor->subtype_name() == "avatar" );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().stable_id == avatar_id.get_value() );
    CHECK_FALSE( callback_actor->validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    CHECK( callback_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( callback_payload["actor"].valid() );
    CHECK_FALSE( callback_payload["handle"].valid() );
}

TEST_CASE( "lua_platform_persistent_task_item_actor_payload_uses_live_handle_only_at_dispatch",
           "[lua][platform][runtime][tasks][handles]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_item_actor_payload", 902, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_payload;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "task_callback", [&callback_payload, &callback_actor,
                                         &callback_called]( const sol::table &payload ) {
        callback_called = true;
        callback_payload = payload["payload"].get<sol::table>();
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"]( "task_callback", lua["task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();

    item &avatar_inventory_item = get_avatar().inv->add_item(
                                      item( itype_id( "rock" ), calendar::turn_zero ),
                                      false, false, false );
    item_location avatar_item_location( get_avatar(), &avatar_inventory_item );
    REQUIRE( avatar_item_location );
    on_out_of_scope item_cleanup( [&avatar_item_location]() {
        if( avatar_item_location ) {
            avatar_item_location.remove_item();
        }
    } );
    item *avatar_item = avatar_item_location.get_item();
    REQUIRE( avatar_item != nullptr );
    const std::int64_t avatar_item_uid = avatar_item->uid().get_value();
    const cata::lua_platform::game_handle avatar_item_handle =
        cata::lua_platform::game_handle::from_item(
            *avatar_item,
            { "avatar_inventory", avatar_item_uid, 0, 0, 0, {} },
            runtime_identity, world_generation );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 42;
    basecamp wrong_actor( "Wrong task actor", tripoint_abs_omt{ 0, 0, 0 } );
    const cata::lua_platform::game_handle wrong_actor_handle =
        cata::lua_platform::game_handle::from_camp(
            wrong_actor, {},
            runtime_identity, world_generation );
    const sol::protected_function_result rejected = ccb["tasks"]["after"](
                0, "task_callback", persistent_payload, 1, "world", wrong_actor_handle );
    CHECK_FALSE( rejected.valid() );
    const sol::protected_function_result empty_tasks = ccb["tasks"]["list"]();
    REQUIRE( empty_tasks.valid() );
    CHECK( empty_tasks.get<sol::table>()["total"].get<std::size_t>() == 0 );

    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
            0, "task_callback", persistent_payload, 1, "world", avatar_item_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK( snapshot["actor_kind"].get<std::string>() == "item" );
    CHECK_FALSE( snapshot["actor_character_id"].valid() );
    REQUIRE( snapshot["actor_item_uid"].valid() );
    CHECK( snapshot["actor_item_uid"].get<std::int64_t>() == avatar_item_uid );
    CHECK_FALSE( snapshot["actor_item_pending"].get<bool>() );
    CHECK_FALSE( snapshot["actor"].valid() );
    CHECK_FALSE( snapshot["live_handle"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );
    CHECK_FALSE( snapshot_payload["handle"].valid() );
    CHECK_FALSE( snapshot_payload["live_handle"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_actor->kind() == cata::lua_platform::game_handle_kind::item );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().scope == "avatar_item" );
    CHECK( callback_actor->locator().stable_id == avatar_item_uid );
    CHECK_FALSE( callback_actor->validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    const cata::lua_platform::native_handle_result<item> resolved =
        callback_actor->resolve_item(
            runtime_identity, cata::lua_platform::runtime_world_generation() );
    REQUIRE( static_cast<bool>( resolved ) );
    CHECK( resolved.value == avatar_item );
    CHECK( resolved.value->uid().get_value() == avatar_item_uid );
    CHECK( callback_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( callback_payload["actor"].valid() );
    CHECK_FALSE( callback_payload["handle"].valid() );
}

TEST_CASE( "lua_platform_persistent_task_monster_actor_reacquires_persistent_identity",
           "[lua][platform][runtime][tasks][handles][monster]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_monster_actor", 903, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_envelope;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "monster_task_callback",
    [&callback_envelope, &callback_actor, &callback_called]( const sol::table & payload ) {
        callback_called = true;
        callback_envelope = payload;
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"](
            "monster_task_callback", lua["monster_task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();

    const tripoint_bub_ms monster_position( 5, 5, get_avatar().pos_bub().z() );
    const shared_ptr_fast<monster> actor_monster =
        make_shared_fast<monster>( mtype_id( "mon_zombie" ), monster_position );
    REQUIRE( get_creature_tracker().add( actor_monster ) );
    on_out_of_scope monster_cleanup( [&actor_monster]() {
        if( actor_monster &&
            get_creature_tracker().temporary_id( *actor_monster ) >= 0 ) {
            get_creature_tracker().remove( *actor_monster );
        }
    } );
    REQUIRE( actor_monster->uid().is_valid() );
    const std::int64_t monster_uid = actor_monster->uid().get_value();
    const tripoint_abs_ms absolute_position = actor_monster->pos_abs();
    const cata::lua_platform::game_handle monster_handle =
        cata::lua_platform::game_handle::from_creature(
            *actor_monster,
            { "monster", 0, absolute_position.x(), absolute_position.y(),
              absolute_position.z(), {} },
            runtime_identity, world_generation );
    CHECK( monster_handle.locator().stable_id == monster_uid );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 73;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
                0, "monster_task_callback", persistent_payload, 1, "world",
                monster_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK( snapshot["actor_kind"].get<std::string>() == "monster" );
    CHECK_FALSE( snapshot["actor_character_id"].valid() );
    CHECK_FALSE( snapshot["actor_item_uid"].valid() );
    REQUIRE( snapshot["actor_monster_uid"].valid() );
    CHECK( snapshot["actor_monster_uid"].get<std::int64_t>() == monster_uid );
    CHECK_FALSE( snapshot["actor_monster_pending"].get<bool>() );
    CHECK_FALSE( snapshot["actor"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 73 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_envelope["actor_kind"].get<std::string>() == "monster" );
    CHECK( callback_envelope["actor_monster_uid"].get<std::int64_t>() == monster_uid );
    CHECK_FALSE( callback_envelope["actor_character_id"].valid() );
    CHECK_FALSE( callback_envelope["actor_item_uid"].valid() );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().stable_id == monster_uid );
    std::optional<cata::lua_platform::game_handle_error> resolve_error;
    CHECK( cata::lua_platform::resolve_exact_monster(
               *callback_actor, runtime_identity,
               cata::lua_platform::runtime_world_generation(), resolve_error ) ==
           actor_monster.get() );
    CHECK_FALSE( resolve_error );
}

TEST_CASE( "lua_platform_persistent_task_participants_snapshot_and_dispatch_exact_handles",
           "[lua][platform][runtime][tasks][participants][handles]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_participants", 905, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_envelope;
    bool callback_called = false;
    lua.set_function( "participant_task_callback",
    [&callback_envelope, &callback_called]( const sol::table &payload ) {
        callback_called = true;
        callback_envelope = payload;
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"](
            "participant_task_callback", lua["participant_task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    const character_id avatar_id = get_avatar().getID();
    const cata::lua_platform::game_handle avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", avatar_id.get_value(), 0, 0, 0, {} },
            runtime_identity, world_generation );

    const tripoint_bub_ms monster_position( 5, 5, get_avatar().pos_bub().z() );
    const shared_ptr_fast<monster> actor_monster =
        make_shared_fast<monster>( mtype_id( "mon_zombie" ), monster_position );
    REQUIRE( get_creature_tracker().add( actor_monster ) );
    on_out_of_scope monster_cleanup( [&actor_monster]() {
        if( actor_monster &&
            get_creature_tracker().temporary_id( *actor_monster ) >= 0 ) {
            get_creature_tracker().remove( *actor_monster );
        }
    } );
    REQUIRE( actor_monster->uid().is_valid() );
    const std::int64_t monster_uid = actor_monster->uid().get_value();
    const tripoint_abs_ms absolute_position = actor_monster->pos_abs();
    const cata::lua_platform::game_handle monster_handle =
        cata::lua_platform::game_handle::from_creature(
            *actor_monster,
            { "monster", 0, absolute_position.x(), absolute_position.y(),
              absolute_position.z(), {} },
            runtime_identity, world_generation );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 905;

    sol::table invalid_participants = lua.create_table();
    invalid_participants["bad-role"] = avatar_handle;
    const sol::protected_function_result rejected = ccb["tasks"]["after"](
            0, "participant_task_callback", persistent_payload, 1, "world",
            sol::nil, invalid_participants );
    CHECK_FALSE( rejected.valid() );
    const sol::protected_function_result empty_tasks = ccb["tasks"]["list"]();
    REQUIRE( empty_tasks.valid() );
    CHECK( empty_tasks.get<sol::table>()["total"].get<std::size_t>() == 0 );

    sol::table participants = lua.create_table();
    participants["alpha"] = avatar_handle;
    participants["beta"] = monster_handle;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
            0, "participant_task_callback", persistent_payload, 1, "world",
            sol::nil, participants );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK_FALSE( snapshot["actor_kind"].valid() );
    CHECK_FALSE( snapshot["actor"].valid() );
    const sol::table snapshot_participants = snapshot["participants"].get<sol::table>();
    const sol::table alpha_snapshot = snapshot_participants["alpha"].get<sol::table>();
    CHECK( alpha_snapshot["kind"].get<std::string>() == "character" );
    CHECK( alpha_snapshot["character_id"].get<std::int64_t>() == avatar_id.get_value() );
    CHECK_FALSE( alpha_snapshot["item_uid"].valid() );
    CHECK_FALSE( alpha_snapshot["monster_uid"].valid() );
    CHECK_FALSE( alpha_snapshot["vehicle_uid"].valid() );
    CHECK_FALSE( alpha_snapshot["pending"].get<bool>() );
    CHECK_FALSE( alpha_snapshot["actor"].valid() );
    CHECK_FALSE( alpha_snapshot["handle"].valid() );
    CHECK_FALSE( alpha_snapshot["live_handle"].valid() );

    const sol::table beta_snapshot = snapshot_participants["beta"].get<sol::table>();
    CHECK( beta_snapshot["kind"].get<std::string>() == "monster" );
    CHECK_FALSE( beta_snapshot["character_id"].valid() );
    CHECK_FALSE( beta_snapshot["item_uid"].valid() );
    CHECK( beta_snapshot["monster_uid"].get<std::int64_t>() == monster_uid );
    CHECK_FALSE( beta_snapshot["vehicle_uid"].valid() );
    CHECK_FALSE( beta_snapshot["pending"].get<bool>() );
    CHECK_FALSE( beta_snapshot["actor"].valid() );
    CHECK_FALSE( beta_snapshot["handle"].valid() );
    CHECK_FALSE( beta_snapshot["live_handle"].valid() );

    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 905 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );
    CHECK_FALSE( snapshot_payload["handle"].valid() );
    CHECK_FALSE( snapshot_payload["live_handle"].valid() );
    CHECK_FALSE( snapshot_payload["participants"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    CHECK_FALSE( callback_envelope["actor"].valid() );
    const sol::table callback_participants =
        callback_envelope["participants"].get<sol::table>();
    const sol::object callback_alpha_object = callback_participants["alpha"];
    const sol::object callback_beta_object = callback_participants["beta"];
    REQUIRE( callback_alpha_object.is<cata::lua_platform::game_handle>() );
    REQUIRE( callback_beta_object.is<cata::lua_platform::game_handle>() );
    const cata::lua_platform::game_handle callback_alpha =
        callback_alpha_object.as<cata::lua_platform::game_handle>();
    const cata::lua_platform::game_handle callback_beta =
        callback_beta_object.as<cata::lua_platform::game_handle>();

    CHECK( callback_alpha.subtype_name() == "avatar" );
    CHECK( callback_alpha.runtime_generation() == runtime_identity.generation() );
    CHECK( callback_alpha.world_generation() == world_generation );
    CHECK( callback_alpha.locator().stable_id == avatar_id.get_value() );
    CHECK_FALSE( callback_alpha.validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    std::optional<cata::lua_platform::game_handle_error> avatar_error;
    CHECK( cata::lua_platform::resolve_exact_character(
               callback_alpha, runtime_identity,
               cata::lua_platform::runtime_world_generation(), avatar_error ) ==
           &get_avatar() );
    CHECK_FALSE( avatar_error );

    CHECK( callback_beta.subtype_name() == "monster" );
    CHECK( callback_beta.runtime_generation() == runtime_identity.generation() );
    CHECK( callback_beta.world_generation() == world_generation );
    CHECK( callback_beta.locator().stable_id == monster_uid );
    CHECK_FALSE( callback_beta.validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    std::optional<cata::lua_platform::game_handle_error> monster_error;
    CHECK( cata::lua_platform::resolve_exact_monster(
               callback_beta, runtime_identity,
               cata::lua_platform::runtime_world_generation(), monster_error ) ==
           actor_monster.get() );
    CHECK_FALSE( monster_error );

    const sol::table callback_payload = callback_envelope["payload"].get<sol::table>();
    CHECK( callback_payload["marker"].get<int>() == 905 );
    CHECK_FALSE( callback_payload["actor"].valid() );
    CHECK_FALSE( callback_payload["handle"].valid() );
    CHECK_FALSE( callback_payload["live_handle"].valid() );
    CHECK_FALSE( callback_payload["participants"].valid() );
}

TEST_CASE( "lua_platform_persistent_task_vehicle_actor_reacquires_persistent_identity",
           "[lua][platform][runtime][tasks][handles][vehicle]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_vehicle_actor", 904, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_envelope;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "vehicle_task_callback",
    [&callback_envelope, &callback_actor, &callback_called]( const sol::table & payload ) {
        callback_called = true;
        callback_envelope = payload;
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"](
            "vehicle_task_callback", lua["vehicle_task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();

    map &here = get_map();
    std::optional<tripoint_bub_ms> vehicle_position;
    for( int x = 10; x <= 30 && !vehicle_position; ++x ) {
        for( int y = 10; y <= 30; ++y ) {
            const tripoint_bub_ms candidate( x, y, get_avatar().pos_bub().z() );
            if( here.inbounds( candidate ) && !here.veh_at( candidate ) ) {
                vehicle_position = candidate;
                break;
            }
        }
    }
    REQUIRE( vehicle_position );
    vehicle *actor_vehicle = here.add_vehicle(
                                 vproto_id( "bicycle" ), *vehicle_position,
                                 0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( actor_vehicle != nullptr );
    REQUIRE( actor_vehicle->uid().is_valid() );
    const std::int64_t vehicle_uid = actor_vehicle->uid().get_value();
    on_out_of_scope vehicle_cleanup( [&here, actor_vehicle, vehicle_uid]() {
        if( vehicle::find_vehicle_by_uid( here, vehicle_uid ) == actor_vehicle ) {
            here.destroy_vehicle( actor_vehicle );
        }
    } );
    const tripoint_abs_ms absolute_position = actor_vehicle->pos_abs();
    const cata::lua_platform::game_handle vehicle_handle =
        cata::lua_platform::game_handle::from_vehicle(
            *actor_vehicle,
            { "vehicle", 0, absolute_position.x(), absolute_position.y(),
              absolute_position.z(), {} },
            runtime_identity, world_generation );
    CHECK( vehicle_handle.locator().stable_id == vehicle_uid );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 91;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
                0, "vehicle_task_callback", persistent_payload, 1, "world",
                vehicle_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK( snapshot["actor_kind"].get<std::string>() == "vehicle" );
    CHECK_FALSE( snapshot["actor_character_id"].valid() );
    CHECK_FALSE( snapshot["actor_item_uid"].valid() );
    CHECK_FALSE( snapshot["actor_monster_uid"].valid() );
    REQUIRE( snapshot["actor_vehicle_uid"].valid() );
    CHECK( snapshot["actor_vehicle_uid"].get<std::int64_t>() == vehicle_uid );
    CHECK_FALSE( snapshot["actor_vehicle_pending"].get<bool>() );
    CHECK_FALSE( snapshot["actor"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 91 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_envelope["actor_kind"].get<std::string>() == "vehicle" );
    CHECK( callback_envelope["actor_vehicle_uid"].get<std::int64_t>() == vehicle_uid );
    CHECK_FALSE( callback_envelope["actor_character_id"].valid() );
    CHECK_FALSE( callback_envelope["actor_item_uid"].valid() );
    CHECK_FALSE( callback_envelope["actor_monster_uid"].valid() );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().stable_id == vehicle_uid );
    const cata::lua_platform::native_handle_result<vehicle> resolved =
        callback_actor->resolve_vehicle(
            runtime_identity, cata::lua_platform::runtime_world_generation() );
    REQUIRE( static_cast<bool>( resolved ) );
    CHECK( resolved.value == actor_vehicle );
    CHECK( resolved.value->uid().get_value() == vehicle_uid );
}

TEST_CASE( "lua_platform_zones_read_surface_uses_read_gate",
           "[lua][platform][zones]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );
    CHECK( zones["types"].valid() );
    CHECK( zones["type"].valid() );
    CHECK( zones["list"].valid() );
    CHECK( zones["at"].valid() );
    CHECK( zones["get"].valid() );
    CHECK( zones["contains"].valid() );

    const sol::protected_function_result types_result = zones["types"]();
    REQUIRE( types_result.valid() );
    const sol::table types_page = types_result.get<sol::table>();
    REQUIRE( types_page.valid() );
    const sol::table type_items = types_page["items"].get<sol::table>();
    REQUIRE( type_items.valid() );
    REQUIRE( types_page["returned"].valid() );

    const sol::protected_function_result list_result = zones["list"]();
    REQUIRE( list_result.valid() );
    const sol::table list_envelope = list_result.get<sol::table>();
    REQUIRE( list_envelope.valid() );
    REQUIRE( list_envelope["ok"].get<bool>() );
    const sol::table list_value = list_envelope["value"].get<sol::table>();
    REQUIRE( list_value.valid() );
    const sol::table list_items = list_value["items"].get<sol::table>();
    REQUIRE( list_items.valid() );

    CHECK( fixture.read_gate_calls > 0 );
    CHECK( fixture.write_gate_calls == 0 );
}

TEST_CASE( "lua_platform_zones_mutation_and_token_surface",
           "[lua][platform][zones][contract]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    CHECK( zones["create"].valid() );
    CHECK( zones["rename"].valid() );
    CHECK( zones["set_enabled"].valid() );
    CHECK( zones["set_temporary_disabled"].valid() );
    CHECK( zones["set_position"].valid() );
    CHECK( zones["remove"].valid() );

    const sol::object zone_token_type = fixture.lua["ZoneToken"];
    REQUIRE( zone_token_type.valid() );
    CHECK( zone_token_type.get_type() == sol::type::table );

    const sol::table list_options = fixture.lua.create_table_with(
                                        "kind", "global" );
    const sol::protected_function_result list_result = zones["list"](
                list_options );
    REQUIRE( list_result.valid() );
    const sol::table list_envelope = list_result.get<sol::table>();
    REQUIRE( list_envelope["ok"].get<bool>() );
    const sol::table list_value = list_envelope["value"].get<sol::table>();
    REQUIRE( list_value.valid() );
    const sol::table list_items = list_value["items"].get<sol::table>();
    REQUIRE( list_items.valid() );
    const std::size_t returned = list_value["returned"].get<std::size_t>();
    for( std::size_t index = 1; index <= returned; ++index ) {
        const sol::object item_object = list_items[index];
        REQUIRE( item_object.is<sol::table>() );
        const sol::table item = item_object.as<sol::table>();
        CHECK( item["kind"].get<std::string>() == "global" );
    }
}

TEST_CASE( "lua_platform_zones_rejects_wrong_game_id_kinds",
           "[lua][platform][zones][contract]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    const auto &zone_types = zone_manager::get_manager().get_types();
    const auto valid_type = std::find_if(
                                zone_types.begin(), zone_types.end(),
    []( const auto &entry ) {
        return entry.first.is_valid();
    } );
    REQUIRE( valid_type != zone_types.end() );

    const sol::protected_function type = zones["type"];
    const sol::protected_function_result wrong_type_result = type(
                cata::lua_platform::script_game_id(
                    "terrain", "t_floor" ) );
    CHECK_FALSE( wrong_type_result.valid() );

    const sol::table wrong_faction_options = fixture.lua.create_table_with(
                                                 "faction",
                                                 cata::lua_platform::script_game_id(
                                                     "zone", valid_type->first.str() ) );
    const sol::protected_function list = zones["list"];
    const sol::protected_function_result wrong_faction_result = list(
                wrong_faction_options );
    CHECK_FALSE( wrong_faction_result.valid() );

    const faction_id faction( "your_followers" );
    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_wrong_kind_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();
    const cata::lua_platform::script_tripoint_coord position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            tripoint_abs_ms::zero.raw() );
    const sol::table wrong_create_options = fixture.lua.create_table_with(
                                                "name", zone_name,
                                                "type",
                                                cata::lua_platform::script_game_id(
                                                    "faction", faction.str() ),
                                                "faction",
                                                cata::lua_platform::script_game_id(
                                                    "faction", faction.str() ),
                                                "start", position,
                                                "end", position,
                                                "kind", "global" );
    const sol::protected_function create = zones["create"];
    const sol::protected_function_result wrong_create_result = create(
                wrong_create_options );
    CHECK_FALSE( wrong_create_result.valid() );

    bool matching_zone_found = false;
    for( zone_manager::ref_zone_data candidate :
         zone_manager::get_manager().get_zones( faction ) ) {
        if( candidate.get().get_name() == zone_name ) {
            matching_zone_found = true;
            break;
        }
    }
    CHECK_FALSE( matching_zone_found );
}

TEST_CASE( "lua_platform_zones_vehicle_create_fails_closed",
           "[lua][platform][zones][contract]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_vehicle_rejected_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();

    const auto &zone_types = zone_manager::get_manager().get_types();
    const auto valid_type = std::find_if(
                                zone_types.begin(), zone_types.end(),
    []( const auto &entry ) {
        return entry.first.is_valid();
    } );
    REQUIRE( valid_type != zone_types.end() );

    const cata::lua_platform::script_tripoint_coord position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            tripoint_abs_ms::zero.raw() );
    const sol::table create_options = fixture.lua.create_table_with(
                                          "name", zone_name,
                                          "type",
                                          cata::lua_platform::script_game_id(
                                              "zone", valid_type->first.str() ),
                                          "start", position,
                                          "end", position,
                                          "kind", "vehicle" );
    const sol::protected_function create = zones["create"];
    const sol::protected_function_result create_result = create(
                create_options );
    REQUIRE( create_result.valid() );
    const sol::table create_envelope = create_result.get<sol::table>();
    REQUIRE_FALSE( create_envelope["ok"].get<bool>() );
    const sol::table error = create_envelope["error"].get<sol::table>();
    REQUIRE( error.valid() );
    CHECK( error["code"].get<std::string>() ==
           "unsupported_vehicle_mutation" );
    CHECK( fixture.write_gate_calls > 0 );

    bool matching_zone_found = false;
    for( zone_manager::ref_zone_data candidate :
         zone_manager::get_manager().get_zones(
             faction_id( "your_followers" ) ) ) {
        if( candidate.get().get_name() == zone_name ) {
            matching_zone_found = true;
            break;
        }
    }
    CHECK_FALSE( matching_zone_found );
}

TEST_CASE( "lua_platform_zones_create_and_remove_global_zone",
           "[lua][platform][zones]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    const faction_id faction( "your_followers" );
    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_global_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();
    on_out_of_scope cleanup( [&zone_name, faction]() {
        zone_manager &manager = zone_manager::get_manager();
        bool removed_any = false;
        while( true ) {
            zone_data *residual = nullptr;
            for( zone_manager::ref_zone_data candidate :
                 manager.get_zones( faction ) ) {
                if( candidate.get().get_name() == zone_name ) {
                    residual = &candidate.get();
                    break;
                }
            }
            if( residual == nullptr || !manager.remove( *residual ) ) {
                break;
            }
            removed_any = true;
        }
        if( removed_any ) {
            manager.cache_data();
        }
    } );

    const auto &zone_types = zone_manager::get_manager().get_types();
    const auto valid_type = std::find_if(
                                zone_types.begin(), zone_types.end(),
    []( const auto &entry ) {
        return entry.first.is_valid();
    } );
    REQUIRE( valid_type != zone_types.end() );

    REQUIRE( g != nullptr );
    map &here = get_map();
    const tripoint_bub_ms avatar_position = get_avatar().pos_bub();
    std::optional<tripoint_bub_ms> global_position;
    for( const tripoint_bub_ms &candidate :
         here.points_in_radius( avatar_position, 3 ) ) {
        if( !here.veh_at( candidate ) ) {
            global_position = candidate;
            break;
        }
    }
    REQUIRE( global_position.has_value() );
    const tripoint_abs_ms global_abs_position =
        here.get_abs( *global_position );
    const cata::lua_platform::script_tripoint_coord position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            global_abs_position.raw() );

    const sol::table create_options = fixture.lua.create_table_with(
                                          "name", zone_name,
                                          "type",
                                          cata::lua_platform::script_game_id(
                                              "zone", valid_type->first.str() ),
                                          "faction",
                                          cata::lua_platform::script_game_id(
                                              "faction", faction.str() ),
                                          "start", position,
                                          "end", position,
                                          "kind", "global" );
    const sol::protected_function create = zones["create"];
    const int write_gates_before_create = fixture.write_gate_calls;
    const sol::protected_function_result create_result = create(
                create_options );
    REQUIRE( create_result.valid() );
    CHECK( fixture.write_gate_calls == write_gates_before_create + 1 );
    const sol::table create_envelope = create_result.get<sol::table>();
    REQUIRE( create_envelope["ok"].get<bool>() );
    const sol::table snapshot = create_envelope["value"].get<sol::table>();
    REQUIRE( snapshot.valid() );
    CHECK( snapshot["kind"].get<std::string>() == "global" );
    CHECK_FALSE( snapshot["personal"].get<bool>() );
    CHECK_FALSE( snapshot["vehicle"].get<bool>() );

    const sol::object token_object = snapshot["token"];
    REQUIRE( token_object.is<sol::userdata>() );
    const sol::userdata token = token_object;
    REQUIRE( token.valid() );
    const sol::protected_function token_is_valid = token["is_valid"];
    const sol::protected_function token_status = token["status"];

    const int read_gates_before_token = fixture.read_gate_calls;
    const sol::protected_function_result valid_result = token_is_valid( token );
    REQUIRE( valid_result.valid() );
    CHECK( valid_result.get<bool>() );
    const sol::protected_function_result status_result = token_status( token );
    REQUIRE( status_result.valid() );
    const sol::table status_envelope = status_result.get<sol::table>();
    REQUIRE( status_envelope["ok"].get<bool>() );
    CHECK( fixture.read_gate_calls >= read_gates_before_token + 2 );

    const sol::protected_function remove = zones["remove"];
    const int write_gates_before_remove = fixture.write_gate_calls;
    const sol::protected_function_result remove_result = remove( token );
    REQUIRE( remove_result.valid() );
    CHECK( fixture.write_gate_calls == write_gates_before_remove + 1 );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["removed"].get<bool>() );

    const sol::protected_function_result invalid_result = token_is_valid( token );
    REQUIRE( invalid_result.valid() );
    CHECK_FALSE( invalid_result.get<bool>() );

    const sol::protected_function_result status_after_remove = token_status(
                token );
    REQUIRE( status_after_remove.valid() );
    const sol::table status_after_remove_envelope =
        status_after_remove.get<sol::table>();
    REQUIRE_FALSE( status_after_remove_envelope["ok"].get<bool>() );
    const sol::table status_after_remove_error =
        status_after_remove_envelope["error"].get<sol::table>();
    REQUIRE( status_after_remove_error.valid() );
    CHECK( status_after_remove_error["code"].get<std::string>() ==
           "not_found" );
}

TEST_CASE( "lua_platform_zones_create_move_and_remove_personal_zone",
           "[lua][platform][zones]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    const faction_id faction( "your_followers" );
    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_personal_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();
    on_out_of_scope cleanup( [&zone_name, faction]() {
        zone_manager &manager = zone_manager::get_manager();
        bool removed_any = false;
        while( true ) {
            zone_data *residual = nullptr;
            for( zone_manager::ref_zone_data candidate :
                 manager.get_zones( faction ) ) {
                if( candidate.get().get_name() == zone_name ) {
                    residual = &candidate.get();
                    break;
                }
            }
            if( residual == nullptr || !manager.remove( *residual ) ) {
                break;
            }
            removed_any = true;
        }
        if( removed_any ) {
            manager.cache_data();
        }
    } );

    const sol::protected_function_result types_result = zones["types"]();
    REQUIRE( types_result.valid() );
    const sol::table types_page = types_result.get<sol::table>();
    const sol::table type_items = types_page["items"].get<sol::table>();
    REQUIRE( type_items.valid() );

    std::optional<cata::lua_platform::script_game_id> personal_type;
    for( const auto &entry : type_items ) {
        if( !entry.second.is<sol::table>() ) {
            continue;
        }
        const sol::table type_snapshot = entry.second.as<sol::table>();
        if( !type_snapshot["can_be_personal"].get<bool>() ) {
            continue;
        }
        const sol::object type_id = type_snapshot["id"];
        REQUIRE( type_id.is<cata::lua_platform::script_game_id>() );
        personal_type = type_id.as<cata::lua_platform::script_game_id>();
        break;
    }
    REQUIRE( personal_type.has_value() );

    const cata::lua_platform::script_tripoint_coord initial_start =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( -4, -3, 0 ).raw() );
    const cata::lua_platform::script_tripoint_coord initial_end =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( 2, 1, 0 ).raw() );
    const sol::table create_options = fixture.lua.create_table_with(
                                          "name", zone_name,
                                          "type", personal_type.value(),
                                          "faction",
                                          cata::lua_platform::script_game_id(
                                              "faction", faction.str() ),
                                          "start", initial_start,
                                          "end", initial_end,
                                          "kind", "personal" );
    const sol::protected_function create = zones["create"];
    const sol::protected_function_result create_result = create(
                create_options );
    REQUIRE( create_result.valid() );
    const sol::table create_envelope = create_result.get<sol::table>();
    REQUIRE( create_envelope["ok"].get<bool>() );
    const sol::table snapshot = create_envelope["value"].get<sol::table>();
    REQUIRE( snapshot.valid() );
    CHECK( snapshot["kind"].get<std::string>() == "personal" );
    CHECK( snapshot["personal"].get<bool>() );
    CHECK_FALSE( snapshot["vehicle"].get<bool>() );

    const sol::object relative_start_object = snapshot["relative_start"];
    const sol::object relative_end_object = snapshot["relative_end"];
    REQUIRE( relative_start_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    REQUIRE( relative_end_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    const cata::lua_platform::script_tripoint_coord created_start =
        relative_start_object.as<cata::lua_platform::script_tripoint_coord>();
    const cata::lua_platform::script_tripoint_coord created_end =
        relative_end_object.as<cata::lua_platform::script_tripoint_coord>();
    CHECK( created_start.native_origin() == coords::origin::relative );
    CHECK( created_start.native_scale() == coords::scale::map_square );
    CHECK( created_end.native_origin() == coords::origin::relative );
    CHECK( created_end.native_scale() == coords::scale::map_square );
    CHECK( created_start == initial_start );
    CHECK( created_end == initial_end );

    const sol::object token_object = snapshot["token"];
    REQUIRE( token_object.is<sol::userdata>() );
    const sol::userdata token = token_object;
    REQUIRE( token.valid() );
    const sol::protected_function token_is_valid = token["is_valid"];

    const cata::lua_platform::script_tripoint_coord moved_start =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( -1, -2, 0 ).raw() );
    const cata::lua_platform::script_tripoint_coord moved_end =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( 3, 2, 0 ).raw() );
    const sol::protected_function set_position = zones["set_position"];
    const sol::protected_function_result set_position_result = set_position(
                token, moved_start, moved_end );
    REQUIRE( set_position_result.valid() );
    const sol::table set_position_envelope =
        set_position_result.get<sol::table>();
    REQUIRE( set_position_envelope["ok"].get<bool>() );
    const sol::table set_position_value =
        set_position_envelope["value"].get<sol::table>();
    REQUIRE( set_position_value.valid() );
    CHECK( set_position_value["changed"].get<bool>() );

    const sol::object after_start_object = set_position_value["after_start"];
    const sol::object after_end_object = set_position_value["after_end"];
    REQUIRE( after_start_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    REQUIRE( after_end_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    CHECK( after_start_object.as<cata::lua_platform::script_tripoint_coord>() ==
           moved_start );
    CHECK( after_end_object.as<cata::lua_platform::script_tripoint_coord>() ==
           moved_end );

    const sol::table moved_snapshot =
        set_position_value["zone"].get<sol::table>();
    REQUIRE( moved_snapshot.valid() );
    const sol::object moved_relative_start_object =
        moved_snapshot["relative_start"];
    const sol::object moved_relative_end_object =
        moved_snapshot["relative_end"];
    REQUIRE( moved_relative_start_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    REQUIRE( moved_relative_end_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    CHECK( moved_relative_start_object.as<
           cata::lua_platform::script_tripoint_coord>() == moved_start );
    CHECK( moved_relative_end_object.as<
           cata::lua_platform::script_tripoint_coord>() == moved_end );

    const sol::protected_function_result stale_after_move = token_is_valid(
                token );
    REQUIRE( stale_after_move.valid() );
    CHECK_FALSE( stale_after_move.get<bool>() );

    const sol::object moved_token_object = moved_snapshot["token"];
    REQUIRE( moved_token_object.is<sol::userdata>() );
    const sol::userdata moved_token = moved_token_object;
    REQUIRE( moved_token.valid() );
    const sol::protected_function moved_token_is_valid =
        moved_token["is_valid"];
    const sol::protected_function_result moved_token_valid =
        moved_token_is_valid( moved_token );
    REQUIRE( moved_token_valid.valid() );
    CHECK( moved_token_valid.get<bool>() );

    const sol::protected_function remove = zones["remove"];
    const sol::protected_function_result remove_result = remove( moved_token );
    REQUIRE( remove_result.valid() );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["removed"].get<bool>() );

    const sol::protected_function_result stale_after_remove =
        moved_token_is_valid( moved_token );
    REQUIRE( stale_after_remove.valid() );
    CHECK_FALSE( stale_after_remove.get<bool>() );
}

TEST_CASE( "lua_platform_weather_read_contract_uses_weather_service",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    const sol::table weather = fixture.services["weather"];
    REQUIRE( weather.valid() );
    CHECK( weather["types"].valid() );
    CHECK( weather["type"].valid() );
    CHECK( weather["current"].valid() );
    CHECK( weather["generator"].valid() );
    CHECK( weather["forecast"].valid() );
    CHECK( weather["limits"].valid() );
    CHECK_FALSE( fixture.services["world"].valid() );
    CHECK_FALSE( fixture.services["game"].valid() );

    const sol::protected_function types = weather["types"];
    const sol::protected_function_result types_result = types();
    REQUIRE( types_result.valid() );

    const sol::protected_function type = weather["type"];
    const cata::lua_platform::script_game_id valid_id(
        "weather_type", "clear" );
    const sol::protected_function_result valid_type = type( valid_id );
    REQUIRE( valid_type.valid() );
    REQUIRE( valid_type.get<sol::table>().valid() );

    const cata::lua_platform::script_game_id invalid_id(
        "weather_type", "missing_weather_type" );
    const sol::protected_function_result invalid_type = type( invalid_id );
    CHECK_FALSE( invalid_type.valid() );

    REQUIRE( g != nullptr );
    const sol::protected_function_result current_result =
        weather["current"]();
    REQUIRE( current_result.valid() );
    CHECK( current_result.get<sol::table>().valid() );

    const sol::protected_function_result generator_result =
        weather["generator"]();
    REQUIRE( generator_result.valid() );
    const sol::protected_function_result forecast_result =
        weather["forecast"]();
    REQUIRE( forecast_result.valid() );
    const sol::protected_function_result limits_result =
        weather["limits"]();
    REQUIRE( limits_result.valid() );

    CHECK( fixture.read_gate_calls > 0 );
    CHECK( fixture.write_gate_calls == 0 );
}

TEST_CASE( "lua_platform_item_category_spawn_rate_service_surface_and_basic_mutations",
           "[lua][platform][item_categories][spawn_rate]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_item_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table item_categories = services["item_categories"];
    REQUIRE( item_categories.valid() );
    CHECK( item_categories["spawn_rate"].valid() );
    CHECK( item_categories["set_spawn_rate"].valid() );
    CHECK( item_categories["set_spawn_rates"].valid() );
    const sol::table items = services["items"];
    REQUIRE( items.valid() );
    CHECK_FALSE( items["spawn_rate"].valid() );
    CHECK_FALSE( items["set_spawn_rate"].valid() );
    CHECK_FALSE( items["set_spawn_rates"].valid() );

    const cata::lua_platform::script_game_id food(
        "item_category", "food" );
    const cata::lua_platform::script_game_id tools(
        "item_category", "tools" );
    const item_category_id food_id( "food" );
    const item_category_id tools_id( "tools" );
    REQUIRE( food_id.is_valid() );
    REQUIRE( tools_id.is_valid() );
    const float food_before = food_id.obj().get_spawn_rate();
    const float tools_before = tools_id.obj().get_spawn_rate();
    on_out_of_scope restore_rates( [food_before, tools_before]() {
        item_category_id( "food" ).obj().set_spawn_rate( food_before );
        item_category_id( "tools" ).obj().set_spawn_rate( tools_before );
    } );

    const sol::protected_function read = item_categories["spawn_rate"];
    const sol::protected_function_result read_result = read( food );
    REQUIRE( read_result.valid() );
    const sol::table read_envelope = read_result.get<sol::table>();
    REQUIRE( read_envelope["ok"].get<bool>() );
    CHECK( read_envelope["value"].get<float>() == food_before );

    const sol::protected_function set = item_categories["set_spawn_rate"];
    const sol::protected_function_result set_result = set( food, 7.5 );
    REQUIRE( set_result.valid() );
    const sol::table set_envelope = set_result.get<sol::table>();
    REQUIRE( set_envelope["ok"].get<bool>() );
    const sol::table set_value = set_envelope["value"].get<sol::table>();
    CHECK( set_value["id"].get<cata::lua_platform::script_game_id>() == food );
    CHECK( set_value["before"].get<float>() == food_before );
    CHECK( set_value["after"].get<float>() == 7.5F );
    CHECK( set_value["changed"].get<bool>() );

    sol::table batch = lua.create_table();
    batch[1] = lua.create_table_with(
                   "id", tools, "spawn_rate", 2.5 );
    batch[2] = lua.create_table_with(
                   "id", food, "spawn_rate", 3.5 );
    const sol::protected_function set_batch = item_categories["set_spawn_rates"];
    const sol::protected_function_result batch_result = set_batch( batch );
    REQUIRE( batch_result.valid() );
    const sol::table batch_envelope = batch_result.get<sol::table>();
    REQUIRE( batch_envelope["ok"].get<bool>() );
    const sol::table batch_value = batch_envelope["value"].get<sol::table>();
    CHECK( batch_value["count"].get<lua_Integer>() == 2 );
    const sol::table batch_items = batch_value["items"].get<sol::table>();
    CHECK( batch_items[1].get<sol::table>()["id"].get<
           cata::lua_platform::script_game_id>() == tools );
    CHECK( batch_items[1].get<sol::table>()["before"].get<float>() == tools_before );
    CHECK( batch_items[1].get<sol::table>()["after"].get<float>() == 2.5F );
    CHECK( batch_items[2].get<sol::table>()["before"].get<float>() == 7.5F );
    CHECK( batch_items[2].get<sol::table>()["after"].get<float>() == 3.5F );
    CHECK( food_id.obj().get_spawn_rate() == 3.5F );
    CHECK( tools_id.obj().get_spawn_rate() == 2.5F );
}

TEST_CASE( "lua_platform_item_category_spawn_rates_fail_closed_without_mutation",
           "[lua][platform][item_categories][spawn_rate][validation]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_item_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const cata::lua_platform::script_game_id food(
        "item_category", "food" );
    const cata::lua_platform::script_game_id tools(
        "item_category", "tools" );
    const cata::lua_platform::script_game_id missing(
        "item_category", "missing_item_category" );
    const cata::lua_platform::script_game_id wrong_kind( "item", "rock" );
    const item_category_id food_id( "food" );
    const item_category_id tools_id( "tools" );
    REQUIRE( food_id.is_valid() );
    REQUIRE( tools_id.is_valid() );
    const float food_before = food_id.obj().get_spawn_rate();
    const float tools_before = tools_id.obj().get_spawn_rate();
    on_out_of_scope restore_rates( [food_before, tools_before]() {
        item_category_id( "food" ).obj().set_spawn_rate( food_before );
        item_category_id( "tools" ).obj().set_spawn_rate( tools_before );
    } );

    const sol::table item_categories = services["item_categories"];
    const sol::protected_function set = item_categories["set_spawn_rate"];
    const sol::protected_function set_batch = item_categories["set_spawn_rates"];
    const auto check_unchanged = [&]() {
        CHECK( food_id.obj().get_spawn_rate() == food_before );
        CHECK( tools_id.obj().get_spawn_rate() == tools_before );
    };
    const auto check_single_rejected = [&]( const cata::lua_platform::script_game_id &id,
            const double rate ) {
        const sol::protected_function_result result = set( id, rate );
        CHECK_FALSE( result.valid() );
        check_unchanged();
    };
    const auto make_update = [&lua]( const cata::lua_platform::script_game_id &id,
                                     const auto &rate ) {
        sol::table update = lua.create_table();
        update["id"] = id;
        update["spawn_rate"] = rate;
        return update;
    };
    const auto check_batch_rejected = [&]( const sol::table &batch ) {
        const sol::protected_function_result result = set_batch( batch );
        CHECK_FALSE( result.valid() );
        check_unchanged();
    };

    check_single_rejected( food, -0.1 );
    check_single_rejected( food, 1000000.1 );
    check_single_rejected( food, std::numeric_limits<double>::quiet_NaN() );
    check_single_rejected( food,
                           std::numeric_limits<double>::infinity() );
    check_single_rejected( missing, 2.0 );
    check_single_rejected( wrong_kind, 2.0 );

    sol::table duplicate = lua.create_table();
    duplicate[1] = make_update( food, 11.0 );
    duplicate[2] = make_update( food, 12.0 );
    check_batch_rejected( duplicate );

    sol::table invalid_category = lua.create_table();
    invalid_category[1] = make_update( missing, 11.0 );
    check_batch_rejected( invalid_category );

    sol::table valid_then_invalid = lua.create_table();
    valid_then_invalid[1] = make_update( tools, 11.0 );
    valid_then_invalid[2] = make_update( missing, 12.0 );
    check_batch_rejected( valid_then_invalid );

    sol::table wrong_category_kind = lua.create_table();
    wrong_category_kind[1] = make_update( wrong_kind, 11.0 );
    check_batch_rejected( wrong_category_kind );

    sol::table nan_rate = lua.create_table();
    nan_rate[1] = make_update(
                       food, std::numeric_limits<double>::quiet_NaN() );
    check_batch_rejected( nan_rate );

    sol::table infinite_rate = lua.create_table();
    infinite_rate[1] = make_update(
                            food, std::numeric_limits<double>::infinity() );
    check_batch_rejected( infinite_rate );

    sol::table negative_rate = lua.create_table();
    negative_rate[1] = make_update( food, -0.1 );
    check_batch_rejected( negative_rate );

    sol::table excessive_rate = lua.create_table();
    excessive_rate[1] = make_update( food, 1000000.1 );
    check_batch_rejected( excessive_rate );

    sol::table invalid_rate_type = lua.create_table();
    sol::table invalid_rate_entry = lua.create_table();
    invalid_rate_entry["id"] = food;
    invalid_rate_entry["spawn_rate"] = true;
    invalid_rate_type[1] = std::move( invalid_rate_entry );
    check_batch_rejected( invalid_rate_type );

    sol::table too_many = lua.create_table();
    for( int index = 1; index <= 257; ++index ) {
        too_many[index] = make_update( food, 1.0 );
    }
    check_batch_rejected( too_many );
}

TEST_CASE( "lua_platform_hordes_read_surface_is_registered",
           "[lua][platform][hordes][contract]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_horde_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::object hordes_object = services["hordes"];
    REQUIRE( hordes_object.is<sol::table>() );
    const sol::table hordes = hordes_object.as<sol::table>();
    CHECK( hordes["limits"].get_type() == sol::type::function );
    CHECK( hordes["definitions"].get_type() == sol::type::function );
    CHECK( hordes["definition"].get_type() == sol::type::function );
    CHECK( hordes["monsters"].get_type() == sol::type::function );
    CHECK( hordes["contains"].get_type() == sol::type::function );
    CHECK( hordes["entities"].get_type() == sol::type::function );
    CHECK( hordes["entity"].get_type() == sol::type::function );
    CHECK( hordes["legacy_groups"].get_type() == sol::type::function );
    CHECK( hordes["legacy_group"].get_type() == sol::type::function );
    CHECK( hordes["summary"].get_type() == sol::type::function );
    CHECK( hordes["spawn_entity"].get_type() == sol::type::function );
    CHECK( hordes["alert_entity"].get_type() == sol::type::function );
    CHECK( hordes["remove_entity"].get_type() == sol::type::function );
    CHECK( hordes["spawn_legacy_group"].get_type() == sol::type::function );
    CHECK( hordes["update_legacy_group"].get_type() == sol::type::function );
    CHECK( hordes["remove_legacy_group"].get_type() == sol::type::function );
    CHECK_FALSE( hordes["signal"].valid() );
    CHECK_FALSE( hordes["advance"].valid() );
}

TEST_CASE( "lua_platform_hordes_alert_entity_commits_with_before_and_after",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const cata::lua_platform::script_tripoint_coord position =
        make_position( tripoint_abs_ms( 1000, 1000, 0 ) );
    const cata::lua_platform::script_tripoint_coord original_destination =
        make_position( tripoint_abs_ms( 0, 0, 0 ) );
    const cata::lua_platform::script_tripoint_coord new_destination =
        make_position( tripoint_abs_ms( 1020, 1010, 0 ) );
    constexpr int original_intensity = 0;
    constexpr int new_intensity = 31;

    const sol::protected_function_result spawn_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    CHECK( spawn_value["status"].get<std::string>() == "committed" );
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_entity"]( token );
    } );

    const sol::protected_function_result alert_result =
        hordes["alert_entity"]( token, new_destination, new_intensity );
    REQUIRE( alert_result.valid() );
    const sol::table alert_envelope = alert_result.get<sol::table>();
    REQUIRE( alert_envelope["ok"].get<bool>() );
    const sol::table alert_value = alert_envelope["value"].get<sol::table>();
    CHECK( alert_value["status"].get<std::string>() == "committed" );

    const sol::table before = alert_value["before"].get<sol::table>();
    const sol::table after = alert_value["after"].get<sol::table>();
    REQUIRE( before.valid() );
    REQUIRE( after.valid() );
    CHECK( before["destination"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           original_destination );
    CHECK( before["tracking_intensity"].get<int>() == original_intensity );
    CHECK( after["destination"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           new_destination );
    CHECK( after["tracking_intensity"].get<int>() == new_intensity );
    CHECK( after["token"].get<sol::userdata>()
           ["identity_generation"].get<std::size_t>() ==
           token["identity_generation"].get<std::size_t>() );
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );
}

TEST_CASE( "lua_platform_hordes_alert_entity_invalid_intensity_is_unchanged",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const cata::lua_platform::script_tripoint_coord position =
        make_position( tripoint_abs_ms( 1100, 1000, 0 ) );
    const cata::lua_platform::script_tripoint_coord original_destination =
        make_position( tripoint_abs_ms( 0, 0, 0 ) );
    const cata::lua_platform::script_tripoint_coord committed_destination =
        make_position( tripoint_abs_ms( 1120, 1010, 0 ) );
    constexpr int original_intensity = 0;
    constexpr int committed_intensity = 37;

    const sol::protected_function_result spawn_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    CHECK( spawn_value["status"].get<std::string>() == "committed" );
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_entity"]( token );
    } );

    const sol::protected_function_result invalid_result =
        hordes["alert_entity"]( token, committed_destination, -1 );
    CHECK_FALSE( invalid_result.valid() );

    // There is no public injection seam for making the post-insert token
    // resolution fail, so that post-commit rollback branch remains uncovered.
    const sol::protected_function_result committed_result =
        hordes["alert_entity"](
            token, committed_destination, committed_intensity );
    REQUIRE( committed_result.valid() );
    const sol::table committed_envelope = committed_result.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    const sol::table committed_value =
        committed_envelope["value"].get<sol::table>();
    CHECK( committed_value["status"].get<std::string>() == "committed" );
    const sol::table before = committed_value["before"].get<sol::table>();
    REQUIRE( before.valid() );
    CHECK( before["destination"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           original_destination );
    CHECK( before["tracking_intensity"].get<int>() == original_intensity );
}

TEST_CASE( "lua_platform_hordes_update_legacy_group_commits_multi_field_update",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_sm &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   position.raw() );
    };
    const tripoint_abs_sm group_position = get_map().get_abs_sub();
    const tripoint_abs_sm original_target_position(
        group_position.x() + 2, group_position.y() + 3,
        group_position.z() );
    const tripoint_abs_sm original_nemesis_target_position(
        group_position.x() - 4, group_position.y() + 1,
        group_position.z() );
    const tripoint_abs_sm updated_target_position(
        group_position.x() + 8, group_position.y() - 2,
        group_position.z() );
    const tripoint_abs_sm updated_nemesis_target_position(
        group_position.x() - 6, group_position.y() - 5,
        group_position.z() );

    sol::table spawn_options = lua.create_table();
    spawn_options["group"] = cata::lua_platform::script_game_id(
                                  "monster_group", "GROUP_ZOMBIE" );
    spawn_options["position"] = make_position( group_position );
    spawn_options["population"] = 111;
    spawn_options["interest"] = 27;
    spawn_options["dying"] = false;
    spawn_options["horde"] = true;
    spawn_options["behavior"] = "roam";
    spawn_options["target"] = make_position( original_target_position );
    spawn_options["nemesis_target"] =
        make_position( original_nemesis_target_position );

    const sol::protected_function_result spawn_result =
        hordes["spawn_legacy_group"]( spawn_options );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    CHECK( spawn_value["status"].get<std::string>() == "committed" );
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_legacy_group"]( token );
    } );

    sol::table update_options = lua.create_table();
    update_options["population"] = 456;
    update_options["interest"] = 83;
    update_options["dying"] = true;
    update_options["horde"] = false;
    update_options["behavior"] = "nemesis";
    update_options["target"] = make_position( updated_target_position );
    update_options["nemesis_target"] =
        make_position( updated_nemesis_target_position );

    const sol::protected_function_result update_result =
        hordes["update_legacy_group"]( token, update_options );
    REQUIRE( update_result.valid() );
    const sol::table update_envelope = update_result.get<sol::table>();
    REQUIRE( update_envelope["ok"].get<bool>() );
    const sol::table update_value = update_envelope["value"].get<sol::table>();
    CHECK( update_value["status"].get<std::string>() == "committed" );
    const sol::table before = update_value["before"].get<sol::table>();
    const sol::table after = update_value["after"].get<sol::table>();
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );

    CHECK( before["population"].get<unsigned int>() == 111U );
    CHECK( before["interest"].get<int>() == 27 );
    CHECK_FALSE( before["dying"].get<bool>() );
    CHECK( before["horde"].get<bool>() );
    CHECK( before["behavior"].get<std::string>() == "roam" );
    CHECK( before["target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_target_position ) );
    CHECK( before["nemesis_target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_nemesis_target_position ) );

    CHECK( after["population"].get<unsigned int>() == 456U );
    CHECK( after["interest"].get<int>() == 83 );
    CHECK( after["dying"].get<bool>() );
    CHECK_FALSE( after["horde"].get<bool>() );
    CHECK( after["behavior"].get<std::string>() == "nemesis" );
    CHECK( after["target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( updated_target_position ) );
    CHECK( after["nemesis_target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( updated_nemesis_target_position ) );
}

TEST_CASE( "lua_platform_hordes_update_legacy_group_invalid_target_is_unchanged",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 1 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 1 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_sm &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   position.raw() );
    };
    const tripoint_abs_sm group_position = get_map().get_abs_sub();
    const tripoint_abs_sm original_target_position(
        group_position.x() + 3, group_position.y() + 2,
        group_position.z() );
    const tripoint_abs_sm original_nemesis_target_position(
        group_position.x() - 2, group_position.y() - 3,
        group_position.z() );
    const tripoint_abs_sm invalid_target_position(
        group_position.x() + 7, group_position.y() + 7,
        group_position.z() + 1 );

    sol::table spawn_options = lua.create_table();
    spawn_options["group"] = cata::lua_platform::script_game_id(
                                  "monster_group", "GROUP_ZOMBIE" );
    spawn_options["position"] = make_position( group_position );
    spawn_options["population"] = 222;
    spawn_options["interest"] = 36;
    spawn_options["dying"] = false;
    spawn_options["horde"] = true;
    spawn_options["behavior"] = "roam";
    spawn_options["target"] = make_position( original_target_position );
    spawn_options["nemesis_target"] =
        make_position( original_nemesis_target_position );

    const sol::protected_function_result spawn_result =
        hordes["spawn_legacy_group"]( spawn_options );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::table spawn_value = spawn_envelope["value"].get<sol::table>();
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );

    on_out_of_scope cleanup( [&hordes, token]() {
        hordes["remove_legacy_group"]( token );
    } );

    sol::table invalid_options = lua.create_table();
    invalid_options["population"] = 777;
    invalid_options["interest"] = 91;
    invalid_options["dying"] = true;
    invalid_options["horde"] = false;
    invalid_options["behavior"] = "nemesis";
    invalid_options["target"] = make_position( invalid_target_position );
    invalid_options["nemesis_target"] =
        make_position( tripoint_abs_sm(
                           group_position.x() - 8,
                           group_position.y() + 6,
                           group_position.z() ) );

    const sol::protected_function_result invalid_result =
        hordes["update_legacy_group"]( token, invalid_options );
    CHECK_FALSE( invalid_result.valid() );

    const sol::protected_function_result read_result =
        hordes["legacy_group"]( token );
    REQUIRE( read_result.valid() );
    const sol::table read_envelope = read_result.get<sol::table>();
    REQUIRE( read_envelope["ok"].get<bool>() );
    const sol::table after = read_envelope["value"].get<sol::table>();

    CHECK( after["population"].get<unsigned int>() == 222U );
    CHECK( after["interest"].get<int>() == 36 );
    CHECK_FALSE( after["dying"].get<bool>() );
    CHECK( after["horde"].get<bool>() );
    CHECK( after["behavior"].get<std::string>() == "roam" );
    CHECK( after["target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_target_position ) );
    CHECK( after["nemesis_target"].get<
               cata::lua_platform::script_tripoint_coord>() ==
           make_position( original_nemesis_target_position ) );
}

TEST_CASE( "lua_platform_hordes_tokens_bind_identity_and_context",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 41 );
    cata::lua_platform::game_handle_runtime current_runtime = runtime;
    std::size_t current_world_generation = 9;
    cata::lua_platform::install_horde_api(
        services,
        [&current_runtime]() {
        return current_runtime;
    },
    [&current_world_generation]() {
        return current_world_generation;
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const tripoint_abs_ms native_position =
        project_to<coords::ms>( get_map().get_abs_sub() );
    const cata::lua_platform::script_tripoint_coord position =
        make_position( native_position );
    const sol::protected_function_result spawn_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( spawn_result.valid() );
    const sol::table spawn_envelope = spawn_result.get<sol::table>();
    REQUIRE( spawn_envelope["ok"].get<bool>() );
    const sol::userdata token =
        spawn_envelope["value"].get<sol::table>()["token"];
    REQUIRE( token.valid() );

    CHECK( token["runtime_generation"].get<std::size_t>() == 41 );
    CHECK( token["world_generation"].get<std::size_t>() == 9 );
    CHECK( token["owner_generation"].get<std::size_t>() > 0 );
    CHECK( token["identity_generation"].get<std::size_t>() > 0 );
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result duplicate_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( duplicate_result.valid() );
    CHECK( duplicate_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "occupied" );
    CHECK( token_is_valid( token ).get<bool>() );

    const auto other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    current_runtime = cata::lua_platform::game_handle_runtime(
                          other_owner, 41 );
    const sol::protected_function_result wrong_runtime_result =
        hordes["entity"]( token );
    REQUIRE( wrong_runtime_result.valid() );
    CHECK( wrong_runtime_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
    CHECK_FALSE( token_is_valid( token ).get<bool>() );

    current_runtime = runtime;
    current_world_generation = 10;
    const sol::protected_function_result wrong_world_result =
        hordes["entity"]( token );
    REQUIRE( wrong_world_result.valid() );
    CHECK( wrong_world_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_world" );

    current_world_generation = 9;
    const sol::protected_function_result remove_result =
        hordes["remove_entity"]( token );
    REQUIRE( remove_result.valid() );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["status"].get<std::string>() == "committed" );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["removed"].get<bool>() );
    CHECK_FALSE( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result replacement_result =
        hordes["spawn_entity"](
            position,
            cata::lua_platform::script_game_id( "monster", "mon_zombie" ) );
    REQUIRE( replacement_result.valid() );
    REQUIRE( replacement_result.get<sol::table>()["ok"].get<bool>() );
    const sol::userdata replacement_token =
        replacement_result.get<sol::table>()["value"].get<sol::table>()
        ["token"];
    REQUIRE( replacement_token.valid() );
    CHECK( token["identity_generation"].get<std::size_t>() !=
           replacement_token["identity_generation"].get<std::size_t>() );
    const sol::protected_function_result stale_replacement_read =
        hordes["entity"]( token );
    REQUIRE( stale_replacement_read.valid() );
    CHECK( stale_replacement_read.get<sol::table>()["error"]
           .get<sol::table>()["code"].get<std::string>() ==
           "missing_horde_entity" );

    const sol::protected_function_result replacement_remove_result =
        hordes["remove_entity"]( replacement_token );
    REQUIRE( replacement_remove_result.valid() );
    REQUIRE( replacement_remove_result.get<sol::table>()["ok"].get<bool>() );

    cata::lua_platform::reset_horde_tokens();
    const sol::protected_function_result stale_owner_result =
        hordes["entity"]( token );
    REQUIRE( stale_owner_result.valid() );
    CHECK( stale_owner_result.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_owner" );
}

TEST_CASE( "lua_platform_hordes_entity_pages_are_stable_and_bounded",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 42 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 11 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_map_position = []( const tripoint_abs_ms &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::map_square,
                   position.raw() );
    };
    const auto make_omt_position = []( const tripoint_abs_omt &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::overmap_terrain,
                   position.raw() );
    };
    const tripoint_abs_ms first_position =
        project_to<coords::ms>( get_map().get_abs_sub() );
    const tripoint_abs_ms second_position(
        first_position.x() + 1, first_position.y(), first_position.z() );
    const cata::lua_platform::script_game_id zombie_id(
        "monster", "mon_zombie" );
    const sol::protected_function_result first_spawn =
        hordes["spawn_entity"]( make_map_position( first_position ), zombie_id );
    const sol::protected_function_result second_spawn =
        hordes["spawn_entity"]( make_map_position( second_position ), zombie_id );
    REQUIRE( first_spawn.valid() );
    REQUIRE( second_spawn.valid() );
    REQUIRE( first_spawn.get<sol::table>()["ok"].get<bool>() );
    REQUIRE( second_spawn.get<sol::table>()["ok"].get<bool>() );
    const sol::userdata first_token =
        first_spawn.get<sol::table>()["value"].get<sol::table>()["token"];
    const sol::userdata second_token =
        second_spawn.get<sol::table>()["value"].get<sol::table>()["token"];
    on_out_of_scope cleanup( [&hordes, first_token, second_token]() {
        hordes["remove_entity"]( first_token );
        hordes["remove_entity"]( second_token );
    } );

    sol::table options = lua.create_table();
    options["radius"] = 0;
    options["limit"] = 1;
    options["monster"] = zombie_id;
    const cata::lua_platform::script_tripoint_coord center =
        make_omt_position( project_to<coords::omt>( first_position ) );

    const sol::protected_function_result first_page_result =
        hordes["entities"]( center, options );
    REQUIRE( first_page_result.valid() );
    const sol::table first_page = first_page_result.get<sol::table>();
    REQUIRE( first_page["total"].get<std::size_t>() >= 2 );
    REQUIRE( first_page["returned"].get<std::size_t>() == 1 );
    REQUIRE( first_page["has_more"].get<bool>() );

    options["offset"] = 1;
    const sol::protected_function_result second_page_result =
        hordes["entities"]( center, options );
    REQUIRE( second_page_result.valid() );
    const sol::table second_page = second_page_result.get<sol::table>();
    REQUIRE( second_page["returned"].get<std::size_t>() == 1 );
    const sol::table first_page_item =
        first_page["items"].get<sol::table>()[1].get<sol::table>();
    const sol::table second_page_item =
        second_page["items"].get<sol::table>()[1].get<sol::table>();
    const sol::userdata first_page_token = first_page_item["token"];
    const sol::userdata second_page_token = second_page_item["token"];
    CHECK( first_page_token["identity_generation"].get<std::size_t>() !=
           second_page_token["identity_generation"].get<std::size_t>() );
}

TEST_CASE( "lua_platform_hordes_remove_legacy_group_is_single_commit",
           "[lua][platform][hordes]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime active_runtime(
        runtime_owner, 43 );
    cata::lua_platform::install_horde_api(
        services,
        [active_runtime]() {
        return active_runtime;
    },
    []() {
        return std::size_t( 12 );
    },
    []() {}, []() {} );

    const sol::table hordes = services["hordes"];
    const auto make_position = []( const tripoint_abs_sm &position ) {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs, coords::scale::submap,
                   position.raw() );
    };
    const tripoint_abs_sm position = get_map().get_abs_sub();
    sol::table options = lua.create_table();
    options["group"] = cata::lua_platform::script_game_id(
                             "monster_group", "GROUP_ZOMBIE" );
    options["position"] = make_position( position );
    options["population"] = 73;
    options["horde"] = true;
    options["behavior"] = "roam";
    const sol::protected_function_result spawn_result =
        hordes["spawn_legacy_group"]( options );
    REQUIRE( spawn_result.valid() );
    REQUIRE( spawn_result.get<sol::table>()["ok"].get<bool>() );
    const sol::table spawn_value =
        spawn_result.get<sol::table>()["value"].get<sol::table>();
    const sol::userdata token = spawn_value["token"];
    REQUIRE( token.valid() );
    CHECK( token["owner_generation"].get<std::size_t>() > 0 );
    CHECK( token["identity_generation"].get<std::size_t>() > 0 );
    const sol::protected_function token_is_valid = token["is_valid"];
    REQUIRE( token_is_valid( token ).valid() );
    CHECK( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result remove_result =
        hordes["remove_legacy_group"]( token );
    REQUIRE( remove_result.valid() );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    const sol::table remove_value = remove_envelope["value"].get<sol::table>();
    CHECK( remove_value["status"].get<std::string>() == "committed" );
    CHECK( remove_value["removed"].get<bool>() );
    CHECK_FALSE( token_is_valid( token ).get<bool>() );

    const sol::protected_function_result stale_read =
        hordes["legacy_group"]( token );
    REQUIRE( stale_read.valid() );
    CHECK( stale_read.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "missing_legacy_horde" );

    const sol::protected_function_result replacement_result =
        hordes["spawn_legacy_group"]( options );
    REQUIRE( replacement_result.valid() );
    REQUIRE( replacement_result.get<sol::table>()["ok"].get<bool>() );
    const sol::userdata replacement_token =
        replacement_result.get<sol::table>()["value"].get<sol::table>()
        ["token"];
    REQUIRE( replacement_token.valid() );
    CHECK( token["identity_generation"].get<std::size_t>() !=
           replacement_token["identity_generation"].get<std::size_t>() );
    const sol::protected_function_result stale_replacement_read =
        hordes["legacy_group"]( token );
    REQUIRE( stale_replacement_read.valid() );
    CHECK( stale_replacement_read.get<sol::table>()["error"]
           .get<sol::table>()["code"].get<std::string>() ==
           "missing_legacy_horde" );

    const sol::protected_function_result replacement_remove =
        hordes["remove_legacy_group"]( replacement_token );
    REQUIRE( replacement_remove.valid() );
    REQUIRE( replacement_remove.get<sol::table>()["ok"].get<bool>() );
}

TEST_CASE( "lua_platform_weather_write_contract_exposes_controls_and_limits",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    const sol::table weather = fixture.services["weather"];
    REQUIRE( weather.valid() );
    CHECK( weather["set_override"].valid() );
    CHECK( weather["clear_override"].valid() );
    CHECK( weather["set_temperature_override"].valid() );
    CHECK( weather["clear_temperature_override"].valid() );
    CHECK( weather["set_wind"].valid() );
    CHECK( weather["clear_overrides"].valid() );
    CHECK( weather["refresh"].valid() );
    CHECK( weather["activate_lightning"].valid() );
    CHECK( weather["override_light"].valid() );
    CHECK_FALSE( fixture.services["gameplay"].valid() );

    const sol::protected_function_result limits_result = weather["limits"]();
    REQUIRE( limits_result.valid() );
    const sol::table limits = limits_result.get<sol::table>();
    REQUIRE( limits.valid() );
    CHECK( limits["maximum_pending_custom_light_events"].get<int>() == 256 );
    CHECK( limits["maximum_wind_direction_degrees"].get<int>() == 359 );
    CHECK( limits["maximum_custom_light_level"].get<int>() == 1000000 );
}

TEST_CASE( "lua_platform_weather_write_controls_apply_valid_overrides",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    REQUIRE( g != nullptr );
    weather_manager &weather_manager_ref = get_weather();
    const units::temperature saved_temperature = weather_manager_ref.temperature;
    const bool saved_lightning_active = weather_manager_ref.lightning_active;
    const weather_type_id saved_weather_id = weather_manager_ref.weather_id;
    const int saved_winddirection = weather_manager_ref.winddirection;
    const int saved_windspeed = weather_manager_ref.windspeed;
    const bool saved_weather_changed = weather_manager_ref.weather_changed;
    const weather_type_id saved_weather_override =
        weather_manager_ref.weather_override;
    const std::optional<units::temperature> saved_forced_temperature =
        weather_manager_ref.forced_temperature;
    const std::optional<int> saved_wind_direction_override =
        weather_manager_ref.wind_direction_override;
    const std::optional<int> saved_windspeed_override =
        weather_manager_ref.windspeed_override;
    const time_point saved_nextweather = weather_manager_ref.nextweather;
    const auto saved_temperature_cache = weather_manager_ref.temperature_cache;
    using weather_precise_type = std::remove_cv_t<std::remove_reference_t<
        decltype( *weather_manager_ref.weather_precise )>>;
    constexpr bool weather_precise_copyable =
        std::is_copy_constructible_v<weather_precise_type> &&
        std::is_copy_assignable_v<weather_precise_type>;
    std::shared_ptr<const weather_precise_type> saved_weather_precise;
    if constexpr( weather_precise_copyable ) {
        saved_weather_precise = std::make_shared<weather_precise_type>(
                                    *weather_manager_ref.weather_precise );
    }
    on_out_of_scope restore_weather( [&weather_manager_ref,
                                      saved_temperature,
                                      saved_lightning_active,
                                      saved_weather_id,
                                      saved_winddirection,
                                      saved_windspeed,
                                      saved_weather_changed,
                                      saved_weather_override,
                                      saved_forced_temperature,
                                      saved_wind_direction_override,
                                      saved_windspeed_override,
                                      saved_nextweather,
                                      saved_temperature_cache,
                                      saved_weather_precise]() {
        weather_manager_ref.temperature = saved_temperature;
        weather_manager_ref.lightning_active = saved_lightning_active;
        weather_manager_ref.weather_id = saved_weather_id;
        weather_manager_ref.winddirection = saved_winddirection;
        weather_manager_ref.windspeed = saved_windspeed;
        weather_manager_ref.weather_changed = saved_weather_changed;
        weather_manager_ref.weather_override = saved_weather_override;
        weather_manager_ref.forced_temperature = saved_forced_temperature;
        weather_manager_ref.wind_direction_override = saved_wind_direction_override;
        weather_manager_ref.windspeed_override = saved_windspeed_override;
        weather_manager_ref.nextweather = saved_nextweather;
        weather_manager_ref.temperature_cache = saved_temperature_cache;
        if constexpr( weather_precise_copyable ) {
            *weather_manager_ref.weather_precise = *saved_weather_precise;
        }
    } );

    const sol::table weather = fixture.services["weather"];
    REQUIRE( weather.valid() );
    if constexpr( weather_precise_copyable ) {
        const sol::protected_function set_override = weather["set_override"];
        const cata::lua_platform::script_game_id clear_weather(
            "weather_type", "clear" );
        const sol::protected_function_result set_override_result =
            set_override( clear_weather );
        REQUIRE( set_override_result.valid() );
        const sol::table set_override_envelope =
            set_override_result.get<sol::table>();
        REQUIRE( set_override_envelope.valid() );
        REQUIRE( set_override_envelope["ok"].get<bool>() );
        CHECK( fixture.write_gate_calls == 1 );
        const sol::table set_override_snapshot =
            set_override_envelope["value"].get<sol::table>();
        REQUIRE( set_override_snapshot.valid() );
        const sol::object weather_override =
            set_override_snapshot["weather_override"];
        REQUIRE( weather_override.is<cata::lua_platform::script_game_id>() );
        CHECK( weather_override.as<cata::lua_platform::script_game_id>() ==
               clear_weather );
    }

    const sol::protected_function set_temperature_override =
        weather["set_temperature_override"];

    const cata::lua_platform::script_unit_value kelvin_temperature =
        cata::lua_platform::script_unit_value::from(
            "temperature", 273.15, "kelvin" );
    const sol::protected_function_result set_temperature_result =
        set_temperature_override( kelvin_temperature );
    REQUIRE( set_temperature_result.valid() );
    const sol::table set_temperature_envelope =
        set_temperature_result.get<sol::table>();
    REQUIRE( set_temperature_envelope.valid() );
    REQUIRE( set_temperature_envelope["ok"].get<bool>() );
    CHECK( fixture.write_gate_calls == ( weather_precise_copyable ? 2 : 1 ) );
    const sol::table set_temperature_snapshot =
        set_temperature_envelope["value"].get<sol::table>();
    REQUIRE( set_temperature_snapshot.valid() );
    const sol::object temperature_override =
        set_temperature_snapshot["temperature_override"];
    REQUIRE( temperature_override.is<cata::lua_platform::script_unit_value>() );
    CHECK( temperature_override.as<cata::lua_platform::script_unit_value>()
           .value_as( "kelvin" ) == Approx( 273.15 ).margin( 0.01 ) );
}

TEST_CASE( "lua_platform_content_finalization_is_single_use_and_rollback_is_terminal",
           "[lua][platform][content]" )
{
    cata::lua_platform::content_transaction transaction( "registrar_test", 1 );
    std::string error;
    REQUIRE( transaction.apply( error ) );
    REQUIRE( transaction.validate_finalized( error ) );
    CHECK_FALSE( transaction.validate_finalized( error ) );
    CHECK( error.find( "already validated" ) != std::string::npos );

    transaction.rollback();
    CHECK_FALSE( transaction.apply( error ) );
    CHECK( error.find( "no longer building" ) != std::string::npos );
}

TEST_CASE( "lua_platform_world_registrar_finalization_failure_boundary_is_terminal",
           "[lua][platform][content]" )
{
    cata::lua_platform::world_content_transaction transaction( "world_test", 1 );
    std::string error;
    CHECK_FALSE( transaction.validate_finalized( error ) );
    CHECK( error.find( "not applied" ) != std::string::npos );
    REQUIRE( transaction.apply( error ) );
    REQUIRE( transaction.validate_finalized( error ) );
    CHECK_FALSE( transaction.validate_finalized( error ) );
    CHECK( error.find( "already validated" ) != std::string::npos );

    transaction.rollback();
    CHECK_FALSE( transaction.apply( error ) );
    CHECK( error.find( "no longer building" ) != std::string::npos );
}

TEST_CASE( "lua_platform_mission_tokens_reject_replacement_and_stale_context",
           "[lua][platform][missions]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 61 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 61 );
    const cata::lua_platform::mission_token original(
        7001, 3, runtime, 17 );
    const cata::lua_platform::mission_token same_instance(
        7001, 3, runtime, 17 );
    const cata::lua_platform::mission_token replacement(
        7001, 4, runtime, 17 );
    const cata::lua_platform::mission_token other_world(
        7001, 3, runtime, 18 );
    const cata::lua_platform::mission_token other_owner_token(
        7001, 3, other_runtime, 17 );

    CHECK( original == same_instance );
    CHECK_FALSE( original == replacement );
    CHECK_FALSE( original == other_world );
    CHECK_FALSE( original == other_owner_token );
    CHECK( original.belongs_to( runtime ) );
    CHECK_FALSE( original.belongs_to( other_runtime ) );
    CHECK( original.identity_generation() == 3 );
    CHECK( replacement.identity_generation() == 4 );

    owner->retire();
    CHECK_FALSE( original.belongs_to( runtime ) );
}

TEST_CASE( "lua_platform_mission_api_requires_explicit_owner_and_generation",
           "[lua][platform][missions]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 62 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 62 );
    cata::lua_platform::game_handle_runtime active_runtime = runtime;
    std::size_t active_world = 19;
    bool read_gate_called = false;
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return active_world;
    },
    [&]() {
        read_gate_called = true;
    } );
    cata::lua_platform::install_mission_api(
        services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return active_world;
    },
    [&]() {
        read_gate_called = true;
    },
    [&]() {
        write_gate_called = true;
    } );

    const sol::table missions = services["missions"];
    CHECK_FALSE( missions["current"].valid() );
    CHECK_FALSE( missions["avatar_has_active"].valid() );
    const cata::lua_platform::mission_token token(
        7002, 1, runtime, active_world );
    const sol::protected_function get = missions["get"];

    active_runtime = other_runtime;
    const sol::protected_function_result wrong_owner = get( token );
    REQUIRE( wrong_owner.valid() );
    const sol::table wrong_owner_result = wrong_owner.get<sol::table>();
    CHECK_FALSE( wrong_owner_result["ok"].get<bool>() );
    CHECK( wrong_owner_result["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );

    active_runtime = runtime;
    active_world = 20;
    const sol::protected_function_result wrong_world = get( token );
    REQUIRE( wrong_world.valid() );
    const sol::table wrong_world_result = wrong_world.get<sol::table>();
    CHECK_FALSE( wrong_world_result["ok"].get<bool>() );
    CHECK( wrong_world_result["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_world" );
    CHECK( read_gate_called );
    CHECK_FALSE( write_gate_called );
}

TEST_CASE( "lua_platform_npc_mission_provider_preflights_exact_owner_and_rollback",
           "[lua][platform][missions][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 63 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 63 );
    cata::lua_platform::game_handle_runtime active_runtime = runtime;
    const std::size_t world_generation = 21;
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return world_generation;
    },
    []() {} );
    cata::lua_platform::install_npc_api(
        services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return world_generation;
    },
    []() {},
    [&]() {
        write_gate_called = true;
    },
    []() {} );

    npc provider;
    provider.normalize();
    provider.setID( character_id( 7003 ), true );
    avatar explicit_owner;
    explicit_owner.normalize();
    explicit_owner.setID( character_id( 7004 ), true );
    avatar wrong_owner;
    wrong_owner.normalize();
    wrong_owner.setID( character_id( 7005 ), true );
    const cata::lua_platform::game_handle provider_handle =
        cata::lua_platform::game_handle::from_creature(
            provider, { "npc", 7003, 0, 0, 0, {} }, runtime, world_generation );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            explicit_owner, { "avatar", 7004, 0, 0, 0, {} }, runtime,
            world_generation );
    const cata::lua_platform::game_handle wrong_owner_handle =
        cata::lua_platform::game_handle::from_creature(
            wrong_owner, { "avatar", 7005, 0, 0, 0, {} }, other_runtime,
            world_generation );

    const sol::table npc_services = services["npcs"];
    const sol::table missions = npc_services["missions"];
    const sol::protected_function assign = missions["assign_selected"];
    const sol::protected_function_result no_selection =
        assign( provider_handle, owner_handle );
    REQUIRE( no_selection.valid() );
    const sol::table no_selection_result = no_selection.get<sol::table>();
    CHECK_FALSE( no_selection_result["ok"].get<bool>() );
    CHECK( no_selection_result["error"].get<sol::table>()["code"].get<std::string>() ==
           "no_selected_mission" );
    CHECK( provider.chatbin.missions.empty() );
    CHECK( provider.chatbin.missions_assigned.empty() );

    const sol::protected_function_result wrong_owner_result =
        assign( provider_handle, wrong_owner_handle );
    REQUIRE( wrong_owner_result.valid() );
    const sol::table wrong_owner_envelope = wrong_owner_result.get<sol::table>();
    CHECK_FALSE( wrong_owner_envelope["ok"].get<bool>() );
    CHECK( wrong_owner_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );

    const sol::protected_function reward = missions["claim_selected_reward"];
    const sol::protected_function_result reward_owner_result =
        reward( provider_handle, wrong_owner_handle );
    REQUIRE( reward_owner_result.valid() );
    const sol::table reward_owner_envelope = reward_owner_result.get<sol::table>();
    CHECK( reward_owner_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
    CHECK( write_gate_called );
}

TEST_CASE( "lua_platform_npc_mission_surface_is_explicit",
           "[lua][platform][missions][npc][contract]" )
{
    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 65 );
    constexpr std::size_t world_generation = 23;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services,
        [runtime]() {
        return runtime;
    },
    [world_generation]() {
        return world_generation;
    }, []() {} );
    cata::lua_platform::install_npc_api(
        services,
        [runtime]() {
        return runtime;
    },
    [world_generation]() {
        return world_generation;
    }, []() {}, []() {}, []() {} );

    const sol::table npcs = services["npcs"];
    REQUIRE( npcs.valid() );
    const sol::table missions = npcs["missions"];
    REQUIRE( missions.valid() );
    for( const char *name : {
             "state", "select", "offer", "add_assigned",
             "assign_selected", "succeed_selected", "fail_selected",
             "clear_selected", "claim_selected_reward"
         } ) {
        CHECK( missions[name].get_type() == sol::type::function );
    }

    CHECK_FALSE( missions["avatar"].valid() );
    CHECK_FALSE( missions["current_avatar"].valid() );
    CHECK_FALSE( missions["current_mission"].valid() );
    CHECK_FALSE( npcs["avatar"].valid() );
}

TEST_CASE( "lua_platform_npc_mission_provider_lifecycle_is_generation_safe",
           "[lua][platform][missions][npc]" )
{
    avatar owner;
    owner.normalize();
    owner.setID( character_id( 7303 ), true );
    clear_npcs();
    owner.reset_all_missions();
    mission::clear_all();
    struct mission_test_cleanup {
        avatar &owner;
        ~mission_test_cleanup() {
            owner.reset_all_missions();
            clear_npcs();
            mission::clear_all();
        }
    } cleanup{ owner };

    const character_id provider_id = get_map().place_npc(
                                         point_bub_ms( 25, 25 ),
                                         npc_template_id( "test_talker" ) );
    g->load_npcs();
    npc *provider = g->find_npc( provider_id );
    REQUIRE( provider != nullptr );
    provider->chatbin.missions.clear();
    provider->chatbin.missions_assigned.clear();
    provider->chatbin.mission_selected = nullptr;

    const auto runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 66 );
    const cata::lua_platform::game_handle_runtime other_runtime(
        other_runtime_owner, 66 );
    cata::lua_platform::game_handle_runtime active_runtime = runtime;
    std::size_t active_world = 24;
    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [&]() {
        return active_runtime;
    };
    const auto current_world = [&]() {
        return active_world;
    };
    cata::lua_platform::install_value_type_api(
        lua, services, []() {} );
    cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_mission_api(
        services, current_runtime, current_world, []() {}, []() {} );
    cata::lua_platform::install_npc_api(
        services, current_runtime, current_world, []() {}, []() {}, []() {} );

    const cata::lua_platform::game_handle provider_handle =
        cata::lua_platform::game_handle::from_creature(
            *provider,
            { "npc", provider_id.get_value(), 0, 0, 0, {} },
            runtime, active_world );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            owner,
            { "avatar", owner.getID().get_value(), 0, 0, 0, {} },
            runtime, active_world );
    avatar wrong_owner;
    wrong_owner.normalize();
    wrong_owner.setID( character_id( 7304 ), true );
    const cata::lua_platform::game_handle wrong_owner_handle =
        cata::lua_platform::game_handle::from_creature(
            wrong_owner, { "avatar", 7304, 0, 0, 0, {} },
            runtime, active_world );
    const cata::lua_platform::game_handle stale_owner_handle =
        cata::lua_platform::game_handle::from_creature(
            wrong_owner, { "avatar", 7304, 0, 0, 0, {} },
            other_runtime, active_world );
    npc wrong_provider;
    wrong_provider.normalize();
    wrong_provider.setID( character_id( 7305 ), true );
    const cata::lua_platform::game_handle wrong_provider_handle =
        cata::lua_platform::game_handle::from_creature(
            wrong_provider, { "npc", 7305, 0, 0, 0, {} },
            runtime, active_world );

    const sol::table missions = services["npcs"]["missions"];
    const sol::protected_function state = missions["state"];
    const sol::protected_function select = missions["select"];
    const sol::protected_function offer = missions["offer"];
    const sol::protected_function add_assigned = missions["add_assigned"];
    const sol::protected_function assign_selected =
        missions["assign_selected"];
    const sol::protected_function succeed_selected =
        missions["succeed_selected"];
    const sol::protected_function fail_selected =
        missions["fail_selected"];
    const sol::protected_function clear_selected =
        missions["clear_selected"];
    const sol::protected_function claim_selected_reward =
        missions["claim_selected_reward"];
    const cata::lua_platform::script_game_id mission_id(
        "mission", "TEST_MISSION_GENERIC_REWARD" );
    const cata::lua_platform::script_game_id no_generic_mission_id(
        "mission", "TEST_MISSION_NO_GENERIC_REWARD" );
    REQUIRE( mission_id.is_valid() );
    REQUIRE( no_generic_mission_id.is_valid() );

    const auto value_from = []( sol::protected_function_result result ) {
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        return envelope["value"].get<sol::table>();
    };
    const auto error_code = []( sol::protected_function_result result ) {
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        return envelope["error"].get<sol::table>()
               ["code"].get<std::string>();
    };

    sol::table initial_state = value_from( state( provider_handle ) );
    CHECK( initial_state["provider_id"].get<int>() == provider_id.get_value() );
    CHECK( initial_state["available"].get<sol::table>()
           ["returned"].get<int>() == 0 );
    CHECK( initial_state["assigned"].get<sol::table>()
           ["returned"].get<int>() == 0 );

    sol::table offer_value = value_from( offer( provider_handle, mission_id ) );
    const cata::lua_platform::mission_token offered_token =
        offer_value["mission"].get<sol::table>()
        ["token"].get<cata::lua_platform::mission_token>();
    CHECK( provider->chatbin.missions.size() == 1 );

    active_runtime = other_runtime;
    CHECK( error_code( select( provider_handle, offered_token ) ) ==
           "stale_runtime" );
    active_runtime = runtime;
    active_world = 25;
    CHECK( error_code( select( provider_handle, offered_token ) ) ==
           "stale_world" );
    active_world = 24;
    CHECK( error_code( select( wrong_provider_handle, offered_token ) ) ==
           "not_provided_here" );
    CHECK( provider->chatbin.mission_selected == nullptr );

    value_from( select( provider_handle, offered_token ) );
    CHECK( provider->chatbin.mission_selected != nullptr );
    CHECK( provider->chatbin.mission_selected->in_progress() == false );
    CHECK( error_code( add_assigned(
                           provider_handle, stale_owner_handle, mission_id ) ) ==
           "stale_runtime" );
    CHECK( provider->chatbin.missions.size() == 1 );
    CHECK( provider->chatbin.missions_assigned.empty() );

    value_from( assign_selected( provider_handle, owner_handle ) );
    CHECK( provider->chatbin.missions.empty() );
    CHECK( provider->chatbin.missions_assigned.size() == 1 );
    CHECK( owner.get_active_missions().size() == 1 );
    const int opinion_before_rejection = provider->op_of_u.value;
    CHECK( error_code( succeed_selected(
                           provider_handle, wrong_owner_handle, true ) ) ==
           "wrong_assignee" );
    CHECK( provider->op_of_u.value == opinion_before_rejection );
    CHECK( error_code( assign_selected( provider_handle, owner_handle ) ) ==
           "not_available" );
    CHECK( provider->chatbin.missions_assigned.size() == 1 );

    const int opinion_value_before_goal_rejection = provider->op_of_u.value;
    CHECK( error_code( succeed_selected(
                           provider_handle, owner_handle, false ) ) ==
           "goal_incomplete" );
    CHECK( provider->op_of_u.value == opinion_value_before_goal_rejection );
    CHECK( provider->chatbin.mission_selected->in_progress() );
    CHECK( error_code( clear_selected( provider_handle, owner_handle ) ) ==
           "not_finished" );
    CHECK( provider->chatbin.missions_assigned.size() == 1 );
    CHECK( owner.get_active_missions().size() == 1 );

    sol::table success_value = value_from(
                                   succeed_selected(
                                       provider_handle, owner_handle, true ) );
    CHECK( success_value["action"].get<std::string>() == "success" );
    CHECK_FALSE( provider->chatbin.mission_selected->in_progress() );
    CHECK( error_code( succeed_selected(
                           provider_handle, owner_handle, true ) ) ==
           "not_active" );

    const int owed_before_reward = provider->op_of_u.owed;
    sol::table reward_value = value_from(
                                   claim_selected_reward(
                                       provider_handle, owner_handle ) );
    CHECK( reward_value["action"].get<std::string>() == "reward" );
    CHECK( reward_value["owed_delta"].get<int>() == 125 );
    CHECK( provider->op_of_u.owed == owed_before_reward + 125 );
    CHECK( provider->chatbin.mission_selected->generic_reward_claimed() );
    CHECK( reward_value["after"].get<sol::table>()
           ["selected"].get<sol::table>()
           ["generic_reward_claimed"].get<bool>() );
    const int owed_after_reward = provider->op_of_u.owed;
    CHECK( error_code( claim_selected_reward(
                           provider_handle, owner_handle ) ) ==
           "already_claimed" );
    CHECK( provider->op_of_u.owed == owed_after_reward );

    std::ostringstream saved_mission;
    JsonOut mission_json( saved_mission );
    provider->chatbin.mission_selected->serialize( mission_json );
    JsonObject saved_mission_object = json_loader::from_string(
                                          saved_mission.str() );
    mission loaded_mission;
    loaded_mission.deserialize( saved_mission_object );
    REQUIRE( loaded_mission.generic_reward_claimed() );
    owner.reset_all_missions();
    provider->chatbin.missions.clear();
    provider->chatbin.missions_assigned.clear();
    provider->chatbin.mission_selected = nullptr;
    mission::clear_all();
    mission::add_existing( loaded_mission );
    mission *reloaded_mission = mission::find(
                                    loaded_mission.get_id(), true );
    REQUIRE( reloaded_mission != nullptr );
    provider->chatbin.missions_assigned.push_back( reloaded_mission );
    provider->chatbin.mission_selected = reloaded_mission;
    CHECK( error_code( claim_selected_reward(
                           provider_handle, owner_handle ) ) ==
           "already_claimed" );
    CHECK( provider->op_of_u.owed == owed_after_reward );
    value_from( clear_selected( provider_handle, owner_handle ) );
    CHECK( provider->chatbin.missions_assigned.empty() );
    CHECK( provider->chatbin.mission_selected == nullptr );

    sol::table no_generic_value = value_from(
                                      add_assigned(
                                          provider_handle, owner_handle,
                                          no_generic_mission_id ) );
    const cata::lua_platform::mission_token no_generic_token =
        no_generic_value["mission"].get<sol::table>()
        ["token"].get<cata::lua_platform::mission_token>();
    value_from( select( provider_handle, no_generic_token ) );
    value_from( succeed_selected(
                    provider_handle, owner_handle, true ) );
    const int owed_before_no_generic = provider->op_of_u.owed;
    CHECK( error_code( claim_selected_reward(
                           provider_handle, owner_handle ) ) ==
           "no_generic_reward" );
    CHECK( provider->op_of_u.owed == owed_before_no_generic );
    CHECK_FALSE(
        provider->chatbin.mission_selected->generic_reward_claimed() );
    value_from( clear_selected( provider_handle, owner_handle ) );

    sol::table add_value = value_from(
                               add_assigned(
                                   provider_handle, owner_handle, mission_id ) );
    const cata::lua_platform::mission_token added_token =
        add_value["mission"].get<sol::table>()
        ["token"].get<cata::lua_platform::mission_token>();
    CHECK( provider->chatbin.missions.empty() );
    CHECK( provider->chatbin.missions_assigned.size() == 1 );
    value_from( select( provider_handle, added_token ) );
    sol::table failure_value = value_from(
                                   fail_selected(
                                       provider_handle, owner_handle ) );
    CHECK( failure_value["action"].get<std::string>() == "failure" );
    CHECK( error_code( fail_selected( provider_handle, owner_handle ) ) ==
           "not_active" );
    CHECK( provider->chatbin.missions_assigned.size() == 1 );
    value_from( clear_selected( provider_handle, owner_handle ) );
    CHECK( provider->chatbin.missions_assigned.empty() );

    mission *retired = mission::reserve_new(
                           mission_type_id( "TEST_MISSION_GOAL_CONDITION1" ),
                           provider->getID() );
    REQUIRE( retired != nullptr );
    const cata::lua_platform::mission_token retired_token(
        retired->get_id(), retired->identity_generation(), runtime,
        active_world );
    REQUIRE( mission::remove_unassigned( retired->get_id() ) );
    CHECK( error_code( select( provider_handle, retired_token ) ) ==
           "missing_mission" );
    provider->chatbin.mission_selected = retired;
    sol::table stale_state = value_from( state( provider_handle ) );
    CHECK_FALSE( stale_state["selected"].valid() );
    CHECK( stale_state["selected_stale"].get<bool>() );
    provider->chatbin.mission_selected = nullptr;

    mission *foreign = mission::reserve_new(
                           mission_type_id( "TEST_MISSION_GOAL_CONDITION1" ),
                           wrong_provider.getID() );
    REQUIRE( foreign != nullptr );
    const cata::lua_platform::mission_token foreign_token(
        foreign->get_id(), foreign->identity_generation(), runtime,
        active_world );
    provider->chatbin.mission_selected = foreign;
    sol::table invalid_state = value_from( state( provider_handle ) );
    CHECK_FALSE( invalid_state["selected"].valid() );
    CHECK( invalid_state["selected_invalid"].get<bool>() );
    provider->chatbin.missions.push_back( foreign );
    CHECK( error_code( select( provider_handle, foreign_token ) ) ==
           "not_provided_here" );
    sol::table filtered_state = value_from( state( provider_handle ) );
    CHECK( filtered_state["available"].get<sol::table>()
           ["returned"].get<int>() == 0 );
    provider->chatbin.missions.clear();
    provider->chatbin.mission_selected = nullptr;
    REQUIRE( mission::remove_unassigned( foreign->get_id() ) );

    cata::lua_platform::retire_npc_handle_identity( *provider );
    CHECK( error_code( state( provider_handle ) ) == "stale_identity" );
}

TEST_CASE( "lua_platform_faction_for_character_requires_exact_live_handle",
           "[lua][platform][factions]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 64 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 64 );
    cata::lua_platform::game_handle_runtime active_runtime = runtime;
    std::size_t active_world = 22;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return active_world;
    },
    []() {} );
    cata::lua_platform::install_faction_api(
        services,
        [&]() {
        return active_runtime;
    },
    [&]() {
        return active_world;
    },
    []() {}, []() {} );

    monster wrong_subtype;
    wrong_subtype.set_hp( 1 );
    const cata::lua_platform::game_handle npc_labeled_monster =
        cata::lua_platform::game_handle::from_creature(
            wrong_subtype, { "npc", 7006, 0, 0, 0, {} }, runtime,
            active_world );
    const sol::table faction_services = services["factions"];
    const sol::protected_function for_character =
        faction_services["for_character"];
    const sol::protected_function_result subtype_result =
        for_character( npc_labeled_monster );
    REQUIRE( subtype_result.valid() );
    CHECK( subtype_result.get<sol::table>()["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_subtype" );

    avatar character;
    character.normalize();
    character.setID( character_id( 7007 ), true );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "avatar", 7007, 0, 0, 0, {} }, runtime,
            active_world );
    active_world = 23;
    const sol::protected_function_result world_result =
        for_character( character_handle );
    REQUIRE( world_result.valid() );
    CHECK( world_result.get<sol::table>()["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_world" );

    active_world = 22;
    active_runtime = other_runtime;
    const sol::protected_function_result runtime_result =
        for_character( character_handle );
    REQUIRE( runtime_result.valid() );
    CHECK( runtime_result.get<sol::table>()["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_faction_mutation_gate_precedes_typed_target_preflight",
           "[lua][platform][factions]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 65 );
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_faction_api(
        services,
        [runtime]() {
        return runtime;
    },
    []() {
        return std::size_t( 24 );
    },
    []() {},
    [&]() {
        write_gate_called = true;
    } );

    const sol::table faction_services = services["factions"];
    const sol::protected_function set_relationship =
        faction_services["set_relationship"];
    const cata::lua_platform::script_game_id source(
        "faction", "source_faction" );
    const cata::lua_platform::script_game_id wrong_target(
        "item", "rock" );
    sol::table updates = lua.create_table();
    updates["knows_your_voice"] = true;
    const sol::protected_function_result result =
        set_relationship( source, wrong_target, updates );
    CHECK_FALSE( result.valid() );
    CHECK( write_gate_called );
    CHECK_FALSE( faction_services["player"].valid() );
}

TEST_CASE( "lua_platform_game_handles_reject_wrong_owner_and_world", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 7 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 7 );
    const cata::lua_platform::game_handle_runtime newer_runtime( owner, 8 );
    monster value;
    value.set_hp( 1 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            value, { "test_character", 0, 0, 0, 0, {} }, runtime, 11 );

    const std::optional<cata::lua_platform::game_handle_error> wrong_world =
        handle.validation_error( runtime, 12 );
    const std::optional<cata::lua_platform::game_handle_error> wrong_owner =
        handle.validation_error( other_runtime, 11 );
    REQUIRE( wrong_world );
    REQUIRE( wrong_owner );
    CHECK( wrong_world->code == "stale_world" );
    CHECK( wrong_owner->code == "stale_runtime" );
    REQUIRE( handle.validation_error( newer_runtime, 11 ) );
    CHECK( handle.validation_error( newer_runtime, 11 )->code == "stale_runtime" );
    CHECK_FALSE( handle.validation_error( runtime, 11 ) );
}

TEST_CASE( "lua_platform_vehicle_handles_bind_owner_world_and_lifetime",
           "[lua][platform][vehicles]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 41 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 41 );
    vehicle value{ vproto_id() };
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 10, 20, 0, {} }, runtime, 3 );

    CHECK( handle.kind() == cata::lua_platform::game_handle_kind::vehicle );
    CHECK( handle.locator().stable_id > 0 );
    CHECK_FALSE( handle.validation_error( runtime, 3 ) );

    const std::optional<cata::lua_platform::game_handle_error> wrong_world =
        handle.validation_error( runtime, 4 );
    const std::optional<cata::lua_platform::game_handle_error> wrong_owner =
        handle.validation_error( other_runtime, 3 );
    REQUIRE( wrong_world );
    REQUIRE( wrong_owner );
    CHECK( wrong_world->code == "stale_world" );
    CHECK( wrong_owner->code == "stale_runtime" );

    cata::lua_platform::retire_vehicle_handle_identity( value );
    const std::optional<cata::lua_platform::game_handle_error> retired =
        handle.validation_error( runtime, 3 );
    REQUIRE( retired );
    CHECK( retired->code == "stale_vehicle" );

    // A replacement handle is explicit and live; the retired handle never
    // becomes valid again merely because the native address is unchanged.
    const cata::lua_platform::game_handle replacement =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 30, 40, 0, {} }, runtime, 3 );
    CHECK_FALSE( replacement.validation_error( runtime, 3 ) );
    CHECK( replacement.locator().stable_id == handle.locator().stable_id );
}

TEST_CASE( "lua_platform_vehicle_part_handles_require_exact_owner_and_identity",
           "[lua][platform][vehicles]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 42 );
    vehicle first{ vproto_id() };
    vehicle second{ vproto_id() };
    vehicle_part detached_part;

    // A part that is not present in the supplied owner cannot be converted
    // into a resolvable handle; callers must obtain it from vehicles.parts.
    const cata::lua_platform::game_handle invalid =
        cata::lua_platform::game_handle::from_vehicle_part(
            detached_part, first, { "vehicle_part", 0, 0, 0, 0, {} },
            runtime, 7 );
    CHECK( invalid.kind() == cata::lua_platform::game_handle_kind::none );

    const cata::lua_platform::game_handle first_handle =
        cata::lua_platform::game_handle::from_vehicle(
            first, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 7 );
    const cata::lua_platform::game_handle second_handle =
        cata::lua_platform::game_handle::from_vehicle(
            second, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 7 );
    CHECK( first_handle.locator().stable_id != second_handle.locator().stable_id );
}

TEST_CASE( "lua_platform_vehicle_part_handles_fail_closed_on_remove_and_replace",
           "[lua][platform][vehicles]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 44 );
    vehicle first{ vproto_id( "car" ) };
    vehicle second{ vproto_id( "car" ) };
    REQUIRE( first.part_count() > 0 );
    REQUIRE( second.part_count() > 0 );

    const cata::lua_platform::game_handle first_handle =
        cata::lua_platform::game_handle::from_vehicle(
            first, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 8 );
    const cata::lua_platform::game_handle second_handle =
        cata::lua_platform::game_handle::from_vehicle(
            second, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 8 );
    vehicle_part &part = first.part( 0 );
    const cata::lua_platform::game_handle part_handle =
        cata::lua_platform::game_handle::from_vehicle_part(
            part, first, { "vehicle_part", 0, 0, 0, 0, {} }, runtime, 8 );
    REQUIRE( part_handle.kind() == cata::lua_platform::game_handle_kind::vehicle_part );
    CHECK( part_handle.resolve_vehicle_part_for_vehicle(
                first_handle, runtime, 8 ).value == &part );

    const std::optional<cata::lua_platform::game_handle_error> wrong_vehicle =
        part_handle.resolve_vehicle_part_for_vehicle(
            second_handle, runtime, 8 ).error;
    REQUIRE( wrong_vehicle );
    CHECK( wrong_vehicle->code == "wrong_vehicle" );

    part.removed = true;
    const std::optional<cata::lua_platform::game_handle_error> removed =
        part_handle.resolve_vehicle_part( runtime, 8 ).error;
    REQUIRE( removed );
    CHECK( removed->code == "stale_vehicle_part" );

    part.removed = false;
    const std::int64_t old_uid = part.get_base().uid().get_value();
    part.set_base( item( part.info().base_item ) );
    CHECK( part.get_base().uid().get_value() != old_uid );
    const std::optional<cata::lua_platform::game_handle_error> replaced =
        part_handle.resolve_vehicle_part( runtime, 8 ).error;
    REQUIRE( replaced );
    CHECK( replaced->code == "stale_vehicle_part" );

    const cata::lua_platform::game_handle replacement_handle =
        cata::lua_platform::game_handle::from_vehicle_part(
            part, first, { "vehicle_part", 0, 0, 0, 0, {} }, runtime, 8 );
    CHECK( replacement_handle.kind() ==
           cata::lua_platform::game_handle_kind::vehicle_part );
    CHECK( replacement_handle.resolve_vehicle_part_for_vehicle(
                first_handle, runtime, 8 ).value == &part );
}

TEST_CASE( "lua_platform_vehicle_handles_fail_closed_after_unload",
           "[lua][platform][vehicles]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 45 );
    std::optional<cata::lua_platform::game_handle> stale;
    {
        vehicle value{ vproto_id() };
        stale = cata::lua_platform::game_handle::from_vehicle(
                    value, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 9 );
        CHECK_FALSE( stale->validation_error( runtime, 9 ) );
    }
    const std::optional<cata::lua_platform::game_handle_error> error =
        stale->validation_error( runtime, 9 );
    REQUIRE( error );
    CHECK( error->code == "destroyed" );
}

TEST_CASE( "lua_platform_vehicle_api_has_no_implicit_vehicle_selector",
           "[lua][platform][vehicles]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_vehicle_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {},
    []() {} );

    const sol::table vehicles = services["vehicles"];
    REQUIRE( vehicles.valid() );
    CHECK( vehicles["parts"].valid() );
    CHECK( vehicles["set_part_enabled"].valid() );
    CHECK_FALSE( vehicles["marked_service_vehicle"].valid() );
    CHECK_FALSE( vehicles["current"].valid() );
    CHECK_FALSE( vehicles["nearest"].valid() );
}

TEST_CASE( "lua_platform_vehicle_mutations_use_the_platform_write_gate",
           "[lua][platform][vehicles]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 46 );
    vehicle value{ vproto_id() };
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 10 );

    sol::state lua;
    sol::table services = lua.create_table();
    bool write_called = false;
    cata::lua_platform::install_game_handle_api(
        lua, services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 10 );
    }, []() {} );
    cata::lua_platform::install_vehicle_api(
        services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 10 );
    }, []() {}, [&]() {
        write_called = true;
    } );

    const sol::table vehicles = services["vehicles"];
    const sol::protected_function rename = vehicles["rename"];
    const sol::protected_function_result result = rename( handle, "explicit" );
    REQUIRE( result.valid() );
    CHECK( write_called );
}

TEST_CASE( "lua_platform_vehicle_cargo_requires_part_handle_not_index",
           "[lua][platform][vehicles][items]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 43 );
    vehicle value{ vproto_id() };
    const cata::lua_platform::game_handle vehicle_handle =
        cata::lua_platform::game_handle::from_vehicle(
            value, { "map_vehicle", 0, 0, 0, 0, {} }, runtime, 1 );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {} );
    cata::lua_platform::install_item_api(
        services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {} );

    const sol::table item_services = services["items"];
    REQUIRE( item_services.valid() );
    const sol::protected_function page = item_services["page"];
    const sol::table typed_holder = lua.create_table_with(
                                         "kind", "vehicle_cargo",
                                         "vehicle", vehicle_handle,
                                         // Deliberately wrong kind: the
                                         // resolver must reject it, not scan.
                                         "part", vehicle_handle );
    const sol::protected_function_result wrong_part = page( typed_holder );
    REQUIRE( wrong_part.valid() );
    const sol::table wrong_part_envelope = wrong_part.get<sol::table>();
    CHECK_FALSE( wrong_part_envelope["ok"].get<bool>() );
    CHECK( wrong_part_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_kind" );

    const sol::table index_holder = lua.create_table_with(
                                        "kind", "vehicle_cargo",
                                        "vehicle", vehicle_handle,
                                        "part_index", 0 );
    const sol::protected_function_result old_index = page( index_holder );
    CHECK_FALSE( old_index.valid() );
}

TEST_CASE( "lua_platform_game_handles_fail_closed_after_owner_retirement", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 3 );
    item value;
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_item(
            value, { "retired_item", value.uid().get_value(), 0, 0, 0, {} }, runtime, 1 );
    CHECK( runtime.has_live_owner() );

    owner->retire();

    CHECK_FALSE( runtime.has_live_owner() );
    CHECK_FALSE( runtime.is_active_match( runtime ) );
    const std::optional<cata::lua_platform::game_handle_error> error =
        handle.validation_error( runtime, 1 );
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_game_handles_reject_destroyed_items", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 5 );
    std::optional<cata::lua_platform::game_handle> handle;
    {
        item value;
        handle = cata::lua_platform::game_handle::from_item(
                     value, { "destroyed_item", value.uid().get_value(), 0, 0, 0, {} },
                     runtime, 1 );
        const std::optional<cata::lua_platform::game_handle_error> before_destroy =
            handle->validation_error( runtime, 1 );
        REQUIRE( before_destroy );
        CHECK( before_destroy->code == "invalid_item" );
    }

    const std::optional<cata::lua_platform::game_handle_error> error =
        handle->validation_error( runtime, 1 );
    REQUIRE( error );
    CHECK( error->code == "destroyed" );
}

TEST_CASE( "lua_platform_item_handles_reject_null_item_instances", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 12 );
    item value;
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_item(
            value, { "null_item", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );

    const std::optional<cata::lua_platform::game_handle_error> error =
        handle.validation_error( runtime, 1 );
    REQUIRE( error );
    CHECK( error->code == "invalid_item" );
}

TEST_CASE( "lua_platform_item_transform_retires_old_handle_and_reissues_identity",
           "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 13 );
    item value( itype_id( "rock" ) );
    const cata::lua_platform::game_handle old_handle =
        cata::lua_platform::game_handle::from_item(
            value, { "character_carried", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );

    CHECK_FALSE( old_handle.validation_error( runtime, 1 ) );
    cata::lua_platform::retire_item_handle_identity( value );

    const std::optional<cata::lua_platform::game_handle_error> stale =
        old_handle.validation_error( runtime, 1 );
    REQUIRE( stale );
    CHECK( stale->code == "stale_item" );

    const cata::lua_platform::game_handle replacement =
        cata::lua_platform::game_handle::from_item(
            value, { "character_carried", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );
    CHECK_FALSE( replacement.validation_error( runtime, 1 ) );
}

TEST_CASE( "lua_platform_item_holder_resolution_rejects_wrong_character",
           "[lua][platform][items]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 14 );
    avatar character;
    character.normalize();
    character.setID( character_id( 6400 ), true );
    item value( itype_id( "rock" ) );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "character_inventory", 0, 0, 0, 0, {} },
            runtime, 1 );
    const cata::lua_platform::game_handle item_handle =
        cata::lua_platform::game_handle::from_item(
            value, { "character_inventory", value.uid().get_value(), 0, 0, 0, {} },
            runtime, 1 );

    Character *resolved_character = nullptr;
    item *resolved_item = nullptr;
    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK_FALSE( cata::lua_platform::resolve_exact_item_for_character(
                     character_handle, item_handle, runtime, 1,
                     resolved_character, resolved_item, error ) );
    REQUIRE( error );
    CHECK( error->code == "not_owned" );
    CHECK( resolved_character == &character );
    CHECK( resolved_item == nullptr );
}

TEST_CASE( "lua_platform_item_page_is_the_only_public_traversal_entry",
           "[lua][platform][items][pagination]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_item_api(
        services,
        []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    },
    []() {},
    []() {} );

    const sol::table items = services["items"];
    REQUIRE( items.valid() );
    CHECK( items["page"].valid() );
    CHECK_FALSE( items["pockets"].valid() );
    CHECK_FALSE( items["contents"].valid() );

    const sol::table inventory = services["inventory"];
    REQUIRE( inventory.valid() );
    CHECK_FALSE( inventory["find"].valid() );
    CHECK_FALSE( inventory["list"].valid() );
    CHECK_FALSE( inventory["filter"].valid() );
}

TEST_CASE( "lua_platform_item_page_binds_cursor_to_root_and_generations",
           "[lua][platform][items][pagination]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime active_runtime( owner, 31 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 31 );
    std::size_t active_world = 1;

    avatar character;
    character.normalize();
    character.setID( character_id( 6401 ), true );
    character.inv->add_item(
        item( itype_id( "rock" ) ), false, false, false );
    character.inv->add_item(
        item( itype_id( "2x4" ) ), false, false, false );
    item nested_container( itype_id( "debug_backpack" ) );
    REQUIRE( nested_container.put_in(
                  item( itype_id( "rock" ) ), pocket_type::CONTAINER ).success() );
    character.inv->add_item(
        std::move( nested_container ), false, false, false );

    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            character, { "character", character.getID().get_value(), 0, 0, 0, {} },
            active_runtime, active_world );

    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [&]() {
        return active_runtime;
    };
    const auto current_world = [&]() {
        return active_world;
    };
    cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_item_api(
        services, current_runtime, current_world, []() {}, []() {} );

    const sol::table holder = lua.create_table_with(
                                  "kind", "character",
                                  "character", character_handle,
                                  "slot", "inventory" );
    const sol::table options = lua.create_table_with(
                                   "page_size", 1,
                                   "max_depth", 8,
                                   "recursive", true );
    const sol::table item_services = services["items"];
    const sol::protected_function page = item_services["page"];

    const sol::protected_function_result first_result = page( holder, options );
    REQUIRE( first_result.valid() );
    const sol::table first_envelope = first_result.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_page = first_envelope["value"].get<sol::table>();
    REQUIRE( first_page["returned"].get<std::size_t>() == 1 );
    REQUIRE_FALSE( first_page["complete"].get<bool>() );
    REQUIRE( first_page["truncated"].get<bool>() );
    REQUIRE( first_page["stop_reason"].get<std::string>() == "page" );
    REQUIRE( first_page["continuation"].is<sol::table>() );
    const sol::table continuation =
        first_page["continuation"].get<sol::table>();

    const sol::protected_function_result next_result =
        page( holder, options, continuation );
    REQUIRE( next_result.valid() );
    const sol::table next_envelope = next_result.get<sol::table>();
    REQUIRE( next_envelope["ok"].get<bool>() );
    CHECK( next_envelope["value"].get<sol::table>()["returned"].get<std::size_t>() == 1 );

    const sol::protected_function_result reused_result =
        page( holder, options, continuation );
    REQUIRE( reused_result.valid() );
    const sol::table reused_envelope = reused_result.get<sol::table>();
    CHECK_FALSE( reused_envelope["ok"].get<bool>() );
    CHECK( reused_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    active_world = 1;
    const sol::protected_function_result second_first_result = page( holder, options );
    REQUIRE( second_first_result.valid() );
    const sol::table second_first = second_first_result.get<sol::table>();
    const sol::table second_value = second_first["value"].get<sol::table>();
    const sol::table second_continuation =
        second_value["continuation"].get<sol::table>();
    active_world = 2;
    const sol::protected_function_result wrong_world_result =
        page( holder, options, second_continuation );
    REQUIRE( wrong_world_result.valid() );
    const sol::table wrong_world = wrong_world_result.get<sol::table>();
    CHECK_FALSE( wrong_world["ok"].get<bool>() );
    CHECK( wrong_world["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    active_world = 1;
    active_runtime = cata::lua_platform::game_handle_runtime( owner, 31 );
    const sol::protected_function_result owner_first_result = page( holder, options );
    REQUIRE( owner_first_result.valid() );
    const sol::table owner_first = owner_first_result.get<sol::table>();
    REQUIRE( owner_first["ok"].get<bool>() );
    const sol::table owner_value = owner_first["value"].get<sol::table>();
    const sol::table owner_continuation =
        owner_value["continuation"].get<sol::table>();

    active_runtime = other_runtime;
    const sol::protected_function_result wrong_owner_result =
        page( holder, options, owner_continuation );
    REQUIRE( wrong_owner_result.valid() );
    const sol::table wrong_owner = wrong_owner_result.get<sol::table>();
    CHECK_FALSE( wrong_owner["ok"].get<bool>() );
    CHECK( wrong_owner["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    active_runtime = cata::lua_platform::game_handle_runtime( owner, 31 );
    const sol::protected_function_result third_first_result = page( holder, options );
    REQUIRE( third_first_result.valid() );
    const sol::table third_first = third_first_result.get<sol::table>();
    const sol::table third_value = third_first["value"].get<sol::table>();
    const sol::table mutation_continuation =
        third_value["continuation"].get<sol::table>();
    cata::lua_platform::bump_item_query_mutation_epoch();
    const sol::protected_function_result stale_result =
        page( holder, options, mutation_continuation );
    REQUIRE( stale_result.valid() );
    const sol::table stale_envelope = stale_result.get<sol::table>();
    CHECK_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_continuation" );

    const sol::table depth_options = lua.create_table_with(
                                         "page_size", 256,
                                         "max_depth", 0,
                                         "recursive", true );
    const sol::protected_function_result depth_result = page( holder, depth_options );
    REQUIRE( depth_result.valid() );
    const sol::table depth_envelope = depth_result.get<sol::table>();
    REQUIRE( depth_envelope["ok"].get<bool>() );
    const sol::table depth_page = depth_envelope["value"].get<sol::table>();
    CHECK_FALSE( depth_page["complete"].get<bool>() );
    CHECK( depth_page["truncated"].get<bool>() );
    CHECK( depth_page["stop_reason"].get<std::string>() == "max_depth" );
}

TEST_CASE( "lua_platform_exact_creature_subtypes_fail_closed", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 6 );
    monster value;
    value.set_hp( 1 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            value, { "monster", 0, 0, 0, 0, {} }, runtime, 2 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( handle.subtype_name() == "monster" );
    CHECK( cata::lua_platform::resolve_exact_monster(
               handle, runtime, 2, error ) == &value );
    CHECK_FALSE( error );
    CHECK( cata::lua_platform::resolve_exact_character(
               handle, runtime, 2, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, runtime, 2, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );

    value.set_hp( 0 );
    CHECK( cata::lua_platform::resolve_exact_monster(
               handle, runtime, 2, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "dead" );
}

TEST_CASE( "lua_platform_npc_and_avatar_handles_require_exact_subtypes", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 47 );
    monster value;
    value.set_hp( 1 );

    const cata::lua_platform::game_handle npc_labeled_monster =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1, 0, 0, 0, {} }, runtime, 5 );
    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               npc_labeled_monster, runtime, 5, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );

    const cata::lua_platform::game_handle avatar_labeled_monster =
        cata::lua_platform::game_handle::from_creature(
            value, { "avatar", 1, 0, 0, 0, {} }, runtime, 5 );
    CHECK( cata::lua_platform::resolve_exact_avatar(
               avatar_labeled_monster, runtime, 5, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "wrong_subtype" );
}

TEST_CASE( "lua_platform_npc_identity_generation_rejects_id_replacement",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 48 );
    npc original;
    original.normalize();
    original.setID( character_id( 1201 ), true );
    const cata::lua_platform::game_handle original_handle =
        cata::lua_platform::game_handle::from_creature(
            original, { "npc", 1201, 0, 0, 0, {} }, runtime, 6 );

    std::optional<cata::lua_platform::game_handle_error> error;
    REQUIRE( cata::lua_platform::resolve_exact_npc(
                 original_handle, runtime, 6, error ) == &original );
    CHECK_FALSE( error );

    original.setID( character_id( 1202 ), true );
    CHECK( cata::lua_platform::resolve_exact_npc(
               original_handle, runtime, 6, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_identity" );
}

TEST_CASE( "lua_platform_npc_identity_generation_rejects_same_id_replacement",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 49 );
    npc original;
    original.normalize();
    original.setID( character_id( 1203 ), true );
    const cata::lua_platform::game_handle original_handle =
        cata::lua_platform::game_handle::from_creature(
            original, { "npc", 1203, 0, 0, 0, {} }, runtime, 7 );

    npc replacement;
    replacement.normalize();
    replacement.setID( character_id( 1203 ), true );
    const cata::lua_platform::game_handle replacement_handle =
        cata::lua_platform::game_handle::from_creature(
            replacement, { "npc", 1203, 0, 0, 0, {} }, runtime, 7 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               original_handle, runtime, 7, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_identity" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               replacement_handle, runtime, 7, error ) == &replacement );
    CHECK_FALSE( error );
}

TEST_CASE( "lua_platform_npc_unload_reload_and_death_fail_closed",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 50 );
    npc value;
    value.normalize();
    value.setID( character_id( 1204 ), true );
    cata::lua_platform::register_npc_handle_identity( value );
    const cata::lua_platform::game_handle before_unload =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1204, 0, 0, 0, {} }, runtime, 8 );

    cata::lua_platform::retire_npc_handle_identity( value );
    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               before_unload, runtime, 8, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_identity" );

    cata::lua_platform::register_npc_handle_identity( value );
    const cata::lua_platform::game_handle after_reload =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1204, 0, 0, 0, {} }, runtime, 8 );
    CHECK( cata::lua_platform::resolve_exact_npc(
               after_reload, runtime, 8, error ) == &value );
    CHECK_FALSE( error );

    value.set_part_hp_cur( bodypart_id( "torso" ), 0 );
    REQUIRE( value.is_dead_state() );
    CHECK( cata::lua_platform::resolve_exact_npc(
               after_reload, runtime, 8, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "dead" );
    cata::lua_platform::retire_npc_handle_identity( value );
}

TEST_CASE( "lua_platform_npc_handles_reject_stale_owner_world_and_runtime",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 51 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 51 );
    const cata::lua_platform::game_handle_runtime newer_runtime( owner, 52 );
    npc value;
    value.normalize();
    value.setID( character_id( 1205 ), true );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            value, { "npc", 1205, 0, 0, 0, {} }, runtime, 9 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, runtime, 10, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_world" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, other_runtime, 9, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
    CHECK( cata::lua_platform::resolve_exact_npc(
               handle, newer_runtime, 9, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_npc_write_gate_precedes_exact_resolution",
           "[lua][platform][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 53 );
    const auto current_runtime = [&]() {
        return runtime;
    };
    const auto current_world = []() {
        return std::size_t( 10 );
    };
    npc target;
    target.normalize();
    target.setID( character_id( 1206 ), true );
    avatar explicit_owner;
    explicit_owner.normalize();
    explicit_owner.setID( character_id( 1207 ), true );
    const cata::lua_platform::game_handle target_handle =
        cata::lua_platform::game_handle::from_creature(
            target, { "npc", 1206, 0, 0, 0, {} }, runtime, 10 );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            explicit_owner, { "avatar", 1207, 0, 0, 0, {} }, runtime, 10 );

    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_npc_api(
        services, current_runtime, current_world, []() {},
        [&]() {
        write_gate_called = true;
        owner->retire();
    }, []() {} );

    const sol::table npc_services = services["npcs"];
    const sol::protected_function set_radio =
        npc_services["set_radio_representative"];
    const sol::protected_function_result result =
        set_radio( target_handle, owner_handle, true );
    REQUIRE( result.valid() );
    CHECK( write_gate_called );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_open_dialogue_reports_synchronous_native_outcomes",
           "[lua][platform][npc][dialogue]" )
{
    sol::state lua;
    sol::state_view state( lua.lua_state() );

    const sol::table not_started =
        cata::lua_platform::detail::make_npc_dialogue_result(
            state, avatar_talk_to_result::not_started );
    REQUIRE( not_started["ok"].get<bool>() );
    const sol::table not_started_value =
        not_started["value"].get<sol::table>();
    CHECK( not_started_value["status"].get<std::string>() == "not_started" );
    CHECK_FALSE( not_started_value["started"].get<bool>() );
    CHECK_FALSE( not_started_value["completed"].get<bool>() );
    CHECK_FALSE( not_started_value["session"].valid() );

    avatar speaker;
    speaker.normalize();
    speaker.setID( character_id( 1273 ), true );
    npc refusing_npc;
    refusing_npc.normalize();
    refusing_npc.setID( character_id( 1274 ), true );
    refusing_npc.set_attitude( NPCATT_KILL );
    const avatar_talk_to_result rejected_native = speaker.talk_to(
                get_talker_for( refusing_npc ), false, false, false,
                "TALK_EXPLICIT_TEST", std::string(), false );
    REQUIRE( rejected_native == avatar_talk_to_result::rejected );
    const sol::table rejected =
        cata::lua_platform::detail::make_npc_dialogue_result(
            state, rejected_native );
    const sol::table rejected_value =
        rejected["value"].get<sol::table>();
    CHECK( rejected_value["status"].get<std::string>() == "rejected" );
    CHECK_FALSE( rejected_value["started"].get<bool>() );
    CHECK_FALSE( rejected_value["completed"].get<bool>() );

    CHECK( speaker.talk_to( std::unique_ptr<talker>() ) ==
           avatar_talk_to_result::not_started );

    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 73 );
    dialogue conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, 18 );
    REQUIRE( session->active() );
    cata::lua_platform::dialogue::end_session( conversation );
    REQUIRE_FALSE( session->active() );

    const sol::table completed =
        cata::lua_platform::detail::make_npc_dialogue_result(
            state, avatar_talk_to_result::completed );
    REQUIRE( completed["ok"].get<bool>() );
    const sol::table completed_value =
        completed["value"].get<sol::table>();
    CHECK( completed_value["status"].get<std::string>() == "completed" );
    CHECK( completed_value["started"].get<bool>() );
    CHECK( completed_value["completed"].get<bool>() );
    std::set<std::string> completed_fields;
    for( const auto &entry : completed_value ) {
        REQUIRE( entry.first.is<std::string>() );
        completed_fields.insert( entry.first.as<std::string>() );
    }
    CHECK( completed_fields == std::set<std::string> {
        "completed", "started", "status"
    } );
}

TEST_CASE( "lua_platform_open_dialogue_requires_exact_handles_and_topic",
           "[lua][platform][npc][dialogue][contract]" )
{
    platform_npc_dialogue_fixture fixture;
    const sol::protected_function open = fixture.open_dialogue();

    const sol::protected_function_result missing_topic =
        open( fixture.target_handle, fixture.speaker_handle );
    CHECK_FALSE( missing_topic.valid() );

    const sol::protected_function_result illegal_topic =
        open( fixture.target_handle, fixture.speaker_handle, "TALK\nINVALID" );
    CHECK_FALSE( illegal_topic.valid() );

    const sol::protected_function_result unknown_topic =
        open( fixture.target_handle, fixture.speaker_handle,
              "TALK_CCB_PLATFORM_UNKNOWN" );
    CHECK_FALSE( unknown_topic.valid() );

    const sol::protected_function_result missing_avatar =
        open( fixture.target_handle, "TALK_CCB_PLATFORM_UNKNOWN" );
    CHECK_FALSE( missing_avatar.valid() );
    const sol::protected_function_result no_participants =
        open( "TALK_CCB_PLATFORM_UNKNOWN" );
    CHECK_FALSE( no_participants.valid() );

    const sol::table npcs = fixture.services["npcs"];
    CHECK_FALSE( npcs["open_current_dialogue"].valid() );
    CHECK_FALSE( npcs["open_nearby_dialogue"].valid() );
    CHECK( fixture.services["dialogue"].get_type() == sol::type::none );
}

TEST_CASE( "lua_platform_open_dialogue_scopes_platform_topics_to_calling_runtime",
           "[lua][platform][npc][dialogue][runtime]" )
{
    cata::lua_platform::clear_active_runtimes();
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    sol::state owner_lua;
    sol::table owner_ccb = owner_lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> owner_runtime =
        cata::lua_platform::make_runtime(
            "dialogue_topic_owner", 81, owner_lua );
    cata::lua_platform::install_runtime_api(
        owner_runtime, owner_lua, owner_ccb );

    const sol::table dialogue_api = owner_ccb["dialogue"];
    const sol::protected_function register_topic =
        dialogue_api["register_topic"];
    sol::table descriptor = owner_lua.create_table();
    descriptor["id"] = "TALK_CCB_DECLARATIVE_OWNER";
    descriptor["dynamic_line"] = "Registered Platform topic";
    descriptor["responses"] = owner_lua.create_table();
    const sol::protected_function_result declarative_registration =
        register_topic( descriptor );
    REQUIRE( declarative_registration.valid() );

    const sol::table runtime_api = owner_ccb["runtime"];
    owner_lua.set_function( "ccb_test_dialogue_handler", []() {} );
    const sol::protected_function register_handler = runtime_api["handler"];
    const sol::object handler_callback =
        owner_lua["ccb_test_dialogue_handler"];
    const sol::protected_function_result handler_registration =
        register_handler(
            "ccb_test_dialogue_handler", handler_callback );
    REQUIRE( handler_registration.valid() );
    const sol::protected_function register_handler_topic =
        runtime_api["dialogue_topic"];
    const sol::protected_function_result handler_topic_registration =
        register_handler_topic(
            "TALK_CCB_HANDLER_OWNER", "ccb_test_dialogue_handler" );
    REQUIRE( handler_topic_registration.valid() );

    cata::lua_platform::set_active_runtimes( { owner_runtime } );
    const cata::lua_platform::game_handle_runtime owner_identity =
        cata::lua_platform::detail::runtime_handle_identity( owner_runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    REQUIRE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                 "TALK_CCB_DECLARATIVE_OWNER", owner_identity,
                 world_generation ) );
    REQUIRE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                 "TALK_CCB_HANDLER_OWNER", owner_identity,
                 world_generation ) );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_UNKNOWN_OWNER", owner_identity,
                     world_generation ) );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_DECLARATIVE_OWNER", owner_identity,
                     world_generation + 1 ) );

    platform_registered_dialogue_call_fixture owner_call(
        owner_identity, world_generation, 1281 );
    const sol::protected_function owner_open = owner_call.open_dialogue();
    for( const std::string &topic : {
             std::string( "TALK_CCB_DECLARATIVE_OWNER" ),
             std::string( "TALK_CCB_HANDLER_OWNER" )
         } ) {
        const sol::protected_function_result result = owner_open(
                    owner_call.target_handle, owner_call.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        const sol::table value = envelope["value"].get<sol::table>();
        CHECK( value["status"].get<std::string>() == "rejected" );
        CHECK_FALSE( value["completed"].get<bool>() );
    }

    const std::vector<std::string> native_topics = get_all_talk_topic_ids();
    REQUIRE_FALSE( native_topics.empty() );
    const sol::protected_function_result native_result = owner_open(
                owner_call.target_handle, owner_call.speaker_handle,
                native_topics.front() );
    REQUIRE( native_result.valid() );
    REQUIRE( native_result.get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result unknown_result = owner_open(
                owner_call.target_handle, owner_call.speaker_handle,
                "TALK_CCB_UNKNOWN_OWNER" );
    CHECK_FALSE( unknown_result.valid() );

    sol::state foreign_lua;
    const std::shared_ptr<cata::lua_platform::runtime> foreign_runtime =
        cata::lua_platform::make_runtime(
            "dialogue_topic_foreign", 81, foreign_lua );
    cata::lua_platform::set_active_runtimes( {
        owner_runtime, foreign_runtime
    } );
    const cata::lua_platform::game_handle_runtime foreign_identity =
        cata::lua_platform::detail::runtime_handle_identity( foreign_runtime );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_DECLARATIVE_OWNER", foreign_identity,
                     world_generation ) );
    platform_registered_dialogue_call_fixture foreign_call(
        foreign_identity, world_generation, 1283 );
    const sol::protected_function_result foreign_result =
        foreign_call.open_dialogue()(
            foreign_call.target_handle, foreign_call.speaker_handle,
            "TALK_CCB_DECLARATIVE_OWNER" );
    CHECK_FALSE( foreign_result.valid() );

    cata::lua_platform::set_active_runtimes( { foreign_runtime } );
    CHECK_FALSE( cata::lua_platform::detail::runtime_has_dialogue_topic(
                     "TALK_CCB_DECLARATIVE_OWNER", owner_identity,
                     world_generation ) );
    const sol::protected_function_result stale_runtime_result = owner_open(
                owner_call.target_handle, owner_call.speaker_handle,
                "TALK_CCB_DECLARATIVE_OWNER" );
    CHECK_FALSE( stale_runtime_result.valid() );
}

TEST_CASE( "lua_platform_open_dialogue_rejection_is_not_completion",
           "[lua][platform][npc][dialogue]" )
{
    const std::vector<std::string> topics = get_all_talk_topic_ids();
    REQUIRE_FALSE( topics.empty() );
    platform_npc_dialogue_fixture fixture;
    fixture.target.set_attitude( NPCATT_KILL );

    const sol::protected_function_result result = fixture.open_dialogue()(
                fixture.target_handle, fixture.speaker_handle, topics.front() );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"].get<sol::table>();
    CHECK( value["status"].get<std::string>() == "rejected" );
    CHECK_FALSE( value["started"].get<bool>() );
    CHECK_FALSE( value["completed"].get<bool>() );
    CHECK_FALSE( value["session"].valid() );
}

TEST_CASE( "lua_platform_open_dialogue_rejects_stale_participants_and_generations",
           "[lua][platform][npc][dialogue]" )
{
    const std::vector<std::string> topics = get_all_talk_topic_ids();
    REQUIRE_FALSE( topics.empty() );
    const std::string topic = topics.front();

    SECTION( "NPC native identity" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.target.setID( character_id( 1275 ), true );
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_identity" );
    }

    SECTION( "avatar native identity" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.speaker.setID( character_id( 1276 ), true );
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_identity" );
    }

    SECTION( "runtime owner" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.active_runtime = fixture.other_runtime;
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_runtime" );
    }

    SECTION( "runtime generation" ) {
        platform_npc_dialogue_fixture fixture;
        fixture.active_runtime = fixture.newer_runtime;
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_runtime" );
    }

    SECTION( "world generation" ) {
        platform_npc_dialogue_fixture fixture;
        ++fixture.active_world;
        const sol::protected_function_result result = fixture.open_dialogue()(
                    fixture.target_handle, fixture.speaker_handle, topic );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        CHECK_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_world" );
    }
}

TEST_CASE( "lua_platform_dialogue_sessions_invalidate_topics_and_participants",
           "[lua][platform]" )
{
    monster participant{ mtype_id( "mon_zombie" ) };
    participant.set_hp( 1 );
    dialogue conversation(
        std::make_unique<talker_monster>( &participant ),
        std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;

    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ONE", runtime, world_generation );
    REQUIRE( topic_session == session );
    CHECK( topic_session->active_for( "TALK_ONE" ) );
    CHECK( topic_session->speaker_snapshot().present );
    CHECK( topic_session->speaker_snapshot().entity );
    CHECK( topic_session->speaker_snapshot().kind == "monster" );

    const cata::lua_platform::dialogue::dialogue_session_ptr replacement_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_TWO", runtime, world_generation );
    REQUIRE( replacement_session != topic_session );
    CHECK( replacement_session->generation() != topic_session->generation() );
    CHECK_FALSE( topic_session->active_for( "TALK_ONE" ) );
    CHECK_FALSE( topic_session->active() );
    CHECK( replacement_session->active_for( "TALK_TWO" ) );

    participant.set_hp( 0 );
    CHECK_FALSE( replacement_session->active_for( "TALK_TWO" ) );

    cata::lua_platform::dialogue::end_session( conversation );
    CHECK_FALSE( topic_session->active() );
}

TEST_CASE( "lua_platform_dialogue_response_callbacks_reject_stale_topics",
           "[lua][platform][dialogue]" )
{
    cata::lua_platform::dialogue::clear_response_callbacks();
    monster participant{ mtype_id( "mon_zombie" ) };
    participant.set_hp( 1 );
    dialogue conversation(
        std::make_unique<talker_monster>( &participant ),
        std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;
    cata::lua_platform::dialogue::begin_session(
        conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr first_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ONE", runtime, world_generation );
    std::size_t callback_calls = 0;
    const std::uint64_t replaced_callback =
        cata::lua_platform::dialogue::register_response_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&]( dialogue &, const talk_topic &, bool ) {
        ++callback_calls;
        return talk_topic( "CALLBACK_RAN" );
    }, first_session, "TALK_ONE" );

    const cata::lua_platform::dialogue::dialogue_session_ptr second_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_TWO", runtime, world_generation );
    const talk_topic fallback( "FALLBACK" );
    const talk_topic after_topic_replacement =
        cata::lua_platform::dialogue::apply_response_callback(
            conversation, replaced_callback, fallback, true );
    CHECK( after_topic_replacement.id == fallback.id );
    CHECK( callback_calls == 0 );
    CHECK( second_session->active_for( "TALK_TWO" ) );

    const std::uint64_t ended_callback =
        cata::lua_platform::dialogue::register_response_callback(
            cata::lua_platform::dialogue::response_callback_origin::platform,
            [&]( dialogue &, const talk_topic &, bool ) {
        ++callback_calls;
        return talk_topic( "CALLBACK_RAN" );
    }, second_session, "TALK_TWO" );
    cata::lua_platform::dialogue::end_session( conversation );
    const talk_topic after_dialogue_end =
        cata::lua_platform::dialogue::apply_response_callback(
            conversation, ended_callback, fallback, true );
    CHECK( after_dialogue_end.id == fallback.id );
    CHECK( callback_calls == 0 );
    cata::lua_platform::dialogue::clear_response_callbacks();
}

TEST_CASE( "lua_platform_dialogue_participants_keep_exact_npc_identity",
           "[lua][platform][dialogue][npc]" )
{
    npc speaker;
    speaker.normalize();
    speaker.setID( character_id( 1210 ), true );
    npc interlocutor;
    interlocutor.normalize();
    interlocutor.setID( character_id( 1211 ), true );
    dialogue conversation(
        std::make_unique<talker_npc>( &speaker ),
        std::make_unique<talker_npc>( &interlocutor ) );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );

    REQUIRE( session->speaker_snapshot().entity );
    REQUIRE( session->interlocutor_snapshot().entity );
    CHECK( session->speaker_snapshot().kind == "npc" );
    CHECK( session->interlocutor_snapshot().kind == "npc" );
    REQUIRE( session->speaker_snapshot().stable_id );
    REQUIRE( session->interlocutor_snapshot().stable_id );
    CHECK( *session->speaker_snapshot().stable_id == 1210 );
    CHECK( *session->interlocutor_snapshot().stable_id == 1211 );
    CHECK( session->participants_live() );

    cata::lua_platform::dialogue::end_session( conversation );
    CHECK_FALSE( session->participants_live() );
}

TEST_CASE( "lua_platform_dialogue_detached_participants_are_snapshots",
           "[lua][platform]" )
{
    dialogue conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 1 );
    const std::size_t world_generation = 1;
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );

    CHECK( session->speaker_snapshot().present );
    CHECK_FALSE( session->speaker_snapshot().entity );
    CHECK( session->speaker_snapshot().kind == "topic" );
    CHECK( session->participants_live() );

    cata::lua_platform::dialogue::end_session( conversation );
    CHECK_FALSE( session->participants_live() );
}

TEST_CASE( "lua_platform_dialogue_sessions_reject_stale_identity_without_dereference",
           "[lua][platform][dialogue]" )
{
    monster participant{ mtype_id( "mon_zombie" ) };
    participant.set_hp( 1 );
    dialogue conversation(
        std::make_unique<talker_monster>( &participant ),
        std::make_unique<talker_topic>() );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto foreign_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 7 );
    const cata::lua_platform::game_handle_runtime newer_runtime( runtime_owner, 8 );
    const cata::lua_platform::game_handle_runtime foreign_runtime( foreign_owner, 7 );
    const std::size_t world_generation = 4;
    const std::size_t newer_world_generation = 5;
    const cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, world_generation );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            conversation, "TALK_ONE", runtime, world_generation );
    REQUIRE( topic_session == session );
    CHECK( session->active_for( "TALK_ONE", runtime, world_generation,
                                &conversation ) );

    const std::optional<cata::lua_platform::game_handle_error> foreign_error =
        session->validation_error( &conversation, foreign_runtime, world_generation );
    REQUIRE( foreign_error );
    CHECK( foreign_error->code == "stale_runtime" );
    const std::optional<cata::lua_platform::game_handle_error> generation_error =
        session->validation_error( &conversation, newer_runtime, world_generation );
    REQUIRE( generation_error );
    CHECK( generation_error->code == "stale_runtime" );
    const std::optional<cata::lua_platform::game_handle_error> world_error =
        session->validation_error( &conversation, runtime, newer_world_generation );
    REQUIRE( world_error );
    CHECK( world_error->code == "stale_world" );

    dialogue different_conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    const std::optional<cata::lua_platform::game_handle_error> native_error =
        session->validation_error( &different_conversation, runtime, world_generation );
    REQUIRE( native_error );
    CHECK( native_error->code == "destroyed" );

    using dialogue_context = cata::lua_platform::dialogue::context;
    dialogue_context context( nullptr, conversation, "TALK_ONE", false,
                              "dialogue context is stale", {}, session,
                              runtime, world_generation );
    CHECK( context.valid() );
    CHECK_FALSE( context.validation_error() );

    dialogue_context foreign_context( nullptr, conversation, "TALK_ONE", false,
                                      "dialogue context is stale", {}, session,
                                      foreign_runtime, world_generation );
    CHECK_FALSE( foreign_context.valid() );
    REQUIRE( foreign_context.validation_error() );
    CHECK( foreign_context.validation_error()->code == "stale_runtime" );

    dialogue_context wrong_world_context( nullptr, conversation, "TALK_ONE", false,
                                          "dialogue context is stale", {}, session,
                                          runtime, newer_world_generation );
    CHECK_FALSE( wrong_world_context.valid() );
    REQUIRE( wrong_world_context.validation_error() );
    CHECK( wrong_world_context.validation_error()->code == "stale_world" );

    dialogue_context wrong_native_context( nullptr, different_conversation, "TALK_ONE",
                                           false, "dialogue context is stale", {}, session,
                                           runtime, world_generation );
    CHECK_FALSE( wrong_native_context.valid() );
    REQUIRE( wrong_native_context.validation_error() );
    CHECK( wrong_native_context.validation_error()->code == "destroyed" );

    runtime_owner->retire();
    CHECK_FALSE( context.valid() );
    REQUIRE( context.validation_error() );
    CHECK( context.validation_error()->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_dialogue_session_scope_and_teardown_retirement",
           "[lua][platform][dialogue]" )
{
    const auto first_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto second_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime first_runtime( first_owner, 11 );
    const cata::lua_platform::game_handle_runtime second_runtime( second_owner, 11 );
    const std::size_t world_generation = 9;
    cata::lua_platform::dialogue::dialogue_session_ptr stale_after_scope;
    std::unique_ptr<cata::lua_platform::dialogue::context> stale_context;

    {
        dialogue conversation(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
        stale_after_scope = cata::lua_platform::dialogue::begin_session(
                                conversation, first_runtime, world_generation );
        const cata::lua_platform::dialogue::dialogue_session_ptr second_session =
            cata::lua_platform::dialogue::session_for(
                conversation, "TALK_ONE", second_runtime, world_generation );
        REQUIRE( stale_after_scope != second_session );
        CHECK( stale_after_scope->active() );
        CHECK( second_session->active() );

        stale_context = std::make_unique<cata::lua_platform::dialogue::context>(
                             nullptr, conversation, "TALK_ONE", false,
                             "dialogue context is stale",
                             cata::lua_platform::dialogue::context::actor_converter{}, second_session,
                             second_runtime, world_generation );
        CHECK( stale_context->valid() );

        cata::lua_platform::dialogue::retire_sessions_for_runtime( first_runtime );
        CHECK_FALSE( stale_after_scope->active() );
        CHECK( second_session->active() );

        cata::lua_platform::dialogue::retire_sessions_for_world( world_generation );
        CHECK_FALSE( second_session->active() );
        CHECK_FALSE( stale_context->valid() );
        REQUIRE( stale_context->validation_error() );
        CHECK( stale_context->validation_error()->code == "destroyed" );
    }

    REQUIRE( stale_after_scope );
    CHECK_FALSE( stale_after_scope->active() );
    CHECK_FALSE( stale_context->valid() );
    REQUIRE( stale_context->validation_error() );
    CHECK( stale_context->validation_error()->code == "destroyed" );
}

TEST_CASE( "lua_platform_npc_identity_generation_bump_retires_dialogue_sessions",
           "[lua][platform][dialogue][npc]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 12 );
    const std::size_t previous_world_generation =
        cata::lua_platform::runtime_world_generation();
    dialogue conversation(
        std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
    cata::lua_platform::dialogue::dialogue_session_ptr session =
        cata::lua_platform::dialogue::begin_session(
            conversation, runtime, previous_world_generation );
    session = cata::lua_platform::dialogue::session_for(
                  conversation, "TALK_IDENTITY_BUMP", runtime,
                  previous_world_generation );
    cata::lua_platform::dialogue::context context(
        nullptr, conversation, "TALK_IDENTITY_BUMP", false,
        "dialogue context is stale", {}, session, runtime,
        previous_world_generation );
    REQUIRE( session );
    CHECK( context.valid() );

    cata::lua_platform::runtime_npc_identity_changed();

    CHECK( cata::lua_platform::runtime_world_generation() !=
           previous_world_generation );
    CHECK_FALSE( session->active() );
    CHECK_FALSE( context.valid() );
    REQUIRE( context.validation_error() );
    CHECK( context.validation_error()->code == "destroyed" );
}

TEST_CASE( "lua_platform_dialogue_move_retires_source_and_target_sessions",
           "[lua][platform][dialogue]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 13 );
    const std::size_t world_generation = 31;

    SECTION( "move construction" ) {
        dialogue source(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
        source.done = true;
        source.topic_stack.emplace_back( "TALK_MOVE_SOURCE" );
        source.responses.emplace_back();
        source.response_condition_exists.push_back( true );
        source.response_condition_eval.push_back( false );
        source.reason = "move source";
        source.by_radio = true;
        source.debug_conditionals = false;
        source.debug_effects = false;
        source.debug_ignore_conditionals = true;
        cata::lua_platform::dialogue::dialogue_session_ptr source_session =
            cata::lua_platform::dialogue::begin_session(
                source, runtime, world_generation );
        source_session = cata::lua_platform::dialogue::session_for(
                             source, "TALK_MOVE_SOURCE", runtime, world_generation );
        cata::lua_platform::dialogue::context source_context(
            nullptr, source, "TALK_MOVE_SOURCE", false,
            "dialogue context is stale", {}, source_session,
            runtime, world_generation );
        REQUIRE( source_context.valid() );

        dialogue moved( std::move( source ) );

        CHECK_FALSE( source_session->active() );
        CHECK_FALSE( source_context.valid() );
        REQUIRE( source_context.validation_error() );
        CHECK( source_context.validation_error()->code == "destroyed" );
        CHECK( moved.done );
        REQUIRE( moved.topic_stack.size() == 1 );
        CHECK( moved.topic_stack.front().id == "TALK_MOVE_SOURCE" );
        CHECK( moved.responses.size() == 1 );
        CHECK( moved.response_condition_exists == std::vector<bool> { true } );
        CHECK( moved.response_condition_eval == std::vector<bool> { false } );
        CHECK( moved.reason == "move source" );
        CHECK( moved.by_radio );
        CHECK_FALSE( moved.debug_conditionals );
        CHECK_FALSE( moved.debug_effects );
        CHECK( moved.debug_ignore_conditionals );
        CHECK( moved.has_actor( false ) );
        CHECK( moved.has_actor( true ) );

        cata::lua_platform::dialogue::dialogue_session_ptr moved_session =
            cata::lua_platform::dialogue::begin_session(
                moved, runtime, world_generation );
        moved_session = cata::lua_platform::dialogue::session_for(
                            moved, "TALK_MOVE_SOURCE", runtime, world_generation );
        CHECK( moved_session->active_for(
                   "TALK_MOVE_SOURCE", runtime, world_generation, &moved ) );
    }

    SECTION( "move assignment" ) {
        dialogue source(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );
        source.topic_stack.emplace_back( "TALK_MOVE_ASSIGN" );
        source.reason = "assigned source";
        dialogue target(
            std::make_unique<talker_topic>(), std::make_unique<talker_topic>() );

        cata::lua_platform::dialogue::dialogue_session_ptr source_session =
            cata::lua_platform::dialogue::begin_session(
                source, runtime, world_generation );
        source_session = cata::lua_platform::dialogue::session_for(
                             source, "TALK_MOVE_ASSIGN", runtime, world_generation );
        cata::lua_platform::dialogue::context source_context(
            nullptr, source, "TALK_MOVE_ASSIGN", false,
            "dialogue context is stale", {}, source_session,
            runtime, world_generation );
        cata::lua_platform::dialogue::dialogue_session_ptr target_session =
            cata::lua_platform::dialogue::begin_session(
                target, runtime, world_generation );
        target_session = cata::lua_platform::dialogue::session_for(
                             target, "TALK_MOVE_TARGET", runtime, world_generation );
        cata::lua_platform::dialogue::context target_context(
            nullptr, target, "TALK_MOVE_TARGET", false,
            "dialogue context is stale", {}, target_session,
            runtime, world_generation );
        REQUIRE( source_context.valid() );
        REQUIRE( target_context.valid() );

        target = std::move( source );

        CHECK_FALSE( source_session->active() );
        CHECK_FALSE( target_session->active() );
        CHECK_FALSE( source_context.valid() );
        CHECK_FALSE( target_context.valid() );
        REQUIRE( source_context.validation_error() );
        REQUIRE( target_context.validation_error() );
        CHECK( source_context.validation_error()->code == "destroyed" );
        CHECK( target_context.validation_error()->code == "destroyed" );
        REQUIRE( target.topic_stack.size() == 1 );
        CHECK( target.topic_stack.front().id == "TALK_MOVE_ASSIGN" );
        CHECK( target.reason == "assigned source" );
        CHECK( target.has_actor( false ) );
        CHECK( target.has_actor( true ) );

        cata::lua_platform::dialogue::dialogue_session_ptr moved_session =
            cata::lua_platform::dialogue::begin_session(
                target, runtime, world_generation );
        moved_session = cata::lua_platform::dialogue::session_for(
                            target, "TALK_MOVE_ASSIGN", runtime, world_generation );
        CHECK( moved_session->active_for(
                   "TALK_MOVE_ASSIGN", runtime, world_generation, &target ) );
    }
}

TEST_CASE( "lua_platform_creature_handles_fail_closed_after_unload", "[lua][platform]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 9 );
    std::optional<cata::lua_platform::game_handle> stale;
    std::optional<cata::lua_platform::game_handle_error> live_error;
    {
        monster value;
        value.set_hp( 1 );
        stale = cata::lua_platform::game_handle::from_creature(
                    value, { "monster", 0, 0, 0, 0, {} }, runtime, 4 );
        CHECK( cata::lua_platform::resolve_exact_monster(
                   *stale, runtime, 4, live_error ) == &value );
    }

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( cata::lua_platform::resolve_exact_monster(
               *stale, runtime, 4, error ) == nullptr );
    REQUIRE( error );
    CHECK( error->code == "destroyed" );
}

TEST_CASE( "lua_platform_native_identity_is_not_reused_by_copy_or_move", "[lua][platform]" )
{
    cata::lua_platform::native_object_identity original;
    const std::uint64_t original_value = original.value();
    cata::lua_platform::native_object_identity copied( original );
    CHECK( copied.value() != original_value );

    cata::lua_platform::native_object_identity moved( std::move( original ) );
    CHECK( moved.value() == original_value );
    CHECK( original.value() != original_value );
}

TEST_CASE( "lua_platform_hooks_use_semantic_participant_fields", "[lua][platform]" )
{
    const auto contains = []( const std::vector<std::string_view> &fields,
                              const std::string_view wanted ) {
        return std::find( fields.begin(), fields.end(), wanted ) != fields.end();
    };
    const cata::lua_platform::script_hook_spec *start =
        cata::lua_platform::find_script_hook_spec( "on_dialogue_start" );
    const cata::lua_platform::script_hook_spec *option =
        cata::lua_platform::find_script_hook_spec( "on_dialogue_option" );
    REQUIRE( start );
    REQUIRE( option );
    CHECK( contains( start->payload_fields, "speaker" ) );
    CHECK( contains( start->payload_fields, "interlocutor" ) );
    CHECK( contains( option->payload_fields, "selected_topic" ) );
    CHECK_FALSE( contains( start->payload_fields, "alpha" ) );
    CHECK_FALSE( contains( start->payload_fields, "beta" ) );
    CHECK_FALSE( contains( option->payload_fields, "avatar" ) );

    const_talker detached_talker;
    const cata::lua_platform::native_callback_talker snapshot =
        cata::lua_platform::snapshot_native_callback_talker( detached_talker );
    CHECK( snapshot.present );
    CHECK_FALSE( snapshot.entity );
    CHECK( snapshot.kind == "topic" );
}

TEST_CASE( "lua_platform_camp_handles_reject_replacement_and_removal",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 61 );
    basecamp original( "Platform Camp", tripoint_abs_omt{ 10, 10, 0 } );
    cata::lua_platform::register_camp_handle_identity( original );
    const cata::lua_platform::game_handle original_handle =
        cata::lua_platform::game_handle::from_camp( original, {}, runtime, 12 );

    CHECK( original_handle.kind() == cata::lua_platform::game_handle_kind::camp );
    CHECK( original_handle.locator().stable_id ==
           static_cast<std::int64_t>( original.platform_id() ) );
    CHECK_FALSE( original_handle.validation_error( runtime, 12 ) );

    basecamp replacement( "Replacement Camp", tripoint_abs_omt{ 10, 10, 0 } );
    replacement.set_platform_id( original.platform_id() );
    cata::lua_platform::register_camp_handle_identity( replacement );
    const std::optional<cata::lua_platform::game_handle_error> replaced =
        original_handle.validation_error( runtime, 12 );
    REQUIRE( replaced );
    CHECK( replaced->code == "stale_camp" );

    const cata::lua_platform::game_handle replacement_handle =
        cata::lua_platform::game_handle::from_camp( replacement, {}, runtime, 12 );
    CHECK_FALSE( replacement_handle.validation_error( runtime, 12 ) );
    cata::lua_platform::retire_camp_handle_identity( replacement );
    const std::optional<cata::lua_platform::game_handle_error> removed =
        replacement_handle.validation_error( runtime, 12 );
    REQUIRE( removed );
    CHECK( removed->code == "stale_camp" );
}

TEST_CASE( "lua_platform_camp_handles_bind_runtime_and_world_generation",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 62 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 62 );
    const cata::lua_platform::game_handle_runtime newer_runtime( owner, 63 );
    basecamp camp( "Generation Camp", tripoint_abs_omt{ 11, 11, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 13 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( handle.resolve_camp( runtime, 14 ).value == nullptr );
    error = handle.resolve_camp( runtime, 14 ).error;
    REQUIRE( error );
    CHECK( error->code == "stale_world" );
    error = handle.resolve_camp( other_runtime, 13 ).error;
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
    error = handle.resolve_camp( newer_runtime, 13 ).error;
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_camp_assignment_preflight_is_exact_and_atomic",
           "[lua][platform][camp]" )
{
    basecamp camp( "Assignment Camp", tripoint_abs_omt{ 12, 12, 0 } );
    CHECK( camp.exact_worker_count() == 0 );
    CHECK_FALSE( camp.assign_exact_worker( nullptr ) );
    CHECK( camp.exact_worker_count() == 0 );

    const shared_ptr_fast<npc> dead_worker = make_shared_fast<npc>();
    dead_worker->normalize();
    dead_worker->setID( character_id( 6201 ), true );
    dead_worker->set_all_parts_hp_cur( 0 );
    CHECK( dead_worker->is_dead_state() );
    CHECK_FALSE( camp.assign_exact_worker( dead_worker ) );
    CHECK( camp.exact_worker_count() == 0 );

    const shared_ptr_fast<npc> worker = make_shared_fast<npc>();
    worker->normalize();
    worker->setID( character_id( 6202 ), true );
    worker->set_all_parts_hp_cur( 100 );
    CHECK_FALSE( worker->is_dead_state() );
    CHECK( camp.assign_exact_worker( worker ) );
    CHECK( camp.has_exact_worker( *worker ) );
    CHECK( camp.exact_worker_count() == 1 );
    CHECK_FALSE( camp.assign_exact_worker( worker ) );
    CHECK( camp.exact_worker_count() == 1 );
    CHECK( camp.recall_exact_worker( worker ) );
    CHECK_FALSE( camp.has_exact_worker( *worker ) );
    CHECK( camp.exact_worker_count() == 0 );
    CHECK_FALSE( camp.recall_exact_worker( worker ) );
}

TEST_CASE( "lua_platform_camp_api_requires_explicit_manager_and_handles",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 64 );
    basecamp camp( "API Camp", tripoint_abs_omt{ 13, 13, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 15 );
    monster wrong_manager;
    wrong_manager.set_hp( 1 );
    const cata::lua_platform::game_handle wrong_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            wrong_manager, { "monster", 6202, 0, 0, 0, {} }, runtime, 15 );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 15 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 15 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    CHECK( camps["get"].valid() );
    CHECK( camps["assign_worker"].valid() );
    CHECK( camps["recall_worker"].valid() );
    CHECK_FALSE( camps["near"].valid() );
    CHECK_FALSE( camps["player_has_camp"].valid() );
    CHECK_FALSE( camps["start_with"].valid() );
    CHECK_FALSE( camps["assign_resident"].valid() );

    const sol::protected_function get = camps["get"];
    const sol::protected_function_result result = get( camp_handle, wrong_manager_handle );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_subtype" );
}

TEST_CASE( "lua_platform_camp_write_gate_precedes_camp_resolution",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 65 );
    basecamp camp( "Write Gate Camp", tripoint_abs_omt{ 14, 14, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 16 );
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 16 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 16 ); },
    []() {}, [&]() {
        write_gate_called = true;
        owner->retire();
    } );
    const sol::protected_function rename = services["camps"]["rename"];
    const sol::protected_function_result result = rename(
            camp_handle, cata::lua_platform::game_handle{}, "New Name" );
    REQUIRE( result.valid() );
    CHECK( write_gate_called );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_camp_resource_keys_reject_ambiguous_duplicates",
           "[lua][platform][camp][resources]" )
{
    const itype_id resource_id( "water" );
    const itype_id charge_id( "battery" );
    basecamp_resource first;
    first.fake_id = resource_id;
    first.ammo_id = charge_id;
    first.available = 4;
    first.consumed = 1;
    basecamp_resource equivalent = first;
    equivalent.available = 6;
    equivalent.consumed = 2;

    std::vector<basecamp_resource> normalized;
    std::string error;
    REQUIRE( basecamp::platform_normalize_resources(
                 { first, equivalent }, normalized, error ) );
    REQUIRE( normalized.size() == 1 );
    CHECK( normalized.front().fake_id == resource_id );
    CHECK( normalized.front().available == 10 );
    CHECK( normalized.front().consumed == 3 );

    basecamp_resource conflicting = equivalent;
    conflicting.ammo_id = itype_id();
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { first, conflicting }, normalized, error ) );
    CHECK( normalized.empty() );
    CHECK( error.find( "conflicting ammo" ) != std::string::npos );

    basecamp_resource overflowing = first;
    overflowing.available = std::numeric_limits<int>::max();
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { overflowing, overflowing }, normalized, error ) );
    CHECK( normalized.empty() );
    CHECK( error.find( "overflow" ) != std::string::npos );

    basecamp_resource negative = first;
    negative.available = -1;
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { negative }, normalized, error ) );
    CHECK( normalized.empty() );
    CHECK( error.find( "negative" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_resource_batch_preflight_is_atomic",
           "[lua][platform][camp][resources]" )
{
    basecamp camp( "Resource Camp", tripoint_abs_omt{ 15, 15, 0 } );
    std::vector<basecamp_resource> before;
    std::string error;
    REQUIRE( camp.platform_resource_snapshot( before, error ) );

    const std::vector<basecamp_platform_resource_change> changes = {
        { itype_id( "water" ), 1 },
        { itype_id( "battery" ), -1 },
    };
    CHECK_FALSE( camp.platform_adjust_resources( changes, error ) );
    const std::string failure_error = error;

    std::vector<basecamp_resource> after;
    REQUIRE( camp.platform_resource_snapshot( after, error ) );
    CHECK( after.size() == before.size() );
    CHECK( failure_error.find( "not provided" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_food_balance_is_owner_scoped_and_bounded",
           "[lua][platform][camp][food]" )
{
    faction owner;
    owner.empty_food_supply();
    owner.consumes_food = true;

    nutrients added;
    added.calories = 5000;
    owner.add_to_food_supply( { { calendar::turn_zero, added } } );
    CHECK( owner.food_supply().calories == 5000 );

    nutrients requested;
    requested.calories = 3000;
    CHECK( owner.consume_food_supply( requested ).calories == 0 );
    CHECK( owner.food_supply().calories == 2000 );

    // This is the balance the Platform binding must reject before calling the
    // native consumer; the native faction method itself intentionally reports
    // an unfulfilled remainder rather than defining the Lua write contract.
    CHECK( owner.food_supply().calories < 3000 );
    CHECK( owner.consumes_food );
    owner.consumes_food = false;
    CHECK_FALSE( owner.consumes_food );
}

TEST_CASE( "lua_platform_camp_inventory_exposes_only_explicit_storage_holders",
           "[lua][platform][camp][inventory]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 66 );
    basecamp camp( "Storage Camp", tripoint_abs_omt{ 16, 16, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 17 );
    camp.set_storage_tiles( { tripoint_abs_ms{ 160, 161, 0 } } );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 17 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 17 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    CHECK( camps["inventory"]["storage_tiles"].valid() );
    CHECK_FALSE( camps["inventory"]["snapshot"].valid() );
    CHECK( camps["tasks"].valid() );
    CHECK( camp.get_storage_tiles().count( tripoint_abs_ms{ 160, 161, 0 } ) == 1 );
    CHECK( camp_handle.kind() == cata::lua_platform::game_handle_kind::camp );
}

TEST_CASE( "lua_platform_camp_food_mutations_enter_the_write_gate_first",
           "[lua][platform][camp][food]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 67 );
    basecamp camp( "Food Camp", tripoint_abs_omt{ 17, 17, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 18 );
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 18 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 18 ); },
    []() {}, [&]() {
        write_gate_called = true;
        owner->retire();
    } );

    const sol::protected_function add_food = services["camps"]["food"]["add"];
    const sol::protected_function_result result = add_food(
        camp_handle, cata::lua_platform::game_handle{}, 1 );
    REQUIRE( result.valid() );
    CHECK( write_gate_called );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_camp_task_registry_dispatches_each_lifecycle_operation",
           "[lua][platform][camp][tasks]" )
{
    const basecamp_platform_task_kind_executor *executor =
        find_basecamp_platform_task_executor( basecamp_platform_worker_reservation_kind );
    REQUIRE( executor != nullptr );
    REQUIRE( executor->dispatch != nullptr );
    CHECK( executor->supports_preflight );
    CHECK( executor->supports_resolve );
    CHECK( executor->supports_start );
    CHECK( executor->supports_cancel );
    CHECK( executor->supports_complete );

    basecamp_platform_task task;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    basecamp_platform_task_execution_context context;
    context.task = &task;
    std::string error;
    CHECK( dispatch_basecamp_platform_task(
               task.kind, basecamp_platform_task_operation::preflight, context, error ) );
    CHECK( error.empty() );
    CHECK_FALSE( dispatch_basecamp_platform_task(
                     "legacy_ui_task", basecamp_platform_task_operation::preflight,
                     context, error ) );
    CHECK( error.find( "unsupported" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_task_save_load_defers_actor_reconciliation",
           "[lua][platform][camp][tasks][serialization]" )
{
    const faction_id owner_id( "your_followers" );
    basecamp original( "Persisted Task Camp", tripoint_abs_omt{ 18, 18, 0 } );
    original.set_owner( owner_id );

    const npc_ptr worker = make_shared_fast<npc>();
    worker->normalize();
    worker->setID( character_id( 9302 ), true );
    worker->set_fac( owner_id );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 72 );
    constexpr std::size_t world_generation = 24;
    const cata::lua_platform::game_handle old_camp_handle =
        cata::lua_platform::game_handle::from_camp( original, {}, runtime, world_generation );
    const cata::lua_platform::game_handle old_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), {}, runtime, world_generation );
    const cata::lua_platform::game_handle old_worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *worker, {}, runtime, world_generation );

    basecamp_platform_task task;
    task.camp_id = original.platform_id();
    task.owner_faction = owner_id;
    task.manager = get_avatar().getID();
    task.manager_identity_generation = 0;
    task.worker = worker->getID();
    task.worker_identity_generation = worker->platform_identity_generation();
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( original.platform_create_task( task, error ) );
    REQUIRE( original.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 10_turns, error ) );

    const basecamp_platform_task running = original.platform_task_snapshot().front();
    REQUIRE( running.state == basecamp_platform_task_state::running );
    const cata::lua_platform::camp_task_token old_token(
        running.task_id, running.identity_generation, old_camp_handle, old_manager_handle,
        old_worker_handle, running.manager_identity_generation,
        running.worker_identity_generation, runtime, world_generation );

    const auto save_camp = []( basecamp &camp ) {
        std::ostringstream saved;
        JsonOut json( saved );
        camp.serialize( json );
        return saved.str();
    };
    const std::string saved_before_unload = save_camp( original );
    CHECK_FALSE( saved_before_unload.empty() );

    // This is the same release-only boundary used by npc::on_unload(): the
    // durable running record remains while its ephemeral reservation is gone.
    original.platform_release_worker_reservation( *worker );
    CHECK( original.platform_task_snapshot().front().awaiting_reconciliation );
    CHECK( original.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::running );
    cata::lua_platform::retire_npc_handle_identity( *worker );
    cata::lua_platform::retire_camp_handle_identity( original );
    const std::string saved_after_unload = save_camp( original );

    std::ostringstream saved;
    saved << saved_after_unload;

    basecamp restored;
    const JsonValue saved_value = json_loader::from_string( saved.str() );
    restored.deserialize( saved_value.get_object() );
    const std::vector<basecamp_platform_task> loaded = restored.platform_task_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().state == basecamp_platform_task_state::running );
    CHECK( loaded.front().awaiting_reconciliation );

    const basecamp_platform_actor_lookup unknown_lookup =
        []( const character_id ) {
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::unknown, nullptr
            };
        };
    CHECK( restored.platform_reconcile_task_reservations( unknown_lookup, error ) );
    CHECK( restored.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::running );
    CHECK( restored.platform_task_snapshot().front().awaiting_reconciliation );

    const npc_ptr reloaded_worker = make_shared_fast<npc>();
    reloaded_worker->normalize();
    reloaded_worker->setID( worker->getID(), true );
    reloaded_worker->set_fac( owner_id );
    cata::lua_platform::register_npc_handle_identity( *reloaded_worker );
    const std::uint64_t reloaded_generation =
        reloaded_worker->platform_identity_generation();
    CHECK( reloaded_generation != running.worker_identity_generation );

    const basecamp_platform_actor_lookup found_lookup =
        [reloaded_worker]( const character_id id ) {
            if( id == reloaded_worker->getID() ) {
                return basecamp_platform_actor_lookup_result{
                    basecamp_platform_actor_lookup_status::found, reloaded_worker
                };
            }
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::unknown, nullptr
            };
        };
    // This models the found branch of npc::on_load(): the producer publishes
    // the new actor lifetime, then asks the persisted camp record to bind it.
    const auto on_load_reconcile = [&]() {
        return restored.platform_reconcile_task_reservations( found_lookup, error );
    };
    CHECK( on_load_reconcile() );
    const basecamp_platform_task rebound = restored.platform_task_snapshot().front();
    CHECK( rebound.state == basecamp_platform_task_state::running );
    CHECK_FALSE( rebound.awaiting_reconciliation );
    CHECK( rebound.worker_identity_generation == reloaded_generation );
    CHECK( restored.has_exact_worker( *reloaded_worker ) );
    CHECK( reloaded_worker->assigned_camp );
    CHECK( *reloaded_worker->assigned_camp == restored.camp_omt_pos() );

    const std::optional<cata::lua_platform::game_handle_error> old_error =
        old_token.worker_handle().validation_error( runtime, world_generation );
    REQUIRE( old_error );
    CHECK( old_error->code == "stale_identity" );

    const cata::lua_platform::game_handle new_camp_handle =
        cata::lua_platform::game_handle::from_camp( restored, {}, runtime, world_generation );
    const cata::lua_platform::game_handle new_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), {}, runtime, world_generation );
    const cata::lua_platform::game_handle new_worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *reloaded_worker, {}, runtime, world_generation );
    const cata::lua_platform::camp_task_token new_token(
        rebound.task_id, rebound.identity_generation, new_camp_handle, new_manager_handle,
        new_worker_handle, rebound.manager_identity_generation,
        rebound.worker_identity_generation, runtime, world_generation );
    CHECK( new_token.belongs_to( runtime ) );
    CHECK( new_token.matches_context(
               new_camp_handle, new_manager_handle, new_worker_handle ) );
    CHECK_FALSE( new_worker_handle.validation_error( runtime, world_generation ) );
    CHECK_FALSE( new_camp_handle.validation_error( runtime, world_generation ) );
}

TEST_CASE( "lua_platform_camp_task_reconcile_lookup_states_fail_closed",
           "[lua][platform][camp][tasks][serialization]" )
{
    const auto make_task = []( basecamp &camp, const faction_id &owner,
                               const int manager_id, const int worker_id ) {
        basecamp_platform_task task;
        task.camp_id = camp.platform_id();
        task.owner_faction = owner;
        task.manager = character_id( manager_id );
        task.worker = character_id( worker_id );
        task.manager_identity_generation = 1;
        task.worker_identity_generation = 1;
        task.kind = std::string( basecamp_platform_worker_reservation_kind );
        return task;
    };

    const faction_id owner( "lookup_state_owner" );
    basecamp ambiguous_camp( "Ambiguous Lookup Camp", tripoint_abs_omt{ 24, 24, 0 } );
    ambiguous_camp.set_owner( owner );
    basecamp_platform_task ambiguous_task = make_task( ambiguous_camp, owner, 9901, 9902 );
    std::string error;
    REQUIRE( ambiguous_camp.platform_create_task( ambiguous_task, error ) );
    const basecamp_platform_actor_lookup ambiguous_lookup =
        []( const character_id ) {
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::ambiguous, nullptr
            };
        };
    CHECK_FALSE( ambiguous_camp.platform_reconcile_task_reservations(
                     ambiguous_lookup, error ) );
    CHECK( ambiguous_camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::cancelled );

    basecamp orphan_camp( "Authoritative Absence Camp", tripoint_abs_omt{ 25, 25, 0 } );
    orphan_camp.set_owner( owner );
    basecamp_platform_task orphan_task = make_task( orphan_camp, owner, 9911, 9912 );
    REQUIRE( orphan_camp.platform_create_task( orphan_task, error ) );
    const basecamp_platform_actor_lookup authoritative_not_found_lookup =
        []( const character_id ) {
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::authoritative_not_found, nullptr
            };
        };
    CHECK_FALSE( orphan_camp.platform_reconcile_task_reservations(
                     authoritative_not_found_lookup, error ) );
    CHECK( orphan_camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::cancelled );
}

TEST_CASE( "lua_platform_camp_task_token_binds_runtime_context_and_generation",
           "[lua][platform][camp][tasks]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 70 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 70 );
    basecamp camp( "Task Token Camp", tripoint_abs_omt{ 26, 26, 0 } );
    basecamp other_camp( "Other Task Token Camp", tripoint_abs_omt{ 27, 27, 0 } );
    npc manager;
    manager.normalize();
    manager.setID( character_id( 9701 ), true );
    npc worker;
    worker.normalize();
    worker.setID( character_id( 9702 ), true );
    npc other_manager;
    other_manager.normalize();
    other_manager.setID( character_id( 9703 ), true );
    npc other_worker;
    other_worker.normalize();
    other_worker.setID( character_id( 9704 ), true );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 19 );
    const cata::lua_platform::game_handle other_camp_handle =
        cata::lua_platform::game_handle::from_camp( other_camp, {}, runtime, 19 );
    const cata::lua_platform::game_handle manager_handle =
        cata::lua_platform::game_handle::from_creature(
            manager, { "npc", manager.getID().get_value(), 0, 0, 0, {} }, runtime, 19 );
    const cata::lua_platform::game_handle worker_handle =
        cata::lua_platform::game_handle::from_creature(
            worker, { "npc", worker.getID().get_value(), 0, 0, 0, {} }, runtime, 19 );
    const cata::lua_platform::game_handle other_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            other_manager, { "npc", other_manager.getID().get_value(), 0, 0, 0, {} },
            runtime, 19 );
    const cata::lua_platform::game_handle other_worker_handle =
        cata::lua_platform::game_handle::from_creature(
            other_worker, { "npc", other_worker.getID().get_value(), 0, 0, 0, {} },
            runtime, 19 );
    const cata::lua_platform::camp_task_token token(
        1, 2, camp_handle, manager_handle, worker_handle, 3, 4, runtime, 19 );

    CHECK( token.belongs_to( runtime ) );
    CHECK_FALSE( token.belongs_to( other_runtime ) );
    CHECK( token.matches_context( camp_handle, manager_handle, worker_handle ) );
    CHECK_FALSE( token.matches_context(
                    other_camp_handle, manager_handle, worker_handle ) );
    CHECK_FALSE( token.matches_context(
                    camp_handle, other_manager_handle, worker_handle ) );
    CHECK_FALSE( token.matches_context(
                    camp_handle, manager_handle, other_worker_handle ) );
    CHECK( token.identity_generation() == 2 );
    CHECK( token.manager_identity_generation() == 3 );
    CHECK( token.worker_identity_generation() == 4 );
}

TEST_CASE( "lua_platform_camp_task_camp_retirement_is_terminal",
           "[lua][platform][camp][tasks]" )
{
    const faction_id owner_id( "platform_task_camp_owner" );
    basecamp camp( "Retirement Camp", tripoint_abs_omt{ 19, 19, 0 } );
    camp.set_owner( owner_id );
    cata::lua_platform::register_camp_handle_identity( camp );

    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner_id;
    task.manager = character_id( 9401 );
    task.worker = character_id( 9402 );
    task.worker_identity_generation = 1;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );

    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 71 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 20 );
    camp.platform_retire_tasks_for_camp();
    REQUIRE( camp.platform_task_snapshot().front().state ==
             basecamp_platform_task_state::cancelled );

    cata::lua_platform::retire_camp_handle_identity( camp );
    const std::optional<cata::lua_platform::game_handle_error> stale =
        handle.validation_error( runtime, 20 );
    REQUIRE( stale );
    CHECK( stale->code == "stale_camp" );
}

TEST_CASE( "lua_platform_camp_task_unload_releases_reservation_without_cancelling_record",
           "[lua][platform][camp][tasks][npc]" )
{
    const faction_id owner_id( "no_faction" );
    basecamp camp( "Unload Camp", tripoint_abs_omt{ 20, 20, 0 } );
    camp.set_owner( owner_id );
    npc_ptr worker = make_shared_fast<npc>();
    worker->normalize();
    worker->setID( character_id( 9502 ), true );

    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner_id;
    task.manager = character_id( 9501 );
    task.worker = worker->getID();
    task.worker_identity_generation = worker->platform_identity_generation();
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );
    REQUIRE( camp.has_exact_worker( *worker ) );

    camp.platform_release_worker_reservation( *worker );
    const basecamp_platform_task loaded = camp.platform_task_snapshot().front();
    CHECK( loaded.state == basecamp_platform_task_state::running );
    CHECK( loaded.awaiting_reconciliation );
    CHECK_FALSE( worker->assigned_camp );
    CHECK_FALSE( camp.has_exact_worker( *worker ) );
}

TEST_CASE( "lua_platform_camp_task_duplicate_start_keeps_staged_state_unchanged",
           "[lua][platform][camp][tasks]" )
{
    const faction_id owner_id( "platform_task_rollback_owner" );
    basecamp camp( "Rollback Camp", tripoint_abs_omt{ 21, 21, 0 } );
    camp.set_owner( owner_id );
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner_id;
    task.manager = character_id( 9601 );
    task.worker = character_id( 9602 );
    task.worker_identity_generation = 1;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );

    CHECK_FALSE( camp.platform_start_task(
                     task.task_id, task.identity_generation, nullptr,
                     calendar::turn_zero, 1_turns, error ) );
    const std::vector<basecamp_platform_task> after_rejection =
        camp.platform_task_snapshot();
    REQUIRE( after_rejection.size() == 1 );
    CHECK( after_rejection.front().state == basecamp_platform_task_state::pending );
    CHECK( after_rejection.front().identity_generation == 1 );

    basecamp_platform_task duplicate = task;
    duplicate.task_id = 0;
    CHECK_FALSE( camp.platform_create_task( duplicate, error ) );
    CHECK( camp.platform_task_snapshot().size() == 1 );
}

TEST_CASE( "lua_platform_camp_task_owner_change_retires_old_records",
           "[lua][platform][camp][tasks]" )
{
    const faction_id old_owner( "platform_task_old_owner" );
    const faction_id new_owner( "platform_task_new_owner" );
    basecamp camp( "Owner Boundary Camp", tripoint_abs_omt{ 22, 22, 0 } );
    camp.set_owner( old_owner );
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = old_owner;
    task.manager = character_id( 9701 );
    task.worker = character_id( 9702 );
    task.worker_identity_generation = 1;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );

    camp.set_owner( new_owner );
    const basecamp_platform_task retired = camp.platform_task_snapshot().front();
    CHECK( retired.state == basecamp_platform_task_state::cancelled );
    CHECK( retired.identity_generation == 2 );
}

TEST_CASE( "lua_platform_camp_task_unsupported_kind_and_schema_fail_closed",
           "[lua][platform][camp][tasks]" )
{
    std::string error;
    CHECK_FALSE( validate_basecamp_platform_task_kind(
                     "legacy_camp_mission", "{}",
                     basecamp_platform_task_operation::preflight, error ) );
    CHECK( error.find( "unsupported" ) != std::string::npos );

    basecamp camp( "Unsupported Task Camp", tripoint_abs_omt{ 23, 23, 0 } );
    camp.set_owner( faction_id( "platform_task_schema_owner" ) );
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = camp.get_owner();
    task.manager = character_id( 9801 );
    task.worker = character_id( 9802 );
    task.worker_identity_generation = 1;
    task.kind = "unsupported_kind";
    CHECK_FALSE( camp.platform_create_task( task, error ) );
    CHECK( camp.platform_task_snapshot().empty() );
}

TEST_CASE( "lua_platform_camp_task_npc_die_retires_terminal_record",
           "[lua][platform][camp][tasks][npc][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    platform_test_camp_scope camp_scope(
        "NPC Death Task Camp", tripoint_abs_omt{ 100, 100, 0 }, owner );
    REQUIRE( camp_scope.camp != nullptr );

    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9811 ), owner, camp_scope.position );
    overmap_buffer.insert_npc( worker );
    basecamp_platform_task task = make_platform_test_task(
                                      *camp_scope.camp, owner, get_avatar().getID(), *worker );
    std::string error;
    REQUIRE( camp_scope.camp->platform_create_task( task, error ) );

    worker->quiet_death = true;
    worker->spawn_corpse = false;
    worker->die( &get_map(), nullptr );

    REQUIRE( worker->is_dead() );
    const basecamp_platform_task retired =
        camp_scope.camp->platform_task_snapshot().front();
    CHECK( retired.state == basecamp_platform_task_state::cancelled );
    CHECK( retired.identity_generation == task.identity_generation + 1 );
    CHECK_FALSE( worker->assigned_camp );
    CHECK( overmap_buffer.remove_npc( worker->getID() ) );
}

TEST_CASE( "lua_platform_camp_task_same_stable_id_replacement_is_terminal",
           "[lua][platform][camp][tasks][npc][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    platform_test_camp_scope camp_scope(
        "NPC Replacement Task Camp", tripoint_abs_omt{ 101, 101, 0 }, owner );
    REQUIRE( camp_scope.camp != nullptr );

    const character_id stable_id( 9821 );
    const npc_ptr original = make_platform_test_npc(
                                 stable_id, owner, camp_scope.position );
    overmap_buffer.insert_npc( original );
    basecamp_platform_task task = make_platform_test_task(
                                      *camp_scope.camp, owner, get_avatar().getID(), *original );
    std::string error;
    REQUIRE( camp_scope.camp->platform_create_task( task, error ) );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 73 );
    const cata::lua_platform::game_handle old_handle =
        cata::lua_platform::game_handle::from_creature(
            *original, { "npc", stable_id.get_value(), 0, 0, 0, {} }, runtime, 25 );

    const npc_ptr replacement = make_platform_test_npc(
                                    stable_id, owner, camp_scope.position );
    overmap_buffer.insert_npc( replacement );

    const basecamp_platform_task retired =
        camp_scope.camp->platform_task_snapshot().front();
    CHECK( retired.state == basecamp_platform_task_state::cancelled );
    CHECK( retired.identity_generation == task.identity_generation + 1 );
    const std::optional<cata::lua_platform::game_handle_error> stale =
        old_handle.validation_error( runtime, 25 );
    REQUIRE( stale );
    CHECK( stale->code == "stale_identity" );
    CHECK( overmap_buffer.remove_npc( stable_id ) );
}

TEST_CASE( "lua_platform_camp_task_cancel_retires_generation",
           "[lua][platform][camp][tasks][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Cancel Generation Camp", tripoint_abs_omt{ 102, 102, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9831 ), owner, camp.camp_omt_pos() );
    basecamp_platform_task task = make_platform_test_task(
                                      camp, owner, character_id( 9832 ), *worker );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    const std::uint64_t old_generation = task.identity_generation;

    REQUIRE( camp.platform_finish_task(
                 task.task_id, old_generation, worker, calendar::turn_zero, false, error ) );
    const basecamp_platform_task cancelled = camp.platform_task_snapshot().front();
    CHECK( cancelled.state == basecamp_platform_task_state::cancelled );
    CHECK( cancelled.identity_generation == old_generation + 1 );
    CHECK_FALSE( camp.platform_finish_task(
                     task.task_id, old_generation, worker, calendar::turn_zero, false, error ) );
}

TEST_CASE( "lua_platform_camp_task_complete_retires_generation",
           "[lua][platform][camp][tasks][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Complete Generation Camp", tripoint_abs_omt{ 103, 103, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9841 ), owner, camp.camp_omt_pos() );
    basecamp_platform_task task = make_platform_test_task(
                                      camp, owner, character_id( 9842 ), *worker );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );
    const basecamp_platform_task running = camp.platform_task_snapshot().front();
    const std::uint64_t old_generation = running.identity_generation;

    REQUIRE( camp.platform_finish_task(
                 running.task_id, old_generation, worker,
                 calendar::turn_zero + 2_turns, true, error ) );
    const basecamp_platform_task completed = camp.platform_task_snapshot().front();
    CHECK( completed.state == basecamp_platform_task_state::completed );
    CHECK( completed.identity_generation == old_generation + 1 );
    CHECK_FALSE( worker->assigned_camp );
    CHECK_FALSE( camp.platform_finish_task(
                     running.task_id, old_generation, worker,
                     calendar::turn_zero + 2_turns, true, error ) );
}

TEST_CASE( "lua_platform_camp_resource_work_create_keeps_typed_descriptor_detached",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Create Camp", tripoint_abs_omt{ 103, 104, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9845 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.food_input_kcal = 3;
    work.duration_turns = 12;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9846 ), *worker, work );
    std::string error;

    REQUIRE( camp.platform_create_task( task, error ) );
    const std::vector<basecamp_platform_task> created = camp.platform_task_snapshot();
    REQUIRE( created.size() == 1 );
    REQUIRE( created.front().resource_work );
    CHECK( created.front().parameters == basecamp_platform_resource_work_parameter_schema );
    CHECK( created.front().resource_work->food_input_kcal == 3 );
    CHECK( created.front().resource_work->duration_turns == 12 );
    CHECK( created.front().reserved_resources.empty() );
    CHECK( created.front().reserved_food_kcal == 0 );
}

TEST_CASE( "lua_platform_camp_resource_work_descriptor_rejects_invalid_shapes",
           "[lua][platform][camp][tasks][resource_work]" )
{
    basecamp_platform_resource_work valid;
    valid.resource_inputs = { { itype_id( "water" ), 2 } };
    valid.resource_outputs = { { itype_id( "2x4" ), 1 } };
    valid.duration_turns = 10;
    std::string error;
    REQUIRE( validate_basecamp_platform_resource_work( valid, error ) );

    basecamp_platform_resource_work duplicate = valid;
    duplicate.resource_inputs.push_back( { itype_id( "water" ), 1 } );
    CHECK_FALSE( validate_basecamp_platform_resource_work( duplicate, error ) );
    CHECK( error.find( "duplicate" ) != std::string::npos );

    basecamp_platform_resource_work zero_amount = valid;
    zero_amount.resource_inputs.front().delta = 0;
    CHECK_FALSE( validate_basecamp_platform_resource_work( zero_amount, error ) );
    CHECK( error.find( "positive" ) != std::string::npos );

    basecamp_platform_resource_work negative = valid;
    negative.resource_inputs.front().delta = -1;
    CHECK_FALSE( validate_basecamp_platform_resource_work( negative, error ) );
    CHECK( error.find( "positive" ) != std::string::npos );

    basecamp_platform_resource_work zero_effect;
    zero_effect.duration_turns = 10;
    CHECK_FALSE( validate_basecamp_platform_resource_work( zero_effect, error ) );
    CHECK( error.find( "non-zero" ) != std::string::npos );

    basecamp_platform_resource_work overflow = valid;
    overflow.resource_outputs.front().delta = 1000000001;
    CHECK_FALSE( validate_basecamp_platform_resource_work( overflow, error ) );
    CHECK( error.find( "bounded" ) != std::string::npos );

    basecamp_platform_resource_work invalid_duration = valid;
    invalid_duration.duration_turns = 0;
    CHECK_FALSE( validate_basecamp_platform_resource_work( invalid_duration, error ) );
    CHECK( error.find( "duration" ) != std::string::npos );

    basecamp_platform_resource_work zero_food = valid;
    zero_food.food_input_kcal = 0;
    CHECK_FALSE( validate_basecamp_platform_resource_work( zero_food, error ) );
    CHECK( error.find( "positive" ) != std::string::npos );

    CHECK_FALSE( validate_basecamp_platform_task_kind(
                     "unsupported_resource_work", "resource_work_v1",
                     basecamp_platform_task_operation::preflight, error ) );
    CHECK( error.find( "unsupported" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_resource_work_start_reserves_inputs_and_blocks_double_spend",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Reservation Camp", tripoint_abs_omt{ 104, 104, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9851 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 3 } };
    work.resource_outputs = { { itype_id( "2x4" ), 2 } };
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9852 ), *worker, work );

    std::vector<basecamp_platform_task> staged_tasks = { task };
    std::vector<npc_ptr> staged_assigned;
    std::vector<basecamp_resource> staged_resources = {
        { itype_id( "water" ), itype_id(), 5, 0 },
        { itype_id( "2x4" ), itype_id(), 0, 0 },
    };
    basecamp_platform_task_execution_context context;
    context.camp = &camp;
    context.task = &staged_tasks.front();
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.now = calendar::turn_zero;
    context.duration = 1_turns;
    std::string error;

    REQUIRE( dispatch_basecamp_platform_task(
                 task.kind, basecamp_platform_task_operation::preflight, context, error ) );
    REQUIRE( dispatch_basecamp_platform_task(
                 task.kind, basecamp_platform_task_operation::start, context, error ) );
    CHECK( staged_tasks.front().state == basecamp_platform_task_state::running );
    REQUIRE( staged_tasks.front().reserved_resources.size() == 1 );
    CHECK( staged_tasks.front().reserved_resources.front().delta == 3 );
    CHECK( staged_resources.front().available == 2 );
    CHECK( context.commit_worker_assignment );

    const int available_after_reservation = staged_resources.front().available;
    CHECK_FALSE( dispatch_basecamp_platform_task(
                     task.kind, basecamp_platform_task_operation::start, context, error ) );
    CHECK( staged_tasks.front().state == basecamp_platform_task_state::running );
    CHECK( staged_tasks.front().reserved_resources.front().delta == 3 );
    CHECK( staged_resources.front().available == available_after_reservation );
}

TEST_CASE( "lua_platform_camp_resource_work_reservation_liability_has_a_bounded_capacity",
           "[lua][platform][camp][tasks][resource_work][capacity]" )
{
    Character &avatar = get_avatar();
    REQUIRE( avatar.get_faction() != nullptr );
    REQUIRE( g != nullptr );
    faction *owner_faction = g->faction_manager_ptr->get(
                                  avatar.get_faction()->id, false );
    REQUIRE( owner_faction != nullptr );
    platform_food_state_scope food_scope( *owner_faction );
    owner_faction->empty_food_supply();
    owner_faction->consumes_food = true;

    // This is the Platform resource-work bound, expressed in the native
    // micro-calorie representation used by faction food storage.
    constexpr std::int64_t maximum_food_kcal = 1000000000;
    nutrients initial_food;
    initial_food.calories = maximum_food_kcal * 1000;
    owner_faction->add_to_food_supply( { { calendar::turn_zero, initial_food } } );

    const faction_id owner_id = avatar.get_faction()->id;
    basecamp camp( "Resource Work Liability Camp", tripoint_abs_omt{ 104, 105, 0 } );
    camp.set_owner( owner_id );
    const npc_ptr first_worker = make_platform_test_npc(
                                     character_id( 9853 ), owner_id, camp.camp_omt_pos() );
    const npc_ptr second_worker = make_platform_test_npc(
                                      character_id( 9854 ), owner_id, camp.camp_omt_pos() );
    basecamp_platform_resource_work first_work;
    first_work.food_input_kcal = maximum_food_kcal;
    first_work.duration_turns = 1;
    basecamp_platform_task first_task = make_platform_resource_work_test_task(
        camp, owner_id, avatar.getID(), *first_worker, first_work );
    basecamp_platform_resource_work second_work;
    second_work.food_input_kcal = 1;
    second_work.duration_turns = 1;
    basecamp_platform_task second_task = make_platform_resource_work_test_task(
        camp, owner_id, avatar.getID(), *second_worker, second_work );
    std::string error;

    REQUIRE( camp.platform_create_task( first_task, error ) );
    REQUIRE( camp.platform_start_task(
                 first_task.task_id, first_task.identity_generation, first_worker,
                 calendar::turn_zero, 1_turns, error ) );
    nutrients replenished_food;
    replenished_food.calories = 1000;
    owner_faction->add_to_food_supply(
        { { calendar::turn_zero, replenished_food } } );
    REQUIRE( camp.platform_create_task( second_task, error ) );
    REQUIRE( camp.platform_start_task(
                 second_task.task_id, second_task.identity_generation, second_worker,
                 calendar::turn_zero, 1_turns, error ) );

    std::vector<basecamp_platform_resource_change> liability;
    std::int64_t food_liability = 0;
    CHECK_FALSE( camp.platform_reservation_liability(
                     liability, food_liability, error ) );
    CHECK( error.find( "exceeds capacity" ) != std::string::npos );
    CHECK( food_liability == maximum_food_kcal );
}

TEST_CASE( "lua_platform_camp_resource_work_cancel_refunds_reservation_atomically",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Cancel Camp", tripoint_abs_omt{ 105, 105, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9861 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 2 } };
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9862 ), *worker, work );
    task.state = basecamp_platform_task_state::running;
    task.started_at = calendar::turn_zero;
    task.due_at = calendar::turn_zero + 1_turns;
    task.reserved_resources = work.resource_inputs;

    std::vector<basecamp_platform_task> staged_tasks = { task };
    std::vector<npc_ptr> staged_assigned = { worker };
    std::vector<basecamp_resource> staged_resources = {
        { itype_id( "water" ), itype_id(), 3, 0 },
    };
    worker->assigned_camp = camp.camp_omt_pos();
    basecamp_platform_task_execution_context context;
    context.camp = &camp;
    context.task = &staged_tasks.front();
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.now = calendar::turn_zero + 1_turns;
    std::string error;

    REQUIRE( dispatch_basecamp_platform_task(
                 task.kind, basecamp_platform_task_operation::cancel, context, error ) );
    CHECK( staged_resources.front().available == 5 );
    CHECK( staged_tasks.front().state == basecamp_platform_task_state::cancelled );
    CHECK( staged_tasks.front().reserved_resources.empty() );
    CHECK( staged_tasks.front().identity_generation == task.identity_generation + 1 );
    CHECK( context.commit_worker_release );
    worker->assigned_camp.reset();
}

TEST_CASE( "lua_platform_camp_resource_work_complete_is_atomic_and_retryable_on_output_overflow",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Complete Camp", tripoint_abs_omt{ 106, 106, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9871 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 2 } };
    work.resource_outputs = { { itype_id( "2x4" ), 2 } };
    work.duration_turns = 1;
    const basecamp_platform_task original = make_platform_resource_work_test_task(
        camp, owner, character_id( 9872 ), *worker, work );
    basecamp_platform_task running = original;
    running.state = basecamp_platform_task_state::running;
    running.started_at = calendar::turn_zero;
    running.due_at = calendar::turn_zero + 1_turns;
    running.reserved_resources = work.resource_inputs;

    const auto finish = [&]( basecamp_platform_task &task,
                             std::vector<basecamp_resource> &resources ) {
        std::vector<basecamp_platform_task> staged_tasks = { task };
        std::vector<npc_ptr> staged_assigned = { worker };
        std::vector<basecamp_resource> staged_resources = resources;
        basecamp_platform_task_execution_context context;
        context.camp = &camp;
        context.task = &staged_tasks.front();
        context.worker = worker;
        context.staged_tasks = &staged_tasks;
        context.staged_assigned = &staged_assigned;
        context.staged_resources = &staged_resources;
        context.now = calendar::turn_zero + 1_turns;
        context.complete = true;
        worker->assigned_camp = camp.camp_omt_pos();
        std::string error;
        const bool completed = dispatch_basecamp_platform_task(
                                   task.kind, basecamp_platform_task_operation::complete,
                                   context, error );
        task = staged_tasks.front();
        if( completed ) {
            resources.swap( staged_resources );
            CHECK( task.state == basecamp_platform_task_state::completed );
            CHECK( task.reserved_resources.empty() );
            CHECK( resources.back().available == 2 );
        } else {
            CHECK( task.state == basecamp_platform_task_state::running );
            REQUIRE( task.reserved_resources.size() == work.resource_inputs.size() );
            CHECK( task.reserved_resources.front().resource_id ==
                   work.resource_inputs.front().resource_id );
            CHECK( task.reserved_resources.front().delta ==
                   work.resource_inputs.front().delta );
            CHECK( resources.front().available == 3 );
            CHECK( resources.front().consumed == 0 );
        }
        worker->assigned_camp.reset();
        return completed;
    };

    std::vector<basecamp_resource> overflow_resources = {
        { itype_id( "water" ), itype_id(), 3, 0 },
        { itype_id( "2x4" ), itype_id(), std::numeric_limits<int>::max(), 0 },
    };
    CHECK_FALSE( finish( running, overflow_resources ) );
    CHECK( running.state == basecamp_platform_task_state::running );
    REQUIRE( running.reserved_resources.size() == work.resource_inputs.size() );
    CHECK( running.reserved_resources.front().resource_id ==
           work.resource_inputs.front().resource_id );
    CHECK( running.reserved_resources.front().delta ==
           work.resource_inputs.front().delta );

    std::vector<basecamp_resource> retry_resources = {
        { itype_id( "water" ), itype_id(), 3, 0 },
        { itype_id( "2x4" ), itype_id(), 0, 0 },
    };
    CHECK( finish( running, retry_resources ) );
    CHECK( running.state == basecamp_platform_task_state::completed );
    CHECK( running.identity_generation == original.identity_generation + 1 );
}

TEST_CASE( "lua_platform_camp_resource_work_liability_and_food_list_are_persisted",
           "[lua][platform][camp][tasks][resource_work][serialization]" )
{
    const auto write_task_save = []( const bool duplicate_reservation,
                                     const bool include_resource_input ) {
        const faction_id owner( "your_followers" );
        const tripoint_abs_omt position{ 107, 107, 0 };
        std::ostringstream saved;
        JsonOut json( saved );
        json.start_object();
        json.member( "owner", owner );
        json.member( "name", "Resource Work Save Camp" );
        json.member( "pos", position );
        json.member( "platform_id", static_cast<std::uint64_t>( 98701 ) );
        json.member( "platform_tasks_version", basecamp_platform_task_schema_version );
        json.member( "platform_tasks" );
        json.start_array();
        json.start_object();
        json.member( "task_id", static_cast<std::uint64_t>( 98702 ) );
        json.member( "generation", static_cast<std::uint64_t>( 1 ) );
        json.member( "camp_id", static_cast<std::uint64_t>( 98701 ) );
        json.member( "owner_faction", owner );
        json.member( "manager_id", character_id( 98703 ) );
        json.member( "worker_id", character_id( 98704 ) );
        json.member( "manager_identity_generation", static_cast<std::uint64_t>( 0 ) );
        json.member( "worker_identity_generation", static_cast<std::uint64_t>( 1 ) );
        json.member( "kind", std::string( basecamp_platform_resource_work_kind ) );
        json.member( "parameters", std::string( basecamp_platform_resource_work_parameter_schema ) );
        json.member( "state", "running" );
        json.member( "started_at", calendar::turn_zero );
        json.member( "due_at", calendar::turn_zero + 10_turns );
        json.member( "resource_work" );
        json.start_object();
        json.member( "resource_inputs" );
        json.start_array();
        if( include_resource_input ) {
            json.start_object();
            json.member( "id", "water" );
            json.member( "amount", static_cast<std::int64_t>( 2 ) );
            json.end_object();
        }
        json.end_array();
        json.member( "resource_outputs" );
        json.start_array();
        if( include_resource_input ) {
            json.start_object();
            json.member( "id", "2x4" );
            json.member( "amount", static_cast<std::int64_t>( 1 ) );
            json.end_object();
        }
        json.end_array();
        if( !include_resource_input ) {
            json.member( "food_input_kcal", static_cast<std::int64_t>( 4 ) );
        }
        json.member( "duration_turns", static_cast<std::int64_t>( 10 ) );
        json.end_object();
        json.member( "reserved_resources" );
        json.start_array();
        if( include_resource_input ) {
            for( int count = 0; count < ( duplicate_reservation ? 2 : 1 ); ++count ) {
                json.start_object();
                json.member( "id", "water" );
                json.member( "amount", static_cast<std::int64_t>( 2 ) );
                json.end_object();
            }
        }
        json.end_array();
        json.member( "reserved_food_kcal", include_resource_input ? 0 : 4 );
        json.member( "reservation_discarded", false );
        json.end_object();
        json.end_array();
        json.member( "bb_pos", tripoint_abs_ms::zero );
        json.member( "dumping_spot", tripoint_abs_ms::zero );
        json.member( "liquid_dumping_spots" );
        json.start_array();
        json.end_array();
        json.member( "hidden_missions" );
        json.start_array();
        json.end_array();
        json.member( "expansions" );
        json.start_array();
        json.end_array();
        json.member( "fortifications" );
        json.start_array();
        json.end_array();
        json.member( "salt_water_pipes" );
        json.start_array();
        json.end_array();
        json.end_object();
        return saved.str();
    };

    basecamp restored;
    const JsonValue saved = json_loader::from_string(
                                write_task_save( false, true ) );
    restored.deserialize( saved.get_object() );
    const std::vector<basecamp_platform_task> loaded = restored.platform_task_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().state == basecamp_platform_task_state::running );
    CHECK( loaded.front().resource_work );
    REQUIRE( loaded.front().reserved_resources.size() == 1 );
    CHECK( loaded.front().reserved_resources.front().delta == 2 );

    basecamp food_restored;
    const JsonValue food_saved = json_loader::from_string(
                                     write_task_save( false, false ) );
    food_restored.deserialize( food_saved.get_object() );
    std::vector<basecamp_platform_resource_change> resource_liability;
    std::int64_t food_liability = 0;
    std::string error;
    REQUIRE( food_restored.platform_reservation_liability(
                 resource_liability, food_liability, error ) );
    CHECK( resource_liability.empty() );
    CHECK( food_liability == 4 );

    faction detached_food_owner;
    detached_food_owner.empty_food_supply();
    detached_food_owner.consumes_food = true;
    nutrients detached_food;
    detached_food.calories = 12000;
    detached_food_owner.add_to_food_supply(
        { { calendar::turn_zero, detached_food } } );
    const platform_food_storage saved_food = detached_food_owner.debug_food_supply();
    nutrients consumed_food;
    consumed_food.calories = 5000;
    detached_food_owner.consume_food_supply( consumed_food );
    detached_food_owner.debug_food_supply() = saved_food;
    CHECK( detached_food_owner.food_supply().calories == 12000 );

    basecamp duplicate_restored;
    const JsonValue duplicate_saved = json_loader::from_string(
                                           write_task_save( true, true ) );
    duplicate_restored.deserialize( duplicate_saved.get_object() );
    CHECK( duplicate_restored.platform_task_snapshot().empty() );
}

TEST_CASE( "lua_platform_camp_resource_work_equivalent_fake_ids_and_load_order_are_bounded",
           "[lua][platform][camp][tasks][resource_work][serialization]" )
{
    basecamp_resource first;
    first.fake_id = itype_id( "water" );
    first.ammo_id = itype_id( "battery" );
    first.available = 2;
    basecamp_resource equivalent = first;
    equivalent.available = 3;
    std::vector<basecamp_resource> normalized;
    std::string error;
    REQUIRE( basecamp::platform_normalize_resources(
                 { first, equivalent }, normalized, error ) );
    REQUIRE( normalized.size() == 1 );
    CHECK( normalized.front().available == 5 );

    basecamp_resource ambiguous = equivalent;
    ambiguous.ammo_id = itype_id( "2x4" );
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { first, ambiguous }, normalized, error ) );
    CHECK( error.find( "conflicting" ) != std::string::npos );

    // A persisted descriptor is retained before storage resources are rebuilt;
    // reconciliation, not deserialization order, decides whether its fake id
    // is a valid camp resource.
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 1 } };
    work.duration_turns = 1;
    CHECK( validate_basecamp_platform_resource_work( work, error ) );
}

TEST_CASE( "lua_platform_camp_resource_work_terminal_lifecycle_policy_is_explicit",
           "[lua][platform][camp][tasks][resource_work][lifecycle]" )
{
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 1 } };
    work.duration_turns = 1;
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Lifecycle Policy Camp", tripoint_abs_omt{ 108, 108, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9881 ), owner, camp.camp_omt_pos() );
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9882 ), *worker, work );
    task.state = basecamp_platform_task_state::running;
    task.started_at = calendar::turn_zero;
    task.due_at = calendar::turn_zero + 1_turns;
    task.reserved_resources = work.resource_inputs;
    task.reservation_discarded = true;

    // The terminal marker is persisted only after a camp/death boundary cannot
    // refund safely; ordinary unload/cancel must leave this marker false and
    // retain the ledger until the explicit refund commit.
    CHECK( task.reservation_discarded );
    task.reservation_discarded = false;
    CHECK_FALSE( task.reservation_discarded );
    CHECK( task.resource_work->resource_inputs.front().resource_id ==
           task.reserved_resources.front().resource_id );
    CHECK( camp.platform_task_snapshot().empty() );
}

TEST_CASE( "lua_platform_camp_resource_work_death_and_owner_change_refund",
           "[lua][platform][camp][tasks][resource_work][lifecycle]" )
{
    Character &avatar = get_avatar();
    REQUIRE( avatar.get_faction() != nullptr );
    REQUIRE( g != nullptr );
    faction *owner_faction = g->faction_manager_ptr->get(
                                  avatar.get_faction()->id, false );
    REQUIRE( owner_faction != nullptr );
    platform_food_state_scope food_scope( *owner_faction );
    owner_faction->empty_food_supply();
    owner_faction->consumes_food = true;
    nutrients initial_food;
    initial_food.calories = 100000;
    owner_faction->add_to_food_supply( { { calendar::turn_zero, initial_food } } );

    const faction_id owner_id = avatar.get_faction()->id;
    const faction_id replacement_owner( "resource_work_replacement_owner" );
    basecamp camp( "Resource Work Death Camp", tripoint_abs_omt{ 109, 109, 0 } );
    camp.set_owner( owner_id );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9891 ), owner_id, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.food_input_kcal = 10;
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner_id, avatar.getID(), *worker, work );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );
    CHECK( owner_faction->food_supply().calories == 90000 );

    // This is the producer-side path used by npc::die(): the task is terminal
    // only after its held food is refunded.
    camp.platform_retire_tasks_for_worker( *worker );
    const basecamp_platform_task death_cancelled = camp.platform_task_snapshot().front();
    CHECK( death_cancelled.state == basecamp_platform_task_state::cancelled );
    CHECK_FALSE( death_cancelled.reservation_discarded );
    CHECK( owner_faction->food_supply().calories == 100000 );

    basecamp owner_change_camp( "Resource Work Owner Camp", tripoint_abs_omt{ 110, 110, 0 } );
    owner_change_camp.set_owner( owner_id );
    const npc_ptr second_worker = make_platform_test_npc(
                                      character_id( 9892 ), owner_id,
                                      owner_change_camp.camp_omt_pos() );
    basecamp_platform_task second_task = make_platform_resource_work_test_task(
        owner_change_camp, owner_id, avatar.getID(), *second_worker, work );
    REQUIRE( owner_change_camp.platform_create_task( second_task, error ) );
    REQUIRE( owner_change_camp.platform_start_task(
                 second_task.task_id, second_task.identity_generation, second_worker,
                 calendar::turn_zero, 1_turns, error ) );
    owner_change_camp.set_owner( replacement_owner );
    const basecamp_platform_task owner_cancelled =
        owner_change_camp.platform_task_snapshot().front();
    CHECK( owner_cancelled.state == basecamp_platform_task_state::cancelled );
    CHECK_FALSE( owner_cancelled.reservation_discarded );
}

TEST_CASE( "lua_platform_camp_resource_work_camp_removal_records_discard_when_refund_is_unsafe",
           "[lua][platform][camp][tasks][resource_work][lifecycle]" )
{
    Character &avatar = get_avatar();
    REQUIRE( avatar.get_faction() != nullptr );
    REQUIRE( g != nullptr );
    faction *owner_faction = g->faction_manager_ptr->get(
                                  avatar.get_faction()->id, false );
    REQUIRE( owner_faction != nullptr );
    platform_food_state_scope food_scope( *owner_faction );
    owner_faction->empty_food_supply();
    owner_faction->consumes_food = true;
    nutrients initial_food;
    initial_food.calories = 100000;
    owner_faction->add_to_food_supply( { { calendar::turn_zero, initial_food } } );

    const faction_id owner_id = avatar.get_faction()->id;
    basecamp camp( "Resource Work Discard Camp", tripoint_abs_omt{ 111, 111, 0 } );
    camp.set_owner( owner_id );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9893 ), owner_id, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.food_input_kcal = 10;
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner_id, avatar.getID(), *worker, work );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );

    // Simulate a camp-removal boundary where the native food store has become
    // unrepresentable.  The terminal record must say discard, never retain a
    // silently dangling liability.
    owner_faction->debug_food_supply().front().second.calories =
        std::numeric_limits<std::int64_t>::max();
    camp.platform_retire_tasks_for_camp();
    const basecamp_platform_task discarded = camp.platform_task_snapshot().front();
    CHECK( discarded.state == basecamp_platform_task_state::cancelled );
    CHECK( discarded.reservation_discarded );
    CHECK( discarded.reserved_resources.empty() );
    CHECK( discarded.reserved_food_kcal == 0 );
}

TEST_CASE( "lua_platform_recipe_item_staging_is_atomic_and_rejects_double_spend",
           "[lua][platform][camp][tasks][recipe_work][items]" )
{
    avatar source;
    source.normalize();
    source.setID( character_id( 99501 ), true );
    item charge_stack( itype_id( "tinder" ), calendar::turn_zero );
    charge_stack.charges = 8;
    item &added_stack = source.inv->add_item(
                            std::move( charge_stack ), false, false, false );
    item_location location( source, &added_stack );
    REQUIRE( static_cast<bool>( location ) );
    item *live_stack = location.get_item();
    REQUIRE( live_stack != nullptr );
    const std::int64_t stack_uid = live_stack->uid().get_value();

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 95 );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            source, { "character", source.getID().get_value(), 0, 0, 0, {} },
            runtime, 1 );
    const cata::lua_platform::game_handle item_handle =
        cata::lua_platform::game_handle::from_item(
            *live_stack, { "character_inventory", stack_uid, 0, 0, 0, {} }, runtime, 1 );

    sol::state lua;
    const sol::table holder = make_platform_recipe_holder_table( lua, character_handle );
    const cata::lua_platform::platform_recipe_item_request request = {
        item_handle, holder, 3, false
    };
    const std::vector<cata::lua_platform::platform_recipe_item_request> duplicate_requests = {
        request, request
    };
    std::vector<basecamp_platform_recipe_escrow_item> staged;
    cata::lua_platform::platform_recipe_item_transaction transaction;
    const std::optional<cata::lua_platform::game_handle_error> duplicate_error =
        cata::lua_platform::stage_platform_recipe_items(
            duplicate_requests, runtime, 1, staged, transaction );
    REQUIRE( duplicate_error );
    CHECK( duplicate_error->code == "duplicate_item" );
    CHECK( staged.empty() );
    CHECK( live_stack->charges == 8 );
    CHECK_FALSE( static_cast<bool>( transaction.rollback ) );

    const std::optional<cata::lua_platform::game_handle_error> staged_error =
        cata::lua_platform::stage_platform_recipe_items(
            { request }, runtime, 1, staged, transaction );
    CHECK_FALSE( staged_error );
    REQUIRE( staged.size() == 1 );
    CHECK( staged.front().stable_uid > 0 );
    CHECK( staged.front().stable_uid != stack_uid );
    CHECK( staged.front().charges == 3 );
    CHECK( live_stack->charges == 5 );
    REQUIRE( transaction.rollback_now() );
    CHECK( live_stack->charges == 8 );
}

TEST_CASE( "lua_platform_recipe_work_staging_keeps_nonconsumed_tools_whole",
           "[lua][platform][camp][tasks][recipe_work][items]" )
{
    avatar source;
    source.normalize();
    source.setID( character_id( 99502 ), true );
    item &added_tool = source.inv->add_item(
                           item( itype_id( "rock" ), calendar::turn_zero ),
                           false, false, false );
    item_location location( source, &added_tool );
    REQUIRE( static_cast<bool>( location ) );
    item *live_tool = location.get_item();
    REQUIRE( live_tool != nullptr );
    const std::int64_t tool_uid = live_tool->uid().get_value();

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 96 );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            source, { "character", source.getID().get_value(), 0, 0, 0, {} },
            runtime, 1 );
    const cata::lua_platform::game_handle item_handle =
        cata::lua_platform::game_handle::from_item(
            *live_tool, { "character_inventory", tool_uid, 0, 0, 0, {} }, runtime, 1 );
    sol::state lua;
    const cata::lua_platform::platform_recipe_item_request request = {
        item_handle, make_platform_recipe_holder_table( lua, character_handle ), 1, true
    };
    std::vector<basecamp_platform_recipe_escrow_item> staged;
    cata::lua_platform::platform_recipe_item_transaction transaction;
    CHECK_FALSE( cata::lua_platform::stage_platform_recipe_items(
                     { request }, runtime, 1, staged, transaction ) );
    REQUIRE( staged.size() == 1 );
    CHECK( staged.front().stable_uid == tool_uid );
    CHECK( staged.front().charges == 1 );
    CHECK( staged.front().tool );
    REQUIRE( transaction.rollback_now() );

    bool restored = false;
    std::vector<std::int64_t> restored_uids;
    source.inv->visit_items( [&restored, &restored_uids, tool_uid]( item *candidate, item * ) {
        if( candidate != nullptr ) {
            restored_uids.push_back( candidate->uid().get_value() );
        }
        if( candidate != nullptr && candidate->uid().get_value() == tool_uid ) {
            restored = true;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    CAPTURE( tool_uid, restored_uids );
    CHECK( restored );
}

TEST_CASE( "lua_platform_recipe_work_rejects_invalid_descriptor_and_escrow",
           "[lua][platform][camp][tasks][recipe_work][preflight]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Invalid Shape Camp", tripoint_abs_omt{ 112, 112, 0 }, character_id( 99503 ) );
    std::string error;

    basecamp_platform_recipe_work invalid = fixture.work;
    invalid.batch = 0;
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.batch = 1001;
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.duration_turns = 0;
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.duration_turns = std::numeric_limits<std::int64_t>::max();
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.source_holders.push_back( invalid.source_holders.front() );
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );

    REQUIRE( fixture.camp.platform_create_task( fixture.task, error ) );
    const basecamp_platform_task pending = fixture.camp.platform_task_snapshot().front();
    const auto rejected_escrow = [&](
        const std::vector<basecamp_platform_recipe_escrow_item> &candidate ) {
        error.clear();
        CHECK_FALSE( fixture.camp.platform_start_task(
                         pending.task_id, pending.identity_generation, fixture.worker,
                         calendar::turn_zero,
                         time_duration::from_turns( fixture.work.duration_turns ), candidate,
                         error ) );
        const basecamp_platform_task unchanged = fixture.camp.platform_task_snapshot().front();
        CHECK( unchanged.state == basecamp_platform_task_state::pending );
        CHECK( unchanged.recipe_escrow.empty() );
        CHECK_FALSE( fixture.worker->assigned_camp );
        CHECK_FALSE( error.empty() );
    };

    std::vector<basecamp_platform_recipe_escrow_item> candidate = fixture.escrow;
    candidate.front().stable_uid = 0;
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.front().charges = 0;
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.front().charges = -1;
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.front().charges = std::numeric_limits<std::int64_t>::max();
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.push_back( candidate.front() );
    rejected_escrow( candidate );
}

TEST_CASE( "lua_platform_recipe_work_refund_pending_rejects_stale_holder_and_recovers_explicitly",
           "[lua][platform][camp][tasks][recipe_work][recovery]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Refund Recovery Camp", tripoint_abs_omt{ 113, 113, 0 }, character_id( 99504 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    REQUIRE( running.state == basecamp_platform_task_state::running );
    const std::vector<basecamp_platform_recipe_escrow_item> original_escrow =
        running.recipe_escrow;

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 97 );
    constexpr std::size_t world_generation = 1;
    cata::lua_platform::register_camp_handle_identity( fixture.camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp(
            fixture.camp, {}, runtime, world_generation );
    const cata::lua_platform::game_handle manager_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", get_avatar().getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const cata::lua_platform::game_handle worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *fixture.worker,
            { "npc", fixture.worker->getID().get_value(), 0, 0, 0, {} }, runtime,
            world_generation );
    const cata::lua_platform::camp_task_token old_token(
        running.task_id, running.identity_generation, camp_handle, manager_handle,
        worker_handle, running.manager_identity_generation,
        running.worker_identity_generation, runtime, world_generation );

    std::string error;
    REQUIRE( fixture.camp.platform_finish_task(
                 running.task_id, running.identity_generation, fixture.worker,
                 calendar::turn_zero, false, original_escrow, error ) );
    const basecamp_platform_task pending = fixture.camp.platform_task_snapshot().front();
    CHECK( pending.state == basecamp_platform_task_state::refund_pending );
    CHECK( pending.identity_generation == running.identity_generation + 1 );
    CHECK( pending.recipe_escrow.size() == original_escrow.size() );
    CHECK_FALSE( fixture.worker->assigned_camp );

    CHECK_FALSE( fixture.camp.platform_claim_recipe_escrow(
                     pending.task_id, old_token.identity_generation(), calendar::turn_zero,
                     false, original_escrow, error ) );
    CHECK( error.find( "stale" ) != std::string::npos );

    std::vector<basecamp_platform_recipe_escrow_item> stale_holder = pending.recipe_escrow;
    stale_holder.front().source_holder.identity_generation++;
    CHECK_FALSE( fixture.camp.platform_claim_recipe_escrow(
                     pending.task_id, pending.identity_generation, calendar::turn_zero, false,
                     stale_holder, error ) );
    CHECK( error.find( "does not match" ) != std::string::npos );
    CHECK( fixture.camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::refund_pending );
    CHECK( fixture.camp.platform_task_snapshot().front().recipe_escrow.size() ==
           original_escrow.size() );

    std::vector<basecamp_platform_recipe_escrow_item> prepared_refund;
    REQUIRE( fixture.camp.platform_prepare_recipe_refund(
                 pending.task_id, pending.identity_generation, nullptr, prepared_refund,
                 error ) );
    CHECK( prepared_refund.size() == original_escrow.size() );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; },
        [world_generation]() { return world_generation; }, []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; },
    [world_generation]() { return world_generation; }, []() {}, []() {} );
    const sol::protected_function resolve = services["camps"]["tasks"]["resolve"];
    const sol::table invalid_destination = make_platform_recipe_holder_table(
                                               lua, cata::lua_platform::game_handle{} );
    const cata::lua_platform::camp_task_token pending_token(
        pending.task_id, pending.identity_generation, camp_handle, manager_handle,
        worker_handle, pending.manager_identity_generation,
        pending.worker_identity_generation, runtime, world_generation );
    const sol::protected_function_result failed = resolve(
            camp_handle, manager_handle, worker_handle, pending_token, invalid_destination );
    REQUIRE( failed.valid() );
    const sol::table failed_envelope = failed.get<sol::table>();
    CHECK_FALSE( failed_envelope["ok"].get<bool>() );
    CHECK( failed_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_kind" );
    CHECK( fixture.camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::refund_pending );
    CHECK( fixture.camp.platform_task_snapshot().front().recipe_escrow.size() ==
           original_escrow.size() );

    avatar fallback;
    fallback.normalize();
    fallback.setID( character_id( 99505 ), true );
    const cata::lua_platform::game_handle fallback_handle =
        cata::lua_platform::game_handle::from_creature(
            fallback, { "character", fallback.getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const sol::table fallback_destination = make_platform_recipe_holder_table(
                                                lua, fallback_handle );
    const sol::protected_function_result recovered = resolve(
            camp_handle, manager_handle, worker_handle, pending_token, fallback_destination );
    REQUIRE( recovered.valid() );
    const sol::table recovered_envelope = recovered.get<sol::table>();
    std::string recovered_error_code;
    std::string recovered_error_message;
    if( !recovered_envelope["ok"].get<bool>() ) {
        const sol::table recovered_error = recovered_envelope["error"];
        recovered_error_code = recovered_error["code"].get<std::string>();
        recovered_error_message = recovered_error["message"].get<std::string>();
    }
    CAPTURE( recovered_error_code, recovered_error_message );
    REQUIRE( recovered_envelope["ok"].get<bool>() );
    const basecamp_platform_task claimed = fixture.camp.platform_task_snapshot().front();
    CHECK( claimed.state == basecamp_platform_task_state::cancelled );
    CHECK( claimed.recipe_escrow.empty() );
    CHECK( claimed.identity_generation == pending.identity_generation + 1 );

    bool found_fallback_item = false;
    const std::int64_t recovered_uid = original_escrow.front().stable_uid;
    fallback.visit_items( [&found_fallback_item, recovered_uid]( item *candidate, item * ) {
        if( candidate != nullptr && candidate->uid().get_value() == recovered_uid ) {
            found_fallback_item = true;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    CHECK( found_fallback_item );
}

TEST_CASE( "lua_platform_recipe_work_completion_is_authoritative_and_not_repeated",
           "[lua][platform][camp][tasks][recipe_work][completion]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Completion Camp", tripoint_abs_omt{ 114, 114, 0 }, character_id( 99506 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    const std::vector<basecamp_platform_recipe_escrow_item> original_escrow =
        running.recipe_escrow;
    const time_point due = calendar::turn_zero +
                           time_duration::from_turns( fixture.work.duration_turns );
    std::string error;
    const std::vector<basecamp_platform_recipe_escrow_item> empty_settlement;

    CHECK_FALSE( fixture.camp.platform_complete_recipe_task(
                     running.task_id, running.identity_generation, fixture.worker, due,
                     original_escrow, empty_settlement, error ) );
    const basecamp_platform_task after_rejected_completion =
        fixture.camp.platform_task_snapshot().front();
    CHECK( after_rejected_completion.state == basecamp_platform_task_state::running );
    CHECK( after_rejected_completion.recipe_escrow.size() == original_escrow.size() );
    CHECK( after_rejected_completion.recipe_commit_marker == 0 );

    std::vector<basecamp_platform_recipe_escrow_item> settled;
    REQUIRE( fixture.camp.platform_prepare_recipe_completion(
                 running.task_id, running.identity_generation, fixture.worker, due, settled,
                 error ) );
    REQUIRE( !settled.empty() );
    CHECK( std::any_of( settled.begin(), settled.end(), [&original_escrow](
    const basecamp_platform_recipe_escrow_item &candidate ) {
        return std::none_of( original_escrow.begin(), original_escrow.end(),
        [&candidate]( const basecamp_platform_recipe_escrow_item &original ) {
            return original.stable_uid == candidate.stable_uid;
        } );
    } ) );
    REQUIRE( fixture.camp.platform_complete_recipe_task(
                 running.task_id, running.identity_generation, fixture.worker, due,
                 original_escrow, settled, error ) );
    const basecamp_platform_task committed = fixture.camp.platform_task_snapshot().front();
    CHECK( committed.state == basecamp_platform_task_state::completed_unclaimed );
    CHECK( committed.recipe_commit_marker == running.identity_generation );
    CHECK( committed.recipe_escrow.size() == settled.size() );
    CHECK_FALSE( fixture.worker->assigned_camp );

    const std::vector<basecamp_platform_recipe_escrow_item> committed_escrow =
        committed.recipe_escrow;
    CHECK_FALSE( fixture.camp.platform_complete_recipe_task(
                     committed.task_id, committed.identity_generation, fixture.worker, due,
                     original_escrow, settled, error ) );
    CHECK( error.find( "already committed" ) != std::string::npos );
    CHECK_FALSE( fixture.camp.platform_prepare_recipe_completion(
                     committed.task_id, committed.identity_generation, fixture.worker, due,
                     settled, error ) );
    const basecamp_platform_task after_repeat = fixture.camp.platform_task_snapshot().front();
    CHECK( after_repeat.state == basecamp_platform_task_state::completed_unclaimed );
    CHECK( after_repeat.recipe_commit_marker == committed.recipe_commit_marker );
    CHECK( after_repeat.recipe_escrow.size() == committed_escrow.size() );
}

TEST_CASE( "lua_platform_recipe_work_save_load_preserves_valid_and_isolates_invalid_escrow",
           "[lua][platform][camp][tasks][recipe_work][serialization]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Save Load Camp", tripoint_abs_omt{ 115, 115, 0 }, character_id( 99507 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    REQUIRE( !running.recipe_escrow.empty() );

    const auto serialize_camp = []( const basecamp &camp ) {
        std::ostringstream saved;
        JsonOut json( saved );
        camp.serialize( json );
        return saved.str();
    };
    const std::string valid_save = serialize_camp( fixture.camp );
    basecamp restored;
    const JsonValue valid_value = json_loader::from_string( valid_save );
    restored.deserialize( valid_value.get_object() );
    const std::vector<basecamp_platform_task> loaded = restored.platform_task_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().state == basecamp_platform_task_state::running );
    CHECK( loaded.front().awaiting_reconciliation );
    CHECK_FALSE( loaded.front().recipe_recovery_required );
    CHECK( loaded.front().recipe_escrow.size() == running.recipe_escrow.size() );
    CHECK( loaded.front().recipe_escrow.front().stable_uid ==
           running.recipe_escrow.front().stable_uid );

    std::string invalid_save = valid_save;
    const std::string stable_uid_key = "\"stable_uid\":";
    const std::size_t stable_uid_position = invalid_save.find( stable_uid_key );
    REQUIRE( stable_uid_position != std::string::npos );
    const std::size_t value_begin = stable_uid_position + stable_uid_key.size();
    const std::size_t value_end = invalid_save.find( ',', value_begin );
    REQUIRE( value_end != std::string::npos );
    invalid_save.replace( value_begin, value_end - value_begin, "-1" );

    basecamp invalid_restored;
    const JsonValue invalid_value = json_loader::from_string( invalid_save );
    invalid_restored.deserialize( invalid_value.get_object() );
    const std::vector<basecamp_platform_task> isolated =
        invalid_restored.platform_task_snapshot();
    REQUIRE( isolated.size() == 1 );
    REQUIRE( isolated.front().recipe_recovery_required );
    CHECK( isolated.front().state == basecamp_platform_task_state::refund_pending );
    REQUIRE( !isolated.front().recipe_escrow.empty() );

    std::string error;
    std::vector<basecamp_platform_recipe_escrow_item> recovery_escrow;
    REQUIRE( invalid_restored.platform_prepare_recipe_refund(
                 isolated.front().task_id, isolated.front().identity_generation, nullptr,
                 recovery_escrow, error ) );
    REQUIRE( invalid_restored.platform_claim_recipe_escrow(
                 isolated.front().task_id, isolated.front().identity_generation,
                 calendar::turn_zero, false, recovery_escrow, error ) );
    const basecamp_platform_task recovered = invalid_restored.platform_task_snapshot().front();
    CHECK( recovered.state == basecamp_platform_task_state::cancelled );
    CHECK( recovered.recipe_escrow.empty() );
    CHECK_FALSE( recovered.recipe_recovery_required );
}

TEST_CASE( "lua_platform_recipe_work_tokens_reject_stale_actor_camp_and_task_context",
           "[lua][platform][camp][tasks][recipe_work][identity]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Stale Context Camp", tripoint_abs_omt{ 116, 116, 0 }, character_id( 99508 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    std::string error;

    const npc_ptr replacement = make_platform_test_npc(
                                    fixture.worker->getID(), fixture.owner,
                                    fixture.camp.camp_omt_pos() );
    cata::lua_platform::register_npc_handle_identity( *replacement );
    std::vector<basecamp_platform_recipe_escrow_item> refund;
    CHECK_FALSE( fixture.camp.platform_prepare_recipe_refund(
                     running.task_id, running.identity_generation, replacement, refund, error ) );
    CHECK( error.find( "exact live worker" ) != std::string::npos );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 98 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_runtime_owner, 98 );
    const cata::lua_platform::game_handle worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *fixture.worker,
            { "npc", fixture.worker->getID().get_value(), 0, 0, 0, {} }, runtime, 2 );
    std::optional<cata::lua_platform::game_handle_error> handle_error =
        worker_handle.validation_error( runtime, 3 );
    REQUIRE( handle_error );
    CHECK( handle_error->code == "stale_world" );
    handle_error = worker_handle.validation_error( other_runtime, 2 );
    REQUIRE( handle_error );
    CHECK( handle_error->code == "stale_runtime" );

    cata::lua_platform::register_camp_handle_identity( fixture.camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( fixture.camp, {}, runtime, 2 );
    cata::lua_platform::retire_camp_handle_identity( fixture.camp );
    handle_error = camp_handle.validation_error( runtime, 2 );
    REQUIRE( handle_error );
    CHECK( handle_error->code == "stale_camp" );

    REQUIRE( fixture.camp.platform_mark_recipe_refund_pending(
                 running.task_id, running.identity_generation, error ) );
    const basecamp_platform_task retired = fixture.camp.platform_task_snapshot().front();
    CHECK_FALSE( fixture.camp.platform_mark_recipe_refund_pending(
                     running.task_id, running.identity_generation, error ) );
    CHECK( retired.identity_generation == running.identity_generation + 1 );
    CHECK( retired.state == basecamp_platform_task_state::refund_pending );
}

TEST_CASE( "lua_platform_recipe_work_escrow_refuses_camp_removal_and_clear_until_claimed",
           "[lua][platform][camp][tasks][recipe_work][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt position{ 117, 117, 0 };
    const std::unique_ptr<overmap> local_overmap =
        std::make_unique<overmap>( project_to<coords::om>( position.xy() ) );
    basecamp seed( "Recipe Removal Camp", position );
    seed.set_owner( owner );
    local_overmap->add_camp( position.xy(), seed );
    const std::optional<basecamp *> found = local_overmap->find_camp( position.xy() );
    REQUIRE( found.has_value() );
    basecamp *camp = *found;
    REQUIRE( camp != nullptr );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 99509 ), owner, position );
    worker->set_skill_level( skill_id( "survival" ), 10 );
    const recipe &making = recipe_id( "tinder" ).obj();
    worker->learn_recipe( &making, true );
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
        worker->getID(), worker->platform_identity_generation() );
    const std::int64_t duration_turns = to_turns<std::int64_t>(
                                            making.batch_duration( *worker,
                                                    crafting_cost_context::for_recipe( *worker, making ), 1 ) );
    basecamp_platform_task task = make_platform_recipe_work_test_task(
                                      *camp, owner, get_avatar().getID(), *worker, "tinder",
                                      duration_turns );
    task.recipe_work->source_holders = { holder };
    task.recipe_work->destination_holder = holder;
    const std::vector<basecamp_platform_recipe_escrow_item> escrow = {
        make_platform_recipe_escrow_test_item(
            item( itype_id( "stick" ), calendar::turn_zero ), holder ),
        make_platform_recipe_escrow_test_item(
            item( itype_id( "knife_combat" ), calendar::turn_zero ), holder, true )
    };
    std::string error;
    REQUIRE( camp->platform_create_task( task, error ) );
    REQUIRE( camp->platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, time_duration::from_turns( duration_turns ), escrow,
                 error ) );

    CHECK_FALSE( camp->platform_retire_tasks_for_camp() );
    REQUIRE( local_overmap->find_camp( position.xy() ).has_value() );
    local_overmap->clear_camps();
    CHECK( local_overmap->find_camp( position.xy() ).has_value() );

    const basecamp_platform_task running = camp->platform_task_snapshot().front();
    REQUIRE( camp->platform_finish_task(
                 running.task_id, running.identity_generation, worker, calendar::turn_zero,
                 false, running.recipe_escrow, error ) );
    const basecamp_platform_task pending = camp->platform_task_snapshot().front();
    REQUIRE( camp->platform_claim_recipe_escrow(
                 pending.task_id, pending.identity_generation, calendar::turn_zero, false,
                 pending.recipe_escrow, error ) );
    local_overmap->clear_camps();
    CHECK_FALSE( local_overmap->find_camp( position.xy() ) );
}

TEST_CASE( "lua_platform_camp_expansion_accepts_authoritative_target_terrain",
           "[lua][platform][camp][expansion][terrain]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 160, 160, 0 };
    const tripoint_abs_omt target_position{ 161, 160, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( target_position, oter_id( "field" ) );

    basecamp camp( "Eligible Expansion Camp", camp_position );
    camp.set_owner( owner );
    std::string error;
    CHECK( camp.platform_validate_expansion_placement(
               "faction_base_canteen_0", target_position, error ) );

    basecamp_platform_expansion expansion;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "Canteen", target_position, expansion, error ) );
    CHECK( expansion.position == target_position );
    CHECK( expansion.identity_generation == 1 );
    CHECK( camp.platform_expansion_snapshot().size() == 1 );
}

TEST_CASE( "lua_platform_camp_expansion_rejects_ineligible_target_terrain_without_mutation",
           "[lua][platform][camp][expansion][terrain]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 162, 162, 0 };
    const tripoint_abs_omt target_position{ 163, 162, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( target_position, oter_id( "river_center" ) );

    basecamp camp( "Invalid Terrain Expansion Camp", camp_position );
    camp.set_owner( owner );
    const oter_id terrain_before = overmap_buffer.ter_existing( target_position );
    std::string error;
    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Invalid Terrain", target_position,
                     rejected, error ) );
    CHECK( error.find( "eligible" ) != std::string::npos );
    CHECK( camp.platform_expansion_snapshot().empty() );
    CHECK( overmap_buffer.ter_existing( target_position ) == terrain_before );
    CHECK( rejected.expansion_id == 0 );
}

TEST_CASE( "lua_platform_camp_expansion_rechecks_terrain_after_eligibility_plan",
           "[lua][platform][camp][expansion][terrain][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 164, 164, 0 };
    const tripoint_abs_omt target_position{ 165, 164, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( target_position, oter_id( "field" ) );

    basecamp camp( "Changed Terrain Expansion Camp", camp_position );
    camp.set_owner( owner );
    std::string error;
    REQUIRE( camp.platform_validate_expansion_placement(
                 "faction_base_canteen_0", target_position, error ) );

    overmap_buffer.ter_set( target_position, oter_id( "river_center" ) );
    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Changed Terrain", target_position,
                     rejected, error ) );
    CHECK( error.find( "eligible" ) != std::string::npos );
    CHECK( camp.platform_expansion_snapshot().empty() );
    CHECK( overmap_buffer.ter_existing( target_position ) == oter_id( "river_center" ) );
}

TEST_CASE( "lua_platform_camp_expansion_rejection_leaves_no_id_gap_or_tombstone",
           "[lua][platform][camp][expansion][terrain][rollback]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 166, 166, 0 };
    const tripoint_abs_omt first_position{ 167, 166, 0 };
    const tripoint_abs_omt second_position{ 166, 167, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( first_position, oter_id( "field" ) );
    overmap_buffer.ter_set( second_position, oter_id( "river_center" ) );

    basecamp camp( "Expansion Rollback Camp", camp_position );
    camp.set_owner( owner );
    std::string error;
    basecamp_platform_expansion first;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "First", first_position, first, error ) );

    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Rejected", second_position, rejected, error ) );
    CHECK( camp.platform_expansion_snapshot().size() == 1 );
    CHECK( rejected.expansion_id == 0 );
    CHECK( overmap_buffer.ter_existing( second_position ) == oter_id( "river_center" ) );

    overmap_buffer.ter_set( second_position, oter_id( "field" ) );
    basecamp_platform_expansion second;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "Second", second_position, second, error ) );
    CHECK( second.expansion_id == first.expansion_id + 1 );
    CHECK( camp.platform_expansion_snapshot().size() == 2 );
}

TEST_CASE( "lua_platform_camp_expansion_create_rejects_conflict_domain_and_type",
           "[lua][platform][camp][expansion]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Expansion Create Camp", tripoint_abs_omt{ 130, 130, 0 } );
    camp.set_owner( owner );
    overmap_buffer.ter_set( tripoint_abs_omt{ 131, 130, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion first;
    std::string error;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "North Store", tripoint_abs_omt{ 131, 130, 0 },
                 first, error ) );
    CHECK( first.expansion_id != 0 );
    CHECK( first.identity_generation == 1 );
    CHECK( first.camp_id == camp.platform_id() );

    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Duplicate", tripoint_abs_omt{ 131, 130, 0 },
                     rejected, error ) );
    CHECK( error.find( "already" ) != std::string::npos );
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Far Away", tripoint_abs_omt{ 133, 130, 0 },
                     rejected, error ) );
    CHECK( error.find( "outside" ) != std::string::npos );
    CHECK_FALSE( camp.platform_create_expansion(
                     "not_a_platform_expansion", "Invalid Type",
                     tripoint_abs_omt{ 130, 131, 0 }, rejected, error ) );
    CHECK( camp.platform_expansion_snapshot().size() == 1 );
}

TEST_CASE( "lua_platform_camp_create_preflight_conflict_and_failed_publish_leave_no_partial_camp",
           "[lua][platform][camp][lifecycle]" )
{
    const faction_id owner = get_avatar().get_faction()->id;
    const tripoint_abs_omt occupied_position{ 125, 125, 0 };
    basecamp existing( "Existing Explicit Camp", occupied_position );
    existing.set_owner( owner );
    overmap_buffer.add_camp( existing );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 124 );
    const cata::lua_platform::game_handle manager =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", get_avatar().getID().get_value(), 0, 0, 0, {} },
            runtime, 34 );
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 34 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 34 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    sol::table options = lua.create_table();
    options["type"] = "faction_base_bare_bones_basecamp_0";
    const cata::lua_platform::script_game_id owner_value(
        "faction", owner.str() );
    const cata::lua_platform::script_tripoint_coord occupied =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::overmap_terrain,
            occupied_position.raw() );
    const sol::protected_function create = camps["create"];
    const sol::protected_function_result conflict = create(
            owner_value, manager, occupied, "Conflicting Camp", options );
    REQUIRE( conflict.valid() );
    const sol::table conflict_result = conflict.get<sol::table>();
    CHECK_FALSE( conflict_result["ok"].get<bool>() );
    CHECK( conflict_result["error"].get<sol::table>()["code"].get<std::string>() ==
           "camp_conflict" );

    const tripoint_abs_omt failed_position{ 126, 126, 0 };
    const cata::lua_platform::script_tripoint_coord failed =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::overmap_terrain,
            failed_position.raw() );
    sol::table invalid_options = lua.create_table();
    invalid_options["type"] = "not_a_camp_type";
    const sol::protected_function_result failed_create = create(
            owner_value, manager, failed, "Failed Camp", invalid_options );
    CHECK_FALSE( failed_create.valid() );
    const overmap_with_local_coords loaded =
        overmap_buffer.get_existing_om_global( failed_position );
    CHECK( ( !loaded.om || !loaded.om->find_camp( failed_position.xy() ) ) );
    overmap_buffer.remove_camp( occupied_position.xy() );
}

TEST_CASE( "lua_platform_camp_expansion_tokens_retire_on_remove_and_owner_change",
           "[lua][platform][camp][expansion][identity]" )
{
    const faction_id owner( "your_followers" );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 120 );
    basecamp camp( "Expansion Token Camp", tripoint_abs_omt{ 135, 135, 0 } );
    camp.set_owner( owner );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 30 );
    overmap_buffer.ter_set( tripoint_abs_omt{ 136, 135, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion expansion;
    std::string error;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "East Store", tripoint_abs_omt{ 136, 135, 0 },
                 expansion, error ) );
    const cata::lua_platform::camp_expansion_token token(
        expansion.expansion_id, expansion.identity_generation, camp_handle,
        owner.str(), runtime, 30 );
    basecamp_platform_expansion resolved;
    REQUIRE( camp.platform_get_expansion(
                 token.expansion_id(), token.identity_generation(), resolved, error ) );
    CHECK( resolved.position == expansion.position );
    REQUIRE( camp.platform_remove_expansion(
                 token.expansion_id(), token.identity_generation(), error ) );
    CHECK_FALSE( camp.platform_get_expansion(
                     token.expansion_id(), token.identity_generation(), resolved, error ) );
    CHECK( error.find( "retired" ) != std::string::npos );

    basecamp owner_change( "Expansion Owner Boundary", tripoint_abs_omt{ 137, 137, 0 } );
    owner_change.set_owner( owner );
    overmap_buffer.ter_set( tripoint_abs_omt{ 136, 137, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion owner_expansion;
    REQUIRE( owner_change.platform_create_expansion(
                 "faction_base_canteen_0", "West Store", tripoint_abs_omt{ 136, 137, 0 },
                 owner_expansion, error ) );
    const std::uint64_t old_generation = owner_expansion.identity_generation;
    owner_change.set_owner( faction_id( "replacement_camp_owner" ) );
    CHECK( owner_change.platform_expansion_snapshot().front().identity_generation ==
           old_generation + 1 );
    CHECK_FALSE( owner_change.platform_get_expansion(
                     owner_expansion.expansion_id, old_generation, resolved, error ) );
}

TEST_CASE( "lua_platform_camp_expansion_save_load_reissues_identity_from_stable_record",
           "[lua][platform][camp][expansion][serialization]" )
{
    const faction_id owner( "your_followers" );
    basecamp original( "Expansion Save Camp", tripoint_abs_omt{ 140, 140, 0 } );
    original.set_owner( owner );
    overmap_buffer.ter_set( tripoint_abs_omt{ 140, 141, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion expansion;
    std::string error;
    REQUIRE( original.platform_create_expansion(
                 "faction_base_canteen_0", "South Store", tripoint_abs_omt{ 140, 141, 0 },
                 expansion, error ) );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 121 );
    cata::lua_platform::register_camp_handle_identity( original );
    const cata::lua_platform::game_handle old_camp_handle =
        cata::lua_platform::game_handle::from_camp( original, {}, runtime, 31 );

    std::ostringstream saved;
    JsonOut json( saved );
    original.serialize( json );
    basecamp restored;
    const JsonValue parsed = json_loader::from_string( saved.str() );
    restored.deserialize( parsed.get_object() );
    const std::vector<basecamp_platform_expansion> loaded =
        restored.platform_expansion_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().expansion_id == expansion.expansion_id );
    CHECK( loaded.front().identity_generation == expansion.identity_generation );
    CHECK( loaded.front().position == expansion.position );

    const cata::lua_platform::game_handle new_camp_handle =
        cata::lua_platform::game_handle::from_camp( restored, {}, runtime, 31 );
    CHECK( old_camp_handle.validation_error( runtime, 31 ) );
    CHECK_FALSE( new_camp_handle.validation_error( runtime, 31 ) );
}

TEST_CASE( "lua_platform_camp_remove_preflight_refuses_tasks_workers_escrow_and_expansion_work",
           "[lua][platform][camp][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    std::string error;

    basecamp assigned( "Assigned Worker Removal", tripoint_abs_omt{ 145, 145, 0 } );
    assigned.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 99601 ), owner, assigned.camp_omt_pos() );
    REQUIRE( assigned.assign_exact_worker( worker ) );
    CHECK_FALSE( assigned.platform_can_remove( error ) );
    CHECK( error.find( "assigned workers" ) != std::string::npos );

    basecamp pending( "Pending Task Removal", tripoint_abs_omt{ 146, 146, 0 } );
    pending.set_owner( owner );
    basecamp_platform_task pending_task = make_platform_test_task(
                                               pending, owner, character_id( 99602 ),
                                               *worker );
    REQUIRE( pending.platform_create_task( pending_task, error ) );
    CHECK_FALSE( pending.platform_can_remove( error ) );
    CHECK( error.find( "task" ) != std::string::npos );

    basecamp expansion_work( "Expansion Work Removal", tripoint_abs_omt{ 147, 147, 0 } );
    expansion_work.set_owner( owner );
    expansion_work.define_camp(
        expansion_work.camp_omt_pos(), "faction_base_bare_bones_basecamp_0", false );
    expansion_work.update_in_progress(
        "faction_base_bare_bones_basecamp_0", base_camps::base_dir );
    CHECK_FALSE( expansion_work.platform_can_remove( error ) );
    CHECK( error.find( "expansion work" ) != std::string::npos );

    platform_recipe_task_fixture escrow_fixture(
        "Escrow Removal", tripoint_abs_omt{ 148, 148, 0 }, character_id( 99603 ) );
    REQUIRE( escrow_fixture.start() );
    const basecamp_platform_task running =
        escrow_fixture.camp.platform_task_snapshot().front();
    REQUIRE( escrow_fixture.camp.platform_finish_task(
                 running.task_id, running.identity_generation, escrow_fixture.worker,
                 calendar::turn_zero, false, running.recipe_escrow, error ) );
    CHECK_FALSE( escrow_fixture.worker->assigned_camp );
    CHECK_FALSE( escrow_fixture.camp.platform_can_remove( error ) );
    CHECK( error.find( "task" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_remove_retires_exact_camp_identity_after_preflight",
           "[lua][platform][camp][identity]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt position{ 150, 150, 0 };
    const std::unique_ptr<overmap> local_overmap =
        std::make_unique<overmap>( project_to<coords::om>( position.xy() ) );
    basecamp seed( "Removable Platform Camp", position );
    seed.set_owner( owner );
    local_overmap->add_camp( position.xy(), seed );
    const std::optional<basecamp *> found = local_overmap->find_camp( position.xy() );
    REQUIRE( found.has_value() );
    basecamp *camp = *found;
    REQUIRE( camp != nullptr );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 122 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_camp( *camp, {}, runtime, 32 );
    const std::uint64_t stable_id = camp->platform_id();

    std::string error;
    REQUIRE( camp->platform_can_remove( error ) );
    local_overmap->remove_camp( position.xy() );
    CHECK_FALSE( local_overmap->find_camp( position.xy() ) );
    CHECK( handle.validation_error( runtime, 32 ) );
    CHECK( handle.locator().stable_id == static_cast<std::int64_t>( stable_id ) );
}

TEST_CASE( "lua_platform_camp_api_exposes_only_explicit_create_remove_and_expansion_routes",
           "[lua][platform][camp][api]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 123 );
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 33 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 33 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    CHECK( camps["create"].valid() );
    CHECK( camps["remove"].valid() );
    const sol::table expansions = camps["expansions"];
    CHECK( expansions["create"].valid() );
    CHECK( expansions["list"].valid() );
    CHECK( expansions["get"].valid() );
    CHECK( expansions["remove"].valid() );
    CHECK_FALSE( camps["near"].valid() );
    CHECK_FALSE( camps["current"].valid() );
    CHECK_FALSE( expansions["nearest"].valid() );
}

TEST_CASE( "lua_platform_upgrade_commit_state_unknown_for_partial_or_unloaded_target",
           "[lua][platform][camp][upgrade][recovery]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt position{ 170, 170, 0 };
    overmap_buffer.ter_set( position, oter_id( "field" ) );

    basecamp camp( "Upgrade Commit State Camp", position );
    camp.set_owner( owner );
    camp.define_camp( position, "faction_base_bare_bones_basecamp_0", false );

    const recipe &upgrade = recipe_id( "faction_base_shelter_1_0" ).obj();
    REQUIRE( upgrade.is_blueprint() );
    REQUIRE( !upgrade.blueprint_build_reqs().reqs_by_parameters.empty() );
    const auto requirement = upgrade.blueprint_build_reqs().reqs_by_parameters.begin();
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                get_avatar().getID(), 1 );

    basecamp_platform_upgrade_work work;
    work.upgrade_id = upgrade.result().str();
    work.blueprint_id = upgrade.get_blueprint().str();
    work.target_kind = basecamp_platform_upgrade_target_kind::camp_core;
    work.target_core_generation = camp.platform_core_upgrade_generation();
    work.target_position = position;
    work.target_terrain = "field";
    work.mapgen_args = requirement->first;
    work.duration_turns = to_turns<std::int64_t>(
                              time_duration::from_moves( requirement->second.time ) );
    work.source_holders = { holder };
    work.destination_holder = holder;

    // A changed terrain without the complete metadata/generation publication
    // is neither a safe retry nor proof of a committed upgrade.
    overmap_buffer.ter_set( position, oter_id( "forest" ) );
    std::string error;
    CHECK( camp.platform_upgrade_commit_state(
               work, 1, 1, 0, error ) == basecamp_platform_upgrade_commit_state::unknown );
    CHECK_FALSE( error.empty() );

    // A target that is no longer attached to the camp has no authoritative
    // loaded target for recovery; it must not be replayed as a retry.
    basecamp_platform_upgrade_work unloaded = work;
    unloaded.target_position = tripoint_abs_omt{ 100000, 100000, 0 };
    error.clear();
    CHECK( camp.platform_upgrade_commit_state(
               unloaded, 1, 1, 0, error ) == basecamp_platform_upgrade_commit_state::unknown );
    CHECK_FALSE( error.empty() );
}

TEST_CASE( "lua_platform_upgrade_legacy_record_is_quarantined_with_escrow",
           "[lua][platform][camp][upgrade][serialization]" )
{
    const faction_id owner( "your_followers" );
    const std::uint64_t camp_id = 99801;
    const std::uint64_t task_id = 99802;
    const character_id manager_id( 99803 );
    const character_id worker_id( 99804 );
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                worker_id, 1 );
    const item escrow_value( itype_id( "stick" ), calendar::turn_zero );
    const std::string serialized_item = serialize_platform_recipe_test_item( escrow_value );

    std::ostringstream saved;
    JsonOut json( saved );
    json.start_object();
    json.member( "owner", owner );
    json.member( "name", "Legacy Upgrade Recovery Camp" );
    json.member( "pos", tripoint_abs_omt{ 171, 171, 0 } );
    json.member( "platform_id", camp_id );
    // v2 predates a safe typed upgrade descriptor.  The upgrade-shaped record
    // therefore has to enter the explicit refund-only quarantine path.
    json.member( "platform_tasks_version", basecamp_platform_task_schema_version_legacy );
    json.member( "platform_tasks" );
    json.start_array();
    json.start_object();
    json.member( "task_id", task_id );
    json.member( "generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "camp_id", camp_id );
    json.member( "owner_faction", owner );
    json.member( "manager_id", manager_id );
    json.member( "worker_id", worker_id );
    json.member( "kind", std::string( basecamp_platform_upgrade_work_kind ) );
    json.member( "state", "running" );
    json.member( "started_at", calendar::turn_zero );
    json.member( "due_at", calendar::turn_zero + 1_turns );
    json.member( "recipe_escrow" );
    json.start_array();
    json.start_object();
    json.member( "stable_uid", escrow_value.uid().get_value() );
    json.member( "identity_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "charges", static_cast<std::int64_t>( 1 ) );
    json.member( "tool", false );
    json.member( "serialized_item", serialized_item );
    json.member( "source_holder" );
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_object();
    json.end_array();
    json.end_object();
    json.end_array();
    json.member( "bb_pos", tripoint_abs_ms::zero );
    json.member( "dumping_spot", tripoint_abs_ms::zero );
    json.member( "liquid_dumping_spots" );
    json.start_array();
    json.end_array();
    json.member( "hidden_missions" );
    json.start_array();
    json.end_array();
    json.member( "expansions" );
    json.start_array();
    json.end_array();
    json.member( "fortifications" );
    json.start_array();
    json.end_array();
    json.member( "salt_water_pipes" );
    json.start_array();
    json.end_array();
    json.end_object();

    basecamp restored;
    const JsonValue parsed = json_loader::from_string( saved.str() );
    restored.deserialize( parsed.get_object() );
    const std::vector<basecamp_platform_task> quarantined_tasks =
        restored.platform_task_snapshot();
    REQUIRE( quarantined_tasks.size() == 1 );
    const basecamp_platform_task &quarantined = quarantined_tasks.front();
    CHECK( quarantined.state == basecamp_platform_task_state::refund_pending );
    CHECK( quarantined.recipe_recovery_required );
    CHECK_FALSE( quarantined.upgrade_work );
    REQUIRE( quarantined.recipe_escrow.size() == 1 );
    CHECK( quarantined.recipe_escrow.front().serialized_item == serialized_item );

    std::string error;
    std::vector<basecamp_platform_recipe_escrow_item> recovery_escrow;
    REQUIRE( restored.platform_prepare_recipe_refund(
                 quarantined.task_id, quarantined.identity_generation, nullptr,
                 recovery_escrow, error ) );
    REQUIRE( restored.platform_claim_recipe_escrow(
                 quarantined.task_id, quarantined.identity_generation,
                 calendar::turn_zero, false, recovery_escrow, error ) );
    const basecamp_platform_task recovered = restored.platform_task_snapshot().front();
    CHECK( recovered.state == basecamp_platform_task_state::cancelled );
    CHECK( recovered.identity_generation == quarantined.identity_generation + 1 );
    CHECK( recovered.recipe_escrow.empty() );
    CHECK_FALSE( recovered.recipe_recovery_required );
}

TEST_CASE( "lua_platform_upgrade_owner_transition_is_idempotent",
           "[lua][platform][camp][upgrade][lifecycle]" )
{
    const faction_id old_owner( "your_followers" );
    const faction_id new_owner( "upgrade_owner_replacement" );
    const tripoint_abs_omt camp_position{ 172, 172, 0 };
    const tripoint_abs_omt expansion_position{ 173, 172, 0 };
    overmap_buffer.ter_set( expansion_position, oter_id( "field" ) );

    basecamp camp( "Idempotent Upgrade Owner Camp", camp_position );
    camp.set_owner( old_owner );
    std::string error;
    basecamp_platform_expansion expansion;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "Canteen", expansion_position,
                 expansion, error ) );

    const npc_ptr worker = make_platform_test_npc(
                               character_id( 99811 ), old_owner, camp_position );
    basecamp_platform_task task = make_platform_test_task(
                                      camp, old_owner, character_id( 99812 ), *worker );
    REQUIRE( camp.platform_create_task( task, error ) );

    camp.set_owner( new_owner );
    const basecamp_platform_task after_first_transition =
        camp.platform_task_snapshot().front();
    const basecamp_platform_expansion after_first_expansion =
        camp.platform_expansion_snapshot().front();
    CHECK( after_first_transition.state == basecamp_platform_task_state::cancelled );
    CHECK( after_first_transition.identity_generation == task.identity_generation + 1 );
    CHECK( after_first_transition.owner_faction == new_owner );
    CHECK( after_first_expansion.identity_generation == expansion.identity_generation + 1 );

    // Both public owner paths must treat an already-published owner as a
    // no-op, with no second task or expansion generation retirement.
    camp.set_owner( new_owner );
    camp.handle_takeover_by( new_owner, false );
    const basecamp_platform_task after_repeat = camp.platform_task_snapshot().front();
    const basecamp_platform_expansion after_repeat_expansion =
        camp.platform_expansion_snapshot().front();
    CHECK( after_repeat.identity_generation == after_first_transition.identity_generation );
    CHECK( after_repeat.state == after_first_transition.state );
    CHECK( after_repeat_expansion.identity_generation ==
           after_first_expansion.identity_generation );
}

TEST_CASE( "lua_platform_upgrade_rejects_unsafe_mapgen_operator",
           "[lua][platform][camp][upgrade][mapgen]" )
{
    const update_mapgen_id unsafe_operator( "fbbb" );
    const tripoint_abs_omt position{ 174, 174, 0 };
    platform_mapgen_transaction_footprint footprint;
    std::string error;

    REQUIRE_FALSE( platform_transaction_safe( unsafe_operator, position, footprint, error ) );
    CHECK( error.find( "unsafe" ) != std::string::npos );
    CHECK( footprint.max_submap_x < footprint.min_submap_x );

    platform_mapgen_transaction_report report;
    const ret_val<void> result = run_mapgen_update_func_transactional(
                                     unsafe_operator, position, {}, nullptr, true,
                                     false, false, 0, std::nullopt, std::nullopt,
                                     &report );
    CHECK_FALSE( result.success() );
    CHECK( result.str().find( "unsafe" ) != std::string::npos );
    CHECK( report.state == platform_mapgen_transaction_state::rejected );
    CHECK( report.code == "unsafe_operator" );

    const update_mapgen_id safe_operator( "fbmc_shelter_1_0" );
    const auto check_rejection = [&]( const bool cancel_on_collision,
                                      const bool mirror_horizontal,
                                      const int rotation,
                                      const char *expected_code ) {
        platform_mapgen_transaction_report rejection_report;
        const ret_val<void> rejection = run_mapgen_update_func_transactional(
                                             safe_operator, position, {}, nullptr,
                                             cancel_on_collision, mirror_horizontal,
                                             false, rotation, std::nullopt,
                                             std::nullopt, &rejection_report );
        CHECK_FALSE( rejection.success() );
        CHECK( rejection_report.state == platform_mapgen_transaction_state::rejected );
        CHECK( rejection_report.code == expected_code );
    };
    check_rejection( true, true, 0, "unsupported_transform" );
    check_rejection( true, false, 1, "unsupported_transform" );
    check_rejection( false, false, 0, "invalid_context" );
}

TEST_CASE( "lua_platform_upgrade_rolls_back_complete_multi_submap_footprint",
           "[lua][platform][camp][upgrade][mapgen][rollback]" )
{
    const update_mapgen_id safe_operator( "fbmc_shelter_1_0" );
    const tripoint_abs_omt position = get_avatar().pos_abs_omt();
    const oter_id original_terrain = overmap_buffer.ter_existing( position );
    const on_out_of_scope restore_terrain( [position, original_terrain]() {
        overmap_buffer.ter_set( position, original_terrain );
    } );
    overmap_buffer.ter_set( position, oter_id( "field" ) );
    const oter_id terrain_before = overmap_buffer.ter_existing( position );

    platform_mapgen_transaction_footprint footprint;
    std::string error;
    REQUIRE( platform_transaction_safe( safe_operator, position, footprint, error ) );
    REQUIRE( footprint.complete_omt_z_stack );

    struct saved_submap {
        tripoint_abs_sm position;
        submap snapshot;
    };
    std::vector<saved_submap> saved_submaps;
    const tripoint_abs_sm base = project_to<coords::sm>( position );
    for( int z = footprint.min_z; z <= footprint.max_z; ++z ) {
        for( int x = footprint.min_submap_x; x <= footprint.max_submap_x; ++x ) {
            for( int y = footprint.min_submap_y; y <= footprint.max_submap_y; ++y ) {
                const tripoint_abs_sm submap_position{ base.x() + x, base.y() + y, z };
                submap *source = MAPBUFFER.lookup_submap( submap_position );
                REQUIRE( source != nullptr );
                saved_submaps.push_back( saved_submap{
                    submap_position, source->get_revert_submap() } );
            }
        }
    }

    // Invalidate the exact expected terrain after the transaction plan was
    // made.  The failure leg must preserve every planned submap and the
    // overmap terrain, rather than applying a partial mapgen publication.
    overmap_buffer.ter_set( position, oter_id( "river_center" ) );
    platform_mapgen_transaction_report report;
    const ret_val<void> result = run_mapgen_update_func_transactional(
                                     safe_operator, position, {}, nullptr, true,
                                     false, false, 0, terrain_before,
                                     oter_id( "faction_base_camp_0" ), &report );
    CHECK_FALSE( result.success() );
    CHECK( report.state == platform_mapgen_transaction_state::rejected );
    CHECK( report.code == "terrain_mismatch" );
    CHECK( report.footprint.min_submap_x == footprint.min_submap_x );
    CHECK( report.footprint.max_submap_x == footprint.max_submap_x );
    CHECK( report.footprint.min_submap_y == footprint.min_submap_y );
    CHECK( report.footprint.max_submap_y == footprint.max_submap_y );
    CHECK( report.footprint.min_z == footprint.min_z );
    CHECK( report.footprint.max_z == footprint.max_z );
    CHECK( report.footprint.complete_omt_z_stack );
    CHECK( overmap_buffer.ter_existing( position ) == oter_id( "river_center" ) );

    for( const saved_submap &saved : saved_submaps ) {
        submap *current = MAPBUFFER.lookup_submap( saved.position );
        REQUIRE( current != nullptr );
        for( int x = 0; x < SEEX; ++x ) {
            for( int y = 0; y < SEEY; ++y ) {
                const point_sm_ms local( x, y );
                CHECK( current->get_ter( local ) == saved.snapshot.get_ter( local ) );
                CHECK( current->get_furn( local ) == saved.snapshot.get_furn( local ) );
            }
        }
    }
}

TEST_CASE( "lua_platform_upgrade_post_commit_is_not_replayed",
           "[lua][platform][camp][upgrade][recovery]" )
{
    const faction_id owner( "your_followers" );
    const std::uint64_t camp_id = 99821;
    const std::uint64_t task_id = 99822;
    const character_id manager_id( 99823 );
    const character_id worker_id( 99824 );
    const tripoint_abs_omt position{ 176, 176, 0 };
    const recipe &upgrade = recipe_id( "faction_base_shelter_1_0" ).obj();
    REQUIRE( upgrade.is_blueprint() );
    REQUIRE( !upgrade.blueprint_build_reqs().reqs_by_parameters.empty() );
    const auto requirement = upgrade.blueprint_build_reqs().reqs_by_parameters.begin();
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                worker_id, 1 );
    basecamp_platform_upgrade_work work;
    work.upgrade_id = upgrade.result().str();
    work.blueprint_id = upgrade.get_blueprint().str();
    work.target_kind = basecamp_platform_upgrade_target_kind::camp_core;
    work.target_core_generation = 1;
    work.target_position = position;
    work.target_terrain = "field";
    work.mapgen_args = requirement->first;
    work.duration_turns = to_turns<std::int64_t>(
                              time_duration::from_moves( requirement->second.time ) );
    work.source_holders = { holder };
    work.destination_holder = holder;
    const item escrow_value( itype_id( "stick" ), calendar::turn_zero );
    const basecamp_platform_recipe_escrow_item escrow_entry =
        make_platform_recipe_escrow_test_item( escrow_value, holder );

    std::ostringstream saved;
    JsonOut json( saved );
    json.start_object();
    json.member( "owner", owner );
    json.member( "name", "Committed Upgrade Recovery Camp" );
    json.member( "pos", position );
    json.member( "platform_id", camp_id );
    json.member( "platform_core_upgrade_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "platform_tasks_version", basecamp_platform_task_schema_version );
    json.member( "platform_tasks" );
    json.start_array();
    json.start_object();
    json.member( "task_id", task_id );
    json.member( "generation", static_cast<std::uint64_t>( 2 ) );
    json.member( "camp_id", camp_id );
    json.member( "owner_faction", owner );
    json.member( "manager_id", manager_id );
    json.member( "worker_id", worker_id );
    json.member( "manager_identity_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "worker_identity_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "kind", std::string( basecamp_platform_upgrade_work_kind ) );
    json.member( "parameters", std::string( basecamp_platform_upgrade_work_parameter_schema ) );
    json.member( "state", "completed_unclaimed" );
    json.member( "started_at", calendar::turn_zero );
    json.member( "due_at", calendar::turn_zero + 1_turns );
    json.member( "finished_at", calendar::turn_zero + 1_turns );
    json.member( "upgrade_work" );
    json.start_object();
    json.member( "upgrade_id", work.upgrade_id );
    json.member( "blueprint_id", work.blueprint_id );
    json.member( "target_kind", "camp_core" );
    json.member( "target_core_generation", work.target_core_generation );
    json.member( "target_expansion_id", static_cast<std::uint64_t>( 0 ) );
    json.member( "target_expansion_generation", static_cast<std::uint64_t>( 0 ) );
    json.member( "target_position", work.target_position );
    json.member( "target_terrain", work.target_terrain );
    json.member( "mapgen_args" );
    work.mapgen_args.serialize( json );
    json.member( "duration_turns", work.duration_turns );
    json.member( "source_holders" );
    json.start_array();
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_array();
    json.member( "destination_holder" );
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_object();
    json.member( "recipe_escrow" );
    json.start_array();
    json.start_object();
    json.member( "stable_uid", escrow_entry.stable_uid );
    json.member( "identity_generation", escrow_entry.identity_generation );
    json.member( "charges", escrow_entry.charges );
    json.member( "tool", escrow_entry.tool );
    json.member( "serialized_item", escrow_entry.serialized_item );
    json.member( "source_holder" );
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_object();
    json.end_array();
    json.member( "upgrade_commit_marker", static_cast<std::uint64_t>( 1 ) );
    json.member( "upgrade_applying_marker", static_cast<std::uint64_t>( 0 ) );
    json.member( "recipe_recovery_required", false );
    json.end_object();
    json.end_array();
    json.member( "bb_pos", tripoint_abs_ms::zero );
    json.member( "dumping_spot", tripoint_abs_ms::zero );
    json.member( "liquid_dumping_spots" );
    json.start_array();
    json.end_array();
    json.member( "hidden_missions" );
    json.start_array();
    json.end_array();
    json.member( "expansions" );
    json.start_array();
    json.end_array();
    json.member( "fortifications" );
    json.start_array();
    json.end_array();
    json.member( "salt_water_pipes" );
    json.start_array();
    json.end_array();
    json.end_object();

    basecamp restored;
    const JsonValue parsed = json_loader::from_string( saved.str() );
    restored.deserialize( parsed.get_object() );
    const basecamp_platform_task before = restored.platform_task_snapshot().front();
    REQUIRE( before.state == basecamp_platform_task_state::completed_unclaimed );
    REQUIRE( before.upgrade_commit_marker != 0 );

    std::string error;
    CHECK_FALSE( restored.platform_finish_task(
                     before.task_id, before.identity_generation, nullptr,
                     calendar::turn_zero + 2_turns, true, before.recipe_escrow, error ) );
    const basecamp_platform_task after = restored.platform_task_snapshot().front();
    CHECK( after.state == before.state );
    CHECK( after.identity_generation == before.identity_generation );
    CHECK( after.upgrade_commit_marker == before.upgrade_commit_marker );
    CHECK( after.recipe_escrow.size() == before.recipe_escrow.size() );
}

TEST_CASE( "lua_platform_trade_quote_requires_exact_participants_and_holders",
           "[lua][platform][trade][quote]" )
{
    platform_trade_quote_fixture fixture( 140, 401, 120001, 120002 );
    REQUIRE( fixture.ready() );

    sol::table wrong_holders = fixture.lua.create_table();
    wrong_holders[1] = fixture.line(
                           "seller_to_buyer", 3, fixture.item_handle,
                           fixture.buyer_handle, fixture.seller_handle );
    const sol::protected_function_result wrong_holder_result =
        fixture.quote_participants( fixture.seller_handle, fixture.buyer_handle,
                                    wrong_holders, fixture.options() );
    REQUIRE( wrong_holder_result.valid() );
    const sol::table wrong_holder_envelope = wrong_holder_result.get<sol::table>();
    REQUIRE_FALSE( wrong_holder_envelope["ok"].get<bool>() );
    CHECK( wrong_holder_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_holder" );

    const sol::protected_function_result same_participant_result =
        fixture.quote_participants( fixture.seller_handle, fixture.seller_handle,
                                    fixture.lines( 3 ), fixture.options() );
    REQUIRE( same_participant_result.valid() );
    const sol::table same_participant_envelope =
        same_participant_result.get<sol::table>();
    REQUIRE_FALSE( same_participant_envelope["ok"].get<bool>() );
    CHECK( same_participant_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "same_participant" );

    const int charges_before = fixture.live_item->charges;
    const sol::protected_function_result result = fixture.quote( 3 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table snapshot = envelope["value"];
    CHECK( snapshot["seller"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.seller_handle.locator().stable_id );
    CHECK( snapshot["buyer"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.buyer_handle.locator().stable_id );

    sol::table quoted_lines = snapshot["lines"];
    const sol::table quoted_line = quoted_lines[1];
    CHECK( quoted_line["direction"].get<std::string>() == "seller_to_buyer" );
    CHECK( quoted_line["quantity"].get<lua_Integer>() == 3 );
    const sol::table source_holder = quoted_line["source_holder"];
    const sol::table destination_holder = quoted_line["destination_holder"];
    CHECK( source_holder["character"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.seller_handle.locator().stable_id );
    CHECK( destination_holder["character"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.buyer_handle.locator().stable_id );
    CHECK( source_holder["locator"].get<sol::table>()
           ["stable_id"].get<lua_Integer>() == fixture.seller_handle.locator().stable_id );
    CHECK( destination_holder["locator"].get<sol::table>()
           ["stable_id"].get<lua_Integer>() == fixture.buyer_handle.locator().stable_id );
    CHECK( fixture.live_item->charges == charges_before );
}

TEST_CASE( "lua_platform_trade_quote_uses_authoritative_price_and_settlement_rules",
           "[lua][platform][trade][quote]" )
{
    platform_trade_quote_fixture fixture( 141, 402, 120011, 120012 );
    REQUIRE( fixture.ready() );
    const int buyer_cash_before = fixture.buyer->cash;
    const int buyer_debt_before = fixture.buyer->op_of_u.owed;
    const int buyer_sold_before = fixture.buyer->op_of_u.sold;
    const int seller_cash_before = fixture.seller.cash;

    const sol::protected_function_result result = fixture.quote( 3 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table snapshot = envelope["value"];
    const sol::table quoted_line = snapshot["lines"].get<sol::table>()[1];
    const int expected_total = npc_trading::trading_price_for_order(
                                   *fixture.buyer, fixture.seller, *fixture.live_item, 3 );

    CHECK( quoted_line["unit_price"].is<lua_Integer>() );
    CHECK( quoted_line["total"].is<lua_Integer>() );
    CHECK( quoted_line["total"].get<lua_Integer>() == expected_total );
    CHECK( snapshot["seller_to_buyer_total"].get<lua_Integer>() == expected_total );
    CHECK( snapshot["buyer_to_seller_total"].get<lua_Integer>() == 0 );
    CHECK( snapshot["net"].get<lua_Integer>() == expected_total );
    CHECK( snapshot["settlement_strategy"].get<std::string>() == "cash" );
    CHECK( snapshot["currency"].get<std::string>() == "cash" );
    CHECK( snapshot["available_settlement_modes"].get<sol::table>()[1]
           .get<std::string>() == "cash" );
    const std::int64_t expected_settlement =
        fixture.buyer->will_exchange_items_freely() ? 0 : expected_total;
    CHECK( snapshot["settlement_amount"].get<lua_Integer>() == expected_settlement );
    CHECK( snapshot["buyer_cash_before"].get<lua_Integer>() == buyer_cash_before );
    CHECK( snapshot["seller_cash_before"].get<lua_Integer>() == seller_cash_before );
    CHECK( snapshot["debt_before"].get<lua_Integer>() == buyer_debt_before );
    CHECK( snapshot["sold_before"].get<lua_Integer>() == buyer_sold_before );
    CHECK( fixture.buyer->cash == buyer_cash_before );
    CHECK( fixture.buyer->op_of_u.owed == buyer_debt_before );
    CHECK( fixture.buyer->op_of_u.sold == buyer_sold_before );
    CHECK( fixture.seller.cash == seller_cash_before );
}

TEST_CASE( "lua_platform_trade_quote_rejects_duplicate_uid_and_partial_charge_mismatch",
           "[lua][platform][trade][quote]" )
{
    platform_trade_quote_fixture fixture( 142, 403, 120021, 120022 );
    REQUIRE( fixture.ready() );
    REQUIRE( fixture.live_item->count_by_charges() );

    sol::table duplicate_lines = fixture.lua.create_table();
    duplicate_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    duplicate_lines[2] = fixture.line(
                             "seller_to_buyer", 2, fixture.item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result duplicate_result =
        fixture.quote( duplicate_lines, fixture.options() );
    REQUIRE( duplicate_result.valid() );
    const sol::table duplicate_envelope = duplicate_result.get<sol::table>();
    REQUIRE_FALSE( duplicate_envelope["ok"].get<bool>() );
    CHECK( duplicate_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "duplicate_item" );

    const sol::protected_function_result partial_mismatch_result = fixture.quote(
            fixture.live_item->charges + 1 );
    REQUIRE( partial_mismatch_result.valid() );
    const sol::table partial_mismatch_envelope =
        partial_mismatch_result.get<sol::table>();
    REQUIRE_FALSE( partial_mismatch_envelope["ok"].get<bool>() );
    CHECK( partial_mismatch_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "invalid_quantity" );
}

TEST_CASE( "lua_platform_trade_quote_rejects_stale_participant_item_and_holder",
           "[lua][platform][trade][quote][stale]" )
{
    {
        platform_trade_quote_fixture fixture( 143, 404, 120031, 120032 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();

        cata::lua_platform::retire_npc_handle_identity( *fixture.buyer );
        const sol::protected_function_result stale_actor_result = fixture.get( token );
        REQUIRE( stale_actor_result.valid() );
        const sol::table stale_actor_envelope = stale_actor_result.get<sol::table>();
        REQUIRE_FALSE( stale_actor_envelope["ok"].get<bool>() );
        CHECK( stale_actor_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_identity" );
    }

    {
        platform_trade_quote_fixture fixture( 144, 405, 120041, 120042 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        fixture.live_item->charges += 1;
        const sol::protected_function_result stale_item_result = fixture.get( token );
        REQUIRE( stale_item_result.valid() );
        const sol::table stale_item_envelope = stale_item_result.get<sol::table>();
        REQUIRE_FALSE( stale_item_envelope["ok"].get<bool>() );
        CHECK( stale_item_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_item" );
    }

    {
        platform_trade_quote_fixture fixture( 145, 406, 120051, 120052 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::bump_item_query_mutation_epoch();
        const sol::protected_function_result stale_epoch_result = fixture.get( token );
        REQUIRE( stale_epoch_result.valid() );
        const sol::table stale_epoch_envelope = stale_epoch_result.get<sol::table>();
        REQUIRE_FALSE( stale_epoch_envelope["ok"].get<bool>() );
        CHECK( stale_epoch_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_holder" );
    }
}

TEST_CASE( "lua_platform_trade_quote_expires_and_retires_on_runtime_world_or_save_change",
           "[lua][platform][trade][quote][lifecycle]" )
{
    platform_calendar_turn_scope turn_scope;
    {
        platform_trade_quote_fixture fixture( 146, 407, 120061, 120062 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3, 1 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        const std::int64_t issued = to_turn<std::int64_t>( calendar::turn );
        calendar::turn = calendar::turn + time_duration::from_turns(
                              token.expires_turn() - issued );
        const sol::protected_function_result expired_result = fixture.get( token );
        REQUIRE( expired_result.valid() );
        const sol::table expired_envelope = expired_result.get<sol::table>();
        REQUIRE_FALSE( expired_envelope["ok"].get<bool>() );
        CHECK( expired_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "expired_quote" );
    }

    {
        platform_trade_quote_fixture fixture( 147, 408, 120071, 120072 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
        fixture.active_runtime = cata::lua_platform::game_handle_runtime(
                                     other_owner, fixture.runtime.generation() );
        const sol::protected_function_result runtime_result = fixture.get( token );
        REQUIRE( runtime_result.valid() );
        const sol::table runtime_envelope = runtime_result.get<sol::table>();
        REQUIRE_FALSE( runtime_envelope["ok"].get<bool>() );
        CHECK( runtime_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_runtime" );
    }

    {
        platform_trade_quote_fixture fixture( 148, 409, 120081, 120082 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        fixture.active_world_generation += 1;
        const sol::protected_function_result world_result = fixture.get( token );
        REQUIRE( world_result.valid() );
        const sol::table world_envelope = world_result.get<sol::table>();
        REQUIRE_FALSE( world_envelope["ok"].get<bool>() );
        CHECK( world_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_world" );
    }

    {
        platform_trade_quote_fixture fixture( 149, 410, 120091, 120092 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::runtime_before_save();
        const sol::protected_function_result save_result = fixture.get( token );
        REQUIRE( save_result.valid() );
        const sol::table save_envelope = save_result.get<sol::table>();
        REQUIRE_FALSE( save_envelope["ok"].get<bool>() );
        CHECK( save_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_quote" );
    }
}

TEST_CASE( "lua_platform_trade_quote_returns_a_detached_snapshot_without_mutation",
           "[lua][platform][trade][quote][snapshot]" )
{
    platform_trade_quote_fixture fixture( 150, 411, 120101, 120102 );
    REQUIRE( fixture.ready() );
    const int item_charges_before = fixture.live_item->charges;
    const int buyer_cash_before = fixture.buyer->cash;
    const sol::protected_function_result result = fixture.quote( 3 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    sol::table snapshot = envelope["value"];
    const cata::lua_platform::trade_quote_token token =
        snapshot["token"].get<cata::lua_platform::trade_quote_token>();
    sol::table quoted_lines = snapshot["lines"];
    const sol::table quoted_line = quoted_lines[1];
    const lua_Integer original_net = snapshot["net"].get<lua_Integer>();
    const lua_Integer original_total = quoted_line["total"].get<lua_Integer>();

    CHECK( token.registered() );
    CHECK( token.quote_id() > 0 );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.active_world_generation );
    CHECK( token.seller_stable_id() == fixture.seller_handle.locator().stable_id );
    CHECK( token.buyer_stable_id() == fixture.buyer_handle.locator().stable_id );
    CHECK( token.seller_identity_generation() == fixture.seller_handle.identity_generation() );
    CHECK( token.buyer_identity_generation() == fixture.buyer_handle.identity_generation() );
    CHECK( token.holder_mutation_generation() ==
           cata::lua_platform::item_holder_mutation_generation() );
    CHECK( token.pricing_generation() == snapshot["pricing_generation"].get<lua_Integer>() );
    CHECK( token.faction_generation() == snapshot["faction_generation"].get<lua_Integer>() );
    CHECK( token.debt_generation() == snapshot["debt_generation"].get<lua_Integer>() );
    CHECK( token.opinion_generation() == snapshot["opinion_generation"].get<lua_Integer>() );
    CHECK( token.issued_turn() == snapshot["issued_turn"].get<lua_Integer>() );
    CHECK( token.expires_turn() == snapshot["expires_turn"].get<lua_Integer>() );
    CHECK( token.expires_turn() > token.issued_turn() );

    CHECK( quoted_line["item_uid"].get<lua_Integer>() == fixture.live_item->uid().get_value() );
    CHECK( quoted_line["item_identity_generation"].get<lua_Integer>() ==
           fixture.item_handle.identity_generation() );
    CHECK( quoted_line["quantity"].get<lua_Integer>() == 3 );
    CHECK( quoted_line["charges_at_quote"].get<lua_Integer>() == item_charges_before );
    CHECK( quoted_line["unit_price"].is<lua_Integer>() );
    CHECK( quoted_line["total"].is<lua_Integer>() );
    CHECK( quoted_line["source_holder_mutation_generation"].get<lua_Integer>() ==
           token.holder_mutation_generation() );
    CHECK( quoted_line["destination_holder_mutation_generation"].get<lua_Integer>() ==
           token.holder_mutation_generation() );
    CHECK( quoted_line["source_holder"].get<sol::table>()["locator"]
           .get<sol::table>()["scope"].get<std::string>() == "avatar" );
    CHECK( quoted_line["destination_holder"].get<sol::table>()["locator"]
           .get<sol::table>()["scope"].get<std::string>() == "npc" );

    snapshot["net"] = -999999;
    quoted_lines[1]["quantity"] = 999999;
    quoted_lines[1]["total"] = -999999;
    snapshot["lines"] = fixture.lua.create_table();

    const sol::protected_function_result reread_result = fixture.get( token );
    REQUIRE( reread_result.valid() );
    const sol::table reread_envelope = reread_result.get<sol::table>();
    REQUIRE( reread_envelope["ok"].get<bool>() );
    const sol::table reread_snapshot = reread_envelope["value"];
    const sol::table reread_line = reread_snapshot["lines"].get<sol::table>()[1];
    CHECK( reread_snapshot["net"].get<lua_Integer>() == original_net );
    CHECK( reread_line["quantity"].get<lua_Integer>() == 3 );
    CHECK( reread_line["total"].get<lua_Integer>() == original_total );
    CHECK( fixture.live_item->charges == item_charges_before );
    CHECK( fixture.buyer->cash == buyer_cash_before );
}

TEST_CASE( "lua_platform_trade_commit_two_way_multi_line",
           "[lua][platform][trade][commit]" )
{
    platform_trade_commit_fixture fixture( 151, 501, 121001, 121002 );
    REQUIRE( fixture.ready() );
    const std::int64_t seller_uid = fixture.live_item->uid().get_value();
    const std::int64_t buyer_uid = fixture.buyer_item->uid().get_value();

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 8, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    requested_lines[2] = fixture.line(
                             "buyer_to_seller", 1, fixture.buyer_item_handle,
                             fixture.buyer_handle, fixture.seller_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    std::string quote_error_code;
    std::string quote_error_message;
    if( !quote_envelope["ok"].get<bool>() ) {
        const sol::table quote_error = quote_envelope["error"];
        quote_error_code = quote_error["code"].get<std::string>();
        quote_error_message = quote_error["message"].get<std::string>();
    }
    CAPTURE( quote_error_code, quote_error_message );
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    const sol::protected_function_result get_result = fixture.get( token );
    REQUIRE( get_result.valid() );
    REQUIRE( get_result.get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE( commit_envelope["ok"].get<bool>() );
    const sol::table committed = commit_envelope["value"];
    CHECK( committed["committed"].get<bool>() );
    CHECK( committed["consumed"].get<bool>() );
    CHECK( committed["commit_generation"].get<lua_Integer>() == 1 );
    CHECK( committed["settlement_strategy"].get<std::string>() == "npc_debt" );
    REQUIRE( committed["lines"].get<sol::table>().size() == 2 );
    CHECK( committed["lines"].get<sol::table>()[1]["item_uid"].get<lua_Integer>() ==
           seller_uid );
    CHECK( committed["lines"].get<sol::table>()[2]["item_uid"].get<lua_Integer>() ==
           buyer_uid );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 0 );
    CHECK( count_platform_trade_items( *fixture.buyer, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, buyer_uid ) == 0 );
    CHECK( count_platform_trade_items( fixture.seller, buyer_uid ) == 1 );
    CHECK( fixture.buyer->op_of_u.owed == committed["debt_after"].get<lua_Integer>() );
    CHECK_FALSE( token.registered() );
}

TEST_CASE( "lua_platform_trade_commit_partial_charges",
           "[lua][platform][trade][commit]" )
{
    platform_trade_commit_fixture fixture( 152, 502, 121011, 121012 );
    REQUIRE( fixture.ready() );
    const std::int64_t seller_uid = fixture.live_item->uid().get_value();
    const int source_charges = fixture.live_item->charges;

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();
    REQUIRE( fixture.get( token ).get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE( commit_envelope["ok"].get<bool>() );
    const sol::table committed_line =
        commit_envelope["value"].get<sol::table>()["lines"].get<sol::table>()[1];
    const std::int64_t transferred_uid =
        committed_line["transferred_item_uid"].get<lua_Integer>();

    CHECK( fixture.live_item->charges == source_charges - 3 );
    CHECK( transferred_uid != seller_uid );
    item *received = find_platform_trade_item( *fixture.buyer, transferred_uid );
    REQUIRE( received != nullptr );
    CHECK( received->charges == 3 );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, transferred_uid ) == 1 );
}

TEST_CASE( "lua_platform_trade_commit_capacity_rollback",
           "[lua][platform][trade][commit][rollback]" )
{
    platform_trade_commit_fixture fixture( 153, 503, 121021, 121022 );
    REQUIRE( fixture.ready() );
    item *blocker = fixture.add_buyer_item( itype_id( "9mm" ), 2 );
    REQUIRE( blocker != nullptr );
    const std::int64_t source_uid = fixture.live_item->uid().get_value();
    const std::int64_t blocker_uid = blocker->uid().get_value();
    const int source_charges = fixture.live_item->charges;
    const int blocker_charges = blocker->charges;

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE_FALSE( commit_envelope["ok"].get<bool>() );
    const std::string code =
        commit_envelope["error"].get<sol::table>()["code"].get<std::string>();
    CHECK( ( code == "destination_rejected" || code == "destination_capacity" ) );
    CHECK( fixture.live_item->charges == source_charges );
    item *unchanged_blocker = find_platform_trade_item( *fixture.buyer, blocker_uid );
    REQUIRE( unchanged_blocker != nullptr );
    CHECK( unchanged_blocker->charges == blocker_charges );
    CHECK( count_platform_trade_items( fixture.seller, source_uid ) == 1 );
    CHECK( token.registered() );

    const sol::protected_function_result retry_read = fixture.get( token );
    REQUIRE( retry_read.valid() );
    CHECK( retry_read.get<sol::table>()["ok"].get<bool>() );
}

TEST_CASE( "lua_platform_trade_commit_mid_extract_rollback",
           "[lua][platform][trade][commit][rollback]" )
{
    platform_trade_commit_fixture fixture( 154, 504, 121031, 121032 );
    REQUIRE( fixture.ready() );
    const std::int64_t seller_uid = fixture.live_item->uid().get_value();
    const std::int64_t buyer_uid = fixture.buyer_item->uid().get_value();

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 8, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    requested_lines[2] = fixture.line(
                             "buyer_to_seller", 1, fixture.buyer_item_handle,
                             fixture.buyer_handle, fixture.seller_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();
    const sol::protected_function_result get_result = fixture.get( token );
    REQUIRE( get_result.valid() );
    REQUIRE( get_result.get<sol::table>()["ok"].get<bool>() );

    cata::lua_platform::platform_trade_item_request first;
    first.item_handle = fixture.seller_item_handle;
    first.source_holder.character = fixture.seller_handle;
    first.source_holder.slot = "inventory";
    first.destination_holder.character = fixture.buyer_handle;
    first.destination_holder.slot = "inventory";
    first.quantity = 8;
    cata::lua_platform::platform_trade_item_request second;
    second.item_handle = fixture.buyer_item_handle;
    second.source_holder.character = fixture.buyer_handle;
    second.source_holder.slot = "inventory";
    second.destination_holder.character = fixture.seller_handle;
    second.destination_holder.slot = "inventory";
    second.quantity = 1;
    const std::vector<cata::lua_platform::platform_trade_item_request> requests = {
        first, second
    };
    std::vector<cata::lua_platform::platform_trade_item_result> staged;
    cata::lua_platform::platform_item_transaction transaction;
    const std::optional<cata::lua_platform::game_handle_error> stage_error =
        cata::lua_platform::stage_platform_trade_items(
            requests, fixture.runtime,
            fixture.active_world_generation,
            cata::lua_platform::item_holder_mutation_generation(), staged,
            transaction );
    REQUIRE_FALSE( stage_error.has_value() );
    REQUIRE( staged.size() == 2 );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 0 );
    CHECK( count_platform_trade_items( *fixture.buyer, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, buyer_uid ) == 0 );
    CHECK( count_platform_trade_items( fixture.seller, buyer_uid ) == 1 );

    // No native extraction-failure injector exists; use the existing staged
    // transaction rollback hook that the commit path owns on mid-operation failure.
    REQUIRE( transaction.rollback_now() );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, seller_uid ) == 0 );
    CHECK( count_platform_trade_items( *fixture.buyer, buyer_uid ) == 1 );
    CHECK( count_platform_trade_items( fixture.seller, buyer_uid ) == 0 );

    const sol::protected_function_result stale_commit = fixture.commit( token );
    REQUIRE( stale_commit.valid() );
    const sol::table stale_envelope = stale_commit.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_holder" );
}

TEST_CASE( "lua_platform_trade_commit_debt_publish_rollback",
           "[lua][platform][trade][commit][rollback]" )
{
    platform_trade_commit_fixture fixture( 155, 505, 121041, 121042 );
    REQUIRE( fixture.ready() );
    const std::int64_t source_uid = fixture.live_item->uid().get_value();
    const int source_charges = fixture.live_item->charges;
    const int original_owed = fixture.buyer->op_of_u.owed;

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();
    REQUIRE( fixture.get( token ).get<sol::table>()["ok"].get<bool>() );

    fixture.buyer->op_of_u.owed = original_owed + 1;
    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE_FALSE( commit_envelope["ok"].get<bool>() );
    const std::string code =
        commit_envelope["error"].get<sol::table>()["code"].get<std::string>();
    CHECK( ( code == "pricing_changed" || code == "debt_changed" ) );
    CHECK( fixture.buyer->op_of_u.owed == original_owed + 1 );
    CHECK( fixture.live_item->charges == source_charges );
    CHECK( count_platform_trade_items( fixture.seller, source_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, source_uid ) == 0 );
    CHECK_FALSE( token.registered() );
}

TEST_CASE( "lua_platform_trade_commit_double_commit",
           "[lua][platform][trade][commit]" )
{
    platform_trade_commit_fixture fixture( 156, 506, 121051, 121052 );
    REQUIRE( fixture.ready() );
    const std::int64_t source_uid = fixture.live_item->uid().get_value();

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    const sol::protected_function_result first_commit = fixture.commit( token );
    REQUIRE( first_commit.valid() );
    const sol::table first_envelope = first_commit.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_value = first_envelope["value"];
    const std::int64_t transferred_uid =
        first_value["lines"].get<sol::table>()[1]["transferred_item_uid"]
        .get<lua_Integer>();
    const int owed_after_first = fixture.buyer->op_of_u.owed;
    CHECK( first_value["commit_generation"].get<lua_Integer>() == 1 );
    CHECK_FALSE( token.registered() );

    const sol::protected_function_result second_commit = fixture.commit( token );
    REQUIRE( second_commit.valid() );
    const sol::table second_envelope = second_commit.get<sol::table>();
    REQUIRE_FALSE( second_envelope["ok"].get<bool>() );
    CHECK( second_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "consumed_quote" );
    CHECK( fixture.live_item->charges == 5 );
    CHECK( count_platform_trade_items( fixture.seller, source_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, transferred_uid ) == 1 );
    CHECK( fixture.buyer->op_of_u.owed == owed_after_first );
}

TEST_CASE( "lua_platform_trade_commit_stale_actor_item_epoch",
           "[lua][platform][trade][commit][stale]" )
{
    {
        platform_trade_commit_fixture fixture( 157, 507, 121061, 121062 );
        REQUIRE( fixture.ready() );
        const int source_charges = fixture.live_item->charges;
        sol::table requested_lines = fixture.lua.create_table();
        requested_lines[1] = fixture.line(
                                 "seller_to_buyer", 3, fixture.seller_item_handle,
                                 fixture.seller_handle, fixture.buyer_handle );
        const sol::protected_function_result quote_result = fixture.quote( requested_lines );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::retire_npc_handle_identity( *fixture.buyer );
        const sol::protected_function_result commit_result = fixture.commit( token );
        REQUIRE( commit_result.valid() );
        const sol::table envelope = commit_result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_identity" );
        CHECK( fixture.live_item->charges == source_charges );
        CHECK_FALSE( token.registered() );
    }

    {
        platform_trade_commit_fixture fixture( 158, 508, 121071, 121072 );
        REQUIRE( fixture.ready() );
        const int source_charges = fixture.live_item->charges;
        sol::table requested_lines = fixture.lua.create_table();
        requested_lines[1] = fixture.line(
                                 "seller_to_buyer", 3, fixture.seller_item_handle,
                                 fixture.seller_handle, fixture.buyer_handle );
        const sol::protected_function_result quote_result = fixture.quote( requested_lines );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        fixture.live_item->charges += 1;
        const sol::protected_function_result commit_result = fixture.commit( token );
        REQUIRE( commit_result.valid() );
        const sol::table envelope = commit_result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_item" );
        CHECK( fixture.live_item->charges == source_charges + 1 );
        CHECK_FALSE( token.registered() );
    }

    {
        platform_trade_commit_fixture fixture( 159, 509, 121081, 121082 );
        REQUIRE( fixture.ready() );
        const int source_charges = fixture.live_item->charges;
        sol::table requested_lines = fixture.lua.create_table();
        requested_lines[1] = fixture.line(
                                 "seller_to_buyer", 3, fixture.seller_item_handle,
                                 fixture.seller_handle, fixture.buyer_handle );
        const sol::protected_function_result quote_result = fixture.quote( requested_lines );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::bump_item_query_mutation_epoch();
        const sol::protected_function_result commit_result = fixture.commit( token );
        REQUIRE( commit_result.valid() );
        const sol::table envelope = commit_result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_holder" );
        CHECK( fixture.live_item->charges == source_charges );
        CHECK_FALSE( token.registered() );
    }
}

namespace
{

struct platform_overmap_travel_fixture {
    explicit platform_overmap_travel_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( owner, runtime_number ),
        world( world_number ) {
        clear_avatar();
        clear_map_without_vision();
        cata::lua_platform::reset_overmap_tile_tokens();

        avatar &player = get_avatar();
        source_omt = project_to<coords::omt>( player.pos_abs() );
        const point_abs_om om_pos = project_to<coords::om>( source_omt.xy() );
        const point_om_omt local_xy =
            project_remain<coords::om>( source_omt.xy() ).remainder;
        source_overmap = overmap_buffer.get_existing( om_pos );
        if( source_overmap != nullptr ) {
            source_local = tripoint_om_omt( local_xy, source_omt.z() );
            preimage.terrain = source_overmap->ter( source_local );
            preimage.seen = source_overmap->seen( source_local );
            preimage.explored = source_overmap->is_explored( source_local );
            preimage.has_note = source_overmap->has_note( source_local );
            preimage.note = source_overmap->note( source_local );
            preimage.danger_radius =
                source_overmap->note_danger_radius( source_local );
            preimage.dangerous = preimage.danger_radius >= 0;
            edit_ready = true;
        }
        target_omt = source_omt + tripoint::east;

        services = lua.create_table();
        const auto current_runtime = [this]() {
            return runtime;
        };
        const auto current_world = [this]() {
            return world;
        };
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_mapgen_service_api(
            services, current_runtime, current_world, []() {},
        [this]() {
            write_called = true;
        } );
        cata::lua_platform::install_overmap_api(
            services, current_runtime, current_world, []() {},
        [this]() {
            write_called = true;
        },
        []( const std::size_t ) {
            return std::size_t{ 0 };
        } );
        cata::lua_platform::install_game_handle_api(
            lua, services, current_runtime, current_world, []() {} );
        cata::lua_platform::install_game_world_service_api(
            services, current_runtime, current_world, []() {},
        [this]() {
            write_called = true;
        },
        []() {}, []() {
            return true;
        } );

        const tripoint_abs_ms position = player.pos_abs();
        avatar_handle = cata::lua_platform::game_handle::from_creature(
                             player,
                             { "avatar", player.getID().get_value(),
                               position.x(), position.y(), position.z(), {} },
                             runtime, world );
    }

    ~platform_overmap_travel_fixture() {
        if( get_avatar().pos_abs_omt() != source_omt ) {
            g->place_player_overmap( source_omt );
        }
        if( edit_ready ) {
            if( source_overmap->ter( source_local ) != preimage.terrain ) {
                source_overmap->ter_set( source_local, preimage.terrain );
            }
            if( source_overmap->seen( source_local ) != preimage.seen ) {
                source_overmap->set_seen( source_local, preimage.seen, true );
            }
            if( source_overmap->is_explored( source_local ) != preimage.explored ) {
                source_overmap->explored( source_local ) = preimage.explored;
            }
            if( preimage.has_note ) {
                if( !source_overmap->has_note( source_local ) ||
                    source_overmap->note( source_local ) != preimage.note ) {
                    if( source_overmap->has_note( source_local ) ) {
                        source_overmap->delete_note( source_local );
                    }
                    source_overmap->add_note( source_local, preimage.note );
                }
            } else if( source_overmap->has_note( source_local ) ) {
                source_overmap->delete_note( source_local );
            }
            if( preimage.has_note && source_overmap->has_note( source_local ) ) {
                source_overmap->mark_note_dangerous(
                    source_local,
                    preimage.dangerous ? preimage.danger_radius : 0,
                    preimage.dangerous );
            }
        }
        cata::lua_platform::reset_overmap_tile_tokens();
        clear_avatar();
    }

    sol::table overmap_api() const {
        return services["overmap"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord abs_omt_position(
        const tripoint_abs_omt &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::overmap_terrain,
                   value.raw() );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> owner;
    cata::lua_platform::game_handle_runtime runtime;
    std::size_t world;
    sol::state lua;
    sol::table services;
    cata::lua_platform::game_handle avatar_handle;
    tripoint_abs_omt source_omt = tripoint_abs_omt::invalid;
    overmap *source_overmap = nullptr;
    tripoint_om_omt source_local = tripoint_om_omt::invalid;
    struct platform_overmap_tile_preimage {
        oter_id terrain;
        om_vision_level seen = om_vision_level::unseen;
        bool explored = false;
        bool has_note = false;
        std::string note;
        int danger_radius = -1;
        bool dangerous = false;
    } preimage;
    bool edit_ready = false;
    tripoint_abs_omt target_omt = tripoint_abs_omt::invalid;
    bool write_called = false;
};

struct platform_map_api_test_fixture {
    explicit platform_map_api_test_fixture( const std::size_t runtime_number,
            const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_map_without_vision();
        cata::lua_platform::reset_map_tile_tokens();
        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_map_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_item_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
        local = tripoint_bub_ms::zero;
        absolute = get_map().get_abs( local );
    }

    ~platform_map_api_test_fixture() {
        cata::lua_platform::reset_map_tile_tokens();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table item_api() const {
        return services["items"];
    }

    map &get_map() const {
        return ::get_map();
    }

    cata::lua_platform::script_tripoint_coord position() const {
        return position( local );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        const tripoint_abs_ms absolute_position = get_map().get_abs( value );
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   absolute_position.raw() );
    }

    sol::table map_holder(
        const cata::lua_platform::map_tile_token &token ) {
        sol::table holder = lua.create_table();
        holder["kind"] = "map_tile";
        holder["tile"] = token;
        return holder;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_abs_ms absolute = tripoint_abs_ms::invalid;
    bool write_called = false;
};

struct platform_monster_relocation_fixture {
    explicit platform_monster_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_map_without_vision();
        get_creature_tracker().clear();
        cata::lua_platform::reset_map_tile_tokens();
        local = tripoint_bub_ms::zero;
        target_local = local + tripoint::east;
        source_abs = get_map().get_abs( local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            get_map().ter_set( local, floor_id.id() );
            get_map().ter_set( target_local, floor_id.id() );
        }

        test_monster = make_shared_fast<monster>(
                            mtype_id( "mon_zombie" ), local );
        if( test_monster ) {
            test_monster->set_hp( 1 );
            if( !get_creature_tracker().add( test_monster ) ) {
                test_monster.reset();
            }
        }

        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_map_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_game_world_service_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        },
        []() {},
        []() {
            return true;
        } );

        if( test_monster ) {
            monster_handle = cata::lua_platform::game_handle::from_creature(
                                 *test_monster,
                                 { "monster", test_monster->uid().get_value(),
                                   source_abs.x(), source_abs.y(), source_abs.z(), {} },
                                 runtime, active_world_generation );
        }
    }

    ~platform_monster_relocation_fixture() {
        for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
            if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
                get_creature_tracker().remove( *entry );
            }
        }
        if( test_monster &&
            get_creature_tracker().temporary_id( *test_monster ) >= 0 ) {
            get_creature_tracker().remove( *test_monster );
        }
        cata::lua_platform::reset_map_tile_tokens();
    }

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value ) {
        shared_ptr_fast<monster> result = make_shared_fast<monster>(
                mtype_id( "mon_zombie" ), value );
        result->set_hp( 1 );
        if( !get_creature_tracker().add( result ) ) {
            return {};
        }
        extra_monsters.push_back( result );
        return result;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    shared_ptr_fast<monster> test_monster;
    std::vector<shared_ptr_fast<monster>> extra_monsters;
    cata::lua_platform::game_handle monster_handle;
    bool write_called = false;
};

struct platform_avatar_relocation_fixture {
    explicit platform_avatar_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_avatar();
        clear_map_without_vision();
        cata::lua_platform::reset_map_tile_tokens();
        get_creature_tracker().clear();
        local = tripoint_bub_ms::zero;
        target_local = local + tripoint::east;
        source_abs = get_map().get_abs( local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            get_map().ter_set( local, floor_id.id() );
            get_map().ter_set( target_local, floor_id.id() );
        }

        avatar &player = get_avatar();
        player.setpos( get_map(), local );
        player.in_vehicle = false;
        player.grab_point = tripoint_rel_ms::zero;
        player.hauling = false;
        player.activity = player_activity();
        player.clear_destination();

        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_map_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_game_world_service_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        },
        []() {},
        []() {
            return true;
        } );

        avatar_handle = cata::lua_platform::game_handle::from_creature(
                             player,
                             { "avatar", player.getID().get_value(),
                               source_abs.x(), source_abs.y(), source_abs.z(), {} },
                             runtime, active_world_generation );
    }

    ~platform_avatar_relocation_fixture() {
        for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
            if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
                get_creature_tracker().remove( *entry );
            }
        }
        clear_avatar();
        cata::lua_platform::reset_map_tile_tokens();
    }

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value ) {
        shared_ptr_fast<monster> result = make_shared_fast<monster>(
                mtype_id( "mon_zombie" ), value );
        result->set_hp( 1 );
        if( !get_creature_tracker().add( result ) ) {
            return {};
        }
        extra_monsters.push_back( result );
        return result;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    std::vector<shared_ptr_fast<monster>> extra_monsters;
    cata::lua_platform::game_handle avatar_handle;
    bool write_called = false;
};

struct platform_npc_relocation_fixture {
    explicit platform_npc_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_npcs();
        clear_map_without_vision();
        cata::lua_platform::reset_map_tile_tokens();
        local = tripoint_bub_ms::zero;
        target_local = local + tripoint::east;
        source_abs = get_map().get_abs( local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            get_map().ter_set( local, floor_id.id() );
            get_map().ter_set( target_local, floor_id.id() );
        }

        npc_id = get_map().place_npc( local.xy(), npc_template_id( "test_talker" ) );
        g->load_npcs();
        test_npc = g->find_npc( npc_id );
        if( test_npc != nullptr ) {
            test_npc->in_vehicle = false;
            test_npc->grab_point = tripoint_rel_ms::zero;
            test_npc->hauling = false;
            test_npc->activity = player_activity();
            test_npc->clear_destination();
        }

        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_map_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_game_world_service_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        },
        []() {},
        []() {
            return true;
        } );

        if( test_npc != nullptr ) {
            npc_handle = cata::lua_platform::game_handle::from_creature(
                             *test_npc,
                             { "npc", test_npc->getID().get_value(),
                               source_abs.x(), source_abs.y(), source_abs.z(), {} },
                             runtime, active_world_generation );
        }
    }

    ~platform_npc_relocation_fixture() {
        clear_npcs();
        cata::lua_platform::reset_map_tile_tokens();
    }

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    npc *test_npc = nullptr;
    character_id npc_id;
    cata::lua_platform::game_handle npc_handle;
    bool write_called = false;
};

struct platform_vehicle_relocation_fixture {
    explicit platform_vehicle_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_vehicles();
        get_creature_tracker().clear();
        clear_map_without_vision();
        cata::lua_platform::reset_map_tile_tokens();
        source_local = tripoint_bub_ms( 8, 8, 0 );
        target_local = source_local + tripoint_rel_ms( 6, 0, 0 );
        source_abs = get_map().get_abs( source_local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            for( int dx = -2; dx <= 8; ++dx ) {
                for( int dy = -2; dy <= 2; ++dy ) {
                    const tripoint_rel_ms offset( dx, dy, 0 );
                    get_map().ter_set( source_local + offset, floor_id.id() );
                }
            }
        }

        epoch_before = cata::lua_platform::map_mutation_epoch();
        test_vehicle = get_map().add_vehicle(
                           vehicle_prototype_test_shopping_cart,
                           source_local, 0_degrees, 0,
                           veh_spawn_status::UNDAMAGED );
        epoch_after = cata::lua_platform::map_mutation_epoch();

        services = lua.create_table();
        cata::lua_platform::install_value_type_api(
            lua, services, []() {} );
        cata::lua_platform::install_map_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        } );
        cata::lua_platform::install_game_handle_api(
            lua, services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {} );
        cata::lua_platform::install_game_world_service_api(
            services,
            [this]() {
            return active_runtime;
        },
        [this]() {
            return active_world_generation;
        },
        []() {},
        [this]() {
            write_called = true;
        },
        []() {},
        []() {
            return true;
        } );

        if( test_vehicle != nullptr ) {
            vehicle_handle = cata::lua_platform::game_handle::from_vehicle(
                                 *test_vehicle,
                                 { "map_vehicle", 0, source_abs.x(),
                                   source_abs.y(), source_abs.z(), {} },
                                 runtime, active_world_generation );
            vehicle_identity_generation = vehicle_handle.identity_generation();

            for( std::size_t part_index = 0;
                 part_index < test_vehicle->part_count(); ++part_index ) {
                vehicle_part &candidate = test_vehicle->part( part_index );
                if( candidate.removed ) {
                    continue;
                }
                const cata::lua_platform::game_handle candidate_handle =
                    cata::lua_platform::game_handle::from_vehicle_part(
                        candidate, *test_vehicle,
                        { "vehicle_part", 0, source_abs.x(), source_abs.y(),
                          source_abs.z(), {} },
                        runtime, active_world_generation );
                if( candidate_handle.kind() ==
                    cata::lua_platform::game_handle_kind::vehicle_part ) {
                    live_part = &candidate;
                    vehicle_part_handle = candidate_handle;
                    part_identity_generation =
                        vehicle_part_handle.identity_generation();
                }
                break;
            }
        }
    }

    ~platform_vehicle_relocation_fixture() {
        g->setremoteveh( nullptr );
        get_avatar().grab( object_type::NONE );
        get_map().unboard_vehicle( source_local );
        clear_avatar();
        clear_vehicles();
        for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
            if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
                get_creature_tracker().remove( *entry );
            }
        }
        cata::lua_platform::reset_map_tile_tokens();
    }

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    vehicle *add_target_blocker_vehicle() {
        vehicle *result = get_map().add_vehicle(
                              vehicle_prototype_test_shopping_cart,
                              target_local, 0_degrees, 0,
                              veh_spawn_status::UNDAMAGED );
        if( result != nullptr ) {
            target_blocker_vehicle = result;
        }
        return result;
    }

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value ) {
        shared_ptr_fast<monster> result = make_shared_fast<monster>(
                mtype_id( "mon_zombie" ), value );
        if( !result ) {
            return {};
        }
        result->set_hp( 1 );
        if( !get_creature_tracker().add( result ) ) {
            return {};
        }
        extra_monsters.push_back( result );
        return result;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms source_local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    vehicle *test_vehicle = nullptr;
    vehicle *target_blocker_vehicle = nullptr;
    vehicle_part *live_part = nullptr;
    std::vector<shared_ptr_fast<monster>> extra_monsters;
    cata::lua_platform::game_handle vehicle_handle;
    cata::lua_platform::game_handle vehicle_part_handle;
    std::size_t vehicle_identity_generation = 0;
    std::size_t part_identity_generation = 0;
    std::uint64_t epoch_before = 0;
    std::uint64_t epoch_after = 0;
    bool write_called = false;
};

struct platform_mapgen_callback_transaction_test_fixture {
    platform_mapgen_callback_transaction_test_fixture() :
        local_map( ter_str_id( "t_floor" ).id() ),
        data( *local_map.cast_to_map(), mapgendata::dummy_settings ),
        context( data, true, UINT64_C( 0x6a09e667f3bcc909 ) ) {
        native_map().ter_set( position(), ter_str_id( "t_floor" ).id() );
        data.set_dir( 0, direction_before );
    }

    map &native_map() {
        return *local_map.cast_to_map();
    }

    static tripoint_bub_ms position() {
        return tripoint_bub_ms( 1, 1, 0 );
    }

    small_fake_map local_map;
    mapgendata data;
    cata::lua_platform::script_mapgen_context context;
    sol::state lua;
    const int direction_before = 37;
};

} // namespace

TEST_CASE( "lua_platform_mapgen_callback_transaction_native_helper",
           "[lua][platform][mapgen][transaction]" )
{
    SECTION( "rollback restores the callback preimage" )
    {
        platform_mapgen_callback_transaction_test_fixture fixture;
        map &here = fixture.native_map();
        const tripoint_bub_ms position = fixture.position();
        const ter_id terrain_before = here.ter( position );
        const int direction_before = fixture.data.dir( 0 );

        platform_mapgen_transaction_report report;
        platform_mapgen_callback_transaction transaction( fixture.data, &report );
        REQUIRE( transaction.ready() );

        REQUIRE( fixture.context.set_terrain(
                     position.x(), position.y(),
                     cata::lua_platform::script_game_id( "terrain", "t_wall" ) ) );
        fixture.context.set_dir( 0, -37 );
        CHECK( here.ter( position ) == ter_str_id( "t_wall" ).id() );
        CHECK( fixture.data.dir( 0 ) == -37 );

        REQUIRE( transaction.rollback( "callback_failed", "test" ) );
        CHECK( report.state == platform_mapgen_transaction_state::rolled_back );
        CHECK( report.code == "callback_failed" );
        CHECK( report.message == "test" );
        CHECK( report.footprint.min_z == fixture.data.zlevel() );
        CHECK( report.footprint.max_z == fixture.data.zlevel() );
        CHECK( here.ter( position ) == terrain_before );
        CHECK( fixture.data.dir( 0 ) == direction_before );

        fixture.context.invalidate();
        CHECK_FALSE( fixture.context.valid() );
    }

    SECTION( "commit keeps the callback terrain change" )
    {
        platform_mapgen_callback_transaction_test_fixture fixture;
        map &here = fixture.native_map();
        const tripoint_bub_ms position = fixture.position();

        platform_mapgen_transaction_report report;
        platform_mapgen_callback_transaction transaction( fixture.data, &report );
        REQUIRE( transaction.ready() );

        REQUIRE( fixture.context.set_terrain(
                     position.x(), position.y(),
                     cata::lua_platform::script_game_id( "terrain", "t_wall" ) ) );
        transaction.commit();

        CHECK( report.state == platform_mapgen_transaction_state::committed );
        CHECK( here.ter( position ) == ter_str_id( "t_wall" ).id() );
    }
}

TEST_CASE( "lua_platform_mapgen_context_exposes_only_safe_mutations",
           "[lua][platform][mapgen][contract]" )
{
    platform_mapgen_callback_transaction_test_fixture fixture;
    cata::lua_platform::install_script_mapgen_context_api( fixture.lua );

    const sol::object mapgen_context_object = fixture.lua["ScriptMapgenContext"];
    REQUIRE( mapgen_context_object.valid() );
    const sol::usertype<cata::lua_platform::script_mapgen_context> mapgen_context =
        mapgen_context_object;

    fixture.lua["context"] = &fixture.context;
    const sol::object context_object = fixture.lua["context"];
    const sol::userdata context = context_object;
    REQUIRE( context.valid() );

    const std::vector<std::string> unsafe_methods = {
        "place_zone",
        "place_npc",
        "place_npc_configured",
        "place_vehicle",
        "apply_faction_ownership",
        "transform",
        "remove_vehicles",
        "remove_npcs",
        "remove_all",
        "nest",
        "generate"
    };
    for( const std::string &method : unsafe_methods ) {
        CHECK_FALSE( mapgen_context[method].valid() );
        CHECK_FALSE( context[method].valid() );
    }

    CHECK( mapgen_context["set_terrain"].valid() );
    CHECK( mapgen_context["queue_point"].valid() );
    CHECK( context["set_terrain"].valid() );
    CHECK( context["queue_point"].valid() );

    CHECK_THROWS_WITH(
        fixture.context.place_vehicle( 0, 0, "", 0, -1, -1, "" ),
        Catch::Matchers::Contains( "external mutation is unsupported" ) );
}

TEST_CASE( "lua_platform_mapgen_service_uses_typed_update_and_target_tokens",
           "[lua][platform][mapgen][contract]" )
{
    platform_overmap_travel_fixture fixture( 809, 39 );

    const sol::table mapgen = fixture.services["mapgen"];
    REQUIRE( mapgen.valid() );
    CHECK( mapgen["update_token"].valid() );
    CHECK( mapgen["apply"].valid() );

    const sol::object world_object = fixture.services["world"];
    CHECK_FALSE( world_object.valid() );
}

TEST_CASE( "lua_platform_mapgen_apply_rejects_untyped_and_legacy_requests",
           "[lua][platform][mapgen][contract]" )
{
    platform_overmap_travel_fixture fixture( 811, 41 );

    const sol::table overmap = fixture.overmap_api();
    const sol::table mapgen = fixture.services["mapgen"];
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function update_token = mapgen["update_token"];
    const sol::protected_function apply = mapgen["apply"];

    const sol::protected_function_result target_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( target_result.valid() );
    const sol::table target_envelope = target_result.get<sol::table>();
    REQUIRE( target_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token target =
        target_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const cata::lua_platform::script_game_id update_id(
        "update_mapgen", "fbmc_shelter_1_0" );
    const sol::protected_function_result update_result = update_token( update_id );
    REQUIRE( update_result.valid() );
    const sol::table update_envelope = update_result.get<sol::table>();
    REQUIRE( update_envelope["ok"].get<bool>() );
    const cata::lua_platform::mapgen_update_token update =
        update_envelope["value"].get<cata::lua_platform::mapgen_update_token>();

    const auto check_error = [&]( const char *expected_code, auto invoke ) {
        fixture.write_called = false;
        const sol::protected_function_result result = invoke();
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               expected_code );
        CHECK_FALSE( fixture.write_called );
    };

    check_error( "invalid_target", [&]() {
        return apply( fixture.abs_omt_position( fixture.target_omt ), update );
    } );
    check_error( "invalid_update", [&]() {
        return apply( target, update_id );
    } );

    const std::vector<std::pair<std::string, sol::table>> invalid_options = {
        { "delay", fixture.lua.create_table_with( "delay", 1 ) },
        { "mission", fixture.lua.create_table_with( "mission", true ) },
        { "key", fixture.lua.create_table_with( "key", "legacy-key" ) },
        { "cancel_on_collision=false",
          fixture.lua.create_table_with( "cancel_on_collision", false ) },
    };
    for( const auto &test_case : invalid_options ) {
        INFO( test_case.first );
        check_error( "invalid_options", [&]() {
            return apply( target, update, test_case.second );
        } );
    }

    const std::vector<std::pair<std::string, sol::table>> unsupported_transforms = {
        { "mirror_horizontal=true",
          fixture.lua.create_table_with( "mirror_horizontal", true ) },
        { "mirror_vertical=true",
          fixture.lua.create_table_with( "mirror_vertical", true ) },
        { "rotation=1", fixture.lua.create_table_with( "rotation", 1 ) },
        { "rotation=4", fixture.lua.create_table_with( "rotation", 4 ) },
    };
    for( const auto &test_case : unsupported_transforms ) {
        INFO( test_case.first );
        check_error( "unsupported_transform", [&]() {
            return apply( target, update, test_case.second );
        } );
    }
}

TEST_CASE( "lua_platform_mapgen_apply_reports_preflight_rejection_without_mutation",
           "[lua][platform][mapgen][transaction]" )
{
    platform_overmap_travel_fixture fixture( 812, 42 );

    const sol::table overmap = fixture.overmap_api();
    const sol::table mapgen = fixture.services["mapgen"];
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function update_token = mapgen["update_token"];
    const sol::protected_function apply = mapgen["apply"];

    const sol::protected_function_result target_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( target_result.valid() );
    const sol::table target_envelope = target_result.get<sol::table>();
    REQUIRE( target_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token target =
        target_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const cata::lua_platform::script_game_id update_id(
        "update_mapgen", "fbbb" );
    const sol::protected_function_result update_result = update_token( update_id );
    REQUIRE( update_result.valid() );
    const sol::table update_envelope = update_result.get<sol::table>();
    REQUIRE( update_envelope["ok"].get<bool>() );
    const cata::lua_platform::mapgen_update_token update =
        update_envelope["value"].get<cata::lua_platform::mapgen_update_token>();

    fixture.write_called = false;
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result result = apply( target, update );
    REQUIRE( result.valid() );
    CHECK_FALSE( fixture.write_called );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    const sol::table error = envelope["error"].get<sol::table>();
    CHECK( error["state"].get<std::string>() == "rejected" );
    CHECK( error["code"].get<std::string>() == "unsafe_operator" );
    const sol::object footprint = error["footprint"];
    CHECK( footprint.get_type() == sol::type::nil );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
}

TEST_CASE( "lua_platform_mapgen_update_tokens_reject_invalid_and_stale_context",
           "[lua][platform][mapgen][tokens]" )
{
    platform_overmap_travel_fixture fixture( 810, 40 );
    const sol::table mapgen = fixture.services["mapgen"];
    const sol::protected_function update_token = mapgen["update_token"];
    const cata::lua_platform::script_game_id valid_update(
        "update_mapgen", "fbmc_shelter_1_0" );
    REQUIRE( valid_update.is_valid() );

    const sol::protected_function_result token_result = update_token( valid_update );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::mapgen_update_token token =
        token_envelope["value"].get<cata::lua_platform::mapgen_update_token>();
    CHECK( token.id() == valid_update );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.world );
    CHECK( token.owner_is_current() );

    const auto check_invalid_id = [&](
        const cata::lua_platform::script_game_id &id ) {
        const sol::protected_function_result result = update_token( id );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "invalid_id" );
    };
    check_invalid_id( cata::lua_platform::script_game_id(
                          "terrain", "t_floor" ) );
    check_invalid_id( cata::lua_platform::script_game_id(
                          "update_mapgen", "lua_platform_missing_update" ) );

    const cata::lua_platform::game_handle_runtime stale_runtime(
        fixture.owner, fixture.runtime.generation() + 1 );
    const std::optional<cata::lua_platform::game_handle_error> runtime_error =
        cata::lua_platform::validate_mapgen_update_token(
            token, stale_runtime, fixture.world );
    REQUIRE( runtime_error.has_value() );
    CHECK( runtime_error->code == "stale_runtime" );

    const std::optional<cata::lua_platform::game_handle_error> world_error =
        cata::lua_platform::validate_mapgen_update_token(
            token, fixture.runtime, fixture.world + 1 );
    REQUIRE( world_error.has_value() );
    CHECK( world_error->code == "stale_world" );

    fixture.owner->retire();
    CHECK_FALSE( token.owner_is_current() );
    const std::optional<cata::lua_platform::game_handle_error> owner_error =
        cata::lua_platform::validate_mapgen_update_token(
            token, fixture.runtime, fixture.world );
    REQUIRE( owner_error.has_value() );
    CHECK( owner_error->code == "stale_owner" );
}

TEST_CASE( "lua_platform_overmap_tile_token_rejects_stale_runtime_world_and_owner",
           "[lua][platform][overmap]" )
{
    platform_overmap_travel_fixture fixture( 801, 31 );
    const tripoint_abs_omt avatar_omt_before = get_avatar().pos_abs_omt();
    const tripoint_abs_sm map_abs_sub_before = get_map().get_abs_sub();
    const sol::protected_function tile_token = fixture.overmap_api()["tile_token"];

    const sol::protected_function_result token_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();
    CHECK( token.native_position() == fixture.target_omt );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.world );
    CHECK( token.owner_is_current() );

    const auto check_wrong_frame = [&](
        const cata::lua_platform::script_tripoint_coord &position ) {
        const sol::protected_function_result result = tile_token( position );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "invalid_position" );
    };

    check_wrong_frame( cata::lua_platform::script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           fixture.target_omt.raw() ) );
    check_wrong_frame( cata::lua_platform::script_tripoint_coord::from_native(
                           coords::origin::relative,
                           coords::scale::overmap_terrain,
                           fixture.target_omt.raw() ) );
    const cata::lua_platform::game_handle_runtime wrong_runtime(
        fixture.owner, fixture.runtime.generation() + 1 );
    const auto wrong_runtime_error =
        cata::lua_platform::validate_overmap_tile_token(
            token, wrong_runtime, fixture.world );
    REQUIRE( wrong_runtime_error.has_value() );
    CHECK( wrong_runtime_error->code == "stale_runtime" );

    const auto wrong_world_error =
        cata::lua_platform::validate_overmap_tile_token(
            token, fixture.runtime, fixture.world + 1 );
    REQUIRE( wrong_world_error.has_value() );
    CHECK( wrong_world_error->code == "stale_world" );

    CHECK_FALSE( cata::lua_platform::validate_overmap_tile_token(
                       token, fixture.runtime, fixture.world ).has_value() );

    cata::lua_platform::reset_overmap_tile_tokens();
    CHECK_FALSE( token.owner_is_current() );
    const auto owner_error = cata::lua_platform::validate_overmap_tile_token(
                                 token, fixture.runtime, fixture.world );
    REQUIRE( owner_error.has_value() );
    CHECK( owner_error->code == "stale_owner" );

    CHECK( get_avatar().pos_abs_omt() == avatar_omt_before );
    CHECK( get_map().get_abs_sub() == map_abs_sub_before );
}

TEST_CASE( "lua_platform_overmap_travel_to_omt_requires_exact_token",
           "[lua][platform][overmap][relocation]" )
{
    platform_overmap_travel_fixture fixture( 802, 32 );
    const sol::protected_function tile_token = fixture.overmap_api()["tile_token"];
    const sol::protected_function_result token_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();
    REQUIRE_FALSE( cata::lua_platform::validate_overmap_tile_token(
                       token, fixture.runtime, fixture.world ).has_value() );

    const std::size_t avatar_identity_generation =
        fixture.avatar_handle.identity_generation();
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const tripoint_abs_omt source_omt = get_avatar().pos_abs_omt();
    const tripoint_abs_sm source_map_abs_sub = get_map().get_abs_sub();
    const sol::protected_function travel_to_omt =
        fixture.relocation_api()["travel_to_omt"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );

    const sol::protected_function_result raw_target = travel_to_omt(
            fixture.avatar_handle,
            fixture.abs_omt_position( fixture.target_omt ), strict_options );
    REQUIRE_FALSE( raw_target.valid() );
    CHECK( get_avatar().pos_abs_omt() == source_omt );
    CHECK( get_map().get_abs_sub() == source_map_abs_sub );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );

    const sol::protected_function_result moved = travel_to_omt(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["scope"].get<std::string>() == "avatar" );
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( get_avatar().pos_abs_omt() == fixture.target_omt );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );

    const cata::lua_platform::game_handle returned_handle =
        moved_value["handle"].get<cata::lua_platform::game_handle>();
    CHECK( returned_handle.identity_generation() == avatar_identity_generation );
    const std::optional<cata::lua_platform::game_handle_error> token_error =
        cata::lua_platform::validate_overmap_tile_token(
            token, fixture.runtime, fixture.world );
    CHECK_FALSE( token_error.has_value() );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = travel_to_omt(
            returned_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK( repeated_value["scope"].get<std::string>() == "avatar" );
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( get_avatar().pos_abs_omt() == fixture.target_omt );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );

    const sol::table relocation = fixture.relocation_api();
    CHECK_FALSE( relocation["overmap_at"].valid() );

    cata::lua_platform::reset_overmap_tile_tokens();
    const std::uint64_t epoch_before_stale =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result stale = travel_to_omt(
            returned_handle, token, strict_options );
    REQUIRE( stale.valid() );
    const sol::table stale_envelope = stale.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_owner" );
    CHECK( get_avatar().pos_abs_omt() == fixture.target_omt );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_stale );
}

TEST_CASE( "lua_platform_overmap_tile_edit_uses_revision_and_keeps_token_stable",
           "[lua][platform][overmap][mutation]" )
{
    platform_overmap_travel_fixture fixture( 803, 33 );
    REQUIRE( fixture.edit_ready );

    const sol::table overmap = fixture.overmap_api();
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function_result source_token_result = tile_token(
            fixture.abs_omt_position( fixture.source_omt ) );
    REQUIRE( source_token_result.valid() );
    const sol::table source_token_envelope = source_token_result.get<sol::table>();
    REQUIRE( source_token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const sol::protected_function snapshot = overmap["snapshot"];
    const sol::protected_function_result before_result = snapshot( token );
    REQUIRE( before_result.valid() );
    const sol::table before_envelope = before_result.get<sol::table>();
    REQUIRE( before_envelope["ok"].get<bool>() );
    const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
    const std::uint64_t before_revision =
        before_snapshot["revision"].get<lua_Integer>();
    const bool before_explored = before_snapshot["explored"].get<bool>();

    sol::table changes = fixture.lua.create_table();
    changes["set_explored"] = !before_explored;
    changes["set_note"] = fixture.lua.create_table_with(
                              "value", "platform edit" );
    changes["set_note_danger"] = fixture.lua.create_table_with(
                                      "dangerous", true, "radius", 3 );

    const sol::protected_function edit = overmap["edit"];
    const sol::protected_function_result committed = edit(
            token, before_revision, changes );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    const sol::table committed_value = committed_envelope["value"].get<sol::table>();
    CHECK( committed_value["accepted"].get<bool>() );
    CHECK( committed_value["changed"].get<bool>() );
    const std::uint64_t committed_revision =
        committed_value["revision"].get<lua_Integer>();
    CHECK( committed_revision == before_revision + 1 );
    const sol::table committed_snapshot =
        committed_value["snapshot"].get<sol::table>();
    CHECK( committed_snapshot["revision"].get<lua_Integer>() == committed_revision );
    CHECK( committed_snapshot["explored"].get<bool>() == !before_explored );
    CHECK( committed_snapshot["note"].get<std::string>() == "platform edit" );
    CHECK( committed_snapshot["note_dangerous"].get<bool>() );
    CHECK( committed_snapshot["note_danger_radius"].get<int>() == 3 );
    CHECK_FALSE( cata::lua_platform::validate_overmap_tile_token(
                       token, fixture.runtime, fixture.world ).has_value() );

    const sol::protected_function_result stale = edit(
            token, before_revision, changes );
    REQUIRE( stale.valid() );
    const sol::table stale_envelope = stale.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_revision" );

    const sol::protected_function_result after_stale_result = snapshot( token );
    REQUIRE( after_stale_result.valid() );
    const sol::table after_stale_envelope = after_stale_result.get<sol::table>();
    REQUIRE( after_stale_envelope["ok"].get<bool>() );
    const sol::table after_stale_snapshot =
        after_stale_envelope["value"].get<sol::table>();
    CHECK( after_stale_snapshot["revision"].get<lua_Integer>() == committed_revision );
    CHECK( after_stale_snapshot["explored"].get<bool>() ==
           committed_snapshot["explored"].get<bool>() );
    CHECK( after_stale_snapshot["note"].get<std::string>() ==
           committed_snapshot["note"].get<std::string>() );
    CHECK( after_stale_snapshot["note_dangerous"].get<bool>() ==
           committed_snapshot["note_dangerous"].get<bool>() );
    CHECK( after_stale_snapshot["note_danger_radius"].get<int>() ==
           committed_snapshot["note_danger_radius"].get<int>() );

    const sol::protected_function_result repeated = edit(
            token, committed_revision, changes );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK( repeated_value["accepted"].get<bool>() );
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["previous_revision"].get<lua_Integer>() == committed_revision );
    CHECK( repeated_value["revision"].get<lua_Integer>() == committed_revision );
}

TEST_CASE( "lua_platform_overmap_tile_edit_seen_uses_revision",
           "[lua][platform][overmap][mutation]" )
{
    platform_overmap_travel_fixture fixture( 804, 34 );
    REQUIRE( fixture.edit_ready );

    const sol::table overmap = fixture.overmap_api();
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function_result source_token_result = tile_token(
            fixture.abs_omt_position( fixture.source_omt ) );
    REQUIRE( source_token_result.valid() );
    const sol::table source_token_envelope = source_token_result.get<sol::table>();
    REQUIRE( source_token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const sol::protected_function snapshot = overmap["snapshot"];
    const sol::protected_function_result before_result = snapshot( token );
    REQUIRE( before_result.valid() );
    const sol::table before_envelope = before_result.get<sol::table>();
    REQUIRE( before_envelope["ok"].get<bool>() );
    const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
    const std::uint64_t before_revision =
        before_snapshot["revision"].get<lua_Integer>();

    const om_vision_level before_native =
        fixture.source_overmap->seen( fixture.source_local );
    const om_vision_level target =
        before_native == om_vision_level::full ?
        om_vision_level::unseen : om_vision_level::full;
    sol::table changes = fixture.lua.create_table();
    changes["set_seen"] = cata::lua_platform::script_enum_value::from(
                              "OmVisionLevel",
                              target == om_vision_level::full ? "full" : "unseen" );

    const sol::protected_function edit = overmap["edit"];
    const sol::protected_function_result committed = edit(
            token, before_revision, changes );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    const sol::table committed_value = committed_envelope["value"].get<sol::table>();
    CHECK( committed_value["changed"].get<bool>() );
    const std::uint64_t committed_revision =
        committed_value["revision"].get<lua_Integer>();
    CHECK( committed_revision == before_revision + 1 );
    CHECK( fixture.source_overmap->seen( fixture.source_local ) == target );
}

TEST_CASE( "lua_platform_overmap_tile_edit_rejects_invalid_changes_and_removes_legacy_mutators",
           "[lua][platform][overmap][mutation]" )
{
    SECTION( "invalid note/danger" )
    {
        platform_overmap_travel_fixture fixture( 805, 35 );
        REQUIRE( fixture.edit_ready );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        const std::uint64_t before_revision =
            before_snapshot["revision"].get<lua_Integer>();
        const bool before_has_note = before_snapshot["note"].is<std::string>();
        const std::string before_note = before_has_note ?
                                        before_snapshot["note"].get<std::string>() :
                                        std::string();
        const bool before_note_dangerous =
            before_snapshot["note_dangerous"].get<bool>();
        const int before_note_danger_radius =
            before_snapshot["note_danger_radius"].get<int>();

        sol::table changes = fixture.lua.create_table();
        changes["set_note"] = fixture.lua.create_table_with(
                                  "clear", true );
        changes["set_note_danger"] = fixture.lua.create_table_with(
                                          "dangerous", true, "radius", 3 );

        const sol::protected_function edit = overmap["edit"];
        const sol::protected_function_result rejected = edit(
                token, before_revision, changes );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "invalid_change" );

        const sol::protected_function_result after_result = snapshot( token );
        REQUIRE( after_result.valid() );
        const sol::table after_envelope = after_result.get<sol::table>();
        REQUIRE( after_envelope["ok"].get<bool>() );
        const sol::table after_snapshot = after_envelope["value"].get<sol::table>();
        CHECK( after_snapshot["revision"].get<lua_Integer>() == before_revision );
        CHECK( after_snapshot["note"].is<std::string>() == before_has_note );
        if( before_has_note ) {
            CHECK( after_snapshot["note"].get<std::string>() == before_note );
        }
        CHECK( after_snapshot["note_dangerous"].get<bool>() ==
               before_note_dangerous );
        CHECK( after_snapshot["note_danger_radius"].get<int>() ==
               before_note_danger_radius );
    }

    SECTION( "unknown field" )
    {
        platform_overmap_travel_fixture fixture( 806, 36 );
        REQUIRE( fixture.edit_ready );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        const std::uint64_t before_revision =
            before_snapshot["revision"].get<lua_Integer>();
        const std::string before_terrain =
            before_snapshot["terrain"].get<
                cata::lua_platform::script_game_id>().value();

        sol::table changes = fixture.lua.create_table();
        changes["unknown"] = true;

        const sol::protected_function edit = overmap["edit"];
        const sol::protected_function_result rejected = edit(
                token, before_revision, changes );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "invalid_change" );

        const sol::protected_function_result after_result = snapshot( token );
        REQUIRE( after_result.valid() );
        const sol::table after_envelope = after_result.get<sol::table>();
        REQUIRE( after_envelope["ok"].get<bool>() );
        const sol::table after_snapshot = after_envelope["value"].get<sol::table>();
        CHECK( after_snapshot["revision"].get<lua_Integer>() == before_revision );
        CHECK( after_snapshot["terrain"].get<
                   cata::lua_platform::script_game_id>().value() == before_terrain );
    }

    SECTION( "legacy mutators removed" )
    {
        platform_overmap_travel_fixture fixture( 807, 37 );
        REQUIRE( fixture.edit_ready );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        CHECK( before_snapshot["revision"].is<lua_Integer>() );

        CHECK_FALSE( overmap["set_terrain"].valid() );
        CHECK_FALSE( overmap["set_seen"].valid() );
        CHECK_FALSE( overmap["set_explored"].valid() );
        CHECK_FALSE( overmap["set_note"].valid() );
        CHECK_FALSE( overmap["set_note_danger"].valid() );
        CHECK( overmap["tile_token"].valid() );
        CHECK( overmap["snapshot"].valid() );
        CHECK( overmap["edit"].valid() );
        CHECK_FALSE( overmap["tile"].valid() );
        CHECK( overmap["reveal"].valid() );
        CHECK_FALSE( overmap["reveal_route"].valid() );
    }

    SECTION( "generated terrain" )
    {
        platform_overmap_travel_fixture fixture( 808, 38 );
        REQUIRE( fixture.edit_ready );
        REQUIRE( fixture.source_overmap->is_omt_generated( fixture.source_local ) );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        const std::uint64_t before_revision =
            before_snapshot["revision"].get<lua_Integer>();
        const cata::lua_platform::script_game_id current_terrain =
            before_snapshot["terrain"].get<cata::lua_platform::script_game_id>();
        const oter_id before_native_terrain =
            fixture.source_overmap->ter( fixture.source_local );

        const cata::lua_platform::script_game_id field(
            "overmap_terrain", "field" );
        const cata::lua_platform::script_game_id forest(
            "overmap_terrain", "forest" );
        const cata::lua_platform::script_game_id target =
            field.is_valid() && field.value() != current_terrain.value() ?
            field : forest;
        REQUIRE( target.is_valid() );
        REQUIRE( target.value() != current_terrain.value() );

        sol::table changes = fixture.lua.create_table();
        changes["set_terrain"] = target;

        const sol::protected_function edit = overmap["edit"];
        const sol::protected_function_result rejected = edit(
                token, before_revision, changes );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "already_generated" );
        CHECK( fixture.source_overmap->ter( fixture.source_local ) ==
               before_native_terrain );

        const sol::protected_function_result after_result = snapshot( token );
        REQUIRE( after_result.valid() );
        const sol::table after_envelope = after_result.get<sol::table>();
        REQUIRE( after_envelope["ok"].get<bool>() );
        const sol::table after_snapshot = after_envelope["value"].get<sol::table>();
        CHECK( after_snapshot["revision"].get<lua_Integer>() == before_revision );
        CHECK( after_snapshot["terrain"].get<
                   cata::lua_platform::script_game_id>().value() ==
               current_terrain.value() );
    }
}

TEST_CASE( "lua_platform_map_tile_rejects_mixed_coordinate_frames",
           "[lua][platform][map]" )
{
    platform_map_api_test_fixture fixture( 701, 1 );
    const sol::protected_function tile = fixture.map_api()["tile"];

    const sol::protected_function_result absolute_result = tile( fixture.position() );
    REQUIRE( absolute_result.valid() );
    const sol::table absolute_envelope = absolute_result.get<sol::table>();
    REQUIRE( absolute_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        absolute_envelope["value"].get<cata::lua_platform::map_tile_token>();
    CHECK( token.native_position() == fixture.absolute );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.active_world_generation );
    CHECK( token.owner_is_current() );

    const cata::lua_platform::script_tripoint_coord bubble_ms =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::reality_bubble,
            coords::scale::map_square,
            fixture.local.raw() );
    CHECK_FALSE( tile( bubble_ms ).valid() );

    const cata::lua_platform::script_tripoint_coord local_ms =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::reality_bubble,
            coords::scale::submap,
            tripoint_bub_sm::zero.raw() );
    CHECK_FALSE( tile( local_ms ).valid() );

    const cata::lua_platform::script_tripoint_coord omt =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            fixture.absolute.raw() );
    CHECK_FALSE( tile( omt ).valid() );

    const sol::table raw_coordinate = fixture.lua.create_table_with(
                                          "x", fixture.absolute.x(),
                                          "y", fixture.absolute.y(),
                                          "z", fixture.absolute.z() );
    CHECK_FALSE( tile( raw_coordinate ).valid() );
}

TEST_CASE( "lua_platform_map_tile_rejects_unloaded_out_of_world_and_z_mismatch",
           "[lua][platform][map]" )
{
    platform_map_api_test_fixture fixture( 702, 2 );
    const sol::protected_function tile = fixture.map_api()["tile"];

    const tripoint_abs_ms outside_world{
        std::numeric_limits<int>::max(), fixture.absolute.y(), fixture.absolute.z()
    };
    const auto outside_world_result = tile(
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            outside_world.raw() ) );
    REQUIRE( outside_world_result.valid() );
    const sol::table outside_world_envelope = outside_world_result.get<sol::table>();
    REQUIRE_FALSE( outside_world_envelope["ok"].get<bool>() );
    CHECK( outside_world_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "out_of_world" );

    const int map_width = fixture.get_map().getmapsize() * SEEX;
    const tripoint_abs_ms outside_bubble = fixture.absolute +
            tripoint_rel_ms( map_width, 0, 0 );
    const auto unloaded_result = tile(
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            outside_bubble.raw() ) );
    REQUIRE( unloaded_result.valid() );
    const sol::table unloaded_envelope = unloaded_result.get<sol::table>();
    REQUIRE_FALSE( unloaded_envelope["ok"].get<bool>() );
    const std::string unloaded_code = unloaded_envelope["error"].get<sol::table>()
                                      ["code"].get<std::string>();
    CHECK( ( unloaded_code == "unloaded" || unloaded_code == "out_of_world" ) );

    const int current_z = fixture.get_map().get_abs_sub().z();
    const int mismatched_z = fixture.get_map().supports_zlevels() ?
                             OVERMAP_HEIGHT + 1 :
                             ( current_z == OVERMAP_HEIGHT ? current_z - 1 : current_z + 1 );
    const tripoint_abs_ms z_mismatch{
        fixture.absolute.x(), fixture.absolute.y(), mismatched_z
    };
    const auto z_result = tile(
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            z_mismatch.raw() ) );
    REQUIRE( z_result.valid() );
    const sol::table z_envelope = z_result.get<sol::table>();
    REQUIRE_FALSE( z_envelope["ok"].get<bool>() );
    const std::string z_code = z_envelope["error"].get<sol::table>()
                               ["code"].get<std::string>();
    CHECK( ( z_code == "z_unloaded" || z_code == "unloaded" ||
             z_code == "out_of_world" ) );
}

TEST_CASE( "lua_platform_map_tile_snapshot_is_bounded_and_detached",
           "[lua][platform][map]" )
{
    platform_map_api_test_fixture fixture( 703, 3 );
    map &here = fixture.get_map();
    REQUIRE( here.add_field( fixture.local, fd_smoke.id(), 1, 0_turns, false ) );

    const sol::table map_api = fixture.map_api();
    const sol::protected_function tile = map_api["tile"];
    const sol::protected_function snapshot = map_api["snapshot"];
    const sol::protected_function_result tile_result = tile( fixture.position() );
    REQUIRE( tile_result.valid() );
    const sol::table tile_envelope = tile_result.get<sol::table>();
    REQUIRE( tile_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        tile_envelope["value"].get<cata::lua_platform::map_tile_token>();

    const sol::protected_function_result first_result = snapshot( token );
    REQUIRE( first_result.valid() );
    const sol::table first_envelope = first_result.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_value = first_envelope["value"].get<sol::table>();
    const std::string first_terrain = first_value["terrain"].get<
                                      cata::lua_platform::script_game_id>().value();
    const sol::table first_fields = first_value["fields"].get<sol::table>();
    CHECK( first_fields["returned"].get<std::size_t>() == 1 );
    const sol::table vehicle_part = first_value["vehicle_part"].get<sol::table>();
    REQUIRE( vehicle_part.valid() );
    CHECK_FALSE( vehicle_part["present"].get<bool>() );
    CHECK_FALSE( vehicle_part["handle"].valid() );
    CHECK( ( first_value["item_count"].is<std::size_t>() ||
             first_value["item_count"].is<lua_Integer>() ) );

    const sol::table bounded_options = fixture.lua.create_table_with(
                                            "field_limit", 0,
                                            "signage_limit", 0 );
    const sol::protected_function_result bounded_result =
        snapshot( token, bounded_options );
    REQUIRE( bounded_result.valid() );
    const sol::table bounded_envelope = bounded_result.get<sol::table>();
    REQUIRE( bounded_envelope["ok"].get<bool>() );
    const sol::table bounded_value = bounded_envelope["value"].get<sol::table>();
    const sol::table bounded_fields = bounded_value["fields"].get<sol::table>();
    CHECK( bounded_fields["returned"].get<std::size_t>() == 0 );
    CHECK( bounded_fields["truncated"].get<bool>() );
    CHECK( bounded_value["signage"].get<std::string>().empty() );

    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    const ter_id original_terrain = here.ter( fixture.local );
    const ter_id replacement = original_terrain == floor_id.id() ?
                               wall_id.id() : floor_id.id();
    REQUIRE( here.ter_set( fixture.local, replacement ) );
    here.clear_fields( fixture.local );

    const sol::protected_function_result after_result = snapshot( token );
    REQUIRE( after_result.valid() );
    const sol::table after_envelope = after_result.get<sol::table>();
    REQUIRE( after_envelope["ok"].get<bool>() );
    const sol::table after_value = after_envelope["value"].get<sol::table>();
    CHECK( after_value["terrain"].get<
               cata::lua_platform::script_game_id>().value() != first_terrain );
    CHECK( first_value["terrain"].get<
               cata::lua_platform::script_game_id>().value() == first_terrain );
    CHECK( first_value["fields"].get<sol::table>()
           ["returned"].get<std::size_t>() == 1 );
}

TEST_CASE( "lua_platform_map_tile_edits_are_atomic_and_rollback",
           "[lua][platform][map][mutation]" )
{
    platform_map_api_test_fixture fixture( 704, 4 );
    map &here = fixture.get_map();
    const sol::table map_api = fixture.map_api();
    const sol::protected_function tile = map_api["tile"];
    const sol::protected_function edit = map_api["edit"];
    const sol::protected_function_result tile_result = tile( fixture.position() );
    REQUIRE( tile_result.valid() );
    const sol::table tile_envelope = tile_result.get<sol::table>();
    REQUIRE( tile_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        tile_envelope["value"].get<cata::lua_platform::map_tile_token>();
    const sol::protected_function snapshot = map_api["snapshot"];
    const sol::protected_function_result snapshot_result = snapshot( token );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot_envelope = snapshot_result.get<sol::table>();
    REQUIRE( snapshot_envelope["ok"].get<bool>() );
    const std::uint64_t revision = snapshot_envelope["value"].get<sol::table>()
                                   ["revision"].get<lua_Integer>();
    const ter_id original_terrain = here.ter( fixture.local );

    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    const ter_str_id target_id = original_terrain == floor_id.id() ?
                                 wall_id : floor_id;
    const cata::lua_platform::script_game_id target_game_id(
        "terrain", target_id.str() );

    sol::table invalid_field = fixture.lua.create_table_with(
                                   "id", cata::lua_platform::script_game_id(
                                             "field", "fd_smoke" ),
                                   "intensity", fd_smoke.obj().get_max_intensity() + 1 );
    sol::table invalid_fields = fixture.lua.create_table();
    invalid_fields[1] = std::move( invalid_field );
    sol::table invalid_changes = fixture.lua.create_table();
    invalid_changes["terrain"] = target_game_id;
    invalid_changes["fields"] = std::move( invalid_fields );

    fixture.write_called = false;
    const sol::protected_function_result rejected = edit(
        token, revision, invalid_changes );
    CHECK_FALSE( rejected.valid() );
    CHECK( fixture.write_called );
    CHECK( here.ter( fixture.local ) == original_terrain );
    CHECK( cata::lua_platform::map_mutation_epoch() == revision );

    sol::table valid_changes = fixture.lua.create_table();
    valid_changes["terrain"] = target_game_id;
    const sol::protected_function_result conflict = edit(
        token, revision + 1, valid_changes );
    REQUIRE( conflict.valid() );
    const sol::table conflict_envelope = conflict.get<sol::table>();
    REQUIRE_FALSE( conflict_envelope["ok"].get<bool>() );
    CHECK( conflict_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "revision_conflict" );
    CHECK( here.ter( fixture.local ) == original_terrain );
    CHECK( cata::lua_platform::map_mutation_epoch() == revision );

    const sol::protected_function_result committed = edit(
        token, revision, valid_changes );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    CHECK( here.ter( fixture.local ) == target_id.id() );
    CHECK( cata::lua_platform::map_mutation_epoch() == revision + 1 );
}

TEST_CASE( "lua_platform_map_tile_never_uses_avatar_or_nearest_fallback",
           "[lua][platform][map][contract]" )
{
    platform_map_api_test_fixture fixture( 705, 5 );
    const sol::table map_api = fixture.map_api();
    const std::set<std::string> expected = { "edit", "snapshot", "tile" };
    std::set<std::string> exposed;
    for( const auto &entry : map_api ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK_FALSE( map_api["avatar"].valid() );
    CHECK_FALSE( map_api["current"].valid() );
    CHECK_FALSE( map_api["nearest"].valid() );

    const sol::protected_function tile = map_api["tile"];
    CHECK_FALSE( tile().valid() );
    const sol::table raw_coordinate = fixture.lua.create_table_with(
                                          "x", fixture.absolute.x(),
                                          "y", fixture.absolute.y(),
                                          "z", fixture.absolute.z() );
    CHECK_FALSE( tile( raw_coordinate ).valid() );

    const sol::protected_function snapshot = map_api["snapshot"];
    CHECK_FALSE( snapshot().valid() );
    const sol::protected_function edit = map_api["edit"];
    CHECK_FALSE( edit().valid() );
}

TEST_CASE( "lua_platform_map_holder_page_and_transfer_require_the_same_token",
           "[lua][platform][map][items]" )
{
    platform_map_api_test_fixture fixture( 706, 6 );
    map &here = fixture.get_map();
    const tripoint_bub_ms destination_local{
        fixture.local.x() + 1, fixture.local.y(), fixture.local.z()
    };
    REQUIRE( here.inbounds( destination_local ) );

    item &source_item = here.add_item(
                            fixture.local, item( itype_id( "rock" ), calendar::turn_zero ) );
    REQUIRE( !source_item.is_null() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result source_tile_result =
        tile( fixture.position() );
    REQUIRE( source_tile_result.valid() );
    REQUIRE( source_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token source_token =
        source_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function_result destination_tile_result =
        tile( fixture.position( destination_local ) );
    REQUIRE( destination_tile_result.valid() );
    REQUIRE( destination_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token destination_token =
        destination_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();

    const sol::table source_holder = fixture.map_holder( source_token );
    const sol::table destination_holder = fixture.map_holder( destination_token );
    const sol::protected_function page = fixture.item_api()["page"];
    const sol::table page_options = fixture.lua.create_table_with(
                                        "page_size", 1,
                                        "max_depth", 0,
                                        "recursive", false );
    const sol::protected_function_result page_result = page(
        source_holder, page_options );
    REQUIRE( page_result.valid() );
    const sol::table page_envelope = page_result.get<sol::table>();
    REQUIRE( page_envelope["ok"].get<bool>() );
    const sol::table page_value = page_envelope["value"];
    REQUIRE( page_value["returned"].get<lua_Integer>() == 1 );
    const cata::lua_platform::game_handle item_handle =
        page_value["items"].get<sol::table>()[1]["handle"]
        .get<cata::lua_platform::game_handle>();
    CHECK( item_handle.locator().scope == "map" );
    CHECK( item_handle.locator().owner_generation ==
           source_token.owner_generation() );

    sol::table bare_position_holder = fixture.lua.create_table_with(
                                           "kind", "map_tile",
                                           "position", fixture.position() );
    CHECK_FALSE( page( bare_position_holder, page_options ).valid() );
    sol::table typed_but_wrong_frame_holder = fixture.lua.create_table_with(
                                                  "kind", "map_tile" );
    typed_but_wrong_frame_holder["tile"] =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::reality_bubble, coords::scale::map_square,
            fixture.local.raw() );
    CHECK_FALSE( page( typed_but_wrong_frame_holder, page_options ).valid() );

    const auto different_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime different_runtime(
        different_owner, fixture.runtime.generation() + 1 );
    fixture.active_runtime = different_runtime;
    const sol::protected_function_result stale_destination_result = tile(
        fixture.position( destination_local ) );
    REQUIRE( stale_destination_result.valid() );
    REQUIRE( stale_destination_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token stale_destination_token =
        stale_destination_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    fixture.active_runtime = fixture.runtime;

    const sol::table stale_destination_holder = fixture.map_holder(
        stale_destination_token );
    const std::uint64_t item_epoch_before_failure =
        cata::lua_platform::item_holder_mutation_generation();
    const std::uint64_t map_epoch_before_failure =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function transfer = fixture.item_api()["transfer"];
    const sol::protected_function_result stale_transfer = transfer(
        item_handle, source_holder, stale_destination_holder );
    REQUIRE( stale_transfer.valid() );
    const sol::table stale_transfer_envelope = stale_transfer.get<sol::table>();
    REQUIRE_FALSE( stale_transfer_envelope["ok"].get<bool>() );
    CHECK( stale_transfer_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() == map_epoch_before_failure );

    const sol::protected_function_result committed = transfer(
        item_handle, source_holder, destination_holder );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    CHECK( committed_envelope["value"].get<sol::table>()
           ["source_handle_stale"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() > map_epoch_before_failure );
    CHECK( here.i_at( destination_local ).size() == 1 );
    CHECK( here.i_at( fixture.local ).size() == 0 );
}

TEST_CASE( "lua_platform_map_mutation_invalidates_token_cursor_and_quote",
           "[lua][platform][map][items][stale]" )
{
    platform_trade_quote_fixture trade_fixture( 707, 607, 126001, 126002 );
    REQUIRE( trade_fixture.ready() );
    const sol::protected_function_result quote_result = trade_fixture.quote( 3 );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token quote_token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    platform_map_api_test_fixture fixture( 708, 7 );
    map &here = fixture.get_map();
    const tripoint_bub_ms destination_local{
        fixture.local.x() + 1, fixture.local.y(), fixture.local.z()
    };
    REQUIRE( here.inbounds( destination_local ) );
    item &first = here.add_item(
                       fixture.local, item( itype_id( "rock" ), calendar::turn_zero ) );
    item &second = here.add_item(
                        fixture.local, item( itype_id( "knife" ), calendar::turn_zero ) );
    REQUIRE( !first.is_null() );
    REQUIRE( !second.is_null() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result source_tile_result =
        tile( fixture.position() );
    REQUIRE( source_tile_result.valid() );
    REQUIRE( source_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token source_token =
        source_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function_result destination_tile_result =
        tile( fixture.position( destination_local ) );
    REQUIRE( destination_tile_result.valid() );
    REQUIRE( destination_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token destination_token =
        destination_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::table source_holder = fixture.map_holder( source_token );
    const sol::table destination_holder = fixture.map_holder( destination_token );

    const sol::table page_options = fixture.lua.create_table_with(
                                        "page_size", 1,
                                        "max_depth", 0,
                                        "recursive", false );
    const sol::protected_function page = fixture.item_api()["page"];
    const sol::protected_function_result page_result = page(
        source_holder, page_options );
    REQUIRE( page_result.valid() );
    const sol::table page_envelope = page_result.get<sol::table>();
    REQUIRE( page_envelope["ok"].get<bool>() );
    const sol::table page_value = page_envelope["value"];
    REQUIRE_FALSE( page_value["complete"].get<bool>() );
    const sol::table continuation = page_value["continuation"];
    REQUIRE( continuation.valid() );
    const cata::lua_platform::game_handle item_handle =
        page_value["items"].get<sol::table>()[1]["handle"]
        .get<cata::lua_platform::game_handle>();

    const auto different_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime different_runtime(
        different_owner, fixture.runtime.generation() + 1 );
    fixture.active_runtime = different_runtime;
    const sol::protected_function_result stale_destination_result = tile(
        fixture.position( destination_local ) );
    REQUIRE( stale_destination_result.valid() );
    REQUIRE( stale_destination_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token stale_destination_token =
        stale_destination_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    fixture.active_runtime = fixture.runtime;

    const sol::table stale_destination_holder = fixture.map_holder(
        stale_destination_token );
    const std::uint64_t item_epoch_before_failure =
        cata::lua_platform::item_holder_mutation_generation();
    const std::uint64_t map_epoch_before_failure =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function transfer = fixture.item_api()["transfer"];
    const sol::protected_function_result failed_transfer = transfer(
        item_handle, source_holder, stale_destination_holder );
    REQUIRE( failed_transfer.valid() );
    REQUIRE_FALSE( failed_transfer.get<sol::table>()["ok"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() == map_epoch_before_failure );

    const sol::protected_function_result still_live_quote =
        trade_fixture.get( quote_token );
    REQUIRE( still_live_quote.valid() );
    REQUIRE( still_live_quote.get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result committed = transfer(
        item_handle, source_holder, destination_holder );
    REQUIRE( committed.valid() );
    REQUIRE( committed.get<sol::table>()["ok"].get<bool>() );
    CHECK( source_token.owner_is_current() );
    const sol::protected_function_result token_snapshot =
        fixture.map_api()["snapshot"]( source_token );
    REQUIRE( token_snapshot.valid() );
    REQUIRE( token_snapshot.get<sol::table>()["ok"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() > map_epoch_before_failure );

    const sol::protected_function_result stale_cursor = page(
        source_holder, page_options, continuation );
    REQUIRE( stale_cursor.valid() );
    const sol::table stale_cursor_envelope = stale_cursor.get<sol::table>();
    REQUIRE_FALSE( stale_cursor_envelope["ok"].get<bool>() );
    CHECK( stale_cursor_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_continuation" );

    const sol::protected_function_result stale_quote =
        trade_fixture.get( quote_token );
    REQUIRE( stale_quote.valid() );
    const sol::table stale_quote_envelope = stale_quote.get<sol::table>();
    REQUIRE_FALSE( stale_quote_envelope["ok"].get<bool>() );
    CHECK( stale_quote_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_holder" );
}

TEST_CASE( "lua_platform_relocation_moves_monster_with_explicit_token",
           "[lua][platform][relocation][monster]" )
{
    platform_monster_relocation_fixture fixture( 709, 8 );
    REQUIRE( fixture.test_monster );
    const std::int64_t monster_uid = fixture.test_monster->uid().get_value();
    REQUIRE( monster_uid > 0 );
    CHECK( fixture.monster_handle.locator().stable_id == monster_uid );
    map &here = fixture.get_map();
    const ter_str_id floor_id( "t_floor" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( here.ter_set( fixture.local, floor_id.id() ) );
    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table force_options = fixture.lua.create_table_with(
                                         "force", true );
    CHECK_FALSE( move( fixture.monster_handle, token, force_options ).valid() );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );

    avatar other_avatar;
    const cata::lua_platform::game_handle avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            other_avatar, { "avatar", 1, 0, 0, 0, {} },
            fixture.runtime, fixture.active_world_generation );
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const sol::protected_function_result unsupported = move(
            avatar_handle, token, strict_options );
    REQUIRE( unsupported.valid() );
    const sol::table unsupported_envelope = unsupported.get<sol::table>();
    REQUIRE_FALSE( unsupported_envelope["ok"].get<bool>() );
    CHECK( unsupported_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "unsupported" );

    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.monster_handle.identity_generation();
    const sol::protected_function_result moved = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( moved_value["scope"].get<std::string>() == "monster" );
    CHECK( fixture.test_monster->pos_abs() == fixture.target_abs );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.monster_handle.identity_generation() == identity_generation );
    CHECK( fixture.write_called );

    const tripoint_abs_ms committed_position = fixture.test_monster->pos_abs();
    const shared_ptr_fast<monster> committed_tracker =
        get_creature_tracker().find( fixture.target_abs );
    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["scope"].get<std::string>() == "monster" );
    CHECK( fixture.test_monster->pos_abs() == committed_position );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           committed_tracker.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
}

TEST_CASE( "lua_platform_relocation_moves_npc_with_explicit_token",
           "[lua][platform][relocation][npc]" )
{
    platform_npc_relocation_fixture fixture( 717, 16 );
    REQUIRE( fixture.test_npc );
    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.npc_handle.identity_generation();
    const sol::protected_function_result moved = move(
            fixture.npc_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( moved_value["scope"].get<std::string>() == "npc" );
    CHECK( fixture.test_npc->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.npc_handle.identity_generation() == identity_generation );
    CHECK( g->find_npc( fixture.npc_id ) == fixture.test_npc );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            fixture.npc_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["scope"].get<std::string>() == "npc" );
    CHECK( fixture.test_npc->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
}

TEST_CASE( "lua_platform_relocation_moves_vehicle_with_explicit_token_and_preserves_part_identity",
           "[lua][platform][relocation][vehicle]" )
{
    platform_vehicle_relocation_fixture fixture( 726, 25 );
    REQUIRE( fixture.test_vehicle );
    REQUIRE( fixture.live_part );
    REQUIRE( fixture.vehicle_handle.kind() ==
             cata::lua_platform::game_handle_kind::vehicle );
    REQUIRE( fixture.vehicle_part_handle.kind() ==
             cata::lua_platform::game_handle_kind::vehicle_part );
    REQUIRE_FALSE( fixture.vehicle_handle.validation_error(
                       fixture.runtime, fixture.active_world_generation ) );
    REQUIRE_FALSE( fixture.vehicle_part_handle.validation_error(
                       fixture.runtime, fixture.active_world_generation ) );

    const std::size_t vehicle_identity_generation =
        fixture.vehicle_handle.identity_generation();
    const std::size_t part_identity_generation =
        fixture.vehicle_part_handle.identity_generation();
    const auto part_uid = fixture.live_part->get_base().uid().get_value();

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result moved = move(
            fixture.vehicle_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["scope"].get<std::string>() == "vehicle" );
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( fixture.test_vehicle->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );

    const cata::lua_platform::game_handle new_vehicle_handle =
        moved_value["handle"].get<cata::lua_platform::game_handle>();
    CHECK( new_vehicle_handle.identity_generation() ==
           vehicle_identity_generation );
    const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
        new_vehicle_handle.resolve_vehicle(
            fixture.runtime, fixture.active_world_generation );
    REQUIRE( static_cast<bool>( resolved_vehicle ) );
    CHECK( resolved_vehicle.value == fixture.test_vehicle );
    CHECK( resolved_vehicle.value->pos_abs() == fixture.target_abs );

    CHECK( fixture.vehicle_part_handle.identity_generation() ==
           part_identity_generation );
    const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
        fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
            new_vehicle_handle, fixture.runtime,
            fixture.active_world_generation );
    REQUIRE( static_cast<bool>( resolved_part ) );
    CHECK( resolved_part.value == fixture.live_part );
    CHECK( resolved_part.value->get_base().uid().get_value() == part_uid );
    CHECK( token.owner_is_current() );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            new_vehicle_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK( repeated_value["scope"].get<std::string>() == "vehicle" );
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( fixture.test_vehicle->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
    CHECK( token.owner_is_current() );
}

TEST_CASE( "lua_platform_relocation_rejects_vehicle_footprint_collisions_without_mutation",
           "[lua][platform][relocation][vehicle]" )
{
    SECTION( "terrain/furniture collision" ) {
        platform_vehicle_relocation_fixture fixture( 727, 26 );
        REQUIRE( fixture.test_vehicle );
        REQUIRE( fixture.live_part );

        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const std::size_t part_identity_generation =
            fixture.vehicle_part_handle.identity_generation();

        map &here = fixture.get_map();
        const ter_str_id wall_id( "t_wall" );
        REQUIRE( wall_id.is_valid() );
        REQUIRE( here.ter_set( fixture.target_local, wall_id.id() ) );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result blocked = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( blocked.valid() );
        const sol::table blocked_envelope = blocked.get<sol::table>();
        REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
        CHECK( blocked_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "blocked" );

        CHECK( fixture.test_vehicle->pos_abs() == fixture.source_abs );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );
        CHECK( fixture.vehicle_part_handle.identity_generation() ==
               part_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
        const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
            fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
                fixture.vehicle_handle, fixture.runtime,
                fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_part ) );
        CHECK( resolved_part.value == fixture.live_part );
    }

    SECTION( "Creature collision" ) {
        platform_vehicle_relocation_fixture fixture( 728, 27 );
        REQUIRE( fixture.test_vehicle );
        REQUIRE( fixture.live_part );

        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const std::size_t part_identity_generation =
            fixture.vehicle_part_handle.identity_generation();
        const shared_ptr_fast<monster> occupant = fixture.add_monster(
                fixture.target_local );
        REQUIRE( occupant );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result blocked = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( blocked.valid() );
        const sol::table blocked_envelope = blocked.get<sol::table>();
        REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
        CHECK( blocked_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "blocked" );

        CHECK( fixture.test_vehicle->pos_abs() == fixture.source_abs );
        CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
               occupant.get() );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );
        CHECK( fixture.vehicle_part_handle.identity_generation() ==
               part_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
        const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
            fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
                fixture.vehicle_handle, fixture.runtime,
                fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_part ) );
        CHECK( resolved_part.value == fixture.live_part );
    }

    SECTION( "other Vehicle collision" ) {
        platform_vehicle_relocation_fixture fixture( 729, 28 );
        REQUIRE( fixture.test_vehicle );
        REQUIRE( fixture.live_part );

        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const std::size_t part_identity_generation =
            fixture.vehicle_part_handle.identity_generation();
        REQUIRE( fixture.add_target_blocker_vehicle() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result blocked = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( blocked.valid() );
        const sol::table blocked_envelope = blocked.get<sol::table>();
        REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
        CHECK( blocked_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "blocked" );

        CHECK( fixture.test_vehicle->pos_abs() == fixture.source_abs );
        CHECK( fixture.target_blocker_vehicle->pos_abs() == fixture.target_abs );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );
        CHECK( fixture.vehicle_part_handle.identity_generation() ==
               part_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
        const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
            fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
                fixture.vehicle_handle, fixture.runtime,
                fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_part ) );
        CHECK( resolved_part.value == fixture.live_part );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_unloaded_inactive_npc_without_mutation",
           "[lua][platform][relocation][npc]" )
{
    SECTION( "stale token" ) {
        platform_npc_relocation_fixture fixture( 718, 17 );
        REQUIRE( fixture.test_npc );
        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        cata::lua_platform::reset_map_tile_tokens();

        const sol::protected_function_result stale = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( stale.valid() );
        const sol::table stale_envelope = stale.get<sol::table>();
        REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
        CHECK( stale_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_token" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "unloaded/inactive" ) {
        platform_npc_relocation_fixture fixture( 719, 18 );
        REQUIRE( fixture.test_npc );
        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const cata::lua_platform::game_handle npc_handle = fixture.npc_handle;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        clear_npcs();
        CHECK( g->find_npc( npc_id ) == nullptr );

        const sol::protected_function_result rejected = move(
                npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_coupled_npc_states_and_preserves_registration",
           "[lua][platform][relocation][npc][state]" )
{
    SECTION( "in_vehicle" ) {
        platform_npc_relocation_fixture fixture( 720, 19 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->in_vehicle = true;

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "active activity" ) {
        platform_npc_relocation_fixture fixture( 721, 20 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->activity = player_activity( meditate_activity_actor() );
        REQUIRE( fixture.test_npc->activity );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "riding effect" ) {
        platform_npc_relocation_fixture fixture( 722, 21 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->add_effect( efftype_id( "riding" ), 1_turns );
        REQUIRE( fixture.test_npc->has_effect( efftype_id( "riding" ) ) );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "companion mission role" ) {
        platform_npc_relocation_fixture fixture( 723, 22 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->companion_mission_role_id =
            std::string( "test_companion_mission_role" );
        REQUIRE_FALSE( fixture.test_npc->companion_mission_role_id.empty() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "assigned camp" ) {
        platform_npc_relocation_fixture fixture( 724, 23 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->assigned_camp = tripoint_abs_omt{ 1, 2, 0 };
        REQUIRE( fixture.test_npc->assigned_camp.has_value() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "marked for death" ) {
        platform_npc_relocation_fixture fixture( 725, 24 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->marked_for_death = true;
        REQUIRE( fixture.test_npc->marked_for_death );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_blocked_occupied_z_and_unloaded",
           "[lua][platform][relocation][monster]" )
{
    platform_monster_relocation_fixture fixture( 710, 9 );
    REQUIRE( fixture.test_monster );
    map &here = fixture.get_map();
    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    REQUIRE( token_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();

    REQUIRE( here.ter_set( fixture.target_local, wall_id.id() ) );
    const sol::protected_function_result blocked = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( blocked.valid() );
    const sol::table blocked_envelope = blocked.get<sol::table>();
    REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
    CHECK( blocked_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "blocked" );

    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );
    const shared_ptr_fast<monster> occupant = fixture.add_monster(
            fixture.target_local );
    REQUIRE( occupant );
    const sol::protected_function_result occupied = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( occupied.valid() );
    const sol::table occupied_envelope = occupied.get<sol::table>();
    REQUIRE_FALSE( occupied_envelope["ok"].get<bool>() );
    CHECK( occupied_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "occupied" );
    get_creature_tracker().remove( *occupant );

    const int current_z = here.get_abs_sub().z();
    const int other_z = current_z == OVERMAP_HEIGHT ?
                        current_z - 1 : current_z + 1;
    const tripoint_abs_ms z_position{
        fixture.target_abs.x(), fixture.target_abs.y(), other_z
    };
    const sol::protected_function_result z_token_result = tile(
            fixture.position( z_position ) );
    REQUIRE( z_token_result.valid() );
    const sol::table z_token_envelope = z_token_result.get<sol::table>();
    REQUIRE( z_token_envelope["ok"].is<bool>() );
    if( z_token_envelope["ok"].get<bool>() ) {
        const cata::lua_platform::map_tile_token z_token =
            z_token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        const sol::protected_function_result z_result = move(
                fixture.monster_handle, z_token, strict_options );
        REQUIRE( z_result.valid() );
        const sol::table z_envelope = z_result.get<sol::table>();
        REQUIRE_FALSE( z_envelope["ok"].get<bool>() );
        CHECK( z_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "z_mismatch" );
    } else {
        const std::string z_code = z_token_envelope["error"]
                                   .get<sol::table>()["code"].get<std::string>();
        CHECK( ( z_code == "z_unloaded" || z_code == "unloaded" ||
                 z_code == "out_of_world" ) );
    }

    const int map_width = here.getmapsize() * SEEX;
    const tripoint_abs_ms unloaded_position = fixture.source_abs +
            tripoint_rel_ms( map_width, 0, 0 );
    const sol::protected_function_result unloaded = tile(
            fixture.position( unloaded_position ) );
    REQUIRE( unloaded.valid() );
    const sol::table unloaded_envelope = unloaded.get<sol::table>();
    REQUIRE_FALSE( unloaded_envelope["ok"].get<bool>() );
    const std::string unloaded_code = unloaded_envelope["error"]
                                      .get<sol::table>()["code"].get<std::string>();
    CHECK( ( unloaded_code == "unloaded" || unloaded_code == "out_of_world" ) );

    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );

    const std::uint64_t epoch_before_vehicle =
        cata::lua_platform::map_mutation_epoch();
    vehicle *vehicle_occupant = here.add_vehicle(
                                    vehicle_prototype_test_shopping_cart,
                                    fixture.target_local, 0_degrees, 0,
                                    veh_spawn_status::UNDAMAGED );
    REQUIRE( vehicle_occupant );
    const sol::protected_function_result vehicle_occupied = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( vehicle_occupied.valid() );
    const sol::table vehicle_occupied_envelope =
        vehicle_occupied.get<sol::table>();
    REQUIRE_FALSE( vehicle_occupied_envelope["ok"].get<bool>() );
    CHECK( vehicle_occupied_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "vehicle_occupied" );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_vehicle );

    const tripoint_abs_ms stale_position = fixture.test_monster->pos_abs();
    const shared_ptr_fast<monster> stale_source_tracker =
        get_creature_tracker().find( fixture.source_abs );
    const shared_ptr_fast<monster> stale_target_tracker =
        get_creature_tracker().find( fixture.target_abs );
    const std::uint64_t epoch_before_stale_token =
        cata::lua_platform::map_mutation_epoch();
    cata::lua_platform::reset_map_tile_tokens();
    const sol::protected_function_result stale_token_result = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( stale_token_result.valid() );
    const sol::table stale_token_envelope =
        stale_token_result.get<sol::table>();
    REQUIRE_FALSE( stale_token_envelope["ok"].get<bool>() );
    CHECK( stale_token_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_token" );
    CHECK( fixture.test_monster->pos_abs() == stale_position );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           stale_source_tracker.get() );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           stale_target_tracker.get() );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_stale_token );
}

TEST_CASE( "lua_platform_relocation_rolls_back_and_updates_tracker_atomically",
           "[lua][platform][relocation][monster][rollback]" )
{
    platform_monster_relocation_fixture fixture( 711, 10 );
    REQUIRE( fixture.test_monster );
    map &here = fixture.get_map();
    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    REQUIRE( token_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.monster_handle.identity_generation();
    const std::int64_t monster_uid = fixture.test_monster->uid().get_value();
    REQUIRE( monster_uid > 0 );
    CHECK( fixture.monster_handle.locator().stable_id == monster_uid );

    get_creature_tracker().remove( *fixture.test_monster );
    const sol::protected_function_result stale_tracker = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( stale_tracker.valid() );
    const sol::table stale_tracker_envelope = stale_tracker.get<sol::table>();
    REQUIRE_FALSE( stale_tracker_envelope["ok"].get<bool>() );
    CHECK( stale_tracker_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_tracker" );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    REQUIRE( get_creature_tracker().add( fixture.test_monster ) );
    CHECK( fixture.test_monster->uid().get_value() == monster_uid );
    CHECK( fixture.monster_handle.locator().stable_id == monster_uid );
    CHECK( get_creature_tracker().find_by_uid( monster_uid ).get() ==
           fixture.test_monster.get() );

    REQUIRE( here.ter_set( fixture.target_local, wall_id.id() ) );
    const sol::protected_function_result blocked = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( blocked.valid() );
    REQUIRE_FALSE( blocked.get<sol::table>()["ok"].get<bool>() );
    CHECK( blocked.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "blocked" );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );

    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );
    const sol::protected_function_result committed = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( committed.valid() );
    REQUIRE( committed.get<sol::table>()["ok"].get<bool>() );
    CHECK( fixture.test_monster->pos_abs() == fixture.target_abs );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.monster_handle.identity_generation() == identity_generation );
}

TEST_CASE( "lua_platform_relocation_moves_avatar_with_explicit_token",
           "[lua][platform][relocation][avatar]" )
{
    platform_avatar_relocation_fixture fixture( 712, 11 );
    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.avatar_handle.identity_generation();
    const sol::protected_function_result moved = move(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["scope"].get<std::string>() == "avatar" );
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( get_avatar().pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.avatar_handle.identity_generation() == identity_generation );
    CHECK( token.owner_is_current() );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["scope"].get<std::string>() == "avatar" );
    CHECK( get_avatar().pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
    CHECK( token.owner_is_current() );
}

TEST_CASE( "lua_platform_relocation_avatar_never_loads_map_or_uses_fallback",
           "[lua][platform][relocation][avatar][contract]" )
{
    platform_avatar_relocation_fixture fixture( 713, 12 );
    map &here = fixture.get_map();
    const auto map_origin_before = here.get_abs_sub();
    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const sol::table relocation = fixture.relocation_api();
    CHECK_FALSE( relocation["current"].valid() );
    CHECK_FALSE( relocation["nearest"].valid() );
    CHECK_FALSE( relocation["raw"].valid() );
    CHECK_FALSE( relocation["raw_coordinate"].valid() );
    CHECK_FALSE( relocation["x"].valid() );
    CHECK_FALSE( relocation["y"].valid() );
    CHECK_FALSE( relocation["z"].valid() );

    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const tripoint_abs_ms position_before = get_avatar().pos_abs();
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const shared_ptr_fast<monster> occupant = fixture.add_monster(
            fixture.target_local );
    REQUIRE( occupant );
    const sol::protected_function_result occupied = move(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( occupied.valid() );
    const sol::table occupied_envelope = occupied.get<sol::table>();
    REQUIRE_FALSE( occupied_envelope["ok"].get<bool>() );
    CHECK( occupied_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "occupied" );
    CHECK( get_avatar().pos_abs() == position_before );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    CHECK( here.get_abs_sub() == map_origin_before );
    get_creature_tracker().remove( *occupant );

    const sol::protected_function_result stale_token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( stale_token_result.valid() );
    const sol::table stale_token_envelope = stale_token_result.get<sol::table>();
    REQUIRE( stale_token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token stale_token =
        stale_token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( stale_token.owner_is_current() );

    const tripoint_abs_ms stale_position = get_avatar().pos_abs();
    const std::uint64_t epoch_before_stale_token =
        cata::lua_platform::map_mutation_epoch();
    const auto map_origin_before_stale_token = here.get_abs_sub();
    cata::lua_platform::reset_map_tile_tokens();
    const sol::protected_function_result stale = move(
            fixture.avatar_handle, stale_token, strict_options );
    REQUIRE( stale.valid() );
    const sol::table stale_envelope = stale.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_token" );
    CHECK( get_avatar().pos_abs() == stale_position );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_stale_token );
    CHECK( here.get_abs_sub() == map_origin_before );
    CHECK( here.get_abs_sub() == map_origin_before_stale_token );
}

TEST_CASE( "lua_platform_relocation_rejects_coupled_avatar_states",
           "[lua][platform][relocation][avatar][state]" )
{
    const auto check_rejected = []( platform_avatar_relocation_fixture &fixture ) {
        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms position_before = get_avatar().pos_abs();
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.avatar_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( get_avatar().pos_abs() == position_before );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    };

    SECTION( "in_vehicle" ) {
        platform_avatar_relocation_fixture fixture( 714, 13 );
        get_avatar().in_vehicle = true;
        check_rejected( fixture );
    }

    SECTION( "grab" ) {
        platform_avatar_relocation_fixture fixture( 715, 14 );
        get_avatar().grab( object_type::VEHICLE, tripoint_rel_ms::east );
        check_rejected( fixture );
    }

    SECTION( "hauling" ) {
        platform_avatar_relocation_fixture fixture( 716, 15 );
        get_avatar().hauling = true;
        check_rejected( fixture );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_vehicle_coupled_states_without_mutation",
           "[lua][platform][relocation][vehicle][state]" )
{
    const auto check_rejected = []( platform_vehicle_relocation_fixture &fixture ) {
        REQUIRE( fixture.test_vehicle );
        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const tripoint_abs_ms source_anchor = fixture.test_vehicle->pos_abs();

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( fixture.test_vehicle->pos_abs() == source_anchor );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
    };

    SECTION( "active remote" ) {
        platform_vehicle_relocation_fixture fixture( 730, 29 );
        REQUIRE( fixture.test_vehicle );
        g->setremoteveh( fixture.test_vehicle );
        REQUIRE( g->remoteveh() == fixture.test_vehicle );
        check_rejected( fixture );
    }

    SECTION( "avatar vehicle grab" ) {
        platform_vehicle_relocation_fixture fixture( 731, 30 );
        REQUIRE( fixture.test_vehicle );
        clear_avatar();
        avatar &player = get_avatar();
        const tripoint_bub_ms avatar_local =
            fixture.source_local + tripoint_rel_ms( -1, 0, 0 );
        player.setpos( fixture.get_map(), avatar_local );
        const tripoint_rel_ms grab_point = fixture.source_local - avatar_local;
        player.grab( object_type::VEHICLE, grab_point );
        REQUIRE( player.get_grab_type() == object_type::VEHICLE );
        REQUIRE( player.grab_point == grab_point );
        const optional_vpart_position grabbed_vehicle = fixture.get_map().veh_at(
                player.pos_bub() + player.grab_point );
        REQUIRE( grabbed_vehicle );
        REQUIRE( &grabbed_vehicle->vehicle() == fixture.test_vehicle );
        check_rejected( fixture );
    }

    SECTION( "boarded rider" ) {
        platform_vehicle_relocation_fixture fixture( 732, 31 );
        REQUIRE( fixture.test_vehicle );
        clear_avatar();
        avatar &player = get_avatar();
        map &here = fixture.get_map();
        player.setpos( here, fixture.source_local, false );
        static const vpart_id seat( "seat" );
        REQUIRE( fixture.test_vehicle->install_part(
                     here, point_rel_ms::zero, seat ) >= 0 );
        here.add_vehicle_to_cache( fixture.test_vehicle );
        here.board_vehicle( fixture.source_local, &player );
        REQUIRE( player.in_vehicle );
        REQUIRE_FALSE( fixture.test_vehicle->boarded_parts().empty() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const tripoint_abs_ms source_anchor = fixture.test_vehicle->pos_abs();
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const sol::protected_function_result rejected = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( fixture.test_vehicle->pos_abs() == source_anchor );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );

        here.unboard_vehicle( fixture.source_local );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
