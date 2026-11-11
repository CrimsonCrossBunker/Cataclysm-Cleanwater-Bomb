#include <functional>
#include <filesystem>
#include <fstream>
#include <string>

#include "android_storage.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "filesystem.h"
#include "path_info.h"

TEST_CASE( "android_storage_migration", "[android][filesystem]" )
{
    const std::filesystem::path test_directory = std::filesystem::canonical(
                std::filesystem::u8path( PATH_INFO::user_dir() ) );
    const std::filesystem::path root = test_directory /
                                       std::filesystem::u8path( "android-storage-migration" );
    REQUIRE( root.parent_path() == test_directory );
    std::filesystem::remove_all( root );
    const on_out_of_scope cleanup( [&root]() {
        std::filesystem::remove_all( root );
    } );
    const std::filesystem::path source = root / std::filesystem::u8path( "legacy" );
    const std::filesystem::path destination = root / std::filesystem::u8path( "documents" );
    std::filesystem::create_directories( source );
    std::filesystem::create_directories( destination );
    const std::filesystem::path marker = destination /
                                         std::filesystem::u8path( ".legacy-android-migration-v1.complete" );

    SECTION( "fresh_install_has_no_optional_legacy_directories" ) {
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( std::filesystem::is_regular_file( marker ) );
        CHECK_FALSE( debug_has_error_been_observed() );
    }

    SECTION( "copy_missing_files_without_overwriting_documents" ) {
        std::filesystem::create_directories( source / std::filesystem::u8path( "config" ) );
        std::filesystem::create_directories( destination / std::filesystem::u8path( "config" ) );
        std::ofstream( source / std::filesystem::u8path( "config/options.json" ) ) << "legacy";
        std::ofstream( destination / std::filesystem::u8path( "config/options.json" ) ) << "documents";
        std::ofstream( source / std::filesystem::u8path( "config/keybindings.json" ) ) << "keybindings";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( read_entire_file( destination / std::filesystem::u8path( "config/options.json" ) ) ==
               "documents" );
        CHECK( read_entire_file( destination / std::filesystem::u8path( "config/keybindings.json" ) ) ==
               "keybindings" );
        CHECK( std::filesystem::is_regular_file( marker ) );
    }

    SECTION( "existing_worlds_are_kept_whole" ) {
        std::filesystem::create_directories( source / std::filesystem::u8path( "save/existing" ) );
        std::filesystem::create_directories( source / std::filesystem::u8path( "save/new" ) );
        std::filesystem::create_directories( destination / std::filesystem::u8path( "save/existing" ) );
        std::ofstream( source / std::filesystem::u8path( "save/existing/legacy.sav" ) ) << "legacy";
        std::ofstream( source / std::filesystem::u8path( "save/new/player.sav" ) ) << "new";
        std::ofstream( destination / std::filesystem::u8path( "save/existing/player.sav" ) ) << "documents";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK_FALSE( std::filesystem::exists( destination /
                                              std::filesystem::u8path( "save/existing/legacy.sav" ) ) );
        CHECK( read_entire_file( destination / std::filesystem::u8path( "save/existing/player.sav" ) ) ==
               "documents" );
        CHECK( read_entire_file( destination / std::filesystem::u8path( "save/new/player.sav" ) ) ==
               "new" );
        CHECK( std::filesystem::is_regular_file( marker ) );
    }

    SECTION( "world_and_character_paths_preserve_utf8" ) {
        const std::filesystem::path world = std::filesystem::u8path( u8"save/survivor_\u96ea" );
        const std::filesystem::path character = std::filesystem::u8path( u8"player_\u00e9.sav" );
        std::filesystem::create_directories( source / world );
        std::ofstream( source / world / character ) << "saved character";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( std::filesystem::is_regular_file( destination / world / character ) );
        CHECK( read_entire_file( destination / world / character ) == "saved character" );
        CHECK( std::filesystem::is_regular_file( marker ) );
    }

    SECTION( "completed_migration_is_not_repeated" ) {
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        REQUIRE( std::filesystem::is_regular_file( marker ) );
        std::filesystem::create_directories( source / std::filesystem::u8path( "config" ) );
        std::ofstream( source / std::filesystem::u8path( "config/new.json" ) ) << "new";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK_FALSE( std::filesystem::exists( destination /
                                              std::filesystem::u8path( "config/new.json" ) ) );
    }

    SECTION( "failed_copy_can_be_retried" ) {
        std::filesystem::create_directories( source / std::filesystem::u8path( "config" ) );
        std::ofstream( source / std::filesystem::u8path( "config/options.json" ) ) << "legacy";
        std::ofstream( destination / std::filesystem::u8path( "config" ) ) << "blocks directory creation";
        REQUIRE_FALSE( debug_has_error_been_observed() );
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( debug_has_error_been_observed() );
        debug_reset_error_observed();
        CHECK_FALSE( std::filesystem::exists( marker ) );
        std::filesystem::remove( destination / std::filesystem::u8path( "config" ) );
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( std::filesystem::is_regular_file( marker ) );
        CHECK( read_entire_file( destination / std::filesystem::u8path( "config/options.json" ) ) ==
               "legacy" );
    }
}

