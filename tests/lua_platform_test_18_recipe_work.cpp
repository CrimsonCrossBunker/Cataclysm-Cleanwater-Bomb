#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_recipe_item_staging_is_atomic_and_rejects_double_spend",
           "[lua][platform][camp][tasks][recipe_work][items]" )
{
    avatar source;
    source.normalize();
    source.setID( character_id( 99501 ), true );
    item charge_stack( itype_id( "tinder" ), calendar::turn_zero );
    charge_stack.charges = 8;
    item &added_stack = source.inv->add_item(
                            std::move( charge_stack ), false, false, false );
    item_location location( source, &added_stack );
    REQUIRE( static_cast<bool>( location ) );
    item *live_stack = location.get_item();
    REQUIRE( live_stack != nullptr );
    const std::int64_t stack_uid = live_stack->uid().get_value();

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 95 );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            source, { "character", source.getID().get_value(), 0, 0, 0, {} },
            runtime, 1 );
    const cata::lua_platform::game_handle item_handle =
        cata::lua_platform::game_handle::from_item(
            *live_stack, { "character_inventory", stack_uid, 0, 0, 0, {} }, runtime, 1 );

    sol::state lua;
    const sol::table holder = make_platform_recipe_holder_table( lua, character_handle );
    const cata::lua_platform::platform_recipe_item_request request = {
        item_handle, holder, 3, false
    };
    const std::vector<cata::lua_platform::platform_recipe_item_request> duplicate_requests = {
        request, request
    };
    std::vector<basecamp_platform_recipe_escrow_item> staged;
    cata::lua_platform::platform_recipe_item_transaction transaction;
    const std::optional<cata::lua_platform::game_handle_error> duplicate_error =
        cata::lua_platform::stage_platform_recipe_items(
            duplicate_requests, runtime, 1, staged, transaction );
    REQUIRE( duplicate_error );
    CHECK( duplicate_error->code == "duplicate_item" );
    CHECK( staged.empty() );
    CHECK( live_stack->charges == 8 );
    CHECK_FALSE( static_cast<bool>( transaction.rollback ) );

    const std::optional<cata::lua_platform::game_handle_error> staged_error =
        cata::lua_platform::stage_platform_recipe_items(
            { request }, runtime, 1, staged, transaction );
    CHECK_FALSE( staged_error );
    REQUIRE( staged.size() == 1 );
    CHECK( staged.front().stable_uid > 0 );
    CHECK( staged.front().stable_uid != stack_uid );
    CHECK( staged.front().charges == 3 );
    CHECK( live_stack->charges == 5 );
    REQUIRE( transaction.rollback_now() );
    CHECK( live_stack->charges == 8 );
}

