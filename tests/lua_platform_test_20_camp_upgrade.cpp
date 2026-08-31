#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_camp_api_exposes_only_explicit_create_remove_and_expansion_routes",
           "[lua][platform][camp][api]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 123 );
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 33 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 33 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    CHECK( camps["create"].valid() );
    CHECK( camps["remove"].valid() );
    const sol::table expansions = camps["expansions"];
    CHECK( expansions["create"].valid() );
    CHECK( expansions["list"].valid() );
    CHECK( expansions["get"].valid() );
    CHECK( expansions["remove"].valid() );
    CHECK_FALSE( camps["near"].valid() );
    CHECK_FALSE( camps["current"].valid() );
    CHECK_FALSE( expansions["nearest"].valid() );
}

TEST_CASE( "lua_platform_upgrade_commit_state_unknown_for_partial_or_unloaded_target",
           "[lua][platform][camp][upgrade][recovery]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt position{ 170, 170, 0 };
    overmap_buffer.ter_set( position, oter_id( "field" ) );

    basecamp camp( "Upgrade Commit State Camp", position );
    camp.set_owner( owner );
    camp.define_camp( position, "faction_base_bare_bones_basecamp_0", false );

    const recipe &upgrade = recipe_id( "faction_base_shelter_1_0" ).obj();
    REQUIRE( upgrade.is_blueprint() );
    REQUIRE( !upgrade.blueprint_build_reqs().reqs_by_parameters.empty() );
    const auto requirement = upgrade.blueprint_build_reqs().reqs_by_parameters.begin();
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                get_avatar().getID(), 1 );

    basecamp_platform_upgrade_work work;
    work.upgrade_id = upgrade.result().str();
    work.blueprint_id = upgrade.get_blueprint().str();
    work.target_kind = basecamp_platform_upgrade_target_kind::camp_core;
    work.target_core_generation = camp.platform_core_upgrade_generation();
    work.target_position = position;
    work.target_terrain = "field";
    work.mapgen_args = requirement->first;
    work.duration_turns = to_turns<std::int64_t>(
                              time_duration::from_moves( requirement->second.time ) );
    work.source_holders = { holder };
    work.destination_holder = holder;

    // A changed terrain without the complete metadata/generation publication
    // is neither a safe retry nor proof of a committed upgrade.
    overmap_buffer.ter_set( position, oter_id( "forest" ) );
    std::string error;
    CHECK( camp.platform_upgrade_commit_state(
               work, 1, 1, 0, error ) == basecamp_platform_upgrade_commit_state::unknown );
    CHECK_FALSE( error.empty() );

    // A target that is no longer attached to the camp has no authoritative
    // loaded target for recovery; it must not be replayed as a retry.
    basecamp_platform_upgrade_work unloaded = work;
    unloaded.target_position = tripoint_abs_omt{ 100000, 100000, 0 };
    error.clear();
    CHECK( camp.platform_upgrade_commit_state(
               unloaded, 1, 1, 0, error ) == basecamp_platform_upgrade_commit_state::unknown );
    CHECK_FALSE( error.empty() );
}

