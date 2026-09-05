#include <sstream>
#include <string>

#include "cata_catch.h"
#include "coordinates.h"
#include "current_map.h"
#include "debug.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "npc.h"
#include "point.h"
#include "type_id.h"

TEST_CASE( "npc_deserialization_does_not_require_loaded_terrain", "[npc][regression]" )
{
    clear_map( -4, 0 );
    npc original;
    original.randomize();
    original.setpos( get_map(), tripoint_bub_ms( 59, 106, -4 ), false );
    // This mutation supplies a passive field emitter, like Magiclysm auras.
    // Rebuilding personality traits must not activate it during deserialization.
    original.personality.aggression = 10;
    original.set_mutation( trait_id( "TEST_ENCH_MUTATION" ) );
    map unloaded;
    original.set_pos_abs_only( unloaded.get_abs( tripoint_bub_ms( 59, 106, -4 ) ) );
    std::ostringstream saved;
    JsonOut out( saved );
    original.serialize( out );
    npc restored;
    swap_map use_unloaded_map( unloaded );
    REQUIRE( unloaded.inbounds( original.pos_abs() ) );
    const std::string errors = capture_debugmsg_during( [&]() {
        restored.deserialize( json_loader::from_string( saved.str() ).get_object() );
    } );
    INFO( errors );
    CHECK( errors.empty() );
    CHECK( restored.pos_abs() == original.pos_abs() );
}
