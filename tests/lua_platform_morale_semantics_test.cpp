#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "npc.h"
#include "type_id.h"
#include <functional>
#include <memory>
#include <string>
#include <vector>
#include "lua_platform_test_support.h"
#include "condition.h"
#include "morale_types.h"

static const morale_type morale_type_morale_feeling_good( "morale_feeling_good" );

TEST_CASE( "lua_platform_morale_semantics_match_legacy_character_operations",
           "[lua][platform][morale][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar old_player;
    avatar new_player;
    npc old_npc;
    npc new_npc;
    old_player.normalize();
    new_player.normalize();
    old_npc.normalize();
    new_npc.normalize();
    old_player.setID( character_id( 4201 ), true );
    new_player.setID( character_id( 4202 ), true );
    old_npc.setID( character_id( 4203 ), true );
    new_npc.setID( character_id( 4204 ), true );
    cata::lua_platform::register_npc_handle_identity( new_npc );
    const on_out_of_scope retire( [&]() {
        cata::lua_platform::retire_npc_handle_identity( new_npc );
    } );
    const bool npc_target = GENERATE( false, true );
    const int sign = GENERATE( -1, 1 );
    const bool capped = GENERATE( false, true );
    const bool custom_time = GENERATE( false, true );
    const morale_type &type = morale_type_morale_feeling_good;
    Character &old_target = npc_target ? static_cast<Character &>( old_npc ) : old_player;
    Character &new_target = npc_target ? static_cast<Character &>( new_npc ) : new_player;
    Character &untouched = npc_target ? static_cast<Character &>( new_player ) : new_npc;
    const std::string prefix = npc_target ? "npc_" : "u_";
    dialogue old_dialogue( get_talker_for( old_player ), get_talker_for( old_npc ) );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "morale_semantics", 4205, lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    bool completed = false;
    lua.set_function( "accept", [&]( const sol::table & ) {
        const cata::lua_platform::game_handle handle = cata::lua_platform::game_handle::from_creature(
                new_target, { npc_target ? "npc" : "avatar", new_target.getID().get_value(),
                              0, 0, 0, {}
                            },
                cata::lua_platform::detail::runtime_handle_identity( runtime ),
                cata::lua_platform::runtime_world_generation() );
        sol::table services = ccb["services"];
        const auto add = [&]() {
            const std::string timing = custom_time ?
                                       R"(, "duration": "10 minutes", "decay_start": "5 minutes")" : "";
            const std::string source = R"({")" + prefix + R"(add_morale": "morale_feeling_good", )"
                                       R"("bonus": )" + std::to_string( sign * 12 ) +
                                       R"(, "max_bonus": )" + std::to_string( sign * 20 ) +
                                       R"(, "capped": )" + ( capped ? "true" : "false" ) + timing + "}";
            talk_effect_t effect;
            effect.parse_sub_effect( json_loader::from_string( source ).get_object(), "morale_semantics" );
            for( const talk_effect_fun_t &function : effect.effects ) {
                function( old_dialogue );
            }
            sol::table options = lua.create_table();
            options["capped"] = capped;
            if( custom_time ) {
                options["duration"] = cata::lua_platform::script_time_duration::from_native( 10_minutes );
                options["decay_start"] = cata::lua_platform::script_time_duration::from_native( 5_minutes );
            }
            const int before = new_target.has_morale( type );
            sol::protected_function function = services["morale"]["add"];
            sol::protected_function_result call = function( handle,
                cata::lua_platform::script_game_id( "morale", type.str() ), sign * 12, sign * 20, options );
            REQUIRE( call.valid() );
            sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            sol::table value = result["value"];
            CHECK( value["before"].get<int>() == before );
            CHECK( value["after"].get<int>() == old_target.has_morale( type ) );
            CHECK( old_target.has_morale( type ) == new_target.has_morale( type ) );
            CHECK( untouched.has_morale( type ) == 0 );
        };
        add();
        REQUIRE( old_target.has_morale( type ) != 0 );
        add();
        add();
        for( int minute = 0; minute < 61; ++minute ) {
            old_target.update_morale();
            new_target.update_morale();
            CHECK( old_target.has_morale( type ) == new_target.has_morale( type ) );
        }
        CHECK( old_target.has_morale( type ) == 0 );
        add();
        for( int repeat = 0; repeat < 2; ++repeat ) {
            talk_effect_t effect;
            effect.parse_sub_effect( json_loader::from_string( R"({")" + prefix +
                    R"(lose_morale": "morale_feeling_good"})" ).get_object(), "morale_semantics" );
            for( const talk_effect_fun_t &function : effect.effects ) {
                function( old_dialogue );
            }
            sol::protected_function function = services["morale"]["remove"];
            sol::protected_function_result call = function( handle,
                cata::lua_platform::script_game_id( "morale", type.str() ) );
            REQUIRE( call.valid() );
            sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            CHECK( new_target.has_morale( type ) == 0 );
            CHECK( old_target.has_morale( type ) == 0 );
            CHECK( untouched.has_morale( type ) == 0 );
        }
        completed = true;
    } );
    sol::protected_function_result registered = ccb["runtime"]["handler"]( "accept", lua["accept"] );
    REQUIRE( registered.valid() );
    registered = ccb["runtime"]["on"]( "world_ready", "accept" );
    REQUIRE( registered.valid() );
    cata::lua_platform::runtime_world_ready( true );
    REQUIRE( completed );
}
#endif