TEST_CASE( "lua_platform_upgrade_legacy_record_is_quarantined_with_escrow",
           "[lua][platform][camp][upgrade][serialization]" )
{
    const faction_id owner( "your_followers" );
    const std::uint64_t camp_id = 99801;
    const std::uint64_t task_id = 99802;
    const character_id manager_id( 99803 );
    const character_id worker_id( 99804 );
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                worker_id, 1 );
    const item escrow_value( itype_id( "stick" ), calendar::turn_zero );
    const std::string serialized_item = serialize_platform_recipe_test_item( escrow_value );

    std::ostringstream saved;
    JsonOut json( saved );
    json.start_object();
    json.member( "owner", owner );
    json.member( "name", "Legacy Upgrade Recovery Camp" );
    json.member( "pos", tripoint_abs_omt{ 171, 171, 0 } );
    json.member( "platform_id", camp_id );
    // v2 predates a safe typed upgrade descriptor.  The upgrade-shaped record
    // therefore has to enter the explicit refund-only quarantine path.
    json.member( "platform_tasks_version", basecamp_platform_task_schema_version_legacy );
    json.member( "platform_tasks" );
    json.start_array();
    json.start_object();
    json.member( "task_id", task_id );
    json.member( "generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "camp_id", camp_id );
    json.member( "owner_faction", owner );
    json.member( "manager_id", manager_id );
    json.member( "worker_id", worker_id );
    json.member( "kind", std::string( basecamp_platform_upgrade_work_kind ) );
    json.member( "state", "running" );
    json.member( "started_at", calendar::turn_zero );
    json.member( "due_at", calendar::turn_zero + 1_turns );
    json.member( "recipe_escrow" );
    json.start_array();
    json.start_object();
    json.member( "stable_uid", escrow_value.uid().get_value() );
    json.member( "identity_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "charges", static_cast<std::int64_t>( 1 ) );
    json.member( "tool", false );
    json.member( "serialized_item", serialized_item );
    json.member( "source_holder" );
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_object();
    json.end_array();
    json.end_object();
    json.end_array();
    json.member( "bb_pos", tripoint_abs_ms::zero );
    json.member( "dumping_spot", tripoint_abs_ms::zero );
    json.member( "liquid_dumping_spots" );
    json.start_array();
    json.end_array();
    json.member( "hidden_missions" );
    json.start_array();
    json.end_array();
    json.member( "expansions" );
    json.start_array();
    json.end_array();
    json.member( "fortifications" );
    json.start_array();
    json.end_array();
    json.member( "salt_water_pipes" );
    json.start_array();
    json.end_array();
    json.end_object();

    basecamp restored;
    const JsonValue parsed = json_loader::from_string( saved.str() );
    restored.deserialize( parsed.get_object() );
    const std::vector<basecamp_platform_task> quarantined_tasks =
        restored.platform_task_snapshot();
    REQUIRE( quarantined_tasks.size() == 1 );
    const basecamp_platform_task &quarantined = quarantined_tasks.front();
    CHECK( quarantined.state == basecamp_platform_task_state::refund_pending );
    CHECK( quarantined.recipe_recovery_required );
    CHECK_FALSE( quarantined.upgrade_work );
    REQUIRE( quarantined.recipe_escrow.size() == 1 );
    CHECK( quarantined.recipe_escrow.front().serialized_item == serialized_item );

    std::string error;
    std::vector<basecamp_platform_recipe_escrow_item> recovery_escrow;
    REQUIRE( restored.platform_prepare_recipe_refund(
                 quarantined.task_id, quarantined.identity_generation, nullptr,
                 recovery_escrow, error ) );
    REQUIRE( restored.platform_claim_recipe_escrow(
                 quarantined.task_id, quarantined.identity_generation,
                 calendar::turn_zero, false, recovery_escrow, error ) );
    const basecamp_platform_task recovered = restored.platform_task_snapshot().front();
    CHECK( recovered.state == basecamp_platform_task_state::cancelled );
    CHECK( recovered.identity_generation == quarantined.identity_generation + 1 );
    CHECK( recovered.recipe_escrow.empty() );
    CHECK_FALSE( recovered.recipe_recovery_required );
}

TEST_CASE( "lua_platform_upgrade_owner_transition_is_idempotent",
           "[lua][platform][camp][upgrade][lifecycle]" )
{
    const faction_id old_owner( "your_followers" );
    const faction_id new_owner( "upgrade_owner_replacement" );
    const tripoint_abs_omt camp_position{ 172, 172, 0 };
    const tripoint_abs_omt expansion_position{ 173, 172, 0 };
    overmap_buffer.ter_set( expansion_position, oter_id( "field" ) );

    basecamp camp( "Idempotent Upgrade Owner Camp", camp_position );
    camp.set_owner( old_owner );
    std::string error;
    basecamp_platform_expansion expansion;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "Canteen", expansion_position,
                 expansion, error ) );

    const npc_ptr worker = make_platform_test_npc(
                               character_id( 99811 ), old_owner, camp_position );
    basecamp_platform_task task = make_platform_test_task(
                                      camp, old_owner, character_id( 99812 ), *worker );
    REQUIRE( camp.platform_create_task( task, error ) );

    camp.set_owner( new_owner );
    const basecamp_platform_task after_first_transition =
        camp.platform_task_snapshot().front();
    const basecamp_platform_expansion after_first_expansion =
        camp.platform_expansion_snapshot().front();
    CHECK( after_first_transition.state == basecamp_platform_task_state::cancelled );
    CHECK( after_first_transition.identity_generation == task.identity_generation + 1 );
    CHECK( after_first_transition.owner_faction == new_owner );
    CHECK( after_first_expansion.identity_generation == expansion.identity_generation + 1 );

    // Both public owner paths must treat an already-published owner as a
    // no-op, with no second task or expansion generation retirement.
    camp.set_owner( new_owner );
    camp.handle_takeover_by( new_owner, false );
    const basecamp_platform_task after_repeat = camp.platform_task_snapshot().front();
    const basecamp_platform_expansion after_repeat_expansion =
        camp.platform_expansion_snapshot().front();
    CHECK( after_repeat.identity_generation == after_first_transition.identity_generation );
    CHECK( after_repeat.state == after_first_transition.state );
    CHECK( after_repeat_expansion.identity_generation ==
           after_first_expansion.identity_generation );
}

