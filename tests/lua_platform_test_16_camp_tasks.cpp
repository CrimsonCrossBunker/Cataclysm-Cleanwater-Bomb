#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_camp_task_registry_dispatches_each_lifecycle_operation",
           "[lua][platform][camp][tasks]" )
{
    const basecamp_platform_task_kind_executor *executor =
        find_basecamp_platform_task_executor( basecamp_platform_worker_reservation_kind );
    REQUIRE( executor != nullptr );
    REQUIRE( executor->dispatch != nullptr );
    CHECK( executor->supports_preflight );
    CHECK( executor->supports_resolve );
    CHECK( executor->supports_start );
    CHECK( executor->supports_cancel );
    CHECK( executor->supports_complete );

    basecamp_platform_task task;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    basecamp_platform_task_execution_context context;
    context.task = &task;
    std::string error;
    CHECK( dispatch_basecamp_platform_task(
               task.kind, basecamp_platform_task_operation::preflight, context, error ) );
    CHECK( error.empty() );
    CHECK_FALSE( dispatch_basecamp_platform_task(
                     "legacy_ui_task", basecamp_platform_task_operation::preflight,
                     context, error ) );
    CHECK( error.find( "unsupported" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_task_save_load_defers_actor_reconciliation",
           "[lua][platform][camp][tasks][serialization]" )
{
    const faction_id owner_id( "your_followers" );
    basecamp original( "Persisted Task Camp", tripoint_abs_omt{ 18, 18, 0 } );
    original.set_owner( owner_id );

    const npc_ptr worker = make_shared_fast<npc>();
    worker->normalize();
    worker->setID( character_id( 9302 ), true );
    worker->set_fac( owner_id );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 72 );
    constexpr std::size_t world_generation = 24;
    const cata::lua_platform::game_handle old_camp_handle =
        cata::lua_platform::game_handle::from_camp( original, {}, runtime, world_generation );
    const cata::lua_platform::game_handle old_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), {}, runtime, world_generation );
    const cata::lua_platform::game_handle old_worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *worker, {}, runtime, world_generation );

    basecamp_platform_task task;
    task.camp_id = original.platform_id();
    task.owner_faction = owner_id;
    task.manager = get_avatar().getID();
    task.manager_identity_generation = 0;
    task.worker = worker->getID();
    task.worker_identity_generation = worker->platform_identity_generation();
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( original.platform_create_task( task, error ) );
    REQUIRE( original.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 10_turns, error ) );

    const basecamp_platform_task running = original.platform_task_snapshot().front();
    REQUIRE( running.state == basecamp_platform_task_state::running );
    const cata::lua_platform::camp_task_token old_token(
        running.task_id, running.identity_generation, old_camp_handle, old_manager_handle,
        old_worker_handle, running.manager_identity_generation,
        running.worker_identity_generation, runtime, world_generation );

    const auto save_camp = []( basecamp &camp ) {
        std::ostringstream saved;
        JsonOut json( saved );
        camp.serialize( json );
        return saved.str();
    };
    const std::string saved_before_unload = save_camp( original );
    CHECK_FALSE( saved_before_unload.empty() );

    // This is the same release-only boundary used by npc::on_unload(): the
    // durable running record remains while its ephemeral reservation is gone.
    original.platform_release_worker_reservation( *worker );
    CHECK( original.platform_task_snapshot().front().awaiting_reconciliation );
    CHECK( original.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::running );
    cata::lua_platform::retire_npc_handle_identity( *worker );
    cata::lua_platform::retire_camp_handle_identity( original );
    const std::string saved_after_unload = save_camp( original );

    std::ostringstream saved;
    saved << saved_after_unload;

    basecamp restored;
    const JsonValue saved_value = json_loader::from_string( saved.str() );
    restored.deserialize( saved_value.get_object() );
    const std::vector<basecamp_platform_task> loaded = restored.platform_task_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().state == basecamp_platform_task_state::running );
    CHECK( loaded.front().awaiting_reconciliation );

    const basecamp_platform_actor_lookup unknown_lookup =
        []( const character_id ) {
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::unknown, nullptr
            };
        };
    CHECK( restored.platform_reconcile_task_reservations( unknown_lookup, error ) );
    CHECK( restored.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::running );
    CHECK( restored.platform_task_snapshot().front().awaiting_reconciliation );

    const npc_ptr reloaded_worker = make_shared_fast<npc>();
    reloaded_worker->normalize();
    reloaded_worker->setID( worker->getID(), true );
    reloaded_worker->set_fac( owner_id );
    cata::lua_platform::register_npc_handle_identity( *reloaded_worker );
    const std::uint64_t reloaded_generation =
        reloaded_worker->platform_identity_generation();
    CHECK( reloaded_generation != running.worker_identity_generation );

    const basecamp_platform_actor_lookup found_lookup =
        [reloaded_worker]( const character_id id ) {
            if( id == reloaded_worker->getID() ) {
                return basecamp_platform_actor_lookup_result{
                    basecamp_platform_actor_lookup_status::found, reloaded_worker
                };
            }
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::unknown, nullptr
            };
        };
    // This models the found branch of npc::on_load(): the producer publishes
    // the new actor lifetime, then asks the persisted camp record to bind it.
    const auto on_load_reconcile = [&]() {
        return restored.platform_reconcile_task_reservations( found_lookup, error );
    };
    CHECK( on_load_reconcile() );
    const basecamp_platform_task rebound = restored.platform_task_snapshot().front();
    CHECK( rebound.state == basecamp_platform_task_state::running );
    CHECK_FALSE( rebound.awaiting_reconciliation );
    CHECK( rebound.worker_identity_generation == reloaded_generation );
    CHECK( restored.has_exact_worker( *reloaded_worker ) );
    CHECK( reloaded_worker->assigned_camp );
    CHECK( *reloaded_worker->assigned_camp == restored.camp_omt_pos() );

    const std::optional<cata::lua_platform::game_handle_error> old_error =
        old_token.worker_handle().validation_error( runtime, world_generation );
    REQUIRE( old_error );
    CHECK( old_error->code == "stale_identity" );

    const cata::lua_platform::game_handle new_camp_handle =
        cata::lua_platform::game_handle::from_camp( restored, {}, runtime, world_generation );
    const cata::lua_platform::game_handle new_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), {}, runtime, world_generation );
    const cata::lua_platform::game_handle new_worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *reloaded_worker, {}, runtime, world_generation );
    const cata::lua_platform::camp_task_token new_token(
        rebound.task_id, rebound.identity_generation, new_camp_handle, new_manager_handle,
        new_worker_handle, rebound.manager_identity_generation,
        rebound.worker_identity_generation, runtime, world_generation );
    CHECK( new_token.belongs_to( runtime ) );
    CHECK( new_token.matches_context(
               new_camp_handle, new_manager_handle, new_worker_handle ) );
    CHECK_FALSE( new_worker_handle.validation_error( runtime, world_generation ) );
    CHECK_FALSE( new_camp_handle.validation_error( runtime, world_generation ) );
}

