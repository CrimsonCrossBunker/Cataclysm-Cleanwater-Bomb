#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <avatar.h>
#include <calendar.h>
#include <cata_scope_helpers.h>
#include "debug.h"
#include <character_id.h>
#include <coordinates.h>
#include <creature_tracker.h>
#include <field_type.h>
#include <item.h>
#include <monster_uid.h>
#include <talker.h>
#include <vehicle.h>
#include <vpart_position.h>

#include "lua_platform_test_map_support.h"

using cata::lua_platform::test::platform_map_api_test_fixture;
using cata::lua_platform::test::platform_vehicle_relocation_fixture;

extern "C" {
#include <lua.h>
}
#include <lua_platform_bindings_coords.h>
#include <lua_platform_bindings_values.h>
#include <lua_platform_handle.h>
#include <lua_platform_items.h>
#include <lua_platform_trade.h>
#include <lua_platform_world.h>
#include <map.h>
#include <map_scale_constants.h>
#include <memory_fast.h>
#include <monster.h>
#include <npc.h>
#include <point.h>
#include <rng.h>
#include <talker_npc.h>
#include <trap.h>
#include <type_id.h>
#include <viewer.h>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <limits>
#include <memory>
#include <optional>
#include <random>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "lua_platform_creatures.h"
#include "lua_platform_sol.h"
#include "lua_platform_test_support.h"

static const itype_id itype_knife_combat( "knife_combat" );
static const itype_id itype_rock( "rock" );
static const mtype_id mon_zombie( "mon_zombie" );
static const ter_furn_transform_id ter_furn_transform_spider_clear_webs( "spider_clear_webs" );
static const ter_str_id ter_t_floor( "t_floor" );
static const ter_str_id ter_t_pit( "t_pit" );
static const ter_str_id ter_t_wall( "t_wall" );
static const trap_str_id tr_beartrap( "tr_beartrap" );
static const trap_str_id tr_pit( "tr_pit" );
static const trap_str_id tr_rollmat( "tr_rollmat" );

TEST_CASE( "lua_platform_character_snapshot_intelligence_matches_native_talker",
           "[lua][platform][characters][conditions][semantic]" )
{
    platform_map_api_test_fixture fixture( 709, 9 );
    const auto current_runtime = [&]() {
        return fixture.active_runtime;
    };
    const auto current_world = [&]() {
        return fixture.active_world_generation;
    };
    cata::lua_platform::install_creature_api(
    fixture.services, current_runtime, current_world, []() {}, []() {} );

    avatar &player = get_avatar();
    const int original_intelligence_base = player.get_int_base();
    player.set_int_base( 12 );
    const on_out_of_scope restore_intelligence( [&player, original_intelligence_base]() {
        player.set_int_base( original_intelligence_base );
    } );

    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;
    const sol::protected_function_result snapshot_call = fixture.lua.safe_script( R"(
        local speaker = services.characters.avatar()
        return services.characters.snapshot(speaker)
    )", sol::script_pass_on_error );
    REQUIRE( snapshot_call.valid() );
    const sol::table snapshot_result = snapshot_call.get<sol::table>();
    REQUIRE( snapshot_result["ok"].get<bool>() );
    const sol::table snapshot = snapshot_result["value"].get<sol::table>();
    const sol::table stats = snapshot["stats"].get<sol::table>();

    const std::unique_ptr<talker> native_speaker = get_talker_for( player );
    REQUIRE( native_speaker );
    const int native_intelligence = native_speaker->int_cur();
    CHECK( stats["intelligence"].get<int>() == native_intelligence );
    // Compare both sides of the native response-condition threshold. The
    // generated Platform predicate reads this same snapshot field.
    for( const int threshold : {
             native_intelligence, native_intelligence + 1
         } ) {
        CHECK( ( native_intelligence >= threshold ) ==
               ( stats["intelligence"].get<int>() >= threshold ) );
    }
}

