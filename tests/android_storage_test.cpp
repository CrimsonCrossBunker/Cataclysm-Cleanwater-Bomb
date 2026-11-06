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
    const std::filesystem::path root = test_directory / "android-storage-migration";
    REQUIRE( root.parent_path() == test_directory );
    std::filesystem::remove_all( root );
    const on_out_of_scope cleanup( [&root]() {
        std::filesystem::remove_all( root );
    } );
    const std::filesystem::path source = root / "legacy";
    const std::filesystem::path destination = root / "documents";
    std::filesystem::create_directories( source );
    std::filesystem::create_directories( destination );
    const std::filesystem::path marker = destination / ".legacy-android-migration-v1.complete";

    SECTION( "fresh_install_has_no_optional_legacy_directories" ) {
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( std::filesystem::is_regular_file( marker ) );
        CHECK_FALSE( debug_has_error_been_observed() );
    }

    SECTION( "copy_missing_files_without_overwriting_documents" ) {
        std::filesystem::create_directories( source / "config" );
        std::filesystem::create_directories( destination / "config" );
        std::ofstream( source / "config/options.json" ) << "legacy";
        std::ofstream( destination / "config/options.json" ) << "documents";
        std::ofstream( source / "config/keybindings.json" ) << "keybindings";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( read_entire_file( destination / "config/options.json" ) == "documents" );
        CHECK( read_entire_file( destination / "config/keybindings.json" ) == "keybindings" );
        CHECK( std::filesystem::is_regular_file( marker ) );
    }

    SECTION( "existing_worlds_are_kept_whole" ) {
        std::filesystem::create_directories( source / "save/existing" );
        std::filesystem::create_directories( source / "save/new" );
        std::filesystem::create_directories( destination / "save/existing" );
        std::ofstream( source / "save/existing/legacy.sav" ) << "legacy";
        std::ofstream( source / "save/new/player.sav" ) << "new";
        std::ofstream( destination / "save/existing/player.sav" ) << "documents";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK_FALSE( std::filesystem::exists( destination / "save/existing/legacy.sav" ) );
        CHECK( read_entire_file( destination / "save/existing/player.sav" ) == "documents" );
        CHECK( read_entire_file( destination / "save/new/player.sav" ) == "new" );
        CHECK( std::filesystem::is_regular_file( marker ) );
    }

    SECTION( "completed_migration_is_not_repeated" ) {
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        REQUIRE( std::filesystem::is_regular_file( marker ) );
        std::filesystem::create_directories( source / "config" );
        std::ofstream( source / "config/new.json" ) << "new";
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK_FALSE( std::filesystem::exists( destination / "config/new.json" ) );
    }

    SECTION( "failed_copy_can_be_retried" ) {
        std::filesystem::create_directories( source / "config" );
        std::ofstream( source / "config/options.json" ) << "legacy";
        std::ofstream( destination / "config" ) << "blocks directory creation";
        REQUIRE_FALSE( debug_has_error_been_observed() );
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( debug_has_error_been_observed() );
        debug_reset_error_observed();
        CHECK_FALSE( std::filesystem::exists( marker ) );
        std::filesystem::remove( destination / "config" );
        migrate_legacy_android_user_data( source.u8string(), destination.u8string() );
        CHECK( std::filesystem::is_regular_file( marker ) );
        CHECK( read_entire_file( destination / "config/options.json" ) == "legacy" );
    }
}

