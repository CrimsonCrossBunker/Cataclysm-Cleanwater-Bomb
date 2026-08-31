#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_camp_resource_work_create_keeps_typed_descriptor_detached",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Create Camp", tripoint_abs_omt{ 103, 104, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9845 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.food_input_kcal = 3;
    work.duration_turns = 12;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9846 ), *worker, work );
    std::string error;

    REQUIRE( camp.platform_create_task( task, error ) );
    const std::vector<basecamp_platform_task> created = camp.platform_task_snapshot();
    REQUIRE( created.size() == 1 );
    REQUIRE( created.front().resource_work );
    CHECK( created.front().parameters == basecamp_platform_resource_work_parameter_schema );
    CHECK( created.front().resource_work->food_input_kcal == 3 );
    CHECK( created.front().resource_work->duration_turns == 12 );
    CHECK( created.front().reserved_resources.empty() );
    CHECK( created.front().reserved_food_kcal == 0 );
}

TEST_CASE( "lua_platform_camp_resource_work_descriptor_rejects_invalid_shapes",
           "[lua][platform][camp][tasks][resource_work]" )
{
    basecamp_platform_resource_work valid;
    valid.resource_inputs = { { itype_id( "water" ), 2 } };
    valid.resource_outputs = { { itype_id( "2x4" ), 1 } };
    valid.duration_turns = 10;
    std::string error;
    REQUIRE( validate_basecamp_platform_resource_work( valid, error ) );

    basecamp_platform_resource_work duplicate = valid;
    duplicate.resource_inputs.push_back( { itype_id( "water" ), 1 } );
    CHECK_FALSE( validate_basecamp_platform_resource_work( duplicate, error ) );
    CHECK( error.find( "duplicate" ) != std::string::npos );

    basecamp_platform_resource_work zero_amount = valid;
    zero_amount.resource_inputs.front().delta = 0;
    CHECK_FALSE( validate_basecamp_platform_resource_work( zero_amount, error ) );
    CHECK( error.find( "positive" ) != std::string::npos );

    basecamp_platform_resource_work negative = valid;
    negative.resource_inputs.front().delta = -1;
    CHECK_FALSE( validate_basecamp_platform_resource_work( negative, error ) );
    CHECK( error.find( "positive" ) != std::string::npos );

    basecamp_platform_resource_work zero_effect;
    zero_effect.duration_turns = 10;
    CHECK_FALSE( validate_basecamp_platform_resource_work( zero_effect, error ) );
    CHECK( error.find( "non-zero" ) != std::string::npos );

    basecamp_platform_resource_work overflow = valid;
    overflow.resource_outputs.front().delta = 1000000001;
    CHECK_FALSE( validate_basecamp_platform_resource_work( overflow, error ) );
    CHECK( error.find( "bounded" ) != std::string::npos );

    basecamp_platform_resource_work invalid_duration = valid;
    invalid_duration.duration_turns = 0;
    CHECK_FALSE( validate_basecamp_platform_resource_work( invalid_duration, error ) );
    CHECK( error.find( "duration" ) != std::string::npos );

    basecamp_platform_resource_work zero_food = valid;
    zero_food.food_input_kcal = 0;
    CHECK_FALSE( validate_basecamp_platform_resource_work( zero_food, error ) );
    CHECK( error.find( "positive" ) != std::string::npos );

    CHECK_FALSE( validate_basecamp_platform_task_kind(
                     "unsupported_resource_work", "resource_work_v1",
                     basecamp_platform_task_operation::preflight, error ) );
    CHECK( error.find( "unsupported" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_resource_work_start_reserves_inputs_and_blocks_double_spend",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Reservation Camp", tripoint_abs_omt{ 104, 104, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9851 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 3 } };
    work.resource_outputs = { { itype_id( "2x4" ), 2 } };
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9852 ), *worker, work );

    std::vector<basecamp_platform_task> staged_tasks = { task };
    std::vector<npc_ptr> staged_assigned;
    std::vector<basecamp_resource> staged_resources = {
        { itype_id( "water" ), itype_id(), 5, 0 },
        { itype_id( "2x4" ), itype_id(), 0, 0 },
    };
    basecamp_platform_task_execution_context context;
    context.camp = &camp;
    context.task = &staged_tasks.front();
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.now = calendar::turn_zero;
    context.duration = 1_turns;
    std::string error;

    REQUIRE( dispatch_basecamp_platform_task(
                 task.kind, basecamp_platform_task_operation::preflight, context, error ) );
    REQUIRE( dispatch_basecamp_platform_task(
                 task.kind, basecamp_platform_task_operation::start, context, error ) );
    CHECK( staged_tasks.front().state == basecamp_platform_task_state::running );
    REQUIRE( staged_tasks.front().reserved_resources.size() == 1 );
    CHECK( staged_tasks.front().reserved_resources.front().delta == 3 );
    CHECK( staged_resources.front().available == 2 );
    CHECK( context.commit_worker_assignment );

    const int available_after_reservation = staged_resources.front().available;
    CHECK_FALSE( dispatch_basecamp_platform_task(
                     task.kind, basecamp_platform_task_operation::start, context, error ) );
    CHECK( staged_tasks.front().state == basecamp_platform_task_state::running );
    CHECK( staged_tasks.front().reserved_resources.front().delta == 3 );
    CHECK( staged_resources.front().available == available_after_reservation );
}

