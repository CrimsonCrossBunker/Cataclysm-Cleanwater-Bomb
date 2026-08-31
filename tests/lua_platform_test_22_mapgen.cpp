#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_map_support.h"

TEST_CASE( "lua_platform_mapgen_callback_transaction_native_helper",
           "[lua][platform][mapgen][transaction]" )
{
    SECTION( "rollback restores the callback preimage" )
    {
        platform_mapgen_callback_transaction_test_fixture fixture;
        map &here = fixture.native_map();
        const tripoint_bub_ms position = fixture.position();
        const ter_id terrain_before = here.ter( position );
        const int direction_before = fixture.data.dir( 0 );

        platform_mapgen_transaction_report report;
        platform_mapgen_callback_transaction transaction( fixture.data, &report );
        REQUIRE( transaction.ready() );

        REQUIRE( fixture.context.set_terrain(
                     position.x(), position.y(),
                     cata::lua_platform::script_game_id( "terrain", "t_wall" ) ) );
        fixture.context.set_dir( 0, -37 );
        CHECK( here.ter( position ) == ter_str_id( "t_wall" ).id() );
        CHECK( fixture.data.dir( 0 ) == -37 );

        REQUIRE( transaction.rollback( "callback_failed", "test" ) );
        CHECK( report.state == platform_mapgen_transaction_state::rolled_back );
        CHECK( report.code == "callback_failed" );
        CHECK( report.message == "test" );
        CHECK( report.footprint.min_z == fixture.data.zlevel() );
        CHECK( report.footprint.max_z == fixture.data.zlevel() );
        CHECK( here.ter( position ) == terrain_before );
        CHECK( fixture.data.dir( 0 ) == direction_before );

        fixture.context.invalidate();
        CHECK_FALSE( fixture.context.valid() );
    }

    SECTION( "commit keeps the callback terrain change" )
    {
        platform_mapgen_callback_transaction_test_fixture fixture;
        map &here = fixture.native_map();
        const tripoint_bub_ms position = fixture.position();

        platform_mapgen_transaction_report report;
        platform_mapgen_callback_transaction transaction( fixture.data, &report );
        REQUIRE( transaction.ready() );

        REQUIRE( fixture.context.set_terrain(
                     position.x(), position.y(),
                     cata::lua_platform::script_game_id( "terrain", "t_wall" ) ) );
        transaction.commit();

        CHECK( report.state == platform_mapgen_transaction_state::committed );
        CHECK( here.ter( position ) == ter_str_id( "t_wall" ).id() );
    }
}

TEST_CASE( "lua_platform_mapgen_context_exposes_only_safe_mutations",
           "[lua][platform][mapgen][contract]" )
{
    platform_mapgen_callback_transaction_test_fixture fixture;
    cata::lua_platform::install_script_mapgen_context_api( fixture.lua );

    const sol::object mapgen_context_object = fixture.lua["ScriptMapgenContext"];
    REQUIRE( mapgen_context_object.valid() );
    const sol::usertype<cata::lua_platform::script_mapgen_context> mapgen_context =
        mapgen_context_object;

    fixture.lua["context"] = &fixture.context;
    const sol::object context_object = fixture.lua["context"];
    const sol::userdata context = context_object;
    REQUIRE( context.valid() );

    const std::vector<std::string> unsafe_methods = {
        "place_zone",
        "place_npc",
        "place_npc_configured",
        "place_vehicle",
        "apply_faction_ownership",
        "transform",
        "remove_vehicles",
        "remove_npcs",
        "remove_all",
        "nest",
        "generate"
    };
    for( const std::string &method : unsafe_methods ) {
        CHECK_FALSE( mapgen_context[method].valid() );
        CHECK_FALSE( context[method].valid() );
    }

    CHECK( mapgen_context["set_terrain"].valid() );
    CHECK( mapgen_context["queue_point"].valid() );
    CHECK( context["set_terrain"].valid() );
    CHECK( context["queue_point"].valid() );

    CHECK_THROWS_WITH(
        fixture.context.place_vehicle( 0, 0, "", 0, -1, -1, "" ),
        Catch::Matchers::Contains( "external mutation is unsupported" ) );
}