TEST_CASE( "lua_platform_camp_task_reconcile_lookup_states_fail_closed",
           "[lua][platform][camp][tasks][serialization]" )
{
    const auto make_task = []( basecamp &camp, const faction_id &owner,
                               const int manager_id, const int worker_id ) {
        basecamp_platform_task task;
        task.camp_id = camp.platform_id();
        task.owner_faction = owner;
        task.manager = character_id( manager_id );
        task.worker = character_id( worker_id );
        task.manager_identity_generation = 1;
        task.worker_identity_generation = 1;
        task.kind = std::string( basecamp_platform_worker_reservation_kind );
        return task;
    };

    const faction_id owner( "lookup_state_owner" );
    basecamp ambiguous_camp( "Ambiguous Lookup Camp", tripoint_abs_omt{ 24, 24, 0 } );
    ambiguous_camp.set_owner( owner );
    basecamp_platform_task ambiguous_task = make_task( ambiguous_camp, owner, 9901, 9902 );
    std::string error;
    REQUIRE( ambiguous_camp.platform_create_task( ambiguous_task, error ) );
    const basecamp_platform_actor_lookup ambiguous_lookup =
        []( const character_id ) {
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::ambiguous, nullptr
            };
        };
    CHECK_FALSE( ambiguous_camp.platform_reconcile_task_reservations(
                     ambiguous_lookup, error ) );
    CHECK( ambiguous_camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::cancelled );

    basecamp orphan_camp( "Authoritative Absence Camp", tripoint_abs_omt{ 25, 25, 0 } );
    orphan_camp.set_owner( owner );
    basecamp_platform_task orphan_task = make_task( orphan_camp, owner, 9911, 9912 );
    REQUIRE( orphan_camp.platform_create_task( orphan_task, error ) );
    const basecamp_platform_actor_lookup authoritative_not_found_lookup =
        []( const character_id ) {
            return basecamp_platform_actor_lookup_result{
                basecamp_platform_actor_lookup_status::authoritative_not_found, nullptr
            };
        };
    CHECK_FALSE( orphan_camp.platform_reconcile_task_reservations(
                     authoritative_not_found_lookup, error ) );
    CHECK( orphan_camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::cancelled );
}

