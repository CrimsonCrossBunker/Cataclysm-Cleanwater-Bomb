#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <memory>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "lua_platform_hooks.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_movement_plan.h"

TEST_CASE( "monster_movement_revalidates_after_platform_move_hook",
           "[monster][movement_plan][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    clear_map_without_vision();
    map &here = get_map();
    monster &source = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    const tripoint_bub_ms step{ 51, 50, 0 };
    source.set_moves( 100 );
    const auto previous = platform::detail::active_runtime_values();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_named_table( "ccb" );
    const auto owner = platform::make_runtime( "movement-lifecycle-test", 1, lua );
    platform::install_runtime_api( owner, lua, ccb );
    const on_out_of_scope restore( [&]() {
        platform::set_active_runtimes( previous );
    } );
    bool allow = true;
    int calls = 0;
    lua.set_function( "test_move_boundary", [&]() {
        ++calls;
        return allow;
    } );
    SECTION( "ordinary cancellation" ) {
        allow = false;
    }
    SECTION( "actor removed during hook" ) {
        lua.set_function( "test_move_boundary", [&]() {
            ++calls;
            get_creature_tracker().remove( source );
            return true;
        } );
    }
    SECTION( "map context retired during hook" ) {
        lua.set_function( "test_move_boundary", [&]() {
            ++calls;
            here.vertical_shift( here.get_abs_sub().z() );
            return true;
        } );
    }
    const auto loaded = lua.safe_script( R"lua(
ccb.runtime.handler("movement_probe", function() return test_move_boundary() end, 1)
ccb.runtime.hook("on_monster_try_move", "movement_probe")
)lua", sol::script_pass_on_error );
    REQUIRE( loaded.valid() );
    owner->world_is_ready = true;
    platform::set_active_runtimes( { owner } );
    REQUIRE( platform::has_native_hook( "on_monster_try_move" ) );
    monster_movement_plan plan( source, here, { here.get_abs( step ), step, true, false } );
    const auto result = plan.commit( plan.proposal(), here );
    CHECK( calls == 1 );
    CHECK( source.pos_bub( here ) == tripoint_bub_ms( 50, 50, 0 ) );
    CHECK( source.get_moves() == 100 );
    CHECK( result == ( allow ? monster_movement_result::cancelled :
                       monster_movement_result::blocked ) );
}
#endif
