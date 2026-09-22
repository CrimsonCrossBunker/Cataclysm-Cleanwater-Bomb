#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include <avatar.h>
#include <character_id.h>
#include <lua_platform_handle.h>
#include <initializer_list>
#include "cata_path.h"
#include "calendar.h"
#include "lua_platform_state.h"
#include "lua_platform_bindings_coords.h"
#include <variant>
#include "lua_platform_runtime_internal.h"
#include "path_info.h"
#include "worldfactory.h"
#include <cata_scope_helpers.h>
#include "flexbuffer_json.h"
#include <json_loader.h>
#include <lua_platform_runtime.h>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <functional>
#include <limits>
#include <memory>
#include <string>
#include <vector>
#include "cata_catch.h"
#include "lua_platform_sol.h"

TEST_CASE( "lua_platform_task_counter_survives_empty_save_and_exhaustion",
           "[lua][platform][tasks][persistence]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    REQUIRE( world_generator != nullptr );
    const platform_lua_test_directory temporary;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "task_counter_persistence" );
    sol::state old_lua;
    sol::state new_lua;
    const on_out_of_scope cleanup( [&]() {
        platform::clear_active_runtimes();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( temporary.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    const auto install = []( sol::state & lua ) {
        const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                    "counter-owner", 2010, lua );
        sol::table ccb = lua.create_table();
        platform::install_runtime_api( owner, lua, ccb );
        lua["ccb"] = ccb;
        lua.set_function( "noop", []() {} );
        const sol::protected_function_result registered = ccb["runtime"]["handler"](
                    "tick", lua["noop"] );
        REQUIRE( registered.valid() );
        platform::set_active_runtimes( { owner } );
        return owner;
    };
    const auto schedule = []( sol::state & lua ) {
        const sol::protected_function_result result = lua["ccb"]["tasks"]["after"](
                    100, "tick", lua.create_table(), 1, "world" );
        REQUIRE( result.valid() );
        return result.get<std::int64_t>();
    };
    const std::shared_ptr<platform::runtime> before = install( old_lua );
    platform::runtime_world_ready( true );
    bool exhausted = false;
    SECTION( "cancelled task ids are not reused" ) {
        const std::int64_t id = schedule( old_lua );
        const sol::protected_function_result cancelled = old_lua["ccb"]["tasks"]["cancel"]( id );
        REQUIRE( cancelled.valid() );
        REQUIRE( cancelled.get<bool>() );
        REQUIRE( before->tasks.empty() );
    }
    SECTION( "exhausted signed id space remains exhausted" ) {
        before->next_task_id = static_cast<std::uint64_t>(
                                   std::numeric_limits<std::int64_t>::max() ) + 1;
        exhausted = true;
    }
    const std::uint64_t expected_next = before->next_task_id;
    std::string error;
    REQUIRE( platform::runtime_save( error ) );
    const cata_path saved = isolated_world.folder_path() / "lua_platform_world.json";
    const JsonObject root = json_loader::from_path( saved ).get_object();
    root.allow_omitted_members();
    const JsonObject mods = root.get_object( "mods" );
    mods.allow_omitted_members();
    const JsonObject record = mods.get_object( "counter-owner" );
    record.allow_omitted_members();
    CHECK( record.get_int64( "last_task_id" ) == static_cast<std::int64_t>( expected_next - 1 ) );
    platform::clear_active_runtimes();
    const std::shared_ptr<platform::runtime> after = install( new_lua );
    platform::runtime_world_ready( false );
    REQUIRE( after->tasks.empty() );
    CHECK( after->next_task_id == expected_next );
    if( exhausted ) {
        const sol::protected_function_result result = new_lua["ccb"]["tasks"]["after"](
                    100, "tick", new_lua.create_table(), 1, "world" );
        CHECK_FALSE( result.valid() );
        CHECK( after->tasks.empty() );
    } else {
        const std::int64_t new_id = schedule( new_lua );
        CHECK( static_cast<std::uint64_t>( new_id ) == expected_next );
        const sol::protected_function_result cancelled = new_lua["ccb"]["tasks"]["cancel"](
                    new_id - 1 );
        REQUIRE( cancelled.valid() );
        CHECK_FALSE( cancelled.get<bool>() );
        CHECK( after->tasks.size() == 1 );
    }
}

TEST_CASE( "lua_platform_preserves_absent_mod_task_counters_and_reads_legacy_records",
           "[lua][platform][tasks][persistence]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    REQUIRE( world_generator != nullptr );
    const platform_lua_test_directory temporary;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "orphan_task_counter" );
    sol::state lua;
    const on_out_of_scope cleanup( [&]() {
        platform::clear_active_runtimes();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( temporary.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    const cata_path saved = isolated_world.folder_path() / "lua_platform_world.json";
    std::string source;
    SECTION( "counter without pending tasks" ) {
        source = R"({"last_task_id":77,"values":{},"tasks":[]})";
    }
    SECTION( "legacy pending task without counter" ) {
        source = R"({"values":{},"tasks":[{"id":77,"handler":"tick","due_turn":9223372036854775807,"payload_version":1,"payload":{}}]})";
    }
    {
        std::ofstream output( saved.get_unrelative_path() );
        output << R"({"version":1,"scope":"world","mods":{"absent-owner":)" << source << "}}";
        output.close();
        REQUIRE( output.good() );
    }
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime( "other-owner", 2011, lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    platform::runtime_world_ready( false );
    std::string error;
    REQUIRE( platform::runtime_save( error ) );
    const JsonObject root = json_loader::from_path( saved ).get_object();
    root.allow_omitted_members();
    const JsonObject mods = root.get_object( "mods" );
    mods.allow_omitted_members();
    const JsonObject retained = mods.get_object( "absent-owner" );
    retained.allow_omitted_members();
    CHECK( retained.get_int64( "last_task_id" ) == 77 );
}
TEST_CASE( "lua_platform_null_payload_and_world_state_survive_runtime_reload",
           "[lua][platform][tasks][persistence][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    REQUIRE( world_generator != nullptr );
    const platform_lua_test_directory temporary;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "null_payload_persistence" );
    sol::state old_lua;
    sol::state new_lua;
    restore_on_out_of_scope restore_turn( calendar::turn );
    const on_out_of_scope cleanup( [&]() {
        platform::clear_active_runtimes();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( temporary.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    int calls = 0;
    const auto install = [&calls]( sol::state & lua ) {
        const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                    "null-payload-owner", 4910, lua );
        sol::table ccb = lua.create_table();
        platform::install_runtime_api( owner, lua, ccb );
        lua["ccb"] = ccb;
        lua.set_function( "receive", [&calls]( const sol::table & context ) {
            const sol::table payload = context["payload"];
            CHECK( payload.get<sol::object>( "empty" ).is<platform::script_null_value>() );
            CHECK( payload.get<sol::object>( "missing" ).get_type() == sol::type::nil );
            const sol::table array = payload["array"];
            CHECK( array.size() == 2 );
            CHECK( array.get<sol::object>( 1 ).is<platform::script_null_value>() );
            CHECK( array.get<std::int64_t>( 2 ) == 42 );
            const auto position = payload.get<platform::script_tripoint_coord>( "position" );
            CHECK( position.x() == -17 );
            CHECK( position.y() == 42 );
            CHECK( position.z() == -3 );
            CHECK( position.origin() == "abs" );
            CHECK( position.scale() == "ms" );
            ++calls;
        } );
        const sol::protected_function_result registered = ccb["runtime"]["handler"](
                    "tick", lua["receive"] );
        REQUIRE( registered.valid() );
        platform::set_active_runtimes( { owner } );
        return owner;
    };
    const std::shared_ptr<platform::runtime> before = install( old_lua );
    platform::runtime_world_ready( true );
    platform::assign_persistent_value( before->world_state, "empty", platform::script_null_value{} );
    sol::table payload = old_lua.create_table();
    payload["empty"] = platform::script_null_value{};
    sol::table array = old_lua.create_table();
    array[1] = platform::script_null_value{};
    array[2] = std::int64_t( 42 );
    payload["array"] = array;
    payload["position"] = platform::script_tripoint_coord::from( "abs", "ms", -17, 42, -3 );
    // Named nested maps are not dense arrays and must not create a task.
    sol::table nested_payload = old_lua.create_table();
    nested_payload["__ccb_task"] = true;
    nested_payload["data"] = payload;
    const sol::protected_function_result rejected = old_lua["ccb"]["tasks"]["after"](
                1, "tick", nested_payload, 1, "world" );
    CHECK_FALSE( rejected.valid() );
    CHECK( before->tasks.empty() );
    const sol::protected_function_result scheduled = old_lua["ccb"]["tasks"]["after"](
                1, "tick", payload, 1, "world" );
    REQUIRE( scheduled.valid() );
    array[2] = std::int64_t( 99 );
    std::string error;
    REQUIRE( platform::runtime_save( error ) );
    platform::clear_active_runtimes();
    const std::shared_ptr<platform::runtime> after = install( new_lua );
    platform::runtime_world_ready( false );
    REQUIRE( after->tasks.size() == 1 );
    CHECK( std::holds_alternative<platform::script_null_value>
           ( after->tasks.front().payload.at( "empty" ) ) );
    CHECK( std::holds_alternative<platform::script_null_value>( after->world_state.at( "empty" ) ) );
    calendar::turn += 1_turns;
    platform::runtime_process_tasks();
    CHECK( calls == 1 );
    CHECK( after->tasks.empty() );
}

TEST_CASE( "lua_platform_nil_task_payload_preserves_metadata_and_save_scope",
           "[lua][platform][tasks][persistence][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    REQUIRE( world_generator != nullptr );
    const platform_lua_test_directory temporary;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "nil_task_payload" );
    sol::state lua;
    const on_out_of_scope cleanup( [&]() {
        platform::clear_active_runtimes();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
    } );
    PATH_INFO::set_savedir( temporary.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    lua.open_libraries( sol::lib::base );
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
                "optional-task-owner", 4911, lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    lua["ccb"] = ccb;
    const sol::protected_function_result registered = lua.safe_script(
                "ccb.runtime.handler('tick', function() end)", sol::script_pass_on_error );
    REQUIRE( registered.valid() );
    platform::set_active_runtimes( { owner } );
    platform::runtime_world_ready( true );
    lua["actor"] = platform::game_handle::from_creature(
                       get_avatar(), { "avatar", get_avatar().getID().get_value(), 0, 0, 0, {} },
                       owner->handle_runtime(), platform::runtime_world_generation() );
    lua["actor_id"] = get_avatar().getID().get_value();
    const std::uint64_t next_id = owner->next_task_id;
    const sol::protected_function_result rejected = lua.safe_script( R"(
        for _, method in ipairs({"after", "every"}) do
            local create = ccb.tasks[method]
            for _, invalid in ipairs({false, 7, "bad", function() end}) do
                assert(not pcall(create, 5, "tick", invalid, 1, "character"))
            end
            assert(not pcall(create, 5, "tick", nil, 99, "character"))
            assert(not pcall(create, 5, "tick", nil, 1, "invalid"))
            assert(ccb.tasks.list().total == 0)
        end
    )", sol::script_pass_on_error );
    REQUIRE( rejected.valid() );
    CHECK( owner->tasks.empty() );
    CHECK( owner->next_task_id == next_id );
    const sol::protected_function_result scheduled = lua.safe_script( R"(
        for _, method in ipairs({"after", "every"}) do
            local create = ccb.tasks[method]
            local id = create(5, "tick", nil, 1, "character", actor, {target=actor})
            local task = ccb.tasks.get(id)
            assert(task.owner == "character" and task.payload_version == 1)
            assert(next(task.payload) == nil)
            assert(task.actor_character_id == actor_id)
            assert(task.participants.target.character_id == actor_id)
            assert(task.recurring == (method == "every"))
            local default = ccb.tasks.get(create(5, "tick"))
            assert(default.owner == "world" and default.payload_version == 1)
            assert(next(default.payload) == nil)
        end
    )", sol::script_pass_on_error );
    REQUIRE( scheduled.valid() );
    REQUIRE( owner->tasks.size() == 4 );
    std::string error;
    REQUIRE( platform::runtime_save( error ) );
    const cata_path character_path = PATH_INFO::player_base_save_path() + ".lua_platform.json";
    const cata_path world_path = isolated_world.folder_path() / "lua_platform_world.json";
    for( const cata_path &path : {
             character_path, world_path
         } ) {
        const JsonObject root = json_loader::from_path( path ).get_object();
        root.allow_omitted_members();
        CHECK( root.get_string( "scope" ) == ( path == character_path ? "character" : "world" ) );
        const JsonObject mods = root.get_object( "mods" );
        mods.allow_omitted_members();
        const JsonObject record = mods.get_object( "optional-task-owner" );
        record.allow_omitted_members();
        const JsonArray tasks = record.get_array( "tasks" );
        REQUIRE( tasks.size() == 2 );
        for( const JsonObject task : tasks ) {
            task.allow_omitted_members();
            CHECK( task.get_int( "payload_version" ) == 1 );
            CHECK( task.get_object( "payload" ).size() == 0 );
            CHECK( task.has_member( "actor_character_id" ) == ( path == character_path ) );
        }
    }
}

#endif
