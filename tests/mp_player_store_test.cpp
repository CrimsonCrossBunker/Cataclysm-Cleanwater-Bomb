#include <filesystem>
#include <fstream>
#include <future>
#include <sstream>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_utility.h"
#include "mp_player_store.h"
#include "path_info.h"
#include "rng.h"

namespace
{
struct player_files {
    cata_path root = PATH_INFO::user_dir_path() / "mp_player_store_test";
    player_files() {
        // The native test runner supplies an isolated user directory.
        REQUIRE_FALSE( std::filesystem::exists( root.get_unrelative_path() ) );
        std::filesystem::create_directories( root.get_unrelative_path() );
    }
    ~player_files() {
        std::filesystem::remove_all( root.get_unrelative_path() );
    }
    void write( const std::string &name, const std::string &data ) const {
        write_to_file( root / name, [&]( std::ostream & out ) {
            out << data;
        } );
    }
    std::string read( const std::string &name ) const {
        std::ifstream in( ( root / name ).get_unrelative_path() );
        return std::string( std::istreambuf_iterator<char>( in ), {} );
    }
};

const cata_mp::player_credentials first{ cata_mp::player_id( std::string( 32, '1' ) ),
    std::string( 64, 'a' ) };
const cata_mp::player_credentials second{ cata_mp::player_id( std::string( 32, '2' ) ),
    std::string( 64, 'b' ) };
const std::string original = R"({"id":3,"name":"Rosalee Blanco","inventory":["book","coat"]})";
const std::string renamed = R"({"id":3,"name":"Renamed","inventory":["book","coat"]})";
const std::string other_actor = R"({"id":4,"name":"Rosalee Blanco","inventory":[]})";
const std::string first_file = "mp_actor_" + first.id.str() + ".json";
} // namespace

TEST_CASE( "mp_profile_persists_without_simulation_rng_or_display_name",
           "[multiplayer][player_identity]" )
{
    player_files files;
    const auto before = rng_get_engine();
    const auto profile = files.root / "profile.json";
    const auto identity = cata_mp::load_or_create_player_credentials( profile );
    REQUIRE( identity.valid() );
    CHECK( rng_get_engine() == before );
    const auto restored = cata_mp::load_or_create_player_credentials( profile );
    CHECK( restored.id == identity.id );
    CHECK( restored.resume_secret == identity.resume_secret );
    const auto another = cata_mp::load_or_create_player_credentials( files.root / "other.json" );
    CHECK_FALSE( another.id == identity.id );
    CHECK( another.resume_secret != identity.resume_secret );
    CHECK( rng_get_engine() == before );
    CHECK_THROWS( cata_mp::player_id( "../../outside" ) );
    CHECK_THROWS( cata_mp::player_id( std::string( 32, 'G' ) ) );
    CHECK_THROWS( cata_mp::load_or_create_player_credentials( files.root / "missing" / "profile" ) );

    files.write( "profile.json", "{\"resume_secret\":\"private text\",bad}" );
    CHECK_THROWS_WITH( cata_mp::load_or_create_player_credentials( profile ),
                       "Malformed multiplayer profile; restore its backup" );
    CHECK( files.read( "profile.json" ) == "{\"resume_secret\":\"private text\",bad}" );
}

TEST_CASE( "mp_rejoin_restores_actor_after_rename_and_same_named_players_stay_distinct",
           "[multiplayer][player_identity][regression]" )
{
    player_files files;
    {
        cata_mp::player_store world( files.root );
        CHECK_FALSE( world.load( first ) );
        world.save( first, original );
        world.save( second, other_actor );
        CHECK( world.load( first ) == original );
        CHECK( world.load( second ) == other_actor );
        world.save( first, renamed );
    }
    cata_mp::player_store reloaded( files.root );
    CHECK( reloaded.load( first ) == renamed );
    CHECK( reloaded.load( second ) == other_actor );
    auto impostor = first;
    impostor.resume_secret = second.resume_secret;
    const auto before = files.read( first_file );
    CHECK_THROWS( reloaded.load( impostor ) );
    CHECK_THROWS( reloaded.save( impostor, original ) );
    CHECK_THROWS( reloaded.save( first, other_actor ) );
    CHECK_THROWS( reloaded.save( second, original ) );
    CHECK( files.read( first_file ) == before );

    const auto other_root = files.root / "another-world";
    std::filesystem::create_directory( other_root.get_unrelative_path() );
    cata_mp::player_store another_world( other_root );
    CHECK_FALSE( another_world.load( first ) );
    another_world.save( first, other_actor );
    CHECK( another_world.load( first ) == other_actor );
    CHECK( reloaded.load( first ) == renamed );
}

