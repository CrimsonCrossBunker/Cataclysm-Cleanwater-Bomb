#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_camp_handles_reject_replacement_and_removal",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 61 );
    basecamp original( "Platform Camp", tripoint_abs_omt{ 10, 10, 0 } );
    cata::lua_platform::register_camp_handle_identity( original );
    const cata::lua_platform::game_handle original_handle =
        cata::lua_platform::game_handle::from_camp( original, {}, runtime, 12 );

    CHECK( original_handle.kind() == cata::lua_platform::game_handle_kind::camp );
    CHECK( original_handle.locator().stable_id ==
           static_cast<std::int64_t>( original.platform_id() ) );
    CHECK_FALSE( original_handle.validation_error( runtime, 12 ) );

    basecamp replacement( "Replacement Camp", tripoint_abs_omt{ 10, 10, 0 } );
    replacement.set_platform_id( original.platform_id() );
    cata::lua_platform::register_camp_handle_identity( replacement );
    const std::optional<cata::lua_platform::game_handle_error> replaced =
        original_handle.validation_error( runtime, 12 );
    REQUIRE( replaced );
    CHECK( replaced->code == "stale_camp" );

    const cata::lua_platform::game_handle replacement_handle =
        cata::lua_platform::game_handle::from_camp( replacement, {}, runtime, 12 );
    CHECK_FALSE( replacement_handle.validation_error( runtime, 12 ) );
    cata::lua_platform::retire_camp_handle_identity( replacement );
    const std::optional<cata::lua_platform::game_handle_error> removed =
        replacement_handle.validation_error( runtime, 12 );
    REQUIRE( removed );
    CHECK( removed->code == "stale_camp" );
}

TEST_CASE( "lua_platform_camp_handles_bind_runtime_and_world_generation",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 62 );
    const cata::lua_platform::game_handle_runtime other_runtime( other_owner, 62 );
    const cata::lua_platform::game_handle_runtime newer_runtime( owner, 63 );
    basecamp camp( "Generation Camp", tripoint_abs_omt{ 11, 11, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 13 );

    std::optional<cata::lua_platform::game_handle_error> error;
    CHECK( handle.resolve_camp( runtime, 14 ).value == nullptr );
    error = handle.resolve_camp( runtime, 14 ).error;
    REQUIRE( error );
    CHECK( error->code == "stale_world" );
    error = handle.resolve_camp( other_runtime, 13 ).error;
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
    error = handle.resolve_camp( newer_runtime, 13 ).error;
    REQUIRE( error );
    CHECK( error->code == "stale_runtime" );
}

TEST_CASE( "lua_platform_camp_assignment_preflight_is_exact_and_atomic",
           "[lua][platform][camp]" )
{
    basecamp camp( "Assignment Camp", tripoint_abs_omt{ 12, 12, 0 } );
    CHECK( camp.exact_worker_count() == 0 );
    CHECK_FALSE( camp.assign_exact_worker( nullptr ) );
    CHECK( camp.exact_worker_count() == 0 );

    const shared_ptr_fast<npc> dead_worker = make_shared_fast<npc>();
    dead_worker->normalize();
    dead_worker->setID( character_id( 6201 ), true );
    dead_worker->set_all_parts_hp_cur( 0 );
    CHECK( dead_worker->is_dead_state() );
    CHECK_FALSE( camp.assign_exact_worker( dead_worker ) );
    CHECK( camp.exact_worker_count() == 0 );

    const shared_ptr_fast<npc> worker = make_shared_fast<npc>();
    worker->normalize();
    worker->setID( character_id( 6202 ), true );
    worker->set_all_parts_hp_cur( 100 );
    CHECK_FALSE( worker->is_dead_state() );
    CHECK( camp.assign_exact_worker( worker ) );
    CHECK( camp.has_exact_worker( *worker ) );
    CHECK( camp.exact_worker_count() == 1 );
    CHECK_FALSE( camp.assign_exact_worker( worker ) );
    CHECK( camp.exact_worker_count() == 1 );
    CHECK( camp.recall_exact_worker( worker ) );
    CHECK_FALSE( camp.has_exact_worker( *worker ) );
    CHECK( camp.exact_worker_count() == 0 );
    CHECK_FALSE( camp.recall_exact_worker( worker ) );
}

TEST_CASE( "lua_platform_camp_api_requires_explicit_manager_and_handles",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 64 );
    basecamp camp( "API Camp", tripoint_abs_omt{ 13, 13, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 15 );
    monster wrong_manager;
    wrong_manager.set_hp( 1 );
    const cata::lua_platform::game_handle wrong_manager_handle =
        cata::lua_platform::game_handle::from_creature(
            wrong_manager, { "monster", 6202, 0, 0, 0, {} }, runtime, 15 );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 15 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 15 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    CHECK( camps["get"].valid() );
    CHECK( camps["assign_worker"].valid() );
    CHECK( camps["recall_worker"].valid() );
    CHECK_FALSE( camps["near"].valid() );
    CHECK_FALSE( camps["player_has_camp"].valid() );
    CHECK_FALSE( camps["start_with"].valid() );
    CHECK_FALSE( camps["assign_resident"].valid() );

    const sol::protected_function get = camps["get"];
    const sol::protected_function_result result = get( camp_handle, wrong_manager_handle );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "wrong_subtype" );
}

TEST_CASE( "lua_platform_camp_write_gate_precedes_camp_resolution",
           "[lua][platform][camp]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 65 );
    basecamp camp( "Write Gate Camp", tripoint_abs_omt{ 14, 14, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 16 );
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 16 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 16 ); },
    []() {}, [&]() {
        write_gate_called = true;
        owner->retire();
    } );
    const sol::protected_function rename = services["camps"]["rename"];
    const sol::protected_function_result result = rename(
            camp_handle, cata::lua_platform::game_handle{}, "New Name" );
    REQUIRE( result.valid() );
    CHECK( write_gate_called );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