TEST_CASE( "lua_platform_upgrade_rejects_unsafe_mapgen_operator",
           "[lua][platform][camp][upgrade][mapgen]" )
{
    const update_mapgen_id unsafe_operator( "fbbb" );
    const tripoint_abs_omt position{ 174, 174, 0 };
    platform_mapgen_transaction_footprint footprint;
    std::string error;

    REQUIRE_FALSE( platform_transaction_safe( unsafe_operator, position, footprint, error ) );
    CHECK( error.find( "unsafe" ) != std::string::npos );
    CHECK( footprint.max_submap_x < footprint.min_submap_x );

    platform_mapgen_transaction_report report;
    const ret_val<void> result = run_mapgen_update_func_transactional(
                                     unsafe_operator, position, {}, nullptr, true,
                                     false, false, 0, std::nullopt, std::nullopt,
                                     &report );
    CHECK_FALSE( result.success() );
    CHECK( result.str().find( "unsafe" ) != std::string::npos );
    CHECK( report.state == platform_mapgen_transaction_state::rejected );
    CHECK( report.code == "unsafe_operator" );

    const update_mapgen_id safe_operator( "fbmc_shelter_1_0" );
    const auto check_rejection = [&]( const bool cancel_on_collision,
                                      const bool mirror_horizontal,
                                      const int rotation,
                                      const char *expected_code ) {
        platform_mapgen_transaction_report rejection_report;
        const ret_val<void> rejection = run_mapgen_update_func_transactional(
                                             safe_operator, position, {}, nullptr,
                                             cancel_on_collision, mirror_horizontal,
                                             false, rotation, std::nullopt,
                                             std::nullopt, &rejection_report );
        CHECK_FALSE( rejection.success() );
        CHECK( rejection_report.state == platform_mapgen_transaction_state::rejected );
        CHECK( rejection_report.code == expected_code );
    };
    check_rejection( true, true, 0, "unsupported_transform" );
    check_rejection( true, false, 1, "unsupported_transform" );
    check_rejection( false, false, 0, "invalid_context" );
}

