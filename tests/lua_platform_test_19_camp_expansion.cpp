#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_camp_expansion_accepts_authoritative_target_terrain",
           "[lua][platform][camp][expansion][terrain]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 160, 160, 0 };
    const tripoint_abs_omt target_position{ 161, 160, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( target_position, oter_id( "field" ) );

    basecamp camp( "Eligible Expansion Camp", camp_position );
    camp.set_owner( owner );
    std::string error;
    CHECK( camp.platform_validate_expansion_placement(
               "faction_base_canteen_0", target_position, error ) );

    basecamp_platform_expansion expansion;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "Canteen", target_position, expansion, error ) );
    CHECK( expansion.position == target_position );
    CHECK( expansion.identity_generation == 1 );
    CHECK( camp.platform_expansion_snapshot().size() == 1 );
}

TEST_CASE( "lua_platform_camp_expansion_rejects_ineligible_target_terrain_without_mutation",
           "[lua][platform][camp][expansion][terrain]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 162, 162, 0 };
    const tripoint_abs_omt target_position{ 163, 162, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( target_position, oter_id( "river_center" ) );

    basecamp camp( "Invalid Terrain Expansion Camp", camp_position );
    camp.set_owner( owner );
    const oter_id terrain_before = overmap_buffer.ter_existing( target_position );
    std::string error;
    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Invalid Terrain", target_position,
                     rejected, error ) );
    CHECK( error.find( "eligible" ) != std::string::npos );
    CHECK( camp.platform_expansion_snapshot().empty() );
    CHECK( overmap_buffer.ter_existing( target_position ) == terrain_before );
    CHECK( rejected.expansion_id == 0 );
}

TEST_CASE( "lua_platform_camp_expansion_rechecks_terrain_after_eligibility_plan",
           "[lua][platform][camp][expansion][terrain][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 164, 164, 0 };
    const tripoint_abs_omt target_position{ 165, 164, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( target_position, oter_id( "field" ) );

    basecamp camp( "Changed Terrain Expansion Camp", camp_position );
    camp.set_owner( owner );
    std::string error;
    REQUIRE( camp.platform_validate_expansion_placement(
                 "faction_base_canteen_0", target_position, error ) );

    overmap_buffer.ter_set( target_position, oter_id( "river_center" ) );
    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Changed Terrain", target_position,
                     rejected, error ) );
    CHECK( error.find( "eligible" ) != std::string::npos );
    CHECK( camp.platform_expansion_snapshot().empty() );
    CHECK( overmap_buffer.ter_existing( target_position ) == oter_id( "river_center" ) );
}

TEST_CASE( "lua_platform_camp_expansion_rejection_leaves_no_id_gap_or_tombstone",
           "[lua][platform][camp][expansion][terrain][rollback]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt camp_position{ 166, 166, 0 };
    const tripoint_abs_omt first_position{ 167, 166, 0 };
    const tripoint_abs_omt second_position{ 166, 167, 0 };
    overmap_buffer.ter_set( camp_position, oter_id( "field" ) );
    overmap_buffer.ter_set( first_position, oter_id( "field" ) );
    overmap_buffer.ter_set( second_position, oter_id( "river_center" ) );

    basecamp camp( "Expansion Rollback Camp", camp_position );
    camp.set_owner( owner );
    std::string error;
    basecamp_platform_expansion first;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "First", first_position, first, error ) );

    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Rejected", second_position, rejected, error ) );
    CHECK( camp.platform_expansion_snapshot().size() == 1 );
    CHECK( rejected.expansion_id == 0 );
    CHECK( overmap_buffer.ter_existing( second_position ) == oter_id( "river_center" ) );

    overmap_buffer.ter_set( second_position, oter_id( "field" ) );
    basecamp_platform_expansion second;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "Second", second_position, second, error ) );
    CHECK( second.expansion_id == first.expansion_id + 1 );
    CHECK( camp.platform_expansion_snapshot().size() == 2 );
}

TEST_CASE( "lua_platform_camp_expansion_create_rejects_conflict_domain_and_type",
           "[lua][platform][camp][expansion]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Expansion Create Camp", tripoint_abs_omt{ 130, 130, 0 } );
    camp.set_owner( owner );
    overmap_buffer.ter_set( tripoint_abs_omt{ 131, 130, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion first;
    std::string error;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "North Store", tripoint_abs_omt{ 131, 130, 0 },
                 first, error ) );
    CHECK( first.expansion_id != 0 );
    CHECK( first.identity_generation == 1 );
    CHECK( first.camp_id == camp.platform_id() );

    basecamp_platform_expansion rejected;
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Duplicate", tripoint_abs_omt{ 131, 130, 0 },
                     rejected, error ) );
    CHECK( error.find( "already" ) != std::string::npos );
    CHECK_FALSE( camp.platform_create_expansion(
                     "faction_base_canteen_0", "Far Away", tripoint_abs_omt{ 133, 130, 0 },
                     rejected, error ) );
    CHECK( error.find( "outside" ) != std::string::npos );
    CHECK_FALSE( camp.platform_create_expansion(
                     "not_a_platform_expansion", "Invalid Type",
                     tripoint_abs_omt{ 130, 131, 0 }, rejected, error ) );
    CHECK( camp.platform_expansion_snapshot().size() == 1 );
}

