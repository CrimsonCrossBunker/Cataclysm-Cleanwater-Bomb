#include "cata_catch.h"

#include <filesystem>
#include <optional>
#include <sstream>
#include <string>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "input_replay.h"
#include "json.h"
#include "json_loader.h"
#include "player_identity.h"
#include "rng.h"

namespace
{
std::string save_player( const avatar &who )
{
    std::ostringstream saved;
    JsonOut out( saved );
    who.serialize( out );
    return saved.str();
}
} // namespace

TEST_CASE( "local_player_identity_is_independent_of_character_and_filename",
           "[player_identity][save]" )
{
    avatar first;
    avatar second;
    first.normalize();
    second.normalize();
    first.name = second.name = "Same name";
    first.set_save_id( "same-slot" );
    second.set_save_id( "same-slot" );
    first.setID( character_id( 12020 ), true );
    second.setID( first.getID(), true );
    const auto before = rng_get_engine();
    first.ensure_player_id();
    second.ensure_player_id();
    REQUIRE( first.get_player_id().valid() );
    REQUIRE( second.get_player_id().valid() );
    CHECK_FALSE( first.get_player_id() == second.get_player_id() );
    CHECK( rng_get_engine() == before );
    const auto player = first.get_player_id();
    first.name = "Renamed character";
    first.set_save_id( "moved-slot" );
    first.setID( character_id( 12021 ), true );
    first.ensure_player_id();
    CHECK( first.get_player_id() == player );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "local_player_save_migration_preserves_simulation_rng_and_roundtrips",
           "[player_identity][save][migration]" )
{
    avatar original;
    original.normalize();
    original.setID( character_id( 12022 ), true );
    const std::string legacy = save_player( original );
    REQUIRE( legacy.find( "local_player_id" ) == std::string::npos );
    original.ensure_player_id();
    const std::string current = save_player( original );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto before_load = rng_get_engine();
    std::optional<cata_default_random_engine> after_load;
    for( const bool old_save : {
             false, true
         } ) {
        CAPTURE( old_save );
        avatar restored;
        restored.normalize();
        // Loading a legacy save into a reused object must not retain its old
        // profile, even when both characters have the same name and ID.
        restored.ensure_player_id();
        const auto previous_player = restored.get_player_id();
        rng_get_engine() = before_load;
        restored.deserialize( json_loader::from_string( old_save ? legacy : current ).get_object() );
        if( after_load ) {
            CHECK( rng_get_engine() == *after_load );
        } else {
            after_load = rng_get_engine();
        }
        CHECK( restored.getID() == original.getID() );
        CHECK( restored.get_player_id().valid() == !old_save );
        restored.ensure_player_id();
        CHECK( rng_get_engine() == *after_load );
        REQUIRE( restored.get_player_id().valid() );
        CHECK_FALSE( restored.get_player_id() == previous_player );
        if( !old_save ) {
            CHECK( restored.get_player_id() == original.get_player_id() );
        }
        avatar reloaded;
        reloaded.deserialize( json_loader::from_string( save_player( restored ) ).get_object() );
        CHECK( reloaded.get_player_id() == restored.get_player_id() );
        CHECK( reloaded.getID() == restored.getID() );
    }
}

TEST_CASE( "local_player_identity_corruption_is_not_migrated_as_a_new_player",
           "[player_identity][save][regression]" )
{
    avatar who;
    who.normalize();
    who.ensure_player_id();
    const std::string original = save_player( who );
    const std::string replacement = GENERATE( "null", "true", "42", "\"\"", "\"../../bad\"",
                                    "\"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\"" );
    CAPTURE( replacement );
    const std::string member = "\"local_player_id\":";
    const auto begin = original.find( member );
    REQUIRE( begin != std::string::npos );
    REQUIRE( original.find( member, begin + member.size() ) == std::string::npos );
    const auto value_begin = begin + member.size();
    const auto end = original.find( ',', value_begin );
    REQUIRE( end != std::string::npos );
    std::string corrupt = original;
    corrupt.replace( value_begin, end - value_begin, replacement );
    const auto before = rng_get_engine();
    CHECK_THROWS_AS( who.deserialize( json_loader::from_string( corrupt ).get_object() ), JsonError );
    CHECK( save_player( who ) == original );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "starting_a_new_player_does_not_reuse_an_imported_profile",
           "[player_identity][save][template]" )
{
    avatar original;
    original.normalize();
    original.setID( character_id( 12023 ), true );
    original.ensure_player_id();
    avatar imported;
    imported.deserialize( json_loader::from_string( save_player( original ) ).get_object() );
    REQUIRE( imported.get_player_id() == original.get_player_id() );
    const auto before = rng_get_engine();
    // The new-game lifecycle calls this even for transfer templates. An
    // ordinary reload calls ensure_player_id instead and retains its profile.
    imported.assign_new_player_id();
    CHECK_FALSE( imported.get_player_id() == original.get_player_id() );
    CHECK( imported.getID() == original.getID() );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "local_player_identity_records_and_replays_without_simulation_rng",
           "[player_identity][replay]" )
{
    REQUIRE_FALSE( input_replay::is_recording() );
    REQUIRE_FALSE( input_replay::is_replaying() );
    const auto path = std::filesystem::temp_directory_path() /
                      ( "ccb-profile-" + create_player_id().str() + ".replay" );
    const on_out_of_scope cleanup( [&]() {
        input_replay::finish();
        std::filesystem::remove( path );
    } );
    avatar first;
    first.normalize();
    first.set_save_id( "first slot" );
    const auto before = rng_get_engine();
    input_replay::set_record_seed( 20261103 );
    REQUIRE( input_replay::begin_record( path.string() ) );
    first.assign_new_player_id();
    input_replay::on_record( input_event( 46, input_event_t::keyboard_code ) );
    input_replay::finish();
    CHECK( rng_get_engine() == before );

    avatar restored;
    restored.normalize();
    restored.set_save_id( "another filename" );
    const auto before_replay = rng_get_engine();
    REQUIRE( input_replay::begin_replay( path.string() ) );
    restored.assign_new_player_id();
    CHECK( restored.get_player_id() == first.get_player_id() );
    CHECK( input_replay::replay_remaining() == 1 );
    CHECK( rng_get_engine() == before_replay );
}