TEST_CASE( "lua_platform_camp_resource_work_reservation_liability_has_a_bounded_capacity",
           "[lua][platform][camp][tasks][resource_work][capacity]" )
{
    Character &avatar = get_avatar();
    REQUIRE( avatar.get_faction() != nullptr );
    REQUIRE( g != nullptr );
    faction *owner_faction = g->faction_manager_ptr->get(
                                  avatar.get_faction()->id, false );
    REQUIRE( owner_faction != nullptr );
    platform_food_state_scope food_scope( *owner_faction );
    owner_faction->empty_food_supply();
    owner_faction->consumes_food = true;

    // This is the Platform resource-work bound, expressed in the native
    // micro-calorie representation used by faction food storage.
    constexpr std::int64_t maximum_food_kcal = 1000000000;
    nutrients initial_food;
    initial_food.calories = maximum_food_kcal * 1000;
    owner_faction->add_to_food_supply( { { calendar::turn_zero, initial_food } } );

    const faction_id owner_id = avatar.get_faction()->id;
    basecamp camp( "Resource Work Liability Camp", tripoint_abs_omt{ 104, 105, 0 } );
    camp.set_owner( owner_id );
    const npc_ptr first_worker = make_platform_test_npc(
                                     character_id( 9853 ), owner_id, camp.camp_omt_pos() );
    const npc_ptr second_worker = make_platform_test_npc(
                                      character_id( 9854 ), owner_id, camp.camp_omt_pos() );
    basecamp_platform_resource_work first_work;
    first_work.food_input_kcal = maximum_food_kcal;
    first_work.duration_turns = 1;
    basecamp_platform_task first_task = make_platform_resource_work_test_task(
        camp, owner_id, avatar.getID(), *first_worker, first_work );
    basecamp_platform_resource_work second_work;
    second_work.food_input_kcal = 1;
    second_work.duration_turns = 1;
    basecamp_platform_task second_task = make_platform_resource_work_test_task(
        camp, owner_id, avatar.getID(), *second_worker, second_work );
    std::string error;

    REQUIRE( camp.platform_create_task( first_task, error ) );
    REQUIRE( camp.platform_start_task(
                 first_task.task_id, first_task.identity_generation, first_worker,
                 calendar::turn_zero, 1_turns, error ) );
    nutrients replenished_food;
    replenished_food.calories = 1000;
    owner_faction->add_to_food_supply(
        { { calendar::turn_zero, replenished_food } } );
    REQUIRE( camp.platform_create_task( second_task, error ) );
    REQUIRE( camp.platform_start_task(
                 second_task.task_id, second_task.identity_generation, second_worker,
                 calendar::turn_zero, 1_turns, error ) );

    std::vector<basecamp_platform_resource_change> liability;
    std::int64_t food_liability = 0;
    CHECK_FALSE( camp.platform_reservation_liability(
                     liability, food_liability, error ) );
    CHECK( error.find( "exceeds capacity" ) != std::string::npos );
    CHECK( food_liability == maximum_food_kcal );
}

