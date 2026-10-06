#include <array>
#include <cstdint>
#include <functional>
#include <set>
#include <string>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "coordinates.h"
#include "enums.h"
#include "map.h"
#include "map_helpers.h"
#include "mapdata.h"
#include "mapbuffer.h"
#include "map_scale_constants.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "point.h"
#include "regional_settings.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vehicle_uid.h"

static const itype_id itype_gasoline( "gasoline" );

static const oter_str_id oter_field( "field" );
static const vproto_id vehicle_prototype_motorized_draisine_2seats( "motorized_draisine_2seats" );
static const vproto_id vehicle_prototype_motorized_draisine_6seats( "motorized_draisine_6seats" );

namespace
{
// Generate the real Mod mapgen, then assemble its terrain in the active map.
// Random wrecks are omitted so that these tests isolate track geometry.
void stamp_railroad( map &here, const point_bub_ms &offset, const std::string &terrain, int z = 0 )
{
    const tripoint_abs_omt pos( project_to<coords::omt>( here.get_abs_sub() ).xy(), z );
    const oter_str_id id( terrain );
    REQUIRE( id.is_valid() );
    for( int x = -1; x <= 1; ++x ) {
        for( int y = -1; y <= 1; ++y ) {
            overmap_buffer.ter_set( pos + tripoint( x, y, 0 ), oter_field.id() );
        }
    }
    overmap_buffer.ter_set( pos, id.id() );
    smallmap generated;
    generated.generate( pos, calendar::turn, false, true );
    for( int x = 0; x < 24; ++x ) {
        for( int y = 0; y < 24; ++y ) {
            const tripoint_omt_ms from( x, y, z );
            const tripoint_bub_ms to( offset.x() + x, offset.y() + y, z );
            here.ter_set( to, generated.ter( from ) );
            here.furn_set( to, generated.furn( from ) );
        }
    }
}

void move_along_rail( map &here, vehicle &veh, int steps, bool reverse, bool all_wheels = true )
{
    for( int i = 0; i < steps; ++i ) {
        const tripoint_bub_ms before = veh.pos_bub( here );
        CAPTURE( i, before, veh.face.dir(), reverse );
        REQUIRE( veh.can_use_rails( here ) );
        veh.velocity = reverse ? -400 : 400;
        veh.of_turn = 100;
        REQUIRE( veh.act_on_map( here ) == &veh );
        REQUIRE( veh.pos_bub( here ) != before );
        REQUIRE_FALSE( veh.skidding );
        REQUIRE( veh.can_use_rails( here ) );
        if( all_wheels ) {
            for( const int index : veh.rail_wheelcache ) {
                REQUIRE( here.has_flag_ter_or_furn( ter_furn_flag::TFLAG_RAIL, veh.bub_part_pos( here, index ) ) );
            }
        }
    }
}
} // namespace

