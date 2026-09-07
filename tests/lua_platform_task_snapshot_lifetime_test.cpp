#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"

namespace
{
// Model task cancellation at a Lua allocation boundary without relying on the
// collector's nondeterministic choice of when to run a Lua __gc callback.
struct task_snapshot_allocator {
    lua_Alloc original = nullptr;
    void *original_data = nullptr;
    cata::lua_platform::runtime *owner = nullptr;
    bool armed = false;
    bool cancelled = false;

    static void *allocate( void *data, void *pointer, std::size_t old_size,
                           std::size_t new_size ) {
        auto &probe = *static_cast<task_snapshot_allocator *>( data );
        if( probe.armed && new_size > 0 ) {
            probe.armed = false;
            probe.owner->tasks.erase( probe.owner->tasks.begin() );
            probe.cancelled = true;
        }
        return probe.original( probe.original_data, pointer, old_size, new_size );
    }
};
} // namespace

TEST_CASE( "lua_platform_task_queries_detach_records_before_lua_allocation",
           "[lua][platform][tasks]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory directory;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    directory.write( "main.lua", R"lua(
local ccb = require("ccb")
ccb.runtime.handler("tick", function() end)
query_get = ccb.tasks.get
query_next = ccb.tasks.next
query_list = ccb.tasks.list
)lua" );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "snapshot-lifetime", directory.root, directory.root / "main.lua" }
    }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
                "snapshot-lifetime" );
    REQUIRE( owner );
    lua_State *lua = owner->lua->lua_state();
    REQUIRE( lua_checkstack( lua, 32 ) );
    const auto populate = [&owner]() {
        owner->tasks.clear();
        for( std::uint64_t id : { 11U, 12U, 13U } ) {
            platform::persistent_task task;
            task.id = id;
            task.handler_id = "tick";
            task.owner = "world";
            task.owner_mod_id = "snapshot-lifetime";
            task.due_turn = static_cast<std::int64_t>( id );
            owner->tasks.push_back( std::move( task ) );
        }
    };
    for( const char *query : { "query_get", "query_next", "query_list" } ) {
        INFO( query );
        populate();
        const auto push_query = [lua, query]() {
            lua_getglobal( lua, query );
            if( std::string_view( query ) == "query_get" ) {
                lua_pushinteger( lua, 11 );
                return 1;
            }
            if( std::string_view( query ) == "query_next" ) {
                lua_pushliteral( lua, "tick" );
                return 1;
            }
            lua_pushnil( lua );
            lua_pushnil( lua );
            lua_pushinteger( lua, 2 );
            return 3;
        };
        // Warm the call frame and interned names before arming the probe.
        int arguments = push_query();
        REQUIRE( lua_pcall( lua, arguments, 1, 0 ) == LUA_OK );
        lua_pop( lua, 1 );
        arguments = push_query();
        task_snapshot_allocator probe;
        probe.owner = owner.get();
        probe.original = lua_getallocf( lua, &probe.original_data );
        const on_out_of_scope restore_allocator( [&]() {
            lua_setallocf( lua, probe.original, probe.original_data );
        } );
        lua_setallocf( lua, task_snapshot_allocator::allocate, &probe );
        probe.armed = true;
        REQUIRE( lua_pcall( lua, arguments, 1, 0 ) == LUA_OK );
        REQUIRE( probe.cancelled );
        REQUIRE( owner->tasks.size() == 2 );
        CHECK( owner->tasks.front().id == 12 );
        REQUIRE( lua_istable( lua, -1 ) );
        if( std::string_view( query ) == "query_list" ) {
            lua_getfield( lua, -1, "items" );
            for( int index = 1; index <= 2; ++index ) {
                lua_rawgeti( lua, -1, index );
                lua_getfield( lua, -1, "id" );
                CHECK( lua_tointeger( lua, -1 ) == 10 + index );
                lua_pop( lua, 2 );
            }
            lua_pop( lua, 1 );
        } else {
            lua_getfield( lua, -1, "id" );
            CHECK( lua_tointeger( lua, -1 ) == 11 );
            lua_pop( lua, 1 );
        }
        lua_pop( lua, 1 );
    }
}
#endif
