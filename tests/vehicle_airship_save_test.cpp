#include <cstdint>
#include <set>

#include "avatar.h"
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

static void airship_bubble_reload_after_descending()
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_abs_sm origin = here.get_abs_sub();
    const tripoint_bub_ms original_position = you.pos_bub();
    int shifted = 0;
    on_out_of_scope restore( [&]() {
        while( shifted > 0 ) {
            here.shift( point_rel_sm::west );
            --shifted;
        }
        here.vertical_shift( origin.z() );
        you.setpos( here, original_position );
    } );
    const int z = GENERATE( 0, 1 );
    CAPTURE( z );
    const tripoint_bub_ms parking( 60, 60, z );
    vehicle *airship = here.add_vehicle( vproto_id( "airship" ), parking, 0_degrees, 0,
                                         veh_spawn_status::UNDAMAGED );
    REQUIRE( airship );
    airship->set_flying( z != 0 );
    const int64_t uid = airship->uid().get_value();
    const int parts = airship->part_count();
    const std::set<tripoint_abs_ms> footprint = airship->get_points();
    here.ter_set( tripoint_bub_ms( 60, 60, -2 ), ter_id( "t_rock_floor" ) );
    you.setpos( here, tripoint_bub_ms( 60, 60, -2 ) );
    here.vertical_shift( -2 );
    here.save();
    MAPBUFFER.save();
    // Follow the same bubble-unloading path used by normal movement.  The
    // player remains below the parked vehicle while it leaves the bubble.
    for( ; shifted < 12; ++shifted ) {
        here.shift( point_rel_sm::east );
    }
    MAPBUFFER.clear_outside_reality_bubble();
    while( shifted > 0 ) {
        here.shift( point_rel_sm::west );
        --shifted;
    }
    here.vertical_shift( origin.z() );
    CHECK( here.get_abs_sub() == origin );
    vehicle *loaded = vehicle::find_vehicle_by_uid( here, uid );
    REQUIRE( loaded );
    CHECK( loaded->part_count() == parts );
    CHECK( loaded->get_points() == footprint );
    CHECK( loaded->is_flying_in_air() == ( z != 0 ) );
}

TEST_CASE( "airship_survives_an_underground_visit_and_mapbuffer_save_reload",
           "[vehicle][save][airship_save]" )
{
    SECTION( "main_reality_bubble_after_descending" ) {
        airship_bubble_reload_after_descending();
    }
    SECTION( "independent_map_views" ) {
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
}
