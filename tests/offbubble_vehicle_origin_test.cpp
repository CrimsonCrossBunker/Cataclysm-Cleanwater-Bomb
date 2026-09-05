#include <functional>
#include <memory>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "mapbuffer.h"
#include "point.h"
#include "submap.h"
#include "type_id.h"
#include "vehicle.h"

TEST_CASE( "offbubble_vehicle_origin_restored_before_grid_lookup", "[vehicle][grid][save]" )
{
    clear_map_without_vision();
    const tripoint_abs_sm origin( 2400, 1800, GENERATE( -2, 0, 2 ) );
    vehicle original( vproto_id( "test_shopping_cart" ) );
    original.sm_pos = origin;
    original.pos = point_sm_ms( 2, 3 );
    std::ostringstream saved;
    JsonOut out( saved );
    original.serialize( out );
    auto loaded = std::make_unique<vehicle>( vproto_id() );
    loaded->deserialize( json_loader::from_string( saved.str() ).get_object() );
    auto sm = std::make_unique<submap>();
    sm->vehicles.push_back( std::move( loaded ) );
    REQUIRE( MAPBUFFER.add_submap( origin, sm ) );
    on_out_of_scope cleanup( []() {
        MAPBUFFER.clear_outside_reality_bubble();
    } );
    const submap *stored = MAPBUFFER.lookup_submap( origin );
    REQUIRE( stored );
    REQUIRE( stored->vehicles.size() == 1 );
    CHECK( stored->vehicles.front()->sm_pos == origin );
    CHECK( stored->vehicles.front()->pos_abs() == original.pos_abs() );
    CHECK( vehicle::find_vehicle_using_parts( get_map(), original.pos_abs() ) ==
           stored->vehicles.front().get() );
}
