#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_persistent_task_actor_payload_uses_live_handle_only_at_dispatch",
           "[lua][platform][runtime][tasks][handles]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_actor_payload", 901, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_payload;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "task_callback", [&callback_payload, &callback_actor,
                                         &callback_called]( const sol::table &payload ) {
        callback_called = true;
        callback_payload = payload["payload"].get<sol::table>();
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"]( "task_callback", lua["task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    const character_id avatar_id = get_avatar().getID();
    const cata::lua_platform::game_handle avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", avatar_id.get_value(), 0, 0, 0, {} },
            runtime_identity, world_generation );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 42;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
            0, "task_callback", persistent_payload, 1, "world", avatar_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    REQUIRE( snapshot["actor_character_id"].valid() );
    CHECK( snapshot["actor_character_id"].get<std::int64_t>() == avatar_id.get_value() );
    CHECK_FALSE( snapshot["actor"].valid() );
    CHECK_FALSE( snapshot["live_handle"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_actor->subtype_name() == "avatar" );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().stable_id == avatar_id.get_value() );
    CHECK_FALSE( callback_actor->validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    CHECK( callback_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( callback_payload["actor"].valid() );
    CHECK_FALSE( callback_payload["handle"].valid() );
}

TEST_CASE( "lua_platform_persistent_task_item_actor_payload_uses_live_handle_only_at_dispatch",
           "[lua][platform][runtime][tasks][handles]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_item_actor_payload", 902, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_payload;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "task_callback", [&callback_payload, &callback_actor,
                                         &callback_called]( const sol::table &payload ) {
        callback_called = true;
        callback_payload = payload["payload"].get<sol::table>();
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"]( "task_callback", lua["task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();

    item &avatar_inventory_item = get_avatar().inv->add_item(
                                      item( itype_id( "rock" ), calendar::turn_zero ),
                                      false, false, false );
    item_location avatar_item_location( get_avatar(), &avatar_inventory_item );
    REQUIRE( avatar_item_location );
    on_out_of_scope item_cleanup( [&avatar_item_location]() {
        if( avatar_item_location ) {
            avatar_item_location.remove_item();
        }
    } );
    item *avatar_item = avatar_item_location.get_item();
    REQUIRE( avatar_item != nullptr );
    const std::int64_t avatar_item_uid = avatar_item->uid().get_value();
    const cata::lua_platform::game_handle avatar_item_handle =
        cata::lua_platform::game_handle::from_item(
            *avatar_item,
            { "avatar_inventory", avatar_item_uid, 0, 0, 0, {} },
            runtime_identity, world_generation );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 42;
    basecamp wrong_actor( "Wrong task actor", tripoint_abs_omt{ 0, 0, 0 } );
    const cata::lua_platform::game_handle wrong_actor_handle =
        cata::lua_platform::game_handle::from_camp(
            wrong_actor, {},
            runtime_identity, world_generation );
    const sol::protected_function_result rejected = ccb["tasks"]["after"](
                0, "task_callback", persistent_payload, 1, "world", wrong_actor_handle );
    CHECK_FALSE( rejected.valid() );
    const sol::protected_function_result empty_tasks = ccb["tasks"]["list"]();
    REQUIRE( empty_tasks.valid() );
    CHECK( empty_tasks.get<sol::table>()["total"].get<std::size_t>() == 0 );

    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
            0, "task_callback", persistent_payload, 1, "world", avatar_item_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK( snapshot["actor_kind"].get<std::string>() == "item" );
    CHECK_FALSE( snapshot["actor_character_id"].valid() );
    REQUIRE( snapshot["actor_item_uid"].valid() );
    CHECK( snapshot["actor_item_uid"].get<std::int64_t>() == avatar_item_uid );
    CHECK_FALSE( snapshot["actor_item_pending"].get<bool>() );
    CHECK_FALSE( snapshot["actor"].valid() );
    CHECK_FALSE( snapshot["live_handle"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );
    CHECK_FALSE( snapshot_payload["handle"].valid() );
    CHECK_FALSE( snapshot_payload["live_handle"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_actor->kind() == cata::lua_platform::game_handle_kind::item );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().scope == "avatar_item" );
    CHECK( callback_actor->locator().stable_id == avatar_item_uid );
    CHECK_FALSE( callback_actor->validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    const cata::lua_platform::native_handle_result<item> resolved =
        callback_actor->resolve_item(
            runtime_identity, cata::lua_platform::runtime_world_generation() );
    REQUIRE( static_cast<bool>( resolved ) );
    CHECK( resolved.value == avatar_item );
    CHECK( resolved.value->uid().get_value() == avatar_item_uid );
    CHECK( callback_payload["marker"].get<int>() == 42 );
    CHECK_FALSE( callback_payload["actor"].valid() );
    CHECK_FALSE( callback_payload["handle"].valid() );
}

TEST_CASE( "lua_platform_persistent_task_monster_actor_reacquires_persistent_identity",
           "[lua][platform][runtime][tasks][handles][monster]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_monster_actor", 903, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_envelope;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "monster_task_callback",
    [&callback_envelope, &callback_actor, &callback_called]( const sol::table & payload ) {
        callback_called = true;
        callback_envelope = payload;
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"](
            "monster_task_callback", lua["monster_task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();

    const tripoint_bub_ms monster_position( 5, 5, get_avatar().pos_bub().z() );
    const shared_ptr_fast<monster> actor_monster =
        make_shared_fast<monster>( mtype_id( "mon_zombie" ), monster_position );
    REQUIRE( get_creature_tracker().add( actor_monster ) );
    on_out_of_scope monster_cleanup( [&actor_monster]() {
        if( actor_monster &&
            get_creature_tracker().temporary_id( *actor_monster ) >= 0 ) {
            get_creature_tracker().remove( *actor_monster );
        }
    } );
    REQUIRE( actor_monster->uid().is_valid() );
    const std::int64_t monster_uid = actor_monster->uid().get_value();
    const tripoint_abs_ms absolute_position = actor_monster->pos_abs();
    const cata::lua_platform::game_handle monster_handle =
        cata::lua_platform::game_handle::from_creature(
            *actor_monster,
            { "monster", 0, absolute_position.x(), absolute_position.y(),
              absolute_position.z(), {} },
            runtime_identity, world_generation );
    CHECK( monster_handle.locator().stable_id == monster_uid );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 73;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
                0, "monster_task_callback", persistent_payload, 1, "world",
                monster_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK( snapshot["actor_kind"].get<std::string>() == "monster" );
    CHECK_FALSE( snapshot["actor_character_id"].valid() );
    CHECK_FALSE( snapshot["actor_item_uid"].valid() );
    REQUIRE( snapshot["actor_monster_uid"].valid() );
    CHECK( snapshot["actor_monster_uid"].get<std::int64_t>() == monster_uid );
    CHECK_FALSE( snapshot["actor_monster_pending"].get<bool>() );
    CHECK_FALSE( snapshot["actor"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 73 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_envelope["actor_kind"].get<std::string>() == "monster" );
    CHECK( callback_envelope["actor_monster_uid"].get<std::int64_t>() == monster_uid );
    CHECK_FALSE( callback_envelope["actor_character_id"].valid() );
    CHECK_FALSE( callback_envelope["actor_item_uid"].valid() );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().stable_id == monster_uid );
    std::optional<cata::lua_platform::game_handle_error> resolve_error;
    CHECK( cata::lua_platform::resolve_exact_monster(
               *callback_actor, runtime_identity,
               cata::lua_platform::runtime_world_generation(), resolve_error ) ==
           actor_monster.get() );
    CHECK_FALSE( resolve_error );
}

TEST_CASE( "lua_platform_persistent_task_participants_snapshot_and_dispatch_exact_handles",
           "[lua][platform][runtime][tasks][participants][handles]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_participants", 905, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_envelope;
    bool callback_called = false;
    lua.set_function( "participant_task_callback",
    [&callback_envelope, &callback_called]( const sol::table &payload ) {
        callback_called = true;
        callback_envelope = payload;
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"](
            "participant_task_callback", lua["participant_task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();
    const character_id avatar_id = get_avatar().getID();
    const cata::lua_platform::game_handle avatar_handle =
        cata::lua_platform::game_handle::from_creature(
            get_avatar(), { "avatar", avatar_id.get_value(), 0, 0, 0, {} },
            runtime_identity, world_generation );

    const tripoint_bub_ms monster_position( 5, 5, get_avatar().pos_bub().z() );
    const shared_ptr_fast<monster> actor_monster =
        make_shared_fast<monster>( mtype_id( "mon_zombie" ), monster_position );
    REQUIRE( get_creature_tracker().add( actor_monster ) );
    on_out_of_scope monster_cleanup( [&actor_monster]() {
        if( actor_monster &&
            get_creature_tracker().temporary_id( *actor_monster ) >= 0 ) {
            get_creature_tracker().remove( *actor_monster );
        }
    } );
    REQUIRE( actor_monster->uid().is_valid() );
    const std::int64_t monster_uid = actor_monster->uid().get_value();
    const tripoint_abs_ms absolute_position = actor_monster->pos_abs();
    const cata::lua_platform::game_handle monster_handle =
        cata::lua_platform::game_handle::from_creature(
            *actor_monster,
            { "monster", 0, absolute_position.x(), absolute_position.y(),
              absolute_position.z(), {} },
            runtime_identity, world_generation );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 905;

    sol::table invalid_participants = lua.create_table();
    invalid_participants["bad-role"] = avatar_handle;
    const sol::protected_function_result rejected = ccb["tasks"]["after"](
            0, "participant_task_callback", persistent_payload, 1, "world",
            sol::nil, invalid_participants );
    CHECK_FALSE( rejected.valid() );
    const sol::protected_function_result empty_tasks = ccb["tasks"]["list"]();
    REQUIRE( empty_tasks.valid() );
    CHECK( empty_tasks.get<sol::table>()["total"].get<std::size_t>() == 0 );

    sol::table participants = lua.create_table();
    participants["alpha"] = avatar_handle;
    participants["beta"] = monster_handle;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
            0, "participant_task_callback", persistent_payload, 1, "world",
            sol::nil, participants );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK_FALSE( snapshot["actor_kind"].valid() );
    CHECK_FALSE( snapshot["actor"].valid() );
    const sol::table snapshot_participants = snapshot["participants"].get<sol::table>();
    const sol::table alpha_snapshot = snapshot_participants["alpha"].get<sol::table>();
    CHECK( alpha_snapshot["kind"].get<std::string>() == "character" );
    CHECK( alpha_snapshot["character_id"].get<std::int64_t>() == avatar_id.get_value() );
    CHECK_FALSE( alpha_snapshot["item_uid"].valid() );
    CHECK_FALSE( alpha_snapshot["monster_uid"].valid() );
    CHECK_FALSE( alpha_snapshot["vehicle_uid"].valid() );
    CHECK_FALSE( alpha_snapshot["pending"].get<bool>() );
    CHECK_FALSE( alpha_snapshot["actor"].valid() );
    CHECK_FALSE( alpha_snapshot["handle"].valid() );
    CHECK_FALSE( alpha_snapshot["live_handle"].valid() );

    const sol::table beta_snapshot = snapshot_participants["beta"].get<sol::table>();
    CHECK( beta_snapshot["kind"].get<std::string>() == "monster" );
    CHECK_FALSE( beta_snapshot["character_id"].valid() );
    CHECK_FALSE( beta_snapshot["item_uid"].valid() );
    CHECK( beta_snapshot["monster_uid"].get<std::int64_t>() == monster_uid );
    CHECK_FALSE( beta_snapshot["vehicle_uid"].valid() );
    CHECK_FALSE( beta_snapshot["pending"].get<bool>() );
    CHECK_FALSE( beta_snapshot["actor"].valid() );
    CHECK_FALSE( beta_snapshot["handle"].valid() );
    CHECK_FALSE( beta_snapshot["live_handle"].valid() );

    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 905 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );
    CHECK_FALSE( snapshot_payload["handle"].valid() );
    CHECK_FALSE( snapshot_payload["live_handle"].valid() );
    CHECK_FALSE( snapshot_payload["participants"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    CHECK_FALSE( callback_envelope["actor"].valid() );
    const sol::table callback_participants =
        callback_envelope["participants"].get<sol::table>();
    const sol::object callback_alpha_object = callback_participants["alpha"];
    const sol::object callback_beta_object = callback_participants["beta"];
    REQUIRE( callback_alpha_object.is<cata::lua_platform::game_handle>() );
    REQUIRE( callback_beta_object.is<cata::lua_platform::game_handle>() );
    const cata::lua_platform::game_handle callback_alpha =
        callback_alpha_object.as<cata::lua_platform::game_handle>();
    const cata::lua_platform::game_handle callback_beta =
        callback_beta_object.as<cata::lua_platform::game_handle>();

    CHECK( callback_alpha.subtype_name() == "avatar" );
    CHECK( callback_alpha.runtime_generation() == runtime_identity.generation() );
    CHECK( callback_alpha.world_generation() == world_generation );
    CHECK( callback_alpha.locator().stable_id == avatar_id.get_value() );
    CHECK_FALSE( callback_alpha.validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    std::optional<cata::lua_platform::game_handle_error> avatar_error;
    CHECK( cata::lua_platform::resolve_exact_character(
               callback_alpha, runtime_identity,
               cata::lua_platform::runtime_world_generation(), avatar_error ) ==
           &get_avatar() );
    CHECK_FALSE( avatar_error );

    CHECK( callback_beta.subtype_name() == "monster" );
    CHECK( callback_beta.runtime_generation() == runtime_identity.generation() );
    CHECK( callback_beta.world_generation() == world_generation );
    CHECK( callback_beta.locator().stable_id == monster_uid );
    CHECK_FALSE( callback_beta.validation_error(
                     runtime_identity, cata::lua_platform::runtime_world_generation() ) );
    std::optional<cata::lua_platform::game_handle_error> monster_error;
    CHECK( cata::lua_platform::resolve_exact_monster(
               callback_beta, runtime_identity,
               cata::lua_platform::runtime_world_generation(), monster_error ) ==
           actor_monster.get() );
    CHECK_FALSE( monster_error );

    const sol::table callback_payload = callback_envelope["payload"].get<sol::table>();
    CHECK( callback_payload["marker"].get<int>() == 905 );
    CHECK_FALSE( callback_payload["actor"].valid() );
    CHECK_FALSE( callback_payload["handle"].valid() );
    CHECK_FALSE( callback_payload["live_handle"].valid() );
    CHECK_FALSE( callback_payload["participants"].valid() );
}

TEST_CASE( "lua_platform_persistent_task_vehicle_actor_reacquires_persistent_identity",
           "[lua][platform][runtime][tasks][handles][vehicle]" )
{
    cata::lua_platform::clear_active_runtimes();

    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_task_vehicle_actor", 904, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );

    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );

    sol::table callback_envelope;
    std::optional<cata::lua_platform::game_handle> callback_actor;
    bool callback_called = false;
    lua.set_function( "vehicle_task_callback",
    [&callback_envelope, &callback_actor, &callback_called]( const sol::table & payload ) {
        callback_called = true;
        callback_envelope = payload;
        const sol::object actor = payload["actor"];
        if( actor.is<cata::lua_platform::game_handle>() ) {
            callback_actor = actor.as<cata::lua_platform::game_handle>();
        }
    } );

    const sol::protected_function_result registered =
        ccb["runtime"]["handler"](
            "vehicle_task_callback", lua["vehicle_task_callback"] );
    REQUIRE( registered.valid() );

    cata::lua_platform::runtime_world_ready( true );
    const cata::lua_platform::game_handle_runtime runtime_identity =
        cata::lua_platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation =
        cata::lua_platform::runtime_world_generation();

    map &here = get_map();
    std::optional<tripoint_bub_ms> vehicle_position;
    for( int x = 10; x <= 30 && !vehicle_position; ++x ) {
        for( int y = 10; y <= 30; ++y ) {
            const tripoint_bub_ms candidate( x, y, get_avatar().pos_bub().z() );
            if( here.inbounds( candidate ) && !here.veh_at( candidate ) ) {
                vehicle_position = candidate;
                break;
            }
        }
    }
    REQUIRE( vehicle_position );
    vehicle *actor_vehicle = here.add_vehicle(
                                 vproto_id( "bicycle" ), *vehicle_position,
                                 0_degrees, 0, veh_spawn_status::UNDAMAGED );
    REQUIRE( actor_vehicle != nullptr );
    REQUIRE( actor_vehicle->uid().is_valid() );
    const std::int64_t vehicle_uid = actor_vehicle->uid().get_value();
    on_out_of_scope vehicle_cleanup( [&here, actor_vehicle, vehicle_uid]() {
        if( vehicle::find_vehicle_by_uid( here, vehicle_uid ) == actor_vehicle ) {
            here.destroy_vehicle( actor_vehicle );
        }
    } );
    const tripoint_abs_ms absolute_position = actor_vehicle->pos_abs();
    const cata::lua_platform::game_handle vehicle_handle =
        cata::lua_platform::game_handle::from_vehicle(
            *actor_vehicle,
            { "vehicle", 0, absolute_position.x(), absolute_position.y(),
              absolute_position.z(), {} },
            runtime_identity, world_generation );
    CHECK( vehicle_handle.locator().stable_id == vehicle_uid );

    sol::table persistent_payload = lua.create_table();
    persistent_payload["marker"] = 91;
    const sol::protected_function_result scheduled = ccb["tasks"]["after"](
                0, "vehicle_task_callback", persistent_payload, 1, "world",
                vehicle_handle );
    REQUIRE( scheduled.valid() );
    const std::int64_t task_id = scheduled.get<std::int64_t>();

    const sol::protected_function_result snapshot_result = ccb["tasks"]["get"]( task_id );
    REQUIRE( snapshot_result.valid() );
    const sol::table snapshot = snapshot_result.get<sol::table>();
    CHECK( snapshot["actor_kind"].get<std::string>() == "vehicle" );
    CHECK_FALSE( snapshot["actor_character_id"].valid() );
    CHECK_FALSE( snapshot["actor_item_uid"].valid() );
    CHECK_FALSE( snapshot["actor_monster_uid"].valid() );
    REQUIRE( snapshot["actor_vehicle_uid"].valid() );
    CHECK( snapshot["actor_vehicle_uid"].get<std::int64_t>() == vehicle_uid );
    CHECK_FALSE( snapshot["actor_vehicle_pending"].get<bool>() );
    CHECK_FALSE( snapshot["actor"].valid() );
    const sol::table snapshot_payload = snapshot["payload"].get<sol::table>();
    CHECK( snapshot_payload["marker"].get<int>() == 91 );
    CHECK_FALSE( snapshot_payload["actor"].valid() );

    cata::lua_platform::runtime_process_tasks();

    REQUIRE( callback_called );
    REQUIRE( callback_actor );
    CHECK( callback_envelope["actor_kind"].get<std::string>() == "vehicle" );
    CHECK( callback_envelope["actor_vehicle_uid"].get<std::int64_t>() == vehicle_uid );
    CHECK_FALSE( callback_envelope["actor_character_id"].valid() );
    CHECK_FALSE( callback_envelope["actor_item_uid"].valid() );
    CHECK_FALSE( callback_envelope["actor_monster_uid"].valid() );
    CHECK( callback_actor->runtime_generation() == runtime_identity.generation() );
    CHECK( callback_actor->world_generation() == world_generation );
    CHECK( callback_actor->locator().stable_id == vehicle_uid );
    const cata::lua_platform::native_handle_result<vehicle> resolved =
        callback_actor->resolve_vehicle(
            runtime_identity, cata::lua_platform::runtime_world_generation() );
    REQUIRE( static_cast<bool>( resolved ) );
    CHECK( resolved.value == actor_vehicle );
    CHECK( resolved.value->uid().get_value() == vehicle_uid );
}

#endif // CATA_ENABLE_LUA_PLATFORM