TEST_CASE( "lua_platform_camp_resource_work_cancel_refunds_reservation_atomically",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Cancel Camp", tripoint_abs_omt{ 105, 105, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9861 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 2 } };
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9862 ), *worker, work );
    task.state = basecamp_platform_task_state::running;
    task.started_at = calendar::turn_zero;
    task.due_at = calendar::turn_zero + 1_turns;
    task.reserved_resources = work.resource_inputs;

    std::vector<basecamp_platform_task> staged_tasks = { task };
    std::vector<npc_ptr> staged_assigned = { worker };
    std::vector<basecamp_resource> staged_resources = {
        { itype_id( "water" ), itype_id(), 3, 0 },
    };
    worker->assigned_camp = camp.camp_omt_pos();
    basecamp_platform_task_execution_context context;
    context.camp = &camp;
    context.task = &staged_tasks.front();
    context.worker = worker;
    context.staged_tasks = &staged_tasks;
    context.staged_assigned = &staged_assigned;
    context.staged_resources = &staged_resources;
    context.now = calendar::turn_zero + 1_turns;
    std::string error;

    REQUIRE( dispatch_basecamp_platform_task(
                 task.kind, basecamp_platform_task_operation::cancel, context, error ) );
    CHECK( staged_resources.front().available == 5 );
    CHECK( staged_tasks.front().state == basecamp_platform_task_state::cancelled );
    CHECK( staged_tasks.front().reserved_resources.empty() );
    CHECK( staged_tasks.front().identity_generation == task.identity_generation + 1 );
    CHECK( context.commit_worker_release );
    worker->assigned_camp.reset();
}

TEST_CASE( "lua_platform_camp_resource_work_complete_is_atomic_and_retryable_on_output_overflow",
           "[lua][platform][camp][tasks][resource_work]" )
{
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Complete Camp", tripoint_abs_omt{ 106, 106, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9871 ), owner, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 2 } };
    work.resource_outputs = { { itype_id( "2x4" ), 2 } };
    work.duration_turns = 1;
    const basecamp_platform_task original = make_platform_resource_work_test_task(
        camp, owner, character_id( 9872 ), *worker, work );
    basecamp_platform_task running = original;
    running.state = basecamp_platform_task_state::running;
    running.started_at = calendar::turn_zero;
    running.due_at = calendar::turn_zero + 1_turns;
    running.reserved_resources = work.resource_inputs;

    const auto finish = [&]( basecamp_platform_task &task,
                             std::vector<basecamp_resource> &resources ) {
        std::vector<basecamp_platform_task> staged_tasks = { task };
        std::vector<npc_ptr> staged_assigned = { worker };
        std::vector<basecamp_resource> staged_resources = resources;
        basecamp_platform_task_execution_context context;
        context.camp = &camp;
        context.task = &staged_tasks.front();
        context.worker = worker;
        context.staged_tasks = &staged_tasks;
        context.staged_assigned = &staged_assigned;
        context.staged_resources = &staged_resources;
        context.now = calendar::turn_zero + 1_turns;
        context.complete = true;
        worker->assigned_camp = camp.camp_omt_pos();
        std::string error;
        const bool completed = dispatch_basecamp_platform_task(
                                   task.kind, basecamp_platform_task_operation::complete,
                                   context, error );
        task = staged_tasks.front();
        if( completed ) {
            resources.swap( staged_resources );
            CHECK( task.state == basecamp_platform_task_state::completed );
            CHECK( task.reserved_resources.empty() );
            CHECK( resources.back().available == 2 );
        } else {
            CHECK( task.state == basecamp_platform_task_state::running );
            REQUIRE( task.reserved_resources.size() == work.resource_inputs.size() );
            CHECK( task.reserved_resources.front().resource_id ==
                   work.resource_inputs.front().resource_id );
            CHECK( task.reserved_resources.front().delta ==
                   work.resource_inputs.front().delta );
            CHECK( resources.front().available == 3 );
            CHECK( resources.front().consumed == 0 );
        }
        worker->assigned_camp.reset();
        return completed;
    };

    std::vector<basecamp_resource> overflow_resources = {
        { itype_id( "water" ), itype_id(), 3, 0 },
        { itype_id( "2x4" ), itype_id(), std::numeric_limits<int>::max(), 0 },
    };
    CHECK_FALSE( finish( running, overflow_resources ) );
    CHECK( running.state == basecamp_platform_task_state::running );
    REQUIRE( running.reserved_resources.size() == work.resource_inputs.size() );
    CHECK( running.reserved_resources.front().resource_id ==
           work.resource_inputs.front().resource_id );
    CHECK( running.reserved_resources.front().delta ==
           work.resource_inputs.front().delta );

    std::vector<basecamp_resource> retry_resources = {
        { itype_id( "water" ), itype_id(), 3, 0 },
        { itype_id( "2x4" ), itype_id(), 0, 0 },
    };
    CHECK( finish( running, retry_resources ) );
    CHECK( running.state == basecamp_platform_task_state::completed );
    CHECK( running.identity_generation == original.identity_generation + 1 );
}

