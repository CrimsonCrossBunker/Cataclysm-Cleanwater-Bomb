#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

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

#endif // CATA_ENABLE_LUA_PLATFORM
