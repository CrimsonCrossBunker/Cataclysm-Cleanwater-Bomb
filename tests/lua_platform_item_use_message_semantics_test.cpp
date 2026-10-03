#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <coordinates.h>
#include <item_uid.h>
#include <pimpl.h>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "json_loader.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "map.h"
#include "map_helpers.h"
#include "messages.h"
#include "npc.h"
#include "point.h"
#include "type_id.h"

static const itype_id itype_efile_map( "efile_map" );
static const itype_id itype_fidget_spinner( "fidget_spinner" );
static const itype_id itype_rock( "rock" );

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform

TEST_CASE( "lua_platform_item_use_context_message_matches_native_u_message_severity",
           "[lua][platform][items][messages][semantic]" )
{
    using namespace cata::lua_platform;
    REQUIRE( g != nullptr );

    avatar user;
    user.normalize();
    item &efile_map = user.inv->add_item( item( itype_efile_map ), false, false, false );
    item_location item_talker( user, &efile_map );
    dialogue native_context( get_talker_for( &user ), get_talker_for( item_talker ) );

    const auto apply_native_message = [&native_context]( const std::string & source ) {
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
            context:message(ccb.services.translate(useful_data_message), "good")
            context:message(ccb.services.translate(already_noted_message))
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

TEST_CASE( "native_fidget_spinner_inline_eoc_returns_zero_for_avatar_and_null_alpha",
           "[items][eoc][messages][semantic]" )
{
    REQUIRE( g != nullptr );
    clear_map();
    Messages::clear_messages();
    const on_out_of_scope cleanup( []() {
        clear_map();
        Messages::clear_messages();
    } );

    avatar user;
    user.normalize();
    item &avatar_spinner = user.inv->add_item(
                               item( itype_fidget_spinner ), false, false, false );
    REQUIRE( avatar_spinner.type->has_use() );

    map &here = get_map();
    const tripoint_bub_ms use_position( 60, 60, 0 );
    const std::optional<int> avatar_result = avatar_spinner.type->invoke(
                &user, avatar_spinner, &here, use_position );
    REQUIRE( avatar_result.has_value() );
    CHECK( *avatar_result == 0 );
    CHECK( Messages::recent_messages_with_formatting( 1 ).size() == 1 );

    Messages::clear_messages();
    item local_spinner( itype_fidget_spinner );
    const std::optional<int> null_alpha_result = local_spinner.type->invoke(
                nullptr, local_spinner, &here, use_position );
    REQUIRE( null_alpha_result.has_value() );
    CHECK( *null_alpha_result == 0 );
    CHECK( Messages::recent_messages_with_formatting( 1 ).empty() );
}

TEST_CASE( "lua_platform_item_use_context_keeps_the_native_npc_and_item_beta",
           "[lua][platform][items][actors][semantic]" )
{
    using namespace cata::lua_platform;
    REQUIRE( g != nullptr );
    debug_reset_error_observed();
    clear_map();

    npc user;
    user.normalize();
    user.setID( character_id( 941721 ), true );
    register_npc_handle_identity( user );
    const on_out_of_scope retire_user( [&user]() {
        retire_npc_handle_identity( user );
    } );
    item &used_item = user.inv->add_item(
                          item( itype_efile_map ), false, false, false );
    avatar avatar_user;
    avatar_user.normalize();
    item &avatar_item = avatar_user.inv->add_item(
                            item( itype_efile_map ), false, false, false );
    map &here = get_map();
    const tripoint_bub_ms map_use_position( 60, 60, 0 );
    const tripoint_abs_ms map_item_position = here.get_abs( map_use_position );
    item &map_used_item = here.add_item_or_charges(
                              map_use_position, item( itype_rock ), false );
    REQUIRE_FALSE( map_used_item.is_null() );

    constexpr std::string_view mod_id = "item_use_npc_actor_bridge";
    clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<runtime> owner = make_runtime( std::string( mod_id ), 941722, lua );
    const on_out_of_scope cleanup( []() {
        clear_active_runtimes();
        clear_map();
        Messages::clear_messages();
    } );
    install_runtime_api( owner, lua, ccb );
    set_active_runtimes( { owner } );
    lua["ccb"] = ccb;
    lua["expected_character_id"] = user.getID().get_value();
    lua["expected_item_uid"] = used_item.uid().get_value();
    lua["expected_item_id"] = "efile_map";
    lua["expected_character_subtype"] = "npc";
    lua["callback_count"] = 0;
    lua["null_character_no_return"] = false;
    lua["null_character_nil"] = false;
    lua["null_character_result"] = 0;
    const sol::protected_function_result registered = lua.safe_script( R"(
        ccb.runtime.handler("npc_item_actor_bridge", function(context)
            callback_count = callback_count + 1
            local character = context.character
            if expected_character_id == nil then
                assert(character == nil)
                assert(context.player_name == nil)
                assert(context.item.kind == "item")
                assert(context.item:locator().scope == "map_item")
                assert(context.item:locator().stable_id == expected_item_uid)
                assert(context.item:locator().position.x == expected_item_x)
                assert(context.item:locator().position.y == expected_item_y)
                assert(context.item:locator().position.z == expected_item_z)
                assert(context.position.x == expected_use_x)
                assert(context.position.y == expected_use_y)
                assert(context.position.z == expected_use_z)
                local snapshot = ccb.services.items.snapshot(context.item, 0)
                assert(snapshot.ok)
                assert(snapshot.value.uid == expected_item_uid)
                assert(snapshot.value.id.value == expected_item_id)
                context:message("No Character means no message.", "good")
                local ignored_severity = pcall(context.message, context,
                                               "No alpha means native u_message returns early.",
                                               "not_a_message_type")
                assert(ignored_severity)
                saved_context = context
                if fail_callback then
                    error("expected item-use callback failure without Character")
                end
                if null_character_no_return then
                    return
                end
                if null_character_nil then
                    return nil
                end
                return null_character_result
            end
            assert(character.kind == "creature")
            assert(character.subtype == expected_character_subtype)
            assert(character:locator().stable_id == expected_character_id)
            assert(character:is_valid())
            assert(ccb.services.characters.snapshot(character).ok)
            if character.subtype == "npc" then
                assert(ccb.services.npcs.get(character).ok)
            end
            local snapshot = ccb.services.items.snapshot(context.item, 0)
            assert(snapshot.ok)
            assert(snapshot.value.uid == expected_item_uid)
            assert(snapshot.value.id.kind == "item")
            assert(snapshot.value.id.value == expected_item_id)
            saved_context = context
            if fail_callback then
                error("expected item-use callback failure")
            end
            return 0
        end)
    )", sol::script_pass_on_error );
    if( !registered.valid() ) {
        const sol::error error = registered;
        INFO( error.what() );
    }
    REQUIRE( registered.valid() );
    runtime_world_ready( true );

    const std::optional<int> result = invoke_use_handler(
                                          mod_id, "npc_item_actor_bridge", &user,
                                          used_item, nullptr, tripoint_bub_ms::zero );
    if( !result ) {
        for( const auto &message : Messages::recent_messages_with_formatting( 10 ) ) {
            UNSCOPED_INFO( message.second );
        }
    }
    REQUIRE( result.has_value() );
    CHECK( *result == 0 );
    CHECK( lua["callback_count"].get<int>() == 1 );
    const sol::protected_function_result stale_after_success = lua.safe_script( R"(
        local character_ok = pcall(function() return saved_context.character end)
        local item_ok = pcall(function() return saved_context.item end)
        assert(not character_ok and not item_ok)
    )", sol::script_pass_on_error );
    REQUIRE( stale_after_success.valid() );

    lua["fail_callback"] = true;
    REQUIRE_FALSE( debug_has_error_been_observed() );
    const std::optional<int> failed = invoke_use_handler(
                                          mod_id, "npc_item_actor_bridge", &user,
                                          used_item, nullptr, tripoint_bub_ms::zero );
    CHECK_FALSE( failed.has_value() );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( lua["callback_count"].get<int>() == 2 );
    const sol::protected_function_result stale_after_failure = lua.safe_script( R"(
        local character_ok = pcall(function() return saved_context.character end)
        local item_ok = pcall(function() return saved_context.item end)
        assert(not character_ok and not item_ok)
    )", sol::script_pass_on_error );
    REQUIRE( stale_after_failure.valid() );

    lua["expected_character_id"] = avatar_user.getID().get_value();
    lua["expected_item_uid"] = avatar_item.uid().get_value();
    lua["expected_character_subtype"] = "avatar";
    lua["fail_callback"] = false;
    const std::optional<int> avatar_result = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", &avatar_user,
                avatar_item, nullptr, tripoint_bub_ms::zero );
    REQUIRE( avatar_result.has_value() );
    CHECK( *avatar_result == 0 );
    CHECK( lua["callback_count"].get<int>() == 3 );

    lua["expected_character_id"] = sol::lua_nil;
    lua["expected_item_uid"] = map_used_item.uid().get_value();
    lua["expected_item_id"] = "rock";
    lua["expected_item_x"] = map_item_position.x();
    lua["expected_item_y"] = map_item_position.y();
    lua["expected_item_z"] = map_item_position.z();
    lua["expected_use_x"] = map_use_position.x();
    lua["expected_use_y"] = map_use_position.y();
    lua["expected_use_z"] = map_use_position.z();
    lua["null_character_no_return"] = true;
    Messages::clear_messages();
    const std::optional<int> null_character_result = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", nullptr,
                map_used_item, &here, map_use_position );
    if( !null_character_result ) {
        for( const std::pair<std::string, std::string> &message :
             Messages::recent_messages_with_formatting( 10 ) ) {
            UNSCOPED_INFO( message.second );
        }
    }
    REQUIRE( null_character_result.has_value() );
    CHECK( *null_character_result == 0 );
    CHECK( lua["callback_count"].get<int>() == 4 );
    CHECK( Messages::recent_messages_with_formatting( 1 ).empty() );
    const sol::protected_function_result stale_null_context = lua.safe_script( R"(
        local character_ok = pcall(function() return saved_context.character end)
        local player_name_ok = pcall(function() return saved_context.player_name end)
        local item_ok = pcall(function() return saved_context.item end)
        local position_ok = pcall(function() return saved_context.position end)
        local message_ok = pcall(function() return saved_context:message("stale", "bad") end)
        assert(not character_ok and not player_name_ok and not item_ok)
        assert(not position_ok and not message_ok)
    )", sol::script_pass_on_error );
    REQUIRE( stale_null_context.valid() );

    lua["null_character_no_return"] = false;
    lua["null_character_result"] = 1;
    const std::optional<int> null_character_nonzero = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", nullptr,
                map_used_item, &here, map_use_position );
    REQUIRE( null_character_nonzero.has_value() );
    CHECK( *null_character_nonzero == 1 );
    CHECK( lua["callback_count"].get<int>() == 5 );

    lua["null_character_nil"] = true;
    const std::optional<int> null_character_nil = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", nullptr,
                map_used_item, &here, map_use_position );
    CHECK_FALSE( null_character_nil.has_value() );
    CHECK( lua["callback_count"].get<int>() == 6 );

    lua["fail_callback"] = true;
    REQUIRE_FALSE( debug_has_error_been_observed() );
    const std::optional<int> null_character_failure = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", nullptr,
                map_used_item, &here, map_use_position );
    CHECK_FALSE( null_character_failure.has_value() );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( lua["callback_count"].get<int>() == 7 );

    REQUIRE_FALSE( debug_has_error_been_observed() );
    const std::optional<int> null_character_without_map = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", nullptr,
                map_used_item, nullptr, map_use_position );
    CHECK_FALSE( null_character_without_map.has_value() );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( lua["callback_count"].get<int>() == 7 );

    // Ranged-hit use can pass a local item while retaining a map-cursor hint.
    item local_item( itype_rock );
    lua["fail_callback"] = false;
    lua["null_character_nil"] = false;
    lua["null_character_no_return"] = true;
    lua["expected_item_uid"] = local_item.uid().get_value();
    lua["expected_item_x"] = map_item_position.x();
    lua["expected_item_y"] = map_item_position.y();
    lua["expected_item_z"] = map_item_position.z();
    Messages::clear_messages();
    const std::optional<int> local_item_result = invoke_use_handler(
                mod_id, "npc_item_actor_bridge", nullptr,
                local_item, &here, map_use_position );
    REQUIRE( local_item_result.has_value() );
    CHECK( *local_item_result == 0 );
    CHECK( lua["callback_count"].get<int>() == 8 );
    CHECK( Messages::recent_messages_with_formatting( 1 ).empty() );
}

#endif
