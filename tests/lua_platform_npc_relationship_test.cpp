#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <functional>
#include <initializer_list>
#include <optional>
#include <string>

#include "avatar.h"
#include "condition.h"
#include "coordinates.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_factions.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "point.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "faction.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_npcs.h"
#include "map_helpers.h"
#include "npc.h"
#include "npctalk.h"
#include "player_helpers.h"

TEST_CASE( "lua_platform_npc_follow_preserves_native_state_transitions",
           "[lua][platform][npc][semantic]" )
{
    clear_avatar();
    clear_npcs();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
        clear_avatar();
    } );
    avatar &player = get_avatar();
    npc &legacy = spawn_npc( player.pos_bub().xy() + point::south, "thug" );
    npc &migrated = spawn_npc( player.pos_bub().xy() + point::north, "thug" );
    for( npc *subject : {
             &legacy, &migrated
         } ) {
        subject->set_attitude( NPCATT_FOLLOW );
        subject->set_mission( NPC_MISSION_GUARD );
        subject->goal = tripoint_abs_omt( 12, 13, 0 );
        subject->guard_pos = tripoint_abs_ms( 24, 25, 0 );
        subject->set_ai_guard_pos( tripoint_abs_ms( 26, 27, 0 ) );
        subject->set_committed_goal( "patrol" );
        subject->cash = 47;
        subject->custom_profession = "test profession";
    }
    const bool temporary = GENERATE( false, true );
    player.cash = 100;
    if( temporary ) {
        talk_function::follow_only( legacy );
    } else {
        talk_function::follow( legacy );
    }
    const int expected_player_cash = player.cash;
    player.cash = 100;

    namespace platform = cata::lua_platform;
    sol::state lua;
    sol::table services = lua.create_table();
    const platform::game_handle_runtime_owner_ptr owner = platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime{ owner, 1 };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api( lua, services, [&]() {
        return runtime;
    },
    []() {
        return 1;
    }, []() {} );
    platform::install_npc_api( services, [&]() {
        return runtime;
    },
    []() {
        return 1;
    }, []() {}, []() {}, []() {} );
    platform::register_npc_handle_identity( migrated );
    const platform::game_handle npc_handle = platform::game_handle::from_creature(
                migrated, { "npc", migrated.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    const platform::game_handle avatar_handle = platform::game_handle::from_creature(
                player, { "avatar", player.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    sol::protected_function function = services["npcs"][temporary ? "follow_temporarily" :
                                       "join_player"];
    sol::protected_function_result call = temporary ? function( npc_handle ) :
                                          function( npc_handle, avatar_handle );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    if( temporary ) {
        CHECK( result["value"]["changed"].get<bool>() );
    }
    CHECK( migrated.get_attitude() == legacy.get_attitude() );
    CHECK( migrated.mission == legacy.mission );
    CHECK( migrated.mission == NPC_MISSION_NULL );
    CHECK( migrated.goal == npc::no_goal_point );
    CHECK_FALSE( migrated.guard_pos );
    CHECK_FALSE( migrated.get_ai_guard_pos() );
    CHECK( migrated.get_committed_goal().empty() );
    CHECK( migrated.cash == legacy.cash );
    CHECK( player.cash == expected_player_cash );
    CHECK( migrated.custom_profession == legacy.custom_profession );
    if( !temporary ) {
        CHECK( migrated.get_faction()->id == legacy.get_faction()->id );
        CHECK( player.follower_ids.count( migrated.getID() ) == 1 );
    }
}

TEST_CASE( "lua_migrated_social_conditions_match_native_talker_slots",
           "[lua][platform][npc][conditions][semantic]" )
{
    clear_avatar();
    clear_npcs();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
        clear_avatar();
    } );
    avatar &player = get_avatar();
    npc &alpha = spawn_npc( player.pos_bub().xy() + point::south, "thug" );
    npc &beta = spawn_npc( player.pos_bub().xy() + point::north, "thug" );
    alpha.set_fac( faction_id( "your_followers" ) );
    beta.set_fac( faction_id( "hells_raiders" ) );
    alpha.set_attitude( NPCATT_FOLLOW );
    beta.set_attitude( NPCATT_KILL );
    alpha.op_of_u.owed = 3;
    beta.op_of_u.owed = 8;
    faction *alpha_faction = alpha.get_faction();
    faction *beta_faction = beta.get_faction();
    REQUIRE( alpha_faction != nullptr );
    REQUIRE( beta_faction != nullptr );
    REQUIRE( alpha_faction != beta_faction );
    const int previous_alpha_trust = alpha_faction->trusts_u;
    const int previous_beta_trust = beta_faction->trusts_u;
    const on_out_of_scope restore_trust( [alpha_faction, beta_faction,
    previous_alpha_trust, previous_beta_trust]() {
        alpha_faction->trusts_u = previous_alpha_trust;
        beta_faction->trusts_u = previous_beta_trust;
    } );
    alpha_faction->trusts_u = 1;
    beta_faction->trusts_u = 8;

    dialogue context( get_talker_for( alpha ), get_talker_for( beta ) );
    const conditional_t owed_condition( json_loader::from_string(
            R"({"u_are_owed":8})" ).get_object() );
    const conditional_t trust_condition( json_loader::from_string(
            R"({"u_has_faction_trust":8})" ).get_object() );
    const conditional_t friend_condition( "u_friend" );

    namespace platform = cata::lua_platform;
    sol::state lua;
    sol::table services = lua.create_table();
    const platform::game_handle_runtime_owner_ptr owner =
        platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime{ owner, 1 };
    const auto current_world = []() {
        return std::size_t( 1 );
    };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api( lua, services, [runtime]() {
        return runtime;
    }, current_world, []() {} );
    platform::install_npc_api( services, [runtime]() {
        return runtime;
    }, current_world, []() {}, []() {}, []() {} );
    platform::install_faction_api( services, [runtime]() {
        return runtime;
    }, current_world, []() {}, []() {} );
    platform::register_npc_handle_identity( alpha );
    platform::register_npc_handle_identity( beta );
    const platform::game_handle alpha_handle = platform::game_handle::from_creature(
            alpha, { "npc", alpha.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    const platform::game_handle beta_handle = platform::game_handle::from_creature(
            beta, { "npc", beta.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );

    const sol::protected_function get_npc = services["npcs"]["get"];
    sol::protected_function_result alpha_call = get_npc( alpha_handle );
    REQUIRE( alpha_call.valid() );
    const sol::table alpha_result = alpha_call;
    REQUIRE( alpha_result["ok"].get<bool>() );
    const sol::table alpha_snapshot = alpha_result["value"];
    sol::protected_function_result beta_call = get_npc( beta_handle );
    REQUIRE( beta_call.valid() );
    const sol::table beta_result = beta_call;
    REQUIRE( beta_result["ok"].get<bool>() );
    const sol::table beta_snapshot = beta_result["value"];
    const sol::protected_function for_character =
        services["factions"]["for_character"];
    sol::protected_function_result alpha_faction_call = for_character( alpha_handle );
    REQUIRE( alpha_faction_call.valid() );
    const sol::table alpha_faction_result = alpha_faction_call;
    REQUIRE( alpha_faction_result["ok"].get<bool>() );
    const sol::table alpha_faction_snapshot = alpha_faction_result["value"];
    sol::protected_function_result faction_call = for_character( beta_handle );
    REQUIRE( faction_call.valid() );
    const sol::table faction_result = faction_call;
    REQUIRE( faction_result["ok"].get<bool>() );
    const sol::table faction_snapshot = faction_result["value"];

    const bool owed_from_platform =
        beta_snapshot["opinion"]["owed"].get<int>() >= 8;
    const bool trust_from_platform =
        faction_snapshot["reputation"]["trusts"].get<int>() >= 8;
    const bool friend_from_platform =
        alpha_snapshot["friendly"].get<bool>();
    CHECK( beta_snapshot["opinion"]["owed"].get<int>() == 8 );
    CHECK( alpha_faction_snapshot["reputation"]["trusts"].get<int>() == 1 );
    CHECK( faction_snapshot["reputation"]["trusts"].get<int>() == 8 );
    CHECK( owed_condition( context ) == owed_from_platform );
    CHECK( owed_from_platform );
    CHECK( trust_condition( context ) == trust_from_platform );
    CHECK( trust_from_platform );
    CHECK( friend_condition( context ) == friend_from_platform );
    CHECK( friend_from_platform );
    CHECK_FALSE( beta_snapshot["friendly"].get<bool>() );
}
#endif