TEST_CASE( "lua_platform_mapgen_service_uses_typed_update_and_target_tokens",
           "[lua][platform][mapgen][contract]" )
{
    platform_overmap_travel_fixture fixture( 809, 39 );

    const sol::table mapgen = fixture.services["mapgen"];
    REQUIRE( mapgen.valid() );
    CHECK( mapgen["update_token"].valid() );
    CHECK( mapgen["apply"].valid() );

    const sol::object world_object = fixture.services["world"];
    CHECK_FALSE( world_object.valid() );
}

TEST_CASE( "lua_platform_mapgen_apply_rejects_untyped_and_legacy_requests",
           "[lua][platform][mapgen][contract]" )
{
    platform_overmap_travel_fixture fixture( 811, 41 );

    const sol::table overmap = fixture.overmap_api();
    const sol::table mapgen = fixture.services["mapgen"];
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function update_token = mapgen["update_token"];
    const sol::protected_function apply = mapgen["apply"];

    const sol::protected_function_result target_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( target_result.valid() );
    const sol::table target_envelope = target_result.get<sol::table>();
    REQUIRE( target_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token target =
        target_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const cata::lua_platform::script_game_id update_id(
        "update_mapgen", "fbmc_shelter_1_0" );
    const sol::protected_function_result update_result = update_token( update_id );
    REQUIRE( update_result.valid() );
    const sol::table update_envelope = update_result.get<sol::table>();
    REQUIRE( update_envelope["ok"].get<bool>() );
    const cata::lua_platform::mapgen_update_token update =
        update_envelope["value"].get<cata::lua_platform::mapgen_update_token>();

    const auto check_error = [&]( const char *expected_code, auto invoke ) {
        fixture.write_called = false;
        const sol::protected_function_result result = invoke();
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               expected_code );
        CHECK_FALSE( fixture.write_called );
    };

    check_error( "invalid_target", [&]() {
        return apply( fixture.abs_omt_position( fixture.target_omt ), update );
    } );
    check_error( "invalid_update", [&]() {
        return apply( target, update_id );
    } );

    const std::vector<std::pair<std::string, sol::table>> invalid_options = {
        { "delay", fixture.lua.create_table_with( "delay", 1 ) },
        { "mission", fixture.lua.create_table_with( "mission", true ) },
        { "key", fixture.lua.create_table_with( "key", "legacy-key" ) },
        { "cancel_on_collision=false",
          fixture.lua.create_table_with( "cancel_on_collision", false ) },
    };
    for( const auto &test_case : invalid_options ) {
        INFO( test_case.first );
        check_error( "invalid_options", [&]() {
            return apply( target, update, test_case.second );
        } );
    }

    const std::vector<std::pair<std::string, sol::table>> unsupported_transforms = {
        { "mirror_horizontal=true",
          fixture.lua.create_table_with( "mirror_horizontal", true ) },
        { "mirror_vertical=true",
          fixture.lua.create_table_with( "mirror_vertical", true ) },
        { "rotation=1", fixture.lua.create_table_with( "rotation", 1 ) },
        { "rotation=4", fixture.lua.create_table_with( "rotation", 4 ) },
    };
    for( const auto &test_case : unsupported_transforms ) {
        INFO( test_case.first );
        check_error( "unsupported_transform", [&]() {
            return apply( target, update, test_case.second );
        } );
    }
}

