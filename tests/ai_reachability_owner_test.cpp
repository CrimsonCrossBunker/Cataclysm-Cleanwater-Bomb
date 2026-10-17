#include <memory>

#include "ai_reachability_owner.h"
#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "field.h"
#include "field_type.h"
#include "creature_tracker.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "level_cache.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "mapdata.h"
#include "maptile_fwd.h"
#include "monster.h"
#include "options_helpers.h"
#include "player_helpers.h"
#include "rng.h"
#include "submap.h"
#include "type_id.h"
#include "units.h"
#include "vehicle.h"

namespace
{
std::unique_ptr<ai_reachability::output> original_map_predicate( const map &here )
{
    auto result = std::make_unique<ai_reachability::output>();
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        for( int x = 0; x < MAPSIZE_X; ++x ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                const tripoint_bub_ms loc{ x, y, z };
                result->passable[z + OVERMAP_DEPTH][x][y] =
                    here.is_transparent_wo_fields( loc ) || here.passable( loc );
                const auto passable_down = [&]( const auto & tile, const ter_t & ter ) {
                    return ( ( ter.movecost != 0 && tile.get_furn_t().movecost >= 0 ) ||
                             here.is_transparent_wo_fields( loc ) ) &&
                           ( ter.has_flag( ter_furn_flag::TFLAG_NO_FLOOR ) ||
                             ter.has_flag( ter_furn_flag::TFLAG_GOES_DOWN ) );
                };
                const auto upper = here.maptile_at( loc );
                const ter_t &terrain = upper.get_ter_t();
                result->up[z + OVERMAP_DEPTH][x][y] = !terrain.id.is_null() &&
                                                      passable_down( upper, terrain );
                const auto above = here.maptile_at( loc + tripoint::above );
                const ter_t &above_terrain = above.get_ter_t();
                // The old down branch deliberately takes both terrain references
                // from above, but furniture from loc. Keep exact behavior here.
                result->down[z + OVERMAP_DEPTH][x][y] = !above_terrain.id.is_null() &&
                                                        passable_down( upper, above_terrain );
            }
        }
    }
    return result;
}
} // namespace

TEST_CASE( "ai_reachability_captured_geometry_matches_actual_map_and_owns_its_inputs",
           "[monster][ai_reachability][owner]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    for( int z = -1; z <= 1; ++z ) {
        for( int x : {
                 0, 11, 12, MAPSIZE_X - 1
             } ) {
            for( int y : {
                     0, 11, 12, MAPSIZE_Y - 1
                 } ) {
                here.ter_set( tripoint_bub_ms{ x, y, z }, ter_id( z == 0 ? "t_stairs_down" : "t_open_air" ) );
                REQUIRE( here.furn_set( tripoint_bub_ms{ x, y, z }, furn_id( "f_bookcase" ),
                                        false, false, true ) );
            }
        }
        here.invalidate_map_cache( z );
        here.build_map_cache( z );
    }
    auto values = std::make_unique<ai_reachability::snapshot>();
    const auto rng_before = rng_get_engine();
    REQUIRE( ai_reachability::capture_geometry( here, *values ) );
    CHECK( ai_reachability::geometry_matches( here, *values ) );
    auto expected = original_map_predicate( here );
    here.ter_set( tripoint_bub_ms{ 12, 12, 0 }, ter_id( "t_wall" ) );
    here.furn_set( tripoint_bub_ms{ 12, 12, 0 }, furn_id( "f_null" ) );
    ai_reachability::frame frame( 4 );
    auto request = frame.try_acquire();
    frame.capture() = *values;
    REQUIRE( frame.prepare( request ) );
    CHECK_FALSE( ai_reachability::geometry_matches( here, *frame.captured() ) );
    REQUIRE( frame.used_workers() );
    REQUIRE( frame.result() != nullptr );
    CHECK( frame.result()->passable == expected->passable );
    CHECK( frame.result()->up == expected->up );
    CHECK( frame.result()->down == expected->down );
    CHECK( rng_get_engine() == rng_before );
    tinymap unsupported;
    CHECK_FALSE( ai_reachability::capture_geometry( *unsupported.cast_to_map(), *values ) );
}

