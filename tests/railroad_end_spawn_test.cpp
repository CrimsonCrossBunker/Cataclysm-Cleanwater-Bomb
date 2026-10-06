#include <string>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "overmapbuffer.h"
#include "rng.h"
#include "type_id.h"
#include "vehicle.h"

static const vproto_id vehicle_prototype_motorized_draisine_2seats( "motorized_draisine_2seats" );
static const vproto_id vehicle_prototype_motorized_draisine_6seats( "motorized_draisine_6seats" );

TEST_CASE( "railroad_end_vehicle_spawns", "[.][railroads][vehicle][mapgen]" )
{
    // Snapshot the shared engine to restore global state, not to generate random values.
    struct restore_rng {
        cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
        ~restore_rng() {
            rng_get_engine() = saved;
        }
    } restore;
    rng_set_engine_seed( 3404 );
    clear_map_without_vision();
    const std::string suffix = GENERATE( "north", "east", "south", "west" );
    const tripoint_abs_omt pos = project_to<coords::omt>( get_map().get_abs_sub() );
    overmap_buffer.ter_set( pos, oter_str_id( "railroad_end_" + suffix ).id() );
    int two_seat_spawns = 0;
    int six_seat_spawns = 0;
    // Keep the existing 40% chances; a fixed, bounded sample exercises both entries.
    for( int attempt = 0; attempt < 12; ++attempt ) {
        smallmap generated;
        generated.generate( pos, calendar::turn, false, true );
        map &generated_map = *generated.cast_to_map();
        for( const wrapped_vehicle &entry : generated.get_vehicles() ) {
            if( entry.v->type == vehicle_prototype_motorized_draisine_2seats ) {
                ++two_seat_spawns;
            } else if( entry.v->type == vehicle_prototype_motorized_draisine_6seats ) {
                ++six_seat_spawns;
            } else {
                continue;
            }
            CAPTURE( suffix, attempt, entry.v->type.str() );
            for( const int index : entry.v->rail_wheelcache ) {
                CHECK( generated_map.has_flag_ter_or_furn( ter_furn_flag::TFLAG_RAIL,
                        entry.v->bub_part_pos( generated_map, index ) ) );
            }
        }
    }
    CAPTURE( suffix, two_seat_spawns, six_seat_spawns );
    CHECK( two_seat_spawns > 0 );
    CHECK( six_seat_spawns > 0 );
}
