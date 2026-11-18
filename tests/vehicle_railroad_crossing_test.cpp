#include <point.h>
#include <vpart_position.h>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "enums.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "map_scale_constants.h"
#include "mapdata.h"
#include "pathfinding.h"
#include "player_helpers.h"
#include "sounds.h"
#include "tileray.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"
#include "vpart_range.h"

static const furn_str_id furn_f_bookcase( "f_bookcase" );

static const ter_str_id ter_t_buffer_stop( "t_buffer_stop" );
static const ter_str_id ter_t_wall( "t_wall" );

static const vproto_id vehicle_prototype_car( "car" );
static const vproto_id vehicle_prototype_motorized_draisine_2seats( "motorized_draisine_2seats" );
static const vproto_id vehicle_prototype_test_shopping_cart( "test_shopping_cart" );

TEST_CASE( "road_vehicle_railroad_track_collision", "[vehicle][collision][railroads]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const tripoint_bub_ms vehicle_position( 60, 60, 0 );
    vehicle *veh = here.add_vehicle( vehicle_prototype_car, vehicle_position, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE_FALSE( veh->can_use_rails( here ) );
    const ter_str_id track( GENERATE( "t_railroad_track", "t_railroad_track_h",
                                      "t_railroad_track_v", "t_railroad_track_d",
                                      "t_railroad_track_d1", "t_railroad_track_d2",
                                      "t_railroad_track_on_tie", "t_railroad_track_h_on_tie",
                                      "t_railroad_track_v_on_tie", "t_railroad_track_d_on_tie",
                                      "t_railroad_track_small", "t_railroad_track_small_d",
                                      "t_railroad_track_recessed" ) );
    CAPTURE( track.str() );
    const tripoint_bub_ms target_position = vehicle_position + tripoint( 10, 0, 0 );
    here.ter_set( target_position, track );
    const int part_index = GENERATE_COPY( 0, veh->wheelcache.front() );
    veh->velocity = GENERATE( -1000, 1000 );

    SECTION( "track_is_not_a_horizontal_obstacle" ) {
        CHECK( veh->part_collision( here, part_index, here.get_abs( target_position ),
                                    true, false ).type == veh_coll_nothing );
        CHECK( here.ter( target_position ) == track );
    }

    SECTION( "furniture_on_track_remains_an_obstacle" ) {
        here.furn_set( target_position, furn_f_bookcase );
        CHECK( veh->part_collision( here, part_index, here.get_abs( target_position ),
                                    true, false ).type != veh_coll_nothing );
    }

    SECTION( "track_still_supports_vertical_collisions" ) {
        CHECK( veh->part_collision( here, part_index, here.get_abs( target_position ),
                                    true, true ).type != veh_coll_nothing );
    }

    SECTION( "buffer_stop_remains_an_obstacle" ) {
        here.ter_set( target_position, ter_t_buffer_stop );
        CHECK( veh->part_collision( here, part_index, here.get_abs( target_position ),
                                    true, false ).type != veh_coll_nothing );
    }
}

TEST_CASE( "road_vehicle_drives_over_railroad_tracks", "[vehicle][collision][railroads]" )
{
    clear_avatar();
    clear_map_without_vision();
    const ter_str_id track( GENERATE( "t_railroad_track", "t_railroad_track_d_on_tie",
                                      "t_railroad_track_small", "t_railroad_track_recessed" ) );
    build_test_map( track.id() );
    map &here = get_map();
    get_avatar().setpos( here, tripoint_bub_ms::zero );
    const tripoint_bub_ms vehicle_position( 60, 60, 0 );
    const vproto_id prototype = GENERATE( vehicle_prototype_car,
                                          vehicle_prototype_motorized_draisine_2seats );
    vehicle *veh = here.add_vehicle( prototype, vehicle_position, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    const int speed = GENERATE( -1000, 1000 );
    CAPTURE( track.str(), speed, prototype.str() );
    const bool on_rails = prototype == vehicle_prototype_motorized_draisine_2seats;
    CHECK( veh->can_use_rails( here ) == on_rails );
    veh->velocity = speed;
    if( !on_rails ) {
        const float traction = here.vehicle_wheel_traction( *veh );
        CHECK( traction < here.vehicle_wheel_traction( *veh, true ) );
    }
    std::vector<int> original_hp( veh->part_count() );
    std::vector<tripoint_bub_ms> original_positions( veh->part_count() );
    for( const vpart_reference &part : veh->get_all_parts() ) {
        original_hp[part.part_index()] = part.part().hp();
        original_positions[part.part_index()] = veh->bub_part_pos( here, part.part_index() );
    }
    sounds::reset_sounds();
    const tripoint_rel_ms displacement( speed > 0 ? 1 : -1, 0, 0 );
    REQUIRE( here.move_vehicle( *veh, displacement, tileray( 0_degrees ) ) == veh );
    CHECK( veh->velocity == speed );
    for( const vpart_reference &part : veh->get_all_parts() ) {
        CHECK( part.part().hp() == original_hp[part.part_index()] );
        CHECK( veh->bub_part_pos( here, part.part_index() ) ==
               original_positions[part.part_index()] + displacement );
    }
    for( const int wheel_index : veh->wheelcache ) {
        CHECK( here.ter( veh->bub_part_pos( here, wheel_index ) ) == track );
    }
    const bool recessed = track->has_flag( ter_furn_flag::TFLAG_NOCOLLIDE );
    CHECK( sounds::get_monster_sounds().first.size() == ( recessed || on_rails ? 0 : 1 ) );
    sounds::reset_sounds();
}

TEST_CASE( "autodrive_crosses_railroad_tracks", "[vehicle][autodrive][railroads]" )
{
    clear_avatar();
    clear_map_without_vision();
    build_test_map( ter_id( "t_pavement" ) );
    map &here = get_map();
    constexpr int omt_size = coords::map_squares_per( coords::omt );
    const tripoint_abs_omt current_omt =
        project_to<coords::omt>( here.get_abs( tripoint_bub_ms( 60, 60, 0 ) ) );
    const tripoint_abs_ms omt_origin = project_to<coords::ms>( current_omt );
    const tripoint_bub_ms start =
        here.get_bub( omt_origin + tripoint( omt_size - 12, omt_size / 2, 0 ) );
    const ter_str_id track( GENERATE( "t_railroad_track", "t_railroad_track_d_on_tie",
                                      "t_railroad_track_recessed" ) );
    const std::string obstacle = GENERATE( "none", "furniture", "buffer_stop" );
    CAPTURE( track.str(), obstacle );
    const int track_x = start.x() + 5;
    for( int offset_y = 0; offset_y < MAPSIZE_Y; ++offset_y ) {
        const tripoint_bub_ms crossing( track_x, offset_y, 0 );
        here.ter_set( crossing, obstacle == "buffer_stop" ? ter_t_buffer_stop : track );
        if( obstacle == "furniture" ) {
            here.furn_set( crossing, furn_f_bookcase );
        }
    }
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );

    avatar &driver = get_avatar();
    driver.clear_map_memory();
    driver.prepare_map_memory_region( omt_origin,
                                      omt_origin + tripoint( omt_size - 1, omt_size - 1, 0 ) );
    for( int offset_x = 0; offset_x < omt_size; ++offset_x ) {
        for( int offset_y = 0; offset_y < omt_size; ++offset_y ) {
            const tripoint_abs_ms position = omt_origin + tripoint( offset_x, offset_y, 0 );
            driver.memorize_terrain( position, here.ter( here.get_bub( position ) ).id().str(), 0, 0 );
        }
    }
    REQUIRE( driver.is_map_memory_valid() );
    vehicle *veh = here.add_vehicle( vehicle_prototype_car, start, 0_degrees, 100,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    veh->add_tag( "IN_CONTROL_OVERRIDE" );
    driver.setpos( here, start + tripoint::south * 8 );
    set_time_to_day();
    constexpr int cautious_speed = 3 * static_cast<int>( vehicles::vmiph_per_tile );
    veh->engine_on = true;
    veh->velocity = cautious_speed;
    veh->cruise_velocity = cautious_speed;
    veh->is_autodriving = true;
    driver.omt_path = { current_omt + tripoint::east };
    driver.set_moves( 1000 );

    if( obstacle == "none" ) {
        for( int step = 0; step < 3; ++step ) {
            CAPTURE( step );
            driver.set_moves( 1000 );
            REQUIRE( veh->do_autodrive( here, driver ) == autodrive_result::ok );
            REQUIRE( veh->cruise_velocity > 0 );
            REQUIRE( here.displace_vehicle( *veh, tripoint_rel_ms( 3, 0, 0 ) ) );
            veh->skidding = false;
            REQUIRE( veh->pos_bub( here ) == start + tripoint( 3 * ( step + 1 ), 0, 0 ) );
        }
        CHECK( veh->pos_bub( here ).x() > track_x );
    } else {
        CHECK( veh->do_autodrive( here, driver ) == autodrive_result::abort );
        CHECK_FALSE( veh->is_autodriving );
        CHECK( veh->pos_bub( here ) == start );
    }
    driver.omt_path.clear();
    here.destroy_vehicle( veh );
    sounds::reset_sounds();
}

TEST_CASE( "route_with_grab_crosses_railroad_tracks", "[pathfinding][vehicle][railroads]" )
{
    clear_avatar();
    clear_map_without_vision();
    build_test_map( ter_id( "t_pavement" ) );
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms start( 60, 60, 0 );
    const tripoint_bub_ms destination( 60, 70, 0 );
    const tripoint_bub_ms crossing( 60, 65, 0 );
    const ter_str_id track( GENERATE( "t_railroad_track", "t_railroad_track_d_on_tie",
                                      "t_railroad_track_recessed" ) );
    const std::string obstacle = GENERATE( "none", "furniture", "buffer_stop" );
    const tripoint_rel_ms grab_direction = GENERATE( tripoint_rel_ms::south, tripoint_rel_ms::north );
    CAPTURE( track.str(), obstacle, grab_direction );
    for( int offset_x = 0; offset_x < MAPSIZE_X; ++offset_x ) {
        here.ter_set( tripoint_bub_ms( offset_x, crossing.y(), 0 ), ter_t_wall );
    }
    here.ter_set( crossing, obstacle == "buffer_stop" ? ter_t_buffer_stop : track );
    if( obstacle == "furniture" ) {
        here.furn_set( crossing, furn_f_bookcase );
    }
    you.setpos( here, start );
    you.clear_destination();
    vehicle *cart = here.add_vehicle( vehicle_prototype_test_shopping_cart, start + grab_direction,
                                      0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( cart != nullptr );
    cart->set_owner( you );
    you.grab( object_type::VEHICLE, grab_direction );
    here.invalidate_map_cache( 0 );
    here.build_map_cache( 0, true );

    const std::vector<tripoint_bub_ms> route =
        route_with_grab( here, you, pathfinding_target::adjacent( destination ) );
    CHECK( route.empty() == ( obstacle != "none" ) );
    you.grab( object_type::NONE );
    here.destroy_vehicle( cart );
}