TEST_CASE( "lua_platform_mapgen_apply_reports_preflight_rejection_without_mutation",
           "[lua][platform][mapgen][transaction]" )
{
    platform_overmap_travel_fixture fixture( 812, 42 );

    const sol::table overmap = fixture.overmap_api();
    const sol::table mapgen = fixture.services["mapgen"];
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function update_token = mapgen["update_token"];
    const sol::protected_function apply = mapgen["apply"];

    const sol::protected_function_result target_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( target_result.valid() );
    const sol::table target_envelope = target_result.get<sol::table>();
    REQUIRE( target_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token target =
        target_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const cata::lua_platform::script_game_id update_id(
        "update_mapgen", "fbbb" );
    const sol::protected_function_result update_result = update_token( update_id );
    REQUIRE( update_result.valid() );
    const sol::table update_envelope = update_result.get<sol::table>();
    REQUIRE( update_envelope["ok"].get<bool>() );
    const cata::lua_platform::mapgen_update_token update =
        update_envelope["value"].get<cata::lua_platform::mapgen_update_token>();

    fixture.write_called = false;
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result result = apply( target, update );
    REQUIRE( result.valid() );
    CHECK_FALSE( fixture.write_called );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    const sol::table error = envelope["error"].get<sol::table>();
    CHECK( error["state"].get<std::string>() == "rejected" );
    CHECK( error["code"].get<std::string>() == "unsafe_operator" );
    const sol::object footprint = error["footprint"];
    CHECK( footprint.get_type() == sol::type::nil );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );
}

TEST_CASE( "lua_platform_mapgen_update_tokens_reject_invalid_and_stale_context",
           "[lua][platform][mapgen][tokens]" )
{
    platform_overmap_travel_fixture fixture( 810, 40 );
    const sol::table mapgen = fixture.services["mapgen"];
    const sol::protected_function update_token = mapgen["update_token"];
    const cata::lua_platform::script_game_id valid_update(
        "update_mapgen", "fbmc_shelter_1_0" );
    REQUIRE( valid_update.is_valid() );

    const sol::protected_function_result token_result = update_token( valid_update );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::mapgen_update_token token =
        token_envelope["value"].get<cata::lua_platform::mapgen_update_token>();
    CHECK( token.id() == valid_update );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.world );
    CHECK( token.owner_is_current() );

    const auto check_invalid_id = [&](
        const cata::lua_platform::script_game_id &id ) {
        const sol::protected_function_result result = update_token( id );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "invalid_id" );
    };
    check_invalid_id( cata::lua_platform::script_game_id(
                          "terrain", "t_floor" ) );
    check_invalid_id( cata::lua_platform::script_game_id(
                          "update_mapgen", "lua_platform_missing_update" ) );

    const cata::lua_platform::game_handle_runtime stale_runtime(
        fixture.owner, fixture.runtime.generation() + 1 );
    const std::optional<cata::lua_platform::game_handle_error> runtime_error =
        cata::lua_platform::validate_mapgen_update_token(
            token, stale_runtime, fixture.world );
    REQUIRE( runtime_error.has_value() );
    CHECK( runtime_error->code == "stale_runtime" );

    const std::optional<cata::lua_platform::game_handle_error> world_error =
        cata::lua_platform::validate_mapgen_update_token(
            token, fixture.runtime, fixture.world + 1 );
    REQUIRE( world_error.has_value() );
    CHECK( world_error->code == "stale_world" );

    fixture.owner->retire();
    CHECK_FALSE( token.owner_is_current() );
    const std::optional<cata::lua_platform::game_handle_error> owner_error =
        cata::lua_platform::validate_mapgen_update_token(
            token, fixture.runtime, fixture.world );
    REQUIRE( owner_error.has_value() );
    CHECK( owner_error->code == "stale_owner" );
}

