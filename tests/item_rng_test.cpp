#include <sstream>

#include "cata_catch.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "rng.h"
#include "type_id.h"

TEST_CASE( "item_reconstruction_does_not_advance_gameplay_rng", "[item_rng][regression]" )
{
    const item source( itype_id( "rock" ) );
    std::ostringstream text;
    JsonOut out( text );
    source.serialize( out );
    const auto before = rng_get_engine();
    item replica;
    CHECK( rng_get_engine() == before );
    JsonValue value = json_loader::from_string( text.str() );
    replica.deserialize( value.get_object() );
    CHECK( rng_get_engine() == before );
    CHECK( replica.typeId() == source.typeId() );
    CHECK( replica.uid().get_value() == source.uid().get_value() );
    CHECK( replica.charges == source.charges );
}

TEST_CASE( "visual_choices_do_not_advance_gameplay_rng", "[item_rng][regression]" )
{
    const auto before = rng_get_engine();
    for( int i = 0; i < 16; ++i ) {
        const int choice = rng_visual( 7, -2 );
        CHECK( ( choice >= -2 && choice <= 7 ) );
    }
    CHECK( rng_visual( 11, 11 ) == 11 );
    CHECK( rng_get_engine() == before );
}
