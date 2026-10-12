#include <cstddef>
#include <map>

#include "cata_catch.h"
#include "character.h"
#include "coordinates.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const itype_id itype_rock( "rock" );
static const vpart_id vpart_frame( "frame" );
static const vproto_id vehicle_prototype_none( "none" );

TEST_CASE( "upstream_nullable_weight_query_preserves_dropped_weight", "[upstream_compat]" )
{
    clear_avatar();
    clear_map_without_vision();
    Character &you = get_player_character();
    item rock( itype_rock );
    REQUIRE( you.wield( rock ) );
    const item_location target = you.get_wielded_item();
    REQUIRE( target );
    const units::mass full = you.weight_carried_with_tweaks( Character::item_tweaks() );
    const std::map<const item *, int> dropped{ { target.get_item(), 1 } };
    const units::mass after = you.weight_carried_with_tweaks( Character::item_tweaks( dropped ) );
    CHECK( full - after == target->weight() );
    CHECK( you.weight_carried_with_tweaks( Character::item_tweaks() ) == full );
}

TEST_CASE( "upstream_vehicle_iterators_keep_independent_copy_positions", "[upstream_compat]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vehicle_prototype_none, tripoint_bub_ms( 60, 60, 0 ),
                                     0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_frame ) >= 0 );
    REQUIRE( veh->install_part( here, point_rel_ms( 1, 0 ), vpart_frame ) >= 0 );
    const vehicle_part_range range = veh->get_all_parts();
    vehicle_part_range::iterator first = range.begin();
    vehicle_part_range::iterator copy( first );
    REQUIRE( first != range.end() );
    const size_t initial = first->part_index();
    ++first;
    REQUIRE( first != range.end() );
    CHECK( copy->part_index() == initial );
    CHECK( first->part_index() != initial );
    copy = first;
    CHECK( copy->part_index() == first->part_index() );
    CHECK( &copy->vehicle() == veh );
    copy = range.end();
    CHECK( copy == range.end() );
    CHECK( first != range.end() );
}
