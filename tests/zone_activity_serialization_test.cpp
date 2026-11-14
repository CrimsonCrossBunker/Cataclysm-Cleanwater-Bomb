#include <memory>
#include <sstream>
#include <string>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "cata_catch.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"

TEST_CASE( "unload_activity_preserves_zone_scope", "[zones][activities][serialization]" )
{
    const int scope = GENERATE( 0, 1, 2 );
    CAPTURE( scope );
    JsonValue data = json_loader::from_string( "{\"scope\":" + std::to_string( scope ) + "}" );
    const std::unique_ptr<activity_actor> actor = unload_loot_activity_actor::deserialize( data );
    REQUIRE( actor );
    std::ostringstream saved;
    JsonOut writer( saved );
    actor->serialize( writer );
    JsonObject object = json_loader::from_string( saved.str() ).get_object();
    object.allow_omitted_members();
    CHECK( object.get_int( "scope" ) == scope );
}

TEST_CASE( "legacy_unload_activity_defaults_to_all_zones", "[zones][activities][serialization]" )
{
    JsonValue data = json_loader::from_string( "{}" );
    const std::unique_ptr<activity_actor> actor = unload_loot_activity_actor::deserialize( data );
    REQUIRE( actor );
    std::ostringstream saved;
    JsonOut writer( saved );
    actor->serialize( writer );
    JsonObject object = json_loader::from_string( saved.str() ).get_object();
    object.allow_omitted_members();
    CHECK( object.get_int( "scope" ) == 0 );
}

TEST_CASE( "unload_activity_rejects_invalid_zone_scope", "[zones][activities][serialization]" )
{
    const int scope = GENERATE( -1, 3 );
    CAPTURE( scope );
    JsonValue data = json_loader::from_string( "{\"scope\":" + std::to_string( scope ) + "}" );
    CHECK_THROWS_AS( unload_loot_activity_actor::deserialize( data ), JsonError );
}