TEST_CASE( "lua_platform_camp_task_token_binds_runtime_context_and_generation",
           "[lua][platform][camp][tasks]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 70 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 70 );
    basecamp camp( "Task Token Camp", tripoint_abs_omt{ 26, 26, 0 } );
    basecamp other_camp( "Other Task Token Camp", tripoint_abs_omt{ 27, 27, 0 } );
    npc manager;
    manager.normalize();
    manager.setID( character_id( 9701 ), true );
    npc worker;
    worker.normalize();
    worker.setID( character_id( 9702 ), true );
    npc other_manager;
    other_manager.normalize();
    other_manager.setID( character_id( 9703 ), true );
    npc other_worker;
    other_worker.normalize();
    other_worker.setID( character_id( 9704 ), true );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 19 );
    const cata::lua_platform::game_handle other_camp_handle =
        cata::lua_platform::game_handle::from_camp( other_camp, {}, runtime, 19 );
    const cata::lua_platform::game_handle manager_handle =
        cata::lua_platform::game_handle::from_creature(
            manager, { "npc", manager.getID().get_value(), 0, 0, 0, {} }, runtime, 19 );
    const cata::lua_platform::game_handle worker_handle =
        cata::lua_platform::game_handle::from_creature(
            worker, { "npc", worker.getID().get_value(), 0, 0, 0, {} }, runtime, 19 );
    const cata::lua_platform::game_handle other_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            other_manager, { "npc", other_manager.getID().get_value(), 0, 0, 0, {} },
            runtime, 19 );
    const cata::lua_platform::game_handle other_worker_handle =
        cata::lua_platform::game_handle::from_creature(
            other_worker, { "npc", other_worker.getID().get_value(), 0, 0, 0, {} },
            runtime, 19 );
    const cata::lua_platform::camp_task_token token(
        1, 2, camp_handle, manager_handle, worker_handle, 3, 4, runtime, 19 );

    CHECK( token.belongs_to( runtime ) );
    CHECK_FALSE( token.belongs_to( other_runtime ) );
    CHECK( token.matches_context( camp_handle, manager_handle, worker_handle ) );
    CHECK_FALSE( token.matches_context(
                    other_camp_handle, manager_handle, worker_handle ) );
    CHECK_FALSE( token.matches_context(
                    camp_handle, other_manager_handle, worker_handle ) );
    CHECK_FALSE( token.matches_context(
                    camp_handle, manager_handle, other_worker_handle ) );
    CHECK( token.identity_generation() == 2 );
    CHECK( token.manager_identity_generation() == 3 );
    CHECK( token.worker_identity_generation() == 4 );
}

TEST_CASE( "lua_platform_camp_task_camp_retirement_is_terminal",
           "[lua][platform][camp][tasks]" )
{
    const faction_id owner_id( "platform_task_camp_owner" );
    basecamp camp( "Retirement Camp", tripoint_abs_omt{ 19, 19, 0 } );
    camp.set_owner( owner_id );
    cata::lua_platform::register_camp_handle_identity( camp );

    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner_id;
    task.manager = character_id( 9401 );
    task.worker = character_id( 9402 );
    task.worker_identity_generation = 1;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );

    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 71 );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 20 );
    camp.platform_retire_tasks_for_camp();
    REQUIRE( camp.platform_task_snapshot().front().state ==
             basecamp_platform_task_state::cancelled );

    cata::lua_platform::retire_camp_handle_identity( camp );
    const std::optional<cata::lua_platform::game_handle_error> stale =
        handle.validation_error( runtime, 20 );
    REQUIRE( stale );
    CHECK( stale->code == "stale_camp" );
}