TEST_CASE( "lua_platform_camp_resource_keys_reject_ambiguous_duplicates",
           "[lua][platform][camp][resources]" )
{
    const itype_id resource_id( "water" );
    const itype_id charge_id( "battery" );
    basecamp_resource first;
    first.fake_id = resource_id;
    first.ammo_id = charge_id;
    first.available = 4;
    first.consumed = 1;
    basecamp_resource equivalent = first;
    equivalent.available = 6;
    equivalent.consumed = 2;

    std::vector<basecamp_resource> normalized;
    std::string error;
    REQUIRE( basecamp::platform_normalize_resources(
                 { first, equivalent }, normalized, error ) );
    REQUIRE( normalized.size() == 1 );
    CHECK( normalized.front().fake_id == resource_id );
    CHECK( normalized.front().available == 10 );
    CHECK( normalized.front().consumed == 3 );

    basecamp_resource conflicting = equivalent;
    conflicting.ammo_id = itype_id();
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { first, conflicting }, normalized, error ) );
    CHECK( normalized.empty() );
    CHECK( error.find( "conflicting ammo" ) != std::string::npos );

    basecamp_resource overflowing = first;
    overflowing.available = std::numeric_limits<int>::max();
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { overflowing, overflowing }, normalized, error ) );
    CHECK( normalized.empty() );
    CHECK( error.find( "overflow" ) != std::string::npos );

    basecamp_resource negative = first;
    negative.available = -1;
    CHECK_FALSE( basecamp::platform_normalize_resources(
                     { negative }, normalized, error ) );
    CHECK( normalized.empty() );
    CHECK( error.find( "negative" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_resource_batch_preflight_is_atomic",
           "[lua][platform][camp][resources]" )
{
    basecamp camp( "Resource Camp", tripoint_abs_omt{ 15, 15, 0 } );
    std::vector<basecamp_resource> before;
    std::string error;
    REQUIRE( camp.platform_resource_snapshot( before, error ) );

    const std::vector<basecamp_platform_resource_change> changes = {
        { itype_id( "water" ), 1 },
        { itype_id( "battery" ), -1 },
    };
    CHECK_FALSE( camp.platform_adjust_resources( changes, error ) );
    const std::string failure_error = error;

    std::vector<basecamp_resource> after;
    REQUIRE( camp.platform_resource_snapshot( after, error ) );
    CHECK( after.size() == before.size() );
    CHECK( failure_error.find( "not provided" ) != std::string::npos );
}

TEST_CASE( "lua_platform_camp_food_balance_is_owner_scoped_and_bounded",
           "[lua][platform][camp][food]" )
{
    faction owner;
    owner.empty_food_supply();
    owner.consumes_food = true;

    nutrients added;
    added.calories = 5000;
    owner.add_to_food_supply( { { calendar::turn_zero, added } } );
    CHECK( owner.food_supply().calories == 5000 );

    nutrients requested;
    requested.calories = 3000;
    CHECK( owner.consume_food_supply( requested ).calories == 0 );
    CHECK( owner.food_supply().calories == 2000 );

    // This is the balance the Platform binding must reject before calling the
    // native consumer; the native faction method itself intentionally reports
    // an unfulfilled remainder rather than defining the Lua write contract.
    CHECK( owner.food_supply().calories < 3000 );
    CHECK( owner.consumes_food );
    owner.consumes_food = false;
    CHECK_FALSE( owner.consumes_food );
}

TEST_CASE( "lua_platform_camp_inventory_exposes_only_explicit_storage_holders",
           "[lua][platform][camp][inventory]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 66 );
    basecamp camp( "Storage Camp", tripoint_abs_omt{ 16, 16, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 17 );
    camp.set_storage_tiles( { tripoint_abs_ms{ 160, 161, 0 } } );

    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 17 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 17 ); },
    []() {}, []() {} );
    const sol::table camps = services["camps"];
    CHECK( camps["inventory"]["storage_tiles"].valid() );
    CHECK_FALSE( camps["inventory"]["snapshot"].valid() );
    CHECK( camps["tasks"].valid() );
    CHECK( camp.get_storage_tiles().count( tripoint_abs_ms{ 160, 161, 0 } ) == 1 );
    CHECK( camp_handle.kind() == cata::lua_platform::game_handle_kind::camp );
}

TEST_CASE( "lua_platform_camp_food_mutations_enter_the_write_gate_first",
           "[lua][platform][camp][food]" )
{
    const auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    const cata::lua_platform::game_handle_runtime runtime( owner, 67 );
    basecamp camp( "Food Camp", tripoint_abs_omt{ 17, 17, 0 } );
    cata::lua_platform::register_camp_handle_identity( camp );
    const cata::lua_platform::game_handle camp_handle =
        cata::lua_platform::game_handle::from_camp( camp, {}, runtime, 18 );
    bool write_gate_called = false;
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_game_handle_api(
        lua, services, [runtime]() { return runtime; }, []() { return std::size_t( 18 ); },
        []() {} );
    cata::lua_platform::install_camp_api(
        services, [runtime]() { return runtime; }, []() { return std::size_t( 18 ); },
    []() {}, [&]() {
        write_gate_called = true;
        owner->retire();
    } );

    const sol::protected_function add_food = services["camps"]["food"]["add"];
    const sol::protected_function_result result = add_food(
        camp_handle, cata::lua_platform::game_handle{}, 1 );
    REQUIRE( result.valid() );
    CHECK( write_gate_called );
    const sol::table envelope = result.get<sol::table>();
    CHECK_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_runtime" );
}

#endif // CATA_ENABLE_LUA_PLATFORM
