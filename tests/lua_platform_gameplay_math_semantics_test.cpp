#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <memory>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_gameplay_math_requires_ordinary_lua",
           "[lua][platform][gameplay][numeric_migration]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    alpha.normalize();
    alpha.setID( character_id( 6511 ), true );
    alpha.set_value( "lua_math_composition_source", 5.25 );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "gameplay_math_removed", 6512, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["ccb"] = ccb;
    lua["actor"] = platform::game_handle::from_creature(
                        alpha, { "avatar", 6511, 0, 0, 0, {} },
                        owner->handle_runtime(), world_generation );

    platform::detail::callback_scope active_callback( *owner );
    const sol::protected_function_result result = lua.safe_script( R"(
        local services = ccb.services
        assert(services.gameplay.math == nil)

        local source = services.variables.get_number(
            actor, "lua_math_composition_source", { strict = true })
        assert(source.ok and source.value.exists and source.value.value == 5.25)

        local computed = source.value.value * 2 + math.sqrt(4)
        assert(computed == 12.5)

        local stored = services.variables.set(
            actor, "lua_math_composition_result", computed,
            { include_before = false })
        assert(stored.ok)
        local result = services.variables.get_number(
            actor, "lua_math_composition_result", { strict = true })
        assert(result.ok and result.value.exists and result.value.value == computed)
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );
}

#endif // CATA_ENABLE_LUA_PLATFORM