TEST_CASE( "lua_platform_overmap_tile_token_rejects_stale_runtime_world_and_owner",
           "[lua][platform][overmap]" )
{
    platform_overmap_travel_fixture fixture( 801, 31 );
    const tripoint_abs_omt avatar_omt_before = get_avatar().pos_abs_omt();
    const tripoint_abs_sm map_abs_sub_before = get_map().get_abs_sub();
    const sol::protected_function tile_token = fixture.overmap_api()["tile_token"];

    const sol::protected_function_result token_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();
    CHECK( token.native_position() == fixture.target_omt );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.world );
    CHECK( token.owner_is_current() );

    const auto check_wrong_frame = [&](
        const cata::lua_platform::script_tripoint_coord &position ) {
        const sol::protected_function_result result = tile_token( position );
        REQUIRE( result.valid() );
        const sol::table envelope = result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "invalid_position" );
    };

    check_wrong_frame( cata::lua_platform::script_tripoint_coord::from_native(
                           coords::origin::abs, coords::scale::map_square,
                           fixture.target_omt.raw() ) );
    check_wrong_frame( cata::lua_platform::script_tripoint_coord::from_native(
                           coords::origin::relative,
                           coords::scale::overmap_terrain,
                           fixture.target_omt.raw() ) );
    const cata::lua_platform::game_handle_runtime wrong_runtime(
        fixture.owner, fixture.runtime.generation() + 1 );
    const auto wrong_runtime_error =
        cata::lua_platform::validate_overmap_tile_token(
            token, wrong_runtime, fixture.world );
    REQUIRE( wrong_runtime_error.has_value() );
    CHECK( wrong_runtime_error->code == "stale_runtime" );

    const auto wrong_world_error =
        cata::lua_platform::validate_overmap_tile_token(
            token, fixture.runtime, fixture.world + 1 );
    REQUIRE( wrong_world_error.has_value() );
    CHECK( wrong_world_error->code == "stale_world" );

    CHECK_FALSE( cata::lua_platform::validate_overmap_tile_token(
                       token, fixture.runtime, fixture.world ).has_value() );

    cata::lua_platform::reset_overmap_tile_tokens();
    CHECK_FALSE( token.owner_is_current() );
    const auto owner_error = cata::lua_platform::validate_overmap_tile_token(
                                 token, fixture.runtime, fixture.world );
    REQUIRE( owner_error.has_value() );
    CHECK( owner_error->code == "stale_owner" );

    CHECK( get_avatar().pos_abs_omt() == avatar_omt_before );
    CHECK( get_map().get_abs_sub() == map_abs_sub_before );
}

