#include <optional>
#include <set>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "item.h"
#include "item_group.h"
#include "itype.h"
#include "mapdata.h"
#include "type_id.h"

TEST_CASE( "ground_cable_drops_only_recover_cable",
           "[map][item_group][ground_cable][upstream_ports]" )
{
    const furn_str_id cable( "f_ground_cable" );
    const itype_id cable_item( "cable" );
    const bool deconstruct = GENERATE( false, true );
    REQUIRE( cable->bash.has_value() );
    REQUIRE( cable->deconstruct.has_value() );
    const item_group_id group = deconstruct ? cable->deconstruct->drop_group : cable->bash->drop_group;
    const std::set<const itype *> possible = item_group::every_possible_item_from( group );
    REQUIRE( possible.size() == 1 );
    CHECK( ( *possible.begin() )->get_id() == cable_item );
    for( int sample = 0; sample < 20; ++sample ) {
        int count = 0;
        for( const item &drop : item_group::items_from( group, calendar::turn_zero ) ) {
            CHECK( drop.typeId() == cable_item );
            count += drop.count();
        }
        CAPTURE( deconstruct, sample, count );
        CHECK( count >= ( deconstruct ? 1 : 0 ) );
        CHECK( count <= 2 );
    }
}