TEST_CASE( "railroad_station_track_alignment", "[.][railroads][vehicle][mapgen]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const bool south = GENERATE( false, true );
    const int line = GENERATE( 0, 1 );
    const vproto_id prototype = GENERATE( vehicle_prototype_motorized_draisine_2seats,
                                          vehicle_prototype_motorized_draisine_6seats );
    CAPTURE( south, line, prototype.str() );
    const int rotation = GENERATE( 0, 1, 2, 3 );
    const std::array<std::string, 4> suffixes = { "north", "east", "south", "west" };
    const point_bub_ms station_origin( 48, 48 );
    const point offset = point( 0, south ? 24 : -24 ).rotate( rotation );
    const std::string straight = rotation % 2 == 0 ? "railroad_ns" : "railroad_ew";
    const std::string station = std::string( south ? "railroad_station_0_4_" : "railroad_station_0_1_" )
                                + suffixes[rotation];
    CAPTURE( rotation );
    stamp_railroad( here, station_origin, station );
    stamp_railroad( here, station_origin + point_rel_ms( offset ), straight );
    const point local_start = point( ( line == 0 ? 7 : 18 ) - ( south ? 2 : 0 ),
                                     south ? 33 : -9 ).rotate( rotation, point( 24, 24 ) );
    const tripoint_bub_ms start( station_origin.x() + local_start.x, station_origin.y() + local_start.y,
                                 0 );
    const units::angle direction = units::from_degrees( ( ( south ? 270 : 90 ) + rotation * 90 ) %
                                   360 );
    vehicle *veh = here.add_vehicle( prototype, start, direction, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    const std::set<tripoint_abs_ms> original_points = veh->get_points();
    move_along_rail( here, *veh, 23, false );
    CHECK( veh->face.dir() == direction );
    move_along_rail( here, *veh, 23, true );
    CHECK( veh->get_points() == original_points );
}

TEST_CASE( "railroad_curve_driving", "[.][railroads][vehicle][mapgen]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const int line = GENERATE( 0, 1 );
    const int rotation = GENERATE( 0, 1, 2, 3 );
    const vproto_id prototype = GENERATE( vehicle_prototype_motorized_draisine_2seats,
                                          vehicle_prototype_motorized_draisine_6seats );
    const std::array<std::string, 4> curves = { "railroad_es", "railroad_sw", "railroad_wn", "railroad_ne" };
    const point_bub_ms corner( 48, 48 );
    const point south = point( 0, 24 ).rotate( rotation );
    const point east = point( 24, 0 ).rotate( rotation );
    stamp_railroad( here, corner, curves[rotation] );
    stamp_railroad( here, corner + point_rel_ms( south ),
                    rotation % 2 == 0 ? "railroad_ns" : "railroad_ew" );
    stamp_railroad( here, corner + point_rel_ms( east ),
                    rotation % 2 == 0 ? "railroad_ew" : "railroad_ns" );
    stamp_railroad( here, corner + point_rel_ms( east * 2 ),
                    rotation % 2 == 0 ? "railroad_ew" : "railroad_ns" );
    const point local_start = point( line == 0 ? 5 : 16, 39 ).rotate( rotation, point( 24, 24 ) );
    const tripoint_bub_ms start( corner.x() + local_start.x, corner.y() + local_start.y, 0 );
    const units::angle direction = units::from_degrees( ( 270 + rotation * 90 ) % 360 );
    CAPTURE( line, rotation, prototype.str() );
    vehicle *veh = here.add_vehicle( prototype, start, direction, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    const std::set<tripoint_abs_ms> original_points = veh->get_points();
    move_along_rail( here, *veh, 45, false, false );
    CHECK( veh->face.dir() == units::from_degrees( rotation * 90 ) );
    move_along_rail( here, *veh, 45, true, false );
    CHECK( veh->face.dir() == direction );
    CHECK( veh->get_points() == original_points );
}

TEST_CASE( "railroad_level_crossing_driving", "[.][railroads][vehicle][mapgen]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const int line = GENERATE( 0, 1 );
    stamp_railroad( here, point_bub_ms( 48, 24 ), "railroad_ns" );
    stamp_railroad( here, point_bub_ms( 48, 48 ), "railroad_level_crossing_north" );
    stamp_railroad( here, point_bub_ms( 48, 72 ), "railroad_ns" );
    vehicle *veh = here.add_vehicle( vehicle_prototype_motorized_draisine_2seats,
                                     tripoint_bub_ms( 48 + ( line == 0 ? 7 : 18 ), 39, 0 ),
                                     90_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    const std::set<tripoint_abs_ms> original_points = veh->get_points();
    move_along_rail( here, *veh, 40, false );
    move_along_rail( here, *veh, 40, true );
    CHECK( veh->get_points() == original_points );
}

TEST_CASE( "railroad_bridge_driving", "[.][railroads][vehicle][mapgen]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const int line = GENERATE( 0, 1 );
    stamp_railroad( here, point_bub_ms( 48, 24 ), "railroad_ns" );
    stamp_railroad( here, point_bub_ms( 48, 48 ), "railroad_bridgehead_ground_north" );
    stamp_railroad( here, point_bub_ms( 48, 48 ), "railroad_bridgehead_ramp_north", 1 );
    stamp_railroad( here, point_bub_ms( 48, 72 ), "railroad_bridge_north" );
    stamp_railroad( here, point_bub_ms( 48, 72 ), "railroad_bridge_overpass_north", 1 );
    stamp_railroad( here, point_bub_ms( 48, 96 ), "railroad_bridgehead_ground_south" );
    stamp_railroad( here, point_bub_ms( 48, 96 ), "railroad_bridgehead_ramp_south", 1 );
    here.invalidate_map_cache( 0 );
    here.invalidate_map_cache( 1 );
    here.build_map_cache( 0, true );
    here.build_map_cache( 1, true );
    vehicle *veh = here.add_vehicle( vehicle_prototype_motorized_draisine_2seats,
                                     tripoint_bub_ms( 48 + ( line == 0 ? 7 : 18 ), 40, 0 ),
                                     90_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    const std::set<tripoint_abs_ms> original_points = veh->get_points();
    move_along_rail( here, *veh, 40, false );
    CHECK( veh->pos_bub( here ).z() == 1 );
    move_along_rail( here, *veh, 34, false );
    CHECK( veh->pos_bub( here ).z() == 0 );
    move_along_rail( here, *veh, 74, true );
    CHECK( veh->get_points() == original_points );
}

TEST_CASE( "railroad_vehicle_save_reload", "[.][railroads][vehicle][save]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    stamp_railroad( here, point_bub_ms( 48, 24 ), "railroad_ns" );
    stamp_railroad( here, point_bub_ms( 48, 48 ), "railroad_station_0_1_north" );
    vehicle *veh = here.add_vehicle( vehicle_prototype_motorized_draisine_2seats,
                                     tripoint_bub_ms( 55, 35, 0 ), 90_degrees, 100, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    move_along_rail( here, *veh, 20, false );
    const tripoint_abs_sm origin = here.get_abs_sub();
    const std::set<tripoint_abs_ms> saved_points = veh->get_points();
    const int64_t uid = veh->uid().get_value();
    const units::angle direction = veh->face.dir();
    here.save();
    MAPBUFFER.save();
    int shifted = 0;
    on_out_of_scope restore( [&here, &shifted]() {
        while( shifted > 0 ) {
            here.shift( point_rel_sm::west );
            --shifted;
        }
    } );
    // Follow normal bubble movement so no stale vehicle cache survives unloading.
    for( ; shifted < 12; ++shifted ) {
        here.shift( point_rel_sm::east );
    }
    MAPBUFFER.clear_outside_reality_bubble();
    while( shifted > 0 ) {
        here.shift( point_rel_sm::west );
        --shifted;
    }
    CHECK( here.get_abs_sub() == origin );
    vehicle *loaded = vehicle::find_vehicle_by_uid( here, uid );
    REQUIRE( loaded );
    CHECK( loaded->get_points() == saved_points );
    CHECK( loaded->face.dir() == direction );
    CHECK( loaded->can_use_rails( here ) );
    move_along_rail( here, *loaded, 10, true );
}

TEST_CASE( "railroad_junction_driving", "[.][railroads][vehicle][mapgen]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const int line = GENERATE( 0, 1 );
    const bool right = GENERATE( false, true );
    stamp_railroad( here, point_bub_ms( 48, 48 ), "railroad_esw" );
    stamp_railroad( here, point_bub_ms( 48, 72 ), "railroad_ns" );
    stamp_railroad( here, point_bub_ms( 24, 48 ), "railroad_ew" );
    stamp_railroad( here, point_bub_ms( 72, 48 ), "railroad_ew" );
    const tripoint_bub_ms start( 48 + ( line == 0 ? 5 : 16 ), 87, 0 );
    vehicle *veh = here.add_vehicle( vehicle_prototype_motorized_draisine_2seats, start,
                                     270_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( veh );
    veh->turn( right ? 15_degrees : -15_degrees );
    move_along_rail( here, *veh, 45, false, false );
    CAPTURE( line, right, veh->pos_bub( here ) );
    CHECK( veh->face.dir() == ( right ? 0_degrees : 180_degrees ) );
    const bool reached_branch = right ? veh->pos_bub( here ).x() >= 72 : veh->pos_bub( here ).x() < 48;
    CHECK( reached_branch );
}

TEST_CASE( "railroad_powered_driving", "[.][railroads][vehicle]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &driver = get_avatar();
    const vproto_id prototype = GENERATE( vehicle_prototype_motorized_draisine_2seats,
                                          vehicle_prototype_motorized_draisine_6seats );
    stamp_railroad( here, point_bub_ms( 48, 24 ), "railroad_ns" );
    stamp_railroad( here, point_bub_ms( 48, 48 ), "railroad_ns" );
    stamp_railroad( here, point_bub_ms( 48, 72 ), "railroad_ns" );
    const tripoint_bub_ms start( 55, 39, 0 );
    vehicle *veh = here.add_vehicle( prototype, start, 90_degrees, 70, veh_spawn_status::PRISTINE );
    REQUIRE( veh );
    driver.setpos( here, start );
    here.board_vehicle( start, &driver );
    REQUIRE( driver.in_vehicle );
    on_out_of_scope unboard( [&here, &driver]() {
        driver.controlling_vehicle = false;
        here.unboard_vehicle( driver.pos_bub( here ) );
    } );
    const int64_t starting_fuel = veh->fuel_left( here, itype_gasoline );
    REQUIRE( starting_fuel > 0 );
    REQUIRE( veh->safe_velocity( here ) > 0 );
    veh->start_engines( here, &driver, true );
    REQUIRE( driver.controlling_vehicle );
    process_activity( driver );
    REQUIRE( veh->engine_on );
    veh->cruise_velocity = 1000;
    for( int i = 0; i < 8; ++i ) {
        here.vehmove();
        veh->idle( here, true );
        REQUIRE( veh->can_use_rails( here ) );
        REQUIRE_FALSE( veh->skidding );
    }
    CHECK( veh->velocity > 0 );
    CHECK( veh->pos_bub( here ).y() > start.y() );
    CHECK( veh->fuel_left( here, itype_gasoline ) < starting_fuel );
}

TEST_CASE( "railroad_world_generation", "[.][railroads][overmap]" )
{
    // Snapshot the shared engine to restore global state, not to generate random values.
    struct restore_rng {
        cata_default_random_engine saved = rng_get_engine(); // NOLINT(cata-determinism)
        ~restore_rng() {
            rng_get_engine() = saved;
        }
    } restore;
    // Earlier mapgen cases may already have populated this overmap or consumed
    // its unique-special deck.  Generate this fixture from a fresh buffer.
    overmap_buffer.clear();
    rng_set_engine_seed( 3404 );
    // Stay inland: the default region becomes ocean east of overmap x=10.
    const point_abs_om location( 1, 0 );
    const region_settings_id region = overmap_buffer.get_overmap_region( tripoint_abs_om( location,
                                      0 ) );
    CAPTURE( region.str(), region->place_railroads, region->get_settings_city().city_size );
    REQUIRE( region->place_railroads );
    REQUIRE( region->get_settings_city().city_size > 0 );
    const overmap_special_id station( "Railway Station" );
    REQUIRE( station.is_valid() );
    REQUIRE( station->has_flag( "OVERMAP_UNIQUE" ) );
    const auto &occurrences = station->get_constraints().occurrences;
    REQUIRE( occurrences.min > 0 );
    REQUIRE( occurrences.max >= occurrences.min );
    // The real Mod uses a 50/100 deck, so an individual overmap is allowed to
    // draw no station.  Supply a pending placement to test generation rather
    // than assert that an optional draw always wins.
    overmap_buffer.get_deck_state( station, occurrences.min, occurrences.max ).to_place = 1;
    const overmap &generated = overmap_buffer.get( location );
    int rail_tiles = 0;
    int stations = 0;
    for( int x = 0; x < OMAPX; ++x ) {
        for( int y = 0; y < OMAPY; ++y ) {
            const oter_type_str_id type = generated.ter( tripoint_om_omt( x, y, 0 ) )->get_type_id();
            rail_tiles += type.str() == "railroad";
            stations += type.str() == "railroad_station_0_1";
        }
    }
    CAPTURE( rail_tiles, stations );
    CHECK( rail_tiles > 0 );
    CHECK( stations > 0 );
}

TEST_CASE( "railroad_station_starter_vehicle", "[.][railroads][vehicle][mapgen]" )
{
    clear_avatar();
    clear_map_without_vision();
    const std::string suffix = GENERATE( "north", "east", "south", "west" );
    const tripoint_abs_omt pos = project_to<coords::omt>( get_map().get_abs_sub() );
    overmap_buffer.ter_set( pos, oter_str_id( "railroad_station_0_4_" + suffix ).id() );
    smallmap generated;
    generated.generate( pos, calendar::turn, false, true );
    vehicle *starter = nullptr;
    for( const wrapped_vehicle &entry : generated.get_vehicles() ) {
        if( entry.v->type == vehicle_prototype_motorized_draisine_2seats ) {
            REQUIRE_FALSE( starter );
            starter = entry.v;
        }
    }
    CAPTURE( suffix );
    REQUIRE( starter );
    map &generated_map = *generated.cast_to_map();
    CHECK( starter->fuel_left( generated_map, itype_gasoline ) > 0 );
    CHECK( starter->safe_velocity( generated_map ) > 0 );
    CHECK( starter->can_use_rails( generated_map ) );
    REQUIRE_FALSE( starter->engines.empty() );
    starter->start_engines( generated_map );
    for( const int index : starter->engines ) {
        REQUIRE( starter->start_engine( generated_map, starter->part( index ) ) );
    }
    for( const int index : starter->rail_wheelcache ) {
        CHECK( generated_map.has_flag_ter_or_furn( ter_furn_flag::TFLAG_RAIL,
                starter->bub_part_pos( generated_map, index ) ) );
    }
}
