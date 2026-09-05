#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "creature_tracker.h"
#include "game.h"
#include "horde_entity.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "monster_helpers.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "type_id.h"

TEST_CASE( "dimension_monster_storage_preserves_identity", "[monster][dimension][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    monster &original = spawn_test_monster( "mon_zombie", get_avatar().pos_bub() + point( 3, 0 ) );
    const int64_t uid = original.uid().get_value();
    horde_entity stored( original );
    REQUIRE( stored.monster_data );
    CHECK( stored.monster_data->uid().get_value() == uid );
    monster restored = stored.monster_data->copy_for_persistence();
    CHECK( restored.uid().get_value() == uid );
    // Deliberately cloning a monster still gives the new creature a new identity.
    monster clone( original );
    CHECK( clone.uid().get_value() != uid );
}

TEST_CASE( "reloading_before_dimension_departure_does_not_duplicate_monsters",
           "[monster][dimension][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    const tripoint_bub_ms pos = get_avatar().pos_bub() + point( 3, 0 );
    monster &original = spawn_test_monster( "mon_zombie", pos );
    const int64_t uid = original.uid().get_value();
    const tripoint_abs_ms abs = original.pos_abs();
    // Dimension departure writes a copy into the source overmap. Reloading
    // the earlier character save restores the same original active monster.
    overmap_buffer.despawn_monster( original );
    REQUIRE( overmap_buffer.entity_at( abs ) );
    if( GENERATE( false, true ) ) {
        // A normal dimension return has no earlier active copy to deduplicate.
        g->remove_zombie( original );
        REQUIRE( get_creature_tracker().size() == 0 );
    }
    overmap_buffer.spawn_monster( project_to<coords::sm>( abs ) );
    CHECK( get_creature_tracker().size() == 1 );
    CHECK( get_creature_tracker().find_by_uid( uid ) );
    CHECK( overmap_buffer.entity_at( abs ) == nullptr );
}