TEST_CASE( "lua_platform_overmap_travel_to_omt_requires_exact_token",
           "[lua][platform][overmap][relocation]" )
{
    platform_overmap_travel_fixture fixture( 802, 32 );
    const sol::protected_function tile_token = fixture.overmap_api()["tile_token"];
    const sol::protected_function_result token_result = tile_token(
            fixture.abs_omt_position( fixture.target_omt ) );
    REQUIRE( token_result.valid() );
    const sol::table token_envelope = token_result.get<sol::table>();
    REQUIRE( token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();
    REQUIRE_FALSE( cata::lua_platform::validate_overmap_tile_token(
                       token, fixture.runtime, fixture.world ).has_value() );

    const std::size_t avatar_identity_generation =
        fixture.avatar_handle.identity_generation();
    const std::uint64_t epoch_before =
        cata::lua_platform::map_mutation_epoch();
    const tripoint_abs_omt source_omt = get_avatar().pos_abs_omt();
    const tripoint_abs_sm source_map_abs_sub = get_map().get_abs_sub();
    const sol::protected_function travel_to_omt =
        fixture.relocation_api()["travel_to_omt"];
    const sol::table strict_options = fixture.lua.create_table_with(
                                           "strict", true );

    const sol::protected_function_result raw_target = travel_to_omt(
            fixture.avatar_handle,
            fixture.abs_omt_position( fixture.target_omt ), strict_options );
    REQUIRE_FALSE( raw_target.valid() );
    CHECK( get_avatar().pos_abs_omt() == source_omt );
    CHECK( get_map().get_abs_sub() == source_map_abs_sub );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before );

    const sol::protected_function_result moved = travel_to_omt(
            fixture.avatar_handle, token, strict_options );
    REQUIRE( moved.valid() );
    const sol::table moved_envelope = moved.get<sol::table>();
    REQUIRE( moved_envelope["ok"].get<bool>() );
    const sol::table moved_value = moved_envelope["value"].get<sol::table>();
    CHECK( moved_value["scope"].get<std::string>() == "avatar" );
    CHECK( moved_value["changed"].get<bool>() );
    CHECK( get_avatar().pos_abs_omt() == fixture.target_omt );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before + 1 );

    const cata::lua_platform::game_handle returned_handle =
        moved_value["handle"].get<cata::lua_platform::game_handle>();
    CHECK( returned_handle.identity_generation() == avatar_identity_generation );
    const std::optional<cata::lua_platform::game_handle_error> token_error =
        cata::lua_platform::validate_overmap_tile_token(
            token, fixture.runtime, fixture.world );
    CHECK_FALSE( token_error.has_value() );

    const std::uint64_t epoch_after_commit =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result repeated = travel_to_omt(
            returned_handle, token, strict_options );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK( repeated_value["scope"].get<std::string>() == "avatar" );
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( get_avatar().pos_abs_omt() == fixture.target_omt );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_after_commit );

    const sol::table relocation = fixture.relocation_api();
    CHECK_FALSE( relocation["overmap_at"].valid() );

    cata::lua_platform::reset_overmap_tile_tokens();
    const std::uint64_t epoch_before_stale =
        cata::lua_platform::map_mutation_epoch();
    const sol::protected_function_result stale = travel_to_omt(
            returned_handle, token, strict_options );
    REQUIRE( stale.valid() );
    const sol::table stale_envelope = stale.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_owner" );
    CHECK( get_avatar().pos_abs_omt() == fixture.target_omt );
    CHECK( cata::lua_platform::map_mutation_epoch() == epoch_before_stale );
}

