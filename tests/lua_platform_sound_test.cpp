#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_test_support.h"

#include "effect.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"

TEST_CASE( "lua_platform_audible_sound_reports_the_native_hearing_gate",
           "[lua][platform][sound][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
            "lua_platform_sound_test", 6107, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;

    avatar &player = get_avatar();
    const efftype_id sleeping( "sleep" );
    const bool already_sleeping = player.has_effect( sleeping );
    if( !already_sleeping ) {
        player.add_effect( sleeping, 10_turns );
    }
    const on_out_of_scope restore_sleep( [&player, already_sleeping, sleeping]() {
        if( !already_sleeping ) {
            player.remove_effect( sleeping );
        }
    } );

    platform::detail::callback_scope active_callback( *owner );
    const sol::protected_function_result result = lua.safe_script( R"(
        local played = ccb.services.sound.play_if_audible(
            "bionics", "sound_test", 20)
        assert(played == false)
        assert(not pcall(ccb.services.sound.play_if_audible,
            "bionics", "sound_test", 129))
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );

    const sol::protected_function_result emit_result = lua.safe_script( R"(
        local snapshot = ccb.services.characters.snapshot(
            ccb.services.characters.avatar())
        assert(snapshot.ok)
        ccb.services.sound.emit(
            snapshot.value.creature.position, 0, "background",
            ccb.services.translate("A faint sound."), false)
        assert(not pcall(ccb.services.sound.emit,
            snapshot.value.creature.position, 1001, "background", "too loud", false))
    )", sol::script_pass_on_error );
    if( !emit_result.valid() ) {
        const sol::error error = emit_result;
        INFO( error.what() );
    }
    REQUIRE( emit_result.valid() );
}

#endif
