#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"
#include <cata_scope_helpers.h>
extern "C" {
    extern "C" {
#include <lua.h>
    }
}
#include <lua_platform_loader.h>
#include <lua_platform_runtime.h>
#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <string_view>
#include <utility>
#include <variant>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"

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
    bool observe_migration = false;
    bool migration_guarded = true;
    int observed_allocations = 0;

    static void *allocate( void *data, void *pointer, std::size_t old_size,
                           std::size_t new_size ) {
        task_snapshot_allocator &probe = *static_cast<task_snapshot_allocator *>( data );
        if( probe.armed && new_size > 0 ) {
            if( probe.observe_migration ) {
                probe.migration_guarded = probe.migration_guarded && probe.owner->task_migration_active;
                ++probe.observed_allocations;
            } else {
                probe.armed = false;
                probe.owner->tasks.erase( probe.owner->tasks.begin() );
                probe.cancelled = true;
            }
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
    directory.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("tick", function() end)
query_get = ccb.tasks.get
query_next = ccb.tasks.next
query_list = ccb.tasks.list
)lua" );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "snapshot-lifetime", directory.root, directory.root / std::filesystem::u8path( "main.lua" ) }
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
        for( std::uint64_t id : {
                 11U, 12U, 13U
             } ) {
            platform::persistent_task task;
            task.id = id;
            task.handler_id = "tick";
            task.owner = "world";
            task.owner_mod_id = "snapshot-lifetime";
            task.due_turn = static_cast<std::int64_t>( id );
            owner->tasks.push_back( std::move( task ) );
        }
    };
    for( const char *query : {
             "query_get", "query_next", "query_list"
         } ) {
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

TEST_CASE( "lua_platform_task_migration_guards_all_lua_allocation_boundaries",
           "[lua][platform][tasks][persistence]" )
{
    namespace platform = cata::lua_platform;
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime( "migration-guard", 2013,
        lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    lua["ccb"] = ccb;
    owner->world_is_ready = true;
    bool valid_result = true;
    SECTION( "valid migrated payload" ) {}
    SECTION( "invalid result preserves the original task and restores the guard" ) {
        valid_result = false;
    }
    lua["valid_result"] = valid_result;
    const sol::protected_function_result setup = lua.safe_script( R"lua(
ccb.runtime.handler("tick", function() end, 2)
ccb.runtime.migrate_task_payload("tick", 1, 2, function(payload)
    assert(not pcall(ccb.tasks.cancel, 41))
    if valid_result then return {value = payload.value + 1} end
    return nil
end)
)lua", sol::script_pass_on_error );
    REQUIRE( setup.valid() );
    platform::persistent_task task;
    task.id = 41;
    task.handler_id = "tick";
    task.payload["value"] = std::int64_t( 1 );
    owner->tasks.push_back( std::move( task ) );
    task_snapshot_allocator probe;
    probe.owner = owner.get();
    probe.observe_migration = true;
    probe.original = lua_getallocf( lua.lua_state(), &probe.original_data );
    bool migrated = false;
    std::string error;
    {
        const on_out_of_scope restore_allocator( [&]() {
            lua_setallocf( lua.lua_state(), probe.original, probe.original_data );
        } );
        lua_setallocf( lua.lua_state(), task_snapshot_allocator::allocate, &probe );
        probe.armed = true;
        migrated = platform::detail::migrate_task_payload( *owner, owner->tasks.front(), error );
        probe.armed = false;
    }
    CHECK( probe.observed_allocations > 0 );
    CHECK( probe.migration_guarded );
    CHECK_FALSE( owner->task_migration_active );
    CHECK( migrated == valid_result );
    REQUIRE( owner->tasks.size() == 1 );
    CHECK( owner->tasks.front().payload_version == ( valid_result ? 2 : 1 ) );
    CHECK( std::get<std::int64_t>( owner->tasks.front().payload.at( "value" ) ) ==
           ( valid_result ? 2 : 1 ) );
    CHECK( error.empty() == valid_result );
}
#endif
