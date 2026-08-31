#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_map_support.h"

TEST_CASE( "lua_platform_relocation_moves_monster_with_explicit_token",
           "[lua][platform][relocation][monster]" )
{
    platform_monster_relocation_fixture fixture( 709, 8 );
    REQUIRE( fixture.test_monster );
    const std::int64_t monster_uid = fixture.test_monster->uid().get_value();
    REQUIRE( monster_uid > 0 );
    CHECK( fixture.monster_handle.locator().stable_id == monster_uid );
    map &here = fixture.get_map();
    const ter_str_id floor_id( "t_floor" );
    REQUIRE( floor_id.is_valid() );
    here.ter_set( fixture.local, floor_id.id() );
    here.ter_set( fixture.target_local, floor_id.id() );
    REQUIRE( here.ter( fixture.local ) == floor_id.id() );
    REQUIRE( here.ter( fixture.target_local ) == floor_id.id() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table force_options = fixture.lua.create_table_with(
                                         "force", true );
    CHECK_FALSE( move( fixture.monster_handle, token, force_options ).valid() );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );

    const cata::lua_platform::game_handle unsupported_handle;
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const sol::protected_function_result unsupported = move(
            unsupported_handle, token, strict_options );
    REQUIRE( unsupported.valid() );
    const sol::table unsupported_envelope = unsupported.get<sol::table>();
    REQUIRE_FALSE( unsupported_envelope["ok"].get<bool>() );
    CHECK( unsupported_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "unsupported" );

    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.monster_handle.identity_generation();
    const sol::protected_function_result moved = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( moved_value["scope"].get<std::string>() == "monster" );
    CHECK( fixture.test_monster->pos_abs() == fixture.target_abs );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.monster_handle.identity_generation() == identity_generation );
    CHECK( fixture.write_called );

    const tripoint_abs_ms committed_position = fixture.test_monster->pos_abs();
    const shared_ptr_fast<monster> committed_tracker =
        get_creature_tracker().find( fixture.target_abs );
    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["scope"].get<std::string>() == "monster" );
    CHECK( fixture.test_monster->pos_abs() == committed_position );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           committed_tracker.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
}

