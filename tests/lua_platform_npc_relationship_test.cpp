#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <initializer_list>
#include <optional>
#include <string>

#include "avatar.h"
#include "coordinates.h"
#include "lua_platform_sol.h"
#include "point.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "faction.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
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
#endif
