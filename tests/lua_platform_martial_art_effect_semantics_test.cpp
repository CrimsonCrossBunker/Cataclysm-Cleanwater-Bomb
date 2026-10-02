#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <initializer_list>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "martialarts.h"
#include "npctalk.h"

TEST_CASE( "lua_platform_martial_art_effect_service_matches_native_effect_ids",
           "[lua][platform][martial_arts][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar native_avatar;
    avatar platform_avatar;
    native_avatar.normalize();
    platform_avatar.normalize();
    native_avatar.setID( character_id( 7201 ), true );
    platform_avatar.setID( character_id( 7202 ), true );
    dialogue native_dialogue( get_talker_for( native_avatar ), nullptr );

    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime(
                             "martial_art_effect_semantics", 7203, lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    cata::lua_platform::runtime_world_ready( true );

    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_creature(
            platform_avatar,
    { "avatar", platform_avatar.getID().get_value(), 0, 0, 0, {} },
    cata::lua_platform::detail::runtime_handle_identity( runtime ),
    cata::lua_platform::runtime_world_generation() );
    sol::table services = ccb["services"];

    const auto apply_native_effect = [&native_dialogue]( const std::string & key,
    const std::string & id ) {
        const JsonValue json = json_loader::from_string(
                                   std::string( "{\"" ) + key + "\":\"" + id + "\"}"
                               );
        const JsonObject input = json.get_object();
        talk_effect_t effect;
        effect.parse_sub_effect( input, "martial_art_effect_semantics" );
        for( const talk_effect_fun_t &function : effect.effects ) {
            function( native_dialogue );
        }
    };
    const auto apply_platform_effect = [&services, &handle]( const std::string & operation,
    const std::string & id ) {
        sol::protected_function function = services["martial_arts"][operation];
        const sol::protected_function_result call = function(
                handle, cata::lua_platform::script_game_id( "martial_art", id ) );
        REQUIRE( call.valid() );
        const sol::table result = call;
        REQUIRE( result["ok"].get<bool>() );
        return result["value"]["changed"].get<bool>();
    };

    for( const std::string &id : {
             std::string( "style_karate" ),
             std::string( "style_not_registered" )
         } ) {
        const matype_id style( id );
        const cata::lua_platform::script_game_id typed_id( "martial_art", id );
        CHECK( typed_id.is_valid() == style.is_valid() );
        if( id == "style_karate" ) {
            REQUIRE( style.is_valid() );
        } else {
            REQUIRE_FALSE( style.is_valid() );
            CHECK_FALSE( typed_id.is_valid() );
        }

        const std::string native_learn_key = "u_learn_martial_art";
        apply_native_effect( native_learn_key, id );
        CHECK( apply_platform_effect( "learn", id ) );
        CHECK( native_avatar.has_martialart( style ) );
        CHECK( platform_avatar.has_martialart( style ) );

        apply_native_effect( native_learn_key, id );
        CHECK_FALSE( apply_platform_effect( "learn", id ) );
        CHECK( native_avatar.has_martialart( style ) );
        CHECK( platform_avatar.has_martialart( style ) );

        if( id == "style_karate" ) {
            native_avatar.martial_arts_data->set_style( style );
            platform_avatar.martial_arts_data->set_style( style );
        }
        apply_native_effect( "u_forget_martial_art", id );
        CHECK( apply_platform_effect( "forget", id ) );
        CHECK_FALSE( native_avatar.has_martialart( style ) );
        CHECK_FALSE( platform_avatar.has_martialart( style ) );
        if( id == "style_karate" ) {
            CHECK( native_avatar.martial_arts_data->selected_style() == matype_id( "style_none" ) );
            CHECK( platform_avatar.martial_arts_data->selected_style() == matype_id( "style_none" ) );
        }
    }
}

#endif