TEST_CASE( "lua_platform_recipe_work_staging_keeps_nonconsumed_tools_whole",
           "[lua][platform][camp][tasks][recipe_work][items]" )
{
    avatar source;
    source.normalize();
    source.setID( character_id( 99502 ), true );
    item &added_tool = source.inv->add_item(
                           item( itype_id( "rock" ), calendar::turn_zero ),
                           false, false, false );
    item_location location( source, &added_tool );
    REQUIRE( static_cast<bool>( location ) );
    item *live_tool = location.get_item();
    REQUIRE( live_tool != nullptr );
    const std::int64_t tool_uid = live_tool->uid().get_value();

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 96 );
    const cata::lua_platform::game_handle character_handle =
        cata::lua_platform::game_handle::from_creature(
            source, { "character", source.getID().get_value(), 0, 0, 0, {} },
            runtime, 1 );
    const cata::lua_platform::game_handle item_handle =
        cata::lua_platform::game_handle::from_item(
            *live_tool, { "character_inventory", tool_uid, 0, 0, 0, {} }, runtime, 1 );
    sol::state lua;
    const cata::lua_platform::platform_recipe_item_request request = {
        item_handle, make_platform_recipe_holder_table( lua, character_handle ), 1, true
    };
    std::vector<basecamp_platform_recipe_escrow_item> staged;
    cata::lua_platform::platform_recipe_item_transaction transaction;
    CHECK_FALSE( cata::lua_platform::stage_platform_recipe_items(
                     { request }, runtime, 1, staged, transaction ) );
    REQUIRE( staged.size() == 1 );
    CHECK( staged.front().stable_uid == tool_uid );
    CHECK( staged.front().charges == 1 );
    CHECK( staged.front().tool );
    REQUIRE( transaction.rollback_now() );

    bool restored = false;
    std::vector<std::int64_t> restored_uids;
    source.inv->visit_items( [&restored, &restored_uids, tool_uid]( item *candidate, item * ) {
        if( candidate != nullptr ) {
            restored_uids.push_back( candidate->uid().get_value() );
        }
        if( candidate != nullptr && candidate->uid().get_value() == tool_uid ) {
            restored = true;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    CAPTURE( tool_uid, restored_uids );
    CHECK( restored );
}

TEST_CASE( "lua_platform_recipe_work_rejects_invalid_descriptor_and_escrow",
           "[lua][platform][camp][tasks][recipe_work][preflight]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Invalid Shape Camp", tripoint_abs_omt{ 112, 112, 0 }, character_id( 99503 ) );
    std::string error;

    basecamp_platform_recipe_work invalid = fixture.work;
    invalid.batch = 0;
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.batch = 1001;
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.duration_turns = 0;
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.duration_turns = std::numeric_limits<std::int64_t>::max();
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );
    invalid = fixture.work;
    invalid.source_holders.push_back( invalid.source_holders.front() );
    CHECK_FALSE( validate_basecamp_platform_recipe_work( invalid, error ) );

    REQUIRE( fixture.camp.platform_create_task( fixture.task, error ) );
    const basecamp_platform_task pending = fixture.camp.platform_task_snapshot().front();
    const auto rejected_escrow = [&](
        const std::vector<basecamp_platform_recipe_escrow_item> &candidate ) {
        error.clear();
        CHECK_FALSE( fixture.camp.platform_start_task(
                         pending.task_id, pending.identity_generation, fixture.worker,
                         calendar::turn_zero,
                         time_duration::from_turns( fixture.work.duration_turns ), candidate,
                         error ) );
        const basecamp_platform_task unchanged = fixture.camp.platform_task_snapshot().front();
        CHECK( unchanged.state == basecamp_platform_task_state::pending );
        CHECK( unchanged.recipe_escrow.empty() );
        CHECK_FALSE( fixture.worker->assigned_camp );
        CHECK_FALSE( error.empty() );
    };

    std::vector<basecamp_platform_recipe_escrow_item> candidate = fixture.escrow;
    candidate.front().stable_uid = 0;
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.front().charges = 0;
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.front().charges = -1;
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.front().charges = std::numeric_limits<std::int64_t>::max();
    rejected_escrow( candidate );
    candidate = fixture.escrow;
    candidate.push_back( candidate.front() );
    rejected_escrow( candidate );
}

