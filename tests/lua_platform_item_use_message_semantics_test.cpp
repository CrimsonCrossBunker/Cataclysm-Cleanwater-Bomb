#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "game.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "json_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "messages.h"
#include "npctalk.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "lua_platform_item_use_context_message_matches_native_u_message_severity",
           "[lua][platform][items][messages][semantic]" )
{
    using namespace cata::lua_platform;
    REQUIRE( g != nullptr );

    avatar user;
    user.normalize();
    item &efile_map = user.inv->add_item( item( itype_id( "efile_map" ) ), false, false, false );
    item_location item_talker( user, &efile_map );
    dialogue native_context( get_talker_for( &user ), get_talker_for( item_talker ) );

    const auto apply_native_message = [&native_context]( const std::string &source ) {
        talk_effect_t effect;
        const JsonValue json = json_loader::from_string( source );
        effect.parse_sub_effect( json.get_object(), "item_use_message_semantics" );
        for( const talk_effect_fun_t &operation : effect.effects ) {
            operation( native_context );
        }
    };

    Messages::clear_messages();
    apply_native_message(
        R"({"u_message":"You found some useful data in the map cache and noted it.",
            "type":"good"})" );
    apply_native_message(
        R"({"u_message":"You already noted everything this map cache can offer."})" );
    const std::vector<std::pair<std::string, std::string>> expected =
        Messages::recent_messages_with_formatting( 2 );
    REQUIRE( expected.size() == 2 );

    constexpr std::string_view mod_id = "item_use_message_semantics";
    clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( std::string( mod_id ), 7401, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
        Messages::clear_messages();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua["useful_data_message"] = "You found some useful data in the map cache and noted it.";
    lua["already_noted_message"] = "You already noted everything this map cache can offer.";
    const sol::protected_function_result registered = lua.safe_script( R"(
        ccb.runtime.handler("map_cache_messages", function(context)
            local translated = ccb.services.translate
            context:message(translated(useful_data_message), "good")
            context:message(translated(already_noted_message))
            local accepted = pcall(context.message, context, "unused", "not_a_message_type")
            assert(not accepted)
            return 0
        end)
    )", sol::script_pass_on_error );
    if( !registered.valid() ) {
        const sol::error error = registered;
        INFO( error.what() );
    }
    REQUIRE( registered.valid() );
    runtime_world_ready( true );

    Messages::clear_messages();
    const std::optional<int> result = invoke_use_handler(
                                          mod_id, "map_cache_messages", &user, efile_map,
                                          nullptr, tripoint_bub_ms::zero );
    REQUIRE( result.has_value() );
    CHECK( *result == 0 );
    CHECK( Messages::recent_messages_with_formatting( 2 ) == expected );
}

#endif
