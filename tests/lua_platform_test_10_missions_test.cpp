#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <character_id.h>
#include <coordinates.h>
#include <dialogue_chatbin.h>
#include "debug.h"
#include "flexbuffer_json.h"
#include <game.h>
#include <json.h>
#include <lua_platform_bindings_values.h>
#include <lua_platform_dialogue.h>
#include <lua_platform_handle.h>
#include <lua_platform_missions.h>
#include <lua_platform_npcs.h>
#include <map.h>
#include <map_helpers.h>
#include <mission.h>
#include <npc_opinion.h>
#include <point.h>
#include <talker.h>
#include <type_id.h>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "condition.h"
#include "dialogue.h"
#include "json_loader.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "npc.h"
#include "npctalk.h"

static const mission_type_id mission_TEST_MISSION_GENERIC_REWARD( "TEST_MISSION_GENERIC_REWARD" );
static const mission_type_id mission_TEST_MISSION_GOAL_CONDITION1( "TEST_MISSION_GOAL_CONDITION1" );
static const npc_template_id npc_template_test_talker( "test_talker" );

TEST_CASE( "lua_platform_mission_tokens_reject_replacement_and_stale_context",
           "[lua][platform][missions]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
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
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
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

TEST_CASE( "lua_platform_active_mission_pages_preserve_native_order_and_tokens",
           "[lua][platform][missions]" )
{
    avatar owner;
    owner.normalize();
    owner.setID( character_id( 7301 ), true );
    owner.reset_all_missions();
    mission::clear_all();
    struct mission_test_cleanup {
        avatar &owner;
        ~mission_test_cleanup() {
            owner.reset_all_missions();
            mission::clear_all();
        }
    } cleanup{ owner };

    mission *first_uid = mission::reserve_new(
                             mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    mission *second_uid = mission::reserve_new(
                              mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    REQUIRE( first_uid != nullptr );
    REQUIRE( second_uid != nullptr );
    // Reverse assignment order from UID order. Native finish/remove effects
    // use the active vector's first matching mission, not the sorted UID list.
    second_uid->assign( owner );
    first_uid->assign( owner );
    const std::vector<mission *> native_order =
        owner.get_active_missions();
    REQUIRE( native_order.size() == 2 );
    CHECK( native_order[0] == second_uid );
    CHECK( native_order[1] == first_uid );

    const cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 64 );
    std::size_t active_world = 22;
    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [runtime]() {
        return runtime;
    };
    const auto current_world = [&active_world]() {
        return active_world;
    };
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_game_handle_api(
    lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_mission_api(
    services, current_runtime, current_world, []() {}, []() {} );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            owner,
    { "avatar", owner.getID().get_value(), 0, 0, 0, {} },
    runtime, active_world );

    const sol::table missions = services["missions"];
    const sol::protected_function active = missions["active"];
    REQUIRE( active.valid() );
    sol::table first_options = lua.create_table();
    first_options["limit"] = 1;
    const sol::protected_function_result first_result =
        active( owner_handle, first_options );
    REQUIRE( first_result.valid() );
    const sol::table first_page = first_result.get<sol::table>();
    CHECK( first_page["total"].get<std::size_t>() == 2 );
    CHECK( first_page["returned"].get<std::size_t>() == 1 );
    CHECK( first_page["has_more"].get<bool>() );
    const sol::table first_items = first_page["items"];
    const sol::table first_item = first_items[1];
    const cata::lua_platform::mission_token first_token =
        first_item["token"].get <
        cata::lua_platform::mission_token > ();
    CHECK( first_token.uid() == second_uid->get_id() );

    sol::table second_options = lua.create_table();
    second_options["offset"] = 1;
    second_options["limit"] = 1;
    const sol::protected_function_result second_result =
        active( owner_handle, second_options );
    REQUIRE( second_result.valid() );
    const sol::table second_page = second_result.get<sol::table>();
    const sol::table second_items = second_page["items"];
    const sol::table second_item = second_items[1];
    CHECK( second_page["total"].get<std::size_t>() == 2 );
    CHECK( second_page["offset"].get<std::size_t>() == 1 );
    CHECK_FALSE( second_page["has_more"].get<bool>() );
    CHECK( second_item["token"].get <
           cata::lua_platform::mission_token > ().uid() ==
           first_uid->get_id() );

    CHECK_FALSE( second_uid->is_complete( character_id(), owner ) );
    const sol::protected_function finish = missions["finish"];
    REQUIRE( finish.valid() );
    const sol::protected_function_result finish_result =
        finish( owner_handle, first_token );
    REQUIRE( finish_result.valid() );
    const sol::table finish_envelope = finish_result.get<sol::table>();
    REQUIRE( finish_envelope["ok"].get<bool>() );
    CHECK( finish_envelope["value"].get<sol::table>()
           ["after"].get<sol::table>()
           ["status"].get<std::string>() == "success" );
    const std::vector<mission *> after_finish = owner.get_active_missions();
    REQUIRE( after_finish.size() == 1 );
    CHECK( after_finish[0] == first_uid );

    sol::table zero_limit = lua.create_table();
    zero_limit["limit"] = 0;
    CHECK_FALSE( active( owner_handle, zero_limit ).valid() );

    active_world = 23;
    const sol::protected_function get = missions["get"];
    const sol::protected_function_result stale_token_result =
        get( first_token );
    REQUIRE( stale_token_result.valid() );
    const sol::table stale_token = stale_token_result.get<sol::table>();
    CHECK_FALSE( stale_token["ok"].get<bool>() );
    CHECK( stale_token["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_world" );
}

TEST_CASE( "lua_platform_mission_abandon_matches_native_remove_first_match",
           "[lua][platform][missions]" )
{
    avatar platform_owner;
    avatar native_owner;
    platform_owner.normalize();
    platform_owner.setID( character_id( 7310 ), true );
    native_owner.normalize();
    native_owner.setID( character_id( 7311 ), true );
    platform_owner.reset_all_missions();
    native_owner.reset_all_missions();
    mission::clear_all();
    struct mission_test_cleanup {
        avatar &platform_owner;
        avatar &native_owner;
        ~mission_test_cleanup() {
            platform_owner.reset_all_missions();
            native_owner.reset_all_missions();
            mission::clear_all();
        }
    } cleanup{ platform_owner, native_owner };

    mission *platform_first = mission::reserve_new(
                                  mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    mission *platform_second = mission::reserve_new(
                                   mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    mission *native_first = mission::reserve_new(
                                mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    mission *native_second = mission::reserve_new(
                                 mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    REQUIRE( platform_first != nullptr );
    REQUIRE( platform_second != nullptr );
    REQUIRE( native_first != nullptr );
    REQUIRE( native_second != nullptr );
    // Both active vectors begin with the later UID, matching the ordering
    // used by the native remove_active_mission effect's first-match loop.
    platform_second->assign( platform_owner );
    platform_first->assign( platform_owner );
    native_second->assign( native_owner );
    native_first->assign( native_owner );

    const std::vector<mission *> native_before =
        native_owner.get_active_missions();
    REQUIRE( native_before.size() == 2 );
    CHECK( native_before.front() == native_second );
    for( mission *entry : native_before ) {
        if( entry->mission_id() == mission_TEST_MISSION_GOAL_CONDITION1 ) {
            native_owner.remove_active_mission( *entry );
            break;
        }
    }

    const cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 67 );
    std::size_t active_world = 26;
    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [runtime]() {
        return runtime;
    };
    const auto current_world = [&active_world]() {
        return active_world;
    };
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_game_handle_api(
    lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_mission_api(
    services, current_runtime, current_world, []() {}, []() {} );
    const cata::lua_platform::game_handle owner_handle =
        cata::lua_platform::game_handle::from_creature(
            platform_owner,
    { "avatar", platform_owner.getID().get_value(), 0, 0, 0, {} },
    runtime, active_world );

    const sol::table missions = services["missions"];
    const sol::protected_function active = missions["active"];
    const sol::protected_function abandon = missions["abandon"];
    const sol::protected_function finish = missions["finish"];
    const sol::protected_function fail = missions["fail"];
    REQUIRE( active.valid() );
    REQUIRE( abandon.valid() );
    REQUIRE( finish.valid() );
    REQUIRE( fail.valid() );

    const sol::protected_function_result first_page_result =
        active( owner_handle );
    REQUIRE( first_page_result.valid() );
    const sol::table first_page = first_page_result.get<sol::table>();
    REQUIRE( first_page["total"].get<std::size_t>() == 2 );
    const sol::table first_item = first_page["items"].get<sol::table>()[1];
    const cata::lua_platform::mission_token first_token =
        first_item["token"].get<cata::lua_platform::mission_token>();
    CHECK( first_token.uid() == platform_second->get_id() );

    const sol::protected_function_result abandon_result =
        abandon( owner_handle, first_token );
    REQUIRE( abandon_result.valid() );
    const sol::table abandon_envelope = abandon_result.get<sol::table>();
    REQUIRE( abandon_envelope["ok"].get<bool>() );
    const sol::table abandoned =
        abandon_envelope["value"].get<sol::table>();
    CHECK( abandoned["abandoned"].get<sol::table>()
           ["uid"].get<int>() == first_token.uid() );
    CHECK( abandoned["removed"].get<bool>() );
    const std::vector<mission *> native_after_abandon =
        native_owner.get_active_missions();
    const std::vector<mission *> platform_after_abandon =
        platform_owner.get_active_missions();
    REQUIRE( native_after_abandon.size() == 1 );
    REQUIRE( platform_after_abandon.size() == 1 );
    CHECK( native_after_abandon.front() == native_first );
    CHECK( platform_after_abandon.front() == platform_first );
    CHECK( native_after_abandon.front()->mission_id() ==
           platform_after_abandon.front()->mission_id() );

    const sol::protected_function_result repeat_abandon_result =
        abandon( owner_handle, first_token );
    REQUIRE( repeat_abandon_result.valid() );
    const sol::table repeat_abandon =
        repeat_abandon_result.get<sol::table>();
    CHECK_FALSE( repeat_abandon["ok"].get<bool>() );
    CHECK( repeat_abandon["error"].get<sol::table>()
           ["code"].get<std::string>() == "missing_mission" );

    const sol::protected_function_result remaining_page_result =
        active( owner_handle );
    REQUIRE( remaining_page_result.valid() );
    const sol::table remaining_page =
        remaining_page_result.get<sol::table>();
    const cata::lua_platform::mission_token remaining_token =
        remaining_page["items"].get<sol::table>()[1].get<sol::table>()
        ["token"].get<cata::lua_platform::mission_token>();
    CHECK( remaining_token.uid() == platform_first->get_id() );

    const sol::protected_function_result finish_result =
        finish( owner_handle, remaining_token );
    REQUIRE( finish_result.valid() );
    CHECK( finish_result.get<sol::table>()["ok"].get<bool>() );
    native_first->wrap_up( native_owner );
    CHECK( platform_owner.get_active_missions().empty() );
    CHECK( native_owner.get_active_missions().empty() );
    CHECK( platform_first->is_complete( character_id(), platform_owner ) );
    CHECK( native_first->is_complete( character_id(), native_owner ) );

    const sol::protected_function_result abandon_completed_result =
        abandon( owner_handle, remaining_token );
    REQUIRE( abandon_completed_result.valid() );
    const sol::table abandon_completed =
        abandon_completed_result.get<sol::table>();
    CHECK_FALSE( abandon_completed["ok"].get<bool>() );
    CHECK( abandon_completed["error"].get<sol::table>()
           ["code"].get<std::string>() == "not_active" );

    mission *platform_failed = mission::reserve_new(
                                   mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    mission *native_failed = mission::reserve_new(
                                 mission_TEST_MISSION_GOAL_CONDITION1, character_id() );
    REQUIRE( platform_failed != nullptr );
    REQUIRE( native_failed != nullptr );
    platform_failed->assign( platform_owner );
    native_failed->assign( native_owner );
    const sol::protected_function_result failed_page_result =
        active( owner_handle );
    REQUIRE( failed_page_result.valid() );
    const sol::table failed_page = failed_page_result.get<sol::table>();
    const cata::lua_platform::mission_token failed_token =
        failed_page["items"].get<sol::table>()[1].get<sol::table>()
        ["token"].get<cata::lua_platform::mission_token>();
    CHECK( failed_token.uid() == platform_failed->get_id() );

    const sol::protected_function_result fail_result =
        fail( owner_handle, failed_token );
    REQUIRE( fail_result.valid() );
    CHECK( fail_result.get<sol::table>()["ok"].get<bool>() );
    native_failed->fail( native_owner );
    CHECK( platform_owner.get_active_missions().empty() );
    CHECK( native_owner.get_active_missions().empty() );
    CHECK( platform_failed->has_failed() );
    CHECK( native_failed->has_failed() );
    const sol::protected_function_result abandon_failed_result =
        abandon( owner_handle, failed_token );
    REQUIRE( abandon_failed_result.valid() );
    const sol::table abandon_failed =
        abandon_failed_result.get<sol::table>();
    CHECK_FALSE( abandon_failed["ok"].get<bool>() );
    CHECK( abandon_failed["error"].get<sol::table>()
           ["code"].get<std::string>() == "not_active" );
}

TEST_CASE( "lua_platform_npc_mission_provider_preflights_exact_owner_and_rollback",
           "[lua][platform][missions][npc]" )
{
    const cata::lua_platform::game_handle_runtime_owner_ptr owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
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
    const cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
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
    []() {
        return world_generation;
    }, []() {} );
    cata::lua_platform::install_npc_api(
        services,
    [runtime]() {
        return runtime;
    },
    []() {
        return world_generation;
    }, []() {}, []() {}, []() {} );

    const sol::table npcs = services["npcs"];
    REQUIRE( npcs.valid() );
    const sol::table missions = npcs["missions"];
    REQUIRE( missions.valid() );
    for( const char *name : {
             "state", "assigned_for_owner", "available_count",
             "selected_condition", "selected_has_goal",
             "selected_has_generic_rewards", "select", "offer",
             "add_assigned",
             "assign_selected", "succeed_selected", "fail_selected",
             "clear_selected", "claim_selected_reward",
             "open_selected_reward_trade"
         } ) {
        CHECK( missions[name].get_type() == sol::type::function );
    }

    CHECK_FALSE( missions["avatar"].valid() );
    CHECK_FALSE( missions["current_avatar"].valid() );
    CHECK_FALSE( missions["current_mission"].valid() );
    CHECK_FALSE( npcs["avatar"].valid() );
}

TEST_CASE( "lua_platform_npc_mission_reward_calls_native_no_selection_path",
           "[lua][platform][missions][npc][semantic]" )
{
    avatar &active_avatar = get_avatar();
    npc provider;
    provider.normalize();
    provider.setID( character_id( 7391 ), true );
    provider.chatbin.mission_selected = nullptr;

    const cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime(
        runtime_owner, 66 );
    constexpr std::size_t world_generation = 24;
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [runtime]() {
        return runtime;
    };
    const auto current_world = []() {
        return world_generation;
    };
    cata::lua_platform::install_game_handle_api(
    lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_npc_api(
    services, current_runtime, current_world, []() {}, [&]() {
        write_gate_called = true;
    }, []() {} );
    const cata::lua_platform::game_handle provider_handle =
        cata::lua_platform::game_handle::from_creature(
            provider, { "npc", provider.getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const cata::lua_platform::game_handle active_avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            active_avatar,
    { "avatar", active_avatar.getID().get_value(), 0, 0, 0, {} },
    runtime, world_generation );
    const sol::table npc_services = services["npcs"];
    const sol::table mission_services = npc_services["missions"];
    const sol::protected_function open_reward_trade =
        mission_services["open_selected_reward_trade"];
    const int debt_before = provider.op_of_u.owed;

    // The no-selection branch avoids opening the native barter UI, allowing a
    // direct comparison that the typed operation delegates to WRAP behavior.
    const std::string native_diagnostic = capture_debugmsg_during( [&]() {
        talk_function::mission_reward( provider );
    } );
    CHECK( native_diagnostic.find( "Called mission_reward with null mission" ) != std::string::npos );
    CHECK( provider.op_of_u.owed == debt_before );
    sol::protected_function_result result;
    const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
        result = open_reward_trade( provider_handle, active_avatar_handle );
    } );
    CHECK( platform_diagnostic == native_diagnostic );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    CHECK( envelope["value"].get<bool>() );
    CHECK( provider.chatbin.mission_selected == nullptr );
    CHECK( provider.op_of_u.owed == debt_before );
    CHECK( write_gate_called );

    avatar other_avatar;
    other_avatar.normalize();
    other_avatar.setID( character_id( 7392 ), true );
    const cata::lua_platform::game_handle other_avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            other_avatar, { "avatar", 7392, 0, 0, 0, {} },
            runtime, world_generation );
    sol::protected_function_result unsupported = open_reward_trade(
                provider_handle, other_avatar_handle );
    REQUIRE( unsupported.valid() );
    const sol::table unsupported_envelope = unsupported.get<sol::table>();
    CHECK_FALSE( unsupported_envelope["ok"].get<bool>() );
    CHECK( unsupported_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "unsupported_participants" );
    CHECK( provider.chatbin.mission_selected == nullptr );
    CHECK( provider.op_of_u.owed == debt_before );
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
                                         npc_template_test_talker );
    g->load_npcs();
    npc *provider = g->find_npc( provider_id );
    REQUIRE( provider != nullptr );
    provider->chatbin.missions.clear();
    provider->chatbin.missions_assigned.clear();
    provider->chatbin.mission_selected = nullptr;

    const cata::lua_platform::game_handle_runtime_owner_ptr runtime_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime_owner_ptr other_runtime_owner =
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
    const sol::protected_function has_active_mission =
        services["missions"]["has_active"];
    const sol::protected_function state = missions["state"];
    const sol::protected_function assigned_for_owner =
        missions["assigned_for_owner"];
    const sol::protected_function available_count =
        missions["available_count"];
    const sol::protected_function selected_condition =
        missions["selected_condition"];
    const sol::protected_function selected_has_goal =
        missions["selected_has_goal"];
    const sol::protected_function selected_has_generic_rewards =
        missions["selected_has_generic_rewards"];
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
    const auto integer_from = []( sol::protected_function_result result ) {
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        return envelope["value"].get<int>();
    };
    const auto boolean_from = []( sol::protected_function_result result ) {
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        return envelope["value"].get<bool>();
    };
    const conditional_t native_generic_rewards_condition(
        "mission_has_generic_rewards" );
    dialogue reward_dialogue(
        get_talker_for( owner ), get_talker_for( *provider ) );
    const auto compare_selected_generic_rewards = [&]() {
        const bool native_result = native_generic_rewards_condition(
                                       reward_dialogue );
        const bool platform_result = boolean_from(
                                         selected_has_generic_rewards(
                                             provider_handle ) );
        CHECK( native_result == platform_result );
    };

    const sol::protected_function npc_snapshot = services["npcs"]["get"];
    CHECK( value_from( npc_snapshot( provider_handle ) )["assigned_missions_value"].get<int>() == 0 );
    sol::table initial_state = value_from( state( provider_handle ) );
    CHECK( initial_state["provider_id"].get<int>() == provider_id.get_value() );
    CHECK( initial_state["available"].get<sol::table>()
           ["returned"].get<int>() == 0 );
    CHECK( initial_state["assigned"].get<sol::table>()
           ["returned"].get<int>() == 0 );
    CHECK( integer_from( available_count( provider_handle ) ) == 0 );
    CHECK_FALSE( boolean_from( has_active_mission( owner_handle, mission_id ) ) );
    for( const char *predicate : {
             "complete", "incomplete", "failed"
         } ) {
        CHECK_FALSE( boolean_from( selected_condition(
                                       provider_handle, owner_handle, predicate ) ) );
    }
    CHECK_FALSE( boolean_from( selected_has_goal(
                                   provider_handle, "MGOAL_CONDITION" ) ) );
    CHECK_FALSE( boolean_from( selected_has_goal(
                                   provider_handle, "NOT_A_MISSION_GOAL" ) ) );
    CHECK( boolean_from( selected_has_generic_rewards( provider_handle ) ) );
    CHECK( error_code( selected_condition(
                           provider_handle, owner_handle, "unknown" ) ) ==
           "invalid_predicate" );
    sol::table initial_owner_missions = value_from(
                                            assigned_for_owner( provider_handle, owner_handle ) );
    CHECK( initial_owner_missions["total"].get<int>() == 0 );

    sol::table offer_value = value_from( offer( provider_handle, mission_id ) );
    const cata::lua_platform::mission_token offered_token =
        offer_value["mission"].get<sol::table>()
        ["token"].get<cata::lua_platform::mission_token>();
    CHECK( provider->chatbin.missions.size() == 1 );
    CHECK( integer_from( available_count( provider_handle ) ) == 1 );

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
    CHECK( boolean_from( selected_has_goal(
                             provider_handle, "MGOAL_CONDITION" ) ) );
    CHECK_FALSE( boolean_from( selected_has_goal(
                                   provider_handle, "MGOAL_ASSASSINATE" ) ) );
    CHECK( error_code( selected_has_goal(
                           provider_handle, "NOT_A_MISSION_GOAL" ) ) ==
           "invalid_mission_goal" );
    CHECK( boolean_from( selected_has_generic_rewards( provider_handle ) ) );
    // Native mission_has_generic_rewards reads beta's current selected
    // mission; compare the live mission result against the typed query.
    compare_selected_generic_rewards();
    CHECK( error_code( add_assigned(
                           provider_handle, stale_owner_handle, mission_id ) ) ==
           "stale_runtime" );
    CHECK( error_code( selected_condition(
                           provider_handle, stale_owner_handle, "failed" ) ) ==
           "stale_runtime" );
    CHECK( provider->chatbin.missions.size() == 1 );
    CHECK( provider->chatbin.missions_assigned.empty() );

    value_from( assign_selected( provider_handle, owner_handle ) );
    CHECK( provider->chatbin.missions.empty() );
    CHECK( provider->chatbin.missions_assigned.size() == 1 );
    CHECK( integer_from( available_count( provider_handle ) ) == 0 );
    CHECK( owner.get_active_missions().size() == 1 );
    CHECK( boolean_from( has_active_mission( owner_handle, mission_id ) ) );
    sol::table one_owner_assignment = value_from(
                                          assigned_for_owner( provider_handle, owner_handle ) );
    CHECK( one_owner_assignment["total"].get<int>() == 1 );
    CHECK( value_from( npc_snapshot( provider_handle ) )["assigned_missions_value"].get<int>() == 125 );
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
    sol::table active_selected_state = value_from( state( provider_handle ) );
    CHECK( active_selected_state["selected"].get<sol::table>()
           ["status"].get<std::string>() == "active" );
    CHECK_FALSE( boolean_from( selected_condition(
                                   provider_handle, owner_handle, "complete" ) ) );
    CHECK( boolean_from( selected_condition(
                             provider_handle, owner_handle, "incomplete" ) ) );
    CHECK_FALSE( boolean_from( selected_condition(
                                   provider_handle, owner_handle, "failed" ) ) );

    sol::table success_value = value_from(
                                   succeed_selected(
                                       provider_handle, owner_handle, true ) );
    CHECK( success_value["action"].get<std::string>() == "success" );
    CHECK_FALSE( provider->chatbin.mission_selected->in_progress() );
    sol::table successful_selected_state = value_from( state( provider_handle ) );
    CHECK( successful_selected_state["selected"].get<sol::table>()
           ["status"].get<std::string>() == "success" );
    CHECK( boolean_from( selected_condition(
                             provider_handle, owner_handle, "complete" ) ) );
    CHECK_FALSE( boolean_from( selected_condition(
                                   provider_handle, owner_handle, "incomplete" ) ) );
    CHECK_FALSE( boolean_from( selected_condition(
                                   provider_handle, owner_handle, "failed" ) ) );
    CHECK( value_from( npc_snapshot( provider_handle ) )["assigned_missions_value"].get<int>() == 125 );
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
    CHECK( value_from( npc_snapshot( provider_handle ) )["assigned_missions_value"].get<int>() == 0 );
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
    CHECK_FALSE( boolean_from( selected_has_generic_rewards( provider_handle ) ) );
    compare_selected_generic_rewards();
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
    sol::table failed_selected_state = value_from( state( provider_handle ) );
    CHECK( failed_selected_state["selected"].get<sol::table>()
           ["status"].get<std::string>() == "failure" );
    CHECK_FALSE( boolean_from( selected_condition(
                                   provider_handle, owner_handle, "complete" ) ) );
    CHECK( boolean_from( selected_condition(
                             provider_handle, owner_handle, "incomplete" ) ) );
    CHECK( boolean_from( selected_condition(
                             provider_handle, owner_handle, "failed" ) ) );
    value_from( clear_selected( provider_handle, owner_handle ) );
    CHECK( provider->chatbin.missions_assigned.empty() );

    mission *owned_for_dialogue = mission::reserve_new(
                                      mission_TEST_MISSION_GOAL_CONDITION1,
                                      provider->getID() );
    REQUIRE( owned_for_dialogue != nullptr );
    owned_for_dialogue->set_assigned_player_id( owner.getID() );
    mission *second_owned_for_dialogue = mission::reserve_new(
            mission_TEST_MISSION_GOAL_CONDITION1,
            provider->getID() );
    REQUIRE( second_owned_for_dialogue != nullptr );
    second_owned_for_dialogue->set_assigned_player_id( owner.getID() );
    mission *owned_by_other = mission::reserve_new(
                                  mission_TEST_MISSION_GOAL_CONDITION1,
                                  provider->getID() );
    REQUIRE( owned_by_other != nullptr );
    owned_by_other->set_assigned_player_id( wrong_owner.getID() );
    provider->chatbin.missions_assigned = {
        owned_for_dialogue, second_owned_for_dialogue, owned_by_other
    };
    CHECK( value_from( state( provider_handle ) )["assigned"].get<sol::table>()
           ["total"].get<int>() == 3 );
    sol::table filtered_owner_missions = value_from(
            assigned_for_owner( provider_handle, owner_handle ) );
    CHECK( filtered_owner_missions["total"].get<int>() == 2 );
    CHECK( filtered_owner_missions["items"].get<sol::table>()[1].get<sol::table>()
           ["uid"].get<int>() == owned_for_dialogue->get_id() );
    CHECK( value_from( assigned_for_owner( provider_handle, wrong_owner_handle ) )
           ["total"].get<int>() == 1 );

    dialogue mission_dialogue(
        get_talker_for( owner ), get_talker_for( *provider ) );
    mission_dialogue.missions_assigned = {
        owned_for_dialogue, second_owned_for_dialogue
    };
    const conditional_t no_available_mission( "has_no_available_mission" );
    const conditional_t one_available_mission( "has_available_mission" );
    const conditional_t many_available_missions( "has_many_available_missions" );
    const conditional_t npc_no_available_mission( "npc_has_no_available_mission" );
    const conditional_t npc_one_available_mission( "npc_has_available_mission" );
    const conditional_t npc_many_available_missions( "npc_has_many_available_missions" );
    const auto check_available_count = [&]( const std::size_t expected ) {
        const std::size_t native_count =
            mission_dialogue.const_actor( true )->available_missions().size();
        CHECK( native_count == expected );
        CHECK( static_cast<std::size_t>( integer_from( available_count( provider_handle ) ) ) ==
               native_count );
        CHECK( no_available_mission( mission_dialogue ) == ( native_count == 0 ) );
        CHECK( one_available_mission( mission_dialogue ) == ( native_count == 1 ) );
        CHECK( many_available_missions( mission_dialogue ) == ( native_count >= 2 ) );
        CHECK( npc_no_available_mission( mission_dialogue ) == ( native_count == 0 ) );
        CHECK( npc_one_available_mission( mission_dialogue ) == ( native_count == 1 ) );
        CHECK( npc_many_available_missions( mission_dialogue ) == ( native_count >= 2 ) );
    };
    provider->chatbin.missions.clear();
    check_available_count( 0 );
    provider->chatbin.missions.push_back( owned_for_dialogue );
    check_available_count( 1 );
    provider->chatbin.missions.push_back( second_owned_for_dialogue );
    check_available_count( 2 );
    provider->chatbin.missions.clear();

    using dialogue_context = cata::lua_platform::dialogue::context;
    const cata::lua_platform::dialogue::dialogue_session_ptr mission_session =
        cata::lua_platform::dialogue::begin_session(
            mission_dialogue, runtime, active_world );
    REQUIRE( mission_session != nullptr );
    const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
        cata::lua_platform::dialogue::session_for(
            mission_dialogue, "TALK_MISSION_INQUIRE", runtime, active_world );
    REQUIRE( topic_session == mission_session );
    dialogue_context mission_context(
        nullptr, mission_dialogue, "TALK_MISSION_INQUIRE", false,
        "dialogue context is stale", {}, topic_session, runtime, active_world );
    REQUIRE( mission_context.valid() );
    lua.open_libraries( sol::lib::base );
    sol::table platform_api = lua.create_table();
    cata::lua_platform::detail::install_runtime_dialogue_presentation_api(
        {}, lua, platform_api );
    lua["mission_dialogue_context"] = &mission_context;

    const conditional_t no_assigned_mission( "has_no_assigned_mission" );
    const conditional_t one_assigned_mission( "has_assigned_mission" );
    const conditional_t many_assigned_missions( "has_many_assigned_missions" );
    const auto check_assigned_count = [&]( const std::size_t expected ) {
        CHECK( mission_context.assigned_mission_count() == expected );
        const sol::protected_function_result lua_count = lua.safe_script(
                    "return mission_dialogue_context:assigned_mission_count()" );
        REQUIRE( lua_count.valid() );
        CHECK( lua_count.get<std::size_t>() == expected );
        CHECK( no_assigned_mission( mission_dialogue ) == ( expected == 0 ) );
        CHECK( one_assigned_mission( mission_dialogue ) == ( expected == 1 ) );
        CHECK( many_assigned_missions( mission_dialogue ) == ( expected >= 2 ) );
    };
    check_assigned_count( 2 );

    // A live provider query follows chatbin storage. The response callback
    // reads the alpha-filtered vector already captured by this dialogue.
    provider->chatbin.missions_assigned.erase(
        provider->chatbin.missions_assigned.begin() + 1 );
    CHECK( value_from( assigned_for_owner( provider_handle, owner_handle ) )
           ["total"].get<int>() == 1 );
    check_assigned_count( 2 );

    mission_dialogue.missions_assigned.resize( 1 );
    check_assigned_count( 1 );
    mission_dialogue.missions_assigned.clear();
    check_assigned_count( 0 );
    cata::lua_platform::dialogue::end_session( mission_dialogue );
    CHECK_THROWS( mission_context.assigned_mission_count() );
    const sol::protected_function_result stale_lua_count = lua.safe_script(
                "return mission_dialogue_context:assigned_mission_count()", sol::script_pass_on_error );
    CHECK_FALSE( stale_lua_count.valid() );

    provider->chatbin.missions_assigned = {
        owned_for_dialogue, second_owned_for_dialogue, owned_by_other
    };
    provider->chatbin.mission_selected = owned_by_other;
    CHECK( value_from( state( provider_handle ) )["selected"].get<sol::table>()
           ["uid"].get<int>() == owned_by_other->get_id() );
    avatar &current_avatar = get_avatar();
    const cata::lua_platform::game_handle current_avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            current_avatar,
    { "avatar", current_avatar.getID().get_value(), 0, 0, 0, {} },
    runtime, active_world );
    dialogue selected_mission_dialogue(
        get_talker_for( current_avatar ), get_talker_for( *provider ) );
    const conditional_t mission_complete( "mission_complete" );
    const conditional_t npc_mission_complete( "npc_mission_complete" );
    const conditional_t mission_incomplete( "mission_incomplete" );
    const conditional_t npc_mission_incomplete( "npc_mission_incomplete" );
    const conditional_t mission_failed( "mission_failed" );
    const conditional_t npc_mission_failed( "npc_mission_failed" );
    const conditional_t mission_goal( json_loader::from_string(
                                          R"({"mission_goal":"MGOAL_CONDITION"})" )
                                      .get_object() );
    const conditional_t npc_mission_goal( json_loader::from_string(
            R"({"npc_mission_goal":"MGOAL_CONDITION"})" )
                                          .get_object() );
    // Native mission status aliases select beta's mission; complete/incomplete
    // then evaluate it with get_avatar(), which is the explicit service owner.
    const auto compare_selected_status = [&]( const char *predicate,
    const conditional_t &native_condition ) {
        CHECK( native_condition( selected_mission_dialogue ) ==
               boolean_from( selected_condition(
                                 provider_handle, current_avatar_handle,
                                 predicate ) ) );
    };
    const auto check_selected_conditions = [&]() {
        compare_selected_status( "complete", mission_complete );
        compare_selected_status( "complete", npc_mission_complete );
        compare_selected_status( "incomplete", mission_incomplete );
        compare_selected_status( "incomplete", npc_mission_incomplete );
        compare_selected_status( "failed", mission_failed );
        compare_selected_status( "failed", npc_mission_failed );
        const bool api_goal = boolean_from(
                                  selected_has_goal( provider_handle,
                                          "MGOAL_CONDITION" ) );
        CHECK( mission_goal( selected_mission_dialogue ) == api_goal );
        CHECK( npc_mission_goal( selected_mission_dialogue ) == api_goal );
    };
    check_selected_conditions();

    // Compare the native status selectors after lifecycle transitions as
    // well as while the beta's selected mission is still reserved.
    const auto make_selected_for_owner = [&]( const mission_type_id & type ) {
        mission *selected = mission::reserve_new( type, provider->getID() );
        REQUIRE( selected != nullptr );
        selected->set_assigned_player_id( character_id() );
        if( selected->get_assigned_player_id() == current_avatar.getID() ) {
            selected->set_assigned_player_id( character_id( -2 ) );
        }
        provider->chatbin.missions_assigned.push_back( selected );
        provider->chatbin.mission_selected = selected;
        selected->assign( wrong_owner );
        return selected;
    };
    mission *successful_for_dialogue = make_selected_for_owner(
                                           mission_TEST_MISSION_GOAL_CONDITION1 );
    successful_for_dialogue->wrap_up( wrong_owner );
    check_selected_conditions();
    CHECK( mission_complete( selected_mission_dialogue ) );
    CHECK_FALSE( mission_failed( selected_mission_dialogue ) );
    CHECK( mission_goal( selected_mission_dialogue ) );
    mission *failed_for_dialogue = make_selected_for_owner(
                                       mission_TEST_MISSION_GOAL_CONDITION1 );
    failed_for_dialogue->fail( wrong_owner );
    check_selected_conditions();
    CHECK( mission_failed( selected_mission_dialogue ) );
    CHECK( mission_goal( selected_mission_dialogue ) );

    const conditional_t alpha_no_available_mission(
        "u_has_no_available_mission" );
    const conditional_t alpha_one_available_mission(
        "u_has_available_mission" );
    const conditional_t alpha_many_available_missions(
        "u_has_many_available_missions" );
    const conditional_t alpha_mission_complete( "u_mission_complete" );
    const conditional_t alpha_mission_incomplete( "u_mission_incomplete" );
    const conditional_t alpha_mission_failed( "u_mission_failed" );
    const conditional_t alpha_mission_goal( json_loader::from_string(
            R"({"u_mission_goal":"MGOAL_CONDITION"})" ).get_object() );

    // Alpha is normally the avatar in TALK. The native avatar talker inherits
    // empty available/selected mission results, even while beta has missions.
    provider->chatbin.missions = { owned_for_dialogue, second_owned_for_dialogue };
    CHECK( alpha_no_available_mission( selected_mission_dialogue ) );
    CHECK_FALSE( alpha_one_available_mission( selected_mission_dialogue ) );
    CHECK_FALSE( alpha_many_available_missions( selected_mission_dialogue ) );
    CHECK_FALSE( alpha_mission_complete( selected_mission_dialogue ) );
    CHECK_FALSE( alpha_mission_incomplete( selected_mission_dialogue ) );
    CHECK_FALSE( alpha_mission_failed( selected_mission_dialogue ) );
    CHECK_FALSE( alpha_mission_goal( selected_mission_dialogue ) );
    provider->chatbin.missions.clear();

    // The same native alpha selectors inspect the selected NPC when that is
    // the actual talker. Typed NPC services preserve this actor-slot choice.
    dialogue npc_alpha_mission_dialogue(
        get_talker_for( *provider ), get_talker_for( current_avatar ) );
    const auto check_alpha_available_count = [&]( const std::size_t expected ) {
        const std::size_t native_count =
            npc_alpha_mission_dialogue.const_actor( false )->available_missions().size();
        CHECK( native_count == expected );
        CHECK( static_cast<std::size_t>( integer_from( available_count( provider_handle ) ) ) ==
               native_count );
        CHECK( alpha_no_available_mission( npc_alpha_mission_dialogue ) ==
               ( native_count == 0 ) );
        CHECK( alpha_one_available_mission( npc_alpha_mission_dialogue ) ==
               ( native_count == 1 ) );
        CHECK( alpha_many_available_missions( npc_alpha_mission_dialogue ) ==
               ( native_count >= 2 ) );
    };
    provider->chatbin.missions.clear();
    check_alpha_available_count( 0 );
    provider->chatbin.missions.push_back( owned_for_dialogue );
    check_alpha_available_count( 1 );
    provider->chatbin.missions.push_back( second_owned_for_dialogue );
    check_alpha_available_count( 2 );
    provider->chatbin.missions.clear();

    const auto compare_alpha_selected_status = [&]( const char *predicate,
    const conditional_t &native_condition ) {
        CHECK( native_condition( npc_alpha_mission_dialogue ) ==
               boolean_from( selected_condition(
                                 provider_handle, current_avatar_handle,
                                 predicate ) ) );
    };
    compare_alpha_selected_status( "complete", alpha_mission_complete );
    compare_alpha_selected_status( "incomplete", alpha_mission_incomplete );
    compare_alpha_selected_status( "failed", alpha_mission_failed );
    CHECK( alpha_mission_goal( npc_alpha_mission_dialogue ) ==
           boolean_from( selected_has_goal(
                             provider_handle, "MGOAL_CONDITION" ) ) );

    provider->chatbin.mission_selected = nullptr;
    provider->chatbin.missions_assigned.clear();

    mission *retired = mission::reserve_new(
                           mission_TEST_MISSION_GOAL_CONDITION1,
                           provider->getID() );
    REQUIRE( retired != nullptr );
    const cata::lua_platform::mission_token retired_token(
        retired->get_id(), retired->identity_generation(), runtime,
        active_world );
    REQUIRE( mission::remove_unassigned( retired->get_id() ) );
    CHECK( error_code( select( provider_handle, retired_token ) ) ==
           "missing_mission" );
    provider->chatbin.missions.push_back( retired );
    CHECK( integer_from( available_count( provider_handle ) ) == 1 );
    sol::table stale_available_state = value_from( state( provider_handle ) );
    CHECK( stale_available_state["available"].get<sol::table>()
           ["total"].get<int>() == 0 );
    provider->chatbin.missions.clear();

    provider->chatbin.missions.push_back( nullptr );
    CHECK( integer_from( available_count( provider_handle ) ) == 1 );
    sol::table null_available_state = value_from( state( provider_handle ) );
    CHECK( null_available_state["available"].get<sol::table>()
           ["total"].get<int>() == 0 );
    provider->chatbin.missions.clear();

    provider->chatbin.mission_selected = retired;
    sol::table stale_state = value_from( state( provider_handle ) );
    CHECK_FALSE( stale_state["selected"].valid() );
    CHECK( stale_state["selected_stale"].get<bool>() );
    for( const char *predicate : {
             "complete", "incomplete", "failed"
         } ) {
        CHECK_FALSE( boolean_from( selected_condition(
                                       provider_handle, owner_handle, predicate ) ) );
    }
    CHECK_FALSE( boolean_from( selected_has_goal(
                                   provider_handle, "MGOAL_CONDITION" ) ) );
    CHECK( error_code( selected_has_generic_rewards( provider_handle ) ) ==
           "stale_mission" );
    provider->chatbin.mission_selected = nullptr;

    mission *foreign = mission::reserve_new(
                           mission_TEST_MISSION_GENERIC_REWARD,
                           wrong_provider.getID() );
    REQUIRE( foreign != nullptr );
    const cata::lua_platform::mission_token foreign_token(
        foreign->get_id(), foreign->identity_generation(), runtime,
        active_world );
    foreign->fail( owner );
    provider->chatbin.mission_selected = foreign;
    sol::table invalid_state = value_from( state( provider_handle ) );
    CHECK_FALSE( invalid_state["selected"].valid() );
    CHECK( invalid_state["selected_invalid"].get<bool>() );
    CHECK_FALSE( boolean_from( selected_condition(
                                   provider_handle, owner_handle, "complete" ) ) );
    CHECK( boolean_from( selected_condition(
                             provider_handle, owner_handle, "incomplete" ) ) );
    CHECK( boolean_from( selected_condition(
                             provider_handle, owner_handle, "failed" ) ) );
    CHECK( boolean_from( selected_has_goal(
                             provider_handle, "MGOAL_CONDITION" ) ) );
    CHECK( boolean_from( selected_has_generic_rewards( provider_handle ) ) );
    compare_selected_generic_rewards();
    provider->chatbin.missions.push_back( foreign );
    CHECK( error_code( select( provider_handle, foreign_token ) ) ==
           "not_provided_here" );
    sol::table filtered_state = value_from( state( provider_handle ) );
    CHECK( filtered_state["available"].get<sol::table>()
           ["total"].get<int>() == 0 );
    CHECK( filtered_state["available"].get<sol::table>()
           ["returned"].get<int>() == 0 );
    CHECK( integer_from( available_count( provider_handle ) ) == 1 );
    provider->chatbin.missions.clear();
    provider->chatbin.mission_selected = nullptr;
    REQUIRE( mission::remove_unassigned( foreign->get_id() ) );

    cata::lua_platform::retire_npc_handle_identity( *provider );
    CHECK( error_code( state( provider_handle ) ) == "stale_identity" );
}

#endif // CATA_ENABLE_LUA_PLATFORM