TEST_CASE( "lua_platform_camp_task_unload_releases_reservation_without_cancelling_record",
           "[lua][platform][camp][tasks][npc]" )
{
    const faction_id owner_id( "no_faction" );
    basecamp camp( "Unload Camp", tripoint_abs_omt{ 20, 20, 0 } );
    camp.set_owner( owner_id );
    npc_ptr worker = make_shared_fast<npc>();
    worker->normalize();
    worker->setID( character_id( 9502 ), true );

    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner_id;
    task.manager = character_id( 9501 );
    task.worker = worker->getID();
    task.worker_identity_generation = worker->platform_identity_generation();
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );
    REQUIRE( camp.has_exact_worker( *worker ) );

    camp.platform_release_worker_reservation( *worker );
    const basecamp_platform_task loaded = camp.platform_task_snapshot().front();
    CHECK( loaded.state == basecamp_platform_task_state::running );
    CHECK( loaded.awaiting_reconciliation );
    CHECK_FALSE( worker->assigned_camp );
    CHECK_FALSE( camp.has_exact_worker( *worker ) );
}

TEST_CASE( "lua_platform_camp_task_duplicate_start_keeps_staged_state_unchanged",
           "[lua][platform][camp][tasks]" )
{
    const faction_id owner_id( "platform_task_rollback_owner" );
    basecamp camp( "Rollback Camp", tripoint_abs_omt{ 21, 21, 0 } );
    camp.set_owner( owner_id );
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = owner_id;
    task.manager = character_id( 9601 );
    task.worker = character_id( 9602 );
    task.worker_identity_generation = 1;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );

    CHECK_FALSE( camp.platform_start_task(
                     task.task_id, task.identity_generation, nullptr,
                     calendar::turn_zero, 1_turns, error ) );
    const std::vector<basecamp_platform_task> after_rejection =
        camp.platform_task_snapshot();
    REQUIRE( after_rejection.size() == 1 );
    CHECK( after_rejection.front().state == basecamp_platform_task_state::pending );
    CHECK( after_rejection.front().identity_generation == 1 );

    basecamp_platform_task duplicate = task;
    duplicate.task_id = 0;
    CHECK_FALSE( camp.platform_create_task( duplicate, error ) );
    CHECK( camp.platform_task_snapshot().size() == 1 );
}

TEST_CASE( "lua_platform_camp_task_owner_change_retires_old_records",
           "[lua][platform][camp][tasks]" )
{
    const faction_id old_owner( "platform_task_old_owner" );
    const faction_id new_owner( "platform_task_new_owner" );
    basecamp camp( "Owner Boundary Camp", tripoint_abs_omt{ 22, 22, 0 } );
    camp.set_owner( old_owner );
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = old_owner;
    task.manager = character_id( 9701 );
    task.worker = character_id( 9702 );
    task.worker_identity_generation = 1;
    task.kind = std::string( basecamp_platform_worker_reservation_kind );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );

    camp.set_owner( new_owner );
    const basecamp_platform_task retired = camp.platform_task_snapshot().front();
    CHECK( retired.state == basecamp_platform_task_state::cancelled );
    CHECK( retired.identity_generation == 2 );
}

TEST_CASE( "lua_platform_camp_task_unsupported_kind_and_schema_fail_closed",
           "[lua][platform][camp][tasks]" )
{
    std::string error;
    CHECK_FALSE( validate_basecamp_platform_task_kind(
                     "legacy_camp_mission", "{}",
                     basecamp_platform_task_operation::preflight, error ) );
    CHECK( error.find( "unsupported" ) != std::string::npos );

    basecamp camp( "Unsupported Task Camp", tripoint_abs_omt{ 23, 23, 0 } );
    camp.set_owner( faction_id( "platform_task_schema_owner" ) );
    basecamp_platform_task task;
    task.camp_id = camp.platform_id();
    task.owner_faction = camp.get_owner();
    task.manager = character_id( 9801 );
    task.worker = character_id( 9802 );
    task.worker_identity_generation = 1;
    task.kind = "unsupported_kind";
    CHECK_FALSE( camp.platform_create_task( task, error ) );
    CHECK( camp.platform_task_snapshot().empty() );
}