TEST_CASE( "lua_platform_player_can_see_uses_active_player_view",
           "[lua][platform][creatures][vision]" )
{
    platform_map_api_test_fixture fixture( 710, 10 );
    const auto current_runtime = [&]() {
        return fixture.active_runtime;
    };
    const auto current_world = [&]() {
        return fixture.active_world_generation;
    };
    cata::lua_platform::install_creature_api(
    fixture.services, current_runtime, current_world, []() {}, []() {} );

    avatar &player = get_avatar();
    const tripoint_bub_ms target_position = player.pos_bub() + tripoint::east;
    const shared_ptr_fast<monster> target = make_shared_fast<monster>(
            mon_zombie, target_position );
    REQUIRE( target );
    target->set_hp( 1 );
    REQUIRE( get_creature_tracker().add( target ) );
    const on_out_of_scope cleanup( [&target]() {
        if( target && get_creature_tracker().temporary_id( *target ) >= 0 ) {
            get_creature_tracker().remove( *target );
        }
    } );
    const tripoint_abs_ms position = fixture.get_map().get_abs( target_position );
    const cata::lua_platform::game_handle target_handle =
        cata::lua_platform::game_handle::from_creature(
    *target, {
        "monster", target->uid().get_value(), position.x(),
        position.y(), position.z(), {}
    },
    fixture.active_runtime, fixture.active_world_generation );
    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;
    fixture.lua["target_handle"] = target_handle;
    fixture.lua["empty_handle"] = cata::lua_platform::game_handle{};
    fixture.lua["stale_handle"] = target_handle;

    const sol::protected_function_result visible = fixture.lua.safe_script(
                "return services.creatures.player_can_see(target_handle)",
                sol::script_pass_on_error );
    REQUIRE( visible.valid() );
    const sol::table visible_result = visible.get<sol::table>();
    REQUIRE( visible_result["ok"].get<bool>() );
    // The map fixture has no remote-view switch; this checks target handle
    // resolution and delegation to the active player-view interface only.
    CHECK( visible_result["value"].get<bool>() ==
           get_player_view().sees( fixture.get_map(), *target ) );

    const sol::protected_function_result empty = fixture.lua.safe_script(
                "return services.creatures.player_can_see(empty_handle)",
                sol::script_pass_on_error );
    REQUIRE( empty.valid() );
    const sol::table empty_result = empty.get<sol::table>();
    REQUIRE_FALSE( empty_result["ok"].get<bool>() );
    CHECK( empty_result["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_kind" );

    ++fixture.active_world_generation;
    const sol::protected_function_result stale = fixture.lua.safe_script(
                "return services.creatures.player_can_see(stale_handle)",
                sol::script_pass_on_error );
    REQUIRE( stale.valid() );
    const sol::table stale_result = stale.get<sol::table>();
    REQUIRE_FALSE( stale_result["ok"].get<bool>() );
    CHECK( stale_result["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_world" );
    --fixture.active_world_generation;

    const sol::protected_function_result nil_target = fixture.lua.safe_script( R"(
        local ok = pcall(services.creatures.player_can_see, nil)
        assert(not ok)
    )", sol::script_pass_on_error );
    REQUIRE( nil_target.valid() );
}

TEST_CASE( "lua_platform_character_vehicle_condition_uses_map_occupancy",
           "[lua][platform][characters][vehicle][semantic]" )
{
    platform_vehicle_relocation_fixture fixture( 733, 32 );
    REQUIRE( fixture.test_vehicle );
    const auto current_runtime = [&]() {
        return fixture.active_runtime;
    };
    const auto current_world = [&]() {
        return fixture.active_world_generation;
    };
    cata::lua_platform::install_creature_api(
    fixture.services, current_runtime, current_world, []() {}, []() {} );

    avatar &player = get_avatar();
    player.setpos( fixture.get_map(), fixture.source_local );
    player.in_vehicle = false;
    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;

    const sol::protected_function_result on_vehicle = fixture.lua.safe_script(
                "local player = services.characters.avatar(); "
                "return services.characters.is_in_vehicle(player)",
                sol::script_pass_on_error );
    REQUIRE( on_vehicle.valid() );
    const sol::table on_vehicle_result = on_vehicle.get<sol::table>();
    REQUIRE( on_vehicle_result["ok"].get<bool>() );
    CHECK_FALSE( player.in_vehicle );
    CHECK( get_map().veh_at( player.pos_bub() ).has_value() );
    CHECK( on_vehicle_result["value"].get<bool>() ==
           get_map().veh_at( player.pos_bub() ).has_value() );

    player.setpos( fixture.get_map(), fixture.target_local );
    player.in_vehicle = true;
    const sol::protected_function_result off_vehicle = fixture.lua.safe_script(
                "local player = services.characters.avatar(); "
                "return services.characters.is_in_vehicle(player)",
                sol::script_pass_on_error );
    REQUIRE( off_vehicle.valid() );
    const sol::table off_vehicle_result = off_vehicle.get<sol::table>();
    REQUIRE( off_vehicle_result["ok"].get<bool>() );
    CHECK( player.in_vehicle );
    CHECK_FALSE( get_map().veh_at( player.pos_bub() ).has_value() );
    CHECK_FALSE( off_vehicle_result["value"].get<bool>() );

    fixture.lua["vehicle_handle"] = fixture.vehicle_handle;
    const sol::protected_function_result wrong_kind = fixture.lua.safe_script(
                "return services.characters.is_in_vehicle(vehicle_handle)",
                sol::script_pass_on_error );
    REQUIRE( wrong_kind.valid() );
    const sol::table wrong_kind_result = wrong_kind.get<sol::table>();
    REQUIRE_FALSE( wrong_kind_result["ok"].get<bool>() );
    CHECK( wrong_kind_result["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_kind" );

    const tripoint_bub_ms non_character_local =
        fixture.source_local + tripoint_rel_ms( 8, 1, 0 );
    const shared_ptr_fast<monster> non_character =
        fixture.add_monster( non_character_local );
    REQUIRE( non_character );
    const tripoint_abs_ms non_character_position =
        fixture.get_map().get_abs( non_character_local );
    fixture.lua["non_character_handle"] =
        cata::lua_platform::game_handle::from_creature(
    *non_character, {
        "monster", non_character->uid().get_value(),
        non_character_position.x(), non_character_position.y(),
        non_character_position.z(), {}
    },
    fixture.active_runtime, fixture.active_world_generation );
    const sol::protected_function_result wrong_subtype = fixture.lua.safe_script(
                "return services.characters.is_in_vehicle(non_character_handle)",
                sol::script_pass_on_error );
    REQUIRE( wrong_subtype.valid() );
    const sol::table wrong_subtype_result = wrong_subtype.get<sol::table>();
    REQUIRE_FALSE( wrong_subtype_result["ok"].get<bool>() );
    CHECK( wrong_subtype_result["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_subtype" );

    const sol::protected_function_result saved_character =
        fixture.lua.safe_script(
            "stale_character = services.characters.avatar()",
            sol::script_pass_on_error );
    REQUIRE( saved_character.valid() );
    ++fixture.active_world_generation;
    const sol::protected_function_result stale = fixture.lua.safe_script(
                "return services.characters.is_in_vehicle(stale_character)",
                sol::script_pass_on_error );
    REQUIRE( stale.valid() );
    const sol::table stale_result = stale.get<sol::table>();
    REQUIRE_FALSE( stale_result["ok"].get<bool>() );
    CHECK( stale_result["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_world" );
    --fixture.active_world_generation;
}

TEST_CASE( "lua_platform_character_snapshot_matches_npc_movement_conditions",
           "[lua][platform][characters][movement][semantic]" )
{
    platform_vehicle_relocation_fixture fixture( 734, 33 );
    REQUIRE( fixture.test_vehicle );
    const auto current_runtime = [&]() {
        return fixture.active_runtime;
    };
    const auto current_world = [&]() {
        return fixture.active_world_generation;
    };
    cata::lua_platform::install_creature_api(
    fixture.services, current_runtime, current_world, []() {}, []() {} );

    npc beta;
    beta.normalize();
    beta.setID( character_id( 7334 ), true );
    beta.spawn_at_precise( fixture.get_map().get_abs( fixture.source_local ) );
    beta.set_attitude( NPCATT_FOLLOW );
    const talker_npc_const native_beta( &beta );
    const sol::protected_function snapshot =
        fixture.services["characters"]["snapshot"];

    const auto check_native_match = [&]( const bool expected_controlling,
    const bool expected_driving, const bool expected_following ) {
        const optional_vpart_position control_vehicle = fixture.get_map().veh_at(
                    native_beta.pos_bub( fixture.get_map() ) );
        const bool native_controlling = control_vehicle &&
                                        native_beta.is_in_control_of( control_vehicle->vehicle() );
        const optional_vpart_position driving_vehicle = fixture.get_map().veh_at(
                    native_beta.pos_abs() );
        const bool native_driving = driving_vehicle &&
                                    driving_vehicle->vehicle().is_moving() &&
                                    native_beta.is_in_control_of( driving_vehicle->vehicle() );
        const bool native_following = native_beta.is_following();
        CHECK( native_controlling == expected_controlling );
        CHECK( native_driving == expected_driving );
        CHECK( native_following == expected_following );
        const tripoint_abs_ms position = beta.pos_abs();
        const cata::lua_platform::game_handle beta_handle =
            cata::lua_platform::game_handle::from_creature(
        beta, {
            "npc", beta.getID().get_value(), position.x(),
            position.y(), position.z(), {}
        },
        fixture.active_runtime, fixture.active_world_generation );
        const sol::protected_function_result result = snapshot( beta_handle );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE( envelope["ok"].get<bool>() );
        const sol::table value = envelope["value"].get<sol::table>();
        const sol::table movement = value["movement"].get<sol::table>();
        const sol::table npc_state = value["npc_state"].get<sol::table>();
        CHECK( movement["controlling_vehicle"].get<bool>() == native_controlling );
        CHECK( movement["driving"].get<bool>() == native_driving );
        CHECK( npc_state["following"].get<bool>() == native_following );
    };

    fixture.test_vehicle->tags.insert( "IN_CONTROL_OVERRIDE" );
    fixture.test_vehicle->velocity = 0;
    check_native_match( true, false, true ); // In control of a stationary vehicle.
    fixture.test_vehicle->velocity = 100;
    check_native_match( true, true, true ); // In control of a moving vehicle.
    beta.set_attitude( NPCATT_WAIT );
    check_native_match( true, true, true ); // WAIT is also a native following attitude.
    beta.set_attitude( NPCATT_KILL );
    check_native_match( true, true, false ); // Not following despite the same vehicle state.
    beta.spawn_at_precise( fixture.get_map().get_abs( fixture.target_local ) );
    check_native_match( false, false, false ); // No vehicle at the native actor square.
}

TEST_CASE( "lua_platform_nil_query_selector_preserves_explicit_options",
           "[lua][platform][map][creatures][semantic]" )
{
    platform_map_api_test_fixture fixture( 709, 9 );
    fixture.local = tripoint_bub_ms( 60, 60, 0 );
    fixture.absolute = fixture.get_map().get_abs( fixture.local );
    const auto current_runtime = [&]() {
        return fixture.active_runtime;
    };
    const auto current_world = [&]() {
        return fixture.active_world_generation;
    };
    cata::lua_platform::install_creature_api(
    fixture.services, current_runtime, current_world, []() {}, [&]() {
        fixture.write_called = true;
    } );
    cata::lua_platform::install_world_api(
    fixture.services, current_runtime, current_world, []() {}, [&]() {
        fixture.write_called = true;
    } );
    get_creature_tracker().clear();
    const on_out_of_scope cleanup( []() {
        get_creature_tracker().clear();
    } );
    for( const int offset : {
             1, 2, 4
         } ) {
        const shared_ptr_fast<monster> entry = make_shared_fast<monster>(
                mon_zombie, fixture.local + tripoint( offset, 0, 0 ) );
        entry->friendly = offset == 2 ? 0 : -1;
        REQUIRE( get_creature_tracker().add( entry ) );
    }
    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;
    fixture.lua["origin"] = fixture.position();
    const sol::protected_function_result queried = fixture.lua.safe_script( R"(
        for _, method in ipairs({"count_nearby", "count_species_nearby", "count_groups_nearby"}) do
            local count = services.monsters[method]
            local options = {radius=3, attitude="friendly"}
            assert(count(origin, nil, options).value == 1)
            assert(count(origin, {}, options).value == 1)
            assert(count(origin, nil, {radius=4, attitude="friendly"}).value == 2)
            assert(count(origin, nil, {radius=3, attitude="both"}).value == 2)
            assert(count(origin).value == 1)
            assert(not pcall(count, origin, nil, {radius=-1}))
            for _, invalid in ipairs({false, 7, "bad", function() end}) do
                assert(not pcall(count, origin, invalid, options))
            end
        end
        local find = services.world.find_location
        local shifted = find(origin, nil, {x_adjust=2})
        assert(shifted.found and shifted.position.x == origin.x + 2)
        assert(shifted.position.y == origin.y and shifted.position.z == origin.z)
        local adjusted = find(origin, nil, {x_adjust=-1, y_adjust=2, z_adjust=1})
        assert(adjusted.found and adjusted.position.x == origin.x - 1)
        assert(adjusted.position.y == origin.y + 2 and adjusted.position.z == origin.z + 1)
        local overridden = find(adjusted.position, nil, {z_adjust=-1, z_override=true})
        assert(overridden.found and overridden.position.z == -1)
        assert(overridden.position.x == adjusted.position.x and overridden.position.y == adjusted.position.y)
        assert(find(origin).position.x == origin.x)
        assert(not pcall(find, origin, nil, {x_adjust="bad"}))
        for _, invalid in ipairs({false, 7, "bad", function() end}) do
            assert(not pcall(find, origin, invalid, {x_adjust=2}))
        end
    )", sol::script_pass_on_error );
    REQUIRE( queried.valid() );
    CHECK_FALSE( fixture.write_called );
    CHECK( get_creature_tracker().size() == 3 );
    CHECK( fixture.get_map().get_abs( fixture.local ) == fixture.absolute );
}

TEST_CASE( "lua_platform_transform_radius_matches_native_scope_and_rng",
           "[lua][platform][world][transform][semantic]" )
{
    platform_map_api_test_fixture fixture( 741, 41 );
    fixture.local = tripoint_bub_ms( 60, 60, 0 );
    fixture.absolute = fixture.get_map().get_abs( fixture.local );
    const auto current_runtime = [&]() {
        return fixture.active_runtime;
    };
    const auto current_world = [&]() {
        return fixture.active_world_generation;
    };
    cata::lua_platform::install_world_api(
    fixture.services, current_runtime, current_world, []() {}, [&]() {
        fixture.write_called = true;
    } );

    map &here = fixture.get_map();
    const tripoint_bub_ms center = fixture.local;
    const tripoint_bub_ms inside = center + tripoint::east;
    const tripoint_bub_ms outside = center + tripoint::south_east;
    const field_type_id web = fd_web.id();
    REQUIRE( ter_furn_transform_spider_clear_webs.is_valid() );
    REQUIRE( here.add_field( center, web, 1, 0_turns, false ) );
    REQUIRE( here.add_field( inside, web, 1, 0_turns, false ) );
    REQUIRE( here.add_field( outside, web, 1, 0_turns, false ) );
    const on_out_of_scope remove_test_fields( [&]() {
        for( const tripoint_bub_ms &position : {
                 center, inside, outside
             } ) {
            here.remove_field( position, web );
        }
    } );

    fixture.lua.open_libraries( sol::lib::base );
    fixture.lua["services"] = fixture.services;
    fixture.lua["origin"] = fixture.position( center );

    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [&saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    constexpr unsigned int seed = 51837;
    rng_set_engine_seed( seed );
    const sol::protected_function_result transformed = fixture.lua.safe_script( R"(
        local transform = services.types.id("terrain_furniture_transform", "spider_clear_webs")
        assert(transform:is_valid())
        local wrong_kind = services.types.id("item", "rock")
        assert(not pcall(services.world.transform_radius, origin, 1, wrong_kind))
        assert(not pcall(services.world.transform_radius, origin, -1, transform))
        assert(not pcall(services.world.transform_radius, origin, 61, transform))
        local result = services.world.transform_radius(origin, 1, transform)
        assert(result.ok)
        assert(result.value.position == origin)
        assert(result.value.radius == 1)
        assert(result.value.transform == transform)
        assert(result.value.scheduled == false)
        return result
    )", sol::script_pass_on_error );
    REQUIRE( transformed.valid() );
    CHECK( fixture.write_called );
    // Snapshot the native engine to compare draw counts without advancing it.
    // NOLINTNEXTLINE(cata-determinism)
    const cata_default_random_engine platform_rng_after = rng_get_engine();
    CHECK( here.get_field( center, web ) == nullptr );
    CHECK( here.get_field( inside, web ) == nullptr );
    REQUIRE( here.get_field( outside, web ) != nullptr );

    REQUIRE( here.add_field( center, web, 1, 0_turns, false ) );
    REQUIRE( here.add_field( inside, web, 1, 0_turns, false ) );
    rng_set_engine_seed( seed );
    here.transform_radius( ter_furn_transform_spider_clear_webs,
                           1, fixture.absolute );

    CHECK( rng_get_engine() == platform_rng_after );
    CHECK( here.get_field( center, web ) == nullptr );
    CHECK( here.get_field( inside, web ) == nullptr );
    CHECK( here.get_field( outside, web ) != nullptr );
}

TEST_CASE( "lua_platform_map_tile_rejects_mixed_coordinate_frames",
           "[lua][platform][map]" )
{
    platform_map_api_test_fixture fixture( 701, 1 );
    const sol::protected_function tile = fixture.map_api()["tile"];

    const sol::protected_function_result absolute_result = tile( fixture.position() );
    REQUIRE( absolute_result.valid() );
    const sol::table absolute_envelope = absolute_result.get<sol::table>();
    REQUIRE( absolute_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        absolute_envelope["value"].get<cata::lua_platform::map_tile_token>();
    CHECK( token.native_position() == fixture.absolute );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.active_world_generation );
    CHECK( token.owner_is_current() );

    const cata::lua_platform::script_tripoint_coord bubble_ms =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::reality_bubble,
            coords::scale::map_square,
            fixture.local.raw() );
    CHECK_FALSE( tile( bubble_ms ).valid() );

    const cata::lua_platform::script_tripoint_coord local_ms =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::reality_bubble,
            coords::scale::submap,
            tripoint_bub_sm::zero.raw() );
    CHECK_FALSE( tile( local_ms ).valid() );

    const cata::lua_platform::script_tripoint_coord omt =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs,
            coords::scale::overmap_terrain,
            fixture.absolute.raw() );
    CHECK_FALSE( tile( omt ).valid() );

    const sol::table raw_coordinate = fixture.lua.create_table_with(
                                          "x", fixture.absolute.x(),
                                          "y", fixture.absolute.y(),
                                          "z", fixture.absolute.z() );
    CHECK_FALSE( tile( raw_coordinate ).valid() );
}

TEST_CASE( "lua_platform_map_tile_rejects_unloaded_out_of_world_and_z_mismatch",
           "[lua][platform][map]" )
{
    platform_map_api_test_fixture fixture( 702, 2 );
    const sol::protected_function tile = fixture.map_api()["tile"];

    const tripoint_abs_ms outside_world{
        std::numeric_limits<int>::max(), fixture.absolute.y(), fixture.absolute.z()
    };
    const sol::protected_function_result outside_world_result = tile(
                cata::lua_platform::script_tripoint_coord::from_native(
                    coords::origin::abs, coords::scale::map_square,
                    outside_world.raw() ) );
    REQUIRE( outside_world_result.valid() );
    const sol::table outside_world_envelope = outside_world_result.get<sol::table>();
    REQUIRE_FALSE( outside_world_envelope["ok"].get<bool>() );
    CHECK( outside_world_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "out_of_world" );

    const int map_width = fixture.get_map().getmapsize() * SEEX;
    const tripoint_abs_ms outside_bubble = fixture.absolute +
                                           tripoint_rel_ms( map_width, 0, 0 );
    const sol::protected_function_result unloaded_result = tile(
                cata::lua_platform::script_tripoint_coord::from_native(
                    coords::origin::abs, coords::scale::map_square,
                    outside_bubble.raw() ) );
    REQUIRE( unloaded_result.valid() );
    const sol::table unloaded_envelope = unloaded_result.get<sol::table>();
    REQUIRE_FALSE( unloaded_envelope["ok"].get<bool>() );
    const std::string unloaded_code = unloaded_envelope["error"].get<sol::table>()
                                      ["code"].get<std::string>();
    CHECK( ( unloaded_code == "unloaded" || unloaded_code == "out_of_world" ) );

    const int current_z = fixture.get_map().get_abs_sub().z();
    const int mismatched_z = fixture.get_map().supports_zlevels() ?
                             OVERMAP_HEIGHT + 1 :
                             ( current_z == OVERMAP_HEIGHT ? current_z - 1 : current_z + 1 );
    const tripoint_abs_ms z_mismatch{
        fixture.absolute.x(), fixture.absolute.y(), mismatched_z
    };
    const sol::protected_function_result z_result = tile(
                cata::lua_platform::script_tripoint_coord::from_native(
                    coords::origin::abs, coords::scale::map_square,
                    z_mismatch.raw() ) );
    REQUIRE( z_result.valid() );
    const sol::table z_envelope = z_result.get<sol::table>();
    REQUIRE_FALSE( z_envelope["ok"].get<bool>() );
    const std::string z_code = z_envelope["error"].get<sol::table>()
                               ["code"].get<std::string>();
    CHECK( ( z_code == "z_unloaded" || z_code == "unloaded" ||
             z_code == "out_of_world" ) );
}

TEST_CASE( "lua_platform_map_tile_snapshot_is_bounded_and_detached",
           "[lua][platform][map]" )
{
    platform_map_api_test_fixture fixture( 703, 3 );
    map &here = fixture.get_map();
    REQUIRE( here.add_field( fixture.local, fd_smoke.id(), 1, 0_turns, false ) );
    REQUIRE( here.add_field( fixture.local, fd_blood.id(), 1, 0_turns, false ) );

    const sol::table map_api = fixture.map_api();
    const sol::protected_function tile = map_api["tile"];
    const sol::protected_function snapshot = map_api["snapshot"];
    const sol::protected_function_result tile_result = tile( fixture.position() );
    REQUIRE( tile_result.valid() );
    const sol::table tile_envelope = tile_result.get<sol::table>();
    REQUIRE( tile_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        tile_envelope["value"].get<cata::lua_platform::map_tile_token>();

    const sol::protected_function_result first_result = snapshot( token );
    REQUIRE( first_result.valid() );
    const sol::table first_envelope = first_result.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_value = first_envelope["value"].get<sol::table>();
    const std::string first_terrain = first_value["terrain"].get <
                                      cata::lua_platform::script_game_id > ().value();
    const sol::table first_fields = first_value["fields"].get<sol::table>();
    CHECK( first_fields["returned"].get<std::size_t>() == 2 );
    const sol::table field_items = first_fields["items"].get<sol::table>();
    CHECK( field_items[1].get<sol::table>()["id"].get <
           cata::lua_platform::script_game_id > ().value() == "fd_blood" );
    CHECK( field_items[2].get<sol::table>()["id"].get <
           cata::lua_platform::script_game_id > ().value() == "fd_smoke" );
    const sol::table vehicle_part = first_value["vehicle_part"].get<sol::table>();
    REQUIRE( vehicle_part.valid() );
    CHECK_FALSE( vehicle_part["present"].get<bool>() );
    CHECK_FALSE( vehicle_part["handle"].valid() );
    CHECK( ( first_value["item_count"].is<std::size_t>() ||
             first_value["item_count"].is<lua_Integer>() ) );

    const sol::table bounded_options = fixture.lua.create_table_with(
                                           "field_limit", 0,
                                           "signage_limit", 0 );
    const sol::protected_function_result bounded_result =
        snapshot( token, bounded_options );
    REQUIRE( bounded_result.valid() );
    const sol::table bounded_envelope = bounded_result.get<sol::table>();
    REQUIRE( bounded_envelope["ok"].get<bool>() );
    const sol::table bounded_value = bounded_envelope["value"].get<sol::table>();
    const sol::table bounded_fields = bounded_value["fields"].get<sol::table>();
    CHECK( bounded_fields["returned"].get<std::size_t>() == 0 );
    CHECK( bounded_fields["truncated"].get<bool>() );
    CHECK( bounded_value["signage"].get<std::string>().empty() );

    REQUIRE( ter_t_floor.is_valid() );
    REQUIRE( ter_t_wall.is_valid() );
    const ter_id original_terrain = here.ter( fixture.local );
    const ter_id replacement = original_terrain == ter_t_floor.id() ?
                               ter_t_wall.id() : ter_t_floor.id();
    REQUIRE( here.ter_set( fixture.local, replacement ) );
    here.clear_fields( fixture.local );

    const sol::protected_function_result after_result = snapshot( token );
    REQUIRE( after_result.valid() );
    const sol::table after_envelope = after_result.get<sol::table>();
    REQUIRE( after_envelope["ok"].get<bool>() );
    const sol::table after_value = after_envelope["value"].get<sol::table>();
    CHECK( after_value["terrain"].get <
           cata::lua_platform::script_game_id > ().value() != first_terrain );
    CHECK( first_value["terrain"].get <
           cata::lua_platform::script_game_id > ().value() == first_terrain );
    CHECK( first_value["fields"].get<sol::table>()
           ["returned"].get<std::size_t>() == 2 );
}

TEST_CASE( "lua_platform_map_tile_edits_are_atomic_and_rollback",
           "[lua][platform][map][mutation]" )
{
    platform_map_api_test_fixture fixture( 704, 4 );
    map &here = fixture.get_map();
    const sol::table map_api = fixture.map_api();
    const sol::protected_function tile = map_api["tile"];
    const sol::protected_function edit = map_api["edit"];
    const sol::protected_function_result tile_result = tile( fixture.position() );
    REQUIRE( tile_result.valid() );
    const sol::table tile_envelope = tile_result.get<sol::table>();
    REQUIRE( tile_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        tile_envelope["value"].get<cata::lua_platform::map_tile_token>();
    const sol::protected_function snapshot = map_api["snapshot"];
    const sol::protected_function_result snapshot_result = snapshot( token );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot_envelope = snapshot_result.get<sol::table>();
    REQUIRE( snapshot_envelope["ok"].get<bool>() );
    const std::uint64_t revision = snapshot_envelope["value"].get<sol::table>()
                                   ["revision"].get<std::uint64_t>();
    const ter_id original_terrain = here.ter( fixture.local );

    REQUIRE( ter_t_floor.is_valid() );
    REQUIRE( ter_t_wall.is_valid() );
    const ter_str_id target_id = original_terrain == ter_t_floor.id() ?
                                 ter_t_wall : ter_t_floor;
    const cata::lua_platform::script_game_id target_game_id(
        "terrain", target_id.str() );

    sol::table invalid_field = fixture.lua.create_table_with(
                                   "id", cata::lua_platform::script_game_id(
                                       "field", "fd_smoke" ),
                                   "intensity", fd_smoke.obj().get_max_intensity() + 1 );
    sol::table invalid_fields = fixture.lua.create_table();
    invalid_fields[1] = std::move( invalid_field );
    sol::table invalid_changes = fixture.lua.create_table();
    invalid_changes["terrain"] = target_game_id;
    invalid_changes["fields"] = std::move( invalid_fields );

    fixture.write_called = false;
    const sol::protected_function_result rejected = edit(
                token, revision, invalid_changes );
    CHECK_FALSE( rejected.valid() );
    CHECK( fixture.write_called );
    CHECK( here.ter( fixture.local ) == original_terrain );
    CHECK( cata::lua_platform::map_mutation_epoch() == revision );

    sol::table valid_changes = fixture.lua.create_table();
    valid_changes["terrain"] = target_game_id;
    const sol::protected_function_result conflict = edit(
                token, revision + 1, valid_changes );
    REQUIRE( conflict.valid() );
    const sol::table conflict_envelope = conflict.get<sol::table>();
    REQUIRE_FALSE( conflict_envelope["ok"].get<bool>() );
    CHECK( conflict_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "revision_conflict" );
    CHECK( here.ter( fixture.local ) == original_terrain );
    CHECK( cata::lua_platform::map_mutation_epoch() == revision );

    const sol::protected_function_result committed = edit(
                token, revision, valid_changes );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    CHECK( here.ter( fixture.local ) == target_id.id() );
    CHECK( cata::lua_platform::map_mutation_epoch() == revision + 1 );
}

TEST_CASE( "lua_platform_map_trap_set_matches_native_same_id_and_builtin_semantics",
           "[lua][platform][map][traps][semantic]" )
{
    platform_map_api_test_fixture fixture( 717, 17 );
    map &here = fixture.get_map();
    REQUIRE( ter_t_floor.is_valid() );
    REQUIRE( ter_t_pit.is_valid() );
    REQUIRE( tr_beartrap.is_valid() );
    REQUIRE( tr_rollmat.is_valid() );
    REQUIRE( tr_pit.is_valid() );

    const tripoint_bub_ms local = fixture.local + tripoint::east;
    here.ter_set( local, ter_t_floor.id() );
    REQUIRE( here.ter( local ) == ter_t_floor.id() );
    here.trap_set( local, tr_beartrap.id() );
    here.memory_cache_dec_set_dirty( local, false );

    const sol::table map_api = fixture.map_api();
    const sol::protected_function_result tile_result = map_api["tile"](
                fixture.position( local ) );
    REQUIRE( tile_result.valid() );
    REQUIRE( tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function_result snapshot_result =
        map_api["snapshot"]( token );
    REQUIRE( snapshot_result.valid() );
    REQUIRE( snapshot_result.get<sol::table>()["ok"].get<bool>() );
    const std::uint64_t revision = snapshot_result.get<sol::table>()
                                   ["value"].get<sol::table>()
                                   ["revision"].get<std::uint64_t>();
    const std::uint64_t epoch_before = cata::lua_platform::map_mutation_epoch();

    fixture.write_called = false;
    const sol::protected_function trap_set = map_api["trap_set"];
    const sol::protected_function_result repeated = trap_set(
                token, revision,
                cata::lua_platform::script_game_id( "trap", tr_beartrap.str() ) );
    REQUIRE( repeated.valid() );
    REQUIRE( repeated.get<sol::table>()["ok"].get<bool>() );
    CHECK( fixture.write_called );
    CHECK( here.tr_at( local ).id.id() == tr_beartrap.id() );
    // Native map::trap_set marks decoration memory dirty even when asked to
    // reapply the trap already at this position.
    CHECK( here.memory_cache_dec_is_dirty( local ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );

    const sol::protected_function_result stale = trap_set(
                token, revision,
                cata::lua_platform::script_game_id( "trap", tr_rollmat.str() ) );
    REQUIRE( stale.valid() );
    REQUIRE_FALSE( stale.get<sol::table>()["ok"].get<bool>() );
    CHECK( stale.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "revision_conflict" );
    CHECK( here.tr_at( local ).id.id() == tr_beartrap.id() );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );

    const sol::table repeated_value = repeated.get<sol::table>()
                                      ["value"].get<sol::table>();
    const sol::protected_function_result replaced = trap_set(
                token, repeated_value["revision"].get<std::uint64_t>(),
                cata::lua_platform::script_game_id( "trap", tr_rollmat.str() ) );
    REQUIRE( replaced.valid() );
    REQUIRE( replaced.get<sol::table>()["ok"].get<bool>() );
    CHECK( here.tr_at( local ).id.id() == tr_rollmat.id() );

    here.ter_set( local, ter_t_floor.id() );
    REQUIRE( here.ter( local ) == ter_t_floor.id() );
    here.trap_set( local, tr_null );
    here.ter_set( local, ter_t_pit.id() );
    REQUIRE( here.ter( local ) == ter_t_pit.id() );
    const sol::protected_function_result built_in_snapshot =
        map_api["snapshot"]( token );
    REQUIRE( built_in_snapshot.valid() );
    REQUIRE( built_in_snapshot.get<sol::table>()["ok"].get<bool>() );
    sol::protected_function_result built_in;
    const std::string built_in_diagnostic = capture_debugmsg_during( [&]() {
        built_in = trap_set(
                       token,
                       built_in_snapshot.get<sol::table>()["value"].get<sol::table>()
                       ["revision"].get<std::uint64_t>(),
                       cata::lua_platform::script_game_id( "trap", tr_beartrap.str() ) );
    } );
    CHECK( built_in_diagnostic.find( "on top of terrain t_pit" ) != std::string::npos );
    REQUIRE( built_in.valid() );
    REQUIRE( built_in.get<sol::table>()["ok"].get<bool>() );
    CHECK( here.tr_at( local ).id.id() == tr_pit.id() );
}

TEST_CASE( "lua_platform_map_tile_never_uses_avatar_or_nearest_fallback",
           "[lua][platform][map][contract]" )
{
    platform_map_api_test_fixture fixture( 705, 5 );
    const sol::table map_api = fixture.map_api();
    const std::set<std::string> expected = {
        "edit", "snapshot", "tile", "trap_set"
    };
    std::set<std::string> exposed;
    for( const auto &entry : map_api ) {
        REQUIRE( entry.first.is<std::string>() );
        exposed.insert( entry.first.as<std::string>() );
    }
    CHECK( exposed == expected );
    CHECK_FALSE( map_api["avatar"].valid() );
    CHECK_FALSE( map_api["current"].valid() );
    CHECK_FALSE( map_api["nearest"].valid() );

    const sol::protected_function tile = map_api["tile"];
    CHECK_FALSE( tile().valid() );
    const sol::table raw_coordinate = fixture.lua.create_table_with(
                                          "x", fixture.absolute.x(),
                                          "y", fixture.absolute.y(),
                                          "z", fixture.absolute.z() );
    CHECK_FALSE( tile( raw_coordinate ).valid() );

    const sol::protected_function snapshot = map_api["snapshot"];
    CHECK_FALSE( snapshot().valid() );
    const sol::protected_function edit = map_api["edit"];
    CHECK_FALSE( edit().valid() );
}

TEST_CASE( "lua_platform_map_holder_page_and_transfer_require_the_same_token",
           "[lua][platform][map][items]" )
{
    platform_map_api_test_fixture fixture( 706, 6 );
    map &here = fixture.get_map();
    const tripoint_bub_ms destination_local{
        fixture.local.x() + 1, fixture.local.y(), fixture.local.z()
    };
    REQUIRE( here.inbounds( destination_local ) );

    item &source_item = here.add_item(
                            fixture.local, item( itype_rock, calendar::turn_zero ) );
    REQUIRE( !source_item.is_null() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result source_tile_result =
        tile( fixture.position() );
    REQUIRE( source_tile_result.valid() );
    REQUIRE( source_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token source_token =
        source_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function_result destination_tile_result =
        tile( fixture.position( destination_local ) );
    REQUIRE( destination_tile_result.valid() );
    REQUIRE( destination_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token destination_token =
        destination_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();

    const sol::table source_holder = fixture.map_holder( source_token );
    const sol::table destination_holder = fixture.map_holder( destination_token );
    const sol::protected_function page = fixture.item_api()["page"];
    const sol::table page_options = fixture.lua.create_table_with(
                                        "page_size", 1,
                                        "max_depth", 0,
                                        "recursive", false );
    const sol::protected_function_result page_result = page(
                source_holder, page_options );
    REQUIRE( page_result.valid() );
    const sol::table page_envelope = page_result.get<sol::table>();
    REQUIRE( page_envelope["ok"].get<bool>() );
    const sol::table page_value = page_envelope["value"];
    REQUIRE( page_value["returned"].get<lua_Integer>() == 1 );
    const cata::lua_platform::game_handle item_handle =
        page_value["items"].get<sol::table>()[1]["handle"]
        .get<cata::lua_platform::game_handle>();
    CHECK( item_handle.locator().scope == "map" );
    CHECK( item_handle.locator().owner_generation ==
           source_token.owner_generation() );

    sol::table bare_position_holder = fixture.lua.create_table_with(
                                          "kind", "map_tile",
                                          "position", fixture.position() );
    CHECK_FALSE( page( bare_position_holder, page_options ).valid() );
    sol::table typed_but_wrong_frame_holder = fixture.lua.create_table_with(
                "kind", "map_tile" );
    typed_but_wrong_frame_holder["tile"] =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::reality_bubble, coords::scale::map_square,
            fixture.local.raw() );
    CHECK_FALSE( page( typed_but_wrong_frame_holder, page_options ).valid() );

    const cata::lua_platform::game_handle_runtime_owner_ptr different_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime different_runtime(
        different_owner, fixture.runtime.generation() + 1 );
    fixture.active_runtime = different_runtime;
    const sol::protected_function_result stale_destination_result = tile(
                fixture.position( destination_local ) );
    REQUIRE( stale_destination_result.valid() );
    REQUIRE( stale_destination_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token stale_destination_token =
        stale_destination_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    fixture.active_runtime = fixture.runtime;

    const sol::table stale_destination_holder = fixture.map_holder(
                stale_destination_token );
    const std::uint64_t item_epoch_before_failure =
        cata::lua_platform::item_holder_mutation_generation();
    const std::uint64_t map_epoch_before_failure =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function transfer = fixture.item_api()["transfer"];
    const sol::protected_function_result stale_transfer = transfer(
                item_handle, source_holder, stale_destination_holder );
    REQUIRE( stale_transfer.valid() );
    const sol::table stale_transfer_envelope = stale_transfer.get<sol::table>();
    REQUIRE_FALSE( stale_transfer_envelope["ok"].get<bool>() );
    CHECK( stale_transfer_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_runtime" );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() == map_epoch_before_failure );

    const sol::protected_function_result committed = transfer(
                item_handle, source_holder, destination_holder );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    CHECK( committed_envelope["value"].get<sol::table>()
           ["source_handle_stale"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() > map_epoch_before_failure );
    CHECK( here.i_at( destination_local ).size() == 1 );
    CHECK( here.i_at( fixture.local ).size() == 0 );
}

TEST_CASE( "lua_platform_map_mutation_invalidates_token_cursor_and_quote",
           "[lua][platform][map][items][stale]" )
{
    platform_trade_quote_fixture trade_fixture( 707, 607, 126001, 126002 );
    REQUIRE( trade_fixture.ready() );
    const sol::protected_function_result quote_result = trade_fixture.quote( 3 );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token quote_token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    platform_map_api_test_fixture fixture( 708, 7 );
    map &here = fixture.get_map();
    const tripoint_bub_ms destination_local{
        fixture.local.x() + 1, fixture.local.y(), fixture.local.z()
    };
    REQUIRE( here.inbounds( destination_local ) );
    item &first = here.add_item(
                      fixture.local, item( itype_rock, calendar::turn_zero ) );
    item &second = here.add_item(
                       fixture.local, item( itype_knife_combat, calendar::turn_zero ) );
    REQUIRE( !first.is_null() );
    REQUIRE( !second.is_null() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result source_tile_result =
        tile( fixture.position() );
    REQUIRE( source_tile_result.valid() );
    REQUIRE( source_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token source_token =
        source_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function_result destination_tile_result =
        tile( fixture.position( destination_local ) );
    REQUIRE( destination_tile_result.valid() );
    REQUIRE( destination_tile_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token destination_token =
        destination_tile_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::table source_holder = fixture.map_holder( source_token );
    const sol::table destination_holder = fixture.map_holder( destination_token );

    const sol::table page_options = fixture.lua.create_table_with(
                                        "page_size", 1,
                                        "max_depth", 0,
                                        "recursive", false );
    const sol::protected_function page = fixture.item_api()["page"];
    const sol::protected_function_result page_result = page(
                source_holder, page_options );
    REQUIRE( page_result.valid() );
    const sol::table page_envelope = page_result.get<sol::table>();
    REQUIRE( page_envelope["ok"].get<bool>() );
    const sol::table page_value = page_envelope["value"];
    REQUIRE_FALSE( page_value["complete"].get<bool>() );
    const sol::table continuation = page_value["continuation"];
    REQUIRE( continuation.valid() );
    const cata::lua_platform::game_handle item_handle =
        page_value["items"].get<sol::table>()[1]["handle"]
        .get<cata::lua_platform::game_handle>();

    const cata::lua_platform::game_handle_runtime_owner_ptr different_owner =
        cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime different_runtime(
        different_owner, fixture.runtime.generation() + 1 );
    fixture.active_runtime = different_runtime;
    const sol::protected_function_result stale_destination_result = tile(
                fixture.position( destination_local ) );
    REQUIRE( stale_destination_result.valid() );
    REQUIRE( stale_destination_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token stale_destination_token =
        stale_destination_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    fixture.active_runtime = fixture.runtime;

    const sol::table stale_destination_holder = fixture.map_holder(
                stale_destination_token );
    const std::uint64_t item_epoch_before_failure =
        cata::lua_platform::item_holder_mutation_generation();
    const std::uint64_t map_epoch_before_failure =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function transfer = fixture.item_api()["transfer"];
    const sol::protected_function_result failed_transfer = transfer(
                item_handle, source_holder, stale_destination_holder );
    REQUIRE( failed_transfer.valid() );
    REQUIRE_FALSE( failed_transfer.get<sol::table>()["ok"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() ==
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() == map_epoch_before_failure );

    const sol::protected_function_result still_live_quote =
        trade_fixture.get( quote_token );
    REQUIRE( still_live_quote.valid() );
    REQUIRE( still_live_quote.get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result committed = transfer(
                item_handle, source_holder, destination_holder );
    REQUIRE( committed.valid() );
    REQUIRE( committed.get<sol::table>()["ok"].get<bool>() );
    CHECK( source_token.owner_is_current() );
    const sol::protected_function_result token_snapshot =
        fixture.map_api()["snapshot"]( source_token );
    REQUIRE( token_snapshot.valid() );
    REQUIRE( token_snapshot.get<sol::table>()["ok"].get<bool>() );
    CHECK( cata::lua_platform::item_holder_mutation_generation() >
           item_epoch_before_failure );
    CHECK( cata::lua_platform::map_mutation_epoch() > map_epoch_before_failure );

    const sol::protected_function_result stale_cursor = page(
                source_holder, page_options, continuation );
    REQUIRE( stale_cursor.valid() );
    const sol::table stale_cursor_envelope = stale_cursor.get<sol::table>();
    REQUIRE_FALSE( stale_cursor_envelope["ok"].get<bool>() );
    CHECK( stale_cursor_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_continuation" );

    const sol::protected_function_result stale_quote =
        trade_fixture.get( quote_token );
    REQUIRE( stale_quote.valid() );
    const sol::table stale_quote_envelope = stale_quote.get<sol::table>();
    REQUIRE_FALSE( stale_quote_envelope["ok"].get<bool>() );
    CHECK( stale_quote_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_holder" );
}

#endif // CATA_ENABLE_LUA_PLATFORM