TEST_CASE( "lua_platform_overmap_tile_edit_uses_revision_and_keeps_token_stable",
           "[lua][platform][overmap][mutation]" )
{
    platform_overmap_travel_fixture fixture( 803, 33 );
    REQUIRE( fixture.edit_ready );

    const sol::table overmap = fixture.overmap_api();
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function_result source_token_result = tile_token(
            fixture.abs_omt_position( fixture.source_omt ) );
    REQUIRE( source_token_result.valid() );
    const sol::table source_token_envelope = source_token_result.get<sol::table>();
    REQUIRE( source_token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const sol::protected_function snapshot = overmap["snapshot"];
    const sol::protected_function_result before_result = snapshot( token );
    REQUIRE( before_result.valid() );
    const sol::table before_envelope = before_result.get<sol::table>();
    REQUIRE( before_envelope["ok"].get<bool>() );
    const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
    const std::size_t before_revision =
        before_snapshot["revision"].get<std::size_t>();
    const bool before_explored = before_snapshot["explored"].get<bool>();

    sol::table changes = fixture.lua.create_table();
    changes["set_explored"] = !before_explored;
    changes["set_note"] = fixture.lua.create_table_with(
                              "value", "platform edit" );
    changes["set_note_danger"] = fixture.lua.create_table_with(
                                      "dangerous", true, "radius", 3 );

    const sol::protected_function edit = overmap["edit"];
    const sol::protected_function_result committed = edit(
            token, before_revision, changes );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    const sol::table committed_value = committed_envelope["value"].get<sol::table>();
    CHECK( committed_value["accepted"].get<bool>() );
    CHECK( committed_value["changed"].get<bool>() );
    const std::size_t committed_revision =
        committed_value["revision"].get<std::size_t>();
    CHECK( committed_revision == before_revision + 1 );
    const sol::table committed_snapshot =
        committed_value["snapshot"].get<sol::table>();
    CHECK( committed_snapshot["revision"].get<std::size_t>() == committed_revision );
    CHECK( committed_snapshot["explored"].get<bool>() == !before_explored );
    CHECK( committed_snapshot["note"].get<std::string>() == "platform edit" );
    CHECK( committed_snapshot["note_dangerous"].get<bool>() );
    CHECK( committed_snapshot["note_danger_radius"].get<int>() == 3 );
    CHECK_FALSE( cata::lua_platform::validate_overmap_tile_token(
                       token, fixture.runtime, fixture.world ).has_value() );

    const sol::protected_function_result stale = edit(
            token, before_revision, changes );
    REQUIRE( stale.valid() );
    const sol::table stale_envelope = stale.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "stale_revision" );

    const sol::protected_function_result after_stale_result = snapshot( token );
    REQUIRE( after_stale_result.valid() );
    const sol::table after_stale_envelope = after_stale_result.get<sol::table>();
    REQUIRE( after_stale_envelope["ok"].get<bool>() );
    const sol::table after_stale_snapshot =
        after_stale_envelope["value"].get<sol::table>();
    CHECK( after_stale_snapshot["revision"].get<std::size_t>() == committed_revision );
    CHECK( after_stale_snapshot["explored"].get<bool>() ==
           committed_snapshot["explored"].get<bool>() );
    CHECK( after_stale_snapshot["note"].get<std::string>() ==
           committed_snapshot["note"].get<std::string>() );
    CHECK( after_stale_snapshot["note_dangerous"].get<bool>() ==
           committed_snapshot["note_dangerous"].get<bool>() );
    CHECK( after_stale_snapshot["note_danger_radius"].get<int>() ==
           committed_snapshot["note_danger_radius"].get<int>() );

    const sol::protected_function_result repeated = edit(
            token, committed_revision, changes );
    REQUIRE( repeated.valid() );
    const sol::table repeated_envelope = repeated.get<sol::table>();
    REQUIRE( repeated_envelope["ok"].get<bool>() );
    const sol::table repeated_value = repeated_envelope["value"].get<sol::table>();
    CHECK( repeated_value["accepted"].get<bool>() );
    CHECK_FALSE( repeated_value["changed"].get<bool>() );
    CHECK( repeated_value["previous_revision"].get<std::size_t>() == committed_revision );
    CHECK( repeated_value["revision"].get<std::size_t>() == committed_revision );
}

TEST_CASE( "lua_platform_overmap_tile_edit_seen_uses_revision",
           "[lua][platform][overmap][mutation]" )
{
    platform_overmap_travel_fixture fixture( 804, 34 );
    REQUIRE( fixture.edit_ready );

    const sol::table overmap = fixture.overmap_api();
    const sol::protected_function tile_token = overmap["tile_token"];
    const sol::protected_function_result source_token_result = tile_token(
            fixture.abs_omt_position( fixture.source_omt ) );
    REQUIRE( source_token_result.valid() );
    const sol::table source_token_envelope = source_token_result.get<sol::table>();
    REQUIRE( source_token_envelope["ok"].get<bool>() );
    const cata::lua_platform::overmap_tile_token token =
        source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

    const sol::protected_function snapshot = overmap["snapshot"];
    const sol::protected_function_result before_result = snapshot( token );
    REQUIRE( before_result.valid() );
    const sol::table before_envelope = before_result.get<sol::table>();
    REQUIRE( before_envelope["ok"].get<bool>() );
    const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
    const std::size_t before_revision =
        before_snapshot["revision"].get<std::size_t>();

    const om_vision_level before_native =
        fixture.source_overmap->seen( fixture.source_local );
    const om_vision_level target =
        before_native == om_vision_level::full ?
        om_vision_level::unseen : om_vision_level::full;
    sol::table changes = fixture.lua.create_table();
    changes["set_seen"] = cata::lua_platform::script_enum_value::from(
                              "OmVisionLevel",
                              target == om_vision_level::full ? "full" : "unseen" );

    const sol::protected_function edit = overmap["edit"];
    const sol::protected_function_result committed = edit(
            token, before_revision, changes );
    REQUIRE( committed.valid() );
    const sol::table committed_envelope = committed.get<sol::table>();
    REQUIRE( committed_envelope["ok"].get<bool>() );
    const sol::table committed_value = committed_envelope["value"].get<sol::table>();
    CHECK( committed_value["changed"].get<bool>() );
    const std::size_t committed_revision =
        committed_value["revision"].get<std::size_t>();
    CHECK( committed_revision == before_revision + 1 );
    CHECK( fixture.source_overmap->seen( fixture.source_local ) == target );
}