TEST_CASE( "lua_platform_camp_resource_work_liability_and_food_list_are_persisted",
           "[lua][platform][camp][tasks][resource_work][serialization]" )
{
    const auto write_task_save = []( const bool duplicate_reservation,
                                     const bool include_resource_input ) {
        const faction_id owner( "your_followers" );
        const tripoint_abs_omt position{ 107, 107, 0 };
        std::ostringstream saved;
        JsonOut json( saved );
        json.start_object();
        json.member( "owner", owner );
        json.member( "name", "Resource Work Save Camp" );
        json.member( "pos", position );
        json.member( "platform_id", static_cast<std::uint64_t>( 98701 ) );
        json.member( "platform_tasks_version", basecamp_platform_task_schema_version );
        json.member( "platform_tasks" );
        json.start_array();
        json.start_object();
        json.member( "task_id", static_cast<std::uint64_t>( 98702 ) );
        json.member( "generation", static_cast<std::uint64_t>( 1 ) );
        json.member( "camp_id", static_cast<std::uint64_t>( 98701 ) );
        json.member( "owner_faction", owner );
        json.member( "manager_id", character_id( 98703 ) );
        json.member( "worker_id", character_id( 98704 ) );
        json.member( "manager_identity_generation", static_cast<std::uint64_t>( 0 ) );
        json.member( "worker_identity_generation", static_cast<std::uint64_t>( 1 ) );
        json.member( "kind", std::string( basecamp_platform_resource_work_kind ) );
        json.member( "parameters", std::string( basecamp_platform_resource_work_parameter_schema ) );
        json.member( "state", "running" );
        json.member( "started_at", calendar::turn_zero );
        json.member( "due_at", calendar::turn_zero + 10_turns );
        json.member( "resource_work" );
        json.start_object();
        json.member( "resource_inputs" );
        json.start_array();
        if( include_resource_input ) {
            json.start_object();
            json.member( "id", "water" );
            json.member( "amount", static_cast<std::int64_t>( 2 ) );
            json.end_object();
        }
        json.end_array();
        json.member( "resource_outputs" );
        json.start_array();
        if( include_resource_input ) {
            json.start_object();
            json.member( "id", "2x4" );
            json.member( "amount", static_cast<std::int64_t>( 1 ) );
            json.end_object();
        }
        json.end_array();
        if( !include_resource_input ) {
            json.member( "food_input_kcal", static_cast<std::int64_t>( 4 ) );
        }
        json.member( "duration_turns", static_cast<std::int64_t>( 10 ) );
        json.end_object();
        json.member( "reserved_resources" );
        json.start_array();
        if( include_resource_input ) {
            for( int count = 0; count < ( duplicate_reservation ? 2 : 1 ); ++count ) {
                json.start_object();
                json.member( "id", "water" );
                json.member( "amount", static_cast<std::int64_t>( 2 ) );
                json.end_object();
            }
        }
        json.end_array();
        json.member( "reserved_food_kcal", include_resource_input ? 0 : 4 );
        json.member( "reservation_discarded", false );
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
        return saved.str();
    };

    basecamp restored;
    const JsonValue saved = json_loader::from_string(
                                write_task_save( false, true ) );
    restored.deserialize( saved.get_object() );
    const std::vector<basecamp_platform_task> loaded = restored.platform_task_snapshot();
    REQUIRE( loaded.size() == 1 );
    CHECK( loaded.front().state == basecamp_platform_task_state::running );
    CHECK( loaded.front().resource_work );
    REQUIRE( loaded.front().reserved_resources.size() == 1 );
    CHECK( loaded.front().reserved_resources.front().delta == 2 );

    basecamp food_restored;
    const JsonValue food_saved = json_loader::from_string(
                                     write_task_save( false, false ) );
    food_restored.deserialize( food_saved.get_object() );
    std::vector<basecamp_platform_resource_change> resource_liability;
    std::int64_t food_liability = 0;
    std::string error;
    REQUIRE( food_restored.platform_reservation_liability(
                 resource_liability, food_liability, error ) );
    CHECK( resource_liability.empty() );
    CHECK( food_liability == 4 );

    faction detached_food_owner;
    detached_food_owner.empty_food_supply();
    detached_food_owner.consumes_food = true;
    nutrients detached_food;
    detached_food.calories = 12000;
    detached_food_owner.add_to_food_supply(
        { { calendar::turn_zero, detached_food } } );
    const platform_food_storage saved_food = detached_food_owner.debug_food_supply();
    nutrients consumed_food;
    consumed_food.calories = 5000;
    detached_food_owner.consume_food_supply( consumed_food );
    detached_food_owner.debug_food_supply() = saved_food;
    CHECK( detached_food_owner.food_supply().calories == 12000 );

    basecamp duplicate_restored;
    const JsonValue duplicate_saved = json_loader::from_string(
                                           write_task_save( true, true ) );
    const std::string dmsg = capture_debugmsg_during( [&]() {
        duplicate_restored.deserialize( duplicate_saved.get_object() );
    } );
    CHECK_THAT( dmsg,
                Catch::Matchers::Contains( "Discarding invalid persisted Platform camp task" ) );
    CHECK( duplicate_restored.platform_task_snapshot().empty() );
}

