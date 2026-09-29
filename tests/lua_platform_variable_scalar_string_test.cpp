#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>
#include <optional>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "global_vars.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"

TEST_CASE( "lua_platform_native_variable_scalar_strings_preserve_full_bytes",
           "[lua][platform][semantic][variables]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar player;
    player.normalize();
    player.setID( character_id( 5902 ), true );

    const std::string actor_key = "lua_native_scalar_string_actor_5902";
    const std::string actor_copy_key = "lua_native_scalar_string_actor_copy_5902";
    const std::string global_key = "lua_native_scalar_string_global_5902";
    const std::string global_copy_key = "lua_native_scalar_string_global_copy_5902";
    const std::string context_key = "bounded_context_scalar_5902";
    const diag_value *previous_global_value =
        get_globals().maybe_get_global_value( global_key );
    const std::optional<diag_value> saved_global_value = previous_global_value == nullptr ?
            std::nullopt : std::optional<diag_value>( *previous_global_value );
    const diag_value *previous_global_copy_value =
        get_globals().maybe_get_global_value( global_copy_key );
    const std::optional<diag_value> saved_global_copy_value =
        previous_global_copy_value == nullptr ?
        std::nullopt : std::optional<diag_value>( *previous_global_copy_value );
    const on_out_of_scope clear_values( [&player, actor_key, actor_copy_key,
             global_key, global_copy_key, saved_global_value, saved_global_copy_value]() {
        player.remove_value( actor_key );
        player.remove_value( actor_copy_key );
        if( saved_global_value ) {
            get_globals().set_global_value( global_key, *saved_global_value );
        } else {
            get_globals().remove_global_value( global_key );
        }
        if( saved_global_copy_value ) {
            get_globals().set_global_value( global_copy_key, *saved_global_copy_value );
        } else {
            get_globals().remove_global_value( global_copy_key );
        }
    } );

    std::string wide_a( 9000, 'a' );
    wide_a[4096] = '\0';
    wide_a.back() = 'z';
    std::string wide_b( 10000, 'b' );
    wide_b[8193] = '\0';
    wide_b.back() = 'y';
    std::string wide_c( 12000, 'c' );
    wide_c[1024] = '\0';
    wide_c.back() = 'x';

    // Seed native storage directly to cover the from-native Lua conversion
    // independently of the Platform setter path.
    player.set_value( actor_key, diag_value( wide_a ) );
    get_globals().set_global_value( global_key, diag_value( wide_a ) );

    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "native_variable_scalar_string", 5902, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;

    const std::size_t world_generation =
        platform::detail::runtime_world_generation_storage();
    const platform::game_handle actor = platform::game_handle::from_creature(
                                            player, { "avatar", 5902, 0, 0, 0, {} }, owner->handle_runtime(),
                                            world_generation );
    lua["ccb"] = ccb;
    lua["actor"] = actor;
    lua["actor_key"] = actor_key;
    lua["actor_copy_key"] = actor_copy_key;
    lua["global_key"] = global_key;
    lua["global_copy_key"] = global_copy_key;
    lua["context_key"] = context_key;
    lua["wide_a"] = wide_a;
    lua["wide_b"] = wide_b;
    lua["wide_c"] = wide_c;

    {
        platform::detail::callback_scope active_callback( *owner );
        const sol::protected_function_result result = lua.safe_script( R"(
            local variables = ccb.services.variables

            local actor_read = variables.get(actor, actor_key)
            assert(actor_read.ok and actor_read.value.exists)
            assert(actor_read.value.value == wide_a)
            local global_read = variables.get_global(global_key)
            assert(global_read.ok and global_read.value.exists)
            assert(global_read.value.value == wide_a)

            local actor_write = variables.set(actor, actor_key, wide_b)
            assert(actor_write.ok and actor_write.value.existed)
            assert(actor_write.value.before == wide_a and actor_write.value.after == wide_b)
            local actor_resolved = variables.resolve({}, actor, "u", actor_key)
            assert(actor_resolved.ok and actor_resolved.value.exists)
            assert(actor_resolved.value.value == wide_b)
            local actor_resolved_write = variables.set_resolved(
                {}, actor, "u", actor_key, wide_c)
            assert(actor_resolved_write.ok and actor_resolved_write.value.existed)
            assert(actor_resolved_write.value.before == wide_b)
            assert(actor_resolved_write.value.after == wide_c)

            local actor_to_global = variables.copy(
                actor, actor_key, nil, global_copy_key)
            assert(actor_to_global.ok and actor_to_global.value.source_exists)
            assert(variables.get_global(global_copy_key).value.value == wide_c)
            local global_write = variables.set_global(global_key, wide_b)
            assert(global_write.ok and global_write.value.existed)
            assert(global_write.value.before == wide_a and global_write.value.after == wide_b)
            local global_resolved = variables.resolve({}, nil, "global", global_key)
            assert(global_resolved.ok and global_resolved.value.exists)
            assert(global_resolved.value.value == wide_b)
            local global_resolved_write = variables.set_resolved(
                {}, nil, "global", global_key, wide_c)
            assert(global_resolved_write.ok and global_resolved_write.value.existed)
            assert(global_resolved_write.value.before == wide_b)
            assert(global_resolved_write.value.after == wide_c)

            local global_to_actor = variables.copy(
                nil, global_key, actor, actor_copy_key)
            assert(global_to_actor.ok and global_to_actor.value.source_exists)
            assert(variables.get(actor, actor_copy_key).value.value == wide_c)
            local actor_remove = variables.remove(actor, actor_copy_key)
            assert(actor_remove.ok and actor_remove.value.removed)
            assert(actor_remove.value.before == wide_c)
            local global_remove = variables.remove_global(global_copy_key)
            assert(global_remove.ok and global_remove.value.removed)
            assert(global_remove.value.before == wide_c)

            -- Context values keep their existing bounded diag-value conversion.
            local context = {}
            local context_ok = pcall(variables.set_resolved,
                context, actor, "context", context_key, wide_a)
            assert(not context_ok and context[context_key] == nil)
        )", sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
        }
        REQUIRE( result.valid() );
    }

    CHECK( player.get_value( actor_key ).str() == wide_c );
    CHECK( get_globals().get_global_value( global_key ).str() == wide_c );
    CHECK( player.maybe_get_value( actor_copy_key ) == nullptr );
    CHECK( get_globals().maybe_get_global_value( global_copy_key ) == nullptr );
}

#endif
