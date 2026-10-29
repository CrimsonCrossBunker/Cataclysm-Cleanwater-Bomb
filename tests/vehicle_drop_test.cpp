#include <cstddef>
#include <list>
#include <optional>
#include <vector>

#include "activity_handlers.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "character_attire.h"
#include "coordinates.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const itype_id itype_backpack( "backpack" );
static const itype_id itype_jeans( "jeans" );
static const vproto_id vehicle_prototype_car( "car" );

TEST_CASE( "deliberate_vehicle_drop_does_not_return_items_to_character",
           "[vehicle][item][drop]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    vehicle *veh = here.add_vehicle( vehicle_prototype_car, tripoint_bub_ms( 60, 60, 0 ),
                                    0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );

    int cargo_index = -1;
    for( const vpart_reference &part : veh->get_all_parts() ) {
        if( part.has_feature( "CARGO" ) ) {
            cargo_index = part.part_index();
            break;
        }
    }
    REQUIRE( cargo_index >= 0 );
    vehicle_part &cargo_part = veh->part( cargo_index );
    vehicle_stack cargo = veh->get_items( cargo_part );
    while( !cargo.empty() ) {
        cargo.erase( cargo.begin() );
    }

    const tripoint_bub_ms drop_position = veh->bub_part_pos( here, cargo_part );
    you.setpos( here, drop_position );
    here.i_clear( drop_position );
    item dropped( itype_jeans, calendar::turn );

    const bool full_cargo = GENERATE( false, true );
    const bool wear_backpack = GENERATE( false, true );
    const bool return_locations = GENERATE( false, true );
    const bool drop_wielded_item = GENERATE( false, true );
    CAPTURE( full_cargo, wear_backpack, return_locations, drop_wielded_item );

    if( full_cargo ) {
        int filled = 0;
        while( filled < 1000 && veh->add_item( here, cargo_part, dropped ) ) {
            ++filled;
        }
        REQUIRE( filled > 0 );
        REQUIRE( filled < 1000 );
        REQUIRE_FALSE( veh->add_item( here, cargo_part, dropped ) );
    }
    if( wear_backpack ) {
        REQUIRE( you.worn.wear_item( you, item( itype_backpack ), false, false ) );
        REQUIRE( you.can_stash( dropped ) );
    }
    const size_t original_cargo_size = cargo.size();
    item_location original;
    if( drop_wielded_item ) {
        REQUIRE( you.wield( dropped ) );
        original = you.get_wielded_item();
        REQUIRE( original );
    }

    if( return_locations ) {
        std::vector<item_location> locations = put_into_vehicle_or_drop_ret_locs(
                you, item_drop_reason::deliberate, { dropped }, drop_position );
        REQUIRE( locations.size() == 1 );
        REQUIRE( locations.front() );
        CHECK( locations.front().where() == ( full_cargo ? item_location::type::map :
                                              item_location::type::vehicle ) );
        CHECK( locations.front()->typeId() == itype_jeans );
    } else {
        put_into_vehicle_or_drop( you, item_drop_reason::deliberate, { dropped } );
    }

    if( drop_wielded_item ) {
        REQUIRE( original );
        CHECK( original == you.get_wielded_item() );
        original.remove_item();
    }
    CHECK_FALSE( you.is_armed() );
    CHECK_FALSE( you.has_item_with( []( const item &candidate ) {
        return candidate.typeId() == itype_jeans;
    } ) );
    CHECK( cargo.size() == original_cargo_size + ( full_cargo ? 0 : 1 ) );
    CHECK( here.i_at( drop_position ).size() == ( full_cargo ? 1 : 0 ) );
}
