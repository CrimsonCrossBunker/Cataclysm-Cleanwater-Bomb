#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <vector>

#include "avatar.h"
#include "bionics.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "condition.h"
#include "debug.h"
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
#include "units.h"

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform

TEST_CASE( "lua_platform_bionic_semantics_match_legacy_character_operations",
           "[lua][platform][bionics][semantic]" )
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
    old_player.setID( character_id( 4101 ), true );
    new_player.setID( character_id( 4102 ), true );
    old_npc.setID( character_id( 4103 ), true );
    new_npc.setID( character_id( 4104 ), true );
    cata::lua_platform::register_npc_handle_identity( new_npc );
    const on_out_of_scope retire( [&]() {
        cata::lua_platform::retire_npc_handle_identity( new_npc );
    } );
    const bool npc_target = GENERATE( false, true );
    const std::string id = GENERATE( std::string( "bio_batteries" ),
                                     std::string( "bio_power_storage" ) );
    Character &old_target = npc_target ? static_cast<Character &>( old_npc ) : old_player;
    Character &new_target = npc_target ? static_cast<Character &>( new_npc ) : new_player;
    Character &untouched = npc_target ? static_cast<Character &>( new_player ) : new_npc;
    const std::string prefix = npc_target ? "npc_" : "u_";
    dialogue old_dialogue( get_talker_for( old_player ), get_talker_for( old_npc ) );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "bionic_semantics", 4105, lua );
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
        const auto query = [&]() {
            sol::protected_function summary = services["bionics"]["summary"];
            sol::protected_function_result call = summary( handle );
            REQUIRE( call.valid() );
            sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            sol::table value = result["value"];
            const conditional_t any( json_loader::from_string( R"({")" + prefix +
                                     R"(has_bionics":"ANY"})" ).get_object() );
            CHECK( any( old_dialogue ) == ( value["installed_count"].get<int>() > 0 ||
                                            value["has_capacity"].get<bool>() ) );
            sol::protected_function has = services["bionics"]["has"];
            call = has( handle, cata::lua_platform::script_game_id( "bionic", id ) );
            REQUIRE( call.valid() );
            result = call;
            REQUIRE( result["ok"].get<bool>() );
            const conditional_t specific( json_loader::from_string( R"({")" + prefix +
                                          R"(has_bionics":")" + id + R"("})" ).get_object() );
            CHECK( specific( old_dialogue ) == result["value"].get<bool>() );
        };
        query();
        old_target.set_max_power_level( 10_kJ );
        new_target.set_max_power_level( 10_kJ );
        REQUIRE( old_target.num_bionics() == 0 );
        REQUIRE( old_target.has_max_power() );
        query();
        for( const std::string operation : {
                 "add_bionic", "add_bionic", "lose_bionic", "lose_bionic"
             } ) {
            talk_effect_t effect;
            effect.parse_sub_effect( json_loader::from_string( std::string( R"({")" ).append( prefix ).append(
                                         operation ).append( R"(":")" ).append( id ).append( R"("})" ) ).get_object(), "bionic_semantics" );
            const bool duplicate = operation == "add_bionic" &&
                                   old_target.has_bionic( bionic_id( id ) ) &&
                                   !bionic_id( id )->dupes_allowed;
            const std::string old_diagnostic = capture_debugmsg_during( [&]() {
                for( const talk_effect_fun_t &function : effect.effects ) {
                    function( old_dialogue );
                }
            } );
            sol::table result;
            const std::string new_diagnostic = capture_debugmsg_during( [&]() {
                sol::protected_function function = services["bionics"][operation == "add_bionic" ?
                                                   "grant" : "remove_type"];
                sol::protected_function_result call = function( handle,
                                                      cata::lua_platform::script_game_id( "bionic", id ) );
                REQUIRE( call.valid() );
                result = call;
                REQUIRE( result["ok"].get<bool>() );
            } );
            CHECK( old_diagnostic == new_diagnostic );
            if( duplicate ) {
                CHECK( old_diagnostic.find( "already installed" ) != std::string::npos );
                CHECK_FALSE( result["value"]["changed"].get<bool>() );
            } else {
                CHECK( old_diagnostic.empty() );
            }
            CHECK( old_target.num_bionics() == new_target.num_bionics() );
            CHECK( old_target.get_max_power_level() == new_target.get_max_power_level() );
            CHECK( old_target.get_power_level() == new_target.get_power_level() );
            CHECK( untouched.num_bionics() == 0 );
            query();
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