TEST_CASE( "lua_platform_upgrade_rolls_back_complete_multi_submap_footprint",
           "[lua][platform][camp][upgrade][mapgen][rollback]" )
{
    const update_mapgen_id safe_operator( "fbmc_shelter_1_0" );
    const tripoint_abs_omt position = get_avatar().pos_abs_omt();
    const oter_id original_terrain = overmap_buffer.ter_existing( position );
    const on_out_of_scope restore_terrain( [position, original_terrain]() {
        overmap_buffer.ter_set( position, original_terrain );
    } );
    overmap_buffer.ter_set( position, oter_id( "field" ) );
    const oter_id terrain_before = overmap_buffer.ter_existing( position );

    platform_mapgen_transaction_footprint footprint;
    std::string error;
    REQUIRE( platform_transaction_safe( safe_operator, position, footprint, error ) );
    REQUIRE( footprint.complete_omt_z_stack );

    struct saved_submap {
        tripoint_abs_sm position;
        submap snapshot;
    };
    std::vector<saved_submap> saved_submaps;
    const tripoint_abs_sm base = project_to<coords::sm>( position );
    for( int z = footprint.min_z; z <= footprint.max_z; ++z ) {
        for( int x = footprint.min_submap_x; x <= footprint.max_submap_x; ++x ) {
            for( int y = footprint.min_submap_y; y <= footprint.max_submap_y; ++y ) {
                const tripoint_abs_sm submap_position{ base.x() + x, base.y() + y, z };
                submap *source = MAPBUFFER.lookup_submap( submap_position );
                REQUIRE( source != nullptr );
                saved_submaps.push_back( saved_submap{
                    submap_position, source->get_revert_submap() } );
            }
        }
    }

    // Invalidate the exact expected terrain after the transaction plan was
    // made.  The failure leg must preserve every planned submap and the
    // overmap terrain, rather than applying a partial mapgen publication.
    overmap_buffer.ter_set( position, oter_id( "river_center" ) );
    platform_mapgen_transaction_report report;
    const ret_val<void> result = run_mapgen_update_func_transactional(
                                     safe_operator, position, {}, nullptr, true,
                                     false, false, 0, terrain_before,
                                     oter_id( "faction_base_camp_0" ), &report );
    CHECK_FALSE( result.success() );
    CHECK( report.state == platform_mapgen_transaction_state::rejected );
    CHECK( report.code == "terrain_mismatch" );
    CHECK( report.footprint.min_submap_x == footprint.min_submap_x );
    CHECK( report.footprint.max_submap_x == footprint.max_submap_x );
    CHECK( report.footprint.min_submap_y == footprint.min_submap_y );
    CHECK( report.footprint.max_submap_y == footprint.max_submap_y );
    CHECK( report.footprint.min_z == footprint.min_z );
    CHECK( report.footprint.max_z == footprint.max_z );
    CHECK( report.footprint.complete_omt_z_stack );
    CHECK( overmap_buffer.ter_existing( position ) == oter_id( "river_center" ) );

    for( const saved_submap &saved : saved_submaps ) {
        submap *current = MAPBUFFER.lookup_submap( saved.position );
        REQUIRE( current != nullptr );
        for( int x = 0; x < SEEX; ++x ) {
            for( int y = 0; y < SEEY; ++y ) {
                const point_sm_ms local( x, y );
                CHECK( current->get_ter( local ) == saved.snapshot.get_ter( local ) );
                CHECK( current->get_furn( local ) == saved.snapshot.get_furn( local ) );
            }
        }
    }
}

