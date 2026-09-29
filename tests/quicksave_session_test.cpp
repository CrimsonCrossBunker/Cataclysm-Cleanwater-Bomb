#include <filesystem>
#include <fstream>
#include <string>
#include <system_error>

#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "save_snapshot.h"
#include "worldfactory.h"

namespace
{
struct save_observer : event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event &e ) override {
        if( e.type() == event_type::game_save ) {
            ++saves;
        }
    }
    int saves = 0;
};
} // namespace

TEST_CASE( "quicksave_ignores_a_session_still_loading", "[save][regression]" )
{
    REQUIRE( world_generator != nullptr );
    REQUIRE( world_generator->active_world != nullptr );
    restore_on_out_of_scope restore_saves( world_generator->active_world->world_saves );
    world_generator->active_world->world_saves.clear();
    restore_on_out_of_scope restore_should_draw( g->should_draw );
    restore_on_out_of_scope restore_quit( g->uquit );
    restore_on_out_of_scope restore_new_game( g->new_game );
    restore_on_out_of_scope restore_checkpoint( g->dimension_checkpoint_pending );
    g->dimension_checkpoint_pending = GENERATE( false, true );
    const bool pending = g->dimension_checkpoint_pending;
    g->should_draw = true;
    g->uquit = QUIT_NO;
    g->new_game = true;
    save_observer observer;
    get_event_bus().subscribe( &observer );
    CHECK( capture_debugmsg_during( []() {
        g->quicksave();
    } ).empty() );
    CHECK( observer.saves == 0 );
    CHECK( g->dimension_checkpoint_pending == pending );
    CHECK( world_generator->active_world->world_saves.empty() );
}

namespace
{
struct checkpoint_save_started {};

struct stop_checkpoint_before_writing : event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event &e ) override {
        if( e.type() == event_type::game_save ) {
            throw checkpoint_save_started{};
        }
    }
};
} // namespace

TEST_CASE( "dimension_checkpoint_ignores_periodic_autosave_settings", "[save][dimension]" )
{
    clear_avatar();
    REQUIRE( world_generator != nullptr );
    REQUIRE( world_generator->active_world != nullptr );
    const override_option autosave( "AUTOSAVE", "false" );
    restore_on_out_of_scope restore_should_draw( g->should_draw );
    restore_on_out_of_scope restore_quit( g->uquit );
    restore_on_out_of_scope restore_new_game( g->new_game );
    restore_on_out_of_scope restore_checkpoint( g->dimension_checkpoint_pending );
    g->should_draw = true;
    g->uquit = QUIT_NO;
    g->new_game = false;
    g->dimension_checkpoint_pending = true;
    // Stop at the save event, before any test-world files are written. This
    // also verifies that an interrupted checkpoint remains pending for retry.
    stop_checkpoint_before_writing observer;
    get_event_bus().subscribe( &observer );
    REQUIRE_THROWS_AS( g->save_pending_dimension_checkpoint(), checkpoint_save_started );
    CHECK( g->dimension_checkpoint_pending );

    g->new_game = true;
    CHECK_NOTHROW( g->save_pending_dimension_checkpoint() );
    CHECK( g->dimension_checkpoint_pending );
}

TEST_CASE( "dimension_rollback_restores_the_last_complete_world_save", "[save][dimension]" )
{
    const std::filesystem::path temporary_root = std::filesystem::temp_directory_path();
    std::filesystem::path world_root;
    std::error_code ec;
    for( int i = 0; i < 100; ++i ) {
        const std::filesystem::path candidate = temporary_root /
                                                ( "ccb-dimension-rollback-test-" + std::to_string( i ) );
        if( std::filesystem::create_directory( candidate, ec ) ) {
            world_root = candidate;
            break;
        }
        REQUIRE( ( !ec || ec == std::errc::file_exists ) );
        ec.clear();
    }
    REQUIRE_FALSE( world_root.empty() );
    on_out_of_scope cleanup( [&world_root]() {
        std::error_code remove_error;
        std::filesystem::remove_all( world_root, remove_error );
    } );
    const cata_path world_dir( cata_path::root_path::unknown, world_root );
    const std::filesystem::path character_file = world_root / "character.sav";
    const std::filesystem::path map_dir = world_root / "maps";
    REQUIRE( std::filesystem::create_directory( map_dir ) );
    const std::filesystem::path map_file = map_dir / "submap";

    auto write_state = [&]( const std::string & value ) {
        std::ofstream( character_file ) << value;
        std::ofstream( map_file ) << value;
    };
    auto read_state = []( const std::filesystem::path & path ) {
        std::ifstream input( path );
        std::string value;
        input >> value;
        return value;
    };

    write_state( "manual" );
    REQUIRE( save_snapshot::make_dimension_rollback( world_dir, "survivor", 1 ) );
    write_state( "checkpoint" );
    CHECK( save_snapshot::dimension_rollback_exists( world_dir ) );
    REQUIRE( save_snapshot::restore_dimension_rollback( world_dir ) );
    CHECK( read_state( character_file ) == "manual" );
    CHECK( read_state( map_file ) == "manual" );
    CHECK( save_snapshot::dimension_rollback_exists( world_dir ) );

    REQUIRE( save_snapshot::delete_dimension_rollback( world_dir ) );
    CHECK_FALSE( save_snapshot::dimension_rollback_exists( world_dir ) );

    REQUIRE( save_snapshot::make_dimension_rollback( world_dir, "survivor", 1 ) );
    write_state( "new" );
    REQUIRE( save_snapshot::make_snapshot( world_dir, "chosen", "survivor", 2 ) );
    REQUIRE( save_snapshot::restore_snapshot( world_dir, "chosen" ) );
    CHECK( read_state( character_file ) == "new" );
    CHECK( read_state( map_file ) == "new" );
    CHECK_FALSE( save_snapshot::dimension_rollback_exists( world_dir ) );
}
