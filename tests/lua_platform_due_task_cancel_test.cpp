#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_runtime_internal.h"
#include <cata_scope_helpers.h>
#include <lua_platform_runtime.h>
#include <functional>
#include <memory>
#include <string>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_due_task_can_be_cancelled_by_an_earlier_callback",
           "[lua][platform][tasks]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime( "due-cancel", 2012, lua );
    const on_out_of_scope cleanup( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    lua["ccb"] = ccb;
    // The first callback cancels a sibling and adds a task for a later pass.
    const sol::protected_function_result setup = lua.safe_script( R"lua(
ran_first = 0
ran_cancelled = 0
ran_last = 0
ran_new = 0
ccb.runtime.handler("first", function()
    ran_first = ran_first + 1
    assert(ccb.tasks.get(cancel_id).handler == "cancelled")
    assert(ccb.tasks.list().total == 2)
    assert(ccb.tasks.cancel(cancel_id))
    assert(ccb.tasks.get(cancel_id) == nil)
    ccb.tasks.after(0, "new")
end)
ccb.runtime.handler("cancelled", function() ran_cancelled = ran_cancelled + 1 end)
ccb.runtime.handler("last", function()
    ran_last = ran_last + 1
    assert(ran_first == 1 and ran_cancelled == 0 and ran_new == 0)
end)
ccb.runtime.handler("new", function() ran_new = ran_new + 1 end)
)lua", sol::script_pass_on_error );
    REQUIRE( setup.valid() );
    platform::set_active_runtimes( { owner } );
    platform::runtime_world_ready( true );
    const sol::protected_function_result scheduled = lua.safe_script( R"lua(
ccb.tasks.after(0, "first")
cancel_id = ccb.tasks.after(0, "cancelled")
ccb.tasks.after(0, "last")
)lua", sol::script_pass_on_error );
    REQUIRE( scheduled.valid() );
    platform::runtime_process_tasks();
    CHECK( lua["ran_first"].get<int>() == 1 );
    CHECK( lua["ran_cancelled"].get<int>() == 0 );
    CHECK( lua["ran_last"].get<int>() == 1 );
    CHECK( lua["ran_new"].get<int>() == 0 );
    REQUIRE( owner->tasks.size() == 1 );
    CHECK( owner->tasks.front().handler_id == "new" );
    platform::runtime_process_tasks();
    CHECK( lua["ran_new"].get<int>() == 1 );
    CHECK( owner->tasks.empty() );
}
#endif