TEST_CASE( "lua_platform_overmap_tile_edit_rejects_invalid_changes_and_removes_legacy_mutators",
           "[lua][platform][overmap][mutation]" )
{
    SECTION( "invalid note/danger" )
    {
        platform_overmap_travel_fixture fixture( 805, 35 );
        REQUIRE( fixture.edit_ready );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        const std::size_t before_revision =
            before_snapshot["revision"].get<std::size_t>();
        const bool before_has_note = before_snapshot["note"].is<std::string>();
        const std::string before_note = before_has_note ?
                                        before_snapshot["note"].get<std::string>() :
                                        std::string();
        const bool before_note_dangerous =
            before_snapshot["note_dangerous"].get<bool>();
        const int before_note_danger_radius =
            before_snapshot["note_danger_radius"].get<int>();

        sol::table changes = fixture.lua.create_table();
        changes["set_note"] = fixture.lua.create_table_with(
                                  "clear", true );
        changes["set_note_danger"] = fixture.lua.create_table_with(
                                          "dangerous", true, "radius", 3 );

        const sol::protected_function edit = overmap["edit"];
        const sol::protected_function_result rejected = edit(
                token, before_revision, changes );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "invalid_change" );

        const sol::protected_function_result after_result = snapshot( token );
        REQUIRE( after_result.valid() );
        const sol::table after_envelope = after_result.get<sol::table>();
        REQUIRE( after_envelope["ok"].get<bool>() );
        const sol::table after_snapshot = after_envelope["value"].get<sol::table>();
        CHECK( after_snapshot["revision"].get<std::size_t>() == before_revision );
        CHECK( after_snapshot["note"].is<std::string>() == before_has_note );
        if( before_has_note ) {
            CHECK( after_snapshot["note"].get<std::string>() == before_note );
        }
        CHECK( after_snapshot["note_dangerous"].get<bool>() ==
               before_note_dangerous );
        CHECK( after_snapshot["note_danger_radius"].get<int>() ==
               before_note_danger_radius );
    }

    SECTION( "unknown field" )
    {
        platform_overmap_travel_fixture fixture( 806, 36 );
        REQUIRE( fixture.edit_ready );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        const std::size_t before_revision =
            before_snapshot["revision"].get<std::size_t>();
        const std::string before_terrain =
            before_snapshot["terrain"].get<
                cata::lua_platform::script_game_id>().value();

        sol::table changes = fixture.lua.create_table();
        changes["unknown"] = true;

        const sol::protected_function edit = overmap["edit"];
        const sol::protected_function_result rejected = edit(
                token, before_revision, changes );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "invalid_change" );

        const sol::protected_function_result after_result = snapshot( token );
        REQUIRE( after_result.valid() );
        const sol::table after_envelope = after_result.get<sol::table>();
        REQUIRE( after_envelope["ok"].get<bool>() );
        const sol::table after_snapshot = after_envelope["value"].get<sol::table>();
        CHECK( after_snapshot["revision"].get<std::size_t>() == before_revision );
        CHECK( after_snapshot["terrain"].get<
                   cata::lua_platform::script_game_id>().value() == before_terrain );
    }

    SECTION( "legacy mutators removed" )
    {
        platform_overmap_travel_fixture fixture( 807, 37 );
        REQUIRE( fixture.edit_ready );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        CHECK( before_snapshot["revision"].is<lua_Integer>() );

        CHECK_FALSE( overmap["set_terrain"].valid() );
        CHECK_FALSE( overmap["set_seen"].valid() );
        CHECK_FALSE( overmap["set_explored"].valid() );
        CHECK_FALSE( overmap["set_note"].valid() );
        CHECK_FALSE( overmap["set_note_danger"].valid() );
        CHECK( overmap["tile_token"].valid() );
        CHECK( overmap["snapshot"].valid() );
        CHECK( overmap["edit"].valid() );
        CHECK_FALSE( overmap["tile"].valid() );
        CHECK( overmap["reveal"].valid() );
        CHECK_FALSE( overmap["reveal_route"].valid() );
    }

    SECTION( "generated terrain" )
    {
        platform_overmap_travel_fixture fixture( 808, 38 );
        REQUIRE( fixture.edit_ready );
        REQUIRE( fixture.source_overmap->is_omt_generated( fixture.source_local ) );

        const sol::table overmap = fixture.overmap_api();
        const sol::protected_function tile_token = overmap["tile_token"];
        const sol::protected_function_result source_token_result = tile_token(
                fixture.abs_omt_position( fixture.source_omt ) );
        REQUIRE( source_token_result.valid() );
        const sol::table source_token_envelope = source_token_result.get<sol::table>();
        REQUIRE( source_token_envelope["ok"].get<bool>() );
        const cata::lua_platform::overmap_tile_token token =
            source_token_envelope["value"].get<cata::lua_platform::overmap_tile_token>();

        const sol::protected_function snapshot = overmap["snapshot"];
        const sol::protected_function_result before_result = snapshot( token );
        REQUIRE( before_result.valid() );
        const sol::table before_envelope = before_result.get<sol::table>();
        REQUIRE( before_envelope["ok"].get<bool>() );
        const sol::table before_snapshot = before_envelope["value"].get<sol::table>();
        const std::size_t before_revision =
            before_snapshot["revision"].get<std::size_t>();
        const cata::lua_platform::script_game_id current_terrain =
            before_snapshot["terrain"].get<cata::lua_platform::script_game_id>();
        const oter_id before_native_terrain =
            fixture.source_overmap->ter( fixture.source_local );

        const cata::lua_platform::script_game_id field(
            "overmap_terrain", "field" );
        const cata::lua_platform::script_game_id forest(
            "overmap_terrain", "forest" );
        const cata::lua_platform::script_game_id target =
            field.is_valid() && field.value() != current_terrain.value() ?
            field : forest;
        REQUIRE( target.is_valid() );
        REQUIRE( target.value() != current_terrain.value() );

        sol::table changes = fixture.lua.create_table();
        changes["set_terrain"] = target;

        const sol::protected_function edit = overmap["edit"];
        const sol::protected_function_result rejected = edit(
                token, before_revision, changes );
        REQUIRE( rejected.valid() );
        const sol::table rejected_envelope = rejected.get<sol::table>();
        REQUIRE_FALSE( rejected_envelope["ok"].get<bool>() );
        CHECK( rejected_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "already_generated" );
        CHECK( fixture.source_overmap->ter( fixture.source_local ) ==
               before_native_terrain );

        const sol::protected_function_result after_result = snapshot( token );
        REQUIRE( after_result.valid() );
        const sol::table after_envelope = after_result.get<sol::table>();
        REQUIRE( after_envelope["ok"].get<bool>() );
        const sol::table after_snapshot = after_envelope["value"].get<sol::table>();
        CHECK( after_snapshot["revision"].get<std::size_t>() == before_revision );
        CHECK( after_snapshot["terrain"].get<
                   cata::lua_platform::script_game_id>().value() ==
               current_terrain.value() );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
