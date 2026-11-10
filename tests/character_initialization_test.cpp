#include <array>
#include <memory>
#include <new>
#include <optional>
#include <sstream>
#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "json.h"
#include "json_loader.h"
#include "npc.h"
#include "rng.h"

namespace
{
template<typename T>
void destroy_character( T *who )
{
    who->~T();
}

std::string save_npc( const npc &who )
{
    std::ostringstream saved;
    JsonOut out( saved );
    who.serialize( out );
    return saved.str();
}

void omit_saved_integer( std::string &saved, const std::string &name )
{
    // Only edit the two known integer members of this freshly serialized NPC.
    const std::string key = "\"" + name + "\":";
    const auto begin = saved.find( key );
    REQUIRE( begin != std::string::npos );
    REQUIRE( saved.find( key, begin + key.size() ) == std::string::npos );
    const auto end = saved.find( ',', begin );
    REQUIRE( end != std::string::npos );
    saved.erase( begin, end - begin + 1 );
}

template<typename TestType>
void check_character_storage_defaults( const unsigned char fill )
{
    // Reused memory exposed these fields in a saved remote NPC. Test both fills
    // instead of relying on a fresh allocation accidentally containing zeroes.
    CAPTURE( static_cast<int>( fill ) );
    alignas( TestType ) std::array<unsigned char, sizeof( TestType )> storage;
    storage.fill( fill );
    const std::unique_ptr<TestType, decltype( &destroy_character<TestType> )> who(
        ::new( storage.data() ) TestType(), destroy_character<TestType> );
    CHECK( who->get_free_dodges_left() == 0 );
    CHECK( who->avg_nat_bpm == 80 );
    who->normalize();
    CHECK( who->get_free_dodges_left() == 0 );
    CHECK( who->avg_nat_bpm == 80 );
}
} // namespace

TEST_CASE( "character_defaults_do_not_depend_on_previous_storage_avatar",
           "[character][initialization][regression]" )
{
    check_character_storage_defaults<avatar>( GENERATE( 0x55, 0xaa ) );
}

TEST_CASE( "character_defaults_do_not_depend_on_previous_storage_npc",
           "[character][initialization][regression]" )
{
    check_character_storage_defaults<npc>( GENERATE( 0x55, 0xaa ) );
}

TEST_CASE( "character_save_defaults_and_explicit_values_roundtrip",
           "[character][initialization][save]" )
{
    npc original;
    original.normalize();
    const int saved_bpm = GENERATE( 0, 73 );
    const int saved_dodges = GENERATE( 0, 2 );
    original.avg_nat_bpm = saved_bpm;
    original.set_free_dodges_left( saved_dodges );
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const auto before_load = rng_get_engine();
    std::optional<cata_default_random_engine> after_explicit_load;
    for( const bool legacy_missing_fields : {
             false, true
         } ) {
        CAPTURE( saved_bpm, saved_dodges, legacy_missing_fields );
        std::string saved = save_npc( original );
        if( legacy_missing_fields ) {
            omit_saved_integer( saved, "avg_nat_bpm" );
            omit_saved_integer( saved, "free_dodges_left" );
        }
        npc restored;
        rng_get_engine() = before_load;
        restored.deserialize( json_loader::from_string( saved ).get_object() );
        // Loading missing optional fields must not add random draws to the
        // existing deserialization path. Other parts of that path use RNG.
        if( after_explicit_load ) {
            CHECK( rng_get_engine() == *after_explicit_load );
        } else {
            after_explicit_load = rng_get_engine();
        }
        CHECK( restored.avg_nat_bpm == ( legacy_missing_fields ? 80 : saved_bpm ) );
        CHECK( restored.get_free_dodges_left() == ( legacy_missing_fields ? 0 : saved_dodges ) );
        const JsonObject serialized = json_loader::from_string( save_npc( restored ) ).get_object();
        serialized.allow_omitted_members();
        CHECK( serialized.get_int( "avg_nat_bpm" ) == restored.avg_nat_bpm );
        CHECK( serialized.get_int( "free_dodges_left" ) == restored.get_free_dodges_left() );
    }
}