TEST_CASE( "lua_platform_camp_create_preflight_conflict_and_failed_publish_leave_no_partial_camp",
           "[lua][platform][camp][lifecycle]" )
{
    const faction_id owner = get_avatar().get_faction()->id;
    const tripoint_abs_omt occupied_position{ 125, 125, 0 };
    basecamp existing( "Existing Explicit Camp", occupied_position );
    existing.set_owner( owner );
    overmap_buffer.add_camp( existing );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 124 );
    const cata::lua_platform::game_handle manager =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", get_avatar().getID().get_value(), 0, 0, 0, {} },
            runtime, 34 );
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 34 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 34 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    sol::table options = lua.create_table();
    options["type"] = "faction_base_bare_bones_basecamp_0";
    const cata::lua_platform::script_game_id owner_value(
        "faction", owner.str() );
    const cata::lua_platform::script_tripoint_coord occupied =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::overmap_terrain,
            occupied_position.raw() );
    const sol::protected_function create = camps["create"];
    const sol::protected_function_result conflict = create(
            owner_value, manager, occupied, "Conflicting Camp", options );
    REQUIRE( conflict.valid() );
    const sol::table conflict_result = conflict.get<sol::table>();
    CHECK_FALSE( conflict_result["ok"].get<bool>() );
    CHECK( conflict_result["error"].get<sol::table>()["code"].get<std::string>() ==
           "camp_conflict" );

    const tripoint_abs_omt failed_position{ 126, 126, 0 };
    const cata::lua_platform::script_tripoint_coord failed =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::overmap_terrain,
            failed_position.raw() );
    sol::table invalid_options = lua.create_table();
    invalid_options["type"] = "not_a_camp_type";
    const sol::protected_function_result failed_create = create(
            owner_value, manager, failed, "Failed Camp", invalid_options );
    CHECK_FALSE( failed_create.valid() );
    const overmap_with_local_coords loaded =
        overmap_buffer.get_existing_om_global( failed_position );
    CHECK( ( !loaded.om || !loaded.om->find_camp( failed_position.xy() ) ) );
    overmap_buffer.remove_camp( occupied_position.xy() );
}

