#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <initializer_list>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "character_id.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "flag.h"
#include "inventory.h"
#include "item.h"
#include "item_location.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_items.h"
#include "lua_platform_sol.h"
#include "npctalk.h"
#include "type_id.h"

TEST_CASE( "lua_platform_item_flag_service_matches_native_talker_slot_effects",
           "[lua][platform][items][flags][semantic]" )
{
    namespace platform = cata::lua_platform;
    avatar alpha_holder;
    avatar beta_holder;
    alpha_holder.normalize();
    beta_holder.normalize();

    item &native_alpha_item = alpha_holder.inv->add_item(
                                  item( itype_id( "rock" ) ), false, false, false );
    item &platform_alpha_item = alpha_holder.inv->add_item(
                                    item( itype_id( "rock" ) ), false, false, false );
    item &native_beta_item = beta_holder.inv->add_item(
                                 item( itype_id( "rock" ) ), false, false, false );
    item &platform_beta_item = beta_holder.inv->add_item(
                                   item( itype_id( "rock" ) ), false, false, false );
    item_location alpha_location( alpha_holder, &native_alpha_item );
    item_location beta_location( beta_holder, &native_beta_item );

    // This dialogue deliberately gives both slots item talkers so the test
    // compares native slot selection itself. Known item-use, inventory-item,
    // and item-event EOC sources put their exact item in beta; they do not
    // prove an alpha item handle for lowering u_*_flag.
    dialogue native_context( get_talker_for( alpha_location ),
                             get_talker_for( beta_location ) );

    const platform::game_handle_runtime_owner_ptr owner =
        platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime( owner, 1 );
    constexpr std::size_t world_generation = 1;
    sol::state lua;
    sol::table services = lua.create_table();
    const auto current_runtime = [&]() {
        return runtime;
    };
    const auto current_world = []() {
        return world_generation;
    };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api(
        lua, services, current_runtime, current_world, []() {} );
    platform::install_item_api(
        services, current_runtime, current_world, []() {}, []() {} );

    const auto item_handle = [&]( item &value ) {
        return platform::game_handle::from_item(
                   value,
                   { "character_inventory", value.uid().get_value(), 0, 0, 0, {} },
                   runtime, world_generation );
    };
    const platform::game_handle alpha_handle = item_handle( platform_alpha_item );
    const platform::game_handle beta_handle = item_handle( platform_beta_item );
    const sol::protected_function set_flag = services["items"]["set_flag"];
    const flag_id filthy( "FILTHY" );
    const platform::script_game_id filthy_id( "json_flag", "FILTHY" );

    const auto apply_native = [&]( const char *slot, const bool enabled ) {
        const std::string selector = std::string( slot ) +
                                     ( enabled ? "_set_flag" : "_unset_flag" );
        const std::string source = std::string( "{\"" ) + selector +
                                   "\":\"FILTHY\"}";
        talk_effect_t effect;
        effect.parse_sub_effect( json_loader::from_string( source ).get_object(),
                                 "item_flag_semantics" );
        for( const talk_effect_fun_t &operation : effect.effects ) {
            operation( native_context );
        }
    };
    const auto compare_slot = [&]( const char *slot, item &native_target,
                                   item &platform_target,
                                   const platform::game_handle &target_handle ) {
        for( const bool enabled : { true, false } ) {
            apply_native( slot, enabled );
            const sol::protected_function_result call = set_flag(
                        target_handle, filthy_id, enabled );
            REQUIRE( call.valid() );
            const sol::table envelope = call;
            REQUIRE( envelope["ok"].get<bool>() );
            const sol::table value = envelope["value"];
            CHECK( value["own_after"].get<bool>() == enabled );
            CHECK( native_target.has_own_flag( filthy ) == enabled );
            CHECK( platform_target.has_own_flag( filthy ) ==
                   native_target.has_own_flag( filthy ) );
        }
    };

    compare_slot( "u", native_alpha_item, platform_alpha_item, alpha_handle );
    compare_slot( "npc", native_beta_item, platform_beta_item, beta_handle );
}

#endif