TEST_CASE( "lua_platform_upgrade_post_commit_is_not_replayed",
           "[lua][platform][camp][upgrade][recovery]" )
{
    const faction_id owner( "your_followers" );
    const std::uint64_t camp_id = 99821;
    const std::uint64_t task_id = 99822;
    const character_id manager_id( 99823 );
    const character_id worker_id( 99824 );
    const tripoint_abs_omt position{ 176, 176, 0 };
    const recipe &upgrade = recipe_id( "faction_base_shelter_1_0" ).obj();
    REQUIRE( upgrade.is_blueprint() );
    REQUIRE( !upgrade.blueprint_build_reqs().reqs_by_parameters.empty() );
    const auto requirement = upgrade.blueprint_build_reqs().reqs_by_parameters.begin();
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
                worker_id, 1 );
    basecamp_platform_upgrade_work work;
    work.upgrade_id = upgrade.result().str();
    work.blueprint_id = upgrade.get_blueprint().str();
    work.target_kind = basecamp_platform_upgrade_target_kind::camp_core;
    work.target_core_generation = 1;
    work.target_position = position;
    work.target_terrain = "field";
    work.mapgen_args = requirement->first;
    work.duration_turns = to_turns<std::int64_t>(
                              time_duration::from_moves( requirement->second.time ) );
    work.source_holders = { holder };
    work.destination_holder = holder;
    const item escrow_value( itype_id( "stick" ), calendar::turn_zero );
    const basecamp_platform_recipe_escrow_item escrow_entry =
        make_platform_recipe_escrow_test_item( escrow_value, holder );

    std::ostringstream saved;
    JsonOut json( saved );
    json.start_object();
    json.member( "owner", owner );
    json.member( "name", "Committed Upgrade Recovery Camp" );
    json.member( "pos", position );
    json.member( "platform_id", camp_id );
    json.member( "platform_core_upgrade_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "platform_tasks_version", basecamp_platform_task_schema_version );
    json.member( "platform_tasks" );
    json.start_array();
    json.start_object();
    json.member( "task_id", task_id );
    json.member( "generation", static_cast<std::uint64_t>( 2 ) );
    json.member( "camp_id", camp_id );
    json.member( "owner_faction", owner );
    json.member( "manager_id", manager_id );
    json.member( "worker_id", worker_id );
    json.member( "manager_identity_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "worker_identity_generation", static_cast<std::uint64_t>( 1 ) );
    json.member( "kind", std::string( basecamp_platform_upgrade_work_kind ) );
    json.member( "parameters", std::string( basecamp_platform_upgrade_work_parameter_schema ) );
    json.member( "state", "completed_unclaimed" );
    json.member( "started_at", calendar::turn_zero );
    json.member( "due_at", calendar::turn_zero + 1_turns );
    json.member( "finished_at", calendar::turn_zero + 1_turns );
    json.member( "upgrade_work" );
    json.start_object();
    json.member( "upgrade_id", work.upgrade_id );
    json.member( "blueprint_id", work.blueprint_id );
    json.member( "target_kind", "camp_core" );
    json.member( "target_core_generation", work.target_core_generation );
    json.member( "target_expansion_id", static_cast<std::uint64_t>( 0 ) );
    json.member( "target_expansion_generation", static_cast<std::uint64_t>( 0 ) );
    json.member( "target_position", work.target_position );
    json.member( "target_terrain", work.target_terrain );
    json.member( "mapgen_args" );
    work.mapgen_args.serialize( json );
    json.member( "duration_turns", work.duration_turns );
    json.member( "source_holders" );
    json.start_array();
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_array();
    json.member( "destination_holder" );
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_object();
    json.member( "recipe_escrow" );
    json.start_array();
    json.start_object();
    json.member( "stable_uid", escrow_entry.stable_uid );
    json.member( "identity_generation", escrow_entry.identity_generation );
    json.member( "charges", escrow_entry.charges );
    json.member( "tool", escrow_entry.tool );
    json.member( "serialized_item", escrow_entry.serialized_item );
    json.member( "source_holder" );
    json.start_object();
    json.member( "kind", "character" );
    json.member( "character_id", holder.character );
    json.member( "identity_generation", holder.identity_generation );
    json.member( "slot", holder.slot );
    json.end_object();
    json.end_object();
    json.end_array();
    json.member( "upgrade_commit_marker", static_cast<std::uint64_t>( 1 ) );
    json.member( "upgrade_applying_marker", static_cast<std::uint64_t>( 0 ) );
    json.member( "recipe_recovery_required", false );
    json.end_object();
    json.end_array();
    json.member( "bb_pos", tripoint_abs_ms::zero );
    json.member( "dumping_spot", tripoint_abs_ms::zero );
    json.member( "liquid_dumping_spots" );
    json.start_array();
    json.end_array();
    json.member( "hidden_missions" );
    json.start_array();
    json.end_array();
    json.member( "expansions" );
    json.start_array();
    json.end_array();
    json.member( "fortifications" );
    json.start_array();
    json.end_array();
    json.member( "salt_water_pipes" );
    json.start_array();
    json.end_array();
    json.end_object();

    basecamp restored;
    const JsonValue parsed = json_loader::from_string( saved.str() );
    restored.deserialize( parsed.get_object() );
    const basecamp_platform_task before = restored.platform_task_snapshot().front();
    REQUIRE( before.state == basecamp_platform_task_state::completed_unclaimed );
    REQUIRE( before.upgrade_commit_marker != 0 );

    std::string error;
    CHECK_FALSE( restored.platform_finish_task(
                     before.task_id, before.identity_generation, nullptr,
                     calendar::turn_zero + 2_turns, true, before.recipe_escrow, error ) );
    const basecamp_platform_task after = restored.platform_task_snapshot().front();
    CHECK( after.state == before.state );
    CHECK( after.identity_generation == before.identity_generation );
    CHECK( after.upgrade_commit_marker == before.upgrade_commit_marker );
    CHECK( after.recipe_escrow.size() == before.recipe_escrow.size() );
}

#endif // CATA_ENABLE_LUA_PLATFORM
