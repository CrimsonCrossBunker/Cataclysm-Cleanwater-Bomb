#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_map_support.h"

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
    const auto outside_world_result = tile(
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
    const auto unloaded_result = tile(
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
    const auto z_result = tile(
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
    const std::string first_terrain = first_value["terrain"].get<
                                      cata::lua_platform::script_game_id>().value();
    const sol::table first_fields = first_value["fields"].get<sol::table>();
    CHECK( first_fields["returned"].get<std::size_t>() == 1 );
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

    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    const ter_id original_terrain = here.ter( fixture.local );
    const ter_id replacement = original_terrain == floor_id.id() ?
                               wall_id.id() : floor_id.id();
    REQUIRE( here.ter_set( fixture.local, replacement ) );
    here.clear_fields( fixture.local );

    const sol::protected_function_result after_result = snapshot( token );
    REQUIRE( after_result.valid() );
    const sol::table after_envelope = after_result.get<sol::table>();
    REQUIRE( after_envelope["ok"].get<bool>() );
    const sol::table after_value = after_envelope["value"].get<sol::table>();
    CHECK( after_value["terrain"].get<
               cata::lua_platform::script_game_id>().value() != first_terrain );
    CHECK( first_value["terrain"].get<
               cata::lua_platform::script_game_id>().value() == first_terrain );
    CHECK( first_value["fields"].get<sol::table>()
           ["returned"].get<std::size_t>() == 1 );
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

    const ter_str_id floor_id( "t_floor" );
    const ter_str_id wall_id( "t_wall" );
    REQUIRE( floor_id.is_valid() );
    REQUIRE( wall_id.is_valid() );
    const ter_str_id target_id = original_terrain == floor_id.id() ?
                                 wall_id : floor_id;
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

TEST_CASE( "lua_platform_map_tile_never_uses_avatar_or_nearest_fallback",
           "[lua][platform][map][contract]" )
{
    platform_map_api_test_fixture fixture( 705, 5 );
    const sol::table map_api = fixture.map_api();
    const std::set<std::string> expected = { "edit", "snapshot", "tile" };
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
                            fixture.local, item( itype_id( "rock" ), calendar::turn_zero ) );
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

    const auto different_owner =
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
                       fixture.local, item( itype_id( "rock" ), calendar::turn_zero ) );
    item &second = here.add_item(
                        fixture.local, item( itype_id( "knife_combat" ), calendar::turn_zero ) );
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

    const auto different_owner =
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
