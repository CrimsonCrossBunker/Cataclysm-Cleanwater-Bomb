#include "cata_catch.h"

#include <filesystem>
#include <fstream>

#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "path_info.h"
#include "rng.h"
#include "save_snapshot.h"
#include "world_identity_store.h"
#include "worldfactory.h"

namespace
{
struct world_files {
    cata_path root = PATH_INFO::user_dir_path() / "world_identity_test";
    world_files() {
        REQUIRE_FALSE( std::filesystem::exists( root.get_unrelative_path() ) );
        std::filesystem::create_directories( root.get_unrelative_path() );
    }
    ~world_files() {
        std::filesystem::remove_all( root.get_unrelative_path() );
    }
    void write( const std::string &name, const std::string &text ) const {
        write_to_file( root / name, [&]( std::ostream & out ) {
            out << text;
        } );
    }
    std::string read( const std::string &name ) const {
        std::ifstream in( ( root / name ).get_unrelative_path() );
        return std::string( std::istreambuf_iterator<char>( in ), {} );
    }
};
} // namespace

TEST_CASE( "world_identity_survives_rename_and_reload_without_simulation_rng",
           "[world_identity][save]" )
{
    world_files files;
    const auto rng_before = rng_get_engine();
    const auto original = load_or_create_world_identity( files.root );
    REQUIRE( original.valid() );
    const std::string document = files.read( WORLD_IDENTITY_FILE );
    CHECK( load_or_create_world_identity( files.root ) == original );
    CHECK( files.read( WORLD_IDENTITY_FILE ) == document );
    const cata_path renamed = PATH_INFO::user_dir_path() / "world_identity_renamed";
    REQUIRE_FALSE( std::filesystem::exists( renamed.get_unrelative_path() ) );
    std::filesystem::rename( files.root.get_unrelative_path(), renamed.get_unrelative_path() );
    files.root = renamed;
    CHECK( load_or_create_world_identity( renamed ) == original );
    const cata_path other = renamed / "another_world";
    std::filesystem::create_directory( other.get_unrelative_path() );
    CHECK( load_or_create_world_identity( other ) != original );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "world_identity_never_replaces_invalid_existing_metadata",
           "[world_identity][save][regression]" )
{
    world_files files;
    const std::string valid = R"({"schema":1,"world_id":"11111111111111111111111111111111"})";
    const std::string bad = GENERATE_COPY( std::string(), "{", valid + "{}", valid + ",",
                                           R"({"schema":2,"world_id":"11111111111111111111111111111111"})",
                                           R"({"schema":1,"world_id":"not-an-id"})", std::string( 1025, 'x' ) );
    files.write( WORLD_IDENTITY_FILE, bad );
    CHECK_THROWS( load_or_create_world_identity( files.root ) );
    CHECK( files.read( WORLD_IDENTITY_FILE ) == bad );
    CHECK_FALSE( std::filesystem::exists( ( files.root /
                                            "world_identity.json.creating" ).get_unrelative_path() ) );
}

TEST_CASE( "world_identity_creation_does_not_publish_on_storage_failure",
           "[world_identity][save][regression]" )
{
    world_files files;
    const auto lock = ( files.root / "world_identity.json.creating" ).get_unrelative_path();
    std::filesystem::create_directory( lock );
    CHECK_THROWS( load_or_create_world_identity( files.root ) );
    CHECK_FALSE( std::filesystem::exists( ( files.root /
                                            WORLD_IDENTITY_FILE ).get_unrelative_path() ) );
    REQUIRE( std::filesystem::remove( lock ) );
    files.write( "not_a_directory", "keep" );
    CHECK_THROWS( load_or_create_world_identity( files.root / "not_a_directory" ) );
    CHECK( files.read( "not_a_directory" ) == "keep" );
    CHECK( load_or_create_world_identity( files.root ).valid() );
    CHECK_FALSE( std::filesystem::exists( lock ) );
}

TEST_CASE( "world_factory_save_and_copy_preserve_the_correct_lineage",
           "[world_identity][save][regression]" )
{
    WORLD original( "World identity factory test" );
    WORLD copied( "Unused identity test name" );
    const auto original_path = original.folder_path().get_unrelative_path();
    const auto copied_path = ( PATH_INFO::savedir_path() / ( original.world_name +
                               "_copy" ) ).get_unrelative_path();
    REQUIRE_FALSE( std::filesystem::exists( original_path ) );
    REQUIRE_FALSE( std::filesystem::exists( copied_path ) );
    const on_out_of_scope cleanup( [&]() {
        std::filesystem::remove_all( original_path );
        std::filesystem::remove_all( copied_path );
    } );
    const auto rng_before = rng_get_engine();
    REQUIRE( original.save() );
    const world_id identity = original.identity();
    WORLD reloaded( original.world_name );
    CHECK( reloaded.identity() == identity );
    copied.COPY_WORLD( &original );
    REQUIRE( copied.save() );
    CHECK( copied.identity() != identity );
    CHECK( original.identity() == identity );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "snapshot_rollback_preserves_world_identity_including_legacy_snapshots",
           "[world_identity][save][snapshot][regression]" )
{
    world_files files;
    files.write( "gameplay.txt", "old state" );
    REQUIRE( save_snapshot::make_snapshot( files.root, "legacy", "tester", 1 ) );
    const auto identity = load_or_create_world_identity( files.root );
    files.write( "gameplay.txt", "new state" );
    REQUIRE( save_snapshot::restore_snapshot( files.root, "legacy" ) );
    CHECK( files.read( "gameplay.txt" ) == "old state" );
    CHECK( load_or_create_world_identity( files.root ) == identity );

    REQUIRE( save_snapshot::make_snapshot( files.root, "current", "tester", 2 ) );
    files.write( "snapshots/current/world_identity.json",
                 R"({"schema":1,"world_id":"11111111111111111111111111111111"})" );
    REQUIRE( save_snapshot::restore_snapshot( files.root, "current" ) );
    CHECK( load_or_create_world_identity( files.root ) == identity );
}
