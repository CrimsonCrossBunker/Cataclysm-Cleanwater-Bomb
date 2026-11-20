#include <cstdint>
#include <functional>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "coordinates.h"
#include "current_map.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "npc.h"
#include "point.h"
#include "type_id.h"

static const itype_id itype_hammer( "hammer" );

static const trait_id trait_TEST_ENCH_MUTATION( "TEST_ENCH_MUTATION" );

TEST_CASE( "npc_save_preserves_unresolved_activity_item_locations",
           "[npc][item_location][save][regression]" )
{
    clear_map_without_vision();
    map &here = get_map();
    const tripoint_bub_ms position( 60, 60, 0 );
    here.i_clear( position );
    item &target = here.add_item( position, item( itype_hammer ) );
    const int64_t target_uid = target.uid().get_value();
    std::ostringstream saved_item;
    JsonOut item_out( saved_item );
    target.serialize( item_out );
    std::ostringstream saved_location;
    JsonOut location_out( saved_location );
    item_location( map_cursor( position ), &target ).serialize( location_out );
    here.i_clear( position );

    npc original;
    original.randomize();
    original.set_pos_abs_only( here.get_abs( position ) );
    item_location pending;
    pending.deserialize( json_loader::from_string( saved_location.str() ).get_object() );
    original.may_activity_occupancy_after_end_items_loc.push_back( pending );
    std::ostringstream saved_npc;
    const std::string errors = capture_debugmsg_during( [&]() {
        JsonOut npc_out( saved_npc );
        original.serialize( npc_out );
    } );
    INFO( errors );
    CHECK( errors.empty() );

    npc restored;
    restored.deserialize( json_loader::from_string( saved_npc.str() ).get_object() );
    item restored_item;
    restored_item.deserialize( json_loader::from_string( saved_item.str() ).get_object() );
    here.add_item( position, std::move( restored_item ) );
    REQUIRE( restored.may_activity_occupancy_after_end_items_loc.size() == 1 );
    REQUIRE( restored.may_activity_occupancy_after_end_items_loc.front() );
    CHECK( restored.may_activity_occupancy_after_end_items_loc.front()->uid().get_value() ==
           target_uid );
    REQUIRE( pending );
    CHECK( pending->uid().get_value() == target_uid );
}

TEST_CASE( "npc_deserialization_does_not_require_loaded_terrain", "[npc][regression]" )
{
    clear_map( -4, 0 );
    npc original;
    original.randomize();
    // This serialization fixture is not registered in an overmap. Initialize
    // its position without trying to migrate a nonexistent registry entry.
    original.set_pos_abs_only( get_map().get_abs( tripoint_bub_ms( 59, 106, -4 ) ) );
    // This mutation supplies a passive field emitter, like Magiclysm auras.
    // Rebuilding personality traits must not activate it during deserialization.
    original.personality.aggression = 10;
    original.set_mutation( trait_TEST_ENCH_MUTATION );
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