TEST_CASE( "lua_platform_recipe_work_refund_pending_rejects_stale_holder_and_recovers_explicitly",
           "[lua][platform][camp][tasks][recipe_work][recovery]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Refund Recovery Camp", tripoint_abs_omt{ 113, 113, 0 }, character_id( 99504 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    REQUIRE( running.state == basecamp_platform_task_state::running );
    const std::vector<basecamp_platform_recipe_escrow_item> original_escrow =
        running.recipe_escrow;

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 97 );
    constexpr std::size_t world_generation = 1;
    cata::lua_platform::register_camp_handle_identity( fixture.camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp(
            fixture.camp, {}, runtime, world_generation );
    const cata::lua_platform::game_handle manager_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", get_avatar().getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const cata::lua_platform::game_handle worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *fixture.worker,
            { "npc", fixture.worker->getID().get_value(), 0, 0, 0, {} }, runtime,
            world_generation );
    const cata::lua_platform::camp_task_token old_token(
        running.task_id, running.identity_generation, camp_handle, manager_handle,
        worker_handle, running.manager_identity_generation,
        running.worker_identity_generation, runtime, world_generation );

    std::string error;
    REQUIRE( fixture.camp.platform_finish_task(
                 running.task_id, running.identity_generation, fixture.worker,
                 calendar::turn_zero, false, original_escrow, error ) );
    const basecamp_platform_task pending = fixture.camp.platform_task_snapshot().front();
    CHECK( pending.state == basecamp_platform_task_state::refund_pending );
    CHECK( pending.identity_generation == running.identity_generation + 1 );
    CHECK( pending.recipe_escrow.size() == original_escrow.size() );
    CHECK_FALSE( fixture.worker->assigned_camp );

    CHECK_FALSE( fixture.camp.platform_claim_recipe_escrow(
                     pending.task_id, old_token.identity_generation(), calendar::turn_zero,
                     false, original_escrow, error ) );
    CHECK( error.find( "stale" ) != std::string::npos );

    std::vector<basecamp_platform_recipe_escrow_item> stale_holder = pending.recipe_escrow;
    stale_holder.front().source_holder.identity_generation++;
    CHECK_FALSE( fixture.camp.platform_claim_recipe_escrow(
                     pending.task_id, pending.identity_generation, calendar::turn_zero, false,
                     stale_holder, error ) );
    CHECK( error.find( "does not match" ) != std::string::npos );
    CHECK( fixture.camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::refund_pending );
    CHECK( fixture.camp.platform_task_snapshot().front().recipe_escrow.size() ==
           original_escrow.size() );

    std::vector<basecamp_platform_recipe_escrow_item> prepared_refund;
    REQUIRE( fixture.camp.platform_prepare_recipe_refund(
                 pending.task_id, pending.identity_generation, nullptr, prepared_refund,
                 error ) );
    CHECK( prepared_refund.size() == original_escrow.size() );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; },
        []() { return world_generation; }, []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; },
    []() { return world_generation; }, []() {}, []() {} );
    const sol::protected_function resolve = services["camps"]["tasks"]["resolve"];
    const sol::table invalid_destination = make_platform_recipe_holder_table(
                                               lua, cata::lua_platform::game_handle{} );
    const cata::lua_platform::camp_task_token pending_token(
        pending.task_id, pending.identity_generation, camp_handle, manager_handle,
        worker_handle, pending.manager_identity_generation,
        pending.worker_identity_generation, runtime, world_generation );
    const sol::protected_function_result failed = resolve(
            camp_handle, manager_handle, worker_handle, pending_token, invalid_destination );
    REQUIRE( failed.valid() );
    const sol::table failed_envelope = failed.get<sol::table>();
    CHECK_FALSE( failed_envelope["ok"].get<bool>() );
    CHECK( failed_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_kind" );
    CHECK( fixture.camp.platform_task_snapshot().front().state ==
           basecamp_platform_task_state::refund_pending );
    CHECK( fixture.camp.platform_task_snapshot().front().recipe_escrow.size() ==
           original_escrow.size() );

    avatar fallback;
    fallback.normalize();
    fallback.setID( character_id( 99505 ), true );
    const cata::lua_platform::game_handle fallback_handle =
        cata::lua_platform::game_handle::from_creature(
            fallback, { "character", fallback.getID().get_value(), 0, 0, 0, {} },
            runtime, world_generation );
    const sol::table fallback_destination = make_platform_recipe_holder_table(
                                                lua, fallback_handle );
    const sol::protected_function_result recovered = resolve(
            camp_handle, manager_handle, worker_handle, pending_token, fallback_destination );
    REQUIRE( recovered.valid() );
    const sol::table recovered_envelope = recovered.get<sol::table>();
    std::string recovered_error_code;
    std::string recovered_error_message;
    if( !recovered_envelope["ok"].get<bool>() ) {
        const sol::table recovered_error = recovered_envelope["error"];
        recovered_error_code = recovered_error["code"].get<std::string>();
        recovered_error_message = recovered_error["message"].get<std::string>();
    }
    CAPTURE( recovered_error_code, recovered_error_message );
    REQUIRE( recovered_envelope["ok"].get<bool>() );
    const basecamp_platform_task claimed = fixture.camp.platform_task_snapshot().front();
    CHECK( claimed.state == basecamp_platform_task_state::cancelled );
    CHECK( claimed.recipe_escrow.empty() );
    CHECK( claimed.identity_generation == pending.identity_generation + 1 );

    bool found_fallback_item = false;
    const std::int64_t recovered_uid = original_escrow.front().stable_uid;
    fallback.visit_items( [&found_fallback_item, recovered_uid]( item *candidate, item * ) {
        if( candidate != nullptr && candidate->uid().get_value() == recovered_uid ) {
            found_fallback_item = true;
            return VisitResponse::ABORT;
        }
        return VisitResponse::NEXT;
    } );
    CHECK( found_fallback_item );
}