TEST_CASE( "lua_platform_relocation_moves_npc_with_explicit_token",
           "[lua][platform][relocation][npc]" )
{
    platform_npc_relocation_fixture fixture( 717, 16 );
    REQUIRE( fixture.test_npc );
    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.npc_handle.identity_generation();
    const sol::protected_function_result moved = move(
            fixture.npc_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( moved_value["scope"].get<std::string>() == "npc" );
    CHECK( fixture.test_npc->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.npc_handle.identity_generation() == identity_generation );
    CHECK( g->find_npc( fixture.npc_id ) == fixture.test_npc );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            fixture.npc_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["scope"].get<std::string>() == "npc" );
    CHECK( fixture.test_npc->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
}

TEST_CASE( "lua_platform_relocation_moves_vehicle_with_explicit_token_and_preserves_part_identity",
           "[lua][platform][relocation][vehicle]" )
{
    platform_vehicle_relocation_fixture fixture( 726, 25 );
    REQUIRE( fixture.test_vehicle );
    REQUIRE( fixture.live_part );
    REQUIRE( fixture.vehicle_handle.kind() ==
             cata::lua_platform::game_handle_kind::vehicle );
    REQUIRE( fixture.vehicle_part_handle.kind() ==
             cata::lua_platform::game_handle_kind::vehicle_part );
    REQUIRE_FALSE( fixture.vehicle_handle.validation_error(
                       fixture.runtime, fixture.active_world_generation ) );
    REQUIRE_FALSE( fixture.vehicle_part_handle.validation_error(
                       fixture.runtime, fixture.active_world_generation ) );

    const std::size_t vehicle_identity_generation =
        fixture.vehicle_handle.identity_generation();
    const std::size_t part_identity_generation =
        fixture.vehicle_part_handle.identity_generation();
    const auto part_uid = fixture.live_part->get_base().uid().get_value();

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result moved = move(
            fixture.vehicle_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["scope"].get<std::string>() == "vehicle" );
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( fixture.test_vehicle->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );

    const cata::lua_platform::game_handle new_vehicle_handle =
        moved_value["handle"].get<cata::lua_platform::game_handle>();
    CHECK( new_vehicle_handle.identity_generation() ==
           vehicle_identity_generation );
    const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
        new_vehicle_handle.resolve_vehicle(
            fixture.runtime, fixture.active_world_generation );
    REQUIRE( static_cast<bool>( resolved_vehicle ) );
    CHECK( resolved_vehicle.value == fixture.test_vehicle );
    CHECK( resolved_vehicle.value->pos_abs() == fixture.target_abs );

    CHECK( fixture.vehicle_part_handle.identity_generation() ==
           part_identity_generation );
    const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
        fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
            new_vehicle_handle, fixture.runtime,
            fixture.active_world_generation );
    REQUIRE( static_cast<bool>( resolved_part ) );
    CHECK( resolved_part.value == fixture.live_part );
    CHECK( resolved_part.value->get_base().uid().get_value() == part_uid );
    CHECK( token.owner_is_current() );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            new_vehicle_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK( repeated_value["scope"].get<std::string>() == "vehicle" );
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( fixture.test_vehicle->pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
    CHECK( token.owner_is_current() );
}

TEST_CASE( "lua_platform_relocation_rejects_vehicle_footprint_collisions_without_mutation",
           "[lua][platform][relocation][vehicle]" )
{
    SECTION( "terrain/furniture collision" ) {
        platform_vehicle_relocation_fixture fixture( 727, 26 );
        REQUIRE( fixture.test_vehicle );
        REQUIRE( fixture.live_part );

        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const std::size_t part_identity_generation =
            fixture.vehicle_part_handle.identity_generation();

        map &here = fixture.get_map();
        const ter_str_id wall_id( "t_wall" );
        REQUIRE( wall_id.is_valid() );
        REQUIRE( here.ter_set( fixture.target_local, wall_id.id() ) );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result blocked = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( blocked.valid() );
        const sol::table blocked_envelope = blocked.get<sol::table>();
        REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
        CHECK( blocked_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "blocked" );

        CHECK( fixture.test_vehicle->pos_abs() == fixture.source_abs );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );
        CHECK( fixture.vehicle_part_handle.identity_generation() ==
               part_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
        const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
            fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
                fixture.vehicle_handle, fixture.runtime,
                fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_part ) );
        CHECK( resolved_part.value == fixture.live_part );
    }

    SECTION( "Creature collision" ) {
        platform_vehicle_relocation_fixture fixture( 728, 27 );
        REQUIRE( fixture.test_vehicle );
        REQUIRE( fixture.live_part );

        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const std::size_t part_identity_generation =
            fixture.vehicle_part_handle.identity_generation();
        const shared_ptr_fast<monster> occupant = fixture.add_monster(
                fixture.target_local );
        REQUIRE( occupant );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result blocked = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( blocked.valid() );
        const sol::table blocked_envelope = blocked.get<sol::table>();
        REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
        CHECK( blocked_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "blocked" );

        CHECK( fixture.test_vehicle->pos_abs() == fixture.source_abs );
        CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
               occupant.get() );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );
        CHECK( fixture.vehicle_part_handle.identity_generation() ==
               part_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
        const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
            fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
                fixture.vehicle_handle, fixture.runtime,
                fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_part ) );
        CHECK( resolved_part.value == fixture.live_part );
    }

    SECTION( "other Vehicle collision" ) {
        platform_vehicle_relocation_fixture fixture( 729, 28 );
        REQUIRE( fixture.test_vehicle );
        REQUIRE( fixture.live_part );

        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const std::size_t part_identity_generation =
            fixture.vehicle_part_handle.identity_generation();
        REQUIRE( fixture.add_target_blocker_vehicle() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result blocked = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( blocked.valid() );
        const sol::table blocked_envelope = blocked.get<sol::table>();
        REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
        CHECK( blocked_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "blocked" );

        CHECK( fixture.test_vehicle->pos_abs() == fixture.source_abs );
        CHECK( fixture.target_blocker_vehicle->pos_abs() == fixture.target_abs );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );
        CHECK( fixture.vehicle_part_handle.identity_generation() ==
               part_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
        const cata::lua_platform::native_handle_result<vehicle_part> resolved_part =
            fixture.vehicle_part_handle.resolve_vehicle_part_for_vehicle(
                fixture.vehicle_handle, fixture.runtime,
                fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_part ) );
        CHECK( resolved_part.value == fixture.live_part );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_unloaded_inactive_npc_without_mutation",
           "[lua][platform][relocation][npc]" )
{
    SECTION( "stale token" ) {
        platform_npc_relocation_fixture fixture( 718, 17 );
        REQUIRE( fixture.test_npc );
        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        cata::lua_platform::reset_map_tile_tokens();

        const sol::protected_function_result stale = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( stale.valid() );
        const sol::table stale_envelope = stale.get<sol::table>();
        REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
        CHECK( stale_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_owner" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "unloaded/inactive" ) {
        platform_npc_relocation_fixture fixture( 719, 18 );
        REQUIRE( fixture.test_npc );
        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const cata::lua_platform::game_handle npc_handle = fixture.npc_handle;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        fixture.test_npc->on_unload();
        get_creature_tracker().clear_npcs();
        const shared_ptr_fast<npc> unloaded_npc =
            overmap_buffer.find_npc( npc_id );
        REQUIRE( unloaded_npc );
        CHECK( unloaded_npc.get() == fixture.test_npc );
        CHECK_FALSE( unloaded_npc->is_active() );

        const sol::protected_function_result rejected = move(
                npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_coupled_npc_states_and_preserves_registration",
           "[lua][platform][relocation][npc][state]" )
{
    SECTION( "in_vehicle" ) {
        platform_npc_relocation_fixture fixture( 720, 19 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->in_vehicle = true;

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "active activity" ) {
        platform_npc_relocation_fixture fixture( 721, 20 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->activity = player_activity( meditate_activity_actor() );
        REQUIRE( fixture.test_npc->activity );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "riding effect" ) {
        platform_npc_relocation_fixture fixture( 722, 21 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->add_effect( efftype_id( "riding" ), 1_turns );
        REQUIRE( fixture.test_npc->has_effect( efftype_id( "riding" ) ) );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "companion mission role" ) {
        platform_npc_relocation_fixture fixture( 723, 22 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->companion_mission_role_id =
            std::string( "test_companion_mission_role" );
        REQUIRE_FALSE( fixture.test_npc->companion_mission_role_id.empty() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "assigned camp" ) {
        platform_npc_relocation_fixture fixture( 724, 23 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->assigned_camp = tripoint_abs_omt{ 1, 2, 0 };
        REQUIRE( fixture.test_npc->assigned_camp.has_value() );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }

    SECTION( "marked for death" ) {
        platform_npc_relocation_fixture fixture( 725, 24 );
        REQUIRE( fixture.test_npc );
        fixture.test_npc->marked_for_death = true;
        REQUIRE( fixture.test_npc->marked_for_death );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms source_position = fixture.test_npc->pos_abs();
        const npc *source_npc = fixture.test_npc;
        const character_id npc_id = fixture.npc_id;
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.npc_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( source_npc->pos_abs() == source_position );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( g->find_npc( npc_id ) == source_npc );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_blocked_occupied_z_and_unloaded",
           "[lua][platform][relocation][monster]" )
{
    platform_monster_relocation_fixture fixture( 710, 9 );
    REQUIRE( fixture.test_monster );
    map &here = fixture.get_map();
    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    here.ter_set( fixture.target_local, floor_id.id() );
    REQUIRE( here.ter( fixture.target_local ) == floor_id.id() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    REQUIRE( token_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();

    REQUIRE( here.ter_set( fixture.target_local, wall_id.id() ) );
    const sol::protected_function_result blocked = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( blocked.valid() );
    const sol::table blocked_envelope = blocked.get<sol::table>();
    REQUIRE_FALSE( blocked_envelope["ok"].get<bool>() );
    CHECK( blocked_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "blocked" );

    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );
    const shared_ptr_fast<monster> occupant = fixture.add_monster(
            fixture.target_local );
    REQUIRE( occupant );
    const sol::protected_function_result occupied = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( occupied.valid() );
    const sol::table occupied_envelope = occupied.get<sol::table>();
    REQUIRE_FALSE( occupied_envelope["ok"].get<bool>() );
    CHECK( occupied_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "occupied" );
    get_creature_tracker().remove( *occupant );

    const int current_z = here.get_abs_sub().z();
    const int other_z = current_z == OVERMAP_HEIGHT ?
                        current_z - 1 : current_z + 1;
    const tripoint_abs_ms z_position{
        fixture.target_abs.x(), fixture.target_abs.y(), other_z
    };
    const sol::protected_function_result z_token_result = tile(
            fixture.position( z_position ) );
    REQUIRE( z_token_result.valid() );
    const sol::table z_token_envelope = z_token_result.get<sol::table>();
    REQUIRE( z_token_envelope["ok"].is<bool>() );
    if( z_token_envelope["ok"].get<bool>() ) {
        const cata::lua_platform::map_tile_token z_token =
            z_token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        const sol::protected_function_result z_result = move(
                fixture.monster_handle, z_token, strict_options );
        REQUIRE( z_result.valid() );
        const sol::table z_envelope = z_result.get<sol::table>();
        REQUIRE_FALSE( z_envelope["ok"].get<bool>() );
        CHECK( z_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "z_mismatch" );
    } else {
        const std::string z_code = z_token_envelope["error"]
                                   .get<sol::table>()["code"].get<std::string>();
        CHECK( ( z_code == "z_unloaded" || z_code == "unloaded" ||
                 z_code == "out_of_world" ) );
    }

    const int map_width = here.getmapsize() * SEEX;
    const tripoint_abs_ms unloaded_position = fixture.source_abs +
            tripoint_rel_ms( map_width, 0, 0 );
    const sol::protected_function_result unloaded = tile(
            fixture.position( unloaded_position ) );
    REQUIRE( unloaded.valid() );
    const sol::table unloaded_envelope = unloaded.get<sol::table>();
    REQUIRE_FALSE( unloaded_envelope["ok"].get<bool>() );
    const std::string unloaded_code = unloaded_envelope["error"]
                                      .get<sol::table>()["code"].get<std::string>();
    CHECK( ( unloaded_code == "unloaded" || unloaded_code == "out_of_world" ) );

    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );

    const std::uint64_t epoch_before_vehicle =
        cata::lua_platform::map_mutation_epoch();
    vehicle *vehicle_occupant = here.add_vehicle(
                                    vehicle_prototype_test_shopping_cart,
                                    fixture.target_local, 0_degrees, 0,
                                    veh_spawn_status::UNDAMAGED );
    REQUIRE( vehicle_occupant );
    const sol::protected_function_result vehicle_occupied = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( vehicle_occupied.valid() );
    const sol::table vehicle_occupied_envelope =
        vehicle_occupied.get<sol::table>();
    REQUIRE_FALSE( vehicle_occupied_envelope["ok"].get<bool>() );
    CHECK( vehicle_occupied_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "vehicle_occupied" );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_vehicle );

    const tripoint_abs_ms stale_position = fixture.test_monster->pos_abs();
    const shared_ptr_fast<monster> stale_source_tracker =
        get_creature_tracker().find( fixture.source_abs );
    const shared_ptr_fast<monster> stale_target_tracker =
        get_creature_tracker().find( fixture.target_abs );
    const std::uint64_t epoch_before_stale_token =
        cata::lua_platform::map_mutation_epoch();
    cata::lua_platform::reset_map_tile_tokens();
    const sol::protected_function_result stale_token_result = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( stale_token_result.valid() );
    const sol::table stale_token_envelope =
        stale_token_result.get<sol::table>();
    REQUIRE_FALSE( stale_token_envelope["ok"].get<bool>() );
    CHECK( stale_token_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_owner" );
    CHECK( fixture.test_monster->pos_abs() == stale_position );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           stale_source_tracker.get() );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           stale_target_tracker.get() );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_stale_token );
}

TEST_CASE( "lua_platform_relocation_rolls_back_and_updates_tracker_atomically",
           "[lua][platform][relocation][monster][rollback]" )
{
    platform_monster_relocation_fixture fixture( 711, 10 );
    REQUIRE( fixture.test_monster );
    map &here = fixture.get_map();
    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    here.ter_set( fixture.target_local, floor_id.id() );
    REQUIRE( here.ter( fixture.target_local ) == floor_id.id() );

    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    REQUIRE( token_result.get<sol::table>()["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_result.get<sol::table>()["value"]
        .get<cata::lua_platform::map_tile_token>();
    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.monster_handle.identity_generation();
    const std::int64_t monster_uid = fixture.test_monster->uid().get_value();
    REQUIRE( monster_uid > 0 );
    CHECK( fixture.monster_handle.locator().stable_id == monster_uid );

    get_creature_tracker().remove( *fixture.test_monster );
    const sol::protected_function_result stale_tracker = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( stale_tracker.valid() );
    const sol::table stale_tracker_envelope = stale_tracker.get<sol::table>();
    REQUIRE_FALSE( stale_tracker_envelope["ok"].get<bool>() );
    CHECK( stale_tracker_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_tracker" );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    REQUIRE( get_creature_tracker().add( fixture.test_monster ) );
    CHECK( fixture.test_monster->uid().get_value() == monster_uid );
    CHECK( fixture.monster_handle.locator().stable_id == monster_uid );
    CHECK( get_creature_tracker().find_by_uid( monster_uid ).get() ==
           fixture.test_monster.get() );

    REQUIRE( here.ter_set( fixture.target_local, wall_id.id() ) );
    const sol::protected_function_result blocked = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( blocked.valid() );
    REQUIRE_FALSE( blocked.get<sol::table>()["ok"].get<bool>() );
    CHECK( blocked.get<sol::table>()["error"].get<sol::table>()
           ["code"].get<std::string>() == "blocked" );
    CHECK( fixture.test_monster->pos_abs() == fixture.source_abs );
    CHECK( get_creature_tracker().find( fixture.source_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.target_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );

    REQUIRE( here.ter_set( fixture.target_local, floor_id.id() ) );
    const sol::protected_function_result committed = move(
            fixture.monster_handle, token, strict_options );
    REQUIRE( committed.valid() );
    REQUIRE( committed.get<sol::table>()["ok"].get<bool>() );
    CHECK( fixture.test_monster->pos_abs() == fixture.target_abs );
    CHECK( get_creature_tracker().find( fixture.target_abs ).get() ==
           fixture.test_monster.get() );
    CHECK_FALSE( get_creature_tracker().find( fixture.source_abs ) );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.monster_handle.identity_generation() == identity_generation );
}

TEST_CASE( "lua_platform_relocation_moves_avatar_with_explicit_token",
           "[lua][platform][relocation][avatar]" )
{
    platform_avatar_relocation_fixture fixture( 712, 11 );
    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const std::size_t identity_generation =
        fixture.avatar_handle.identity_generation();
    const sol::protected_function_result moved = move(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["scope"].get<std::string>() == "avatar" );
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( get_avatar().pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );
    CHECK( fixture.avatar_handle.identity_generation() == identity_generation );
    CHECK( token.owner_is_current() );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = move(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["scope"].get<std::string>() == "avatar" );
    CHECK( get_avatar().pos_abs() == fixture.target_abs );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );
    CHECK( token.owner_is_current() );
}

TEST_CASE( "lua_platform_relocation_avatar_never_loads_map_or_uses_fallback",
           "[lua][platform][relocation][avatar][contract]" )
{
    platform_avatar_relocation_fixture fixture( 713, 12 );
    map &here = fixture.get_map();
    const auto map_origin_before = here.get_abs_sub();
    const sol::protected_function tile = fixture.map_api()["tile"];
    const sol::protected_function move = fixture.relocation_api()["move"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );
    const sol::table relocation = fixture.relocation_api();
    CHECK_FALSE( relocation["current"].valid() );
    CHECK_FALSE( relocation["nearest"].valid() );
    CHECK_FALSE( relocation["raw"].valid() );
    CHECK_FALSE( relocation["raw_coordinate"].valid() );
    CHECK_FALSE( relocation["x"].valid() );
    CHECK_FALSE( relocation["y"].valid() );
    CHECK_FALSE( relocation["z"].valid() );

    const sol::protected_function_result token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token token =
        token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( token.owner_is_current() );

    const tripoint_abs_ms position_before = get_avatar().pos_abs();
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const shared_ptr_fast<monster> occupant = fixture.add_monster(
            fixture.target_local );
    REQUIRE( occupant );
    const sol::protected_function_result occupied = move(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( occupied.valid() );
    const sol::table occupied_envelope = occupied.get<sol::table>();
    REQUIRE_FALSE( occupied_envelope["ok"].get<bool>() );
    CHECK( occupied_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "occupied" );
    CHECK( get_avatar().pos_abs() == position_before );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    CHECK( here.get_abs_sub() == map_origin_before );
    get_creature_tracker().remove( *occupant );

    const sol::protected_function_result stale_token_result = tile(
            fixture.position( fixture.target_local ) );
    REQUIRE( stale_token_result.valid() );
    const sol::table stale_token_envelope = stale_token_result.get<sol::table>();
    REQUIRE( stale_token_envelope["ok"].get<bool>() );
    const cata::lua_platform::map_tile_token stale_token =
        stale_token_envelope["value"].get<cata::lua_platform::map_tile_token>();
    REQUIRE( stale_token.owner_is_current() );

    const tripoint_abs_ms stale_position = get_avatar().pos_abs();
    const std::uint64_t epoch_before_stale_token =
        cata::lua_platform::map_mutation_epoch();
    const auto map_origin_before_stale_token = here.get_abs_sub();
    cata::lua_platform::reset_map_tile_tokens();
    const sol::protected_function_result stale = move(
            fixture.avatar_handle, stale_token, strict_options );
    REQUIRE( stale.valid() );
    const sol::table stale_envelope = stale.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_owner" );
    CHECK( get_avatar().pos_abs() == stale_position );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_stale_token );
    CHECK( here.get_abs_sub() == map_origin_before );
    CHECK( here.get_abs_sub() == map_origin_before_stale_token );
}

TEST_CASE( "lua_platform_relocation_rejects_coupled_avatar_states",
           "[lua][platform][relocation][avatar][state]" )
{
    const auto check_rejected = []( platform_avatar_relocation_fixture &fixture ) {
        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const tripoint_abs_ms position_before = get_avatar().pos_abs();
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.avatar_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( get_avatar().pos_abs() == position_before );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
    };

    SECTION( "in_vehicle" ) {
        platform_avatar_relocation_fixture fixture( 714, 13 );
        get_avatar().in_vehicle = true;
        check_rejected( fixture );
    }

    SECTION( "grab" ) {
        platform_avatar_relocation_fixture fixture( 715, 14 );
        get_avatar().grab( object_type::VEHICLE, tripoint_rel_ms::east );
        check_rejected( fixture );
    }

    SECTION( "hauling" ) {
        platform_avatar_relocation_fixture fixture( 716, 15 );
        get_avatar().hauling = true;
        check_rejected( fixture );
    }
}

TEST_CASE( "lua_platform_relocation_rejects_vehicle_coupled_states_without_mutation",
           "[lua][platform][relocation][vehicle][state]" )
{
    const auto check_rejected = []( platform_vehicle_relocation_fixture &fixture ) {
        REQUIRE( fixture.test_vehicle );
        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const tripoint_abs_ms source_anchor = fixture.test_vehicle->pos_abs();

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const sol::protected_function_result rejected = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( fixture.test_vehicle->pos_abs() == source_anchor );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );

        const cata::lua_platform::native_handle_result<vehicle> resolved_vehicle =
            fixture.vehicle_handle.resolve_vehicle(
                fixture.runtime, fixture.active_world_generation );
        REQUIRE( static_cast<bool>( resolved_vehicle ) );
        CHECK( resolved_vehicle.value == fixture.test_vehicle );
    };

    SECTION( "active remote" ) {
        platform_vehicle_relocation_fixture fixture( 730, 29 );
        REQUIRE( fixture.test_vehicle );
        item_location remote_control = get_avatar().i_add(
                                           item( itype_id( "remotevehcontrol" ),
                                                 calendar::turn_zero ) );
        REQUIRE( remote_control != item_location::nowhere );
        remote_control->active = true;
        REQUIRE( get_avatar().has_active_item(
                     itype_id( "remotevehcontrol" ) ) );
        g->setremoteveh( fixture.test_vehicle );
        REQUIRE( g->remoteveh() == fixture.test_vehicle );
        check_rejected( fixture );
    }

    SECTION( "avatar vehicle grab" ) {
        platform_vehicle_relocation_fixture fixture( 731, 30 );
        REQUIRE( fixture.test_vehicle );
        clear_avatar();
        avatar &player = get_avatar();
        const tripoint_bub_ms avatar_local =
            fixture.source_local + tripoint_rel_ms( -1, 0, 0 );
        player.setpos( fixture.get_map(), avatar_local );
        const tripoint_rel_ms grab_point = fixture.source_local - avatar_local;
        player.grab( object_type::VEHICLE, grab_point );
        REQUIRE( player.get_grab_type() == object_type::VEHICLE );
        REQUIRE( player.grab_point == grab_point );
        const optional_vpart_position grabbed_vehicle = fixture.get_map().veh_at(
                player.pos_bub() + player.grab_point );
        REQUIRE( grabbed_vehicle );
        REQUIRE( &grabbed_vehicle->vehicle() == fixture.test_vehicle );
        check_rejected( fixture );
    }

    SECTION( "boarded rider" ) {
        platform_vehicle_relocation_fixture fixture( 732, 31 );
        REQUIRE( fixture.test_vehicle );
        clear_avatar();
        avatar &player = get_avatar();
        map &here = fixture.get_map();
        player.setpos( here, fixture.source_local, false );
        const int cargo_part = fixture.test_vehicle->part_with_feature(
                                   point_rel_ms::zero,
                                   vpart_bitflags::VPFLAG_CARGO, true );
        REQUIRE( cargo_part >= 0 );
        fixture.test_vehicle->remove_part(
            fixture.test_vehicle->part( cargo_part ) );
        REQUIRE( fixture.test_vehicle->part( cargo_part ).removed );
        fixture.test_vehicle->part_removal_cleanup( here );
        static const vpart_id seat( "seat" );
        REQUIRE( fixture.test_vehicle->install_part(
                     here, point_rel_ms::zero, seat ) >= 0 );
        here.add_vehicle_to_cache( fixture.test_vehicle );
        here.board_vehicle( fixture.source_local, &player );
        REQUIRE( player.in_vehicle );
        const std::vector<int> boarded_parts =
            fixture.test_vehicle->boarded_parts();
        REQUIRE( boarded_parts.size() == 1 );
        const int boarded_part = boarded_parts.front();
        REQUIRE( fixture.test_vehicle->get_passenger( boarded_part ) == &player );

        const sol::protected_function tile = fixture.map_api()["tile"];
        const sol::protected_function_result token_result = tile(
                fixture.position( fixture.target_local ) );
        REQUIRE( token_result.valid() );
        const sol::table token_envelope = token_result.get<sol::table>();
        REQUIRE( token_envelope["ok"].get<bool>() );
        const cata::lua_platform::map_tile_token token =
            token_envelope["value"].get<cata::lua_platform::map_tile_token>();
        REQUIRE( token.owner_is_current() );

        const tripoint_abs_ms source_anchor = fixture.test_vehicle->pos_abs();
        const std::uint64_t epoch_before =
            cata::lua_platform::map_mutation_epoch();
        const std::size_t vehicle_identity_generation =
            fixture.vehicle_handle.identity_generation();
        const sol::protected_function move = fixture.relocation_api()["move"];
        const sol::table strict_options = fixture.lua.create_table_with(
                                               "strict", true );
        const sol::protected_function_result rejected = move(
                fixture.vehicle_handle, token, strict_options );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "unsupported_state" );
        CHECK( fixture.test_vehicle->pos_abs() == source_anchor );
        CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
        CHECK( fixture.vehicle_handle.identity_generation() ==
               vehicle_identity_generation );

        here.unboard_vehicle(
            vpart_reference( *fixture.test_vehicle, boarded_part ), &player );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
