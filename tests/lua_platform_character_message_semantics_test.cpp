#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "game.h"
#include "inventory.h"
#include "item.h"
#include "json_loader.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "messages.h"
#include "npc.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "lua_platform_character_messages_match_native_actor_targeted_hook",
           "[lua][platform][characters][messages][semantic]" )
{
    using namespace cata::lua_platform;
    REQUIRE( g != nullptr );
    const on_out_of_scope clear_messages( []() {
        Messages::clear_messages();
    } );

    // Use the real static message shape that currently accompanies
    // u_roll_remainder in Xedra_Evolved. Its plain JSON string is parsed by
    // translation_or_var as no_translation, so translated() returns this
    // literal unchanged.
    const cata_path source_path(
        cata_path::root_path::data,
        "mods/Xedra_Evolved/mutations/"
        "playable_changeling_seasonal_magic_research_eocs.json" );
    const JsonArray eocs = json_loader::from_path( source_path ).get_array();
    std::string translated_format;
    for( const JsonObject eoc : eocs ) {
        eoc.allow_omitted_members();
        if( eoc.get_string( "id", "" ) !=
            "EOC_CHANGELING_RESEARCH_SEASONAL_MAGIC_SPRING_TIER_1" ) {
            continue;
        }
        for( const JsonObject effect : eoc.get_array( "effect" ) ) {
            effect.allow_omitted_members();
            if( effect.has_array( "u_roll_remainder" ) &&
                effect.get_string( "type", "" ) == "spell" &&
                effect.has_string( "message" ) ) {
                translated_format = effect.get_string( "message" );
                break;
            }
        }
        break;
    }
    REQUIRE_FALSE( translated_format.empty() );
    const std::size_t placeholder = translated_format.find( "%s" );
    REQUIRE( placeholder != std::string::npos );
    CHECK( translated_format.find( "%", placeholder + 2 ) == std::string::npos );

    avatar &player_target = get_avatar();
    avatar item_user;
    item_user.normalize();
    item &used_item = item_user.inv->add_item(
                          item( itype_id( "efile_map" ) ), false, false, false );
    npc beta;
    beta.normalize();
    beta.setID( character_id( 941701 ), true );
    register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&beta]() {
        retire_npc_handle_identity( beta );
    } );
    const std::string learned_name = "a spring glamour";

    Messages::clear_messages();
    player_target.add_msg_if_player( translated_format, learned_name );
    const std::vector<std::pair<std::string, std::string>> expected =
        Messages::recent_messages_with_formatting( 2 );
    REQUIRE( expected.size() == 1 );
    beta.add_msg_if_player( translated_format, learned_name );
    CHECK( Messages::recent_messages_with_formatting( 2 ) == expected );

    clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    constexpr std::string_view mod_id = "character_message_semantics";
    const std::shared_ptr<runtime> owner = make_runtime( std::string( mod_id ), 941702, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua["research_message_format"] = translated_format;
    lua["learned_name"] = learned_name;
    lua["beta_handle"] = game_handle::from_creature(
                             beta,
                             { "npc", beta.getID().get_value(), 0, 0, 0, {} },
                             cata::lua_platform::detail::runtime_handle_identity( owner ),
                             runtime_world_generation() );
    const sol::protected_function_result registered = lua.safe_script( R"(
        ccb.runtime.handler("character_message_semantics", function(context)
            local characters = ccb.services.characters
            local player_result = characters.add_msg_if_player(
                characters.avatar(), research_message_format, learned_name)
            assert(player_result.ok and player_result.value == true)
            local npc_result = characters.add_msg_if_player(
                beta_handle, research_message_format, learned_name)
            assert(npc_result.ok and npc_result.value == true)
            local oversized = characters.add_msg_if_player(
                characters.avatar(), string.rep("x", 8193), learned_name)
            assert(not oversized.ok and oversized.error.code == "message_too_long")
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
                                          mod_id, "character_message_semantics", &item_user,
                                          used_item, nullptr, tripoint_bub_ms::zero );
    REQUIRE( result.has_value() );
    CHECK( *result == 0 );
    // The exact Avatar handle emits the same formatted output as the native
    // add_msg_if_player(format, argument) call; the exact NPC handle remains
    // a native no-op. No detached snapshot or global messages.add is involved.
    CHECK( Messages::recent_messages_with_formatting( 2 ) == expected );
}

#endif