TEST_CASE( "lua_platform_camp_resource_work_equivalent_fake_ids_and_load_order_are_bounded",
           "[lua][platform][camp][tasks][resource_work][serialization]" )
{
    basecamp_resource first;
    first.fake_id = itype_id( "water" );
    first.ammo_id = itype_id( "battery" );
    first.available = 2;
    basecamp_resource equivalent = first;
    equivalent.available = 3;
    std::vector<basecamp_resource> normalized;
    std::string error;
    REQUIRE( basecamp::platform_normalize_resources(
                 { first, equivalent }, normalized, error ) );
    REQUIRE( normalized.size() == 1 );
    CHECK( normalized.front().available == 5 );

    basecamp_resource ambiguous = equivalent;
    ambiguous.ammo_id = itype_id( "2x4" );
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { first, ambiguous }, normalized, error ) );
    CHECK( error.find( "conflicting" ) != std::string::npos );

    // A persisted descriptor is retained before storage resources are rebuilt;
    // reconciliation, not deserialization order, decides whether its fake id
    // is a valid camp resource.
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 1 } };
    work.duration_turns = 1;
    CHECK( validate_basecamp_platform_resource_work( work, error ) );
}

TEST_CASE( "lua_platform_camp_resource_work_terminal_lifecycle_policy_is_explicit",
           "[lua][platform][camp][tasks][resource_work][lifecycle]" )
{
    basecamp_platform_resource_work work;
    work.resource_inputs = { { itype_id( "water" ), 1 } };
    work.duration_turns = 1;
    const faction_id owner( "your_followers" );
    basecamp camp( "Resource Work Lifecycle Policy Camp", tripoint_abs_omt{ 108, 108, 0 } );
    camp.set_owner( owner );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9881 ), owner, camp.camp_omt_pos() );
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner, character_id( 9882 ), *worker, work );
    task.state = basecamp_platform_task_state::running;
    task.started_at = calendar::turn_zero;
    task.due_at = calendar::turn_zero + 1_turns;
    task.reserved_resources = work.resource_inputs;
    task.reservation_discarded = true;

    // The terminal marker is persisted only after a camp/death boundary cannot
    // refund safely; ordinary unload/cancel must leave this marker false and
    // retain the ledger until the explicit refund commit.
    CHECK( task.reservation_discarded );
    task.reservation_discarded = false;
    CHECK_FALSE( task.reservation_discarded );
    CHECK( task.resource_work->resource_inputs.front().resource_id ==
           task.reserved_resources.front().resource_id );
    CHECK( camp.platform_task_snapshot().empty() );
}

