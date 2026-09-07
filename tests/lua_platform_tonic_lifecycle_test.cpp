#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "itype.h"
#include "lua_platform_runtime_internal.h"
#include "path_info.h"
#include "worldfactory.h"

TEST_CASE( "lua_platform_tonic_survives_character_and_runtime_reload",
           "[lua][platform][playable_mvp][persistence]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    clear_avatar();
    avatar &player = get_avatar();
    player.setID( character_id( 4401 ), true );
    const time_point old_turn = calendar::turn;
    const std::string old_savedir = PATH_INFO::savedir();
    REQUIRE( world_generator != nullptr );
    WORLD *old_world = world_generator->active_world;
    const platform_lua_test_directory temporary;
    const std::filesystem::path &directory = temporary.root;
    WORLD isolated_world( directory.filename().string() + "_tonic" );
    const on_out_of_scope cleanup( [&]() {
        platform::shutdown();
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
        calendar::turn = old_turn;
        clear_avatar();
    } );
    PATH_INFO::set_savedir( directory.string() + "/" );
    world_generator->active_world = &isolated_world;
    REQUIRE( std::filesystem::create_directory( isolated_world.folder_path().get_unrelative_path() ) );
    const auto root = PATH_INFO::moddir().get_unrelative_path() / "Lua_First_Example";
    const platform::mod_source source { "Lua_First_Example", root, root / "main.lua" };
    const auto load = [&]( bool new_game ) {
        std::string error;
        REQUIRE( platform::prepare_mods( { source }, error ) );
        REQUIRE( platform::apply_prepared_content( error ) );
        REQUIRE( platform::validate_finalized_prepared_content( error ) );
        platform::commit_prepared_mods();
        REQUIRE( platform::loaded_mod_ids() == std::vector<std::string> { source.id } );
        platform::runtime_world_ready( new_game );
    };
    const auto integer_state = [&]( const std::string & key ) {
        const auto owner = platform::detail::find_active_runtime( source.id );
        REQUIRE( owner );
        sol::table ccb = ( *owner->lua )["package"]["loaded"]["ccb"];
        sol::protected_function_result call = ccb["state"]["character"]["get"]( key, 0 );
        REQUIRE( call.valid() );
        return call.get<int>();
    };
    const auto save = [&]() {
        platform::runtime_before_save();
        std::string error;
        REQUIRE( platform::runtime_save( error ) );
        platform::runtime_after_save( true, error );
        std::ofstream stream( directory / "avatar.json" );
        JsonOut json( stream );
        player.serialize( json );
    };
    load( true );
    const itype_id tonic_id( "lua_first_nano_tonic" );
    const itype_id cell_id( "lua_first_cleanwater_cell" );
    const efftype_id recovery( "lua_first_nano_recovery" );
    REQUIRE( tonic_id.is_valid() );
    REQUIRE( recovery.is_valid() );
    item tonic( tonic_id );
    const auto use = [&]() {
        const auto used = tonic.type->invoke( &player, tonic, &get_map(), player.pos_bub() );
        REQUIRE( used );
        CHECK( *used == 0 );
    };
    player.set_stamina( 1000 );
    use(); // Empty resource path must not create a task or cooldown.
    CHECK( integer_state( "tonic_ready_at" ) == 0 );
    CHECK_FALSE( player.has_effect( recovery ) );
    REQUIRE( player.wear_item( item( itype_id( "backpack" ) ), false ) );
    player.i_add( item( cell_id ) );
    player.i_add( item( cell_id ) );
    REQUIRE( player.amount_of( cell_id ) == 2 );
    use();
    CHECK( player.amount_of( cell_id ) == 1 );
    CHECK( player.has_effect( recovery ) );
    CHECK( integer_state( "tonic_events" ) == 1 );
    CHECK( integer_state( "tonic_task" ) > 0 );
    use(); // Cooldown does not consume a second resource or schedule a duplicate.
    CHECK( player.amount_of( cell_id ) == 1 );
    calendar::turn += 10_seconds;
    platform::runtime_process_tasks();
    CHECK( player.get_stamina() == 1100 );
    CHECK( integer_state( "lua_first_tonic_ticks" ) == 1 );
    save();
    const std::weak_ptr<platform::runtime> previous = platform::detail::find_active_runtime(
            source.id );
    // Keep static definitions cached, but retire the active registry so the loader
    // cannot transfer in-memory character state or tasks during replacement.
    platform::clear_active_runtimes();
    clear_avatar();
    REQUIRE( !player.has_effect( recovery ) );
    std::ifstream stream( directory / "avatar.json" );
    std::stringstream saved;
    saved << stream.rdbuf();
    player.setID( character_id(), true );
    player.deserialize( json_loader::from_string( saved.str() ).get_object() );
    REQUIRE( player.get_stamina() == 1100 );
    REQUIRE( player.amount_of( cell_id ) == 1 );
    REQUIRE( player.has_effect( recovery ) );
    std::string reload_error;
    const bool reloaded = platform::reload_active_mods( reload_error );
    INFO( reload_error );
    REQUIRE( reloaded );
    REQUIRE( previous.expired() );
    {
        const auto fresh = platform::detail::find_active_runtime( source.id );
        REQUIRE( fresh );
        REQUIRE( fresh->character_state.empty() );
        REQUIRE( fresh->tasks.empty() );
    }
    // Only the sidecar can supply progress to this fresh runtime.
    platform::runtime_world_ready( false );
    CHECK( integer_state( "lua_first_tonic_ticks" ) == 1 );
    CHECK( integer_state( "tonic_events" ) == 1 );
    use();
    CHECK( player.amount_of( cell_id ) == 1 );
    for( const int expected : {
             1200, 1300
         } ) {
        calendar::turn += 10_seconds;
        platform::runtime_process_tasks();
        CHECK( player.get_stamina() == expected );
    }
    CHECK( integer_state( "lua_first_tonic_ticks" ) == 3 );
    CHECK( integer_state( "tonic_task" ) == 0 );
    CHECK_FALSE( player.has_effect( recovery ) );
    platform::runtime_process_tasks();
    CHECK( player.get_stamina() == 1300 );
    CHECK( integer_state( "lua_first_tonic_ticks" ) == 3 );
    calendar::turn += 30_seconds;
    use(); // Persisted cooldown expires; the remaining resource starts a fresh cycle.
    CHECK( player.amount_of( cell_id ) == 0 );
    CHECK( integer_state( "tonic_events" ) == 2 );
    CHECK( player.has_effect( recovery ) );
}
#endif