TEST_CASE( "ai_reachability_owner_path_preserves_order_across_terrain_and_lifecycle_changes",
           "[monster][ai_reachability][owner]" )
{
    std::vector<std::vector<tripoint_abs_ms>> baseline;
    for( const char *workers : {
             "0", "1", "4"
         } ) {
        override_option option( "AI_REACHABILITY_WORKERS", workers );
        clear_map_without_vision();
        clear_avatar();
        map &here = get_map();
        avatar &player = get_avatar();
        player.setpos( here, { 115, 115, 0 } );
        std::vector<monster *> creatures;
        for( int x = 42; x < 62; ++x ) {
            for( int y = 42; y < 62; ++y ) {
                here.ter_set( tripoint_bub_ms{ x, y, -1 }, ter_id( "t_rock" ) );
                here.ter_set( tripoint_bub_ms{ x, y, 0 }, ter_id( "t_floor" ) );
                here.ter_set( tripoint_bub_ms{ x, y, 1 }, ter_id( "t_floor" ) );
                if( creatures.size() < 80 ) {
                    creatures.push_back( &spawn_test_monster( "mon_zombie", { x, y, 0 } ) );
                }
            }
        }
        creature_tracker &tracker = get_creature_tracker();
        std::vector<std::vector<tripoint_abs_ms>> observed;
        const auto collect = [&]() {
            std::vector<tripoint_abs_ms> row;
            tracker.for_each_reachable( *creatures.front(), [&]( Creature * other ) {
                row.push_back( other->pos_abs() );
            } );
            REQUIRE_FALSE( row.empty() );
            observed.push_back( std::move( row ) );
        };
        const auto before = rng_get_engine();
        for( int z = -1; z <= 1; ++z ) {
            here.invalidate_map_cache( z );
            here.build_map_cache( z );
        }
        tracker.invalidate_reachability_cache();
        tracker.precompute_all_zones();
        collect();
        here.ter_set( tripoint_bub_ms{ 43, 43, 0 }, ter_id( "t_stairs_down" ) );
        collect();
        tracker.swap_positions( *creatures[2], *creatures[3] );
        collect();
        creatures.back()->set_hp( 0 );
        tracker.remove( *creatures.back() );
        tracker.invalidate_reachability_cache();
        collect();
        CHECK( rng_get_engine() == before );
        if( workers[0] == '0' ) {
            baseline = observed;
        } else {
            CHECK( observed == baseline );
        }
    }
}