TEST_CASE( "lua_platform_camp_resource_work_death_and_owner_change_refund",
           "[lua][platform][camp][tasks][resource_work][lifecycle]" )
{
    Character &avatar = get_avatar();
    REQUIRE( avatar.get_faction() != nullptr );
    REQUIRE( g != nullptr );
    faction *owner_faction = g->faction_manager_ptr->get(
                                  avatar.get_faction()->id, false );
    REQUIRE( owner_faction != nullptr );
    platform_food_state_scope food_scope( *owner_faction );
    owner_faction->empty_food_supply();
    owner_faction->consumes_food = true;
    nutrients initial_food;
    initial_food.calories = 100000;
    owner_faction->add_to_food_supply( { { calendar::turn_zero, initial_food } } );

    const faction_id owner_id = avatar.get_faction()->id;
    const faction_id replacement_owner( "resource_work_replacement_owner" );
    basecamp camp( "Resource Work Death Camp", tripoint_abs_omt{ 109, 109, 0 } );
    camp.set_owner( owner_id );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9891 ), owner_id, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.food_input_kcal = 10;
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner_id, avatar.getID(), *worker, work );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );
    CHECK( owner_faction->food_supply().calories == 90000 );

    // This is the producer-side path used by npc::die(): the task is terminal
    // only after its held food is refunded.
    camp.platform_retire_tasks_for_worker( *worker );
    const basecamp_platform_task death_cancelled = camp.platform_task_snapshot().front();
    CHECK( death_cancelled.state == basecamp_platform_task_state::cancelled );
    CHECK_FALSE( death_cancelled.reservation_discarded );
    CHECK( owner_faction->food_supply().calories == 100000 );

    basecamp owner_change_camp( "Resource Work Owner Camp", tripoint_abs_omt{ 110, 110, 0 } );
    owner_change_camp.set_owner( owner_id );
    const npc_ptr second_worker = make_platform_test_npc(
                                      character_id( 9892 ), owner_id,
                                      owner_change_camp.camp_omt_pos() );
    basecamp_platform_task second_task = make_platform_resource_work_test_task(
        owner_change_camp, owner_id, avatar.getID(), *second_worker, work );
    REQUIRE( owner_change_camp.platform_create_task( second_task, error ) );
    REQUIRE( owner_change_camp.platform_start_task(
                 second_task.task_id, second_task.identity_generation, second_worker,
                 calendar::turn_zero, 1_turns, error ) );
    owner_change_camp.set_owner( replacement_owner );
    const basecamp_platform_task owner_cancelled =
        owner_change_camp.platform_task_snapshot().front();
    CHECK( owner_cancelled.state == basecamp_platform_task_state::cancelled );
    CHECK_FALSE( owner_cancelled.reservation_discarded );
}

TEST_CASE( "lua_platform_camp_resource_work_camp_removal_records_discard_when_refund_is_unsafe",
           "[lua][platform][camp][tasks][resource_work][lifecycle]" )
{
    Character &avatar = get_avatar();
    REQUIRE( avatar.get_faction() != nullptr );
    REQUIRE( g != nullptr );
    faction *owner_faction = g->faction_manager_ptr->get(
                                  avatar.get_faction()->id, false );
    REQUIRE( owner_faction != nullptr );
    platform_food_state_scope food_scope( *owner_faction );
    owner_faction->empty_food_supply();
    owner_faction->consumes_food = true;
    nutrients initial_food;
    initial_food.calories = 100000;
    owner_faction->add_to_food_supply( { { calendar::turn_zero, initial_food } } );

    const faction_id owner_id = avatar.get_faction()->id;
    basecamp camp( "Resource Work Discard Camp", tripoint_abs_omt{ 111, 111, 0 } );
    camp.set_owner( owner_id );
    const npc_ptr worker = make_platform_test_npc(
                               character_id( 9893 ), owner_id, camp.camp_omt_pos() );
    basecamp_platform_resource_work work;
    work.food_input_kcal = 10;
    work.duration_turns = 1;
    basecamp_platform_task task = make_platform_resource_work_test_task(
                                      camp, owner_id, avatar.getID(), *worker, work );
    std::string error;
    REQUIRE( camp.platform_create_task( task, error ) );
    REQUIRE( camp.platform_start_task(
                 task.task_id, task.identity_generation, worker,
                 calendar::turn_zero, 1_turns, error ) );

    // Simulate a camp-removal boundary where the native food store has become
    // unrepresentable.  The terminal record must say discard, never retain a
    // silently dangling liability.
    owner_faction->debug_food_supply().front().second.calories =
        std::numeric_limits<std::int64_t>::max();
    camp.platform_retire_tasks_for_camp();
    const basecamp_platform_task discarded = camp.platform_task_snapshot().front();
    CHECK( discarded.state == basecamp_platform_task_state::cancelled );
    CHECK( discarded.reservation_discarded );
    CHECK( discarded.reserved_resources.empty() );
    CHECK( discarded.reserved_food_kcal == 0 );
}

#endif // CATA_ENABLE_LUA_PLATFORM