TEST_CASE( "lua_platform_recipe_work_completion_is_authoritative_and_not_repeated",
           "[lua][platform][camp][tasks][recipe_work][completion]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Completion Camp", tripoint_abs_omt{ 114, 114, 0 }, character_id( 99506 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    const std::vector<basecamp_platform_recipe_escrow_item> original_escrow =
        running.recipe_escrow;
    const time_point due = calendar::turn_zero +
                           time_duration::from_turns( fixture.work.duration_turns );
    std::string error;
    const std::vector<basecamp_platform_recipe_escrow_item> empty_settlement;

    CHECK_FALSE( fixture.camp.platform_complete_recipe_task(
                     running.task_id, running.identity_generation, fixture.worker, due,
                     original_escrow, empty_settlement, error ) );
    const basecamp_platform_task after_rejected_completion =
        fixture.camp.platform_task_snapshot().front();
    CHECK( after_rejected_completion.state == basecamp_platform_task_state::running );
    CHECK( after_rejected_completion.recipe_escrow.size() == original_escrow.size() );
    CHECK( after_rejected_completion.recipe_commit_marker == 0 );

    std::vector<basecamp_platform_recipe_escrow_item> settled;
    REQUIRE( fixture.camp.platform_prepare_recipe_completion(
                 running.task_id, running.identity_generation, fixture.worker, due, settled,
                 error ) );
    REQUIRE( !settled.empty() );
    CHECK( std::any_of( settled.begin(), settled.end(), [&original_escrow](
    const basecamp_platform_recipe_escrow_item &candidate ) {
        return std::none_of( original_escrow.begin(), original_escrow.end(),
        [&candidate]( const basecamp_platform_recipe_escrow_item &original ) {
            return original.stable_uid == candidate.stable_uid;
        } );
    } ) );
    REQUIRE( fixture.camp.platform_complete_recipe_task(
                 running.task_id, running.identity_generation, fixture.worker, due,
                 original_escrow, settled, error ) );
    const basecamp_platform_task committed = fixture.camp.platform_task_snapshot().front();
    CHECK( committed.state == basecamp_platform_task_state::completed_unclaimed );
    CHECK( committed.recipe_commit_marker == running.identity_generation );
    CHECK( committed.recipe_escrow.size() == settled.size() );
    CHECK_FALSE( fixture.worker->assigned_camp );

    const std::vector<basecamp_platform_recipe_escrow_item> committed_escrow =
        committed.recipe_escrow;
    CHECK_FALSE( fixture.camp.platform_complete_recipe_task(
                     committed.task_id, committed.identity_generation, fixture.worker, due,
                     original_escrow, settled, error ) );
    CHECK( error.find( "already committed" ) != std::string::npos );
    CHECK_FALSE( fixture.camp.platform_prepare_recipe_completion(
                     committed.task_id, committed.identity_generation, fixture.worker, due,
                     settled, error ) );
    const basecamp_platform_task after_repeat = fixture.camp.platform_task_snapshot().front();
    CHECK( after_repeat.state == basecamp_platform_task_state::completed_unclaimed );
    CHECK( after_repeat.recipe_commit_marker == committed.recipe_commit_marker );
    CHECK( after_repeat.recipe_escrow.size() == committed_escrow.size() );
}

TEST_CASE( "lua_platform_recipe_work_save_load_preserves_valid_and_isolates_invalid_escrow",
           "[lua][platform][camp][tasks][recipe_work][serialization]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Save Load Camp", tripoint_abs_omt{ 115, 115, 0 }, character_id( 99507 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    REQUIRE( !running.recipe_escrow.empty() );

    const auto serialize_camp = []( const basecamp &camp ) {
        std::ostringstream saved;
        JsonOut json( saved );
        camp.serialize( json );
        return saved.str();
    };
    const std::string valid_save = serialize_camp( fixture.camp );
    basecamp restored;
    const JsonValue valid_value = json_loader::from_string( valid_save );
    restored.deserialize( valid_value.get_object() );
    const std::vector<basecamp_platform_task> loaded = restored.platform_task_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().state == basecamp_platform_task_state::running );
    CHECK( loaded.front().awaiting_reconciliation );
    CHECK_FALSE( loaded.front().recipe_recovery_required );
    CHECK( loaded.front().recipe_escrow.size() == running.recipe_escrow.size() );
    CHECK( loaded.front().recipe_escrow.front().stable_uid ==
           running.recipe_escrow.front().stable_uid );

    std::string invalid_save = valid_save;
    const std::string stable_uid_key = "\"stable_uid\":";
    const std::size_t stable_uid_position = invalid_save.find( stable_uid_key );
    REQUIRE( stable_uid_position != std::string::npos );
    const std::size_t value_begin = stable_uid_position + stable_uid_key.size();
    const std::size_t value_end = invalid_save.find( ',', value_begin );
    REQUIRE( value_end != std::string::npos );
    invalid_save.replace( value_begin, value_end - value_begin, "-1" );

    basecamp invalid_restored;
    const JsonValue invalid_value = json_loader::from_string( invalid_save );
    invalid_restored.deserialize( invalid_value.get_object() );
    const std::vector<basecamp_platform_task> isolated =
        invalid_restored.platform_task_snapshot();
    REQUIRE( isolated.size() == 1 );
    REQUIRE( isolated.front().recipe_recovery_required );
    CHECK( isolated.front().state == basecamp_platform_task_state::refund_pending );
    REQUIRE( !isolated.front().recipe_escrow.empty() );

    std::string error;
    std::vector<basecamp_platform_recipe_escrow_item> recovery_escrow;
    REQUIRE( invalid_restored.platform_prepare_recipe_refund(
                 isolated.front().task_id, isolated.front().identity_generation, nullptr,
                 recovery_escrow, error ) );
    REQUIRE( invalid_restored.platform_claim_recipe_escrow(
                 isolated.front().task_id, isolated.front().identity_generation,
                 calendar::turn_zero, false, recovery_escrow, error ) );
    const basecamp_platform_task recovered = invalid_restored.platform_task_snapshot().front();
    CHECK( recovered.state == basecamp_platform_task_state::cancelled );
    CHECK( recovered.recipe_escrow.empty() );
    CHECK_FALSE( recovered.recipe_recovery_required );
}

TEST_CASE( "lua_platform_recipe_work_tokens_reject_stale_actor_camp_and_task_context",
           "[lua][platform][camp][tasks][recipe_work][identity]" )
{
    platform_recipe_task_fixture fixture(
        "Recipe Stale Context Camp", tripoint_abs_omt{ 116, 116, 0 }, character_id( 99508 ) );
    REQUIRE( fixture.start() );
    const basecamp_platform_task running = fixture.camp.platform_task_snapshot().front();
    std::string error;

    const npc_ptr replacement = make_platform_test_npc(
                                    fixture.worker->getID(), fixture.owner,
                                    fixture.camp.camp_omt_pos() );
    cata::lua_platform::register_npc_handle_identity( *replacement );
    std::vector<basecamp_platform_recipe_escrow_item> refund;
    CHECK_FALSE( fixture.camp.platform_prepare_recipe_refund(
                     running.task_id, running.identity_generation, replacement, refund, error ) );
    CHECK( error.find( "exact live worker" ) != std::string::npos );

    const auto runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_runtime_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( runtime_owner, 98 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_runtime_owner, 98 );
    const cata::lua_platform::game_handle worker_handle =
        cata::lua_platform::game_handle::from_creature(
            *fixture.worker,
            { "npc", fixture.worker->getID().get_value(), 0, 0, 0, {} }, runtime, 2 );
    std::optional<cata::lua_platform::game_handle_error> handle_error =
        worker_handle.validation_error( runtime, 3 );
    REQUIRE( handle_error );
    CHECK( handle_error->code == "stale_world" );
    handle_error = worker_handle.validation_error( other_runtime, 2 );
    REQUIRE( handle_error );
    CHECK( handle_error->code == "stale_runtime" );

    cata::lua_platform::register_camp_handle_identity( fixture.camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( fixture.camp, {}, runtime, 2 );
    cata::lua_platform::retire_camp_handle_identity( fixture.camp );
    handle_error = camp_handle.validation_error( runtime, 2 );
    REQUIRE( handle_error );
    CHECK( handle_error->code == "stale_camp" );

    REQUIRE( fixture.camp.platform_mark_recipe_refund_pending(
                 running.task_id, running.identity_generation, error ) );
    const basecamp_platform_task retired = fixture.camp.platform_task_snapshot().front();
    CHECK_FALSE( fixture.camp.platform_mark_recipe_refund_pending(
                     running.task_id, running.identity_generation, error ) );
    CHECK( retired.identity_generation == running.identity_generation + 1 );
    CHECK( retired.state == basecamp_platform_task_state::refund_pending );
}

TEST_CASE( "lua_platform_recipe_work_escrow_refuses_camp_removal_and_clear_until_claimed",
           "[lua][platform][camp][tasks][recipe_work][lifecycle]" )
{
    const faction_id owner( "your_followers" );
    const tripoint_abs_omt position{ 117, 117, 0 };
    const std::unique_ptr<overmap> local_overmap =
        std::make_unique<overmap>( project_to<coords::om>( position.xy() ) );
    basecamp seed( "Recipe Removal Camp", position );
    seed.set_owner( owner );
    local_overmap->add_camp( position.xy(), seed );
    const std::optional<basecamp *> found = local_overmap->find_camp( position.xy() );
    REQUIRE( found.has_value() );
    basecamp *camp = *found;
    REQUIRE( camp != nullptr );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 99509 ), owner, position );
    worker->set_skill_level( skill_id( "survival" ), 10 );
    const recipe &making = recipe_id( "tinder" ).obj();
    worker->learn_recipe( &making, true );
    const basecamp_platform_recipe_holder holder = make_platform_recipe_holder(
        worker->getID(), worker->platform_identity_generation() );
    const std::int64_t duration_turns = to_turns<std::int64_t>(
                                            making.batch_duration( *worker,
                                                    crafting_cost_context::for_recipe( *worker, making ), 1 ) );
    basecamp_platform_task task = make_platform_recipe_work_test_task(
                                      *camp, owner, get_avatar().getID(), *worker, "tinder",
                                      duration_turns );
    task.recipe_work->source_holders = { holder };
    task.recipe_work->destination_holder = holder;
    const std::vector<basecamp_platform_recipe_escrow_item> escrow = {
        make_platform_recipe_escrow_test_item(
            item( itype_id( "stick" ), calendar::turn_zero ), holder ),
        make_platform_recipe_escrow_test_item(
            item( itype_id( "knife_combat" ), calendar::turn_zero ), holder, true )
    };
    std::string error;
    REQUIRE( camp->platform_create_task( task, error ) );
    REQUIRE( camp->platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, time_duration::from_turns( duration_turns ), escrow,
                 error ) );

    CHECK_FALSE( camp->platform_retire_tasks_for_camp() );
    REQUIRE( local_overmap->find_camp( position.xy() ).has_value() );
    local_overmap->clear_camps();
    CHECK( local_overmap->find_camp( position.xy() ).has_value() );

    const basecamp_platform_task running = camp->platform_task_snapshot().front();
    REQUIRE( camp->platform_finish_task(
                 running.task_id, running.identity_generation, worker, calendar::turn_zero,
                 false, running.recipe_escrow, error ) );
    const basecamp_platform_task pending = camp->platform_task_snapshot().front();
    REQUIRE( camp->platform_claim_recipe_escrow(
                 pending.task_id, pending.identity_generation, calendar::turn_zero, false,
                 pending.recipe_escrow, error ) );
    local_overmap->clear_camps();
    CHECK_FALSE( local_overmap->find_camp( position.xy() ) );
}

#endif // CATA_ENABLE_LUA_PLATFORM