TEST_CASE( "mp_concurrent_profile_creators_never_replace_the_winning_identity",
           "[multiplayer][player_identity]" )
{
    player_files files;
    const auto path = files.root / "shared-profile.json";
    const auto rng_before = rng_get_engine();
    std::promise<void> begin;
    const auto ready = begin.get_future().share();
    std::vector<std::future<cata_mp::player_credentials>> creators;
    for( int i = 0; i < 4; ++i ) {
        creators.push_back( std::async( std::launch::async, [ready, path]() {
            ready.wait();
            return cata_mp::load_or_create_player_credentials( path );
        } ) );
    }
    begin.set_value();
    const auto winner = creators.front().get();
    for( size_t i = 1; i < creators.size(); ++i ) {
        const auto result = creators[i].get();
        CHECK( result.id == winner.id );
        CHECK( result.resume_secret == winner.resume_secret );
    }
    const auto stored = cata_mp::load_or_create_player_credentials( path );
    CHECK( stored.id == winner.id );
    CHECK( stored.resume_secret == winner.resume_secret );
    CHECK_FALSE( std::filesystem::exists( ( path + ".creating" ).get_unrelative_path() ) );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "mp_different_authorities_never_receive_the_same_resume_capability",
           "[multiplayer][player_identity]" )
{
    player_files files;
    const auto a = cata_mp::load_server_player_credentials( files.root, "127.0.0.1:18359" );
    const auto b = cata_mp::load_server_player_credentials( files.root, "127.0.0.2:18359" );
    const auto again = cata_mp::load_server_player_credentials( files.root, "127.0.0.1:18359" );
    CHECK( a.id == again.id );
    CHECK( a.resume_secret == again.resume_secret );
    CHECK_FALSE( a.id == b.id );
    CHECK( a.resume_secret != b.resume_secret );
    CHECK_THROWS( cata_mp::load_server_player_credentials( files.root, "" ) );
    CHECK_THROWS( cata_mp::load_server_player_credentials( files.root, std::string( 97, 'x' ) ) );
}

TEST_CASE( "mp_legacy_import_requires_an_explicit_record_and_preserves_originals",
           "[multiplayer][player_identity][migration]" )
{
    player_files files;
    files.write( "mp_player_Rosalee_Blanco.json", original );
    files.write( "mp_player_player.json", other_actor );
    files.write( "unrelated.json", original );
    cata_mp::player_store world( files.root );
    CHECK_FALSE( world.load( first ) ); // Never guess using the old nickname.
    REQUIRE( world.legacy_records().size() == 2 );
    CHECK_THROWS( world.import_legacy( first, files.root / "unrelated.json" ) );
    world.import_legacy( first, files.root / "mp_player_Rosalee_Blanco.json" );
    CHECK( world.load( first ) == original );
    CHECK( files.read( "mp_player_Rosalee_Blanco.json" ) == original );
    CHECK_THROWS( world.import_legacy( first, files.root / "mp_player_player.json" ) );
    CHECK_THROWS( world.import_legacy( second, files.root / "mp_player_Rosalee_Blanco.json" ) );
    CHECK_FALSE( world.load( second ) );
    world.import_legacy( second, files.root / "mp_player_player.json" );
    CHECK( world.load( second ) == other_actor );
}

TEST_CASE( "mp_corrupt_records_fail_closed_and_never_become_new_characters",
           "[multiplayer][player_identity][regression]" )
{
    player_files files;
    cata_mp::player_store world( files.root );
    world.save( first, original );
    const auto good = files.read( first_file );
    SECTION( "truncated_existing_file" ) {
        files.write( first_file, good.substr( 0, good.size() / 2 ) );
    }
    SECTION( "future_schema" ) {
        auto changed = good;
        changed.replace( changed.find( "\"schema\":1" ), 10, "\"schema\":2" );
        files.write( first_file, changed );
    }
    SECTION( "trailing_object" ) {
        files.write( first_file, good + "{}" );
    }
    SECTION( "secret_replaced_on_disk" ) {
        auto changed = good;
        changed.replace( changed.find( first.resume_secret ), 64, second.resume_secret );
        files.write( first_file, changed );
        // A fresh world reads the authoritative file and still rejects the old key.
    }
    CHECK_THROWS( world.load( first ) );
    const auto broken = files.read( first_file );
    CHECK_THROWS( world.save( first, renamed ) );
    CHECK( files.read( first_file ) == broken );
    cata_mp::player_store reloaded( files.root );
    CHECK_THROWS( reloaded.load( first ) );
}

TEST_CASE( "mp_store_write_failure_keeps_actor_binding_retryable",
           "[multiplayer][player_identity][regression]" )
{
    player_files files;
    cata_mp::player_store world( files.root );
    CHECK_FALSE( world.load( first ) ); // Materialize the index.
    // A directory at the atomic rename destination deterministically fails even
    // under a privileged test runner, without relying on permission bits.
    std::filesystem::create_directory( ( files.root / first_file ).get_unrelative_path() );
    CHECK_THROWS( world.save( first, original ) );
    std::filesystem::remove( ( files.root / first_file ).get_unrelative_path() );
    world.save( first, original );
    CHECK( world.load( first ) == original );
    CHECK_THROWS( world.save( first, R"({"id":-1})" ) );
    CHECK_THROWS( world.save( first, R"({"id":2147483647})" ) );
    CHECK_THROWS( world.save( first, original + "{}" ) );
    CHECK( world.load( first ) == original );
}
