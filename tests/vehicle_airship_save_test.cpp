#include <cstdint>
#include <set>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "map.h"
#include "map_helpers.h"
#include "mapbuffer.h"
#include "player_helpers.h"
#include "point.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vehicle_uid.h"

TEST_CASE( "airship_survives_an_underground_visit_and_mapbuffer_save_reload",
           "[vehicle][save][airship_save]" )
{
    clear_avatar();
    clear_map_without_vision();
    const int z = GENERATE( 0, 1 );
    const bool flying = GENERATE( false, true );
    CAPTURE( z, flying );
    const tripoint_abs_omt column = project_to<coords::omt>( get_map().get_abs_sub() ) +
                                    tripoint_rel_omt( 30 + z, 30 + flying, 0 );
    const tripoint_abs_omt parking( column.xy(), z );
    const tripoint_abs_omt underground( column.xy(), -2 );
    on_out_of_scope cleanup( []() {
        MAPBUFFER.clear_outside_reality_bubble();
    } );
    int64_t uid = 0;
    int parts = 0;
    std::set<tripoint_abs_ms> footprint;
    {
        tinymap surface;
        surface.load( parking, true );
        map &here = *surface.cast_to_map();
        clear_vehicles( &here );
        for( int x = 0; x < 24; ++x ) {
            for( int y = 0; y < 24; ++y ) {
                here.set( tripoint_bub_ms( x, y, z ), ter_id( z == 0 ? "t_pavement" : "t_open_air" ),
                          furn_str_id::NULL_ID() );
            }
        }
        vehicle *airship = surface.add_vehicle( vproto_id( "airship" ),
                                                tripoint_omt_ms( 13, 12, z ), 0_degrees, 0, veh_spawn_status::UNDAMAGED );
        REQUIRE( airship );
        REQUIRE( airship->is_airship( here ) );
        airship->set_flying( flying );
        uid = airship->uid().get_value();
        REQUIRE( uid > 0 );
        parts = airship->part_count();
        footprint = airship->get_points();
        surface.save();
        {
            tinymap lower;
            lower.load( underground, true );
            lower.save();
        }
        REQUIRE( surface.get_vehicles().size() == 1 );
        CHECK( surface.get_vehicles().front().v->uid().get_value() == uid );
        MAPBUFFER.save();
    }
    // Evict only after both map views have released their submap pointers.
    MAPBUFFER.clear_outside_reality_bubble();
    {
        tinymap loaded;
        loaded.load( parking, true );
        const auto vehicles = loaded.get_vehicles();
        REQUIRE( vehicles.size() == 1 );
        const vehicle &airship = *vehicles.front().v;
        CHECK( airship.uid().get_value() == uid );
        CHECK( airship.part_count() == parts );
        CHECK( airship.get_points() == footprint );
        CHECK( airship.is_flying_in_air() == flying );
    }
}
