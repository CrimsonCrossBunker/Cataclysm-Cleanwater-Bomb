#include <set>
#include <memory>
#include <functional>
#include <string>
#include <vector>

#include "avatar.h"
#include "ballistics.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "damage.h"
#include "debug.h"
#include "dispersion.h"
#include "game.h"
#include "map.h"
#include "map_helpers.h"
#include "map_scale_constants.h"
#include "player_helpers.h"
#include "point.h"
#include "projectile.h"
#include "type_id.h"
#include "world_position.h"

static const ammo_effect_str_id ammo_effect_STREAM( "STREAM" );
static const damage_type_id damage_bash( "bash" );
static const mtype_id mon_bee( "mon_bee" );
static const mtype_id mon_zombie( "mon_zombie" );
static const ter_str_id ter_t_open_air( "t_open_air" );

TEST_CASE( "projectiles_stop_at_the_loaded_map_boundary", "[projectile][bounds]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const point direction = GENERATE( point::west, point::east, point::north,
                                      point::south, point::north_west, point::south_east );
    const tripoint_bub_ms source( direction.x < 0 ? 1 : direction.x > 0 ? MAPSIZE_X - 2 : 60,
                                  direction.y < 0 ? 1 : direction.y > 0 ? MAPSIZE_Y - 2 : 60, 0 );
    const tripoint_bub_ms target = source + tripoint_rel_ms( direction.x, direction.y, 0 );
    you.setpos( here, source );
    REQUIRE( g->place_critter_at( mon_zombie, target ) != nullptr );
    projectile shot;
    shot.speed = 1000;
    shot.range = 12;
    shot.impact.add_damage( damage_bash, 1 );
    shot.proj_effects.insert( ammo_effect_STREAM );
    dealt_projectile_attack attack;
    const std::string diagnostics = capture_debugmsg_during( [&]() {
        projectile_attack( attack, shot, source, target, dispersion_sources(), &you );
    } );
    CHECK( diagnostics.empty() );
    CHECK( here.inbounds( attack.end_point ) );
    CHECK( attack.end_point == target );
}

TEST_CASE( "vertical_projectiles_stop_at_the_loaded_map_boundary", "[projectile][bounds]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const int direction = GENERATE( -1, 1 );
    const int boundary_z = direction > 0 ? OVERMAP_HEIGHT : -OVERMAP_DEPTH;
    const tripoint_bub_ms source( 60, 60, boundary_z - direction );
    const tripoint_bub_ms target( 60, 60, boundary_z );
    here.ter_set( source, ter_t_open_air );
    here.ter_set( target, ter_t_open_air );
    you.setpos( here, source );
    REQUIRE( g->place_critter_at( mon_bee, target ) != nullptr );
    projectile shot;
    shot.speed = 1000;
    shot.range = 12;
    shot.impact.add_damage( damage_bash, 1 );
    shot.proj_effects.insert( ammo_effect_STREAM );
    dealt_projectile_attack attack;
    const std::string diagnostics = capture_debugmsg_during( [&]() {
        projectile_attack( attack, shot, source, target, dispersion_sources(), &you );
    } );
    CHECK( diagnostics.empty() );
    CHECK( here.inbounds( attack.end_point ) );
    CHECK( attack.end_point == target );
}



TEST_CASE( "fractional_projectile_path_starts_at_the_actual_shooting_position",
           "[projectile][render3d]" )
{
    clear_avatar();
    clear_map_without_vision();
    map &here = get_map();
    avatar &you = get_avatar();
    const tripoint_bub_ms source( 60, 60, 0 );
    const tripoint_bub_ms target( 62, 61, 0 );
    you.setpos( here, source, false );
    CHECK( projectile_path( here, source, target, &you, nullptr ) ==
           here.find_clear_path( source, target ) );

    const auto offset = world_position::from_tile( here.get_abs( source ), tripoint( 128, 240, 0 ) );
    REQUIRE( offset );
    you.setpos( here, *offset, false );
    const std::vector<tripoint_bub_ms> expected = {
        source + point::south, source + point::south_east, target
    };
    CHECK( projectile_path( here, source, target, &you, nullptr ) == expected );
    const std::vector<tripoint_bub_ms> reversed = {
        source + point::south_east, source + point::south, source
    };
    CHECK( projectile_path( here, target, source, nullptr, &you ) == reversed );
}
