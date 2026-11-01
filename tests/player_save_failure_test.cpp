#include <filesystem>
#include <fstream>
#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <system_error>

#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "game.h"
#include "path_info.h"
#include "player_helpers.h"
#include "worldfactory.h"
#include "zzip.h"

TEST_CASE( "compressed_player_save_reports_unopenable_archive", "[save][regression][zzip]" )
{
    clear_avatar();
    REQUIRE( world_generator != nullptr );
    std::filesystem::path root;
    for( int i = 0; i < 100; ++i ) {
        const std::filesystem::path candidate = std::filesystem::temp_directory_path() /
                                                std::filesystem::u8path( "ccb-player-save-failure-" + std::to_string( i ) );
        std::error_code error;
        if( std::filesystem::create_directory( candidate, error ) ) {
            root = candidate;
            break;
        }
        REQUIRE( ( !error || error == std::errc::file_exists ) );
    }
    REQUIRE_FALSE( root.empty() );
    const std::string old_savedir = PATH_INFO::savedir();
    WORLD *old_world = world_generator->active_world;
    WORLD isolated_world( "unopenable_player_archive" );
    const on_out_of_scope cleanup( [&]() {
        world_generator->active_world = old_world;
        PATH_INFO::set_savedir( old_savedir );
        std::error_code error;
        std::filesystem::remove_all( root, error );
    } );
    PATH_INFO::set_savedir( root.generic_u8string() + "/" );
    world_generator->active_world = &isolated_world;
    const std::filesystem::path directory = isolated_world.folder_path().get_unrelative_path();
    REQUIRE( std::filesystem::create_directory( directory ) );
    for( const char *name : {
             "maps.dict", "mmr.dict", "overmaps.dict"
         } ) {
        REQUIRE( std::filesystem::copy_file(
                     ( PATH_INFO::compression_folder_path() / name ).get_unrelative_path(),
                     directory / name ) );
    }
    REQUIRE( isolated_world.has_compression_enabled() );
    // A directory at the archive path fails on every platform, including when
    // tests run with privileges that bypass read-only file permissions.
    const std::filesystem::path archive = ( PATH_INFO::player_base_save_path() +
                                            SAVE_EXTENSION + zzip_suffix ).get_unrelative_path();
    REQUIRE( std::filesystem::create_directory( archive ) );
    const std::filesystem::path marker = archive / "preserve.txt";
    {
        std::ofstream output( marker );
        output << "original";
        REQUIRE( output.good() );
    }
    REQUIRE_FALSE( zzip::load( archive ).has_value() );
    bool saved = true;
    const std::string error = capture_debugmsg_during( [&]() {
        saved = g->save();
    } );
    CHECK_FALSE( saved );
    CHECK( error.find( "game not saved" ) != std::string::npos );
    CHECK( std::filesystem::is_directory( archive ) );
    std::string original;
    std::ifstream( marker ) >> original;
    CHECK( original == "original" );
}
