#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "cata_path.h"
#include "lua_platform_runtime_internal.h"
#include "messages.h"
#include "path_info.h"
#include "worldfactory.h"

TEST_CASE( "lua_platform_bad_saved_task_error_identifies_its_record",
           "[lua][platform][runtime][persistence]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    Messages::clear_messages();
    REQUIRE( world_generator != nullptr );
    const platform_lua_test_directory temporary;
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "saved_task_diagnostic" );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> runtime =
        platform::make_runtime( "broken-owner", 1904, lua );
    const on_out_of_scope cleanup( [&]() {
        platform::clear_active_runtimes();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
        Messages::clear_messages();
    } );
    PATH_INFO::set_savedir( temporary.root.string() + "/" );
    world_generator->active_world = &isolated_world;
    const std::filesystem::path directory = isolated_world.folder_path().get_unrelative_path();
    REQUIRE( std::filesystem::create_directory( directory ) );
    const std::filesystem::path state_path = directory / "lua_platform_world.json";
    {
        std::ofstream stream( state_path );
        REQUIRE( stream.good() );
        stream << R"({"version":1,"scope":"world","mods":{"broken-owner":{
            "values":{},"tasks":[{"id":42,"handler":"","due_turn":0,
            "payload_version":1,"payload":{}}]}}})";
        stream.close();
        REQUIRE( stream.good() );
    }
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( false );
    CHECK( runtime->world_state.empty() );
    CHECK( runtime->tasks.empty() );
    const auto messages = Messages::recent_messages( 10 );
    const auto error = std::find_if( messages.begin(), messages.end(),
    []( const auto &entry ) {
        return entry.second.find( "handler id cannot be empty" ) != std::string::npos;
    } );
    REQUIRE( error != messages.end() );
    CHECK( error->second.find( state_path.generic_u8string() ) != std::string::npos );
    CHECK( error->second.find( "scope=world" ) != std::string::npos );
    CHECK( error->second.find( "Mod='broken-owner'" ) != std::string::npos );
    CHECK( error->second.find( "task[0], id=42" ) != std::string::npos );
}
#endif