TEST_CASE( "ai_reachability_geometry_freshness_observes_direct_bulk_and_storage_changes",
           "[monster][ai_reachability][owner]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    submap *sm = here.maptile_at( tripoint_bub_ms{ 48, 48, 0 } ).wrapped_submap();
    REQUIRE( sm != nullptr );
    sm->set_all_ter( ter_id( "t_floor" ) );
    sm->set_ter( point_sm_ms{ 1, 2 }, ter_id( "t_stairs_down" ) );
    auto values = std::make_unique<ai_reachability::snapshot>();
    REQUIRE( ai_reachability::capture_geometry( here, *values ) );
    REQUIRE( ai_reachability::geometry_matches( here, *values ) );
    const auto before_stamp = sm->geometry_stamp();
    ai_reachability::frame previous( 0 );
    auto previous_request = previous.try_acquire();
    previous.capture() = *values;
    REQUIRE( previous.prepare( previous_request ) );
    // The test listener reseeds every SECTION after this shared setup. Match
    // that boundary so mutations and preparation are checked against its seed.
    const unsigned seed = Catch::getCurrentContext().getConfig()->rngSeed();
    rng_set_engine_seed( seed ? seed : rng_get_first_seed() );
    const auto rng_before = rng_get_engine();
    SECTION( "direct_terrain_same_cost_and_transparency" ) {
        sm->set_ter( point_sm_ms{ 2, 2 }, ter_id( "t_stairs_down" ) );
    }
    SECTION( "direct_furniture" ) {
        sm->set_furn( point_sm_ms{ 2, 2 }, furn_id( "f_bookcase" ) );
    }
    SECTION( "all_terrain" ) {
        sm->set_all_ter( ter_id( "t_open_air" ) );
    }
    SECTION( "all_furniture" ) {
        sm->set_all_furn( furn_id( "f_bookcase" ) );
    }
    SECTION( "rotate" ) {
        sm->rotate( 1 );
    }
    SECTION( "mirror" ) {
        sm->mirror( true );
    }
    SECTION( "revert_nonuniform" ) {
        submap replacement;
        replacement.set_all_ter( ter_id( "t_stairs_down" ) );
        sm->revert_submap( replacement );
    }
    SECTION( "revert_uniform" ) {
        submap replacement;
        replacement.set_all_ter( ter_id( "t_wall" ), true );
        sm->revert_submap( replacement );
    }
    SECTION( "merge" ) {
        submap overlay;
        overlay.set_all_ter( ter_id( "t_stairs_down" ) );
        sm->merge_submaps( &overlay, true );
    }
    SECTION( "terrain_reload" ) {
        const std::string terrain = "[[\"t_floor\"," + std::to_string( submap::elements ) + "]]";
        sm->load( json_loader::from_string( terrain ), "terrain", 32 );
    }
    SECTION( "furniture_reload" ) {
        sm->load( json_loader::from_string( "[[2,2,\"f_bookcase\"]]" ), "furniture", 32 );
    }
    SECTION( "move_replaces_existing_storage" ) {
        submap replacement;
        replacement.set_all_ter( ter_id( "t_open_air" ) );
        *sm = std::move( replacement );
    }
    SECTION( "loaded_block_positions_change" ) {
        submap *other = here.maptile_at( tripoint_bub_ms{ 60, 48, 0 } ).wrapped_submap();
        REQUIRE( other != nullptr );
        REQUIRE( other != sm );
        std::swap( *sm, *other );
    }
    SECTION( "derived_transparency_changes_without_geometry_write" ) {
        auto &cache = const_cast<level_cache &>( here.get_cache_ref( 0 ) );
        cache.transparent_cache_wo_fields[50].flip( 50 );
    }
    CHECK_FALSE( ai_reachability::geometry_matches( here, *values ) );
    const auto expected_current = original_map_predicate( here );
    ai_reachability::geometry_view checked( here, *previous.captured() );
    CHECK( checked.matches_at( tripoint_bub_ms{ 75, 75, 0 }, 1 ) );
    CHECK_FALSE( checked.matches_at( tripoint_bub_ms{ 50, 50, 0 }, 1 ) );
    if( sm->geometry_stamp() != before_stamp ) {
        // Downward traversal also depends on the upper block, although its
        // destination block and transparency remain unchanged.
        CHECK_FALSE( checked.matches_at( tripoint_bub_ms{ 50, 50, -1 }, -1 ) );
    }
    CHECK( checked.stale() );
    std::size_t incorrect_reuses = 0;
    std::size_t validated_cells = 0;
    for( int z = -OVERMAP_DEPTH; z <= OVERMAP_HEIGHT; ++z ) {
        for( int x = 0; x < MAPSIZE_X; ++x ) {
            for( int y = 0; y < MAPSIZE_Y; ++y ) {
                for( int direction : {
                         1, -1
                     } ) {
                    if( checked.matches_at( tripoint_bub_ms{ x, y, z }, direction ) ) {
                        ++validated_cells;
                        const auto &old = direction == 1 ? previous.result()->up : previous.result()->down;
                        const auto &now = direction == 1 ? expected_current->up : expected_current->down;
                        incorrect_reuses += old[z + OVERMAP_DEPTH][x][y] != now[z + OVERMAP_DEPTH][x][y];
                    }
                }
            }
        }
    }
    CHECK( validated_cells > 0 );
    CHECK( incorrect_reuses == 0 );
    REQUIRE( ai_reachability::capture_geometry( here, *values ) );
    CHECK( ai_reachability::geometry_matches( here, *values ) );
    ai_reachability::frame frame( 4 );
    auto request = frame.try_acquire();
    frame.capture() = *values;
    REQUIRE( frame.prepare( request ) );
    const auto expected = original_map_predicate( here );
    REQUIRE( frame.result() != nullptr );
    CHECK( frame.result()->passable == expected->passable );
    CHECK( frame.result()->up == expected->up );
    CHECK( frame.result()->down == expected->down );
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "ai_reachability_passability_captures_full_vehicle_and_field_rules",
           "[monster][ai_reachability][owner]" )
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    get_avatar().setpos( here, { 115, 115, 0 } );
    const tripoint_bub_ms door_pos{ 60, 60, 0 };
    const tripoint_bub_ms field_pos{ 50, 50, 0 };
    here.ter_set( door_pos, ter_id( "t_floor" ) );
    here.ter_set( field_pos, ter_id( "t_floor" ) );
    vehicle *veh = here.add_vehicle( vproto_id( "none" ), door_pos, 0_degrees, 0,
                                     veh_spawn_status::UNDAMAGED );
    REQUIRE( veh != nullptr );
    REQUIRE( veh->install_part( here, point_rel_ms::zero, vpart_id( "frame" ) ) >= 0 );
    const int door = veh->install_part( here, point_rel_ms::zero, vpart_id( "door" ) );
    REQUIRE( door >= 0 );
    veh->refresh();
    here.add_vehicle_to_cache( veh );
    const field_type_id web( "fd_web" );
    REQUIRE( here.add_field( field_pos, web, 1 ) );
    field_entry *entry = here.field_at( field_pos ).find_field( web );
    REQUIRE( entry != nullptr );
    int &field_cost = const_cast<field_intensity_level &>( entry->get_intensity_level() ).move_cost;
    restore_on_out_of_scope restore_cost( field_cost );
    ai_reachability::frame frame( 4 );
    const auto verify_fresh = [&]() {
        // Use the actual cached transparency that the original bitmap reads,
        // including opaque but otherwise movable floor cells.
        auto &cache = const_cast<level_cache &>( here.get_cache_ref( 0 ) );
        cache.transparent_cache_wo_fields[door_pos.x()].reset( door_pos.y() );
        cache.transparent_cache_wo_fields[field_pos.x()].reset( field_pos.y() );
        auto request = frame.try_acquire();
        auto &values = frame.capture();
        const auto before = rng_get_engine();
        REQUIRE( ai_reachability::capture_geometry( here, values ) );
        const auto expected = original_map_predicate( here );
        REQUIRE( frame.prepare( request ) );
        REQUIRE( frame.result() != nullptr );
        CHECK( frame.result()->passable == expected->passable );
        CHECK( frame.result()->up == expected->up );
        CHECK( frame.result()->down == expected->down );
        CHECK( rng_get_engine() == before );
    };
    veh->close( here, door );
    field_cost = -1;
    REQUIRE_FALSE( here.passable( door_pos ) );
    REQUIRE_FALSE( here.passable( field_pos ) );
    verify_fresh();
    // Fields and vehicle doors can change without terrain/furniture versions.
    // Every horizontal publication must recapture these complete decisions.
    veh->open( here, door );
    field_cost = 2;
    REQUIRE( here.passable( door_pos ) );
    REQUIRE( here.passable( field_pos ) );
    verify_fresh();
    REQUIRE( here.furn_set( field_pos, furn_id( "f_bookcase" ), false, false, true ) );
    REQUIRE_FALSE( here.passable( field_pos ) );
    verify_fresh();
    here.ter_set( door_pos, ter_id( "t_wall" ) );
    REQUIRE_FALSE( here.passable( door_pos ) );
    verify_fresh();
}