TEST_CASE( "lua_platform_camp_expansion_tokens_retire_on_remove_and_owner_change",
           "[lua][platform][camp][expansion][identity]" )
{
    const faction_id owner( "your_followers" );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 120 );
    basecamp camp( "Expansion Token Camp", tripoint_abs_omt{ 135, 135, 0 } );
    camp.set_owner( owner );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 30 );
    overmap_buffer.ter_set( tripoint_abs_omt{ 136, 135, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion expansion;
    std::string error;
    REQUIRE( camp.platform_create_expansion(
                 "faction_base_canteen_0", "East Store", tripoint_abs_omt{ 136, 135, 0 },
                 expansion, error ) );
    const cata::lua_platform::camp_expansion_token token(
        expansion.expansion_id, expansion.identity_generation, camp_handle,
        owner.str(), runtime, 30 );
    basecamp_platform_expansion resolved;
    REQUIRE( camp.platform_get_expansion(
                 token.expansion_id(), token.identity_generation(), resolved, error ) );
    CHECK( resolved.position == expansion.position );
    REQUIRE( camp.platform_remove_expansion(
                 token.expansion_id(), token.identity_generation(), error ) );
    CHECK_FALSE( camp.platform_get_expansion(
                     token.expansion_id(), token.identity_generation(), resolved, error ) );
    CHECK( error.find( "retired" ) != std::string::npos );

    basecamp owner_change( "Expansion Owner Boundary", tripoint_abs_omt{ 137, 137, 0 } );
    owner_change.set_owner( owner );
    overmap_buffer.ter_set( tripoint_abs_omt{ 136, 137, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion owner_expansion;
    REQUIRE( owner_change.platform_create_expansion(
                 "faction_base_canteen_0", "West Store", tripoint_abs_omt{ 136, 137, 0 },
                 owner_expansion, error ) );
    const std::uint64_t old_generation = owner_expansion.identity_generation;
    owner_change.set_owner( faction_id( "replacement_camp_owner" ) );
    CHECK( owner_change.platform_expansion_snapshot().front().identity_generation ==
           old_generation + 1 );
    CHECK_FALSE( owner_change.platform_get_expansion(
                     owner_expansion.expansion_id, old_generation, resolved, error ) );
}

TEST_CASE( "lua_platform_camp_expansion_save_load_reissues_identity_from_stable_record",
           "[lua][platform][camp][expansion][serialization]" )
{
    const faction_id owner( "your_followers" );
    basecamp original( "Expansion Save Camp", tripoint_abs_omt{ 140, 140, 0 } );
    original.set_owner( owner );
    overmap_buffer.ter_set( tripoint_abs_omt{ 140, 141, 0 }, oter_id( "field" ) );
    basecamp_platform_expansion expansion;
    std::string error;
    REQUIRE( original.platform_create_expansion(
                 "faction_base_canteen_0", "South Store", tripoint_abs_omt{ 140, 141, 0 },
                 expansion, error ) );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 121 );
    cata::lua_platform::register_camp_handle_identity( original );
    const cata::lua_platform::game_handle old_camp_handle =
        cata::lua_platform::game_handle::from_camp( original, {}, runtime, 31 );

    std::ostringstream saved;
    JsonOut json( saved );
    original.serialize( json );
    basecamp restored;
    const JsonValue parsed = json_loader::from_string( saved.str() );
    restored.deserialize( parsed.get_object() );
    const std::vector<basecamp_platform_expansion> loaded =
        restored.platform_expansion_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().expansion_id == expansion.expansion_id );
    CHECK( loaded.front().identity_generation == expansion.identity_generation );
    CHECK( loaded.front().position == expansion.position );

    const cata::lua_platform::game_handle new_camp_handle =
        cata::lua_platform::game_handle::from_camp( restored, {}, runtime, 31 );
    CHECK( old_camp_handle.validation_error( runtime, 31 ) );
    CHECK_FALSE( new_camp_handle.validation_error( runtime, 31 ) );
}

TEST_CASE( "lua_platform_camp_remove_preflight_refuses_tasks_workers_escrow_and_expansion_work",
           "[lua][platform][camp][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    std::string error;

    basecamp assigned( "Assigned Worker Removal", tripoint_abs_omt{ 145, 145, 0 } );
    assigned.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 99601 ), owner, assigned.camp_omt_pos() );
    REQUIRE( assigned.assign_exact_worker( worker ) );
    CHECK_FALSE( assigned.platform_can_remove( error ) );
    CHECK( error.find( "assigned workers" ) != std::string::npos );

    basecamp pending( "Pending Task Removal", tripoint_abs_omt{ 146, 146, 0 } );
    pending.set_owner( owner );
    basecamp_platform_task pending_task = make_platform_test_task(
                                               pending, owner, character_id( 99602 ),
                                               *worker );
    REQUIRE( pending.platform_create_task( pending_task, error ) );
    CHECK_FALSE( pending.platform_can_remove( error ) );
    CHECK( error.find( "task" ) != std::string::npos );

    basecamp expansion_work( "Expansion Work Removal", tripoint_abs_omt{ 147, 147, 0 } );
    expansion_work.set_owner( owner );
    expansion_work.define_camp(
        expansion_work.camp_omt_pos(), "faction_base_bare_bones_basecamp_0", false );
    expansion_work.update_in_progress(
        "faction_base_bare_bones_basecamp_0", base_camps::base_dir );
    CHECK_FALSE( expansion_work.platform_can_remove( error ) );
    CHECK( error.find( "expansion work" ) != std::string::npos );

    platform_recipe_task_fixture escrow_fixture(
        "Escrow Removal", tripoint_abs_omt{ 148, 148, 0 }, character_id( 99603 ) );
    REQUIRE( escrow_fixture.start() );
    const basecamp_platform_task running =
        escrow_fixture.camp.platform_task_snapshot().front();
    REQUIRE( escrow_fixture.camp.platform_finish_task(
                 running.task_id, running.identity_generation, escrow_fixture.worker,
                 calendar::turn_zero, false, running.recipe_escrow, error ) );
    CHECK_FALSE( escrow_fixture.worker->assigned_camp );
    CHECK_FALSE( escrow_fixture.camp.platform_can_remove( error ) );
    CHECK( error.find( "task" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_remove_retires_exact_camp_identity_after_preflight",
           "[lua][platform][camp][identity]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt position{ 150, 150, 0 };
    const std::unique_ptr<overmap> local_overmap =
        std::make_unique<overmap>( project_to<coords::om>( position.xy() ) );
    basecamp seed( "Removable Platform Camp", position );
    seed.set_owner( owner );
    local_overmap->add_camp( position.xy(), seed );
    const std::optional<basecamp *> found = local_overmap->find_camp( position.xy() );
    REQUIRE( found.has_value() );
    basecamp *camp = *found;
    REQUIRE( camp != nullptr );
    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 122 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_camp( *camp, {}, runtime, 32 );
    const std::uint64_t stable_id = camp->platform_id();

    std::string error;
    REQUIRE( camp->platform_can_remove( error ) );
    local_overmap->remove_camp( position.xy() );
    CHECK_FALSE( local_overmap->find_camp( position.xy() ) );
    CHECK( handle.validation_error( runtime, 32 ) );
    CHECK( handle.locator().stable_id == static_cast<std::int64_t>( stable_id ) );
}

#endif // CATA_ENABLE_LUA_PLATFORM