TEST_CASE( "lua_platform_camp_task_npc_die_retires_terminal_record",
           "[lua][platform][camp][tasks][npc][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    platform_test_camp_scope camp_scope(
        "NPC Death Task Camp", tripoint_abs_omt{ 100, 100, 0 }, owner );
    REQUIRE( camp_scope.camp != nullptr );

    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9811 ), owner, camp_scope.position );
    overmap_buffer.insert_npc( worker );
    basecamp_platform_task task = make_platform_test_task(
                                      *camp_scope.camp, owner, get_avatar().getID(), *worker );
    std::string error;
    REQUIRE( camp_scope.camp->platform_create_task( task, error ) );

    worker->quiet_death = true;
    worker->spawn_corpse = false;
    worker->die( &get_map(), nullptr );

    REQUIRE( worker->is_dead() );
    const basecamp_platform_task retired =
        camp_scope.camp->platform_task_snapshot().front();
    CHECK( retired.state == basecamp_platform_task_state::cancelled );
    CHECK( retired.identity_generation == task.identity_generation + 1 );
    CHECK_FALSE( worker->assigned_camp );
    CHECK( overmap_buffer.remove_npc( worker->getID() ) );
}

TEST_CASE( "lua_platform_camp_task_same_stable_id_replacement_is_terminal",
           "[lua][platform][camp][tasks][npc][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    platform_test_camp_scope camp_scope(
        "NPC Replacement Task Camp", tripoint_abs_omt{ 101, 101, 0 }, owner );
    REQUIRE( camp_scope.camp != nullptr );

    const character_id stable_id( 9821 );
    const npc_ptr original = make_platform_test_npc(
                                 stable_id, owner, camp_scope.position );
    overmap_buffer.insert_npc( original );
    basecamp_platform_task task = make_platform_test_task(
                                      *camp_scope.camp, owner, get_avatar().getID(), *original );
    std::string error;
    REQUIRE( camp_scope.camp->platform_create_task( task, error ) );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 73 );
    const cata::lua_platform::game_handle old_handle =
        cata::lua_platform::game_handle::from_creature(
            *original, { "npc", stable_id.get_value(), 0, 0, 0, {} }, runtime, 25 );

    const npc_ptr replacement = make_platform_test_npc(
                                    stable_id, owner, camp_scope.position );
    overmap_buffer.insert_npc( replacement );

    const basecamp_platform_task retired =
        camp_scope.camp->platform_task_snapshot().front();
    CHECK( retired.state == basecamp_platform_task_state::cancelled );
    CHECK( retired.identity_generation == task.identity_generation + 1 );
    const std::optional<cata::lua_platform::game_handle_error> stale =
        old_handle.validation_error( runtime, 25 );
    REQUIRE( stale );
    CHECK( stale->code == "stale_identity" );
    CHECK( overmap_buffer.remove_npc( stable_id ) );
}

TEST_CASE( "lua_platform_camp_task_cancel_retires_generation",
           "[lua][platform][camp][tasks][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Cancel Generation Camp", tripoint_abs_omt{ 102, 102, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9831 ), owner, camp.camp_omt_pos() );
    basecamp_platform_task task = make_platform_test_task(
                                      camp, owner, character_id( 9832 ), *worker );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    const std::uint64_t old_generation = task.identity_generation;

    REQUIRE( camp.platform_finish_task(
                 task.task_id, old_generation, worker, calendar::turn_zero, false, error ) );
    const basecamp_platform_task cancelled = camp.platform_task_snapshot().front();
    CHECK( cancelled.state == basecamp_platform_task_state::cancelled );
    CHECK( cancelled.identity_generation == old_generation + 1 );
    CHECK_FALSE( camp.platform_finish_task(
                     task.task_id, old_generation, worker, calendar::turn_zero, false, error ) );
}

TEST_CASE( "lua_platform_camp_task_complete_retires_generation",
           "[lua][platform][camp][tasks][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Complete Generation Camp", tripoint_abs_omt{ 103, 103, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9841 ), owner, camp.camp_omt_pos() );
    basecamp_platform_task task = make_platform_test_task(
                                      camp, owner, character_id( 9842 ), *worker );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );
    const basecamp_platform_task running = camp.platform_task_snapshot().front();
    const std::uint64_t old_generation = running.identity_generation;

    REQUIRE( camp.platform_finish_task(
                 running.task_id, old_generation, worker,
                 calendar::turn_zero + 2_turns, true, error ) );
    const basecamp_platform_task completed = camp.platform_task_snapshot().front();
    CHECK( completed.state == basecamp_platform_task_state::completed );
    CHECK( completed.identity_generation == old_generation + 1 );
    CHECK_FALSE( worker->assigned_camp );
    CHECK_FALSE( camp.platform_finish_task(
                     running.task_id, old_generation, worker,
                     calendar::turn_zero + 2_turns, true, error ) );
}

#endif // CATA_ENABLE_LUA_PLATFORM
