#include <memory>
#include <sstream>
#include <string>

#include "activity_actor.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_catch.h"
#include "clzones.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "player_helpers.h"

TEST_CASE( "unload_activity_scope_survives_save_and_reload", "[zones][activities][save]" )
{
    clear_avatar();
    const zone_scope scope = GENERATE( zone_scope::all, zone_scope::static_only,
                                       zone_scope::personal_only );
    JsonValue input = json_loader::from_string(
                          "{\"scope\":" + std::to_string( static_cast<int>( scope ) ) + "}" );
    std::unique_ptr<activity_actor> restored = unload_loot_activity_actor::deserialize( input );
    const unload_loot_activity_actor *unloading =
        dynamic_cast<const unload_loot_activity_actor *>( restored.get() );
    REQUIRE( unloading );
    CHECK( unloading->query_for( get_avatar() ).scope == scope );

    std::ostringstream saved;
    JsonOut output( saved );
    unloading->serialize( output );
    JsonValue serialized = json_loader::from_string( saved.str() );
    JsonObject saved_data = serialized.get_object();
    saved_data.allow_omitted_members();
    CHECK( saved_data.get_int( "scope" ) == static_cast<int>( scope ) );
    restored = unload_loot_activity_actor::deserialize( serialized );
    unloading = dynamic_cast<const unload_loot_activity_actor *>( restored.get() );
    REQUIRE( unloading );
    CHECK( unloading->query_for( get_avatar() ).scope == scope );
}

TEST_CASE( "unload_activity_scope_preserves_legacy_default", "[zones][activities][save]" )
{
    clear_avatar();
    JsonValue input = json_loader::from_string( "{}" );
    const std::unique_ptr<activity_actor> restored = unload_loot_activity_actor::deserialize( input );
    const unload_loot_activity_actor *unloading =
        dynamic_cast<const unload_loot_activity_actor *>( restored.get() );
    REQUIRE( unloading );
    CHECK( unloading->query_for( get_avatar() ).scope == zone_scope::all );
}

TEST_CASE( "unload_activity_scope_rejects_invalid_values", "[zones][activities][save]" )
{
    const int scope = GENERATE( -1, 3 );
    JsonValue input = json_loader::from_string( "{\"scope\":" + std::to_string( scope ) + "}" );
    CHECK_THROWS_AS( unload_loot_activity_actor::deserialize( input ), JsonError );
}
